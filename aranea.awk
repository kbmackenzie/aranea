#!/bin/awk -f

# Escape line that will become part of a 'here document'.
# The characters that should be escaped are: $ ` \
function escape_line(line) {
  # I have to do it in steps, because the regexp backreference approach...
  #   gsub(/[`$\\]/, "\\&", doc)
  # ... has unexpected behavior. ("\\&" has a special meaning in sub/gsub).
  # https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html#index-sub_0028_0029-function-1

  gsub(/\\/, "\\\\", line)
  gsub(/\$/, "\\$" , line)
  gsub(/`/ , "\\`" , line)
  return line
}

BEGIN {
  print escape_line("hello $world, find my \\voice")
}
