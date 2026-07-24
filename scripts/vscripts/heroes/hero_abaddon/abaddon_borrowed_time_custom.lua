--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_abaddon_borrowed_time_custom", "heroes/hero_abaddon/abaddon_borrowed_time_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_abaddon_borrowed_time_custom_buff", "heroes/hero_abaddon/abaddon_borrowed_time_custom", LUA_MODIFIER_MOTION_NONE )

abaddon_borrowed_time_custom = class({})

function abaddon_borrowed_time_custom:GetIntrinsicModifierName()
	return "modifier_abaddon_borrowed_time_custom"
end

function abaddon_borrowed_time_custom:OnSpellStart()
	if not IsServer() then return end
	local buff_duration = self:GetSpecialValueFor("duration")
	self:GetCaster():Purge(false, true, false, true, false)
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_abaddon_borrowed_time_custom_buff", { duration = buff_duration })
end

modifier_abaddon_borrowed_time_custom = class({})
function modifier_abaddon_borrowed_time_custom:IsHidden() return true end
function modifier_abaddon_borrowed_time_custom:IsPurgeException() return false end
function modifier_abaddon_borrowed_time_custom:IsPurgable() return false end
function modifier_abaddon_borrowed_time_custom:RemoveOnDeath() return false end
function modifier_abaddon_borrowed_time_custom:TakeDamageScriptModifier(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if params.damage <= 0 then return end
    if self:GetParent():IsIllusion() then return end
    if self:GetParent():PassivesDisabled() then return end
    if params.damage >= self:GetParent():GetHealth() then return end
    if self:GetParent():GetHealth() <= self:GetAbility():GetSpecialValueFor("hp_threshold") and self:GetAbility():IsFullyCastable() then
        self:GetAbility():OnSpellStart()
        self:GetAbility():UseResources(false, false, false, true)
    end
end

modifier_abaddon_borrowed_time_custom_buff = class({
	IsHidden				= function(self) return false end,
	IsPurgable	  			= function(self) return false end,
	IsDebuff	  			= function(self) return false end,
	GetEffectName			= function(self) return "particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf" end,
	GetEffectAttachType		= function(self) return PATTACH_ABSORIGIN_FOLLOW end,
	GetStatusEffectName		= function(self) return "particles/status_fx/status_effect_abaddon_borrowed_time.vpcf" end,
	StatusEffectPriority	= function(self) return 15 end,
})

function modifier_abaddon_borrowed_time_custom_buff:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
    }
end

function modifier_abaddon_borrowed_time_custom_buff:OnCreated()
	if IsServer() then
		local target = self:GetParent()
		target:EmitSound("Hero_Abaddon.BorrowedTime")
		target:Purge(false, true, false, true, false)
	end
end

function modifier_abaddon_borrowed_time_custom_buff:GetAbsoluteNoDamagePhysical(params)
    self:HealHero(params)
	return 1
end

function modifier_abaddon_borrowed_time_custom_buff:GetAbsoluteNoDamageMagical(params)
    self:HealHero(params)
	return 1
end

function modifier_abaddon_borrowed_time_custom_buff:GetAbsoluteNoDamagePure(params)
    self:HealHero(params)
	return 1
end

function modifier_abaddon_borrowed_time_custom_buff:HealHero(params)
    if not IsServer() then return end
    if params.damage <= 0 then return end
    local particle_heal = ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_borrowed_time_heal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle_heal, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(particle_heal, 1, params.attacker:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle_heal)
    self:GetParent():Heal(params.damage, self:GetAbility())
end