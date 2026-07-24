--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- furbolg_enrage_attack_speed rewrite

LinkLuaModifier("modifier_devour_enrage_attack_speed", "abilities/heroes/doom/devour_enrage_attack_speed.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_devour_enrage_attack_speed_buff", "abilities/heroes/doom/devour_enrage_attack_speed.lua", LUA_MODIFIER_MOTION_NONE)

devour_enrage_attack_speed = devour_enrage_attack_speed or class({})

function devour_enrage_attack_speed:GetIntrinsicModifierName()
	return "modifier_devour_enrage_attack_speed"
end


modifier_devour_enrage_attack_speed = devour_enrage_attack_speed or class({})

function modifier_devour_enrage_attack_speed:IsHidden() return true end
function modifier_devour_enrage_attack_speed:IsPurgable() return false end
function modifier_devour_enrage_attack_speed:IsDebuff() return false end

function modifier_devour_enrage_attack_speed:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_devour_enrage_attack_speed:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not self.caster or self.caster:IsNull() then return end
	if not self.ability or self.ability:IsNull() then return end

	self.duration = self.ability:GetSpecialValueFor("duration")
	self.radius = self.ability:GetSpecialValueFor("radius")
end

function modifier_devour_enrage_attack_speed:OnRefresh()
	self:OnCreated()
end

function modifier_devour_enrage_attack_speed:OnDeath(kv)
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
			ally:AddNewModifier(self.caster, self.ability, "modifier_devour_enrage_attack_speed_buff", {duration = self.duration})
		end
	end
end

-- TODO addon_english
modifier_devour_enrage_attack_speed_buff = devour_enrage_attack_speed_buff or class({})

function modifier_devour_enrage_attack_speed_buff:IsHidden() return false end
function modifier_devour_enrage_attack_speed_buff:IsPurgable() return true end
function modifier_devour_enrage_attack_speed_buff:IsDebuff() return false end

function modifier_devour_enrage_attack_speed_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_devour_enrage_attack_speed_buff:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not self.caster or self.caster:IsNull() then return end
	if not self.ability or self.ability:IsNull() then return end

	self.bonus_aspd = self.ability:GetSpecialValueFor("bonus_aspd")
end

function modifier_devour_enrage_attack_speed_buff:OnRefresh()
	self:OnCreated()
end

function modifier_devour_enrage_attack_speed_buff:GetModifierAttackSpeedBonus_Constant() return self.bonus_aspd end