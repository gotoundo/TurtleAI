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