--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_oracle_change_of_fate", "heroes/npc_dota_hero_oracle_custom/oracle_change_of_fate", LUA_MODIFIER_MOTION_NONE)

oracle_change_of_fate = class({})

function oracle_change_of_fate:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/change_of_edict.vpcf", context )
end

function oracle_change_of_fate:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()

	if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		if target:TriggerSpellAbsorb(self) then return end
	end

	self:ApplyFatesEdict(target)
end

function oracle_change_of_fate:ApplyFatesEdict(target)
	self:GetCaster():EmitSound("Hero_Oracle.FatesEdict.Cast")

	target:EmitSound("Hero_Oracle.FatesEdict")

	local duration = self:GetSpecialValueFor("duration")

	if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		duration = duration * (1-target:GetStatusResistance())
	end

	target:AddNewModifier(self:GetCaster(), self, "modifier_oracle_change_of_fate", {duration = duration})
end

modifier_oracle_change_of_fate = class({})

function modifier_oracle_change_of_fate:IsDebuff() return true end
function modifier_oracle_change_of_fate:IsPurgeException() return false end
function modifier_oracle_change_of_fate:IsPurgable() return false end

function modifier_oracle_change_of_fate:GetEffectName()
	return "particles/change_of_edict.vpcf"
end

function modifier_oracle_change_of_fate:OnCreated()
	if not IsServer() then return end
	self:GetParent():EmitSound("Hero_Oracle.FatesEdict")
end

function modifier_oracle_change_of_fate:OnDestroy()
	if not IsServer() then return end
	self:GetParent():StopSound("Hero_Oracle.FatesEdict")
end

function modifier_oracle_change_of_fate:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_EVENT_ON_HEAL_RECEIVED,
		MODIFIER_PROPERTY_DISABLE_HEALING,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_PROPERTY_MIN_HEALTH,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
	}
end

function modifier_oracle_change_of_fate:GetAbsoluteNoDamagePhysical(params)
	if params.inflictor and params.inflictor:GetAbilityName() == "oracle_change_of_fate" then return end
    if params.damage <= 0 then return end
    if self:GetParent():HasModifier("modifier_abaddon_borrowed_time_custom_buff") then return end
	self:GetParent():SetHealth(math.min(self:GetParent():GetHealth() + params.damage, self:GetParent():GetMaxHealth()))
    return 1
end

function modifier_oracle_change_of_fate:GetAbsoluteNoDamageMagical(params)
	if params.inflictor and params.inflictor:GetAbilityName() == "oracle_change_of_fate" then return end
    if params.damage <= 0 then return end
    if self:GetParent():HasModifier("modifier_abaddon_borrowed_time_custom_buff") then return end
	self:GetParent():SetHealth(math.min(self:GetParent():GetHealth() + params.damage, self:GetParent():GetMaxHealth()))
    return 1
end

function modifier_oracle_change_of_fate:GetAbsoluteNoDamagePure(params)
	if params.inflictor and params.inflictor:GetAbilityName() == "oracle_change_of_fate" then return end
    if params.damage <= 0 then return end
    if self:GetParent():HasModifier("modifier_abaddon_borrowed_time_custom_buff") then return end
	self:GetParent():SetHealth(math.min(self:GetParent():GetHealth() + params.damage, self:GetParent():GetMaxHealth()))
    return 1
end

function modifier_oracle_change_of_fate:OnHealReceived(params)
	if params.unit == self:GetParent() and self:GetRemainingTime() >= 0 then
        if self:GetParent():HasModifier("modifier_abaddon_borrowed_time_custom_buff") then return end
		local damage_flag = DOTA_DAMAGE_FLAG_NON_LETHAL
		if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
			damage_flag = DOTA_DAMAGE_FLAG_NONE
		end
		ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = params.gain, damage_type = DAMAGE_TYPE_PURE, ability = self:GetAbility(), damage_flags = damage_flag + DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_HPLOSS })
	end
end

function modifier_oracle_change_of_fate:GetDisableHealing(params)
	return 1
end