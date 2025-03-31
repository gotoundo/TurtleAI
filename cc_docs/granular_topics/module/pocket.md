# pocket

Control the current pocket computer, adding or removing upgrades.

This API is only available on pocket computers. As such, you may use its presence to determine what kind of computer
you are using:

```
if pocket then
  print("On a pocket computer")
else
  print("On something else")
end
```

## Recipes

**Pocket Computer**

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Golden Apple](/images/items/minecraft/golden_apple.png "Golden Apple")

![Stone](/images/items/minecraft/stone.png "Stone")

![Stone](/images/items/minecraft/stone.png "Stone")

![Glass Pane](/images/items/minecraft/glass_pane.png "Glass Pane")

![Stone](/images/items/minecraft/stone.png "Stone")

![Pocket Computer](/images/items/computercraft/pocket_computer_normal.png "Pocket Computer")

**Advanced Pocket Computer**

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Golden Apple](/images/items/minecraft/golden_apple.png "Golden Apple")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Glass Pane](/images/items/minecraft/glass_pane.png "Glass Pane")

![Gold Ingot](/images/items/minecraft/gold_ingot.png "Gold Ingot")

![Advanced Pocket Computer](/images/items/computercraft/pocket_computer_advanced.png "Advanced Pocket Computer")

|  |  |
| --- | --- |
| [equipBack()](#v:equipBack) | Search the player's inventory for another upgrade, replacing the existing one with that item if found. |
| [unequipBack()](#v:unequipBack) | Remove the pocket computer's current upgrade. |

equipBack()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/pocket/apis/PocketAPI.java#L63)
:   Search the player's inventory for another upgrade, replacing the existing one with that item if found.

    This inventory search starts from the player's currently selected slot, allowing you to prioritise upgrades.

    ### Returns

    1. `boolean` If an item was equipped.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason an item was not equipped.

unequipBack()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/common/src/main/java/dan200/computercraft/shared/pocket/apis/PocketAPI.java#L94)
:   Remove the pocket computer's current upgrade.

    ### Returns

    1. `boolean` If the upgrade was unequipped.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The reason an upgrade was not unequipped.