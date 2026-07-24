--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_stunned_duel_custom", "modifiers/modifier_stunned_duel_custom", LUA_MODIFIER_MOTION_NONE)

modifier_wodaduel_boss_pve=class({})

function modifier_wodaduel_boss_pve:IsPurgable() 
	return false
end

function modifier_wodaduel_boss_pve:IsPurgeException()
	return false
end

function modifier_wodaduel_boss_pve:IsHidden() 
	return true 
end

function modifier_wodaduel_boss_pve:RemoveOnDeath() 
	return false
end

function modifier_wodaduel_boss_pve:OnCreated()
	if not IsServer() then return end

	self.death = true

	self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_stunned_duel_custom", {duration = 1})

	ProjectileManager:ProjectileDodge(self:GetParent())

	Timers:CreateTimer(0.25, function()
		self.particles = ParticleManager:CreateParticle("particles/woda_legion_duel_ring.vpcf", PATTACH_ABSORIGIN, self:GetParent())
		ParticleManager:SetParticleControl(self.particles, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(self.particles, 7, self:GetParent():GetAbsOrigin())
		self:GetParent():EmitSound("Hero_LegionCommander.Duel")
	end)

	Timers:CreateTimer(1, function()
		if self.particles then 
			ParticleManager:DestroyParticle(self.particles, false)
		end
		self:GetParent():StopSound("Hero_LegionCommander.Duel")
	end)

	self:StartIntervalThink(FrameTime())
end

function modifier_wodaduel_boss_pve:OnIntervalThink()
	if not IsServer() then return end
	arena_system:DuelPositionCheck(self:GetParent())
end






modifier_wodaduel_boss_pve_end=class({})

function modifier_wodaduel_boss_pve_end:IsPurgable() 
	return false
end

function modifier_wodaduel_boss_pve_end:IsPurgeException()
	return false
end

function modifier_wodaduel_boss_pve_end:IsHidden() 
	return true 
end

function modifier_wodaduel_boss_pve_end:RemoveOnDeath() 
	return false
end

function modifier_wodaduel_boss_pve_end:OnCreated()
	if not IsServer() then return end

	self.death = true

	self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_stunned_duel_custom", {duration = 1})

	ProjectileManager:ProjectileDodge(self:GetParent())

	Timers:CreateTimer(0.25, function()
		self.particles = ParticleManager:CreateParticle("particles/woda_legion_duel_ring.vpcf", PATTACH_ABSORIGIN, self:GetParent())
		ParticleManager:SetParticleControl(self.particles, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(self.particles, 7, self:GetParent():GetAbsOrigin())
		self:GetParent():EmitSound("Hero_LegionCommander.Duel")
	end)

	Timers:CreateTimer(1, function()
		if self.particles then 
			ParticleManager:DestroyParticle(self.particles, false)
		end
		self:GetParent():StopSound("Hero_LegionCommander.Duel")
	end)

	self:StartIntervalThink(FrameTime())
end

function modifier_wodaduel_boss_pve_end:OnIntervalThink()
	if not IsServer() then return end
	arena_system:EndDuelPositionCheck(self:GetParent())
end