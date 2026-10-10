--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_invoker_deafening_blast_custom",
	"abilities/invoker/invoker_invoke_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_invoker_invoke_custom_legendary",
	"abilities/invoker/invoker_invoke_custom",
	LUA_MODIFIER_MOTION_NONE,
	"modifier_invoker_invoke_7"
)
LinkLuaModifier(
	"modifier_invoker_invoke_custom_legendary_illusion",
	"abilities/invoker/invoker_invoke_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_invoker_invoke_custom_tracker",
	"abilities/invoker/invoker_invoke_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_invoker_deafening_blast_custom_cd",
	"abilities/invoker/invoker_invoke_custom",
	LUA_MODIFIER_MOTION_NONE,
	"modifier_invoker_hero_6"
)
LinkLuaModifier(
	"modifier_invoker_invoke_custom_blast_thinker",
	"abilities/invoker/invoker_invoke_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_invoker_invoke_custom_damage_effect",
	"abilities/invoker/invoker_invoke_custom",
	LUA_MODIFIER_MOTION_NONE,
	"modifier_invoker_invoke_3"
)
LinkLuaModifier(
	"modifier_invoker_stolen_ability_tracker",
	"abilities/invoker/invoker_invoke_custom",
	LUA_MODIFIER_MOTION_NONE
)

invoker_invoke_custom = class({})
invoker_invoke_custom.talents = {}
invoker_invoke_custom.orb_order = "qwe"
invoker_invoke_custom.invoke_list = {
	["qqq"] = "invoker_cold_snap_custom",
	["qqw"] = "invoker_ghost_walk_custom",
	["qqe"] = "invoker_ice_wall_custom",
	["www"] = "invoker_emp_custom",
	["qww"] = "invoker_tornado_custom",
	["wwe"] = "invoker_alacrity_custom",
	["eee"] = "invoker_sun_strike_custom",
	["qee"] = "invoker_forge_spirit_custom",
	["wee"] = "invoker_chaos_meteor_custom",
	["qwe"] = "invoker_deafening_blast_custom",
}

invoker_invoke_custom.modifier_list = {
	["q"] = "modifier_invoker_quas_custom",
	["w"] = "modifier_invoker_wex_custom",
	["e"] = "modifier_invoker_exort_custom",

	["modifier_invoker_quas_custom"] = "q",
	["modifier_invoker_wex_custom"] = "w",
	["modifier_invoker_exort_custom"] = "e",
}

invoker_invoke_custom.particle_list = {
	["modifier_invoker_quas_custom"] = "particles/units/heroes/hero_invoker/invoker_quas_orb.vpcf",
	["modifier_invoker_wex_custom"] = "particles/units/heroes/hero_invoker/invoker_wex_orb.vpcf",
	["modifier_invoker_exort_custom"] = "particles/units/heroes/hero_invoker/invoker_exort_orb.vpcf",
}

function invoker_invoke_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/crystal_maiden/maiden_shield_active.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_invoker/invoker_invoke.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_invoker/invoker_quas_orb.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_invoker/invoker_wex_orb.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_invoker/invoker_exort_orb.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_invoker/invoker_deafening_blast.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_invoker/invoker_deafening_blast_knockback_debuff.vpcf",
		context
	)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_invoker/invoker_deafening_blast_disarm_debuff.vpcf",
		context
	)
	PrecacheResource("particle", "particles/invoker/item_speed.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_dark_seer/dark_seer_surge.vpcf", context)
	PrecacheResource("particle", "particles/invoker/invoke_legendary_clock.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/econ/items/faceless_void/faceless_void_bracers_of_aeons/fv_bracers_of_aeons_dialatedebuf.vpcf",
		context
	)
	PrecacheResource("particle", "particles/troll_warlord/refresh_ranged.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_weaver/weaver_timelapse.vpcf", context)
	PrecacheResource("particle", "particles/huskar/huskar_timer.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_invoker/invoker_dot_enemy.vpcf", context)
	dota1x6:PrecacheShopItems("npc_dota_hero_invoker", context)
end

