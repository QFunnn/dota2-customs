--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_stunned_duel_custom", "modifiers/modifier_stunned_duel_custom", LUA_MODIFIER_MOTION_NONE)

modifier_wodaduel_duo = class({})
function modifier_wodaduel_duo:IsPurgable() return false end
function modifier_wodaduel_duo:IsPurgeException() return false end
function modifier_wodaduel_duo:IsHidden() return true end
function modifier_wodaduel_duo:RemoveOnDeath() return false end

function modifier_wodaduel_duo:OnCreated(params)
	if not IsServer() then return end
	self.death = true
    if params.end_duel then
        self.end_duel = true
    end
	self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_stunned_duel_custom", {duration = 3})
	ProjectileManager:ProjectileDodge(self:GetParent())
	Timers:CreateTimer(0.25, function()
		self.particles = ParticleManager:CreateParticle("particles/woda_legion_duel_ring.vpcf", PATTACH_ABSORIGIN, self:GetParent())
		ParticleManager:SetParticleControl(self.particles, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(self.particles, 7, self:GetParent():GetAbsOrigin())
		self:GetParent():EmitSound("Hero_LegionCommander.Duel")
	end)
	Timers:CreateTimer(3, function()
		if self.particles then 
			ParticleManager:DestroyParticle(self.particles, false)
		end
		self:GetParent():StopSound("Hero_LegionCommander.Duel")
	end)
	self:StartIntervalThink(FrameTime())
end

function modifier_wodaduel_duo:OnIntervalThink()
	if not IsServer() then return end
    if self.end_duel then
        arena_system:EndDuelPositionCheck(self:GetParent())
    else
	    arena_system:DuelPositionCheck(self:GetParent())
    end
end

function modifier_wodaduel_duo:DeclareFunctions() 
    return 
    {
    	MODIFIER_EVENT_ON_DEATH
    }
end

function modifier_wodaduel_duo:OnDeath(params)
	if params.unit ~= self:GetParent() then return end
    if params.reincarnate then return end
	if self.death then
		self.death = false
        if self.end_duel then
            arena_system:EndGameDuo()
        else
		    arena_system:EndDuelDuo()
        end
	end
end