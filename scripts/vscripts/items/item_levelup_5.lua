--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 22:18:26 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_levelup_5", "items/item_levelup_5", LUA_MODIFIER_MOTION_NONE)

item_levelup_5 = class({})

function item_levelup_5:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local duration = self:GetSpecialValueFor("duration")
	local modifier_item_levelup_5 = caster:FindModifierByName("modifier_item_levelup_5")
	if modifier_item_levelup_5 then
		duration = modifier_item_levelup_5:GetRemainingTime() + duration
	end
	caster:AddNewModifier(caster, ability, "modifier_item_levelup_5", { duration = duration })
	ConsumeLevelUpItemCharge(caster, ability)
end

modifier_item_levelup_5 = class({})
function modifier_item_levelup_5:IsPurgable()
	return false
end
function modifier_item_levelup_5:IsPurgeException()
	return false
end
function modifier_item_levelup_5:OnCreated(params)
	self.heal = self:GetAbility():GetSpecialValueFor("heal")
	self.heal_regen = self:GetAbility():GetSpecialValueFor("heal_regen")
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	if not IsServer() then
		return
	end
	self.first_regen = true
	self:StartIntervalThink(1)
	self:OnIntervalThink()
end

function modifier_item_levelup_5:OnIntervalThink()
	if not IsServer() then
		return
	end
	local max_health = tonumber(self.caster._levelup_max_health) or 0
	local health_regen = max_health / 100 * self.heal_regen
	if self.first_regen then
		health_regen = max_health / 100 * self.heal
		self.first_regen = false
	end
	if self.caster._levelup_max_health and self.caster.LevelUpModifyHealth then
		self.caster:LevelUpModifyHealth(health_regen)
	end
end

function modifier_item_levelup_5:OnDestroy()
	if not IsServer() then
		return
	end
end