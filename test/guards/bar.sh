#ifndef BAR_SH
#define BAR_SH

#include test/guards/foo.sh

bar() {
  foo
  echo Calling a function defined in bar.sh!
}

#endif
