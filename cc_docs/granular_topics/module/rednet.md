# rednet

Communicate with other computers by using [modems](../peripheral/modem.html). [`rednet`](rednet.html)
provides a layer of abstraction on top of the main [`modem`](../peripheral/modem.html) peripheral, making
it slightly easier to use.

## Basic usage

In order to send a message between two computers, each computer must have a
modem on one of its sides (or in the case of pocket computers and turtles, the
modem must be equipped as an upgrade). The two computers should then call
[`rednet.open`](rednet.html#v:open), which sets up the modems ready to send and receive messages.

Once rednet is opened, you can send messages using [`rednet.send`](rednet.html#v:send) and receive
them using [`rednet.receive`](rednet.html#v:receive). It's also possible to send a message to *every*
rednet-using computer using [`rednet.broadcast`](rednet.html#v:broadcast).

##### â  Network security

While rednet provides a friendly way to send messages to specific computers, it
doesn't provide any guarantees about security. Other computers could be
listening in to your messages, or even pretending to send messages from other computers!

If you're playing on a multi-player server (or at least one where you don't
trust other players), it's worth encrypting or signing your rednet messages.

## Protocols and hostnames

Several rednet messages accept "protocol"s - simple string names describing what
a message is about. When sending messages using [`rednet.send`](rednet.html#v:send) and
[`rednet.broadcast`](rednet.html#v:broadcast), you can optionally specify a protocol for the message. This
same protocol can then be given to [`rednet.receive`](rednet.html#v:receive), to ignore all messages not
using this protocol.

It's also possible to look-up computers based on protocols, providing a basic
system for service discovery and [DNS](https://en.wikipedia.org/wiki/Domain_Name_System "Domain Name System"). A computer can advertise that it
supports a particular protocol with [`rednet.host`](rednet.html#v:host), also providing a friendly
"hostname". Other computers may then find all computers which support this
protocol using [`rednet.lookup`](rednet.html#v:lookup).

### See also

* **[`rednet_message`](../event/rednet_message.html)** Queued when a rednet message is received.
* **[`modem`](../peripheral/modem.html)** Rednet is built on top of the modem peripheral. Modems provide a more
  bare-bones but flexible interface.

### Changes

* **New in version 1.2**

|  |  |
| --- | --- |
| [CHANNEL\_BROADCAST = 65535](#v:CHANNEL_BROADCAST) | The channel used by the Rednet API to [`broadcast`](rednet.html#v:broadcast) messages. |
| [CHANNEL\_REPEAT = 65533](#v:CHANNEL_REPEAT) | The channel used by the Rednet API to repeat messages. |
| [MAX\_ID\_CHANNELS = 65500](#v:MAX_ID_CHANNELS) | The number of channels rednet reserves for computer IDs. |
| [open(modem)](#v:open) | Opens a modem with the given [`peripheral`](peripheral.html) name, allowing it to send and receive messages over rednet. |
| [close([modem])](#v:close) | Close a modem with the given [`peripheral`](peripheral.html) name, meaning it can no longer send and receive rednet messages. |
| [isOpen([modem])](#v:isOpen) | Determine if rednet is currently open. |
| [send(recipient, message [, protocol])](#v:send) | Allows a computer or turtle with an attached modem to send a message intended for a computer with a specific ID. |
| [broadcast(message [, protocol])](#v:broadcast) | Broadcasts a string message over the predefined [`CHANNEL_BROADCAST`](rednet.html#v:CHANNEL_BROADCAST) channel. |
| [receive([protocol\_filter [, timeout]])](#v:receive) | Wait for a rednet message to be received, or until `nTimeout` seconds have elapsed. |
| [host(protocol, hostname)](#v:host) | Register the system as "hosting" the desired protocol under the specified name. |
| [unhost(protocol)](#v:unhost) | Stop [hosting](rednet.html#v:host) a specific protocol, meaning it will no longer respond to [`rednet.lookup`](rednet.html#v:lookup) requests. |
| [lookup(protocol [, hostname])](#v:lookup) | Search the local rednet network for systems [hosting](rednet.html#v:host) the desired protocol and returns any computer IDs that respond as "r... |
| [run()](#v:run) | Listen for modem messages and converts them into rednet messages, which may then be [received](rednet.html#v:receive). |

CHANNEL\_BROADCAST = 65535[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L53)
:   The channel used by the Rednet API to [`broadcast`](rednet.html#v:broadcast) messages.

CHANNEL\_REPEAT = 65533[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L56)
:   The channel used by the Rednet API to repeat messages.

MAX\_ID\_CHANNELS = 65500[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L60)
:   The number of channels rednet reserves for computer IDs. Computers with IDs
    greater or equal to this limit wrap around to 0.

open(modem)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L91)
:   Opens a modem with the given [`peripheral`](peripheral.html) name, allowing it to send and
    receive messages over rednet.

    This will open the modem on two channels: one which has the same
    [ID](os.html#v:getComputerID) as the computer, and another on
    [the broadcast channel](rednet.html#v:CHANNEL_BROADCAST).

    ### Parameters

    1. modem [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the modem to open.

    ### Throws

    * If there is no such modem with the given name

    ### Usage

    * Open rednet on the back of the computer, allowing you to send and receive
      rednet messages using it.

      ```
      rednet.open("back")
      ```
    * Open rednet on all attached modems. This abuses the "filter" argument to
      [`peripheral.find`](peripheral.html#v:find).

      ```
      peripheral.find("modem", rednet.open)
      ```

    ### See also

    * **[`rednet.close`](rednet.html#v:close)**
    * **[`rednet.isOpen`](rednet.html#v:isOpen)**

close([modem])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L107)
:   Close a modem with the given [`peripheral`](peripheral.html) name, meaning it can no longer
    send and receive rednet messages.

    ### Parameters

    1. modem? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side the modem exists on. If not given, all
       open modems will be closed.

    ### Throws

    * If there is no such modem with the given name

    ### See also

    * **[`rednet.open`](rednet.html#v:open)**

isOpen([modem])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L133)
:   Determine if rednet is currently open.

    ### Parameters

    1. modem? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Which modem to check. If not given, all connected
       modems will be checked.

    ### Returns

    1. `boolean` If the given modem is open.

    ### See also

    * **[`rednet.open`](rednet.html#v:open)**

    ### Changes

    * **New in version 1.31**

send(recipient, message [, protocol])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L176)
:   Allows a computer or turtle with an attached modem to send a message
    intended for a computer with a specific ID. At least one such modem must first
    be [opened](rednet.html#v:open) before sending is possible.

    Assuming the target was in range and also had a correctly opened modem, the
    target computer may then use [`rednet.receive`](rednet.html#v:receive) to collect the message.

    ### Parameters

    1. recipient `number` The ID of the receiving computer.
    2. message The message to send. Like with [`modem.transmit`](../peripheral/modem.html#v:transmit), this can
       contain any primitive type (numbers, booleans and strings) as well as
       tables. Other types (like functions), as well as metatables, will not be
       transmitted.
    3. protocol? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The "protocol" to send this message under. When
       using [`rednet.receive`](rednet.html#v:receive) one can filter to only receive messages sent under a
       particular protocol.

    ### Returns

    1. `boolean` If this message was successfully sent (i.e. if rednet is
       currently [open](rednet.html#v:open)). Note, this does not guarantee the message was
       actually *received*.

    ### Usage

    * Send a message to computer #2.

      ```
      rednet.send(2, "Hello from rednet!")
      ```

    ### See also

    * **[`rednet.receive`](rednet.html#v:receive)**

    ### Changes

    * **Changed in version 1.6:** Added protocol parameter.
    * **Changed in version 1.82.0:** Now returns whether the message was successfully sent.

broadcast(message [, protocol])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L233)
:   Broadcasts a string message over the predefined [`CHANNEL_BROADCAST`](rednet.html#v:CHANNEL_BROADCAST)
    channel. The message will be received by every device listening to rednet.

    ### Parameters

    1. message The message to send. This should not contain coroutines or
       functions, as they will be converted to `nil`.
    2. protocol? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The "protocol" to send this message under. When
       using [`rednet.receive`](rednet.html#v:receive) one can filter to only receive messages sent under a
       particular protocol.

    ### Usage

    * Broadcast the words "Hello, world!" to every computer using rednet.

      ```
      rednet.broadcast("Hello, world!")
      ```

    ### See also

    * **[`rednet.receive`](rednet.html#v:receive)**

    ### Changes

    * **Changed in version 1.6:** Added protocol parameter.

receive([protocol\_filter [, timeout]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L276)
:   Wait for a rednet message to be received, or until `nTimeout` seconds have
    elapsed.

    ### Parameters

    1. protocol\_filter? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The protocol the received message must be
       sent with. If specified, any messages not sent under this protocol will be
       discarded.
    2. timeout? `number` The number of seconds to wait if no message is
       received.

    ### Returns

    1. `number` The computer which sent this message
    2. The received message
    3. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The protocol this message was sent under.

    #### Or

    1. nil If the timeout elapsed and no message was received.

    ### Usage

    * Receive a rednet message.

      ```
      local id, message = rednet.receive()
      print(("Computer %d sent message %s"):format(id, message))
      ```
    * Receive a message, stopping after 5 seconds if no message was received.

      ```
      local id, message = rednet.receive(nil, 5)
      if not id then
          printError("No message received")
      else
          print(("Computer %d sent message %s"):format(id, message))
      end
      ```
    * Receive a message from computer #2.

      ```
      local id, message
      repeat
          id, message = rednet.receive()
      until id == 2

      print(message)
      ```

    ### See also

    * **[`rednet.broadcast`](rednet.html#v:broadcast)**
    * **[`rednet.send`](rednet.html#v:send)**

    ### Changes

    * **Changed in version 1.6:** Added protocol filter parameter.

host(protocol, hostname)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L332)
:   Register the system as "hosting" the desired protocol under the specified
    name. If a rednet [lookup](rednet.html#v:lookup) is performed for that protocol (and
    maybe name) on the same network, the registered system will automatically
    respond via a background process, hence providing the system performing the
    lookup with its ID number.

    Multiple computers may not register themselves on the same network as having the
    same names against the same protocols, and the title `localhost` is specifically
    reserved. They may, however, share names as long as their hosted protocols are
    different, or if they only join a given network after "registering" themselves
    before doing so (eg while offline or part of a different network).

    ### Parameters

    1. protocol [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The protocol this computer provides.
    2. hostname [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name this computer exposes for the given protocol.

    ### Throws

    * If trying to register a hostname which is reserved, or currently in use.

    ### See also

    * **[`rednet.unhost`](rednet.html#v:unhost)**
    * **[`rednet.lookup`](rednet.html#v:lookup)**

    ### Changes

    * **New in version 1.6**

unhost(protocol)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L351)
:   Stop [hosting](rednet.html#v:host) a specific protocol, meaning it will no longer
    respond to [`rednet.lookup`](rednet.html#v:lookup) requests.

    ### Parameters

    1. protocol [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The protocol to unregister your self from.

    ### Changes

    * **New in version 1.6**

lookup(protocol [, hostname])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L388)
:   Search the local rednet network for systems [hosting](rednet.html#v:host) the
    desired protocol and returns any computer IDs that respond as "registered"
    against it.

    If a hostname is specified, only one ID will be returned (assuming an exact
    match is found).

    ### Parameters

    1. protocol [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The protocol to search for.
    2. hostname? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The hostname to search for.

    ### Returns

    1. `number`... A list of computer IDs hosting the given protocol.

    #### Or

    1. `number` | nil The computer ID with the provided hostname and protocol,
       or `nil` if none exists.

    ### Usage

    * Find all computers which are hosting the `"chat"` protocol.

      ```
      local computers = {rednet.lookup("chat")}
      print(#computers .. " computers available to chat")
      for _, computer in pairs(computers) do
        print("Computer #" .. computer)
      end
      ```
    * Find a computer hosting the `"chat"` protocol with a hostname of `"my_host"`.

      ```
      local id = rednet.lookup("chat", "my_host")
      if id then
        print("Found my_host at computer #" .. id)
      else
        printError("Cannot find my_host")
      end
      ```

    ### Changes

    * **New in version 1.6**

run()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/rednet.lua#L461)
:   Listen for modem messages and converts them into rednet messages, which may
    then be [received](rednet.html#v:receive).

    This is automatically started in the background on computer startup, and
    should not be called manually.