# TurtleAI
Welcome to my AI integration project for Minecraft! 

I only started playing the [Computer Craft: Tweaked](https://tweaked.cc/) mod a couple weeks ago -- it lets you run Lua code in Minecraft on little computers and entities called Turtles -- I've definitely been hyperfocusing on it a little bit. I'm actually playing in survival mode so I haven't even unlocked most of the mod yet, including GPS lmao. Our server is using [AllTheMods9](https://www.curseforge.com/minecraft/modpacks/all-the-mods-9).

![screenshot](readme-screenshot.webp)

Anyway, this project is all about piping LLM APIs into Minecraft so you can use AI to answer questions about documentation, translate natural language into turtle mining code, power fully independent NPCs and computer systems... Right now I've got working integrations for Gemini and Ollama chatbots. I'm just gonna poop this code into the public sphere before I get distracted. Having other people complain about my code will motivate me to make it better. Sorry in advance.

## Getting Started
Run this script on your in-game Computer to download the Gemini chatbot with documentation, and the client for controlling turtles:
```
wget run https://raw.githubusercontent.com/gotoundo/TurtleAI/refs/heads/main/download_turtle_ai_client.lua
```
Then download and run this turtle server setup script on a turtle you want to control:
```
wget run https://raw.githubusercontent.com/gotoundo/TurtleAI/refs/heads/main/download_turtle_ai_server.lua
```
You'll want to get a free Gemini key from [Google AI Studio](https://ai.google.dev/gemini-api/docs/api-key).

I've also included an [Ollama chatbot script](https://github.com/gotoundo/TurtleAI/blob/main/ollama_chat.lua) in the project that will let you use your local LLM server as a backend. It defaults to [qwen](https://ollama.com/library/qwen2.5) but you can edit the script to use whatever local model you'd like. It doesn't have access to the documentation yet -- I'm focused on Gemini because it's fast, currently free, and really quite smart.

I think the [gemini_turtle.lua](https://github.com/gotoundo/TurtleAI/blob/main/gemini_turtle.lua) script is the most interesting right now as it lets you talk to the turtle in natural language and it will execute custom Lua code to drive itself around and do stuff. My main focus now is cleaning up the prompt engineering so it can understand ComputerCraft code better. I've included a [simple_mining.lua](https://github.com/gotoundo/TurtleAI/blob/main/simple_mining.lua) script that the turtle can call with different dimensions - a demonstration of agentic tool calling. It would be great to get some help from some more experienced computercrafters to make that mining script more efficient.

I strongly recommend you use a secure pocket computer for this as the API key(s) are saved in plaintext in the computer's settings. Don't use this code on a public server or someone can probably steal your API key (this is bad).

## Let's make Skynet in Minecraft lmao
Anyways, I'd love to collaborate with you on this project. Please use the [discussion tab](https://github.com/gotoundo/TurtleAI/discussions), make pull requests, etc. Even if you don't know how to code I'd love to know what types of scripts you're using so I can check them out as a reference. Again, I only started in ComputerCraft a couple weeks ago and this mod apparently has like a decade of history. If you're a more advanced coder and down to clown, let's start dividing up work ;)
