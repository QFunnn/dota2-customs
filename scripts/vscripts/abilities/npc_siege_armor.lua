--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_siege_attack", "abilities/npc_siege_armor.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_siege_plusarmor", "abilities/npc_siege_armor.lua", LUA_MODIFIER_MOTION_NONE)

npc_siege_armor = class({})


function npc_siege_armor:GetIntrinsicModifierName() return "modifier_siege_attack" end
 
modifier_siege_attack = class ({})

function modifier_siege_attack:IsHidden() return true end
function modifier_siege_attack:IsPurgable() return false end


function modifier_siege_attack:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.duration = self.ability:GetSpecialValueFor("duration")

self.parent:AddAttackEvent_out(self, true)
end


function modifier_siege_attack:AttackEvent_out(params)
if not IsServer() then return end
if params.attacker ~= self.parent then return end

local target = params.target
target:EmitSound("Item_Desolator.Target")

local friends = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, 1000, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE , FIND_ANY_ORDER, false)
if #friends > 0 then 

for _,friend in pairs(friends) do
		friend:AddNewModifier(self.parent, self.ability, "modifier_siege_plusarmor", {duration = self.duration})
	end
end

end



modifier_siege_plusarmor = class ({})

function modifier_siege_plusarmor:IsHidden() return false end
function modifier_siege_plusarmor:IsPurgable() return false end

function modifier_siege_plusarmor:OnCreated(table)
self.armor = self:GetAbility():GetSpecialValueFor("armor")
if not IsServer() then return end
 self:GetParent():EmitSound("Hero_Dawnbreaker.Luminosity.Heal")  
self:SetStackCount(1)
end

function modifier_siege_plusarmor:GetEffectName() return "particles/items2_fx/medallion_of_courage_friend.vpcf" end
function modifier_siege_plusarmor:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end

function modifier_siege_plusarmor:OnRefresh(table)
	if not IsServer() then return end
if self:GetStackCount() >= self:GetAbility():GetSpecialValueFor("max") then return end
self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_siege_plusarmor:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_TOOLTIP
	}
end

function modifier_siege_plusarmor:GetModifierPhysicalArmorBonus() return self.armor*self:GetStackCount() end

function modifier_siege_plusarmor:OnTooltip() return self.armor*self:GetStackCount() end