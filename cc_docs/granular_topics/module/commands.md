# commands

Execute [Minecraft commands](https://minecraft.wiki/w/Commands) and gather data from the results from
a command computer.

##### ð note

This API is only available on Command computers. It is not accessible to normal
players.

While one may use [`commands.exec`](commands.html#v:exec) directly to execute a command, the
commands API also provides helper methods to execute every command. For
instance, `commands.say("Hi!")` is equivalent to `commands.exec("say Hi!")`.

[`commands.async`](commands.html#v:async) provides a similar interface to execute asynchronous
commands. `commands.async.say("Hi!")` is equivalent to
`commands.execAsync("say Hi!")`.

### Usage

* Set the block above this computer to stone:

  ```
  commands.setblock("~", "~1", "~", "minecraft:stone")
  ```

### Changes

* **New in version 1.7**

|  |  |
| --- | --- |
| [exec(command)](#v:exec) | Execute a specific command. |
| [execAsync(command)](#v:execAsync) | Asynchronously execute a command. |
| [list(...)](#v:list) | List all available commands which the computer has permission to execute. |
| [getBlockPosition()](#v:getBlockPosition) | Get the position of the current command computer. |
| [getBlockInfos(minX, minY, minZ, maxX, maxY, maxZ [, dimension])](#v:getBlockInfos) | Get information about a range of blocks. |
| [getBlockInfo(x, y, z [, dimension])](#v:getBlockInfo) | Get some basic information about a block. |
| [native](#v:native) | The builtin commands API, without any generated command helper functions |
| [async](#v:async) | A table containing asynchronous wrappers for all commands. |

exec(command)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/computer/apis/CommandAPI.java#L100)
:   Execute a specific command.

    ### Parameters

    1. command [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The command to execute.

    ### Returns

    1. `boolean` Whether the command executed successfully.
    2. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } The output of this command, as a list of lines.
    3. `number` | nil The number of "affected" objects, or `nil` if the command failed. The definition of this
       varies from command to command.

    ### Usage

    * Set the block above the command computer to stone.

      ```
      commands.exec("setblock ~ ~1 ~ minecraft:stone")
      ```

    ### Changes

    * **Changed in version 1.71:** Added return value with command output.
    * **Changed in version 1.85.0:** Added return value with the number of affected objects.

execAsync(command)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/computer/apis/CommandAPI.java#L126)
:   Asynchronously execute a command.

    Unlike [`exec`](commands.html#v:exec), this will immediately return, instead of waiting for the
    command to execute. This allows you to run multiple commands at the same
    time.

    When this command has finished executing, it will queue a `task_complete`
    event containing the result of executing this command (what [`exec`](commands.html#v:exec) would
    return).

    ### Parameters

    1. command [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The command to execute.

    ### Returns

    1. `number` The "task id". When this command has been executed, it will queue a `task_complete` event with a matching id.

    ### Usage

    * Asynchronously sets the block above the computer to stone.

      ```
      commands.execAsync("setblock ~ ~1 ~ minecraft:stone")
      ```

    ### See also

    * **[`parallel`](parallel.html)** One may also use the parallel API to run multiple commands at once.

list(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/computer/apis/CommandAPI.java#L139)
:   List all available commands which the computer has permission to execute.

    ### Parameters

    1. ... [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The sub-command to complete.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A list of all available commands

getBlockPosition()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/computer/apis/CommandAPI.java#L166)
:   Get the position of the current command computer.

    ### Returns

    1. `number` This computer's x position.
    2. `number` This computer's y position.
    3. `number` This computer's z position.

    ### See also

    * **[`gps.locate`](gps.html#v:locate)** To get the position of a non-command computer.

getBlockInfos(minX, minY, minZ, maxX, maxY, maxZ [, dimension])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/computer/apis/CommandAPI.java#L213)
:   Get information about a range of blocks.

    This returns the same information as [`getBlockInfo`](commands.html#v:getBlockInfo), just for multiple
    blocks at once.

    Blocks are traversed by ascending y level, followed by z and x - the returned
    table may be indexed using `x + z*width + y*width*depth + 1`.

    ### Parameters

    1. minX `number` The start x coordinate of the range to query.
    2. minY `number` The start y coordinate of the range to query.
    3. minZ `number` The start z coordinate of the range to query.
    4. maxX `number` The end x coordinate of the range to query.
    5. maxY `number` The end y coordinate of the range to query.
    6. maxZ `number` The end z coordinate of the range to query.
    7. dimension? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The dimension to query (e.g. "minecraft:overworld"). Defaults to the current dimension.

    ### Returns

    1. { [`table`](https://www.lua.org/manual/5.1/manual.html#5.5)... } A list of information about each block.

    ### Throws

    * If the coordinates are not within the world.
    * If trying to get information about more than 4096 blocks.

    ### Usage

    * Print out all blocks in a cube around the computer.

      ```
      -- Get a 3x3x3 cube around the computer
      local x, y, z = commands.getBlockPosition()
      local min_x, min_y, min_z, max_x, max_y, max_z = x - 1, y - 1, z - 1, x + 1, y + 1, z + 1
      local blocks = commands.getBlockInfos(min_x, min_y, min_z, max_x, max_y, max_z)

      -- Then loop over all blocks and print them out.
      local width, height, depth = max_x - min_x + 1, max_y - min_y + 1, max_z - min_z + 1
      for x = min_x, max_x do
        for y = min_y, max_y do
          for z = min_z, max_z do
            print(("%d, %d %d => %s"):format(x, y, z, blocks[(x - min_x) + (z - min_z) * width + (y - min_y) * width * depth + 1].name))
          end
        end
      end
      ```

    ### Changes

    * **New in version 1.76**
    * **Changed in version 1.99:** Added `dimension` argument.

getBlockInfo(x, y, z [, dimension])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/computer/apis/CommandAPI.java#L263)
:   Get some basic information about a block.

    The returned table contains the current name, metadata and block state (as
    with [`turtle.inspect`](turtle.html#v:inspect)). If there is a block entity for that block, its NBT
    will also be returned.

    ### Parameters

    1. x `number` The x position of the block to query.
    2. y `number` The y position of the block to query.
    3. z `number` The z position of the block to query.
    4. dimension? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The dimension to query (e.g. "minecraft:overworld"). Defaults to the current dimension.

    ### Returns

    1. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) The given block's information.

    ### Throws

    * If the coordinates are not within the world, or are not currently loaded.

    ### Changes

    * **Changed in version 1.76:** Added block state info to return value
    * **Changed in version 1.99:** Added `dimension` argument.

native[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/command/commands.lua#L35)
:   The builtin commands API, without any generated command helper functions

    This may be useful if a built-in function (such as [`commands.list`](commands.html#v:list)) has been
    overwritten by a command.

async[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/command/commands.lua#L61)
:   A table containing asynchronous wrappers for all commands.

    As with [`commands.execAsync`](commands.html#v:execAsync), this returns the "task id" of the enqueued
    command.

    ### Usage

    * Asynchronously sets the block above the computer to stone.

      ```
      commands.async.setblock("~", "~1", "~", "minecraft:stone")
      ```

    ### See also

    * **[`execAsync`](commands.html#v:execAsync)**