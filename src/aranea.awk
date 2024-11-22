#!/bin/awk -f

BEGIN {
  # When using GNU Awk, parse fields in a more sensible way (support quoted strings).
  # This has no effect on other flavors of Awk.
  FPAT = "([[:alnum:][:punct:]]+)|(\".*\")"

  file_count = 0
  cond_level = 0

  while (read_line() != 0) {
    # A little bit of a soup of 'continue', but I have no better options.
    # I wish POSIX Awk supported higher-order functions.
    keep = !should_skip()

    if (keep && /^#include/) {
      if (NF != 2) { syntax_error("#include", $0) }
      push_file($2)
      continue
    }

    if (keep && /^#data/) {
      if (NF != 3) { syntax_error("#data", $0) }
      read_as_data_variable($2, $3)
      continue
    }

    if (keep && /^#define/) {
      if (NF != 2) { syntax_error("#define", $0) }
      define_map[$2] = 1
      continue
    }

    if (keep && /^#undef/) {
      if (NF != 2) { syntax_error("#undef", $0) }
      delete define_map[$2]
      continue
    }

    if (keep && /^#ifdef/) {
      if (NF != 2) { syntax_error("#ifdef", $0) }
      push_conditional($2 in define_map)
      continue
    }

    if (keep && /^#ifndef/) {
      if (NF != 2) { syntax_error("#ifndef", $0) }
      push_conditional(!($2 in define_map))
      continue
    }

    if (/^#else/) {
      flip_conditional()
      continue
    }

    if (/^#endif/) {
      pop_conditional()
      continue
    }

    # When not matching any of the above, just print.
    if (keep) { print $0 }
  }
  check_conditionals()
}

# Push a file onto the file stack.
function push_file(file) {
  file_stack[file_count++] = file
}

# Pop the file stack.
function pop_file() {
  if (file_count > 0) {
    close(file_stack[file_count - 1])
    delete file_stack[--file_count]
  }
}

# Write an error message to stderr and exit.
# Simple utility.
function throw_error(message, no_context,  context) {
  context = (no_context) ? "" : ("| error: " ERRNO)
  print "line " NR ":", message, context > "/dev/stderr"
  exit 1
}

# Write a syntax error concerning a specific directive.
# Simple utility.
function syntax_error(directive, line) {
  throw_error("syntax error: incorrect argument count for " directive " directive: " quote(line), 1)
}

# Read a line.
# - When a file is at the top of the file stack, read from it.
# - When the file stack is empty, read next line from normal input.
#
# The return value of this function has special meaning:
# - 0: End of input has been reached.
# - 1: A line has been successfully read.
function read_line(   retval, source) {
  if (file_count == 0) {
    retval = getline
  }
  else {
    retval = getline < file_stack[file_count - 1]
  }
  if (retval == 0) {
    if (file_count == 0) return 0
    pop_file()
    return read_line()
  }
  if (retval == 1) {
    return 1
  }
  
  source = (file_count <= 0) ? "input" : quote(file_stack[file_count - 1])
  throw_error("couldn't read line from " source)
}

# Escape line that will become part of a 'here document'.
# The characters that should be escaped are: $ ` \
function escape_line(line) {
  gsub(/[$`\\]/, "\\\\&", line)
  return line
}

# Get a valid delimeter based on a filename to use in a 'here document'.
# This is done so that nested here documents are simpler to implement.
function get_delimeter(filepath) {
  gsub(/[^a-zA-Z_]/, "_", filepath)
  return filepath
}

# Quote (+ escape) a string for displaying. Surrounds it with double quotes.
# This function expects only a single line (no newline characters)!
function quote(line) {
  gsub(/"/, "\\\"", line)
  return "\"" line "\""
}

# Read data from file into cat as a 'here document'.
# Assign it to a shell variable.
function read_as_data_variable(variable, file,  line, retval, delimeter) {
  # Get delimeter based on the filename.
  # A little safer than using a common acronym like 'EOF'. :)
  delimeter = get_delimeter(file)

  print variable "=$(cat << '" delimeter "'"
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

# Conditional jumps (#ifdef, #ifndef, #else) are represented by a boolean stack.
#
# It follows two simple rules:
# - When the top of the stack is 1 (true), keep the current line.
# - When the top of the stack is 0 (false), skip the current line.
#
# In addition....
# - When #else is found, flip the boolean value at the top of the stack.
# - When #endif is found, pop the stack.

# Should the current line be skipped?
function should_skip() {
  return (cond_level > 0) && !conditionals[cond_level - 1]
}

# Push the result of a condition into the stack.
# This begins a new conditional block.
function push_conditional(result) {
  conditionals[cond_level++] = (result) ? 1 : 0
}

# Pop the conditional stack.
# This closes an existing conditional block.
function pop_conditional() {
  if (cond_level <= 0) {
    throw_error("cannot close unopened conditional", 1)
  }
  delete conditionals[--cond_level]
}

# Flip the value at the top of the conditional stack.
# This is done for #else blocks.
function flip_conditional() {
  if (cond_level <= 0) {
    throw_error("cannot flip unopened conditional", 1)
  }
  conditionals[cond_level - 1] = !conditionals[cond_level - 1]
}

# Check the conditional stack at the end; see if they're all closed.
# If they're not, handle it appropriately.
function check_conditionals(  noun) {
  if (cond_level > 0) {
    noun = (cond_level == 1) ? "directive" : "directives"
    throw_error("syntax error: " cond_level " unclosed conditional " noun "!", 1)
  }
}
