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