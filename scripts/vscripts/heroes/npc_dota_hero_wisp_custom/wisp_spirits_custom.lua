--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_wisp_spirits_custom", "heroes/npc_dota_hero_wisp_custom/wisp_spirits_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_spirits_custom_wisp", "heroes/npc_dota_hero_wisp_custom/wisp_spirits_custom", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_wisp_spirits_custom_hero_hit", "heroes/npc_dota_hero_wisp_custom/wisp_spirits_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_spirits_custom_creep_hit", "heroes/npc_dota_hero_wisp_custom/wisp_spirits_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_spirits_custom_creep_slow", "heroes/npc_dota_hero_wisp_custom/wisp_spirits_custom", LUA_MODIFIER_MOTION_NONE)

wisp_spirits_custom = class({})
wisp_spirits_custom.modifier_wisp_15 = {3,6}
wisp_spirits_custom.modifier_wisp_15_creep = {1,2}
wisp_spirits_custom.modifier_wisp_16 = {-2,-4}
wisp_spirits_custom.modifier_wisp_21 = -25
wisp_spirits_custom.modifier_wisp_21_duration = 0.3

function wisp_spirits_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_wisp/wisp_guardian.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_wisp/wisp_guardian_explosion.vpcf", context)
end

function wisp_spirits_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_wisp_16") then
        bonus = self.modifier_wisp_16[self:GetCaster():GetTalentLevel("modifier_wisp_16")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function wisp_spirits_custom:GetIntrinsicModifierName()
    if self:GetCaster():HasModifier("modifier_wisp_1") then return end
    if self:GetCaster():HasModifier("modifier_wisp_10") then return end
    if self:GetCaster():HasModifier("modifier_wisp_21") then
        return "modifier_wisp_spirits_custom"
    end
end

function wisp_spirits_custom:OnSpellStart()
	if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_wisp_21") then
        local modifier_wisp_spirits_custom = self:GetCaster():FindModifierByName("modifier_wisp_spirits_custom")
        if modifier_wisp_spirits_custom then
            modifier_wisp_spirits_custom:DestroyAllSpirits()
        end
        return
    end
    local spirit_duration = self:GetSpecialValueFor("spirit_duration")
	self:GetCaster():EmitSound("Hero_Wisp.Spirits.Cast")
    local modifier_wisp_spirits_custom = self:GetCaster():FindModifierByName("modifier_wisp_spirits_custom")
    if modifier_wisp_spirits_custom then
        modifier_wisp_spirits_custom:Destroy()
    end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_wisp_spirits_custom", {duration = spirit_duration})
end

modifier_wisp_spirits_custom = class({})
function modifier_wisp_spirits_custom:IsPurgable() return false end
function modifier_wisp_spirits_custom:IsPurgeException() return false end
function modifier_wisp_spirits_custom:RemoveOnDeath() return not self:GetCaster():HasModifier("modifier_wisp_21") end

function modifier_wisp_spirits_custom:OnCreated(params)
	if not IsServer() then return end
	self.start_time = GameRules:GetGameTime()
	self.spirit_summon_interval = 1
	self.max_spirits = self:GetAbility():GetSpecialValueFor("spirit_amount")
	self.collision_radius = self:GetAbility():GetSpecialValueFor("hero_hit_radius")
	self.explosion_radius = self:GetAbility():GetSpecialValueFor("explode_radius")
	self.spirit_radius = self:GetAbility():GetSpecialValueFor("hero_hit_radius")
	self.spirit_min_radius = self:GetAbility():GetSpecialValueFor("min_range")
	self.spirit_max_radius = self:GetAbility():GetSpecialValueFor("max_range")
	self.spirit_movement_rate = self:GetAbility():GetSpecialValueFor("spirit_movement_rate")
	self.creep_damage = self:GetAbility():GetSpecialValueFor("creep_damage")
	self.explosion_damage = self:GetAbility():GetSpecialValueFor("hero_damage")
	self.spirit_turn_rate = 100
	self.update_timer = 0
    self.spirits_num_spirits = 0
	self.time_to_update = 0.5
    self.spirits_movementFactor	= 1
    self.spirits_spiritsSpawned	= {}
	EmitSoundOn("Hero_Wisp.Spirits.Loop", self:GetCaster())	
    local wisp_spirits_in_custom = self:GetCaster():FindAbilityByName("wisp_spirits_in_custom")
    if wisp_spirits_in_custom then
        wisp_spirits_in_custom:SetLevel(wisp_spirits_in_custom:GetMaxLevel())
        wisp_spirits_in_custom:SetHidden(false)
    end
    local wisp_spirits_out_custom = self:GetCaster():FindAbilityByName("wisp_spirits_out_custom")
    if wisp_spirits_out_custom then
        wisp_spirits_out_custom:SetLevel(wisp_spirits_out_custom:GetMaxLevel())
        wisp_spirits_out_custom:SetHidden(false)
    end
	self:StartIntervalThink(FrameTime())
end

function modifier_wisp_spirits_custom:OnIntervalThink()
	if not IsServer() then return end
    local elapsedTime = GameRules:GetGameTime() - self.start_time
    local idealNumSpiritsSpawned = math.min(elapsedTime / self.spirit_summon_interval, self.max_spirits)

    -- Первый спавн огоньков
	if self.spirits_num_spirits < idealNumSpiritsSpawned then
		local npc_dota_wisp_spirit = CreateUnitByName("npc_dota_wisp_spirit", self:GetCaster():GetAbsOrigin(), false, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeam())
        local spiritIndex = self.spirits_num_spirits + 1
        npc_dota_wisp_spirit.spirit_index = spiritIndex
        self.spirits_num_spirits = spiritIndex
        self.spirits_spiritsSpawned[spiritIndex] = npc_dota_wisp_spirit
        npc_dota_wisp_spirit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_wisp_spirits_custom_wisp", {})
	end

    -- Изменение радиуса
    local currentRadius	= self.spirit_radius
	local deltaRadius = self.spirits_movementFactor * self.spirit_movement_rate * FrameTime()
	currentRadius = currentRadius + deltaRadius
	currentRadius = math.min( math.max( currentRadius, self.spirit_min_radius ), self.spirit_max_radius )
	self.spirit_radius = currentRadius

    -- Удаляем огоньков если они закончились
    if not self:GetCaster():HasModifier("modifier_wisp_21") then
        if self.spirits_num_spirits == self.max_spirits then
            local destroy_modifier = true
            for _, spirit in pairs(self.spirits_spiritsSpawned) do
                if spirit ~= nil and not spirit:IsNull() then
                    destroy_modifier = false
                end
            end
            if destroy_modifier then
                self:Destroy()
            end
        end
    else
        for _, spirit in pairs(self.spirits_spiritsSpawned) do
            if spirit ~= nil and not spirit:IsNull() then
                local modifier_wisp_spirits_custom_hero_hit = spirit:FindModifierByName("modifier_wisp_spirits_custom_hero_hit")
                if modifier_wisp_spirits_custom_hero_hit then
                    if not modifier_wisp_spirits_custom_hero_hit.set then
                        modifier_wisp_spirits_custom_hero_hit.set = true
                        modifier_wisp_spirits_custom_hero_hit:SetDuration(1, true)
                    end
                    break
                end
            end
        end
    end
end

function modifier_wisp_spirits_custom:OnDestroy()
	if not IsServer() then return end
    for _, spirit in pairs(self.spirits_spiritsSpawned) do
        if spirit ~= nil and not spirit:IsNull() then
            spirit:RemoveModifierByName("modifier_wisp_spirits_custom_wisp")
        end
    end
    local wisp_spirits_in_custom = self:GetCaster():FindAbilityByName("wisp_spirits_in_custom")
    if wisp_spirits_in_custom then
        wisp_spirits_in_custom:SetHidden(true)
        if wisp_spirits_in_custom:GetToggleState() then
            wisp_spirits_in_custom:ToggleAbility()
        end
    end
    local wisp_spirits_out_custom = self:GetCaster():FindAbilityByName("wisp_spirits_out_custom")
    if wisp_spirits_out_custom then
        wisp_spirits_out_custom:SetHidden(true)
        if wisp_spirits_out_custom:GetToggleState() then
            wisp_spirits_out_custom:ToggleAbility()
        end
    end
	self:GetCaster():StopSound("Hero_Wisp.Spirits.Loop")
end

function modifier_wisp_spirits_custom:DestroyAllSpirits()
    if not IsServer() then return end
    for _, spirit in pairs(self.spirits_spiritsSpawned) do
        if spirit ~= nil and not spirit:IsNull() then
            local modifier_wisp_spirits_custom_wisp = spirit:FindModifierByName("modifier_wisp_spirits_custom_wisp")
            if modifier_wisp_spirits_custom_wisp then
                modifier_wisp_spirits_custom_wisp:Explosion(true)
            end
        end
    end
end

modifier_wisp_spirits_custom_wisp = class({})

function modifier_wisp_spirits_custom_wisp:OnCreated(params)
	if not IsServer() then return end
    self.damage_interval = 0.1
    self.damage_timer = 0
    self.hit_table = {}
    self.parent = self:GetParent()
    local modifier_wisp_spirits_custom = self:GetCaster():FindModifierByName("modifier_wisp_spirits_custom")
    if not modifier_wisp_spirits_custom then return end
    self.rotate_radius = modifier_wisp_spirits_custom.spirit_radius
	self.base_facing = Vector(0,1,0)
    self.explode_radius = self:GetAbility():GetSpecialValueFor("explode_radius")
    self.collision_radius = self:GetAbility():GetSpecialValueFor("hero_hit_radius")
	self.relative_pos = Vector( -self.rotate_radius, 0, 100 )
    self.rotation = (self:GetParent().spirit_index ) * 360 / self:GetAbility():GetSpecialValueFor("spirit_amount")
    self.position = self:GetCaster():GetOrigin() + self.relative_pos
    self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_guardian.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    self:AddParticle(self.pfx, false, false, -1, false, false)
    self.not_damage = {}
    self.grace_period = (360 / (360 / 2.5)) / 2
    self:StartIntervalThink(FrameTime())
    if not self:ApplyHorizontalMotionController() then
		self:Destroy()
	end
end

function modifier_wisp_spirits_custom_wisp:OnIntervalThink()
	if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_wisp_spirits_custom_hero_hit") or self:GetCaster():HasModifier("modifier_wodawisp") or self:GetCaster():HasModifier("modifier_wodarelax") or not self:GetCaster():IsAlive() then
        if self.pfx then
            ParticleManager:DestroyParticle(self.pfx, false)
            self.pfx = nil
        end
        self:GetParent():AddNoDraw()
    else
        self:GetParent():RemoveNoDraw()
        if not self.pfx then
            self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_guardian.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
            self:AddParticle(self.pfx, false, false, -1, false, false)
        end
    end
    if not self:GetParent():IsCurrentlyHorizontalMotionControlled() then
        self:ApplyHorizontalMotionController()
    end
    local spirit = self:GetParent()
    local nearby_enemy_units = FindUnitsInRadius(self:GetCaster():GetTeam(), spirit:GetAbsOrigin(), nil, self.collision_radius, DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    if nearby_enemy_units ~= nil and #nearby_enemy_units > 0 then
        self:OnHit(nearby_enemy_units)
    end
    for enemy, grace_period in pairs( self.not_damage ) do
        if grace_period > 0 then
            self.not_damage[enemy] = grace_period - FrameTime()
        end
    end
end

function modifier_wisp_spirits_custom_wisp:Explosion(is_destroy)
    if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_wisp_spirits_custom_hero_hit") then return end
    if self:GetCaster():HasModifier("modifier_wodawisp") then return end
    if self:GetCaster():HasModifier("modifier_wodarelax") then return end
    if not self:GetCaster():IsAlive() then return end
    local enemies_hit =  FindUnitsInRadius(self:GetCaster():GetTeam(), self:GetParent():GetAbsOrigin(), nil, self.explode_radius, DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    local creep_damage = self:GetAbility():GetSpecialValueFor("creep_damage")
    local hero_damage = self:GetAbility():GetSpecialValueFor("hero_damage")
    if self:GetCaster():HasModifier("modifier_wisp_15") then
        creep_damage = creep_damage + (self:GetCaster():GetMana() / 100 * self:GetAbility().modifier_wisp_15_creep[self:GetCaster():GetTalentLevel("modifier_wisp_15")])
        hero_damage = hero_damage + (self:GetCaster():GetMana() / 100 * self:GetAbility().modifier_wisp_15[self:GetCaster():GetTalentLevel("modifier_wisp_15")])
    end
	local damage_table = {attacker = self:GetCaster(), ability = self:GetAbility(), damage_type = self:GetAbility():GetAbilityDamageType(), damage = hero_damage}
	for _,enemy in pairs(enemies_hit) do
		if enemy:IsAlive() and not self:GetParent():IsNull() then 
			damage_table.victim = enemy
			ApplyDamage(damage_table)
            if self:GetParent():HasModifier("modifier_wisp_21") then
                enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_wisp_spirits_custom_creep_slow", {duration = self:GetAbility().modifier_wisp_21_duration * (1-self:GetParent():GetStatusResistance())})
            end
		end
	end
    if is_destroy then
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_guardian_explosion.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)
        EmitSoundOn("Hero_Wisp.Spirits.Target", self:GetParent())
        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_wisp_spirits_custom_hero_hit", {})
    end
end

function modifier_wisp_spirits_custom_wisp:OnHit(enemies_hit) 
    if not IsServer() then return end
    if not self:GetCaster():IsAlive() then return end
	local hit_hero = false
    local creep_damage = self:GetAbility():GetSpecialValueFor("creep_damage")
    local hero_damage = self:GetAbility():GetSpecialValueFor("hero_damage")
    if self:GetCaster():HasModifier("modifier_wisp_15") then
        creep_damage = creep_damage + (self:GetCaster():GetMana() / 100 * self:GetAbility().modifier_wisp_15_creep[self:GetCaster():GetTalentLevel("modifier_wisp_15")])
        hero_damage = hero_damage + (self:GetCaster():GetMana() / 100 * self:GetAbility().modifier_wisp_15[self:GetCaster():GetTalentLevel("modifier_wisp_15")])
    end
	local damage_table = {attacker = self:GetCaster(), ability = self:GetAbility(), damage_type = self:GetAbility():GetAbilityDamageType(), damage = creep_damage}
	for _,enemy in pairs(enemies_hit) do
		if enemy:IsAlive() and not self:GetParent():IsNull() then
             
			local hit = false
			damage_table.victim = enemy
			if enemy:IsConsideredHero() and not enemy:IsIllusion() then
				hit_hero = true
			else
                self.not_damage[enemy] = self.not_damage[enemy] or 0
                if self.not_damage[enemy] < 0.01 then
                    self.not_damage[enemy] = self.grace_period
                    print(self.grace_period)
                    damage_table.damage	= creep_damage
                    hit = true
                end
                enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_wisp_spirits_custom_creep_slow", {duration = self:GetAbility().modifier_wisp_21_duration})
			end
			if hit then
				ApplyDamage(damage_table)
			end
		end
	end
    if not self:GetCaster():HasModifier("modifier_wisp_21") then
        if hit_hero then 
            self:Destroy()
        end
    else
        if hit_hero then 
            self:Explosion(true)
        end
    end
end

function modifier_wisp_spirits_custom_wisp:CheckState()
	return
    {
		[MODIFIER_STATE_NO_TEAM_MOVE_TO] 	= true,
		[MODIFIER_STATE_NO_TEAM_SELECT] 	= true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] 		= true,
		[MODIFIER_STATE_MAGIC_IMMUNE] 		= true,
		[MODIFIER_STATE_INVULNERABLE] 		= true,
		[MODIFIER_STATE_UNSELECTABLE] 		= true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] 	= true,
		[MODIFIER_STATE_NO_HEALTH_BAR] 		= true,
	}
