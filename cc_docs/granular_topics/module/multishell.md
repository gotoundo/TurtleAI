# multishell

Multishell allows multiple programs to be run at the same time.

When multiple programs are running, it displays a tab bar at the top of the
screen, which allows you to switch between programs. New programs can be
launched using the `fg` or `bg` programs, or using the [`shell.openTab`](shell.html#v:openTab) and
[`multishell.launch`](multishell.html#v:launch) functions.

Each process is identified by its ID, which corresponds to its position in
the tab list. As tabs may be opened and closed, this ID is *not* constant
over a program's run. As such, be careful not to use stale IDs.

As with [`shell`](shell.html), [`multishell`](multishell.html) is not a "true" API. Instead, it is a
standard program, which launches a shell and injects its API into the shell's
environment. This API is not available in the global environment, and so is
not available to [APIs](os.html#v:loadAPI).

### Changes

* **New in version 1.6**

|  |  |
| --- | --- |
| [getFocus()](#v:getFocus) | Get the currently visible process. |
| [setFocus(n)](#v:setFocus) | Change the currently visible process. |
| [getTitle(n)](#v:getTitle) | Get the title of the given tab. |
| [setTitle(n, title)](#v:setTitle) | Set the title of the given process. |
| [getCurrent()](#v:getCurrent) | Get the index of the currently running process. |
| [launch(tProgramEnv, sProgramPath, ...)](#v:launch) | Start a new process, with the given environment, program and arguments. |
| [getCount()](#v:getCount) | Get the number of processes within this multishell. |

getFocus()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/advanced/multishell.lua#L230)
:   Get the currently visible process. This will be the one selected on
    the tab bar.

    Note, this is different to [`getCurrent`](multishell.html#v:getCurrent), which returns the process which is
    currently executing.

    ### Returns

    1. `number` The currently visible process's index.

    ### See also

    * **[`setFocus`](multishell.html#v:setFocus)**

setFocus(n)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/advanced/multishell.lua#L240)
:   Change the currently visible process.

    ### Parameters

    1. n `number` The process index to switch to.

    ### Returns

    1. `boolean` If the process was changed successfully. This will
       return `false` if there is no process with this id.

    ### See also

    * **[`getFocus`](multishell.html#v:getFocus)**

getTitle(n)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/advanced/multishell.lua#L257)
:   Get the title of the given tab.

    This starts as the name of the program, but may be changed using
    [`multishell.setTitle`](multishell.html#v:setTitle).

    ### Parameters

    1. n `number` The process index.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The current process title, or `nil` if the
       process doesn't exist.

setTitle(n, title)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/advanced/multishell.lua#L273)
:   Set the title of the given process.

    ### Parameters

    1. n `number` The process index.
    2. title [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The new process title.

    ### Usage

    * Change the title of the current process

      ```
      multishell.setTitle(multishell.getCurrent(), "Hello")
      ```

    ### See also

    * **[`getTitle`](multishell.html#v:getTitle)**

getCurrent()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/advanced/multishell.lua#L285)
:   Get the index of the currently running process.

    ### Returns

    1. `number` The currently running process.

launch(tProgramEnv, sProgramPath, ...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/advanced/multishell.lua#L305)
:   Start a new process, with the given environment, program and arguments.

    The returned process index is not constant over the program's run. It can be
    safely used immediately after launching (for instance, to update the title or
    switch to that tab). However, after your program has yielded, it may no
    longer be correct.

    ### Parameters

    1. tProgramEnv [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The environment to load the path under.
    2. sProgramPath [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to the program to run.
    3. ... Additional arguments to pass to the program.

    ### Returns

    1. `number` The index of the created process.

    ### Usage

    * Run the "hello" program, and set its title to "Hello!"

      ```
      local id = multishell.launch({}, "/rom/programs/fun/hello.lua")
      multishell.setTitle(id, "Hello!")
      ```

    ### See also

    * **[`os.run`](os.html#v:run)**

getCount()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/advanced/multishell.lua#L319)
:   Get the number of processes within this multishell.

    ### Returns

    1. `number` The number of processes.