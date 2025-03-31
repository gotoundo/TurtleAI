# monitor

Monitors are a block which act as a terminal, displaying information on one side. This allows them to be read and
interacted with in-world without opening a GUI.

Monitors act as [terminal redirects](../module/term.html#ty:Redirect) and so expose the same methods, as well as several additional
ones, which are documented below.

If the monitor is resized (by adding new blocks to the monitor, or by calling [`setTextScale`](monitor.html#v:setTextScale)), then a
[`monitor_resize`](../event/monitor_resize.html) event will be queued.

Like computers, monitors come in both normal (no colour) and advanced (colour) varieties. Advanced monitors be right
clicked, which will trigger a [`monitor_touch`](../event/monitor_touch.html) event.

## Recipes

**Monitor**

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Glass Pane](/images/items/minecraft/glass_pane.png "Glass Pane")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Monitor](/images/items/computercraft/monitor_normal.png "Monitor")

**Advanced Monitor**

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Glass Pane](/images/items/minecraft/glass_pane.png "Glass Pane")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Advanced Monitor](/images/items/computercraft/monitor_advanced.png "Advanced Monitor")4

### Usage

* Write "Hello, world!" to an adjacent monitor:

  ```
  local monitor = peripheral.find("monitor")
  monitor.setCursorPos(1, 1)
  monitor.write("Hello, world!")
  ```

### See also

* **[`monitor_resize`](../event/monitor_resize.html)** Queued when a monitor is resized.
* **[`monitor_touch`](../event/monitor_touch.html)** Queued when an advanced monitor is clicked.

