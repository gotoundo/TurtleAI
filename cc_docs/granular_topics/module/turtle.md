# turtle

Turtles are a robotic device, which can break and place blocks, attack mobs, and move about the world. They have
an internal inventory of 16 slots, allowing them to store blocks they have broken or would like to place.

## Movement

Turtles are capable of moving through the world. As turtles are blocks themselves, they are confined to Minecraft's
grid, moving a single block at a time.

[`turtle.forward`](turtle.html#v:forward) and [`turtle.back`](turtle.html#v:back) move the turtle in the direction it is facing, while [`turtle.up`](turtle.html#v:up) and
[`turtle.down`](turtle.html#v:down) move it up and down (as one might expect!). In order to move left or right, you first need
to turn the turtle using [`turtle.turnLeft`](turtle.html#v:turnLeft)/[`turtle.turnRight`](turtle.html#v:turnRight) and then move forward or backwards.

##### ð info

The name "turtle" comes from [Turtle graphics](https://en.wikipedia.org/wiki/Turtle_graphics "Turtle graphics"), which originated from the Logo programming language. Here you'd
move a turtle with various commands like "move 10" and "turn left", much like ComputerCraft's turtles!

Moving a turtle (though not turning it) consumes *fuel*. If a turtle does not have any [fuel](turtle.html#v:refuel), it
won't move, and the movement functions will return `false`. If your turtle isn't going anywhere, the first thing to
check is if you've fuelled your turtle.

##### Handling errors

Many turtle functions can fail in various ways. For instance, a turtle cannot move forward if there's already a
block there. Instead of erroring, functions which can fail either return `true` if they succeed, or `false` and
some error message if they fail.

Unexpected failures can often lead to strange behaviour. It's often a good idea to check the return values of these
functions, or wrap them in [`assert`](https://www.lua.org/manual/5.1/manual.html#pdf-assert) (for instance, use `assert(turtle.forward())` rather than `turtle.forward()`),
so the program doesn't misbehave.

## Turtle upgrades

While a normal turtle can move about the world and place blocks, its functionality is limited. Thankfully, turtles
can be upgraded with upgrades. Turtles have two upgrade slots, one on the left and right sides. Upgrades can be
equipped by crafting a turtle with the upgrade, or calling the [`turtle.equipLeft`](turtle.html#v:equipLeft)/[`turtle.equipRight`](turtle.html#v:equipRight) functions.

By default, any diamond tool may be used as an upgrade (though more may be added with [datapacks](https://datapacks.madefor.cc)). The diamond
pickaxe may be used to break blocks (with [`turtle.dig`](turtle.html#v:dig)), while the sword can attack entities ([`turtle.attack`](turtle.html#v:attack)).
Other tools have more niche use-cases, for instance hoes can til dirt.

Some peripherals (namely [speakers](../peripheral/speaker.html) and Ender and Wireless [modems](../peripheral/modem.html)) can also be equipped as
upgrades. These are then accessible by accessing the `"left"` or `"right"` peripheral.

## Recipes

**Turtle**

![Iron Ingot](/images/items/minecraft/iron_ingot.png "Iron Ingot")

![Iron Ingot](/images/items/minecraft/iron_ingot.png "Iron Ingot")

![Iron Ingot](/images/items/minecraft/iron_ingot.png "Iron Ingot")

![Iron Ingot](/images/items/minecraft/iron_ingot.png "Iron Ingot")

![Computer](/images/items/computercraft/computer_normal.png "Computer")

![Iron Ingot](/images/items/minecraft/iron_ingot.png "Iron Ingot")

![Iron Ingot](/images/items/minecraft/iron_ingot.png "Iron Ingot")

![Chest](/images/items/minecraft/chest.png "Chest")

![Iron Ingot](/images/items/minecraft/iron_ingot.png "Iron Ingot")

![Turtle](/images/items/computercraft/turtle_normal.png "Turtle")

**Advanced Turtle**

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Advanced Computer](/images/items/computercraft/computer_advanced.png "Advanced Computer")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Chest](/images/items/minecraft/chest.png "Chest")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Advanced Turtle](/images/items/computercraft/turtle_advanced.png "Advanced Turtle")

### Changes

* **New in version 1.3**

|  |  |
| --- | --- |
| [craft([limit=64])](#v:craft) | Craft a recipe based on the turtle's inventory. |
| [native](#v:native) | The builtin turtle API, without any generated helper functions. |
| [forward()](#v:forward) | Move the turtle forward one block. |
| [back()](#v:back) | Move the turtle backwards one block. |
| [up()](#v:up) | Move the turtle up one block. |
| [down()](#v:down) | Move the turtle down one block. |
| [turnLeft()](#v:turnLeft) | Rotate the turtle 90 degrees to the left. |
| [turnRight()](#v:turnRight) | Rotate the turtle 90 degrees to the right. |
| [dig([side])](#v:dig) | Attempt to break the block in front of the turtle. |
| [digUp([side])](#v:digUp) | Attempt to break the block above the turtle. |
| [digDown([side])](#v:digDown) | Attempt to break the block below the turtle. |
| [place([text])](#v:place) | Place a block or item into the world in front of the turtle. |
| [placeUp([text])](#v:placeUp) | Place a block or item into the world above the turtle. |
| [placeDown([text])](#v:placeDown) | Place a block or item into the world below the turtle. |
| [drop([count])](#v:drop) | Drop the currently selected stack into the inventory in front of the turtle, or as an item into the world if there is no inventory. |
| [dropUp([count])](#v:dropUp) | Drop the currently selected stack into the inventory above the turtle, or as an item into the world if there is no inventory. |
| [dropDown([count])](#v:dropDown) | Drop the currently selected stack into the inventory below the turtle, or as an item into the world if there is no inventory. |
| [select(slot)](#v:select) | Change the currently selected slot. |
| [getItemCount([slot])](#v:getItemCount) | Get the number of items in the given slot. |
| [getItemSpace([slot])](#v:getItemSpace) | Get the remaining number of items which may be stored in this stack. |
| [detect()](#v:detect) | Check if there is a solid block in front of the turtle. |
| [detectUp()](#v:detectUp) | Check if there is a solid block above the turtle. |
| [detectDown()](#v:detectDown) | Check if there is a solid block below the turtle. |
| [compare()](#v:compare) | Check if the block in front of the turtle is equal to the item in the currently selected slot. |
| [compareUp()](#v:compareUp) | Check if the block above the turtle is equal to the item in the currently selected slot. |
| [compareDown()](#v:compareDown) | Check if the block below the turtle is equal to the item in the currently selected slot. |
| [attack([side])](#v:attack) | Attack the entity in front of the turtle. |
| [attackUp([side])](#v:attackUp) | Attack the entity above the turtle. |
| [attackDown([side])](#v:attackDown) | Attack the entity below the turtle. |
| [suck([count])](#v:suck) | Suck an item from the inventory in front of the turtle, or from an item floating in the world. |
| [suckUp([count])](#v:suckUp) | Suck an item from the inventory above the turtle, or from an item floating in the world. |
| [suckDown([count])](#v:suckDown) | Suck an item from the inventory below the turtle, or from an item floating in the world. |
| [getFuelLevel()](#v:getFuelLevel) | Get the maximum amount of fuel this turtle currently holds. |
| [refuel([count])](#v:refuel) | Refuel this turtle. |
| [compareTo(slot)](#v:compareTo) | Compare the item in the currently selected slot to the item in another slot. |
| [transferTo(slot [, count])](#v:transferTo) | Move an item from the selected slot to another one. |
| [getSelectedSlot()](#v:getSelectedSlot) | Get the currently selected slot. |
| [getFuelLimit()](#v:getFuelLimit) | Get the maximum amount of fuel this turtle can hold. |
| [equipLeft()](#v:equipLeft) | Equip (or unequip) an item on the left side of this turtle. |
| [equipRight()](#v:equipRight) | Equip (or unequip) an item on the right side of this turtle. |
| [getEquippedLeft()](#v:getEquippedLeft) | Get the upgrade currently equipped on the left of the turtle. |
| [getEquippedRight()](#v:getEquippedRight) | Get the upgrade currently equipped on the right of the turtle. |
| [inspect()](#v:inspect) | Get information about the block in front of the turtle. |
| [inspectUp()](#v:inspectUp) | Get information about the block above the turtle. |
| [inspectDown()](#v:inspectDown) | Get information about the block below the turtle. |
| [getItemDetail([slot [, detailed]])](#v:getItemDetail) | Get detailed information about the items in the given slot. |

craft([limit=64])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/doc/stub/turtle.lua#L17)
:   Craft a recipe based on the turtle's inventory.
    The turtle's inventory should set up like a crafting grid. For instance, to
    craft sticks, slots 1 and 5 should contain planks. *All* other slots should be
    empty, including those outside the crafting "grid".

    ### Parameters

    1. limit? `number` = `64` The maximum number of crafting steps to run.

    ### Returns

    1. true If crafting succeeds.

    #### Or

    1. false If crafting fails.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) A string describing why crafting failed.

    ### Throws

    * When limit is less than 1 or greater than 64.

    ### Changes

    * **New in version 1.4**

native[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/turtle/turtle.lua#L15)
:   ##### ð Deprecated

    Historically this table behaved differently to the main turtle API, but this is no longer the case. You
    should not need to use it.

    The builtin turtle API, without any generated helper functions.

forward()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L100)
:   Move the turtle forward one block.

    ### Returns

    1. `boolean` Whether the turtle could successfully move.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the turtle could not move.

back()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L112)
:   Move the turtle backwards one block.

    ### Returns

    1. `boolean` Whether the turtle could successfully move.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the turtle could not move.

up()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L124)
:   Move the turtle up one block.

    ### Returns

    1. `boolean` Whether the turtle could successfully move.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the turtle could not move.

down()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L136)
:   Move the turtle down one block.

    ### Returns

    1. `boolean` Whether the turtle could successfully move.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the turtle could not move.

turnLeft()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L148)
:   Rotate the turtle 90 degrees to the left.

    ### Returns

    1. `boolean` Whether the turtle could successfully turn.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the turtle could not turn.

turnRight()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L160)
:   Rotate the turtle 90 degrees to the right.

    ### Returns

    1. `boolean` Whether the turtle could successfully turn.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the turtle could not turn.

dig([side])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L178)
:   Attempt to break the block in front of the turtle.

    This requires a turtle tool capable of breaking the block. Diamond pickaxes
    (mining turtles) can break any vanilla block, but other tools (such as axes)
    are more limited.

    ### Parameters

    1. side? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The specific tool to use. Should be "left" or "right".

    ### Returns

    1. `boolean` Whether a block was broken.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason no block was broken.

    ### Changes

    * **Changed in version 1.6:** Added optional side argument.

digUp([side])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L193)
:   Attempt to break the block above the turtle. See [`dig`](turtle.html#v:dig) for full details.

    ### Parameters

    1. side? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The specific tool to use.

    ### Returns

    1. `boolean` Whether a block was broken.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason no block was broken.

    ### Changes

    * **Changed in version 1.6:** Added optional side argument.

digDown([side])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L208)
:   Attempt to break the block below the turtle. See [`dig`](turtle.html#v:dig) for full details.

    ### Parameters

    1. side? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The specific tool to use.

    ### Returns

    1. `boolean` Whether a block was broken.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason no block was broken.

    ### Changes

    * **Changed in version 1.6:** Added optional side argument.

place([text])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L228)
:   Place a block or item into the world in front of the turtle.

    "Placing" an item allows it to interact with blocks and entities in front of the turtle. For instance, buckets
    can pick up and place down fluids, and wheat can be used to breed cows. However, you cannot use [`place`](turtle.html#v:place) to
    perform arbitrary block interactions, such as clicking buttons or flipping levers.

    ### Parameters

    1. text? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) When placing a sign, set its contents to this text.

    ### Returns

    1. `boolean` Whether the block could be placed.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the block was not placed.

    ### Changes

    * **New in version 1.4**

placeUp([text])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L244)
:   Place a block or item into the world above the turtle.

    ### Parameters

    1. text? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) When placing a sign, set its contents to this text.

    ### Returns

    1. `boolean` Whether the block could be placed.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the block was not placed.

    ### See also

    * **[`place`](turtle.html#v:place)** For more information about placing items.

    ### Changes

    * **New in version 1.4**

placeDown([text])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L260)
:   Place a block or item into the world below the turtle.

    ### Parameters

    1. text? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) When placing a sign, set its contents to this text.

    ### Returns

    1. `boolean` Whether the block could be placed.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the block was not placed.

    ### See also

    * **[`place`](turtle.html#v:place)** For more information about placing items.

    ### Changes

    * **New in version 1.4**

drop([count])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L277)
:   Drop the currently selected stack into the inventory in front of the turtle, or as an item into the world if
    there is no inventory.

    ### Parameters

    1. count? `number` The number of items to drop. If not given, the entire stack will be dropped.

    ### Returns

    1. `boolean` Whether items were dropped.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the no items were dropped.

    ### Throws

    * If dropping an invalid number of items.

    ### See also

    * **[`select`](turtle.html#v:select)**

    ### Changes

    * **New in version 1.31**

dropUp([count])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L294)
:   Drop the currently selected stack into the inventory above the turtle, or as an item into the world if there is
    no inventory.

    ### Parameters

    1. count? `number` The number of items to drop. If not given, the entire stack will be dropped.

    ### Returns

    1. `boolean` Whether items were dropped.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the no items were dropped.

    ### Throws

    * If dropping an invalid number of items.

    ### See also

    * **[`select`](turtle.html#v:select)**

    ### Changes

    * **New in version 1.4**

dropDown([count])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L311)
:   Drop the currently selected stack into the inventory below the turtle, or as an item into the world if
    there is no inventory.

    ### Parameters

    1. count? `number` The number of items to drop. If not given, the entire stack will be dropped.

    ### Returns

    1. `boolean` Whether items were dropped.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the no items were dropped.

    ### Throws

    * If dropping an invalid number of items.

    ### See also

    * **[`select`](turtle.html#v:select)**

    ### Changes

    * **New in version 1.4**

select(slot)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L328)
:   Change the currently selected slot.

    The selected slot is determines what slot actions like [`drop`](turtle.html#v:drop) or [`getItemCount`](turtle.html#v:getItemCount) act on.

    ### Parameters

    1. slot `number` The slot to select.

    ### Returns

    1. true When the slot has been selected.

    ### Throws

    * If the slot is out of range.

    ### See also

    * **[`getSelectedSlot`](turtle.html#v:getSelectedSlot)**

getItemCount([slot])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L344)
:   Get the number of items in the given slot.

    ### Parameters

    1. slot? `number` The slot we wish to check. Defaults to the [selected slot](turtle.html#v:select).

    ### Returns

    1. `number` The number of items in this slot.

    ### Throws

    * If the slot is out of range.

getItemSpace([slot])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L359)
:   Get the remaining number of items which may be stored in this stack.

    For instance, if a slot contains 13 blocks of dirt, it has room for another 51.

    ### Parameters

    1. slot? `number` The slot we wish to check. Defaults to the [selected slot](turtle.html#v:select).

    ### Returns

    1. `number` The space left in this slot.

    ### Throws

    * If the slot is out of range.

detect()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L373)
:   Check if there is a solid block in front of the turtle. In this case, solid refers to any non-air or liquid
    block.

    ### Returns

    1. `boolean` If there is a solid block in front.

detectUp()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L384)
:   Check if there is a solid block above the turtle. In this case, solid refers to any non-air or liquid block.

    ### Returns

    1. `boolean` If there is a solid block above.

detectDown()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L395)
:   Check if there is a solid block below the turtle. In this case, solid refers to any non-air or liquid block.

    ### Returns

    1. `boolean` If there is a solid block below.

compare()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L407)
:   Check if the block in front of the turtle is equal to the item in the currently selected slot.

    ### Returns

    1. `boolean` If the block and item are equal.

    ### Changes

    * **New in version 1.31**

compareUp()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L419)
:   Check if the block above the turtle is equal to the item in the currently selected slot.

    ### Returns

    1. `boolean` If the block and item are equal.

    ### Changes

    * **New in version 1.31**

compareDown()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L431)
:   Check if the block below the turtle is equal to the item in the currently selected slot.

    ### Returns

    1. `boolean` If the block and item are equal.

    ### Changes

    * **New in version 1.31**

attack([side])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L446)
:   Attack the entity in front of the turtle.

    ### Parameters

    1. side? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The specific tool to use.

    ### Returns

    1. `boolean` Whether an entity was attacked.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason nothing was attacked.

    ### Changes

    * **New in version 1.4**
    * **Changed in version 1.6:** Added optional side argument.

attackUp([side])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L461)
:   Attack the entity above the turtle.

    ### Parameters

    1. side? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The specific tool to use.

    ### Returns

    1. `boolean` Whether an entity was attacked.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason nothing was attacked.

    ### Changes

    * **New in version 1.4**
    * **Changed in version 1.6:** Added optional side argument.

attackDown([side])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L476)
:   Attack the entity below the turtle.

    ### Parameters

    1. side? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The specific tool to use.

    ### Returns

    1. `boolean` Whether an entity was attacked.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason nothing was attacked.

    ### Changes

    * **New in version 1.4**
    * **Changed in version 1.6:** Added optional side argument.

suck([count])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L494)
:   Suck an item from the inventory in front of the turtle, or from an item floating in the world.

    This will pull items into the first acceptable slot, starting at the [currently selected](turtle.html#v:select) one.

    ### Parameters

    1. count? `number` The number of items to suck. If not given, up to a stack of items will be picked up.

    ### Returns

    1. `boolean` Whether items were picked up.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the no items were picked up.

    ### Throws

    * If given an invalid number of items.

    ### Changes

    * **New in version 1.4**
    * **Changed in version 1.6:** Added an optional limit argument.

suckUp([count])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L510)
:   Suck an item from the inventory above the turtle, or from an item floating in the world.

    ### Parameters

    1. count? `number` The number of items to suck. If not given, up to a stack of items will be picked up.

    ### Returns

    1. `boolean` Whether items were picked up.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the no items were picked up.

    ### Throws

    * If given an invalid number of items.

    ### Changes

    * **New in version 1.4**
    * **Changed in version 1.6:** Added an optional limit argument.

suckDown([count])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L526)
:   Suck an item from the inventory below the turtle, or from an item floating in the world.

    ### Parameters

    1. count? `number` The number of items to suck. If not given, up to a stack of items will be picked up.

    ### Returns

    1. `boolean` Whether items were picked up.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason the no items were picked up.

    ### Throws

    * If given an invalid number of items.

    ### Changes

    * **New in version 1.4**
    * **Changed in version 1.6:** Added an optional limit argument.

getFuelLevel()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L541)
:   Get the maximum amount of fuel this turtle currently holds.

    ### Returns

    1. `number` The current amount of fuel a turtle this turtle has.

    #### Or

    1. "unlimited" If turtles do not consume fuel when moving.

    ### See also

    * **[`getFuelLimit`](turtle.html#v:getFuelLimit)**
    * **[`refuel`](turtle.html#v:refuel)**

    ### Changes

    * **New in version 1.4**

refuel([count])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L583)
:   Refuel this turtle.

    While most actions a turtle can perform (such as digging or placing blocks) are free, moving consumes fuel from
    the turtle's internal buffer. If a turtle has no fuel, it will not move.

    [`refuel`](turtle.html#v:refuel) refuels the turtle, consuming fuel items (such as coal or lava buckets) from the currently
    selected slot and converting them into energy. This finishes once the turtle is fully refuelled or all items have
    been consumed.

    ### Parameters

    1. count? `number` The maximum number of items to consume. One can pass `0` to check if an item is combustable or not.

    ### Returns

    1. true If the turtle was refuelled.

    #### Or

    1. false If the turtle was not refuelled.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The reason the turtle was not refuelled.

    ### Throws

    * If the refuel count is out of range.

    ### Usage

    * Refuel a turtle from the currently selected slot.

      ```
      local level = turtle.getFuelLevel()
      if level == "unlimited" then error("Turtle does not need fuel", 0) end

      local ok, err = turtle.refuel()
      if ok then
        local new_level = turtle.getFuelLevel()
        print(("Refuelled %d, current level is %d"):format(new_level - level, new_level))
      else
        printError(err)
      end
      ```
    * Check if the current item is a valid fuel source.

      ```
      local is_fuel, reason = turtle.refuel(0)
      if not is_fuel then printError(reason) end
      ```

    ### See also

    * **[`getFuelLevel`](turtle.html#v:getFuelLevel)**
    * **[`getFuelLimit`](turtle.html#v:getFuelLimit)**

    ### Changes

    * **New in version 1.4**

compareTo(slot)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L599)
:   Compare the item in the currently selected slot to the item in another slot.

    ### Parameters

    1. slot `number` The slot to compare to.

    ### Returns

    1. `boolean` If the two items are equal.

    ### Throws

    * If the slot is out of range.

    ### Changes

    * **New in version 1.4**

transferTo(slot [, count])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L615)
:   Move an item from the selected slot to another one.

    ### Parameters

    1. slot `number` The slot to move this item to.
    2. count? `number` The maximum number of items to move.

    ### Returns

    1. `boolean` If some items were successfully moved.

    ### Throws

    * If the slot is out of range.
    * If the number of items is out of range.

    ### Changes

    * **New in version 1.45**

getSelectedSlot()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L629)
:   Get the currently selected slot.

    ### Returns

    1. `number` The current slot.

    ### See also

    * **[`select`](turtle.html#v:select)**

    ### Changes

    * **New in version 1.6**

getFuelLimit()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L646)
:   Get the maximum amount of fuel this turtle can hold.

    By default, normal turtles have a limit of 20,000 and advanced turtles of 100,000.

    ### Returns

    1. `number` The maximum amount of fuel a turtle can hold.

    #### Or

    1. "unlimited" If turtles do not consume fuel when moving.

    ### See also

    * **[`getFuelLevel`](turtle.html#v:getFuelLevel)**
    * **[`refuel`](turtle.html#v:refuel)**

    ### Changes

    * **New in version 1.6**

equipLeft()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L666)
:   Equip (or unequip) an item on the left side of this turtle.

    This finds the item in the currently selected slot and attempts to equip it to the left side of the turtle. The
    previous upgrade is removed and placed into the turtle's inventory. If there is no item in the slot, the previous
    upgrade is removed, but no new one is equipped.

    ### Returns

    1. true If the item was equipped.

    #### Or

    1. false If we could not equip the item.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The reason equipping this item failed.

    ### See also

    * **[`equipRight`](turtle.html#v:equipRight)**
    * **[`getEquippedLeft`](turtle.html#v:getEquippedLeft)**

    ### Changes

    * **New in version 1.6**

equipRight()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L686)
:   Equip (or unequip) an item on the right side of this turtle.

    This finds the item in the currently selected slot and attempts to equip it to the right side of the turtle. The
    previous upgrade is removed and placed into the turtle's inventory. If there is no item in the slot, the previous
    upgrade is removed, but no new one is equipped.

    ### Returns

    1. true If the item was equipped.

    #### Or

    1. false If we could not equip the item.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The reason equipping this item failed.

    ### See also

    * **[`equipLeft`](turtle.html#v:equipLeft)**
    * **[`getEquippedRight`](turtle.html#v:getEquippedRight)**

    ### Changes

    * **New in version 1.6**

getEquippedLeft()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L701)
:   Get the upgrade currently equipped on the left of the turtle.

    This returns information about the currently equipped item, in the same form as
    [`getItemDetail`](turtle.html#v:getItemDetail).

    ### Returns

    1. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) | nil Information about the currently equipped item, or `nil` if no upgrade is equipped.

    ### See also

    * **[`equipLeft`](turtle.html#v:equipLeft)**

    ### Changes

    * **New in version 1.116.0**

getEquippedRight()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L717)
:   Get the upgrade currently equipped on the right of the turtle.

    This returns information about the currently equipped item, in the same form as
    [`getItemDetail`](turtle.html#v:getItemDetail).

    ### Returns

    1. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) | nil Information about the currently equipped item, or `nil` if no upgrade is equipped.

    ### See also

    * **[`equipRight`](turtle.html#v:equipRight)**

    ### Changes

    * **New in version 1.116.0**

inspect()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L744)
:   Get information about the block in front of the turtle.

    ### Returns

    1. `boolean` Whether there is a block in front of the turtle.
    2. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) | [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Information about the block in front, or a message explaining that there is no block.

    ### Usage

    * ```
      local has_block, data = turtle.inspect()
      if has_block then
        print(textutils.serialise(data))
        -- {
        --   name = "minecraft:oak_log",
        --   state = { axis = "x" },
        --   tags = { ["minecraft:logs"] = true, ... },
        -- }
      else
        print("No block in front of the turtle")
      end
      ```

    ### Changes

    * **New in version 1.64**
    * **Changed in version 1.76:** Added block state to return value.

inspectUp()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L757)
:   Get information about the block above the turtle.

    ### Returns

    1. `boolean` Whether there is a block above the turtle.
    2. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) | [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Information about the above below, or a message explaining that there is no block.

    ### Changes

    * **New in version 1.64**

inspectDown()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L770)
:   Get information about the block below the turtle.

    ### Returns

    1. `boolean` Whether there is a block below the turtle.
    2. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) | [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) Information about the block below, or a message explaining that there is no block.

    ### Changes

    * **New in version 1.64**

getItemDetail([slot [, detailed]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/turtle/apis/TurtleAPI.java#L798)
:   Get detailed information about the items in the given slot.

    ### Parameters

    1. slot? `number` The slot to get information about. Defaults to the [selected slot](turtle.html#v:select).
    2. detailed? `boolean` Whether to include "detailed" information. When `true` the method will contain much
       more information about the item at the cost of taking longer to run.

    ### Returns

    1. nil | [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) Information about the item in this slot, or `nil` if it is empty.

    ### Throws

    * If the slot is out of range.

    ### Usage

    * Print the current slot, assuming it contains 13 dirt.

      ```
      print(textutils.serialise(turtle.getItemDetail()))
      -- => {
      --  name = "minecraft:dirt",
      --  count = 13,
      -- }
      ```

    ### See also

    * **[`inventory.getItemDetail`](../generic_peripheral/inventory.html#v:getItemDetail)** Describes the information returned by a detailed query.

    ### Changes

    * **New in version 1.64**
    * **Changed in version 1.90.0:** Added detailed parameter.