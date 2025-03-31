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