# cc.require

A pure Lua implementation of the builtin [`require`](https://www.lua.org/manual/5.1/manual.html#pdf-require) function and
[`package`](https://www.lua.org/manual/5.1/manual.html#5.3) library.

Generally you do not need to use this module - it is injected into the every
program's environment. However, it may be useful when building a custom shell or
when running programs yourself.

### Usage

* Construct the package and require function, and insert them into a
  custom environment.

  ```
  local r = require "cc.require"
  local env = setmetatable({}, { __index = _ENV })
  env.require, env.package = r.make(env, "/")

  -- Now we have our own require function, separate to the original.
  local r2 = env.require "cc.require"
  print(r, r2)
  ```

### See also

* **[`Reusing code with require`](../guide/using_require.html)** For an introduction on how to use [`require`](https://www.lua.org/manual/5.1/manual.html#pdf-require).

### Changes

* **New in version 1.88.0**

|  |  |
| --- | --- |
| [make(env, dir)](#v:make) | Build an implementation of Lua's [`package`](https://www.lua.org/manual/5.1/manual.html#5.3) library, and a [`require`](https://www.lua.org/manual/5.1/manual.html#pdf-require) function to load modules within it. |

make(env, dir)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/require.lua#L120)
:   Build an implementation of Lua's [`package`](https://www.lua.org/manual/5.1/manual.html#5.3) library, and a [`require`](https://www.lua.org/manual/5.1/manual.html#pdf-require)
    function to load modules within it.

    ### Parameters

    1. env [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The environment to load packages into.
    2. dir [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The directory that relative packages are loaded from.

    ### Returns

    1. `function` The new [`require`](https://www.lua.org/manual/5.1/manual.html#pdf-require) function.
    2. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The new [`package`](https://www.lua.org/manual/5.1/manual.html#5.3) library.