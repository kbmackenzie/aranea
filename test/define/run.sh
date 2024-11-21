echo Begin definition tests.

#define foo
echo Defined foo.

#ifdef foo
echo Foo is defined.
#else
echo Foo is not defined.
#endif

#define bar
echo Defined bar.

#ifdef bar
echo Bar is defined.
#else
echo Bar is not defined.
#endif

#ifdef baz
echo Baz is defined.
#else
echo Baz is not defined.
#endif
