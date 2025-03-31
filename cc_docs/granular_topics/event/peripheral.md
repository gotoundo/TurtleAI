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