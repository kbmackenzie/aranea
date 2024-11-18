#!/bin/awk -f

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

# Write an error message to stderr.
# Simple utility.
function log_error(message) {
  print message > "/dev/stderr"
}

# Read a file and print its contents escaped for a 'here document' string.
# This means the following characters are escaped: $ ` \
function read_as_heredoc(file,  line, retval) {
  do {
    retval = getline line < file
    if (retval == 1) {
      print escape_line(line)
    }
    if (retval == -1) {
      log_error("couldn't read line from file " quote(file))
      exit 1
    }
  } while (retval > 0)
  close(file)
}

BEGIN {
  print escape_line("hello $world, find `my \\voice")
  print quote("hello\nworld")
}

$1 == "#script" {
  if (NF < 3) {
    log_error("invalid syntax for #script statement: " quote($0))
    exit 1
  }
  print $2 "=$(cat << EOF"
  read_as_heredoc($3)
  print "EOF"
  print ")"
}

#($1 == "#ifdef") && ($2 in defined) {
#}
