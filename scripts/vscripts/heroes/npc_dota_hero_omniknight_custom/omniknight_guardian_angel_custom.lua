--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_omniknight_guardian_angel_custom", "heroes/npc_dota_hero_omniknight_custom/omniknight_guardian_angel_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_omniknight_guardian_angel_custom_aura", "heroes/npc_dota_hero_omniknight_custom/omniknight_guardian_angel_custom", LUA_MODIFIER_MOTION_NONE )

omniknight_guardian_angel_custom = class({})

function omniknight_guardian_angel_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_omniknight/omniknight_guardian_angel_ally.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_omniknight/omniknight_guardian_angel_omni.vpcf", context )
end

omniknight_guardian_angel_custom.modifier_omniknight_20 = {50,100,150}

function omniknight_guardian_angel_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function omniknight_guardian_angel_custom:OnSpellStart()
	if not IsServer() then return end
    local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("duration")
	local radius = self:GetSpecialValueFor("radius")
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_omniknight_guardian_angel_custom_aura", {duration = duration} )
	self:GetCaster():EmitSound("Hero_Omniknight.GuardianAngel.Cast")
end

modifier_omniknight_guardian_angel_custom_aura = class({})
function modifier_omniknight_guardian_angel_custom_aura:IsPurgable() return false end
function modifier_omniknight_guardian_angel_custom_aura:IsPurgeException() return false end
function modifier_omniknight_guardian_angel_custom_aura:IsAura() return true end
function modifier_omniknight_guardian_angel_custom_aura:GetModifierAura() return "modifier_omniknight_guardian_angel_custom" end
function modifier_omniknight_guardian_angel_custom_aura:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("radius") end
function modifier_omniknight_guardian_angel_custom_aura:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_omniknight_guardian_angel_custom_aura:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_omniknight_guardian_angel_custom_aura:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES end
function modifier_omniknight_guardian_angel_custom_aura:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_guardian_angel_aura.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 1, Vector( self:GetAbility():GetSpecialValueFor("radius"), 0, 1 ))
    self:AddParticle(particle, false, false, -1, false, false)
end

modifier_omniknight_guardian_angel_custom = class({})

function modifier_omniknight_guardian_angel_custom:IsPurgable()
	return true
end

function modifier_omniknight_guardian_angel_custom:OnCreated( kv )
	if not IsServer() then return end
	self:PlayEffects()
end

function modifier_omniknight_guardian_angel_custom:OnRefresh( kv )
	if not IsServer() then return end
	self:GetParent():EmitSound("Hero_Omniknight.GuardianAngel")
end

function modifier_omniknight_guardian_angel_custom:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	}
	return funcs
end

function modifier_omniknight_guardian_angel_custom:GetModifierConstantManaRegen()
    if not self:GetParent():HasModifier("modifier_omniknight_20") then return end
    return self:GetAbility().modifier_omniknight_20[self:GetCaster():GetTalentLevel("modifier_omniknight_20")]
end

function modifier_omniknight_guardian_angel_custom:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_omniknight_guardian_angel_custom:PlayEffects()
	self:GetParent():EmitSound("Hero_Omniknight.GuardianAngel")
	local particle_cast = "particles/units/heroes/hero_omniknight/omniknight_guardian_angel_ally.vpcf"
	if self:GetParent()==self:GetCaster() then
		particle_cast = "particles/units/heroes/hero_omniknight/omniknight_guardian_angel_omni.vpcf"
	end
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( effect_cast, 5, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true )
	self:AddParticle( effect_cast, false, false, -1, false, false )
end