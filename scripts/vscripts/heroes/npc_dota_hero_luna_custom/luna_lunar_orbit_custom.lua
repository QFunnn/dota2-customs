--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_luna_lunar_orbit_custom", "heroes/npc_dota_hero_luna_custom/luna_lunar_orbit_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_luna_lunar_orbit_custom_glaive", "heroes/npc_dota_hero_luna_custom/luna_lunar_orbit_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_luna_lunar_orbit_custom_damage", "heroes/npc_dota_hero_luna_custom/luna_lunar_orbit_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_luna_lunar_orbit_custom_blood", "heroes/npc_dota_hero_luna_custom/luna_lunar_orbit_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )

luna_lunar_orbit_custom = class({})
luna_lunar_orbit_custom.modifier_luna_8 = {10,15,20}
luna_lunar_orbit_custom.modifier_luna_8_cd = {-2,-3,-4}
luna_lunar_orbit_custom.modifier_luna_12_count = 150
luna_lunar_orbit_custom.modifier_luna_13_dmg = 1
luna_lunar_orbit_custom.modifier_luna_13_max = {7,14,21}
luna_lunar_orbit_custom.modifier_luna_13_duration = 2
luna_lunar_orbit_custom.modifier_luna_19 = 400

function luna_lunar_orbit_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_luna/luna_moon_glaive_shield.vpcf", context)
end

function luna_lunar_orbit_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_luna_14") then
        return DOTA_ABILITY_BEHAVIOR_PASSIVE
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT
end

function luna_lunar_orbit_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_luna_14") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, level)
end

function luna_lunar_orbit_custom:GetCooldown(level)
    if self:GetCaster():HasModifier("modifier_luna_14") then
        return 0
    end
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_luna_8") then
        bonus = self.modifier_luna_8_cd[self:GetCaster():GetTalentLevel("modifier_luna_8")]
    end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function luna_lunar_orbit_custom:GetIntrinsicModifierName()
    if self:GetCaster():HasModifier("modifier_luna_14") then
        return "modifier_luna_lunar_orbit_custom"
    end
end

function luna_lunar_orbit_custom:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_luna_lunar_orbit_custom", { duration = self:GetSpecialValueFor("rotating_glaives_duration") })
    if self:GetCaster():HasModifier("modifier_luna_19") then
        local distance = self.modifier_luna_19
        local direction = self:GetCaster():GetForwardVector()
        self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_generic_knockback_lua", { duration = 0.5, distance = distance, height = 100, direction_x = direction.x, direction_y = direction.y})
        self:GetCaster():AddActivityModifier("selemene_gesture")
        --self:GetCaster():StartGesture(ACT_DOTA_TAUNT)
        local callback = function()
            --self:GetCaster():FadeGesture(ACT_DOTA_TAUNT)
            --self:GetCaster():RemoveGesture(ACT_DOTA_TAUNT)
        end
        if knockback then
            knockback:SetEndCallback( callback )
        end
    end
end

