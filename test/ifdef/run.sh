#define foo
#define bar
echo Defined foo and bar.

#ifdef foo
echo Foo is defined.
#ifdef bar
echo Foo *and* bar are defined!
#ifdef baz
echo Foo *and* bar *and* baz are defined!
#else
echo Baz is not defined.
#endif
#endif
#endif

#ifdef foo
echo Foo is still defined.
#ifndef baz
echo Baz is still not defined.
#endif
#ifdef bar
echo Foo *and* bar are still defined!
#else
echo Bar is not defined.
#endif
#endif

#ifndef foo
echo Foo is not defined.
#else
echo Foo is defined.
#ifdef bar
echo Foo *and* bar are defined.
#else
echo Foo is defined, but bar is not.
#endif
#endif
