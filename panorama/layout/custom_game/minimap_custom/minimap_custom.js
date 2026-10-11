--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


GameEvents.Subscribe_custom( "set_map_change_woda", ChangeMapPlayer )

function IsArenaMapWODA()
{
	return /^(arena|1_player|4_player)$/.test(Game.GetMapInfo().map_display_name)
}

function IsOverlayMapDisabled()
{
	return Game.GetMapInfo().map_display_name == "overthrow"
}

function GetOverlayMapWODA()
{
	var arena = IsArenaMapWODA()
	$("#OverlayMapWODA").style.visibility = arena ? "collapse" : "visible"
	$("#OverlayMapWODAArena").style.visibility = arena ? "visible" : "collapse"
	return arena ? $("#OverlayMapWODAArena") : $("#OverlayMapWODA")
}

function HideOverlayMapWODA()
{
	$.GetContextPanel().visible = false
	$("#OverlayMapWODA").style.visibility = "collapse"
	$("#OverlayMapWODAArena").style.visibility = "collapse"
	$("#OverlayMapWODABG").style.visibility = "collapse"
}

function ApplyMinimapBlockStyle(minimap_container)
{
	if (!minimap_container) { return }
	let minimap_block = minimap_container.FindChildTraverse("minimap_block")
	if (minimap_block)
	{
		minimap_block.style.backgroundImage = "url('file://{images}/custom_game/talents/map_bg.png')"
		minimap_block.hittest = true
		let minimap_bgs = minimap_container.FindChildTraverse("minimap_bgs")
		if (minimap_bgs)
		{
			minimap_bgs.style.opacity = "0"
		}
		minimap_block.style.opacity = "0"
	}
}

function ChangeMapPlayer(data)
{
	if (IsOverlayMapDisabled())
	{
		HideOverlayMapWODA()
		return
	} 

    $.Schedule(1, function()
    {
        ApplyMinimapBlockStyle(FindDotaHudElement("minimap_container"))
        let map = GetOverlayMapWODA()
        map.fixedoffsetenabled = true;
        map.minheightgroupbrightness = 1;
    })
 
	if (data)
	{
		let map_now = GetOverlayMapWODA()
		map_now.fixedoffsetenabled = true;
		map_now.minheightgroupbrightness = 1;
		map_now.SetFixedOffset(data.x, data.y);
	}
} 

GameEvents.Subscribe_custom( "set_map_hidden_wisp", set_map_hidden_wisp )

function set_map_hidden_wisp(data)
{
	if (IsOverlayMapDisabled())
	{
		HideOverlayMapWODA()
		return
	}
	let map = GetOverlayMapWODA()
	for (var i = 0; i < map.GetChildCount(); i++)
	{
        let panel = map.GetChild(i)
        if (panel && panel.paneltype == "DOTAHeroImage")
        {
        	panel.style.opacity = String(data.visible)
        }
    } 
}

function SetMinimapReconnect()
{
	if (IsOverlayMapDisabled())
	{
		HideOverlayMapWODA()
		return
	}
	let data = CustomNetTables.GetTableValue("map_info", "map_coord")
	if (data && data.x && data.y)
	{
		let minimap_container = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements").FindChildTraverse("minimap_container");
		ApplyMinimapBlockStyle(minimap_container)
		$("#OverlayMapWODABG").style.visibility = "visible"
		let map = GetOverlayMapWODA()
		map.fixedoffsetenabled = true;
		map.SetFixedOffset(data.x, data.y);
        map.minheightgroupbrightness = 1;
	}
} 

$.Schedule(1, function()
{
    SetMinimapReconnect()
})