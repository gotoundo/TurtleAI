# vector

A basic 3D vector type and some common vector operations. This may be useful
when working with coordinates in Minecraft's world (such as those from the
[`gps`](gps.html) API).

An introduction to vectors can be found on [Wikipedia](http://en.wikipedia.org/wiki/Euclidean_vector).

### Changes

* **New in version 1.31**

|  |  |
| --- | --- |
| [new(x, y, z)](#v:new) | Construct a new [`Vector`](vector.html#ty:Vector) with the given coordinates. |

new(x, y, z)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L223)
:   Construct a new [`Vector`](vector.html#ty:Vector) with the given coordinates.

    ### Parameters

    1. x `number` The X coordinate or direction of the vector.
    2. y `number` The Y coordinate or direction of the vector.
    3. z `number` The Z coordinate or direction of the vector.

    ### Returns

    1. [`Vector`](vector.html#ty:Vector) The constructed vector.

### Types

### Vector

A 3-dimensional vector, with `x`, `y`, and `z` values.

This is suitable for representing both position and directional vectors.

Vector:add(o)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L34)
:   Adds two vectors together.

    ### Parameters

    1. o [`Vector`](vector.html#ty:Vector) The second vector to add.

    ### Returns

    1. [`Vector`](vector.html#ty:Vector) The resulting vector

    ### Usage

    * ```
      v1:add(v2)
      ```
    * ```
      v1 + v2
      ```

Vector:sub(o)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L52)
:   Subtracts one vector from another.

    ### Parameters

    1. o [`Vector`](vector.html#ty:Vector) The vector to subtract.

    ### Returns

    1. [`Vector`](vector.html#ty:Vector) The resulting vector

    ### Usage

    * ```
      v1:sub(v2)
      ```
    * ```
      v1 - v2
      ```

Vector:mul(factor)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L70)
:   Multiplies a vector by a scalar value.

    ### Parameters

    1. factor `number` The scalar value to multiply with.

    ### Returns

    1. [`Vector`](vector.html#ty:Vector) A vector with value `(x * m, y * m, z * m)`.

    ### Usage

    * ```
      vector.new(1, 2, 3):mul(3)
      ```
    * ```
      vector.new(1, 2, 3) * 3
      ```

Vector:div(factor)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L88)
:   Divides a vector by a scalar value.

    ### Parameters

    1. factor `number` The scalar value to divide by.

    ### Returns

    1. [`Vector`](vector.html#ty:Vector) A vector with value `(x / m, y / m, z / m)`.

    ### Usage

    * ```
      vector.new(1, 2, 3):div(3)
      ```
    * ```
      vector.new(1, 2, 3) / 3
      ```

Vector:unm()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L104)
:   Negate a vector

    ### Returns

    1. [`Vector`](vector.html#ty:Vector) The negated vector.

    ### Usage

    * ```
      -vector.new(1, 2, 3)
      ```

Vector:dot(o)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L119)
:   Compute the dot product of two vectors

    ### Parameters

    1. o [`Vector`](vector.html#ty:Vector) The second vector to compute the dot product of.

    ### Returns

    1. `number` The dot product of `self` and `o`.

    ### Usage

    * ```
      v1:dot(v2)
      ```

Vector:cross(o)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L132)
:   Compute the cross product of two vectors

    ### Parameters

    1. o [`Vector`](vector.html#ty:Vector) The second vector to compute the cross product of.

    ### Returns

    1. [`Vector`](vector.html#ty:Vector) The cross product of `self` and `o`.

    ### Usage

    * ```
      v1:cross(v2)
      ```

Vector:length()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L146)
:   Get the length (also referred to as magnitude) of this vector.

    ### Returns

    1. `number` The length of this vector.

Vector:normalize()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L157)
:   Divide this vector by its length, producing with the same direction, but
    of length 1.

    ### Returns

    1. [`Vector`](vector.html#ty:Vector) The normalised vector

    ### Usage

    * ```
      v:normalize()
      ```

Vector:round([tolerance])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L168)
:   Construct a vector with each dimension rounded to the nearest value.

    ### Parameters

    1. tolerance? `number` The tolerance that we should round to,
       defaulting to 1. For instance, a tolerance of 0.5 will round to the
       nearest 0.5.

    ### Returns

    1. [`Vector`](vector.html#ty:Vector) The rounded vector.

Vector:tostring()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L186)
:   Convert this vector into a string, for pretty printing.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) This vector's string representation.

    ### Usage

    * ```
      v:tostring()
      ```
    * ```
      tostring(v)
      ```

Vector:equals(other)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/vector.lua#L197)
:   Check for equality between two vectors.

    ### Parameters

    1. other [`Vector`](vector.html#ty:Vector) The second vector to compare to.

    ### Returns

    1. `boolean` Whether or not the vectors are equal.