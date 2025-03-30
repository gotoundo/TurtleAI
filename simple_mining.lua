-- 3D Mining Turtle Script with Inventory Management and Recovery
-- Usage: 3dminer <width> <height> <depth>
-- The turtle will mine a rectangular prism of the specified dimensions
-- Written for CC:Tweaked Minecraft mod

-- to do
-- The "Estimated fuel required" warning should only appear when the program is starting for the first time (not on every turn and not on continuation)
-- Prepare script for auto-running upon startup. If the turtle has 0 items in its inventory, it quits the script instead; its been broken and replaced by the player.

-- Configuration
local CONFIG = {
  STATE_FILE = ".3dminer_state",
  DEBUG = false,
  SLOTS_IN_INVENTORY = 16,
  INITIAL_FACING = 0  -- Save initial facing direction (0=East by default)
}

-- Direction constants
local DIRECTION = {
  EAST = 0,  -- +x
  SOUTH = 1, -- +z
  WEST = 2,  -- -x
  NORTH = 3  -- -z
}

-- Operation state constants
local STATE = {
  MINING = "mining",
  RETURNING_TO_DEPOSIT = "returning_to_deposit",
  RETURNING_TO_MINE = "returning_to_mine",
  JOB_COMPLETED = "job_completed"
}

-- Function to print debug messages
local function debug(message)
  if CONFIG.DEBUG then
    print("[DEBUG] " .. message)
  end
end

-- Forward declarations to handle circular dependencies
local movement
local inventory
local mining

-- Unified state object
local state = {
  pos = { x = 0, y = 0, z = 0 },
  facing = DIRECTION.EAST,
  dimensions = { width = 0, height = 0, depth = 0 },
  current = { x = 0, y = 0, z = 0 },
  operation = STATE.MINING,
  resume = nil,
  resumeOperation = false,
  
  -- Save the current state to settings
  save = function(self)
    settings.set("3dminer.pos.x", self.pos.x)
    settings.set("3dminer.pos.y", self.pos.y)
    settings.set("3dminer.pos.z", self.pos.z)
    settings.set("3dminer.facing", self.facing)
    settings.set("3dminer.dimensions.width", self.dimensions.width)
    settings.set("3dminer.dimensions.height", self.dimensions.height)
    settings.set("3dminer.dimensions.depth", self.dimensions.depth)
    settings.set("3dminer.current.x", self.current.x)
    settings.set("3dminer.current.y", self.current.y)
    settings.set("3dminer.current.z", self.current.z)
    settings.set("3dminer.operation", self.operation)
    
    -- Save resume position if available
    if self.resume then
      settings.set("3dminer.resume.x", self.resume.x)
      settings.set("3dminer.resume.y", self.resume.y)
      settings.set("3dminer.resume.z", self.resume.z)
      settings.set("3dminer.resume.facing", self.resume.facing)
    end
    
    settings.save(CONFIG.STATE_FILE)
  end,
  
  -- Load state from settings
  load = function(self)
    if not fs.exists(CONFIG.STATE_FILE) or not settings.load(CONFIG.STATE_FILE) then
      return false
    end
    
    -- Check for required settings
    local requiredSettings = {
      "3dminer.pos.x", "3dminer.pos.y", "3dminer.pos.z", "3dminer.facing",
      "3dminer.dimensions.width", "3dminer.dimensions.height", "3dminer.dimensions.depth",
      "3dminer.current.x", "3dminer.current.y", "3dminer.current.z"
    }
    
    for _, setting in ipairs(requiredSettings) do
      if settings.get(setting) == nil then
        return false
      end
    end
    
    -- Load basic state
    self.pos.x = settings.get("3dminer.pos.x")
    self.pos.y = settings.get("3dminer.pos.y")
    self.pos.z = settings.get("3dminer.pos.z")
    self.facing = settings.get("3dminer.facing")
    self.dimensions.width = settings.get("3dminer.dimensions.width")
    self.dimensions.height = settings.get("3dminer.dimensions.height")
    self.dimensions.depth = settings.get("3dminer.dimensions.depth")
    self.current.x = settings.get("3dminer.current.x")
    self.current.y = settings.get("3dminer.current.y")
    self.current.z = settings.get("3dminer.current.z")
    self.operation = settings.get("3dminer.operation") or STATE.MINING
    
    -- Load resume position if it exists
    if settings.get("3dminer.resume.x") ~= nil then
      self.resume = {
        x = settings.get("3dminer.resume.x"),
        y = settings.get("3dminer.resume.y"),
        z = settings.get("3dminer.resume.z"),
        facing = settings.get("3dminer.resume.facing")
      }
    else
      self.resume = nil
    end
    
    return true
  end,
  
  -- Clear state
  clear = function(self)
    if fs.exists(CONFIG.STATE_FILE) then
      fs.delete(CONFIG.STATE_FILE)
    end
  end,
  
  -- Transition to a new operation state
  transition = function(self, newState, resumePosition)
    self.operation = newState
    
    if newState == STATE.RETURNING_TO_DEPOSIT and resumePosition then
      -- Save resume position when returning to deposit
      self.resume = resumePosition
    elseif newState == STATE.MINING then
      -- Clear resume position when back to mining
      self.resume = nil
    end
    
    self:save()
  end,
  
  -- Check if a position is within the mining area
  isInMiningArea = function(self, x, y, z)
    return x >= 0 and x < self.dimensions.width and 
           y >= 0 and y < self.dimensions.height and 
           z >= 0 and z < self.dimensions.depth
  end,
  
  -- Get position in a specific direction from current position
  getPositionInDirection = function(self, direction)
    local x, y, z = self.pos.x, self.pos.y, self.pos.z
    
    if direction == "forward" then
      if self.facing == DIRECTION.EAST then x = x + 1
      elseif self.facing == DIRECTION.SOUTH then z = z + 1
      elseif self.facing == DIRECTION.WEST then x = x - 1
      elseif self.facing == DIRECTION.NORTH then z = z - 1
      end
    elseif direction == "up" then
      y = y + 1
    elseif direction == "down" then
      y = y - 1
    end
    
    return x, y, z
  end,
  
  -- Update position after movement
  updatePosition = function(self, direction)
    if direction == "forward" then
      if self.facing == DIRECTION.EAST then self.pos.x = self.pos.x + 1
      elseif self.facing == DIRECTION.SOUTH then self.pos.z = self.pos.z + 1
      elseif self.facing == DIRECTION.WEST then self.pos.x = self.pos.x - 1
      elseif self.facing == DIRECTION.NORTH then self.pos.z = self.pos.z - 1
      end
    elseif direction == "back" then
      if self.facing == DIRECTION.EAST then self.pos.x = self.pos.x - 1
      elseif self.facing == DIRECTION.SOUTH then self.pos.z = self.pos.z - 1
      elseif self.facing == DIRECTION.WEST then self.pos.x = self.pos.x + 1
      elseif self.facing == DIRECTION.NORTH then self.pos.z = self.pos.z + 1
      end
    elseif direction == "up" then
      self.pos.y = self.pos.y + 1
    elseif direction == "down" then
      self.pos.y = self.pos.y - 1
    end
    
    self:save()
  end
}

