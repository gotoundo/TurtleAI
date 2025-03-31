# disk

Interact with disk drives.

These functions can operate on locally attached or remote disk drives. To use a
locally attached drive, specify âsideâ as one of the six sides (e.g. `left`); to
use a remote disk drive, specify its name as printed when enabling its modem
(e.g. `drive_0`).

##### tip

All computers (except command computers), turtles and pocket computers can be
placed within a disk drive to access it's internal storage like a disk.

### Changes

* **New in version 1.2**

|  |  |
| --- | --- |
| [isPresent(name)](#v:isPresent) | Checks whether any item at all is in the disk drive |
| [getLabel(name)](#v:getLabel) | Get the label of the floppy disk, record, or other media within the given disk drive. |
| [setLabel(name, label)](#v:setLabel) | Set the label of the floppy disk or other media |
| [hasData(name)](#v:hasData) | Check whether the current disk provides a mount. |
| [getMountPath(name)](#v:getMountPath) | Find the directory name on the local computer where the contents of the current floppy disk (or other mount) can be found. |
| [hasAudio(name)](#v:hasAudio) | Whether the current disk is a music disk as opposed to a floppy disk or other item. |
| [getAudioTitle(name)](#v:getAudioTitle) | Get the title of the audio track from the music record in the drive. |
| [playAudio(name)](#v:playAudio) | Starts playing the music record in the drive. |
| [stopAudio(name)](#v:stopAudio) | Stops the music record in the drive from playing, if it was started with [`disk.playAudio`](disk.html#v:playAudio). |
| [eject(name)](#v:eject) | Ejects any item currently in the drive, spilling it into the world as a loose item. |
| [getID(name)](#v:getID) | Returns a number which uniquely identifies the disk in the drive. |

isPresent(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L32)
:   Checks whether any item at all is in the disk drive

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the disk drive.

    ### Returns

    1. `boolean` If something is in the disk drive.

    ### Usage

    * ```
      disk.isPresent("top")
      ```

getLabel(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L49)
:   Get the label of the floppy disk, record, or other media within the given
    disk drive.

    If there is a computer or turtle within the drive, this will set the label as
    read by `os.getComputerLabel`.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the disk drive.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The name of the current media, or `nil` if the drive is
       not present or empty.

    ### See also

    * **[`disk.setLabel`](disk.html#v:setLabel)**

setLabel(name, label)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L60)
:   Set the label of the floppy disk or other media

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the disk drive.
    2. label [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The new label of the disk

hasData(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L73)
:   Check whether the current disk provides a mount.

    This will return true for disks and computers, but not records.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the disk drive.

    ### Returns

    1. `boolean` If the disk is present and provides a mount.

    ### See also

    * **[`disk.getMountPath`](disk.html#v:getMountPath)**

getMountPath(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L87)
:   Find the directory name on the local computer where the contents of the
    current floppy disk (or other mount) can be found.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the disk drive.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The mount's directory, or `nil` if the drive does not
       contain a floppy or computer.

    ### See also

    * **[`disk.hasData`](disk.html#v:hasData)**

hasAudio(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L103)
:   Whether the current disk is a [music disk](https://minecraft.wiki/w/Music_Disc) as opposed to a floppy disk
    or other item.

    If this returns true, you will can [play](disk.html#v:playAudio) the record.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the disk drive.

    ### Returns

    1. `boolean` If the disk is present and has audio saved on it.

getAudioTitle(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L117)
:   Get the title of the audio track from the music record in the drive.

    This generally returns the same as [`disk.getLabel`](disk.html#v:getLabel) for records.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the disk drive.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | false | nil The track title, `false` if there is not a music
       record in the drive or `nil` if no drive is present.

playAudio(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L133)
:   Starts playing the music record in the drive.

    If any record is already playing on any disk drive, it stops before the
    target drive starts playing. The record stops when it reaches the end of the
    track, when it is removed from the drive, when [`disk.stopAudio`](disk.html#v:stopAudio) is called, or
    when another record is started.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the disk drive.

    ### Usage

    * ```
      disk.playAudio("bottom")
      ```

stopAudio(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L143)
:   Stops the music record in the drive from playing, if it was started with
    [`disk.playAudio`](disk.html#v:playAudio).

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name o the disk drive.

eject(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L159)
:   Ejects any item currently in the drive, spilling it into the world as a loose item.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the disk drive.

    ### Usage

    * ```
      disk.eject("bottom")
      ```

getID(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/disk.lua#L173)
:   Returns a number which uniquely identifies the disk in the drive.

    Note, unlike [`disk.getLabel`](disk.html#v:getLabel), this does not return anything for other media,
    such as computers or turtles.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the disk drive.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The disk ID, or `nil` if the drive does not contain a floppy disk.

    ### Changes

    * **New in version 1.4**