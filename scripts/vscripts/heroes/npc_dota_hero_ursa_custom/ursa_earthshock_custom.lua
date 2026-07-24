--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ursa_earthshock_custom_debuff", "heroes/npc_dota_hero_ursa_custom/ursa_earthshock_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ursa_earthshock_custom_handler", "heroes/npc_dota_hero_ursa_custom/ursa_earthshock_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_arc_lua", "modifiers/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH)

ursa_earthshock_custom = class({})
ursa_earthshock_custom.modifier_ursa_13 = {75,150}
ursa_earthshock_custom.modifier_ursa_11 = {1,2}
ursa_earthshock_custom.modifier_ursa_19 = {50,100}
ursa_earthshock_custom.modifier_ursa_14 = 0.8
ursa_earthshock_custom.modifier_ursa_17 = {200,400}
ursa_earthshock_custom.modifier_ursa_12 = {2500,2000,1500}

function ursa_earthshock_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_ursa/ursa_earthshock.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_ursa/ursa_earthshock_modifier.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_ursa.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_ursa.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_ursa.vpcf", context)
end

function ursa_earthshock_custom:GetCastRange(vLocation, hTarget)
    if IsClient() then
        if self:GetCaster():HasModifier("modifier_ursa_17") then
            return self:GetSpecialValueFor("hop_distance") + self.modifier_ursa_17[self:GetCaster():GetTalentLevel("modifier_ursa_17")]
        end
    end
end

function ursa_earthshock_custom:GetIntrinsicModifierName()
    return "modifier_ursa_earthshock_custom_handler"
end

function ursa_earthshock_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_ursa_17") then
        return DOTA_ABILITY_BEHAVIOR_POINT
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end

function ursa_earthshock_custom:OnSpellStart()
    local shock_radius = self:GetSpecialValueFor("shock_radius")
    local hop_distance = self:GetSpecialValueFor("hop_distance")
    if self:GetCaster():HasModifier("modifier_ursa_17") then
        hop_distance = hop_distance + self.modifier_ursa_17[self:GetCaster():GetTalentLevel("modifier_ursa_17")]
    end
    local hop_duration = self:GetSpecialValueFor("hop_duration")
    local hop_height = self:GetSpecialValueFor("hop_height")
    local direction = self:GetCaster():GetForwardVector()
    local point = self:GetCursorPosition()
    if point == self:GetCaster():GetAbsOrigin() then
        point = point + self:GetCaster():GetForwardVector()
    end
    if point ~= nil and self:GetCaster():HasModifier("modifier_ursa_17") then
        direction = point - self:GetCaster():GetAbsOrigin()
        direction.z = 0
        hop_distance = math.min(direction:Length2D(), hop_distance + self:GetCaster():GetCastRangeBonus())
        direction = direction:Normalized()
    end
    if self:GetCaster():IsRooted() and not self:GetCaster():IsDebuffImmune() then
        hop_distance = 0
    end
    local arc = self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_generic_arc_lua",
    { 
        dir_x = direction.x,
        dir_y = direction.y,
        duration = hop_duration,
        distance = hop_distance,
        height = hop_height,
        fix_end = false,
        isStun = true,
        isForward = true,
        activity = ACT_DOTA_CAST_ABILITY_1,
    })
    arc:SetEndCallback( function( interrupted )
        self:EarthShockCast(self:GetCaster():GetAbsOrigin(), true)
    end)
end

