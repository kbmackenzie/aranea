#define foo
echo Foo has been defined.

#ifdef foo
echo Foo is defined.
#else
echo Foo is not defined.
#endif

#undef foo
echo Foo has been un-defined.

#ifdef foo
echo Foo is defined.
#else
echo Foo is not defined.
#endif

#define foo
echo Foo has been defined again.

#ifdef foo
echo Foo is defined.
#else
echo Foo is not defined.
#endif

#undef bar
echo Bar has been un-defined.
echo It was never defined in the first place.
echo This should not throw any errors.

#ifdef bar
echo Bar is defined.
#else
echo Bar is not defined.
#endif
