--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]


modifier_grimstroke_stroke_of_fate_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_grimstroke_stroke_of_fate_lua:IsHidden()
	return false
end

function modifier_grimstroke_stroke_of_fate_lua:IsDebuff()
	return true
end

function modifier_grimstroke_stroke_of_fate_lua:IsStunDebuff()
	return false
end

function modifier_grimstroke_stroke_of_fate_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_grimstroke_stroke_of_fate_lua:OnCreated(kv)
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor("attack_slow_pct") -- special value
end

function modifier_grimstroke_stroke_of_fate_lua:OnRefresh(kv)
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor("attack_slow_pct") -- special value
end

function modifier_grimstroke_stroke_of_fate_lua:OnDestroy(kv) end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_grimstroke_stroke_of_fate_lua:DeclareFunctions()
	local funcs = {
		-- MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end
function modifier_grimstroke_stroke_of_fate_lua:GetModifierAttackSpeedBonus_Constant()
	return -self.slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_grimstroke_stroke_of_fate_lua:GetEffectName()
	return "particles/units/heroes/hero_grimstroke/grimstroke_dark_artistry_debuff.vpcf"
end

function modifier_grimstroke_stroke_of_fate_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_grimstroke_stroke_of_fate_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_grimstroke_ink_swell.vpcf"
end

function modifier_grimstroke_stroke_of_fate_lua:StatusEffectPriority()
	return 10000
end