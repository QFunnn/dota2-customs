--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_alchemist_goblins_greed_custom",
	"abilities/alchemist/alchemist_goblins_greed_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_alchemist_goblins_greed_custom_stack",
	"abilities/alchemist/alchemist_goblins_greed_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_alchemist_goblins_greed_custom_rune_cd",
	"abilities/alchemist/alchemist_goblins_greed_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_alchemist_goblins_greed_custom_runes",
	"abilities/alchemist/alchemist_goblins_greed_custom",
	LUA_MODIFIER_MOTION_NONE
)

alchemist_goblins_greed_custom = class({})
alchemist_goblins_greed_custom.talents = {}

function alchemist_goblins_greed_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/orange_drop.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf", context)
	PrecacheResource("particle", "particles/lc_wave.vpcf", context)
	PrecacheResource("particle", "particles/items2_fx/hand_of_midas.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_alchemist/alchemist_lasthit_coins.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_alchemist/alchemist_lasthit_msg_gold.vpcf", context)
	PrecacheResource("particle", "particles/generic_gameplay/rune_haste_owner.vpcf", context)
	PrecacheResource("particle", "particles/generic_gameplay/rune_doubledamage_owner.vpcf", context)
	PrecacheResource("particle", "particles/generic_gameplay/rune_regen_owner.vpcf", context)
	PrecacheResource("particle", "particles/generic_gameplay/rune_arcane_owner.vpcf", context)
	PrecacheResource("particle", "particles/lc_odd_proc_.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/econ/items/effigies/status_fx_effigies/status_effect_effigy_gold_lvl2.vpcf",
		context
	)
	PrecacheResource(
		"particle",
		"particles/econ/items/effigies/status_fx_effigies/gold_effigy_ambient_dire_lvl2.vpcf",
		context
	)
	PrecacheResource("particle", "particles/econ/events/ti9/shovel_smoke_cloud.vpcf", context)

	PrecacheResource("soundfile", "soundevents/npc_dota_hero_alchemist.vsndevts", context)
	dota1x6:PrecacheShopItems("npc_dota_hero_alchemist", context)
end

function alchemist_goblins_greed_custom:UpdateTalents()
	local caster = self:GetCaster()
	if not self.init then
		self.init = true
		self.talents = {
			has_h6 = 0,
			h6_cd = caster:GetTalentValue("modifier_alchemist_hero_6", "cd", true),
			h6_cdr = caster:GetTalentValue("modifier_alchemist_hero_6", "cdr", true),
			h6_max = caster:GetTalentValue("modifier_alchemist_hero_6", "max", true),

			has_r7 = 0,
			r7_points = caster:GetTalentValue("modifier_alchemist_rage_legendary", "points", true) / 100,
		}
	end

	if caster:HasTalent("modifier_alchemist_hero_6") then
		self.talents.has_h6 = 1
	end

	if caster:HasTalent("modifier_alchemist_rage_legendary") then
		self.talents.has_r7 = 1
	end
end

function alchemist_goblins_greed_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_alchemist_goblins_greed_custom"
end

modifier_alchemist_goblins_greed_custom = class(mod_visible)
function modifier_alchemist_goblins_greed_custom:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.ability.tracker = self
	self.parent.goblins_greed_ability = self.ability
	self.ability:UpdateTalents()

	self.parent:AddDeathEvent(self, true)

	self.ability.bonus_gold = self.ability:GetSpecialValueFor("bonus_gold")
	self.ability.bonus_bonus_gold = self.ability:GetSpecialValueFor("bonus_bonus_gold")
	self.ability.bonus_gold_cap = self.ability:GetSpecialValueFor("bonus_gold_cap")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.scepter_gold = self.ability:GetSpecialValueFor("scepter_gold")

	self.scepter_init = false

	if not IsServer() then
		return
	end
	self:CheckStack()

	if self.ability:IsStolen() then
		return
	end
	if not self.parent:IsRealHero() then
		return
	end

	self:StartIntervalThink(2)
