# speaker\_audio\_empty

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The name of the speaker which is available to play more audio.

## Example

This uses [`io.lines`](../module/io.html#v:lines) to read audio data in blocks of 16KiB from "example\_song.dfpwm", and then attempts to play it
using [`speaker.playAudio`](../peripheral/speaker.html#v:playAudio). If the speaker's buffer is full, it waits for an event and tries again.

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

* **[`speaker.playAudio`](../peripheral/speaker.html#v:playAudio)** To play audio using the speaker