end

function modifier_wisp_spirits_custom_wisp:UpdateHorizontalMotion(me, dt)
    local modifier_wisp_spirits_custom = self:GetCaster():FindModifierByName("modifier_wisp_spirits_custom")
    if not modifier_wisp_spirits_custom then return end
    self.rotate_radius = modifier_wisp_spirits_custom.spirit_radius
    self.relative_pos = Vector( -self.rotate_radius, 0, 100 )
    self.rotation = self.rotation + ((360 / 2.5) * dt)
	local origin = self:GetCaster():GetOrigin()
	self.position = RotatePosition( origin, QAngle( 0, -self.rotation, 0 ), origin + self.relative_pos )
	self:GetParent():SetOrigin( self.position )
end

function modifier_wisp_spirits_custom_wisp:OnDestroy()
	if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_guardian_explosion.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
    EmitSoundOn("Hero_Wisp.Spirits.Target", self:GetParent())
    self:Explosion()
	UTIL_Remove(self:GetParent())
end

modifier_wisp_spirits_custom_creep_hit = class({})
function modifier_wisp_spirits_custom_creep_hit:IsHidden() return true end

modifier_wisp_spirits_custom_hero_hit = class({})
function modifier_wisp_spirits_custom_hero_hit:IsHidden() return true end

