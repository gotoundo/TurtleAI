# fs

Interact with the computer's files and filesystem, allowing you to manipulate files, directories and paths. This
includes:

* **Reading and writing files:** Call [`open`](fs.html#v:open) to obtain a file "handle", which can be used to read from or
  write to a file.
* **Path manipulation:** [`combine`](fs.html#v:combine), [`getName`](fs.html#v:getName) and [`getDir`](fs.html#v:getDir) allow you to manipulate file
  paths, joining them together or extracting components.
* **Querying paths:** For instance, checking if a file exists, or whether it's a directory. See [`getSize`](fs.html#v:getSize),
  [`exists`](fs.html#v:exists), [`isDir`](fs.html#v:isDir), [`isReadOnly`](fs.html#v:isReadOnly) and [`attributes`](fs.html#v:attributes).
* **File and directory manipulation:** For instance, moving or copying files. See [`makeDir`](fs.html#v:makeDir), [`move`](fs.html#v:move),
  [`copy`](fs.html#v:copy) and [`delete`](fs.html#v:delete).

##### ð note

All functions in the API work on absolute paths, and do not take the [current directory](shell.html#v:dir) into account.
You can use [`shell.resolve`](shell.html#v:resolve) to convert a relative path into an absolute one.

## Mounts

While a computer can only have one hard drive and filesystem, other filesystems may be "mounted" inside it. For
instance, the [drive peripheral](../peripheral/drive.html) mounts
its disk's contents at `"disk/"`, `"disk1/"`, etc...

You can see which mount a path belongs to with the [`getDrive`](fs.html#v:getDrive) function. This returns `"hdd"` for the
computer's main filesystem (`"/"`), `"rom"` for the rom (`"rom/"`).

Most filesystems have a limited capacity, operations which would cause that capacity to be reached (such as writing
an incredibly large file) will fail. You can see a mount's capacity with [`getCapacity`](fs.html#v:getCapacity) and the remaining
space with [`getFreeSpace`](fs.html#v:getFreeSpace).

|  |  |
| --- | --- |
| [complete(...)](#v:complete) | Provides completion for a file or directory name, suitable for use with [`_G.read`](_G.html#v:read). |
| [find(path)](#v:find) | Searches for files matching a string with wildcards. |
| [isDriveRoot(path)](#v:isDriveRoot) | Returns true if a path is mounted to the parent filesystem. |
| [list(path)](#v:list) | Returns a list of files in a directory. |
| [combine(path, ...)](#v:combine) | Combines several parts of a path into one full path, adding separators as needed. |
| [getName(path)](#v:getName) | Returns the file name portion of a path. |
| [getDir(path)](#v:getDir) | Returns the parent directory portion of a path. |
| [getSize(path)](#v:getSize) | Returns the size of the specified file. |
| [exists(path)](#v:exists) | Returns whether the specified path exists. |
| [isDir(path)](#v:isDir) | Returns whether the specified path is a directory. |
| [isReadOnly(path)](#v:isReadOnly) | Returns whether a path is read-only. |
| [makeDir(path)](#v:makeDir) | Creates a directory, and any missing parents, at the specified path. |
| [move(path, dest)](#v:move) | Moves a file or directory from one path to another. |
| [copy(path, dest)](#v:copy) | Copies a file or directory to a new path. |
| [delete(path)](#v:delete) | Deletes a file or directory. |
| [open(path, mode)](#v:open) | Opens a file for reading or writing at a path. |
| [getDrive(path)](#v:getDrive) | Returns the name of the mount that the specified path is located on. |
| [getFreeSpace(path)](#v:getFreeSpace) | Returns the amount of free space available on the drive the path is located on. |
| [getCapacity(path)](#v:getCapacity) | Returns the capacity of the drive the path is located on. |
| [attributes(path)](#v:attributes) | Get attributes about a specific file or folder. |

complete(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/fs.lua#L63)
:   Provides completion for a file or directory name, suitable for use with
    [`_G.read`](_G.html#v:read).

    When a directory is a possible candidate for completion, two entries are
    included - one with a trailing slash (indicating that entries within this
    directory exist) and one without it (meaning this entry is an immediate
    completion candidate). `include_dirs` can be set to `false` to only include
    those with a trailing slash.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to complete.
    2. location [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The location where paths are resolved from.
    3. include\_files? `boolean` = `true` When `false`, only directories will
       be included in the returned list.
    4. include\_dirs? `boolean` = `true` When `false`, "raw" directories will
       not be included in the returned list.

    #### Or

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to complete.
    2. location [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The location where paths are resolved from.
    3. options { include\_dirs? = `boolean`, include\_files? = `boolean`, include\_hidden? = `boolean` }

       This table form is an expanded version of the previous syntax. The
       `include_files` and `include_dirs` arguments from above are passed in as fields.

       This table also accepts the following options:

       * `include_hidden`: Whether to include hidden files (those starting with `.`)
         by default. They will still be shown when typing a `.`.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of possible completion candidates.

    ### Usage

    * Complete files in the root directory.

      ```
      read(nil, nil, function(str)
          return fs.complete(str, "", true, false)
      end)
      ```
    * Complete files in the root directory, hiding hidden files by default.

      ```
      read(nil, nil, function(str)
          return fs.complete(str, "", {
              include_files = true,
              include_dirs = false,
              include_hidden = false,
          })
      end)
      ```

    ### Changes

    * **New in version 1.74**
    * **Changed in version 1.101.0**

find(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/fs.lua#L190)
:   Searches for files matching a string with wildcards.

    This string looks like a normal path string, but can include wildcards, which
    can match multiple paths:

    * "?" matches any single character in a file name.
    * "\*" matches any number of characters.

    For example, `rom/*/command*` will look for any path starting with `command`
    inside any subdirectory of `/rom`.

    Note that these wildcards match a single segment of the path. For instance
    `rom/*.lua` will include `rom/startup.lua` but *not* include `rom/programs/list.lua`.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The wildcard-qualified path to search for.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of paths that match the search string.

    ### Throws

    * If the supplied path was invalid.

    ### Usage

    * List all Markdown files in the help folder

      ```
      fs.find("rom/help/*.md")
      ```

    ### Changes

    * **New in version 1.6**
    * **Changed in version 1.106.0:** Added support for the `?` wildcard.

isDriveRoot(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/fs.lua#L233)
:   Returns true if a path is mounted to the parent filesystem.

    The root filesystem "/" is considered a mount, along with disk folders and
    the rom folder.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to check.

    ### Returns

    1. `boolean` If the path is mounted, rather than a normal file/folder.

    ### Throws

    * If the path does not exist.

    ### See also

    * **[`getDrive`](fs.html#v:getDrive)**

    ### Changes

    * **New in version 1.87.0**

list(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L103)
:   Returns a list of files in a directory.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to list.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A table with a list of files in the directory.

    ### Throws

    * If the path doesn't exist.

    ### Usage

    * List all files under `/rom/`

      ```
      local files = fs.list("/rom/")
      for i = 1, #files do
        print(files[i])
      end
      ```

combine(path, ...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L128)
:   Combines several parts of a path into one full path, adding separators as
    needed.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The first part of the path. For example, a parent directory path.
    2. ... [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Additional parts of the path to combine.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The new path, with separators added between parts as needed.

    ### Throws

    * On argument errors.

    ### Usage

    * Combine several file paths together

      ```
      fs.combine("/rom/programs", "../apis", "parallel.lua")
      -- => rom/apis/parallel.lua
      ```

    ### Changes

    * **Changed in version 1.95.0:** Now supports multiple arguments.

getName(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L154)
:   Returns the file name portion of a path.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to get the name from.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The final part of the path (the file name).

    ### Usage

    * Get the file name of `rom/startup.lua`

      ```
      fs.getName("rom/startup.lua")
      -- => startup.lua
      ```

    ### Changes

    * **New in version 1.2**

getDir(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L171)
:   Returns the parent directory portion of a path.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to get the directory from.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path with the final part removed (the parent directory).

    ### Usage

    * Get the directory name of `rom/startup.lua`

      ```
      fs.getDir("rom/startup.lua")
      -- => rom
      ```

    ### Changes

    * **New in version 1.63**

getSize(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L184)
:   Returns the size of the specified file.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The file to get the file size of.

    ### Returns

    1. `number` The size of the file, in bytes.

    ### Throws

    * If the path doesn't exist.

    ### Changes

    * **New in version 1.3**

exists(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L199)
:   Returns whether the specified path exists.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to check the existence of.

    ### Returns

    1. `boolean` Whether the path exists.

isDir(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L214)
:   Returns whether the specified path is a directory.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to check.

    ### Returns

    1. `boolean` Whether the path is a directory.

isReadOnly(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L229)
:   Returns whether a path is read-only.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to check.

    ### Returns

    1. `boolean` Whether the path cannot be written to.

makeDir(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L244)
:   Creates a directory, and any missing parents, at the specified path.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to the directory to create.

    ### Throws

    * If the directory couldn't be created.

move(path, dest)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L262)
:   Moves a file or directory from one path to another.

    Any parent directories are created as needed.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The current file or directory to move from.
    2. dest [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The destination path for the file or directory.

    ### Throws

    * If the file or directory couldn't be moved.

copy(path, dest)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L280)
:   Copies a file or directory to a new path.

    Any parent directories are created as needed.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The file or directory to copy.
    2. dest [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to the destination file or directory.

    ### Throws

    * If the file or directory couldn't be copied.

delete(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L298)
:   Deletes a file or directory.

    If the path points to a directory, all of the enclosed files and
    subdirectories are also deleted.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to the file or directory to delete.

    ### Throws

    * If the file or directory couldn't be deleted.

open(path, mode)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L365)
:   Opens a file for reading or writing at a path.

    The `mode` string can be any of the following:

    * **"r"**: Read mode.
    * **"w"**: Write mode.
    * **"a"**: Append mode.
    * **"r+"**: Update mode (allows reading and writing), all data is preserved.
    * **"w+"**: Update mode, all data is erased.

    The mode may also have a "b" at the end, which opens the file in "binary
    mode". This changes [`fs.ReadHandle.read`](fs.html#ty:ReadHandle:read) and [`fs.WriteHandle.write`](fs.html#ty:WriteHandle:write)
    to read/write single bytes as numbers rather than strings.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to the file to open.
    2. mode [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The mode to open the file with.

    ### Returns

    1. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) A file handle object for the file.

    #### Or

    1. nil If the file does not exist, or cannot be opened.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil A message explaining why the file cannot be opened.

    ### Throws

    * If an invalid mode was specified.

    ### Usage

    * Read the contents of a file.

      ```
      local file = fs.open("/rom/help/intro.txt", "r")
      local contents = file.readAll()
      file.close()

      print(contents)
      ```
    * Open a file and read all lines into a table. [`io.lines`](io.html#v:lines) offers an alternative way to do this.

      ```
      local file = fs.open("/rom/motd.txt", "r")
      local lines = {}
      while true do
        local line = file.readLine()

        -- If line is nil then we've reached the end of the file and should stop
        if not line then break end

        lines[#lines + 1] = line
      end

      file.close()

      print(lines[math.random(#lines)]) -- Pick a random line and print it.
      ```
    * Open a file and write some text to it. You can run `edit out.txt` to see the written text.

      ```
      local file = fs.open("out.txt", "w")
      file.write("Just testing some code")
      file.close() -- Remember to call close, otherwise changes may not be written!
      ```

    ### Changes

    * **Changed in version 1.109.0:** Add support for update modes (`r+` and `w+`).
    * **Changed in version 1.109.0:** Opening a file in non-binary mode now uses the raw bytes of the file rather than encoding to
      UTF-8.

getDrive(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L413)
:   Returns the name of the mount that the specified path is located on.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to get the drive of.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The name of the drive that the file is on; e.g. `hdd` for local files, or `rom` for ROM files.

    ### Throws

    * If the path doesn't exist.

    ### Usage

    * Print the drives of a couple of mounts:

      ```
      print("/: " .. fs.getDrive("/"))
      print("/rom/: " .. fs.getDrive("rom"))
      ```

getFreeSpace(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L433)
:   Returns the amount of free space available on the drive the path is
    located on.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to check the free space for.

    ### Returns

    1. `number` | "unlimited" The amount of free space available, in bytes, or "unlimited".

    ### Throws

    * If the path doesn't exist.

    ### See also

    * **[`getCapacity`](fs.html#v:getCapacity)** To get the capacity of this drive.

    ### Changes

    * **New in version 1.4**

getCapacity(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L454)
:   Returns the capacity of the drive the path is located on.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path of the drive to get.

    ### Returns

    1. `number` | nil This drive's capacity. This will be nil for "read-only" drives, such as the ROM or
       treasure disks.

    ### Throws

    * If the capacity cannot be determined.

    ### See also

    * **[`getFreeSpace`](fs.html#v:getFreeSpace)** To get the free space available on this drive.

    ### Changes

    * **New in version 1.87.0**

attributes(path)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/FSAPI.java#L484)
:   Get attributes about a specific file or folder.

    The returned attributes table contains information about the size of the file, whether it is a directory,
    when it was created and last modified, and whether it is read only.

    The creation and modification times are given as the number of milliseconds since the UNIX epoch. This may be
    given to [`os.date`](os.html#v:date) in order to convert it to more usable form.

    ### Parameters

    1. path [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The path to get attributes for.

    ### Returns

    1. { size = `number`, isDir = `boolean`, isReadOnly = `boolean`, created = `number`, modified = `number` } The resulting attributes.

    ### Throws

    * If the path does not exist.

    ### See also

    * **[`getSize`](fs.html#v:getSize)** If you only care about the file's size.
    * **[`isDir`](fs.html#v:isDir)** If you only care whether a path is a directory or not.

    ### Changes

    * **New in version 1.87.0**
    * **Changed in version 1.91.0:** Renamed `modification` field to `modified`.
    * **Changed in version 1.95.2:** Added `isReadOnly` to attributes.

### Types

### ReadWriteHandle

A file handle opened for reading and writing with [`fs.open`](fs.html#v:open).

ReadWriteHandle.read([count])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadWriteHandle.java#L31)
:   Read a number of bytes from this file.

    ### Parameters

    1. count? `number` The number of bytes to read. This may be 0 to determine we are at the end of the file. When
       absent, a single byte will be read.

    ### Returns

    1. nil If we are at the end of the file.

    #### Or

    1. `number` The value of the byte read. This is returned if the file is opened in binary mode and
       `count` is absent

    #### Or

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The bytes read as a string. This is returned when the `count` is given.

    ### Throws

    * When trying to read a negative number of bytes.
    * If the file has been closed.

    ### Changes

    * **Changed in version 1.80pr1:** Now accepts an integer argument to read multiple bytes, returning a string instead of a number.

ReadWriteHandle.readAll()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadWriteHandle.java#L40)
:   Read the remainder of the file.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The remaining contents of the file, or `nil` in the event of an error.

    ### Throws

    * If the file has been closed.

    ### Changes

    * **New in version 1.80pr1**

ReadWriteHandle.readLine([withTrailing])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadWriteHandle.java#L49)
:   Read a line from the file.

    ### Parameters

    1. withTrailing? `boolean` Whether to include the newline characters with the returned string. Defaults to `false`.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The read line or `nil` if at the end of the file.

    ### Throws

    * If the file has been closed.

    ### Changes

    * **New in version 1.80pr1.9**
    * **Changed in version 1.81.0:** `\r` is now stripped.

ReadWriteHandle.seek([whence [, offset]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadWriteHandle.java#L58)
:   Seek to a new position within the file, changing where bytes are written to. The new position is an offset
    given by `offset`, relative to a start position determined by `whence`:

    * `"set"`: `offset` is relative to the beginning of the file.
    * `"cur"`: Relative to the current position. This is the default.
    * `"end"`: Relative to the end of the file.

    In case of success, `seek` returns the new file position from the beginning of the file.

    ### Parameters

    1. whence? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Where the offset is relative to.
    2. offset? `number` The offset to seek to.

    ### Returns

    1. `number` The new position.

    #### Or

    1. nil If seeking failed.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The reason seeking failed.

    ### Throws

    * If the file has been closed.

    ### Changes

    * **New in version 1.80pr1.9**

ReadWriteHandle.write(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadWriteHandle.java#L67)
:   Write a string or byte to the file.

    ### Parameters

    1. contents [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The string to write.

    #### Or

    1. charcode `number` The byte to write, if the file was opened in binary mode.

    ### Throws

    * If the file has been closed.

    ### Changes

    * **Changed in version 1.80pr1:** Now accepts a string to write multiple bytes.

ReadWriteHandle.writeLine(text)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadWriteHandle.java#L76)
:   Write a string of characters to the file, following them with a new line character.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The text to write to the file.

    ### Throws

    * If the file has been closed.

ReadWriteHandle.flush()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadWriteHandle.java#L85)
:   Save the current file without closing it.

    ### Throws

    * If the file has been closed.

ReadWriteHandle.close()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/AbstractHandle.java#L54)
:   Close this file, freeing any resources it uses.

    Once a file is closed it may no longer be read or written to.

    ### Throws

    * If the file has already been closed.

### WriteHandle

A file handle opened for writing by [`fs.open`](fs.html#v:open).

WriteHandle.write(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/WriteHandle.java#L35)
:   Write a string or byte to the file.

    ### Parameters

    1. contents [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The string to write.

    #### Or

    1. charcode `number` The byte to write, if the file was opened in binary mode.

    ### Throws

    * If the file has been closed.

    ### Changes

    * **Changed in version 1.80pr1:** Now accepts a string to write multiple bytes.

WriteHandle.writeLine(text)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/WriteHandle.java#L44)
:   Write a string of characters to the file, following them with a new line character.

    ### Parameters

    1. text [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The text to write to the file.

    ### Throws

    * If the file has been closed.

WriteHandle.flush()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/WriteHandle.java#L53)
:   Save the current file without closing it.

    ### Throws

    * If the file has been closed.

WriteHandle.seek([whence [, offset]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/WriteHandle.java#L67)
:   Seek to a new position within the file, changing where bytes are written to. The new position is an offset
    given by `offset`, relative to a start position determined by `whence`:

    * `"set"`: `offset` is relative to the beginning of the file.
    * `"cur"`: Relative to the current position. This is the default.
    * `"end"`: Relative to the end of the file.

    In case of success, `seek` returns the new file position from the beginning of the file.

    ### Parameters

    1. whence? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Where the offset is relative to.
    2. offset? `number` The offset to seek to.

    ### Returns

    1. `number` The new position.

    #### Or

    1. nil If seeking failed.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The reason seeking failed.

    ### Throws

    * If the file has been closed.

    ### Changes

    * **New in version 1.80pr1.9**

WriteHandle.close()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/AbstractHandle.java#L54)
:   Close this file, freeing any resources it uses.

    Once a file is closed it may no longer be read or written to.

    ### Throws

    * If the file has already been closed.

### ReadHandle

A file handle opened for reading with [`fs.open`](fs.html#v:open).

ReadHandle.read([count])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadHandle.java#L32)
:   Read a number of bytes from this file.

    ### Parameters

    1. count? `number` The number of bytes to read. This may be 0 to determine we are at the end of the file. When
       absent, a single byte will be read.

    ### Returns

    1. nil If we are at the end of the file.

    #### Or

    1. `number` The value of the byte read. This is returned if the file is opened in binary mode and
       `count` is absent

    #### Or

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The bytes read as a string. This is returned when the `count` is given.

    ### Throws

    * When trying to read a negative number of bytes.
    * If the file has been closed.

    ### Changes

    * **Changed in version 1.80pr1:** Now accepts an integer argument to read multiple bytes, returning a string instead of a number.

ReadHandle.readAll()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadHandle.java#L41)
:   Read the remainder of the file.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The remaining contents of the file, or `nil` in the event of an error.

    ### Throws

    * If the file has been closed.

    ### Changes

    * **New in version 1.80pr1**

ReadHandle.readLine([withTrailing])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadHandle.java#L50)
:   Read a line from the file.

    ### Parameters

    1. withTrailing? `boolean` Whether to include the newline characters with the returned string. Defaults to `false`.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The read line or `nil` if at the end of the file.

    ### Throws

    * If the file has been closed.

    ### Changes

    * **New in version 1.80pr1.9**
    * **Changed in version 1.81.0:** `\r` is now stripped.

ReadHandle.seek([whence [, offset]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/ReadHandle.java#L59)
:   Seek to a new position within the file, changing where bytes are written to. The new position is an offset
    given by `offset`, relative to a start position determined by `whence`:

    * `"set"`: `offset` is relative to the beginning of the file.
    * `"cur"`: Relative to the current position. This is the default.
    * `"end"`: Relative to the end of the file.

    In case of success, `seek` returns the new file position from the beginning of the file.

    ### Parameters

    1. whence? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Where the offset is relative to.
    2. offset? `number` The offset to seek to.

    ### Returns

    1. `number` The new position.

    #### Or

    1. nil If seeking failed.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The reason seeking failed.

    ### Throws

    * If the file has been closed.

    ### Changes

    * **New in version 1.80pr1.9**

ReadHandle.close()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/handles/AbstractHandle.java#L54)
:   Close this file, freeing any resources it uses.

    Once a file is closed it may no longer be read or written to.

    ### Throws

    * If the file has already been closed.