|  |  |
| --- | --- |
| [setTextScale(scale)](#v:setTextScale) | Set the scale of this monitor. |
| [getTextScale()](#v:getTextScale) | Get the monitor's current text scale. |
| [write(text)](#v:write) | Write `text` at the current cursor position, moving the cursor to the end of the text. |
| [scroll(y)](#v:scroll) | Move all positions up (or down) by `y` pixels. |
| [getCursorPos()](#v:getCursorPos) | Get the position of the cursor. |
| [setCursorPos(x, y)](#v:setCursorPos) | Set the position of the cursor. |
| [getCursorBlink()](#v:getCursorBlink) | Checks if the cursor is currently blinking. |
| [setCursorBlink(blink)](#v:setCursorBlink) | Sets whether the cursor should be visible (and blinking) at the current [cursor position](monitor.html#v:getCursorPos). |
| [getSize()](#v:getSize) | Get the size of the terminal. |
| [clear()](#v:clear) | Clears the terminal, filling it with the [current background colour](monitor.html#v:getBackgroundColour). |
| [clearLine()](#v:clearLine) | Clears the line the cursor is currently on, filling it with the [current background colour](monitor.html#v:getBackgroundColour). |
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

setTextScale(scale)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/monitor/MonitorPeripheral.java#L66)
:   Set the scale of this monitor. A larger scale will result in the monitor having a lower resolution, but display
    text much larger.

    ### Parameters

    1. scale `number` The monitor's scale. This must be a multiple of 0.5 between 0.5 and 5.

    ### Throws

    * If the scale is out of range.

    ### See also

    * **[`getTextScale`](monitor.html#v:getTextScale)**

getTextScale()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/monitor/MonitorPeripheral.java#L80)
:   Get the monitor's current text scale.

    ### Returns

    1. `number` The monitor's current scale.

    ### Throws

    * If the monitor cannot be found.

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
:   Set the position of the cursor. [terminal writes](monitor.html#v:write) will begin from this position.

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
:   Sets whether the cursor should be visible (and blinking) at the current [cursor position](monitor.html#v:getCursorPos).

    ### Parameters

    1. blink `boolean` Whether the cursor should blink.

getSize()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L125)
:   Get the size of the terminal.

    ### Returns

    1. `number` The terminal's width.
    2. `number` The terminal's height.

clear()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L136)
:   Clears the terminal, filling it with the [current background colour](monitor.html#v:getBackgroundColour).

clearLine()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L147)
:   Clears the line the cursor is currently on, filling it with the [current background
    colour](monitor.html#v:getBackgroundColour).

getTextColour()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L160)
:   Return the colour that new text will be written as.

    ### Returns

    1. `number` The current text colour.

    ### See also

    * **[`colors`](../module/colors.html)** For a list of colour constants, returned by this function.

    ### Changes

    * **New in version 1.74**

getTextColor()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L160)
:   Return the colour that new text will be written as.

    ### Returns

    1. `number` The current text colour.

    ### See also

    * **[`colors`](../module/colors.html)** For a list of colour constants, returned by this function.

    ### Changes

    * **New in version 1.74**

setTextColour(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L174)
:   Set the colour that new text will be written as.

    ### Parameters

    1. colour `number` The new text colour.

    ### See also

    * **[`colors`](../module/colors.html)** For a list of colour constants.

    ### Changes

    * **New in version 1.45**
    * **Changed in version 1.80pr1:** Standard computers can now use all 16 colors, being changed to grayscale on screen.

setTextColor(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L174)
:   Set the colour that new text will be written as.

    ### Parameters

    1. colour `number` The new text colour.

    ### See also

    * **[`colors`](../module/colors.html)** For a list of colour constants.

    ### Changes

    * **New in version 1.45**
    * **Changed in version 1.80pr1:** Standard computers can now use all 16 colors, being changed to grayscale on screen.

getBackgroundColour()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L192)
:   Return the current background colour. This is used when [writing text](monitor.html#v:write) and [clearing](monitor.html#v:clear)
    the terminal.

    ### Returns

    1. `number` The current background colour.

    ### See also

    * **[`colors`](../module/colors.html)** For a list of colour constants, returned by this function.

    ### Changes

    * **New in version 1.74**

getBackgroundColor()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L192)
:   Return the current background colour. This is used when [writing text](monitor.html#v:write) and [clearing](monitor.html#v:clear)
    the terminal.

    ### Returns

    1. `number` The current background colour.

    ### See also

    * **[`colors`](../module/colors.html)** For a list of colour constants, returned by this function.

    ### Changes

    * **New in version 1.74**

setBackgroundColour(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L207)
:   Set the current background colour. This is used when [writing text](monitor.html#v:write) and [clearing](monitor.html#v:clear) the
    terminal.

    ### Parameters

    1. colour `number` The new background colour.

    ### See also

    * **[`colors`](../module/colors.html)** For a list of colour constants.

    ### Changes

    * **New in version 1.45**
    * **Changed in version 1.80pr1:** Standard computers can now use all 16 colors, being changed to grayscale on screen.

setBackgroundColor(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L207)
:   Set the current background colour. This is used when [writing text](monitor.html#v:write) and [clearing](monitor.html#v:clear) the
    terminal.

    ### Parameters

    1. colour `number` The new background colour.

    ### See also

    * **[`colors`](../module/colors.html)** For a list of colour constants.

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

    As with [`write`](monitor.html#v:write), the text will be written at the current cursor location, with the cursor
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

    * **[`colors`](../module/colors.html)** For a list of colour constants, and their hexadecimal values.

    ### Changes

    * **New in version 1.74**
    * **Changed in version 1.80pr1:** Standard computers can now use all 16 colors, being changed to grayscale on screen.

setPaletteColour(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L299)
:   Set the palette for a specific colour.

    ComputerCraft's palette system allows you to change how a specific colour should be displayed. For instance, you
    can make [`colors.red`](../module/colors.html#v:red) *more red* by setting its palette to #FF0000. This does now allow you to draw more
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

    * Change the [red colour](../module/colors.html#v:red) from the default #CC4C4C to #FF0000.

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

    * **[`colors.unpackRGB`](../module/colors.html#v:unpackRGB)** To convert from the 24-bit format to three separate channels.
    * **[`colors.packRGB`](../module/colors.html#v:packRGB)** To convert from three separate channels to the 24-bit format.

    ### Changes

    * **New in version 1.80pr1**

setPaletteColor(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L299)
:   Set the palette for a specific colour.

    ComputerCraft's palette system allows you to change how a specific colour should be displayed. For instance, you
    can make [`colors.red`](../module/colors.html#v:red) *more red* by setting its palette to #FF0000. This does now allow you to draw more
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

    * Change the [red colour](../module/colors.html#v:red) from the default #CC4C4C to #FF0000.

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

    * **[`colors.unpackRGB`](../module/colors.html#v:unpackRGB)** To convert from the 24-bit format to three separate channels.
    * **[`colors.packRGB`](../module/colors.html#v:packRGB)** To convert from three separate channels to the 24-bit format.

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