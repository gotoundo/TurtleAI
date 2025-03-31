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