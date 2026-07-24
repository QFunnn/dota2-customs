--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_huskar_4_buff", "modifiers/talents/npc_dota_hero_huskar/modifier_huskar_4", LUA_MODIFIER_MOTION_NONE)

modifier_huskar_4=class({})

function modifier_huskar_4:IsHidden() return true end
function modifier_huskar_4:IsPurgable() return false end
function modifier_huskar_4:IsPurgeException() return false end
function modifier_huskar_4:RemoveOnDeath() return false end

function modifier_huskar_4:OnCreated()
    self.has_attack = 0
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_huskar_4:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_huskar_4:DeclareFunctions()
    return 
    {
         
    }
end

function modifier_huskar_4:OnAttackLanded(params)
    if not IsServer() then return end
    if params.target ~= self:GetParent() then return end
    if params.attacker == self:GetParent() then return end
    local huskar_burning_spear_custom = self:GetParent():FindAbilityByName("huskar_burning_spear_custom")
    if huskar_burning_spear_custom then
        local modifier_huskar_4_buff = params.attacker:FindModifierByName("modifier_huskar_4_buff")
        if modifier_huskar_4_buff == nil then
            modifier_huskar_4_buff = self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_huskar_4_buff",{})
        end
        self.has_attack = self.has_attack + 1
        if modifier_huskar_4_buff then
            modifier_huskar_4_buff:SetStackCount(self.has_attack)
        end
        if self.has_attack >= huskar_burning_spear_custom.modifier_huskar_4[self:GetStackCount()] then
            huskar_burning_spear_custom:AttackTarget(params.attacker)
            self.has_attack = 0
            if modifier_huskar_4_buff then
                modifier_huskar_4_buff:SetStackCount(0)
            end
        end
    end
end

modifier_huskar_4_buff = class({})
function modifier_huskar_4_buff:IsPurgable() return false end
function modifier_huskar_4_buff:IsPurgeException() return false end
function modifier_huskar_4_buff:RemoveOnDeath() return false end
function modifier_huskar_4_buff:GetTexture() return "huskar_4" end