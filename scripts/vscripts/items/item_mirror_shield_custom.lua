--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_mirror_shield_custom", "items/item_mirror_shield_custom", LUA_MODIFIER_MOTION_NONE)

item_mirror_shield_custom = class({})

function item_mirror_shield_custom:GetIntrinsicModifierName()
    return "modifier_item_mirror_shield_custom"
end

modifier_item_mirror_shield_custom = class({})
function modifier_item_mirror_shield_custom:IsPurgable() return false end
function modifier_item_mirror_shield_custom:IsPurgeException() return false end
function modifier_item_mirror_shield_custom:IsHidden() return true end
function modifier_item_mirror_shield_custom:RemoveOnDeath() return false end

function modifier_item_mirror_shield_custom:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
end

function modifier_item_mirror_shield_custom:OnIntervalThink()
    if not IsServer() then return end
    local removed = false
    local item_linken_sphere = self:GetCaster():FindItemInInventory("item_sphere")
    if item_linken_sphere and item_linken_sphere:IsFullyCastable() then
        removed = true
    end
    if not self:GetAbility():IsFullyCastable() then
        removed = true
    end
    local modifier_mirror_shield_delay = self:GetParent():FindModifierByName("modifier_mirror_shield_delay")
    if modifier_mirror_shield_delay then
        if self:GetAbility():IsFullyCastable() then
            modifier_mirror_shield_delay:Destroy()
        else
            self:GetAbility():UseResources(false, false, false, true)
        end
    end
    if removed then
        if self.modifier_item_mirror_shield then
            self.modifier_item_mirror_shield:Destroy()
            self.modifier_item_mirror_shield = nil
        end
    else
        if not self.modifier_item_mirror_shield then
            self.modifier_item_mirror_shield = self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_mirror_shield", {})
        end
    end
end

function modifier_item_mirror_shield_custom:OnDestroy()
    if not IsServer() then return end
    if self.modifier_item_mirror_shield then
        self.modifier_item_mirror_shield:Destroy()
        self.modifier_item_mirror_shield = nil
    end
end