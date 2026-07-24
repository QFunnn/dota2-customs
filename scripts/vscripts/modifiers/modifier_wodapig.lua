--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_wodapig = class({})

function modifier_wodapig:IsPurgable() return false end

function modifier_wodapig:IsHidden() return true end

function modifier_wodapig:RemoveOnDeath() return false end

function modifier_wodapig:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/econ/courier/courier_devourling_gold/courier_devourling_gold_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_wodapig:DeclareFunctions()
	local decFuncs = {
		 
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
	}
	return decFuncs
end

function modifier_wodapig:CheckState()
	return {[MODIFIER_STATE_DEBUFF_IMMUNE] = true}
end

function modifier_wodapig:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_wodapig:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_wodapig:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_wodapig:OnAttackLanded(keys)
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

function modifier_wodapig:GetStatusEffectName()
    return "particles/status_fx/status_effect_phantom_lancer_illstrong.vpcf"
end

function modifier_wodapig:StatusEffectPriority()
    return 10000
end