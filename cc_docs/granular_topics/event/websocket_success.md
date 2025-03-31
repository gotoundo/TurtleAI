# websocket\_success

The [`websocket_success`](websocket_success.html) event is fired when a WebSocket connection request returns successfully.

This event is normally handled inside [`http.websocket`](../module/http.html#v:websocket), but it can still be seen when using [`http.websocketAsync`](../module/http.html#v:websocketAsync).

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The URL of the site.
3. [`http.Websocket`](../module/http.html#ty:Websocket): The handle for the WebSocket.

## Example

Prints the content of a website (this may fail if the request fails):

```
local myURL = "wss://example.tweaked.cc/echo"
http.websocketAsync(myURL)
local event, url, handle
repeat
    event, url, handle = os.pullEvent("websocket_success")
until url == myURL
print("Connected to " .. url)
handle.send("Hello!")
print(handle.receive())
handle.close()
```

### See also

* **[`http.websocketAsync`](../module/http.html#v:websocketAsync)** To open a WebSocket asynchronously.