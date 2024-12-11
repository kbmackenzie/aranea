Aranea is primarily designed as a preprocessor for POSIX-compliant shell scripting languages. **However**, a large subset of Aranea's preprocessor directives are **language-agnostic**.

Those are:

- `#include`
- `#define`
- `#undef`
- `#ifdef`
- `#ifndef`
- `#else`
- `#endif`

Because of this, Aranea **can be used with other languages** aside from shell.

## Non-Language-Agnostic Directives

### `#data`

The `#data` directive directly translates to POSIX shell variable assignment.
