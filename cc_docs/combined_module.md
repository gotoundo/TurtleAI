# MODULE Documentation

## Source File: `module/_G.md`

# \_G

Functions in the global environment, defined in `bios.lua`. This does not
include standard Lua functions.

|  |  |
| --- | --- |
| [sleep(time)](#v:sleep) | Pauses execution for the specified number of seconds. |
| [write(text)](#v:write) | Writes a line of text to the screen without a newline at the end, wrapping text if necessary. |
| [print(...)](#v:print) | Prints the specified values to the screen separated by spaces, wrapping if necessary. |
| [printError(...)](#v:printError) | Prints the specified values to the screen in red, separated by spaces, wrapping if necessary. |
| [read([replaceChar [, history [, completeFn [, default]]]])](#v:read) | Reads user input from the terminal. |
| [\_HOST](#v:_HOST) | Stores the current ComputerCraft and Minecraft versions. |
| [\_CC\_DEFAULT\_SETTINGS](#v:_CC_DEFAULT_SETTINGS) | The default computer settings as defined in the ComputerCraft configuration. |

sleep(time)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/doc/stub/global.lua#L41)
:   Pauses execution for the specified number of seconds.

    As it waits for a fixed amount of world ticks, `time` will automatically be
    rounded up to the nearest multiple of 0.05 seconds. If you are using coroutines
    or the [parallel API](parallel.html), it will only pause execution of the current
    thread, not the whole program.

    ##### tip

    Because sleep internally uses timers, it is a function that yields. This means
    that you can use it to prevent "Too long without yielding" errors. However, as
    the minimum sleep time is 0.05 seconds, it will slow your program down.

    ##### â  warning

    Internally, this function queues and waits for a timer event (using
    [`os.startTimer`](os.html#v:startTimer)), however it does not listen for any other events. This means
    that any event that occurs while sleeping will be entirely discarded. If you
    need to receive events while sleeping, consider using [timers](os.html#v:startTimer),
    or the [parallel API](parallel.html).

    ### Parameters

    1. time `number` The number of seconds to sleep for, rounded up to the
       nearest multiple of 0.05.

    ### Usage

    * Sleep for three seconds.

      ```
      print("Sleeping for three seconds")
      sleep(3)
      print("Done!")
      ```

    ### See also

    * **[`os.startTimer`](os.html#v:startTimer)**

write(text)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/doc/stub/global.lua#L50)
:   Writes a line of text to the screen without a newline at the end, wrapping
    text if necessary.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The text to write to the string

    ### Returns

    1. `number` The number of lines written

    ### Usage

    * ```
      write("Hello, world")
      ```

    ### See also

    * **[`print`](_G.html#v:print)** A wrapper around write that adds a newline and accepts multiple arguments

print(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/doc/stub/global.lua#L58)
:   Prints the specified values to the screen separated by spaces, wrapping if
    necessary. After printing, the cursor is moved to the next line.

    ### Parameters

    1. ... The values to print on the screen

    ### Returns

    1. `number` The number of lines written

    ### Usage

    * ```
      print("Hello, world!")
      ```

printError(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/doc/stub/global.lua#L65)
:   Prints the specified values to the screen in red, separated by spaces,
    wrapping if necessary. After printing, the cursor is moved to the next line.

    ### Parameters

    1. ... The values to print on the screen

    ### Usage

    * ```
      printError("Something went wrong!")
      ```

read([replaceChar [, history [, completeFn [, default]]]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/doc/stub/global.lua#L113)
:   Reads user input from the terminal. This automatically handles arrow keys,
    pasting, character replacement, history scrollback, auto-completion, and
    default values.

    ### Parameters

    1. replaceChar? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) A character to replace each typed character with.
       This can be used for hiding passwords, for example.
    2. history? [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) A table holding history items that can be scrolled
       back to with the up/down arrow keys. The oldest item is at index 1, while the
       newest item is at the highest index.
    3. completeFn? function(partial: [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)):{ [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } | nil A function
       to be used for completion. This function should take the partial text typed so
       far, and returns a list of possible completion options.
    4. default? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Default text which should already be entered into
       the prompt.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The text typed in.

    ### Usage

    * Read a string and echo it back to the user

      ```
      write("> ")
      local msg = read()
      print(msg)
      ```
    * Prompt a user for a password.

      ```
      while true do
        write("Password> ")
        local pwd = read("*")
        if pwd == "let me in" then break end
        print("Incorrect password, try again.")
      end
      print("Logged in!")
      ```
    * A complete example with completion, history and a default value.

      ```
      local completion = require "cc.completion"
      local history = { "potato", "orange", "apple" }
      local choices = { "apple", "orange", "banana", "strawberry" }
      write("> ")
      local msg = read(nil, history, function(text) return completion.choice(text, choices) end, "app")
      print(msg)
      ```

    ### See also

    * **[`cc.completion`](../library/cc.completion.html)** For functions to help with completion.

    ### Changes

    * **Changed in version 1.74:** Added `completeFn` parameter.
    * **Changed in version 1.80pr1:** Added `default` parameter.

\_HOST[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/doc/stub/global.lua#L125)
:   Stores the current ComputerCraft and Minecraft versions.

    Outside of Minecraft (for instance, in an emulator) [`_HOST`](_G.html#v:_HOST) will contain the
    emulator's version instead.

    For example, `ComputerCraft 1.93.0 (Minecraft 1.15.2)`.

    ### Usage

    * Print the current computer's environment.

      ```
      print(_HOST)
      ```

    ### Changes

    * **New in version 1.76**

\_CC\_DEFAULT\_SETTINGS[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/doc/stub/global.lua#L140)
:   The default computer settings as defined in the ComputerCraft
    configuration.

    This is a comma-separated list of settings pairs defined by the mod
    configuration or server owner. By default, it is empty.

    An example value to disable autocompletion:

    ```
    shell.autocomplete=false,lua.autocomplete=false,edit.autocomplete=false
    ```

    ### Usage

    * ```
      _CC_DEFAULT_SETTINGS
      ```

    ### Changes

    * **New in version 1.77**

---

## Source File: `module/colors.md`

# colors

Constants and functions for colour values, suitable for working with
[`term`](term.html) and [`redstone`](redstone.html).

This is useful in conjunction with [Bundled Cables](redstone.html#v:setBundledOutput)
from mods like Project Red, and [colors on Advanced Computers and Advanced
Monitors](term.html#v:setTextColour).

For the non-American English version just replace [`colors`](colors.html) with [`colours`](colours.html).
This alternative API is exactly the same, except the colours use British English
(e.g. [`colors.gray`](colors.html#v:gray) is spelt [`colours.grey`](colours.html#v:grey)).

On basic terminals (such as the Computer and Monitor), all the colors are
converted to grayscale. This means you can still use all 16 colors on the
screen, but they will appear as the nearest tint of gray. You can check if a
terminal supports color by using the function [`term.isColor`](term.html#v:isColor).

Grayscale colors are calculated by taking the average of the three components,
i.e. `(red + green + blue) / 3`.

| Default Colors | | | | | | | |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Color | Value | | | Default Palette Color | | | |
| Dec | Hex | Paint/Blit | Preview | Hex | RGB | Grayscale |
| `colors.white` | 1 | 0x1 | 0 |  | #F0F0F0 | 240, 240, 240 |  |
| `colors.orange` | 2 | 0x2 | 1 |  | #F2B233 | 242, 178, 51 |  |
| `colors.magenta` | 4 | 0x4 | 2 |  | #E57FD8 | 229, 127, 216 |  |
| `colors.lightBlue` | 8 | 0x8 | 3 |  | #99B2F2 | 153, 178, 242 |  |
| `colors.yellow` | 16 | 0x10 | 4 |  | #DEDE6C | 222, 222, 108 |  |
| `colors.lime` | 32 | 0x20 | 5 |  | #7FCC19 | 127, 204, 25 |  |
| `colors.pink` | 64 | 0x40 | 6 |  | #F2B2CC | 242, 178, 204 |  |
| `colors.gray` | 128 | 0x80 | 7 |  | #4C4C4C | 76, 76, 76 |  |
| `colors.lightGray` | 256 | 0x100 | 8 |  | #999999 | 153, 153, 153 |  |
| `colors.cyan` | 512 | 0x200 | 9 |  | #4C99B2 | 76, 153, 178 |  |
| `colors.purple` | 1024 | 0x400 | a |  | #B266E5 | 178, 102, 229 |  |
| `colors.blue` | 2048 | 0x800 | b |  | #3366CC | 51, 102, 204 |  |
| `colors.brown` | 4096 | 0x1000 | c |  | #7F664C | 127, 102, 76 |  |
| `colors.green` | 8192 | 0x2000 | d |  | #57A64E | 87, 166, 78 |  |
| `colors.red` | 16384 | 0x4000 | e |  | #CC4C4C | 204, 76, 76 |  |
| `colors.black` | 32768 | 0x8000 | f |  | #111111 | 17, 17, 17 |  |

### See also

* **[`colours`](colours.html)**

|  |  |
| --- | --- |
| [white = 0x1](#v:white) | White: Written as `0` in paint files and [`term.blit`](term.html#v:blit), has a default terminal colour of #F0F0F0. |
| [orange = 0x2](#v:orange) | Orange: Written as `1` in paint files and [`term.blit`](term.html#v:blit), has a default terminal colour of #F2B233. |
| [magenta = 0x4](#v:magenta) | Magenta: Written as `2` in paint files and [`term.blit`](term.html#v:blit), has a default terminal colour of #E57FD8. |
| [lightBlue = 0x8](#v:lightBlue) | Light blue: Written as `3` in paint files and [`term.blit`](term.html#v:blit), has a default terminal colour of #99B2F2. |
| [yellow = 0x10](#v:yellow) | Yellow: Written as `4` in paint files and [`term.blit`](term.html#v:blit), has a default terminal colour of #DEDE6C. |
| [lime = 0x20](#v:lime) | Lime: Written as `5` in paint files and [`term.blit`](term.html#v:blit), has a default terminal colour of #7FCC19. |
| [pink = 0x40](#v:pink) | Pink: Written as `6` in paint files and [`term.blit`](term.html#v:blit), has a default terminal colour of #F2B2CC. |
| [gray = 0x80](#v:gray) | Gray: Written as `7` in paint files and [`term.blit`](term.html#v:blit), has a default terminal colour of #4C4C4C. |
| [lightGray = 0x100](#v:lightGray) | Light gray: Written as `8` in paint files and [`term.blit`](term.html#v:blit), has a default terminal colour of #999999. |
| [cyan = 0x200](#v:cyan) | Cyan: Written as `9` in paint files and [`term.blit`](term.html#v:blit), has a default terminal colour of #4C99B2. |
| [purple = 0x400](#v:purple) | Purple: Written as `a` in paint files and [`term.blit`](term.html#v:blit), has a default terminal colour of #B266E5. |
| [blue = 0x800](#v:blue) | Blue: Written as `b` in paint files and [`term.blit`](term.html#v:blit), has a default terminal colour of #3366CC. |
| [brown = 0x1000](#v:brown) | Brown: Written as `c` in paint files and [`term.blit`](term.html#v:blit), has a default terminal colour of #7F664C. |
| [green = 0x2000](#v:green) | Green: Written as `d` in paint files and [`term.blit`](term.html#v:blit), has a default terminal colour of #57A64E. |
| [red = 0x4000](#v:red) | Red: Written as `e` in paint files and [`term.blit`](term.html#v:blit), has a default terminal colour of #CC4C4C. |
| [black = 0x8000](#v:black) | Black: Written as `f` in paint files and [`term.blit`](term.html#v:blit), has a default terminal colour of #111111. |
| [combine(...)](#v:combine) | Combines a set of colors (or sets of colors) into a larger set. |
| [subtract(colors, ...)](#v:subtract) | Removes one or more colors (or sets of colors) from an initial set. |
| [test(colors, color)](#v:test) | Tests whether `color` is contained within `colors`. |
| [packRGB(r, g, b)](#v:packRGB) | Combine a three-colour RGB value into one hexadecimal representation. |
| [unpackRGB(rgb)](#v:unpackRGB) | Separate a hexadecimal RGB colour into its three constituent channels. |
| [rgb8(...)](#v:rgb8) | Either calls [`colors.packRGB`](colors.html#v:packRGB) or [`colors.unpackRGB`](colors.html#v:unpackRGB), depending on how many arguments it receives. |
| [toBlit(color)](#v:toBlit) | Converts the given color to a paint/blit hex character (0-9a-f). |
| [fromBlit(hex)](#v:fromBlit) | Converts the given paint/blit hex character (0-9a-f) to a color. |

white = 0x1[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L145)
:   White: Written as `0` in paint files and [`term.blit`](term.html#v:blit), has a default
    terminal colour of #F0F0F0.

orange = 0x2[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L149)
:   Orange: Written as `1` in paint files and [`term.blit`](term.html#v:blit), has a
    default terminal colour of #F2B233.

magenta = 0x4[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L153)
:   Magenta: Written as `2` in paint files and [`term.blit`](term.html#v:blit), has a
    default terminal colour of #E57FD8.

lightBlue = 0x8[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L157)
:   Light blue: Written as `3` in paint files and [`term.blit`](term.html#v:blit), has a
    default terminal colour of #99B2F2.

yellow = 0x10[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L161)
:   Yellow: Written as `4` in paint files and [`term.blit`](term.html#v:blit), has a
    default terminal colour of #DEDE6C.

lime = 0x20[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L165)
:   Lime: Written as `5` in paint files and [`term.blit`](term.html#v:blit), has a default
    terminal colour of #7FCC19.

pink = 0x40[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L169)
:   Pink: Written as `6` in paint files and [`term.blit`](term.html#v:blit), has a default
    terminal colour of #F2B2CC.

gray = 0x80[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L173)
:   Gray: Written as `7` in paint files and [`term.blit`](term.html#v:blit), has a default
    terminal colour of #4C4C4C.

lightGray = 0x100[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L177)
:   Light gray: Written as `8` in paint files and [`term.blit`](term.html#v:blit), has a
    default terminal colour of #999999.

cyan = 0x200[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L181)
:   Cyan: Written as `9` in paint files and [`term.blit`](term.html#v:blit), has a default
    terminal colour of #4C99B2.

purple = 0x400[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L185)
:   Purple: Written as `a` in paint files and [`term.blit`](term.html#v:blit), has a
    default terminal colour of #B266E5.

blue = 0x800[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L189)
:   Blue: Written as `b` in paint files and [`term.blit`](term.html#v:blit), has a default
    terminal colour of #3366CC.

brown = 0x1000[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L193)
:   Brown: Written as `c` in paint files and [`term.blit`](term.html#v:blit), has a default
    terminal colour of #7F664C.

green = 0x2000[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L197)
:   Green: Written as `d` in paint files and [`term.blit`](term.html#v:blit), has a default
    terminal colour of #57A64E.

red = 0x4000[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L201)
:   Red: Written as `e` in paint files and [`term.blit`](term.html#v:blit), has a default
    terminal colour of #CC4C4C.

black = 0x8000[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L205)
:   Black: Written as `f` in paint files and [`term.blit`](term.html#v:blit), has a default
    terminal colour of #111111.

combine(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L218)
:   Combines a set of colors (or sets of colors) into a larger set. Useful for
    Bundled Cables.

    ### Parameters

    1. ... `number` The colors to combine.

    ### Returns

    1. `number` The union of the color sets given in `...`

    ### Usage

    * ```
      colors.combine(colors.white, colors.magenta, colours.lightBlue)
      -- => 13
      ```

    ### Changes

    * **New in version 1.2**

subtract(colors, ...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L244)
:   Removes one or more colors (or sets of colors) from an initial set. Useful
    for Bundled Cables.

    Each parameter beyond the first may be a single color or may be a set of
    colors (in the latter case, all colors in the set are removed from the
    original set).

    ### Parameters

    1. colors `number` The color from which to subtract.
    2. ... `number` The colors to subtract.

    ### Returns

    1. `number` The resulting color.

    ### Usage

    * ```
      colours.subtract(colours.lime, colours.orange, colours.white)
      -- => 32
      ```

    ### Changes

    * **New in version 1.2**

test(colors, color)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L267)
:   Tests whether `color` is contained within `colors`. Useful for Bundled
    Cables.

    ### Parameters

    1. colors `number` A color, or color set
    2. color `number` A color or set of colors that `colors` should contain.

    ### Returns

    1. `boolean` If `colors` contains all colors within `color`.

    ### Usage

    * ```
      colors.test(colors.combine(colors.white, colors.magenta, colours.lightBlue), colors.lightBlue)
      -- => true
      ```

    ### Changes

    * **New in version 1.2**

packRGB(r, g, b)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L285)
:   Combine a three-colour RGB value into one hexadecimal representation.

    ### Parameters

    1. r `number` The red channel, should be between 0 and 1.
    2. g `number` The green channel, should be between 0 and 1.
    3. b `number` The blue channel, should be between 0 and 1.

    ### Returns

    1. `number` The combined hexadecimal colour.

    ### Usage

    * ```
      colors.packRGB(0.7, 0.2, 0.6)
      -- => 0xb23399
      ```

    ### Changes

    * **New in version 1.81.0**

unpackRGB(rgb)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L308)
:   Separate a hexadecimal RGB colour into its three constituent channels.

    ### Parameters

    1. rgb `number` The combined hexadecimal colour.

    ### Returns

    1. `number` The red channel, will be between 0 and 1.
    2. `number` The green channel, will be between 0 and 1.
    3. `number` The blue channel, will be between 0 and 1.

    ### Usage

    * ```
      colors.unpackRGB(0xb23399)
      -- => 0.7, 0.2, 0.6
      ```

    ### See also

    * **[`colors.packRGB`](colors.html#v:packRGB)**

    ### Changes

    * **New in version 1.81.0**

rgb8(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L340)
:   ##### ð Deprecated

    Use [`packRGB`](colors.html#v:packRGB) or [`unpackRGB`](colors.html#v:unpackRGB) directly.

    Either calls [`colors.packRGB`](colors.html#v:packRGB) or [`colors.unpackRGB`](colors.html#v:unpackRGB), depending on how many
    arguments it receives.

    ### Parameters

    1. r `number` The red channel, as an argument to [`colors.packRGB`](colors.html#v:packRGB).
    2. g `number` The green channel, as an argument to [`colors.packRGB`](colors.html#v:packRGB).
    3. b `number` The blue channel, as an argument to [`colors.packRGB`](colors.html#v:packRGB).

    #### Or

    1. rgb `number` The combined hexadecimal color, as an argument to [`colors.unpackRGB`](colors.html#v:unpackRGB).

    ### Returns

    1. `number` The combined hexadecimal colour, as returned by [`colors.packRGB`](colors.html#v:packRGB).

    #### Or

    1. `number` The red channel, as returned by [`colors.unpackRGB`](colors.html#v:unpackRGB)
    2. `number` The green channel, as returned by [`colors.unpackRGB`](colors.html#v:unpackRGB)
    3. `number` The blue channel, as returned by [`colors.unpackRGB`](colors.html#v:unpackRGB)

    ### Usage

    * ```
      colors.rgb8(0xb23399)
      -- => 0.7, 0.2, 0.6
      ```
    * ```
      colors.rgb8(0.7, 0.2, 0.6)
      -- => 0xb23399
      ```

    ### Changes

    * **New in version 1.80pr1**
    * **Changed in version 1.81.0:** Deprecated in favor of colors.(un)packRGB.

toBlit(color)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L369)
:   Converts the given color to a paint/blit hex character (0-9a-f).

    This is equivalent to converting `floor(log_2(color))` to hexadecimal. Values
    outside the range of a valid colour will error.

    ### Parameters

    1. color `number` The color to convert.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The blit hex code of the color.

    ### Usage

    * ```
      colors.toBlit(colors.red)
      -- => "c"
      ```

    ### See also

    * **[`colors.fromBlit`](colors.html#v:fromBlit)**

    ### Changes

    * **New in version 1.94.0**

fromBlit(hex)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colors.lua#L392)
:   Converts the given paint/blit hex character (0-9a-f) to a color.

    This is equivalent to converting the hex character to a number and then 2 ^ decimal

    ### Parameters

    1. hex [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The paint/blit hex character to convert

    ### Returns

    1. `number` The color

    ### Usage

    * ```
      colors.fromBlit("e")
      -- => 16384
      ```

    ### See also

    * **[`colors.toBlit`](colors.html#v:toBlit)**

    ### Changes

    * **New in version 1.105.0**

---

## Source File: `module/colours.md`

# colours

An alternative version of [`colors`](colors.html) for lovers of British spelling.

### See also

* **[`colors`](colors.html)**

### Changes

* **New in version 1.2**

|  |  |
| --- | --- |
| [grey](#v:grey) | Grey. |
| [lightGrey](#v:lightGrey) | Light grey. |

grey[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colours.lua#L20)
:   Grey. Written as `7` in paint files and [`term.blit`](term.html#v:blit), has a default
    terminal colour of #4C4C4C.

    ### See also

    * **[`colors.gray`](colors.html#v:gray)**

lightGrey[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/colours.lua#L27)
:   Light grey. Written as `8` in paint files and [`term.blit`](term.html#v:blit), has a
    default terminal colour of #999999.

    ### See also

    * **[`colors.lightGray`](colors.html#v:lightGray)**

---

## Source File: `module/commands.md`

# commands

Execute [Minecraft commands](https://minecraft.wiki/w/Commands) and gather data from the results from
a command computer.

##### ð note

This API is only available on Command computers. It is not accessible to normal
players.

While one may use [`commands.exec`](commands.html#v:exec) directly to execute a command, the
commands API also provides helper methods to execute every command. For
instance, `commands.say("Hi!")` is equivalent to `commands.exec("say Hi!")`.

[`commands.async`](commands.html#v:async) provides a similar interface to execute asynchronous
commands. `commands.async.say("Hi!")` is equivalent to
`commands.execAsync("say Hi!")`.

### Usage

* Set the block above this computer to stone:

  ```
  commands.setblock("~", "~1", "~", "minecraft:stone")
  ```

### Changes

* **New in version 1.7**

|  |  |
| --- | --- |
| [exec(command)](#v:exec) | Execute a specific command. |
| [execAsync(command)](#v:execAsync) | Asynchronously execute a command. |
| [list(...)](#v:list) | List all available commands which the computer has permission to execute. |
| [getBlockPosition()](#v:getBlockPosition) | Get the position of the current command computer. |
| [getBlockInfos(minX, minY, minZ, maxX, maxY, maxZ [, dimension])](#v:getBlockInfos) | Get information about a range of blocks. |
| [getBlockInfo(x, y, z [, dimension])](#v:getBlockInfo) | Get some basic information about a block. |
| [native](#v:native) | The builtin commands API, without any generated command helper functions |
| [async](#v:async) | A table containing asynchronous wrappers for all commands. |

exec(command)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/computer/apis/CommandAPI.java#L100)
:   Execute a specific command.

    ### Parameters

    1. command [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The command to execute.

    ### Returns

    1. `boolean` Whether the command executed successfully.
    2. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } The output of this command, as a list of lines.
    3. `number` | nil The number of "affected" objects, or `nil` if the command failed. The definition of this
       varies from command to command.

    ### Usage

    * Set the block above the command computer to stone.

      ```
      commands.exec("setblock ~ ~1 ~ minecraft:stone")
      ```

    ### Changes

    * **Changed in version 1.71:** Added return value with command output.
    * **Changed in version 1.85.0:** Added return value with the number of affected objects.

execAsync(command)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/computer/apis/CommandAPI.java#L126)
:   Asynchronously execute a command.

    Unlike [`exec`](commands.html#v:exec), this will immediately return, instead of waiting for the
    command to execute. This allows you to run multiple commands at the same
    time.

    When this command has finished executing, it will queue a `task_complete`
    event containing the result of executing this command (what [`exec`](commands.html#v:exec) would
    return).

    ### Parameters

    1. command [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The command to execute.

    ### Returns

    1. `number` The "task id". When this command has been executed, it will queue a `task_complete` event with a matching id.

    ### Usage

    * Asynchronously sets the block above the computer to stone.

      ```
      commands.execAsync("setblock ~ ~1 ~ minecraft:stone")
      ```

    ### See also

    * **[`parallel`](parallel.html)** One may also use the parallel API to run multiple commands at once.

list(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/computer/apis/CommandAPI.java#L139)
:   List all available commands which the computer has permission to execute.

    ### Parameters

    1. ... [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The sub-command to complete.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of all available commands

getBlockPosition()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/computer/apis/CommandAPI.java#L166)
:   Get the position of the current command computer.

    ### Returns

    1. `number` This computer's x position.
    2. `number` This computer's y position.
    3. `number` This computer's z position.

    ### See also

    * **[`gps.locate`](gps.html#v:locate)** To get the position of a non-command computer.

getBlockInfos(minX, minY, minZ, maxX, maxY, maxZ [, dimension])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/computer/apis/CommandAPI.java#L213)
:   Get information about a range of blocks.

    This returns the same information as [`getBlockInfo`](commands.html#v:getBlockInfo), just for multiple
    blocks at once.

    Blocks are traversed by ascending y level, followed by z and x - the returned
    table may be indexed using `x + z*width + y*width*depth + 1`.

    ### Parameters

    1. minX `number` The start x coordinate of the range to query.
    2. minY `number` The start y coordinate of the range to query.
    3. minZ `number` The start z coordinate of the range to query.
    4. maxX `number` The end x coordinate of the range to query.
    5. maxY `number` The end y coordinate of the range to query.
    6. maxZ `number` The end z coordinate of the range to query.
    7. dimension? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The dimension to query (e.g. "minecraft:overworld"). Defaults to the current dimension.

    ### Returns

    1. { [`table`](https://www.lua.org/manual/5.1/manual.html#5.5)... } A list of information about each block.

    ### Throws

    * If the coordinates are not within the world.
    * If trying to get information about more than 4096 blocks.

    ### Usage

    * Print out all blocks in a cube around the computer.

      ```
      -- Get a 3x3x3 cube around the computer
      local x, y, z = commands.getBlockPosition()
      local min_x, min_y, min_z, max_x, max_y, max_z = x - 1, y - 1, z - 1, x + 1, y + 1, z + 1
      local blocks = commands.getBlockInfos(min_x, min_y, min_z, max_x, max_y, max_z)

      -- Then loop over all blocks and print them out.
      local width, height, depth = max_x - min_x + 1, max_y - min_y + 1, max_z - min_z + 1
      for x = min_x, max_x do
        for y = min_y, max_y do
          for z = min_z, max_z do
            print(("%d, %d %d => %s"):format(x, y, z, blocks[(x - min_x) + (z - min_z) * width + (y - min_y) * width * depth + 1].name))
          end
        end
      end
      ```

    ### Changes

    * **New in version 1.76**
    * **Changed in version 1.99:** Added `dimension` argument.

getBlockInfo(x, y, z [, dimension])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/computer/apis/CommandAPI.java#L263)
:   Get some basic information about a block.

    The returned table contains the current name, metadata and block state (as
    with [`turtle.inspect`](turtle.html#v:inspect)). If there is a block entity for that block, its NBT
    will also be returned.

    ### Parameters

    1. x `number` The x position of the block to query.
    2. y `number` The y position of the block to query.
    3. z `number` The z position of the block to query.
    4. dimension? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The dimension to query (e.g. "minecraft:overworld"). Defaults to the current dimension.

    ### Returns

    1. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The given block's information.

    ### Throws

    * If the coordinates are not within the world, or are not currently loaded.

    ### Changes

    * **Changed in version 1.76:** Added block state info to return value
    * **Changed in version 1.99:** Added `dimension` argument.

native[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/command/commands.lua#L35)
:   The builtin commands API, without any generated command helper functions

    This may be useful if a built-in function (such as [`commands.list`](commands.html#v:list)) has been
    overwritten by a command.

async[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/command/commands.lua#L61)
:   A table containing asynchronous wrappers for all commands.

    As with [`commands.execAsync`](commands.html#v:execAsync), this returns the "task id" of the enqueued
    command.

    ### Usage

    * Asynchronously sets the block above the computer to stone.

      ```
      commands.async.setblock("~", "~1", "~", "minecraft:stone")
      ```

    ### See also

    * **[`execAsync`](commands.html#v:execAsync)**

---

## Source File: `module/disk.md`

# disk

Interact with disk drives.

These functions can operate on locally attached or remote disk drives. To use a
locally attached drive, specify âsideâ as one of the six sides (e.g. `left`); to
use a remote disk drive, specify its name as printed when enabling its modem
(e.g. `drive_0`).

##### tip

All computers (except command computers), turtles and pocket computers can be
placed within a disk drive to access it's internal storage like a disk.

### Changes

* **New in version 1.2**

|  |  |
| --- | --- |
| [isPresent(name)](#v:isPresent) | Checks whether any item at all is in the disk drive |
| [getLabel(name)](#v:getLabel) | Get the label of the floppy disk, record, or other media within the given disk drive. |
| [setLabel(name, label)](#v:setLabel) | Set the label of the floppy disk or other media |
| [hasData(name)](#v:hasData) | Check whether the current disk provides a mount. |
| [getMountPath(name)](#v:getMountPath) | Find the directory name on the local computer where the contents of the current floppy disk (or other mount) can be found. |
| [hasAudio(name)](#v:hasAudio) | Whether the current disk is a music disk as opposed to a floppy disk or other item. |
| [getAudioTitle(name)](#v:getAudioTitle) | Get the title of the audio track from the music record in the drive. |
| [playAudio(name)](#v:playAudio) | Starts playing the music record in the drive. |
| [stopAudio(name)](#v:stopAudio) | Stops the music record in the drive from playing, if it was started with [`disk.playAudio`](disk.html#v:playAudio). |
| [eject(name)](#v:eject) | Ejects any item currently in the drive, spilling it into the world as a loose item. |
| [getID(name)](#v:getID) | Returns a number which uniquely identifies the disk in the drive. |

isPresent(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L32)
:   Checks whether any item at all is in the disk drive

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the disk drive.

    ### Returns

    1. `boolean` If something is in the disk drive.

    ### Usage

    * ```
      disk.isPresent("top")
      ```

getLabel(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L49)
:   Get the label of the floppy disk, record, or other media within the given
    disk drive.

    If there is a computer or turtle within the drive, this will set the label as
    read by `os.getComputerLabel`.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the disk drive.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The name of the current media, or `nil` if the drive is
       not present or empty.

    ### See also

    * **[`disk.setLabel`](disk.html#v:setLabel)**

setLabel(name, label)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L60)
:   Set the label of the floppy disk or other media

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the disk drive.
    2. label [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The new label of the disk

hasData(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L73)
:   Check whether the current disk provides a mount.

    This will return true for disks and computers, but not records.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the disk drive.

    ### Returns

    1. `boolean` If the disk is present and provides a mount.

    ### See also

    * **[`disk.getMountPath`](disk.html#v:getMountPath)**

getMountPath(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L87)
:   Find the directory name on the local computer where the contents of the
    current floppy disk (or other mount) can be found.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the disk drive.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The mount's directory, or `nil` if the drive does not
       contain a floppy or computer.

    ### See also

    * **[`disk.hasData`](disk.html#v:hasData)**

hasAudio(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L103)
:   Whether the current disk is a [music disk](https://minecraft.wiki/w/Music_Disc) as opposed to a floppy disk
    or other item.

    If this returns true, you will can [play](disk.html#v:playAudio) the record.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the disk drive.

    ### Returns

    1. `boolean` If the disk is present and has audio saved on it.

getAudioTitle(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L117)
:   Get the title of the audio track from the music record in the drive.

    This generally returns the same as [`disk.getLabel`](disk.html#v:getLabel) for records.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the disk drive.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | false | nil The track title, `false` if there is not a music
       record in the drive or `nil` if no drive is present.

playAudio(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L133)
:   Starts playing the music record in the drive.

    If any record is already playing on any disk drive, it stops before the
    target drive starts playing. The record stops when it reaches the end of the
    track, when it is removed from the drive, when [`disk.stopAudio`](disk.html#v:stopAudio) is called, or
    when another record is started.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the disk drive.

    ### Usage

    * ```
      disk.playAudio("bottom")
      ```

stopAudio(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L143)
:   Stops the music record in the drive from playing, if it was started with
    [`disk.playAudio`](disk.html#v:playAudio).

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name o the disk drive.

eject(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L159)
:   Ejects any item currently in the drive, spilling it into the world as a loose item.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the disk drive.

    ### Usage

    * ```
      disk.eject("bottom")
      ```

getID(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L173)
:   Returns a number which uniquely identifies the disk in the drive.

    Note, unlike [`disk.getLabel`](disk.html#v:getLabel), this does not return anything for other media,
    such as computers or turtles.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the disk drive.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The disk ID, or `nil` if the drive does not contain a floppy disk.

    ### Changes

    * **New in version 1.4**

---

## Source File: `module/fs.md`

# fs

Interact with the computer's files and filesystem, allowing you to manipulate files, directories and paths. This
includes:

* **Reading and writing files:** Call [`open`](fs.html#v:open) to obtain a file "handle", which can be used to read from or
  write to a file.
* **Path manipulation:** [`combine`](fs.html#v:combine), [`getName`](fs.html#v:getName) and [`getDir`](fs.html#v:getDir) allow you to manipulate file
  paths, joining them together or extracting components.
* **Querying paths:** For instance, checking if a file exists, or whether it's a directory. See [`getSize`](fs.html#v:getSize),
  [`exists`](fs.html#v:exists), [`isDir`](fs.html#v:isDir), [`isReadOnly`](fs.html#v:isReadOnly) and [`attributes`](fs.html#v:attributes).
* **File and directory manipulation:** For instance, moving or copying files. See [`makeDir`](fs.html#v:makeDir), [`move`](fs.html#v:move),
  [`copy`](fs.html#v:copy) and [`delete`](fs.html#v:delete).

##### ð note

All functions in the API work on absolute paths, and do not take the [current directory](shell.html#v:dir) into account.
You can use [`shell.resolve`](shell.html#v:resolve) to convert a relative path into an absolute one.

## Mounts

While a computer can only have one hard drive and filesystem, other filesystems may be "mounted" inside it. For
instance, the [drive peripheral](../peripheral/drive.html) mounts
its disk's contents at `"disk/"`, `"disk1/"`, etc...

You can see which mount a path belongs to with the [`getDrive`](fs.html#v:getDrive) function. This returns `"hdd"` for the
computer's main filesystem (`"/"`), `"rom"` for the rom (`"rom/"`).

Most filesystems have a limited capacity, operations which would cause that capacity to be reached (such as writing
an incredibly large file) will fail. You can see a mount's capacity with [`getCapacity`](fs.html#v:getCapacity) and the remaining
space with [`getFreeSpace`](fs.html#v:getFreeSpace).

|  |  |
| --- | --- |
| [complete(...)](#v:complete) | Provides completion for a file or directory name, suitable for use with [`_G.read`](_G.html#v:read). |
| [find(path)](#v:find) | Searches for files matching a string with wildcards. |
| [isDriveRoot(path)](#v:isDriveRoot) | Returns true if a path is mounted to the parent filesystem. |
| [list(path)](#v:list) | Returns a list of files in a directory. |
| [combine(path, ...)](#v:combine) | Combines several parts of a path into one full path, adding separators as needed. |
| [getName(path)](#v:getName) | Returns the file name portion of a path. |
| [getDir(path)](#v:getDir) | Returns the parent directory portion of a path. |
| [getSize(path)](#v:getSize) | Returns the size of the specified file. |
| [exists(path)](#v:exists) | Returns whether the specified path exists. |
| [isDir(path)](#v:isDir) | Returns whether the specified path is a directory. |
| [isReadOnly(path)](#v:isReadOnly) | Returns whether a path is read-only. |
| [makeDir(path)](#v:makeDir) | Creates a directory, and any missing parents, at the specified path. |
| [move(path, dest)](#v:move) | Moves a file or directory from one path to another. |
| [copy(path, dest)](#v:copy) | Copies a file or directory to a new path. |
| [delete(path)](#v:delete) | Deletes a file or directory. |
| [open(path, mode)](#v:open) | Opens a file for reading or writing at a path. |
| [getDrive(path)](#v:getDrive) | Returns the name of the mount that the specified path is located on. |
| [getFreeSpace(path)](#v:getFreeSpace) | Returns the amount of free space available on the drive the path is located on. |
| [getCapacity(path)](#v:getCapacity) | Returns the capacity of the drive the path is located on. |
| [attributes(path)](#v:attributes) | Get attributes about a specific file or folder. |

complete(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/fs.lua#L63)
:   Provides completion for a file or directory name, suitable for use with
    [`_G.read`](_G.html#v:read).

    When a directory is a possible candidate for completion, two entries are
    included - one with a trailing slash (indicating that entries within this
    directory exist) and one without it (meaning this entry is an immediate
    completion candidate). `include_dirs` can be set to `false` to only include
    those with a trailing slash.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to complete.
    2. location [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The location where paths are resolved from.
    3. include\_files? `boolean` = `true` When `false`, only directories will
       be included in the returned list.
    4. include\_dirs? `boolean` = `true` When `false`, "raw" directories will
       not be included in the returned list.

    #### Or

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to complete.
    2. location [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The location where paths are resolved from.
    3. options { include\_dirs? = `boolean`, include\_files? = `boolean`, include\_hidden? = `boolean` }

       This table form is an expanded version of the previous syntax. The
       `include_files` and `include_dirs` arguments from above are passed in as fields.

       This table also accepts the following options:

       * `include_hidden`: Whether to include hidden files (those starting with `.`)
         by default. They will still be shown when typing a `.`.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of possible completion candidates.

    ### Usage

    * Complete files in the root directory.

      ```
      read(nil, nil, function(str)
          return fs.complete(str, "", true, false)
      end)
      ```
    * Complete files in the root directory, hiding hidden files by default.

      ```
      read(nil, nil, function(str)
          return fs.complete(str, "", {
              include_files = true,
              include_dirs = false,
              include_hidden = false,
          })
      end)
      ```

    ### Changes

    * **New in version 1.74**
    * **Changed in version 1.101.0**

find(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/fs.lua#L190)
:   Searches for files matching a string with wildcards.

    This string looks like a normal path string, but can include wildcards, which
    can match multiple paths:

    * "?" matches any single character in a file name.
    * "\*" matches any number of characters.

    For example, `rom/*/command*` will look for any path starting with `command`
    inside any subdirectory of `/rom`.

    Note that these wildcards match a single segment of the path. For instance
    `rom/*.lua` will include `rom/startup.lua` but *not* include `rom/programs/list.lua`.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The wildcard-qualified path to search for.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of paths that match the search string.

    ### Throws

    * If the supplied path was invalid.

    ### Usage

    * List all Markdown files in the help folder

      ```
      fs.find("rom/help/*.md")
      ```

    ### Changes

    * **New in version 1.6**
    * **Changed in version 1.106.0:** Added support for the `?` wildcard.

isDriveRoot(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/fs.lua#L233)
:   Returns true if a path is mounted to the parent filesystem.

    The root filesystem "/" is considered a mount, along with disk folders and
    the rom folder.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to check.

    ### Returns

    1. `boolean` If the path is mounted, rather than a normal file/folder.

    ### Throws

    * If the path does not exist.

    ### See also

    * **[`getDrive`](fs.html#v:getDrive)**

    ### Changes

    * **New in version 1.87.0**

list(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L103)
:   Returns a list of files in a directory.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to list.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A table with a list of files in the directory.

    ### Throws

    * If the path doesn't exist.

    ### Usage

    * List all files under `/rom/`

      ```
      local files = fs.list("/rom/")
      for i = 1, #files do
        print(files[i])
      end
      ```

combine(path, ...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L128)
:   Combines several parts of a path into one full path, adding separators as
    needed.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The first part of the path. For example, a parent directory path.
    2. ... [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Additional parts of the path to combine.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The new path, with separators added between parts as needed.

    ### Throws

    * On argument errors.

    ### Usage

    * Combine several file paths together

      ```
      fs.combine("/rom/programs", "../apis", "parallel.lua")
      -- => rom/apis/parallel.lua
      ```

    ### Changes

    * **Changed in version 1.95.0:** Now supports multiple arguments.

getName(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L154)
:   Returns the file name portion of a path.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to get the name from.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The final part of the path (the file name).

    ### Usage

    * Get the file name of `rom/startup.lua`

      ```
      fs.getName("rom/startup.lua")
      -- => startup.lua
      ```

    ### Changes

    * **New in version 1.2**

getDir(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L171)
:   Returns the parent directory portion of a path.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to get the directory from.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path with the final part removed (the parent directory).

    ### Usage

    * Get the directory name of `rom/startup.lua`

      ```
      fs.getDir("rom/startup.lua")
      -- => rom
      ```

    ### Changes

    * **New in version 1.63**

getSize(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L184)
:   Returns the size of the specified file.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The file to get the file size of.

    ### Returns

    1. `number` The size of the file, in bytes.

    ### Throws

    * If the path doesn't exist.

    ### Changes

    * **New in version 1.3**

exists(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L199)
:   Returns whether the specified path exists.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to check the existence of.

    ### Returns

    1. `boolean` Whether the path exists.

isDir(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L214)
:   Returns whether the specified path is a directory.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to check.

    ### Returns

    1. `boolean` Whether the path is a directory.

isReadOnly(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L229)
:   Returns whether a path is read-only.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to check.

    ### Returns

    1. `boolean` Whether the path cannot be written to.

makeDir(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L244)
:   Creates a directory, and any missing parents, at the specified path.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to the directory to create.

    ### Throws

    * If the directory couldn't be created.

move(path, dest)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L262)
:   Moves a file or directory from one path to another.

    Any parent directories are created as needed.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The current file or directory to move from.
    2. dest [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The destination path for the file or directory.

    ### Throws

    * If the file or directory couldn't be moved.

copy(path, dest)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L280)
:   Copies a file or directory to a new path.

    Any parent directories are created as needed.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The file or directory to copy.
    2. dest [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to the destination file or directory.

    ### Throws

    * If the file or directory couldn't be copied.

delete(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L298)
:   Deletes a file or directory.

    If the path points to a directory, all of the enclosed files and
    subdirectories are also deleted.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to the file or directory to delete.

    ### Throws

    * If the file or directory couldn't be deleted.

open(path, mode)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L365)
:   Opens a file for reading or writing at a path.

    The `mode` string can be any of the following:

    * **"r"**: Read mode.
    * **"w"**: Write mode.
    * **"a"**: Append mode.
    * **"r+"**: Update mode (allows reading and writing), all data is preserved.
    * **"w+"**: Update mode, all data is erased.

    The mode may also have a "b" at the end, which opens the file in "binary
    mode". This changes [`fs.ReadHandle.read`](fs.html#ty:ReadHandle:read) and [`fs.WriteHandle.write`](fs.html#ty:WriteHandle:write)
    to read/write single bytes as numbers rather than strings.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to the file to open.
    2. mode [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The mode to open the file with.

    ### Returns

    1. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) A file handle object for the file.

    #### Or

    1. nil If the file does not exist, or cannot be opened.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil A message explaining why the file cannot be opened.

    ### Throws

    * If an invalid mode was specified.

    ### Usage

    * Read the contents of a file.

      ```
      local file = fs.open("/rom/help/intro.txt", "r")
      local contents = file.readAll()
      file.close()

      print(contents)
      ```
    * Open a file and read all lines into a table. [`io.lines`](io.html#v:lines) offers an alternative way to do this.

      ```
      local file = fs.open("/rom/motd.txt", "r")
      local lines = {}
      while true do
        local line = file.readLine()

        -- If line is nil then we've reached the end of the file and should stop
        if not line then break end

        lines[#lines + 1] = line
      end

      file.close()

      print(lines[math.random(#lines)]) -- Pick a random line and print it.
      ```
    * Open a file and write some text to it. You can run `edit out.txt` to see the written text.

      ```
      local file = fs.open("out.txt", "w")
      file.write("Just testing some code")
      file.close() -- Remember to call close, otherwise changes may not be written!
      ```

    ### Changes

    * **Changed in version 1.109.0:** Add support for update modes (`r+` and `w+`).
    * **Changed in version 1.109.0:** Opening a file in non-binary mode now uses the raw bytes of the file rather than encoding to
      UTF-8.

getDrive(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L413)
:   Returns the name of the mount that the specified path is located on.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to get the drive of.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The name of the drive that the file is on; e.g. `hdd` for local files, or `rom` for ROM files.

    ### Throws

    * If the path doesn't exist.

    ### Usage

    * Print the drives of a couple of mounts:

      ```
      print("/: " .. fs.getDrive("/"))
      print("/rom/: " .. fs.getDrive("rom"))
      ```

getFreeSpace(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L433)
:   Returns the amount of free space available on the drive the path is
    located on.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to check the free space for.

    ### Returns

    1. `number` | "unlimited" The amount of free space available, in bytes, or "unlimited".

    ### Throws

    * If the path doesn't exist.

    ### See also

    * **[`getCapacity`](fs.html#v:getCapacity)** To get the capacity of this drive.

    ### Changes

    * **New in version 1.4**

getCapacity(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L454)
:   Returns the capacity of the drive the path is located on.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path of the drive to get.

    ### Returns

    1. `number` | nil This drive's capacity. This will be nil for "read-only" drives, such as the ROM or
       treasure disks.

    ### Throws

    * If the capacity cannot be determined.

    ### See also

    * **[`getFreeSpace`](fs.html#v:getFreeSpace)** To get the free space available on this drive.

    ### Changes

    * **New in version 1.87.0**

attributes(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L484)
:   Get attributes about a specific file or folder.

    The returned attributes table contains information about the size of the file, whether it is a directory,
    when it was created and last modified, and whether it is read only.

    The creation and modification times are given as the number of milliseconds since the UNIX epoch. This may be
    given to [`os.date`](os.html#v:date) in order to convert it to more usable form.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to get attributes for.

    ### Returns

    1. { size = `number`, isDir = `boolean`, isReadOnly = `boolean`, created = `number`, modified = `number` } The resulting attributes.

    ### Throws

    * If the path does not exist.

    ### See also

    * **[`getSize`](fs.html#v:getSize)** If you only care about the file's size.
    * **[`isDir`](fs.html#v:isDir)** If you only care whether a path is a directory or not.

    ### Changes

    * **New in version 1.87.0**
    * **Changed in version 1.91.0:** Renamed `modification` field to `modified`.
    * **Changed in version 1.95.2:** Added `isReadOnly` to attributes.

### Types

### ReadWriteHandle

A file handle opened for reading and writing with [`fs.open`](fs.html#v:open).

ReadWriteHandle.read([count])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadWriteHandle.java#L31)
:   Read a number of bytes from this file.

    ### Parameters

    1. count? `number` The number of bytes to read. This may be 0 to determine we are at the end of the file. When
       absent, a single byte will be read.

    ### Returns

    1. nil If we are at the end of the file.

    #### Or

    1. `number` The value of the byte read. This is returned if the file is opened in binary mode and
       `count` is absent

    #### Or

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The bytes read as a string. This is returned when the `count` is given.

    ### Throws

    * When trying to read a negative number of bytes.
    * If the file has been closed.

    ### Changes

    * **Changed in version 1.80pr1:** Now accepts an integer argument to read multiple bytes, returning a string instead of a number.

ReadWriteHandle.readAll()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadWriteHandle.java#L40)
:   Read the remainder of the file.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The remaining contents of the file, or `nil` in the event of an error.

    ### Throws

    * If the file has been closed.

    ### Changes

    * **New in version 1.80pr1**

ReadWriteHandle.readLine([withTrailing])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadWriteHandle.java#L49)
:   Read a line from the file.

    ### Parameters

    1. withTrailing? `boolean` Whether to include the newline characters with the returned string. Defaults to `false`.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The read line or `nil` if at the end of the file.

    ### Throws

    * If the file has been closed.

    ### Changes

    * **New in version 1.80pr1.9**
    * **Changed in version 1.81.0:** `\r` is now stripped.

ReadWriteHandle.seek([whence [, offset]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadWriteHandle.java#L58)
:   Seek to a new position within the file, changing where bytes are written to. The new position is an offset
    given by `offset`, relative to a start position determined by `whence`:

    * `"set"`: `offset` is relative to the beginning of the file.
    * `"cur"`: Relative to the current position. This is the default.
    * `"end"`: Relative to the end of the file.

    In case of success, `seek` returns the new file position from the beginning of the file.

    ### Parameters

    1. whence? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Where the offset is relative to.
    2. offset? `number` The offset to seek to.

    ### Returns

    1. `number` The new position.

    #### Or

    1. nil If seeking failed.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The reason seeking failed.

    ### Throws

    * If the file has been closed.

    ### Changes

    * **New in version 1.80pr1.9**

ReadWriteHandle.write(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadWriteHandle.java#L67)
:   Write a string or byte to the file.

    ### Parameters

    1. contents [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The string to write.

    #### Or

    1. charcode `number` The byte to write, if the file was opened in binary mode.

    ### Throws

    * If the file has been closed.

    ### Changes

    * **Changed in version 1.80pr1:** Now accepts a string to write multiple bytes.

ReadWriteHandle.writeLine(text)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadWriteHandle.java#L76)
:   Write a string of characters to the file, following them with a new line character.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The text to write to the file.

    ### Throws

    * If the file has been closed.

ReadWriteHandle.flush()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadWriteHandle.java#L85)
:   Save the current file without closing it.

    ### Throws

    * If the file has been closed.

ReadWriteHandle.close()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/AbstractHandle.java#L54)
:   Close this file, freeing any resources it uses.

    Once a file is closed it may no longer be read or written to.

    ### Throws

    * If the file has already been closed.

### WriteHandle

A file handle opened for writing by [`fs.open`](fs.html#v:open).

WriteHandle.write(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/WriteHandle.java#L35)
:   Write a string or byte to the file.

    ### Parameters

    1. contents [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The string to write.

    #### Or

    1. charcode `number` The byte to write, if the file was opened in binary mode.

    ### Throws

    * If the file has been closed.

    ### Changes

    * **Changed in version 1.80pr1:** Now accepts a string to write multiple bytes.

WriteHandle.writeLine(text)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/WriteHandle.java#L44)
:   Write a string of characters to the file, following them with a new line character.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The text to write to the file.

    ### Throws

    * If the file has been closed.

WriteHandle.flush()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/WriteHandle.java#L53)
:   Save the current file without closing it.

    ### Throws

    * If the file has been closed.

WriteHandle.seek([whence [, offset]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/WriteHandle.java#L67)
:   Seek to a new position within the file, changing where bytes are written to. The new position is an offset
    given by `offset`, relative to a start position determined by `whence`:

    * `"set"`: `offset` is relative to the beginning of the file.
    * `"cur"`: Relative to the current position. This is the default.
    * `"end"`: Relative to the end of the file.

    In case of success, `seek` returns the new file position from the beginning of the file.

    ### Parameters

    1. whence? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Where the offset is relative to.
    2. offset? `number` The offset to seek to.

    ### Returns

    1. `number` The new position.

    #### Or

    1. nil If seeking failed.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The reason seeking failed.

    ### Throws

    * If the file has been closed.

    ### Changes

    * **New in version 1.80pr1.9**

WriteHandle.close()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/AbstractHandle.java#L54)
:   Close this file, freeing any resources it uses.

    Once a file is closed it may no longer be read or written to.

    ### Throws

    * If the file has already been closed.

### ReadHandle

A file handle opened for reading with [`fs.open`](fs.html#v:open).

ReadHandle.read([count])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadHandle.java#L32)
:   Read a number of bytes from this file.

    ### Parameters

    1. count? `number` The number of bytes to read. This may be 0 to determine we are at the end of the file. When
       absent, a single byte will be read.

    ### Returns

    1. nil If we are at the end of the file.

    #### Or

    1. `number` The value of the byte read. This is returned if the file is opened in binary mode and
       `count` is absent

    #### Or

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The bytes read as a string. This is returned when the `count` is given.

    ### Throws

    * When trying to read a negative number of bytes.
    * If the file has been closed.

    ### Changes

    * **Changed in version 1.80pr1:** Now accepts an integer argument to read multiple bytes, returning a string instead of a number.

ReadHandle.readAll()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadHandle.java#L41)
:   Read the remainder of the file.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The remaining contents of the file, or `nil` in the event of an error.

    ### Throws

    * If the file has been closed.

    ### Changes

    * **New in version 1.80pr1**

ReadHandle.readLine([withTrailing])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadHandle.java#L50)
:   Read a line from the file.

    ### Parameters

    1. withTrailing? `boolean` Whether to include the newline characters with the returned string. Defaults to `false`.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The read line or `nil` if at the end of the file.

    ### Throws

    * If the file has been closed.

    ### Changes

    * **New in version 1.80pr1.9**
    * **Changed in version 1.81.0:** `\r` is now stripped.

ReadHandle.seek([whence [, offset]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadHandle.java#L59)
:   Seek to a new position within the file, changing where bytes are written to. The new position is an offset
    given by `offset`, relative to a start position determined by `whence`:

    * `"set"`: `offset` is relative to the beginning of the file.
    * `"cur"`: Relative to the current position. This is the default.
    * `"end"`: Relative to the end of the file.

    In case of success, `seek` returns the new file position from the beginning of the file.

    ### Parameters

    1. whence? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Where the offset is relative to.
    2. offset? `number` The offset to seek to.

    ### Returns

    1. `number` The new position.

    #### Or

    1. nil If seeking failed.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The reason seeking failed.

    ### Throws

    * If the file has been closed.

    ### Changes

    * **New in version 1.80pr1.9**

ReadHandle.close()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/AbstractHandle.java#L54)
:   Close this file, freeing any resources it uses.

    Once a file is closed it may no longer be read or written to.

    ### Throws

    * If the file has already been closed.

---

## Source File: `module/gps.md`

# gps

Use [modems](../peripheral/modem.html) to locate the position of the current turtle or
computers.

It broadcasts a PING message over [`rednet`](rednet.html) and wait for responses. In order for
this system to work, there must be at least 4 computers used as gps hosts which
will respond and allow trilateration. Three of these hosts should be in a plane,
and the fourth should be either above or below the other three. The three in a
plane should not be in a line with each other. You can set up hosts using the
gps program.

##### ð note

When entering in the coordinates for the host you need to put in the `x`, `y`,
and `z` coordinates of the block that the modem is connected to, not the modem.
All modem distances are measured from the block that the modem is placed on.

Also note that you may choose which axes x, y, or z refers to - so long as your
systems have the same definition as any GPS servers that're in range, it works
just the same. For example, you might build a GPS cluster according to [this
tutorial](https://ccf.squiddev.cc/forums2/index.php?/topic/3088-how-to-guide-gps-global-position-system/), using z to account for height, or you might use y to account for
height in the way that Minecraft's debug screen displays.

### See also

* **[`Setting up GPS`](../guide/gps_setup.html)** For more detailed instructions on setting up GPS

### Changes

* **New in version 1.31**

|  |  |
| --- | --- |
| [CHANNEL\_GPS = 65534](#v:CHANNEL_GPS) | The channel which GPS requests and responses are broadcast on. |
| [locate([timeout=2 [, debug=false]])](#v:locate) | Tries to retrieve the computer or turtles own location. |

CHANNEL\_GPS = 65534[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/gps.lua#L36)
:   The channel which GPS requests and responses are broadcast on.

locate([timeout=2 [, debug=false]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/gps.lua#L101)
:   Tries to retrieve the computer or turtles own location.

    ### Parameters

    1. timeout? `number` = `2` The maximum time in seconds taken to establish our
       position.
    2. debug? `boolean` = `false` Print debugging messages

    ### Returns

    1. `number` This computer's `x` position.
    2. `number` This computer's `y` position.
    3. `number` This computer's `z` position.

    #### Or

    1. nil If the position could not be established.

---

## Source File: `module/help.md`

# help

Find help files on the current computer.

### Changes

* **New in version 1.2**

|  |  |
| --- | --- |
| [path()](#v:path) | Returns a colon-separated list of directories where help files are searched for. |
| [setPath(newPath)](#v:setPath) | Sets the colon-separated list of directories where help files are searched for to `newPath` |
| [lookup(topic)](#v:lookup) | Returns the location of the help file for the given topic. |
| [topics()](#v:topics) | Returns a list of topics that can be looked up and/or displayed. |
| [completeTopic(prefix)](#v:completeTopic) | Returns a list of topic endings that match the prefix. |

path()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/help.lua#L19)
:   Returns a colon-separated list of directories where help files are searched
    for. All directories are absolute.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The current help search path, separated by colons.

    ### See also

    * **[`help.setPath`](help.html#v:setPath)**

setPath(newPath)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/help.lua#L30)
:   Sets the colon-separated list of directories where help files are searched
    for to `newPath`

    ### Parameters

    1. newPath [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The new path to use.

    ### Usage

    * ```
      help.setPath( "/disk/help/" )
      ```
    * ```
      help.setPath( help.path() .. ":/myfolder/help/" )
      ```

    ### See also

    * **[`help.path`](help.html#v:path)**

lookup(topic)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/help.lua#L45)
:   Returns the location of the help file for the given topic.

    ### Parameters

    1. topic [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The topic to find

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The path to the given topic's help file, or `nil` if it
       cannot be found.

    ### Usage

    * ```
      help.lookup("disk")
      ```

    ### Changes

    * **Changed in version 1.80pr1:** Now supports finding .txt files.
    * **Changed in version 1.97.0:** Now supports finding Markdown files.

topics()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/help.lua#L66)
:   Returns a list of topics that can be looked up and/or displayed.

    ### Returns

    1. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) A list of topics in alphabetical order.

    ### Usage

    * ```
      help.topics()
      ```

completeTopic(prefix)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/help.lua#L107)
:   Returns a list of topic endings that match the prefix. Can be used with
    `read` to allow input of a help topic.

    ### Parameters

    1. prefix [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The prefix to match

    ### Returns

    1. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) A list of matching topics.

    ### Changes

    * **New in version 1.74**

---

## Source File: `module/http.md`

# http

Make HTTP requests, sending and receiving data to a remote web server.

### See also

* **[`Allowing access to local IPs`](../guide/local_ips.html)** To allow accessing servers running on your local network.

### Changes

* **New in version 1.1**

|  |  |
| --- | --- |
| [get(...)](#v:get) | Make a HTTP GET request to the given url. |
| [post(...)](#v:post) | Make a HTTP POST request to the given url. |
| [request(...)](#v:request) | Asynchronously make a HTTP request to the given url. |
| [checkURLAsync(url)](#v:checkURLAsync) | Asynchronously determine whether a URL can be requested. |
| [checkURL(url)](#v:checkURL) | Determine whether a URL can be requested. |
| [websocketAsync(...)](#v:websocketAsync) | Asynchronously open a websocket. |
| [websocket(...)](#v:websocket) | Open a websocket. |

get(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/http/http.lua#L104)
:   Make a HTTP GET request to the given url.

    ### Parameters

    1. url [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The url to request
    2. headers? { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) } Additional headers to send as part
       of this request.
    3. binary? `boolean` = `false` Whether the [response handle](fs.html#ty:ReadHandle)
       should be opened in binary mode.

    #### Or

    1. request { url = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), headers? = { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) }, binary? = `boolean`, method? = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), redirect? = `boolean`, timeout? = `number` } Options for the request. See [`http.request`](http.html#v:request) for details on how
       these options behave.

    ### Returns

    1. [`Response`](http.html#ty:Response) The resulting http response, which can be read from.

    #### Or

    1. nil When the http request failed, such as in the event of a 404
       error or connection timeout.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) A message detailing why the request failed.
    3. [`Response`](http.html#ty:Response) | nil The failing http response, if available.

    ### Usage

    * Make a request to [example.tweaked.cc](https://example.tweaked.cc),
      and print the returned page.

      ```
      local request = http.get("https://example.tweaked.cc")
      print(request.readAll())
      -- => HTTP is working!
      request.close()
      ```

    ### Changes

    * **Changed in version 1.63:** Added argument for headers.
    * **Changed in version 1.80pr1:** Response handles are now returned on error if available.
    * **Changed in version 1.80pr1:** Added argument for binary handles.
    * **Changed in version 1.80pr1.6:** Added support for table argument.
    * **Changed in version 1.86.0:** Added PATCH and TRACE methods.
    * **Changed in version 1.105.0:** Added support for custom timeouts.
    * **Changed in version 1.109.0:** The returned response now reads the body as raw bytes, rather
      than decoding from UTF-8.

post(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/http/http.lua#L148)
:   Make a HTTP POST request to the given url.

    ### Parameters

    1. url [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The url to request
    2. body [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The body of the POST request.
    3. headers? { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) } Additional headers to send as part
       of this request.
    4. binary? `boolean` = `false` Whether the [response handle](fs.html#ty:ReadHandle)
       should be opened in binary mode.

    #### Or

    1. request { url = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), body? = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), headers? = { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) }, binary? = `boolean`, method? = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), redirect? = `boolean`, timeout? = `number` } Options for the request. See [`http.request`](http.html#v:request) for details on how
       these options behave.

    ### Returns

    1. [`Response`](http.html#ty:Response) The resulting http response, which can be read from.

    #### Or

    1. nil When the http request failed, such as in the event of a 404
       error or connection timeout.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) A message detailing why the request failed.
    3. [`Response`](http.html#ty:Response) | nil The failing http response, if available.

    ### Changes

    * **New in version 1.31**
    * **Changed in version 1.63:** Added argument for headers.
    * **Changed in version 1.80pr1:** Response handles are now returned on error if available.
    * **Changed in version 1.80pr1:** Added argument for binary handles.
    * **Changed in version 1.80pr1.6:** Added support for table argument.
    * **Changed in version 1.86.0:** Added PATCH and TRACE methods.
    * **Changed in version 1.105.0:** Added support for custom timeouts.
    * **Changed in version 1.109.0:** The returned response now reads the body as raw bytes, rather
      than decoding from UTF-8.

request(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/http/http.lua#L201)
:   Asynchronously make a HTTP request to the given url.

    This returns immediately, a [`http_success`](../event/http_success.html) or [`http_failure`](../event/http_failure.html) will be queued
    once the request has completed.

    ### Parameters

    1. url [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The url to request
    2. body? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) An optional string containing the body of the
       request. If specified, a `POST` request will be made instead.
    3. headers? { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) } Additional headers to send as part
       of this request.
    4. binary? `boolean` = `false` Whether the [response handle](fs.html#ty:ReadHandle)
       should be opened in binary mode.

    #### Or

    1. request { url = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), body? = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), headers? = { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) }, binary? = `boolean`, method? = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), redirect? = `boolean`, timeout? = `number` }

       Options for the request.

       This table form is an expanded version of the previous syntax. All arguments
       from above are passed in as fields instead (for instance,
       `http.request("https://example.com")` becomes `http.request { url = "https://example.com" }`).
       This table also accepts several additional options:

       * `method`: Which HTTP method to use, for instance `"PATCH"` or `"DELETE"`.
       * `redirect`: Whether to follow HTTP redirects. Defaults to true.
       * `timeout`: The connection timeout, in seconds.

    ### See also

    * **[`http.get`](http.html#v:get)** For a synchronous way to make GET requests.
    * **[`http.post`](http.html#v:post)** For a synchronous way to make POST requests.

    ### Changes

    * **Changed in version 1.63:** Added argument for headers.
    * **Changed in version 1.80pr1:** Added argument for binary handles.
    * **Changed in version 1.80pr1.6:** Added support for table argument.
    * **Changed in version 1.86.0:** Added PATCH and TRACE methods.
    * **Changed in version 1.105.0:** Added support for custom timeouts.
    * **Changed in version 1.109.0:** The returned response now reads the body as raw bytes, rather
      than decoding from UTF-8.

checkURLAsync(url)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/http/http.lua#L223)
:   Asynchronously determine whether a URL can be requested.

    If this returns `true`, one should also listen for [`http_check`](../event/http_check.html) which will
    container further information about whether the URL is allowed or not.

    ### Parameters

    1. url [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The URL to check.

    ### Returns

    1. true When this url is not invalid. This does not imply that it is
       allowed - see the comment above.

    #### Or

    1. false When this url is invalid.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) A reason why this URL is not valid (for instance, if it is
       malformed, or blocked).

    ### See also

    * **[`http.checkURL`](http.html#v:checkURL)** For a synchronous version.

checkURL(url)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/http/http.lua#L264)
:   Determine whether a URL can be requested.

    If this returns `true`, one should also listen for [`http_check`](../event/http_check.html) which will
    container further information about whether the URL is allowed or not.

    ### Parameters

    1. url [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The URL to check.

    ### Returns

    1. true When this url is valid and can be requested via [`http.request`](http.html#v:request).

    #### Or

    1. false When this url is invalid.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) A reason why this URL is not valid (for instance, if it is
       malformed, or blocked).

    ### Usage

    * ```
      print(http.checkURL("https://example.tweaked.cc/"))
      -- => true
      print(http.checkURL("http://localhost/"))
      -- => false Domain not permitted
      print(http.checkURL("not a url"))
      -- => false URL malformed
      ```

    ### See also

    * **[`http.checkURLAsync`](http.html#v:checkURLAsync)** For an asynchronous version.

websocketAsync(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/http/http.lua#L307)
:   Asynchronously open a websocket.

    This returns immediately, a [`websocket_success`](../event/websocket_success.html) or [`websocket_failure`](../event/websocket_failure.html)
    will be queued once the request has completed.

    ### Parameters

    1. url [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The websocket url to connect to. This should have the
       `ws://` or `wss://` protocol.
    2. headers? { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) } Additional headers to send as part
       of the initial websocket connection.

    #### Or

    1. request { url = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), headers? = { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) }, timeout? = `number` } Options for the websocket. See [`http.websocket`](http.html#v:websocket) for details on how
       these options behave.

    ### See also

    * **[`websocket_success`](../event/websocket_success.html)**
    * **[`websocket_failure`](../event/websocket_failure.html)**

    ### Changes

    * **New in version 1.80pr1.3**
    * **Changed in version 1.95.3:** Added User-Agent to default headers.
    * **Changed in version 1.105.0:** Added support for table argument and custom timeout.
    * **Changed in version 1.109.0:** Non-binary websocket messages now use the raw bytes rather than
      using UTF-8.

websocket(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/http/http.lua#L365)
:   Open a websocket.

    ### Parameters

    1. url [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The websocket url to connect to. This should have the
       `ws://` or `wss://` protocol.
    2. headers? { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) } Additional headers to send as part
       of the initial websocket connection.

    #### Or

    1. request { url = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), headers? = { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) }, timeout? = `number` }

       Options for the websocket.

       This table form is an expanded version of the previous syntax. All arguments
       from above are passed in as fields instead (for instance,
       `http.websocket("https://example.com")` becomes `http.websocket { url = "https://example.com" }`).
       This table also accepts the following additional options:

       * `timeout`: The connection timeout, in seconds.

    ### Returns

    1. [`Websocket`](http.html#ty:Websocket) The websocket connection.

    #### Or

    1. false If the websocket connection failed.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) An error message describing why the connection failed.

    ### Usage

    * Connect to an echo websocket and send a message.

      ```
      local ws = assert(http.websocket("wss://example.tweaked.cc/echo"))
      ws.send("Hello!") -- Send a message
      print(ws.receive()) -- And receive the reply
      ws.close()
      ```

    ### Changes

    * **New in version 1.80pr1.1**
    * **Changed in version 1.80pr1.3:** No longer asynchronous.
    * **Changed in version 1.95.3:** Added User-Agent to default headers.
    * **Changed in version 1.105.0:** Added support for table argument and custom timeout.
    * **Changed in version 1.109.0:** Non-binary websocket messages now use the raw bytes rather than
      using UTF-8.

### Types

### Response

A http response. This provides the same methods as a [file](fs.html#ty:ReadHandle), though provides several request
specific methods.

### See also

* **[`http.request`](http.html#v:request)** On how to make a http request.

Response.getResponseCode()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/http/request/HttpResponseHandle.java#L45)
:   Returns the response code and response message returned by the server.

    ### Returns

    1. `number` The response code (i.e. 200)
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The response message (i.e. "OK")

    ### Changes

    * **Changed in version 1.80pr1.13:** Added response message return value.

Response.getResponseHeaders()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/http/request/HttpResponseHandle.java#L68)
:   Get a table containing the response's headers, in a format similar to that required by [`http.request`](http.html#v:request).
    If multiple headers are sent with the same name, they will be combined with a comma.

    ### Returns

    1. { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) } The response's headers.

    ### Usage

    * Make a request to [example.tweaked.cc](https://example.tweaked.cc), and print the
      returned headers.

      ```
      local request = http.get("https://example.tweaked.cc")
      print(textutils.serialize(request.getResponseHeaders()))
      -- => {
      --  [ "Content-Type" ] = "text/plain; charset=utf8",
      --  [ "content-length" ] = 17,
      --  ...
      -- }
      request.close()
      ```

### Websocket

A websocket, which can be used to send and receive messages with a web server.

### See also

* **[`http.websocket`](http.html#v:websocket)** On how to open a websocket.

Websocket.receive([timeout])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/http/websocket/WebsocketHandle.java#L59)
:   Wait for a message from the server.

    ### Parameters

    1. timeout? `number` The number of seconds to wait if no message is received.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The received message.
    2. `boolean` If this was a binary message.

    #### Or

    1. nil If the websocket was closed while waiting, or if we timed out.

    ### Throws

    * If the websocket has been closed.

    ### Changes

    * **Changed in version 1.80pr1.13:** Added return value indicating whether the message was binary.
    * **Changed in version 1.87.0:** Added timeout argument.

Websocket.send(message [, binary])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/http/websocket/WebsocketHandle.java#L78)
:   Send a websocket message to the connected server.

    ### Parameters

    1. message [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The message to send.
    2. binary? `boolean` Whether this message should be treated as a binary message.

    ### Throws

    * If the message is too large.
    * If the websocket has been closed.

    ### Changes

    * **Changed in version 1.81.0:** Added argument for binary mode.

Websocket.close()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/http/websocket/WebsocketHandle.java#L103)
:   Close this websocket. This will terminate the connection, meaning messages can no longer be sent or received
    along it.

---

## Source File: `module/io.md`

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

---

## Source File: `module/keys.md`

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

---

## Source File: `module/multishell.md`

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

---

## Source File: `module/os.md`

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

---

## Source File: `module/paintutils.md`

# paintutils

Utilities for drawing more complex graphics, such as pixels, lines and
images.

### Changes

* **New in version 1.45**

|  |  |
| --- | --- |
| [parseImage(image)](#v:parseImage) | Parses an image from a multi-line string |
| [loadImage(path)](#v:loadImage) | Loads an image from a file. |
| [drawPixel(xPos, yPos [, colour])](#v:drawPixel) | Draws a single pixel to the current term at the specified position. |
| [drawLine(startX, startY, endX, endY [, colour])](#v:drawLine) | Draws a straight line from the start to end position. |
| [drawBox(startX, startY, endX, endY [, colour])](#v:drawBox) | Draws the outline of a box on the current term from the specified start position to the specified end position. |
| [drawFilledBox(startX, startY, endX, endY [, colour])](#v:drawFilledBox) | Draws a filled box on the current term from the specified start position to the specified end position. |
| [drawImage(image, xPos, yPos)](#v:drawImage) | Draw an image loaded by [`paintutils.parseImage`](paintutils.html#v:parseImage) or [`paintutils.loadImage`](paintutils.html#v:loadImage). |

parseImage(image)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/paintutils.lua#L66)
:   Parses an image from a multi-line string

    ### Parameters

    1. image [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The string containing the raw-image data.

    ### Returns

    1. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The parsed image data, suitable for use with [`paintutils.drawImage`](paintutils.html#v:drawImage).

    ### Usage

    * Parse an image from a string, and draw it.

      ```
      local image = paintutils.parseImage([[
       e  e

      e    e
       eeee
      ]])
      paintutils.drawImage(image, term.getCursorPos())
      ```

    ### Changes

    * **New in version 1.80pr1**

loadImage(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/paintutils.lua#L87)
:   Loads an image from a file.

    You can create a file suitable for being loaded using the `paint` program.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The file to load.

    ### Returns

    1. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) | nil The parsed image data, suitable for use with
       [`paintutils.drawImage`](paintutils.html#v:drawImage), or `nil` if the file does not exist.

    ### Usage

    * Load an image and draw it.

      ```
      local image = paintutils.loadImage("data/example.nfp")
      paintutils.drawImage(image, term.getCursorPos())
      ```

drawPixel(xPos, yPos [, colour])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/paintutils.lua#L108)
:   Draws a single pixel to the current term at the specified position.

    Be warned, this may change the position of the cursor and the current
    background colour. You should not expect either to be preserved.

    ### Parameters

    1. xPos `number` The x position to draw at, where 1 is the far left.
    2. yPos `number` The y position to draw at, where 1 is the very top.
    3. colour? `number` The [color](colors.html) of this pixel. This will be
       the current background colour if not specified.

drawLine(startX, startY, endX, endY [, colour])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/paintutils.lua#L131)
:   Draws a straight line from the start to end position.

    Be warned, this may change the position of the cursor and the current
    background colour. You should not expect either to be preserved.

    ### Parameters

    1. startX `number` The starting x position of the line.
    2. startY `number` The starting y position of the line.
    3. endX `number` The end x position of the line.
    4. endY `number` The end y position of the line.
    5. colour? `number` The [color](colors.html) of this pixel. This will be
       the current background colour if not specified.

    ### Usage

    * ```
      paintutils.drawLine(2, 3, 30, 7, colors.red)
      ```

drawBox(startX, startY, endX, endY [, colour])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/paintutils.lua#L205)
:   Draws the outline of a box on the current term from the specified start
    position to the specified end position.

    Be warned, this may change the position of the cursor and the current
    background colour. You should not expect either to be preserved.

    ### Parameters

    1. startX `number` The starting x position of the line.
    2. startY `number` The starting y position of the line.
    3. endX `number` The end x position of the line.
    4. endY `number` The end y position of the line.
    5. colour? `number` The [color](colors.html) of this pixel. This will be
       the current background colour if not specified.

    ### Usage

    * ```
      paintutils.drawBox(2, 3, 30, 7, colors.red)
      ```

drawFilledBox(startX, startY, endX, endY [, colour])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/paintutils.lua#L258)
:   Draws a filled box on the current term from the specified start position to
    the specified end position.

    Be warned, this may change the position of the cursor and the current
    background colour. You should not expect either to be preserved.

    ### Parameters

    1. startX `number` The starting x position of the line.
    2. startY `number` The starting y position of the line.
    3. endX `number` The end x position of the line.
    4. endY `number` The end y position of the line.
    5. colour? `number` The [color](colors.html) of this pixel. This will be
       the current background colour if not specified.

    ### Usage

    * ```
      paintutils.drawFilledBox(2, 3, 30, 7, colors.red)
      ```

drawImage(image, xPos, yPos)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/paintutils.lua#L296)
:   Draw an image loaded by [`paintutils.parseImage`](paintutils.html#v:parseImage) or [`paintutils.loadImage`](paintutils.html#v:loadImage).

    ### Parameters

    1. image [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The parsed image data.
    2. xPos `number` The x position to start drawing at.
    3. yPos `number` The y position to start drawing at.

---

## Source File: `module/parallel.md`

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

---

## Source File: `module/peripheral.md`

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

---

## Source File: `module/pocket.md`

# pocket

Control the current pocket computer, adding or removing upgrades.

This API is only available on pocket computers. As such, you may use its presence to determine what kind of computer
you are using:

```
if pocket then
  print("On a pocket computer")
else
  print("On something else")
end
```

## Recipes

**Pocket Computer**

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Golden Apple](/images/items/minecraft/golden_apple.png "Golden Apple")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Glass Pane](/images/items/minecraft/glass_pane.png "Glass Pane")

![Stone](/images/items/minecraft/stone.png "Stone")

![Pocket Computer](/images/items/computercraft/pocket_computer_normal.png "Pocket Computer")

**Advanced Pocket Computer**

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Golden Apple](/images/items/minecraft/golden_apple.png "Golden Apple")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Glass Pane](/images/items/minecraft/glass_pane.png "Glass Pane")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Advanced Pocket Computer](/images/items/computercraft/pocket_computer_advanced.png "Advanced Pocket Computer")

|  |  |
| --- | --- |
| [equipBack()](#v:equipBack) | Search the player's inventory for another upgrade, replacing the existing one with that item if found. |
| [unequipBack()](#v:unequipBack) | Remove the pocket computer's current upgrade. |

equipBack()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/pocket/apis/PocketAPI.java#L63)
:   Search the player's inventory for another upgrade, replacing the existing one with that item if found.

    This inventory search starts from the player's currently selected slot, allowing you to prioritise upgrades.

    ### Returns

    1. `boolean` If an item was equipped.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason an item was not equipped.

unequipBack()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/pocket/apis/PocketAPI.java#L94)
:   Remove the pocket computer's current upgrade.

    ### Returns

    1. `boolean` If the upgrade was unequipped.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason an upgrade was not unequipped.

---

## Source File: `module/rednet.md`

# rednet

Communicate with other computers by using [modems](../peripheral/modem.html). [`rednet`](rednet.html)
provides a layer of abstraction on top of the main [`modem`](../peripheral/modem.html) peripheral, making
it slightly easier to use.

## Basic usage

In order to send a message between two computers, each computer must have a
modem on one of its sides (or in the case of pocket computers and turtles, the
modem must be equipped as an upgrade). The two computers should then call
[`rednet.open`](rednet.html#v:open), which sets up the modems ready to send and receive messages.

Once rednet is opened, you can send messages using [`rednet.send`](rednet.html#v:send) and receive
them using [`rednet.receive`](rednet.html#v:receive). It's also possible to send a message to *every*
rednet-using computer using [`rednet.broadcast`](rednet.html#v:broadcast).

##### â  Network security

While rednet provides a friendly way to send messages to specific computers, it
doesn't provide any guarantees about security. Other computers could be
listening in to your messages, or even pretending to send messages from other computers!

If you're playing on a multi-player server (or at least one where you don't
trust other players), it's worth encrypting or signing your rednet messages.

## Protocols and hostnames

Several rednet messages accept "protocol"s - simple string names describing what
a message is about. When sending messages using [`rednet.send`](rednet.html#v:send) and
[`rednet.broadcast`](rednet.html#v:broadcast), you can optionally specify a protocol for the message. This
same protocol can then be given to [`rednet.receive`](rednet.html#v:receive), to ignore all messages not
using this protocol.

It's also possible to look-up computers based on protocols, providing a basic
system for service discovery and [DNS](https://en.wikipedia.org/wiki/Domain_Name_System "Domain Name System"). A computer can advertise that it
supports a particular protocol with [`rednet.host`](rednet.html#v:host), also providing a friendly
"hostname". Other computers may then find all computers which support this
protocol using [`rednet.lookup`](rednet.html#v:lookup).

### See also

* **[`rednet_message`](../event/rednet_message.html)** Queued when a rednet message is received.
* **[`modem`](../peripheral/modem.html)** Rednet is built on top of the modem peripheral. Modems provide a more
  bare-bones but flexible interface.

### Changes

* **New in version 1.2**

|  |  |
| --- | --- |
| [CHANNEL\_BROADCAST = 65535](#v:CHANNEL_BROADCAST) | The channel used by the Rednet API to [`broadcast`](rednet.html#v:broadcast) messages. |
| [CHANNEL\_REPEAT = 65533](#v:CHANNEL_REPEAT) | The channel used by the Rednet API to repeat messages. |
| [MAX\_ID\_CHANNELS = 65500](#v:MAX_ID_CHANNELS) | The number of channels rednet reserves for computer IDs. |
| [open(modem)](#v:open) | Opens a modem with the given [`peripheral`](peripheral.html) name, allowing it to send and receive messages over rednet. |
| [close([modem])](#v:close) | Close a modem with the given [`peripheral`](peripheral.html) name, meaning it can no longer send and receive rednet messages. |
| [isOpen([modem])](#v:isOpen) | Determine if rednet is currently open. |
| [send(recipient, message [, protocol])](#v:send) | Allows a computer or turtle with an attached modem to send a message intended for a computer with a specific ID. |
| [broadcast(message [, protocol])](#v:broadcast) | Broadcasts a string message over the predefined [`CHANNEL_BROADCAST`](rednet.html#v:CHANNEL_BROADCAST) channel. |
| [receive([protocol\_filter [, timeout]])](#v:receive) | Wait for a rednet message to be received, or until `nTimeout` seconds have elapsed. |
| [host(protocol, hostname)](#v:host) | Register the system as "hosting" the desired protocol under the specified name. |
| [unhost(protocol)](#v:unhost) | Stop [hosting](rednet.html#v:host) a specific protocol, meaning it will no longer respond to [`rednet.lookup`](rednet.html#v:lookup) requests. |
| [lookup(protocol [, hostname])](#v:lookup) | Search the local rednet network for systems [hosting](rednet.html#v:host) the desired protocol and returns any computer IDs that respond as "r... |
| [run()](#v:run) | Listen for modem messages and converts them into rednet messages, which may then be [received](rednet.html#v:receive). |

CHANNEL\_BROADCAST = 65535[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L53)
:   The channel used by the Rednet API to [`broadcast`](rednet.html#v:broadcast) messages.

CHANNEL\_REPEAT = 65533[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L56)
:   The channel used by the Rednet API to repeat messages.

MAX\_ID\_CHANNELS = 65500[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L60)
:   The number of channels rednet reserves for computer IDs. Computers with IDs
    greater or equal to this limit wrap around to 0.

open(modem)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L91)
:   Opens a modem with the given [`peripheral`](peripheral.html) name, allowing it to send and
    receive messages over rednet.

    This will open the modem on two channels: one which has the same
    [ID](os.html#v:getComputerID) as the computer, and another on
    [the broadcast channel](rednet.html#v:CHANNEL_BROADCAST).

    ### Parameters

    1. modem [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the modem to open.

    ### Throws

    * If there is no such modem with the given name

    ### Usage

    * Open rednet on the back of the computer, allowing you to send and receive
      rednet messages using it.

      ```
      rednet.open("back")
      ```
    * Open rednet on all attached modems. This abuses the "filter" argument to
      [`peripheral.find`](peripheral.html#v:find).

      ```
      peripheral.find("modem", rednet.open)
      ```

    ### See also

    * **[`rednet.close`](rednet.html#v:close)**
    * **[`rednet.isOpen`](rednet.html#v:isOpen)**

close([modem])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L107)
:   Close a modem with the given [`peripheral`](peripheral.html) name, meaning it can no longer
    send and receive rednet messages.

    ### Parameters

    1. modem? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side the modem exists on. If not given, all
       open modems will be closed.

    ### Throws

    * If there is no such modem with the given name

    ### See also

    * **[`rednet.open`](rednet.html#v:open)**

isOpen([modem])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L133)
:   Determine if rednet is currently open.

    ### Parameters

    1. modem? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Which modem to check. If not given, all connected
       modems will be checked.

    ### Returns

    1. `boolean` If the given modem is open.

    ### See also

    * **[`rednet.open`](rednet.html#v:open)**

    ### Changes

    * **New in version 1.31**

send(recipient, message [, protocol])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L176)
:   Allows a computer or turtle with an attached modem to send a message
    intended for a computer with a specific ID. At least one such modem must first
    be [opened](rednet.html#v:open) before sending is possible.

    Assuming the target was in range and also had a correctly opened modem, the
    target computer may then use [`rednet.receive`](rednet.html#v:receive) to collect the message.

    ### Parameters

    1. recipient `number` The ID of the receiving computer.
    2. message The message to send. Like with [`modem.transmit`](../peripheral/modem.html#v:transmit), this can
       contain any primitive type (numbers, booleans and strings) as well as
       tables. Other types (like functions), as well as metatables, will not be
       transmitted.
    3. protocol? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The "protocol" to send this message under. When
       using [`rednet.receive`](rednet.html#v:receive) one can filter to only receive messages sent under a
       particular protocol.

    ### Returns

    1. `boolean` If this message was successfully sent (i.e. if rednet is
       currently [open](rednet.html#v:open)). Note, this does not guarantee the message was
       actually *received*.

    ### Usage

    * Send a message to computer #2.

      ```
      rednet.send(2, "Hello from rednet!")
      ```

    ### See also

    * **[`rednet.receive`](rednet.html#v:receive)**

    ### Changes

    * **Changed in version 1.6:** Added protocol parameter.
    * **Changed in version 1.82.0:** Now returns whether the message was successfully sent.

broadcast(message [, protocol])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L233)
:   Broadcasts a string message over the predefined [`CHANNEL_BROADCAST`](rednet.html#v:CHANNEL_BROADCAST)
    channel. The message will be received by every device listening to rednet.

    ### Parameters

    1. message The message to send. This should not contain coroutines or
       functions, as they will be converted to `nil`.
    2. protocol? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The "protocol" to send this message under. When
       using [`rednet.receive`](rednet.html#v:receive) one can filter to only receive messages sent under a
       particular protocol.

    ### Usage

    * Broadcast the words "Hello, world!" to every computer using rednet.

      ```
      rednet.broadcast("Hello, world!")
      ```

    ### See also

    * **[`rednet.receive`](rednet.html#v:receive)**

    ### Changes

    * **Changed in version 1.6:** Added protocol parameter.

receive([protocol\_filter [, timeout]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L276)
:   Wait for a rednet message to be received, or until `nTimeout` seconds have
    elapsed.

    ### Parameters

    1. protocol\_filter? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The protocol the received message must be
       sent with. If specified, any messages not sent under this protocol will be
       discarded.
    2. timeout? `number` The number of seconds to wait if no message is
       received.

    ### Returns

    1. `number` The computer which sent this message
    2. The received message
    3. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The protocol this message was sent under.

    #### Or

    1. nil If the timeout elapsed and no message was received.

    ### Usage

    * Receive a rednet message.

      ```
      local id, message = rednet.receive()
      print(("Computer %d sent message %s"):format(id, message))
      ```
    * Receive a message, stopping after 5 seconds if no message was received.

      ```
      local id, message = rednet.receive(nil, 5)
      if not id then
          printError("No message received")
      else
          print(("Computer %d sent message %s"):format(id, message))
      end
      ```
    * Receive a message from computer #2.

      ```
      local id, message
      repeat
          id, message = rednet.receive()
      until id == 2

      print(message)
      ```

    ### See also

    * **[`rednet.broadcast`](rednet.html#v:broadcast)**
    * **[`rednet.send`](rednet.html#v:send)**

    ### Changes

    * **Changed in version 1.6:** Added protocol filter parameter.

host(protocol, hostname)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L332)
:   Register the system as "hosting" the desired protocol under the specified
    name. If a rednet [lookup](rednet.html#v:lookup) is performed for that protocol (and
    maybe name) on the same network, the registered system will automatically
    respond via a background process, hence providing the system performing the
    lookup with its ID number.

    Multiple computers may not register themselves on the same network as having the
    same names against the same protocols, and the title `localhost` is specifically
    reserved. They may, however, share names as long as their hosted protocols are
    different, or if they only join a given network after "registering" themselves
    before doing so (eg while offline or part of a different network).

    ### Parameters

    1. protocol [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The protocol this computer provides.
    2. hostname [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name this computer exposes for the given protocol.

    ### Throws

    * If trying to register a hostname which is reserved, or currently in use.

    ### See also

    * **[`rednet.unhost`](rednet.html#v:unhost)**
    * **[`rednet.lookup`](rednet.html#v:lookup)**

    ### Changes

    * **New in version 1.6**

unhost(protocol)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L351)
:   Stop [hosting](rednet.html#v:host) a specific protocol, meaning it will no longer
    respond to [`rednet.lookup`](rednet.html#v:lookup) requests.

    ### Parameters

    1. protocol [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The protocol to unregister your self from.

    ### Changes

    * **New in version 1.6**

lookup(protocol [, hostname])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L388)
:   Search the local rednet network for systems [hosting](rednet.html#v:host) the
    desired protocol and returns any computer IDs that respond as "registered"
    against it.

    If a hostname is specified, only one ID will be returned (assuming an exact
    match is found).

    ### Parameters

    1. protocol [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The protocol to search for.
    2. hostname? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The hostname to search for.

    ### Returns

    1. `number`... A list of computer IDs hosting the given protocol.

    #### Or

    1. `number` | nil The computer ID with the provided hostname and protocol,
       or `nil` if none exists.

    ### Usage

    * Find all computers which are hosting the `"chat"` protocol.

      ```
      local computers = {rednet.lookup("chat")}
      print(#computers .. " computers available to chat")
      for _, computer in pairs(computers) do
        print("Computer #" .. computer)
      end
      ```
    * Find a computer hosting the `"chat"` protocol with a hostname of `"my_host"`.

      ```
      local id = rednet.lookup("chat", "my_host")
      if id then
        print("Found my_host at computer #" .. id)
      else
        printError("Cannot find my_host")
      end
      ```

    ### Changes

    * **New in version 1.6**

run()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L461)
:   Listen for modem messages and converts them into rednet messages, which may
    then be [received](rednet.html#v:receive).

    This is automatically started in the background on computer startup, and
    should not be called manually.

---

## Source File: `module/redstone.md`

# redstone

Get and set redstone signals adjacent to this computer.

The [`redstone`](redstone.html) library exposes three "types" of redstone control:

* Binary input/output ([`setOutput`](redstone.html#v:setOutput)/[`getInput`](redstone.html#v:getInput)): These simply check if a redstone wire has any input or
  output. A signal strength of 1 and 15 are treated the same.
* Analogue input/output ([`setAnalogOutput`](redstone.html#v:setAnalogOutput)/[`getAnalogInput`](redstone.html#v:getAnalogInput)): These work with the actual signal
  strength of the redstone wired, from 0 to 15.
* Bundled cables ([`setBundledOutput`](redstone.html#v:setBundledOutput)/[`getBundledInput`](redstone.html#v:getBundledInput)): These interact with "bundled" cables, such
  as those from Project:Red. These allow you to send 16 separate on/off signals. Each channel corresponds to a
  colour, with the first being [`colors.white`](colors.html#v:white) and the last [`colors.black`](colors.html#v:black).

Whenever a redstone input changes, a [`redstone`](../event/redstone.html) event will be fired. This may be used instead of repeativly
polling.

This module may also be referred to as `rs`. For example, one may call `rs.getSides()` instead of
[`getSides`](redstone.html#v:getSides).

### Usage

* Toggle the redstone signal above the computer every 0.5 seconds.

  ```
  while true do
    redstone.setOutput("top", not redstone.getOutput("top"))
    sleep(0.5)
  end
  ```
* Mimic a redstone comparator in [subtraction mode](https://minecraft.wiki/w/Redstone_Comparator#Subtract_signal_strength "Redstone Comparator on
  the Minecraft wiki.").

  ```
  while true do
    local rear = rs.getAnalogueInput("back")
    local sides = math.max(rs.getAnalogueInput("left"), rs.getAnalogueInput("right"))
    rs.setAnalogueOutput("front", math.max(rear - sides, 0))

    os.pullEvent("redstone") -- Wait for a change to inputs.
  end
  ```

|  |  |
| --- | --- |
| [getSides()](#v:getSides) | Returns a table containing the six sides of the computer. |
| [setOutput(side, on)](#v:setOutput) | Turn the redstone signal of a specific side on or off. |
| [getOutput(side)](#v:getOutput) | Get the current redstone output of a specific side. |
| [getInput(side)](#v:getInput) | Get the current redstone input of a specific side. |
| [setAnalogOutput(side, value)](#v:setAnalogOutput) | Set the redstone signal strength for a specific side. |
| [setAnalogueOutput(side, value)](#v:setAnalogueOutput) | Set the redstone signal strength for a specific side. |
| [getAnalogOutput(side)](#v:getAnalogOutput) | Get the redstone output signal strength for a specific side. |
| [getAnalogueOutput(side)](#v:getAnalogueOutput) | Get the redstone output signal strength for a specific side. |
| [getAnalogInput(side)](#v:getAnalogInput) | Get the redstone input signal strength for a specific side. |
| [getAnalogueInput(side)](#v:getAnalogueInput) | Get the redstone input signal strength for a specific side. |
| [setBundledOutput(side, output)](#v:setBundledOutput) | Set the bundled cable output for a specific side. |
| [getBundledOutput(side)](#v:getBundledOutput) | Get the bundled cable output for a specific side. |
| [getBundledInput(side)](#v:getBundledInput) | Get the bundled cable input for a specific side. |
| [testBundledInput(side, mask)](#v:testBundledInput) | Determine if a specific combination of colours are on for the given side. |

getSides()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneAPI.java#L73)
:   Returns a table containing the six sides of the computer. Namely, "top", "bottom", "left", "right", "front" and
    "back".

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A table of valid sides.

    ### Changes

    * **New in version 1.2**

setOutput(side, on)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L27)
:   Turn the redstone signal of a specific side on or off.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to set.
    2. on `boolean` Whether the redstone signal should be on or off. When on, a signal strength of 15 is emitted.

getOutput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L39)
:   Get the current redstone output of a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `boolean` Whether the redstone output is on or off.

    ### See also

    * **[`setOutput`](redstone.html#v:setOutput)**

getInput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L50)
:   Get the current redstone input of a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `boolean` Whether the redstone input is on or off.

setAnalogOutput(side, value)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L63)
:   Set the redstone signal strength for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to set.
    2. value `number` The signal strength between 0 and 15.

    ### Throws

    * If `value` is not between 0 and 15.

    ### Changes

    * **New in version 1.51**

setAnalogueOutput(side, value)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L63)
:   Set the redstone signal strength for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to set.
    2. value `number` The signal strength between 0 and 15.

    ### Throws

    * If `value` is not between 0 and 15.

    ### Changes

    * **New in version 1.51**

getAnalogOutput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L77)
:   Get the redstone output signal strength for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `number` The output signal strength, between 0 and 15.

    ### See also

    * **[`setAnalogOutput`](redstone.html#v:setAnalogOutput)**

    ### Changes

    * **New in version 1.51**

getAnalogueOutput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L77)
:   Get the redstone output signal strength for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `number` The output signal strength, between 0 and 15.

    ### See also

    * **[`setAnalogOutput`](redstone.html#v:setAnalogOutput)**

    ### Changes

    * **New in version 1.51**

getAnalogInput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L89)
:   Get the redstone input signal strength for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `number` The input signal strength, between 0 and 15.

    ### Changes

    * **New in version 1.51**

getAnalogueInput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L89)
:   Get the redstone input signal strength for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `number` The input signal strength, between 0 and 15.

    ### Changes

    * **New in version 1.51**

setBundledOutput(side, output)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L102)
:   Set the bundled cable output for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to set.
    2. output `number` The colour bitmask to set.

    ### See also

    * **[`colors.subtract`](colors.html#v:subtract)** For removing a colour from the bitmask.
    * **[`colors.combine`](colors.html#v:combine)** For adding a color to the bitmask.

getBundledOutput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L113)
:   Get the bundled cable output for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `number` The bundle cable's output.

getBundledInput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L125)
:   Get the bundled cable input for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `number` The bundle cable's input.

    ### See also

    * **[`testBundledInput`](redstone.html#v:testBundledInput)** To determine if a specific colour is set.

testBundledInput(side, mask)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L142)
:   Determine if a specific combination of colours are on for the given side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to test.
    2. mask `number` The mask to test.

    ### Returns

    1. `boolean` If the colours are on.

    ### Usage

    * Check if [`colors.white`](colors.html#v:white) and [`colors.black`](colors.html#v:black) are on above this block.

      ```
      print(redstone.testBundledInput("top", colors.combine(colors.white, colors.black)))
      ```

    ### See also

    * **[`getBundledInput`](redstone.html#v:getBundledInput)**

---

## Source File: `module/settings.md`

# settings

Read and write configuration options for CraftOS and your programs.

When a computer starts, it reads the current value of settings from the
`/.settings` file. These values then may be [read](settings.html#v:get) or
[modified](settings.html#v:set).

##### â  warning

Calling [`settings.set`](settings.html#v:set) does *not* update the settings file by default. You
*must* call [`settings.save`](settings.html#v:save) to persist values.

### Usage

* Define an basic setting `123` and read its value.

  ```
  settings.define("my.setting", {
      description = "An example setting",
      default = 123,
      type = "number",
  })
  print("my.setting = " .. settings.get("my.setting")) -- 123
  ```

  You can then use the `set` program to change its value (e.g. `set my.setting 456`),
  and then re-run the `example` program to check it has changed.

### Changes

* **New in version 1.78**

|  |  |
| --- | --- |
| [define(name [, options])](#v:define) | Define a new setting, optional specifying various properties about it. |
| [undefine(name)](#v:undefine) | Remove a [definition](settings.html#v:define) of a setting. |
| [set(name, value)](#v:set) | Set the value of a setting. |
| [get(name [, default])](#v:get) | Get the value of a setting. |
| [getDetails(name)](#v:getDetails) | Get details about a specific setting. |
| [unset(name)](#v:unset) | Remove the value of a setting, setting it to the default. |
| [clear()](#v:clear) | Resets the value of all settings. |
| [getNames()](#v:getNames) | Get the names of all currently defined settings. |
| [load([path=".settings"])](#v:load) | Load settings from the given file. |
| [save([path=".settings"])](#v:save) | Save settings to the given file. |

define(name [, options])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/settings.lua#L66)
:   Define a new setting, optional specifying various properties about it.

    While settings do not have to be added before being used, doing so allows
    you to provide defaults and additional metadata.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of this option
    2. options? { description? = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), default? = `any`, type? = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) }

       Options for this setting. This table accepts the following fields:

       * `description`: A description which may be printed when running the `set` program.
       * `default`: A default value, which is returned by [`settings.get`](settings.html#v:get) if the
         setting has not been changed.
       * `type`: Require values to be of this type. [Setting](settings.html#v:set) the value to another type
         will error. Must be one of: `"number"`, `"string"`, `"boolean"`, or `"table"`.

    ### Changes

    * **New in version 1.87.0**

undefine(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/settings.lua#L94)
:   Remove a [definition](settings.html#v:define) of a setting.

    If a setting has been changed, this does not remove its value. Use [`settings.unset`](settings.html#v:unset)
    for that.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of this option

    ### Changes

    * **New in version 1.87.0**

set(name, value)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/settings.lua#L125)
:   Set the value of a setting.

    ##### â  warning

    Calling [`settings.set`](settings.html#v:set) does *not* update the settings file by default. You
    *must* call [`settings.save`](settings.html#v:save) to persist values.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the setting to set
    2. value The setting's value. This cannot be `nil`, and must be
       serialisable by [`textutils.serialize`](textutils.html#v:serialize).

    ### Throws

    * If this value cannot be serialised

    ### See also

    * **[`settings.unset`](settings.html#v:unset)**

get(name [, default])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/settings.lua#L143)
:   Get the value of a setting.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the setting to get.
    2. default? The value to use should there be pre-existing value for
       this setting. If not given, it will use the setting's default value if given,
       or `nil` otherwise.

    ### Returns

    1. The setting's, or the default if the setting has not been changed.

    ### Changes

    * **Changed in version 1.87.0:** Now respects default value if pre-defined and `default` is unset.

getDetails(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/settings.lua#L163)
:   Get details about a specific setting.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the setting to get.

    ### Returns

    1. { description? = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), default? = `any`, type? = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), value? = `any` } Information about this setting. This includes all information from [`settings.define`](settings.html#v:define),
       as well as this setting's value.

    ### Changes

    * **New in version 1.87.0**

unset(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/settings.lua#L180)
:   Remove the value of a setting, setting it to the default.

    [`settings.get`](settings.html#v:get) will return the default value until the setting's value is
    [set](settings.html#v:set), or the computer is rebooted.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the setting to unset.

    ### See also

    * **[`settings.set`](settings.html#v:set)**
    * **[`settings.clear`](settings.html#v:clear)**

clear()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/settings.lua#L189)
:   Resets the value of all settings. Equivalent to calling [`settings.unset`](settings.html#v:unset)
    on every setting.

    ### See also

    * **[`settings.unset`](settings.html#v:unset)**

getNames()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/settings.lua#L199)
:   Get the names of all currently defined settings.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) } An alphabetically sorted list of all currently-defined
       settings.

load([path=".settings"])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/settings.lua#L223)
:   Load settings from the given file.

    Existing settings will be merged with any pre-existing ones. Conflicting
    entries will be overwritten, but any others will be preserved.

    ### Parameters

    1. path? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) = `".settings"` The file to load from.

    ### Returns

    1. `boolean` Whether settings were successfully read from this
       file. Reasons for failure may include the file not existing or being
       corrupted.

    ### See also

    * **[`settings.save`](settings.html#v:save)**

    ### Changes

    * **Changed in version 1.87.0:** `path` is now optional.

save([path=".settings"])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/settings.lua#L263)
:   Save settings to the given file.

    This will entirely overwrite the pre-existing file. Settings defined in the
    file, but not currently loaded will be removed.

    ### Parameters

    1. path? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) = `".settings"` The path to save settings to.

    ### Returns

    1. `boolean` If the settings were successfully saved.

    ### See also

    * **[`settings.load`](settings.html#v:load)**

    ### Changes

    * **Changed in version 1.87.0:** `path` is now optional.

---

## Source File: `module/shell.md`

# shell

The shell API provides access to CraftOS's command line interface.

It allows you to [start programs](shell.html#v:run), [add completion for a
program](shell.html#v:setCompletionFunction), and much more.

[`shell`](shell.html) is not a "true" API. Instead, it is a standard program, which injects
its API into the programs that it launches. This allows for multiple shells to
run at the same time, but means that the API is not available in the global
environment, and so is unavailable to other [APIs](os.html#v:loadAPI).

## Programs and the program path

When you run a command with the shell, either from the prompt or
[from Lua code](shell.html#v:run), the shell API performs several steps to work out
which program to run:

1. Firstly, the shell attempts to resolve [aliases](shell.html#v:aliases). This allows
   us to use multiple names for a single command. For example, the `list`
   program has two aliases: `ls` and `dir`. When you write `ls /rom`, that's
   expanded to `list /rom`.
2. Next, the shell attempts to find where the program actually is. For this, it
   uses the [program path](shell.html#v:path). This is a colon separated list of
   directories, each of which is checked to see if it contains the program.

   `list` or `list.lua` doesn't exist in `.` (the current directory), so the
   shell now looks in `/rom/programs`, where `list.lua` can be found!
3. Finally, the shell reads the file and checks if the file starts with a
   `#!`. This is a [hashbang](https://en.wikipedia.org/wiki/Shebang_(Unix)), which says that this file shouldn't be treated
   as Lua, but instead passed to *another* program, the name of which should
   follow the `#!`.

### Changes

* **Changed in version 1.103.0:** Added support for hashbangs.

|  |  |
| --- | --- |
| [execute(command, ...)](#v:execute) | Run a program with the supplied arguments. |
| [run(...)](#v:run) | Run a program with the supplied arguments. |
| [exit()](#v:exit) | Exit the current shell. |
| [dir()](#v:dir) | Return the current working directory. |
| [setDir(dir)](#v:setDir) | Set the current working directory. |
| [path()](#v:path) | Set the path where programs are located. |
| [setPath(path)](#v:setPath) | Set the [current program path](shell.html#v:path). |
| [resolve(path)](#v:resolve) | Resolve a relative path to an absolute path. |
| [resolveProgram(command)](#v:resolveProgram) | Resolve a program, using the [program path](shell.html#v:path) and list of [aliases](shell.html#v:aliases). |
| [programs([include\_hidden])](#v:programs) | Return a list of all programs on the [path](shell.html#v:path). |
| [complete(sLine)](#v:complete) | Complete a shell command line. |
| [completeProgram(program)](#v:completeProgram) | Complete the name of a program. |
| [setCompletionFunction(program, complete)](#v:setCompletionFunction) | Set the completion function for a program. |
| [getCompletionInfo()](#v:getCompletionInfo) | Get a table containing all completion functions. |
| [getRunningProgram()](#v:getRunningProgram) | Returns the path to the currently running program. |
| [setAlias(command, program)](#v:setAlias) | Add an alias for a program. |
| [clearAlias(command)](#v:clearAlias) | Remove an alias. |
| [aliases()](#v:aliases) | Get the current aliases for this shell. |
| [openTab(...)](#v:openTab) | Open a new [`multishell`](multishell.html) tab running a command. |
| [switchTab(id)](#v:switchTab) | Switch to the [`multishell`](multishell.html) tab with the given index. |

execute(command, ...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/shell.lua#L206)
:   Run a program with the supplied arguments.

    Unlike [`shell.run`](shell.html#v:run), each argument is passed to the program verbatim. While
    `shell.run("echo", "b c")` runs `echo` with `b` and `c`,
    `shell.execute("echo", "b c")` runs `echo` with a single argument `b c`.

    ### Parameters

    1. command [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The program to execute.
    2. ... [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Arguments to this program.

    ### Returns

    1. `boolean` Whether the program exited successfully.

    ### Usage

    * Run `paint my-image` from within your program:

      ```
      shell.execute("paint", "my-image")
      ```

    ### Changes

    * **New in version 1.88.0**

run(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/shell.lua#L260)
:   Run a program with the supplied arguments.

    All arguments are concatenated together and then parsed as a command line. As
    a result, `shell.run("program a b")` is the same as `shell.run("program", "a", "b")`.

    ### Parameters

    1. ... [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The program to run and its arguments.

    ### Returns

    1. `boolean` Whether the program exited successfully.

    ### Usage

    * Run `paint my-image` from within your program:

      ```
      shell.run("paint", "my-image")
      ```

    ### See also

    * **[`shell.execute`](shell.html#v:execute)** Run a program directly without parsing the arguments.

    ### Changes

    * **Changed in version 1.80pr1:** Programs now get their own environment instead of sharing the same one.
    * **Changed in version 1.83.0:** `arg` is now added to the environment.

exit()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/shell.lua#L274)
:   Exit the current shell.

    This does *not* terminate your program, it simply makes the shell terminate
    after your program has finished. If this is the toplevel shell, then the
    computer will be shutdown.

dir()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/shell.lua#L284)
:   Return the current working directory. This is what is displayed before the
    `>`  of the shell prompt, and is used by [`shell.resolve`](shell.html#v:resolve) to handle relative
    paths.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The current working directory.

    ### See also

    * **[`setDir`](shell.html#v:setDir)** To change the working directory.

setDir(dir)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/shell.lua#L295)
:   Set the current working directory.

    ### Parameters

    1. dir [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The new working directory.

    ### Throws

    * If the path does not exist or is not a directory.

    ### Usage

    * Set the working directory to "rom"

      ```
      shell.setDir("rom")
      ```

path()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/shell.lua#L312)
:   Set the path where programs are located.

    The path is composed of a list of directory names in a string, each separated
    by a colon (`:`). On normal turtles will look in the current directory (`.`),
    `/rom/programs` and `/rom/programs/turtle` folder, making the path
    `.:/rom/programs:/rom/programs/turtle`.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The current shell's path.

    ### See also

    * **[`setPath`](shell.html#v:setPath)** To change the current path.

setPath(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/shell.lua#L323)
:   Set the [current program path](shell.html#v:path).

    Be careful to prefix directories with a `/`. Otherwise they will be searched
    for from the [current directory](shell.html#v:dir), rather than the computer's root.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The new program path.

    ### Changes

    * **New in version 1.2**

resolve(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/shell.lua#L340)
:   Resolve a relative path to an absolute path.

    The [`fs`](fs.html) and [`io`](io.html) APIs work using absolute paths, and so we must convert
    any paths relative to the [current directory](shell.html#v:dir) to absolute ones. This
    does nothing when the path starts with `/`.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to resolve.

    ### Usage

    * Resolve `startup.lua` when in the `rom` folder.

      ```
      shell.setDir("rom")
      print(shell.resolve("startup.lua"))
      -- => rom/startup.lua
      ```

resolveProgram(command)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/shell.lua#L371)
:   Resolve a program, using the [program path](shell.html#v:path) and list of [aliases](shell.html#v:aliases).

    ### Parameters

    1. command [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the program

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The absolute path to the program, or `nil` if it could
       not be found.

    ### Usage

    * Locate the `hello` program.

      ```
       shell.resolveProgram("hello")
       -- => rom/programs/fun/hello.lua
      ```

    ### Changes

    * **New in version 1.2**
    * **Changed in version 1.80pr1:** Now searches for files with and without the `.lua` extension.

programs([include\_hidden])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/shell.lua#L416)
:   Return a list of all programs on the [path](shell.html#v:path).

    ### Parameters

    1. include\_hidden? `boolean` Include hidden files. Namely, any which
       start with `.`.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) } A list of available programs.

    ### Usage

    * ```
      textutils.tabulate(shell.programs())
      ```

    ### Changes

    * **New in version 1.2**

complete(sLine)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/shell.lua#L530)
:   Complete a shell command line.

    This accepts an incomplete command, and completes the program name or
    arguments. For instance, `l` will be completed to `ls`, and `ls ro` will be
    completed to `ls rom/`.

    Completion handlers for your program may be registered with
    [`shell.setCompletionFunction`](shell.html#v:setCompletionFunction).

    ### Parameters

    1. sLine [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The input to complete.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) } | nil The list of possible completions.

    ### See also

    * **[`_G.read`](_G.html#v:read)** For more information about completion.
    * **[`shell.completeProgram`](shell.html#v:completeProgram)**
    * **[`shell.setCompletionFunction`](shell.html#v:setCompletionFunction)**
    * **[`shell.getCompletionInfo`](shell.html#v:getCompletionInfo)**

    ### Changes

    * **New in version 1.74**

completeProgram(program)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/shell.lua#L572)
:   Complete the name of a program.

    ### Parameters

    1. program [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of a program to complete.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) } A list of possible completions.

    ### See also

    * **[`cc.shell.completion.program`](../library/cc.shell.completion.html#v:program)**

setCompletionFunction(program, complete)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/shell.lua#L606)
:   Set the completion function for a program. When the program is entered on
    the command line, this program will be called to provide auto-complete
    information.

    The completion function accepts four arguments:

    1. The current shell. As completion functions are inherited, this is not
       guaranteed to be the shell you registered this function in.
    2. The index of the argument currently being completed.
    3. The current argument. This may be the empty string.
    4. A list of the previous arguments.

    For instance, when completing `pastebin put rom/st` our pastebin completion
    function will receive the shell API, an index of 2, `rom/st` as the current
    argument, and a "previous" table of `{ "put" }`. This function may then wish
    to return a table containing `artup.lua`, indicating the entire command
    should be completed to `pastebin put rom/startup.lua`.

    You completion entries may also be followed by a space, if you wish to
    indicate another argument is expected.

    ### Parameters

    1. program [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to the program. This should be an absolute path
       *without* the leading `/`.
    2. complete function(shell: [`table`](https://www.lua.org/manual/5.1/manual.html#5.5), index: `number`, argument: [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), previous: { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) }):{ [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) } | nil The completion function.

    ### See also

    * **[`cc.shell.completion`](../library/cc.shell.completion.html)** Various utilities to help with writing completion functions.
    * **[`shell.complete`](shell.html#v:complete)**
    * **[`_G.read`](_G.html#v:read)** For more information about completion.

    ### Changes

    * **New in version 1.74**

getCompletionInfo()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/shell.lua#L621)
:   Get a table containing all completion functions.

    This should only be needed when building custom shells. Use
    [`setCompletionFunction`](shell.html#v:setCompletionFunction) to add a completion function.

    ### Returns

    1. { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = { fnComplete = `function` } } A table mapping the
       absolute path of programs, to their completion functions.

getRunningProgram()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/shell.lua#L629)
:   Returns the path to the currently running program.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The absolute path to the running program.

    ### Changes

    * **New in version 1.3**

setAlias(command, program)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/shell.lua#L644)
:   Add an alias for a program.

    ### Parameters

    1. command [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the alias to add.
    2. program [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name or path to the program.

    ### Usage

    * Alias `vim` to the `edit` program

      ```
      shell.setAlias("vim", "edit")
      ```

    ### Changes

    * **New in version 1.2**

clearAlias(command)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/shell.lua#L653)
:   Remove an alias.

    ### Parameters

    1. command [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The alias name to remove.

aliases()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/shell.lua#L669)
:   Get the current aliases for this shell.

    Aliases are used to allow multiple commands to refer to a single program. For
    instance, the `list` program is aliased to `dir` or `ls`. Running `ls`, `dir`
    or `list` in the shell will all run the `list` program.

    ### Returns

    1. { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) } A table, where the keys are the names of
       aliases, and the values are the path to the program.

    ### See also

    * **[`shell.setAlias`](shell.html#v:setAlias)**
    * **[`shell.resolveProgram`](shell.html#v:resolveProgram)** This uses aliases when resolving a program name to
      an absolute path.

openTab(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/shell.lua#L694)
:   Open a new [`multishell`](multishell.html) tab running a command.

    This behaves similarly to [`shell.run`](shell.html#v:run), but instead returns the process
    index.

    This function is only available if the [`multishell`](multishell.html) API is.

    ### Parameters

    1. ... [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The command line to run.

    ### Usage

    * Launch the Lua interpreter and switch to it.

      ```
      local id = shell.openTab("lua")
      shell.switchTab(id)
      ```

    ### See also

    * **[`shell.run`](shell.html#v:run)**
    * **[`multishell.launch`](multishell.html#v:launch)**

    ### Changes

    * **New in version 1.6**

switchTab(id)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/programs/shell.lua#L714)
:   Switch to the [`multishell`](multishell.html) tab with the given index.

    ### Parameters

    1. id `number` The tab to switch to.

    ### See also

    * **[`multishell.setFocus`](multishell.html#v:setFocus)**

    ### Changes

    * **New in version 1.6**

---

## Source File: `module/term.md`

# term

Interact with a computer's terminal or monitors, writing text and drawing ASCII graphics.

## Writing to the terminal

The simplest operation one can perform on a terminal is displaying (or writing) some text. This can be performed with
the [`term.write`](term.html#v:write) method.

```
term.write("Hello, world!")
```

When you write text, this advances the cursor, so the next call to [`term.write`](term.html#v:write) will write text immediately after
the previous one.

```
term.write("Hello, world!")
term.write("Some more text")
```

[`term.getCursorPos`](term.html#v:getCursorPos) and [`term.setCursorPos`](term.html#v:setCursorPos) can be used to manually change the cursor's position.

```
term.clear()

term.setCursorPos(1, 1) -- The first column of line 1
term.write("First line")

term.setCursorPos(20, 2) -- The 20th column of line 2
term.write("Second line")
```

[`term.write`](term.html#v:write) is a relatively basic and low-level function, and does not handle more advanced features such as line
breaks or word wrapping. If you just want to display text to the screen, you probably want to use [`print`](https://www.lua.org/manual/5.1/manual.html#pdf-print) or
[`write`](term.html#v:write) instead.

## Colours

So far we've been writing text in black and white. However, advanced computers are also capable of displaying text
in a variety of colours, with the [`term.setTextColour`](term.html#v:setTextColour) and [`term.setBackgroundColour`](term.html#v:setBackgroundColour) functions.

```
print("This text is white")
term.setTextColour(colours.green)
print("This text is green")
```

These functions accept any of the constants from the [`colors`](colors.html) API. [Combinations of colours](colors.html#v:combine) may
be accepted, but will only display a single colour (typically following the behaviour of [`colors.toBlit`](colors.html#v:toBlit)).

The [`paintutils`](paintutils.html) API provides several helpful functions for displaying graphics using [`term.setBackgroundColour`](term.html#v:setBackgroundColour).

|  |  |
| --- | --- |
| [nativePaletteColour(colour)](#v:nativePaletteColour) | Get the default palette value for a colour. |
| [nativePaletteColor(colour)](#v:nativePaletteColor) | Get the default palette value for a colour. |
| [write(text)](#v:write) | Write `text` at the current cursor position, moving the cursor to the end of the text. |
| [scroll(y)](#v:scroll) | Move all positions up (or down) by `y` pixels. |
| [getCursorPos()](#v:getCursorPos) | Get the position of the cursor. |
| [setCursorPos(x, y)](#v:setCursorPos) | Set the position of the cursor. |
| [getCursorBlink()](#v:getCursorBlink) | Checks if the cursor is currently blinking. |
| [setCursorBlink(blink)](#v:setCursorBlink) | Sets whether the cursor should be visible (and blinking) at the current [cursor position](term.html#v:getCursorPos). |
| [getSize()](#v:getSize) | Get the size of the terminal. |
| [clear()](#v:clear) | Clears the terminal, filling it with the [current background colour](term.html#v:getBackgroundColour). |
| [clearLine()](#v:clearLine) | Clears the line the cursor is currently on, filling it with the [current background colour](term.html#v:getBackgroundColour). |
| [getTextColour()](#v:getTextColour) | Return the colour that new text will be written as. |
| [getTextColor()](#v:getTextColor) | Return the colour that new text will be written as. |
| [setTextColour(colour)](#v:setTextColour) | Set the colour that new text will be written as. |
| [setTextColor(colour)](#v:setTextColor) | Set the colour that new text will be written as. |
| [getBackgroundColour()](#v:getBackgroundColour) | Return the current background colour. |
| [getBackgroundColor()](#v:getBackgroundColor) | Return the current background colour. |
| [setBackgroundColour(colour)](#v:setBackgroundColour) | Set the current background colour. |
| [setBackgroundColor(colour)](#v:setBackgroundColor) | Set the current background colour. |
| [isColour()](#v:isColour) | Determine if this terminal supports colour. |
| [isColor()](#v:isColor) | Determine if this terminal supports colour. |
| [blit(text, textColour, backgroundColour)](#v:blit) | Writes `text` to the terminal with the specific foreground and background colours. |
| [setPaletteColour(...)](#v:setPaletteColour) | Set the palette for a specific colour. |
| [setPaletteColor(...)](#v:setPaletteColor) | Set the palette for a specific colour. |
| [getPaletteColour(colour)](#v:getPaletteColour) | Get the current palette for a specific colour. |
| [getPaletteColor(colour)](#v:getPaletteColor) | Get the current palette for a specific colour. |
| [redirect(target)](#v:redirect) | Redirects terminal output to a monitor, a [`window`](window.html), or any other custom terminal object. |
| [current()](#v:current) | Returns the current terminal object of the computer. |
| [native()](#v:native) | Get the native terminal object of the current computer. |

nativePaletteColour(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermAPI.java#L91)
:   Get the default palette value for a colour.

    ### Parameters

    1. colour `number` The colour whose palette should be fetched.

    ### Returns

    1. `number` The red channel, will be between 0 and 1.
    2. `number` The green channel, will be between 0 and 1.
    3. `number` The blue channel, will be between 0 and 1.

    ### Throws

    * When given an invalid colour.

    ### See also

    * **[`term.Redirect.setPaletteColour`](term.html#ty:Redirect:setPaletteColour)** To change the palette colour.

    ### Changes

    * **New in version 1.81.0**

nativePaletteColor(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermAPI.java#L91)
:   Get the default palette value for a colour.

    ### Parameters

    1. colour `number` The colour whose palette should be fetched.

    ### Returns

    1. `number` The red channel, will be between 0 and 1.
    2. `number` The green channel, will be between 0 and 1.
    3. `number` The blue channel, will be between 0 and 1.

    ### Throws

    * When given an invalid colour.

    ### See also

    * **[`term.Redirect.setPaletteColour`](term.html#ty:Redirect:setPaletteColour)** To change the palette colour.

    ### Changes

    * **New in version 1.81.0**

write(text)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L38)
:   Write `text` at the current cursor position, moving the cursor to the end of the text.

    Unlike functions like `write` and `print`, this does not wrap the text - it simply copies the
    text to the current terminal line.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The text to write.

scroll(y)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L57)
:   Move all positions up (or down) by `y` pixels.

    Every pixel in the terminal will be replaced by the line `y` pixels below it. If `y` is negative, it
    will copy pixels from above instead.

    ### Parameters

    1. y `number` The number of lines to move up by. This may be a negative number.

getCursorPos()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L70)
:   Get the position of the cursor.

    ### Returns

    1. `number` The x position of the cursor.
    2. `number` The y position of the cursor.

setCursorPos(x, y)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L83)
:   Set the position of the cursor. [terminal writes](term.html#v:write) will begin from this position.

    ### Parameters

    1. x `number` The new x position of the cursor.
    2. y `number` The new y position of the cursor.

getCursorBlink()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L98)
:   Checks if the cursor is currently blinking.

    ### Returns

    1. `boolean` If the cursor is blinking.

    ### Changes

    * **New in version 1.80pr1.9**

setCursorBlink(blink)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L109)
:   Sets whether the cursor should be visible (and blinking) at the current [cursor position](term.html#v:getCursorPos).

    ### Parameters

    1. blink `boolean` Whether the cursor should blink.

getSize()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L125)
:   Get the size of the terminal.

    ### Returns

    1. `number` The terminal's width.
    2. `number` The terminal's height.

clear()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L136)
:   Clears the terminal, filling it with the [current background colour](term.html#v:getBackgroundColour).

clearLine()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L147)
:   Clears the line the cursor is currently on, filling it with the [current background
    colour](term.html#v:getBackgroundColour).

getTextColour()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L160)
:   Return the colour that new text will be written as.

    ### Returns

    1. `number` The current text colour.

    ### See also

    * **[`colors`](colors.html)** For a list of colour constants, returned by this function.

    ### Changes

    * **New in version 1.74**

getTextColor()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L160)
:   Return the colour that new text will be written as.

    ### Returns

    1. `number` The current text colour.

    ### See also

    * **[`colors`](colors.html)** For a list of colour constants, returned by this function.

    ### Changes

    * **New in version 1.74**

setTextColour(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L174)
:   Set the colour that new text will be written as.

    ### Parameters

    1. colour `number` The new text colour.

    ### See also

    * **[`colors`](colors.html)** For a list of colour constants.

    ### Changes

    * **New in version 1.45**
    * **Changed in version 1.80pr1:** Standard computers can now use all 16 colors, being changed to grayscale on screen.

setTextColor(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L174)
:   Set the colour that new text will be written as.

    ### Parameters

    1. colour `number` The new text colour.

    ### See also

    * **[`colors`](colors.html)** For a list of colour constants.

    ### Changes

    * **New in version 1.45**
    * **Changed in version 1.80pr1:** Standard computers can now use all 16 colors, being changed to grayscale on screen.

getBackgroundColour()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L192)
:   Return the current background colour. This is used when [writing text](term.html#v:write) and [clearing](term.html#v:clear)
    the terminal.

    ### Returns

    1. `number` The current background colour.

    ### See also

    * **[`colors`](colors.html)** For a list of colour constants, returned by this function.

    ### Changes

    * **New in version 1.74**

getBackgroundColor()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L192)
:   Return the current background colour. This is used when [writing text](term.html#v:write) and [clearing](term.html#v:clear)
    the terminal.

    ### Returns

    1. `number` The current background colour.

    ### See also

    * **[`colors`](colors.html)** For a list of colour constants, returned by this function.

    ### Changes

    * **New in version 1.74**

setBackgroundColour(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L207)
:   Set the current background colour. This is used when [writing text](term.html#v:write) and [clearing](term.html#v:clear) the
    terminal.

    ### Parameters

    1. colour `number` The new background colour.

    ### See also

    * **[`colors`](colors.html)** For a list of colour constants.

    ### Changes

    * **New in version 1.45**
    * **Changed in version 1.80pr1:** Standard computers can now use all 16 colors, being changed to grayscale on screen.

setBackgroundColor(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L207)
:   Set the current background colour. This is used when [writing text](term.html#v:write) and [clearing](term.html#v:clear) the
    terminal.

    ### Parameters

    1. colour `number` The new background colour.

    ### See also

    * **[`colors`](colors.html)** For a list of colour constants.

    ### Changes

    * **New in version 1.45**
    * **Changed in version 1.80pr1:** Standard computers can now use all 16 colors, being changed to grayscale on screen.

isColour()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L226)
:   Determine if this terminal supports colour.

    Terminals which do not support colour will still allow writing coloured text/backgrounds, but it will be
    displayed in greyscale.

    ### Returns

    1. `boolean` Whether this terminal supports colour.

    ### Changes

    * **New in version 1.45**

isColor()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L226)
:   Determine if this terminal supports colour.

    Terminals which do not support colour will still allow writing coloured text/backgrounds, but it will be
    displayed in greyscale.

    ### Returns

    1. `boolean` Whether this terminal supports colour.

    ### Changes

    * **New in version 1.45**

blit(text, textColour, backgroundColour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L253)
:   Writes `text` to the terminal with the specific foreground and background colours.

    As with [`write`](term.html#v:write), the text will be written at the current cursor location, with the cursor
    moving to the end of the text.

    `textColour` and `backgroundColour` must both be strings the same length as `text`. All
    characters represent a single hexadecimal digit, which is converted to one of CC's colours. For instance,
    `"a"` corresponds to purple.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The text to write.
    2. textColour [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The corresponding text colours.
    3. backgroundColour [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The corresponding background colours.

    ### Throws

    * If the three inputs are not the same length.

    ### Usage

    * Prints "Hello, world!" in rainbow text.

      ```
      term.blit("Hello, world!","01234456789ab","0000000000000")
      ```

    ### See also

    * **[`colors`](colors.html)** For a list of colour constants, and their hexadecimal values.

    ### Changes

    * **New in version 1.74**
    * **Changed in version 1.80pr1:** Standard computers can now use all 16 colors, being changed to grayscale on screen.

setPaletteColour(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L299)
:   Set the palette for a specific colour.

    ComputerCraft's palette system allows you to change how a specific colour should be displayed. For instance, you
    can make [`colors.red`](colors.html#v:red) *more red* by setting its palette to #FF0000. This does now allow you to draw more
    colours - you are still limited to 16 on the screen at one time - but you can change *which* colours are
    used.

    ### Parameters

    1. index `number` The colour whose palette should be changed.
    2. colour `number` A 24-bit integer representing the RGB value of the colour. For instance the integer
       `0xFF0000` corresponds to the colour #FF0000.

    #### Or

    1. index `number` The colour whose palette should be changed.
    2. r `number` The intensity of the red channel, between 0 and 1.
    3. g `number` The intensity of the green channel, between 0 and 1.
    4. b `number` The intensity of the blue channel, between 0 and 1.

    ### Usage

    * Change the [red colour](colors.html#v:red) from the default #CC4C4C to #FF0000.

      ```
      term.setPaletteColour(colors.red, 0xFF0000)
      term.setTextColour(colors.red)
      print("Hello, world!")
      ```
    * As above, but specifying each colour channel separately.

      ```
      term.setPaletteColour(colors.red, 1, 0, 0)
      term.setTextColour(colors.red)
      print("Hello, world!")
      ```

    ### See also

    * **[`colors.unpackRGB`](colors.html#v:unpackRGB)** To convert from the 24-bit format to three separate channels.
    * **[`colors.packRGB`](colors.html#v:packRGB)** To convert from three separate channels to the 24-bit format.

    ### Changes

    * **New in version 1.80pr1**

setPaletteColor(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L299)
:   Set the palette for a specific colour.

    ComputerCraft's palette system allows you to change how a specific colour should be displayed. For instance, you
    can make [`colors.red`](colors.html#v:red) *more red* by setting its palette to #FF0000. This does now allow you to draw more
    colours - you are still limited to 16 on the screen at one time - but you can change *which* colours are
    used.

    ### Parameters

    1. index `number` The colour whose palette should be changed.
    2. colour `number` A 24-bit integer representing the RGB value of the colour. For instance the integer
       `0xFF0000` corresponds to the colour #FF0000.

    #### Or

    1. index `number` The colour whose palette should be changed.
    2. r `number` The intensity of the red channel, between 0 and 1.
    3. g `number` The intensity of the green channel, between 0 and 1.
    4. b `number` The intensity of the blue channel, between 0 and 1.

    ### Usage

    * Change the [red colour](colors.html#v:red) from the default #CC4C4C to #FF0000.

      ```
      term.setPaletteColour(colors.red, 0xFF0000)
      term.setTextColour(colors.red)
      print("Hello, world!")
      ```
    * As above, but specifying each colour channel separately.

      ```
      term.setPaletteColour(colors.red, 1, 0, 0)
      term.setTextColour(colors.red)
      print("Hello, world!")
      ```

    ### See also

    * **[`colors.unpackRGB`](colors.html#v:unpackRGB)** To convert from the 24-bit format to three separate channels.
    * **[`colors.packRGB`](colors.html#v:packRGB)** To convert from three separate channels to the 24-bit format.

    ### Changes

    * **New in version 1.80pr1**

getPaletteColour(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L325)
:   Get the current palette for a specific colour.

    ### Parameters

    1. colour `number` The colour whose palette should be fetched.

    ### Returns

    1. `number` The red channel, will be between 0 and 1.
    2. `number` The green channel, will be between 0 and 1.
    3. `number` The blue channel, will be between 0 and 1.

    ### Changes

    * **New in version 1.80pr1**

getPaletteColor(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L325)
:   Get the current palette for a specific colour.

    ### Parameters

    1. colour `number` The colour whose palette should be fetched.

    ### Returns

    1. `number` The red channel, will be between 0 and 1.
    2. `number` The green channel, will be between 0 and 1.
    3. `number` The blue channel, will be between 0 and 1.

    ### Changes

    * **New in version 1.80pr1**

redirect(target)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/term.lua#L40)
:   Redirects terminal output to a monitor, a [`window`](window.html), or any other custom
    terminal object. Once the redirect is performed, any calls to a "term"
    function - or to a function that makes use of a term function, as [`print`](https://www.lua.org/manual/5.1/manual.html#pdf-print) -
    will instead operate with the new terminal object.

    A "terminal object" is simply a table that contains functions with the same
    names - and general features - as those found in the term table. For example,
    a wrapped monitor is suitable.

    The redirect can be undone by pointing back to the previous terminal object
    (which this function returns whenever you switch).

    ### Parameters

    1. target [`Redirect`](term.html#ty:Redirect) The terminal redirect the [`term`](term.html) API will draw to.

    ### Returns

    1. [`Redirect`](term.html#ty:Redirect) The previous redirect object, as returned by
       [`term.current`](term.html#v:current).

    ### Usage

    * Redirect to a monitor on the right of the computer.

      ```
      term.redirect(peripheral.wrap("right"))
      ```

    ### Changes

    * **New in version 1.31**

current()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/term.lua#L67)
:   Returns the current terminal object of the computer.

    ### Returns

    1. [`Redirect`](term.html#ty:Redirect) The current terminal redirect

    ### Usage

    * Create a new [`window`](window.html) which draws to the current redirect target.

      ```
      window.create(term.current(), 1, 1, 10, 10)
      ```

    ### Changes

    * **New in version 1.6**

native()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/term.lua#L79)
:   Get the native terminal object of the current computer.

    It is recommended you do not use this function unless you absolutely have
    to. In a multitasked environment, [`term.native`](term.html#v:native) will *not* be the current
    terminal object, and so drawing may interfere with other programs.

    ### Returns

    1. [`Redirect`](term.html#ty:Redirect) The native terminal redirect.

    ### Changes

    * **New in version 1.6**

### Types

### Redirect

A base class for all objects which interact with a terminal. Namely the [`term`](term.html) and monitors.

Redirect.write(text)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L38)
:   Write `text` at the current cursor position, moving the cursor to the end of the text.

    Unlike functions like `write` and `print`, this does not wrap the text - it simply copies the
    text to the current terminal line.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The text to write.

Redirect.scroll(y)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L57)
:   Move all positions up (or down) by `y` pixels.

    Every pixel in the terminal will be replaced by the line `y` pixels below it. If `y` is negative, it
    will copy pixels from above instead.

    ### Parameters

    1. y `number` The number of lines to move up by. This may be a negative number.

Redirect.getCursorPos()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L70)
:   Get the position of the cursor.

    ### Returns

    1. `number` The x position of the cursor.
    2. `number` The y position of the cursor.

Redirect.setCursorPos(x, y)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L83)
:   Set the position of the cursor. [terminal writes](term.html#v:write) will begin from this position.

    ### Parameters

    1. x `number` The new x position of the cursor.
    2. y `number` The new y position of the cursor.

Redirect.getCursorBlink()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L98)
:   Checks if the cursor is currently blinking.

    ### Returns

    1. `boolean` If the cursor is blinking.

    ### Changes

    * **New in version 1.80pr1.9**

Redirect.setCursorBlink(blink)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L109)
:   Sets whether the cursor should be visible (and blinking) at the current [cursor position](term.html#v:getCursorPos).

    ### Parameters

    1. blink `boolean` Whether the cursor should blink.

Redirect.getSize()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L125)
:   Get the size of the terminal.

    ### Returns

    1. `number` The terminal's width.
    2. `number` The terminal's height.

Redirect.clear()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L136)
:   Clears the terminal, filling it with the [current background colour](term.html#v:getBackgroundColour).

Redirect.clearLine()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L147)
:   Clears the line the cursor is currently on, filling it with the [current background
    colour](term.html#v:getBackgroundColour).

Redirect.getTextColour()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L160)
:   Return the colour that new text will be written as.

    ### Returns

    1. `number` The current text colour.

    ### See also

    * **[`colors`](colors.html)** For a list of colour constants, returned by this function.

    ### Changes

    * **New in version 1.74**

Redirect.getTextColor()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L160)
:   Return the colour that new text will be written as.

    ### Returns

    1. `number` The current text colour.

    ### See also

    * **[`colors`](colors.html)** For a list of colour constants, returned by this function.

    ### Changes

    * **New in version 1.74**

Redirect.setTextColour(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L174)
:   Set the colour that new text will be written as.

    ### Parameters

    1. colour `number` The new text colour.

    ### See also

    * **[`colors`](colors.html)** For a list of colour constants.

    ### Changes

    * **New in version 1.45**
    * **Changed in version 1.80pr1:** Standard computers can now use all 16 colors, being changed to grayscale on screen.

Redirect.setTextColor(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L174)
:   Set the colour that new text will be written as.

    ### Parameters

    1. colour `number` The new text colour.

    ### See also

    * **[`colors`](colors.html)** For a list of colour constants.

    ### Changes

    * **New in version 1.45**
    * **Changed in version 1.80pr1:** Standard computers can now use all 16 colors, being changed to grayscale on screen.

Redirect.getBackgroundColour()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L192)
:   Return the current background colour. This is used when [writing text](term.html#v:write) and [clearing](term.html#v:clear)
    the terminal.

    ### Returns

    1. `number` The current background colour.

    ### See also

    * **[`colors`](colors.html)** For a list of colour constants, returned by this function.

    ### Changes

    * **New in version 1.74**

Redirect.getBackgroundColor()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L192)
:   Return the current background colour. This is used when [writing text](term.html#v:write) and [clearing](term.html#v:clear)
    the terminal.

    ### Returns

    1. `number` The current background colour.

    ### See also

    * **[`colors`](colors.html)** For a list of colour constants, returned by this function.

    ### Changes

    * **New in version 1.74**

Redirect.setBackgroundColour(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L207)
:   Set the current background colour. This is used when [writing text](term.html#v:write) and [clearing](term.html#v:clear) the
    terminal.

    ### Parameters

    1. colour `number` The new background colour.

    ### See also

    * **[`colors`](colors.html)** For a list of colour constants.

    ### Changes

    * **New in version 1.45**
    * **Changed in version 1.80pr1:** Standard computers can now use all 16 colors, being changed to grayscale on screen.

Redirect.setBackgroundColor(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L207)
:   Set the current background colour. This is used when [writing text](term.html#v:write) and [clearing](term.html#v:clear) the
    terminal.

    ### Parameters

    1. colour `number` The new background colour.

    ### See also

    * **[`colors`](colors.html)** For a list of colour constants.

    ### Changes

    * **New in version 1.45**
    * **Changed in version 1.80pr1:** Standard computers can now use all 16 colors, being changed to grayscale on screen.

Redirect.isColour()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L226)
:   Determine if this terminal supports colour.

    Terminals which do not support colour will still allow writing coloured text/backgrounds, but it will be
    displayed in greyscale.

    ### Returns

    1. `boolean` Whether this terminal supports colour.

    ### Changes

    * **New in version 1.45**

Redirect.isColor()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L226)
:   Determine if this terminal supports colour.

    Terminals which do not support colour will still allow writing coloured text/backgrounds, but it will be
    displayed in greyscale.

    ### Returns

    1. `boolean` Whether this terminal supports colour.

    ### Changes

    * **New in version 1.45**

Redirect.blit(text, textColour, backgroundColour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L253)
:   Writes `text` to the terminal with the specific foreground and background colours.

    As with [`write`](term.html#v:write), the text will be written at the current cursor location, with the cursor
    moving to the end of the text.

    `textColour` and `backgroundColour` must both be strings the same length as `text`. All
    characters represent a single hexadecimal digit, which is converted to one of CC's colours. For instance,
    `"a"` corresponds to purple.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The text to write.
    2. textColour [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The corresponding text colours.
    3. backgroundColour [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The corresponding background colours.

    ### Throws

    * If the three inputs are not the same length.

    ### Usage

    * Prints "Hello, world!" in rainbow text.

      ```
      term.blit("Hello, world!","01234456789ab","0000000000000")
      ```

    ### See also

    * **[`colors`](colors.html)** For a list of colour constants, and their hexadecimal values.

    ### Changes

    * **New in version 1.74**
    * **Changed in version 1.80pr1:** Standard computers can now use all 16 colors, being changed to grayscale on screen.

Redirect.setPaletteColour(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L299)
:   Set the palette for a specific colour.

    ComputerCraft's palette system allows you to change how a specific colour should be displayed. For instance, you
    can make [`colors.red`](colors.html#v:red) *more red* by setting its palette to #FF0000. This does now allow you to draw more
    colours - you are still limited to 16 on the screen at one time - but you can change *which* colours are
    used.

    ### Parameters

    1. index `number` The colour whose palette should be changed.
    2. colour `number` A 24-bit integer representing the RGB value of the colour. For instance the integer
       `0xFF0000` corresponds to the colour #FF0000.

    #### Or

    1. index `number` The colour whose palette should be changed.
    2. r `number` The intensity of the red channel, between 0 and 1.
    3. g `number` The intensity of the green channel, between 0 and 1.
    4. b `number` The intensity of the blue channel, between 0 and 1.

    ### Usage

    * Change the [red colour](colors.html#v:red) from the default #CC4C4C to #FF0000.

      ```
      term.setPaletteColour(colors.red, 0xFF0000)
      term.setTextColour(colors.red)
      print("Hello, world!")
      ```
    * As above, but specifying each colour channel separately.

      ```
      term.setPaletteColour(colors.red, 1, 0, 0)
      term.setTextColour(colors.red)
      print("Hello, world!")
      ```

    ### See also

    * **[`colors.unpackRGB`](colors.html#v:unpackRGB)** To convert from the 24-bit format to three separate channels.
    * **[`colors.packRGB`](colors.html#v:packRGB)** To convert from three separate channels to the 24-bit format.

    ### Changes

    * **New in version 1.80pr1**

Redirect.setPaletteColor(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L299)
:   Set the palette for a specific colour.

    ComputerCraft's palette system allows you to change how a specific colour should be displayed. For instance, you
    can make [`colors.red`](colors.html#v:red) *more red* by setting its palette to #FF0000. This does now allow you to draw more
    colours - you are still limited to 16 on the screen at one time - but you can change *which* colours are
    used.

    ### Parameters

    1. index `number` The colour whose palette should be changed.
    2. colour `number` A 24-bit integer representing the RGB value of the colour. For instance the integer
       `0xFF0000` corresponds to the colour #FF0000.

    #### Or

    1. index `number` The colour whose palette should be changed.
    2. r `number` The intensity of the red channel, between 0 and 1.
    3. g `number` The intensity of the green channel, between 0 and 1.
    4. b `number` The intensity of the blue channel, between 0 and 1.

    ### Usage

    * Change the [red colour](colors.html#v:red) from the default #CC4C4C to #FF0000.

      ```
      term.setPaletteColour(colors.red, 0xFF0000)
      term.setTextColour(colors.red)
      print("Hello, world!")
      ```
    * As above, but specifying each colour channel separately.

      ```
      term.setPaletteColour(colors.red, 1, 0, 0)
      term.setTextColour(colors.red)
      print("Hello, world!")
      ```

    ### See also

    * **[`colors.unpackRGB`](colors.html#v:unpackRGB)** To convert from the 24-bit format to three separate channels.
    * **[`colors.packRGB`](colors.html#v:packRGB)** To convert from three separate channels to the 24-bit format.

    ### Changes

    * **New in version 1.80pr1**

Redirect.getPaletteColour(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L325)
:   Get the current palette for a specific colour.

    ### Parameters

    1. colour `number` The colour whose palette should be fetched.

    ### Returns

    1. `number` The red channel, will be between 0 and 1.
    2. `number` The green channel, will be between 0 and 1.
    3. `number` The blue channel, will be between 0 and 1.

    ### Changes

    * **New in version 1.80pr1**

Redirect.getPaletteColor(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L325)
:   Get the current palette for a specific colour.

    ### Parameters

    1. colour `number` The colour whose palette should be fetched.

    ### Returns

    1. `number` The red channel, will be between 0 and 1.
    2. `number` The green channel, will be between 0 and 1.
    3. `number` The blue channel, will be between 0 and 1.

    ### Changes

    * **New in version 1.80pr1**

---

## Source File: `module/textutils.md`

# textutils

Helpful utilities for formatting and manipulating strings.

### Changes

* **New in version 1.2**

|  |  |
| --- | --- |
| [slowWrite(text [, rate])](#v:slowWrite) | Slowly writes string text at current cursor position, character-by-character. |
| [slowPrint(sText [, nRate])](#v:slowPrint) | Slowly prints string text at current cursor position, character-by-character. |
| [formatTime(nTime [, bTwentyFourHour])](#v:formatTime) | Takes input time and formats it in a more readable format such as `6:30 PM`. |
| [pagedPrint(text [, free\_lines])](#v:pagedPrint) | Prints a given string to the display. |
| [tabulate(...)](#v:tabulate) | Prints tables in a structured form. |
| [pagedTabulate(...)](#v:pagedTabulate) | Prints tables in a structured form, stopping and prompting for input should the result not fit on the terminal. |
| [empty\_json\_array](#v:empty_json_array) | A table representing an empty JSON array, in order to distinguish it from an empty JSON object. |
| [json\_null](#v:json_null) | A table representing the JSON null value. |
| [serialize(t, opts)](#v:serialize) | Convert a Lua object into a textual representation, suitable for saving in a file or pretty-printing. |
| [serialise(t, opts)](#v:serialise) | Convert a Lua object into a textual representation, suitable for saving in a file or pretty-printing. |
| [unserialize(s)](#v:unserialize) | Converts a serialised string back into a reassembled Lua object. |
| [unserialise(s)](#v:unserialise) | Converts a serialised string back into a reassembled Lua object. |
| [serializeJSON(...)](#v:serializeJSON) | Returns a JSON representation of the given data. |
| [serialiseJSON(...)](#v:serialiseJSON) | Returns a JSON representation of the given data. |
| [unserializeJSON(s [, options])](#v:unserializeJSON) | Converts a serialised JSON string back into a reassembled Lua object. |
| [unserialiseJSON(s [, options])](#v:unserialiseJSON) | Converts a serialised JSON string back into a reassembled Lua object. |
| [urlEncode(str)](#v:urlEncode) | Replaces certain characters in a string to make it safe for use in URLs or POST data. |
| [complete(sSearchText [, tSearchTable])](#v:complete) | Provides a list of possible completions for a partial Lua expression. |

slowWrite(text [, rate])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/textutils.lua#L27)
:   Slowly writes string text at current cursor position,
    character-by-character.

    Like [`_G.write`](_G.html#v:write), this does not insert a newline at the end.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The the text to write to the screen
    2. rate? `number` The number of characters to write each second,
       Defaults to 20.

    ### Usage

    * ```
      textutils.slowWrite("Hello, world!")
      ```
    * ```
      textutils.slowWrite("Hello, world!", 5)
      ```

    ### Changes

    * **New in version 1.3**

slowPrint(sText [, nRate])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/textutils.lua#L54)
:   Slowly prints string text at current cursor position,
    character-by-character.

    Like [`print`](https://www.lua.org/manual/5.1/manual.html#pdf-print), this inserts a newline after printing.

    ### Parameters

    1. sText [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The the text to write to the screen
    2. nRate? `number` The number of characters to write each second,
       Defaults to 20.

    ### Usage

    * ```
      textutils.slowPrint("Hello, world!")
      ```
    * ```
      textutils.slowPrint("Hello, world!", 5)
      ```

formatTime(nTime [, bTwentyFourHour])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/textutils.lua#L71)
:   Takes input time and formats it in a more readable format such as `6:30 PM`.

    ### Parameters

    1. nTime `number` The time to format, as provided by [`os.time`](os.html#v:time).
    2. bTwentyFourHour? `boolean` Whether to format this as a 24-hour
       clock (`18:30`) rather than a 12-hour one (`6:30 AM`)

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The formatted time

    ### Usage

    * Print the current in-game time as a 12-hour clock.

      ```
      textutils.formatTime(os.time())
      ```
    * Print the local time as a 24-hour clock.

      ```
      textutils.formatTime(os.time("local"), true)
      ```

pagedPrint(text [, free\_lines])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/textutils.lua#L141)
:   Prints a given string to the display.

    If the action can be completed without scrolling, it acts much the same as
    [`print`](https://www.lua.org/manual/5.1/manual.html#pdf-print); otherwise, it will throw up a "Press any key to continue" prompt at
    the bottom of the display. Each press will cause it to scroll down and write a
    single line more before prompting again, if need be.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The text to print to the screen.
    2. free\_lines? `number` The number of lines which will be
       automatically scrolled before the first prompt appears (meaning free\_lines +
       1 lines will be printed). This can be set to the cursor's y position - 2 to
       always try to fill the screen. Defaults to 0, meaning only one line is
       displayed before prompting.

    ### Returns

    1. `number` The number of lines printed.

    ### Usage

    * Generates several lines of text and then prints it, paging once the
      bottom of the terminal is reached.

      ```
      local lines = {}
      for i = 1, 30 do lines[i] = ("This is line #%d"):format(i) end
      local message = table.concat(lines, "\n")

      local width, height = term.getCursorPos()
      textutils.pagedPrint(message, height - 2)
      ```

tabulate(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/textutils.lua#L251)
:   Prints tables in a structured form.

    This accepts multiple arguments, either a table or a number. When
    encountering a table, this will be treated as a table row, with each column
    width being auto-adjusted.

    When encountering a number, this sets the text color of the subsequent rows to it.

    ### Parameters

    1. ... { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } | `number` The rows and text colors to display.

    ### Usage

    * ```
      textutils.tabulate(
        colors.orange, { "1", "2", "3" },
        colors.lightBlue, { "A", "B", "C" }
      )
      ```

    ### Changes

    * **New in version 1.3**

pagedTabulate(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/textutils.lua#L273)
:   Prints tables in a structured form, stopping and prompting for input should
    the result not fit on the terminal.

    This functions identically to [`textutils.tabulate`](textutils.html#v:tabulate), but will prompt for user
    input should the whole output not fit on the display.

    ### Parameters

    1. ... { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } | `number` The rows and text colors to display.

    ### Usage

    * Generates a long table, tabulates it, and prints it to the screen.

      ```
      local rows = {}
      for i = 1, 30 do rows[i] = {("Row #%d"):format(i), math.random(1, 400)} end

      textutils.pagedTabulate(colors.orange, {"Column", "Value"}, colors.lightBlue, table.unpack(rows))
      ```

    ### See also

    * **[`textutils.tabulate`](textutils.html#v:tabulate)**
    * **[`textutils.pagedPrint`](textutils.html#v:pagedPrint)**

    ### Changes

    * **New in version 1.3**

empty\_json\_array[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/textutils.lua#L398)
:   A table representing an empty JSON array, in order to distinguish it from an
    empty JSON object.

    The contents of this table should not be modified.

    ### Usage

    * ```
      textutils.serialiseJSON(textutils.empty_json_array)
      ```

    ### See also

    * **[`textutils.serialiseJSON`](textutils.html#v:serialiseJSON)**
    * **[`textutils.unserialiseJSON`](textutils.html#v:unserialiseJSON)**

json\_null[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/textutils.lua#L407)
:   A table representing the JSON null value.

    The contents of this table should not be modified.

    ### Usage

    * ```
      textutils.serialiseJSON(textutils.json_null)
      ```

    ### See also

    * **[`textutils.serialiseJSON`](textutils.html#v:serialiseJSON)**
    * **[`textutils.unserialiseJSON`](textutils.html#v:unserialiseJSON)**

serialize(t, opts)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/textutils.lua#L813)
:   Convert a Lua object into a textual representation, suitable for
    saving in a file or pretty-printing.

    ### Parameters

    1. t The object to serialise
    2. opts { compact? = `boolean`, allow\_repetitions? = `boolean` }

       Options for serialisation.

       * `compact`: Do not emit indentation and other whitespace between terms.
       * `allow_repetitions`: Relax the check for recursive tables, allowing them to appear multiple
         times (as long as tables do not appear inside themselves).

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The serialised representation

    ### Throws

    * If the object contains a value which cannot be
      serialised. This includes functions and tables which appear multiple
      times.

    ### Usage

    * Serialise a basic table.

      ```
      textutils.serialise({ 1, 2, 3, a = 1, ["another key"] = { true } })
      ```
    * Demonstrates some of the other options

      ```
      local tbl = { 1, 2, 3 }
      print(textutils.serialise({ tbl, tbl }, { allow_repetitions = true }))

      print(textutils.serialise(tbl, { compact = true }))
      ```

    ### See also

    * **[`cc.pretty.pretty_print`](../library/cc.pretty.html#v:pretty_print)** An alternative way to display a table, often more
      suitable for pretty printing.

    ### Changes

    * **New in version 1.3**
    * **Changed in version 1.97.0:** Added `opts` argument.

serialise(t, opts)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/textutils.lua#L813)
:   Convert a Lua object into a textual representation, suitable for
    saving in a file or pretty-printing.

    ### Parameters

    1. t The object to serialise
    2. opts { compact? = `boolean`, allow\_repetitions? = `boolean` }

       Options for serialisation.

       * `compact`: Do not emit indentation and other whitespace between terms.
       * `allow_repetitions`: Relax the check for recursive tables, allowing them to appear multiple
         times (as long as tables do not appear inside themselves).

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The serialised representation

    ### Throws

    * If the object contains a value which cannot be
      serialised. This includes functions and tables which appear multiple
      times.

    ### Usage

    * Serialise a basic table.

      ```
      textutils.serialise({ 1, 2, 3, a = 1, ["another key"] = { true } })
      ```
    * Demonstrates some of the other options

      ```
      local tbl = { 1, 2, 3 }
      print(textutils.serialise({ tbl, tbl }, { allow_repetitions = true }))

      print(textutils.serialise(tbl, { compact = true }))
      ```

    ### See also

    * **[`cc.pretty.pretty_print`](../library/cc.pretty.html#v:pretty_print)** An alternative way to display a table, often more
      suitable for pretty printing.

    ### Changes

    * **New in version 1.3**
    * **Changed in version 1.97.0:** Added `opts` argument.

unserialize(s)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/textutils.lua#L836)
:   Converts a serialised string back into a reassembled Lua object.

    This is mainly used together with [`textutils.serialise`](textutils.html#v:serialise).

    ### Parameters

    1. s [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The serialised string to deserialise.

    ### Returns

    1. The deserialised object

    #### Or

    1. nil If the object could not be deserialised.

    ### Changes

    * **New in version 1.3**

unserialise(s)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/textutils.lua#L836)
:   Converts a serialised string back into a reassembled Lua object.

    This is mainly used together with [`textutils.serialise`](textutils.html#v:serialise).

    ### Parameters

    1. s [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The serialised string to deserialise.

    ### Returns

    1. The deserialised object

    #### Or

    1. nil If the object could not be deserialised.

    ### Changes

    * **New in version 1.3**

serializeJSON(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/textutils.lua#L915)
:   Returns a JSON representation of the given data.

    This is largely intended for interacting with various functions from the
    [`commands`](commands.html) API, though may also be used in making [`http`](http.html) requests.

    Lua has a rather different data model to Javascript/JSON. As a result, some Lua
    values do not serialise cleanly into JSON.

    * Lua tables can contain arbitrary key-value pairs, but JSON only accepts arrays,
      and objects (which require a string key). When serialising a table, if it only
      has numeric keys, then it will be treated as an array. Otherwise, the table will
      be serialised to an object using the string keys. Non-string keys (such as numbers
      or tables) will be dropped.

      A consequence of this is that an empty table will always be serialised to an object,
      not an array. [`textutils.empty_json_array`](textutils.html#v:empty_json_array) may be used to express an empty array.
    * Lua strings are an a sequence of raw bytes, and do not have any specific encoding.
      However, JSON strings must be valid unicode. By default, non-ASCII characters in a
      string are serialised to their unicode code point (for instance, `"\xfe"` is
      converted to `"\u00fe"`). The `unicode_strings` option may be set to treat all input
      strings as UTF-8.
    * Lua does not distinguish between missing keys (`undefined` in JS) and ones explicitly
      set to `null`. As a result `{ x = nil }` is serialised to `{}`. [`textutils.json_null`](textutils.html#v:json_null)
      may be used to get an explicit null value (`{ x = textutils.json_null }` will serialise
      to `{"x": null}`).

    ### Parameters

    1. t The value to serialise. Like [`textutils.serialise`](textutils.html#v:serialise), this should not
       contain recursive tables or functions.
    2. options? { nbt\_style? = `boolean`, unicode\_strings? = `boolean`, allow\_repetitions? = `boolean` }

       Options for serialisation.

       * `nbt_style`: Whether to produce NBT-style JSON (non-quoted keys) instead of standard JSON.
       * `unicode_strings`: Whether to treat strings as containing UTF-8 characters instead of
         using the default 8-bit character set.
       * `allow_repetitions`: Relax the check for recursive tables, allowing them to appear multiple
         times (as long as tables do not appear inside themselves).

    #### Or

    1. t The value to serialise. Like [`textutils.serialise`](textutils.html#v:serialise), this should not
       contain recursive tables or functions.
    2. bNBTStyle `boolean` Whether to produce NBT-style JSON (non-quoted keys)
       instead of standard JSON.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The JSON representation of the input.

    ### Throws

    * If the object contains a value which cannot be serialised. This includes
      functions and tables which appear multiple times.

    ### Usage

    * Serialise a simple object

      ```
      textutils.serialiseJSON({ values = { 1, "2", true } })
      ```
    * Serialise an object to a NBT-style string

      ```
      textutils.serialiseJSON({ values = { 1, "2", true } }, { nbt_style = true })
      ```

    ### See also

    * **[`textutils.json_null`](textutils.html#v:json_null)** Use to serialise a JSON `null` value.
    * **[`textutils.empty_json_array`](textutils.html#v:empty_json_array)** Use to serialise a JSON empty array.

    ### Changes

    * **New in version 1.7**
    * **Changed in version 1.106.0:** Added `options` overload and `unicode_strings` option.
    * **Changed in version 1.109.0:** Added `allow_repetitions` option.

serialiseJSON(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/textutils.lua#L915)
:   Returns a JSON representation of the given data.

    This is largely intended for interacting with various functions from the
    [`commands`](commands.html) API, though may also be used in making [`http`](http.html) requests.

    Lua has a rather different data model to Javascript/JSON. As a result, some Lua
    values do not serialise cleanly into JSON.

    * Lua tables can contain arbitrary key-value pairs, but JSON only accepts arrays,
      and objects (which require a string key). When serialising a table, if it only
      has numeric keys, then it will be treated as an array. Otherwise, the table will
      be serialised to an object using the string keys. Non-string keys (such as numbers
      or tables) will be dropped.

      A consequence of this is that an empty table will always be serialised to an object,
      not an array. [`textutils.empty_json_array`](textutils.html#v:empty_json_array) may be used to express an empty array.
    * Lua strings are an a sequence of raw bytes, and do not have any specific encoding.
      However, JSON strings must be valid unicode. By default, non-ASCII characters in a
      string are serialised to their unicode code point (for instance, `"\xfe"` is
      converted to `"\u00fe"`). The `unicode_strings` option may be set to treat all input
      strings as UTF-8.
    * Lua does not distinguish between missing keys (`undefined` in JS) and ones explicitly
      set to `null`. As a result `{ x = nil }` is serialised to `{}`. [`textutils.json_null`](textutils.html#v:json_null)
      may be used to get an explicit null value (`{ x = textutils.json_null }` will serialise
      to `{"x": null}`).

    ### Parameters

    1. t The value to serialise. Like [`textutils.serialise`](textutils.html#v:serialise), this should not
       contain recursive tables or functions.
    2. options? { nbt\_style? = `boolean`, unicode\_strings? = `boolean`, allow\_repetitions? = `boolean` }

       Options for serialisation.

       * `nbt_style`: Whether to produce NBT-style JSON (non-quoted keys) instead of standard JSON.
       * `unicode_strings`: Whether to treat strings as containing UTF-8 characters instead of
         using the default 8-bit character set.
       * `allow_repetitions`: Relax the check for recursive tables, allowing them to appear multiple
         times (as long as tables do not appear inside themselves).

    #### Or

    1. t The value to serialise. Like [`textutils.serialise`](textutils.html#v:serialise), this should not
       contain recursive tables or functions.
    2. bNBTStyle `boolean` Whether to produce NBT-style JSON (non-quoted keys)
       instead of standard JSON.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The JSON representation of the input.

    ### Throws

    * If the object contains a value which cannot be serialised. This includes
      functions and tables which appear multiple times.

    ### Usage

    * Serialise a simple object

      ```
      textutils.serialiseJSON({ values = { 1, "2", true } })
      ```
    * Serialise an object to a NBT-style string

      ```
      textutils.serialiseJSON({ values = { 1, "2", true } }, { nbt_style = true })
      ```

    ### See also

    * **[`textutils.json_null`](textutils.html#v:json_null)** Use to serialise a JSON `null` value.
    * **[`textutils.empty_json_array`](textutils.html#v:empty_json_array)** Use to serialise a JSON empty array.

    ### Changes

    * **New in version 1.7**
    * **Changed in version 1.106.0:** Added `options` overload and `unicode_strings` option.
    * **Changed in version 1.109.0:** Added `allow_repetitions` option.

unserializeJSON(s [, options])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/textutils.lua#L540)
:   Converts a serialised JSON string back into a reassembled Lua object.

    This may be used with [`textutils.serializeJSON`](textutils.html#v:serializeJSON), or when communicating
    with command blocks or web APIs.

    If a `null` value is encountered, it is converted into `nil`. It can be converted
    into [`textutils.json_null`](textutils.html#v:json_null) with the `parse_null` option.

    If an empty array is encountered, it is converted into [`textutils.empty_json_array`](textutils.html#v:empty_json_array).
    It can be converted into a new empty table with the `parse_empty_array` option.

    ### Parameters

    1. s [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The serialised string to deserialise.
    2. options? { nbt\_style? = `boolean`, parse\_null? = `boolean`, parse\_empty\_array? = `boolean` }

       Options which control how this JSON object is parsed.

       * `nbt_style`: When true, this will accept [stringified NBT](https://minecraft.wiki/w/NBT_format) strings,
         as produced by many commands.
       * `parse_null`: When true, `null` will be parsed as [`json_null`](textutils.html#v:json_null), rather than
         `nil`.
       * `parse_empty_array`: When false, empty arrays will be parsed as a new table.
         By default (or when this value is true), they are parsed as [`empty_json_array`](textutils.html#v:empty_json_array).

    ### Returns

    1. The deserialised object

    #### Or

    1. nil If the object could not be deserialised.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) A message describing why the JSON string is invalid.

    ### Usage

    * Unserialise a basic JSON object

      ```
      textutils.unserialiseJSON('{"name": "Steve", "age": null}')
      ```
    * Unserialise a basic JSON object, returning null values as [`json_null`](textutils.html#v:json_null).

      ```
      textutils.unserialiseJSON('{"name": "Steve", "age": null}', { parse_null = true })
      ```

    ### See also

    * **[`textutils.json_null`](textutils.html#v:json_null)** Use to serialize a JSON `null` value.
    * **[`textutils.empty_json_array`](textutils.html#v:empty_json_array)** Use to serialize a JSON empty array.

    ### Changes

    * **New in version 1.87.0**
    * **Changed in version 1.100.6:** Added `parse_empty_array` option

unserialiseJSON(s [, options])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/textutils.lua#L540)
:   Converts a serialised JSON string back into a reassembled Lua object.

    This may be used with [`textutils.serializeJSON`](textutils.html#v:serializeJSON), or when communicating
    with command blocks or web APIs.

    If a `null` value is encountered, it is converted into `nil`. It can be converted
    into [`textutils.json_null`](textutils.html#v:json_null) with the `parse_null` option.

    If an empty array is encountered, it is converted into [`textutils.empty_json_array`](textutils.html#v:empty_json_array).
    It can be converted into a new empty table with the `parse_empty_array` option.

    ### Parameters

    1. s [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The serialised string to deserialise.
    2. options? { nbt\_style? = `boolean`, parse\_null? = `boolean`, parse\_empty\_array? = `boolean` }

       Options which control how this JSON object is parsed.

       * `nbt_style`: When true, this will accept [stringified NBT](https://minecraft.wiki/w/NBT_format) strings,
         as produced by many commands.
       * `parse_null`: When true, `null` will be parsed as [`json_null`](textutils.html#v:json_null), rather than
         `nil`.
       * `parse_empty_array`: When false, empty arrays will be parsed as a new table.
         By default (or when this value is true), they are parsed as [`empty_json_array`](textutils.html#v:empty_json_array).

    ### Returns

    1. The deserialised object

    #### Or

    1. nil If the object could not be deserialised.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) A message describing why the JSON string is invalid.

    ### Usage

    * Unserialise a basic JSON object

      ```
      textutils.unserialiseJSON('{"name": "Steve", "age": null}')
      ```
    * Unserialise a basic JSON object, returning null values as [`json_null`](textutils.html#v:json_null).

      ```
      textutils.unserialiseJSON('{"name": "Steve", "age": null}', { parse_null = true })
      ```

    ### See also

    * **[`textutils.json_null`](textutils.html#v:json_null)** Use to serialize a JSON `null` value.
    * **[`textutils.empty_json_array`](textutils.html#v:empty_json_array)** Use to serialize a JSON empty array.

    ### Changes

    * **New in version 1.87.0**
    * **Changed in version 1.100.6:** Added `parse_empty_array` option

urlEncode(str)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/textutils.lua#L943)
:   Replaces certain characters in a string to make it safe for use in URLs or POST data.

    ### Parameters

    1. str [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The string to encode

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The encoded string.

    ### Usage

    * ```
      print("https://example.com/?view=" .. textutils.urlEncode("some text&things"))
      ```

    ### Changes

    * **New in version 1.31**

complete(sSearchText [, tSearchTable])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/textutils.lua#L982)
:   Provides a list of possible completions for a partial Lua expression.

    If the completed element is a table, suggestions will have `.` appended to
    them. Similarly, functions have `(` appended to them.

    ### Parameters

    1. sSearchText [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The partial expression to complete, such as a
       variable name or table index.
    2. tSearchTable? [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The table to find variables in, defaulting to
       the global environment ([`_G`](_G.html)). The function also searches the "parent"
       environment via the `__index` metatable field.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } The (possibly empty) list of completions.

    ### Usage

    * ```
      textutils.complete( "pa", _ENV )
      ```

    ### See also

    * **[`shell.setCompletionFunction`](shell.html#v:setCompletionFunction)**
    * **[`_G.read`](_G.html#v:read)**

    ### Changes

    * **New in version 1.74**

---

## Source File: `module/turtle.md`

# turtle

Turtles are a robotic device, which can break and place blocks, attack mobs, and move about the world. They have
an internal inventory of 16 slots, allowing them to store blocks they have broken or would like to place.

## Movement

Turtles are capable of moving through the world. As turtles are blocks themselves, they are confined to Minecraft's
grid, moving a single block at a time.

[`turtle.forward`](turtle.html#v:forward) and [`turtle.back`](turtle.html#v:back) move the turtle in the direction it is facing, while [`turtle.up`](turtle.html#v:up) and
[`turtle.down`](turtle.html#v:down) move it up and down (as one might expect!). In order to move left or right, you first need
to turn the turtle using [`turtle.turnLeft`](turtle.html#v:turnLeft)/[`turtle.turnRight`](turtle.html#v:turnRight) and then move forward or backwards.

##### ð info

The name "turtle" comes from [Turtle graphics](https://en.wikipedia.org/wiki/Turtle_graphics "Turtle graphics"), which originated from the Logo programming language. Here you'd
move a turtle with various commands like "move 10" and "turn left", much like ComputerCraft's turtles!

Moving a turtle (though not turning it) consumes *fuel*. If a turtle does not have any [fuel](turtle.html#v:refuel), it
won't move, and the movement functions will return `false`. If your turtle isn't going anywhere, the first thing to
check is if you've fuelled your turtle.

##### Handling errors

Many turtle functions can fail in various ways. For instance, a turtle cannot move forward if there's already a
block there. Instead of erroring, functions which can fail either return `true` if they succeed, or `false` and
some error message if they fail.

Unexpected failures can often lead to strange behaviour. It's often a good idea to check the return values of these
functions, or wrap them in [`assert`](https://www.lua.org/manual/5.1/manual.html#pdf-assert) (for instance, use `assert(turtle.forward())` rather than `turtle.forward()`),
so the program doesn't misbehave.

## Turtle upgrades

While a normal turtle can move about the world and place blocks, its functionality is limited. Thankfully, turtles
can be upgraded with upgrades. Turtles have two upgrade slots, one on the left and right sides. Upgrades can be
equipped by crafting a turtle with the upgrade, or calling the [`turtle.equipLeft`](turtle.html#v:equipLeft)/[`turtle.equipRight`](turtle.html#v:equipRight) functions.

By default, any diamond tool may be used as an upgrade (though more may be added with [datapacks](https://datapacks.madefor.cc)). The diamond
pickaxe may be used to break blocks (with [`turtle.dig`](turtle.html#v:dig)), while the sword can attack entities ([`turtle.attack`](turtle.html#v:attack)).
Other tools have more niche use-cases, for instance hoes can til dirt.

Some peripherals (namely [speakers](../peripheral/speaker.html) and Ender and Wireless [modems](../peripheral/modem.html)) can also be equipped as
upgrades. These are then accessible by accessing the `"left"` or `"right"` peripheral.

## Recipes

**Turtle**

![Iron Ingot](/images/items/minecraft/iron_ingot.png "Iron Ingot")

![Iron Ingot](/images/items/minecraft/iron_ingot.png "Iron Ingot")

![Iron Ingot](/images/items/minecraft/iron_ingot.png "Iron Ingot")

![Iron Ingot](/images/items/minecraft/iron_ingot.png "Iron Ingot")

![Computer](/images/items/computercraft/computer_normal.png "Computer")

![Iron Ingot](/images/items/minecraft/iron_ingot.png "Iron Ingot")

![Iron Ingot](/images/items/minecraft/iron_ingot.png "Iron Ingot")

![Chest](/images/items/minecraft/chest.png "Chest")

![Iron Ingot](/images/items/minecraft/iron_ingot.png "Iron Ingot")

![Turtle](/images/items/computercraft/turtle_normal.png "Turtle")

**Advanced Turtle**

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Advanced Computer](/images/items/computercraft/computer_advanced.png "Advanced Computer")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Chest](/images/items/minecraft/chest.png "Chest")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Advanced Turtle](/images/items/computercraft/turtle_advanced.png "Advanced Turtle")

### Changes

* **New in version 1.3**

|  |  |
| --- | --- |
| [craft([limit=64])](#v:craft) | Craft a recipe based on the turtle's inventory. |
| [native](#v:native) | The builtin turtle API, without any generated helper functions. |
| [forward()](#v:forward) | Move the turtle forward one block. |
| [back()](#v:back) | Move the turtle backwards one block. |
| [up()](#v:up) | Move the turtle up one block. |
| [down()](#v:down) | Move the turtle down one block. |
| [turnLeft()](#v:turnLeft) | Rotate the turtle 90 degrees to the left. |
| [turnRight()](#v:turnRight) | Rotate the turtle 90 degrees to the right. |
| [dig([side])](#v:dig) | Attempt to break the block in front of the turtle. |
| [digUp([side])](#v:digUp) | Attempt to break the block above the turtle. |
| [digDown([side])](#v:digDown) | Attempt to break the block below the turtle. |
| [place([text])](#v:place) | Place a block or item into the world in front of the turtle. |
| [placeUp([text])](#v:placeUp) | Place a block or item into the world above the turtle. |
| [placeDown([text])](#v:placeDown) | Place a block or item into the world below the turtle. |
| [drop([count])](#v:drop) | Drop the currently selected stack into the inventory in front of the turtle, or as an item into the world if there is no inventory. |
| [dropUp([count])](#v:dropUp) | Drop the currently selected stack into the inventory above the turtle, or as an item into the world if there is no inventory. |
| [dropDown([count])](#v:dropDown) | Drop the currently selected stack into the inventory below the turtle, or as an item into the world if there is no inventory. |
| [select(slot)](#v:select) | Change the currently selected slot. |
| [getItemCount([slot])](#v:getItemCount) | Get the number of items in the given slot. |
| [getItemSpace([slot])](#v:getItemSpace) | Get the remaining number of items which may be stored in this stack. |
| [detect()](#v:detect) | Check if there is a solid block in front of the turtle. |
| [detectUp()](#v:detectUp) | Check if there is a solid block above the turtle. |
| [detectDown()](#v:detectDown) | Check if there is a solid block below the turtle. |
| [compare()](#v:compare) | Check if the block in front of the turtle is equal to the item in the currently selected slot. |
| [compareUp()](#v:compareUp) | Check if the block above the turtle is equal to the item in the currently selected slot. |
| [compareDown()](#v:compareDown) | Check if the block below the turtle is equal to the item in the currently selected slot. |
| [attack([side])](#v:attack) | Attack the entity in front of the turtle. |
| [attackUp([side])](#v:attackUp) | Attack the entity above the turtle. |
| [attackDown([side])](#v:attackDown) | Attack the entity below the turtle. |
| [suck([count])](#v:suck) | Suck an item from the inventory in front of the turtle, or from an item floating in the world. |
| [suckUp([count])](#v:suckUp) | Suck an item from the inventory above the turtle, or from an item floating in the world. |
| [suckDown([count])](#v:suckDown) | Suck an item from the inventory below the turtle, or from an item floating in the world. |
| [getFuelLevel()](#v:getFuelLevel) | Get the maximum amount of fuel this turtle currently holds. |
| [refuel([count])](#v:refuel) | Refuel this turtle. |
| [compareTo(slot)](#v:compareTo) | Compare the item in the currently selected slot to the item in another slot. |
| [transferTo(slot [, count])](#v:transferTo) | Move an item from the selected slot to another one. |
| [getSelectedSlot()](#v:getSelectedSlot) | Get the currently selected slot. |
| [getFuelLimit()](#v:getFuelLimit) | Get the maximum amount of fuel this turtle can hold. |
| [equipLeft()](#v:equipLeft) | Equip (or unequip) an item on the left side of this turtle. |
| [equipRight()](#v:equipRight) | Equip (or unequip) an item on the right side of this turtle. |
| [getEquippedLeft()](#v:getEquippedLeft) | Get the upgrade currently equipped on the left of the turtle. |
| [getEquippedRight()](#v:getEquippedRight) | Get the upgrade currently equipped on the right of the turtle. |
| [inspect()](#v:inspect) | Get information about the block in front of the turtle. |
| [inspectUp()](#v:inspectUp) | Get information about the block above the turtle. |
| [inspectDown()](#v:inspectDown) | Get information about the block below the turtle. |
| [getItemDetail([slot [, detailed]])](#v:getItemDetail) | Get detailed information about the items in the given slot. |

craft([limit=64])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/doc/stub/turtle.lua#L17)
:   Craft a recipe based on the turtle's inventory.
    The turtle's inventory should set up like a crafting grid. For instance, to
    craft sticks, slots 1 and 5 should contain planks. *All* other slots should be
    empty, including those outside the crafting "grid".

    ### Parameters

    1. limit? `number` = `64` The maximum number of crafting steps to run.

    ### Returns

    1. true If crafting succeeds.

    #### Or

    1. false If crafting fails.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) A string describing why crafting failed.

    ### Throws

    * When limit is less than 1 or greater than 64.

    ### Changes

    * **New in version 1.4**

native[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/turtle/turtle.lua#L15)
:   ##### ð Deprecated

    Historically this table behaved differently to the main turtle API, but this is no longer the case. You
    should not need to use it.

    The builtin turtle API, without any generated helper functions.

forward()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L100)
:   Move the turtle forward one block.

    ### Returns

    1. `boolean` Whether the turtle could successfully move.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the turtle could not move.

back()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L112)
:   Move the turtle backwards one block.

    ### Returns

    1. `boolean` Whether the turtle could successfully move.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the turtle could not move.

up()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L124)
:   Move the turtle up one block.

    ### Returns

    1. `boolean` Whether the turtle could successfully move.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the turtle could not move.

down()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L136)
:   Move the turtle down one block.

    ### Returns

    1. `boolean` Whether the turtle could successfully move.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the turtle could not move.

turnLeft()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L148)
:   Rotate the turtle 90 degrees to the left.

    ### Returns

    1. `boolean` Whether the turtle could successfully turn.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the turtle could not turn.

turnRight()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L160)
:   Rotate the turtle 90 degrees to the right.

    ### Returns

    1. `boolean` Whether the turtle could successfully turn.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the turtle could not turn.

dig([side])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L178)
:   Attempt to break the block in front of the turtle.

    This requires a turtle tool capable of breaking the block. Diamond pickaxes
    (mining turtles) can break any vanilla block, but other tools (such as axes)
    are more limited.

    ### Parameters

    1. side? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The specific tool to use. Should be "left" or "right".

    ### Returns

    1. `boolean` Whether a block was broken.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason no block was broken.

    ### Changes

    * **Changed in version 1.6:** Added optional side argument.

digUp([side])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L193)
:   Attempt to break the block above the turtle. See [`dig`](turtle.html#v:dig) for full details.

    ### Parameters

    1. side? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The specific tool to use.

    ### Returns

    1. `boolean` Whether a block was broken.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason no block was broken.

    ### Changes

    * **Changed in version 1.6:** Added optional side argument.

digDown([side])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L208)
:   Attempt to break the block below the turtle. See [`dig`](turtle.html#v:dig) for full details.

    ### Parameters

    1. side? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The specific tool to use.

    ### Returns

    1. `boolean` Whether a block was broken.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason no block was broken.

    ### Changes

    * **Changed in version 1.6:** Added optional side argument.

place([text])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L228)
:   Place a block or item into the world in front of the turtle.

    "Placing" an item allows it to interact with blocks and entities in front of the turtle. For instance, buckets
    can pick up and place down fluids, and wheat can be used to breed cows. However, you cannot use [`place`](turtle.html#v:place) to
    perform arbitrary block interactions, such as clicking buttons or flipping levers.

    ### Parameters

    1. text? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) When placing a sign, set its contents to this text.

    ### Returns

    1. `boolean` Whether the block could be placed.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the block was not placed.

    ### Changes

    * **New in version 1.4**

placeUp([text])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L244)
:   Place a block or item into the world above the turtle.

    ### Parameters

    1. text? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) When placing a sign, set its contents to this text.

    ### Returns

    1. `boolean` Whether the block could be placed.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the block was not placed.

    ### See also

    * **[`place`](turtle.html#v:place)** For more information about placing items.

    ### Changes

    * **New in version 1.4**

placeDown([text])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L260)
:   Place a block or item into the world below the turtle.

    ### Parameters

    1. text? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) When placing a sign, set its contents to this text.

    ### Returns

    1. `boolean` Whether the block could be placed.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the block was not placed.

    ### See also

    * **[`place`](turtle.html#v:place)** For more information about placing items.

    ### Changes

    * **New in version 1.4**

drop([count])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L277)
:   Drop the currently selected stack into the inventory in front of the turtle, or as an item into the world if
    there is no inventory.

    ### Parameters

    1. count? `number` The number of items to drop. If not given, the entire stack will be dropped.

    ### Returns

    1. `boolean` Whether items were dropped.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the no items were dropped.

    ### Throws

    * If dropping an invalid number of items.

    ### See also

    * **[`select`](turtle.html#v:select)**

    ### Changes

    * **New in version 1.31**

dropUp([count])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L294)
:   Drop the currently selected stack into the inventory above the turtle, or as an item into the world if there is
    no inventory.

    ### Parameters

    1. count? `number` The number of items to drop. If not given, the entire stack will be dropped.

    ### Returns

    1. `boolean` Whether items were dropped.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the no items were dropped.

    ### Throws

    * If dropping an invalid number of items.

    ### See also

    * **[`select`](turtle.html#v:select)**

    ### Changes

    * **New in version 1.4**

dropDown([count])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L311)
:   Drop the currently selected stack into the inventory below the turtle, or as an item into the world if
    there is no inventory.

    ### Parameters

    1. count? `number` The number of items to drop. If not given, the entire stack will be dropped.

    ### Returns

    1. `boolean` Whether items were dropped.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the no items were dropped.

    ### Throws

    * If dropping an invalid number of items.

    ### See also

    * **[`select`](turtle.html#v:select)**

    ### Changes

    * **New in version 1.4**

select(slot)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L328)
:   Change the currently selected slot.

    The selected slot is determines what slot actions like [`drop`](turtle.html#v:drop) or [`getItemCount`](turtle.html#v:getItemCount) act on.

    ### Parameters

    1. slot `number` The slot to select.

    ### Returns

    1. true When the slot has been selected.

    ### Throws

    * If the slot is out of range.

    ### See also

    * **[`getSelectedSlot`](turtle.html#v:getSelectedSlot)**

getItemCount([slot])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L344)
:   Get the number of items in the given slot.

    ### Parameters

    1. slot? `number` The slot we wish to check. Defaults to the [selected slot](turtle.html#v:select).

    ### Returns

    1. `number` The number of items in this slot.

    ### Throws

    * If the slot is out of range.

getItemSpace([slot])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L359)
:   Get the remaining number of items which may be stored in this stack.

    For instance, if a slot contains 13 blocks of dirt, it has room for another 51.

    ### Parameters

    1. slot? `number` The slot we wish to check. Defaults to the [selected slot](turtle.html#v:select).

    ### Returns

    1. `number` The space left in this slot.

    ### Throws

    * If the slot is out of range.

detect()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L373)
:   Check if there is a solid block in front of the turtle. In this case, solid refers to any non-air or liquid
    block.

    ### Returns

    1. `boolean` If there is a solid block in front.

detectUp()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L384)
:   Check if there is a solid block above the turtle. In this case, solid refers to any non-air or liquid block.

    ### Returns

    1. `boolean` If there is a solid block above.

detectDown()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L395)
:   Check if there is a solid block below the turtle. In this case, solid refers to any non-air or liquid block.

    ### Returns

    1. `boolean` If there is a solid block below.

compare()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L407)
:   Check if the block in front of the turtle is equal to the item in the currently selected slot.

    ### Returns

    1. `boolean` If the block and item are equal.

    ### Changes

    * **New in version 1.31**

compareUp()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L419)
:   Check if the block above the turtle is equal to the item in the currently selected slot.

    ### Returns

    1. `boolean` If the block and item are equal.

    ### Changes

    * **New in version 1.31**

compareDown()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L431)
:   Check if the block below the turtle is equal to the item in the currently selected slot.

    ### Returns

    1. `boolean` If the block and item are equal.

    ### Changes

    * **New in version 1.31**

attack([side])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L446)
:   Attack the entity in front of the turtle.

    ### Parameters

    1. side? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The specific tool to use.

    ### Returns

    1. `boolean` Whether an entity was attacked.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason nothing was attacked.

    ### Changes

    * **New in version 1.4**
    * **Changed in version 1.6:** Added optional side argument.

attackUp([side])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L461)
:   Attack the entity above the turtle.

    ### Parameters

    1. side? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The specific tool to use.

    ### Returns

    1. `boolean` Whether an entity was attacked.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason nothing was attacked.

    ### Changes

    * **New in version 1.4**
    * **Changed in version 1.6:** Added optional side argument.

attackDown([side])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L476)
:   Attack the entity below the turtle.

    ### Parameters

    1. side? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The specific tool to use.

    ### Returns

    1. `boolean` Whether an entity was attacked.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason nothing was attacked.

    ### Changes

    * **New in version 1.4**
    * **Changed in version 1.6:** Added optional side argument.

suck([count])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L494)
:   Suck an item from the inventory in front of the turtle, or from an item floating in the world.

    This will pull items into the first acceptable slot, starting at the [currently selected](turtle.html#v:select) one.

    ### Parameters

    1. count? `number` The number of items to suck. If not given, up to a stack of items will be picked up.

    ### Returns

    1. `boolean` Whether items were picked up.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the no items were picked up.

    ### Throws

    * If given an invalid number of items.

    ### Changes

    * **New in version 1.4**
    * **Changed in version 1.6:** Added an optional limit argument.

suckUp([count])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L510)
:   Suck an item from the inventory above the turtle, or from an item floating in the world.

    ### Parameters

    1. count? `number` The number of items to suck. If not given, up to a stack of items will be picked up.

    ### Returns

    1. `boolean` Whether items were picked up.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the no items were picked up.

    ### Throws

    * If given an invalid number of items.

    ### Changes

    * **New in version 1.4**
    * **Changed in version 1.6:** Added an optional limit argument.

suckDown([count])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L526)
:   Suck an item from the inventory below the turtle, or from an item floating in the world.

    ### Parameters

    1. count? `number` The number of items to suck. If not given, up to a stack of items will be picked up.

    ### Returns

    1. `boolean` Whether items were picked up.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the no items were picked up.

    ### Throws

    * If given an invalid number of items.

    ### Changes

    * **New in version 1.4**
    * **Changed in version 1.6:** Added an optional limit argument.

getFuelLevel()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L541)
:   Get the maximum amount of fuel this turtle currently holds.

    ### Returns

    1. `number` The current amount of fuel a turtle this turtle has.

    #### Or

    1. "unlimited" If turtles do not consume fuel when moving.

    ### See also

    * **[`getFuelLimit`](turtle.html#v:getFuelLimit)**
    * **[`refuel`](turtle.html#v:refuel)**

    ### Changes

    * **New in version 1.4**

refuel([count])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L583)
:   Refuel this turtle.

    While most actions a turtle can perform (such as digging or placing blocks) are free, moving consumes fuel from
    the turtle's internal buffer. If a turtle has no fuel, it will not move.

    [`refuel`](turtle.html#v:refuel) refuels the turtle, consuming fuel items (such as coal or lava buckets) from the currently
    selected slot and converting them into energy. This finishes once the turtle is fully refuelled or all items have
    been consumed.

    ### Parameters

    1. count? `number` The maximum number of items to consume. One can pass `0` to check if an item is combustable or not.

    ### Returns

    1. true If the turtle was refuelled.

    #### Or

    1. false If the turtle was not refuelled.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The reason the turtle was not refuelled.

    ### Throws

    * If the refuel count is out of range.

    ### Usage

    * Refuel a turtle from the currently selected slot.

      ```
      local level = turtle.getFuelLevel()
      if level == "unlimited" then error("Turtle does not need fuel", 0) end

      local ok, err = turtle.refuel()
      if ok then
        local new_level = turtle.getFuelLevel()
        print(("Refuelled %d, current level is %d"):format(new_level - level, new_level))
      else
        printError(err)
      end
      ```
    * Check if the current item is a valid fuel source.

      ```
      local is_fuel, reason = turtle.refuel(0)
      if not is_fuel then printError(reason) end
      ```

    ### See also

    * **[`getFuelLevel`](turtle.html#v:getFuelLevel)**
    * **[`getFuelLimit`](turtle.html#v:getFuelLimit)**

    ### Changes

    * **New in version 1.4**

compareTo(slot)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L599)
:   Compare the item in the currently selected slot to the item in another slot.

    ### Parameters

    1. slot `number` The slot to compare to.

    ### Returns

    1. `boolean` If the two items are equal.

    ### Throws

    * If the slot is out of range.

    ### Changes

    * **New in version 1.4**

transferTo(slot [, count])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L615)
:   Move an item from the selected slot to another one.

    ### Parameters

    1. slot `number` The slot to move this item to.
    2. count? `number` The maximum number of items to move.

    ### Returns

    1. `boolean` If some items were successfully moved.

    ### Throws

    * If the slot is out of range.
    * If the number of items is out of range.

    ### Changes

    * **New in version 1.45**

getSelectedSlot()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L629)
:   Get the currently selected slot.

    ### Returns

    1. `number` The current slot.

    ### See also

    * **[`select`](turtle.html#v:select)**

    ### Changes

    * **New in version 1.6**

getFuelLimit()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L646)
:   Get the maximum amount of fuel this turtle can hold.

    By default, normal turtles have a limit of 20,000 and advanced turtles of 100,000.

    ### Returns

    1. `number` The maximum amount of fuel a turtle can hold.

    #### Or

    1. "unlimited" If turtles do not consume fuel when moving.

    ### See also

    * **[`getFuelLevel`](turtle.html#v:getFuelLevel)**
    * **[`refuel`](turtle.html#v:refuel)**

    ### Changes

    * **New in version 1.6**

equipLeft()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L666)
:   Equip (or unequip) an item on the left side of this turtle.

    This finds the item in the currently selected slot and attempts to equip it to the left side of the turtle. The
    previous upgrade is removed and placed into the turtle's inventory. If there is no item in the slot, the previous
    upgrade is removed, but no new one is equipped.

    ### Returns

    1. true If the item was equipped.

    #### Or

    1. false If we could not equip the item.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The reason equipping this item failed.

    ### See also

    * **[`equipRight`](turtle.html#v:equipRight)**
    * **[`getEquippedLeft`](turtle.html#v:getEquippedLeft)**

    ### Changes

    * **New in version 1.6**

equipRight()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L686)
:   Equip (or unequip) an item on the right side of this turtle.

    This finds the item in the currently selected slot and attempts to equip it to the right side of the turtle. The
    previous upgrade is removed and placed into the turtle's inventory. If there is no item in the slot, the previous
    upgrade is removed, but no new one is equipped.

    ### Returns

    1. true If the item was equipped.

    #### Or

    1. false If we could not equip the item.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The reason equipping this item failed.

    ### See also

    * **[`equipLeft`](turtle.html#v:equipLeft)**
    * **[`getEquippedRight`](turtle.html#v:getEquippedRight)**

    ### Changes

    * **New in version 1.6**

getEquippedLeft()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L701)
:   Get the upgrade currently equipped on the left of the turtle.

    This returns information about the currently equipped item, in the same form as
    [`getItemDetail`](turtle.html#v:getItemDetail).

    ### Returns

    1. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) | nil Information about the currently equipped item, or `nil` if no upgrade is equipped.

    ### See also

    * **[`equipLeft`](turtle.html#v:equipLeft)**

    ### Changes

    * **New in version 1.116.0**

getEquippedRight()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L717)
:   Get the upgrade currently equipped on the right of the turtle.

    This returns information about the currently equipped item, in the same form as
    [`getItemDetail`](turtle.html#v:getItemDetail).

    ### Returns

    1. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) | nil Information about the currently equipped item, or `nil` if no upgrade is equipped.

    ### See also

    * **[`equipRight`](turtle.html#v:equipRight)**

    ### Changes

    * **New in version 1.116.0**

inspect()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L744)
:   Get information about the block in front of the turtle.

    ### Returns

    1. `boolean` Whether there is a block in front of the turtle.
    2. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) | [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Information about the block in front, or a message explaining that there is no block.

    ### Usage

    * ```
      local has_block, data = turtle.inspect()
      if has_block then
        print(textutils.serialise(data))
        -- {
        --   name = "minecraft:oak_log",
        --   state = { axis = "x" },
        --   tags = { ["minecraft:logs"] = true, ... },
        -- }
      else
        print("No block in front of the turtle")
      end
      ```

    ### Changes

    * **New in version 1.64**
    * **Changed in version 1.76:** Added block state to return value.

inspectUp()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L757)
:   Get information about the block above the turtle.

    ### Returns

    1. `boolean` Whether there is a block above the turtle.
    2. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) | [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Information about the above below, or a message explaining that there is no block.

    ### Changes

    * **New in version 1.64**

inspectDown()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L770)
:   Get information about the block below the turtle.

    ### Returns

    1. `boolean` Whether there is a block below the turtle.
    2. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) | [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Information about the block below, or a message explaining that there is no block.

    ### Changes

    * **New in version 1.64**

getItemDetail([slot [, detailed]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L798)
:   Get detailed information about the items in the given slot.

    ### Parameters

    1. slot? `number` The slot to get information about. Defaults to the [selected slot](turtle.html#v:select).
    2. detailed? `boolean` Whether to include "detailed" information. When `true` the method will contain much
       more information about the item at the cost of taking longer to run.

    ### Returns

    1. nil | [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) Information about the item in this slot, or `nil` if it is empty.

    ### Throws

    * If the slot is out of range.

    ### Usage

    * Print the current slot, assuming it contains 13 dirt.

      ```
      print(textutils.serialise(turtle.getItemDetail()))
      -- => {
      --  name = "minecraft:dirt",
      --  count = 13,
      -- }
      ```

    ### See also

    * **[`inventory.getItemDetail`](../generic_peripheral/inventory.html#v:getItemDetail)** Describes the information returned by a detailed query.

    ### Changes

    * **New in version 1.64**
    * **Changed in version 1.90.0:** Added detailed parameter.

---

## Source File: `module/vector.md`

# vector

A basic 3D vector type and some common vector operations. This may be useful
when working with coordinates in Minecraft's world (such as those from the
[`gps`](gps.html) API).

An introduction to vectors can be found on [Wikipedia](http://en.wikipedia.org/wiki/Euclidean_vector).

### Changes

* **New in version 1.31**

|  |  |
| --- | --- |
| [new(x, y, z)](#v:new) | Construct a new [`Vector`](vector.html#ty:Vector) with the given coordinates. |

new(x, y, z)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L223)
:   Construct a new [`Vector`](vector.html#ty:Vector) with the given coordinates.

    ### Parameters

    1. x `number` The X coordinate or direction of the vector.
    2. y `number` The Y coordinate or direction of the vector.
    3. z `number` The Z coordinate or direction of the vector.

    ### Returns

    1. [`Vector`](vector.html#ty:Vector) The constructed vector.

### Types

### Vector

A 3-dimensional vector, with `x`, `y`, and `z` values.

This is suitable for representing both position and directional vectors.

Vector:add(o)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L34)
:   Adds two vectors together.

    ### Parameters

    1. o [`Vector`](vector.html#ty:Vector) The second vector to add.

    ### Returns

    1. [`Vector`](vector.html#ty:Vector) The resulting vector

    ### Usage

    * ```
      v1:add(v2)
      ```
    * ```
      v1 + v2
      ```

Vector:sub(o)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L52)
:   Subtracts one vector from another.

    ### Parameters

    1. o [`Vector`](vector.html#ty:Vector) The vector to subtract.

    ### Returns

    1. [`Vector`](vector.html#ty:Vector) The resulting vector

    ### Usage

    * ```
      v1:sub(v2)
      ```
    * ```
      v1 - v2
      ```

Vector:mul(factor)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L70)
:   Multiplies a vector by a scalar value.

    ### Parameters

    1. factor `number` The scalar value to multiply with.

    ### Returns

    1. [`Vector`](vector.html#ty:Vector) A vector with value `(x * m, y * m, z * m)`.

    ### Usage

    * ```
      vector.new(1, 2, 3):mul(3)
      ```
    * ```
      vector.new(1, 2, 3) * 3
      ```

Vector:div(factor)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L88)
:   Divides a vector by a scalar value.

    ### Parameters

    1. factor `number` The scalar value to divide by.

    ### Returns

    1. [`Vector`](vector.html#ty:Vector) A vector with value `(x / m, y / m, z / m)`.

    ### Usage

    * ```
      vector.new(1, 2, 3):div(3)
      ```
    * ```
      vector.new(1, 2, 3) / 3
      ```

Vector:unm()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L104)
:   Negate a vector

    ### Returns

    1. [`Vector`](vector.html#ty:Vector) The negated vector.

    ### Usage

    * ```
      -vector.new(1, 2, 3)
      ```

Vector:dot(o)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L119)
:   Compute the dot product of two vectors

    ### Parameters

    1. o [`Vector`](vector.html#ty:Vector) The second vector to compute the dot product of.

    ### Returns

    1. `number` The dot product of `self` and `o`.

    ### Usage

    * ```
      v1:dot(v2)
      ```

Vector:cross(o)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L132)
:   Compute the cross product of two vectors

    ### Parameters

    1. o [`Vector`](vector.html#ty:Vector) The second vector to compute the cross product of.

    ### Returns

    1. [`Vector`](vector.html#ty:Vector) The cross product of `self` and `o`.

    ### Usage

    * ```
      v1:cross(v2)
      ```

Vector:length()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L146)
:   Get the length (also referred to as magnitude) of this vector.

    ### Returns

    1. `number` The length of this vector.

Vector:normalize()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L157)
:   Divide this vector by its length, producing with the same direction, but
    of length 1.

    ### Returns

    1. [`Vector`](vector.html#ty:Vector) The normalised vector

    ### Usage

    * ```
      v:normalize()
      ```

Vector:round([tolerance])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L168)
:   Construct a vector with each dimension rounded to the nearest value.

    ### Parameters

    1. tolerance? `number` The tolerance that we should round to,
       defaulting to 1. For instance, a tolerance of 0.5 will round to the
       nearest 0.5.

    ### Returns

    1. [`Vector`](vector.html#ty:Vector) The rounded vector.

Vector:tostring()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L186)
:   Convert this vector into a string, for pretty printing.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) This vector's string representation.

    ### Usage

    * ```
      v:tostring()
      ```
    * ```
      tostring(v)
      ```

Vector:equals(other)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L197)
:   Check for equality between two vectors.

    ### Parameters

    1. other [`Vector`](vector.html#ty:Vector) The second vector to compare to.

    ### Returns

    1. `boolean` Whether or not the vectors are equal.

---

## Source File: `module/window.md`

# window

A [terminal redirect](term.html#ty:Redirect) occupying a smaller area of an
existing terminal. This allows for easy definition of spaces within the display
that can be written/drawn to, then later redrawn/repositioned/etc as need
be. The API itself contains only one function, [`window.create`](window.html#v:create), which returns
the windows themselves.

Windows are considered terminal objects - as such, they have access to nearly
all the commands in the term API (plus a few extras of their own, listed within
said API) and are valid targets to redirect to.

Each window has a "parent" terminal object, which can be the computer's own
display, a monitor, another window or even other, user-defined terminal
objects. Whenever a window is rendered to, the actual screen-writing is
performed via that parent (or, if that has one too, then that parent, and so
forth). Bear in mind that the cursor of a window's parent will hence be moved
around etc when writing a given child window.

Windows retain a memory of everything rendered "through" them (hence acting as
display buffers), and if the parent's display is wiped, the window's content can
be easily redrawn later. A window may also be flagged as invisible, preventing
any changes to it from being rendered until it's flagged as visible once more.

A parent terminal object may have multiple children assigned to it, and windows
may overlap. For example, the Multishell system functions by assigning each tab
a window covering the screen, each using the starting terminal display as its
parent, and only one of which is visible at a time.

### Changes

* **New in version 1.6**

|  |  |
| --- | --- |
| [create(parent, nX, nY, nWidth, nHeight [, bStartVisible])](#v:create) | Returns a terminal object that is a space within the specified parent terminal object. |

create(parent, nX, nY, nWidth, nHeight [, bStartVisible])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L106)
:   Returns a terminal object that is a space within the specified parent
    terminal object. This can then be used (or even redirected to) in the same
    manner as eg a wrapped monitor. Refer to [the term API](term.html) for a list of
    functions available to it.

    [`term`](term.html) itself may not be passed as the parent, though [`term.native`](term.html#v:native) is
    acceptable. Generally, [`term.current`](term.html#v:current) or a wrapped monitor will be most
    suitable, though windows may even have other windows assigned as their
    parents.

    ### Parameters

    1. parent [`term.Redirect`](term.html#ty:Redirect) The parent terminal redirect to draw to.
    2. nX `number` The x coordinate this window is drawn at in the parent terminal
    3. nY `number` The y coordinate this window is drawn at in the parent terminal
    4. nWidth `number` The width of this window
    5. nHeight `number` The height of this window
    6. bStartVisible? `boolean` Whether this window is visible by
       default. Defaults to `true`.

    ### Returns

    1. [`Window`](window.html#ty:Window) The constructed window

    ### Usage

    * Create a smaller window, fill it red and write some text to it.

      ```
      local my_window = window.create(term.current(), 1, 1, 20, 5)
      my_window.setBackgroundColour(colours.red)
      my_window.setTextColour(colours.white)
      my_window.clear()
      my_window.write("Testing my window!")
      ```
    * Create a smaller window and redirect to it.

      ```
      local my_window = window.create(term.current(), 1, 1, 25, 5)
      term.redirect(my_window)
      print("Writing some long text which will wrap around and show the bounds of this window.")
      ```

    ### Changes

    * **New in version 1.6**

### Types

### Window

The window object. Refer to the [module's documentation](window.html) for
a full description.

### See also

* **[`term.Redirect`](term.html#ty:Redirect)**

Window.write(sText)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L268)
:   ### Parameters

    1. sText

Window.blit(sText, sTextColor, sBackgroundColor)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L273)
:   ### Parameters

    1. sText
    2. sTextColor
    3. sBackgroundColor

Window.clear()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L285)


Window.clearLine()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L302)


Window.getCursorPos()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L316)


Window.setCursorPos(x, y)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L320)
:   ### Parameters

    1. x
    2. y

Window.setCursorBlink(blink)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L330)
:   ### Parameters

    1. blink

Window.getCursorBlink()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L338)


Window.isColor()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L346)


Window.isColour()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L350)


Window.setTextColor(color)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L354)
:   ### Parameters

    1. color

Window.setTextColour(color)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L354)
:   ### Parameters

    1. color

Window.setPaletteColour(colour, r, g, b)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L366)
:   ### Parameters

    1. colour
    2. r
    3. g
    4. b

Window.setPaletteColor(colour, r, g, b)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L366)
:   ### Parameters

    1. colour
    2. r
    3. g
    4. b

Window.getPaletteColour(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L391)
:   ### Parameters

    1. colour

Window.getPaletteColor(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L391)
:   ### Parameters

    1. colour

Window.setBackgroundColor(color)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L399)
:   ### Parameters

    1. color

Window.setBackgroundColour(color)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L399)
:   ### Parameters

    1. color

Window.getSize()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L407)


Window.scroll(n)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L411)
:   ### Parameters

    1. n

Window.getTextColor()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L435)


Window.getTextColour()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L439)


Window.getBackgroundColor()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L443)


Window.getBackgroundColour()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L447)


Window.getLine(y)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L459)
:   Get the buffered contents of a line in this window.

    ### Parameters

    1. y `number` The y position of the line to get.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The textual content of this line.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The text colours of this line, suitable for use with [`term.blit`](term.html#v:blit).
    3. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The background colours of this line, suitable for use with [`term.blit`](term.html#v:blit).

    ### Throws

    * If `y` is not between 1 and this window's height.

    ### Changes

    * **New in version 1.84.0**

Window.setVisible(visible)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L478)
:   Set whether this window is visible. Invisible windows will not be drawn
    to the screen until they are made visible again.

    Making an invisible window visible will immediately draw it.

    ### Parameters

    1. visible `boolean` Whether this window is visible.

Window.isVisible()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L494)
:   Get whether this window is visible. Invisible windows will not be
    drawn to the screen until they are made visible again.

    ### Returns

    1. `boolean` Whether this window is visible.

    ### See also

    * **[`Window:setVisible`](window.html#ty:Window:setVisible)**

    ### Changes

    * **New in version 1.94.0**

Window.redraw()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L500)
:   Draw this window. This does nothing if the window is not visible.

    ### See also

    * **[`Window:setVisible`](window.html#ty:Window:setVisible)**

Window.restoreCursor()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L512)
:   Set the current terminal's cursor to where this window's cursor is. This
    does nothing if the window is not visible.

Window.getPosition()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L524)
:   Get the position of the top left corner of this window.

    ### Returns

    1. `number` The x position of this window.
    2. `number` The y position of this window.

Window.reposition(new\_x, new\_y [, new\_width, new\_height [, new\_parent]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/window.lua#L541)
:   Reposition or resize the given window.

    This function also accepts arguments to change the size of this window.
    It is recommended that you fire a `term_resize` event after changing a
    window's, to allow programs to adjust their sizing.

    ### Parameters

    1. new\_x `number` The new x position of this window.
    2. new\_y `number` The new y position of this window.
    3. new\_width? `number` The new width of this window.
    4. new\_height `number` The new height of this window.
    5. new\_parent? [`term.Redirect`](term.html#ty:Redirect) The new redirect object this
       window should draw to.

    ### Changes

    * **Changed in version 1.85.0:** Add `new_parent` parameter.