-- Unified movement system
movement = {
  -- Turn the turtle a number of times (positive = right, negative = left)
  turn = function(times)
    times = times or 1
    
    if times > 0 then
      for i = 1, times do
        turtle.turnRight()
        state.facing = (state.facing + 1) % 4
      end
    elseif times < 0 then
      for i = 1, -times do
        turtle.turnLeft()
        state.facing = (state.facing - 1) % 4
      end
    end
    
    state:save()
  end,
  
  -- Turn to face a specific direction
  faceTo = function(direction)
    -- Find shortest path to target direction
    local currentDir = state.facing
    local diff = (direction - currentDir) % 4
    
    -- If diff > 2, it's shorter to turn left
    if diff > 2 then
      movement.turn(-(4 - diff))
    else
      movement.turn(diff)
    end
  end,
  
  -- Move in a direction with optional digging
  move = function(direction, safeMining)
    -- Direction can be "forward", "back", "up", or "down"
    local moveFunc, digFunc
    
    if direction == "forward" then
      moveFunc = turtle.forward
      digFunc = turtle.dig
    elseif direction == "back" then
      moveFunc = turtle.back
      digFunc = nil -- Can't dig backwards
    elseif direction == "up" then
      moveFunc = turtle.up
      digFunc = turtle.digUp
    elseif direction == "down" then
      moveFunc = turtle.down
      digFunc = turtle.digDown
    else
      return false, "Invalid direction"
    end
    
    -- If in safe mining mode, check if target position is in mining area
    if safeMining and digFunc then
      local x, y, z = state:getPositionInDirection(direction)
      
      -- Only dig if in mining area
      if state:isInMiningArea(x, y, z) then
        digFunc()
      end
    elseif digFunc then
      -- In regular mode, always dig if blocked
      local success = moveFunc()
      if not success and digFunc then
        digFunc()
        success = moveFunc()
      end
      
      if success then
        state:updatePosition(direction)
        return true
      else
        return false, "Movement obstructed"
      end
    end
    
    -- Try to move
    local success = moveFunc()
    if success then
      state:updatePosition(direction)
      return true
    end
    
    return false, "Movement failed"
  end,
  
  -- Navigate to a specific position with or without safe mining
  navigateTo = function(x, y, z, safeMining)
    -- First handle Y coordinate (up/down)
    while state.pos.y < y do
      local success, reason = movement.move("up", safeMining)
      if not success then
        print("Failed to move up: " .. (reason or "unknown reason"))
        return false
      end
    end
    
    while state.pos.y > y do
      local success, reason = movement.move("down", safeMining)
      if not success then
        print("Failed to move down: " .. (reason or "unknown reason"))
        return false
      end
    end
    
    -- Handle X coordinate
    if state.pos.x < x then
      movement.faceTo(DIRECTION.EAST) -- Face +X
    elseif state.pos.x > x then
      movement.faceTo(DIRECTION.WEST) -- Face -X
    end
    
    while state.pos.x ~= x do
      local success, reason = movement.move("forward", safeMining)
      if not success then
        print("Failed to move along X axis: " .. (reason or "unknown reason"))
        return false
      end
    end
    
    -- Handle Z coordinate
    if state.pos.z < z then
      movement.faceTo(DIRECTION.SOUTH) -- Face +Z
    elseif state.pos.z > z then
      movement.faceTo(DIRECTION.NORTH) -- Face -Z
    end
    
    while state.pos.z ~= z do
      local success, reason = movement.move("forward", safeMining)
      if not success then
        print("Failed to move along Z axis: " .. (reason or "unknown reason"))
        return false
      end
    end
    
    return true
  end,
  
  -- Return to origin (0,0,0)
  returnToOrigin = function()
    print("Returning to origin...")
    
    -- Update state to job completed
    state:transition(STATE.JOB_COMPLETED)
    
    -- Navigate back to origin
    movement.navigateTo(0, 0, 0, false)
    
    -- Face forward (original direction)
    movement.faceTo(CONFIG.INITIAL_FACING)
    
    -- Deposit any collected items
    inventory.deposit()
    
    print("Returned to starting position")
    
    -- Clear the state file as we've completed the task
    state:clear()
  end,
  
  -- Return to origin to deposit items, then return to mining
  returnToDeposit = function()
    print("Inventory full, returning to deposit items...")
    
    -- Save resume position
    local resumePosition = {
      x = state.pos.x,
      y = state.pos.y,
      z = state.pos.z,
      facing = state.facing
    }
    
    -- Update state to returning
    state:transition(STATE.RETURNING_TO_DEPOSIT, resumePosition)
    
    -- Navigate to origin
    movement.navigateTo(0, 0, 0, false)
    
    -- Deposit items
    inventory.deposit()
    
    -- Update state to returning to mine
    state:transition(STATE.RETURNING_TO_MINE)
    
    -- Navigate back to mining position
    movement.navigateTo(resumePosition.x, resumePosition.y, resumePosition.z, false)
    
    -- Restore facing direction
    movement.faceTo(resumePosition.facing)
    
    -- Reset state to mining
    state:transition(STATE.MINING)
    
    print("Returned to mining position, continuing operation.")
    return true
  end
}