function invoker_invoke_custom:UpdateTalents(name)
	local caster = self:GetCaster()
	if not self.init then
		self.init = true
		self.talents = {
			has_r1 = 0,
			r1_damage = 0,
			r1_spell = 0,

			has_r2 = 0,
			r2_cdr = 0,
			r2_radius = 0,

			has_r3 = 0,
			r3_damage = 0,
			r3_base = 0,
			r3_duration = caster:GetTalentValue("modifier_invoker_invoke_3", "duration", true),
			r3_interval = caster:GetTalentValue("modifier_invoker_invoke_3", "interval", true),
			r3_damage_type = caster:GetTalentValue("modifier_invoker_invoke_3", "damage_type", true),
			r3_heal = caster:GetTalentValue("modifier_invoker_invoke_3", "heal", true) / 100,

			has_r4 = 0,
			r4_level = caster:GetTalentValue("modifier_invoker_invoke_4", "level", true),
			r4_cd_items = caster:GetTalentValue("modifier_invoker_invoke_4", "cd_items", true),

			r7_duration = caster:GetTalentValue("modifier_invoker_invoke_7", "duration", true),
			r7_vision_radius = caster:GetTalentValue("modifier_invoker_invoke_7", "vision_radius", true),
			r7_talent_cd = caster:GetTalentValue("modifier_invoker_invoke_7", "talent_cd", true),

			has_h1 = 0,
			h1_mana = 0,
			h1_shield = 0,
			h1_duration = caster:GetTalentValue("modifier_invoker_hero_1", "duration", true),
			h1_max = caster:GetTalentValue("modifier_invoker_hero_1", "max", true),

			h2_armor = 0,

			h3_move = 0,
			h3_status = 0,

			has_h6 = 0,
			h6_health = caster:GetTalentValue("modifier_invoker_hero_6", "health", true),
			h6_talent_cd = caster:GetTalentValue("modifier_invoker_hero_6", "talent_cd", true),
			h6_bkb = caster:GetTalentValue("modifier_invoker_hero_6", "bkb", true),

			s1_max = caster:GetTalentValue("modifier_invoker_spells_1", "max", true),

			s2_max = caster:GetTalentValue("modifier_invoker_spells_2", "max", true),

			s3_max = caster:GetTalentValue("modifier_invoker_spells_3", "max", true),

			has_s4 = 0,
			s4_cdr = caster:GetTalentValue("modifier_invoker_spells_4", "cdr", true),
			s4_spell = caster:GetTalentValue("modifier_invoker_spells_4", "spell", true),
			s4_max = caster:GetTalentValue("modifier_invoker_spells_4", "max", true),
		}
	end

	local need_refresh = false
	if
		name == "modifier_invoker_invoke_1"
		or name == "modifier_invoker_invoke_2"
		or name == "modifier_invoker_invoke_4"
	then
		need_refresh = true
	end

	if caster:HasTalent("modifier_invoker_invoke_1") then
		self.talents.has_r1 = 1
		self.talents.r1_damage = caster:GetTalentValue("modifier_invoker_invoke_1", "damage") / 100
		self.talents.r1_spell = caster:GetTalentValue("modifier_invoker_invoke_1", "spell")
	end

	if caster:HasTalent("modifier_invoker_invoke_2") then
		self.talents.has_r2 = 1
		self.talents.r2_cdr = caster:GetTalentValue("modifier_invoker_invoke_2", "cdr")
		self.talents.r2_radius = caster:GetTalentValue("modifier_invoker_invoke_2", "radius") / 100
	end

	if caster:HasTalent("modifier_invoker_invoke_3") then
		self.talents.has_r3 = 1
		self.talents.r3_damage = caster:GetTalentValue("modifier_invoker_invoke_3", "damage") / 100
		self.talents.r3_base = caster:GetTalentValue("modifier_invoker_invoke_3", "base")
		caster:AddSpellEvent(self.tracker, true)
	end

	if caster:HasTalent("modifier_invoker_invoke_4") then
		self.talents.has_r4 = 1
		caster:AddSpellEvent(self.tracker, true)
	end

	if caster:HasTalent("modifier_invoker_hero_1") then
		self.talents.has_h1 = 1
		self.talents.h1_mana = caster:GetTalentValue("modifier_invoker_hero_1", "mana")
		self.talents.h1_shield = caster:GetTalentValue("modifier_invoker_hero_1", "shield")
		caster:AddSpellEvent(self.tracker, true)
	end

	if caster:HasTalent("modifier_invoker_hero_2") then
		self.talents.h2_armor = caster:GetTalentValue("modifier_invoker_hero_2", "armor")
	end

	if caster:HasTalent("modifier_invoker_hero_3") then
		self.talents.h3_move = caster:GetTalentValue("modifier_invoker_hero_3", "move")
		self.talents.h3_status = caster:GetTalentValue("modifier_invoker_hero_3", "status")
	end

	if caster:HasTalent("modifier_invoker_hero_6") then
		self.talents.has_h6 = 1
		caster:AddDamageEvent_inc(self.tracker, true)
	end

	if caster:HasTalent("modifier_invoker_spells_4") then
		self.talents.has_s4 = 1
	end

	if need_refresh then
		InvokerAbilityManager(caster)
	end
end

function invoker_invoke_custom:ProcsMagicStick()
	return false
end

function invoker_invoke_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_invoker_invoke_custom_tracker"
end

function invoker_invoke_custom:GetBehavior()
	local bonus = 0
	if self.caster:HasShard() then
		bonus = DOTA_ABILITY_BEHAVIOR_IGNORE_SILENCE_CUSTOM + DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE
	end
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
		+ DOTA_ABILITY_BEHAVIOR_IMMEDIATE
		+ DOTA_ABILITY_BEHAVIOR_SHOW_IN_GUIDES
		+ DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE
		+ DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL
		+ bonus
end

function invoker_invoke_custom:GetCooldown(level)
	if self.caster:HasModifier("modifier_invoker_invoke_custom_legendary") then
		return 0
	end

	local cooldown = (self.base_cd or 0)
	local reduction = (self.cooldown_reduction_per_orb or 0)
	if self.caster.exort_ability then
		cooldown = cooldown - self.caster.exort_ability:GetLevel() * reduction
	end
	if self.caster.wex_ability then
		cooldown = cooldown - self.caster.wex_ability:GetLevel() * reduction
	end
	if self.caster.quas_ability then
		cooldown = cooldown - self.caster.quas_ability:GetLevel() * reduction
	end
	return cooldown
