--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_faceless_void_time_walk_custom", "heroes/npc_dota_hero_faceless_void_custom/faceless_void_time_walk_custom", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier("modifier_faceless_void_time_walk_custom_counter", "heroes/npc_dota_hero_faceless_void_custom/faceless_void_time_walk_custom" ,LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_faceless_void_time_walk_custom_silence", "heroes/npc_dota_hero_faceless_void_custom/faceless_void_time_walk_custom", LUA_MODIFIER_MOTION_HORIZONTAL )

faceless_void_time_walk_custom = class({})
faceless_void_time_walk_custom.modifier_faceless_void_10_cooldown = {-0.5,-1}
faceless_void_time_walk_custom.modifier_faceless_void_10_range = {50,100}
faceless_void_time_walk_custom.modifier_faceless_void_21 = 400
faceless_void_time_walk_custom.modifier_faceless_void_8_radius = 400
faceless_void_time_walk_custom.modifier_faceless_void_8_duration = {2,3}

function faceless_void_time_walk_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_faceless_void_10") then
        return "faceless_void_10"
    end
    return "faceless_void_time_walk"
end

function faceless_void_time_walk_custom:Precache(context)
    PrecacheResource("particle", "particles/units/heroes/hero_faceless_void/faceless_void_time_walk_slow.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_faceless_void/faceless_void_time_walk_preimage.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_faceless_void/faceless_void_chrono_speed.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_faceless_void/faceless_void_time_walk.vpcf", context)
    PrecacheResource("particle", "particles/status_fx/status_effect_faceless_timewalk.vpcf", context)
end

