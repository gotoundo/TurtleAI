# cc.pretty

A pretty printer for rendering data structures in an aesthetically
pleasing manner.

In order to display something using [`cc.pretty`](cc.pretty.html), you build up a series of
[documents](cc.pretty.html#ty:Doc). These behave a little bit like strings; you can concatenate
them together and then print them to the screen.

However, documents also allow you to control how they should be printed. There
are several functions (such as [`nest`](cc.pretty.html#v:nest) and [`group`](cc.pretty.html#v:group)) which allow you to control
the "layout" of the document. When you come to display the document, the 'best'
(most compact) layout is used.

The structure of this module is based on [A Prettier Printer](https://homepages.inf.ed.ac.uk/wadler/papers/prettier/prettier.pdf "A Prettier Printer").

### Usage

* Print a table to the terminal

  ```
  local pretty = require "cc.pretty"
  pretty.pretty_print({ 1, 2, 3 })
  ```
* Build a custom document and display it

  ```
  local pretty = require "cc.pretty"
  pretty.print(pretty.group(pretty.text("hello") .. pretty.space_line .. pretty.text("world")))
  ```

### Changes

* **New in version 1.87.0**

|  |  |
| --- | --- |
| [empty](#v:empty) | An empty document. |
| [space](#v:space) | A document with a single space in it. |
| [line](#v:line) | A line break. |
| [space\_line](#v:space_line) | A line break. |
| [text(text [, colour])](#v:text) | Create a new document from a string. |
| [concat(...)](#v:concat) | Concatenate several documents together. |
| [nest(depth, doc)](#v:nest) | Indent later lines of the given document with the given number of spaces. |
| [group(doc)](#v:group) | Builds a document which is displayed on a single line if there is enough room, or as normal if not. |
| [write(doc [, ribbon\_frac=0.6])](#v:write) | Display a document on the terminal. |
| [print(doc [, ribbon\_frac=0.6])](#v:print) | Display a document on the terminal with a trailing new line. |
| [render(doc [, width [, ribbon\_frac=0.6]])](#v:render) | Render a document, converting it into a string. |
| [pretty(obj [, options])](#v:pretty) | Pretty-print an arbitrary object, converting it into a document. |
| [pretty\_print(obj [, options [, ribbon\_frac=0.6]])](#v:pretty_print) | A shortcut for calling [`pretty`](cc.pretty.html#v:pretty) and [`print`](cc.pretty.html#v:print) together. |

empty[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L57)
:   An empty document.

space[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L60)
:   A document with a single space in it.

line[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L63)
:   A line break. When collapsed with [`group`](cc.pretty.html#v:group), this will be replaced with [`empty`](cc.pretty.html#v:empty).

space\_line[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L66)
:   A line break. When collapsed with [`group`](cc.pretty.html#v:group), this will be replaced with [`space`](cc.pretty.html#v:space).

text(text [, colour])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L87)
:   Create a new document from a string.

    If your string contains multiple lines, [`group`](cc.pretty.html#v:group) will flatten the string
    into a single line, with spaces between each line.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The string to construct a new document with.
    2. colour? `number` The colour this text should be printed with. If not given, we default to the current
       colour.

    ### Returns

    1. [`Doc`](cc.pretty.html#ty:Doc) The document with the provided text.

    ### Usage

    * Write some blue text.

      ```
      local pretty = require "cc.pretty"
      pretty.print(pretty.text("Hello!", colours.blue))
      ```

concat(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L126)
:   Concatenate several documents together. This behaves very similar to string concatenation.

    ### Parameters

    1. ... [`Doc`](cc.pretty.html#ty:Doc) | [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The documents to concatenate.

    ### Returns

    1. [`Doc`](cc.pretty.html#ty:Doc) The concatenated documents.

    ### Usage

    * ```
      local pretty = require "cc.pretty"
      local doc1, doc2 = pretty.text("doc1"), pretty.text("doc2")
      print(pretty.concat(doc1, " - ", doc2))
      print(doc1 .. " - " .. doc2) -- Also supports ..
      ```

nest(depth, doc)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L161)
:   Indent later lines of the given document with the given number of spaces.

    For instance, nesting the document

    ```
    foo
    bar
    ```

    by two spaces will produce

    ```
    foo
      bar
    ```

    ### Parameters

    1. depth `number` The number of spaces with which the document should be indented.
    2. doc [`Doc`](cc.pretty.html#ty:Doc) The document to indent.

    ### Returns

    1. [`Doc`](cc.pretty.html#ty:Doc) The nested document.

    ### Usage

    * ```
      local pretty = require "cc.pretty"
      print(pretty.nest(2, pretty.text("foo\nbar")))
      ```

group(doc)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L200)
:   Builds a document which is displayed on a single line if there is enough
    room, or as normal if not.

    ### Parameters

    1. doc [`Doc`](cc.pretty.html#ty:Doc) The document to group.

    ### Returns

    1. [`Doc`](cc.pretty.html#ty:Doc) The grouped document.

    ### Usage

    * Uses group to show things being displayed on one or multiple lines.

      ```
      local pretty = require "cc.pretty"
      local doc = pretty.group("Hello" .. pretty.space_line .. "World")
      print(pretty.render(doc, 5)) -- On multiple lines
      print(pretty.render(doc, 20)) -- Collapsed onto one.
      ```

write(doc [, ribbon\_frac=0.6])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L233)
:   Display a document on the terminal.

    ### Parameters

    1. doc [`Doc`](cc.pretty.html#ty:Doc) The document to render
    2. ribbon\_frac? `number` = `0.6` The maximum fraction of the width that we should write in.

print(doc [, ribbon\_frac=0.6])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L295)
:   Display a document on the terminal with a trailing new line.

    ### Parameters

    1. doc [`Doc`](cc.pretty.html#ty:Doc) The document to render.
    2. ribbon\_frac? `number` = `0.6` The maximum fraction of the width that we should write in.

render(doc [, width [, ribbon\_frac=0.6]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L309)
:   Render a document, converting it into a string.

    ### Parameters

    1. doc [`Doc`](cc.pretty.html#ty:Doc) The document to render.
    2. width? `number` The maximum width of this document. Note that long strings will not be wrapped to fit
       this width - it is only used for finding the best layout.
    3. ribbon\_frac? `number` = `0.6` The maximum fraction of the width that we should write in.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The rendered document as a string.

pretty(obj [, options])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L471)
:   Pretty-print an arbitrary object, converting it into a document.

    This can then be rendered with [`write`](cc.pretty.html#v:write) or [`print`](cc.pretty.html#v:print).

    ### Parameters

    1. obj The object to pretty-print.
    2. options? { function\_args = `boolean`, function\_source = `boolean` }

       Controls how various properties are displayed.

       * `function_args`: Show the arguments to a function if known (`false` by default).
       * `function_source`: Show where the function was defined, instead of
         `function: xxxxxxxx` (`false` by default).

    ### Returns

    1. [`Doc`](cc.pretty.html#ty:Doc) The object formatted as a document.

    ### Usage

    * Display a table on the screen

      ```
      local pretty = require "cc.pretty"
      pretty.print(pretty.pretty({ 1, 2, 3 }))
      ```

    ### See also

    * **[`pretty_print`](cc.pretty.html#v:pretty_print)** for a shorthand to prettify and print an object.

    ### Changes

    * **Changed in version 1.88.0:** Added `options` argument.

pretty\_print(obj [, options [, ribbon\_frac=0.6]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L501)
:   A shortcut for calling [`pretty`](cc.pretty.html#v:pretty) and [`print`](cc.pretty.html#v:print) together.

    ### Parameters

    1. obj The object to pretty-print.
    2. options? { function\_args = `boolean`, function\_source = `boolean` }

       Controls how various properties are displayed.

       * `function_args`: Show the arguments to a function if known (`false` by default).
       * `function_source`: Show where the function was defined, instead of
         `function: xxxxxxxx` (`false` by default).
    3. ribbon\_frac? `number` = `0.6` The maximum fraction of the width that we should write in.

    ### Usage

    * Display a table on the screen.

      ```
      local pretty = require "cc.pretty"
      pretty.pretty_print({ 1, 2, 3 })
      ```

    ### See also

    * **[`pretty`](cc.pretty.html#v:pretty)**
    * **[`print`](cc.pretty.html#v:print)**

    ### Changes

    * **New in version 1.99**

### Types

### Doc

A document containing formatted text, with multiple possible layouts.

Documents effectively represent a sequence of strings in alternative layouts,
which we will try to print in the most compact form necessary.