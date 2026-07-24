--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- furbolg_enrage_damage rewrite

LinkLuaModifier("modifier_devour_enrage_damage", "abilities/heroes/doom/devour_enrage_damage.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_devour_enrage_damage_buff", "abilities/heroes/doom/devour_enrage_damage.lua", LUA_MODIFIER_MOTION_NONE)

devour_enrage_damage = devour_enrage_damage or class({})

function devour_enrage_damage:GetIntrinsicModifierName()
	return "modifier_devour_enrage_damage"
end


modifier_devour_enrage_damage = modifier_devour_enrage_damage or class({})

function modifier_devour_enrage_damage:IsHidden() return true end
function modifier_devour_enrage_damage:IsPurgable() return false end
function modifier_devour_enrage_damage:IsDebuff() return false end

function modifier_devour_enrage_damage:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_devour_enrage_damage:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not self.caster or self.caster:IsNull() then return end
	if not self.ability or self.ability:IsNull() then return end

	self.duration = self.ability:GetSpecialValueFor("duration")
	self.radius = self.ability:GetSpecialValueFor("radius")
end

function modifier_devour_enrage_damage:OnRefresh()
	self:OnCreated()
end

function modifier_devour_enrage_damage:OnDeath(kv)
	if not IsServer() then return end
	if not kv.unit or not kv.attacker or not kv.unit:IsRealHero() or kv.unit:IsReincarnating() then return end
	if kv.unit ~= self.caster then return end

	local allies = FindUnitsInRadius(
					self.caster:GetTeamNumber(),
					self.caster:GetAbsOrigin(),
					nil,
					self.radius,
					DOTA_UNIT_TARGET_TEAM_FRIENDLY,
					DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)

	for _, ally in pairs(allies) do
		if ally and not ally:IsNull() then
			ally:AddNewModifier(self.caster, self.ability, "modifier_devour_enrage_damage_buff", {duration = self.duration})
		end
	end
end


modifier_devour_enrage_damage_buff = modifier_devour_enrage_damage_buff or class({})

function modifier_devour_enrage_damage_buff:IsHidden() return false end
function modifier_devour_enrage_damage_buff:IsPurgable() return true end
function modifier_devour_enrage_damage_buff:IsDebuff() return false end

function modifier_devour_enrage_damage_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_devour_enrage_damage_buff:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not self.caster or self.caster:IsNull() then return end
	if not self.ability or self.ability:IsNull() then return end

	self.bonus_dmg_pct = self.ability:GetSpecialValueFor("bonus_dmg_pct")
end

function modifier_devour_enrage_damage_buff:OnRefresh()
	self:OnCreated()
end

function modifier_devour_enrage_damage_buff:GetModifierBaseDamageOutgoing_Percentage() return self.bonus_dmg_pct end