--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_minigames_warrior_refraction", "abilities/minigames/refraction.lua", LUA_MODIFIER_MOTION_NONE )

minigames_warrior_refraction = class({})

function minigames_warrior_refraction:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_templar_assassin/templar_assassin_refraction.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_templar_assassin/templar_assassin_refract_plasma_contact_warp.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_templar_assassin/templar_assassin_refract_hit.vpcf", context)
end

function minigames_warrior_refraction:OnSpellStart()
    local caster = self:GetCaster()
    local Duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(caster, self, "modifier_minigames_warrior_refraction", {duration=Duration})
end

modifier_minigames_warrior_refraction = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

	DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_AVOID_DAMAGE
        }
    end,

	OnCreated				= function(self)
        local ability = self:GetAbility()
        local parent = self:GetParent()
        if ability then
            self.Blocks = ability:GetSpecialValueFor("block")
        end

        if not IsServer() then return end

        self:SetStackCount(self.Blocks)

        EmitSoundOn("Minigames.Refraction.Cast", parent)

        local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_templar_assassin/templar_assassin_refraction.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
        ParticleManager:SetParticleControlEnt(fx, 1, parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", parent:GetAbsOrigin(), true)
        self:AddParticle(fx, false, false, -1, true, false)
	end,

    GetModifierAvoidDamage           = function(self, event) 
		if self.Blocks > 0 then
            self.Blocks = self.Blocks - 1

            self:SetStackCount(self.Blocks)

            if IsServer() then
                local warp_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_templar_assassin/templar_assassin_refract_plasma_contact_warp.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
                ParticleManager:ReleaseParticleIndex(warp_particle)
                
                local hit_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_templar_assassin/templar_assassin_refract_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
                ParticleManager:SetParticleControlEnt(hit_particle, 2, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
                ParticleManager:ReleaseParticleIndex(hit_particle)

                EmitSoundOn("Minigames.Refraction.Absorb", self:GetParent())
            end

            if self.Blocks <= 0 then
                self:Destroy()
            end

            return 1
        end

        return 0
	end,
})