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