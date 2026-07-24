--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_creature_tear_armor = class({})


function modifier_creature_tear_armor:GetTexture()
	return "ursa_fury_swipes"
end


function modifier_creature_tear_armor:IsHidden()
	return true
end

function modifier_creature_tear_armor:IsDebuff()
	return false
end

function modifier_creature_tear_armor:IsPurgable()
	return false
end

function modifier_creature_tear_armor:DeclareFunctions()
    local funcs = {
    	MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
	return funcs
end


function modifier_creature_tear_armor:OnAttackLanded(params)
    if IsServer() then
        if self:GetParent() == params.attacker then
            local hTarget = params.target
            if hTarget ~= nil then
                local hDebuff = hTarget:FindModifierByName("modifier_creature_berserk_debuff")
                if hDebuff == nil then
                    hDebuff = hTarget:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_creature_berserk_debuff", { duration = 12.0 })
                    if hDebuff ~= nil then
                        hDebuff:SetStackCount(0)
                    end
                end
                if hDebuff ~= nil then
                    local nLayer =  self:GetAbility():GetSpecialValueFor("armor_reduce")
                    hDebuff:SetStackCount(hDebuff:GetStackCount() + nLayer)
                    hDebuff:SetDuration(12.0, true)
                end
            end
        end
    end
    return 0
end