# Turtle Companion System

A ComputerCraft: Tweaked system that makes a turtle follow a player like a loyal dog companion.

## Overview

This system consists of two programs that work together:
- **player_beacon.lua** - Runs on a pocket computer to broadcast your position
- **dog_turtle.lua** - Runs on a turtle to follow the player's beacon

## Requirements

### Hardware
- **1 Pocket Computer** with wireless modem (for the player)
- **1 Turtle** with wireless modem upgrade (the companion)
- **GPS Network** - At least 4 GPS hosts set up in your world

### GPS Setup
You need a functioning GPS network for this system to work. See the [GPS Setup Guide](https://tweaked.cc/guide/gps_setup.html) for details.

Quick setup:
```bash
# On each of 4 computers with modems (placed at known coordinates)
gps host <x> <y> <z>
```

## Installation

### Option 1: Manual Installation
1. Copy `player_beacon.lua` to your pocket computer
2. Copy `dog_turtle.lua` to your turtle

### Option 2: GitHub Download
```lua
-- On pocket computer:
wget https://raw.githubusercontent.com/[your-repo]/companion/player_beacon.lua player_beacon.lua

-- On turtle:
wget https://raw.githubusercontent.com/[your-repo]/companion/dog_turtle.lua dog_turtle.lua
```

## Usage

### Step 1: Start the Player Beacon
On your pocket computer, run:
```bash
player_beacon [your_name]
```

Example:
```bash
player_beacon steve
```

The beacon will continuously broadcast your GPS position to any nearby turtles.

### Step 2: Start the Dog Turtle
On your turtle, run:
```bash
dog_turtle [player_name] [follow_distance]
```

Example:
```bash
dog_turtle steve 3
```

This makes the turtle follow the player named "steve" and maintain a distance of 3 blocks.

### Parameters
- **player_name** (optional, default: "player") - Must match the name used in player_beacon
- **follow_distance** (optional, default: 3) - How many blocks away the turtle stays

## Features

- **GPS-based tracking** - Uses the GPS API for accurate positioning
- **Wireless communication** - Uses rednet protocol for position updates
- **Obstacle navigation** - Automatically digs through obstacles or goes around them
- **Auto-refueling** - Attempts to refuel from inventory when fuel is low
- **Real-time status display** - Shows current positions, distance, and fuel level
- **Configurable follow distance** - Set how close the turtle stays to you

## How It Works

1. The pocket computer gets its GPS position every 0.5 seconds
2. When the position changes, it broadcasts the update via rednet
3. The turtle receives the position update
4. The turtle calculates the distance and direction to the player
5. If too far away, the turtle moves toward the player
6. The cycle repeats continuously

## Tips

- **Fuel**: Make sure your turtle has plenty of fuel (coal, charcoal, etc.)
- **Tools**: Equip the turtle with a diamond pickaxe to dig through obstacles
- **Range**: Wireless modems have limited range (64 blocks by default)
- **Multiple turtles**: You can have multiple turtles following the same player
- **GPS coverage**: Ensure GPS works in the areas you'll be exploring

## Troubleshooting

### "No modem found!"
- Make sure a wireless modem is equipped on the pocket computer or turtle
- For turtles, craft: turtle + wireless modem

### "GPS unavailable"
- Ensure you have at least 4 GPS hosts running
- GPS hosts must be at known coordinates
- Check that you're within range of the GPS network

### Turtle stops following
- Check fuel level - the turtle may be out of fuel
- Verify the player beacon is still running
- Ensure both devices are within wireless modem range

### Turtle gets stuck
- The turtle will attempt to dig through obstacles
- Equip a diamond pickaxe upgrade for best results
- Some blocks (like bedrock) cannot be broken

## Customization

You can modify these variables in `dog_turtle.lua`:
- `UPDATE_TIMEOUT` - How long to wait before considering player lost (default: 5 seconds)
- `POSITION_TOLERANCE` - Movement precision (default: 1 block)
- `followDistance` - Default follow distance (default: 3 blocks)

In `player_beacon.lua`:
- `updateInterval` - How often to broadcast position (default: 0.5 seconds)

## License

MIT License - Feel free to modify and distribute