end

function invoker_invoke_custom:Spawn()
	if not IsServer() then
		return
	end
	self:SetLevel(1)
end

function invoker_invoke_custom:OnUpgrade()
	if self.status then
		return
	end

	self.MAX_ORB = 3
	self.status = {}
	self.modifiers = {}
	self.names = {}

	self.ability_slot = {}
	self.MAX_ABILITY = 2

	local empty1 = self.caster:FindAbilityByName("invoker_empty1")
	local empty2 = self.caster:FindAbilityByName("invoker_empty2")
	table.insert(self.ability_slot, empty1)
	table.insert(self.ability_slot, empty2)
end

function invoker_invoke_custom:OnSpellStart()
	local particle_cast = wearables_system:GetParticleReplacementAbility(
		self.caster,
		"particles/units/heroes/hero_invoker/invoker_invoke.vpcf",
		self
	)
	self.caster:GenericParticle(particle_cast)
	self.caster:EmitSound("Hero_Invoker.Invoke")

	local key = ""
	for i = 1, string.len(self.orb_order) do
		local k = string.sub(self.orb_order, i, i)
		if self.status[k] then
			for j = 1, self.status[k] do
				key = key .. k
			end
		end
	end

	local ability_name = self.invoke_list[key]
	if not ability_name then
		return
	end

	local ability = self.caster:FindAbilityByName(ability_name)
	if not ability then
		return
	end

	local exist = 0
	for i = 1, #self.ability_slot do
		if self.ability_slot[i] == ability then
			exist = i
		end
	end

	if exist > 0 then
		self:InvokeExist(exist)
		self:RefundManaCost()
		self:EndCd(0)
		return
	end

	if #self.ability_slot < self.MAX_ABILITY then
		table.insert(self.ability_slot, ability)
	else
		self.caster:SwapAbilities(
			ability:GetAbilityName(),
			self.ability_slot[#self.ability_slot]:GetAbilityName(),
			true,
			false
		)
		self.ability_slot[#self.ability_slot] = ability
	end

	self:InvokeExist(#self.ability_slot)
end

function invoker_invoke_custom:CreateTalent()
	for i = 0, 20 do
		local current_item = self.caster:GetItemInSlot(i)
		if current_item then
			if current_item:IsActiveNeutral() then
				self.caster:RemoveItem(current_item)
			end
		end
	end

	self.caster:EmitSound("Invoker.Book_sound")
	local item = CreateItem("item_invoker_custom_legendary", self.caster, self.caster)
	self.caster:AddItem(item)

	CustomGameEventManager:Send_ServerToPlayer(
		PlayerResource:GetPlayer(self.caster:GetPlayerOwnerID()),
		"invoker_hide_neutral",
		{}
	)
end

function invoker_invoke_custom:AbilityHit(target)
	if not IsServer() then
		return
	end

	if self.talents.has_r3 == 1 then
		target:AddNewModifier(
			self.caster,
			self,
			"modifier_invoker_invoke_custom_damage_effect",
			{ duration = self.talents.r3_duration + 0.3 }
		)
	end

	if not target:IsRealHero() then
		return
	end

	if self.caster:GetQuest() == "Invoker.Quest_8" and not self.caster:QuestCompleted() then
		self.caster:UpdateQuest(1)
	end

	self.tracker:ScepterEvent("modifier_invoker_spells_4", 1)
end

function invoker_invoke_custom:InvokeExist(slot)
	for i = slot, 2, -1 do
		self.caster:SwapAbilities(
			self.ability_slot[i - 1]:GetAbilityName(),
			self.ability_slot[i]:GetAbilityName(),
			true,
			true
		)
		self.ability_slot[i], self.ability_slot[i - 1] = self.ability_slot[i - 1], self.ability_slot[i]
	end
end

function invoker_invoke_custom:AddOrb(modifier)
	local orb_name = self.modifier_list[modifier:GetName()]
	if not self.status[orb_name] then
		self.status[orb_name] = 0
	end

	self:AddOrbParticle(self.particle_list[modifier:GetName()])

	table.insert(self.modifiers, modifier)
	table.insert(self.names, orb_name)
	self.status[orb_name] = self.status[orb_name] + 1

	if #self.modifiers > self.MAX_ORB then
		self.status[self.names[1]] = self.status[self.names[1]] - 1

		if IsValid(self.modifiers[1]) then
			self.modifiers[1]:Destroy()
		end
		table.remove(self.modifiers, 1)
		table.remove(self.names, 1)
	end
end

function invoker_invoke_custom:AddOrbParticle(particle)
	if not self.caster.invoked_orbs_particle then
		self.caster.invoked_orbs_particle = {}
	end

	if not self.caster.invoked_orbs_particle_attach then
		self.caster.invoked_orbs_particle_attach = {}
		self.caster.invoked_orbs_particle_attach[1] = "attach_orb1"
		self.caster.invoked_orbs_particle_attach[2] = "attach_orb2"
		self.caster.invoked_orbs_particle_attach[3] = "attach_orb3"
	end

	if self.caster.invoked_orbs_particle[1] then
		ParticleManager:DestroyParticle(self.caster.invoked_orbs_particle[1], false)
		self.caster.invoked_orbs_particle[1] = nil
	end

	self.caster.invoked_orbs_particle[1] = self.caster.invoked_orbs_particle[2]
	self.caster.invoked_orbs_particle[2] = self.caster.invoked_orbs_particle[3]

	local orb_particle_original = particle
	local orb_set_particle = particle
	if particle == "particles/units/heroes/hero_invoker/invoker_quas_orb.vpcf" then
		orb_set_particle = wearables_system:GetParticleReplacementAbility(
			self.caster,
			orb_particle_original,
			self,
			"invoker_quas_custom"
		)
	elseif particle == "particles/units/heroes/hero_invoker/invoker_wex_orb.vpcf" then
		orb_set_particle = wearables_system:GetParticleReplacementAbility(
			self.caster,
			orb_particle_original,
			self,
			"invoker_wex_custom"
		)
	elseif particle == "particles/units/heroes/hero_invoker/invoker_exort_orb.vpcf" then
		orb_set_particle = wearables_system:GetParticleReplacementAbility(
			self.caster,
			orb_particle_original,
			self,
			"invoker_exort_custom"
		)
	end
	self.caster.invoked_orbs_particle[3] =
		ParticleManager:CreateParticle(orb_set_particle, PATTACH_CUSTOMORIGIN, self.caster)
	ParticleManager:SetParticleControlEnt(
		self.caster.invoked_orbs_particle[3],
		0,
		self.caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack" .. RandomInt(1, 2),
		self.caster:GetAbsOrigin(),
		false
	)
	ParticleManager:SetParticleControlEnt(
		self.caster.invoked_orbs_particle[3],
		1,
		self.caster,
		PATTACH_POINT_FOLLOW,
		self.caster.invoked_orbs_particle_attach[1],
		self.caster:GetAbsOrigin(),
		false
	)

	local temp_attachment_point = self.caster.invoked_orbs_particle_attach[1]
	self.caster.invoked_orbs_particle_attach[1] = self.caster.invoked_orbs_particle_attach[2]
	self.caster.invoked_orbs_particle_attach[2] = self.caster.invoked_orbs_particle_attach[3]
	self.caster.invoked_orbs_particle_attach[3] = temp_attachment_point
end

modifier_invoker_invoke_custom_tracker = class(mod_hidden)
function modifier_invoker_invoke_custom_tracker:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.ability.tracker = self
	self.ability:UpdateTalents()

	self.ability.base_cd = self.ability:GetSpecialValueFor("base_cd")
	self.ability.cooldown_reduction_per_orb = self.ability:GetSpecialValueFor("cooldown_reduction_per_orb")

	self.parent.invoke_ability = self.ability

	if not IsServer() then
		return
	end

	self.spells_table = {
		["modifier_invoker_spells_1"] = { 0, self.ability.talents.s1_max },
		["modifier_invoker_spells_2"] = { 0, self.ability.talents.s2_max },
		["modifier_invoker_spells_3"] = { 0, self.ability.talents.s3_max },
		["modifier_invoker_spells_4"] = { 0, self.ability.talents.s4_max },
	}

	self.parent:AddRespawnEvent(self, true)
	self.parent:AddDeathEvent(self, true)
end

function modifier_invoker_invoke_custom_tracker:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	}
end

function modifier_invoker_invoke_custom_tracker:GetModifierPhysicalArmorBonus()
	return self.ability.talents.h2_armor
end

function modifier_invoker_invoke_custom_tracker:GetModifierStatusResistanceStacking()
	return self.ability.talents.h3_status
end

function modifier_invoker_invoke_custom_tracker:GetModifierMoveSpeedBonus_Constant()
	return self.ability.talents.h3_move
end

function modifier_invoker_invoke_custom_tracker:GetModifierPercentageManacostStacking()
	return self.ability.talents.h1_mana
end

function modifier_invoker_invoke_custom_tracker:GetModifierSpellAmplify_Percentage()
	return self.ability.talents.r1_spell
		+ ((self.ability.talents.has_s4 == 1 and self.parent:HasScepter()) and self.ability.talents.s4_spell or 0)
end

function modifier_invoker_invoke_custom_tracker:GetModifierPercentageCooldown()
	return self.ability.talents.r2_cdr
		+ ((self.ability.talents.has_s4 == 1 and self.parent:HasScepter()) and self.ability.talents.s4_cdr or 0)
end

function modifier_invoker_invoke_custom_tracker:ScepterEvent(name, count)
	if not IsServer() then
		return
	end

	local need_refresh = false
	local data = self.spells_table[name]
	if data and data[1] < data[2] then
		need_refresh = true
		data[1] = math.min(data[2], data[1] + count)
		if data[1] >= data[2] then
			self.parent:InitTalent(name)
		end
	end

	if not need_refresh then
		return
	end
	self:StartIntervalThink(3)
end

function modifier_invoker_invoke_custom_tracker:OnIntervalThink()
	if not IsServer() then
		return
	end

	local player_data = players[self.parent:GetId()].upgrades
	if player_data then
		for name, data in pairs(self.spells_table) do
			player_data[name .. "_count"] = data[1]
		end
	end

	self.parent:UpdateCommonBonus()
	self:StartIntervalThink(-1)
end

function modifier_invoker_invoke_custom_tracker:SpellEvent(params)
	if not IsServer() then
		return
	end
	if params.unit ~= self.parent then
		return
	end

	if self.ability.talents.has_r3 == 1 and params.ability:IsItem() and params.target then
		params.target:AddNewModifier(self.parent, self.ability, "modifier_invoker_invoke_custom_damage_effect", {})
	end

	if params.ability:IsItem() then
		return
	end

	if self.ability.talents.has_r4 == 1 then
		self.parent:CdItems(self.ability.talents.r4_cd_items, "modifier_invoker_invoke_4")
	end

	if self.ability.talents.has_h1 == 1 then
		local max = self.ability.talents.h1_shield * self.ability.talents.h1_max
		if not IsValid(self.shield_mod) then
			self.shield_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_shield", {
				duration = self.ability.talents.h1_duration,
				max_shield = max,
				shield_talent = "modifier_invoker_hero_1",
			})
		end

		if self.shield_mod then
			self.shield_mod:SetDuration(self.ability.talents.h1_duration, true)
			self.shield_mod:AddShield(self.ability.talents.h1_shield, max)
		end
	end
