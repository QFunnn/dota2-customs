--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_bloodstone_3", "item_ability/item_bloodstone_3.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_bloodstone_3_drained", "item_ability/item_bloodstone_3.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_dark_shield", "item_ability/item_dark_shield.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_bloodstone_3 == nil then
	item_bloodstone_3 = class({})
end
function item_bloodstone_3:GetIntrinsicModifierName()
	return "modifier_item_dark_shield"
end
function item_bloodstone_3:OnSpellStart()
	local hCaster = self:GetCaster()
	local buff_duration = self:GetSpecialValueFor("buff_duration")
	local drained_duration = self:GetSpecialValueFor("drained_duration")

	if IsValid(hCaster) and hCaster:IsAlive() then
		EmitSoundOn("DOTA_Item.Bloodstone.Cast", hCaster)
		hCaster:AddNewModifier(hCaster, self, "modifier_item_bloodstone_3", { duration = buff_duration })
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_bloodstone_3 == nil then
	modifier_item_bloodstone_3 = class({})
end
function modifier_item_bloodstone_3:IsHidden()
	return false
end
function modifier_item_bloodstone_3:IsDebuff()
	return false
end
function modifier_item_bloodstone_3:IsPurgable()
	return false
end
function modifier_item_bloodstone_3:IsPurgeException()
	return false
end
function modifier_item_bloodstone_3:OnCreated(params)
	if IsServer() then
		local hParent = self:GetParent()
		local iParticleID = ParticleManager:CreateParticle("particles/items_fx/bloodstone_heal.vpcf", PATTACH_OVERHEAD_FOLLOW, hParent)
		ParticleManager:SetParticleControlEnt(iParticleID, 2, hParent, PATTACH_POINT_FOLLOW, "attach_hitloc", hParent:GetAbsOrigin(), true)
		self:AddParticle(iParticleID, false, false, -1, false, false)
	end
end
function modifier_item_bloodstone_3:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_item_bloodstone_3:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_bloodstone_3:DeclareFunctions()
	return {
	}
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_bloodstone_3_drained == nil then
	modifier_item_bloodstone_3_drained = class({})
end
function modifier_item_bloodstone_3_drained:IsHidden()
	return false
end
function modifier_item_bloodstone_3_drained:IsDebuff()
	return false
end
function modifier_item_bloodstone_3_drained:IsPurgable()
	return false
end
function modifier_item_bloodstone_3_drained:IsPurgeException()
	return false
end
function modifier_item_bloodstone_3_drained:OnCreated(params)
	if IsServer() then
	end
end
function modifier_item_bloodstone_3_drained:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_item_bloodstone_3_drained:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_bloodstone_3_drained:DeclareFunctions()
	return {
	}
end