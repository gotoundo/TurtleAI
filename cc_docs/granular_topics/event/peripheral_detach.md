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