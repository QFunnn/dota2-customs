--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lone_druid_spotlight_moonlight", "heroes/npc_dota_hero_lone_druid_custom/lone_druid_spotlight_moonlight", LUA_MODIFIER_MOTION_NONE)

lone_druid_spotlight_moonlight = class({})

function lone_druid_spotlight_moonlight:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_lone_druid_spotlight_moonlight", {})
end

modifier_lone_druid_spotlight_moonlight = class({})

function modifier_lone_druid_spotlight_moonlight:IsPurgable() return false end

function modifier_lone_druid_spotlight_moonlight:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_lone_druid_spotlight_moonlight:OnCreated()
	if not IsServer() then return end
	self.wave = 0
	self.wave_max = self:GetCaster():GetIntellect(false) / self:GetAbility():GetSpecialValueFor("wave_intellect")
	local interval = self:GetAbility():GetSpecialValueFor("interval")
	self:StartIntervalThink(interval)
	self:GetParent():EmitSound("Ability.Starfall")
end

function modifier_lone_druid_spotlight_moonlight:OnIntervalThink()
	local point = self:GetParent():GetAbsOrigin()

	local units = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, 0, false )

	if #units > 0 then
		local lone_druid_moonlight = self:GetCaster():FindAbilityByName("lone_druid_moonlight")
		if lone_druid_moonlight and lone_druid_moonlight:GetLevel() > 0 then
			lone_druid_moonlight:StartMoonLight(units[RandomInt(1, #units)])
		end
	end

	self.wave = self.wave + 1

	if self.wave >= self.wave_max then
		self:Destroy()
	end
end