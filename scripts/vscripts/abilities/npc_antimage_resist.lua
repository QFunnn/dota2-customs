--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_antimage_resist", "abilities/npc_antimage_resist", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_antimage_bkb", "abilities/npc_antimage_resist", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_antimage_bkb_cd", "abilities/npc_antimage_resist", LUA_MODIFIER_MOTION_NONE)

npc_antimage_resist = class({})


function npc_antimage_resist:GetIntrinsicModifierName() return "modifier_antimage_resist" end
 
modifier_antimage_resist = class ({})

function modifier_antimage_resist:IsHidden() return true end
function modifier_antimage_resist:IsPurgable() return false end

function modifier_antimage_resist:DeclareFunctions() return {

    MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,

} end


function modifier_antimage_resist:GetModifierMagicalResistanceBonus() return self:GetAbility():GetSpecialValueFor("resist") end


function modifier_antimage_resist:OnCreated(table)
self.parent = self:GetParent()
self.parent:AddDamageEvent_inc(self, true)
end

function modifier_antimage_resist:DamageEvent_inc(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end
if self.parent:HasModifier("modifier_antimage_bkb_cd") then return end
if self.parent:GetHealthPercent() > self:GetAbility():GetSpecialValueFor("health") then return end
if not self.parent:IsAlive() then return end

self.parent:Purge(false, true, false, true, true)
self.parent:EmitSound("DOTA_Item.MinotaurHorn.Cast")
self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_generic_debuff_immune", {magic = -50, effect = 1, duration = self:GetAbility():GetSpecialValueFor("bkb")})
self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_antimage_bkb_cd", {})
end


modifier_antimage_bkb_cd = class({})
function modifier_antimage_bkb_cd:IsHidden() return true end
function modifier_antimage_bkb_cd:IsPurgable() return false end



modifier_antimage_bkb = class({})
function modifier_antimage_bkb:IsHidden() return false end
function modifier_antimage_bkb:IsPurgable() return false end
function modifier_antimage_bkb:CheckState() return {[MODIFIER_STATE_MAGIC_IMMUNE] = true} end
function modifier_antimage_bkb:GetEffectName() return "particles/items5_fx/minotaur_horn.vpcf" end