modifier_luna_lunar_orbit_custom = class({})
function modifier_luna_lunar_orbit_custom:IsHidden() return false end
function modifier_luna_lunar_orbit_custom:IsDebuff() return false end
function modifier_luna_lunar_orbit_custom:IsPurgable() return false end
function modifier_luna_lunar_orbit_custom:OnCreated()
	if not IsServer() then return end
    self:GetParent():EmitSound("Hero_Luna.LunarOrbit.Cast")
    self.count = self:GetAbility():GetSpecialValueFor("rotating_glaives")
	self.distance = self:GetAbility():GetSpecialValueFor("rotating_glaives_movement_radius")
    self.hit_radius = self:GetAbility():GetSpecialValueFor("rotating_glaives_hit_radius")
    self.speed = self:GetAbility():GetSpecialValueFor("rotating_glaives_speed")
    self.damage = self:GetAbility():GetSpecialValueFor("rotating_glaives_collision_damage")
    self.rotate_duration = self:GetAbility():GetSpecialValueFor("rotating_glaives_duration")
    if self:GetCaster():HasModifier("modifier_luna_12") then
        self.count = self.count + math.floor((self:GetCaster():GetStrength() / self:GetAbility().modifier_luna_12_count))
    end
    if self.thinkers then
		for i = 1, #self.thinkers do
			UTIL_Remove(self.thinkers[i])
		end
	end
	self.thinkers = {}
    local angle = 360 / self.count
    local start_radius = 100
    if self:GetCaster():HasModifier("modifier_luna_14") then
        start_radius = self.distance
        self.rotate_duration = 9999999
    end
    local forward_vector = self:GetParent():GetForwardVector()
    local caster_location = self:GetParent():GetAbsOrigin()
    local front_position = caster_location + forward_vector * start_radius
    self.angle_diff = angle
    self.hits = {}
    for i = 1, self.count do
        local pos = GetGroundPosition(RotatePosition(caster_location, QAngle(0, angle * i, 0), front_position), nil)
        self.thinkers[i] = CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_luna_lunar_orbit_custom_glaive", { angle = angle * i, owner = self:GetParent():entindex() }, pos, self:GetCaster():GetTeamNumber(), false )
        self.thinkers[i]:SetAbsOrigin(pos)
        self.thinkers[i].current_radius = start_radius
        local effect = ParticleManager:CreateParticle("particles/units/heroes/hero_luna/luna_moon_glaive_shield.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.thinkers[i])
        ParticleManager:SetParticleControlEnt(effect, 0, self.thinkers[i], PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0, 0, 0), true )
        ParticleManager:SetParticleControl(effect, 1, Vector(0, self.hit_radius, self.rotate_duration))
        ParticleManager:SetParticleControlEnt( effect, 2, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0, 0, 0), true )
        self.thinkers[i].particle = effect
        self:AddParticle(effect, true, false, -1, false, false)
        self.hits[i] = {}
    end
    self.grace_period = (self.distance / self.speed) / 2
    self.interval = 0.01
    self:StartIntervalThink(self.interval)
end

function modifier_luna_lunar_orbit_custom:OnRefresh()
	if not IsServer() then return end
    self:OnCreated()
end

function modifier_luna_lunar_orbit_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    }
end

function modifier_luna_lunar_orbit_custom:GetModifierIncomingDamage_Percentage()
    return self:GetAbility():GetSpecialValueFor("rotating_glaives_damage_reduction")
end

