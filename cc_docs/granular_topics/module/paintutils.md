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