--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--[[ Hero Demo game mode ]]
-- Note: Hero Demo makes use of some mode-specific Dota2 C++ code for its activation from the main Dota2 UI.  Regular custom games can't do this.

OT3Demo = OT3Demo or {}


require("game/demo/events")
require("game/demo/utils")



function OT3Demo:Init(game_mode_entity)
	print("[Demo] init!")
	if self.initialized then return end

	OT3Demo.hero_to_spawn = "npc_dota_hero_axe"
	OT3Demo.DOTA_MAX_ABILITIES = 16


	game_mode_entity:SetTowerBackdoorProtectionEnabled(true)
	game_mode_entity:SetFixedRespawnTime(4.0)
	game_mode_entity:SetDraftingBanningTimeOverride(0.0)

	GameRules:SetUseUniversalShopMode(true)
	GameRules:SetPreGameTime(5.0)
	GameRules:SetCustomGameSetupTimeout(3.0) -- skip the custom team UI with 0, or do indefinite duration with -1
	GameRules:SetSuggestAbilitiesEnabled(true)
	GameRules:SetSuggestItemsEnabled(true)

	Convars:SetInt("sv_cheats", 1)
	Convars:SetInt("dota_easybuy", 0)

	EventDriver:Listen("Events:npc_spawned", OT3Demo.OnNPCSpawned, self)
	EventDriver:Listen("Events:entity_killed", OT3Demo.OnEntityKilled, self)

	-- Events
	ListenToGameEvent("dota_item_purchased", Dynamic_Wrap(OT3Demo, "OnItemPurchased"), self)
	ListenToGameEvent("dota_player_used_ability", Dynamic_Wrap(OT3Demo, "OnAbilityUsed"), self)

	EventStream:Listen("Demo:get_state", self.OnRequestInitialSpawnHeroID, self)

	EventStream:Listen("Demo:refresh_all_players", self.OnRefreshButtonPressed, self)
	EventStream:Listen("Demo:toggle_free_spells", self.OnFreeSpellsButtonPressed, self)

	EventStream:Listen("Demo:set_selected_unit", self.OnSelectSpawnHeroButtonPressed, self)
	EventStream:Listen("Demo:remove_selected", self.OnRemoveSelectedPressed, self)

	EventStream:Listen("Demo:spawn_enemy", self.OnSpawnEnemyButtonPressed, self)
	EventStream:Listen("Demo:spawn_ally", self.OnSpawnAllyButtonPressed, self)
	EventStream:Listen("Demo:spawn_dummy", self.OnDummyTargetButtonPressed, self)
	EventStream:Listen("Demo:spawn_rune", self.OnSpawnRune, self)

	EventStream:Listen("Demo:level_up", self.OnLevelUpHero, self)
	EventStream:Listen("Demo:level_max", self.OnMaxLevelUpHero, self)
	EventStream:Listen("Demo:add_scepter", self.OnScepterHero, self)
	EventStream:Listen("Demo:add_shard", self.OnShardHero, self)
	EventStream:Listen("Demo:reset_hero", self.OnResetHero, self)
	EventStream:Listen("Demo:toggle_invulnerability", self.OnSetInvulnerabilityHero, self)

	EventStream:Listen("Demo:change_hero", self.OnChangeHeroButtonPressed, self)

	EventStream:Listen("Demo:toggle_pause", self.OnPauseButtonPressed, self)
	EventStream:Listen("Demo:leave", self.OnLeaveButtonPressed, self)

	EventStream:Listen("Demo:toggle_towers", self.OnTowersToggled, self)
	EventStream:Listen("Demo:toggle_creeps", self.OnCreepsToggled, self)

	self.demo_player_id = 0
	self.free_spells_enabled = false
	self.invulnerability_enabled = false
	self.ui_init = false

	self.creeps_enabled = true
	self.towers_enabled = true

	self.towers = {}
	self:PrepareTowers()

	self.initialized = true
end


function OT3Demo:PrepareTowers()
	for _, tower in pairs(Entities:FindAllByClassname("npc_dota_tower") or {}) do
		if IsValidEntity(tower) and tower:IsTower() then
			tower:SetUnitCanRespawn(true)
			table.insert(self.towers, tower)
		end
	end
end