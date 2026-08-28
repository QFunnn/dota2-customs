--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_xdes_heart", "items/neutral/item_xdes_heart.lua", LUA_MODIFIER_MOTION_NONE)

item_xdes_heart = class({})

function item_xdes_heart:GetIntrinsicModifierName()
	return "modifier_item_xdes_heart"
end

-------------------------------------------------------------------

modifier_item_xdes_heart = class({})

function modifier_item_xdes_heart:IsHidden()
	return true
end

function modifier_item_xdes_heart:IsPurgable()
	return false
end

function modifier_item_xdes_heart:DestroyOnExpire()
	return false
end

function modifier_item_xdes_heart:RemoveOnDeath()
	return false
end

function modifier_item_xdes_heart:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	}
	return funcs
end

if IsServer() then
	function modifier_item_xdes_heart:GetModifierBonusStats_Agility()
		return self:GetCaster():GetBaseAgility()
	end

	function modifier_item_xdes_heart:GetModifierBonusStats_Intellect()
		return self:GetCaster():GetBaseIntellect()
	end

	function modifier_item_xdes_heart:GetModifierBonusStats_Strength()
		return self:GetCaster():GetBaseStrength()
	end
end