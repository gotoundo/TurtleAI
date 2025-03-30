# GUIDE Documentation

## Source File: `guide/gps_setup.md`

# Setting up GPS

The [`gps`](../module/gps.html) API allows computers and turtles to find their current position using wireless modems.

In order to use GPS, you'll need to set up multiple *GPS hosts*. These are computers running the special `gps host`
program, which tell other computers the host's position. Several hosts running together are known as a *GPS
constellation*.

In order to give the best results, a GPS constellation needs at least four computers. More than four GPS hosts per
constellation is redundant, but it does not cause problems.

## Building a GPS constellation

![An example GPS constellation.](../gps-constellation-example-1a3f81fb.png)

We are going to build our GPS constellation as shown in the image above. You will need 4 computers and either 4 wireless
modems or 4 ender modems. Try not to mix ender and wireless modems together as you might get some odd behavior when your
requesting computers are out of range.

##### Ender modems vs wireless modems

Ender modems have a very large range, which makes them very useful for setting up GPS hosts. If you do this then you
will likely only need one GPS constellation for the whole dimension (such as the Overworld or Nether).

If you do use wireless modems then you may find that you need multiple GPS constellations to cover your needs.

A computer needs a wireless or ender modem and to be in range of a GPS constellation that is in the same dimension as
it to use the GPS API. The reason for this is that ComputerCraft mimics real-life GPS by making use of the distance
parameter of [modem messages](../event/modem_message.html) and some maths.

Locate where you want to place your GPS constellation. You will need an area at least 6 blocks high, 6 blocks wide, and
6 blocks deep (6x6x6). If you are using wireless modems then you may want to build your constellation as high as you can
because high altitude boosts modem message range and thus the radius that your constellation covers.

The GPS constellation will only work when it is in a loaded chunk. If you want your constellation to always be
accessible, you may want to permanently load the chunk using a vanilla or modded chunk loader. Make sure that your 6x6x6
area fits in a single chunk to reduce the number of chunks that need to be kept loaded.

Let's get started building the constellation! Place your first computer in one of the corners of your 6x6x6. Remember
which computer this is as other computers need to be placed relative to it. Place the second computer 4 blocks above the
first. Go back to your first computer and place your third computer 5 blocks in front of your first computer, leaving 4
blocks of air between them. Finally for the fourth computer, go back to your first computer and place it 5 blocks right
of your first computer, leaving 4 blocks of air between them.

With all four computers placed within the 6x6x6, place one modem on top of each computer. You should have 4 modems and 4
computers all within your 6x6x6 where each modem is attached to a computer and each computer has a modem.

Currently your GPS constellation will not work, that's because each host is not aware that it's a GPS host. We will fix
this in the next section.

## Configuring the constellation

Now that the structure of your constellation is built, we need to configure each host in it.

Go back to the first computer that you placed and create a startup file, by running `edit startup`.

Type the following code into the file:

```
shell.run("gps", "host", x, y, z)
```

Escape from the computer GUI and then press `F3` to open Minecraft's debug screen and then look at the computer
(without opening the GUI). On the right of the screen about halfway down you should see an entry labeled `Targeted Block`, the numbers correspond to the position of the block that you are looking at. Replace `x` with the first number,
`y` with the second number, and `z` with the third number.

For example, if I had a computer at x = 59, y = 5, z = -150, then my `F3` debug screen entry would be `Target Block: 59, 5, -150` and I would change my startup file to this `shell.run("gps", "host", 59, 5, -150)`.

To hide Minecraft's debug screen, press `F3` again.

Create similar startup files for the other computers in your constellation, making sure to input the each computer's own
coordinates.

##### â  Modem messages come from the computer's position, not the modem's

Wireless modems transmit from the block that they are attached to *not* the block space that they occupy, the
coordinates that you input into your GPS host should be the position of the computer and not the position of the modem.

