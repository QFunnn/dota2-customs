--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_cone_armor", "abilities/npc_cone_armor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_cone_cd", "abilities/npc_cone_armor", LUA_MODIFIER_MOTION_NONE)

npc_cone_armor = class({})

function npc_cone_armor:OnSpellStart()
if not IsServer() then return end

self:GetCaster():EmitSound("UI.Generic_shield")
self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_cone_armor", {duration = self:GetSpecialValueFor("duration")})
self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_cone_cd", {duration = self:GetCooldownTimeRemaining()})
end



modifier_cone_armor = class ({})

function modifier_cone_armor:IsHidden() return false end

function modifier_cone_armor:IsPurgable() return true end

function modifier_cone_armor:GetTexture() return "pangolier_shield_crash" end



function modifier_cone_armor:DeclareFunctions() return
    {

        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT

    }
end



function modifier_cone_armor:OnCreated(table)

    self.armor = self:GetAbility():GetSpecialValueFor("armor")
    self.speed = self:GetAbility():GetSpecialValueFor("speed")
end

function modifier_cone_armor:GetEffectName() return "particles/items3_fx/star_emblem_friend_shield.vpcf" end
 
function modifier_cone_armor:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end

function modifier_cone_armor:GetModifierIncomingDamage_Percentage()
	return -1*self.armor
end
function modifier_cone_armor:GetModifierAttackSpeedBonus_Constant()
	return self.speed
end


modifier_cone_cd = class({})

function modifier_cone_cd:IsHidden() return false end
function modifier_cone_cd:IsPurgable() return false end