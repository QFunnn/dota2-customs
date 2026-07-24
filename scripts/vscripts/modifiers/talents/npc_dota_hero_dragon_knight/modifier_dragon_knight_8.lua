--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_dragon_knight_8=class({})

function modifier_dragon_knight_8:IsHidden() return true end
function modifier_dragon_knight_8:IsPurgable() return false end
function modifier_dragon_knight_8:IsPurgeException() return false end
function modifier_dragon_knight_8:RemoveOnDeath() return false end

function modifier_dragon_knight_8:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    if self:GetParent():HasModifier("modifier_dragon_knight_1") and self:GetParent():HasModifier("modifier_dragon_knight_8") and self:GetParent():HasModifier("modifier_dragon_knight_15") then
        local dragon_knight_elder_dragon_form_custom = self:GetCaster():FindAbilityByName("dragon_knight_elder_dragon_form_custom")
        if dragon_knight_elder_dragon_form_custom then
            dragon_knight_elder_dragon_form_custom:SetLevel(4)
            for i=1,4 do
                self:GetParent():RemoveModifierByName("modifier_dragon_knight_elder_dragon_form_custom_"..i)
            end
            self:GetParent():AddNewModifier( self:GetParent(), dragon_knight_elder_dragon_form_custom, "modifier_dragon_knight_elder_dragon_form_custom_4", {} )
        end
    end
end

function modifier_dragon_knight_8:OnIntervalThink()
    if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_wodawisp") then return end
    if self:GetParent():HasModifier("modifier_dragon_knight_1") and self:GetParent():HasModifier("modifier_dragon_knight_8") and self:GetParent():HasModifier("modifier_dragon_knight_15") then
        local dragon_knight_elder_dragon_form_custom = self:GetCaster():FindAbilityByName("dragon_knight_elder_dragon_form_custom")
        if dragon_knight_elder_dragon_form_custom and not self:GetParent():HasModifier("modifier_dragon_knight_elder_dragon_form_custom_4") then
            self:GetParent():AddNewModifier( self:GetParent(), dragon_knight_elder_dragon_form_custom, "modifier_dragon_knight_elder_dragon_form_custom_4", {} )
        end
    end
end

function modifier_dragon_knight_8:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end