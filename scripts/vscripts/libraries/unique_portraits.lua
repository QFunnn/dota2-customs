--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


UniquePortraits = UniquePortraits or class({})

-- Depricated
--local hash_styles_table = {
--	[1977497166] = 0,
--	[1055040020] = 0,
--	[676911571] = 0,
--	[628863847] = 1,
--	[392129534] = 1,
--	[1347516877] = 2,
--}

PORTRAITS_BY_STYLES = {
	["models/items/windrunner/windrunner_arcana/wr_arcana_base.vmdl"] = {
		["default"] = "npc_dota_hero_windrunner_alt1",
		["1"] = "npc_dota_hero_windrunner_alt2",
	},
	["models/items/pudge/arcana/pudge_arcana_base.vmdl"] = {
		["1"] = "npc_dota_hero_pudge_alt1",
		["2"] = "npc_dota_hero_pudge_alt2",
	},
	["models/items/earthshaker/earthshaker_arcana/earthshaker_arcana.vmdl"] = {
		["01"] = "npc_dota_hero_earthshaker_alt1",
		["02"] = "npc_dota_hero_earthshaker_alt2",
	},
	["models/items/wraith_king/arcana/wraith_king_arcana.vmdl"] = {
		["default"] = "npc_dota_hero_skeleton_king_alt1",
		["1"] = "npc_dota_hero_skeleton_king_alt2",
	},
	["models/heroes/juggernaut/juggernaut_arcana.vmdl"] = {
		["0"] = "npc_dota_hero_juggernaut_alt1",
		["1"] = "npc_dota_hero_juggernaut_alt2",
	},
	["models/heroes/lina/lina.vmdl"] = {
		["1"] = "npc_dota_hero_lina_alt1",
	},
	["models/items/ogre_magi/ogre_arcana/ogre_magi_arcana.vmdl"] = {
		["0"] = "npc_dota_hero_ogre_magi_alt1",
		["1"] = "npc_dota_hero_ogre_magi_alt2",
	},
	["models/items/queenofpain/queenofpain_arcana/queenofpain_arcana.vmdl"] = {
		["default"] = "npc_dota_hero_queenofpain_alt1",
		["1"] = "npc_dota_hero_queenofpain_alt2",
	},
	["models/heroes/legion_commander/legion_commander.vmdl"] = {
		["1"] = "npc_dota_hero_legion_commander_alt1",
	},
	["models/items/spectre/spectre_arcana/spectre_arcana_base.vmdl"] = {
		["default"] = "npc_dota_hero_spectre_alt1",
		["1"] = "npc_dota_hero_spectre_alt2",
	},
	["models/items/faceless_void/faceless_void_arcana/faceless_void_arcana_base.vmdl"] = {
		["default"] = "npc_dota_hero_faceless_void_alt1",
		["1"] = "npc_dota_hero_faceless_void_alt2",
	},
	["models/items/razor/razor_arcana/razor_arcana.vmdl"] = {
		["default"] = "npc_dota_hero_razor_alt1",
		["2"] = "npc_dota_hero_razor_alt2",
	},
	["models/items/drow/drow_arcana/drow_arcana.vmdl"] = {
		["default"] = "npc_dota_hero_drow_ranger_alt1",
		["1"] = "npc_dota_hero_drow_ranger_alt2",
	},
	["models/items/vengefulspirit/vengeful_spirit_arcana/vengeful_spirit_arcana.vmdl"] = {
		["default"] = "npc_dota_hero_vengefulspirit_alt1",
		["1"] = "npc_dota_hero_vengefulspirit_alt2",
	},
	["models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl"] = {
		["default"] = "npc_dota_hero_skywrath_mage_alt1",
		["1"] = "npc_dota_hero_skywrath_mage_alt2",
	},
	["models/heroes/pudge_cute/pudge_cute.vmdl"] = "npc_dota_hero_pudge_persona1",
	["models/heroes/antimage_female/antimage_female.vmdl"] = "npc_dota_hero_antimage_persona1",
	["models/items/antimage_female/mh_antimage_kirin/antimage_female_kirin.vmdl"] = "npc_dota_hero_antimage_persona1",
	["models/heroes/invoker_kid/invoker_kid.vmdl"] = "npc_dota_hero_invoker_persona1",
	["models/items/axe/ti9_jungle_axe/axe_bare.vmdl"] = "npc_dota_hero_axe_alt",
	["models/heroes/phantom_assassin/pa_arcana.vmdl"] = "npc_dota_hero_phantom_assassin_alt1",
	["models/heroes/shadow_fiend/shadow_fiend_arcana.vmdl"] = "npc_dota_hero_nevermore_alt1",
	["models/heroes/terrorblade/terrorblade_arcana.vmdl"] = "npc_dota_hero_terrorblade_alt1",
	["models/heroes/crystal_maiden/crystal_maiden_arcana.vmdl"] = "npc_dota_hero_crystal_maiden_alt1",
	["models/items/monkey_king/monkey_king_arcana_head/mesh/monkey_king_arcana.vmdl"] = "npc_dota_hero_monkey_king_alt1",
	["models/items/rubick/rubick_arcana/rubick_arcana_base.vmdl"] = "npc_dota_hero_rubick_alt",
	["models/items/techies/bigshot/bigshot.vmdl"] = "npc_dota_hero_techies_alt1",
	["models/heroes/zeus/zeus_arcana.vmdl"] = "npc_dota_hero_zuus_alt1",
	["models/heroes/dragon_knight_persona/dk_persona_base.vmdl"] = "npc_dota_hero_dragon_knight_persona1",
	["models/items/io/io_ti7/io_ti7.vmdl"] = "npc_dota_hero_wisp_alt",
	["models/heroes/phantom_assassin_persona/phantom_assassin_persona.vmdl"] = "npc_dota_hero_phantom_assassin_persona1",
	["models/heroes/crystal_maiden_persona/crystal_maiden_persona.vmdl"] = "npc_dota_hero_crystal_maiden_persona1",
	["models/heroes/mirana_persona/mirana_persona_base.vmdl"] = "npc_dota_hero_mirana_persona1",
	["models/items/vengefulspirit/imperia/imperia.vmdl"] = "npc_dota_hero_vengefulspirit_alt3",

	-- Crutches because with this set noone model has any material diff from default WR
	["models/items/windrunner/mh_windrunner_zinogre/mh_windrunner_zinogre_shoulder_refit.vmdl"] = "npc_dota_hero_windrunner_alt1",
	["models/items/windrunner/mh_windrunner_zinogre/mh_windrunner_zinogre_shoulder_refit_rainbow.vmdl"] = "npc_dota_hero_windrunner_alt1",
	["models/items/windrunner/windrunner_arcana/wr_arcana_zinogre_mail.vmdl"] = "npc_dota_hero_windrunner_alt1",
}

