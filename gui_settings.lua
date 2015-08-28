config = require('config')
file = require('files')
packets = require('packets')
images = require('images')
texts = require('texts')

defaults = {}
defaults.global = {}
defaults.global.targetBarHeight = 10
defaults.global.targetBarWidth = 598
defaults.global.subtargetBarHeight = 10
defaults.global.subtargetBarWidth = 198
defaults.global.X = windower.get_windower_settings().x_res / 2 - defaults.global.targetBarWidth / 2
defaults.global.Y = 50
defaults.global.BGPath = windower.addon_path.. 'bar_bg.png'
defaults.global.FGPath = windower.addon_path.. 'bar_fg.png'
defaults.global.stBGPath = windower.addon_path.. 'st_bar_bg.png'
defaults.global.stFGPath = windower.addon_path.. 'st_bar_fg.png'
defaults.global.visible = false
defaults.global.font = 'Arial'
defaults.global.txtSize = 14
defaults.global.strkSize = 1
defaults.global.style = 0

settings = config.load(defaults)
config.save(settings)

bg_image = images.new()
fg_image = images.new()

st_bg_image = images.new()
st_fg_image = images.new()
txtTarget = texts.new()
txtSubTarget = texts.new()

function init_images()
	bg_image:pos(settings.global.X, settings.global.Y)
	bg_image:path(settings.global.BGPath)
	bg_image:color(255, 255, 255, 255)
	bg_image:fit(true)
	bg_image:size(settings.global.targetBarHeight, settings.global.targetBarWidth)
	bg_image:repeat_xy(1, 1)
	
	fg_image:pos(settings.global.X + 2, settings.global.Y + 1)
	fg_image:path(settings.global.FGPath)
	fg_image:fit(true)
	fg_image:size(settings.global.targetBarHeight, settings.global.targetBarWidth)
	fg_image:repeat_xy(1, 1)
	
	st_bg_image:pos(settings.global.X + 400, settings.global.Y + 15)
	st_bg_image:path(settings.global.stBGPath)
	st_bg_image:color(255, 255, 255, 255)
	st_bg_image:fit(true)
	st_bg_image:size(settings.global.subtargetBarHeight, settings.global.subtargetBarWidth)
	st_bg_image:repeat_xy(1, 1)
	
    st_fg_image:pos(settings.global.X + 402, settings.global.Y + 16)
	st_fg_image:path(settings.global.stFGPath)
	st_fg_image:color(255, 255, 255, 255)
	st_fg_image:fit(true)
	st_fg_image:size(settings.global.subtargetBarHeight, settings.global.subtargetBarWidth)
	st_fg_image:repeat_xy(1, 1)
	
	txtTarget:pos(settings.global.X, settings.global.Y)
	txtTarget:font(settings.global.font)
	txtTarget:size(settings.global.size)
	txtTarget:bold(true)
	txtTarget:text('Enemy Name')
	
	txtTarget:bg_visible(false)
	txtTarget:color(255, 255, 255)
	txtTarget:alpha(255)
	
	txtTarget:stroke_width(settings.global.strkSize)
	txtTarget:stroke_color(50, 50, 50)
	txtTarget:stroke_transparency(127)
	
	txtSubTarget:pos(settings.global.X + 400, settings.global.Y + 15)
	txtSubTarget:font(settings.global.font)
	txtSubTarget:size(settings.global.size)
	txtSubTarget:bold(true)
	txtSubTarget:text('Sub Name')
	
	txtSubTarget:bg_visible(false)
	txtSubTarget:color(255, 255, 255)
	txtSubTarget:alpha(255)
	
	txtSubTarget:stroke_width(settings.global.strkSize)
	txtSubTarget:stroke_color(50, 50, 50)
	txtSubTarget:stroke_transparency(127)
		
end

renderSubTargetBar = function(...)
	if settings.global.visible == true then
		local subtarget = windower.ffxi.get_mob_by_target('st')
		
		if subtarget ~= nil then
			st_bg_image:show()
			st_fg_image:show()
			txtSubTarget:show()
			local i = subtarget.hpp / 100
			local new_width = math.floor(198 * i)	
			
			st_fg_image:size(new_width, 10)
			txtSubTarget:text('  ' .. subtarget.name)
		else
			st_bg_image:hide()
			st_fg_image:hide()
			txtSubTarget:hide()
		end
	end
end

renderTargetBar = function (...)
	if settings.global.visible == true then
		local target = windower.ffxi.get_mob_by_target('t')
		local player = windower.ffxi.get_player()
		
		if target ~= nil then
			local old_width = fg_image:width()
			local i = target.hpp / 100
			local new_width = math.floor(settings.global.targetBarWidth * i)
			
			if settings.global.style == 1 then
				--Animated Style 'borrowed' from Morath's barfiller
				if new_width ~= nil and new_width > 0 then
					if old_width > new_width then
						local last_update = 0
						local x = old_width + math.ceil(((new_width - old_width) * 0.1))
						fg_image:size(x, 10)
			
						local now = os.clock()
						if now - last_update > 0.5 then
							last_update = now
						end
					elseif old_width <= new_width then
						fg_image:size(new_width, 10)
					end
				end
			else
				--Classic Style
				fg_image:size(new_width, 10)
			end
			
			--Update the Text
			txtTarget:text('  ' .. target.name .. ' - HP ' .. target.hpp .. '%')
			if player.in_combat == true then
				txtTarget:color(255, 80, 80)
			else
				if target.is_npc == false then
					txtTarget:color(255, 255, 255)
				else
					if target.claim_id == 0 then
						txtTarget:color(230, 230, 138)
					else 
						if target.hpp == 0 then
							txtTarget:color(155, 155, 155)
						else
							txtTarget:color(153, 102, 255)
						end
					end
				end
			end
		end
	end
end

targetChange = function(index)
	if index == 0 then
		bg_image:hide()
		fg_image:hide()
		txtTarget:hide()
		settings.global.visible = false
	else
		bg_image:show()
		fg_image:show()
		txtTarget:show()
		settings.global.visible = true
	end
end