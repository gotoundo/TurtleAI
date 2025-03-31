# file\_transfer

The [`file_transfer`](file_transfer.html) event is queued when a user drags-and-drops a file on an open computer.

This event contains a single argument of type [`TransferredFiles`](file_transfer.html#ty:TransferredFiles), which can be used to [get the files to be
transferred](file_transfer.html#ty:TransferredFiles:getFiles). Each file returned is a [binary file handle](../module/fs.html#ty:ReadHandle) with an
additional [getName](file_transfer.html#ty:TransferredFile:getName) method.

## Return values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name
2. [`TransferredFiles`](file_transfer.html#ty:TransferredFiles): The list of transferred files.

## Example

Waits for a user to drop files on top of the computer, then prints the list of files and the size of each file.

```
local _, files = os.pullEvent("file_transfer")
for _, file in ipairs(files.getFiles()) do
  -- Seek to the end of the file to get its size, then go back to the beginning.
  local size = file.seek("end")
  file.seek("set", 0)

  print(file.getName() .. " " .. size)
end
```

## Example

Save each transferred file to the computer's storage.

```
local _, files = os.pullEvent("file_transfer")
for _, file in ipairs(files.getFiles()) do
  local handle = fs.open(file.getName(), "wb")
  handle.write(file.readAll())

  handle.close()
  file.close()
end
```

### Changes

* **New in version 1.101.0**

### Types

### TransferredFiles

A list of files that have been transferred to this computer.

TransferredFiles.getFiles()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/transfer/TransferredFiles.java#L40)
:   All the files that are being transferred to this computer.

    ### Returns

    1. { [`file_transfer.TransferredFile`](file_transfer.html#ty:TransferredFile)... } The list of files.

### TransferredFile

A binary file handle that has been transferred to this computer.

This inherits all methods of [binary file handles](../module/fs.html#ty:ReadHandle), meaning you can use the standard
[read functions](../module/fs.html#ty:ReadHandle:read) to access the contents of the file.

### See also

* **[`fs.ReadHandle`](../module/fs.html#ty:ReadHandle)**

TransferredFile.getName()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/transfer/TransferredFile.java#L38)
:   Get the name of this file being transferred.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The file's name.