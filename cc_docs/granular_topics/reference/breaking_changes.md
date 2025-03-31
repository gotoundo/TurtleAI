# Incompatibilities between versions

CC: Tweaked tries to remain as compatible between versions as possible, meaning most programs written for older version
of the mod should run fine on later versions.

##### â  External peripherals

While CC: Tweaked is relatively stable across versions, this may not be true for other mods which add their own
peripherals. Older programs which interact with external blocks may not work on newer versions of the game.

However, some changes to the underlying game, or CC: Tweaked's own internals may break some programs. This page serves
as documentation for breaking changes and "gotchas" one should look out for between versions.

## CC: Tweaked 1.109.0 to 1.109.3

* Update to Lua 5.2:

  + Support for Lua 5.0's pseudo-argument `arg` has been removed. You should always use `...` for varargs.
  + Environments are no longer baked into the runtime, and instead use the `_ENV` local or upvalue. [`getfenv`](https://www.lua.org/manual/5.1/manual.html#pdf-getfenv)/[`setfenv`](https://www.lua.org/manual/5.1/manual.html#pdf-setfenv)
    now only work on Lua functions with an `_ENV` upvalue. [`getfenv`](https://www.lua.org/manual/5.1/manual.html#pdf-getfenv) will return the global environment when called
    with other functions, and [`setfenv`](https://www.lua.org/manual/5.1/manual.html#pdf-setfenv) will have no effect.
  + [`load`](https://www.lua.org/manual/5.1/manual.html#pdf-load)/[`loadstring`](https://www.lua.org/manual/5.1/manual.html#pdf-loadstring) defaults to using the global environment (`_G`) rather than the current coroutine's
    environment.
  + Support for dumping functions ([`string.dump`](https://www.lua.org/manual/5.1/manual.html#pdf-string.dump)) and loading binary chunks has been removed.
  + [`math.random`](https://www.lua.org/manual/5.1/manual.html#pdf-math.random) now uses Lua 5.4's random number generator.
* File handles, HTTP requests and websockets now always use the original bytes rather than encoding/decoding to UTF-8.

## Minecraft 1.13

* The "key code" for [`key`](../event/key.html) and [`key_up`](../event/key_up.html) events has changed, due to Minecraft updating to LWJGL 3. Make sure you're
  using the constants provided by the [`keys`](../module/keys.html) API, rather than hard-coding numerical values.

  Related to this change, the numpad enter key now has a different key code to the enter key. You may need to adjust
  your programs to handle both. (Note, the `keys.numpadEnter` constant was defined in pre-1.13 versions of CC, but the
  `keys.enter` constant was queued when the key was pressed)
* Minecraft 1.13 removed the concept of item damage and block metadata (see ["The Flattening"](https://minecraft.wiki/w/Java_Edition_1.13/Flattening)). As a
  result [`turtle.inspect`](../module/turtle.html#v:inspect) no longer provides block metadata, and [`turtle.getItemDetail`](../module/turtle.html#v:getItemDetail) no longer provides damage.

  + Block states (`turtle.inspect().state`) should provide all the same information as block metadata, but in a much
    more understandable format.
  + Item and block names now represent a unique item type. For instance, wool is split into 16 separate items
    (`minecraft:white_wool`, etc...) rather than a single `minecraft:wool` with each meta/damage value specifying the
    colour.
* Custom ROMs are now provided using data packs rather than resource packs. This should mostly be a matter of renaming
  the "assets" folder to "data", and placing it in "datapacks", but there are a couple of other gotchas to look out
  for:

  + Data packs [impose some restrictions on file names](https://minecraft.wiki/w/Tutorials/Creating_a_data_pack#Legal_characters). As a result, your programs and directories
    must all be lower case.
  + Due to how data packs are read by CC: Tweaked, you may need to use the `/reload` command to see changes to your
    pack show up on the computer.

  See [the example datapack](https://github.com/cc-tweaked/datapack-example "An example datapack for CC: Tweaked") for how to get started.
* Turtles can now be waterlogged and move "through" water sources rather than breaking them.

## CC: Tweaked 1.88.0

* Unlabelled computers and turtles now keep their ID when broken, meaning that unlabelled computers/items do not stack.

## ComputerCraft 1.80pr1

* Programs run via [`shell.run`](../module/shell.html#v:run) are now started in their own isolated environment. This means globals set by programs
  will not be accessible outside of this program.
* Programs containing `/` are looked up in the current directory and are no longer looked up on the path. For instance,
  you can no longer type `turtle/excavate` to run `/rom/programs/turtle/excavate.lua`.