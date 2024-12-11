## Introduction

Aranea is a **tiny, minimalist** shell preprocessor written in POSIX-compliant **Awk**. It's a small, portable, self-contained script!

It's inspired by the C preprocessor, and its output can be used with any [POSIX-compliant shell][3].

You're encouraged to read the sections below **in order**.

## Table of Contents

1. [Using Aranea](#using-aranea)
2. [File Search](#file-search)
3. [Preprocessor Directives](#preprocessor-directives)
4. [A Note About Whitespace](#a-note-about-whitespace)
5. [Known Caveats](#known-caveats)

## Using Aranea

Aranea can be invoked like any other shell utility. It expects a filepath as argument:

```bash
aranea myscript.sh
```

Aranea writes **all** of its transpilation output to `stdout` by default. It **never** mutates its input files.

To capture its output into a file, you should use **redirections**, as you would with any other shell utility:

```bash
aranea myscript.sh > output.sh
```

Alternatively, you can pipe Aranea's output into a POSIX-compliant shell like `bash` to execute it directly:

```bash
aranea myscript.sh | bash
```

## File Search

Aranea always looks for files in the **current working directory**. Whenever a directive expects a filepath, know the path should be relative to the current working directory.

As an example, with this directory structure (where `.` is the current working directory)...

```tree
.
├── lib
│   ├── bar.sh
│   └── foo.sh
└── foobar.sh
```

... if we wish to include `foo.sh` and `bar.sh` inside `foobar.sh`, we must do:

```c
#include lib/foo.sh
#include lib/bar.sh
```

## Preprocessor Directives

Aranea is inspired by the C preprocessor, and features similar directives. All preprocessor directives begin with a `#`, like a comment would in `sh`.

### `#include` 

The `#include` directive includes another shell script inside the current script.

```c
#include foo.sh
```

Aranea recursively resolves any preprocessor directives within included scripts, meaning included scripts can also include other scripts, *ad infinitum*.

To prevent a script from being included twice, you can use [include guards][2], as you would with C/C++ header files!

```c
#ifndef FOO_SH
#define FOO_SH
...
#endif
```

**Note:** When using [GNU Awk][1], you can put quotes around the filepath, allowing it to have spaces:

```c
#include "this path can have spaces.sh"
```

[See this section](#a-note-about-whitespace) to know why this feature isn't available when using POSIX Awk.

### `#data`

The `#data` directive includes a data file (read as text) into the current script—as a [here document][4].

It stores the contents of the file in a shell variable specified as part of the directive:

```c
#data EXAMPLE data/example.txt
```

Which you can then use normally in your script:

```bash
echo "$EXAMPLE"
```

**Note:** When using [GNU Awk][1], you can put quotes around the filepath, allowing it to have spaces:

```c
#data EXAMPLE "data/example with spaces.txt"
```

[See this section](#a-note-about-whitespace) to know why this feature isn't available when using POSIX Awk.

### `#define`

The `#define` directive defines a preprocessor flag:

```c
#define FOO
```

**This is different from a C preprocessor macro**: no text substitution ever occurs. Flags only exist in the preprocessor's *'memory'*, and are meant to be used for **conditional compilation**.

### `#undef`

The `#undef` directive un-defines a preprocessor flag; that is, it removes its definition:

```c
#undef FOO
```

### `#ifdef`

The `#ifdef` directive begins a conditional block. It accepts a flag as argument, and checks if that flag has been defined:

```c
#ifdef FOO
...
#endif
```

As shown in the example above, a conditional block opened by `#ifdef` must **always** be closed with an `#endif` directive. Additionally, an `#else` directive is also supported:

```c
#ifdef BAR
...
#else
...
#endif
```

Nesting is also supported: conditional blocks can be nested within other conditional blocks.

### `#ifndef`

The `#ifndef` directive works exactly like `#ifdef`, but checks if the flag has **not** been defined instead.

It's specially useful in [include guards][2]:

```c
#ifndef FOO_SH
#define FOO_SH
...
#endif
```

## A Note About Whitespace

By default, POSIX Awk splits record fields by **whitespace**. You can define custom field separators, but they have limitations: you're only able to express what fields *aren't*.

Aranea splits fields by **whitespace** when using POSIX Awk. This is the default behavior.

It makes directives look very clean, but has one unfortunate consequence: filepaths with **spaces** aren't valid.

```c
#include oops not valid.sh
```

It shouldn't be a problem for **most** projects (*who uses spaces in their script names?!*), but it can be a surprise for some people, thus it deserves to be documented.

### Solution: GNU Awk

Whitespace is thankfully **not a problem with [GNU Awk][1]**, thanks to the `FPAT` extension, which lets Aranea use a regular expression for parsing fields.

With GNU Awk, **Aranea supports quoted strings**:

```c
#include "spaces are perfectly okay here.sh"
```

Because of this, you're heavily encouraged to use GNU Awk for best results.

A lot of Linux distributions already come with GNU Awk. In those distributions, `/usr/bin/awk` is typically a symlink to `/usr/bin/gawk`.

**Unfortunately**, Debian-based distros (like Ubuntu) ship with `mawk` instead. There, you will need to install `gawk` yourself (`sudo apt-get install gawk`) and manually edit the shebang line in the `aranea` script to use `gawk`.

[See this section](gawk-extras.md#installing-gnu-awk) for guidance on checking what flavor of Awk you have.

## Known Caveats

Aranea is just a little Awk script. It can do **a lot** for something so tiny, but of course it has limitations. Namely:

### Aranea Doesn't Speak Shell

Aranea doesn't understand shell code. If your shell code has any syntax errors, Aranea will not alert you about them.

You can easily get around this by piping Aranea's output to [shellcheck][5] during development:

```bash
aranea myscript.sh | shellcheck -
```

### Aranea Can't See Strings

Aranea doesn't "see" shell strings. This has unfortunate consequences for *multiline strings*:

```bash
EXAMPLE='
This is a multiline string.
#define foo
The line above is parsed as a valid preprocessor directive...
'
```

The `#define foo` line above is parsed as a valid preprocessor directive, despite being part of a multiline string.

**This can easily be avoided** by storing that string in a separate file and using the `#data` directive:

```c
#data EXAMPLE my-multiline-string.txt
```

Aranea will happily embed that text file into the script and assign its contents to the EXAMPLE variable. Problem solved!

[1]: https://www.gnu.org/software/gawk/
[2]: https://en.wikipedia.org/wiki/Include_guard
[3]: https://wiki.archlinux.org/title/Command-line_shell#POSIX_compliant
[4]: https://en.wikipedia.org/wiki/Here_document
[5]: https://www.shellcheck.net/
