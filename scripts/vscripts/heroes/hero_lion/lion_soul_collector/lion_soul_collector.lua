--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


lion_soul_collector = class({})
LinkLuaModifier(
	"modifier_lion_soul_collector",
	"heroes/hero_lion/lion_soul_collector/lion_soul_collector",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_lion_soul_collector_debuff",
	"heroes/hero_lion/lion_soul_collector/lion_soul_collector",
	LUA_MODIFIER_MOTION_NONE
)

--------------------------------------------------------------------------------
function lion_soul_collector:GetIntrinsicModifierName()
	return "modifier_lion_soul_collector"
end

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

modifier_lion_soul_collector = class({})

function modifier_lion_soul_collector:IsHidden()
	if self:GetStackCount() >= 1 then
		return false
	else
		return true
	end
end

function modifier_lion_soul_collector:IsPurgable()
	return false
end

function modifier_lion_soul_collector:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_lion_soul_collector:RemoveOnDeath()
	return false
end

function modifier_lion_soul_collector:DestroyOnExpire()
	return false
end

function modifier_lion_soul_collector:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_lion_soul_collector:OnRefresh(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_lion_soul_collector:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	}
	return funcs
end

function modifier_lion_soul_collector:OnDeath(params)
	local parent = self:GetParent()

	if parent:PassivesDisabled() or parent:HasModifier("modifier_guild_event") then
		return
	end

	if params.unit:IsIllusion() then
		return
	end

	if not params.unit:FindModifierByNameAndCaster("modifier_lion_soul_collector_debuff", parent) then
		return
	end

	if not _G.excludedUnitsLookup[params.unit:GetUnitName()] then
		return
	end

	count = 1
	local abil = self:GetParent():FindAbilityByName("special_bonus_lion_int10")
	if abil ~= nil and abil:GetLevel() > 0 then
		count = 2
	end
	for i = 1, count do
		self:IncrementStackCount()
	end
end

function modifier_lion_soul_collector:IsAura()
	return (not self:GetCaster():PassivesDisabled())
end

function modifier_lion_soul_collector:GetModifierAura()
	return "modifier_lion_soul_collector_debuff"
end

function modifier_lion_soul_collector:GetAuraRadius()
	return self.radius
end

function modifier_lion_soul_collector:GetAuraDuration()
	return 0.5
end

function modifier_lion_soul_collector:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_lion_soul_collector:GetAuraSearchType()
	return DOTA_UNIT_TARGET_ALL
end

function modifier_lion_soul_collector:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_lion_soul_collector:IsAuraActiveOnDeath()
	return false
end

function modifier_lion_soul_collector:GetAuraEntityReject(hEntity)
	if IsServer() then
		if hEntity == self:GetCaster() then
			return true
		end
	end
	return false
end

-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------

modifier_lion_soul_collector_debuff = class({})

function modifier_lion_soul_collector_debuff:IsHidden()
	return true
end

function modifier_lion_soul_collector_debuff:IsPurgable()
	return false
end