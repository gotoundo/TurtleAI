# http\_check

The [`http_check`](http_check.html) event is fired when a URL check finishes.

This event is normally handled inside [`http.checkURL`](../module/http.html#v:checkURL), but it can still be seen when using [`http.checkURLAsync`](../module/http.html#v:checkURLAsync).

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The URL requested to be checked.
3. `boolean`: Whether the check succeeded.
4. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)|`nil`: If the check failed, a reason explaining why the check failed.

### See also

* **[`http.checkURLAsync`](../module/http.html#v:checkURLAsync)** To check a URL asynchronously.