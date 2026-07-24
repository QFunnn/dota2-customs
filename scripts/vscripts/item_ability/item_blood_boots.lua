--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_arcane_walker", "item_ability/item_arcane_walker.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_arcane_walker_magical_armor_pen", "item_ability/item_arcane_walker.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_blood_boots", "item_ability/item_blood_boots.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_blood_boots == nil then
	item_blood_boots = class({})
end
function item_blood_boots:GetIntrinsicModifierName()
	return "modifier_item_arcane_walker"
end
function item_blood_boots:OnSpellStart()
	local hCaster = self:GetCaster()

	if IsValid(hCaster) then
		local replenish_amount = self:GetSpecialValueFor("replenish_amount")
		local bonus_replenish_amount_pct = self:GetSpecialValueFor("bonus_replenish_amount_pct")
		local duration = self:GetSpecialValueFor("duration")
		local fManaLostPct = 0
		if hCaster:GetMaxMana() > 0 then
			fManaLostPct = math.floor((hCaster:GetMaxMana() - hCaster:GetMana()) / hCaster:GetMaxMana() * 100)
		end
		local fAmount = replenish_amount * (100 + (fManaLostPct * bonus_replenish_amount_pct)) * 0.01
		hCaster:GiveMana(fAmount)
		SendOverheadEventMessage(hCaster, OVERHEAD_ALERT_MANA_ADD, hCaster, math.floor(fAmount), nil)

		local iParticleID = ParticleManager:CreateParticle("particles/items_fx/arcane_boots_recipient.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
		ParticleManager:ReleaseParticleIndex(iParticleID)
		local iParticleID2 = ParticleManager:CreateParticle("particles/items_fx/arcane_boots.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
		ParticleManager:ReleaseParticleIndex(iParticleID2)

		hCaster:AddNewModifier(hCaster, self, "modifier_item_blood_boots", {duration = duration})
		EmitSoundOn("DOTA_Item.ArcaneBoots.Activate", hCaster)
		EmitSoundOn("DOTA_Item.Bloodstone.Cast", hCaster)
	end
end
function item_blood_boots:OnOwnerDied()
	local death_lose_charge = self:GetSpecialValueFor("death_lose_charge")
	self:SetCurrentCharges(math.max(0, self:GetCurrentCharges() - death_lose_charge))
	local hCaster = self:GetCaster()
	hCaster.arcane_walker_charge = self:GetCurrentCharges()
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_blood_boots == nil then
	modifier_item_blood_boots = class({})
end
function modifier_item_blood_boots:IsHidden()
	return false
end
function modifier_item_blood_boots:IsDebuff()
	return false
end
function modifier_item_blood_boots:IsPurgable()
	return false
end
function modifier_item_blood_boots:IsPurgeException()
	return false
end
function modifier_item_blood_boots:GetEffectName()
	return "particles/items_fx/bloodstone_heal.vpcf"
end
function modifier_item_blood_boots:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end