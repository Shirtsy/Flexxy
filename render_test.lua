local get_point_canvas = require("hex_render")

local function getRunningPath()
    local runningProgram = shell.getRunningProgram()
    local programName = fs.getName(runningProgram)
    return runningProgram:sub( 1, #runningProgram - #programName )
end

-- Function to extract pattern and direction from JSON data
local function get_pattern(pattern_name)
    if type(pattern_name) == "table" then
        return pattern_name.pattern, pattern_name.direction
    else
        -- Load the JSON file
        local file = fs.open(getRunningPath() .. "symbol-registry.json", "r")
        -- Parse the JSON content
        local data = textutils.unserialiseJSON(file.readAll())
        if not data then
            error("Failed to decode JSON data")
        end

        -- Find and return the pattern and direction for the given modName
        local entry = data[pattern_name]
        if entry then
            return entry.pattern, entry.direction
        else
            return nil, nil
        end
    end
end

local pattern_list = {
    "Mind's Reflection",
    "Compass' Purification II",
    "Gemini Decomposition",
    "Vector Reflection -Y",
    "Additive Distillation",
    "Jester's Gambit",
    "Mind's Reflection",
    "Alidade's Purification",
    "Scout's Distillation",
    "Jester's Gambit",
    "Flay Mind",
    {pattern = "aqaawaaqqaa", direction = "SOUTH_EAST"}
}

term.clear()
local width, height = 10, 6
local row_length = math.floor(51/width)
for i, pattern in pairs(pattern_list) do
    local pattern, start_angle = get_pattern(pattern)
    local canv = get_point_canvas(pattern, start_angle, width, height)
    canv:set_foreground_color(colors.yellow)
    canv:render_canvas((i-1) % row_length * width + 1, 2 + height * math.floor((i-1) / row_length))
end
term.setCursorPos(1,1)