end

function modifier_invoker_invoke_custom_tracker:DamageEvent_inc(params)
	if not IsServer() then
		return
	end
	if self.ability.talents.has_h6 == 0 then
		return
	end
	if self.parent:GetHealthPercent() > self.ability.talents.h6_health then
		return
	end
	if self.parent ~= params.unit then
		return
	end
	if self.parent:PassivesDisabled() then
		return
	end
	if self.parent:HasModifier("modifier_invoker_deafening_blast_custom_cd") then
		return
	end
	if not self.parent.deafing_ability then
		return
	end

	self.parent:EmitSound("Invoker.Deafing_bkb")
	self.parent.deafing_ability:OnSpellStart(true)
	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_invoker_deafening_blast_custom_cd",
		{ duration = self.ability.talents.h6_talent_cd }
	)
	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_generic_debuff_immune",
		{ duration = self.ability.talents.h6_bkb, effect = 2 }
	)
end

function modifier_invoker_invoke_custom_tracker:DeathEvent(params)
	if not IsServer() then
		return
	end
	if not self.parent:IsRealHero() then
		return
	end
	if params.unit ~= self.parent then
		return
	end
	if not self.parent.invoked_orbs_particle then
		return
	end

	for i = 1, #self.parent.invoked_orbs_particle do
		if self.parent.invoked_orbs_particle[i] ~= nil then
			ParticleManager:DestroyParticle(self.parent.invoked_orbs_particle[i], false)
			self.parent.invoked_orbs_particle[i] = nil
		end
	end
