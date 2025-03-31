# redstone

Get and set redstone signals adjacent to this computer.

The [`redstone`](redstone.html) library exposes three "types" of redstone control:

* Binary input/output ([`setOutput`](redstone.html#v:setOutput)/[`getInput`](redstone.html#v:getInput)): These simply check if a redstone wire has any input or
  output. A signal strength of 1 and 15 are treated the same.
* Analogue input/output ([`setAnalogOutput`](redstone.html#v:setAnalogOutput)/[`getAnalogInput`](redstone.html#v:getAnalogInput)): These work with the actual signal
  strength of the redstone wired, from 0 to 15.
* Bundled cables ([`setBundledOutput`](redstone.html#v:setBundledOutput)/[`getBundledInput`](redstone.html#v:getBundledInput)): These interact with "bundled" cables, such
  as those from Project:Red. These allow you to send 16 separate on/off signals. Each channel corresponds to a
  colour, with the first being [`colors.white`](colors.html#v:white) and the last [`colors.black`](colors.html#v:black).

Whenever a redstone input changes, a [`redstone`](../event/redstone.html) event will be fired. This may be used instead of repeativly
polling.

This module may also be referred to as `rs`. For example, one may call `rs.getSides()` instead of
[`getSides`](redstone.html#v:getSides).

### Usage

* Toggle the redstone signal above the computer every 0.5 seconds.

  ```
  while true do
    redstone.setOutput("top", not redstone.getOutput("top"))
    sleep(0.5)
  end
  ```
* Mimic a redstone comparator in [subtraction mode](https://minecraft.wiki/w/Redstone_Comparator#Subtract_signal_strength "Redstone Comparator on
  the Minecraft wiki.").

  ```
  while true do
    local rear = rs.getAnalogueInput("back")
    local sides = math.max(rs.getAnalogueInput("left"), rs.getAnalogueInput("right"))
    rs.setAnalogueOutput("front", math.max(rear - sides, 0))

    os.pullEvent("redstone") -- Wait for a change to inputs.
  end
  ```

|  |  |
| --- | --- |
| [getSides()](#v:getSides) | Returns a table containing the six sides of the computer. |
| [setOutput(side, on)](#v:setOutput) | Turn the redstone signal of a specific side on or off. |
| [getOutput(side)](#v:getOutput) | Get the current redstone output of a specific side. |
| [getInput(side)](#v:getInput) | Get the current redstone input of a specific side. |
| [setAnalogOutput(side, value)](#v:setAnalogOutput) | Set the redstone signal strength for a specific side. |
| [setAnalogueOutput(side, value)](#v:setAnalogueOutput) | Set the redstone signal strength for a specific side. |
| [getAnalogOutput(side)](#v:getAnalogOutput) | Get the redstone output signal strength for a specific side. |
| [getAnalogueOutput(side)](#v:getAnalogueOutput) | Get the redstone output signal strength for a specific side. |
| [getAnalogInput(side)](#v:getAnalogInput) | Get the redstone input signal strength for a specific side. |
| [getAnalogueInput(side)](#v:getAnalogueInput) | Get the redstone input signal strength for a specific side. |
| [setBundledOutput(side, output)](#v:setBundledOutput) | Set the bundled cable output for a specific side. |
| [getBundledOutput(side)](#v:getBundledOutput) | Get the bundled cable output for a specific side. |
| [getBundledInput(side)](#v:getBundledInput) | Get the bundled cable input for a specific side. |
| [testBundledInput(side, mask)](#v:testBundledInput) | Determine if a specific combination of colours are on for the given side. |

getSides()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneAPI.java#L73)
:   Returns a table containing the six sides of the computer. Namely, "top", "bottom", "left", "right", "front" and
    "back".

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)... } A table of valid sides.

    ### Changes

    * **New in version 1.2**

setOutput(side, on)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L27)
:   Turn the redstone signal of a specific side on or off.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to set.
    2. on `boolean` Whether the redstone signal should be on or off. When on, a signal strength of 15 is emitted.

getOutput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L39)
:   Get the current redstone output of a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `boolean` Whether the redstone output is on or off.

    ### See also

    * **[`setOutput`](redstone.html#v:setOutput)**

getInput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L50)
:   Get the current redstone input of a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `boolean` Whether the redstone input is on or off.

setAnalogOutput(side, value)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L63)
:   Set the redstone signal strength for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to set.
    2. value `number` The signal strength between 0 and 15.

    ### Throws

    * If `value` is not between 0 and 15.

    ### Changes

    * **New in version 1.51**

setAnalogueOutput(side, value)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L63)
:   Set the redstone signal strength for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to set.
    2. value `number` The signal strength between 0 and 15.

    ### Throws

    * If `value` is not between 0 and 15.

    ### Changes

    * **New in version 1.51**

getAnalogOutput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L77)
:   Get the redstone output signal strength for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `number` The output signal strength, between 0 and 15.

    ### See also

    * **[`setAnalogOutput`](redstone.html#v:setAnalogOutput)**

    ### Changes

    * **New in version 1.51**

getAnalogueOutput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L77)
:   Get the redstone output signal strength for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `number` The output signal strength, between 0 and 15.

    ### See also

    * **[`setAnalogOutput`](redstone.html#v:setAnalogOutput)**

    ### Changes

    * **New in version 1.51**

getAnalogInput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L89)
:   Get the redstone input signal strength for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `number` The input signal strength, between 0 and 15.

    ### Changes

    * **New in version 1.51**

getAnalogueInput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L89)
:   Get the redstone input signal strength for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `number` The input signal strength, between 0 and 15.

    ### Changes

    * **New in version 1.51**

setBundledOutput(side, output)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L102)
:   Set the bundled cable output for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to set.
    2. output `number` The colour bitmask to set.

    ### See also

    * **[`colors.subtract`](colors.html#v:subtract)** For removing a colour from the bitmask.
    * **[`colors.combine`](colors.html#v:combine)** For adding a color to the bitmask.

getBundledOutput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L113)
:   Get the bundled cable output for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `number` The bundle cable's output.

getBundledInput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L125)
:   Get the bundled cable input for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `number` The bundle cable's input.

    ### See also

    * **[`testBundledInput`](redstone.html#v:testBundledInput)** To determine if a specific colour is set.

testBundledInput(side, mask)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L142)
:   Determine if a specific combination of colours are on for the given side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to test.
    2. mask `number` The mask to test.

    ### Returns

    1. `boolean` If the colours are on.

    ### Usage

    * Check if [`colors.white`](colors.html#v:white) and [`colors.black`](colors.html#v:black) are on above this block.

      ```
      print(redstone.testBundledInput("top", colors.combine(colors.white, colors.black)))
      ```

    ### See also

    * **[`getBundledInput`](redstone.html#v:getBundledInput)**