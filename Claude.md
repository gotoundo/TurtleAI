# TurtleAI Project

## Overview
TurtleAI is a Minecraft ComputerCraft integration project that brings LLM-powered AI capabilities to programmable turtles and computers. It enables natural language control of turtles, AI-powered documentation chat, companion systems, and AI art generation/display.

**Primary Language:** Lua (ComputerCraft/CC: Tweaked)
**Supporting Languages:** Python (for bridge servers and art generation)
**Minecraft Mod:** CC: Tweaked (ComputerCraft)
**Target Environment:** Minecraft with ComputerCraft mod installed

## Project Philosophy
- **Keep it simple:** Prefer straightforward solutions over complex architectures
- **In-game first:** All code runs on ComputerCraft computers/turtles in Minecraft
- **LLM-powered:** Leverage AI for natural language control and assistance
- **Self-updating:** Programs can update themselves from GitHub
- **Modular design:** Each feature is self-contained and optional

## Core Components

### 1. CC Chat (`gemini_chat.lua`) ⭐ Main Feature
**Purpose:** AI-powered documentation chat with RAG (Retrieval Augmented Generation)

**Key Features:**
- Natural language queries about ComputerCraft APIs
- Conversation history with context
- Local documentation search and retrieval
- Multiple Gemini model support (2.5 Flash, 3.0 Flash Preview)
- Auto-update functionality
- Clean terminal UI

**Technical Details:**
- Uses Gemini API for LLM responses
- Implements RAG pipeline: query → doc selection → context building → answer generation
- JSON parsing with fallback to regex for robustness
- Settings-based API key storage
- Documentation loaded from `/cc_docs/` directory

**Commands:**
- `help` - Show available commands
- `info` - System information (version, model, API key status, docs loaded)
- `model [2.5|3|flash]` - Switch between Gemini models
- `setkey` - Set Gemini API key
- `clear` - Clear conversation history
- `save [filename]` - Save conversation to file
- `listdocs` - List loaded documentation
- `reload` - Reload documentation files
- `update` - Auto-update from GitHub
- `debug` - Toggle debug mode
- `exit` - Exit program

**Version:** 1.7.0
**Model Default:** `models/gemini-2.5-flash`

### 2. Turtle AI Client (`turtle_ai_client.lua`)
**Purpose:** Natural language control of turtles using Gemini API

**Key Features:**
- Direct natural language commands ("move forward 10 blocks")
- Gemini converts commands to Lua code
- Executes generated code on turtle
- Status reporting

**Model:** `models/gemini-3-flash-preview`

### 3. Turtle AI Server (`turtle_ai_server.lua`)
**Purpose:** Server component for turtle control (if using client/server architecture)

### 4. Gemini Turtle (`gemini_turtle.lua`)
**Purpose:** Alternative direct Gemini integration for turtle control

### 5. Companion System (`companion/`)
**Purpose:** GPS-based turtle follower system

**Files:**
- `player_beacon.lua` - Runs on player's pocket computer to broadcast position
- `dog_turtle.lua` - Turtle that follows the player beacon
- `install.lua` - Installer script

**Features:**
- GPS-based position tracking
- Automatic following with configurable distance
- Obstacle avoidance
- Status display on turtle

### 6. AI Art Display (`cc-art-display/`)
**Purpose:** Display AI-generated art on ComputerCraft monitors

**Components:**
- `art_display.lua` - ComputerCraft program to request and display art
- `bridge_server.py` - Python server that interfaces with ComfyUI

**Workflow:**
1. User enters prompt in ComputerCraft
2. HTTP request sent to bridge server
3. Bridge server generates image via ComfyUI
4. Image converted to CC's 16-color palette
5. Displayed on monitors in-game

### 7. AI Console Art (`ai-console-art/`)
**Purpose:** Generate AI art and display as ASCII/ANSI in terminal

**Files:**
- `console_art.py` - Main application
- `comfy_client.py` - ComfyUI API client
- `comfy_server.py` - ComfyUI server manager
- `image_to_ascii.py` - Image to ASCII converter

### 8. Mining Programs
- `tunnel.lua` - Advanced tunnel boring with settings
- `simple_tunnel.lua` - Basic tunnel program
- `simple_mining.lua` - Basic mining operations

### 9. Other Utilities
- `ollama_chat.lua` - Ollama integration for local LLM
- `github_reader.lua` - Read files from GitHub
- `download_turtle_ai_client.lua` - Installer for turtle AI client
- `download_turtle_ai_server.lua` - Installer for turtle AI server

## Project Structure

