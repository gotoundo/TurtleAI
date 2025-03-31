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