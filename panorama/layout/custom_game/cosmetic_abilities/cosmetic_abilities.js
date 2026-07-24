--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const cosmeticAbilityOverrideImages = {
	high_five_custom: "file://{images}/spellicons/consumables/high_five.png",
	seasonal_ti9_banner: "file://{images}/spellicons/consumables/seasonal_ti9_banner_2.png",
};

let dummyCaster = -1;
let currentAbilityName;
let currentSprayName;

function CastAbilityByDummy(abilityName) {
	if (dummyCaster > -1) {
		let ability;
		for (let i = 0; i < Entities.GetAbilityCount(dummyCaster); i++) {
			if (Entities.GetAbility(dummyCaster, i) > -1) {
				const _ability = Entities.GetAbility(dummyCaster, i);
				const _abilityName = Abilities.GetAbilityName(_ability);
				if (_abilityName == abilityName) ability = _ability;
			}
		}
		if (ability) {
			if (!Abilities.IsCooldownReady(ability)) {
				GameEvents.SendEventClientSide("dota_hud_error_message", {
					splitscreenplayer: 0,
					reason: 80,
					message: "dota_cursor_cooldown_no_time",
				});
			} else {
				const oldSelectedUnit = Players.GetSelectedEntities(Game.GetLocalPlayerID());
				GameUI.SelectUnit(dummyCaster, false);
				Abilities.ExecuteAbility(ability, dummyCaster, false);
				oldSelectedUnit.forEach((ent, index) => {
					GameUI.SelectUnit(ent, index != 0);
				});
			}
		}
	}
}

function UpdateCosmeticSpray(keys) {
	const sprayPanel = FindDotaHudElement("CosmeticSprayPanel");
	if (keys.item_name) {
		sprayPanel.SetHasClass("Hidden", false)
	}
	else {
		sprayPanel.SetHasClass("Hidden", true)
	}
	currentSprayName = keys.item_name

	sprayPanel.SetPanelEvent("onmouseover", () => {
		$.DispatchEvent("DOTAShowAbilityTooltip", sprayPanel, "spray_tooltip");
	});
	sprayPanel.SetPanelEvent("onmouseout", () => {
		$.DispatchEvent("DOTAHideAbilityTooltip", sprayPanel);
	});

	sprayPanel.cooldownEffect.style["opacity-mask"] = "url( 'file://{images}/custom_game/econ/spray_no_empty.png' )";
	sprayPanel.FindChildTraverse("CosmeticAbilityImage").SetImage("file://{images}/custom_game/econ/spray_no_empty.png");
	sprayPanel.SetPanelEvent("onactivate", () => {

		// var pageTaunt = FindDotaHudElement("page_taunt");
		if (sprayPanel != undefined && sprayPanel != null && sprayPanel.tauntCooldown <= 0) {
			//冷却设置成最大
			sprayPanel.tauntCooldown = 80;
			GameEvents.SendCustomGameEventToServer('ActiveTaunt', { itemName: keys.item_name })
		} else {
			GameEvents.SendEventClientSide("dota_hud_error_message", {
				splitscreenplayer: 0,
				reason: 80,
				message: "dota_cursor_cooldown_no_time",
			});
		}

	});
}

function UpdateCosmeticAbility(keys) {

	let abilityPanel = FindDotaHudElement("CosmeticAbilityPanel")
	if (keys.ability_name) {
		abilityPanel.SetHasClass("Hidden", false)
	}
	else {
		abilityPanel.SetHasClass("Hidden", true)
	}
	CreateCustomAbility(abilityPanel, keys.ability_name);
}

function CreateCustomAbility(ability, abilityName) {
	const image_path = cosmeticAbilityOverrideImages[abilityName] || "file://{images}/spellicons/consumables/" + abilityName + ".png";
	ability.cooldownEffect.style["opacity-mask"] = "url( '" + image_path + "' )";
	ability.FindChildTraverse("CosmeticAbilityImage").SetImage(image_path);
	//记录下最近的技能
	currentAbilityName = abilityName
	ability.SetPanelEvent("onmouseover", () => {
		$.DispatchEvent("DOTAShowAbilityTooltip", ability, abilityName);
	});
	ability.SetPanelEvent("onmouseout", () => {
		$.DispatchEvent("DOTAHideAbilityTooltip", ability);
	});

	ability.SetPanelEvent("onactivate", () => {
		CastAbilityByDummy(abilityName);
	});

}
function UpdateAbilitiesCooldown() {

	if (dummyCaster != -1 && currentAbilityName != undefined) {
		let ability = Entities.GetAbilityByName(dummyCaster, currentAbilityName)
		const abilityPanel = FindDotaHudElement("CosmeticAbilityPanel");
		if (abilityPanel != undefined) {
			if (!Abilities.IsCooldownReady(ability)) {
				if (abilityPanel.maxCooldown == null) {
					abilityPanel.maxCooldown = Abilities.GetCooldownLength(ability);
				}
				const remaining = Abilities.GetCooldownTimeRemaining(ability);
				const progress = (remaining / abilityPanel.maxCooldown) * -360;
				abilityPanel.cooldownRoot.visible = true;
				abilityPanel.cooldownEffect.style.clip = "radial( 50% 75%, 0deg, " + progress + "deg )";
				abilityPanel.cooldownValue.text = Math.ceil(remaining);
			} else {
				abilityPanel.maxCooldown = null;
				abilityPanel.cooldownRoot.visible = false;
			}
		}
	}

	if (currentSprayName != undefined) {
		const sprayPanel = FindDotaHudElement("CosmeticSprayPanel");
		if (sprayPanel != null && sprayPanel != undefined) {
			// var pageTaunt = FindDotaHudElement("page_taunt");
			// if (pageTaunt != null) {
			sprayPanel.tauntCooldown = (sprayPanel.tauntCooldown ?? 0) - 0.1
			if (sprayPanel.tauntCooldown > 0.05) {
				const progress = (sprayPanel.tauntCooldown / 80) * -360;
				sprayPanel.cooldownRoot.visible = true;
				sprayPanel.cooldownEffect.style.clip = "radial( 50% 75%, 0deg, " + progress + "deg )";
				sprayPanel.cooldownValue.text = Math.ceil(sprayPanel.tauntCooldown);
			} else {
				sprayPanel.cooldownRoot.visible = false;
			}
			// }
		}
	}

	$.Schedule(0.1, () => {
		UpdateAbilitiesCooldown();
	});
}

