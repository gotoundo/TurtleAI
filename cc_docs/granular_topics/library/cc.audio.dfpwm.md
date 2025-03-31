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