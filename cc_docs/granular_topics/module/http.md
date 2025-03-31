# http

Make HTTP requests, sending and receiving data to a remote web server.

### See also

* **[`Allowing access to local IPs`](../guide/local_ips.html)** To allow accessing servers running on your local network.

### Changes

* **New in version 1.1**

|  |  |
| --- | --- |
| [get(...)](#v:get) | Make a HTTP GET request to the given url. |
| [post(...)](#v:post) | Make a HTTP POST request to the given url. |
| [request(...)](#v:request) | Asynchronously make a HTTP request to the given url. |
| [checkURLAsync(url)](#v:checkURLAsync) | Asynchronously determine whether a URL can be requested. |
| [checkURL(url)](#v:checkURL) | Determine whether a URL can be requested. |
| [websocketAsync(...)](#v:websocketAsync) | Asynchronously open a websocket. |
| [websocket(...)](#v:websocket) | Open a websocket. |

get(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/http/http.lua#L104)
:   Make a HTTP GET request to the given url.

    ### Parameters

    1. url [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The url to request
    2. headers? { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) } Additional headers to send as part
       of this request.
    3. binary? `boolean` = `false` Whether the [response handle](fs.html#ty:ReadHandle)
       should be opened in binary mode.

    #### Or

    1. request { url = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), headers? = { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) }, binary? = `boolean`, method? = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), redirect? = `boolean`, timeout? = `number` } Options for the request. See [`http.request`](http.html#v:request) for details on how
       these options behave.

    ### Returns

    1. [`Response`](http.html#ty:Response) The resulting http response, which can be read from.

    #### Or

    1. nil When the http request failed, such as in the event of a 404
       error or connection timeout.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) A message detailing why the request failed.
    3. [`Response`](http.html#ty:Response) | nil The failing http response, if available.

    ### Usage

    * Make a request to [example.tweaked.cc](https://example.tweaked.cc),
      and print the returned page.

      ```
      local request = http.get("https://example.tweaked.cc")
      print(request.readAll())
      -- => HTTP is working!
      request.close()
      ```

    ### Changes

    * **Changed in version 1.63:** Added argument for headers.
    * **Changed in version 1.80pr1:** Response handles are now returned on error if available.
    * **Changed in version 1.80pr1:** Added argument for binary handles.
    * **Changed in version 1.80pr1.6:** Added support for table argument.
    * **Changed in version 1.86.0:** Added PATCH and TRACE methods.
    * **Changed in version 1.105.0:** Added support for custom timeouts.
    * **Changed in version 1.109.0:** The returned response now reads the body as raw bytes, rather
      than decoding from UTF-8.

post(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/http/http.lua#L148)
:   Make a HTTP POST request to the given url.

    ### Parameters

    1. url [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The url to request
    2. body [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The body of the POST request.
    3. headers? { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) } Additional headers to send as part
       of this request.
    4. binary? `boolean` = `false` Whether the [response handle](fs.html#ty:ReadHandle)
       should be opened in binary mode.

    #### Or

    1. request { url = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), body? = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), headers? = { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) }, binary? = `boolean`, method? = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), redirect? = `boolean`, timeout? = `number` } Options for the request. See [`http.request`](http.html#v:request) for details on how
       these options behave.

    ### Returns

    1. [`Response`](http.html#ty:Response) The resulting http response, which can be read from.

    #### Or

    1. nil When the http request failed, such as in the event of a 404
       error or connection timeout.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) A message detailing why the request failed.
    3. [`Response`](http.html#ty:Response) | nil The failing http response, if available.

    ### Changes

    * **New in version 1.31**
    * **Changed in version 1.63:** Added argument for headers.
    * **Changed in version 1.80pr1:** Response handles are now returned on error if available.
    * **Changed in version 1.80pr1:** Added argument for binary handles.
    * **Changed in version 1.80pr1.6:** Added support for table argument.
    * **Changed in version 1.86.0:** Added PATCH and TRACE methods.
    * **Changed in version 1.105.0:** Added support for custom timeouts.
    * **Changed in version 1.109.0:** The returned response now reads the body as raw bytes, rather
      than decoding from UTF-8.

request(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/http/http.lua#L201)
:   Asynchronously make a HTTP request to the given url.

    This returns immediately, a [`http_success`](../event/http_success.html) or [`http_failure`](../event/http_failure.html) will be queued
    once the request has completed.

    ### Parameters

    1. url [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The url to request
    2. body? [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) An optional string containing the body of the
       request. If specified, a `POST` request will be made instead.
    3. headers? { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) } Additional headers to send as part
       of this request.
    4. binary? `boolean` = `false` Whether the [response handle](fs.html#ty:ReadHandle)
       should be opened in binary mode.

    #### Or

    1. request { url = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), body? = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), headers? = { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) }, binary? = `boolean`, method? = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), redirect? = `boolean`, timeout? = `number` }

       Options for the request.

       This table form is an expanded version of the previous syntax. All arguments
       from above are passed in as fields instead (for instance,
       `http.request("https://example.com")` becomes `http.request { url = "https://example.com" }`).
       This table also accepts several additional options:

       * `method`: Which HTTP method to use, for instance `"PATCH"` or `"DELETE"`.
       * `redirect`: Whether to follow HTTP redirects. Defaults to true.
       * `timeout`: The connection timeout, in seconds.

    ### See also

    * **[`http.get`](http.html#v:get)** For a synchronous way to make GET requests.
    * **[`http.post`](http.html#v:post)** For a synchronous way to make POST requests.

    ### Changes

    * **Changed in version 1.63:** Added argument for headers.
    * **Changed in version 1.80pr1:** Added argument for binary handles.
    * **Changed in version 1.80pr1.6:** Added support for table argument.
    * **Changed in version 1.86.0:** Added PATCH and TRACE methods.
    * **Changed in version 1.105.0:** Added support for custom timeouts.
    * **Changed in version 1.109.0:** The returned response now reads the body as raw bytes, rather
      than decoding from UTF-8.

checkURLAsync(url)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/http/http.lua#L223)
:   Asynchronously determine whether a URL can be requested.

    If this returns `true`, one should also listen for [`http_check`](../event/http_check.html) which will
    container further information about whether the URL is allowed or not.

    ### Parameters

    1. url [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The URL to check.

    ### Returns

    1. true When this url is not invalid. This does not imply that it is
       allowed - see the comment above.

    #### Or

    1. false When this url is invalid.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) A reason why this URL is not valid (for instance, if it is
       malformed, or blocked).

    ### See also

    * **[`http.checkURL`](http.html#v:checkURL)** For a synchronous version.

checkURL(url)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/http/http.lua#L264)
:   Determine whether a URL can be requested.

    If this returns `true`, one should also listen for [`http_check`](../event/http_check.html) which will
    container further information about whether the URL is allowed or not.

    ### Parameters

    1. url [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The URL to check.

    ### Returns

    1. true When this url is valid and can be requested via [`http.request`](http.html#v:request).

    #### Or

    1. false When this url is invalid.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) A reason why this URL is not valid (for instance, if it is
       malformed, or blocked).

    ### Usage

    * ```
      print(http.checkURL("https://example.tweaked.cc/"))
      -- => true
      print(http.checkURL("http://localhost/"))
      -- => false Domain not permitted
      print(http.checkURL("not a url"))
      -- => false URL malformed
      ```

    ### See also

    * **[`http.checkURLAsync`](http.html#v:checkURLAsync)** For an asynchronous version.

websocketAsync(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/http/http.lua#L307)
:   Asynchronously open a websocket.

    This returns immediately, a [`websocket_success`](../event/websocket_success.html) or [`websocket_failure`](../event/websocket_failure.html)
    will be queued once the request has completed.

    ### Parameters

    1. url [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The websocket url to connect to. This should have the
       `ws://` or `wss://` protocol.
    2. headers? { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) } Additional headers to send as part
       of the initial websocket connection.

    #### Or

    1. request { url = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), headers? = { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) }, timeout? = `number` } Options for the websocket. See [`http.websocket`](http.html#v:websocket) for details on how
       these options behave.

    ### See also

    * **[`websocket_success`](../event/websocket_success.html)**
    * **[`websocket_failure`](../event/websocket_failure.html)**

    ### Changes

    * **New in version 1.80pr1.3**
    * **Changed in version 1.95.3:** Added User-Agent to default headers.
    * **Changed in version 1.105.0:** Added support for table argument and custom timeout.
    * **Changed in version 1.109.0:** Non-binary websocket messages now use the raw bytes rather than
      using UTF-8.

websocket(...)[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/resources/data/computercraft/lua/rom/apis/http/http.lua#L365)
:   Open a websocket.

    ### Parameters

    1. url [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The websocket url to connect to. This should have the
       `ws://` or `wss://` protocol.
    2. headers? { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) } Additional headers to send as part
       of the initial websocket connection.

    #### Or

    1. request { url = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4), headers? = { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) }, timeout? = `number` }

       Options for the websocket.

       This table form is an expanded version of the previous syntax. All arguments
       from above are passed in as fields instead (for instance,
       `http.websocket("https://example.com")` becomes `http.websocket { url = "https://example.com" }`).
       This table also accepts the following additional options:

       * `timeout`: The connection timeout, in seconds.

    ### Returns

    1. [`Websocket`](http.html#ty:Websocket) The websocket connection.

    #### Or

    1. false If the websocket connection failed.
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) An error message describing why the connection failed.

    ### Usage

    * Connect to an echo websocket and send a message.

      ```
      local ws = assert(http.websocket("wss://example.tweaked.cc/echo"))
      ws.send("Hello!") -- Send a message
      print(ws.receive()) -- And receive the reply
      ws.close()
      ```

    ### Changes

    * **New in version 1.80pr1.1**
    * **Changed in version 1.80pr1.3:** No longer asynchronous.
    * **Changed in version 1.95.3:** Added User-Agent to default headers.
    * **Changed in version 1.105.0:** Added support for table argument and custom timeout.
    * **Changed in version 1.109.0:** Non-binary websocket messages now use the raw bytes rather than
      using UTF-8.

### Types

### Response

A http response. This provides the same methods as a [file](fs.html#ty:ReadHandle), though provides several request
specific methods.

### See also

* **[`http.request`](http.html#v:request)** On how to make a http request.

Response.getResponseCode()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/http/request/HttpResponseHandle.java#L45)
:   Returns the response code and response message returned by the server.

    ### Returns

    1. `number` The response code (i.e. 200)
    2. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The response message (i.e. "OK")

    ### Changes

    * **Changed in version 1.80pr1.13:** Added response message return value.

Response.getResponseHeaders()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/http/request/HttpResponseHandle.java#L68)
:   Get a table containing the response's headers, in a format similar to that required by [`http.request`](http.html#v:request).
    If multiple headers are sent with the same name, they will be combined with a comma.

    ### Returns

    1. { [[`string`](https://www.lua.org/manual/5.1/manual.html#5.4)] = [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) } The response's headers.

    ### Usage

    * Make a request to [example.tweaked.cc](https://example.tweaked.cc), and print the
      returned headers.

      ```
      local request = http.get("https://example.tweaked.cc")
      print(textutils.serialize(request.getResponseHeaders()))
      -- => {
      --  [ "Content-Type" ] = "text/plain; charset=utf8",
      --  [ "content-length" ] = 17,
      --  ...
      -- }
      request.close()
      ```

### Websocket

A websocket, which can be used to send and receive messages with a web server.

### See also

* **[`http.websocket`](http.html#v:websocket)** On how to open a websocket.

Websocket.receive([timeout])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/http/websocket/WebsocketHandle.java#L59)
:   Wait for a message from the server.

    ### Parameters

    1. timeout? `number` The number of seconds to wait if no message is received.

    ### Returns

    1. [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The received message.
    2. `boolean` If this was a binary message.

    #### Or

    1. nil If the websocket was closed while waiting, or if we timed out.

    ### Throws

    * If the websocket has been closed.

    ### Changes

    * **Changed in version 1.80pr1.13:** Added return value indicating whether the message was binary.
    * **Changed in version 1.87.0:** Added timeout argument.

Websocket.send(message [, binary])[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/http/websocket/WebsocketHandle.java#L78)
:   Send a websocket message to the connected server.

    ### Parameters

    1. message [`string`](https://www.lua.org/manual/5.1/manual.html#5.4) The message to send.
    2. binary? `boolean` Whether this message should be treated as a binary message.

    ### Throws

    * If the message is too large.
    * If the websocket has been closed.

    ### Changes

    * **Changed in version 1.81.0:** Added argument for binary mode.

Websocket.close()[Source](https://github.com/cc-tweaked/CC-Tweaked/blob/9c0ce27ce6ac568ecdff2a369cf517cb9431279f/projects/core/src/main/java/dan200/computercraft/core/apis/http/websocket/WebsocketHandle.java#L103)
:   Close this websocket. This will terminate the connection, meaning messages can no longer be sent or received
    along it.