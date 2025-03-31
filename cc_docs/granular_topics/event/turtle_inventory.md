# turtle\_inventory

The [`turtle_inventory`](turtle_inventory.html) event is fired when a turtle's inventory is changed.

## Return values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.

## Example

Prints a message when the inventory is changed:

```
while true do
  os.pullEvent("turtle_inventory")
  print("The inventory was changed.")
end
```