--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_wodafrog = class({})

function modifier_wodafrog:IsPurgable() return false end

function modifier_wodafrog:IsHidden() return true end

function modifier_wodafrog:RemoveOnDeath() return false end

function modifier_wodafrog:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_arcana_ground_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_wodafrog:DeclareFunctions()
	local decFuncs = 
    {
		 
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
	}
	return decFuncs
end

function modifier_wodafrog:CheckState()
	return {[MODIFIER_STATE_DEBUFF_IMMUNE] = true}
end

function modifier_wodafrog:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_wodafrog:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_wodafrog:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_wodafrog:OnAttackLanded(keys)
    if not IsServer() then return end
    if keys.target == self:GetParent() then
        if keys.attacker:GetUnitName() == "npc_dota_thinker" then return end
        if self:GetParent():GetHealth() - 1 <= 0 then
            self:GetParent():Kill(nil, keys.attacker)
        else
            self:GetParent():SetHealth(self:GetParent():GetHealth() - 1)
        end
    end
end

function modifier_wodafrog:StatusEffectPriority()
    return 10000
end