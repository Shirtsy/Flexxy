local Vector2D = require("vector2d")
local math = require("math")

local pattern_angles = {
    a = 120,
    q = 60,
    w = 0,
    e = -60,
    d = -120,
    s = 180,
    EAST = 0,
    NORTH_EAST = 60,
    NORTH_WEST = 120,
    WEST = 180,
    SOUTH_WEST = 240,
    SOUTH_EAST = 300
}

local function parse_pattern(pattern, start_angle)
    local function parse_angles(str)
        local angles = {}
        for i = 1, #str do
            local char = str:sub(i, i):lower()
            if pattern_angles[char] then
                table.insert(angles, pattern_angles[char])
            elseif pattern_angles[char:upper()] then
                table.insert(angles, pattern_angles[char:upper()])
            end
        end
        return angles
    end

    local start_angles = parse_angles(start_angle)
    local pattern_angles = parse_angles(pattern)

    -- Concatenate the pattern angles to the start angles
    for _, angle in ipairs(pattern_angles) do
        table.insert(start_angles, angle)
    end

    return start_angles
end


local function plot_pattern(angles)
    local points = {Vector2D.new(0, 0)}  -- Start at (0, 0)
    local current_point = Vector2D.new(0, 0)

    for _, angle in ipairs(angles) do
        -- Convert angle to radians
        local rad_angle = math.rad(angle)
        
        -- Calculate the next point
        local dx = math.cos(rad_angle)
        local dy = math.sin(rad_angle)
        local vector = Vector2D.new(dx, dy)
        
        -- Add the new vector to the current point
        current_point = Vector2D.add(current_point, vector)
        
        -- Add the new point to our list
        table.insert(points, Vector2D.new(current_point.x, current_point.y))
    end

    return points
end

local function process_points(points, target_size)
    -- Find bounds
    local min_x, max_x = math.huge, -math.huge
    local min_y, max_y = math.huge, -math.huge

    for _, point in ipairs(points) do
        min_x = math.min(min_x, point.x)
        max_x = math.max(max_x, point.x)
        min_y = math.min(min_y, point.y)
        max_y = math.max(max_y, point.y)
    end

    -- Calculate center
    local center = Vector2D.new((min_x + max_x) / 2, (min_y + max_y) / 2)

    -- Calculate current size
    local width = max_x - min_x
    local height = max_y - min_y
    local current_size = math.max(width, height)

    -- Calculate scale factor
    local scale_factor = target_size / current_size

    -- Process points
    local processed_points = {}
    for _, point in ipairs(points) do
        -- Shift to origin
        local shifted = Vector2D.sub(point, Vector2D.new(min_x, min_y))
        
        -- Scale
        local scaled = Vector2D.mul(shifted, scale_factor)
        
        table.insert(processed_points, scaled)
    end

    return processed_points, center
end
