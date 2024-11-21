#define foo
#define bar
echo Define foo and bar.

#ifndef foo
echo Foo is not defined.
#else
echo Foo is defined.
#ifndef bar 
echo Bar is not defined.
#else
echo Bar is defined.
#ifndef baz
echo Baz is not defined.
#else
echo Baz is defined.
#endif
#endif
#endif

#undef foo
#undef bar
echo Un-defined foo and bar.

#ifndef foo
echo Foo is not defined.
#ifndef bar
echo Bar is not defined.
#ifndef baz
echo Baz is not defined.
echo Foo, bar and baz are all not defined.
#define foo
echo Foo is defined now, but it no longer matters.
#endif
#endif
#endif

#ifndef foo
echo Foo is not defined.
#else
echo Foo is defined now!
#endif
