# help

Find help files on the current computer.

### Changes

* **New in version 1.2**

|  |  |
| --- | --- |
| [path()](#v:path) | Returns a colon-separated list of directories where help files are searched for. |
| [setPath(newPath)](#v:setPath) | Sets the colon-separated list of directories where help files are searched for to `newPath` |
| [lookup(topic)](#v:lookup) | Returns the location of the help file for the given topic. |
| [topics()](#v:topics) | Returns a list of topics that can be looked up and/or displayed. |
| [completeTopic(prefix)](#v:completeTopic) | Returns a list of topic endings that match the prefix. |

path()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/help.lua#L19)
:   Returns a colon-separated list of directories where help files are searched
    for. All directories are absolute.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The current help search path, separated by colons.

    ### See also

    * **[`help.setPath`](help.html#v:setPath)**

setPath(newPath)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/help.lua#L30)
:   Sets the colon-separated list of directories where help files are searched
    for to `newPath`

    ### Parameters

    1. newPath [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The new path to use.

    ### Usage

    * ```
      help.setPath( "/disk/help/" )
      ```
    * ```
      help.setPath( help.path() .. ":/myfolder/help/" )
      ```

    ### See also

    * **[`help.path`](help.html#v:path)**

lookup(topic)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/help.lua#L45)
:   Returns the location of the help file for the given topic.

    ### Parameters

    1. topic [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The topic to find

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) | nil The path to the given topic's help file, or `nil` if it
       cannot be found.

    ### Usage

    * ```
      help.lookup("disk")
      ```

    ### Changes

    * **Changed in version 1.80pr1:** Now supports finding .txt files.
    * **Changed in version 1.97.0:** Now supports finding Markdown files.

topics()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/help.lua#L66)
:   Returns a list of topics that can be looked up and/or displayed.

    ### Returns

    1. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) A list of topics in alphabetical order.

    ### Usage

    * ```
      help.topics()
      ```

completeTopic(prefix)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/help.lua#L107)
:   Returns a list of topic endings that match the prefix. Can be used with
    `read` to allow input of a help topic.

    ### Parameters

    1. prefix [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The prefix to match

    ### Returns

    1. [`table`](https://www.lua.org/manual/5.1/manual.html#5.5) A list of matching topics.

    ### Changes

    * **New in version 1.74**