--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_centaur_aura", "abilities/neutral_centaur_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_centaur_aura_buff", "abilities/neutral_centaur_aura", LUA_MODIFIER_MOTION_NONE)



neutral_centaur_aura = class({})

function neutral_centaur_aura:GetIntrinsicModifierName() return "modifier_centaur_aura" end


modifier_centaur_aura = class({})

function modifier_centaur_aura:IsPurgable() return false end
function modifier_centaur_aura:IsHidden() return true end
function modifier_centaur_aura:IsAura() return true end
function modifier_centaur_aura:GetAuraDuration() return 0.1 end
function modifier_centaur_aura:GetAuraRadius() return 500 end
function modifier_centaur_aura:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_centaur_aura:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_centaur_aura:GetModifierAura() return "modifier_centaur_aura_buff" end

modifier_centaur_aura_buff = class({})
function modifier_centaur_aura_buff:IsPurgable() return false end
function modifier_centaur_aura_buff:IsHidden() return false end
function modifier_centaur_aura_buff:GetAttributes() return  MODIFIER_ATTRIBUTE_MULTIPLE end



function modifier_centaur_aura_buff:OnCreated(table)

self.armor = self:GetAbility():GetSpecialValueFor("armor")
self.magic = self:GetAbility():GetSpecialValueFor("magic")
end


function modifier_centaur_aura_buff:DeclareFunctions()
return {
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
}
end




function modifier_centaur_aura_buff:GetModifierMagicalResistanceBonus() 
	return self.magic 
end

function modifier_centaur_aura_buff:GetModifierPhysicalArmorBonus() 
	return self.armor 
end