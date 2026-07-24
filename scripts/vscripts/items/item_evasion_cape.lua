--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_evasion_cape_passive", "items/item_evasion_cape", LUA_MODIFIER_MOTION_NONE)

item_evasion_cape = class({})

function item_evasion_cape:Spawn()
    if not IsServer() then return end
    if not self.isActive then
        self.isActive = true
        self:SetCurrentCharges(3)
    end
end

function item_evasion_cape:GetIntrinsicModifierName()
	return "modifier_item_evasion_cape_passive"
end

function item_evasion_cape:OnChargeCountChanged(is_spent)
    if not IsServer() then return end
    if not is_spent then
        if self and self:GetCaster() then
            self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_consecrated_wraps_speed_buff", {duration = self:GetSpecialValueFor("duration")})
        end
    end
end

modifier_item_evasion_cape_passive = class({})
function modifier_item_evasion_cape_passive:IsHidden() return true end
function modifier_item_evasion_cape_passive:IsPurgable() return false end
function modifier_item_evasion_cape_passive:IsPurgeException() return false end
function modifier_item_evasion_cape_passive:OnCreated()
    if not IsServer() then return end
    self.modifier_item_consecrated_wraps = self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_consecrated_wraps", {})
end
function modifier_item_evasion_cape_passive:OnDestroy()
    if not IsServer() then return end
    if self.modifier_item_consecrated_wraps then
        self.modifier_item_consecrated_wraps:Destroy()
    end
end
function modifier_item_evasion_cape_passive:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_EVASION_CONSTANT,
    }
end

function modifier_item_evasion_cape_passive:GetModifierEvasion_Constant()
    return self:GetAbility():GetSpecialValueFor("bonus_evasion")
end