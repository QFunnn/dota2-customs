--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_siege_melting", "abilities/npc_siege_melting.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_siege_armor", "abilities/npc_siege_melting.lua", LUA_MODIFIER_MOTION_NONE)

npc_siege_melting = class({})


function npc_siege_melting:GetIntrinsicModifierName() return "modifier_siege_melting" end
 
modifier_siege_melting = class ({})

function modifier_siege_melting:IsHidden() return true end
function modifier_siege_melting:IsPurgable() return false end



function modifier_siege_melting:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.duration = self.ability:GetSpecialValueFor("duration")

self.parent:AddAttackEvent_out(self, true)
end



function modifier_siege_melting:AttackEvent_out(params)
if not IsServer() then return end
if params.attacker ~= self.parent then return end

local target = params.target
target:EmitSound("Item_Desolator.Target")
target:AddNewModifier(self.parent, self.ability, "modifier_siege_armor", {duration = self.duration})
end



modifier_siege_armor = class ({})

function modifier_siege_armor:IsHidden() return false end
function modifier_siege_armor:IsPurgable() return false end

function modifier_siege_armor:OnCreated(table)
self.armor = -self:GetAbility():GetSpecialValueFor("armor")
if not IsServer() then return end
self:GetParent():EmitSound("Item.StarEmblem.Enemy")
self:SetStackCount(1)
end

function modifier_siege_armor:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self:GetAbility():GetSpecialValueFor("max") then return end
self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_siege_armor:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_TOOLTIP
	}
end

function modifier_siege_armor:GetModifierPhysicalArmorBonus() return self.armor*self:GetStackCount() end

function modifier_siege_armor:OnTooltip() return self.armor*self:GetStackCount() end

function modifier_siege_armor:GetEffectName() return "particles/general/generic_armor_reduction.vpcf" end
function modifier_siege_armor:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end