--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_razor_storm_surge_custom", "heroes/npc_dota_hero_razor_custom/razor_storm_surge_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_storm_surge_custom_slow", "heroes/npc_dota_hero_razor_custom/razor_storm_surge_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_storm_surge_custom_cooldown", "heroes/npc_dota_hero_razor_custom/razor_storm_surge_custom", LUA_MODIFIER_MOTION_NONE)

razor_storm_surge_custom = class({})

razor_storm_surge_custom.modifier_razor_4_forward = {6,10,14}
razor_storm_surge_custom.modifier_razor_4_side = {3,5,7}
razor_storm_surge_custom.modifier_razor_5 = {10,20,30}
razor_storm_surge_custom.modifier_razor_6_chance = 18
razor_storm_surge_custom.modifier_razor_6_cooldown = -2
razor_storm_surge_custom.modifier_razor_6_radius = 500

function razor_storm_surge_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle","particles/units/heroes/hero_razor/razor_unstable_current.vpcf", context )
    PrecacheResource( "particle","particles/razor_custom/razor_shield_front.vpcf", context )
    PrecacheResource( "particle","particles/razor_custom/razor_shield_side.vpcf", context )
end

function razor_storm_surge_custom:GetCooldown(iLevel)
    if self:GetCaster():HasModifier("modifier_razor_6") and self:GetCaster():HasModifier("modifier_razor_eye_of_the_storm_custom") then
        return self.BaseClass.GetCooldown( self, iLevel ) + self.modifier_razor_6_cooldown
    end
    return self.BaseClass.GetCooldown( self, iLevel )
end

function razor_storm_surge_custom:GetIntrinsicModifierName()
    if not self:GetCaster():IsRealHero() then return end
    return "modifier_razor_storm_surge_custom"
end

modifier_razor_storm_surge_custom = class({})
function modifier_razor_storm_surge_custom:IsHidden() return true end
function modifier_razor_storm_surge_custom:IsPurgable() return false end
function modifier_razor_storm_surge_custom:OnCreated(table)
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.chance = self.ability:GetSpecialValueFor("strike_pct_chance")
    self.count  = self.ability:GetSpecialValueFor("strike_target_count")
    self.radius = self.ability:GetSpecialValueFor("strike_search_radius")
    self.strike_internal_cd = self.ability:GetSpecialValueFor("strike_internal_cd")
    self.damage = self.ability:GetSpecialValueFor("strike_damage")
    self.angle_front = 70
	self.angle_side = 120
end 

function modifier_razor_storm_surge_custom:OnRefresh(table)
    self:OnCreated()
end

function modifier_razor_storm_surge_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    }
end

function modifier_razor_storm_surge_custom:HitEnemies(attacker, start_cooldown)
    if not IsServer() then return end
    local duration = self.ability:GetSpecialValueFor("strike_slow_duration")
    if self.parent:PassivesDisabled() then return end
    if start_cooldown then
        local strike_internal_cd = self.strike_internal_cd
        if self.parent:HasModifier("modifier_razor_6") and self:GetCaster():HasModifier("modifier_razor_eye_of_the_storm_custom") then
            strike_internal_cd = strike_internal_cd + self.ability.modifier_razor_6_cooldown
        end
        self.parent:AddNewModifier(self.parent, self.ability, "modifier_razor_storm_surge_custom_cooldown", {duration = strike_internal_cd})
        self:GetAbility():StartCooldown(strike_internal_cd)
    end
    local targets = {}
    local ignore_heroes = {}
    local max_targets = self.count
    local remaining_slots = max_targets
    if attacker then 
        table.insert(targets, attacker)
        remaining_slots = remaining_slots - 1
    end
    if remaining_slots > 0 then
        local heroes = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false)
        for _, hero in pairs(heroes) do
            if remaining_slots <= 0 then break end
            if not attacker or hero ~= attacker then
                table.insert(targets, hero)
                remaining_slots = remaining_slots - 1
                ignore_heroes[hero:entindex()] = true
            end
        end
    end
    if remaining_slots > 0 then
        local creeps = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false )
        for _, creep in pairs(creeps) do
            if remaining_slots <= 0 then break end
            if not attacker or creep ~= attacker then
                table.insert(targets, creep)
                remaining_slots = remaining_slots - 1
                ignore_heroes[creep:entindex()] = true
            end
        end
    end
    if self:GetCaster():HasModifier("modifier_razor_eye_of_the_storm_custom") and self:GetCaster():HasModifier("modifier_razor_6") then
        local heroes = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetOrigin(), nil, self:GetAbility().modifier_razor_6_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false)
        for _, hero in pairs(heroes) do
            if not ignore_heroes[hero:entindex()] then
                table.insert(targets, hero)
            end
        end
    end
    local damage = self.damage
    if self:GetCaster():HasModifier("modifier_razor_5") then
        damage = damage + (self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * self:GetAbility().modifier_razor_5[self:GetCaster():GetTalentLevel("modifier_razor_5")])
    end
    local damage_table = {attacker = self.parent, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL, damage = damage}
    for _,target in pairs(targets) do 
        local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_razor/razor_unstable_current.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent )
        ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
        ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
        ParticleManager:ReleaseParticleIndex(particle)
        target:EmitSound("Hero_Razor.UnstableCurrent.Target")
        damage_table.victim = target
        target:AddNewModifier(self:GetCaster(), self.ability, "modifier_razor_storm_surge_custom_slow", {duration = duration * (1 - target:GetStatusResistance())})
        ApplyDamage(damage_table)
    end
    self.parent:EmitSound("Hero_Razor.UnstableCurrent.Strike")
