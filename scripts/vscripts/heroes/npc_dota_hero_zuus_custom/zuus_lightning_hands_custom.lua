--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_generic_orb_effect_lua", "modifiers/modifier_generic_orb_effect_lua", LUA_MODIFIER_MOTION_NONE )

zuus_lightning_hands_custom = class({})

function zuus_lightning_hands_custom:OnUpgrade()
    if not IsServer() then return end
    if self and self:GetLevel() == 1 then
        self:ToggleAutoCast()
    end
end

function zuus_lightning_hands_custom:GetCastRange()
    return self:GetCaster():Script_GetAttackRange() + 50
end

function zuus_lightning_hands_custom:GetIntrinsicModifierName()
	return "modifier_generic_orb_effect_lua"
end

function zuus_lightning_hands_custom:OnOrbImpact( params )
	if not IsServer() then return end
    if self:GetCaster():IsIllusion() then return end
    local zuus_arc_lightning_custom = self:GetCaster():FindAbilityByName("zuus_arc_lightning_custom")
    if zuus_arc_lightning_custom and zuus_arc_lightning_custom:GetLevel() > 0 then
        local damage_percent = self:GetSpecialValueFor("damage_percent")
	    zuus_arc_lightning_custom:StartArc(params.target, zuus_arc_lightning_custom:GetSpecialValueFor("jump_count"), damage_percent)
    end
end