end

function modifier_alchemist_goblins_greed_custom:OnIntervalThink()
	if not IsServer() then
		return
	end
	if self.ability:IsStolen() then
		return
	end
	if not self.parent:HasScepter() then
		return
	end
	if self.scepter_init then
		return
	end
	if not self.parent:IsAlive() then
		return
	end

	self.scepter_init = true

	local scepter = self.parent:FindItemInInventory("item_ultimate_scepter")
	if scepter and not scepter:IsNull() then
		scepter:StartCooldown(1)
	end

	local item = CreateItem("item_alchemist_recipe", self.parent, self.parent)
	self.parent:GenericParticle("particles/orange_drop.vpcf")
	EmitSoundOnEntityForPlayer("powerup_02", self.parent, self.parent:GetId())
	self.parent:AddItem(item)

	self:StartIntervalThink(-1)
end

function modifier_alchemist_goblins_greed_custom:CheckStack()
	if not IsServer() then
		return
	end
	local stack = self.ability.bonus_gold
	local mod = self.parent:FindModifierByName("modifier_alchemist_goblins_greed_custom_stack")
	if mod then
		stack = stack + mod:GetStackCount() * self.ability.bonus_bonus_gold
	end

	local more_gold = self.parent:HasScepter() and self.ability.scepter_gold or 0

	self:SetStackCount(math.min(self.ability.bonus_gold_cap + more_gold, stack))
end