```
TurtleAI/
├── gemini_chat.lua              # Main chat program with RAG
├── turtle_ai_client.lua         # Turtle control via Gemini
├── turtle_ai_server.lua         # Server component
├── gemini_turtle.lua            # Alternative turtle control
├── ollama_chat.lua              # Ollama integration
├── tunnel.lua                   # Advanced mining
├── simple_tunnel.lua            # Basic mining
├── companion/                   # GPS follower system
│   ├── dog_turtle.lua
│   ├── player_beacon.lua
│   └── install.lua
├── cc-art-display/              # In-game AI art
│   ├── art_display.lua
│   ├── bridge_server.py
│   └── README.md
├── ai-console-art/              # Terminal AI art
│   ├── console_art.py
│   ├── comfy_client.py
│   ├── comfy_server.py
│   ├── image_to_ascii.py
│   └── README.md
├── cc_docs/                     # ComputerCraft documentation
│   └── category_index.json
└── README.md
```

## Technical Details

### ComputerCraft Environment
- **Language:** Lua 5.2 (with CC: Tweaked modifications)
- **HTTP API:** Available via `http.get()`, `http.post()`
- **File System:** Via `fs.*` API
- **Settings:** Persistent via `settings.*` API
- **Networking:** Modems, wireless, wired networks
- **Peripherals:** Monitors, disk drives, printers, etc.

### API Integration

#### Gemini API
**Endpoint:** `https://generativelanguage.googleapis.com/v1beta/{MODEL}:generateContent`

**Authentication:** API key via query parameter `?key=YOUR_KEY`

**Request Format:**
```json
{
  "contents": [
    {
      "role": "user",
      "parts": [{"text": "prompt here"}]
    }
  ],
  "generationConfig": {
    "maxOutputTokens": 1000
  }
}
```

**Response Format:**
```json
{
  "candidates": [
    {
      "content": {
        "parts": [
          {"text": "response here"}
        ]
      }
    }
  ]
}
```

**Models Available:**
- `models/gemini-2.5-flash` - Default, fastest
- `models/gemini-3-flash-preview` - Latest preview

#### HTTP in ComputerCraft
**Important:** Must configure `computercraft-common.toml` to allow HTTP:
```toml
[[http.rules]]
    host = "127.0.0.1"
    action = "allow"

[[http.rules]]
    host = "generativelanguage.googleapis.com"
    action = "allow"
```

### JSON Parsing
Uses ComputerCraft's built-in `textutils.unserialiseJSON()` with regex fallback for robustness.

### Auto-Update Mechanism
Programs can update themselves:
1. Download new version from GitHub to temp file
2. Validate content (length check)
3. Delete old version
4. Rename temp to original name
5. Restart program

**GitHub Raw URL Pattern:**
```
https://raw.githubusercontent.com/gotoundo/TurtleAI/dev/{filename}
```

## Development Guidelines

### Code Style
- **Indentation:** 2 spaces
- **Naming:** `camelCase` for functions, `UPPER_CASE` for constants
- **Comments:** Explain "why", not "what"
- **Line length:** Keep under 100 chars when possible
- **Error handling:** Always check return values from API calls

### Adding Features to gemini_chat.lua
1. Add command to `help` command list
2. Add `elseif command == "newcmd"` block in main loop
3. Keep commands simple and focused
4. Update VERSION constant (semantic versioning)
5. Test thoroughly before committing

### Version Numbering
- **Major (X.0.0):** Breaking changes, major new features
- **Minor (1.X.0):** New features, significant improvements
- **Patch (1.0.X):** Bug fixes, small tweaks

### Git Workflow
- **Branch:** `dev` (main development branch)
- **Main branch:** `main` (stable releases)
- **Commit format:** Descriptive, multi-line with Co-Authored-By: Claude
- Always test in-game before pushing

### Testing
1. Test in ComputerCraft environment (in Minecraft)
2. Verify HTTP requests work
3. Check error messages are helpful
4. Test auto-update functionality
5. Verify conversation history works correctly

## Common Tasks

### Adding a New Command to CC Chat
```lua
elseif command == "mycmd" then
  local arg = input:match("^mycmd%s+(.+)$")
  if arg then
    -- Handle command with argument
    print("Running: " .. arg)
  else
    -- Handle command without argument
    print("Usage: mycmd <argument>")
  end
```

### Calling Gemini API
```lua
local response = http.post(
  url,
  requestBody,
  {["Content-Type"] = "application/json"}
)

if not response then
  return nil, "Connection failed"
end

local responseText = response.readAll()
response.close()

local result = parseJSON(responseText)
```

### Reading/Writing Files
```lua
-- Read
local file = fs.open("filename.txt", "r")
local content = file.readAll()
file.close()

-- Write
local file = fs.open("filename.txt", "w")
file.write(content)
file.close()
```

### Settings Management
```lua
-- Define
settings.define("my.setting", {
  description = "My setting",
  default = "value",
  type = "string"
})

-- Load
settings.load()

-- Get
local value = settings.get("my.setting")

-- Set
settings.set("my.setting", "new value")
settings.save()
```

