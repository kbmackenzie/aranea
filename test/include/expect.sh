echo Including bar.sh...
echo Including foo.sh...
foo() {
  echo Called function defined in foo.sh!
}

bar() {
  foo
  echo Called function defined in bar.sh!
}

echo Running function from bar.sh...
bar
