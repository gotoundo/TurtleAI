# keys

Constants for all keyboard "key codes", as queued by the [`key`](../event/key.html) event.

These values are not guaranteed to remain the same between versions. It is
recommended that you use the constants provided by this file, rather than
the underlying numerical values.

### Changes

* **New in version 1.4**

|  |  |
| --- | --- |
| [getName(code)](#v:getName) | Translates a numerical key code to a human-readable name. |

getName(code)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/keys.lua#L153)
:   Translates a numerical key code to a human-readable name. The human-readable
    name is one of the constants in the keys API.

    ### Parameters

    1. code `number` The key code to look up.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The name of the key, or `nil` if not a valid key code.

    ### Usage

    * ```
      keys.getName(keys.enter)
      ```