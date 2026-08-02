--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_imba_aether_lens2_passive",
	"items/custom_items/item_aether_kaya2.lua",
	LUA_MODIFIER_MOTION_NONE
)
-------------------------------------------

item_Aether_kaya2 = class({})
-------------------------------------------
function item_Aether_kaya2:GetIntrinsicModifierName()
	return "modifier_imba_aether_lens2_passive"
end

-------------------------------------------
modifier_imba_aether_lens2_passive = modifier_imba_aether_lens2_passive or class({})
function modifier_imba_aether_lens2_passive:IsDebuff()
	return false
end
function modifier_imba_aether_lens2_passive:IsHidden()
	return true
end
function modifier_imba_aether_lens2_passive:IsPermanent()
	return true
end
function modifier_imba_aether_lens2_passive:IsPurgable()
	return false
end
function modifier_imba_aether_lens2_passive:IsPurgeException()
	return false
end
function modifier_imba_aether_lens2_passive:IsStunDebuff()
	return false
end
function modifier_imba_aether_lens2_passive:RemoveOnDeath()
	return false
end
function modifier_imba_aether_lens2_passive:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_imba_aether_lens2_passive:OnDestroy() end

function modifier_imba_aether_lens2_passive:OnCreated()
	if self:GetParent():IsHero() and self:GetAbility() then
		self.bonus_mana = self:GetAbility():GetSpecialValueFor("bonus_mp")

		self.cast_range_bonus = self:GetAbility():GetSpecialValueFor("bonus_cr")
		self.spell_power = self:GetAbility():GetSpecialValueFor("bonus_md")
		self.bonus_int = self:GetAbility():GetSpecialValueFor("bonus_intelligence")
		self.mnoz = self:GetAbility():GetSpecialValueFor("bonus_dmg")
	end
	if self:GetParent():IsHero() and self:GetParent():HasModifier("modifier_imba_aether_lens_passive") and item then
		self.bonus_mana = 0

		self.cast_range_bonus = 0
		self.spell_power = 0
		self.bonus_int = 0
	end
end

function modifier_imba_aether_lens2_passive:DeclareFunctions()
	local decFuns = {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		-- MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return decFuns
end

function modifier_imba_aether_lens2_passive:GetModifierSpellAmplify_Percentage()
	dopdmg = self:GetCaster():GetIntellect(true) * self.mnoz
	local magarmor_increase = dopdmg + self.spell_power
	return magarmor_increase
end

function modifier_imba_aether_lens2_passive:GetModifierManaBonus()
	return self.bonus_mana
end

-- function modifier_imba_aether_lens2_passive:GetModifierCastRangeBonusStacking()
-- return self.cast_range_bonus
-- end

function modifier_imba_aether_lens2_passive:GetModifierBonusStats_Intellect()
	return self.bonus_int
end

function modifier_imba_aether_lens2_passive:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE
end