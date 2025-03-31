# websocket\_failure

The [`websocket_failure`](websocket_failure.html) event is fired when a WebSocket connection request fails.

This event is normally handled inside [`http.websocket`](../module/http.html#v:websocket), but it can still be seen when using [`http.websocketAsync`](../module/http.html#v:websocketAsync).

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The URL of the site requested.
3. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): An error describing the failure.

## Example

Prints an error why the website cannot be contacted:

```
local myURL = "wss://example.tweaked.cc/not-a-websocket"
http.websocketAsync(myURL)
local event, url, err
repeat
    event, url, err = os.pullEvent("websocket_failure")
until url == myURL
print("The URL " .. url .. " could not be reached: " .. err)
```

### See also

* **[`http.websocketAsync`](../module/http.html#v:websocketAsync)** To send an HTTP request.