function UniquePortraits:Init()
	self.portraitsData = {}
	self.players_checked = {}
	CustomNetTables:SetTableValue("game_state", "portraits", self.portraitsData)

	ListenToGameEvent("npc_spawned", Dynamic_Wrap(UniquePortraits, "OnNPCSpawned"), self)
end

function UniquePortraits:OnNPCSpawned(data)
	local spawned_unit = EntIndexToHScript(data.entindex)
	if not spawned_unit or not spawned_unit.GetPlayerOwnerID then return end
	if not spawned_unit:IsRealHero() then return end

	local player_id = spawned_unit:GetPlayerOwnerID()
	if not player_id or not IsValidPlayerID(player_id) then return end
	if self.players_checked[player_id] then return end

	Timers:CreateTimer(1, function()
		UniquePortraits:UpdatePortraitsDataFromPlayer(player_id)
	end)
end

CACHED_PORTRAITS = {}

function UniquePortraits:GetPortraitByMaterialHash(model_name, material_hash)
	local cosmetic_model_check = CreateUnitByName("cosmetic_model_check", Vector(0, 0, 0), false, nil, nil, DOTA_TEAM_NEUTRALS)

	cosmetic_model_check:SetModel(model_name)
	cosmetic_model_check:SetOriginalModel(model_name)

	for material_name, portrait_name in pairs(PORTRAITS_BY_STYLES[model_name]) do
		cosmetic_model_check:SetMaterialGroup(material_name)

		if (cosmetic_model_check:GetMaterialGroupHash() == material_hash) then
			cosmetic_model_check:RemoveSelf()
			return portrait_name
		end
	end

	cosmetic_model_check:RemoveSelf()
end

function UniquePortraits:UpdatePortraitsDataFromPlayer(player_id)
	local hero = PlayerResource:GetSelectedHeroEntity(player_id)
	if hero then
		self.players_checked[player_id] = true

		local models = {}
		local model = hero:FirstMoveChild()
		local baseModel = hero:GetRootMoveParent()

		if baseModel then
			table.insert(models, { modelName = baseModel:GetModelName(), material_hash = baseModel:GetMaterialGroupHash() })
		end
		while model ~= nil do
			if model:GetClassname() == "dota_item_wearable" or model:GetClassname() == "prop_dynamic" or model:GetClassname() == "additional_wearable" then
				table.insert(models, { modelName = model:GetModelName(), material_hash = model:GetMaterialGroupHash() })
			end
			model = model:NextMovePeer()
		end

		for _, check_model in pairs(models) do
			local portrait_data = PORTRAITS_BY_STYLES[check_model.modelName]

			if portrait_data then
				local unique_icon
				if (type(portrait_data) == 'table') then
					unique_icon = UniquePortraits:GetPortraitByMaterialHash(check_model.modelName, check_model.material_hash)
				elseif (type(portrait_data) == 'string') then
					unique_icon = portrait_data
				end
				if unique_icon then
					self.portraitsData[hero:GetUnitName() .. player_id] = unique_icon
				end
			end
		end
		CustomNetTables:SetTableValue("game_state", "portraits", self.portraitsData)
	else
		Timers:CreateTimer(1, function()
			self:UpdatePortraitsDataFromPlayer(player_id)
		end)
	end
end

UniquePortraits:Init()