function ursa_earthshock_custom:EarthShockCast(point, is_ability)
    if not IsServer() then return end
    local ursa_fury_swipes_custom = self:GetCaster():FindAbilityByName("ursa_fury_swipes_custom")
    local radius = self:GetSpecialValueFor("shock_radius")
    if self:GetCaster():HasModifier("modifier_ursa_13") then
        radius = radius + self.modifier_ursa_13[self:GetCaster():GetTalentLevel("modifier_ursa_13")]
    end
    local damage = self:GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_ursa_19") then
        damage = damage + self.modifier_ursa_19[self:GetCaster():GetTalentLevel("modifier_ursa_19")]
    end
    local duration = self:GetSpecialValueFor("duration")
    if is_ability then
        self:GetCaster():EmitSound("Hero_Ursa.Earthshock")
    end
    if is_ability and self:GetCaster():HasModifier("modifier_ursa_14") then
        local ursa_enrage_custom = self:GetCaster():FindAbilityByName("ursa_enrage_custom")
        if ursa_enrage_custom and ursa_enrage_custom:GetLevel() > 0 then
            ursa_enrage_custom:OnSpellStart(self.modifier_ursa_14, true)
        end
    end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ursa/ursa_earthshock.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl( particle, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControl( particle, 1, Vector(radius, radius/2, radius/4) )
	ParticleManager:ReleaseParticleIndex( particle )
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
    for _, enemy in pairs(enemies) do
        enemy:AddNewModifier(self:GetCaster(), self, "modifier_ursa_earthshock_custom_debuff", {duration = duration * (1-enemy:GetStatusResistance())})
        if self:GetCaster():HasModifier("modifier_ursa_8") then
            self:GetCaster():PerformAttack(enemy, true, true, true, false, false, false, true)
        else
            ApplyDamage({victim = enemy, attacker = self:GetCaster(), damage = damage, ability = self, damage_type = DAMAGE_TYPE_MAGICAL})
        end
        if self:GetCaster():HasModifier("modifier_ursa_11") then
            if ursa_fury_swipes_custom and ursa_fury_swipes_custom:GetLevel() > 0 then
                local bonus_reset_time = ursa_fury_swipes_custom:GetSpecialValueFor("bonus_reset_time")
                for i=1, self.modifier_ursa_11[self:GetCaster():GetTalentLevel("modifier_ursa_11")] do
                    enemy:AddNewModifier(self:GetCaster(), ursa_fury_swipes_custom, "modifier_ursa_fury_swipes_custom_debuff", {duration = bonus_reset_time * (1-enemy:GetStatusResistance())})
                end
            end
        end
    end
end

modifier_ursa_earthshock_custom_debuff = class({})

function modifier_ursa_earthshock_custom_debuff:OnCreated( kv )
	self.movement_slow = self:GetAbility():GetSpecialValueFor("movement_slow")
end

function modifier_ursa_earthshock_custom_debuff:OnRefresh( kv )
	self.movement_slow = self:GetAbility():GetSpecialValueFor("movement_slow")
end

function modifier_ursa_earthshock_custom_debuff:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_ursa_earthshock_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.movement_slow
end

function modifier_ursa_earthshock_custom_debuff:GetEffectName()
	return "particles/units/heroes/hero_ursa/ursa_earthshock_modifier.vpcf"
end

function modifier_ursa_earthshock_custom_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_ursa_earthshock_custom_handler = class({})
function modifier_ursa_earthshock_custom_handler:IsHidden() return true end
function modifier_ursa_earthshock_custom_handler:IsPurgable() return false end
function modifier_ursa_earthshock_custom_handler:IsPurgeException() return false end
function modifier_ursa_earthshock_custom_handler:RemoveOnDeath() return false end
function modifier_ursa_earthshock_custom_handler:OnCreated()
    if not IsServer() then return end
    self.distance = 0
    self.origin = self:GetCaster():GetOrigin()
    self:StartIntervalThink(FrameTime())
end
function modifier_ursa_earthshock_custom_handler:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetCaster():HasModifier("modifier_ursa_12") then return end
    if self:GetCaster():HasModifier("modifier_wodawisp") then return end
    if self:GetCaster():HasModifier("modifier_wodarelax") then return end
    local new_distance = (self:GetCaster():GetOrigin() - self.origin):Length2D()
    self.origin = self:GetParent():GetAbsOrigin()
    if new_distance > 600 then return end
    self.distance = self.distance + new_distance
    if self.distance >= self:GetAbility().modifier_ursa_12[self:GetCaster():GetTalentLevel("modifier_ursa_12")] then
        self.distance = math.max(0, self.distance - self:GetAbility().modifier_ursa_12[self:GetCaster():GetTalentLevel("modifier_ursa_12")])
        self:GetAbility():EarthShockCast(self:GetParent():GetAbsOrigin(), false)
    end
end