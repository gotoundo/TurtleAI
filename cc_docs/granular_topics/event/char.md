# char

The [`char`](char.html) event is fired when a character is typed on the keyboard.

The [`char`](char.html) event is different to a key press. Sometimes multiple key presses may result in one character being
typed (for instance, on some European keyboards). Similarly, some keys (e.g. `Ctrl`) do not have any
corresponding character. The [`key`](key.html) should be used if you want to listen to key presses themselves.

## Return values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The string representing the character that was pressed.

## Example

Prints each character the user presses:

```
while true do
    local event, character = os.pullEvent("char")
    print(character .. " was pressed.")
end
```

### See also

* **[`key`](key.html)** To listen to any key press.