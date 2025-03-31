# disk

The [`disk`](../module/disk.html) event is fired when a disk is inserted into an adjacent or networked disk drive.

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The side of the disk drive that had a disk inserted.

## Example

Prints a message when a disk is inserted:

```
while true do
  local event, side = os.pullEvent("disk")
  print("Inserted a disk on side " .. side)
end
```

### See also

* **[`disk_eject`](disk_eject.html)** For the event sent when a disk is removed.