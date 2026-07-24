--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_spider_passive", "abilities/npc_spider_passive.lua", LUA_MODIFIER_MOTION_NONE)

npc_spider_passive = class({})


function npc_spider_passive:GetIntrinsicModifierName() return "modifier_spider_passive" end
 
modifier_spider_passive = class ({})

function modifier_spider_passive:IsHidden() return true end

function modifier_spider_passive:OnCreated(table)
    if not IsServer() then return end
 self:SetHasCustomTransmitterData(true)
self.miss = self:GetAbility():GetSpecialValueFor("miss")
self.magic = self:GetAbility():GetSpecialValueFor("magic")
end
function modifier_spider_passive:DeclareFunctions() return {

    MODIFIER_PROPERTY_EVASION_CONSTANT,
    MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS

} end





function modifier_spider_passive:AddCustomTransmitterData() return {
miss = self.miss,
magic = self.magic


} end

function modifier_spider_passive:HandleCustomTransmitterData(data)
self.miss = data.miss
self.magic = data.magic
end


function modifier_spider_passive:GetModifierEvasion_Constant() return self.miss end

function modifier_spider_passive:GetModifierMagicalResistanceBonus() return self.magic end