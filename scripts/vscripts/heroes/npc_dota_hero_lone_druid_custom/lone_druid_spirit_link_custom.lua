--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lone_druid_spirit_link_custom", "heroes/npc_dota_hero_lone_druid_custom/lone_druid_spirit_link_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lone_druid_spirit_link_custom_buff", "heroes/npc_dota_hero_lone_druid_custom/lone_druid_spirit_link_custom", LUA_MODIFIER_MOTION_NONE)

lone_druid_spirit_link_custom = class({})

function lone_druid_spirit_link_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end

end

function lone_druid_spirit_link_custom:GetIntrinsicModifierName()
	return "modifier_lone_druid_spirit_link_custom"
end

modifier_lone_druid_spirit_link_custom = class({})

function modifier_lone_druid_spirit_link_custom:IsHidden() return true end

function modifier_lone_druid_spirit_link_custom:OnCreated()
	if not IsServer() then return end
	self:GetCaster():EmitSound("Hero_LoneDruid.SpiritLink.Cast")
end

function modifier_lone_druid_spirit_link_custom:OnRefresh()
	if not IsServer() then return end
	self:OnCreated()
end

function modifier_lone_druid_spirit_link_custom:IsAura()
    return true
end

function modifier_lone_druid_spirit_link_custom:GetAuraDuration() return 0.03 end

function modifier_lone_druid_spirit_link_custom:GetModifierAura()
    return "modifier_lone_druid_spirit_link_custom_buff"
end

function modifier_lone_druid_spirit_link_custom:GetAuraRadius()
    return FIND_UNITS_EVERYWHERE
end

function modifier_lone_druid_spirit_link_custom:GetAuraEntityReject(hEntity)
    if hEntity:GetOwner() == self:GetCaster() or (hEntity == self:GetCaster() or hEntity:GetUnitName() == "npc_dota_lone_druid_bear_custom") then
        return false
    end
    return true
end

function modifier_lone_druid_spirit_link_custom:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_lone_druid_spirit_link_custom:GetAuraSearchType()
    return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end

function modifier_lone_druid_spirit_link_custom:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED
end

modifier_lone_druid_spirit_link_custom_buff = class({})

function modifier_lone_druid_spirit_link_custom_buff:IsPurgable() return false end
function modifier_lone_druid_spirit_link_custom_buff:RemoveOnDeath() return false end

function modifier_lone_druid_spirit_link_custom_buff:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_lone_druid_spirit_link_custom_buff:GetModifierMoveSpeedBonus_Constant()
    if self:GetParent():GetUnitName() == "npc_dota_lone_druid_bear_custom" then
        return self:GetAbility():GetSpecialValueFor("bonus_movement_speed_bear")
    else
	    return self:GetAbility():GetSpecialValueFor("bonus_movement_speed_druid")
    end
end

function modifier_lone_druid_spirit_link_custom_buff:OnTakeDamage( params )
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
    if params.unit == self:GetParent() then return end
    if params.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then return end
    local life_steal = self:GetAbility():GetSpecialValueFor("lifesteal_percent")
    local heal = params.damage * life_steal / 100
    if self:GetParent():GetUnitName() == "npc_dota_lone_druid_bear_custom" then
        self:GetCaster():Heal(heal, self:GetAbility())
        local effect_cast = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
        ParticleManager:ReleaseParticleIndex( effect_cast )
    else
        for _, unit in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)) do
            if unit:GetUnitName() == "npc_dota_lone_druid_bear_custom" and unit:GetOwner() == self:GetCaster() then
                unit:Heal(heal, self:GetAbility())
                local effect_cast = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
                ParticleManager:ReleaseParticleIndex( effect_cast )
            end
        end
    end
end