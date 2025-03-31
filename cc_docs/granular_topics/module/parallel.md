# parallel

A simple way to run several functions at once.

Functions are not actually executed simultaneously, but rather this API will
automatically switch between them whenever they yield (e.g. whenever they call
[`coroutine.yield`](https://www.lua.org/manual/5.1/manual.html#pdf-coroutine.yield), or functions that call that - such as [`os.pullEvent`](os.html#v:pullEvent) - or
functions that call that, etc - basically, anything that causes the function
to "pause").

Each function executed in "parallel" gets its own copy of the event queue,
and so "event consuming" functions (again, mostly anything that causes the
script to pause - eg [`os.sleep`](os.html#v:sleep), [`rednet.receive`](rednet.html#v:receive), most of the [`turtle`](turtle.html) API,
etc) can safely be used in one without affecting the event queue accessed by
the other.

##### â  warning

When using this API, be careful to pass the functions you want to run in
parallel, and *not* the result of calling those functions.

For instance, the following is correct:

```
local function do_sleep() sleep(1) end
parallel.waitForAny(do_sleep, rednet.receive)
```

but the following is **NOT**:

```
local function do_sleep() sleep(1) end
parallel.waitForAny(do_sleep(), rednet.receive)
```

### Changes

* **New in version 1.2**

|  |  |
| --- | --- |
| [waitForAny(...)](#v:waitForAny) | Switches between execution of the functions, until any of them finishes. |
| [waitForAll(...)](#v:waitForAll) | Switches between execution of the functions, until all of them are finished. |

waitForAny(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/parallel.lua#L117)
:   Switches between execution of the functions, until any of them
    finishes. If any of the functions errors, the message is propagated upwards
    from the [`parallel.waitForAny`](parallel.html#v:waitForAny) call.

    ### Parameters

    1. ... `function` The functions this task will run

    ### Usage

    * Print a message every second until the `q` key is pressed.

      ```
      local function tick()
          while true do
              os.sleep(1)
              print("Tick")
          end
      end
      local function wait_for_q()
          repeat
              local _, key = os.pullEvent("key")
          until key == keys.q
          print("Q was pressed!")
      end

      parallel.waitForAny(tick, wait_for_q)
      print("Everything done!")
      ```

waitForAll(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/parallel.lua#L141)
:   Switches between execution of the functions, until all of them are
    finished. If any of the functions errors, the message is propagated upwards
    from the [`parallel.waitForAll`](parallel.html#v:waitForAll) call.

    ### Parameters

    1. ... `function` The functions this task will run

    ### Usage

    * Start off two timers and wait for them both to run.

      ```
      local function a()
          os.sleep(1)
          print("A is done")
      end
      local function b()
          os.sleep(3)
          print("B is done")
      end

      parallel.waitForAll(a, b)
      print("Everything done!")
      ```