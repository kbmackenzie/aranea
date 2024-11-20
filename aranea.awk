#!/bin/awk -f

BEGIN {
  # When using GAWK, parse fields in a more sensible way (support quoted strings).
  # This has no effect on other flavors of Awk.
  FPAT = "([[:alnum:][:punct:]]+)|(\".*\")"

  queue_size = 0
  while (read_line() != 0) {
    if /^#include/ {
      if (NF < 2) { syntax_error("#include", $0) }
      enqueue_file($2)
      continue
    }

    if /^#data/ {
      if (NF < 3) { syntax_error("#data", $0) }
      read_as_data_variable($1, $2)
      continue
    }

    if /^#define/ {
      if (NF < 3) { syntax_error("#define", $0) }
      define_map[$1] = $2
      continue
    }

    if /^#ifdef/ {
      continue
    }

    if /^#else/ {
      continue
    }
  }
}

# Add a special file to the queue.
function enqueue_file(file) {
  file_queue[queue_size++] = file
}

# Remove a special file from the queue.
function dequeue_file() {
  if (queue_size > 0)
    delete file_queue[queue_size--]
}

# Write an error message to stderr and exit.
# Simple utility.
function throw_error(message) {
  print message " | error: " ERRNO > "/dev/stderr"
  exit 1
}

function syntax_error(directive, line) {
  throw_error("invalid syntax for " directive " directive: " quote(line))
}

# Read a line.
# - When a special file is enqueued, read from it.
# - When no file is enqueued, read next line from normal input.
#
# The return value of this function has special meaning:
# - 0: End of input has been reached.
# - 1: A line has been successfully read.
function read_line(   retval) {
  if (queue_size == 0) {
    retval = getline
  }
  else {
    retval = getline < file_queue[queue_size]
  }
  if (retval == 0) {
    if (queue_size == 0) return 0
    dequeue_file()
    return read_line()
  }
  if (retval == 1) {
    return 1
  }
  throw_error("couldn't read line")
}

# Escape line that will become part of a 'here document'.
# The characters that should be escaped are: $ ` \
function escape_line(line) {
  gsub(/[$`\\]/, "\\\\&", line)
  return line
}

# Get a valid delimeter based on a filename to use in a 'here document'.
# This is done so that nested here documents are simpler to implement.
function get_delimeter(filepath,  key) {
  gsub(/[^[a-zA-Z_]]/, "_", key)
  return key
}

# Quote + escape a string for displaying.
# Surrounds it with double quotes.
function quote(line) {
  gsub(/\n/, "\\n", line)
  return "\"" line "\""
}

# Read data from file into cat as a 'here document'.
# Assign it to a shell variable.
function read_as_data_variable(variable, file,  line, retval, delimeter) {
  # Get delimeter based on a filename.
  # This allows nested heredocs! :)
  delimeter = get_delimeter(file)

  print variable "=$(cat << " delimeter
  while (1) {
    retval = getline line < file
    if (retval == 1) {
      print escape_line(line)
      continue
    }
    if (retval < 0) {
      throw_error("couldn't read file " quote(file))
    }
    break
  }
  print delimeter
  print ")"
}
