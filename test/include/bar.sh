echo Including foo.sh...
#include test/include/foo.sh

bar() {
  foo
  echo Called function defined in bar.sh!
}