end

function modifier_invoker_invoke_custom_tracker:RespawnEvent(params)
	if not IsServer() then
		return
	end
	if not self.parent:IsRealHero() then
		return
	end
	if params.unit ~= self.parent then
		return
	end

	for _, mod in pairs(self.parent:FindAllModifiers()) do
		for name, particle in pairs(self.ability.particle_list) do
			if mod:GetName() == name then
				self.ability:AddOrbParticle(particle)
			end
		end
	end
end

modifier_invoker_invoke_custom_damage_effect = class(mod_visible)
function modifier_invoker_invoke_custom_damage_effect:GetTexture()
	return "buffs/invoker/invoke_3"
end
function modifier_invoker_invoke_custom_damage_effect:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.RemoveForDuel = true

	self.damage = self.ability.talents.r3_damage
	self.interval = self.ability.talents.r3_interval
	self.duration = self.ability.talents.r3_duration / self.interval

	self.damageTable = {
		victim = self.parent,
		attacker = self.caster,
		ability = self.ability,
		damage_type = self.ability.talents.r3_damage_type,
	}
	self.parent:GenericParticle("particles/units/heroes/hero_invoker/invoker_dot_enemy.vpcf", self)

	self.count = 0
	self.damage_tick = 0
	self.damage_total = 0
	self:AddDamage()
	self:StartIntervalThink(self.interval)
end

function modifier_invoker_invoke_custom_damage_effect:OnRefresh()
	if not IsServer() then
		return
	end
	self:AddDamage()
end

function modifier_invoker_invoke_custom_damage_effect:AddDamage()
	if not IsServer() then
		return
	end
	self.count = self.duration
	self.damage_total = self.damage_total + self.ability.talents.r3_base + self.damage * self.caster:GetIntellect(false)
	self.damage_tick = self.damage_total / self.count
end

function modifier_invoker_invoke_custom_damage_effect:OnIntervalThink()
	if not IsServer() then
		return
	end

	self.damageTable.damage = self.damage_tick
	local real_damage = DoDamage(self.damageTable, "modifier_invoker_invoke_3")
	self.parent:SendNumber(4, real_damage)

	local result = self.caster:CanLifesteal(self.parent)
	if result then
		self.caster:GenericHeal(
			result * self.ability.talents.r3_heal * real_damage,
			self.ability,
			true,
			"",
			"modifier_invoker_invoke_3"
		)
	end

	self.damage_total = self.damage_total - self.damage_tick
	self.count = self.count - 1
	if self.count <= 0 then
		self:Destroy()
		return
	end
