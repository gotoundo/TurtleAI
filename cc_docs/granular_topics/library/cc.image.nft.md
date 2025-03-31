# cc.image.nft

Read and draw nft ("Nitrogen Fingers Text") images.

nft ("Nitrogen Fingers Text") is a file format for drawing basic images.
Unlike the images that [`paintutils.parseImage`](../module/paintutils.html#v:parseImage) uses, nft supports coloured
text as well as simple coloured pixels.

### Usage

* Load an image from `example.nft` and draw it.

  ```
  local nft = require "cc.image.nft"
  local image = assert(nft.load("data/example.nft"))
  nft.draw(image, term.getCursorPos())
  ```

### Changes

* **New in version 1.90.0**

|  |  |
| --- | --- |
| [parse(image)](#v:parse) | Parse an nft image from a string. |
| [load(path)](#v:load) | Load an nft image from a file. |
| [draw(image, xPos, yPos [, target])](#v:draw) | Draw an nft image to the screen. |

parse(image)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/image/nft.lua#L25)
:   Parse an nft image from a string.

    ### Parameters

    1. image [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The image contents.

    ### Returns

    1. table The parsed image.

load(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/image/nft.lua#L78)
:   Load an nft image from a file.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The file to load.

    ### Returns

    1. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The parsed image.

    #### Or

    1. nil If the file does not exist or could not be loaded.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) An error message explaining why the file could not be
       loaded.

draw(image, xPos, yPos [, target])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/image/nft.lua#L95)
:   Draw an nft image to the screen.

    ### Parameters

    1. image [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) An image, as returned from [`load`](cc.image.nft.html#v:load) or [`parse`](cc.image.nft.html#v:parse).
    2. xPos `number` The x position to start drawing at.
    3. yPos `number` The y position to start drawing at.
    4. target? [`term.Redirect`](../module/term.html#ty:Redirect) The terminal redirect to draw to. Defaults to the
       current terminal.