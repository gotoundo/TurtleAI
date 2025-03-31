# cc.completion

A collection of helper methods for working with input completion, such
as that require by [`_G.read`](../module/_G.html#v:read).

### See also

* **[`cc.shell.completion`](cc.shell.completion.html)** For additional helpers to use with
  [`shell.setCompletionFunction`](../module/shell.html#v:setCompletionFunction).

### Changes

* **New in version 1.85.0**

|  |  |
| --- | --- |
| [choice(text, choices [, add\_space])](#v:choice) | Complete from a choice of one or more strings. |
| [peripheral(text [, add\_space])](#v:peripheral) | Complete the name of a currently attached peripheral. |
| [side(text [, add\_space])](#v:side) | Complete the side of a computer. |
| [setting(text [, add\_space])](#v:setting) | Complete a [setting](../module/settings.html). |
| [command(text [, add\_space])](#v:command) | Complete the name of a Minecraft [command](../module/commands.html). |

choice(text, choices [, add\_space])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/completion.lua#L42)
:   Complete from a choice of one or more strings.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The input string to complete.
    2. choices { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } The list of choices to complete from.
    3. add\_space? `boolean` Whether to add a space after the completed item.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of suffixes of matching strings.

    ### Usage

    * Call [`_G.read`](../module/_G.html#v:read), completing the names of various animals.

      ```
      local completion = require "cc.completion"
      local animals = { "dog", "cat", "lion", "unicorn" }
      read(nil, nil, function(text) return completion.choice(text, animals) end)
      ```

peripheral(text [, add\_space])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/completion.lua#L57)
:   Complete the name of a currently attached peripheral.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The input string to complete.
    2. add\_space? `boolean` Whether to add a space after the completed name.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of suffixes of matching peripherals.

    ### Usage

    * ```
      local completion = require "cc.completion"
      read(nil, nil, completion.peripheral)
      ```

side(text [, add\_space])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/completion.lua#L73)
:   Complete the side of a computer.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The input string to complete.
    2. add\_space? `boolean` Whether to add a space after the completed side.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of suffixes of matching sides.

    ### Usage

    * ```
      local completion = require "cc.completion"
      read(nil, nil, completion.side)
      ```

setting(text [, add\_space])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/completion.lua#L87)
:   Complete a [setting](../module/settings.html).

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The input string to complete.
    2. add\_space? `boolean` Whether to add a space after the completed settings.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of suffixes of matching settings.

    ### Usage

    * ```
      local completion = require "cc.completion"
      read(nil, nil, completion.setting)
      ```

command(text [, add\_space])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/completion.lua#L103)
:   Complete the name of a Minecraft [command](../module/commands.html).

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The input string to complete.
    2. add\_space? `boolean` Whether to add a space after the completed command.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of suffixes of matching commands.

    ### Usage

    * ```
      local completion = require "cc.completion"
      read(nil, nil, completion.command)
      ```