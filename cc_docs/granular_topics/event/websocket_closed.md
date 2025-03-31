# websocket\_closed

The [`websocket_closed`](websocket_closed.html) event is fired when an open WebSocket connection is closed.

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The URL of the WebSocket that was closed.
3. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4)|`nil`: The [server-provided reason](https://www.rfc-editor.org/rfc/rfc6455.html#section-7.1.6 "The WebSocket Connection Close Reason, RFC 6455")
   the websocket was closed. This will be `nil` if the connection was closed
   abnormally.
4. `number`|`nil`: The [connection close code](https://www.rfc-editor.org/rfc/rfc6455.html#section-7.1.5 "The WebSocket Connection Close Code, RFC 6455"),
   indicating why the socket was closed. This will be `nil` if the connection
   was closed abnormally.

## Example

Prints a message when a WebSocket is closed (this may take a minute):

```
local myURL = "wss://example.tweaked.cc/echo"
local ws = http.websocket(myURL)
local event, url
repeat
    event, url = os.pullEvent("websocket_closed")
until url == myURL
print("The WebSocket at " .. url .. " was closed.")
```