-- Unified item handling
inventory = {
  -- Check if inventory is full
  isFull = function()
    for i = 1, CONFIG.SLOTS_IN_INVENTORY do
      if turtle.getItemCount(i) == 0 then
        return false
      end
    end
    return true
  end,
  
  -- Classify slot contents
  classifySlot = function(slot)
    turtle.select(slot)
    
    -- Check if it's a tool
    local itemDetail = turtle.getItemDetail()
    if itemDetail and itemDetail.damage ~= nil then
      return "tool"
    end
    
    -- Check if it's fuel
    if turtle.refuel(0) then
      return "fuel"
    end
    
    -- Otherwise it's just an item
    return "item"
  end,
  
  -- Deposit items into chest
  deposit = function()
    -- Turn to face the direction opposite of initial facing (toward chest)
    movement.faceTo((CONFIG.INITIAL_FACING + 2) % 4)
    
    -- Check if there's a chest
    if not turtle.detect() then
      print("No chest detected behind turtle! Please place one.")
      print("Press Enter when ready")
      read()
      
      -- Check again
      if not turtle.detect() then
        print("Still no chest detected. Continuing with full inventory.")
        -- Turn back to initial direction
        movement.faceTo(CONFIG.INITIAL_FACING)
        return false
      end
    end
    
    -- Deposit all non-tool, non-fuel items
    for i = 1, CONFIG.SLOTS_IN_INVENTORY do
      turtle.select(i)
      
      local itemType = inventory.classifySlot(i)
      if itemType ~= "tool" and itemType ~= "fuel" then
        turtle.drop()
      end
    end
    
    -- Turn back to initial facing direction
    movement.faceTo(CONFIG.INITIAL_FACING)
    
    -- Select the first slot
    turtle.select(1)
    
    return true
  end,
  
  -- Check and refuel if needed
  checkFuel = function()
    local estimatedNeeded = state.dimensions.width * state.dimensions.height * state.dimensions.depth * 2
    local fuelLevel = turtle.getFuelLevel()
    
    if fuelLevel == "unlimited" then
      return true
    end
    
    -- Need enough fuel to mine all blocks and return home
    if fuelLevel < estimatedNeeded then
      -- Try to refuel from inventory
      for i = 1, CONFIG.SLOTS_IN_INVENTORY do
        turtle.select(i)
        if turtle.refuel(0) then
          -- If this slot contains fuel, use it
          turtle.refuel()
          print("Refueled. New level: " .. turtle.getFuelLevel())
        end
      end
    end
    
    -- Check if we have enough fuel after refueling
    if turtle.getFuelLevel() < estimatedNeeded then
      print("Warning: Fuel may be insufficient to complete mining and return")
      print("Current fuel: " .. turtle.getFuelLevel() .. ", Estimated needed: " .. estimatedNeeded)
      print("Continue anyway? (y/n)")
      print("Auto-choosing yes")
      return true
      -- local input = read()
      -- if input:lower() ~= "y" then
      --   return false
      -- end
    end
    
    return true
  end
}

