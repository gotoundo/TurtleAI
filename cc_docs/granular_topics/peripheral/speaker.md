# speaker

The speaker peripheral allows your computer to play notes and other sounds.

The speaker can play three kinds of sound, in increasing orders of complexity:

* [`playNote`](speaker.html#v:playNote) allows you to play noteblock note.
* [`playSound`](speaker.html#v:playSound) plays any built-in Minecraft sound, such as block sounds or mob noises.
* [`playAudio`](speaker.html#v:playAudio) can play arbitrary audio.

## Recipe

**Speaker**

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Note Block](/images/items/minecraft/note_block.png "Note Block")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Redstone Dust](/images/items/minecraft/redstone.png "Redstone Dust")

![Stone](/images/items/minecraft/stone.png "Stone")

![Speaker](/images/items/computercraft/speaker.png "Speaker")

### Changes

* **New in version 1.80pr1**

|  |  |
| --- | --- |
| [playNote(instrument [, volume [, pitch]])](#v:playNote) | Plays a note block note through the speaker. |
| [playSound(name [, volume [, pitch]])](#v:playSound) | Plays a Minecraft sound through the speaker. |
| [playAudio(audio [, volume])](#v:playAudio) | Attempt to stream some audio data to the speaker. |
| [stop()](#v:stop) | Stop all audio being played by this speaker. |

playNote(instrument [, volume [, pitch]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/speaker/SpeakerPeripheral.java#L206)
:   Plays a note block note through the speaker.

    This takes the name of a note to play, as well as optionally the volume
    and pitch to play the note at.

    The pitch argument uses semitones as the unit. This directly maps to the
    number of clicks on a note block. For reference, 0, 12, and 24 map to F#,
    and 6 and 18 map to C.

    A maximum of 8 notes can be played in a single tick. If this limit is hit, this function will return
    `false`.

    ### Valid instruments

    The speaker supports [all of Minecraft's noteblock instruments](https://minecraft.wiki/w/Note_Block#Instruments).
    These are:

    `"harp"`, `"basedrum"`, `"snare"`, `"hat"`, `"bass"`, `"flute"`,
    `"bell"`, `"guitar"`, `"chime"`, `"xylophone"`, `"iron_xylophone"`,
    `"cow_bell"`, `"didgeridoo"`, `"bit"`, `"banjo"` and `"pling"`.

    ### Parameters

    1. instrument [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The instrument to use to play this note.
    2. volume? `number` The volume to play the note at, from 0.0 to 3.0. Defaults to 1.0.
    3. pitch? `number` The pitch to play the note at in semitones, from 0 to 24. Defaults to 12.

    ### Returns

    1. `boolean` Whether the note could be played as the limit was reached.

    ### Throws

    * If the instrument doesn't exist.

playSound(name [, volume [, pitch]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/speaker/SpeakerPeripheral.java#L251)
:   Plays a Minecraft sound through the speaker.

    This takes the [name of a Minecraft sound](https://minecraft.wiki/w/Sounds.json), such as
    `"minecraft:block.note_block.harp"`, as well as an optional volume and pitch.

    Only one sound can be played at once. This function will return `false` if another sound was started
    this tick, or if some [audio](speaker.html#v:playAudio) is still playing.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the sound to play.
    2. volume? `number` The volume to play the sound at, from 0.0 to 3.0. Defaults to 1.0.
    3. pitch? `number` The speed to play the sound at, from 0.5 to 2.0. Defaults to 1.0.

    ### Returns

    1. `boolean` Whether the sound could be played.

    ### Throws

    * If the sound name was invalid.

    ### Usage

    * Play a creeper hiss with the speaker.

      ```
      local speaker = peripheral.find("speaker")
      speaker.playSound("entity.creeper.primed")
      ```

playAudio(audio [, volume])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/speaker/SpeakerPeripheral.java#L316)
:   Attempt to stream some audio data to the speaker.

    This accepts a list of audio samples as amplitudes between -128 and 127. These are stored in an internal buffer
    and played back at 48kHz. If this buffer is full, this function will return `false`. Programs should
    wait for a [`speaker_audio_empty`](../event/speaker_audio_empty.html) event before trying to play audio again.

    The speaker only buffers a single call to [`playAudio`](speaker.html#v:playAudio) at once. This means if you try to play a small
    number of samples, you'll have a lot of stutter. You should try to play as many samples in one call as possible
    (up to 128Ã1024), as this reduces the chances of audio stuttering or halting, especially when the server or
    computer is lagging.

    While the speaker accepts 8-bit PCM audio, the audio stream is re-encoded before being played. This means that
    the supplied samples may not be played out exactly.

    [Playing audio with speakers](../guide/speaker_audio.html) provides a more complete guide to using speakers.

    ### Parameters

    1. audio { `number`... } A list of amplitudes.
    2. volume? `number` The volume to play this audio at. If not given, defaults to the previous volume
       given to [`playAudio`](speaker.html#v:playAudio).

    ### Returns

    1. `boolean` If there was room to accept this audio data.

    ### Throws

    * If the audio data is malformed.

    ### Usage

    * Read an audio file, decode it using [`cc.audio.dfpwm`](../library/cc.audio.dfpwm.html), and play it using the speaker.

      ```
      local dfpwm = require("cc.audio.dfpwm")
      local speaker = peripheral.find("speaker")

      local decoder = dfpwm.make_decoder()
      for chunk in io.lines("data/example.dfpwm", 16 * 1024) do
          local buffer = decoder(chunk)

          while not speaker.playAudio(buffer) do
              os.pullEvent("speaker_audio_empty")
          end
      end
      ```

    ### See also

    * **[`cc.audio.dfpwm`](../library/cc.audio.dfpwm.html)** Provides utilities for decoding DFPWM audio files into a format which can be played by
      the speaker.
    * **[`Playing audio with speakers`](../guide/speaker_audio.html)** For a more complete introduction to the [`playAudio`](speaker.html#v:playAudio) function.

    ### Changes

    * **New in version 1.100**

stop()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/speaker/SpeakerPeripheral.java#L343)
:   Stop all audio being played by this speaker.

    This clears any audio that [`playAudio`](speaker.html#v:playAudio) had queued and stops the latest sound played by [`playSound`](speaker.html#v:playSound).

    ### Changes

    * **New in version 1.100**