end

modifier_invoker_deafening_blast_custom_cd = class(mod_cd)
function modifier_invoker_deafening_blast_custom_cd:GetTexture()
	return "buffs/invoker/hero_8"
end

item_invoker_custom_legendary = class({})
function item_invoker_custom_legendary:GetCooldown()
	local caster = self:GetCaster()
	return (caster.invoke_ability and caster.invoke_ability.talents.r7_talent_cd or 0) / caster:GetCooldownReduction()
end

function item_invoker_custom_legendary:OnSpellStart()
	local caster = self:GetCaster()
	if not caster.invoke_ability then
		return
	end
	caster.invoke_ability:EndCd(0)
	caster:AddNewModifier(
		caster,
		self,
		"modifier_invoker_invoke_custom_legendary",
		{ duration = caster.invoke_ability.talents.r7_duration }
	)
end

modifier_invoker_invoke_custom_legendary = class(mod_hidden)
function modifier_invoker_invoke_custom_legendary:GetEffectName()
	return "particles/invoker/item_speed.vpcf"
end
function modifier_invoker_invoke_custom_legendary:GetStatusEffectName()
	return "particles/status_fx/status_effect_huskar_lifebreak.vpcf"
end
function modifier_invoker_invoke_custom_legendary:StatusEffectPriority()
	return MODIFIER_PRIORITY_ULTRA
end
function modifier_invoker_invoke_custom_legendary:OnCreated()
	if not IsServer() then
		return
	end
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	self.RemoveForDuel = true

	self.parent:GenericParticle("particles/units/heroes/hero_dark_seer/dark_seer_surge.vpcf", self)
	self.parent:GenericParticle("particles/invoker/invoke_legendary_clock.vpcf", self)
	self.parent:GenericParticle(
		"particles/econ/items/faceless_void/faceless_void_bracers_of_aeons/fv_bracers_of_aeons_dialatedebuf.vpcf",
		self
	)

	self.parent:EmitSound("Invoker.Invoke_legendary_start")
	self.parent:EmitSound("Invoker.Invoke_legendary_loop")

	self.pos = self.parent:GetAbsOrigin()
	self.max_time = self:GetRemainingTime()
	self.health_level = self.parent:GetHealthPercent() / 100
	self.mana_level = self.parent:GetManaPercent() / 100

	local illusion_self = CreateIllusions(self.parent, self.parent, {
		outgoing_damage = 0,
		duration = self:GetRemainingTime() + 0.2,
	}, 1, 0, false, false)

	for _, illusion in pairs(illusion_self) do
		illusion.owner = self.parent
		illusion:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_invoker_invoke_custom_legendary_illusion",
			{ duration = self:GetRemainingTime() }
		)
		illusion:SetAbsOrigin(self.pos)
		self.illusion = illusion
	end

	self.interval = 0.1
	self.vision_radius = self.parent.invoke_ability and self.parent.invoke_ability.talents.r7_vision_radius or 0

	self:OnIntervalThink()
	self:StartIntervalThink(self.interval)
end

function modifier_invoker_invoke_custom_legendary:OnIntervalThink()
	if not IsServer() then
		return
	end

	if not IsValid(self.ability) then
		self.fast_end = true
		self:Destroy()
		return
	end

	AddFOWViewer(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), self.vision_radius, self.interval * 2, false)
	self.parent:UpdateUIshort({
		max_time = self.max_time,
		time = (self.max_time - self:GetElapsedTime()),
		stack = self:GetRemainingTime(),
		use_zero = 1,
		style = "InvokerInvoke",
		priority = 1,
	})
end

