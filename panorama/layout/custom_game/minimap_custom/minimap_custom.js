--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GameEvents.Subscribe_custom( "set_map_change_woda", ChangeMapPlayer )

function ChangeMapPlayer(data)
{
	if (Game.GetMapInfo().map_display_name == "arena")
	{
		$.GetContextPanel().visible = false
		$("#OverlayMapWODA").style.visibility = "collapse"
		$("#OverlayMapWODABG").style.visibility = "collapse"
		return
	}
	if (Game.GetMapInfo().map_display_name == "overthrow")
	{
		$.GetContextPanel().visible = false
		$("#OverlayMapWODA").style.visibility = "collapse"
		$("#OverlayMapWODABG").style.visibility = "collapse"
		return
	}

    $.Schedule(1, function()
    {
        let minimap_container = FindDotaHudElement("minimap_container");
        if (minimap_container)
        {
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
        $("#OverlayMapWODA").style.visibility = "visible"
        $("#OverlayMapWODA").fixedoffsetenabled = true;
        $("#OverlayMapWODA").minheightgroupbrightness = 1;
    })
	
	if (data)
	{
		$("#OverlayMapWODA").SetFixedOffset(data.x, data.y);
	}
}

GameEvents.Subscribe_custom( "set_map_hidden_wisp", set_map_hidden_wisp )

function set_map_hidden_wisp(data)
{
	if (Game.GetMapInfo().map_display_name == "arena")
	{
		$.GetContextPanel().visible = false
		$("#OverlayMapWODA").style.visibility = "collapse"
		$("#OverlayMapWODABG").style.visibility = "collapse"
		return
	}
	if (Game.GetMapInfo().map_display_name == "overthrow")
	{
		$.GetContextPanel().visible = false
		$("#OverlayMapWODA").style.visibility = "collapse"
		$("#OverlayMapWODABG").style.visibility = "collapse"
		return
	}
	for (var i = 0; i < $("#OverlayMapWODA").GetChildCount(); i++) 
	{
        let panel = $("#OverlayMapWODA").GetChild(i)
        if (panel && panel.paneltype == "DOTAHeroImage")
        {
        	panel.style.opacity = String(data.visible)
        }
    } 	
}

function SetMinimapReconnect()
{
	if (Game.GetMapInfo().map_display_name == "arena")
	{
		$.GetContextPanel().visible = false
		$("#OverlayMapWODA").style.visibility = "collapse"
		$("#OverlayMapWODABG").style.visibility = "collapse"
		return
	}
	if (Game.GetMapInfo().map_display_name == "overthrow")
	{
		$.GetContextPanel().visible = false
		$("#OverlayMapWODA").style.visibility = "collapse"
		$("#OverlayMapWODABG").style.visibility = "collapse"
		return
	}
	let data = CustomNetTables.GetTableValue("map_info", "map_coord")
	if (data && data.x && data.y)
	{
		let minimap_container = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements").FindChildTraverse("minimap_container");
		if (minimap_container)
		{
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
		$("#OverlayMapWODABG").style.visibility = "visible"
		$("#OverlayMapWODA").style.visibility = "visible"
		$("#OverlayMapWODA").fixedoffsetenabled = true;
		$("#OverlayMapWODA").SetFixedOffset(data.x, data.y);
        $("#OverlayMapWODA").minheightgroupbrightness = 1;
	}
} 

$.Schedule(1, function() 
{
    SetMinimapReconnect()
})