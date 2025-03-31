# disk\_eject

The [`disk_eject`](disk_eject.html) event is fired when a disk is removed from an adjacent or networked disk drive.

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The side of the disk drive that had a disk removed.

## Example

Prints a message when a disk is removed:

```
while true do
  local event, side = os.pullEvent("disk_eject")
  print("Removed a disk on side " .. side)
end
```

### See also

* **[`disk`](../module/disk.html)** For the event sent when a disk is inserted.