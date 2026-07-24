--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_ironwood_staff", "items/item_ironwood_staff", LUA_MODIFIER_MOTION_NONE )

item_ironwood_staff = class({})

function item_ironwood_staff:GetAOERadius()
    return 250
end

function item_ironwood_staff:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	local point = self:GetCursorPosition()
	if point == self:GetCaster():GetAbsOrigin() then
		point = point + self:GetCaster():GetForwardVector()
	end
    local r = 150 
    local c = math.sqrt( 2 ) * 0.5 * r 
    local x_offset = { -r, -c, 0.0, c, r, c, 0.0, -c }
    local y_offset = { 0.0, c, r, c, 0.0, -c, -r, -c }
    local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_furion/furion_sprout.vpcf", PATTACH_CUSTOMORIGIN, nil )
    ParticleManager:SetParticleControl( nFXIndex, 0, point )
    ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 0.0, r, 0.0 ) )
    ParticleManager:ReleaseParticleIndex( nFXIndex )

    for i = 1,8 do
        CreateTempTree( point + Vector( x_offset[i], y_offset[i], 0.0 ), duration )
    end

    for i = 1,8 do
        ResolveNPCPositions( point + Vector( x_offset[i], y_offset[i], 0.0 ), 128 )
    end

    AddFOWViewer( self:GetCaster():GetTeamNumber(), point, 250, duration, false )

    EmitSoundOnLocationWithCaster( point, "Hero_Furion.Sprout", self:GetCaster() )
end

function item_ironwood_staff:GetIntrinsicModifierName()
    return "modifier_item_ironwood_staff"
end

modifier_item_ironwood_staff = class({})

function modifier_item_ironwood_staff:IsHidden() return true end
function modifier_item_ironwood_staff:IsPurgable() return false end
function modifier_item_ironwood_staff:IsPurgeException() return false end
function modifier_item_ironwood_staff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_ironwood_staff:DeclareFunctions() 
    return 
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    } 
end

function modifier_item_ironwood_staff:GetModifierBonusStats_Strength()
    return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_ironwood_staff:GetModifierBonusStats_Agility()
    return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_ironwood_staff:GetModifierBonusStats_Intellect()
    return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end