## Debugging

### Debug Mode in CC Chat
Type `debug` to toggle verbose output:
- Connection status
- Selected documents
- Context size
- Response size
- Server error messages (always shown)

### Common Issues

**"Could not connect to Gemini API"**
- Check API key is set (`setkey` command)
- Verify HTTP is allowed in CC config
- Check network connectivity
- Try switching models (`model 2.5` or `model 3`)

**"Failed to parse response"**
- Enable debug mode to see raw response
- Server may have returned an error
- Check API key is valid

**Truncated responses**
- Fixed in v1.4.3+ (was JSON parsing bug)
- Fixed in v1.4.3+ (was prompt instruction too restrictive)

**Documentation not loading**
- Check `/cc_docs/category_index.json` exists
- Use `reload` command to retry
- Enable debug mode to see detailed load process

## Installation

### In-Game Installation (ComputerCraft)

**CC Chat:**
```lua
wget https://raw.githubusercontent.com/gotoundo/TurtleAI/dev/gemini_chat.lua gemini_chat.lua
gemini_chat
setkey
-- Enter your Gemini API key
```

**Turtle AI:**
```lua
wget https://raw.githubusercontent.com/gotoundo/TurtleAI/dev/turtle_ai_client.lua turtle_ai_client.lua
```

**Companion System:**
```lua
wget https://raw.githubusercontent.com/gotoundo/TurtleAI/dev/companion/install.lua install.lua
install
```

### Python Components

**AI Console Art:**
```bash
cd ai-console-art
pip install -r requirements.txt
python console_art.py
```

**CC Art Display Bridge:**
```bash
cd cc-art-display
pip install -r requirements.txt
python bridge_server.py
```

## API Keys and Secrets

- **API keys:** Stored via ComputerCraft `settings` API
- **Never hardcode:** API keys in source code
- **Default:** Empty string, must be set by user
- **Display:** Masked (first 8 + last 4 chars)

## Future Enhancements

### Potential Features
- Multi-model support (Claude, GPT, etc.)
- Voice control via speech-to-text
- Turtle swarm coordination
- Automated building from blueprints
- Advanced pathfinding
- Inventory management AI
- Trading system integration

### Known Limitations
- ComputerCraft Lua is sandboxed (limited OS access)
- HTTP requests are rate-limited
- No async/await (must use parallel API)
- JSON parsing can be fragile with large responses
- 16-color display limits art quality

## Resources

- **CC: Tweaked Docs:** https://tweaked.cc/
- **Gemini API Docs:** https://ai.google.dev/gemini-api/docs
- **ComfyUI:** https://github.com/comfyanonymous/ComfyUI
- **Project GitHub:** https://github.com/gotoundo/TurtleAI

## Contact & Contributions

This is an active development project. When working on features:
1. Test thoroughly in-game
2. Keep code simple and readable
3. Update documentation
4. Use semantic versioning
5. Add Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com> to commits

## Recent Changes

### v1.7.0 (Latest)
- Added model switcher command
- Changed default to Gemini 2.5 Flash
- Simplified debug output
- Server errors always shown

### v1.6.0
- Rebranded to "CC Chat"
- Added `help` and `info` commands
- Cleaner startup screen

### v1.5.0
- Added auto-update command

### v1.4.3
- Fixed response truncation bug
- Improved response length

### v1.4.2
- Fixed JSON parsing issues

### v1.4.1
- Fixed model name format

## Architecture Notes

### RAG Pipeline (in gemini_chat.lua)
1. **Query Processing:** User enters question
2. **Document Selection:** AI selects relevant docs from index (up to 3)
3. **Context Building:** Selected docs combined into context string
4. **Answer Generation:** Query + context + history sent to Gemini
5. **Response:** AI answers using docs as reference

### Why This Approach?
- **Token efficiency:** Only relevant docs sent, not entire knowledge base
- **Better answers:** Focused context improves relevance
- **Scalable:** Works with large documentation sets
- **Transparent:** Shows which docs were used

### Conversation History
Maintained in memory as array of `{role, text}` objects. Each query adds user message, each response adds model message. History provides context for follow-up questions.

## Special Considerations

### ComputerCraft Limitations
- **No require():** Can't use standard Lua modules
- **No coroutines:** Limited to CC's parallel API
- **Sandboxed:** Can't access real OS
- **Event-driven:** Must yield regularly or timeout
- **Limited RAM:** Keep data structures small

### Minecraft Integration
- Programs run on in-game computers
- Turtles are mobile robots with inventory
- GPS requires 4+ computers in known positions
- Wireless modems have range limits
- Chunk loading affects turtle operations

---

**Remember:** This is Minecraft! Keep it fun, keep it simple, and always test in-game before pushing code.
