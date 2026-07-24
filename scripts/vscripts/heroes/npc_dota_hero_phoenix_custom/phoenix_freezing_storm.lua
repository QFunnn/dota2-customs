--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_phoenix_freezing_storm", "heroes/npc_dota_hero_phoenix_custom/phoenix_freezing_storm", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua.lua", LUA_MODIFIER_MOTION_BOTH )

phoenix_freezing_storm = class({})

function phoenix_freezing_storm:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/items_fx/black_king_bar_avatar_aghanim.vpcf", context )
    PrecacheResource( "particle", "particles/phoenix_csutom/phoenix_explsoion.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_phoenix/phoenix_outburst_target.vpcf", context )
end

function phoenix_freezing_storm:OnSpellStart()
    if not IsServer() then return end
    local radius_knockback = self:GetSpecialValueFor("radius_knockback")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_phoenix_freezing_storm", {duration = self:GetSpecialValueFor("duration")})
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
    local point = self:GetCaster():GetAbsOrigin()
    local phoenix_ice_debuff = self:GetCaster():FindAbilityByName("phoenix_ice_debuff")
    for _, target in pairs(units) do
        local enemy_direction = (target:GetOrigin() - point)
        enemy_direction.z = 0
        enemy_direction = enemy_direction:Normalized()
        target:AddNewModifier(self:GetCaster(), self, "modifier_generic_knockback_lua", { duration = 0.25, distance = radius_knockback, height = 70, direction_x = enemy_direction.x, direction_y = enemy_direction.y, IsStun = true})
        if phoenix_ice_debuff then
            phoenix_ice_debuff:AddStack(target, 1)
        end
    end
    StartSoundEvent( "Hero_Phoenix.SuperNova.Explode", self:GetCaster())
	local pfx = ParticleManager:CreateParticle( "particles/phoenix_csutom/phoenix_explsoion.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl(pfx, 0, self:GetCaster():GetAbsOrigin() )
    ParticleManager:SetParticleControl(pfx, 1, self:GetCaster():GetAbsOrigin() )
    ParticleManager:SetParticleControl(pfx, 0, self:GetCaster():GetAbsOrigin() )    
	ParticleManager:ReleaseParticleIndex(pfx)
end

modifier_phoenix_freezing_storm = class({})
function modifier_phoenix_freezing_storm:IsPurgable() return false end
function modifier_phoenix_freezing_storm:IsPurgeException() return false end
function modifier_phoenix_freezing_storm:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_phoenix_freezing_storm:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movement_speed")
end

function modifier_phoenix_freezing_storm:CheckState()
 	return 
 	{
 		[MODIFIER_STATE_DEBUFF_IMMUNE] = true
	}
end

function modifier_phoenix_freezing_storm:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar_aghanim.vpcf"
end