function faceless_void_time_walk_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_faceless_void_10") then
        bonus = self.modifier_faceless_void_10_cooldown[self:GetCaster():GetTalentLevel("modifier_faceless_void_10")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function faceless_void_time_walk_custom:GetBehavior()
    local behavior = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_DIRECTIONAL + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
    if self:GetCaster():HasModifier("modifier_faceless_void_14") then
        if not self:GetCaster():HasModifier("modifier_wodawisp") and not self:GetCaster():IsHexed() then
            behavior = behavior + 137438953472
        end
    end
    if self:GetCaster():HasModifier("modifier_faceless_void_21") then
        behavior = behavior + DOTA_ABILITY_BEHAVIOR_AOE
    end
    return behavior
end

function faceless_void_time_walk_custom:GetAOERadius()
    if self:GetCaster():HasModifier("modifier_faceless_void_21") then
        return self.modifier_faceless_void_21
    end
    return 0
end

function faceless_void_time_walk_custom:GetCastRange()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_faceless_void_10") then
        bonus = self.modifier_faceless_void_10_range[self:GetCaster():GetTalentLevel("modifier_faceless_void_10")]
    end
    if IsClient() then
        return self:GetSpecialValueFor("range") + bonus
    end
    return 99999
end

function faceless_void_time_walk_custom:GetIntrinsicModifierName()
    if not self:GetCaster():IsIllusion() then
        return "modifier_faceless_void_time_walk_custom_counter"
    end
end

function faceless_void_time_walk_custom:OnSpellStart()
    if not IsServer() then return end

    local bonus = 0
    if self:GetCaster():HasModifier("modifier_faceless_void_10") then
        bonus = self.modifier_faceless_void_10_range[self:GetCaster():GetTalentLevel("modifier_faceless_void_10")]
    end
    local range = self:GetSpecialValueFor("range") + self:GetCaster():GetCastRangeBonus() + bonus

	self.start_position = self:GetCaster():GetAbsOrigin()
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_faceless_void_time_walk_custom", {duration = range / self:GetSpecialValueFor("speed")})
    local pcf = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_time_walk_slow.vpcf", PATTACH_POINT_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControl(pcf, 1, Vector(self:GetSpecialValueFor("radius"), 0, 0))
    ParticleManager:ReleaseParticleIndex(pcf)
    EmitSoundOn("Hero_FacelessVoid.TimeWalk", self:GetCaster())
    ProjectileManager:ProjectileDodge(self:GetCaster())
    Timers:CreateTimer(1.5,function()
        local faceless_void_time_walk_reverse_custom = self:GetCaster():FindAbilityByName("faceless_void_time_walk_reverse_custom")
        if faceless_void_time_walk_reverse_custom then
            faceless_void_time_walk_reverse_custom:SetActivated(false)
        end
    end)
end

modifier_faceless_void_time_walk_custom = class({})

function modifier_faceless_void_time_walk_custom:IsPurgable() return false end
function modifier_faceless_void_time_walk_custom:IsPurgeException() return false end

function modifier_faceless_void_time_walk_custom:OnCreated(data)
    if not IsServer() then return end
	self.start_pos = self:GetCaster():GetAbsOrigin()
	self.reverse = data.reverse == 1
    local point = self:GetAbility():GetCursorPosition()
	if data.point_x and data.point_y and data.point_z then
		point = Vector(data.point_x,data.point_y,data.point_z)
	end
    self.range = self:GetAbility():GetSpecialValueFor("range") + self:GetCaster():GetCastRangeBonus()
    if self:GetCaster():HasModifier("modifier_faceless_void_10") then
        self.range = self.range + self:GetAbility().modifier_faceless_void_10_range[self:GetCaster():GetTalentLevel("modifier_faceless_void_10")]
    end
    local calc = point - self:GetCaster():GetAbsOrigin() 
    self.direction = calc:Normalized()
    self.len = math.min(calc:Length2D(), self.range)

    if not self.reverse and not self:GetCaster():HasModifier("modifier_faceless_void_8") then
        self:GetCaster():HealWithParams(self:GetCaster().time_walk_damage_taken, self:GetAbility(), false, true, self:GetParent(), false)
        self:GetCaster().time_walk_damage_taken = 0
        local modifier_faceless_void_time_walk_custom_counter = self:GetCaster():FindModifierByName("modifier_faceless_void_time_walk_custom_counter")
        if modifier_faceless_void_time_walk_custom_counter then
            for _, timer in pairs(modifier_faceless_void_time_walk_custom_counter.timers) do
                Timers:RemoveTimer(timer)
            end
            modifier_faceless_void_time_walk_custom_counter.timers = {}
        end
    end

    local end_point = self:GetCaster():GetAbsOrigin() + self.direction * self.len
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_time_walk_preimage.vpcf", PATTACH_ABSORIGIN, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, end_point)
	if self.reverse then
    	ParticleManager:SetParticleControlEnt(particle, 2, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetForwardVector() * -1, true)
    else
    	ParticleManager:SetParticleControlEnt(particle, 2, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetForwardVector(), true)
	end
	ParticleManager:ReleaseParticleIndex(particle)
    local nfx = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_chrono_speed.vpcf", PATTACH_POINT_FOLLOW, self:GetCaster())
    self:AddParticle(nfx, false, false, -1, false, false)
    self:ApplyHorizontalMotionController()
end

function modifier_faceless_void_time_walk_custom:OnDestroy()
    if not IsServer() then return end
    self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_1_END)
	if not self.reverse then
        if not self:GetCaster():HasModifier("modifier_faceless_void_8") then
            --self:GetCaster():HealWithParams(self:GetCaster().time_walk_damage_taken, self:GetAbility(), false, true, self:GetParent(), false)
            --self:GetCaster().time_walk_damage_taken = 0
            --local modifier_faceless_void_time_walk_custom_counter = self:GetCaster():FindModifierByName("modifier_faceless_void_time_walk_custom_counter")
            --if modifier_faceless_void_time_walk_custom_counter then
            --    for _, timer in pairs(modifier_faceless_void_time_walk_custom_counter.timers) do
            --        Timers:RemoveTimer(timer)
            --    end
            --    modifier_faceless_void_time_walk_custom_counter.timers = {}
            --end
        else
            local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetAbility().modifier_faceless_void_8_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
            for _,unit in pairs(units) do
                unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_faceless_void_time_walk_custom_silence", {duration = self:GetAbility().modifier_faceless_void_8_duration[self:GetCaster():GetTalentLevel("modifier_faceless_void_8")] * (1-unit:GetStatusResistance())})
            end
            self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_faceless_void_time_walk_custom_silence", {duration = self:GetAbility().modifier_faceless_void_8_duration[self:GetCaster():GetTalentLevel("modifier_faceless_void_8")]})
        end
        if self:GetCaster():HasModifier("modifier_faceless_void_21") then
            local faceless_void_time_lock_custom = self:GetCaster():FindAbilityByName("faceless_void_time_lock_custom")
            if faceless_void_time_lock_custom and faceless_void_time_lock_custom:GetLevel() > 0 then
                local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetAbility().modifier_faceless_void_21, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
                for _,unit in pairs(units) do
                    faceless_void_time_lock_custom:TimeLock(unit, true)
                end
            end
        end
        if self:GetCaster():HasModifier("modifier_faceless_void_20") then
            local faceless_void_time_walk_reverse_custom = self:GetCaster():FindAbilityByName("faceless_void_time_walk_reverse_custom")
            if faceless_void_time_walk_reverse_custom then
                faceless_void_time_walk_reverse_custom:SetActivated(true)
                faceless_void_time_walk_reverse_custom.reverse_position = self.start_pos
            end
        end
    end
