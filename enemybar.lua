_addon.name = 'enemybar'
_addon.author = 'mmckee'
_addon.version = '0.1'
_addon.language = 'English'



stroke = 1
width = 400
height = 20

h_width = width

x = windower.get_windower_settings().x_res / 2 - width / 2
y = 50

windower.prim.create('outline')
windower.prim.set_color('outline', 255, 200, 200, 200)
windower.prim.set_position('outline', x - stroke, y - stroke)
windower.prim.set_size('outline', width + stroke, height + stroke)
windower.prim.set_visibility('outline', false)

windower.prim.create('outline_tc')
windower.prim.set_color('outline_tc', 255, 200, 200, 200)
windower.prim.set_position('outline_tc', x + width, y - stroke)
windower.prim.set_size('outline_tc', stroke, stroke)
windower.prim.set_visibility('outline_tc', false)

windower.prim.create('outline_b')
windower.prim.set_color('outline_b', 255, 100, 100, 100)
windower.prim.set_position('outline_b', x, y)
windower.prim.set_size('outline_b', width + stroke, height + stroke)
windower.prim.set_visibility('outline_b', false)

windower.prim.create('outline_b_tc')
windower.prim.set_color('outline_b_tc', 255, 100, 100, 100)
windower.prim.set_position('outline_b_tc', x - stroke, y + height)
windower.prim.set_size('outline_b_tc', stroke, stroke)
windower.prim.set_visibility('outline_b_tc', false)

windower.prim.create('background')
windower.prim.set_color('background', 255, 0, 0, 0)
windower.prim.set_position('background', x, y)
windower.prim.set_size('background', width, height)
windower.prim.set_visibility('background', false)

windower.prim.create('foreground')
windower.prim.set_color('foreground', 255, 255, 150, 0)
windower.prim.set_position('foreground', x, y)
windower.prim.set_size('foreground', width, height)
windower.prim.set_visibility('foreground', false)

windower.text.create('eb_name')
windower.text.set_bg_color('eb_name', 0, 0, 0, 0)
windower.text.set_bg_visibility('eb_name', false)
windower.text.set_color('eb_name', 255, 255, 255, 255)
windower.text.set_font('eb_name', 'Arial')
windower.text.set_font_size('eb_name', height - 9)
windower.text.set_bold('eb_name', true)
windower.text.set_location('eb_name', x, y)
windower.text.set_text('eb_name', 'Enemy Name')
windower.text.set_stroke_color('eb_name', 255, 100, 100, 100)
windower.text.set_stroke_width('eb_name', 1)
windower.text.set_visibility('eb_name', false)


visible = false
mob = nil
windower.register_event('prerender', function()
	if visible == true then
		local mob = windower.ffxi.get_mob_by_target('t')
		local player = windower.ffxi.get_player()
		if mob ~= nil then
			local i = mob.hpp / 100
			local new_width = math.floor(width * i)
			
			--local x = old_width + math.ceil(((new_width - old_width) * 0.1))
			windower.prim.set_size('foreground', new_width, height)
			windower.text.set_text('eb_name', '  ' .. mob.name .. ' - HP ' .. mob.hpp .. '%')
			if player.in_combat == true then
				windower.prim.set_color('foreground', 255, 255, 15, 0)
			else
				if mob.is_npc == false then
					windower.prim.set_color('foreground', 255, 0, 150, 255)
				else
					if mob.claim_id == 0 then
						windower.prim.set_color('foreground', 255, 255, 150, 0)
					else 
						windower.prim.set_color('foreground', 255, 153, 102, 255)
					end
				end
			end
		end
	end
end)

windower.register_event('target change', function(index)
	if index == 0 then
		windower.prim.set_visibility('outline', false)
		windower.prim.set_visibility('outline_b', false)
		windower.prim.set_visibility('outline_tc', false)
		windower.prim.set_visibility('outline_b_tc', false)
		windower.text.set_visibility('eb_name', false)
		windower.prim.set_visibility('foreground', false)
		windower.prim.set_visibility('background', false)
		visible = false
	else
		windower.prim.set_visibility('outline', true)
		windower.prim.set_visibility('outline_b', true)
		windower.prim.set_visibility('outline_tc', true)
		windower.prim.set_visibility('outline_b_tc', true)
		windower.text.set_visibility('eb_name', true)
		windower.prim.set_visibility('foreground', true)
		windower.prim.set_visibility('background', true)
		visible = true
	end
end)