Congratulations, your constellation is now fully set up! You can test it by placing another computer close by, placing a
wireless modem on it, and running the `gps locate` program (or calling the [`gps.locate`](../module/gps.html#v:locate) function).

##### ð Why use Minecraft's coordinates?

CC doesn't care if you use Minecraft's coordinate system, so long as all of the GPS hosts with overlapping ranges use
the same reference point (requesting computers will get confused if hosts have different reference points). However,
using MC's coordinate system does provide a nice standard to adopt server-wide. It also is consistent with how command
computers get their location, they use MC's command system to get their block which returns that in MC's coordinate
system.

---

## Source File: `guide/local_ips.md`

# Allowing access to local IPs

By default, ComputerCraft blocks access to local IP addresses for security. This means you can't normally access any
HTTP server running on your computer. However, this may be useful for testing programs without having a remote
server. You can unblock these IPs in the ComputerCraft config.

* [Minecraft 1.13 and later, CC:T 1.87.0 and later](#cc-1.87.0)
* [Minecraft 1.13 and later, CC:T 1.86.2 and earlier](#cc-1.86.2)
* [Minecraft 1.12.2 and earlier](#mc-1.12)

## Minecraft 1.13 and later, CC:T 1.87.0 and later

The configuration file can be located at `serverconfig/computercraft-server.toml` inside the world folder on either
single-player or multiplayer. Look for lines that look like this:

```
#A list of rules which control behaviour of the "http" API for specific domains or IPs.
#Each rule is an item with a 'host' to match against, and a series of properties. The host may be a domain name ("pastebin.com"),
#wildcard ("*.pastebin.com") or CIDR notation ("127.0.0.0/8"). If no rules, the domain is blocked.
[[http.rules]]
    host = "$private"
    action = "deny"
```

On 1.95.0 and later, this will be a single entry with `host = "$private"`. On earlier versions, this will be a number of
`[[http.rules]]` with various IP addresses. You will want to remove all of the `[[http.rules]]` entries that have
`action = "deny"`. Then save the file and relaunch Minecraft (Server).

Here's what it should look like after removing:

```
#A list of rules which control behaviour of the "http" API for specific domains or IPs.
#Each rule is an item with a 'host' to match against, and a series of properties. The host may be a domain name ("pastebin.com"),
#wildcard ("*.pastebin.com") or CIDR notation ("127.0.0.0/8"). If no rules, the domain is blocked.
[[http.rules]]
    #The maximum size (in bytes) that a computer can send or receive in one websocket packet.
    max_websocket_message = 131072
    host = "*"
    #The maximum size (in bytes) that a computer can upload in a single request. This includes headers and POST text.
    max_upload = 4194304
    action = "allow"
    #The maximum size (in bytes) that a computer can download in a single request. Note that responses may receive more data than allowed, but this data will not be returned to the client.
    max_download = 16777216
    #The period of time (in milliseconds) to wait before a HTTP request times out. Set to 0 for unlimited.
    timeout = 30000
```

## Minecraft 1.13 and later, CC:T 1.86.2 and earlier

The configuration file for singleplayer is at `.minecraft/config/computercraft-common.toml`. Look for lines that look
like this:

```
#A list of wildcards for domains or IP ranges that cannot be accessed through the "http" API on Computers.
#If this is empty then all whitelisted domains will be accessible. Example: "*.github.com" will block access to all subdomains of github.com.
#You can use domain names ("pastebin.com"), wildcards ("*.pastebin.com") or CIDR notation ("127.0.0.0/8").
blacklist = ["127.0.0.0/8", "10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16", "fd00::/8"]
```

Remove everything inside the array, leaving the last line as `blacklist = []`. Then save the file and relaunch Minecraft.

Here's what it should look like after removing:

```
#A list of wildcards for domains or IP ranges that cannot be accessed through the "http" API on Computers.
#If this is empty then all whitelisted domains will be accessible. Example: "*.github.com" will block access to all subdomains of github.com.
#You can use domain names ("pastebin.com"), wildcards ("*.pastebin.com") or CIDR notation ("127.0.0.0/8").
blacklist = []
```

## Minecraft 1.12.2 and earlier

On singleplayer, the configuration file is located at `.minecraft\config\ComputerCraft.cfg`. On multiplayer, the
configuration file is located at `<server folder>\config\ComputerCraft.cfg`. Look for lines that look like this:

```
# A list of wildcards for domains or IP ranges that cannot be accessed through the "http" API on Computers.
# If this is empty then all explicitly allowed domains will be accessible. Example: "*.github.com" will block access to all subdomains of github.com.
# You can use domain names ("pastebin.com"), wildcards ("*.pastebin.com") or CIDR notation ("127.0.0.0/8").
S:blocked_domains <
    127.0.0.0/8
    10.0.0.0/8
    172.16.0.0/12
    192.168.0.0/16
    fd00::/8
 >
```

Delete everything between the `<>`, leaving the last line as `S:blocked_domains = <>`. Then save the file and relaunch
Minecraft (Server).

Here's what it should look like after removing:

```
# A list of wildcards for domains or IP ranges that cannot be accessed through the "http" API on Computers.
# If this is empty then all explicitly allowed domains will be accessible. Example: "*.github.com" will block access to all subdomains of github.com.
# You can use domain names ("pastebin.com"), wildcards ("*.pastebin.com") or CIDR notation ("127.0.0.0/8").
S:blocked_domains <>
```

---

## Source File: `guide/speaker_audio.md`

# Playing audio with speakers

CC: Tweaked's speaker peripheral provides a powerful way to play any audio you like with the [`speaker.playAudio`](../peripheral/speaker.html#v:playAudio)
method. However, for people unfamiliar with digital audio, it's not the most intuitive thing to use. This guide provides
an introduction to digital audio, demonstrates how to play music with CC: Tweaked's speakers, and then briefly discusses
the more complex topic of audio processing.

## A short introduction to digital audio

When sound is recorded it is captured as an analogue signal, effectively the electrical version of a sound
wave. However, this signal is continuous, and so can't be used directly by a computer. Instead, we measure (or *sample*)
the amplitude of the wave many times a second and then *quantise* that amplitude, rounding it to the nearest
representable value.

This representation of sound - a long, uniformally sampled list of amplitudes is referred to as [Pulse-code
Modulation](https://en.wikipedia.org/wiki/Pulse-code_modulation "Pulse-code Modulation - Wikipedia") (PCM). PCM can be thought of as the "standard" audio format, as it's incredibly easy to work with. For
instance, to mix two pieces of audio together, you can just add samples from the two tracks together and take the average.

CC: Tweaked's speakers also work with PCM audio. It plays back 48,000 samples a second, where each sample is an integer
between -128 and 127. This is more commonly referred to as 48kHz and an 8-bit resolution.

Let's now look at a quick example. We're going to generate a [Sine Wave](https://en.wikipedia.org/wiki/Sine_wave "Sine wave - Wikipedia") at 220Hz, which sounds like a low monotonous
hum. First we wrap our speaker peripheral, and then we fill a table (also referred to as a *buffer*) with 128Ã1024
samples - this is the maximum number of samples a speaker can accept in one go.

In order to fill this buffer, we need to do a little maths. We want to play 220 sine waves each second, where each sine
wave completes a full oscillation in 2Ï "units". This means one seconds worth of audio is 2ÃÏÃ220 "units" long. We then
need to split this into 48k samples, basically meaning for each sample we move 2ÃÏÃ220/48k "along" the sine curve.

```
local speaker = peripheral.find("speaker")

local buffer = {}
local t, dt = 0, 2 * math.pi * 220 / 48000
for i = 1, 128 * 1024 do
    buffer[i] = math.floor(math.sin(t) * 127)
    t = (t + dt) % (math.pi * 2)
end

speaker.playAudio(buffer)
```

## Streaming audio

You might notice that the above snippet only generates a short bit of audio - 2.7s seconds to be precise. While we could
try increasing the number of loop iterations, we'll get an error when we try to play it through the speaker: the sound
buffer is too large for it to handle.

Our 2.7 seconds of audio is stored in a table with over 130 *thousand* elements. If we wanted to play a full minute of
sine waves (and why wouldn't you?), you'd need a table with almost 3 *million*. Suddenly you find these numbers adding
up very quickly, and these tables take up more and more memory.

Instead of building our entire song (well, sine wave) in one go, we can produce it in small batches, each of which get
passed off to [`speaker.playAudio`](../peripheral/speaker.html#v:playAudio) when the time is right. This allows us to build a *stream* of audio, where we read
chunks of audio one at a time (either from a file or a tone generator like above), do some optional processing to each
one, and then play them.

Let's adapt our example from above to do that instead.

```
local speaker = peripheral.find("speaker")

local t, dt = 0, 2 * math.pi * 220 / 48000
while true do
    local buffer = {}
    for i = 1, 16 * 1024 * 8 do
        buffer[i] = math.floor(math.sin(t) * 127)
        t = (t + dt) % (math.pi * 2)
    end

    while not speaker.playAudio(buffer) do
        os.pullEvent("speaker_audio_empty")
    end
end
```

It looks pretty similar to before, aside from we've wrapped the generation and playing code in a while loop, and added a
rather odd loop with [`speaker.playAudio`](../peripheral/speaker.html#v:playAudio) and [`os.pullEvent`](../module/os.html#v:pullEvent).

Let's talk about this loop, why do we need to keep calling [`speaker.playAudio`](../peripheral/speaker.html#v:playAudio)? Remember that what we're trying to do
here is avoid keeping too much audio in memory at once. However, if we're generating audio quicker than the speakers can
play it, we're not helping at all - all this audio is still hanging around waiting to be played!

In order to avoid this, the speaker rejects any new chunks of audio if its backlog is too large. When this happens,
[`speaker.playAudio`](../peripheral/speaker.html#v:playAudio) returns false. Once enough audio has played, and the backlog has been reduced, a
[`speaker_audio_empty`](../event/speaker_audio_empty.html) event is queued, and we can try to play our chunk once more.

## Storing audio

PCM is a fantastic way of representing audio when we want to manipulate it, but it's not very efficient when we want to
store it to disk. Compare the size of a WAV file (which uses PCM) to an equivalent MP3, it's often 5 times the size.
Instead, we store audio in special formats (or *codecs*) and then convert them to PCM when we need to do processing on
them.

Modern audio codecs use some incredibly impressive techniques to compress the audio as much as possible while preserving
sound quality. However, due to CC: Tweaked's limited processing power, it's not really possible to use these from your
computer. Instead, we need something much simpler.

DFPWM (Dynamic Filter Pulse Width Modulation) is the de facto standard audio format of the ComputerCraft (and
OpenComputers) world. Originally popularised by the addon mod [Computronics](https://github.com/Vexatos/Computronics/ "Computronics on GitHub"), CC:T now has built-in support for it with
the [`cc.audio.dfpwm`](../library/cc.audio.dfpwm.html) module. This allows you to read DFPWM files from disk, decode them to PCM, and then play them
using the speaker.

Let's dive in with an example, and we'll explain things afterwards:

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

Once again, we see the [`speaker.playAudio`](../peripheral/speaker.html#v:playAudio)/[`speaker_audio_empty`](../event/speaker_audio_empty.html) loop. However, the rest of the program is a little
different.

First, we require the dfpwm module and call [`cc.audio.dfpwm.make_decoder`](../library/cc.audio.dfpwm.html#v:make_decoder) to construct a new decoder. This decoder
accepts blocks of DFPWM data and converts it to a list of 8-bit amplitudes, which we can then play with our speaker.

As mentioned above, [`speaker.playAudio`](../peripheral/speaker.html#v:playAudio) accepts at most 128Ã1024 samples in one go. DFPWM uses a single bit for each
sample, which means we want to process our audio in chunks of 16Ã1024 bytes (16KiB). In order to do this, we use
[`io.lines`](../module/io.html#v:lines), which provides a nice way to loop over chunks of a file. You can of course just use [`fs.open`](../module/fs.html#v:open) and
[`fs.ReadHandle.read`](../module/fs.html#ty:ReadHandle:read) if you prefer.

## Processing audio

As mentioned near the beginning of this guide, PCM audio is pretty easy to work with as it's just a list of amplitudes.
You can mix together samples from different streams by adding their amplitudes, change the rate of playback by removing
samples, etc...

Let's put together a small demonstration here. We're going to add a small delay effect to the song above, so that you
hear a faint echo a second and a half later.

In order to do this, we'll follow a format similar to the previous example, decoding the audio and then playing it.
However, we'll also add some new logic between those two steps, which loops over every sample in our chunk of audio, and
adds the sample from 1.5 seconds ago to it.

For this, we'll need to keep track of the last 72k samples - exactly 1.5 seconds worth of audio. We can do this using a
[Ring Buffer](https://en.wikipedia.org/wiki/Circular_buffer "Circular buffer - Wikipedia"), which helps makes things a little more efficient.

```
local dfpwm = require("cc.audio.dfpwm")
local speaker = peripheral.find("speaker")

-- Speakers play at 48kHz, so 1.5 seconds is 72k samples. We first fill our buffer
-- with 0s, as there's nothing to echo at the start of the track!
local samples_i, samples_n = 1, 48000 * 1.5
local samples = {}
for i = 1, samples_n do samples[i] = 0 end

local decoder = dfpwm.make_decoder()
for chunk in io.lines("data/example.dfpwm", 16 * 1024) do
    local buffer = decoder(chunk)

    for i = 1, #buffer do
        local original_value = buffer[i]

        -- Replace this sample with its current amplitude plus the amplitude from 1.5 seconds ago.
        -- We scale both to ensure the resulting value is still between -128 and 127.
        buffer[i] = original_value * 0.6 + samples[samples_i] * 0.4

        -- Now store the current sample, and move the "head" of our ring buffer forward one place.
        samples[samples_i] = original_value
        samples_i = samples_i + 1
        if samples_i > samples_n then samples_i = 1 end
    end

    while not speaker.playAudio(buffer) do
        os.pullEvent("speaker_audio_empty")
    end

    -- The audio processing above can be quite slow and preparing the first batch of audio
    -- may timeout the computer. We sleep to avoid this.
    -- There's definitely better ways of handling this - this is just an example!
    sleep(0.05)
end
```

##### ð Confused?

Don't worry if you don't understand this example. It's quite advanced, and does use some ideas that this guide doesn't
cover. That said, don't be afraid to ask [the community for help](/#community).

It's worth noting that the examples of audio processing we've mentioned here are about manipulating the *amplitude* of
the wave. If you wanted to modify the *frequency* (for instance, shifting the pitch), things get rather more complex.
For this, you'd need to use the [Fast Fourier transform](https://en.wikipedia.org/wiki/Fast_Fourier_transform "Fast Fourier transform - Wikipedia") to convert the stream of amplitudes to frequencies,
process those, and then convert them back to amplitudes.

This is, I'm afraid, left as an exercise to the reader.

### See also

* **[`speaker.playAudio`](../peripheral/speaker.html#v:playAudio)** Play PCM audio using a speaker.
* **[`cc.audio.dfpwm`](../library/cc.audio.dfpwm.html)** Provides utilities for encoding and decoding DFPWM files.

---

## Source File: `guide/using_require.md`

# Reusing code with require

A library is a collection of useful functions and other definitions which is stored separately to your main program. You
might want to create a library because you have some functions which are used in multiple programs, or just to split
your program into multiple more modular files.

Let's say we want to create a small library to make working with the [terminal](../module/term.html) a little easier. We'll provide two
functions: `reset`, which clears the terminal and sets the cursor to (1, 1), and `write_center`, which prints some text
in the middle of the screen.

Start off by creating a file called `more_term.lua`:

```
local function reset()
  term.clear()
  term.setCursorPos(1, 1)
end

local function write_center(text)
  local x, y = term.getCursorPos()
  local width, height = term.getSize()
  term.setCursorPos(math.floor((width - #text) / 2) + 1, y)
  term.write(text)
end

return { reset = reset, write_center = write_center }
```

Now, what's going on here? We define our two functions as one might expect, and then at the bottom return a table with
the two functions. When we require this library, this table is what is returned. With that, we can then call the
original functions. Now create a new file, with the following:

```
local more_term = require("more_term")
more_term.reset()
more_term.write_center("Hello, world!")
```

When run, this'll clear the screen and print some text in the middle of the first line.

## require in depth

While the previous section is a good introduction to how [`require`](https://www.lua.org/manual/5.1/manual.html#pdf-require) operates, there are a couple of remaining points
which are worth mentioning for more advanced usage.

### Libraries can return anything

In our above example, we return a table containing the functions we want to expose. However, it's worth pointing out
that you can return ''anything'' from your library - a table, a function or even just a string! [`require`](https://www.lua.org/manual/5.1/manual.html#pdf-require) treats them
all the same, and just returns whatever your library provides.

### Module resolution and the package path

In the above examples, we defined our library in a file, and [`require`](https://www.lua.org/manual/5.1/manual.html#pdf-require) read from it. While this is what you'll do most
of the time, it is possible to make [`require`](https://www.lua.org/manual/5.1/manual.html#pdf-require) look elsewhere for your library, such as downloading from a website or
loading from an in-memory library store.

As a result, the *module name* you pass to [`require`](https://www.lua.org/manual/5.1/manual.html#pdf-require) doesn't correspond to a file path. One common mistake is to load
code from a sub-directory using `require("folder/library")` or even `require("folder/library.lua")`, neither of which
will do quite what you expect.

When loading libraries (also referred to as *modules*) from files, [`require`](https://www.lua.org/manual/5.1/manual.html#pdf-require) searches along the [*module
path*](https://www.lua.org/manual/5.1/manual.html#pdf-package.path). By default, this looks something like:

* `?.lua`
* `?/init.lua`
* `/rom/modules/main/?.lua`
* etc...

When you call `require("my_library")`, [`require`](https://www.lua.org/manual/5.1/manual.html#pdf-require) replaces the `?` in each element of the path with your module name, and
checks if the file exists. In this case, we'd look for `my_library.lua`, `my_library/init.lua`,
`/rom/modules/main/my_library.lua` and so on. Note that this works *relative to the current program*, so if your
program is actually called `folder/program`, then we'll look for `folder/my_library.lua`, etc...

One other caveat is loading libraries from sub-directories. For instance, say we have a file
`my/fancy/library.lua`. This can be loaded by using `require("my.fancy.library")` - the '.'s are replaced with '/'
before we start looking for the library.

## External links

There are several external resources which go into require in a little more detail:

* The [Lua Module tutorial](http://lua-users.org/wiki/ModulesTutorial) on the Lua wiki.
* [Lua's manual section on `require`](https://www.lua.org/manual/5.1/manual.html#pdf-require).