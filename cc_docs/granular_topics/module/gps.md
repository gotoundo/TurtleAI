# gps

Use [modems](../peripheral/modem.html) to locate the position of the current turtle or
computers.

It broadcasts a PING message over [`rednet`](rednet.html) and wait for responses. In order for
this system to work, there must be at least 4 computers used as gps hosts which
will respond and allow trilateration. Three of these hosts should be in a plane,
and the fourth should be either above or below the other three. The three in a
plane should not be in a line with each other. You can set up hosts using the
gps program.

##### ð note

When entering in the coordinates for the host you need to put in the `x`, `y`,
and `z` coordinates of the block that the modem is connected to, not the modem.
All modem distances are measured from the block that the modem is placed on.

Also note that you may choose which axes x, y, or z refers to - so long as your
systems have the same definition as any GPS servers that're in range, it works
just the same. For example, you might build a GPS cluster according to [this
tutorial](https://ccf.squiddev.cc/forums2/index.php?/topic/3088-how-to-guide-gps-global-position-system/), using z to account for height, or you might use y to account for
height in the way that Minecraft's debug screen displays.

### See also

* **[`Setting up GPS`](../guide/gps_setup.html)** For more detailed instructions on setting up GPS

### Changes

* **New in version 1.31**

|  |  |
| --- | --- |
| [CHANNEL\_GPS = 65534](#v:CHANNEL_GPS) | The channel which GPS requests and responses are broadcast on. |
| [locate([timeout=2 [, debug=false]])](#v:locate) | Tries to retrieve the computer or turtles own location. |

CHANNEL\_GPS = 65534[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/gps.lua#L36)
:   The channel which GPS requests and responses are broadcast on.

locate([timeout=2 [, debug=false]])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/gps.lua#L101)
:   Tries to retrieve the computer or turtles own location.

    ### Parameters

    1. timeout? `number` = `2` The maximum time in seconds taken to establish our
       position.
    2. debug? `boolean` = `false` Print debugging messages

    ### Returns

    1. `number` This computer's `x` position.
    2. `number` This computer's `y` position.
    3. `number` This computer's `z` position.

    #### Or

    1. nil If the position could not be established.