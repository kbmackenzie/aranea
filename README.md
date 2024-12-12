Aranea is a **tiny, minimalist** shell preprocessor written in POSIX-compliant **Awk**. It's a small, portable, self-contained script.

It's inspired by the C preprocessor, and its output can be used with any [POSIX-compliant shell][3]. It should work out-of-the-box in most Linux distributions. It can...

<img align="left" width="192" height="192" src="logo.svg" alt="Aranea logo">

- **Embed data files** into shell scripts with the **`#data` directive**, helping make shell scripts more self-contained.
- **Include shell scripts** with the **`#include` directive**, making script development more modular while still generating only a single file at the end. Included files **can also contain preprocessor directives**, which are resolved **recursively**.
- **Conditional compilation**: Define flags with `#define` and check for their existence with `#ifdef` and `#ifndef`. This can be used to create [include guards][2], for example.

It also has extra features when used with [GNU Awk][1], as explained [here](./docs/gawk-extras.md).

Additionally, Aranea **can be used with other languages**—so long as you only use language-agnostic directives. See [this section of the documentation](./docs/usage-with-other-languages.md) to learn more.

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
make PREFIX=/usr/local/bin install
```

**Note:** Aranea has extra features when used with [GNU Awk][1], as explained [here](./docs/gawk-extras.md).

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
