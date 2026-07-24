--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_duel_teleporting = class({})

function modifier_duel_teleporting:IsHidden() return true end
function modifier_duel_teleporting:IsPurgable() return false end
function modifier_duel_teleporting:RemoveOnDeath() return false end
function modifier_duel_teleporting:IsPurgeException() return false end
function modifier_duel_teleporting:CheckState()
	return
	{
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_ROOTED] = true,
	}
end

function modifier_duel_teleporting:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
	}
	return funcs
end

function modifier_duel_teleporting:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_duel_teleporting:GetAbsoluteNoDamageMagical()
	return 1
end

function modifier_duel_teleporting:GetAbsoluteNoDamagePure()
	return 1
end

function modifier_duel_teleporting:OnCreated()
	if not IsServer() then return end
    self:GetParent():RemoveModifierByName("modifier_oracle_false_promise_custom")
	self.teleportFromEffect = ParticleManager:CreateParticle("particles/items2_fx/teleport_start.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(self.teleportFromEffect, 2, Vector(255, 255, 255))
	self:GetCaster():EmitSound("Portal.Loop_Appear")
end

function modifier_duel_teleporting:OnDestroy()
	if not IsServer() then return end
	self:GetCaster():StopSound("Portal.Loop_Appear")
	self:GetCaster():StopSound("Hero_Tinker.MechaBoots.Loop")
	if self.teleportFromEffect then
		ParticleManager:DestroyParticle(self.teleportFromEffect, true)
    	ParticleManager:ReleaseParticleIndex(self.teleportFromEffect)
    end
end

modifier_duel_teleporting_2 = class({})

function modifier_duel_teleporting_2:IsHidden() return true end
function modifier_duel_teleporting_2:IsPurgable() return false end
function modifier_duel_teleporting_2:RemoveOnDeath() return false end
function modifier_duel_teleporting_2:IsPurgeException() return false end
function modifier_duel_teleporting_2:CheckState()
	return
	{
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_ROOTED] = true,
	}
end

function modifier_duel_teleporting_2:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
	}
	return funcs
end

function modifier_duel_teleporting_2:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_duel_teleporting_2:GetAbsoluteNoDamageMagical()
	return 1
end

function modifier_duel_teleporting_2:GetAbsoluteNoDamagePure()
	return 1
end