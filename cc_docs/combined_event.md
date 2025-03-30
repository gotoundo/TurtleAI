# EVENT Documentation

## Source File: `event/alarm.md`

# alarm

The [`alarm`](alarm.html) event is fired when an alarm started with [`os.setAlarm`](../module/os.html#v:setAlarm) completes.

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. `number`: The ID of the alarm that finished.

## Example

Starts a timer and then waits for it to complete.

```
local alarm_id = os.setAlarm(os.time() + 0.05)
local event, id
repeat
    event, id = os.pullEvent("alarm")
until id == alarm_id
print("Alarm with ID " .. id .. " was fired")
```

### See also

* **[`os.setAlarm`](../module/os.html#v:setAlarm)** To start an alarm.

---

## Source File: `event/char.md`

# char

The [`char`](char.html) event is fired when a character is typed on the keyboard.

The [`char`](char.html) event is different to a key press. Sometimes multiple key presses may result in one character being
typed (for instance, on some European keyboards). Similarly, some keys (e.g. `Ctrl`) do not have any
corresponding character. The [`key`](key.html) should be used if you want to listen to key presses themselves.

## Return values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The string representing the character that was pressed.

## Example

Prints each character the user presses:

```
while true do
    local event, character = os.pullEvent("char")
    print(character .. " was pressed.")
end
```

### See also

* **[`key`](key.html)** To listen to any key press.

---

## Source File: `event/computer_command.md`

# computer\_command

The [`computer_command`](computer_command.html) event is fired when the `/computercraft queue` command is run for the current computer.

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)â¦: The arguments passed to the command.

## Example

Prints the contents of messages sent:

```
while true do
  local event = {os.pullEvent("computer_command")}
  print("Received message:", table.unpack(event, 2))
end
```

---

## Source File: `event/disk.md`

# disk

The [`disk`](../module/disk.html) event is fired when a disk is inserted into an adjacent or networked disk drive.

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The side of the disk drive that had a disk inserted.

## Example

Prints a message when a disk is inserted:

```
while true do
  local event, side = os.pullEvent("disk")
  print("Inserted a disk on side " .. side)
end
```

### See also

* **[`disk_eject`](disk_eject.html)** For the event sent when a disk is removed.

---

## Source File: `event/disk_eject.md`

# disk\_eject

The [`disk_eject`](disk_eject.html) event is fired when a disk is removed from an adjacent or networked disk drive.

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The side of the disk drive that had a disk removed.

## Example

Prints a message when a disk is removed:

```
while true do
  local event, side = os.pullEvent("disk_eject")
  print("Removed a disk on side " .. side)
end
```

### See also

* **[`disk`](../module/disk.html)** For the event sent when a disk is inserted.

---

## Source File: `event/file_transfer.md`

# file\_transfer

The [`file_transfer`](file_transfer.html) event is queued when a user drags-and-drops a file on an open computer.

This event contains a single argument of type [`TransferredFiles`](file_transfer.html#ty:TransferredFiles), which can be used to [get the files to be
transferred](file_transfer.html#ty:TransferredFiles:getFiles). Each file returned is a [binary file handle](../module/fs.html#ty:ReadHandle) with an
additional [getName](file_transfer.html#ty:TransferredFile:getName) method.

## Return values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name
2. [`TransferredFiles`](file_transfer.html#ty:TransferredFiles): The list of transferred files.

## Example

Waits for a user to drop files on top of the computer, then prints the list of files and the size of each file.

```
local _, files = os.pullEvent("file_transfer")
for _, file in ipairs(files.getFiles()) do
  -- Seek to the end of the file to get its size, then go back to the beginning.
  local size = file.seek("end")
  file.seek("set", 0)

  print(file.getName() .. " " .. size)
end
```

## Example

Save each transferred file to the computer's storage.

```
local _, files = os.pullEvent("file_transfer")
for _, file in ipairs(files.getFiles()) do
  local handle = fs.open(file.getName(), "wb")
  handle.write(file.readAll())

  handle.close()
  file.close()
end
```

### Changes

* **New in version 1.101.0**

### Types

### TransferredFiles

A list of files that have been transferred to this computer.

TransferredFiles.getFiles()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/transfer/TransferredFiles.java#L40)
:   All the files that are being transferred to this computer.

    ### Returns

    1. { [`file_transfer.TransferredFile`](file_transfer.html#ty:TransferredFile)... } The list of files.

### TransferredFile

A binary file handle that has been transferred to this computer.

This inherits all methods of [binary file handles](../module/fs.html#ty:ReadHandle), meaning you can use the standard
[read functions](../module/fs.html#ty:ReadHandle:read) to access the contents of the file.

### See also

* **[`fs.ReadHandle`](../module/fs.html#ty:ReadHandle)**

TransferredFile.getName()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/transfer/TransferredFile.java#L38)
:   Get the name of this file being transferred.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The file's name.

---

## Source File: `event/http_check.md`

# http\_check

The [`http_check`](http_check.html) event is fired when a URL check finishes.

This event is normally handled inside [`http.checkURL`](../module/http.html#v:checkURL), but it can still be seen when using [`http.checkURLAsync`](../module/http.html#v:checkURLAsync).

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The URL requested to be checked.
3. `boolean`: Whether the check succeeded.
4. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)|`nil`: If the check failed, a reason explaining why the check failed.

### See also

* **[`http.checkURLAsync`](../module/http.html#v:checkURLAsync)** To check a URL asynchronously.

---

## Source File: `event/http_failure.md`

# http\_failure

The [`http_failure`](http_failure.html) event is fired when an HTTP request fails.

This event is normally handled inside [`http.get`](../module/http.html#v:get) and [`http.post`](../module/http.html#v:post), but it can still be seen when using [`http.request`](../module/http.html#v:request).

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The URL of the site requested.
3. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): An error describing the failure.
4. [`http.Response`](../module/http.html#ty:Response)|`nil`: A response handle if the connection succeeded, but the server's
   response indicated failure.

## Example

Prints an error why the website cannot be contacted:

```
local myURL = "https://does.not.exist.tweaked.cc"
http.request(myURL)
local event, url, err
repeat
    event, url, err = os.pullEvent("http_failure")
until url == myURL
print("The URL " .. url .. " could not be reached: " .. err)
```

Prints the contents of a webpage that does not exist:

```
local myURL = "https://tweaked.cc/this/does/not/exist"
http.request(myURL)
local event, url, err, handle
repeat
    event, url, err, handle = os.pullEvent("http_failure")
until url == myURL
print("The URL " .. url .. " could not be reached: " .. err)
print(handle.getResponseCode())
handle.close()
```

### See also

* **[`http.request`](../module/http.html#v:request)** To send an HTTP request.

---

## Source File: `event/http_success.md`

# http\_success

The [`http_success`](http_success.html) event is fired when an HTTP request returns successfully.

This event is normally handled inside [`http.get`](../module/http.html#v:get) and [`http.post`](../module/http.html#v:post), but it can still be seen when using [`http.request`](../module/http.html#v:request).

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The URL of the site requested.
3. [`http.Response`](../module/http.html#ty:Response): The successful HTTP response.

## Example

Prints the content of a website (this may fail if the request fails):

```
local myURL = "https://tweaked.cc/"
http.request(myURL)
local event, url, handle
repeat
    event, url, handle = os.pullEvent("http_success")
until url == myURL
print("Contents of " .. url .. ":")
print(handle.readAll())
handle.close()
```

### See also

* **[`http.request`](../module/http.html#v:request)** To make an HTTP request.

---

## Source File: `event/key.md`

# key

This event is fired when any key is pressed while the terminal is focused.

This event returns a numerical "key code" (for instance, `F1` is 290). This value may vary between versions and
so it is recommended to use the constants in the [`keys`](../module/keys.html) API rather than hard coding numeric values.

If the button pressed represented a printable character, then the [`key`](key.html) event will be followed immediately by a [`char`](char.html)
event. If you are consuming text input, use a [`char`](char.html) event instead!

## Return values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. `number`: The numerical key value of the key pressed.
3. `boolean`: Whether the key event was generated while holding the key (`true`), rather than pressing it the first time (`false`).

## Example

Prints each key when the user presses it, and if the key is being held.

```
while true do
  local event, key, is_held = os.pullEvent("key")
  print(("%s held=%s"):format(keys.getName(key), is_held))
end
```

---

## Source File: `event/key_up.md`

# key\_up

Fired whenever a key is released (or the terminal is closed while a key was being pressed).

This event returns a numerical "key code" (for instance, `F1` is 290). This value may vary between versions and
so it is recommended to use the constants in the [`keys`](../module/keys.html) API rather than hard coding numeric values.

## Return values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. `number`: The numerical key value of the key pressed.

## Example

Prints each key released on the keyboard whenever a [`key_up`](key_up.html) event is fired.

```
while true do
  local event, key = os.pullEvent("key_up")
  local name = keys.getName(key) or "unknown key"
  print(name .. " was released.")
end
```

### See also

* **[`keys`](../module/keys.html)** For a lookup table of the given keys.

---

## Source File: `event/modem_message.md`

# modem\_message

The [`modem_message`](modem_message.html) event is fired when a message is received on an open channel on any [`modem`](../peripheral/modem.html).

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The side of the modem that received the message.
3. `number`: The channel that the message was sent on.
4. `number`: The reply channel set by the sender.
5. `any`: The message as sent by the sender.
6. `number`|`nil`: The distance between the sender and the receiver in blocks, or `nil` if the message was sent between dimensions.

## Example

Wraps a [`modem`](../peripheral/modem.html) peripheral, opens channel 0 for listening, and prints all received messages.

```
local modem = peripheral.find("modem") or error("No modem attached", 0)
modem.open(0)

while true do
    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    print(("Message received on side %s on channel %d (reply to %d) from %f blocks away with message %s"):format(
        side, channel, replyChannel, distance, tostring(message)
    ))
end
```

---

## Source File: `event/monitor_resize.md`

# monitor\_resize

The [`monitor_resize`](monitor_resize.html) event is fired when an adjacent or networked [monitor's](../peripheral/monitor.html) size is changed.

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The side or network ID of the monitor that was resized.

## Example

Prints a message when a monitor is resized:

```
while true do
  local event, side = os.pullEvent("monitor_resize")
  print("The monitor on side " .. side .. " was resized.")
end
```

---

## Source File: `event/monitor_touch.md`

# monitor\_touch

The [`monitor_touch`](monitor_touch.html) event is fired when an adjacent or networked [Advanced Monitor](../peripheral/monitor.html) is right-clicked.

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The side or network ID of the monitor that was touched.
3. `number`: The X coordinate of the touch, in characters.
4. `number`: The Y coordinate of the touch, in characters.

## Example

Prints a message when a monitor is touched:

```
while true do
  local event, side, x, y = os.pullEvent("monitor_touch")
  print("The monitor on side " .. side .. " was touched at (" .. x .. ", " .. y .. ")")
end
```

---

## Source File: `event/mouse_click.md`

# mouse\_click

This event is fired when the terminal is clicked with a mouse. This event is only fired on advanced computers (including
advanced turtles and pocket computers).

## Return values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. `number`: The mouse button that was clicked.
3. `number`: The X-coordinate of the click.
4. `number`: The Y-coordinate of the click.

## Mouse buttons

Several mouse events ([`mouse_click`](mouse_click.html), [`mouse_up`](mouse_up.html), [`mouse_scroll`](mouse_scroll.html)) contain a "mouse button" code. This takes a
numerical value depending on which button on your mouse was last pressed when this event occurred.

| Button Code | Mouse Button |
| --- | --- |
| 1 | Left button |
| 2 | Right button |
| 3 | Middle button |

## Example

Print the button and the coordinates whenever the mouse is clicked.

```
while true do
  local event, button, x, y = os.pullEvent("mouse_click")
  print(("The mouse button %s was pressed at %d, %d"):format(button, x, y))
end
```

---

## Source File: `event/mouse_drag.md`

# mouse\_drag

This event is fired every time the mouse is moved while a mouse button is being held.

## Return values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. `number`: The [mouse button](mouse_click.html#Mouse_buttons) that is being pressed.
3. `number`: The X-coordinate of the mouse.
4. `number`: The Y-coordinate of the mouse.

## Example

Print the button and the coordinates whenever the mouse is dragged.

```
while true do
  local event, button, x, y = os.pullEvent("mouse_drag")
  print(("The mouse button %s was dragged at %d, %d"):format(button, x, y))
end
```

### See also

* **[`mouse_click`](mouse_click.html)** For when a mouse button is initially pressed.

---

## Source File: `event/mouse_scroll.md`

# mouse\_scroll

This event is fired when a mouse wheel is scrolled in the terminal.

## Return values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. `number`: The direction of the scroll. (-1 = up, 1 = down)
3. `number`: The X-coordinate of the mouse when scrolling.
4. `number`: The Y-coordinate of the mouse when scrolling.

## Example

Prints the direction of each scroll, and the position of the mouse at the time.

```
while true do
  local event, dir, x, y = os.pullEvent("mouse_scroll")
  print(("The mouse was scrolled in direction %s at %d, %d"):format(dir, x, y))
end
```

---

## Source File: `event/mouse_up.md`

# mouse\_up

This event is fired when a mouse button is released or a held mouse leaves the computer's terminal.

## Return values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. `number`: The [mouse button](mouse_click.html#Mouse_buttons) that was released.
3. `number`: The X-coordinate of the mouse.
4. `number`: The Y-coordinate of the mouse.

## Example

Prints the coordinates and button number whenever the mouse is released.

```
while true do
  local event, button, x, y = os.pullEvent("mouse_up")
  print(("The mouse button %s was released at %d, %d"):format(button, x, y))
end
```

---

## Source File: `event/paste.md`

# paste

The [`paste`](paste.html) event is fired when text is pasted into the computer through Ctrl-V (or âV on Mac).

## Return values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The text that was pasted.

## Example

Prints pasted text:

```
while true do
  local event, text = os.pullEvent("paste")
  print('"' .. text .. '" was pasted')
end
```

---

## Source File: `event/peripheral.md`

# peripheral

The [`peripheral`](../module/peripheral.html) event is fired when a peripheral is attached on a side or to a modem.

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The side the peripheral was attached to.

## Example

Prints a message when a peripheral is attached:

```
while true do
  local event, side = os.pullEvent("peripheral")
  print("A peripheral was attached on side " .. side)
end
```

### See also

* **[`peripheral_detach`](peripheral_detach.html)** For the event fired when a peripheral is detached.

---

## Source File: `event/peripheral_detach.md`

# peripheral\_detach

The [`peripheral_detach`](peripheral_detach.html) event is fired when a peripheral is detached from a side or from a modem.

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The side the peripheral was detached from.

## Example

Prints a message when a peripheral is detached:

```
while true do
  local event, side = os.pullEvent("peripheral_detach")
  print("A peripheral was detached on side " .. side)
end
```

### See also

* **[`peripheral`](../module/peripheral.html)** For the event fired when a peripheral is attached.

---

## Source File: `event/rednet_message.md`

# rednet\_message

The [`rednet_message`](rednet_message.html) event is fired when a message is sent over Rednet.

This event is usually handled by [`rednet.receive`](../module/rednet.html#v:receive), but it can also be pulled manually.

[`rednet_message`](rednet_message.html) events are sent by [`rednet.run`](../module/rednet.html#v:run) in the top-level coroutine in response to [`modem_message`](modem_message.html) events. A [`rednet_message`](rednet_message.html) event is always preceded by a [`modem_message`](modem_message.html) event. They are generated inside CraftOS rather than being sent by the ComputerCraft machine.

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. `number`: The ID of the sending computer.
3. `any`: The message sent.
4. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)|`nil`: The protocol of the message, if provided.

## Example

Prints a message when one is sent:

```
while true do
  local event, sender, message, protocol = os.pullEvent("rednet_message")
  if protocol ~= nil then
    print("Received message from " .. sender .. " with protocol " .. protocol .. " and message " .. tostring(message))
  else
    print("Received message from " .. sender .. " with message " .. tostring(message))
  end
end
```

### See also

* **[`modem_message`](modem_message.html)** For raw modem messages sent outside of Rednet.
* **[`rednet.receive`](../module/rednet.html#v:receive)** To wait for a Rednet message with an optional timeout and protocol filter.

---

## Source File: `event/redstone.md`

# redstone

The [`redstone`](redstone.html) event is fired whenever any redstone inputs on the computer or [relay](../peripheral/redstone_relay.html) change.

## Return values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.

## Example

Prints a message when a redstone input changes:

```
while true do
  os.pullEvent("redstone")
  print("A redstone input has changed!")
end
```

## See also

* [The `redstone` API on computers](../module/redstone.html)
* [The `redstone_relay` peripheral](../peripheral/redstone_relay.html)

---

## Source File: `event/speaker_audio_empty.md`

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

---

## Source File: `event/task_complete.md`

# task\_complete

The [`task_complete`](task_complete.html) event is fired when an asynchronous task completes. This is usually handled inside the function call that queued the task; however, functions such as [`commands.execAsync`](../module/commands.html#v:execAsync) return immediately so the user can wait for completion.

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. `number`: The ID of the task that completed.
3. `boolean`: Whether the command succeeded.
4. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): If the command failed, an error message explaining the failure. (This is not present if the command succeeded.)
5. â¦: Any parameters returned from the command.

## Example

Prints the results of an asynchronous command:

```
local taskID = commands.execAsync("say Hello")
local event
repeat
    event = {os.pullEvent("task_complete")}
until event[2] == taskID
if event[3] == true then
  print("Task " .. event[2] .. " succeeded:", table.unpack(event, 4))
else
  print("Task " .. event[2] .. " failed: " .. event[4])
end
```

### See also

* **[`commands.execAsync`](../module/commands.html#v:execAsync)** To run a command which fires a task\_complete event.

---

## Source File: `event/term_resize.md`

# term\_resize

The [`term_resize`](term_resize.html) event is fired when the main terminal is resized. For instance:

* When a the tab bar is shown or hidden in [`multishell`](../module/multishell.html).
* When the terminal is redirected to a monitor via the "monitor" program and the monitor is resized.

When this event fires, some parts of the terminal may have been moved or deleted. Simple terminal programs (those
not using [`term.setCursorPos`](../module/term.html#v:setCursorPos)) can ignore this event, but more complex GUI programs should redraw the entire screen.

## Return values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.

## Example

Print a message each time the terminal is resized.

```
while true do
  os.pullEvent("term_resize")
  local w, h = term.getSize()
  print("The term was resized to (" .. w .. ", " .. h .. ")")
end
```

---

## Source File: `event/terminate.md`

# terminate

The [`terminate`](terminate.html) event is fired when `Ctrl-T` is held down.

This event is normally handled by [`os.pullEvent`](../module/os.html#v:pullEvent), and will not be returned. However, [`os.pullEventRaw`](../module/os.html#v:pullEventRaw) will return this event when fired.

[`terminate`](terminate.html) will be sent even when a filter is provided to [`os.pullEventRaw`](../module/os.html#v:pullEventRaw). When using [`os.pullEventRaw`](../module/os.html#v:pullEventRaw) with a filter, make sure to check that the event is not [`terminate`](terminate.html).

## Return values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.

## Example

Prints a message when Ctrl-T is held:

```
while true do
  local event = os.pullEventRaw("terminate")
  if event == "terminate" then print("Terminate requested!") end
end
```

Exits when Ctrl-T is held:

```
while true do
  os.pullEvent()
end
```

---

## Source File: `event/timer.md`

# timer

The [`timer`](timer.html) event is fired when a timer started with [`os.startTimer`](../module/os.html#v:startTimer) completes.

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. `number`: The ID of the timer that finished.

## Example

Start and wait for a timer to finish.

```
local timer_id = os.startTimer(2)
local event, id
repeat
    event, id = os.pullEvent("timer")
until id == timer_id
print("Timer with ID " .. id .. " was fired")
```

### See also

* **[`os.startTimer`](../module/os.html#v:startTimer)** To start a timer.

---

## Source File: `event/turtle_inventory.md`

# turtle\_inventory

The [`turtle_inventory`](turtle_inventory.html) event is fired when a turtle's inventory is changed.

## Return values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.

## Example

Prints a message when the inventory is changed:

```
while true do
  os.pullEvent("turtle_inventory")
  print("The inventory was changed.")
end
```

---

## Source File: `event/websocket_closed.md`

# websocket\_closed

The [`websocket_closed`](websocket_closed.html) event is fired when an open WebSocket connection is closed.

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The URL of the WebSocket that was closed.
3. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)|`nil`: The [server-provided reason](https://www.rfc-editor.org/rfc/rfc6455.html#section-7.1.6 "The WebSocket Connection Close Reason, RFC 6455")
   the websocket was closed. This will be `nil` if the connection was closed
   abnormally.
4. `number`|`nil`: The [connection close code](https://www.rfc-editor.org/rfc/rfc6455.html#section-7.1.5 "The WebSocket Connection Close Code, RFC 6455"),
   indicating why the socket was closed. This will be `nil` if the connection
   was closed abnormally.

## Example

Prints a message when a WebSocket is closed (this may take a minute):

```
local myURL = "wss://example.tweaked.cc/echo"
local ws = http.websocket(myURL)
local event, url
repeat
    event, url = os.pullEvent("websocket_closed")
until url == myURL
print("The WebSocket at " .. url .. " was closed.")
```

---

## Source File: `event/websocket_failure.md`

# websocket\_failure

The [`websocket_failure`](websocket_failure.html) event is fired when a WebSocket connection request fails.

This event is normally handled inside [`http.websocket`](../module/http.html#v:websocket), but it can still be seen when using [`http.websocketAsync`](../module/http.html#v:websocketAsync).

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The URL of the site requested.
3. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): An error describing the failure.

## Example

Prints an error why the website cannot be contacted:

```
local myURL = "wss://example.tweaked.cc/not-a-websocket"
http.websocketAsync(myURL)
local event, url, err
repeat
    event, url, err = os.pullEvent("websocket_failure")
until url == myURL
print("The URL " .. url .. " could not be reached: " .. err)
```

### See also

* **[`http.websocketAsync`](../module/http.html#v:websocketAsync)** To send an HTTP request.

---

## Source File: `event/websocket_message.md`

# websocket\_message

The [`websocket_message`](websocket_message.html) event is fired when a message is received on an open WebSocket connection.

This event is normally handled by [`http.Websocket.receive`](../module/http.html#ty:Websocket:receive), but it can also be pulled manually.

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The URL of the WebSocket.
3. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The contents of the message.
4. `boolean`: Whether this is a binary message.

## Example

Prints a message sent by a WebSocket:

```
local myURL = "wss://example.tweaked.cc/echo"
local ws = http.websocket(myURL)
ws.send("Hello!")
local event, url, message
repeat
    event, url, message = os.pullEvent("websocket_message")
until url == myURL
print("Received message from " .. url .. " with contents " .. message)
ws.close()
```

---

## Source File: `event/websocket_success.md`

# websocket\_success

The [`websocket_success`](websocket_success.html) event is fired when a WebSocket connection request returns successfully.

This event is normally handled inside [`http.websocket`](../module/http.html#v:websocket), but it can still be seen when using [`http.websocketAsync`](../module/http.html#v:websocketAsync).

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The URL of the site.
3. [`http.Websocket`](../module/http.html#ty:Websocket): The handle for the WebSocket.

## Example

Prints the content of a website (this may fail if the request fails):

```
local myURL = "wss://example.tweaked.cc/echo"
http.websocketAsync(myURL)
local event, url, handle
repeat
    event, url, handle = os.pullEvent("websocket_success")
until url == myURL
print("Connected to " .. url)
handle.send("Hello!")
print(handle.receive())
handle.close()
```

### See also

* **[`http.websocketAsync`](../module/http.html#v:websocketAsync)** To open a WebSocket asynchronously.