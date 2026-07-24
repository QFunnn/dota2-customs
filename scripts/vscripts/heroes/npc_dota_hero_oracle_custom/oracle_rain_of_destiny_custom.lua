--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_oracle_rain_of_destiny_custom", "heroes/npc_dota_hero_oracle_custom/oracle_rain_of_destiny_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_oracle_rain_of_destiny_custom_buff", "heroes/npc_dota_hero_oracle_custom/oracle_rain_of_destiny_custom", LUA_MODIFIER_MOTION_NONE)

oracle_rain_of_destiny_custom = class({})

function oracle_rain_of_destiny_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_scepter_rain_of_destiny.vpcf", context )
end

function oracle_rain_of_destiny_custom:OnSpellStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_oracle_rain_of_destiny_custom", {duration = self:GetSpecialValueFor("duration")})
end

modifier_oracle_rain_of_destiny_custom = class({})

function modifier_oracle_rain_of_destiny_custom:IsPurgable() return false end
function modifier_oracle_rain_of_destiny_custom:IsPurgeException() return false end

function modifier_oracle_rain_of_destiny_custom:OnCreated()
	if not IsServer() then return end
	self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_scepter_rain_of_destiny.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt( self.particle, 0, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetAbsOrigin(), true )
	ParticleManager:SetParticleControl(self.particle, 1, Vector(self:GetAbility():GetSpecialValueFor("radius"), self:GetAbility():GetSpecialValueFor("radius"), self:GetAbility():GetSpecialValueFor("radius")))
	self:AddParticle(self.particle, false, false, -1, false, false)
end

function modifier_oracle_rain_of_destiny_custom:GetAuraDuration()
	return 0.1
end

function modifier_oracle_rain_of_destiny_custom:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_oracle_rain_of_destiny_custom:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_oracle_rain_of_destiny_custom:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end

function modifier_oracle_rain_of_destiny_custom:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_oracle_rain_of_destiny_custom:GetModifierAura()
	return "modifier_oracle_rain_of_destiny_custom_buff"
end

function modifier_oracle_rain_of_destiny_custom:IsAura()
	return true
end

function modifier_oracle_rain_of_destiny_custom:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

modifier_oracle_rain_of_destiny_custom_buff = class({})

function modifier_oracle_rain_of_destiny_custom_buff:OnCreated()
	self.heal_amp = self:GetAbility():GetSpecialValueFor("heal_amp")
	if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		self.heal_amp = self.heal_amp * (-1)
	end
	if not IsServer() then return end
	self:StartIntervalThink(1)
end

function modifier_oracle_rain_of_destiny_custom_buff:OnIntervalThink()
	if not IsServer() then return end
	local damage = self:GetAbility():GetSpecialValueFor("base") + (self:GetCaster():GetManaRegen() / 100 * self:GetAbility():GetSpecialValueFor("percent"))
	if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		ApplyDamage({victim = self:GetParent(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, attacker = self:GetCaster(), ability = self:GetAbility()})
	else
		self:GetParent():Heal(damage, self:GetAbility())
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetParent(), damage, nil)
	end
end

function modifier_oracle_rain_of_destiny_custom_buff:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET
	}
end

function modifier_oracle_rain_of_destiny_custom_buff:GetModifierHealAmplify_PercentageTarget()
	return self.heal_amp
end