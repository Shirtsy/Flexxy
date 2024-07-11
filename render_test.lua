local draw_pattern = require("hex_render")

term.clear()
local pattern = "qeqwqwqwqwqeqaeqeaqeqaeqaqded"
local direction = "NORTH_EAST"
draw_pattern(direction, pattern, 20, 1, 20, colors.yellow)
draw_pattern(direction, pattern, 41, 1, 20, colors.yellow)
term.setCursorPos(1,1)