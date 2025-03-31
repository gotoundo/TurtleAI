# paste

The [`paste`](paste.html) event is fired when text is pasted into the computer through Ctrl-V (or âV on Mac).

## Return values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The text that was pasted.

## Example

Prints pasted text:

```
while true do
  local event, text = os.pullEvent("paste")
  print('"' .. text .. '" was pasted')
end
```