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