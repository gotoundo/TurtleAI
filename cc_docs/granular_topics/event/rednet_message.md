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