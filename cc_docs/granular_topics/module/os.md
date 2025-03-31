# os

The [`os`](os.html) API allows interacting with the current computer.

|  |  |
| --- | --- |
| [loadAPI(path)](#v:loadAPI) | Loads the given API into the global environment. |
| [unloadAPI(name)](#v:unloadAPI) | Unloads an API which was loaded by [`os.loadAPI`](os.html#v:loadAPI). |
| [pullEvent([filter])](#v:pullEvent) | Pause execution of the current thread and waits for any events matching `filter`. |
| [pullEventRaw([filter])](#v:pullEventRaw) | Pause execution of the current thread and waits for events, including the `terminate` event. |
| [sleep(time)](#v:sleep) | Pauses execution for the specified number of seconds, alias of [`_G.sleep`](_G.html#v:sleep). |
| [version()](#v:version) | Get the current CraftOS version (for example, `CraftOS 1.9`). |
| [run(env, path, ...)](#v:run) | Run the program at the given path with the specified environment and arguments. |
| [queueEvent(name, ...)](#v:queueEvent) | Adds an event to the event queue. |
| [startTimer(time)](#v:startTimer) | Starts a timer that will run for the specified number of seconds. |
| [cancelTimer(token)](#v:cancelTimer) | Cancels a timer previously started with [`startTimer`](os.html#v:startTimer). |
| [setAlarm(time)](#v:setAlarm) | Sets an alarm that will fire at the specified [in-game time](os.html#v:time). |
| [cancelAlarm(token)](#v:cancelAlarm) | Cancels an alarm previously started with setAlarm. |
| [shutdown()](#v:shutdown) | Shuts down the computer immediately. |
| [reboot()](#v:reboot) | Reboots the computer immediately. |
| [getComputerID()](#v:getComputerID) | Returns the ID of the computer. |
| [computerID()](#v:computerID) | Returns the ID of the computer. |
| [getComputerLabel()](#v:getComputerLabel) | Returns the label of the computer, or `nil` if none is set. |
| [computerLabel()](#v:computerLabel) | Returns the label of the computer, or `nil` if none is set. |
| [setComputerLabel([label])](#v:setComputerLabel) | Set the label of this computer. |
| [clock()](#v:clock) | Returns the number of seconds that the computer has been running. |
| [time([locale])](#v:time) | Returns the current time depending on the string passed in. |
| [day([args])](#v:day) | Returns the day depending on the locale specified. |
| [epoch([args])](#v:epoch) | Returns the number of milliseconds since an epoch depending on the locale. |
| [date([format [, time]])](#v:date) | Returns a date string (or table) using a specified format string and optional time to format. |

loadAPI(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/doc/stub/os.lua#L20)
:   ##### ð Deprecated

    When possible it's best to avoid using this function. It pollutes
    the global table and can mask errors.

    [`require`](https://www.lua.org/manual/5.1/manual.html#pdf-require) should be used to load libraries instead.

    Loads the given API into the global environment.

    This function loads and executes the file at the given path, and all global
    variables and functions exported by it will by available through the use of
    `myAPI.<function name>`, where `myAPI` is the base name of the API file.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path of the API to load.

    ### Returns

    1. `boolean` Whether or not the API was successfully loaded.

    ### Changes

    * **New in version 1.2**

unloadAPI(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/doc/stub/os.lua#L29)
:   ##### ð Deprecated

    See [`os.loadAPI`](os.html#v:loadAPI) for why.

    Unloads an API which was loaded by [`os.loadAPI`](os.html#v:loadAPI).

    This effectively removes the specified table from `_G`.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the API to unload.

    ### Changes

    * **New in version 1.2**

pullEvent([filter])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/doc/stub/os.lua#L67)
:   Pause execution of the current thread and waits for any events matching
    `filter`.

    This function [yields](https://www.lua.org/manual/5.1/manual.html#pdf-coroutine.yield) the current process and waits for it
    to be resumed with a vararg list where the first element matches `filter`.
    If no `filter` is supplied, this will match all events.

    Unlike [`os.pullEventRaw`](os.html#v:pullEventRaw), it will stop the application upon a "terminate"
    event, printing the error "Terminated".

    ### Parameters

    1. filter? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Event to filter for.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) event The name of the event that fired.
    2. `any` param... Optional additional parameters of the event.

    ### Usage

    * Listen for `mouse_click` events.

      ```
      while true do
          local event, button, x, y = os.pullEvent("mouse_click")
          print("Button", button, "was clicked at", x, ",", y)
      end
      ```
    * Listen for multiple events.

      ```
      while true do
          local eventData = {os.pullEvent()}
          local event = eventData[1]

          if event == "mouse_click" then
              print("Button", eventData[2], "was clicked at", eventData[3], ",", eventData[4])
          elseif event == "key" then
              print("Key code", eventData[2], "was pressed")
          end
      end
      ```

    ### See also

    * **[`os.pullEventRaw`](os.html#v:pullEventRaw)** To pull the terminate event.

    ### Changes

    * **Changed in version 1.3:** Added filter argument.

pullEventRaw([filter])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/doc/stub/os.lua#L90)
:   Pause execution of the current thread and waits for events, including the
    `terminate` event.

    This behaves almost the same as [`os.pullEvent`](os.html#v:pullEvent), except it allows you to handle
    the `terminate` event yourself - the program will not stop execution when
    `Ctrl+T` is pressed.

    ### Parameters

    1. filter? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Event to filter for.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) event The name of the event that fired.
    2. `any` param... Optional additional parameters of the event.

    ### Usage

    * Listen for `terminate` events.

      ```
      while true do
          local event = os.pullEventRaw()
          if event == "terminate" then
              print("Caught terminate event!")
          end
      end
      ```

    ### See also

    * **[`os.pullEvent`](os.html#v:pullEvent)** To pull events normally.

sleep(time)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/doc/stub/os.lua#L96)
:   Pauses execution for the specified number of seconds, alias of [`_G.sleep`](_G.html#v:sleep).

    ### Parameters

    1. time `number` The number of seconds to sleep for, rounded up to the
       nearest multiple of 0.05.

version()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/doc/stub/os.lua#L105)
:   Get the current CraftOS version (for example, `CraftOS 1.9`).

    This is defined by `bios.lua`. For the current version of CC:Tweaked, this
    should return `CraftOS 1.9`.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The current CraftOS version.

    ### Usage

    * ```
      os.version()
      ```

run(env, path, ...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/doc/stub/os.lua#L130)
:   Run the program at the given path with the specified environment and
    arguments.

    This function does not resolve program names like the shell does. This means
    that, for example, `os.run("edit")` will not work. As well as this, it does not
    provide access to the [`shell`](shell.html) API in the environment. For this behaviour, use
    [`shell.run`](shell.html#v:run) instead.

    If the program cannot be found, or failed to run, it will print the error and
    return `false`. If you want to handle this more gracefully, use an alternative
    such as [`loadfile`](https://www.lua.org/manual/5.1/manual.html#pdf-loadfile).

    ### Parameters

    1. env [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The environment to run the program with.
    2. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The exact path of the program to run.
    3. ... The arguments to pass to the program.

    ### Returns

    1. `boolean` Whether or not the program ran successfully.

    ### Usage

    * Run the default shell from within your program:

      ```
      os.run({}, "/rom/programs/shell.lua")
      ```

    ### See also

    * **[`shell.run`](shell.html#v:run)**
    * **[`loadfile`](https://www.lua.org/manual/5.1/manual.html#pdf-loadfile)**

queueEvent(name, ...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/OSAPI.java#L139)
:   Adds an event to the event queue. This event can later be pulled with
    os.pullEvent.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the event to queue.
    2. ... The parameters of the event. These can be any primitive type (boolean, number, string) as well as
       tables. Other types (like functions), as well as metatables, will not be preserved.

    ### See also

    * **[`os.pullEvent`](os.html#v:pullEvent)** To pull the event queued

startTimer(time)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/OSAPI.java#L159)
:   Starts a timer that will run for the specified number of seconds. Once
    the timer fires, a [`timer`](../event/timer.html) event will be added to the queue with the ID
    returned from this function as the first parameter.

    As with [sleep](os.html#v:sleep), the time will automatically be rounded up to
    the nearest multiple of 0.05 seconds, as it waits for a fixed amount of
    world ticks.

    ### Parameters

    1. time `number` The number of seconds until the timer fires.

    ### Returns

    1. `number` The ID of the new timer. This can be used to filter the [`timer`](../event/timer.html)
       event, or [cancel the timer](os.html#v:cancelTimer).

    ### Throws

    * If the time is below zero.

    ### See also

    * **[`cancelTimer`](os.html#v:cancelTimer)** To cancel a timer.

cancelTimer(token)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/OSAPI.java#L172)
:   Cancels a timer previously started with [`startTimer`](os.html#v:startTimer). This
    will stop the timer from firing.

    ### Parameters

    1. token `number` The ID of the timer to cancel.

    ### See also

    * **[`startTimer`](os.html#v:startTimer)** To start a timer.

    ### Changes

    * **New in version 1.6**

setAlarm(time)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/OSAPI.java#L189)
:   Sets an alarm that will fire at the specified [in-game time](os.html#v:time).
    When it fires, an `alarm` event will be added to the event queue with the
    ID returned from this function as the first parameter.

    ### Parameters

    1. time `number` The time at which to fire the alarm, in the range [0.0, 24.0).

    ### Returns

    1. `number` The ID of the new alarm. This can be used to filter the
       `alarm` event, or [cancel the alarm](os.html#v:cancelAlarm).

    ### Throws

    * If the time is out of range.

    ### See also

    * **[`cancelAlarm`](os.html#v:cancelAlarm)** To cancel an alarm.

    ### Changes

    * **New in version 1.2**

cancelAlarm(token)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/OSAPI.java#L208)
:   Cancels an alarm previously started with setAlarm. This will stop the
    alarm from firing.

    ### Parameters

    1. token `number` The ID of the alarm to cancel.

    ### See also

    * **[`setAlarm`](os.html#v:setAlarm)** To set an alarm.

    ### Changes

    * **New in version 1.6**

shutdown()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/OSAPI.java#L218)
:   Shuts down the computer immediately.

reboot()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/OSAPI.java#L226)
:   Reboots the computer immediately.

getComputerID()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/OSAPI.java#L236)
:   Returns the ID of the computer.

    ### Returns

    1. `number` The ID of the computer.

computerID()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/OSAPI.java#L236)
:   Returns the ID of the computer.

    ### Returns

    1. `number` The ID of the computer.

getComputerLabel()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/OSAPI.java#L248)
:   Returns the label of the computer, or `nil` if none is set.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The label of the computer.

    ### Changes

    * **New in version 1.3**

computerLabel()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/OSAPI.java#L248)
:   Returns the label of the computer, or `nil` if none is set.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The label of the computer.

    ### Changes

    * **New in version 1.3**

setComputerLabel([label])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/OSAPI.java#L260)
:   Set the label of this computer.

    ### Parameters

    1. label? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The new label. May be `nil` in order to clear it.

    ### Changes

    * **New in version 1.3**

clock()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/OSAPI.java#L271)
:   Returns the number of seconds that the computer has been running.

    ### Returns

    1. `number` The computer's uptime.

    ### Changes

    * **New in version 1.2**

time([locale])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/OSAPI.java#L305)
:   Returns the current time depending on the string passed in. This will
    always be in the range [0.0, 24.0).

    * If called with `ingame`, the current world time will be returned.
      This is the default if nothing is passed.
    * If called with `utc`, returns the hour of the day in UTC time.
    * If called with `local`, returns the hour of the day in the
      timezone the server is located in.

    This function can also be called with a table returned from [`date`](os.html#v:date),
    which will convert the date fields into a UNIX timestamp (number of
    seconds since 1 January 1970).

    ### Parameters

    1. locale? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The locale of the time, or a table filled by `os.date("*t")` to decode. Defaults to `ingame` locale if not specified.

    ### Returns

    1. `any` The hour of the selected locale, or a UNIX timestamp from the table, depending on the argument passed in.

    ### Throws

    * If an invalid locale is passed.

    ### Usage

    * Print the current in-game time.

      ```
      textutils.formatTime(os.time())
      ```

    ### See also

    * **[`textutils.formatTime`](textutils.html#v:formatTime)** To convert times into a user-readable string.
    * **[`date`](os.html#v:date)** To get a date table that can be converted with this function.

    ### Changes

    * **New in version 1.2**
    * **Changed in version 1.80pr1:** Add support for getting the local and UTC time.
    * **Changed in version 1.82.0:** Arguments are now case insensitive.
    * **Changed in version 1.83.0:** [`time`](os.html#v:time) now accepts table arguments and converts them to UNIX timestamps.

day([args])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/OSAPI.java#L335)
:   Returns the day depending on the locale specified.

    * If called with `ingame`, returns the number of days since the
      world was created. This is the default.
    * If called with `utc`, returns the number of days since 1 January
      1970 in the UTC timezone.
    * If called with `local`, returns the number of days since 1
      January 1970 in the server's local timezone.

    ### Parameters

    1. args? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The locale to get the day for. Defaults to `ingame` if not set.

    ### Returns

    1. `number` The day depending on the selected locale.

    ### Throws

    * If an invalid locale is passed.

    ### Changes

    * **New in version 1.48**
    * **Changed in version 1.82.0:** Arguments are now case insensitive.

epoch([args])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/OSAPI.java#L374)
:   Returns the number of milliseconds since an epoch depending on the locale.

    * If called with `ingame`, returns the number of *in-game* milliseconds since the
      world was created. This is the default.
    * If called with `utc`, returns the number of milliseconds since 1
      January 1970 in the UTC timezone.
    * If called with `local`, returns the number of milliseconds since 1
      January 1970 in the server's local timezone.

    ##### ð info

    The `ingame` time zone assumes that one Minecraft day consists of 86,400,000
    milliseconds. Since one in-game day is much faster than a real day (20 minutes), this
    will change quicker than real time - one real second is equal to 72000 in-game
    milliseconds. If you wish to convert this value to real time, divide by 72000; to
    convert to ticks (where a day is 24000 ticks), divide by 3600.

    ### Parameters

    1. args? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The locale to get the milliseconds for. Defaults to `ingame` if not set.

    ### Returns

    1. `number` The milliseconds since the epoch depending on the selected locale.

    ### Throws

    * If an invalid locale is passed.

    ### Usage

    * Get the current time and use [`date`](os.html#v:date) to convert it to a table.

      ```
      -- Dividing by 1000 converts it from milliseconds to seconds.
      local time = os.epoch("local") / 1000
      local time_table = os.date("*t", time)
      print(textutils.serialize(time_table))
      ```

    ### Changes

    * **New in version 1.80pr1**

date([format [, time]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/OSAPI.java#L439)
:   Returns a date string (or table) using a specified format string and
    optional time to format.

    The format string takes the same formats as C's [strftime](http://www.cplusplus.com/reference/ctime/strftime/)
    function. The format string can also be prefixed with an exclamation mark
    (`!`) to use UTC time instead of the server's local timezone.

    If the format is exactly `"*t"` (or `"!*t"` ), a table
    representation of the timestamp will be returned instead. This table has
    fields for the year, month, day, hour, minute, second, day of the week,
    day of the year, and whether Daylight Savings Time is in effect. This
    table can be converted back to a timestamp with [`time`](os.html#v:time).

    ### Parameters

    1. format? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The format of the string to return. This defaults to `%c`, which expands to a string similar to "Sat Dec 24 16:58:00 2011".
    2. time? `number` The timestamp to convert to a string. This defaults to the current time.

    ### Returns

    1. `any` The resulting formated string, or table.

    ### Throws

    * If an invalid format is passed.

    ### Usage

    * Print the current date in a user-friendly string.

      ```
      os.date("%A %d %B %Y") -- See the reference above!
      ```
    * Convert a timestamp to a table.

      ```
      os.date("!*t", 1242534247)
      --[=[ {
        -- Date
        year  = 2009,
        month = 5,
        day   = 17,
        yday  = 137,
        wday  = 1,
        -- Time
        hour  = 4,
        min   = 24,
        sec   = 7,
        isdst = false,
      } ]=]
      ```

    ### Changes

    * **New in version 1.83.0**