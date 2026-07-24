--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_creature_berserk_debuff = class({})


function modifier_creature_berserk_debuff:GetTexture()
	return "item_desolator"
end


function modifier_creature_berserk_debuff:IsHidden()
	return false
end

function modifier_creature_berserk_debuff:IsDebuff()
	return true
end

function modifier_creature_berserk_debuff:IsPurgable()
	return false
end


function modifier_creature_berserk_debuff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
	return funcs
end

function modifier_creature_berserk_debuff:GetModifierPhysicalArmorBonus(params)
   return  -1*self:GetStackCount()
end
