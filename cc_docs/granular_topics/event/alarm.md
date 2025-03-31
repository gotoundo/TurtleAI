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