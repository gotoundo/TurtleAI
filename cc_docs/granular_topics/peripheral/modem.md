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