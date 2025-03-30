# GENERIC_PERIPHERAL Documentation

## Source File: `generic_peripheral/energy_storage.md`

# energy\_storage

Methods for interacting with blocks which store energy.

This works with energy storage blocks, as well as generators and machines which consume energy.

##### ð note

Due to limitations with Forge's energy API, it is not possible to measure throughput (i.e. FE used/generated per
tick).

### Changes

* **New in version 1.94.0**

|  |  |
| --- | --- |
| [getEnergy()](#v:getEnergy) | Get the energy of this block. |
| [getEnergyCapacity()](#v:getEnergyCapacity) | Get the maximum amount of energy this block can store. |

getEnergy()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/generic/methods/AbstractEnergyMethods.java#L42)
:   Get the energy of this block.

    ### Returns

    1. `number` The energy stored in this block, in FE.

getEnergyCapacity()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/generic/methods/AbstractEnergyMethods.java#L51)
:   Get the maximum amount of energy this block can store.

    ### Returns

    1. `number` The energy capacity of this block.

---

## Source File: `generic_peripheral/fluid_storage.md`

# fluid\_storage

Methods for interacting with tanks and other fluid storage blocks.

### Changes

* **New in version 1.94.0**

|  |  |
| --- | --- |
| [tanks()](#v:tanks) | Get all "tanks" in this fluid storage. |
| [pushFluid(toName [, limit [, fluidName]])](#v:pushFluid) | Move a fluid from one fluid container to another connected one. |
| [pullFluid(fromName [, limit [, fluidName]])](#v:pullFluid) | Move a fluid from a connected fluid container into this one. |

tanks()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/generic/methods/AbstractFluidMethods.java#L48)
:   Get all "tanks" in this fluid storage.

    Each tank either contains some amount of fluid or is empty. Tanks with fluids inside will return some basic
    information about the fluid, including its name and amount.

    The returned table is sparse, and so empty tanks will be `nil` - it is recommended to loop over using [`pairs`](https://www.lua.org/manual/5.1/manual.html#pdf-pairs)
    rather than [`ipairs`](https://www.lua.org/manual/5.1/manual.html#pdf-ipairs).

    ### Returns

    1. { [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) | nil... } Basic information about all fluids in this fluid storage.

pushFluid(toName [, limit [, fluidName]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/generic/methods/AbstractFluidMethods.java#L67)
:   Move a fluid from one fluid container to another connected one.

    This allows you to pull fluid in the current fluid container to another container *on the same wired
    network*. Both containers must attached to wired modems which are connected via a cable.

    ### Parameters

    1. toName [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the peripheral/container to push to. This is the string given to [`peripheral.wrap`](../module/peripheral.html#v:wrap),
       and displayed by the wired modem.
    2. limit? `number` The maximum amount of fluid to move.
    3. fluidName? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The fluid to move. If not given, an arbitrary fluid will be chosen.

    ### Returns

    1. `number` The amount of moved fluid.

    ### Throws

    * If the peripheral to transfer to doesn't exist or isn't an fluid container.

    ### See also

    * **[`peripheral.getName`](../module/peripheral.html#v:getName)** Allows you to get the name of a [wrapped](../module/peripheral.html#v:wrap) peripheral.

pullFluid(fromName [, limit [, fluidName]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/generic/methods/AbstractFluidMethods.java#L88)
:   Move a fluid from a connected fluid container into this one.

    This allows you to pull fluid in the current fluid container from another container *on the same wired
    network*. Both containers must be attached to wired modems which are connected via a cable.

    ### Parameters

    1. fromName [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the peripheral/container to push to. This is the string given to [`peripheral.wrap`](../module/peripheral.html#v:wrap),
       and displayed by the wired modem.
    2. limit? `number` The maximum amount of fluid to move.
    3. fluidName? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The fluid to move. If not given, an arbitrary fluid will be chosen.

    ### Returns

    1. `number` The amount of moved fluid.

    ### Throws

    * If the peripheral to transfer to doesn't exist or isn't an fluid container.

    ### See also

    * **[`peripheral.getName`](../module/peripheral.html#v:getName)** Allows you to get the name of a [wrapped](../module/peripheral.html#v:wrap) peripheral.

---

## Source File: `generic_peripheral/inventory.md`

# inventory

Methods for interacting with inventories.

### Changes

* **New in version 1.94.0**

|  |  |
| --- | --- |
| [size()](#v:size) | Get the size of this inventory. |
| [list()](#v:list) | List all items in this inventory. |
| [getItemDetail(slot)](#v:getItemDetail) | Get detailed information about an item. |
| [getItemLimit(slot)](#v:getItemLimit) | Get the maximum number of items which can be stored in this slot. |
| [pushItems(toName, fromSlot [, limit [, toSlot]])](#v:pushItems) | Push items from one inventory to another connected one. |
| [pullItems(fromName, fromSlot [, limit [, toSlot]])](#v:pullItems) | Pull items from a connected inventory into this one. |

size()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/generic/methods/AbstractInventoryMethods.java#L43)
:   Get the size of this inventory.

    ### Returns

    1. `number` The number of slots in this inventory.

list()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/generic/methods/AbstractInventoryMethods.java#L70)
:   List all items in this inventory. This returns a table, with an entry for each slot.

    Each item in the inventory is represented by a table containing some basic information, much like
    [`turtle.getItemDetail`](../module/turtle.html#v:getItemDetail)
    includes. More information can be fetched with [`getItemDetail`](inventory.html#v:getItemDetail). The table contains the item `name`, the
    `count` and an a (potentially nil) hash of the item's `nbt.` This NBT data doesn't contain anything useful, but
    allows you to distinguish identical items.

    The returned table is sparse, and so empty slots will be `nil` - it is recommended to loop over using [`pairs`](https://www.lua.org/manual/5.1/manual.html#pdf-pairs)
    rather than [`ipairs`](https://www.lua.org/manual/5.1/manual.html#pdf-ipairs).

    ### Returns

    1. { [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) | nil... } Basic information about all items in this inventory.

    ### Usage

    * Find an adjacent chest and print all items in it.

      ```
      local chest = peripheral.find("minecraft:chest")
      for slot, item in pairs(chest.list()) do
        print(("%d x %s in slot %d"):format(item.count, item.name, slot))
      end
      ```

getItemDetail(slot)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/generic/methods/AbstractInventoryMethods.java#L109)
:   Get detailed information about an item.

    The returned information contains the same information as each item in
    [`list`](inventory.html#v:list), as well as additional details like the display name
    (`displayName`), and item and item durability (`damage`, `maxDamage`, `durability`).

    Some items include more information (such as enchantments) - it is
    recommended to print it out using [`textutils.serialize`](../module/textutils.html#v:serialize) or in the Lua
    REPL, to explore what is available.

    ##### ð Deprecated fields

    Older versions of CC: Tweaked exposed an `itemGroups` field, listing the
    creative tabs an item was available under. This information is no longer available on
    more recent versions of the game, and so this field will always be empty. Do not use this
    field in new code!

    ### Parameters

    1. slot `number` The slot to get information about.

    ### Returns

    1. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) | nil Information about the item in this slot, or `nil` if it is empty.

    ### Throws

    * If the slot is out of range.

    ### Usage

    * Print some information about the first in a chest.

      ```
      local chest = peripheral.find("minecraft:chest")
      local item = chest.getItemDetail(1)
      if not item then print("No item") return end

      print(("%s (%s)"):format(item.displayName, item.name))
      print(("Count: %d/%d"):format(item.count, item.maxCount))

      if item.damage then
        print(("Damage: %d/%d"):format(item.damage, item.maxDamage))
      end
      ```

getItemLimit(slot)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/generic/methods/AbstractInventoryMethods.java#L134)
:   Get the maximum number of items which can be stored in this slot.

    Typically this will be limited to 64 items. However, some inventories (such as barrels or caches) can store
    hundreds or thousands of items in one slot.

    ### Parameters

    1. slot `number` The slot

    ### Returns

    1. `number` The maximum number of items in this slot.

    ### Throws

    * If the slot is out of range.

    ### Usage

    * Count the maximum number of items an adjacent chest can hold.

      ```
      local chest = peripheral.find("minecraft:chest")
      local total = 0
      for i = 1, chest.size() do
        total = total + chest.getItemLimit(i)
      end
      print(total)
      ```

    ### Changes

    * **New in version 1.96.0**

pushItems(toName, fromSlot [, limit [, toSlot]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/generic/methods/AbstractInventoryMethods.java#L162)
:   Push items from one inventory to another connected one.

    This allows you to push an item in an inventory to another inventory *on the same wired network*. Both
    inventories must attached to wired modems which are connected via a cable.

    ### Parameters

    1. toName [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the peripheral/inventory to push to. This is the string given to [`peripheral.wrap`](../module/peripheral.html#v:wrap),
       and displayed by the wired modem.
    2. fromSlot `number` The slot in the current inventory to move items to.
    3. limit? `number` The maximum number of items to move. Defaults to the current stack limit.
    4. toSlot? `number` The slot in the target inventory to move to. If not given, the item will be inserted into any slot.

    ### Returns

    1. `number` The number of transferred items.

    ### Throws

    * If the peripheral to transfer to doesn't exist or isn't an inventory.
    * If either source or destination slot is out of range.

    ### Usage

    * Wrap two chests, and push an item from one to another.

      ```
      local chest_a = peripheral.wrap("minecraft:chest_0")
      local chest_b = peripheral.wrap("minecraft:chest_1")

      chest_a.pushItems(peripheral.getName(chest_b), 1)
      ```

    ### See also

    * **[`peripheral.getName`](../module/peripheral.html#v:getName)** Allows you to get the name of a [wrapped](../module/peripheral.html#v:wrap) peripheral.

pullItems(fromName, fromSlot [, limit [, toSlot]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/peripheral/generic/methods/AbstractInventoryMethods.java#L192)
:   Pull items from a connected inventory into this one.

    This allows you to transfer items between inventories *on the same wired network*. Both this and the source
    inventory must attached to wired modems which are connected via a cable.

    ### Parameters

    1. fromName [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the peripheral/inventory to pull from. This is the string given to [`peripheral.wrap`](../module/peripheral.html#v:wrap),
       and displayed by the wired modem.
    2. fromSlot `number` The slot in the source inventory to move items from.
    3. limit? `number` The maximum number of items to move. Defaults to the current stack limit.
    4. toSlot? `number` The slot in current inventory to move to. If not given, the item will be inserted into any slot.

    ### Returns

    1. `number` The number of transferred items.

    ### Throws

    * If the peripheral to transfer to doesn't exist or isn't an inventory.
    * If either source or destination slot is out of range.

    ### Usage

    * Wrap two chests, and push an item from one to another.

      ```
      local chest_a = peripheral.wrap("minecraft:chest_0")
      local chest_b = peripheral.wrap("minecraft:chest_1")

      chest_a.pullItems(peripheral.getName(chest_b), 1)
      ```

    ### See also

    * **[`peripheral.getName`](../module/peripheral.html#v:getName)** Allows you to get the name of a [wrapped](../module/peripheral.html#v:wrap) peripheral.