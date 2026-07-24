--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_ancient_apparition_17=class({})

function modifier_ancient_apparition_17:IsHidden() return true end
function modifier_ancient_apparition_17:IsPurgable() return false end
function modifier_ancient_apparition_17:IsPurgeException() return false end
function modifier_ancient_apparition_17:RemoveOnDeath() return false end

function modifier_ancient_apparition_17:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_ancient_apparition_17:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_ancient_apparition_17:DeclareFunctions()
    return
    {
         
    }
end

function modifier_ancient_apparition_17:OnTakeDamage(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if params.attacker == self:GetParent() then return end
    local ancient_apparition_ice_blast_custom = self:GetCaster():FindAbilityByName("ancient_apparition_ice_blast_custom")
    if ancient_apparition_ice_blast_custom and ancient_apparition_ice_blast_custom:GetLevel() > 0 then
        local modifier_ancient_apparition_ice_blast_custom_debuff = params.attacker:FindModifierByName("modifier_ancient_apparition_ice_blast_custom_debuff")
        if modifier_ancient_apparition_ice_blast_custom_debuff and modifier_ancient_apparition_ice_blast_custom_debuff:GetRemainingTime() > duration then return end
        ancient_apparition_ice_blast_custom:AttackEffect(params.attacker)
    end
end