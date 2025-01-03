Aranea has one extra feature when used with [GNU Awk][1]. More extra features may be added in the future.

## Table of Contents

1. [Extra Features](#extra-features)
    1. [Quoted Strings](#quoted-strings)
2. [Installing GNU Awk](#installing-gnu-awk)

## Extra Features

### Quoted Strings

When parsing lines, Aranea splits fields by **whitespace**. This is the default behavior for POSIX Awk. As you might imagine, though, this has an unfortunate consequence: filepaths with **spaces** aren't valid.

```c
#include oops not valid.sh
```

It shouldn't be a problem for **most** projects (*who uses spaces in their script names?!*), but it can be a surprise for some people.

Whitespace is fortunately **not a problem with [GNU Awk][1]**, thanks to the `FPAT` extension, which lets Aranea use a regular expression for matching fields.

With GNU Awk, **Aranea supports quoted strings**:

```c
#include "spaces are perfectly okay here.sh"
```

## Installing GNU Awk

A lot of Linux distributions already come with GNU Awk. In those distributions, `/usr/bin/awk` is typically a symlink to `/usr/bin/gawk`.

To know what flavor of Awk you have, run this command:

```bash
realpath /usr/bin/awk
```

If your distribution comes with another flavor of Awk, you'll need to manually install `gawk`. On Debian-based distros, you can simply run `sudo apt-get install gawk`.

Afterward, you can install Aranea with:

```bash
make install-gawk
```

This will install Aranea with a shebang specifying `gawk` instead of `awk`.

The default install location is `~/.local/bin`. To install it somewhere else, you can run:

```bash
make PREFIX=/usr/local/bin install-gawk
```

**Unfortunately**, a lot of Debian-based distros (like Ubuntu) ship with `mawk` as their default Awk flavor. You can run `sudo apt-get install gawk` to install `gawk` on such distros.

[1]: https://www.gnu.org/software/gawk/
