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