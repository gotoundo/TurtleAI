# LIBRARY Documentation

## Source File: `library/cc.audio.dfpwm.md`

# cc.audio.dfpwm

Convert between streams of DFPWM audio data and a list of amplitudes.

DFPWM (Dynamic Filter Pulse Width Modulation) is an audio codec designed by GreaseMonkey. It's a relatively compact
format compared to raw PCM data, only using 1 bit per sample, but is simple enough to encode and decode in real time.

Typically DFPWM audio is read from [the filesystem](../module/fs.html#ty:ReadHandle) or a [a web request](../module/http.html#ty:Response) as a string,
and converted a format suitable for [`speaker.playAudio`](../peripheral/speaker.html#v:playAudio).

## Encoding and decoding files

This module exposes two key functions, [`make_decoder`](cc.audio.dfpwm.html#v:make_decoder) and [`make_encoder`](cc.audio.dfpwm.html#v:make_encoder), which construct a new decoder or encoder.
The returned encoder/decoder is itself a function, which converts between the two kinds of data.

These encoders and decoders have lots of hidden state, so you should be careful to use the same encoder or decoder for
a specific audio stream. Typically you will want to create a decoder for each stream of audio you read, and an encoder
for each one you write.

## Converting audio to DFPWM

DFPWM is not a popular file format and so standard audio processing tools may not have an option to export to it.
Instead, you can convert audio files online using [music.madefor.cc](https://music.madefor.cc/ "DFPWM audio converter for Computronics and CC: Tweaked"), the [LionRay Wav Converter](https://github.com/gamax92/LionRay/ "LionRay Wav Converter ") Java
application or [FFmpeg](https://ffmpeg.org "FFmpeg command-line audio manipulation library") 5.1 or later.

### Usage

* Reads "data/example.dfpwm" in chunks, decodes them and then doubles the speed of the audio. The resulting audio
  is then re-encoded and saved to "speedy.dfpwm". This processed audio can then be played with the `speaker` program.

  ```
  local dfpwm = require("cc.audio.dfpwm")

  local encoder = dfpwm.make_encoder()
  local decoder = dfpwm.make_decoder()

  local out = fs.open("speedy.dfpwm", "wb")
  for input in io.lines("data/example.dfpwm", 16 * 1024 * 2) do
    local decoded = decoder(input)
    local output = {}

    -- Read two samples at once and take the average.
    for i = 1, #decoded, 2 do
      local value_1, value_2 = decoded[i], decoded[i + 1]
      output[(i + 1) / 2] = (value_1 + value_2) / 2
    end

    out.write(encoder(output))

    sleep(0) -- This program takes a while to run, so we need to make sure we yield.
  end
  out.close()
  ```

### See also

* **[`Playing audio with speakers`](../guide/speaker_audio.html)** Gives a more general introduction to audio processing and the speaker.
* **[`speaker.playAudio`](../peripheral/speaker.html#v:playAudio)** To play the decoded audio data.

### Changes

* **New in version 1.100.0**

|  |  |
| --- | --- |
| [make\_encoder()](#v:make_encoder) | Create a new encoder for converting PCM audio data into DFPWM. |
| [encode(input)](#v:encode) | A convenience function for encoding a complete file of audio at once. |
| [make\_decoder()](#v:make_decoder) | Create a new decoder for converting DFPWM into PCM audio data. |
| [decode(input)](#v:decode) | A convenience function for decoding a complete file of audio at once. |

make\_encoder()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/audio/dfpwm.lua#L104)
:   Create a new encoder for converting PCM audio data into DFPWM.

    The returned encoder is itself a function. This function accepts a table of amplitude data between -128 and 127 and
    returns the encoded DFPWM data.

    ##### â  Reusing encoders

    Encoders have lots of internal state which tracks the state of the current stream. If you reuse an encoder for multiple
    streams, or use different encoders for the same stream, the resulting audio may not sound correct.

    ### Returns

    1. function(pcm: { `number`... }):[`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The encoder function

    ### See also

    * **[`encode`](cc.audio.dfpwm.html#v:encode)** A helper function for encoding an entire file of audio at once.

encode(input)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/audio/dfpwm.lua#L220)
:   A convenience function for encoding a complete file of audio at once.

    This should only be used for complete pieces of audio. If you are writing multiple chunks to the same place,
    you should use an encoder returned by [`make_encoder`](cc.audio.dfpwm.html#v:make_encoder) instead.

    ### Parameters

    1. input { `number`... } The table of amplitude data.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The encoded DFPWM data.

    ### See also

    * **[`make_encoder`](cc.audio.dfpwm.html#v:make_encoder)**

make\_decoder()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/audio/dfpwm.lua#L162)
:   Create a new decoder for converting DFPWM into PCM audio data.

    The returned decoder is itself a function. This function accepts a string and returns a table of amplitudes, each value
    between -128 and 127.

    ##### â  Reusing decoders

    Decoders have lots of internal state which tracks the state of the current stream. If you reuse an decoder for
    multiple streams, or use different decoders for the same stream, the resulting audio may not sound correct.

    ### Returns

    1. function(dfpwm: [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)):{ `number`... } The encoder function

    ### Usage

    * Reads "data/example.dfpwm" in blocks of 16KiB (the speaker can accept a maximum of 128Ã1024 samples), decodes
      them and then plays them through the speaker.

      ```
      local dfpwm = require "cc.audio.dfpwm"
      local speaker = peripheral.find("speaker")

      local decoder = dfpwm.make_decoder()
      for input in io.lines("data/example.dfpwm", 16 * 1024) do
        local decoded = decoder(input)
        while not speaker.playAudio(decoded) do
          os.pullEvent("speaker_audio_empty")
        end
      end
      ```

    ### See also

    * **[`decode`](cc.audio.dfpwm.html#v:decode)** A helper function for decoding an entire file of audio at once.

decode(input)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/audio/dfpwm.lua#L206)
:   A convenience function for decoding a complete file of audio at once.

    This should only be used for short files. For larger files, one should read the file in chunks and process it using
    [`make_decoder`](cc.audio.dfpwm.html#v:make_decoder).

    ### Parameters

    1. input [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The DFPWM data to convert.

    ### Returns

    1. { `number`... } The produced amplitude data.

    ### See also

    * **[`make_decoder`](cc.audio.dfpwm.html#v:make_decoder)**

---

## Source File: `library/cc.completion.md`

# cc.completion

A collection of helper methods for working with input completion, such
as that require by [`_G.read`](../module/_G.html#v:read).

### See also

* **[`cc.shell.completion`](cc.shell.completion.html)** For additional helpers to use with
  [`shell.setCompletionFunction`](../module/shell.html#v:setCompletionFunction).

### Changes

* **New in version 1.85.0**

|  |  |
| --- | --- |
| [choice(text, choices [, add\_space])](#v:choice) | Complete from a choice of one or more strings. |
| [peripheral(text [, add\_space])](#v:peripheral) | Complete the name of a currently attached peripheral. |
| [side(text [, add\_space])](#v:side) | Complete the side of a computer. |
| [setting(text [, add\_space])](#v:setting) | Complete a [setting](../module/settings.html). |
| [command(text [, add\_space])](#v:command) | Complete the name of a Minecraft [command](../module/commands.html). |

choice(text, choices [, add\_space])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/completion.lua#L42)
:   Complete from a choice of one or more strings.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The input string to complete.
    2. choices { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } The list of choices to complete from.
    3. add\_space? `boolean` Whether to add a space after the completed item.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of suffixes of matching strings.

    ### Usage

    * Call [`_G.read`](../module/_G.html#v:read), completing the names of various animals.

      ```
      local completion = require "cc.completion"
      local animals = { "dog", "cat", "lion", "unicorn" }
      read(nil, nil, function(text) return completion.choice(text, animals) end)
      ```

peripheral(text [, add\_space])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/completion.lua#L57)
:   Complete the name of a currently attached peripheral.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The input string to complete.
    2. add\_space? `boolean` Whether to add a space after the completed name.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of suffixes of matching peripherals.

    ### Usage

    * ```
      local completion = require "cc.completion"
      read(nil, nil, completion.peripheral)
      ```

side(text [, add\_space])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/completion.lua#L73)
:   Complete the side of a computer.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The input string to complete.
    2. add\_space? `boolean` Whether to add a space after the completed side.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of suffixes of matching sides.

    ### Usage

    * ```
      local completion = require "cc.completion"
      read(nil, nil, completion.side)
      ```

setting(text [, add\_space])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/completion.lua#L87)
:   Complete a [setting](../module/settings.html).

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The input string to complete.
    2. add\_space? `boolean` Whether to add a space after the completed settings.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of suffixes of matching settings.

    ### Usage

    * ```
      local completion = require "cc.completion"
      read(nil, nil, completion.setting)
      ```

command(text [, add\_space])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/completion.lua#L103)
:   Complete the name of a Minecraft [command](../module/commands.html).

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The input string to complete.
    2. add\_space? `boolean` Whether to add a space after the completed command.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of suffixes of matching commands.

    ### Usage

    * ```
      local completion = require "cc.completion"
      read(nil, nil, completion.command)
      ```

---

## Source File: `library/cc.expect.md`

# cc.expect

The [`cc.expect`](cc.expect.html) library provides helper functions for verifying that
function arguments are well-formed and of the correct type.

### Usage

* Define a basic function and check it has the correct arguments.

  ```
  local expect = require "cc.expect"
  local expect, field = expect.expect, expect.field

  local function add_person(name, info)
      expect(1, name, "string")
      expect(2, info, "table", "nil")

      if info then
          print("Got age=", field(info, "age", "number"))
          print("Got gender=", field(info, "gender", "string", "nil"))
      end
  end

  add_person("Anastazja") -- `info' is optional
  add_person("Kion", { age = 23 }) -- `gender' is optional
  add_person("Caoimhin", { age = 23, gender = true }) -- error!
  ```

### Changes

* **New in version 1.84.0**
* **Changed in version 1.96.0:** The module can now be called directly as a function, which wraps around `expect.expect`.

|  |  |
| --- | --- |
| [expect(index, value, ...)](#v:expect) | Expect an argument to have a specific type. |
| [field(tbl, index, ...)](#v:field) | Expect an field to have a specific type. |
| [range(num [, min=-math.huge [, max=math.huge]])](#v:range) | Expect a number to be within a specific range. |

expect(index, value, ...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/expect.lua#L67)
:   Expect an argument to have a specific type.

    ### Parameters

    1. index `number` The 1-based argument index.
    2. value The argument's value.
    3. ... [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The allowed types of the argument.

    ### Returns

    1. The given `value`.

    ### Throws

    * If the value is not one of the allowed types.

field(tbl, index, ...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/expect.lua#L95)
:   Expect an field to have a specific type.

    ### Parameters

    1. tbl [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The table to index.
    2. index [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The field name to check.
    3. ... [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The allowed types of the argument.

    ### Returns

    1. The contents of the given field.

    ### Throws

    * If the field is not one of the allowed types.

range(num [, min=-math.huge [, max=math.huge]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/expect.lua#L126)
:   Expect a number to be within a specific range.

    ### Parameters

    1. num `number` The value to check.
    2. min? `number` = `-math.huge` The minimum value.
    3. max? `number` = `math.huge` The maximum value.

    ### Returns

    1. The given `value`.

    ### Throws

    * If the value is outside of the allowed range.

    ### Changes

    * **New in version 1.96.0**

---

## Source File: `library/cc.image.nft.md`

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

---

## Source File: `library/cc.pretty.md`

# cc.pretty

A pretty printer for rendering data structures in an aesthetically
pleasing manner.

In order to display something using [`cc.pretty`](cc.pretty.html), you build up a series of
[documents](cc.pretty.html#ty:Doc). These behave a little bit like strings; you can concatenate
them together and then print them to the screen.

However, documents also allow you to control how they should be printed. There
are several functions (such as [`nest`](cc.pretty.html#v:nest) and [`group`](cc.pretty.html#v:group)) which allow you to control
the "layout" of the document. When you come to display the document, the 'best'
(most compact) layout is used.

The structure of this module is based on [A Prettier Printer](https://homepages.inf.ed.ac.uk/wadler/papers/prettier/prettier.pdf "A Prettier Printer").

### Usage

* Print a table to the terminal

  ```
  local pretty = require "cc.pretty"
  pretty.pretty_print({ 1, 2, 3 })
  ```
* Build a custom document and display it

  ```
  local pretty = require "cc.pretty"
  pretty.print(pretty.group(pretty.text("hello") .. pretty.space_line .. pretty.text("world")))
  ```

### Changes

* **New in version 1.87.0**

|  |  |
| --- | --- |
| [empty](#v:empty) | An empty document. |
| [space](#v:space) | A document with a single space in it. |
| [line](#v:line) | A line break. |
| [space\_line](#v:space_line) | A line break. |
| [text(text [, colour])](#v:text) | Create a new document from a string. |
| [concat(...)](#v:concat) | Concatenate several documents together. |
| [nest(depth, doc)](#v:nest) | Indent later lines of the given document with the given number of spaces. |
| [group(doc)](#v:group) | Builds a document which is displayed on a single line if there is enough room, or as normal if not. |
| [write(doc [, ribbon\_frac=0.6])](#v:write) | Display a document on the terminal. |
| [print(doc [, ribbon\_frac=0.6])](#v:print) | Display a document on the terminal with a trailing new line. |
| [render(doc [, width [, ribbon\_frac=0.6]])](#v:render) | Render a document, converting it into a string. |
| [pretty(obj [, options])](#v:pretty) | Pretty-print an arbitrary object, converting it into a document. |
| [pretty\_print(obj [, options [, ribbon\_frac=0.6]])](#v:pretty_print) | A shortcut for calling [`pretty`](cc.pretty.html#v:pretty) and [`print`](cc.pretty.html#v:print) together. |

empty[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L57)
:   An empty document.

space[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L60)
:   A document with a single space in it.

line[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L63)
:   A line break. When collapsed with [`group`](cc.pretty.html#v:group), this will be replaced with [`empty`](cc.pretty.html#v:empty).

space\_line[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L66)
:   A line break. When collapsed with [`group`](cc.pretty.html#v:group), this will be replaced with [`space`](cc.pretty.html#v:space).

text(text [, colour])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L87)
:   Create a new document from a string.

    If your string contains multiple lines, [`group`](cc.pretty.html#v:group) will flatten the string
    into a single line, with spaces between each line.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The string to construct a new document with.
    2. colour? `number` The colour this text should be printed with. If not given, we default to the current
       colour.

    ### Returns

    1. [`Doc`](cc.pretty.html#ty:Doc) The document with the provided text.

    ### Usage

    * Write some blue text.

      ```
      local pretty = require "cc.pretty"
      pretty.print(pretty.text("Hello!", colours.blue))
      ```

concat(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L126)
:   Concatenate several documents together. This behaves very similar to string concatenation.

    ### Parameters

    1. ... [`Doc`](cc.pretty.html#ty:Doc) | [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The documents to concatenate.

    ### Returns

    1. [`Doc`](cc.pretty.html#ty:Doc) The concatenated documents.

    ### Usage

    * ```
      local pretty = require "cc.pretty"
      local doc1, doc2 = pretty.text("doc1"), pretty.text("doc2")
      print(pretty.concat(doc1, " - ", doc2))
      print(doc1 .. " - " .. doc2) -- Also supports ..
      ```

nest(depth, doc)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L161)
:   Indent later lines of the given document with the given number of spaces.

    For instance, nesting the document

    ```
    foo
    bar
    ```

    by two spaces will produce

    ```
    foo
      bar
    ```

    ### Parameters

    1. depth `number` The number of spaces with which the document should be indented.
    2. doc [`Doc`](cc.pretty.html#ty:Doc) The document to indent.

    ### Returns

    1. [`Doc`](cc.pretty.html#ty:Doc) The nested document.

    ### Usage

    * ```
      local pretty = require "cc.pretty"
      print(pretty.nest(2, pretty.text("foo\nbar")))
      ```

group(doc)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L200)
:   Builds a document which is displayed on a single line if there is enough
    room, or as normal if not.

    ### Parameters

    1. doc [`Doc`](cc.pretty.html#ty:Doc) The document to group.

    ### Returns

    1. [`Doc`](cc.pretty.html#ty:Doc) The grouped document.

    ### Usage

    * Uses group to show things being displayed on one or multiple lines.

      ```
      local pretty = require "cc.pretty"
      local doc = pretty.group("Hello" .. pretty.space_line .. "World")
      print(pretty.render(doc, 5)) -- On multiple lines
      print(pretty.render(doc, 20)) -- Collapsed onto one.
      ```

write(doc [, ribbon\_frac=0.6])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L233)
:   Display a document on the terminal.

    ### Parameters

    1. doc [`Doc`](cc.pretty.html#ty:Doc) The document to render
    2. ribbon\_frac? `number` = `0.6` The maximum fraction of the width that we should write in.

print(doc [, ribbon\_frac=0.6])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L295)
:   Display a document on the terminal with a trailing new line.

    ### Parameters

    1. doc [`Doc`](cc.pretty.html#ty:Doc) The document to render.
    2. ribbon\_frac? `number` = `0.6` The maximum fraction of the width that we should write in.

render(doc [, width [, ribbon\_frac=0.6]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L309)
:   Render a document, converting it into a string.

    ### Parameters

    1. doc [`Doc`](cc.pretty.html#ty:Doc) The document to render.
    2. width? `number` The maximum width of this document. Note that long strings will not be wrapped to fit
       this width - it is only used for finding the best layout.
    3. ribbon\_frac? `number` = `0.6` The maximum fraction of the width that we should write in.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The rendered document as a string.

pretty(obj [, options])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L471)
:   Pretty-print an arbitrary object, converting it into a document.

    This can then be rendered with [`write`](cc.pretty.html#v:write) or [`print`](cc.pretty.html#v:print).

    ### Parameters

    1. obj The object to pretty-print.
    2. options? { function\_args = `boolean`, function\_source = `boolean` }

       Controls how various properties are displayed.

       * `function_args`: Show the arguments to a function if known (`false` by default).
       * `function_source`: Show where the function was defined, instead of
         `function: xxxxxxxx` (`false` by default).

    ### Returns

    1. [`Doc`](cc.pretty.html#ty:Doc) The object formatted as a document.

    ### Usage

    * Display a table on the screen

      ```
      local pretty = require "cc.pretty"
      pretty.print(pretty.pretty({ 1, 2, 3 }))
      ```

    ### See also

    * **[`pretty_print`](cc.pretty.html#v:pretty_print)** for a shorthand to prettify and print an object.

    ### Changes

    * **Changed in version 1.88.0:** Added `options` argument.

pretty\_print(obj [, options [, ribbon\_frac=0.6]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/pretty.lua#L501)
:   A shortcut for calling [`pretty`](cc.pretty.html#v:pretty) and [`print`](cc.pretty.html#v:print) together.

    ### Parameters

    1. obj The object to pretty-print.
    2. options? { function\_args = `boolean`, function\_source = `boolean` }

       Controls how various properties are displayed.

       * `function_args`: Show the arguments to a function if known (`false` by default).
       * `function_source`: Show where the function was defined, instead of
         `function: xxxxxxxx` (`false` by default).
    3. ribbon\_frac? `number` = `0.6` The maximum fraction of the width that we should write in.

    ### Usage

    * Display a table on the screen.

      ```
      local pretty = require "cc.pretty"
      pretty.pretty_print({ 1, 2, 3 })
      ```

    ### See also

    * **[`pretty`](cc.pretty.html#v:pretty)**
    * **[`print`](cc.pretty.html#v:print)**

    ### Changes

    * **New in version 1.99**

### Types

### Doc

A document containing formatted text, with multiple possible layouts.

Documents effectively represent a sequence of strings in alternative layouts,
which we will try to print in the most compact form necessary.

---

## Source File: `library/cc.require.md`

# cc.require

A pure Lua implementation of the builtin [`require`](https://www.lua.org/manual/5.1/manual.html#pdf-require) function and
[`package`](https://www.lua.org/manual/5.1/manual.html#5.3) library.

Generally you do not need to use this module - it is injected into the every
program's environment. However, it may be useful when building a custom shell or
when running programs yourself.

### Usage

* Construct the package and require function, and insert them into a
  custom environment.

  ```
  local r = require "cc.require"
  local env = setmetatable({}, { __index = _ENV })
  env.require, env.package = r.make(env, "/")

  -- Now we have our own require function, separate to the original.
  local r2 = env.require "cc.require"
  print(r, r2)
  ```

### See also

* **[`Reusing code with require`](../guide/using_require.html)** For an introduction on how to use [`require`](https://www.lua.org/manual/5.1/manual.html#pdf-require).

### Changes

* **New in version 1.88.0**

|  |  |
| --- | --- |
| [make(env, dir)](#v:make) | Build an implementation of Lua's [`package`](https://www.lua.org/manual/5.1/manual.html#5.3) library, and a [`require`](https://www.lua.org/manual/5.1/manual.html#pdf-require) function to load modules within it. |

make(env, dir)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/require.lua#L120)
:   Build an implementation of Lua's [`package`](https://www.lua.org/manual/5.1/manual.html#5.3) library, and a [`require`](https://www.lua.org/manual/5.1/manual.html#pdf-require)
    function to load modules within it.

    ### Parameters

    1. env [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The environment to load packages into.
    2. dir [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The directory that relative packages are loaded from.

    ### Returns

    1. `function` The new [`require`](https://www.lua.org/manual/5.1/manual.html#pdf-require) function.
    2. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The new [`package`](https://www.lua.org/manual/5.1/manual.html#5.3) library.

---

## Source File: `library/cc.shell.completion.md`

# cc.shell.completion

A collection of helper methods for working with shell completion.

Most programs may be completed using the [`build`](cc.shell.completion.html#v:build) helper method, rather than
manually switching on the argument index.

Note, the helper functions within this module do not accept an argument index,
and so are not directly usable with the [`shell.setCompletionFunction`](../module/shell.html#v:setCompletionFunction). Instead,
wrap them using [`build`](cc.shell.completion.html#v:build), or your own custom function.

### Usage

* Register a completion handler for example.lua which prompts for a
  choice of options, followed by a directory, and then multiple files.

  ```
  local completion = require "cc.shell.completion"
  local complete = completion.build(
    { completion.choice, { "get", "put" } },
    completion.dir,
    { completion.file, many = true }
  )
  shell.setCompletionFunction("example.lua", complete)
  read(nil, nil, shell.complete, "example ")
  ```

### See also

* **[`cc.completion`](cc.completion.html)** For more general helpers, suitable for use with [`_G.read`](../module/_G.html#v:read).
* **[`shell.setCompletionFunction`](../module/shell.html#v:setCompletionFunction)**

### Changes

* **New in version 1.85.0**

|  |  |
| --- | --- |
| [file(shell, text)](#v:file) | Complete the name of a file relative to the current working directory. |
| [dir(shell, text)](#v:dir) | Complete the name of a directory relative to the current working directory. |
| [dirOrFile(shell, text, previous [, add\_space])](#v:dirOrFile) | Complete the name of a file or directory relative to the current working directory. |
| [program(shell, text)](#v:program) | Complete the name of a program. |
| [programWithArgs(shell, text, previous, starting)](#v:programWithArgs) | Complete arguments of a program. |
| [help](#v:help) | Wraps [`help.completeTopic`](../module/help.html#v:completeTopic) as a [`build`](cc.shell.completion.html#v:build) compatible function. |
| [choice](#v:choice) | Wraps [`cc.completion.choice`](cc.completion.html#v:choice) as a [`build`](cc.shell.completion.html#v:build) compatible function. |
| [peripheral](#v:peripheral) | Wraps [`cc.completion.peripheral`](cc.completion.html#v:peripheral) as a [`build`](cc.shell.completion.html#v:build) compatible function. |
| [side](#v:side) | Wraps [`cc.completion.side`](cc.completion.html#v:side) as a [`build`](cc.shell.completion.html#v:build) compatible function. |
| [setting](#v:setting) | Wraps [`cc.completion.setting`](cc.completion.html#v:setting) as a [`build`](cc.shell.completion.html#v:build) compatible function. |
| [command](#v:command) | Wraps [`cc.completion.command`](cc.completion.html#v:command) as a [`build`](cc.shell.completion.html#v:build) compatible function. |
| [build(...)](#v:build) | A helper function for building shell completion arguments. |

file(shell, text)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L40)
:   Complete the name of a file relative to the current working directory.

    ### Parameters

    1. shell [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The shell we're completing in.
    2. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Current text to complete.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of suffixes of matching files.

dir(shell, text)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L53)
:   Complete the name of a directory relative to the current working directory.

    ### Parameters

    1. shell [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The shell we're completing in.
    2. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Current text to complete.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of suffixes of matching directories.

dirOrFile(shell, text, previous [, add\_space])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L69)
:   Complete the name of a file or directory relative to the current working
    directory.

    ### Parameters

    1. shell [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The shell we're completing in.
    2. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Current text to complete.
    3. previous { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } The shell arguments before this one.
    4. add\_space? `boolean` Whether to add a space after the completed item.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of suffixes of matching files and directories.

program(shell, text)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L98)
:   Complete the name of a program.

    ### Parameters

    1. shell [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The shell we're completing in.
    2. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Current text to complete.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of suffixes of matching programs.

    ### See also

    * **[`shell.completeProgram`](../module/shell.html#v:completeProgram)**

programWithArgs(shell, text, previous, starting)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L110)
:   Complete arguments of a program.

    ### Parameters

    1. shell [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The shell we're completing in.
    2. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Current text to complete.
    3. previous { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } The shell arguments before this one.
    4. starting `number` Which argument index this program and args start at.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of suffixes of matching programs or arguments.

    ### Changes

    * **New in version 1.97.0**

help[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L200)
:   Wraps [`help.completeTopic`](../module/help.html#v:completeTopic) as a [`build`](cc.shell.completion.html#v:build) compatible function.

choice[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L201)
:   Wraps [`cc.completion.choice`](cc.completion.html#v:choice) as a [`build`](cc.shell.completion.html#v:build) compatible function.

peripheral[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L202)
:   Wraps [`cc.completion.peripheral`](cc.completion.html#v:peripheral) as a [`build`](cc.shell.completion.html#v:build) compatible function.

side[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L203)
:   Wraps [`cc.completion.side`](cc.completion.html#v:side) as a [`build`](cc.shell.completion.html#v:build) compatible function.

setting[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L204)
:   Wraps [`cc.completion.setting`](cc.completion.html#v:setting) as a [`build`](cc.shell.completion.html#v:build) compatible function.

command[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L205)
:   Wraps [`cc.completion.command`](cc.completion.html#v:command) as a [`build`](cc.shell.completion.html#v:build) compatible function.

build(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/shell/completion.lua#L158)
:   A helper function for building shell completion arguments.

    This accepts a series of single-argument completion functions, and combines
    them into a function suitable for use with [`shell.setCompletionFunction`](../module/shell.html#v:setCompletionFunction).

    ### Parameters

    1. ... nil | [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) | `function`

       Every argument to [`build`](cc.shell.completion.html#v:build) represents an argument
       to the program you wish to complete. Each argument can be one of three types:

       * `nil`: This argument will not be completed.
       * A function: This argument will be completed with the given function. It is
         called with the [`shell`](../module/shell.html) object, the string to complete and the arguments
         before this one.
       * A table: This acts as a more powerful version of the function case. The table
         must have a function as the first item - this will be called with the shell,
         string and preceding arguments as above, but also followed by any additional
         items in the table. This provides a more convenient interface to pass
         options to your completion functions.

         If this table is the last argument, it may also set the `many` key to true,
         which states this function should be used to complete any remaining arguments.

---

## Source File: `library/cc.strings.md`

# cc.strings

Various utilities for working with strings and text.

### See also

* **[`textutils`](../module/textutils.html)** For additional string related utilities.

### Changes

* **New in version 1.95.0**

|  |  |
| --- | --- |
| [wrap(text [, width])](#v:wrap) | Wraps a block of text, so that each line fits within the given width. |
| [ensure\_width(line [, width])](#v:ensure_width) | Makes the input string a fixed width. |
| [split(str, deliminator [, plain=false [, limit]])](#v:split) | Split a string into parts, each separated by a deliminator. |

wrap(text [, width])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/strings.lua#L32)
:   Wraps a block of text, so that each line fits within the given width.

    This may be useful if you want to wrap text before displaying it to a
    [`monitor`](../peripheral/monitor.html) or [`printer`](../peripheral/printer.html) without using [print](../module/_G.html#v:print).

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The string to wrap.
    2. width? `number` The width to constrain to, defaults to the width of
       the terminal.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } The wrapped input string as a list of lines.

    ### Usage

    * Wrap a string and write it to the terminal.

      ```
      term.clear()
      local lines = require "cc.strings".wrap("This is a long piece of text", 10)
      for i = 1, #lines do
        term.setCursorPos(1, i)
        term.write(lines[i])
      end
      ```

ensure\_width(line [, width])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/strings.lua#L100)
:   Makes the input string a fixed width. This either truncates it, or pads it
    with spaces.

    ### Parameters

    1. line [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The string to normalise.
    2. width? `number` The width to constrain to, defaults to the width of
       the terminal.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The string with a specific width.

    ### Usage

    * ```
      require "cc.strings".ensure_width("a short string", 20)
      ```
    * ```
      require "cc.strings".ensure_width("a rather long string which is truncated", 20)
      ```

split(str, deliminator [, plain=false [, limit]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/strings.lua#L142)
:   Split a string into parts, each separated by a deliminator.

    For instance, splitting the string `"a b c"` with the deliminator `" "`, would
    return a table with three strings: `"a"`, `"b"`, and `"c"`.

    By default, the deliminator is given as a [Lua pattern](https://www.lua.org/manual/5.3/manual.html#6.4.1). Passing `true`
    to the `plain` argument will cause the deliminator to be treated as a litteral
    string.

    ### Parameters

    1. str [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The string to split.
    2. deliminator [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The pattern to split this string on.
    3. plain? `boolean` = `false` Treat the deliminator as a plain string, rather than a pattern.
    4. limit? `number` The maximum number of elements in the returned list.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } The list of split strings.

    ### Usage

    * Split a string into words.

      ```
      require "cc.strings".split("This is a sentence.", "%s+")
      ```
    * Split a string by "-" into at most 3 elements.

      ```
      require "cc.strings".split("a-separated-string-of-sorts", "-", true, 3)
      ```

    ### See also

    * **[`table.concat`](https://www.lua.org/manual/5.1/manual.html#pdf-table.concat)** To join strings together.

    ### Changes

    * **New in version 1.112.0**