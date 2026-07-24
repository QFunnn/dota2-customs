--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_ice_armor_buff", "neutrals/woda_neutral_woda_neutral_ice_armor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_woda_neutral_ice_armor_debuff", "neutrals/woda_neutral_woda_neutral_ice_armor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

woda_neutral_ice_armor = class({})

function woda_neutral_ice_armor:Precache(context)
    PrecacheResource( "particle", "particles/neutral_fx/ogre_magi_frost_armor.vpcf", context )
end

function woda_neutral_ice_armor:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("duration")
	
	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {})

	Timers:CreateTimer(0, function()
		if not self:GetCaster():IsAlive() then return end
		target:EmitSound("n_creep_OgreMagi.FrostArmor")
		target:AddNewModifier(self:GetCaster(), self, "modifier_woda_neutral_ice_armor_buff", {duration = duration})
		self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
	end)
end

modifier_woda_neutral_ice_armor_buff = class({})

function modifier_woda_neutral_ice_armor_buff:GetEffectName() return "particles/neutral_fx/ogre_magi_frost_armor.vpcf" end
 
function modifier_woda_neutral_ice_armor_buff:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end

function modifier_woda_neutral_ice_armor_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		 
	}
end

function modifier_woda_neutral_ice_armor_buff:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_woda_neutral_ice_armor_buff:OnAttackLanded(params)
	if not IsServer() then return end
	if params.target ~= self:GetParent() then return end
	local duration_debuff = self:GetAbility():GetSpecialValueFor("duration_debuff")
	params.attacker:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_woda_neutral_ice_armor_debuff", {duration = duration_debuff * (1 - params.attacker:GetStatusResistance())})
end

modifier_woda_neutral_ice_armor_debuff = class({})

function modifier_woda_neutral_ice_armor_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_woda_neutral_ice_armor_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("movement_speed")
end

function modifier_woda_neutral_ice_armor_debuff:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("attack_speed")
end