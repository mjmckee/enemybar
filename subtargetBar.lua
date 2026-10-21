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

local hide_subtarget_bar = function()
    stbg_cap_l:hide()
    stbg_cap_r:hide()
    stbg_body:hide()
    stfg_body:hide()
    st_text:hide()
end

render_subtarget_bar = function(...)
    if visible == true then
        local subtarget = windower.ffxi.get_mob_by_target('st')
        
        if subtarget ~= nil and target ~= nil and subtarget.id ~= target.id then
            stbg_cap_l:show()
            stbg_cap_r:show()
            stbg_body:show()
            stfg_body:show()
            st_text:show()

            local i = subtarget.hpp / 100
            local new_width = math.floor(subtargetBarWidth * i)	
            stfg_body:width(new_width)		
            stbg_body:width(subtargetBarWidth)

            st_text.name = subtarget.name
            st_text:color(get_name_color(subtarget))
        else
            hide_subtarget_bar()
        end
    else
        -- No target at all: hide the sub-target bar too, like the target bar does
        hide_subtarget_bar()
    end
end