function UpdateCosmeticsDummyIndex(keys) {
	dummyCaster = keys.entity_index;
}

function UpdateCosmeticTaunt(keys) {

	if (keys.playerId == Players.GetLocalPlayer()) {
		let tauntPanel = FindDotaHudElement("CosmeticTauntPanel")

		//8632为未装备嘲讽的占位物品
		if (keys.itemDef && keys.itemDef != 8632) {
			tauntPanel.SetHasClass("Hidden", false);
			tauntPanel.SetPanelEvent("onmouseover", () => {
				$.DispatchEvent("DOTAShowAbilityTooltip", tauntPanel, "taunt_tooltip");
			});
			tauntPanel.SetPanelEvent("onmouseout", () => {
				$.DispatchEvent("DOTAHideAbilityTooltip", tauntPanel);
			});

			tauntPanel.cooldownRoot.visible = false;

			tauntPanel.FindChildTraverse("CosmeticAbilityImage").SetImage("file://{images}/custom_game/econ/taunt.png");

			tauntPanel.SetPanelEvent("onactivate", () => {
				GameEvents.SendCustomGameEventToServer("Taunt", {});
			});
		}
		else {
			tauntPanel.SetHasClass("Hidden", true)
		}

	}
}


(function () {

	const centerBlock = FindDotaHudElement("center_block");
	let cosmetics = centerBlock.FindChildTraverse("BarOverItems");

	if (cosmetics) {
		cosmetics.DeleteAsync(0);
	}

	let barOverItemsOverride = centerBlock.FindChildTraverse("BarOverItemsOverride");
	if (barOverItemsOverride) {
		barOverItemsOverride.RemoveAndDeleteChildren()
	}

	const tauntPanel = $.CreatePanel("Button", FindDotaHudElement("BarOverItemsOverride"), "CosmeticTauntPanel");
	tauntPanel.BLoadLayoutSnippet("CosmeticAbility");
	tauntPanel.cooldownEffect = tauntPanel.FindChildTraverse("CooldownEffect");
	tauntPanel.cooldownValue = tauntPanel.FindChildTraverse("CooldownValue");
	tauntPanel.cooldownRoot = tauntPanel.FindChildTraverse("CooldownRoot");
	tauntPanel.AddClass("Hidden")

	const cosmeticAbility = $.CreatePanel("Button", FindDotaHudElement("BarOverItemsOverride"), "CosmeticAbilityPanel");
	cosmeticAbility.BLoadLayoutSnippet("CosmeticAbility");
	cosmeticAbility.cooldownEffect = cosmeticAbility.FindChildTraverse("CooldownEffect");
	cosmeticAbility.cooldownValue = cosmeticAbility.FindChildTraverse("CooldownValue");
	cosmeticAbility.cooldownRoot = cosmeticAbility.FindChildTraverse("CooldownRoot");
	cosmeticAbility.AddClass("Hidden")

	const sprayPanel = $.CreatePanel("Button", FindDotaHudElement("BarOverItemsOverride"), "CosmeticSprayPanel");
	sprayPanel.BLoadLayoutSnippet("CosmeticAbility");
	sprayPanel.cooldownEffect = sprayPanel.FindChildTraverse("CooldownEffect");
	sprayPanel.cooldownValue = sprayPanel.FindChildTraverse("CooldownValue");
	sprayPanel.cooldownRoot = sprayPanel.FindChildTraverse("CooldownRoot");
	sprayPanel.currentRemaining = -1
	sprayPanel.AddClass("Hidden")

	if (!cosmetics) {
		$("#BarOverItemsOverride").SetParent(centerBlock);
	}

	function updatebuffstyle() {
		$.Schedule(0.5, updatebuffstyle)
		let buff_basic_style = "translateY( -43px )"
		let right_minimap = Game.IsHUDFlipped()
		if (right_minimap) {
			buff_basic_style = buff_basic_style + " ScaleX(-1)"
		}

		FindDotaHudElement("buffs").style.transform = buff_basic_style;
		FindDotaHudElement("debuffs").style.transform = buff_basic_style;
	}

	updatebuffstyle()

	GameEvents.Subscribe("UpdateCosmeticTaunt", UpdateCosmeticTaunt);
	GameEvents.Subscribe("UpdateCosmeticAbility", UpdateCosmeticAbility);
	GameEvents.Subscribe("UpdateCosmeticSpray", UpdateCosmeticSpray);
	GameEvents.Subscribe("UpdateCosmeticsDummyIndex", UpdateCosmeticsDummyIndex);

	//更新面板CD
	UpdateAbilitiesCooldown()

})();