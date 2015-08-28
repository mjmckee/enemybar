_addon.name = 'enemybar'
_addon.author = 'mmckee'
_addon.version = '0.2'
_addon.language = 'English'


require('gui_settings')

windower.register_event('load', function()
	if windower.ffxi.get_info().logged_in then
		init_images()
	end
end)

windower.register_event('prerender', renderTargetBar)
windower.register_event('prerender', renderSubTargetBar)
windower.register_event('target change', targetChange)