-- Mining operations
mining = {
  -- Mine a single block in a specific direction if it's in the mining area
  mineInDirection = function(direction)
    local x, y, z = state:getPositionInDirection(direction)
    
    if state:isInMiningArea(x, y, z) then
      if direction == "forward" then
        turtle.dig()
      elseif direction == "up" then
        turtle.digUp()
      elseif direction == "down" then
        turtle.digDown()
      end
      return true
    end
    
    return false
  end,
  
  -- Check and mine blocks above and below current position
  checkVerticalBlocks = function()
    if state.pos.y + 1 < state.dimensions.height then
      mining.mineInDirection("up")
    end
    
    if state.pos.y - 1 >= 0 then
      mining.mineInDirection("down")
    end
  end,
  
  -- Resume operation based on current state
  resumeOperation = function()
    if state.operation == STATE.RETURNING_TO_DEPOSIT then
      print("Continuing return to deposit...")
      movement.navigateTo(0, 0, 0, false)
      inventory.deposit()
      state:transition(STATE.RETURNING_TO_MINE)
      movement.navigateTo(state.resume.x, state.resume.y, state.resume.z, false)
      movement.faceTo(state.resume.facing)
      state:transition(STATE.MINING)
      
    elseif state.operation == STATE.RETURNING_TO_MINE then
      print("Continuing return to mining position...")
      movement.navigateTo(state.resume.x, state.resume.y, state.resume.z, false)
      movement.faceTo(state.resume.facing)
      state:transition(STATE.MINING)
      
    elseif state.operation == STATE.JOB_COMPLETED then
      print("Job already completed. Returning to origin...")
      movement.navigateTo(0, 0, 0, false)
      movement.faceTo(CONFIG.INITIAL_FACING)
      state:clear()
      return false
    end
    
    return true
  end,
  
  -- Main mining function
  start = function()
    -- Check if we need to resume a specific operation
    if state.operation ~= STATE.MINING then
      if not mining.resumeOperation() then
        return
      end
    end
    
    -- Normal mining operation
    print("Mining operation: " .. state.dimensions.width .. "x" .. 
          state.dimensions.height .. "x" .. state.dimensions.depth)
    print("Total blocks to mine: " .. 
          (state.dimensions.width * state.dimensions.height * state.dimensions.depth))
    
    if not inventory.checkFuel() then
      print("Mining aborted due to insufficient fuel")
      return
    end
    
    -- Mine in a 3D snake pattern, starting from where we left off if resuming
    for y = state.current.y, state.dimensions.height - 1 do
      -- Update current position for this layer
      state.current.y = y
      state:save()
      
      -- Determine starting Z position
      local startZ = 0
      if y == state.current.y and state.resumeOperation then
        startZ = state.current.z
      end
      
      for z = startZ, state.dimensions.depth - 1 do
        -- Update current position for this row
        state.current.z = z
        state:save()
        
        -- Determine starting X position and direction for this row
        local startX = 0
        local endX = state.dimensions.width - 1
        local step = 1
        
        -- If on odd rows (z is odd), go right to left
        if z % 2 == 1 then
          startX = state.dimensions.width - 1
          endX = 0
          step = -1
        end
        
        -- If resuming and on the current row, start from where we left off
        if y == state.current.y and z == state.current.z and state.resumeOperation then
          startX = state.current.x
        end
        
        -- Move to the start position of this row
        movement.navigateTo(startX, y, z, true)
        
        -- Reset resumeOperation after reaching the starting position
        if y == state.current.y and z == state.current.z and state.resumeOperation then
          state.resumeOperation = false
        end
        
        -- Iterate through the row
        local x = startX
        while (step > 0 and x <= endX) or (step < 0 and x >= endX) do
          -- Update current position
          state.current.x = x
          state:save()
          
          -- Only move if not already at this position
          if not (state.pos.x == x and state.pos.y == y and state.pos.z == z) then
            movement.navigateTo(x, y, z, true)
          end
          
          -- Mine vertical blocks
          mining.checkVerticalBlocks()
          
          -- Check if inventory is full
          if inventory.isFull() then
            movement.returnToDeposit()
          end
          
          inventory.checkFuel()
          
          x = x + step
        end
      end
    end
    
    movement.returnToOrigin()
    print("Mining operation complete!")
  end
}

