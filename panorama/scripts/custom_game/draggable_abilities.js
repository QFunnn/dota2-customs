--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var state = false;
var abilities_panel;
var player_hero;
var draggable_delimiter;
var reorder_active_overlay;
var overlay_base;
var DRAG_OFFSET = 10;
var REORDER_HEADER_OFFSET = 60;

const reorder_types = Object.freeze({
	after: 1,
	before: 2,
});

function GetCoverPanel(ability_cover_name) {
	let cover_panel = $("#" + ability_cover_name);
	if (!cover_panel) {
		cover_panel = $.CreatePanel("Panel", $.GetContextPanel(), ability_cover_name);
		cover_panel.SetHasClass("Cover", true);
		cover_panel.BLoadLayoutSnippet("draggable_overlay");
		cover_panel.SetAcceptsFocus(false);
		cover_panel.SetDisableFocusOnMouseDown(true);
		$.RegisterEventHandler("DragStart", cover_panel, OnDragStart);
		$.RegisterEventHandler("DragEnd", cover_panel, OnDragEnd)
	}
	cover_panel.visible = state;
	cover_panel.SetDraggable(state);
	return cover_panel;
}

function SetPositionFromPanel(target, src, offset_x = 0, offset_y = 0) {
	let initial_position = src.GetPositionWithinWindow();

	let x_pos = initial_position.x / src.actualuiscale_x + offset_x;
	let y_pos = initial_position.y / src.actualuiscale_y + offset_y;
	target.style.position = `${x_pos}px ${y_pos}px 0px`;
}

function RebuildCovers(keys) {

    if (keys!=undefined && keys.swap_ui_secret!=undefined)
    {
       $("#drag_desc_container").swap_ui_secret = keys.swap_ui_secret
    }

	//$.Msg(_GetVisibleChilds(abilities_panel.Children()))
	$.Each(_GetVisibleChilds(abilities_panel.Children()), function (child, index) {
		let ability_cover_name = child.id;
		let cover_panel = GetCoverPanel(ability_cover_name);

		let ability_button = _GetAbilityButton(child);
		//$.Msg(cover_panel)
		cover_panel.style.width = ability_button.actuallayoutwidth / child.actualuiscale_x + "px";
		cover_panel.style.height = ability_button.actuallayoutheight / child.actualuiscale_y + "px";
		SetPositionFromPanel(cover_panel, ability_button);

		child.ability_params = _GetAbilityParams(child);
	});

	SetPositionFromPanel(
		reorder_active_overlay,
		overlay_base,
		REORDER_HEADER_OFFSET,
		overlay_base.actuallayoutheight / 4 + 4,
	);
	reorder_active_overlay.style.width =
		overlay_base.actuallayoutwidth / overlay_base.actualuiscale_x - REORDER_HEADER_OFFSET + "px";
	reorder_active_overlay.style.height = overlay_base.actuallayoutheight / 4 / overlay_base.actualuiscale_y + "px";
}

function _GetAbilityButton(ability_panel) {
	if (!ability_panel) {
		return;
	}
	return ability_panel.FindChildTraverse("AbilityButton")
}

function _GetAbilityParams(ability_panel) {
	let ability_image = _GetAbilityButton(ability_panel).GetChild(0);
	return {
		index: ability_image.contextEntityIndex,
		name: ability_image.abilityname,
		id: ability_image.abilityid,
	};
}

function _GetVisibleChilds(children) {
	return children.filter((panel) => !panel.BHasClass("Hidden"));
}

function CancelDraggablePositionUpdater() {
	draggable_delimiter.visible = false;
}

function UpdateDraggablePosition() {
	let position = GameUI.GetCursorPosition();
	let children = _GetVisibleChilds(abilities_panel.Children());
	let updated = false;
	for (var i = 0; i < children.length; i++) {
		if (children[i].GetPositionWithinWindow().x + children[i].actuallayoutwidth / 2 > position[0]) {
			SetPositionFromPanel(draggable_delimiter, _GetAbilityButton(children[i]), -2);
			updated = true;
			break;
		}
	}
	if (!updated) {
		let last = children[children.length - 1];
		SetPositionFromPanel(draggable_delimiter, _GetAbilityButton(last), last.actuallayoutwidth + 2);
	}

	if (state) {
		$.Schedule(0.1, UpdateDraggablePosition);
	}
}

