#!/bin/awk -f

BEGIN {
  # Match fields. Fields can be keywords (e.g. #include) or strings (e.g. "hello.awk").
  # Note: FPAT is specific to GNU Awk!
  FPAT="([[:alnum:][:punct:]]+)|(\".*\")"
}

{
  print "\"" $1 "\""
  print "\"" $2 "\""
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

# Write an error message to stderr and exit.
# Simple utility.
function throw_error(message) {
  print message > "/dev/stderr"
  if (ERRNO) {
    print "error: " ERRNO > "/dev/stderr"
  }
  exit 1
}

# Read a file and print its contents escaped for a 'here document' string.
# This means the following characters are escaped: $ ` \
function read_as_heredoc(file,  line, retval) {
  do {
    retval = getline line < file
    if (retval == 1) {
      print escape_line(line)
    }
    if (retval < 0) {
      throw_error("couldn't read line from file " quote(file))
    }
  } while (retval > 0)
  close(file)
}

# Read a script verbatim and print its lines.
# When the script has a shebang at the top, skip it.
function read_as_script(file,  line, retval, first) {
  first = 1
  do {
    retval = getline line < file
    if (retval == 1) {
      if (first && line ~ /^#!/) continue
      print line
    }
    if (retval < 0) {
      throw_error("couldn't read line from file " quote(file))
    }
    first = 0
  } while (retval > 0)
  close(file)
}

$1 == "#data" {
  if (NF < 3) {
    throw_error("invalid syntax for #data directive: " quote($0))
  }
  print $2 "=$(cat << EOF"
  read_as_heredoc($3)
  print "EOF"
  print ")"
  next
}

$1 == "#include" {
  if (NF < 2) {
    throw_error("invalid syntax for #include directive: " quote($0))
  }
  read_as_script($2)
  next
}

#($1 == "#ifdef") && ($2 in defined) {
#}
