# settings

Read and write configuration options for CraftOS and your programs.

When a computer starts, it reads the current value of settings from the
`/.settings` file. These values then may be [read](settings.html#v:get) or
[modified](settings.html#v:set).

##### â  warning

Calling [`settings.set`](settings.html#v:set) does *not* update the settings file by default. You
*must* call [`settings.save`](settings.html#v:save) to persist values.

### Usage

* Define an basic setting `123` and read its value.

  ```
  settings.define("my.setting", {
      description = "An example setting",
      default = 123,
      type = "number",
  })
  print("my.setting = " .. settings.get("my.setting")) -- 123
  ```

  You can then use the `set` program to change its value (e.g. `set my.setting 456`),
  and then re-run the `example` program to check it has changed.

### Changes

* **New in version 1.78**

|  |  |
| --- | --- |
| [define(name [, options])](#v:define) | Define a new setting, optional specifying various properties about it. |
| [undefine(name)](#v:undefine) | Remove a [definition](settings.html#v:define) of a setting. |
| [set(name, value)](#v:set) | Set the value of a setting. |
| [get(name [, default])](#v:get) | Get the value of a setting. |
| [getDetails(name)](#v:getDetails) | Get details about a specific setting. |
| [unset(name)](#v:unset) | Remove the value of a setting, setting it to the default. |
| [clear()](#v:clear) | Resets the value of all settings. |
| [getNames()](#v:getNames) | Get the names of all currently defined settings. |
| [load([path=".settings"])](#v:load) | Load settings from the given file. |
| [save([path=".settings"])](#v:save) | Save settings to the given file. |

define(name [, options])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/settings.lua#L66)
:   Define a new setting, optional specifying various properties about it.

    While settings do not have to be added before being used, doing so allows
    you to provide defaults and additional metadata.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of this option
    2. options? { description? = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), default? = `any`, type? = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) }

       Options for this setting. This table accepts the following fields:

       * `description`: A description which may be printed when running the `set` program.
       * `default`: A default value, which is returned by [`settings.get`](settings.html#v:get) if the
         setting has not been changed.
       * `type`: Require values to be of this type. [Setting](settings.html#v:set) the value to another type
         will error. Must be one of: `"number"`, `"string"`, `"boolean"`, or `"table"`.

    ### Changes

    * **New in version 1.87.0**

undefine(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/settings.lua#L94)
:   Remove a [definition](settings.html#v:define) of a setting.

    If a setting has been changed, this does not remove its value. Use [`settings.unset`](settings.html#v:unset)
    for that.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of this option

    ### Changes

    * **New in version 1.87.0**

set(name, value)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/settings.lua#L125)
:   Set the value of a setting.

    ##### â  warning

    Calling [`settings.set`](settings.html#v:set) does *not* update the settings file by default. You
    *must* call [`settings.save`](settings.html#v:save) to persist values.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the setting to set
    2. value The setting's value. This cannot be `nil`, and must be
       serialisable by [`textutils.serialize`](textutils.html#v:serialize).

    ### Throws

    * If this value cannot be serialised

    ### See also

    * **[`settings.unset`](settings.html#v:unset)**

get(name [, default])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/settings.lua#L143)
:   Get the value of a setting.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the setting to get.
    2. default? The value to use should there be pre-existing value for
       this setting. If not given, it will use the setting's default value if given,
       or `nil` otherwise.

    ### Returns

    1. The setting's, or the default if the setting has not been changed.

    ### Changes

    * **Changed in version 1.87.0:** Now respects default value if pre-defined and `default` is unset.

getDetails(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/settings.lua#L163)
:   Get details about a specific setting.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the setting to get.

    ### Returns

    1. { description? = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), default? = `any`, type? = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), value? = `any` } Information about this setting. This includes all information from [`settings.define`](settings.html#v:define),
       as well as this setting's value.

    ### Changes

    * **New in version 1.87.0**

unset(name)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/settings.lua#L180)
:   Remove the value of a setting, setting it to the default.

    [`settings.get`](settings.html#v:get) will return the default value until the setting's value is
    [set](settings.html#v:set), or the computer is rebooted.

    ### Parameters

    1. name [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The name of the setting to unset.

    ### See also

    * **[`settings.set`](settings.html#v:set)**
    * **[`settings.clear`](settings.html#v:clear)**

clear()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/settings.lua#L189)
:   Resets the value of all settings. Equivalent to calling [`settings.unset`](settings.html#v:unset)
    on every setting.

    ### See also

    * **[`settings.unset`](settings.html#v:unset)**

getNames()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/settings.lua#L199)
:   Get the names of all currently defined settings.

    ### Returns

    1. { [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) } An alphabetically sorted list of all currently-defined
       settings.

load([path=".settings"])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/settings.lua#L223)
:   Load settings from the given file.

    Existing settings will be merged with any pre-existing ones. Conflicting
    entries will be overwritten, but any others will be preserved.

    ### Parameters

    1. path? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) = `".settings"` The file to load from.

    ### Returns

    1. `boolean` Whether settings were successfully read from this
       file. Reasons for failure may include the file not existing or being
       corrupted.

    ### See also

    * **[`settings.save`](settings.html#v:save)**

    ### Changes

    * **Changed in version 1.87.0:** `path` is now optional.

save([path=".settings"])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/settings.lua#L263)
:   Save settings to the given file.

    This will entirely overwrite the pre-existing file. Settings defined in the
    file, but not currently loaded will be removed.

    ### Parameters

    1. path? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) = `".settings"` The path to save settings to.

    ### Returns

    1. `boolean` If the settings were successfully saved.

    ### See also

    * **[`settings.load`](settings.html#v:load)**

    ### Changes

    * **Changed in version 1.87.0:** `path` is now optional.