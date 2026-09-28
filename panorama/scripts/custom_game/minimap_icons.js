--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


var dotaHud = $.GetContextPanel().GetParent().GetParent().GetParent()
var icon_size = 13
var square_size = 7
var base_size = 24
var base_delta = 22
var root = null

GameEvents.Subscribe_custom('send_minimap_icons', update_minimap_icons)

GameEvents.OnLoaded(function()
{
	GameEvents.SendCustomGameEventToServer_custom("request_minimap_icons", {})
})

$.RegisterForUnhandledEvent("StyleClassesChanged", function(panel)
{
	if (!panel || panel.id != "Hud")
		return

	if (!root)
		return

	update_root()
})


function update_minimap_icons(data)
{
	if (!root)
	{
		let block = dotaHud.FindChildTraverse("minimap_block")

		if (!block)
			return

		for (let i = 0; i < block.GetChildCount(); i++)
		{
			let child = block.GetChild(i)

			if (child.id == "CustomMinimapIcons" || child.BHasClass("CustomMinimapIcons"))
				child.DeleteAsync(0)
		}

		root = $.CreatePanel("Panel", block, "")
		root.AddClass("CustomMinimapIcons")
		root.hittest = false
		root.hittestchildren = false
	}

	update_root()

	for (let i = 0; i < root.GetChildCount(); i++)
	{
		root.GetChild(i).visible = false
	}

	if (!data.overview || !data.icons)
		return

	let min_x = Number(data.overview.x)
	let max_y = Number(data.overview.y)
	let size = Number(data.overview.size)

	if (!size)
		return

	for (let id in data.icons)
	{
		let info = data.icons[id]
		let panel = root.FindChild(id)

		if (!panel)
		{
			panel = $.CreatePanel("Panel", root, id)
			panel.style.backgroundSize = "contain"
		}

		let icon_px = info.player != undefined ? base_size : (info.color ? square_size : icon_size)
		let slots = info.slots ? Number(info.slots) : 1
		let shift = (Number(info.slot || 0) - (slots - 1)/2) * base_delta
		let image = info.image

		if (info.player != undefined)
		{
			let player_info = Game.GetPlayerInfo(Number(info.player))
			image = "file://{images}/heroes/icons/" + Game.GetHeroImage(info.player, player_info ? player_info.player_selected_hero : "") + ".png"
		}

		panel.visible = true
		panel.style.width = icon_px + "px"
		panel.style.height = icon_px + "px"
		panel.style.marginLeft = (shift - icon_px/2) + "px"
		panel.style.marginTop = -icon_px/2 + "px"
		panel.style.backgroundImage = image ? 'url("' + image + '")' : "none"
		panel.style.backgroundColor = info.color ? info.color : "none"
		panel.style.border = info.color ? "1px solid #000000" : "0px solid #00000000"
		panel.style.position = ((Number(info.x) - min_x) / size * 100) + "% " + ((max_y - Number(info.y)) / size * 100) + "% 0px"
	}
}


function update_root()
{
	let block = root.GetParent()
	let map = block.FindChildTraverse("minimap")

	if (map && block.actuallayoutwidth > 0 && map.actuallayoutwidth > 0)
	{
		let scale_x = map.actuallayoutwidth / block.actuallayoutwidth
		let scale_y = map.actuallayoutheight / block.actuallayoutheight

		root.style.width = (scale_x * 100) + "%"
		root.style.height = (scale_y * 100) + "%"
		root.style.position = ((1 - scale_x) / 2 * 100) + "% " + ((1 - scale_y) / 2 * 100) + "% 0px"
	}
	else
	{
		root.style.width = "100%"
		root.style.height = "100%"
		root.style.position = "0% 0% 0px"
	}

	root.style.transform = dotaHud.BHasClass("HUDFlipped") ? "scaleX(-1)" : "scaleX(1)"
}