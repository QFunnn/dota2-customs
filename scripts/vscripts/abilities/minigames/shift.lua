--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_minigames_pudge_shift", "abilities/minigames/shift.lua", LUA_MODIFIER_MOTION_NONE )

minigames_pudge_shift = class({})

function minigames_pudge_shift:Precache(context)
    PrecacheResource("particle", "particles/minigames/pudge_shift/pudge_shift_new.vpcf", context)
end

function minigames_pudge_shift:OnSpellStart()
    local caster = self:GetCaster()
    local MaxDuration = self:GetChannelTime()

    caster:AddNewModifier(caster, self, "modifier_minigames_pudge_shift", {duration=MaxDuration})
end

function minigames_pudge_shift:OnChannelFinish(bInterrupted)
    local caster = self:GetCaster()
    caster:RemoveModifierByName("modifier_minigames_pudge_shift")
end

modifier_minigames_pudge_shift = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

	CheckState				= function(self)
		return {
			[MODIFIER_STATE_INVULNERABLE] = true,
			[MODIFIER_STATE_OUT_OF_GAME] = true,
			[MODIFIER_STATE_UNSELECTABLE] = true,
		}
	end,

    OnCreated               = function(self)
        if not IsServer() then return end

        local parent = self:GetParent()

        ProjectileManager:ProjectileDodge(parent)

        local fx = ParticleManager:CreateParticle("particles/minigames/pudge_shift/pudge_shift_new.vpcf", PATTACH_WORLDORIGIN, parent)
        ParticleManager:SetParticleControl(fx, 0, parent:GetAbsOrigin())
        self:AddParticle(fx, false, false, -1, false, false)

        parent:EmitSound("Minigames.Shift")
        
        parent:AddNoDraw()
    end,

    OnDestroy               = function(self)
        if not IsServer() then return end

        local parent = self:GetParent()

	    parent:RemoveNoDraw()

        parent:StopSound("Minigames.Shift")
    end,
})