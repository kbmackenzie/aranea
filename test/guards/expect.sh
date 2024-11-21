echo Including scripts...

foo {
  echo Calling a function defined in foo.sh!
}



bar() {
  foo
  echo Calling a function defined in bar.sh!
}


echo Calling bar...
bar
