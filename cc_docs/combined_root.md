# ROOT Documentation

## Source File: `index.md`

# CC: Tweaked

CC: Tweaked is a mod for Minecraft which adds programmable computers, turtles and more to the game. A fork of the
much-beloved [ComputerCraft](https://github.com/dan200/ComputerCraft "ComputerCraft on GitHub"), it continues its legacy with improved performance and stability, along with a wealth of
new features.

CC: Tweaked can be installed from [Modrinth](https://modrinth.com/mod/gu7yAYhd "Download CC: Tweaked from Modrinth"). It runs on both [Minecraft Forge](https://files.minecraftforge.net/ "Download Minecraft Forge.") and [Fabric](https://fabricmc.net/use/installer/ "Download Fabric.").

## Features

Controlled using the [Lua programming language](https://www.lua.org/ "Lua's main website"), CC: Tweaked's computers provides all the tools you need to start
writing code and automating your Minecraft world.

![A ComputerCraft terminal open and ready to be programmed.](basic-terminal-45a33440.png)

While computers are incredibly powerful, they're rather limited by their inability to move about. *Turtles* are the
solution here. They can move about the world, placing and breaking blocks, swinging a sword to protect you from zombies,
or whatever else you program them to!

![A turtle tunneling in Minecraft.](turtle-1b1e3370.png)

Not all problems can be solved with a pickaxe though, and so CC: Tweaked also provides a bunch of additional peripherals
for your computers. You can play a tune with speakers, display text or images on a monitor, connect all your
computers together with modems, and much more.

Computers can now also interact with inventories such as chests, allowing you to build complex inventory and item
management systems.

![A chest's contents being read by a computer and displayed on a monitor.](peripherals-d5df11cc.png)

## Getting Started

While ComputerCraft is lovely for both experienced programmers and for people who have never coded before, it can be a
little daunting getting started. Thankfully, there's several fantastic tutorials out there:

* [Direwolf20's ComputerCraft tutorials](https://www.youtube.com/watch?v=wrUHUhfCY5A "ComputerCraft Tutorial Episode 1 - HELP! and Hello World")
* [Sethbling's ComputerCraft series](https://www.youtube.com/watch?v=DSsx4VSe-Uk "Programming Tutorial with Minecraft Turtles -- Ep. 1: Intro to Turtles and If-Then-Else_End")
* [Lyqyd's Computer Basics 1](https://ccf.squiddev.cc/forums2/index.php?/topic/15033-computer-basics-i/ "Computer Basics I")

Once you're a little more familiar with the mod, the sidebar and links below provide more detailed documentation on the
various APIs and peripherals provided by the mod.

## Community

If you need help getting started with CC: Tweaked, want to show off your latest project, or just want to chat about
ComputerCraft, do check out our [GitHub discussions page](https://github.com/cc-tweaked/CC-Tweaked/discussions)! There's also a fairly populated,
albeit quiet IRC channel on [EsperNet](https://www.esper.net/), if that's more your cup of tea. You can join `#computercraft` through your
desktop client, or online using [KiwiIRC](https://kiwiirc.com/nextclient/#irc://irc.esper.net:+6697/#computercraft "#computercraft on EsperNet").

## Get Involved

CC: Tweaked lives on [GitHub](https://github.com/cc-tweaked/CC-Tweaked/ "CC: Tweaked on GitHub"). If you've got any ideas, feedback or bugs please do [create an issue](https://github.com/cc-tweaked/CC-Tweaked/issues/new/choose).

## Globals

|  |  |
| --- | --- |
| [\_G](module/_G.html) | Functions in the global environment, defined in `bios.lua`. |
| [colors](module/colors.html) | Constants and functions for colour values, suitable for working with [`term`](module/term.html) and [`redstone`](module/redstone.html). |
| [colours](module/colours.html) | An alternative version of [`colors`](module/colors.html) for lovers of British spelling. |
| [commands](module/commands.html) | Execute Minecraft commands and gather data from the results from a command computer. |
| [disk](module/disk.html) | Interact with disk drives. |
| [fs](module/fs.html) | Interact with the computer's files and filesystem, allowing you to manipulate files, directories and paths. |
| [gps](module/gps.html) | Use [modems](peripheral/modem.html) to locate the position of the current turtle or computers. |
| [help](module/help.html) | Find help files on the current computer. |
| [http](module/http.html) | Make HTTP requests, sending and receiving data to a remote web server. |
| [io](module/io.html) | Emulates Lua's standard io library. |
| [keys](module/keys.html) | Constants for all keyboard "key codes", as queued by the [`key`](event/key.html) event. |
| [multishell](module/multishell.html) | Multishell allows multiple programs to be run at the same time. |
| [os](module/os.html) | The [`os`](module/os.html) API allows interacting with the current computer. |
| [paintutils](module/paintutils.html) | Utilities for drawing more complex graphics, such as pixels, lines and images. |
| [parallel](module/parallel.html) | A simple way to run several functions at once. |
| [peripheral](module/peripheral.html) | Find and control peripherals attached to this computer. |
| [pocket](module/pocket.html) | Control the current pocket computer, adding or removing upgrades. |
| [rednet](module/rednet.html) | Communicate with other computers by using [modems](peripheral/modem.html). |
| [redstone](module/redstone.html) | Get and set redstone signals adjacent to this computer. |
| [settings](module/settings.html) | Read and write configuration options for CraftOS and your programs. |
| [shell](module/shell.html) | The shell API provides access to CraftOS's command line interface. |
| [term](module/term.html) | Interact with a computer's terminal or monitors, writing text and drawing ASCII graphics. |
| [textutils](module/textutils.html) | Helpful utilities for formatting and manipulating strings. |
| [turtle](module/turtle.html) | Turtles are a robotic device, which can break and place blocks, attack mobs, and move about the world. |
| [vector](module/vector.html) | A basic 3D vector type and some common vector operations. |
| [window](module/window.html) | A [terminal redirect](module/term.html#ty:Redirect) occupying a smaller area of an existing terminal. |

## Modules

|  |  |
| --- | --- |
| [cc.audio.dfpwm](library/cc.audio.dfpwm.html) | Convert between streams of DFPWM audio data and a list of amplitudes. |
| [cc.completion](library/cc.completion.html) | A collection of helper methods for working with input completion, such as that require by [`_G.read`](module/_G.html#v:read). |
| [cc.expect](library/cc.expect.html) | The [`cc.expect`](library/cc.expect.html) library provides helper functions for verifying that function arguments are well-formed and of the correct type. |
| [cc.image.nft](library/cc.image.nft.html) | Read and draw nft ("Nitrogen Fingers Text") images. |
| [cc.pretty](library/cc.pretty.html) | A pretty printer for rendering data structures in an aesthetically pleasing manner. |
| [cc.require](library/cc.require.html) | A pure Lua implementation of the builtin [`require`](https://www.lua.org/manual/5.1/manual.html#pdf-require) function and [`package`](https://www.lua.org/manual/5.1/manual.html#5.3) library. |
| [cc.shell.completion](library/cc.shell.completion.html) | A collection of helper methods for working with shell completion. |
| [cc.strings](library/cc.strings.html) | Various utilities for working with strings and text. |

## Peripherals

|  |  |
| --- | --- |
| [command](peripheral/command.html) | This peripheral allows you to interact with command blocks. |
| [computer](peripheral/computer.html) | A computer or turtle wrapped as a peripheral. |
| [drive](peripheral/drive.html) | Disk drives are a peripheral which allow you to read and write to floppy disks and other "mountable media" (such as computers or turtles). |
| [modem](peripheral/modem.html) | Modems allow you to send messages between computers over long distances. |
| [monitor](peripheral/monitor.html) | Monitors are a block which act as a terminal, displaying information on one side. |
| [printer](peripheral/printer.html) | The printer peripheral allows printing text onto pages. |
| [redstone\_relay](peripheral/redstone_relay.html) | The redstone relay is a peripheral that allows reading and outputting redstone signals. |
| [speaker](peripheral/speaker.html) | The speaker peripheral allows your computer to play notes and other sounds. |

## Generic Peripherals

|  |  |
| --- | --- |
| [energy\_storage](generic_peripheral/energy_storage.html) | Methods for interacting with blocks which store energy. |
| [fluid\_storage](generic_peripheral/fluid_storage.html) | Methods for interacting with tanks and other fluid storage blocks. |
| [inventory](generic_peripheral/inventory.html) | Methods for interacting with inventories. |

## Events

|  |  |
| --- | --- |
| [alarm](event/alarm.html) | The [`alarm`](event/alarm.html) event is fired when an alarm started with [`os.setAlarm`](module/os.html#v:setAlarm) completes. |
| [char](event/char.html) | The [`char`](event/char.html) event is fired when a character is typed on the keyboard. |
| [computer\_command](event/computer_command.html) | The [`computer_command`](event/computer_command.html) event is fired when the `/computercraft queue` command is run for the current computer. |
| [disk](event/disk.html) | The [`disk`](module/disk.html) event is fired when a disk is inserted into an adjacent or networked disk drive. |
| [disk\_eject](event/disk_eject.html) | The [`disk_eject`](event/disk_eject.html) event is fired when a disk is removed from an adjacent or networked disk drive. |
| [file\_transfer](event/file_transfer.html) | The [`file_transfer`](event/file_transfer.html) event is queued when a user drags-and-drops a file on an open computer. |
| [http\_check](event/http_check.html) | The [`http_check`](event/http_check.html) event is fired when a URL check finishes. |
| [http\_failure](event/http_failure.html) | The [`http_failure`](event/http_failure.html) event is fired when an HTTP request fails. |
| [http\_success](event/http_success.html) | The [`http_success`](event/http_success.html) event is fired when an HTTP request returns successfully. |
| [key](event/key.html) | This event is fired when any key is pressed while the terminal is focused. |
| [key\_up](event/key_up.html) | Fired whenever a key is released (or the terminal is closed while a key was being pressed). |
| [modem\_message](event/modem_message.html) | The [`modem_message`](event/modem_message.html) event is fired when a message is received on an open channel on any [`modem`](peripheral/modem.html). |
| [monitor\_resize](event/monitor_resize.html) | The [`monitor_resize`](event/monitor_resize.html) event is fired when an adjacent or networked [monitor's](peripheral/monitor.html) size is changed. |
| [monitor\_touch](event/monitor_touch.html) | The [`monitor_touch`](event/monitor_touch.html) event is fired when an adjacent or networked [Advanced Monitor](peripheral/monitor.html) is right-clicked. |
| [mouse\_click](event/mouse_click.html) | This event is fired when the terminal is clicked with a mouse. |
| [mouse\_drag](event/mouse_drag.html) | This event is fired every time the mouse is moved while a mouse button is being held. |
| [mouse\_scroll](event/mouse_scroll.html) | This event is fired when a mouse wheel is scrolled in the terminal. |
| [mouse\_up](event/mouse_up.html) | This event is fired when a mouse button is released or a held mouse leaves the computer's terminal. |
| [paste](event/paste.html) | The [`paste`](event/paste.html) event is fired when text is pasted into the computer through Ctrl-V (or âV on Mac). |
| [peripheral](event/peripheral.html) | The [`peripheral`](module/peripheral.html) event is fired when a peripheral is attached on a side or to a modem. |
| [peripheral\_detach](event/peripheral_detach.html) | The [`peripheral_detach`](event/peripheral_detach.html) event is fired when a peripheral is detached from a side or from a modem. |
| [rednet\_message](event/rednet_message.html) | The [`rednet_message`](event/rednet_message.html) event is fired when a message is sent over Rednet. |
| [redstone](event/redstone.html) | The [`redstone`](event/redstone.html) event is fired whenever any redstone inputs on the computer or [relay](peripheral/redstone_relay.html) change. |
| [speaker\_audio\_empty](event/speaker_audio_empty.html) | Return Values |
| [task\_complete](event/task_complete.html) | The [`task_complete`](event/task_complete.html) event is fired when an asynchronous task completes. |
| [term\_resize](event/term_resize.html) | The [`term_resize`](event/term_resize.html) event is fired when the main terminal is resized. |
| [terminate](event/terminate.html) | The [`terminate`](event/terminate.html) event is fired when `Ctrl-T` is held down. |
| [timer](event/timer.html) | The [`timer`](event/timer.html) event is fired when a timer started with [`os.startTimer`](module/os.html#v:startTimer) completes. |
| [turtle\_inventory](event/turtle_inventory.html) | The [`turtle_inventory`](event/turtle_inventory.html) event is fired when a turtle's inventory is changed. |
| [websocket\_closed](event/websocket_closed.html) | The [`websocket_closed`](event/websocket_closed.html) event is fired when an open WebSocket connection is closed. |
| [websocket\_failure](event/websocket_failure.html) | The [`websocket_failure`](event/websocket_failure.html) event is fired when a WebSocket connection request fails. |
| [websocket\_message](event/websocket_message.html) | The [`websocket_message`](event/websocket_message.html) event is fired when a message is received on an open WebSocket connection. |
| [websocket\_success](event/websocket_success.html) | The [`websocket_success`](event/websocket_success.html) event is fired when a WebSocket connection request returns successfully. |

## Guides

|  |  |
| --- | --- |
| [Setting up GPS](guide/gps_setup.html) | The [`gps`](module/gps.html) API allows computers and turtles to find their current position using wireless modems. |
| [Allowing access to local IPs](guide/local_ips.html) | By default, ComputerCraft blocks access to local IP addresses for security. |
| [Playing audio with speakers](guide/speaker_audio.html) | CC: Tweaked's speaker peripheral provides a powerful way to play any audio you like with the [`speaker.playAudio`](peripheral/speaker.html#v:playAudio) method. |
| [Reusing code with require](guide/using_require.html) | A library is a collection of useful functions and other definitions which is stored separately to your main program. |

## Reference

|  |  |
| --- | --- |
| [Incompatibilities between versions](reference/breaking_changes.html) | CC: Tweaked tries to remain as compatible between versions as possible, meaning most programs written for older version |
| [The /computercraft command](reference/computercraft_command.html) | CC: Tweaked provides a `/computercraft` command for server owners to manage running computers on a server. |
| [Lua 5.2/5.3 features in CC: Tweaked](reference/feature_compat.html) | CC: Tweaked is based off of the Cobalt Lua runtime, which uses Lua 5. |