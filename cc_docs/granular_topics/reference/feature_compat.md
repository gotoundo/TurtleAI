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