-- Parse command line arguments
local args = {...}

-- Check for saved state
if state:load() then
  print("Found saved mining operation.")
  print("Dimensions: " .. state.dimensions.width .. "x" .. state.dimensions.height .. "x" .. state.dimensions.depth)
  print("Current position: " .. state.pos.x .. "," .. state.pos.y .. "," .. state.pos.z)
  
  -- Display different messages based on operation state
  if state.operation == STATE.MINING then
    print("Progress: Mining at " .. state.current.x .. "," .. state.current.y .. "," .. state.current.z)
  elseif state.operation == STATE.RETURNING_TO_DEPOSIT then
    print("Status: Returning to deposit items")
    if state.resume then
      print("Will resume mining at: " .. state.resume.x .. "," .. state.resume.y .. "," .. state.resume.z)
    end
  elseif state.operation == STATE.RETURNING_TO_MINE then
    print("Status: Returning to mining position after deposit")
    if state.resume then
      print("Heading to: " .. state.resume.x .. "," .. state.resume.y .. "," .. state.resume.z)
    end
  elseif state.operation == STATE.JOB_COMPLETED then
    print("Status: Job completed, returning home")
  end
  
  write("Resume operation? (y/n): ")
  local input = read()
  
  if input:lower() == "y" then
    state.resumeOperation = true
  else
    -- Clear the saved state
    state:clear()
    state = {
      pos = { x = 0, y = 0, z = 0 },
      facing = DIRECTION.EAST,
      dimensions = { width = 0, height = 0, depth = 0 },
      current = { x = 0, y = 0, z = 0 },
      operation = STATE.MINING,
      resume = nil,
      resumeOperation = false,
      
      save = state.save,
      load = state.load,
      clear = state.clear,
      transition = state.transition,
      isInMiningArea = state.isInMiningArea,
      getPositionInDirection = state.getPositionInDirection,
      updatePosition = state.updatePosition
    }
  end
end

-- If not resuming, parse arguments
if not state.resumeOperation then
  if #args < 3 then
    print("Usage: 3dminer <width> <height> <depth>")
    return
  end

  state.dimensions.width = tonumber(args[1])
  state.dimensions.height = tonumber(args[2])
  state.dimensions.depth = tonumber(args[3])

  if state.dimensions.width <= 0 or state.dimensions.height <= 0 or state.dimensions.depth <= 0 then
    print("Dimensions must be positive numbers")
    return
  end
  
  state:save()
end

-- Save the initial facing direction if starting fresh
if not state.resumeOperation then
  CONFIG.INITIAL_FACING = state.facing
end

-- Check for program interruption
local function handleEvents()
  while true do
    local event = os.pullEvent()
    
    -- If terminated (Ctrl+T), save state and exit
    if event == "terminate" then
      print("Program terminated by user.")
      print("Current state saved. Run the program again to resume.")
      return
    end
  end
end

-- Start the mining operation in parallel with event handling
parallel.waitForAny(mining.start, handleEvents)