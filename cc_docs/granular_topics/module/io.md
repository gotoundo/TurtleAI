# io

Emulates Lua's standard [io library](https://www.lua.org/manual/5.1/manual.html#5.7).

|  |  |
| --- | --- |
| [stdin](#v:stdin) | A file handle representing the "standard input". |
| [stdout](#v:stdout) | A file handle representing the "standard output". |
| [stderr](#v:stderr) | A file handle representing the "standard error" stream. |
| [close([file])](#v:close) | Closes the provided file handle. |
| [flush()](#v:flush) | Flushes the current output file. |
| [input([file])](#v:input) | Get or set the current input file. |
| [lines([filename, ...])](#v:lines) | Opens the given file name in read mode and returns an iterator that, each time it is called, returns a new line from the file. |
| [open(filename [, mode])](#v:open) | Open a file with the given mode, either returning a new file handle or `nil`, plus an error message. |
| [output([file])](#v:output) | Get or set the current output file. |
| [read(...)](#v:read) | Read from the currently opened input file. |
| [type(obj)](#v:type) | Checks whether `handle` is a given file handle, and determine if it is open or not. |
| [write(...)](#v:write) | Write to the currently opened output file. |

stdin[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/io.lua#L243)
:   A file handle representing the "standard input". Reading from this
    file will prompt the user for input.

stdout[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/io.lua#L245)
:   A file handle representing the "standard output". Writing to this
    file will display the written text to the screen.

stderr[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/io.lua#L247)
:   A file handle representing the "standard error" stream.

    One may use this to display error messages, writing to it will display
    them on the terminal.

close([file])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/io.lua#L284)
:   Closes the provided file handle.

    ### Parameters

    1. file? [`Handle`](io.html#ty:Handle) The file handle to close, defaults to the
       current output file.

    ### See also

    * **[`Handle:close`](io.html#ty:Handle:close)**
    * **[`io.output`](io.html#v:output)**

    ### Changes

    * **New in version 1.55**

flush()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/io.lua#L298)
:   Flushes the current output file.

    ### See also

    * **[`Handle:flush`](io.html#ty:Handle:flush)**
    * **[`io.output`](io.html#v:output)**

    ### Changes

    * **New in version 1.55**

input([file])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/io.lua#L308)
:   Get or set the current input file.

    ### Parameters

    1. file? [`Handle`](io.html#ty:Handle) | [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The new input file, either as a file path or pre-existing handle.

    ### Returns

    1. [`Handle`](io.html#ty:Handle) The current input file.

    ### Throws

    * If the provided filename cannot be opened for reading.

    ### Changes

    * **New in version 1.55**

lines([filename, ...])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/io.lua#L349)
:   Opens the given file name in read mode and returns an iterator that,
    each time it is called, returns a new line from the file.

    This can be used in a for loop to iterate over all lines of a file

    Once the end of the file has been reached, `nil` will be returned. The file is
    automatically closed.

    If no file name is given, the [current input](io.html#v:input) will be used instead.
    In this case, the handle is not used.

    ### Parameters

    1. filename? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the file to extract lines from
    2. ... The argument to pass to [`Handle:read`](io.html#ty:Handle:read) for each line.

    ### Returns

    1. function():[`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The line iterator.

    ### Throws

    * If the file cannot be opened for reading

    ### Usage

    * Iterate over every line in a file and print it out.

      ```
      for line in io.lines("/rom/help/intro.txt") do
        print(line)
      end
      ```

    ### See also

    * **[`Handle:lines`](io.html#ty:Handle:lines)**
    * **[`io.input`](io.html#v:input)**

    ### Changes

    * **New in version 1.55**

open(filename [, mode])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/io.lua#L383)
:   Open a file with the given mode, either returning a new file handle
    or `nil`, plus an error message.

    The `mode` string can be any of the following:

    * **"r"**: Read mode.
    * **"w"**: Write mode.
    * **"a"**: Append mode.
    * **"r+"**: Update mode (allows reading and writing), all data is preserved.
    * **"w+"**: Update mode, all data is erased.

    The mode may also have a `b` at the end, which opens the file in "binary
    mode". This has no impact on functionality.

    ### Parameters

    1. filename [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the file to open.
    2. mode? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The mode to open the file with. This defaults to `r`.

    ### Returns

    1. [`Handle`](io.html#ty:Handle) The opened file.

    #### Or

    1. nil In case of an error.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The reason the file could not be opened.

    ### Changes

    * **Changed in version 1.111.0:** Add support for `r+` and `w+`.

output([file])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/io.lua#L399)
:   Get or set the current output file.

    ### Parameters

    1. file? [`Handle`](io.html#ty:Handle) | [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The new output file, either as a file path or pre-existing handle.

    ### Returns

    1. [`Handle`](io.html#ty:Handle) The current output file.

    ### Throws

    * If the provided filename cannot be opened for writing.

    ### Changes

    * **New in version 1.55**

read(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/io.lua#L420)
:   Read from the currently opened input file.

    This is equivalent to `io.input():read(...)`. See [the documentation](io.html#ty:Handle:read)
    there for full details.

    ### Parameters

    1. ... [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The formats to read, defaulting to a whole line.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil... The data read, or `nil` if nothing can be read.

type(obj)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/io.lua#L430)
:   Checks whether `handle` is a given file handle, and determine if it is open
    or not.

    ### Parameters

    1. obj The value to check

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil `"file"` if this is an open file, `"closed file"` if it
       is a closed file handle, or `nil` if not a file handle.

write(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/io.lua#L448)
:   Write to the currently opened output file.

    This is equivalent to `io.output():write(...)`. See [the documentation](io.html#ty:Handle:write)
    there for full details.

    ### Parameters

    1. ... [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The strings to write

    ### Changes

    * **Changed in version 1.81.0:** Multiple arguments are now allowed.

### Types

### Handle

A file handle which can be read or written to.

Handle.close()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/io.lua#L42)
:   Close this file handle, freeing any resources it uses.

    ### Returns

    1. true If this handle was successfully closed.

    #### Or

    1. nil If this file handle could not be closed.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The reason it could not be closed.

    ### Throws

    * If this handle was already closed.

Handle.flush()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/io.lua#L61)
:   Flush any buffered output, forcing it to be written to the file

    ### Throws

    * If the handle has been closed

Handle.lines(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/io.lua#L96)
:   Returns an iterator that, each time it is called, returns a new
    line from the file.

    This can be used in a for loop to iterate over all lines of a file

    Once the end of the file has been reached, `nil` will be returned. The file is
    *not* automatically closed.

    ### Parameters

    1. ... The argument to pass to [`Handle:read`](io.html#ty:Handle:read) for each line.

    ### Returns

    1. function():[`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The line iterator.

    ### Throws

    * If the file cannot be opened for reading

    ### Usage

    * Iterate over every line in a file and print it out.

      ```
      local file = io.open("/rom/help/intro.txt")
      for line in file:lines() do
        print(line)
      end
      file:close()
      ```

    ### See also

    * **[`io.lines`](io.html#v:lines)**

    ### Changes

    * **New in version 1.3**

Handle.read(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/io.lua#L129)
:   Reads data from the file, using the specified formats. For each
    format provided, the function returns either the data read, or `nil` if
    no data could be read.

    The following formats are available:

    * `l`: Returns the next line (without a newline on the end).
    * `L`: Returns the next line (with a newline on the end).
    * `a`: Returns the entire rest of the file.
    * ~~`n`: Returns a number~~ (not implemented in CC).

    These formats can be preceded by a `*` to make it compatible with Lua 5.1.

    If no format is provided, `l` is assumed.

    ### Parameters

    1. ... The formats to use.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil... The data read from the file.

Handle.seek([whence [, offset]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/io.lua#L189)
:   Seeks the file cursor to the specified position, and returns the
    new position.

    `whence` controls where the seek operation starts, and is a string that
    may be one of these three values:

    * `set`: base position is 0 (beginning of the file)
    * `cur`: base is current position
    * `end`: base is end of file

    The default value of `whence` is `cur`, and the default value of `offset`
    is 0. This means that `file:seek()` without arguments returns the current
    position without moving.

    ### Parameters

    1. whence? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The place to set the cursor from.
    2. offset? `number` The offset from the start to move to.

    ### Returns

    1. `number` The new location of the file cursor.

Handle.setvbuf(mode [, size])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/io.lua#L211)
:   ##### ð Deprecated

    This has no effect in CC.

    Sets the buffering mode for an output file.

    This has no effect under ComputerCraft, and exists with compatility
    with base Lua.

    ### Parameters

    1. mode [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The buffering mode.
    2. size? `number` The size of the buffer.

    ### See also

    * **[`file:setvbuf`](https://www.lua.org/manual/5.1/manual.html#pdf-file:setvbuf)** Lua's documentation for `setvbuf`.

Handle.write(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/io.lua#L220)
:   Write one or more values to the file

    ### Parameters

    1. ... [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | `number` The values to write.

    ### Returns

    1. [`Handle`](io.html#ty:Handle) The current file, allowing chained calls.

    #### Or

    1. nil If the file could not be written to.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The error message which occurred while writing.

    ### Changes

    * **Changed in version 1.81.0:** Multiple arguments are now allowed.