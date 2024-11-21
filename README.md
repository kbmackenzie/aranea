Aranea is a **tiny, minimalist** shell preprocessor written in POSIX-compliant **Awk**. It's a tiny, portable, self-contained script!

It's inspired by the C preprocessor, and its output can be used with any [POSIX-compliant shell][3]. It should work out-of-the-box in most Linux distributions. It can...

- **Embed data files** into shell scripts with the **`#data` directive**, helping make shell scripts more self-contained.
- **Include shell scripts** with the **`#include` directive**, making script development more modular while still generating only a single file at the end. Included files **can also contain preprocessor directives**, which are resolved **recursively**.
- **Conditional compilation**: Define flags with `#define` and check for their existence with `#ifdef` and `#ifndef`. This can be used to create [include guards][2], for example.

Aranea has extra features when used with [GNU Awk][1], as explained [here](./docs/gawk.md).

## Table of Contents 

1. [Installation](#installation)
2. [Usage](#usage)

## Installation

Aranea is a self-contained Awk script and has no dependencies. It should work out-of-the-box in most GNU/Linux distributions, as most distros come with *some* flavor of Awk.

To install the script to `~/.local/bin`, simply run:

```bash
make install
```

If you wish to install it somewhere else (e.g. `/usr/local/bin`), simply define `PREFIX`:

```bash
make PREFIX=/usr/bin install
```

**Note:** Aranea has extra features when used with [GNU Awk][1], as explained [here](./docs/gawk.md).

## Usage

All documentation can be found [here](docs/aranea.md)!

1. [Using Aranea](docs/aranea.md#using-aranea)
2. [File Search](docs/aranea.md#file-search)
3. [Preprocessor Directives](docs/aranea.md#preprocessor-directives)
4. [A Note About Whitespace](docs/aranea.md#a-note-about-whitespace)
5. [Known Caveats](docs/aranea.md#known-caveats)

[1]: https://www.gnu.org/software/gawk/
[2]: https://en.wikipedia.org/wiki/Include_guard
[3]: https://wiki.archlinux.org/title/Command-line_shell#POSIX_compliant
