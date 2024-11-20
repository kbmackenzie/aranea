#!/bin/awk -f

BEGIN {
  # Match fields. Fields can be keywords (e.g. #include) or strings (e.g. "hello.awk").
  # Note: FPAT is specific to GNU Awk!
  FPAT="([[:alnum:][:punct:]]+)|(\".*\")"

  # File queue, where @data and @include file names will be stored.
  # When queue is empty, read from normal program flow input. 
  # file_queue[]
  queue_size = 0
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
  print message ": " ERRNO > "/dev/stderr"
  exit 1
}

# Read a line.
# - When a special file is enqueued, read from it.
# - When no file is enqueued, read next line from normal input.
function read_line(   line, retval) {
  if (queue_size <= 0) {
    retval = getline line
  }
  else {
    retval = getline line < file_queue[queue_size]
  }
  if (retval == 0) {
    dequeue_file()
    return read_line()
  }
  if (retval == 1) {
    return line
  }
  throw_error("couldn't read line")
}

# Escape line that will become part of a 'here document'.
# The characters that should be escaped are: $ ` \
function escape_line(line) {
  gsub(/[$`\\]/, "\\\\&", line)
  return line
}

# Quote + escape a string for displaying.
# Surrounds it with double quotes.
function quote(line) {
  gsub(/\n/, "\\n", line)
  return "\"" line "\""
}