function modifier_invoker_invoke_custom_legendary:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:UpdateUIshort({ hide = 1, hide_full = 1, style = "InvokerInvoke", priority = 1 })

	if IsValid(self.illusion) then
		self.illusion:Kill(nil, nil)
	end

	self.parent:StopSound("Invoker.Invoke_legendary_loop")

	if self.fast_end then
		return
	end

	if self.parent.invoke_ability then
		self.ability:StartCooldown(self.parent.invoke_ability.talents.r7_talent_cd)
	end

	if self:GetRemainingTime() > 0.1 then
		return
	end
	if not self.parent:IsAlive() then
		return
	end

	EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "Invoker.Invoke_return", self.parent)
	self.parent:EmitSound("Invoker.Invoke_legendary_refresh")

	local particle =
		ParticleManager:CreateParticle("particles/troll_warlord/refresh_ranged.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(particle)

	local abs = self.pos
	abs.z = abs.z + 100

	local geminate_lapse_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_weaver/weaver_timelapse.vpcf",
		PATTACH_WORLDORIGIN,
		self.parent
	)
	ParticleManager:SetParticleControl(geminate_lapse_particle, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(geminate_lapse_particle, 2, abs)
	ParticleManager:ReleaseParticleIndex(geminate_lapse_particle)

	for i = 0, 20 do
		local current_ability = self.parent:GetAbilityByIndex(i)
		if current_ability then
			if not current_ability:IsActivated() then
				current_ability.need_reset_cd = true
			else
				current_ability:EndCd(0)
			end
		end
	end

	ProjectileManager:ProjectileDodge(self.parent)
	self.parent:Purge(false, true, false, true, true)

	self.parent:SetHealth(self.parent:GetMaxHealth() * self.health_level)
	self.parent:SetMana(self.parent:GetMaxMana() * self.mana_level)

	FindClearSpaceForUnit(self.parent, self.pos, true)
end

modifier_invoker_invoke_custom_legendary_illusion = class(mod_hidden)
function modifier_invoker_invoke_custom_legendary_illusion:GetStatusEffectName()
	return "particles/status_fx/status_effect_huskar_lifebreak.vpcf"
end
function modifier_invoker_invoke_custom_legendary_illusion:StatusEffectPriority()
	return MODIFIER_PRIORITY_ILLUSION
end
function modifier_invoker_invoke_custom_legendary_illusion:OnCreated()
	if not IsServer() then
		return
	end
	self.caster = self:GetCaster()
	self.parent = self:GetParent()

	self.caster:AddDamageEvent_out(self, true)
	self.parent:GenericParticle(
		"particles/econ/items/faceless_void/faceless_void_bracers_of_aeons/fv_bracers_of_aeons_dialatedebuf.vpcf",
		self
	)

	self.freeze = false
	self.targets = {}

	self.t = -1
	self.timer = self:GetRemainingTime() * 2
	self.parent:StartGesture(ACT_DOTA_TELEPORT)

	self:OnIntervalThink()
	self:StartIntervalThink(0.5)
end

function modifier_invoker_invoke_custom_legendary_illusion:OnIntervalThink()
	if not IsServer() then
		return
	end

	if self.t ~= -1 then
		self.freeze = true
	end

	self.t = self.t + 1

	local number = (self.timer - self.t) / 2
	local int = number
	if number % 1 ~= 0 then
		int = number - 0.5
	end

	local digits = math.floor(math.log10(number)) + 2

	local decimal = number % 1

	if decimal == 0.5 then
		decimal = 8
	else
		decimal = 1
	end

	local particle =
		ParticleManager:CreateParticle("particles/huskar/huskar_timer.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
	ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(0, int, decimal))
	ParticleManager:SetParticleControl(particle, 2, Vector(digits, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)
end

function modifier_invoker_invoke_custom_legendary_illusion:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_FROZEN] = self.freeze,
	}
end

function modifier_invoker_invoke_custom_legendary_illusion:DamageEvent_out(params)
	if not IsServer() then
		return
	end
	if not params.attacker then
		return
	end
	if not params.unit:IsRealHero() then
		return
	end
	if self.caster ~= params.attacker then
		return
	end
	if self.targets[params.unit:GetTeamNumber()] then
		return
	end

	self.targets[params.unit:GetTeamNumber()] = true

	AddFOWViewer(params.unit:GetTeamNumber(), self.parent:GetAbsOrigin(), 10, self:GetRemainingTime(), false)
end

invoker_deafening_blast_custom = class({})
invoker_deafening_blast_custom.talents = {}

function invoker_deafening_blast_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/units/heroes/hero_invoker/invoker_deafening_blast.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_invoker/invoker_deafening_blast_knockback_debuff.vpcf",
		context
	)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_invoker/invoker_deafening_blast_disarm_debuff.vpcf",
		context
	)
	PrecacheResource("particle", "particles/status_fx/status_effect_iceblast.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/econ/items/invoker/invoker_ti6/invoker_deafening_blast_disarm_ti6_debuff.vpcf",
		context
	)
	PrecacheResource(
		"particle",
		"particles/econ/items/invoker/invoker_ti6/invoker_deafening_blast_ti6_knockback_debuff.vpcf",
		context
	)
end

function invoker_deafening_blast_custom:UpdateTalents()
	local caster = self:GetCaster()
	if not self.init then
		self.init = true
		self.talents = {
			h2_duration = 0,

			has_h6 = 0,
			h6_count = caster:GetTalentValue("modifier_invoker_hero_6", "count", true),

			has_s4 = 0,
			s4_cd = caster:GetTalentValue("modifier_invoker_spells_4", "cd", true),
		}
	end

	if caster:HasTalent("modifier_invoker_hero_2") then
		self.talents.h2_duration = caster:GetTalentValue("modifier_invoker_hero_2", "duration")
	end

	if caster:HasTalent("modifier_invoker_hero_6") then
		self.talents.has_h6 = 1
	end

	if caster:HasTalent("modifier_invoker_spells_4") then
		self.talents.has_s4 = 1
	end
end

function invoker_deafening_blast_custom:GetAbilityTextureName()
	return wearables_system:GetAbilityIconReplacement(self.caster, "invoker_deafening_blast", self)
end

function invoker_deafening_blast_custom:GetIntrinsicModifierName()
	if self:GetCaster():GetUnitName() == "npc_dota_hero_invoker" then
		return
	end
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_invoker_stolen_ability_tracker"
end

