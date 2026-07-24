--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_foulfell_power", "item_ability/item_foulfell_power.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_dark_shield", "item_ability/item_dark_shield.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_foulfell_power == nil then
	item_foulfell_power = class({})
end
function item_foulfell_power:GetIntrinsicModifierName()
	return "modifier_item_dark_shield"
end
function item_foulfell_power:OnSpellStart()
	local hCaster = self:GetCaster()
	local unholy_duration = self:GetSpecialValueFor("unholy_duration")

	if IsValid(hCaster) and hCaster:IsAlive() then
		EmitSoundOn("DOTA_Item.Satanic.Activate", hCaster)
		hCaster:Purge(false, true, false, false, false)
		hCaster:AddNewModifier(hCaster, self, "modifier_item_foulfell_power", { duration = unholy_duration })
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_foulfell_power == nil then
	modifier_item_foulfell_power = class({})
end
function modifier_item_foulfell_power:IsHidden()
	return false
end
function modifier_item_foulfell_power:IsDebuff()
	return false
end
function modifier_item_foulfell_power:IsPurgable()
	return false
end
function modifier_item_foulfell_power:IsPurgeException()
	return false
end
function modifier_item_foulfell_power:OnCreated(params)
	if IsServer() then
	end
end
function modifier_item_foulfell_power:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_item_foulfell_power:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_foulfell_power:DeclareFunctions()
	return {
	}
end
function modifier_item_foulfell_power:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_item_foulfell_power:GetEffectName()
	return "particles/items2_fx/satanic_buff.vpcf"
end