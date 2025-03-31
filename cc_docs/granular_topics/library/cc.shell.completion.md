# cc.shell.completion

A collection of helper methods for working with shell completion.

Most programs may be completed using the [`build`](cc.shell.completion.html#v:build) helper method, rather than
manually switching on the argument index.

Note, the helper functions within this module do not accept an argument index,
and so are not directly usable with the [`shell.setCompletionFunction`](../module/shell.html#v:setCompletionFunction). Instead,
wrap them using [`build`](cc.shell.completion.html#v:build), or your own custom function.

### Usage

* Register a completion handler for example.lua which prompts for a
  choice of options, followed by a directory, and then multiple files.

  ```
  local completion = require "cc.shell.completion"
  local complete = completion.build(
    { completion.choice, { "get", "put" } },
    completion.dir,
    { completion.file, many = true }
  )
  shell.setCompletionFunction("example.lua", complete)
  read(nil, nil, shell.complete, "example ")
  ```

### See also

* **[`cc.completion`](cc.completion.html)** For more general helpers, suitable for use with [`_G.read`](../module/_G.html#v:read).
* **[`shell.setCompletionFunction`](../module/shell.html#v:setCompletionFunction)**

### Changes

* **New in version 1.85.0**

|  |  |
| --- | --- |
| [file(shell, text)](#v:file) | Complete the name of a file relative to the current working directory. |
| [dir(shell, text)](#v:dir) | Complete the name of a directory relative to the current working directory. |
| [dirOrFile(shell, text, previous [, add\_space])](#v:dirOrFile) | Complete the name of a file or directory relative to the current working directory. |
| [program(shell, text)](#v:program) | Complete the name of a program. |
| [programWithArgs(shell, text, previous, starting)](#v:programWithArgs) | Complete arguments of a program. |
| [help](#v:help) | Wraps [`help.completeTopic`](../module/help.html#v:completeTopic) as a [`build`](cc.shell.completion.html#v:build) compatible function. |
| [choice](#v:choice) | Wraps [`cc.completion.choice`](cc.completion.html#v:choice) as a [`build`](cc.shell.completion.html#v:build) compatible function. |
| [peripheral](#v:peripheral) | Wraps [`cc.completion.peripheral`](cc.completion.html#v:peripheral) as a [`build`](cc.shell.completion.html#v:build) compatible function. |
| [side](#v:side) | Wraps [`cc.completion.side`](cc.completion.html#v:side) as a [`build`](cc.shell.completion.html#v:build) compatible function. |
| [setting](#v:setting) | Wraps [`cc.completion.setting`](cc.completion.html#v:setting) as a [`build`](cc.shell.completion.html#v:build) compatible function. |
| [command](#v:command) | Wraps [`cc.completion.command`](cc.completion.html#v:command) as a [`build`](cc.shell.completion.html#v:build) compatible function. |
| [build(...)](#v:build) | A helper function for building shell completion arguments. |

file(shell, text)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L40)
:   Complete the name of a file relative to the current working directory.

    ### Parameters

    1. shell [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The shell we're completing in.
    2. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Current text to complete.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of suffixes of matching files.

dir(shell, text)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L53)
:   Complete the name of a directory relative to the current working directory.

    ### Parameters

    1. shell [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The shell we're completing in.
    2. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Current text to complete.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of suffixes of matching directories.

dirOrFile(shell, text, previous [, add\_space])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L69)
:   Complete the name of a file or directory relative to the current working
    directory.

    ### Parameters

    1. shell [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The shell we're completing in.
    2. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Current text to complete.
    3. previous { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } The shell arguments before this one.
    4. add\_space? `boolean` Whether to add a space after the completed item.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of suffixes of matching files and directories.

program(shell, text)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L98)
:   Complete the name of a program.

    ### Parameters

    1. shell [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The shell we're completing in.
    2. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Current text to complete.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of suffixes of matching programs.

    ### See also

    * **[`shell.completeProgram`](../module/shell.html#v:completeProgram)**

programWithArgs(shell, text, previous, starting)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L110)
:   Complete arguments of a program.

    ### Parameters

    1. shell [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The shell we're completing in.
    2. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Current text to complete.
    3. previous { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } The shell arguments before this one.
    4. starting `number` Which argument index this program and args start at.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of suffixes of matching programs or arguments.

    ### Changes

    * **New in version 1.97.0**

help[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L200)
:   Wraps [`help.completeTopic`](../module/help.html#v:completeTopic) as a [`build`](cc.shell.completion.html#v:build) compatible function.

choice[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L201)
:   Wraps [`cc.completion.choice`](cc.completion.html#v:choice) as a [`build`](cc.shell.completion.html#v:build) compatible function.

peripheral[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L202)
:   Wraps [`cc.completion.peripheral`](cc.completion.html#v:peripheral) as a [`build`](cc.shell.completion.html#v:build) compatible function.

side[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L203)
:   Wraps [`cc.completion.side`](cc.completion.html#v:side) as a [`build`](cc.shell.completion.html#v:build) compatible function.

setting[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L204)
:   Wraps [`cc.completion.setting`](cc.completion.html#v:setting) as a [`build`](cc.shell.completion.html#v:build) compatible function.

command[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L205)
:   Wraps [`cc.completion.command`](cc.completion.html#v:command) as a [`build`](cc.shell.completion.html#v:build) compatible function.

build(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L158)
:   A helper function for building shell completion arguments.

    This accepts a series of single-argument completion functions, and combines
    them into a function suitable for use with [`shell.setCompletionFunction`](../module/shell.html#v:setCompletionFunction).

    ### Parameters

    1. ... nil | [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) | `function`

       Every argument to [`build`](cc.shell.completion.html#v:build) represents an argument
       to the program you wish to complete. Each argument can be one of three types:

       * `nil`: This argument will not be completed.
       * A function: This argument will be completed with the given function. It is
         called with the [`shell`](../module/shell.html) object, the string to complete and the arguments
         before this one.
       * A table: This acts as a more powerful version of the function case. The table
         must have a function as the first item - this will be called with the shell,
         string and preceding arguments as above, but also followed by any additional
         items in the table. This provides a more convenient interface to pass
         options to your completion functions.

         If this table is the last argument, it may also set the `many` key to true,
         which states this function should be used to complete any remaining arguments.