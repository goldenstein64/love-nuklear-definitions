# LÖVE Nuklear Definitions

Definition files for [keharriso/love-nuklear](https://github.com/keharriso/love-nuklear) 2.6.1 to use with [sumneko/lua-language-server](https://github.com/sumneko/lua-language-server). The annotations have been manually re-written directly from the [docs](https://github.com/keharriso/love-nuklear/wiki/Documentation) to be parsable by the LSP.

Some features are missing simply because I don't know how to lint them. The most pressing one is finding a stricter definition for the `nuklear.color` alias, it is just a string as of now.

Some of `nuklear.ui`'s function definitions have a lot of overloads, like `ui:combobox`, so their documentation is hard to read. It may be better to switch to optional arguments in the future.

The type definitions under `nuklear.style` do not offer key auto-complete because the fields are defined using bracket indexing, so documentation for styles is essentially limited to linting. It may be better to offer an alternative form of documentation using alternative keys, a plugin, a template, etc.

## Usage

```jsonc
// settings.json
{
  "Lua.workspace.library": [
    // path to wherever this repo was cloned to
    "path/to/this/repo",
    // e.g. on Windows, "$USERPROFILE/Documents/LuaEnvironments/love-nuklear"

    // this library uses LÖVE as a dependency
    "${3rd}/love2d"
  ]
}
```

For a more detailed description of how to install a library of definition files, see the LSP's [wiki](https://github.com/sumneko/lua-language-server/wiki/Libraries).

## Types

The types provided by this library are, exhaustively:

* Classes, given as `nuklear.[CLASS NAME]`. Every class is listed below:

  * `nuklear.ui`
  * `nuklear.style`
  * `nuklear.style.text`
  * `nuklear.style.button`
  * `nuklear.style.option`
  * `nuklear.style.selectable`
  * `nuklear.style.slider`
  * `nuklear.style.progress`
  * `nuklear.style.edit`
  * `nuklear.style.scrollbar`
  * `nuklear.style.chart`
  * `nuklear.style.tab`
  * `nuklear.style.combo`
  * `nuklear.style.window`
  * `nuklear.style.window.header`

* Aliases, given by `nuklear.[ALIAS NAME]`. Every alias is listed below:

  * `nuklear.flags`
  * `nuklear.image`
  * `nuklear.symbol`
  * `nuklear.alignment`
  * `nuklear.color`