end 

function modifier_razor_storm_surge_custom:OnAbilityFullyCast(params)
    if not IsServer() then return end
    if params.unit:GetTeamNumber() == self.parent:GetTeamNumber() then return end
    if not params.target then return end 
    if params.target ~= self.parent then return end
    if self.parent:HasModifier("modifier_razor_storm_surge_custom_cooldown") then return end
    if not self:GetAbility():IsActivated() then return end
    self:HitEnemies(params.unit, true)
end 

function modifier_razor_storm_surge_custom:OnAttackLanded(params)
    if not IsServer() then return end 
    if self.parent ~= params.target then return end 
    if self.parent:HasModifier("modifier_razor_storm_surge_custom_cooldown") then return end
    if not self:GetAbility():IsActivated() then return end
    local chance = self.chance
    if self:GetCaster():HasModifier("modifier_razor_eye_of_the_storm_custom") and self:GetCaster():HasModifier("modifier_razor_6") then
        chance = chance + self:GetAbility().modifier_razor_6_chance
    end
    if RollPseudoRandomPercentage(chance , 2025, self.parent) then 
        self:HitEnemies(params.attacker, true)
    end 

end

function modifier_razor_storm_surge_custom:GetModifierIncomingDamage_Percentage( params )
    if not self:GetParent():HasModifier("modifier_razor_4") then return end
	if params.target:PassivesDisabled() then return 0 end
    if not self:GetAbility():IsActivated() then return end
	local parent = params.target
	local attacker = params.attacker
	local reduction = 0
	local facing_direction = parent:GetAnglesAsVector().y
	local attacker_vector = (attacker:GetOrigin() - parent:GetOrigin())
	local attacker_direction = VectorToAngles( attacker_vector ).y
	local angle_diff = math.abs( AngleDiff( facing_direction, attacker_direction ) )
	if angle_diff < self.angle_front then
		reduction = self:GetAbility().modifier_razor_4_forward[parent:GetTalentLevel("modifier_razor_4")]
		self:PlayEffects( true, attacker_vector )
	elseif angle_diff < self.angle_side then
		reduction = self:GetAbility().modifier_razor_4_side[parent:GetTalentLevel("modifier_razor_4")]
		self:PlayEffects( false, attacker_vector )
	end
	return -reduction
end

function modifier_razor_storm_surge_custom:PlayEffects( front )
	local particle_cast = "particles/razor_custom/razor_shield_front.vpcf"
	local sound_cast = "Hero_Mars.Shield.Block"
	if not front then
		particle_cast = "particles/razor_custom/razor_shield_side.vpcf"
		sound_cast = "Hero_Mars.Shield.BlockSmall"
	end
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	EmitSoundOn( sound_cast, self:GetParent() )
end

modifier_razor_storm_surge_custom_slow = class({})
function modifier_razor_storm_surge_custom_slow:IsHidden() return false end
function modifier_razor_storm_surge_custom_slow:IsPurgable() return true end
function modifier_razor_storm_surge_custom_slow:OnCreated()
    self.slow = self:GetAbility():GetSpecialValueFor("strike_move_slow_pct")
end 

function modifier_razor_storm_surge_custom_slow:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_razor_storm_surge_custom_slow:GetModifierMoveSpeedBonus_Percentage()
    return self.slow
end

modifier_razor_storm_surge_custom_cooldown = class({})
function modifier_razor_storm_surge_custom_cooldown:IsHidden() return true end
function modifier_razor_storm_surge_custom_cooldown:IsPurgable() return false end
function modifier_razor_storm_surge_custom_cooldown:IsDebuff() return true end