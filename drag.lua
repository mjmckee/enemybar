--[[
Copyright © 2015, Mike McKee
All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of enemybar nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Mike McKee BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--]]

-- Click and drag any part of the bars to move all of them together.
--
-- The texts and images libraries can drag each object on its own, but that
-- would pull the pieces apart, so those flags stay off (draggable = false in
-- gui_settings.lua) and this handler moves everything through position_bars().

-- Mouse event types (the libraries use the same values):
--   0 = mouse moved, 1 = left down, 2 = left up, 3 = left double click
local dragging = nil -- set to {x = offset_x, y = offset_y} while a drag is active

local clamp = function(value, low, high)
    return math.max(low, math.min(high, value))
end

-- True if the pointer is over a visible part of either bar.
-- hover() returns false for hidden objects, so nothing is draggable without a target.
local over_bars = function(x, y)
    local parts = {tbg_body, stbg_body, t_text, st_text}
    for _, part in ipairs(parts) do
        if part ~= nil and part:hover(x, y) then
            return true
        end
    end
    return false
end

local save_position = function()
    settings.pos.x = bar_x
    settings.pos.y = bar_y
    config.save(settings)
end

windower.register_event('mouse', function(type, x, y, delta, blocked)
    if blocked then
        return
    end

    if type == 1 or type == 3 then
        if over_bars(x, y) then
            dragging = {x = x - bar_x, y = y - bar_y}
            return true -- keep this click from reaching the game
        end

    elseif type == 0 then
        if dragging then
            if visible ~= true then
                dragging = nil -- the bars were hidden mid-drag, so stop
                return
            end
            local res = windower.get_windower_settings()
            local max_x = (res.x_res or 1920) - targetBarWidth - 2
            local max_y = (res.y_res or 1080) - 40
            position_bars(clamp(x - dragging.x, 1, max_x), clamp(y - dragging.y, 0, max_y))
        end

    elseif type == 2 then
        if dragging then
            dragging = nil
            save_position()
            return true -- matches the click we blocked
        end
    end
end)
