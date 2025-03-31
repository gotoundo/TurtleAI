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