end


function modifier_faceless_void_time_walk_custom:UpdateHorizontalMotion( me, dt )
    local caster = self:GetParent()
    if self.len > 0 then
        local pos = GetGroundPosition(self:GetParent():GetAbsOrigin(), self:GetParent())
        self:GetParent():SetAbsOrigin(pos + self.direction * self:GetAbility():GetSpecialValueFor("speed")*dt)
        self.len = self.len - self:GetAbility():GetSpecialValueFor("speed")*dt
    else
        FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
        self:Destroy()
    end
end

function modifier_faceless_void_time_walk_custom:CheckState()
    return 
    { 
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        [MODIFIER_STATE_INVULNERABLE] = true
    }
end

function modifier_faceless_void_time_walk_custom:GetEffectName()
    return "particles/units/heroes/hero_faceless_void/faceless_void_time_walk.vpcf"
end

function modifier_faceless_void_time_walk_custom:GetStatusEffectName()
    return "particles/status_fx/status_effect_faceless_timewalk.vpcf"
end

function modifier_faceless_void_time_walk_custom:StatusEffectPriority()
    return 10
end

function modifier_faceless_void_time_walk_custom:IsHidden()
    return true
end

modifier_faceless_void_time_walk_custom_counter = class({}) 
function modifier_faceless_void_time_walk_custom_counter:IsPurgable()  return false end
function modifier_faceless_void_time_walk_custom_counter:IsDebuff()    return false end
function modifier_faceless_void_time_walk_custom_counter:IsHidden()    return true end

function modifier_faceless_void_time_walk_custom_counter:OnCreated()
    self.caster = self:GetCaster()
    self.damage_time = self:GetAbility():GetSpecialValueFor("backtrack_duration")
    self.caster.time_walk_damage_taken = 0
    self.timers = {}
end

function modifier_faceless_void_time_walk_custom_counter:OnTakeDamage( data )
    local unit = data.unit
    local damage_taken = data.damage
    if unit == self.caster then
        self.caster.time_walk_damage_taken = self.caster.time_walk_damage_taken + damage_taken
        local timer = Timers:CreateTimer(self.damage_time, function()
            if self.caster.time_walk_damage_taken then
                self.caster.time_walk_damage_taken = self.caster.time_walk_damage_taken - damage_taken
            end
        end)
        table.insert(self.timers, timer)
    end
end

modifier_faceless_void_time_walk_custom_silence = class({})
function modifier_faceless_void_time_walk_custom_silence:IsDebuff() return true end
function modifier_faceless_void_time_walk_custom_silence:IsPurgable() return false end
function modifier_faceless_void_time_walk_custom_silence:GetTexture() return "faceless_void_8" end
function modifier_faceless_void_time_walk_custom_silence:CheckState()
    return
    {
        [MODIFIER_STATE_SILENCED] = true,
    }
end
function modifier_faceless_void_time_walk_custom_silence:GetEffectName()
    return "particles/generic_gameplay/generic_silence.vpcf"
end
function modifier_faceless_void_time_walk_custom_silence:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

faceless_void_time_walk_reverse_custom = class({})

function faceless_void_time_walk_reverse_custom:OnSpellStart()
    if not IsServer() then return end
    local faceless_void_time_walk_custom = self:GetCaster():FindAbilityByName("faceless_void_time_walk_custom")
    local range = faceless_void_time_walk_custom:GetSpecialValueFor("range") + self:GetCaster():GetCastRangeBonus()
    if self:GetCaster():HasModifier("modifier_faceless_void_10") then
        range = range + faceless_void_time_walk_custom.modifier_faceless_void_10_range[self:GetCaster():GetTalentLevel("modifier_faceless_void_10")]
    end
	self:GetCaster():AddNewModifier(self:GetCaster(), faceless_void_time_walk_custom, "modifier_faceless_void_time_walk_custom", 
	{
		duration = range / faceless_void_time_walk_custom:GetSpecialValueFor("speed"),
		point_x = self.reverse_position.x,
		point_y = self.reverse_position.y,
		point_z = self.reverse_position.z,
		reverse = 1
	})
    local pcf = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_time_walk_slow.vpcf", PATTACH_POINT_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControl(pcf, 1, Vector(faceless_void_time_walk_custom:GetSpecialValueFor("radius"), 0, 0))
    EmitSoundOn("Hero_FacelessVoid.TimeWalk", self:GetCaster())
    ProjectileManager:ProjectileDodge(self:GetCaster())
	self:SetActivated(false)
end