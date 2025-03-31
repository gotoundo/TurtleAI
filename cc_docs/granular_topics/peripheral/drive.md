# drive

Disk drives are a peripheral which allow you to read and write to floppy disks and other "mountable media" (such as
computers or turtles). They also allow you to [play records](drive.html#v:playAudio).

When a disk drive attaches some mount (such as a floppy disk or computer), it attaches a folder called `disk`,
`disk2`, etc... to the root directory of the computer. This folder can be used to interact with the files on
that disk.

When a disk is inserted, a `disk` event is fired, with the side peripheral is on. Likewise, when the disk is
detached, a `disk_eject` event is fired.

## Recipe

**Disk Drive**

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Redstone Dust](/images/items/minecraft/redstone.png "Redstone Dust")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Redstone Dust](/images/items/minecraft/redstone.png "Redstone Dust")

![Stone](/images/items/minecraft/stone.png "Stone")

![Disk Drive](/images/items/computercraft/disk_drive.png "Disk Drive")

|  |  |
| --- | --- |
| [isDiskPresent()](#v:isDiskPresent) | Returns whether a disk is currently inserted in the drive. |
| [getDiskLabel()](#v:getDiskLabel) | Returns the label of the disk in the drive if available. |
| [setDiskLabel([label])](#v:setDiskLabel) | Sets or clears the label for a disk. |
| [hasData()](#v:hasData) | Returns whether a disk with data is inserted. |
| [getMountPath()](#v:getMountPath) | Returns the mount path for the inserted disk. |
| [hasAudio()](#v:hasAudio) | Returns whether a disk with audio is inserted. |
| [getAudioTitle()](#v:getAudioTitle) | Returns the title of the inserted audio disk. |
| [playAudio()](#v:playAudio) | Plays the audio in the inserted disk, if available. |
| [stopAudio()](#v:stopAudio) | Stops any audio that may be playing. |
| [ejectDisk()](#v:ejectDisk) | Ejects any disk that may be in the drive. |
| [getDiskID()](#v:getDiskID) | Returns the ID of the disk inserted in the drive. |

isDiskPresent()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L52)
:   Returns whether a disk is currently inserted in the drive.

    ### Returns

    1. `boolean` Whether a disk is currently inserted in the drive.

getDiskLabel()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L63)
:   Returns the label of the disk in the drive if available.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The label of the disk, or `nil` if either no disk is inserted or the disk doesn't have a label.

setDiskLabel([label])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L80)
:   Sets or clears the label for a disk.

    If no label or `nil` is passed, the label will be cleared.

    If the inserted disk's label can't be changed (for example, a record),
    an error will be thrown.

    ### Parameters

    1. label? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The new label of the disk, or `nil` to clear.

    ### Throws

    * If the disk's label can't be changed.

hasData()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L95)
:   Returns whether a disk with data is inserted.

    ### Returns

    1. `boolean` Whether a disk with data is inserted.

getMountPath()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L106)
:   Returns the mount path for the inserted disk.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The mount path for the disk, or `nil` if no data disk is inserted.

hasAudio()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L117)
:   Returns whether a disk with audio is inserted.

    ### Returns

    1. `boolean` Whether a disk with audio is inserted.

getAudioTitle()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L128)
:   Returns the title of the inserted audio disk.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil | false The title of the audio, `false` if no disk is inserted, or `nil` if the disk has no audio.

playAudio()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L138)
:   Plays the audio in the inserted disk, if available.

stopAudio()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L148)
:   Stops any audio that may be playing.

    ### See also

    * **[`playAudio`](drive.html#v:playAudio)**

ejectDisk()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L156)
:   Ejects any disk that may be in the drive.

getDiskID()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/diskdrive/DiskDrivePeripheral.java#L168)
:   Returns the ID of the disk inserted in the drive.

    ### Returns

    1. `number` | nil The ID of the disk in the drive, or `nil` if no disk with an ID is inserted.

    ### Changes

    * **New in version 1.4**