# peripheral

Find and control peripherals attached to this computer.

Peripherals are blocks (or turtle and pocket computer upgrades) which can
be controlled by a computer. For instance, the [`speaker`](../peripheral/speaker.html) peripheral allows a
computer to play music and the [`monitor`](../peripheral/monitor.html) peripheral allows you to display text
in the world.

## Referencing peripherals

Computers can interact with adjacent peripherals. Each peripheral is given a
name based on which direction it is in. For instance, a disk drive below your
computer will be called `"bottom"` in your Lua code, one to the left called
`"left"` , and so on for all 6 directions (`"bottom"`, `"top"`, `"left"`,
`"right"`, `"front"`, `"back"`).

You can list the names of all peripherals with the `peripherals` program, or the
[`peripheral.getNames`](peripheral.html#v:getNames) function.

It's also possible to use peripherals which are further away from your computer
through the use of [Wired Modems](../peripheral/modem.html). Place one modem against your computer
(you may need to sneak and right click), run Networking Cable to your
peripheral, and then place another modem against that block. You can then right
click the modem to use (or *attach*) the peripheral. This will print a
peripheral name to chat, which can then be used just like a direction name to
access the peripheral. You can click on the message to copy the name to your
clipboard.

## Using peripherals

Once you have the name of a peripheral, you can call functions on it using the
[`peripheral.call`](peripheral.html#v:call) function. This takes the name of our peripheral, the name of
the function we want to call, and then its arguments.

##### ð info

Some bits of the peripheral API call peripheral functions *methods* instead
(for example, the [`peripheral.getMethods`](peripheral.html#v:getMethods) function). Don't worry, they're the
same thing!

Let's say we have a monitor above our computer (and so "top") and want to
[write some text to it](../peripheral/monitor.html#v:write). We'd write the following:

```
peripheral.call("top", "write", "This is displayed on a monitor!")
```

Once you start calling making a couple of peripheral calls this can get very
repetitive, and so we can [wrap](peripheral.html#v:wrap) a peripheral. This builds a
table of all the peripheral's functions so you can use it like an API or module.

For instance, we could have written the above example as follows:

```
local my_monitor = peripheral.wrap("top")
my_monitor.write("This is displayed on a monitor!")
```

## Finding peripherals

Sometimes when you're writing a program you don't care what a peripheral is
called, you just need to know it's there. For instance, if you're writing a
music player, you just need a speaker - it doesn't matter if it's above or below
the computer.

Thankfully there's a quick way to do this: [`peripheral.find`](peripheral.html#v:find). This takes a
*peripheral type* and returns all the attached peripherals which are of this
type.

What is a peripheral type though? This is a string which describes what a
peripheral is, and so what functions are available on it. For instance, speakers
are just called `"speaker"`, and monitors `"monitor"`. Some peripherals might
have more than one type - a Minecraft chest is both a `"minecraft:chest"` and
`"inventory"`.

You can get all the types a peripheral has with [`peripheral.getType`](peripheral.html#v:getType), and check
a peripheral is a specific type with [`peripheral.hasType`](peripheral.html#v:hasType).

To return to our original example, let's use [`peripheral.find`](peripheral.html#v:find) to find an
attached speaker:

```
local speaker = peripheral.find("speaker")
speaker.playNote("harp")
```

### See also

* **[`peripheral`](../event/peripheral.html)** This event is fired whenever a new peripheral is attached.
* **[`peripheral_detach`](../event/peripheral_detach.html)** This event is fired whenever a peripheral is detached.

### Changes

* **New in version 1.3**
* **Changed in version 1.51:** Add support for wired modems.
* **Changed in version 1.99:** Peripherals can have multiple types.

|  |  |
| --- | --- |
| [getNames()](#v:getNames) | Provides a list of all peripherals available. |
| [isPresent(name)](#v:isPresent) | Determines if a peripheral is present with the given name. |
| [getType(peripheral)](#v:getType) | Get the types of a named or wrapped peripheral. |
| [hasType(peripheral, peripheral\_type)](#v:hasType) | Check if a peripheral is of a particular type. |
| [getMethods(name)](#v:getMethods) | Get all available methods for the peripheral with the given name. |
| [getName(peripheral)](#v:getName) | Get the name of a peripheral wrapped with [`peripheral.wrap`](peripheral.html#v:wrap). |
| [call(name, method, ...)](#v:call) | Call a method on the peripheral with the given name. |
| [wrap(name)](#v:wrap) | Get a table containing all functions available on a peripheral. |
| [find(ty [, filter])](#v:find) | Find all peripherals of a specific type, and return the [wrapped](peripheral.html#v:wrap) peripherals. |

getNames()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/peripheral.lua#L110)
:   Provides a list of all peripherals available.

    If a device is located directly next to the system, then its name will be
    listed as the side it is attached to. If a device is attached via a Wired
    Modem, then it'll be reported according to its name on the wired network.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of the names of all attached peripherals.

    ### Changes

    * **New in version 1.51**

isPresent(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/peripheral.lua#L133)
:   Determines if a peripheral is present with the given name.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side or network name that you want to check.

    ### Returns

    1. `boolean` If a peripheral is present with the given name.

    ### Usage

    * ```
      peripheral.isPresent("top")
      ```
    * ```
      peripheral.isPresent("monitor_0")
      ```

getType(peripheral)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/peripheral.lua#L159)
:   Get the types of a named or wrapped peripheral.

    ### Parameters

    1. peripheral [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The name of the peripheral to find, or a
       wrapped peripheral instance.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... The peripheral's types, or `nil` if it is not present.

    ### Usage

    * Get the type of a peripheral above this computer.

      ```
      peripheral.getType("top")
      ```

    ### Changes

    * **Changed in version 1.88.0:** Accepts a wrapped peripheral as an argument.
    * **Changed in version 1.99:** Now returns multiple types.

hasType(peripheral, peripheral\_type)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/peripheral.lua#L189)
:   Check if a peripheral is of a particular type.

    ### Parameters

    1. peripheral [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The name of the peripheral or a wrapped peripheral instance.
    2. peripheral\_type [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The type to check.

    ### Returns

    1. `boolean` | nil If a peripheral has a particular type, or `nil` if it is not present.

    ### Changes

    * **New in version 1.99**

getMethods(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/peripheral.lua#L217)
:   Get all available methods for the peripheral with the given name.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the peripheral to find.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } | nil A list of methods provided by this peripheral, or `nil` if
       it is not present.

getName(peripheral)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/peripheral.lua#L236)
:   Get the name of a peripheral wrapped with [`peripheral.wrap`](peripheral.html#v:wrap).

    ### Parameters

    1. peripheral [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The peripheral to get the name of.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the given peripheral.

    ### Changes

    * **New in version 1.88.0**

call(name, method, ...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/peripheral.lua#L255)
:   Call a method on the peripheral with the given name.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the peripheral to invoke the method on.
    2. method [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the method
    3. ... Additional arguments to pass to the method

    ### Returns

    1. The return values of the peripheral method.

    ### Usage

    * Open the modem on the top of this computer.

      ```
      peripheral.call("top", "open", 1)
      ```

wrap(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/peripheral.lua#L281)
:   Get a table containing all functions available on a peripheral. These can
    then be called instead of using [`peripheral.call`](peripheral.html#v:call) every time.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the peripheral to wrap.

    ### Returns

    1. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) | nil The table containing the peripheral's methods, or `nil` if
       there is no peripheral present with the given name.

    ### Usage

    * Open the modem on the top of this computer.

      ```
      local modem = peripheral.wrap("top")
      modem.open(1)
      ```

find(ty [, filter])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/peripheral.lua#L332)
:   Find all peripherals of a specific type, and return the
    [wrapped](peripheral.html#v:wrap) peripherals.

    ### Parameters

    1. ty [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The type of peripheral to look for.
    2. filter? function(name: [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), wrapped: [`table`](https://www.lua.org/manual/5.1/manual.html#5.5)):`boolean` A
       filter function, which takes the peripheral's name and wrapped table
       and returns if it should be included in the result.

    ### Returns

    1. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5)... 0 or more wrapped peripherals matching the given filters.

    ### Usage

    * Find all monitors and store them in a table, writing "Hello" on each one.

      ```
      local monitors = { peripheral.find("monitor") }
      for _, monitor in pairs(monitors) do
        monitor.write("Hello")
      end
      ```
    * Find all wireless modems connected to this computer.

      ```
      local modems = { peripheral.find("modem", function(name, modem)
          return modem.isWireless() -- Check this modem is wireless.
      end) }
      ```
    * This abuses the `filter` argument to call [`rednet.open`](rednet.html#v:open) on every modem.

      ```
      peripheral.find("modem", rednet.open)
      ```

    ### Changes

    * **New in version 1.6**