function OnDragStart(panel, drag_callbacks) {
	let child = abilities_panel.FindChild(panel.id);
	if (!child.ability_params) {
		child.ability_params = _GetAbilityParams(child);
	}
	let ability_image = $.CreatePanel("DOTAAbilityImage", $.GetContextPanel(), panel.id);
	ability_image.style.width = `${panel.actuallayoutwidth}px`;
	ability_image.style.height = `${panel.actuallayoutheight}px`;
	ability_image.abilityname = child.ability_params.name;

	drag_callbacks.displayPanel = ability_image;
	drag_callbacks.offsetX = panel.actuallayoutwidth / 2 - DRAG_OFFSET;
	drag_callbacks.offsetY = panel.actuallayoutheight / 2 - DRAG_OFFSET;

	//child.SetHasClass("Hidden", true);
	$.GetContextPanel().SetHasClass("Dragging", true);
	CancelDraggablePositionUpdater();
	draggable_delimiter.visible = true;
	UpdateDraggablePosition();
	return true;
}

function OnDragEnd(data, displayed) {
	let position = GameUI.GetCursorPosition();
	let dragged_panel = abilities_panel.FindChild(data.id);
	let children = _GetVisibleChilds(abilities_panel.Children());
	let swapped = false;
	let event_table = {
		moved_ability: dragged_panel.ability_params.name,
		swap_ui_secret: $("#drag_desc_container").swap_ui_secret
	};
	CancelDraggablePositionUpdater();
	//dragged_panel.SetHasClass("Hidden", false);
	$.GetContextPanel().SetHasClass("Dragging", false);
	data.SetParent($.GetContextPanel());
	displayed.DeleteAsync(0);
	if (!state) {
		return;
	}
	for (var i = 0; i < children.length; i++) {
		if (children[i].GetPositionWithinWindow().x + children[i].actuallayoutwidth / 2 > position[0]) {
			swapped = true;
			event_table.reorder_type = reorder_types.before;
			event_table.ref_ability = children[i].ability_params.name;
			break;
		}
	}
	if (!swapped) {
		let last = children[children.length - 1];
		event_table.reorder_type = reorder_types.after;
		if (!last.ability_params) {
			last.ability_params = _GetAbilityParams(last);
		}
		event_table.ref_ability = last.ability_params.name;
	}
	GameEvents.SendCustomGameEventToServer("ReorderComplete", event_table);
	//$.Msg(event_table)
	return true;
}

function SetDraggableEvents(state, child, index) {
	if (child.BHasClass("Hidden")) {
		return;
	}
	let ability_cover_name = child.id;
	let cover_panel = GetCoverPanel(ability_cover_name);

	let ability_button = _GetAbilityButton(child);
	cover_panel.style.width = ability_button.actuallayoutwidth / child.actualuiscale_x + "px";
	cover_panel.style.height = ability_button.actuallayoutheight / child.actualuiscale_y + "px";

	if (!state) {
		return;
	}
	if (child.events_set) {
		return;
	}
	child.ability_params = _GetAbilityParams(child);

	// more hacking to align covers properly
	let initial_position = ability_button.GetPositionWithinWindow();
	cover_panel.style.position = `${initial_position.x / child.actualuiscale_x}px ${
		initial_position.y / child.actualuiscale_y
	}px 0px`;

	child.transitionProperty = "position";
	child.transitionDuration = "0.1s";

	child.events_set = true;
}

function ToggleAbilitiesReorder(data) {
	if (!data || data.state == undefined) {
		state = !state;
	} else {
		state = data.state;
	}
	if (!abilities_panel) {
		return;
	}
	if (!state) {
		CancelDraggablePositionUpdater();
	}
	player_hero = Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer());
	let unit = Players.GetLocalPlayerPortraitUnit();

	reorder_active_overlay.visible = state;

	if (player_hero != unit) {
		return;
	}
	$.Each(abilities_panel.Children(), function (child, index) {
		SetDraggableEvents(state, child, index);
	});
	RebuildCovers();
	GameEvents.SendCustomGameEventToServer("reorder:toggle_serverside", { state: state });
}

(function () {
	abilities_panel = FindDotaHudElement("abilities");
	overlay_base = FindDotaHudElement("AbilitiesAndStatBranch");

	draggable_delimiter = $.CreatePanel("Panel", $.GetContextPanel(), "DraggableDelimiter");
	draggable_delimiter.visible = false;

	reorder_active_overlay = $("#drag_desc_container");
	reorder_active_overlay.visible = false;

	GameEvents.Subscribe("ReorderToggle", ToggleAbilitiesReorder);
	GameEvents.Subscribe("ReorderInterrupt", (data) => {

		if(reorder_active_overlay.visible)
		{
			$.Schedule(0.1, () => {
				GameEvents.SendEventClientSide("dota_hud_error_message", {
					splitscreenplayer: 0,
					reason: 80,
					message: "#reorder_interrupted",
				});
			});
		}
		ToggleAbilitiesReorder(data);
	});

	GameEvents.Subscribe("RefreshAbilityOrder", RebuildCovers);
	CreateKeyCommand("F8",ToggleAbilitiesReorder)

})();