function invoker_deafening_blast_custom:GetCooldown(level)
	return self.BaseClass.GetCooldown(self, level)
		+ ((self.talents.has_s4 == 1 and self.caster:HasScepter()) and self.talents.s4_cd or 0)
end

function invoker_deafening_blast_custom:OnSpellStart()
	self.caster:StartGesture(ACT_DOTA_CAST_DEAFENING_BLAST)

	local target_loc = self:GetCursorPosition()
	local caster_loc = self.caster:GetAbsOrigin()

	if target_loc == caster_loc then
		target_loc = target_loc + self.caster:GetForwardVector()
	end

	local direction = (target_loc - caster_loc):Normalized()

	local thinker = CreateModifierThinker(
		self.caster,
		self,
		"modifier_invoker_invoke_custom_blast_thinker",
		{},
		caster_loc,
		self.caster:GetTeamNumber(),
		false
	)
	thinker.hit_targets = {}

	local projectile = {
		Ability = self,
		EffectName = wearables_system:GetParticleReplacementAbility(
			self.caster,
			"particles/units/heroes/hero_invoker/invoker_deafening_blast.vpcf",
			self
		),
		vSpawnOrigin = caster_loc,
		fDistance = self.travel_distance,
		fStartRadius = self.radius_start,
		fEndRadius = self.radius_end,
		Source = self.caster,
		bHasFrontalCone = false,
		bReplaceExisting = false,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		fExpireTime = GameRules:GetGameTime() + 10.5,
		bDeleteOnHit = false,
		bProvidesVision = false,
		ExtraData = { thinker = thinker:entindex() },
	}

	local count = 0
	if self.talents.has_h6 == 1 then
		count = self.talents.h6_count
	end

	for i = 0, count do
		projectile.vVelocity = RotatePosition(Vector(0, 0, 0), QAngle(0, i * 30, 0), direction) * self.travel_speed
		ProjectileManager:CreateLinearProjectile(projectile)
	end
	self.caster:EmitSound(wearables_system:GetSoundReplacement(self.caster, "Hero_Invoker.DeafeningBlast", self))
end

function invoker_deafening_blast_custom:OnProjectileHit_ExtraData(target, location, ExtraData)
	local thinker = EntIndexToHScript(ExtraData.thinker)
	if not thinker then
		return
	end

	if not target then
		UTIL_Remove(thinker)
		return nil
	end

	if thinker.hit_targets[target:entindex()] then
		return
	end
	thinker.hit_targets[target:entindex()] = true

	if IsValid(self.caster.invoke_ability) then
		self.caster.invoke_ability:AbilityHit(target)
	end

	local knockback_duration = self.knockback_duration + self.talents.h2_duration
	local disarm_duration = self.disarm_duration + self.talents.h2_duration
	local knockback_distance = knockback_duration * self.knockback_speed

	local center = location
	if location == target:GetAbsOrigin() then
		center = self.caster:GetAbsOrigin()
	end

	local direction = (target:GetAbsOrigin() - center):Normalized()
	direction.z = 0

	local point = target:GetAbsOrigin() + direction * knockback_distance

	local knockback = target:AddNewModifier(self.caster, self, "modifier_generic_arc", {
		target_x = point.x,
		target_y = point.y,
		distance = knockback_distance,
		duration = knockback_duration,
		height = 0,
		fix_end = true,
		isStun = false,
	})

	if knockback then
		local particle_name_knockback = wearables_system:GetParticleReplacementAbility(
			self.caster,
			"particles/units/heroes/hero_invoker/invoker_deafening_blast_knockback_debuff.vpcf",
			self
		)
		target:GenericParticle(particle_name_knockback, knockback)
	end

	DoDamage({
		victim = target,
		attacker = self.caster,
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	})
	target:AddNewModifier(
		self.caster,
		self,
		"modifier_invoker_deafening_blast_custom",
		{ duration = disarm_duration * (1 - target:GetStatusResistance()) }
	)
end

modifier_invoker_invoke_custom_blast_thinker = class(mod_hidden)

modifier_invoker_deafening_blast_custom = class(mod_visible)
function modifier_invoker_deafening_blast_custom:IsPurgeException()
	return false
end
function modifier_invoker_deafening_blast_custom:GetTexture()
	return "invoker_deafening_blast"
end
function modifier_invoker_deafening_blast_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_iceblast.vpcf"
end
function modifier_invoker_deafening_blast_custom:StatusEffectPriority()
	return MODIFIER_PRIORITY_HIGH
end
function modifier_invoker_deafening_blast_custom:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	local particle_name = wearables_system:GetParticleReplacementAbility(
		self.caster,
		"particles/units/heroes/hero_invoker/invoker_deafening_blast_disarm_debuff.vpcf",
		self.ability
	)
	self.parent:GenericParticle(particle_name, self, true)
end

function modifier_invoker_deafening_blast_custom:CheckState()
	return {
		[MODIFIER_STATE_DISARMED] = true,
	}
end

modifier_invoker_stolen_ability_tracker = class(mod_hidden)
function modifier_invoker_stolen_ability_tracker:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	InvokerAbilityManager(self.parent)
end

function modifier_invoker_stolen_ability_tracker:OnRefresh()
	InvokerAbilityManager(self.parent)
end