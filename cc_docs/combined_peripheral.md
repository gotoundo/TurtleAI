# PERIPHERAL Documentation

## Source File: `peripheral/command.md`

# command

This peripheral allows you to interact with command blocks.

Command blocks are only wrapped as peripherals if the `enable_command_block` option is true within the
config.

This API is *not* the same as the [`commands`](../module/commands.html) API, which is exposed on command computers.

|  |  |
| --- | --- |
| [getCommand()](#v:getCommand) | Get the command this command block will run. |
| [setCommand(command)](#v:setCommand) | Set the command block's command. |
| [runCommand()](#v:runCommand) | Execute the command block once. |

getCommand()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/commandblock/CommandBlockPeripheral.java#L40)
:   Get the command this command block will run.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The current command.

setCommand(command)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/commandblock/CommandBlockPeripheral.java#L50)
:   Set the command block's command.

    ### Parameters

    1. command [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The new command.

runCommand()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/commandblock/CommandBlockPeripheral.java#L63)
:   Execute the command block once.

    ### Returns

    1. `boolean` If the command completed successfully.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil A failure message.

---

## Source File: `peripheral/computer.md`

# computer

A computer or turtle wrapped as a peripheral.

This allows for basic interaction with adjacent computers. Computers wrapped as peripherals will have the type
`computer` while turtles will be `turtle`.

|  |  |
| --- | --- |
| [turnOn()](#v:turnOn) | Turn the other computer on. |
| [shutdown()](#v:shutdown) | Shutdown the other computer. |
| [reboot()](#v:reboot) | Reboot or turn on the other computer. |
| [getID()](#v:getID) | Get the other computer's ID. |
| [isOn()](#v:isOn) | Determine if the other computer is on. |
| [getLabel()](#v:getLabel) | Get the other computer's label. |

turnOn()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/computer/blocks/ComputerPeripheral.java#L37)
:   Turn the other computer on.

shutdown()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/computer/blocks/ComputerPeripheral.java#L50)
:   Shutdown the other computer.

reboot()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/computer/blocks/ComputerPeripheral.java#L63)
:   Reboot or turn on the other computer.

getID()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/computer/blocks/ComputerPeripheral.java#L79)
:   Get the other computer's ID.

    ### Returns

    1. `number` The computer's ID.

    ### See also

    * **[`os.getComputerID`](../module/os.html#v:getComputerID)** To get your computer's ID.

isOn()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/computer/blocks/ComputerPeripheral.java#L90)
:   Determine if the other computer is on.

    ### Returns

    1. `boolean` If the computer is on.

getLabel()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/computer/blocks/ComputerPeripheral.java#L102)
:   Get the other computer's label.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The computer's label.

    ### See also

    * **[`os.getComputerLabel`](../module/os.html#v:getComputerLabel)** To get your label.

---

## Source File: `peripheral/drive.md`

# drive

Disk drives are a peripheral which allow you to read and write to floppy disks and other "mountable media" (such as
computers or turtles). They also allow you to [play records](drive.html#v:playAudio).

When a disk drive attaches some mount (such as a floppy disk or computer), it attaches a folder called `disk`,
`disk2`, etc... to the root directory of the computer. This folder can be used to interact with the files on
that disk.

When a disk is inserted, a `disk` event is fired, with the side peripheral is on. Likewise, when the disk is
detached, a `disk_eject` event is fired.

## Recipe

**Disk Drive**

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Redstone Dust](/images/items/minecraft/redstone.png "Redstone Dust")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Redstone Dust](/images/items/minecraft/redstone.png "Redstone Dust")

![Stone](/images/items/minecraft/stone.png "Stone")

![Disk Drive](/images/items/computercraft/disk_drive.png "Disk Drive")

|  |  |
| --- | --- |
| [isDiskPresent()](#v:isDiskPresent) | Returns whether a disk is currently inserted in the drive. |
| [getDiskLabel()](#v:getDiskLabel) | Returns the label of the disk in the drive if available. |
| [setDiskLabel([label])](#v:setDiskLabel) | Sets or clears the label for a disk. |
| [hasData()](#v:hasData) | Returns whether a disk with data is inserted. |
| [getMountPath()](#v:getMountPath) | Returns the mount path for the inserted disk. |
| [hasAudio()](#v:hasAudio) | Returns whether a disk with audio is inserted. |
| [getAudioTitle()](#v:getAudioTitle) | Returns the title of the inserted audio disk. |
| [playAudio()](#v:playAudio) | Plays the audio in the inserted disk, if available. |
| [stopAudio()](#v:stopAudio) | Stops any audio that may be playing. |
| [ejectDisk()](#v:ejectDisk) | Ejects any disk that may be in the drive. |
| [getDiskID()](#v:getDiskID) | Returns the ID of the disk inserted in the drive. |

isDiskPresent()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L52)
:   Returns whether a disk is currently inserted in the drive.

    ### Returns

    1. `boolean` Whether a disk is currently inserted in the drive.

getDiskLabel()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L63)
:   Returns the label of the disk in the drive if available.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The label of the disk, or `nil` if either no disk is inserted or the disk doesn't have a label.

setDiskLabel([label])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L80)
:   Sets or clears the label for a disk.

    If no label or `nil` is passed, the label will be cleared.

    If the inserted disk's label can't be changed (for example, a record),
    an error will be thrown.

    ### Parameters

    1. label? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The new label of the disk, or `nil` to clear.

    ### Throws

    * If the disk's label can't be changed.

hasData()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L95)
:   Returns whether a disk with data is inserted.

    ### Returns

    1. `boolean` Whether a disk with data is inserted.

getMountPath()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L106)
:   Returns the mount path for the inserted disk.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The mount path for the disk, or `nil` if no data disk is inserted.

hasAudio()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L117)
:   Returns whether a disk with audio is inserted.

    ### Returns

    1. `boolean` Whether a disk with audio is inserted.

getAudioTitle()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L128)
:   Returns the title of the inserted audio disk.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil | false The title of the audio, `false` if no disk is inserted, or `nil` if the disk has no audio.

playAudio()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L138)
:   Plays the audio in the inserted disk, if available.

stopAudio()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L148)
:   Stops any audio that may be playing.

    ### See also

    * **[`playAudio`](drive.html#v:playAudio)**

ejectDisk()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L156)
:   Ejects any disk that may be in the drive.

getDiskID()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L168)
:   Returns the ID of the disk inserted in the drive.

    ### Returns

    1. `number` | nil The ID of the disk in the drive, or `nil` if no disk with an ID is inserted.

    ### Changes

    * **New in version 1.4**

---

## Source File: `peripheral/modem.md`

# modem

Modems allow you to send messages between computers over long distances.

##### tip

Modems provide a fairly basic set of methods, which makes them very flexible but often hard to work with. The
[`rednet`](../module/rednet.html) API is built on top of modems, and provides a more user-friendly interface.

## Sending and receiving messages

Modems operate on a series of channels, a bit like frequencies on a radio. Any modem can send a message on a
particular channel, but only those which have [opened](modem.html#v:open) the channel and are "listening in" can receive
messages.

Channels are represented as an integer between 0 and 65535 inclusive. These channels don't have any defined meaning,
though some APIs or programs will assign a meaning to them. For instance, the [`gps`](../module/gps.html) module sends all its messages on
channel 65534 ([`gps.CHANNEL_GPS`](../module/gps.html#v:CHANNEL_GPS)), while [`rednet`](../module/rednet.html) uses channels equal to the computer's ID.

* Sending messages is done with the [`transmit`](modem.html#v:transmit) message.
* Receiving messages is done by listening to the [`modem_message`](../event/modem_message.html) event.

## Types of modem

CC: Tweaked comes with three kinds of modem, with different capabilities.

* **Wireless modems:** Wireless modems can send messages to any other wireless modem. They can be placed next to a
  computer, or equipped as a pocket computer or turtle upgrade.

  Wireless modems have a limited range, only sending messages to modems within 64 blocks. This range increases
  linearly once the modem is above y=96, to a maximum of 384 at world height.
* **Ender modems:** These are upgraded versions of normal wireless modems. They do not have a distance
  limit, and can send messages between dimensions.
* **Wired modems:** These send messages to other any other wired modems connected to the same network
  (using *Networking Cable*). They also can be used to attach additional peripherals to a computer.

## Recipes

**Wireless Modem**

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Ender Pearl](/images/items/minecraft/ender_pearl.png "Ender Pearl")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Wireless Modem](/images/items/computercraft/wireless_modem_normal.png "Wireless Modem")

**Ender Modem**

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Eye of Ender](/images/items/minecraft/ender_eye.png "Eye of Ender")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Ender Modem](/images/items/computercraft/wireless_modem_advanced.png "Ender Modem")

**Wired Modem**

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Redstone Dust](/images/items/minecraft/redstone.png "Redstone Dust")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Wired Modem](/images/items/computercraft/wired_modem.png "Wired Modem")

**Networking Cable**

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Redstone Dust](/images/items/minecraft/redstone.png "Redstone Dust")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Networking Cable](/images/items/computercraft/cable.png "Networking Cable")6

**Wired Modem**

![Wired Modem](/images/items/computercraft/wired_modem.png "Wired Modem")

![Wired Modem](/images/items/computercraft/wired_modem_full.png "Wired Modem")

### Usage

* Wrap a modem and a message on channel 15, requesting a response on channel 43. Then wait for a message to
  arrive on channel 43 and print it.

  ```
  local modem = peripheral.find("modem") or error("No modem attached", 0)
  modem.open(43) -- Open 43 so we can receive replies

  -- Send our message
  modem.transmit(15, 43, "Hello, world!")

  -- And wait for a reply
  local event, side, channel, replyChannel, message, distance
  repeat
    event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
  until channel == 43

  print("Received a reply: " .. tostring(message))
  ```

### See also

* **[`modem_message`](../event/modem_message.html)** Queued when a modem receives a message on an [open channel](modem.html#v:open).
* **[`rednet`](../module/rednet.html)** A networking API built on top of the modem peripheral.

|  |  |
| --- | --- |
| [open(channel)](#v:open) | Open a channel on a modem. |
| [isOpen(channel)](#v:isOpen) | Check if a channel is open. |
| [close(channel)](#v:close) | Close an open channel, meaning it will no longer receive messages. |
| [closeAll()](#v:closeAll) | Close all open channels. |
| [transmit(channel, replyChannel, payload)](#v:transmit) | Sends a modem message on a certain channel. |
| [isWireless()](#v:isWireless) | Determine if this is a wired or wireless modem. |
| [getNamesRemote()](#v:getNamesRemote) | List all remote peripherals on the wired network. |
| [isPresentRemote(name)](#v:isPresentRemote) | Determine if a peripheral is available on this wired network. |
| [getTypeRemote(name)](#v:getTypeRemote) | Get the type of a peripheral is available on this wired network. |
| [hasTypeRemote(name, type)](#v:hasTypeRemote) | Check a peripheral is of a particular type. |
| [getMethodsRemote(name)](#v:getMethodsRemote) | Get all available methods for the remote peripheral with the given name. |
| [callRemote(remoteName, method, ...)](#v:callRemote) | Call a method on a peripheral on this wired network. |
| [getNameLocal()](#v:getNameLocal) | Returns the network name of the current computer, if the modem is on. |

open(channel)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/modem/ModemPeripheral.java#L160)
:   Open a channel on a modem. A channel must be open in order to receive messages. Modems can have up to 128
    channels open at one time.

    ### Parameters

    1. channel `number` The channel to open. This must be a number between 0 and 65535.

    ### Throws

    * If the channel is out of range.
    * If there are too many open channels.

isOpen(channel)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/modem/ModemPeripheral.java#L172)
:   Check if a channel is open.

    ### Parameters

    1. channel `number` The channel to check.

    ### Returns

    1. `boolean` Whether the channel is open.

    ### Throws

    * If the channel is out of range.

close(channel)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/modem/ModemPeripheral.java#L183)
:   Close an open channel, meaning it will no longer receive messages.

    ### Parameters

    1. channel `number` The channel to close.

    ### Throws

    * If the channel is out of range.

closeAll()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/modem/ModemPeripheral.java#L191)
:   Close all open channels.

transmit(channel, replyChannel, payload)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/modem/ModemPeripheral.java#L217)
:   Sends a modem message on a certain channel. Modems listening on the channel will queue a `modem_message`
    event on adjacent computers.

    ##### ð note

    The channel does not need be open to send a message.

    ### Parameters

    1. channel `number` The channel to send messages on.
    2. replyChannel `number` The channel that responses to this message should be sent on. This can be the same as
       `channel` or entirely different. The channel must have been [opened](modem.html#v:open) on
       the sending computer in order to receive the replies.
    3. payload `any` The object to send. This can be any primitive type (boolean, number, string) as well as
       tables. Other types (like functions), as well as metatables, will not be transmitted.

    ### Throws

    * If the channel is out of range.

    ### Usage

    * Wrap a modem and a message on channel 15, requesting a response on channel 43.

      ```
      local modem = peripheral.find("modem") or error("No modem attached", 0)
      modem.transmit(15, 43, "Hello, world!")
      ```

isWireless()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/modem/ModemPeripheral.java#L244)
:   Determine if this is a wired or wireless modem.

    Some methods (namely those dealing with wired networks and remote peripherals) are only available on wired
    modems.

    ### Returns

    1. `boolean` `true` if this is a wireless modem.

getNamesRemote()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/modem/wired/WiredModemPeripheral.java#L97)
:   List all remote peripherals on the wired network.

    If this computer is attached to the network, it *will not* be included in
    this list.

    ##### ð note

    This function only appears on wired modems. Check [`isWireless`](modem.html#v:isWireless) returns false before calling it.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } Remote peripheral names on the network.

isPresentRemote(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/modem/wired/WiredModemPeripheral.java#L114)
:   Determine if a peripheral is available on this wired network.

    ##### ð note

    This function only appears on wired modems. Check [`isWireless`](modem.html#v:isWireless) returns false before calling it.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The peripheral's name.

    ### Returns

    1. `boolean` boolean If a peripheral is present with the given name.

    ### See also

    * **[`peripheral.isPresent`](../module/peripheral.html#v:isPresent)**

getTypeRemote(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/modem/wired/WiredModemPeripheral.java#L132)
:   Get the type of a peripheral is available on this wired network.

    ##### ð note

    This function only appears on wired modems. Check [`isWireless`](modem.html#v:isWireless) returns false before calling it.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The peripheral's name.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The peripheral's type, or `nil` if it is not present.

    ### See also

    * **[`peripheral.getType`](../module/peripheral.html#v:getType)**

    ### Changes

    * **Changed in version 1.99:** Peripherals can have multiple types - this function returns multiple values.

hasTypeRemote(name, type)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/modem/wired/WiredModemPeripheral.java#L152)
:   Check a peripheral is of a particular type.

    ##### ð note

    This function only appears on wired modems. Check [`isWireless`](modem.html#v:isWireless) returns false before calling it.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The peripheral's name.
    2. type [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The type to check.

    ### Returns

    1. `boolean` | nil If a peripheral has a particular type, or `nil` if it is not present.

    ### See also

    * **[`peripheral.getType`](../module/peripheral.html#v:getType)**

    ### Changes

    * **New in version 1.99**

getMethodsRemote(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/modem/wired/WiredModemPeripheral.java#L170)
:   Get all available methods for the remote peripheral with the given name.

    ##### ð note

    This function only appears on wired modems. Check [`isWireless`](modem.html#v:isWireless) returns false before calling it.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The peripheral's name.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } | nil A list of methods provided by this peripheral, or `nil` if it is not present.

    ### See also

    * **[`peripheral.getMethods`](../module/peripheral.html#v:getMethods)**

callRemote(remoteName, method, ...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/modem/wired/WiredModemPeripheral.java#L195)
:   Call a method on a peripheral on this wired network.

    ##### ð note

    This function only appears on wired modems. Check [`isWireless`](modem.html#v:isWireless) returns false before calling it.

    ### Parameters

    1. remoteName [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the peripheral to invoke the method on.
    2. method [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the method
    3. ... Additional arguments to pass to the method

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The return values of the peripheral method.

    ### See also

    * **[`peripheral.call`](../module/peripheral.html#v:call)**

getNameLocal()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/modem/wired/WiredModemPeripheral.java#L217)
:   Returns the network name of the current computer, if the modem is on. This
    may be used by other computers on the network to wrap this computer as a
    peripheral.

    ##### ð note

    This function only appears on wired modems. Check [`isWireless`](modem.html#v:isWireless) returns false before calling it.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The current computer's name on the wired network.

    ### Changes

    * **New in version 1.80pr1.7**

---

## Source File: `peripheral/monitor.md`

# monitor

Monitors are a block which act as a terminal, displaying information on one side. This allows them to be read and
interacted with in-world without opening a GUI.

Monitors act as [terminal redirects](../module/term.html#ty:Redirect) and so expose the same methods, as well as several additional
ones, which are documented below.

If the monitor is resized (by adding new blocks to the monitor, or by calling [`setTextScale`](monitor.html#v:setTextScale)), then a
[`monitor_resize`](../event/monitor_resize.html) event will be queued.

Like computers, monitors come in both normal (no colour) and advanced (colour) varieties. Advanced monitors be right
clicked, which will trigger a [`monitor_touch`](../event/monitor_touch.html) event.

## Recipes

**Monitor**

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Glass Pane](/images/items/minecraft/glass_pane.png "Glass Pane")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Monitor](/images/items/computercraft/monitor_normal.png "Monitor")

**Advanced Monitor**

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Glass Pane](/images/items/minecraft/glass_pane.png "Glass Pane")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Advanced Monitor](/images/items/computercraft/monitor_advanced.png "Advanced Monitor")4

### Usage

* Write "Hello, world!" to an adjacent monitor:

  ```
  local monitor = peripheral.find("monitor")
  monitor.setCursorPos(1, 1)
  monitor.write("Hello, world!")
  ```

### See also

* **[`monitor_resize`](../event/monitor_resize.html)** Queued when a monitor is resized.
* **[`monitor_touch`](../event/monitor_touch.html)** Queued when an advanced monitor is clicked.

|  |  |
| --- | --- |
| [setTextScale(scale)](#v:setTextScale) | Set the scale of this monitor. |
| [getTextScale()](#v:getTextScale) | Get the monitor's current text scale. |
| [write(text)](#v:write) | Write `text` at the current cursor position, moving the cursor to the end of the text. |
| [scroll(y)](#v:scroll) | Move all positions up (or down) by `y` pixels. |
| [getCursorPos()](#v:getCursorPos) | Get the position of the cursor. |
| [setCursorPos(x, y)](#v:setCursorPos) | Set the position of the cursor. |
| [getCursorBlink()](#v:getCursorBlink) | Checks if the cursor is currently blinking. |
| [setCursorBlink(blink)](#v:setCursorBlink) | Sets whether the cursor should be visible (and blinking) at the current [cursor position](monitor.html#v:getCursorPos). |
| [getSize()](#v:getSize) | Get the size of the terminal. |
| [clear()](#v:clear) | Clears the terminal, filling it with the [current background colour](monitor.html#v:getBackgroundColour). |
| [clearLine()](#v:clearLine) | Clears the line the cursor is currently on, filling it with the [current background colour](monitor.html#v:getBackgroundColour). |
| [getTextColour()](#v:getTextColour) | Return the colour that new text will be written as. |
| [getTextColor()](#v:getTextColor) | Return the colour that new text will be written as. |
| [setTextColour(colour)](#v:setTextColour) | Set the colour that new text will be written as. |
| [setTextColor(colour)](#v:setTextColor) | Set the colour that new text will be written as. |
| [getBackgroundColour()](#v:getBackgroundColour) | Return the current background colour. |
| [getBackgroundColor()](#v:getBackgroundColor) | Return the current background colour. |
| [setBackgroundColour(colour)](#v:setBackgroundColour) | Set the current background colour. |
| [setBackgroundColor(colour)](#v:setBackgroundColor) | Set the current background colour. |
| [isColour()](#v:isColour) | Determine if this terminal supports colour. |
| [isColor()](#v:isColor) | Determine if this terminal supports colour. |
| [blit(text, textColour, backgroundColour)](#v:blit) | Writes `text` to the terminal with the specific foreground and background colours. |
| [setPaletteColour(...)](#v:setPaletteColour) | Set the palette for a specific colour. |
| [setPaletteColor(...)](#v:setPaletteColor) | Set the palette for a specific colour. |
| [getPaletteColour(colour)](#v:getPaletteColour) | Get the current palette for a specific colour. |
| [getPaletteColor(colour)](#v:getPaletteColor) | Get the current palette for a specific colour. |

setTextScale(scale)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/monitor/MonitorPeripheral.java#L66)
:   Set the scale of this monitor. A larger scale will result in the monitor having a lower resolution, but display
    text much larger.

    ### Parameters

    1. scale `number` The monitor's scale. This must be a multiple of 0.5 between 0.5 and 5.

    ### Throws

    * If the scale is out of range.

    ### See also

    * **[`getTextScale`](monitor.html#v:getTextScale)**

getTextScale()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/monitor/MonitorPeripheral.java#L80)
:   Get the monitor's current text scale.

    ### Returns

    1. `number` The monitor's current scale.

    ### Throws

    * If the monitor cannot be found.

    ### Changes

    * **New in version 1.81.0**

write(text)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L38)
:   Write `text` at the current cursor position, moving the cursor to the end of the text.

    Unlike functions like `write` and `print`, this does not wrap the text - it simply copies the
    text to the current terminal line.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The text to write.

scroll(y)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L57)
:   Move all positions up (or down) by `y` pixels.

    Every pixel in the terminal will be replaced by the line `y` pixels below it. If `y` is negative, it
    will copy pixels from above instead.

    ### Parameters

    1. y `number` The number of lines to move up by. This may be a negative number.

getCursorPos()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L70)
:   Get the position of the cursor.

    ### Returns

    1. `number` The x position of the cursor.
    2. `number` The y position of the cursor.

setCursorPos(x, y)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L83)
:   Set the position of the cursor. [terminal writes](monitor.html#v:write) will begin from this position.

    ### Parameters

    1. x `number` The new x position of the cursor.
    2. y `number` The new y position of the cursor.

getCursorBlink()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L98)
:   Checks if the cursor is currently blinking.

    ### Returns

    1. `boolean` If the cursor is blinking.

    ### Changes

    * **New in version 1.80pr1.9**

setCursorBlink(blink)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L109)
:   Sets whether the cursor should be visible (and blinking) at the current [cursor position](monitor.html#v:getCursorPos).

    ### Parameters

    1. blink `boolean` Whether the cursor should blink.

getSize()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L125)
:   Get the size of the terminal.

    ### Returns

    1. `number` The terminal's width.
    2. `number` The terminal's height.

clear()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L136)
:   Clears the terminal, filling it with the [current background colour](monitor.html#v:getBackgroundColour).

clearLine()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L147)
:   Clears the line the cursor is currently on, filling it with the [current background
    colour](monitor.html#v:getBackgroundColour).

getTextColour()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L160)
:   Return the colour that new text will be written as.

    ### Returns

    1. `number` The current text colour.

    ### See also

    * **[`colors`](../module/colors.html)** For a list of colour constants, returned by this function.

    ### Changes

    * **New in version 1.74**

getTextColor()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L160)
:   Return the colour that new text will be written as.

    ### Returns

    1. `number` The current text colour.

    ### See also

    * **[`colors`](../module/colors.html)** For a list of colour constants, returned by this function.

    ### Changes

    * **New in version 1.74**

setTextColour(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L174)
:   Set the colour that new text will be written as.

    ### Parameters

    1. colour `number` The new text colour.

    ### See also

    * **[`colors`](../module/colors.html)** For a list of colour constants.

    ### Changes

    * **New in version 1.45**
    * **Changed in version 1.80pr1:** Standard computers can now use all 16 colors, being changed to grayscale on screen.

setTextColor(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L174)
:   Set the colour that new text will be written as.

    ### Parameters

    1. colour `number` The new text colour.

    ### See also

    * **[`colors`](../module/colors.html)** For a list of colour constants.

    ### Changes

    * **New in version 1.45**
    * **Changed in version 1.80pr1:** Standard computers can now use all 16 colors, being changed to grayscale on screen.

getBackgroundColour()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L192)
:   Return the current background colour. This is used when [writing text](monitor.html#v:write) and [clearing](monitor.html#v:clear)
    the terminal.

    ### Returns

    1. `number` The current background colour.

    ### See also

    * **[`colors`](../module/colors.html)** For a list of colour constants, returned by this function.

    ### Changes

    * **New in version 1.74**

getBackgroundColor()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L192)
:   Return the current background colour. This is used when [writing text](monitor.html#v:write) and [clearing](monitor.html#v:clear)
    the terminal.

    ### Returns

    1. `number` The current background colour.

    ### See also

    * **[`colors`](../module/colors.html)** For a list of colour constants, returned by this function.

    ### Changes

    * **New in version 1.74**

setBackgroundColour(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L207)
:   Set the current background colour. This is used when [writing text](monitor.html#v:write) and [clearing](monitor.html#v:clear) the
    terminal.

    ### Parameters

    1. colour `number` The new background colour.

    ### See also

    * **[`colors`](../module/colors.html)** For a list of colour constants.

    ### Changes

    * **New in version 1.45**
    * **Changed in version 1.80pr1:** Standard computers can now use all 16 colors, being changed to grayscale on screen.

setBackgroundColor(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L207)
:   Set the current background colour. This is used when [writing text](monitor.html#v:write) and [clearing](monitor.html#v:clear) the
    terminal.

    ### Parameters

    1. colour `number` The new background colour.

    ### See also

    * **[`colors`](../module/colors.html)** For a list of colour constants.

    ### Changes

    * **New in version 1.45**
    * **Changed in version 1.80pr1:** Standard computers can now use all 16 colors, being changed to grayscale on screen.

isColour()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L226)
:   Determine if this terminal supports colour.

    Terminals which do not support colour will still allow writing coloured text/backgrounds, but it will be
    displayed in greyscale.

    ### Returns

    1. `boolean` Whether this terminal supports colour.

    ### Changes

    * **New in version 1.45**

isColor()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L226)
:   Determine if this terminal supports colour.

    Terminals which do not support colour will still allow writing coloured text/backgrounds, but it will be
    displayed in greyscale.

    ### Returns

    1. `boolean` Whether this terminal supports colour.

    ### Changes

    * **New in version 1.45**

blit(text, textColour, backgroundColour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L253)
:   Writes `text` to the terminal with the specific foreground and background colours.

    As with [`write`](monitor.html#v:write), the text will be written at the current cursor location, with the cursor
    moving to the end of the text.

    `textColour` and `backgroundColour` must both be strings the same length as `text`. All
    characters represent a single hexadecimal digit, which is converted to one of CC's colours. For instance,
    `"a"` corresponds to purple.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The text to write.
    2. textColour [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The corresponding text colours.
    3. backgroundColour [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The corresponding background colours.

    ### Throws

    * If the three inputs are not the same length.

    ### Usage

    * Prints "Hello, world!" in rainbow text.

      ```
      term.blit("Hello, world!","01234456789ab","0000000000000")
      ```

    ### See also

    * **[`colors`](../module/colors.html)** For a list of colour constants, and their hexadecimal values.

    ### Changes

    * **New in version 1.74**
    * **Changed in version 1.80pr1:** Standard computers can now use all 16 colors, being changed to grayscale on screen.

setPaletteColour(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L299)
:   Set the palette for a specific colour.

    ComputerCraft's palette system allows you to change how a specific colour should be displayed. For instance, you
    can make [`colors.red`](../module/colors.html#v:red) *more red* by setting its palette to #FF0000. This does now allow you to draw more
    colours - you are still limited to 16 on the screen at one time - but you can change *which* colours are
    used.

    ### Parameters

    1. index `number` The colour whose palette should be changed.
    2. colour `number` A 24-bit integer representing the RGB value of the colour. For instance the integer
       `0xFF0000` corresponds to the colour #FF0000.

    #### Or

    1. index `number` The colour whose palette should be changed.
    2. r `number` The intensity of the red channel, between 0 and 1.
    3. g `number` The intensity of the green channel, between 0 and 1.
    4. b `number` The intensity of the blue channel, between 0 and 1.

    ### Usage

    * Change the [red colour](../module/colors.html#v:red) from the default #CC4C4C to #FF0000.

      ```
      term.setPaletteColour(colors.red, 0xFF0000)
      term.setTextColour(colors.red)
      print("Hello, world!")
      ```
    * As above, but specifying each colour channel separately.

      ```
      term.setPaletteColour(colors.red, 1, 0, 0)
      term.setTextColour(colors.red)
      print("Hello, world!")
      ```

    ### See also

    * **[`colors.unpackRGB`](../module/colors.html#v:unpackRGB)** To convert from the 24-bit format to three separate channels.
    * **[`colors.packRGB`](../module/colors.html#v:packRGB)** To convert from three separate channels to the 24-bit format.

    ### Changes

    * **New in version 1.80pr1**

setPaletteColor(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L299)
:   Set the palette for a specific colour.

    ComputerCraft's palette system allows you to change how a specific colour should be displayed. For instance, you
    can make [`colors.red`](../module/colors.html#v:red) *more red* by setting its palette to #FF0000. This does now allow you to draw more
    colours - you are still limited to 16 on the screen at one time - but you can change *which* colours are
    used.

    ### Parameters

    1. index `number` The colour whose palette should be changed.
    2. colour `number` A 24-bit integer representing the RGB value of the colour. For instance the integer
       `0xFF0000` corresponds to the colour #FF0000.

    #### Or

    1. index `number` The colour whose palette should be changed.
    2. r `number` The intensity of the red channel, between 0 and 1.
    3. g `number` The intensity of the green channel, between 0 and 1.
    4. b `number` The intensity of the blue channel, between 0 and 1.

    ### Usage

    * Change the [red colour](../module/colors.html#v:red) from the default #CC4C4C to #FF0000.

      ```
      term.setPaletteColour(colors.red, 0xFF0000)
      term.setTextColour(colors.red)
      print("Hello, world!")
      ```
    * As above, but specifying each colour channel separately.

      ```
      term.setPaletteColour(colors.red, 1, 0, 0)
      term.setTextColour(colors.red)
      print("Hello, world!")
      ```

    ### See also

    * **[`colors.unpackRGB`](../module/colors.html#v:unpackRGB)** To convert from the 24-bit format to three separate channels.
    * **[`colors.packRGB`](../module/colors.html#v:packRGB)** To convert from three separate channels to the 24-bit format.

    ### Changes

    * **New in version 1.80pr1**

getPaletteColour(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L325)
:   Get the current palette for a specific colour.

    ### Parameters

    1. colour `number` The colour whose palette should be fetched.

    ### Returns

    1. `number` The red channel, will be between 0 and 1.
    2. `number` The green channel, will be between 0 and 1.
    3. `number` The blue channel, will be between 0 and 1.

    ### Changes

    * **New in version 1.80pr1**

getPaletteColor(colour)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/TermMethods.java#L325)
:   Get the current palette for a specific colour.

    ### Parameters

    1. colour `number` The colour whose palette should be fetched.

    ### Returns

    1. `number` The red channel, will be between 0 and 1.
    2. `number` The green channel, will be between 0 and 1.
    3. `number` The blue channel, will be between 0 and 1.

    ### Changes

    * **New in version 1.80pr1**

---

## Source File: `peripheral/printer.md`

# printer

The printer peripheral allows printing text onto pages. These pages can then be crafted together into printed pages
or books.

Printers require ink (one of the coloured dyes) and paper in order to function. Once loaded, a new page can be
started with [`newPage`](printer.html#v:newPage). Then the printer can be used similarly to a normal terminal; [text can be written](printer.html#v:write), and [the cursor moved](printer.html#v:setCursorPos). Once all text has
been printed, [`endPage`](printer.html#v:endPage) should be called to finally print the page.

## Recipes

**Printer**

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Redstone Dust](/images/items/minecraft/redstone.png "Redstone Dust")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Black Dye](/images/items/minecraft/black_dye.png "Black Dye")

![Stone](/images/items/minecraft/stone.png "Stone")

![Printer](/images/items/computercraft/printer.png "Printer")

**Printed Pages**

![Printed Page](/images/items/computercraft/printed_page.png "Printed Page")

![Printed Page](/images/items/computercraft/printed_page.png "Printed Page")

![String](/images/items/minecraft/string.png "String")

![Printed Pages](/images/items/computercraft/printed_pages.png "Printed Pages")

**Printed Book**

![Leather](/images/items/minecraft/leather.png "Leather")

![Printed Page](/images/items/computercraft/printed_page.png "Printed Page")

![String](/images/items/minecraft/string.png "String")

![Printed Book](/images/items/computercraft/printed_book.png "Printed Book")

### Usage

* Print a page titled "Hello" with a small message on it.

  ```
  local printer = peripheral.find("printer")

  -- Start a new page, or print an error.
  if not printer.newPage() then
    error("Cannot start a new page. Do you have ink and paper?")
  end

  -- Write to the page
  printer.setPageTitle("Hello")
  printer.write("This is my first page")
  printer.setCursorPos(1, 3)
  printer.write("This is two lines below.")

  -- And finally print the page!
  if not printer.endPage() then
    error("Cannot end the page. Is there enough space?")
  end
  ```

### See also

* **[`cc.strings.wrap`](../library/cc.strings.html#v:wrap)** To wrap text before printing it.

|  |  |
| --- | --- |
| [write(text)](#v:write) | Writes text to the current page. |
| [getCursorPos()](#v:getCursorPos) | Returns the current position of the cursor on the page. |
| [setCursorPos(x, y)](#v:setCursorPos) | Sets the position of the cursor on the page. |
| [getPageSize()](#v:getPageSize) | Returns the size of the current page. |
| [newPage()](#v:newPage) | Starts printing a new page. |
| [endPage()](#v:endPage) | Finalizes printing of the current page and outputs it to the tray. |
| [setPageTitle([title])](#v:setPageTitle) | Sets the title of the current page. |
| [getInkLevel()](#v:getInkLevel) | Returns the amount of ink left in the printer. |
| [getPaperLevel()](#v:getPaperLevel) | Returns the amount of paper left in the printer. |

write(text)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/printer/PrinterPeripheral.java#L81)
:   Writes text to the current page.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The value to write to the page.

    ### Throws

    * If any values couldn't be converted to a string, or if no page is started.

getCursorPos()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/printer/PrinterPeripheral.java#L97)
:   Returns the current position of the cursor on the page.

    ### Returns

    1. `number` The X position of the cursor.
    2. `number` The Y position of the cursor.

    ### Throws

    * If a page isn't being printed.

setCursorPos(x, y)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/printer/PrinterPeripheral.java#L112)
:   Sets the position of the cursor on the page.

    ### Parameters

    1. x `number` The X coordinate to set the cursor at.
    2. y `number` The Y coordinate to set the cursor at.

    ### Throws

    * If a page isn't being printed.

getPageSize()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/printer/PrinterPeripheral.java#L126)
:   Returns the size of the current page.

    ### Returns

    1. `number` The width of the page.
    2. `number` The height of the page.

    ### Throws

    * If a page isn't being printed.

newPage()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/printer/PrinterPeripheral.java#L139)
:   Starts printing a new page.

    ### Returns

    1. `boolean` Whether a new page could be started.

endPage()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/printer/PrinterPeripheral.java#L150)
:   Finalizes printing of the current page and outputs it to the tray.

    ### Returns

    1. `boolean` Whether the page could be successfully finished.

    ### Throws

    * If a page isn't being printed.

setPageTitle([title])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/printer/PrinterPeripheral.java#L162)
:   Sets the title of the current page.

    ### Parameters

    1. title? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The title to set for the page.

    ### Throws

    * If a page isn't being printed.

getInkLevel()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/printer/PrinterPeripheral.java#L173)
:   Returns the amount of ink left in the printer.

    ### Returns

    1. `number` The amount of ink available to print with.

getPaperLevel()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/printer/PrinterPeripheral.java#L183)
:   Returns the amount of paper left in the printer.

    ### Returns

    1. `number` The amount of paper available to print with.

---

## Source File: `peripheral/redstone_relay.md`

# redstone\_relay

The redstone relay is a peripheral that allows reading and outputting redstone signals. While this is not very useful
on its own (as computers have the same functionality [built-in](../module/redstone.html)), this can be used with [wired
modems](modem.html) to interact with multiple redstone signals from the same computer.

The peripheral provides largely identical methods to a computer's built-in [`redstone`](../module/redstone.html) API, allowing setting
signals on all six sides of the block ("top", "bottom", "left", "right", "front" and "back").

## Recipe

**Redstone Relay**

![Stone](/images/items/minecraft/stone.png "Stone")

![Redstone Dust](/images/items/minecraft/redstone.png "Redstone Dust")

![Stone](/images/items/minecraft/stone.png "Stone")

![Redstone Dust](/images/items/minecraft/redstone.png "Redstone Dust")

![Wired Modem](/images/items/computercraft/wired_modem.png "Wired Modem")

![Redstone Dust](/images/items/minecraft/redstone.png "Redstone Dust")

![Stone](/images/items/minecraft/stone.png "Stone")

![Redstone Dust](/images/items/minecraft/redstone.png "Redstone Dust")

![Stone](/images/items/minecraft/stone.png "Stone")

![Redstone Relay](/images/items/computercraft/redstone_relay.png "Redstone Relay")

### Usage

* Toggle the redstone signal above the computer every 0.5 seconds.

  ```
  local relay = peripheral.find("redstone_relay")
  while true do
    relay.setOutput("top", not relay.getOutput("top"))
    sleep(0.5)
  end
  ```

### Changes

* **New in version 1.114.0**

|  |  |
| --- | --- |
| [setOutput(side, on)](#v:setOutput) | Turn the redstone signal of a specific side on or off. |
| [getOutput(side)](#v:getOutput) | Get the current redstone output of a specific side. |
| [getInput(side)](#v:getInput) | Get the current redstone input of a specific side. |
| [setAnalogOutput(side, value)](#v:setAnalogOutput) | Set the redstone signal strength for a specific side. |
| [setAnalogueOutput(side, value)](#v:setAnalogueOutput) | Set the redstone signal strength for a specific side. |
| [getAnalogOutput(side)](#v:getAnalogOutput) | Get the redstone output signal strength for a specific side. |
| [getAnalogueOutput(side)](#v:getAnalogueOutput) | Get the redstone output signal strength for a specific side. |
| [getAnalogInput(side)](#v:getAnalogInput) | Get the redstone input signal strength for a specific side. |
| [getAnalogueInput(side)](#v:getAnalogueInput) | Get the redstone input signal strength for a specific side. |
| [setBundledOutput(side, output)](#v:setBundledOutput) | Set the bundled cable output for a specific side. |
| [getBundledOutput(side)](#v:getBundledOutput) | Get the bundled cable output for a specific side. |
| [getBundledInput(side)](#v:getBundledInput) | Get the bundled cable input for a specific side. |
| [testBundledInput(side, mask)](#v:testBundledInput) | Determine if a specific combination of colours are on for the given side. |

setOutput(side, on)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L27)
:   Turn the redstone signal of a specific side on or off.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to set.
    2. on `boolean` Whether the redstone signal should be on or off. When on, a signal strength of 15 is emitted.

getOutput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L39)
:   Get the current redstone output of a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `boolean` Whether the redstone output is on or off.

    ### See also

    * **[`setOutput`](redstone_relay.html#v:setOutput)**

getInput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L50)
:   Get the current redstone input of a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `boolean` Whether the redstone input is on or off.

setAnalogOutput(side, value)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L63)
:   Set the redstone signal strength for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to set.
    2. value `number` The signal strength between 0 and 15.

    ### Throws

    * If `value` is not between 0 and 15.

    ### Changes

    * **New in version 1.51**

setAnalogueOutput(side, value)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L63)
:   Set the redstone signal strength for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to set.
    2. value `number` The signal strength between 0 and 15.

    ### Throws

    * If `value` is not between 0 and 15.

    ### Changes

    * **New in version 1.51**

getAnalogOutput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L77)
:   Get the redstone output signal strength for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `number` The output signal strength, between 0 and 15.

    ### See also

    * **[`setAnalogOutput`](redstone_relay.html#v:setAnalogOutput)**

    ### Changes

    * **New in version 1.51**

getAnalogueOutput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L77)
:   Get the redstone output signal strength for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `number` The output signal strength, between 0 and 15.

    ### See also

    * **[`setAnalogOutput`](redstone_relay.html#v:setAnalogOutput)**

    ### Changes

    * **New in version 1.51**

getAnalogInput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L89)
:   Get the redstone input signal strength for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `number` The input signal strength, between 0 and 15.

    ### Changes

    * **New in version 1.51**

getAnalogueInput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L89)
:   Get the redstone input signal strength for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `number` The input signal strength, between 0 and 15.

    ### Changes

    * **New in version 1.51**

setBundledOutput(side, output)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L102)
:   Set the bundled cable output for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to set.
    2. output `number` The colour bitmask to set.

    ### See also

    * **[`colors.subtract`](../module/colors.html#v:subtract)** For removing a colour from the bitmask.
    * **[`colors.combine`](../module/colors.html#v:combine)** For adding a color to the bitmask.

getBundledOutput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L113)
:   Get the bundled cable output for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `number` The bundle cable's output.

getBundledInput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L125)
:   Get the bundled cable input for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `number` The bundle cable's input.

    ### See also

    * **[`testBundledInput`](redstone_relay.html#v:testBundledInput)** To determine if a specific colour is set.

testBundledInput(side, mask)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L142)
:   Determine if a specific combination of colours are on for the given side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to test.
    2. mask `number` The mask to test.

    ### Returns

    1. `boolean` If the colours are on.

    ### Usage

    * Check if [`colors.white`](../module/colors.html#v:white) and [`colors.black`](../module/colors.html#v:black) are on above this block.

      ```
      print(redstone.testBundledInput("top", colors.combine(colors.white, colors.black)))
      ```

    ### See also

    * **[`getBundledInput`](redstone_relay.html#v:getBundledInput)**

---

## Source File: `peripheral/speaker.md`

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