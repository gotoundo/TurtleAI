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