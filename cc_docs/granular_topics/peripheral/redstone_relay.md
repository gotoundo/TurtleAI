# redstone\_relay

The redstone relay is a peripheral that allows reading and outputting redstone signals. While this is not very useful
on its own (as computers have the same functionality [built-in](../module/redstone.html)), this can be used with [wired
modems](modem.html) to interact with multiple redstone signals from the same computer.

The peripheral provides largely identical methods to a computer's built-in [`redstone`](../module/redstone.html) API, allowing setting
signals on all six sides of the block ("top", "bottom", "left", "right", "front" and "back").

## Recipe

**Redstone Relay**

![Stone](/images/items/minecraft/stone.png "Stone")

![Redstone Dust](/images/items/minecraft/redstone.png "Redstone Dust")

![Stone](/images/items/minecraft/stone.png "Stone")

![Redstone Dust](/images/items/minecraft/redstone.png "Redstone Dust")

![Wired Modem](/images/items/computercraft/wired_modem.png "Wired Modem")

![Redstone Dust](/images/items/minecraft/redstone.png "Redstone Dust")

![Stone](/images/items/minecraft/stone.png "Stone")

![Redstone Dust](/images/items/minecraft/redstone.png "Redstone Dust")

![Stone](/images/items/minecraft/stone.png "Stone")

![Redstone Relay](/images/items/computercraft/redstone_relay.png "Redstone Relay")

### Usage

* Toggle the redstone signal above the computer every 0.5 seconds.

  ```
  local relay = peripheral.find("redstone_relay")
  while true do
    relay.setOutput("top", not relay.getOutput("top"))
    sleep(0.5)
  end
  ```

### Changes

* **New in version 1.114.0**

|  |  |
| --- | --- |
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

    * **[`setOutput`](redstone_relay.html#v:setOutput)**

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

    * **[`setAnalogOutput`](redstone_relay.html#v:setAnalogOutput)**

    ### Changes

    * **New in version 1.51**

getAnalogueOutput(side)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L77)
:   Get the redstone output signal strength for a specific side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to get.

    ### Returns

    1. `number` The output signal strength, between 0 and 15.

    ### See also

    * **[`setAnalogOutput`](redstone_relay.html#v:setAnalogOutput)**

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

    * **[`colors.subtract`](../module/colors.html#v:subtract)** For removing a colour from the bitmask.
    * **[`colors.combine`](../module/colors.html#v:combine)** For adding a color to the bitmask.

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

    * **[`testBundledInput`](redstone_relay.html#v:testBundledInput)** To determine if a specific colour is set.

testBundledInput(side, mask)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/RedstoneMethods.java#L142)
:   Determine if a specific combination of colours are on for the given side.

    ### Parameters

    1. side [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The side to test.
    2. mask `number` The mask to test.

    ### Returns

    1. `boolean` If the colours are on.

    ### Usage

    * Check if [`colors.white`](../module/colors.html#v:white) and [`colors.black`](../module/colors.html#v:black) are on above this block.

      ```
      print(redstone.testBundledInput("top", colors.combine(colors.white, colors.black)))
      ```

    ### See also

    * **[`getBundledInput`](redstone_relay.html#v:getBundledInput)**