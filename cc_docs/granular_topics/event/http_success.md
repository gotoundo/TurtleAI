# http\_success

The [`http_success`](http_success.html) event is fired when an HTTP request returns successfully.

This event is normally handled inside [`http.get`](../module/http.html#v:get) and [`http.post`](../module/http.html#v:post), but it can still be seen when using [`http.request`](../module/http.html#v:request).

## Return Values

1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The event name.
2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4): The URL of the site requested.
3. [`http.Response`](../module/http.html#ty:Response): The successful HTTP response.

## Example

Prints the content of a website (this may fail if the request fails):

```
local myURL = "https://tweaked.cc/"
http.request(myURL)
local event, url, handle
repeat
    event, url, handle = os.pullEvent("http_success")
until url == myURL
print("Contents of " .. url .. ":")
print(handle.readAll())
handle.close()
```

### See also

* **[`http.request`](../module/http.html#v:request)** To make an HTTP request.