function modifier_alchemist_goblins_greed_custom:DeathEvent(params)
	if not IsServer() then
		return
	end
	if params.attacker ~= self.parent then
		return
	end
	if self.parent:GetTeamNumber() == params.unit:GetTeamNumber() then
		return
	end
	if not params.unit:IsUnit() then
		return
	end
	if not self.parent:IsAlive() then
		return
	end

	local gold = self:GetStackCount()
	local target = params.unit

	if self.parent:GetQuest() == "Alch.Quest_7" and self.parent:QuestCompleted() == false then
		self.parent:UpdateQuest(gold)
	end

	self.parent:GiveGold(gold, nil, true, self.ability)

	local effect_name = wearables_system:GetParticleReplacementAbility(
		self.parent,
		"particles/units/heroes/hero_alchemist/alchemist_lasthit_coins.vpcf",
		self
	)

	local effect_cast = ParticleManager:CreateParticleForPlayer(
		effect_name,
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent,
		self.parent:GetPlayerOwner()
	)
	ParticleManager:SetParticleControl(effect_cast, 1, self.parent:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)

	local digit = string.len(tostring(math.floor(gold))) + 1
	local effect_cast_2 = ParticleManager:CreateParticleForPlayer(
		"particles/units/heroes/hero_alchemist/alchemist_lasthit_msg_gold.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent,
		self.parent:GetPlayerOwner()
	)
	ParticleManager:SetParticleControl(effect_cast_2, 1, Vector(0, gold, 0))
	ParticleManager:SetParticleControl(effect_cast_2, 2, Vector(1, digit, 0))
	ParticleManager:SetParticleControl(effect_cast_2, 3, Vector(255, 255, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast_2)

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_alchemist_goblins_greed_custom_stack",
		{ duration = self.ability.duration }
	)

	if
		target:IsCreep()
		and self.ability.talents.has_h6 == 1
		and not self.parent:HasModifier("modifier_alchemist_goblins_greed_custom_rune_cd")
	then
		local point = GetGroundPosition(self.parent:GetAbsOrigin() + self.parent:GetForwardVector() * 150, nil)

		EmitSoundOnLocationWithCaster(point, "Alch.gold", self.parent)
		CreateRune(point, DOTA_RUNE_BOUNTY)

		local effect_cast = ParticleManager:CreateParticle(
			"particles/econ/events/ti9/shovel_smoke_cloud.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(effect_cast, 0, point)
		ParticleManager:SetParticleControl(effect_cast, 1, point)
		ParticleManager:ReleaseParticleIndex(effect_cast)

		self.parent:AddNewModifier(
			self.parent,
			nil,
			"modifier_alchemist_goblins_greed_custom_rune_cd",
			{ duration = self.ability.talents.h6_cd }
		)
	end

	if self.ability.talents.has_r7 == 0 then
		return
	end

	local stats = CreepsStats[target:GetUnitName()]
	local points = stats and stats.blue
	if not points and Shared_Bounty[target:GetUnitName()] then
		points = Shared_Bounty[target:GetUnitName()].blue
	end

	if not points then
		return
	end
	self.parent:AddPoints("white", points * self.ability.talents.r7_points, "modifier_alchemist_rage_legendary")
end

modifier_alchemist_goblins_greed_custom_stack = class(mod_hidden)
function modifier_alchemist_goblins_greed_custom_stack:RemoveOnDeath()
	return false
end
function modifier_alchemist_goblins_greed_custom_stack:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.duration = self.ability.duration

	if not IsServer() then
		return
	end
	self.mod = self.ability.tracker

	self:OnRefresh()
end

function modifier_alchemist_goblins_greed_custom_stack:OnRefresh()
	if not IsServer() then
		return
	end

	Timers:CreateTimer(self.duration, function()
		if not IsValid(self) then
			return
		end
		self:DecrementStackCount()
		if self:GetStackCount() <= 0 then
			self:Destroy()
			return
		end
		if IsValid(self.mod) then
			self.mod:CheckStack()
		end
	end)

	self:IncrementStackCount()
	if IsValid(self.mod) then
		self.mod:CheckStack()
	end
end

function modifier_alchemist_goblins_greed_custom_stack:OnDestroy()
	if not IsServer() then
		return
	end
	if not IsValid(self.mod) then
		return
	end
	self.mod:CheckStack()
end

modifier_alchemist_goblins_greed_custom_runes = class({})
function modifier_alchemist_goblins_greed_custom_runes:IsHidden()
	return self.ability.talents.has_h6 == 0 or self:GetStackCount() >= self.max
end
function modifier_alchemist_goblins_greed_custom_runes:IsPurgable()
	return false
end
function modifier_alchemist_goblins_greed_custom_runes:RemoveOnDeath()
	return false
end
function modifier_alchemist_goblins_greed_custom_runes:GetTexture()
	return "buffs/alchemist/hero_7"
end
function modifier_alchemist_goblins_greed_custom_runes:OnCreated()
	self.parent = self:GetParent()
	self.ability = self.parent.goblins_greed_ability

	self.max = self.ability.talents.h6_max

	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.5)
	self:OnRefresh()
end

function modifier_alchemist_goblins_greed_custom_runes:OnRefresh()
	if not IsServer() then
		return
	end
	if self:GetStackCount() >= self.max then
		return
	end
	self:IncrementStackCount()
end

function modifier_alchemist_goblins_greed_custom_runes:OnIntervalThink()
	if not IsServer() then
		return
	end
	if self.ability.talents.has_h6 == 0 then
		return
	end
	if self:GetStackCount() < self.max then
		return
	end

	self.parent:GenericParticle("particles/lc_odd_proc_.vpcf")
	self.parent:EmitSound("BS.Thirst_legendary_active")
	self:StartIntervalThink(-1)
end

function modifier_alchemist_goblins_greed_custom_runes:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	}
end

function modifier_alchemist_goblins_greed_custom_runes:GetModifierPercentageCooldown()
	if not IsValid(self.parent) then
		return
	end
	if self.ability.talents.has_h6 == 0 then
		return
	end
	return (self.ability.talents.h6_cdr / self.max) * self:GetStackCount()
end

modifier_alchemist_goblins_greed_custom_rune_cd = class(mod_cd)
function modifier_alchemist_goblins_greed_custom_rune_cd:GetTexture()
	return "buffs/alchemist/hero_7"
end