_addon.name = 'enemybar'
_addon.author = 'mmckee'
_addon.version = '0.1'
_addon.language = 'English'

x = windower.get_windower_settings().x_res / 2 - 500 / 2
y = 50

windower.prim.create('background')
windower.prim.set_color('background', 255, 0, 0, 0)
windower.prim.set_position('background', x, y)
windower.prim.set_size('background', 500, 25)
windower.prim.set_visibility('background', false)

windower.prim.create('foreground')
windower.prim.set_color('foreground', 255, 255, 15, 0)
windower.prim.set_position('foreground', x, y)
windower.prim.set_size('foreground', 500, 25)
windower.prim.set_visibility('foreground', false)

windower.text.create('eb_name')
windower.text.set_bg_color('eb_name', 0, 0, 0, 0)
windower.text.set_bg_visibility('eb_name', false)
windower.text.set_color('eb_name', 255, 255, 255, 255)
windower.text.set_font('eb_name', 'Arial')
windower.text.set_font_size('eb_name', 16)
windower.text.set_bold('eb_name', true)
windower.text.set_location('eb_name', x, y)
windower.text.set_text('eb_name', 'Enemy Name')
windower.text.set_visibility('eb_name', false)


visible = false
mob = nil
windower.register_event('prerender', function()
	if visible == true then
		local mob = windower.ffxi.get_mob_by_target('t')
		local player = windower.ffxi.get_player()
		if mob ~= nil then
			windower.text.set_text('eb_name', mob.name .. ' - HP ' .. mob.hpp .. '%')
			i = mob.hpp / 100
			windower.prim.set_size('foreground', math.floor(500 * i), 25)
			
			if player.in_combat == true then
				windower.prim.set_color('foreground', 255, 255, 150, 0)
			end
		end
	end
end)

windower.register_event('target change', function(index)
	if index == 0 then
		
		windower.text.set_visibility('eb_name', false)
		windower.prim.set_visibility('foreground', false)
		windower.prim.set_visibility('background', false)
		visible = false
	else
		
		windower.text.set_visibility('eb_name', true)
		windower.prim.set_visibility('foreground', true)
		windower.prim.set_visibility('background', true)
		visible = true
	end
end)