function modifier_luna_lunar_orbit_custom:OnIntervalThink()
    if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_luna_14") then
        if self:GetParent():PassivesDisabled() or not self:GetCaster():IsAlive() or self:GetParent():HasModifier("modifier_wodawisp") or self:GetParent():HasModifier("modifier_smoke_of_deceit") then
            if self.thinkers then
                for i = 1, self.count do
                    if self.thinkers[i] and not self.thinkers[i]:IsNull() then
                        ParticleManager:DestroyParticle(self.thinkers[i].particle, true)
                        UTIL_Remove(self.thinkers[i])
                    end
                end
                self.thinkers = nil
            end
        else
            if not self.thinkers then
                self:OnCreated()
            end
        end
    end
    local elapsed_time = self:GetElapsedTime()
    local caster_location = self:GetParent():GetAbsOrigin()
    for i = 1, self.count do
        for enemy, grace_period in pairs( self.hits[i] ) do
            if grace_period > 0 then
                self.hits[i][enemy] = grace_period - 0.01
            end
        end
    end
    local currentRadius	= self.distance * math.min(elapsed_time, 1)
    local end_time = self:GetDuration() - 1.5
    if elapsed_time >= end_time then
        local fade_time = elapsed_time - end_time
        currentRadius = self.distance - (self.distance - 100) * math.min(fade_time, 1)
    end
    if self:GetCaster():HasModifier("modifier_luna_14") then
        currentRadius = self.distance
    end
    for i = 1, self.count do
        if self.thinkers and self.thinkers[i] and not self.thinkers[i]:IsNull() then
            self.thinkers[i].current_radius = currentRadius
            local rotation_angle = elapsed_time * (self.speed / 1.4) + (self.angle_diff * i)
            local relPos = Vector( 0, currentRadius, 0 )
            relPos = RotatePosition( Vector(0,0,0), QAngle( 0, -rotation_angle, 0 ), relPos )
            local absPos = GetGroundPosition( relPos + caster_location, nil )
            self.thinkers[i]:SetAbsOrigin( absPos )
            local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self.thinkers[i]:GetAbsOrigin(), nil, self.hit_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
            for _, enemy in ipairs(enemies) do
                if not enemy:HasModifier("modifier_wodawisp") and not enemy:HasModifier("modifier_wodarelax") and enemy:IsAlive() then
                    self.hits[i][enemy] = self.hits[i][enemy] or 0
                    if self.hits[i][enemy] < 0.01 then
                        self.hits[i][enemy] = self.grace_period
                        local modifier_luna_lunar_orbit_custom_damage = self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_luna_lunar_orbit_custom_damage", {})
                        if self:GetCaster():HasModifier("modifier_luna_8") then
                            ApplyDamage({attacker = self:GetCaster(), victim = enemy, ability = self:GetAbility(), damage = self:GetAbility().modifier_luna_8[self:GetCaster():GetTalentLevel("modifier_luna_8")], damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK})
                        end
                        self:GetCaster():PerformAttack(enemy, true, false, true, true, false, false, true)
                        if modifier_luna_lunar_orbit_custom_damage then
                            modifier_luna_lunar_orbit_custom_damage:Destroy()
                        end
                        if self:GetCaster():HasModifier("modifier_luna_13") then
                            enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_luna_lunar_orbit_custom_blood", {duration = self:GetAbility().modifier_luna_13_duration})
                        end
                    end
                end
            end
        end
    end
end

function modifier_luna_lunar_orbit_custom:OnDestroy()
	if not IsServer() then return end
    for i = 1, self.count do
        if self.thinkers[i] and not self.thinkers[i]:IsNull() then
            ParticleManager:DestroyParticle(self.thinkers[i].particle, true)
            UTIL_Remove(self.thinkers[i])
        end
    end
end


modifier_luna_lunar_orbit_custom_glaive = class({})

modifier_luna_lunar_orbit_custom_damage = class({})
function modifier_luna_lunar_orbit_custom_damage:IsHidden() return true end
function modifier_luna_lunar_orbit_custom_damage:IsPurgable() return false end
function modifier_luna_lunar_orbit_custom_damage:IsPurgeException() return false end
function modifier_luna_lunar_orbit_custom_damage:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
    }
end
function modifier_luna_lunar_orbit_custom_damage:GetModifierDamageOutgoing_Percentage(params)
    if IsServer() then
        local damage = self:GetAbility():GetSpecialValueFor("rotating_glaives_collision_damage") - 100
        local modifier_luna_lunar_orbit_custom_blood = params.target:FindModifierByName("modifier_luna_lunar_orbit_custom_blood")
        if modifier_luna_lunar_orbit_custom_blood then
            damage = damage + modifier_luna_lunar_orbit_custom_blood:GetStackCount() * self:GetAbility().modifier_luna_13_dmg
        end
        return damage
    end
end

modifier_luna_lunar_orbit_custom_blood = class({})

function modifier_luna_lunar_orbit_custom_blood:GetTexture() return "luna_13" end

function modifier_luna_lunar_orbit_custom_blood:OnCreated()
    if not IsServer() then return end
    if self:GetStackCount() >= self:GetAbility().modifier_luna_13_max[self:GetCaster():GetTalentLevel("modifier_luna_13")] then return end
    self:IncrementStackCount()
end

function modifier_luna_lunar_orbit_custom_blood:OnRefresh()
    if not IsServer() then return end
    if self:GetStackCount() >= self:GetAbility().modifier_luna_13_max[self:GetCaster():GetTalentLevel("modifier_luna_13")] then return end
    self:IncrementStackCount()
end