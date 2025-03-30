# REFERENCE Documentation

## Source File: `reference/breaking_changes.md`

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

---

## Source File: `reference/computercraft_command.md`

# The /computercraft command

CC: Tweaked provides a `/computercraft` command for server owners to manage running computers on a server.

## Permissions

As the `/computercraft` command is mostly intended for debugging and administrative purposes, its sub-commands typically
require you to have op (or similar).

* All players have access to the [`queue`](#queue "/computercraft queue") sub-command.
* On a multi-player server, all other commands require op.
* On a single-player world, the player can run the [`dump`](#dump "/computercraft dump"), [`turn-on`](#turn-on "/computercraft turn-on")/[`shutdown`](#shutdown "/computercraft shutdown"), and [`track`](#track "/computercraft track") sub-commands, even
  when cheats are not enabled. The [`tp`](#tp "/computercraft tp") and [`view`](#view "/computercraft view") commands require cheats.

If a permission mod such as [LuckPerms](https://github.com/LuckPerms/LuckPerms/ "A permissions plugin for Minecraft servers.") is installed[1](#fn-permission), you can configure access to the individual
sub-commands. Each sub-command creates a `computercraft.command.NAME` permission node to control which players can
execute it.

## Computer selectors

Some commands (such as [`tp`](#tp "/computercraft tp") or [`turn-on`](#turn-on "/computercraft turn-on")) target a specific computer, or a list of computers. To specify which
computers to operate on, you must use "computer selectors".

Computer selectors are similar to Minecraft's [entity target selectors](https://minecraft.wiki/w/Target_selectors "Target Selectors on the Minecraft wiki"), but targeting computers instead. They allow
you to select one or more computers, based on a set of predicates.

The following predicates are supported:

* `id=<id>`: Select computer(s) with a specific id.
* `instance=<id>`: Select the computer with the given instance id.
* `family=<normal|advanced|command>`: Select computers based on their type.
* `label=<label>`: Select computers with the given label.
* `distance=<distance>`: Select computers within a specific distance of the player executing the command. This uses
  Minecraft's [float range](https://minecraft.wiki/w/Argument_types#minecraft:float_range) syntax.

`#<id>` may also be used as a shorthand for `@c[id=<id>]`, to select computer(s) with a specific id.

### Examples:

* `/computercraft turn-on #12`: Turn on the computer(s) with an id of 12.
* `/computercraft shutdown @c[distance=..100]`: Shut down all computers with 100 blocks of the player.

## Commands

### `/computercraft dump`

`/computercraft dump` prints a table of currently loaded computers, including their id, position, and whether they're
running. It can also be run with a single computer argument to dump more detailed information about a computer.

![A screenshot of a Minecraft world. In the chat box, there is a table listing 5 computers, with columns labelled "Computer", "On" and "Position". Below that, is a more detailed list of information about Computer 0, including its label ("My computer") and that it has a monitor on the right hand side](../computercraft-dump-e4816091.png "An example of
running '/computercraft dump'")

Next to the computer id, there are several buttons to either [teleport](#tp "/computercraft tp") to the computer, or [open its terminal](#view "/computercraft view").

Computers are sorted by distance to the player, so nearby computers will appear earlier.

### `/computercraft turn-on [computers...]`

Turn on one or more computers or, if no run with no arguments, all loaded computers.

#### Examples

* `/computercraft turn-on #0 #2`: Turn on computers with id 0 and 2.
* `/computercraft turn-on @c[family=command]`: Turn on all command computers.

### `/computercraft shutdown [computers...]`

Shutdown one or more computers or, if no run with no arguments, all loaded computers.

This is sometimes useful when dealing with lag, as a way to ensure that ComputerCraft is not causing problems.

#### Examples

* `/computercraft shutdown`: Shut down all loaded computers.
* `/computercraft shutdown @c[distance=..10]`: Shut down all computers in a block radius.

### `/computercraft tp [computer]`

Teleport to the given computer.

This is normally used from via the [`dump`](#dump "/computercraft dump") command interface rather than being invoked directly.

### `/computercraft view [computer]`

Open a terminal for the specified computer. This allows remotely viewing computers without having to interact with the
block.

This is normally used from via the [`dump`](#dump "/computercraft dump") command interface rather than being invoked directly.

### `/computercraft track`

The `/computercraft track` command allows you to enable profiling of computers. When a computer runs code, or interacts
with the Minecraft world, we time how long that takes. This timing information may then be queried, and used to find
computers which may be causing lag.

To enable the profiler, run `/computercraft track start`. Computers will then start recording metrics. Once enough data
has been gathered, run `/computercraft track stop` to stop profiling and display the recorded data.

![](../computercraft-track-68451592.png)

The table by default shows the number of times each computer has run, and how long it ran for (in total, and on
average). In the above screenshot, we can see one computer was particularly badly behaved, and ran for 7 seconds. The
buttons may be used to [teleport](#tp "/computercraft tp") to the computer, or [open its terminal](#view "/computercraft view") , and inspect it further.

`/computercraft track dump` can be used to display this table at any point (including while profiling is still running).

Computers also record other information, such as how much server-thread time they consume, or their HTTP bandwidth
usage. The `dump` subcommand accepts a list of other fields to display, instead of the default timings.

#### Examples

* `/computercraft track dump server_tasks_count server_tasks`: Print the number of server-thread tasks each computer
  executed, and how long they took in total.
* `/computercraft track dump http_upload http_download`: Print the number of bytes uploaded and downloaded by each
  computer.

### `/computercraft queue`

The queue subcommand allows non-operator players to queue a `computer_command` event on *command* computers.

This has a similar purpose to vanilla's [`/trigger`](https://minecraft.wiki/w/Commands/trigger "/trigger on the Minecraft wiki") command. Command computers may choose to listen to this event, and
then perform some action.

1. This supports any mod which uses Forge's permission API or [fabric-permission-api](https://github.com/lucko/fabric-permissions-api "A simple permissions API for Fabric"). [â©ï¸ï¸](#ref-1-fn-permission)

---

## Source File: `reference/feature_compat.md`

# Lua 5.2/5.3 features in CC: Tweaked

CC: Tweaked is based off of the Cobalt Lua runtime, which uses Lua 5.2. However, Cobalt and CC:T implement additional
features from Lua 5.2 and 5.3 (as well as some deprecated 5.0 and 5.1 features). This page lists all of the
compatibility for these newer versions.

## Lua 5.2

| Feature | Supported? | Notes |
| --- | --- | --- |
| `goto`/labels | â |  |
| `_ENV` | â |  |
| `\z` escape | â |  |
| `\xNN` escape | â |  |
| Hex literal fractional/exponent parts | â |  |
| Empty statements | â |  |
| `__len` metamethod | â |  |
| `__ipairs` metamethod | â | Deprecated in Lua 5.3. `ipairs` uses `__len`/`__index` instead. |
| `__pairs` metamethod | â |  |
| `bit32` library | â |  |
| `collectgarbage` isrunning, generational, incremental options | â | `collectgarbage` does not exist in CC:T. |
| New `load` syntax | â |  |
| `loadfile` mode parameter | â | Supports both 5.1 and 5.2+ syntax. |
| Removed `loadstring` | â |  |
| Removed `getfenv`, `setfenv` | ð¶ | Only supports closures with an `_ENV` upvalue. |
| `rawlen` function | â |  |
| Negative index to `select` | â |  |
| Removed `unpack` | â |  |
| Arguments to `xpcall` | â |  |
| Second return value from `coroutine.running` | â |  |
| Removed `module` | â |  |
| `package.loaders` -> `package.searchers` | â |  |
| Second argument to loader functions | â |  |
| `package.config` | â |  |
| `package.searchpath` | â |  |
| Removed `package.seeall` | â |  |
| `string.dump` on functions with upvalues (blanks them out) | â | `string.dump` is not supported |
| `string.rep` separator | â |  |
| `%g` match group | â |  |
| Removal of `%z` match group | â |  |
| Removed `table.maxn` | â |  |
| `table.pack`/`table.unpack` | â |  |
| `math.log` base argument | â |  |
| Removed `math.log10` | â |  |
| `*L` mode to `file:read` | â |  |
| `os.execute` exit type + return value | â | `os.execute` does not exist in CC:T. |
| `os.exit` close argument | â | `os.exit` does not exist in CC:T. |
| `istailcall` field in `debug.getinfo` | â |  |
| `nparams` field in `debug.getinfo` | â |  |
| `isvararg` field in `debug.getinfo` | â |  |
| `debug.getlocal` negative indices for varargs | â |  |
| `debug.getuservalue`/`debug.setuservalue` | â | Userdata are rarely used in CC:T, so this is not necessary. |
| `debug.upvalueid` | â |  |
| `debug.upvaluejoin` | â |  |
| Tail call hooks | â |  |
| `=` prefix for chunks | â |  |
| Yield across C boundary | â |  |
| Removal of ambiguity error | â |  |
| Identifiers may no longer use locale-dependent letters | â |  |
| Ephemeron tables | â |  |
| Identical functions may be reused | â | Removed in Lua 5.4 |
| Generational garbage collector | â | Cobalt uses the built-in Java garbage collector. |

## Lua 5.3

| Feature | Supported? | Notes |
| --- | --- | --- |
| Integer subtype | â |  |
| Bitwise operators/floor division | â |  |
| `\u{XXX}` escape sequence | â |  |
| `utf8` library | â |  |
| removed `__ipairs` metamethod | â |  |
| `coroutine.isyieldable` | â |  |
| `string.dump` strip argument | â |  |
| `string.pack`/`string.unpack`/`string.packsize` | â |  |
| `table.move` | â |  |
| `math.atan2` -> `math.atan` | ð¶ | `math.atan` supports its two argument form. |
| Removed `math.frexp`, `math.ldexp`, `math.pow`, `math.cosh`, `math.sinh`, `math.tanh` | â |  |
| `math.maxinteger`/`math.mininteger` | â |  |
| `math.tointeger` | â |  |
| `math.type` | â |  |
| `math.ult` | â |  |
| Removed `bit32` library | â |  |
| Remove `*` from `file:read` modes | â |  |
| Metamethods respected in `table.*`, `ipairs` | â |  |

## Lua 5.0

| Feature | Supported? | Notes |
| --- | --- | --- |
| `arg` table | ð¶ | Only set in the shell - not used in functions. |
| `string.gfind` | â | Equal to `string.gmatch`. |
| `table.getn` | â | Equal to `#tbl`. |
| `table.setn` | â |  |
| `math.mod` | â | Equal to `math.fmod`. |
| `table.foreach`/`table.foreachi` | â |  |
| `gcinfo` | â | Cobalt uses the built-in Java garbage collector. |