--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chen_8=class({})

function modifier_chen_8:IsHidden() return true end
function modifier_chen_8:IsPurgable() return false end
function modifier_chen_8:IsPurgeException() return false end
function modifier_chen_8:RemoveOnDeath() return false end

function modifier_chen_8:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local chen_creep_mana_break = self:GetCaster():FindAbilityByName("chen_creep_mana_break")
    if chen_creep_mana_break then
        chen_creep_mana_break:SetLevel(self:GetStackCount())
        chen_creep_mana_break:SetHidden(false)
    end
    local chen_creep_visual_antimage = self:GetParent():FindAbilityByName("chen_creep_visual_antimage")
    if chen_creep_visual_antimage then
        chen_creep_visual_antimage:SetLevel(1)
        chen_creep_visual_antimage:SetHidden(false)
    end
end

function modifier_chen_8:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local chen_creep_mana_break = self:GetCaster():FindAbilityByName("chen_creep_mana_break")
    if chen_creep_mana_break then
        chen_creep_mana_break:SetLevel(self:GetStackCount())
        chen_creep_mana_break:SetHidden(false)
    end
end

function modifier_chen_8:DeclareFunctions()
    return
    {
         
    }
end

function modifier_chen_8:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.target == self:GetParent() then return end
	DoCleaveAttack(params.attacker, params.target, self:GetCaster():GetAbilityByIndex(0), params.original_damage / 100 * 25, 150, 360, 650, "particles/items_fx/battlefury_cleave.vpcf") 
end