wisp_spirits_in_custom = class({})

function wisp_spirits_in_custom:OnToggle()
    if not IsServer() then return end
    local modifier_wisp_spirits_custom = self:GetCaster():FindModifierByName("modifier_wisp_spirits_custom")
    if not modifier_wisp_spirits_custom then return end
    local wisp_spirits_out_custom = self:GetCaster():FindAbilityByName("wisp_spirits_out_custom")
    if self:GetToggleState() then
        modifier_wisp_spirits_custom.spirits_movementFactor = -1
        if wisp_spirits_out_custom and wisp_spirits_out_custom:GetToggleState() then
            wisp_spirits_out_custom:ToggleAbility()
        end
    else
        if not wisp_spirits_out_custom:GetToggleState() then
            modifier_wisp_spirits_custom.spirits_movementFactor = 0
        end
    end
end

wisp_spirits_out_custom = class({})

function wisp_spirits_out_custom:OnToggle()
    if not IsServer() then return end
    local modifier_wisp_spirits_custom = self:GetCaster():FindModifierByName("modifier_wisp_spirits_custom")
    if not modifier_wisp_spirits_custom then return end
    local wisp_spirits_in_custom = self:GetCaster():FindAbilityByName("wisp_spirits_in_custom")
    if self:GetToggleState() then
        modifier_wisp_spirits_custom.spirits_movementFactor = 1
        if wisp_spirits_in_custom and wisp_spirits_in_custom:GetToggleState() then
            wisp_spirits_in_custom:ToggleAbility()
        end
    else
        if not wisp_spirits_in_custom:GetToggleState() then
            modifier_wisp_spirits_custom.spirits_movementFactor = 0
        end
    end
end

modifier_wisp_spirits_custom_creep_slow = class({})
function modifier_wisp_spirits_custom_creep_slow:GetTexture() return "wisp_21" end
function modifier_wisp_spirits_custom_creep_slow:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end
function modifier_wisp_spirits_custom_creep_slow:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility().modifier_wisp_21
end