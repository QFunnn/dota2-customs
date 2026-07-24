--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


chen_soul_persuasion = chen_soul_persuasion or class({})

LinkLuaModifier("chen_soul_persuasion_passive", "abilities/heroes/chen/chen_soul_persuasion", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_chen_holy_persuasion_lua", "abilities/heroes/chen/chen_soul_persuasion", LUA_MODIFIER_MOTION_NONE)

local souls_modifier_name = "chen_soul_persuasion_passive"


function chen_soul_persuasion:Spawn()
	if IsServer() then
		self.summon_list = {}
		self.martyrdom_cooldown_end = 0
	end
end


function chen_soul_persuasion:GetIntrinsicModifierName()
	return souls_modifier_name
end


-- function chen_soul_persuasion:OnItemEquipped(item)
-- 	local caster = self:GetCaster()

-- 	if not caster:HasScepter() then return end

-- 	self:ValidateCurrentSummons()
-- 	for _, unit in pairs(self.summon_list or {}) do
-- 		if not unit:HasAbility("chen_martyrdom") then
-- 			self:AddMartyrdom(unit)
-- 		end
-- 	end
-- end


function chen_soul_persuasion:GetManaCost(iLevel)
	if self:GetLevel() == 0 then return end
	local stacks = self:GetCaster():GetModifierStackCount("chen_soul_persuasion_passive", nil)
	local summon_level = self:CheckSummonLevel(stacks)
	return self:GetLevelSpecialValueFor("summon_mana_cost", math.max(summon_level - 1, 0))
end


function chen_soul_persuasion:CastFilterResult()
	local parent = self:GetCaster()
	local soul_count = parent:GetModifierStackCount(souls_modifier_name, parent)
	local summon_souls = self:CheckSummonType(soul_count)

	if summon_souls == 0 then
		return UF_FAIL_CUSTOM
	end

	return UF_SUCCESS
end


function chen_soul_persuasion:GetCustomCastError()
	return "#dota_chen_soul_persuasion_not_enough_souls"
end


function chen_soul_persuasion:OnSpellStart()
	if not IsServer() then return end

	local parent = self:GetCaster()
	local soul_count = parent:GetModifierStackCount(souls_modifier_name, parent)
	local summon_souls = self:CheckSummonType(soul_count)

	if summon_souls == 0 then
		self:EndCooldown()
		return
	end

	local summon_max = self:GetSpecialValueFor("creeps_max_summoned")
	self:ValidateCurrentSummons()

	if not self.summon_list then self.summon_list = {} end

	if #self.summon_list >= summon_max then
		local unit = table.remove(self.summon_list, 1)
		unit:ForceKill(false)
	end

	local current_data = self.ability_data[summon_souls]

	local modifier = parent:FindModifierByName(souls_modifier_name)
	modifier:SpendSouls(summon_souls)

	local creep_count = math.min(self:GetSpecialValueFor("summon_count"), summon_max - #self.summon_list)

	for _ = 1, creep_count do
		self:CreateCreep(current_data.creeps)
	end
end


function chen_soul_persuasion:ValidateCurrentSummons()
	for unit_index = #(self.summon_list or {}), 1, -1 do
		local unit_handle = self.summon_list[unit_index]
		if not unit_handle or unit_handle:IsNull() or not unit_handle:IsAlive() then
			table.remove(self.summon_list, unit_index)
		end
	end
end



function chen_soul_persuasion:CreateCreep(creeps_data)
	local parent = self:GetCaster()

	local spawn_point = GetRandomPathablePositionWithin(parent:GetAbsOrigin(), 210, 140)
	spawn_point.z = 0

	local unit = CreateUnitByName(table.random(creeps_data), spawn_point, false, parent, parent, parent:GetTeamNumber())
	unit:SetControllableByPlayer(parent:GetPlayerOwnerID(), true)

	FindClearSpaceForUnit(unit, spawn_point, true)

	table.insert(self.summon_list, unit)

	local min_health = self:GetSpecialValueFor("health_min") + self:GetSpecialValueFor("bonus_health_per_level") * parent:GetLevel()

	if unit:GetMaxHealth() < min_health then
		unit:SetBaseMaxHealth(min_health)
		unit:SetMaxHealth(min_health)
		unit:SetHealth(min_health)
	end

	unit:AddNewModifier(unit, self, "modifier_chen_holy_persuasion_lua", nil)

	-- if parent:HasScepter() then
	-- 	self:AddMartyrdom(unit)
	-- end

	local abilities_level = GetCreepAbilityLevel()
	if parent:HasShard() then
		abilities_level = abilities_level + 1
	end

	for i = 0, unit:GetAbilityCount() - 1 do
		local ability = unit:GetAbilityByIndex(i)
		if IsValidEntity(ability) then
			ability:SetLevel(abilities_level)
		end
	end

	local spawn_particle = ParticleManager:CreateParticle("particles/econ/items/pets/pet_frondillo/pet_spawn_frondillo.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(spawn_particle, 0, spawn_point)
	ParticleManager:ReleaseParticleIndex(spawn_particle)
end


function chen_soul_persuasion:AddMartyrdom(unit)
	local martyrdom = unit:AddAbility("chen_martyrdom")
	unit:RemoveAbilityFromIndexByName("chen_martyrdom")
	unit:SetAbilityByIndex(martyrdom, 5)
	martyrdom:SetLevel(1)

	local cooldown = self.martyrdom_cooldown_end - GameRules:GetGameTime()

	if cooldown > 0 then
		martyrdom:StartCooldown(cooldown)
	end
end


function chen_soul_persuasion:CheckSummonType(stacks_count)
	if not stacks_count then return 0 end

	-- attempt to re-init in case soul requirements are missing
	if not self.souls_summon_ancient then
		self:MakeCreepsTables()
	end

	-- but if it failed, we shouldn't be able to cast it
	if not self.souls_summon_ancient then return 0 end

	if stacks_count >= self.souls_summon_ancient then
		return self.souls_summon_ancient
	end
	if stacks_count >= self.souls_summon_big then
		return self.souls_summon_big
	end
	if stacks_count >= self.souls_summon_middle then
		return self.souls_summon_middle
	end
	if stacks_count >= self.souls_summon_little then
		return self.souls_summon_little
	end
	return 0
end


function chen_soul_persuasion:CheckSummonLevel(stacks_count)
	if not stacks_count then return 0 end

	-- attempt to re-init in case soul requirements are missing
	if not self.souls_summon_ancient then
		self:MakeCreepsTables()
	end

	-- but if it failed, we shouldn't be able to cast it
	if not self.souls_summon_ancient then return 0 end

	if stacks_count >= self.souls_summon_ancient then
		return 4
	end
	if stacks_count >= self.souls_summon_big then
		return 3
	end
	if stacks_count >= self.souls_summon_middle then
		return 2
	end
	if stacks_count >= self.souls_summon_little then
		return 1
	end
	return 0
end


function chen_soul_persuasion:GetAbilityTextureName()
	if self.ability_data then
		local caster = self:GetCaster()
		return self.ability_data[self:CheckSummonType(caster:GetModifierStackCount("chen_soul_persuasion_passive", caster))].icon
	end
	return "chen_soul_persuasion_1"
end


function chen_soul_persuasion:MakeCreepsTables()
	local special_value_names = {
		"souls_summon_little",
		"souls_summon_middle",
		"souls_summon_big",
		"souls_summon_ancient",
	}

	for _, name in pairs(special_value_names) do
		self[name] = self:GetSpecialValueFor(name)
	end

	self.ability_data = {
		[0] = {
			icon = "chen_soul_persuasion_1",
		},
		[self.souls_summon_little] = {
			creeps = {
				--Level 1:
				"npc_dota_neutral_wildkin",
				"npc_dota_neutral_kobold_tunneler",
				"npc_dota_neutral_kobold",

				--Level 2:
				"npc_dota_neutral_satyr_trickster",
				"npc_dota_neutral_centaur_outrunner",
				"npc_dota_neutral_fel_beast",
				"npc_dota_neutral_forest_troll_berserker",
				"npc_dota_neutral_gnoll_assassin",
				"npc_dota_neutral_kobold_taskmaster",
				"npc_dota_neutral_forest_troll_high_priest",
				"npc_dota_neutral_ogre_mauler",
			},
			icon = "chen_soul_persuasion_1",
		},
		[self.souls_summon_middle] = {
			creeps = {
				--Level 3:
				"npc_dota_neutral_ghost",
				"npc_dota_neutral_giant_wolf",
				"npc_dota_neutral_dark_troll",
				"npc_dota_neutral_ogre_magi",

				--Level 4:
				"npc_dota_neutral_polar_furbolg_champion",
				"npc_dota_neutral_satyr_soulstealer",
				"npc_dota_neutral_mud_golem",
			},
			icon = "chen_soul_persuasion_2",
		},
		[self.souls_summon_big] = {
			creeps = {
				--Level 5:
				"npc_dota_neutral_centaur_khan",
				"npc_dota_neutral_polar_furbolg_ursa_warrior",
				"npc_dota_neutral_warpine_raider",
				"npc_dota_neutral_enraged_wildkin",
				"npc_dota_neutral_alpha_wolf",

				--Level 6:
				"npc_dota_neutral_satyr_hellcaller",
				"npc_dota_neutral_dark_troll_warlord",
			},
			icon = "chen_soul_persuasion_3",
		},
		[self.souls_summon_ancient] = {
			creeps = {
				--Level 3 Ancients:
				"npc_dota_neutral_black_drake",

				--Level 5 Ancients:
				"npc_dota_neutral_rock_golem",
				"npc_dota_neutral_frostbitten_golem",
				"npc_dota_neutral_small_thunder_lizard",

				--Level 6 Ancients:
				--"npc_dota_neutral_prowler_shaman",		-- deprecated
				--"npc_dota_neutral_prowler_acolyte",		-- deprecated
				"npc_dota_neutral_granite_golem",
				"npc_dota_neutral_big_thunder_lizard",
				"npc_dota_neutral_black_dragon",
				"npc_dota_neutral_ice_shaman",
			},
			icon = "chen_soul_persuasion_4",
		}
	}
end



chen_soul_persuasion_passive = chen_soul_persuasion_passive or class({})

function chen_soul_persuasion_passive:OnCreated(keys)
	local ability = self:GetAbility()
	ability:MakeCreepsTables()

	if not IsServer() then return end

	self.souls_limit = ability:GetSpecialValueFor("souls_limit")
	self.souls_per_kill = ability:GetSpecialValueFor("souls_per_kill")
	self.souls_per_second = ability:GetSpecialValueFor("souls_per_second")

	self.current_souls = self.current_souls or 0

	self:StartIntervalThink(1.0)
end


function chen_soul_persuasion_passive:OnRefresh(keys)
    self:OnCreated(keys)
end


function chen_soul_persuasion_passive:OnIntervalThink()
	local ability = self:GetAbility()

	self.souls_limit = ability:GetSpecialValueFor("souls_limit")
	self.souls_per_second = ability:GetSpecialValueFor("souls_per_second")
	self.current_souls = math.min(self.current_souls + self.souls_per_second, self.souls_limit)

	self:SetStackCount(math.floor(self.current_souls))
end


function chen_soul_persuasion_passive:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_HERO_KILLED,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}
end


function chen_soul_persuasion_passive:OnHeroKilled(keys)
	if not IsServer() then return end

	local parent = self:GetParent()
	local killer_player_id = keys.attacker:GetPlayerOwnerID()

	if killer_player_id and killer_player_id == parent:GetPlayerOwnerID() then
		local ability = self:GetAbility()

		self.souls_per_kill = ability:GetSpecialValueFor("souls_per_kill")
		self.souls_limit = ability:GetSpecialValueFor("souls_limit")

		self.current_souls = math.min(self.current_souls + self.souls_per_kill, self.souls_limit)

		self:SetStackCount(math.floor(self.current_souls))
	end
end


function chen_soul_persuasion_passive:SpendSouls(count)
	if not IsServer() then return end

	self.current_souls = self.current_souls - count
	self:SetStackCount(math.floor(self.current_souls))
end


function chen_soul_persuasion_passive:OnAbilityFullyCast(event)
	local caster = self:GetCaster()

	if event.ability:GetAbilityName() == "chen_martyrdom" and event.unit:GetMainControllingPlayer() == caster:GetPlayerOwnerID() then
		local ability = self:GetAbility()
		ability.martyrdom_cooldown_end = GameRules:GetGameTime() + event.ability:GetCooldownTimeRemaining()
	end
end



modifier_chen_holy_persuasion_lua = class({})


function modifier_chen_holy_persuasion_lua:IsHidden() return true end
function modifier_chen_holy_persuasion_lua:IsPurgable() return false end
function modifier_chen_holy_persuasion_lua:RemoveOnDeath() return false end


function modifier_chen_holy_persuasion_lua:OnCreated()
	local ability = self:GetAbility()

	self.movement_speed_bonus = ability:GetSpecialValueFor("movement_speed_bonus")
	self.damage_bonus = ability:GetSpecialValueFor("damage_bonus")
end


function modifier_chen_holy_persuasion_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end


function modifier_chen_holy_persuasion_lua:GetModifierMoveSpeedBonus_Constant()
	return self.movement_speed_bonus
end


function modifier_chen_holy_persuasion_lua:GetModifierPreAttack_BonusDamage()
	return self.damage_bonus
end