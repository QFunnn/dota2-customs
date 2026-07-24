--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_spirit_breaker_greater_bash_custom", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_greater_bash", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spirit_breaker_greater_bash_custom_knockback", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_greater_bash", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_spirit_breaker_greater_bash_custom_vision", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_greater_bash", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spirit_breaker_greater_bash_custom_cooldown", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_greater_bash", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spirit_breaker_greater_bash_custom_light", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_greater_bash", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spirit_breaker_greater_bash_custom_light_attackspeed", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_greater_bash", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spirit_breaker_greater_bash_custom_light_spell_amplify", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_greater_bash", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spirit_breaker_greater_bash_custom_light_spell_amplify_stack", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_greater_bash", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spirit_breaker_greater_bash_custom_stack_vision", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_greater_bash", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spirit_breaker_greater_bash_custom_scepter_cooldown", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_greater_bash", LUA_MODIFIER_MOTION_NONE )

spirit_breaker_greater_bash_custom = class({})

spirit_breaker_greater_bash_custom.modifier_spirit_breaker_8_targets = {1,2}
spirit_breaker_greater_bash_custom.modifier_spirit_breaker_8_attacks = {30,15}
spirit_breaker_greater_bash_custom.modifier_spirit_breaker_8_duration = 5
spirit_breaker_greater_bash_custom.modifier_spirit_breaker_8_radius = 300
spirit_breaker_greater_bash_custom.modifier_spirit_breaker_9_bash_duration = {0.1,0.2,0.3}
spirit_breaker_greater_bash_custom.modifier_spirit_breaker_13 = {350,350}
spirit_breaker_greater_bash_custom.modifier_spirit_breaker_13_duration = 10
spirit_breaker_greater_bash_custom.modifier_spirit_breaker_13_spell = {4,6}
spirit_breaker_greater_bash_custom.modifier_spirit_breaker_13_lifesteal = 3

spirit_breaker_greater_bash_custom.cascading_bash_cooldown = 1.2
spirit_breaker_greater_bash_custom.cascading_bashes_damage_multiplier = 25
spirit_breaker_greater_bash_custom.cascading_bashes_creep_penalty = 25
spirit_breaker_greater_bash_custom.cascading_bashes_nether_strike_additional_cooldown = 0.6
spirit_breaker_greater_bash_custom.cascading_bashes_hero_hitbox = 185
spirit_breaker_greater_bash_custom.cascading_bashes_creep_hitbox = 100

function spirit_breaker_greater_bash_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_spirit_breaker_13") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
    return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function spirit_breaker_greater_bash_custom:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_2)
    if self.npc_dota_spirit_breaker_light ~= nil and not self.npc_dota_spirit_breaker_light:IsNull() and self.npc_dota_spirit_breaker_light:IsAlive() then
        UTIL_Remove(self.npc_dota_spirit_breaker_light)
        self.npc_dota_spirit_breaker_light = nil
    end
    self.npc_dota_spirit_breaker_light = CreateUnitByName("npc_dota_spirit_breaker_light", self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * 200, true, self:GetCaster(), self:GetCaster(), DOTA_TEAM_NEUTRALS)
    if self.npc_dota_spirit_breaker_light then
        self.npc_dota_spirit_breaker_light:AddNewModifier(self:GetCaster(), self, "modifier_spirit_breaker_greater_bash_custom_light", {duration = 20})
        self.npc_dota_spirit_breaker_light:SetRenderColor(83, 89, 255)
    end
end

function spirit_breaker_greater_bash_custom:GetCooldown(level)
    if self:GetCaster():HasModifier("modifier_spirit_breaker_13") then
        return 20
    end
    return self.BaseClass.GetCooldown( self, level )
end

function spirit_breaker_greater_bash_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_spirit_breaker.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_spirit_breaker/spirit_breaker_greater_bash.vpcf", context )
end

function spirit_breaker_greater_bash_custom:GetIntrinsicModifierName()
	return "modifier_spirit_breaker_greater_bash_custom"
end

modifier_spirit_breaker_greater_bash_custom = class({})

function modifier_spirit_breaker_greater_bash_custom:IsPurgable() return false end
function modifier_spirit_breaker_greater_bash_custom:IsPurgeException() return false end
function modifier_spirit_breaker_greater_bash_custom:RemoveOnDeath() return false end
function modifier_spirit_breaker_greater_bash_custom:IsHidden() return true end

function modifier_spirit_breaker_greater_bash_custom:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.pseudoseed = RandomInt( 1, 100 )
	self.chance = self:GetAbility():GetSpecialValueFor( "chance_pct" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )

	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
	
	self.knockback_duration = self:GetAbility():GetSpecialValueFor( "knockback_duration" )
	self.knockback_distance = self:GetAbility():GetSpecialValueFor( "knockback_distance" )
	self.knockback_height = self:GetAbility():GetSpecialValueFor( "knockback_height" )
	self.movespeed_pct = self:GetAbility():GetSpecialValueFor( "bonus_movespeed_pct" )
	self.movespeed_duration = self:GetAbility():GetSpecialValueFor( "movespeed_duration" )
	if not IsServer() then return end
end

function modifier_spirit_breaker_greater_bash_custom:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_spirit_breaker_greater_bash_custom:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
	return funcs
end

function modifier_spirit_breaker_greater_bash_custom:GetModifierProcAttack_Feedback( params )
	if not IsServer() then return end

	if self.parent:PassivesDisabled() then return end
	if params.target:IsWard() then return end
    if self:GetParent():IsIllusion() then return end
	if self:GetParent():HasModifier("modifier_item_diffusal_basher") then return end
    if self:GetCaster():HasModifier("modifier_spirit_breaker_13") then
        if self:GetCaster():HasModifier("modifier_spirit_breaker_greater_bash_custom_cooldown") then return end
    else
        if not self.ability:IsFullyCastable() then return end
    end
	local filter = UnitFilter( params.target, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, self.parent:GetTeamNumber())
	if filter~=UF_SUCCESS then return end
    local bash_proc = false
    if RollPseudoRandomPercentage( self.chance, self.pseudoseed, self.parent ) then 
        bash_proc = true
    end

	if bash_proc then 
        if self:GetCaster():HasModifier("modifier_spirit_breaker_13") then
            self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_spirit_breaker_greater_bash_custom_cooldown", {duration = 1.2 * self:GetCaster():GetCooldownReduction()})
        else
            self.ability:UseResources( false, false, false, true )
        end
	    self:Bash( params.target, false )
        self:BashTalentEight()
        local bashed_units = {}
        if self:GetCaster():HasModifier("modifier_spirit_breaker_8") then
            bashed_units = self:AoeBash(params.target, params.target:GetAbsOrigin(), bashed_units)
        end
    end
end

function modifier_spirit_breaker_greater_bash_custom:AoeBash(target, point, bashed_units)
    if not IsServer() then return end
    local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), point, nil, self:GetAbility().modifier_spirit_breaker_8_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
    for _, unit in pairs(units) do
        if unit ~= target and not bashed_units[unit:entindex()] then
            self:Bash( unit, false )
            self:BashTalentEight()
            bashed_units[unit:entindex()] = true
        end
    end
    return bashed_units
end

function modifier_spirit_breaker_greater_bash_custom:BashTalentEight()
    if not self:GetCaster():HasModifier("modifier_spirit_breaker_8") then return end
    local modifier_spirit_breaker_greater_bash_custom_stack_vision = self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_spirit_breaker_greater_bash_custom_stack_vision", {})
    if modifier_spirit_breaker_greater_bash_custom_stack_vision and modifier_spirit_breaker_greater_bash_custom_stack_vision:GetStackCount() >= self:GetAbility().modifier_spirit_breaker_8_attacks[self:GetCaster():GetTalentLevel("modifier_spirit_breaker_8")] then
        modifier_spirit_breaker_greater_bash_custom_stack_vision:SetStackCount(0)
        local vision_units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
        for _, vision_unit in pairs(vision_units) do
            if vision_unit and vision_unit:IsAlive() then
                vision_unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_spirit_breaker_greater_bash_custom_vision", {duration = self:GetAbility().modifier_spirit_breaker_8_duration* (1 - vision_unit:GetStatusResistance())})
                break
            end
        end
    end
end

function modifier_spirit_breaker_greater_bash_custom:Bash( target, double, caster, new_direction, is_scepter )
    local start_caster = self.parent
    if caster then
        start_caster = caster
    end

    local bash_duration_bonus = 0
	if self:GetCaster():HasModifier("modifier_spirit_breaker_9") then
        bash_duration_bonus = self:GetAbility().modifier_spirit_breaker_9_bash_duration[self:GetCaster():GetTalentLevel("modifier_spirit_breaker_9")]
	end
    
	local direction = target:GetOrigin()-start_caster:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

    if new_direction then
        direction = new_direction
    end

	local dist = self.knockback_distance

	if double then
		dist = dist*2
	end

    target:AddNewModifier( start_caster, self.ability, "modifier_stunned", { duration = (self.duration + bash_duration_bonus) * (1 - target:GetStatusResistance()) } )
    local arc = target:AddNewModifier( start_caster, self.ability, "modifier_spirit_breaker_greater_bash_custom_knockback", { dir_x = direction.x, dir_y = direction.y, duration = self.knockback_duration * (1 - target:GetStatusResistance()), distance = dist, height = self.knockback_height, activity = ACT_DOTA_FLAIL, IsStun = true } )
    arc:SetEndCallback(function()
        FindClearSpaceForUnit(target, target:GetAbsOrigin(), true)
    end)

    local damge_movespeed = self.damage

	local damage = start_caster:GetIdealSpeed() * damge_movespeed/100
    if is_scepter then
        damage = damage * (1 + (self:GetAbility().cascading_bashes_damage_multiplier / 100))
        if not target:IsHero() then
            damage = damage * (self:GetAbility().cascading_bashes_creep_penalty / 100)
        end
    end

	local damageTable = 
    {
		victim = target,
		attacker = start_caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self.ability,
	}

	ApplyDamage( damageTable )
	self:PlayEffects( target, not target:IsHero() )
end

function modifier_spirit_breaker_greater_bash_custom:PlayEffects( target, isCreep )
	local sound_cast = "Hero_Spirit_Breaker.GreaterBash"
	if isCreep then
		sound_cast = "Hero_Spirit_Breaker.GreaterBash.Creep"
	end
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_spirit_breaker/spirit_breaker_greater_bash.vpcf", PATTACH_POINT_FOLLOW, target )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:ReleaseParticleIndex( effect_cast )
    target:EmitSound(sound_cast)
end

modifier_spirit_breaker_greater_bash_custom_knockback = class({})

function modifier_spirit_breaker_greater_bash_custom_knockback:IsHidden() return true end

function modifier_spirit_breaker_greater_bash_custom_knockback:IsDebuff()
	return false
end

function modifier_spirit_breaker_greater_bash_custom_knockback:IsStunDebuff()
	return false
end

function modifier_spirit_breaker_greater_bash_custom_knockback:IsPurgable()
	return true
end

function modifier_spirit_breaker_greater_bash_custom_knockback:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_spirit_breaker_greater_bash_custom_knockback:OnCreated( kv )
	if not IsServer() then return end
    self.ignore_heroes = kv.ignore_heroes or {}
	self.interrupted = false
	self:SetJumpParameters( kv )
	self:Jump()
end

function modifier_spirit_breaker_greater_bash_custom_knockback:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_spirit_breaker_greater_bash_custom_knockback:OnRemoved()
end

function modifier_spirit_breaker_greater_bash_custom_knockback:OnDestroy()
	if not IsServer() then return end

	-- preserve height
	local pos = self:GetParent():GetOrigin()

	self:GetParent():RemoveHorizontalMotionController( self )
	self:GetParent():RemoveVerticalMotionController( self )

	-- preserve height if has end offset
	if self.end_offset~=0 then
		self:GetParent():SetOrigin( pos )
	end

	if self.endCallback then
		self.endCallback( self.interrupted )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_spirit_breaker_greater_bash_custom_knockback:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DISABLE_TURNING,
	}
	if self:GetStackCount()>0 then
		table.insert( funcs, MODIFIER_PROPERTY_OVERRIDE_ANIMATION )
	end

	return funcs
end

function modifier_spirit_breaker_greater_bash_custom_knockback:GetModifierDisableTurning()
	if not self.isForward then return end
	return 1
end
function modifier_spirit_breaker_greater_bash_custom_knockback:GetOverrideAnimation()
	return self:GetStackCount()
end
--------------------------------------------------------------------------------
-- Status Effects
function modifier_spirit_breaker_greater_bash_custom_knockback:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = self.isRestricted or false,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_spirit_breaker_greater_bash_custom_knockback:UpdateHorizontalMotion( me, dt )
	if self.fix_duration and self:GetElapsedTime()>=self.duration then return end
	local pos = me:GetOrigin() + self.direction * self.speed * dt
	me:SetOrigin( pos )
    if self:GetCaster():HasModifier("modifier_spirit_breaker_14") then
        local radius = self:GetAbility().cascading_bashes_hero_hitbox
        if not self:GetParent():IsHero() then
            radius = self:GetAbility().cascading_bashes_hero_hitbox
        end
        local modifier_spirit_breaker_greater_bash_custom = self:GetCaster():FindModifierByName("modifier_spirit_breaker_greater_bash_custom")
        if modifier_spirit_breaker_greater_bash_custom then
            local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), pos, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
            for _, enemy in pairs(enemies) do
                if not enemy:HasModifier("modifier_spirit_breaker_greater_bash_custom_knockback") and not enemy:HasModifier("modifier_spirit_breaker_greater_bash_custom_scepter_cooldown") and not self.ignore_heroes[enemy:entindex()] and enemy ~= self:GetParent() then
                    local new_direction = enemy:GetAbsOrigin() - self:GetParent():GetAbsOrigin()
                    new_direction.z = 0
                    new_direction = new_direction:Normalized()
                    self.ignore_heroes[enemy:entindex()] = true
                    modifier_spirit_breaker_greater_bash_custom:Bash(enemy, nil, nil, new_direction, true, self.ignore_heroes)
                    enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_spirit_breaker_greater_bash_custom_scepter_cooldown", {duration = self:GetAbility().cascading_bash_cooldown})
                end
            end
        end
    end
end

function modifier_spirit_breaker_greater_bash_custom_knockback:UpdateVerticalMotion( me, dt )
	if self.fix_duration and self:GetElapsedTime()>=self.duration then return end

	local pos = me:GetOrigin()
	local time = self:GetElapsedTime()

	-- set relative position
	local height = pos.z
	local speed = self:GetVerticalSpeed( time )
	pos.z = height + speed * dt
	me:SetOrigin( pos )

	if not self.fix_duration then
		local ground = GetGroundHeight( pos, me ) + self.end_offset
		if pos.z <= ground then

			-- below ground, set height as ground then destroy
			pos.z = ground
			me:SetOrigin( pos )
			self:Destroy()
		end
	end
end

function modifier_spirit_breaker_greater_bash_custom_knockback:OnHorizontalMotionInterrupted()
	self.interrupted = true
	self:Destroy()
end

function modifier_spirit_breaker_greater_bash_custom_knockback:OnVerticalMotionInterrupted()
	self.interrupted = true
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Motion Helper
function modifier_spirit_breaker_greater_bash_custom_knockback:SetJumpParameters( kv )
	self.parent = self:GetParent()

	-- load types
	self.fix_end = true
	self.fix_duration = true
	self.fix_height = true
	if kv.fix_end then
		self.fix_end = kv.fix_end==1
	end
	if kv.fix_duration then
		self.fix_duration = kv.fix_duration==1
	end
	if kv.fix_height then
		self.fix_height = kv.fix_height==1
	end

	-- load other types
	self.isStun = kv.isStun==1
	self.isRestricted = kv.isRestricted==1
	self.isForward = kv.isForward==1
	self.activity = kv.activity or 0
	self:SetStackCount( self.activity )

	-- load direction
	if kv.target_x and kv.target_y then
		local origin = self.parent:GetOrigin()
		local dir = Vector( kv.target_x, kv.target_y, 0 ) - origin
		dir.z = 0
		dir = dir:Normalized()
		self.direction = dir
	end
	if kv.dir_x and kv.dir_y then
		self.direction = Vector( kv.dir_x, kv.dir_y, 0 ):Normalized()
	end
	if not self.direction then
		self.direction = self.parent:GetForwardVector()
	end

	-- load horizontal data
	self.duration = kv.duration
	self.distance = kv.distance
	self.speed = kv.speed
	if not self.duration then
		self.duration = self.distance/self.speed
	end
	if not self.distance then
		self.speed = self.speed or 0
		self.distance = self.speed*self.duration
	end
	if not self.speed then
		self.distance = self.distance or 0
		self.speed = self.distance/self.duration
	end

	-- load vertical data
	self.height = kv.height or 0
	self.start_offset = kv.start_offset or 0
	self.end_offset = kv.end_offset or 0

	-- calculate height positions
	local pos_start = self.parent:GetOrigin()
	local pos_end = pos_start + self.direction * self.distance
	local height_start = GetGroundHeight( pos_start, self.parent ) + self.start_offset
	local height_end = GetGroundHeight( pos_end, self.parent ) + self.end_offset
	local height_max

	-- determine jumping height if not fixed
	if not self.fix_height then
	
		-- ideal height is proportional to max distance
		self.height = math.min( self.height, self.distance/4 )
	end

	-- determine height max
	if self.fix_end then
		height_end = height_start
		height_max = height_start + self.height
	else
		-- calculate height
		local tempmin, tempmax = height_start, height_end
		if tempmin>tempmax then
			tempmin,tempmax = tempmax, tempmin
		end
		local delta = (tempmax-tempmin)*2/3

		height_max = tempmin + delta + self.height
	end

	-- set duration
	if not self.fix_duration then
		self:SetDuration( -1, false )
	else
		self:SetDuration( self.duration, true )
	end

	-- calculate arc
	self:InitVerticalArc( height_start, height_max, height_end, self.duration )
end

function modifier_spirit_breaker_greater_bash_custom_knockback:Jump()
	-- apply horizontal motion
	if self.distance>0 then
		if not self:ApplyHorizontalMotionController() then
			self.interrupted = true
			self:Destroy()
		end
	end

	-- apply vertical motion
	if self.height>0 then
		if not self:ApplyVerticalMotionController() then
			self.interrupted = true
			self:Destroy()
		end
	end
end

function modifier_spirit_breaker_greater_bash_custom_knockback:InitVerticalArc( height_start, height_max, height_end, duration )
	local height_end = height_end - height_start
	local height_max = height_max - height_start

	-- fail-safe1: height_max cannot be smaller than height delta
	if height_max<height_end then
		height_max = height_end+0.01
	end

	-- fail-safe2: height-max must be positive
	if height_max<=0 then
		height_max = 0.01
	end

	-- math magic
	local duration_end = ( 1 + math.sqrt( 1 - height_end/height_max ) )/2
	self.const1 = 4*height_max*duration_end/duration
	self.const2 = 4*height_max*duration_end*duration_end/(duration*duration)
end

function modifier_spirit_breaker_greater_bash_custom_knockback:GetVerticalPos( time )
	return self.const1*time - self.const2*time*time
end

function modifier_spirit_breaker_greater_bash_custom_knockback:GetVerticalSpeed( time )
	return self.const1 - 2*self.const2*time
end

--------------------------------------------------------------------------------
-- Helper
function modifier_spirit_breaker_greater_bash_custom_knockback:SetEndCallback( func )
	self.endCallback = func
end


modifier_spirit_breaker_greater_bash_custom_cooldown = class({})
function modifier_spirit_breaker_greater_bash_custom_cooldown:IsHidden() return true end
function modifier_spirit_breaker_greater_bash_custom_cooldown:IsPurgeException() return false end
function modifier_spirit_breaker_greater_bash_custom_cooldown:IsPurgable() return false end
function modifier_spirit_breaker_greater_bash_custom_cooldown:RemoveOnDeath() return false end

modifier_spirit_breaker_greater_bash_custom_light = class({})
function modifier_spirit_breaker_greater_bash_custom_light:IsHidden() return true end
function modifier_spirit_breaker_greater_bash_custom_light:IsPurgable() return false end

function modifier_spirit_breaker_greater_bash_custom_light:OnCreated()
	if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/spirit_breaker_sphere.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    self:AddParticle(particle, false, false, -1, false, false)
	self:StartIntervalThink(FrameTime())
end

function modifier_spirit_breaker_greater_bash_custom_light:OnIntervalThink()
	if not IsServer() then return end
	AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), 10, FrameTime()*2, true)
end

function modifier_spirit_breaker_greater_bash_custom_light:CheckState()
	return
	{
	    [MODIFIER_STATE_STUNNED] = true,
	    [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	    [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	    --[MODIFIER_STATE_MAGIC_IMMUNE] = true
	}
end

function modifier_spirit_breaker_greater_bash_custom_light:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove(self:GetParent())
end

function modifier_spirit_breaker_greater_bash_custom_light:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        MODIFIER_EVENT_ON_ATTACK_START,
		 
	}
	return funcs
end

function modifier_spirit_breaker_greater_bash_custom_light:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_spirit_breaker_greater_bash_custom_light:GetAbsoluteNoDamageMagical()
	return 1
end

function modifier_spirit_breaker_greater_bash_custom_light:GetAbsoluteNoDamagePure()
	return 1
end

function modifier_spirit_breaker_greater_bash_custom_light:OnAttackStart(params)
    if not IsServer() then return end
    if params.target ~= self:GetParent() then return end
    if params.attacker ~= self:GetCaster() then return end
    if not params.attacker:IsRealHero() then return end
    params.attacker:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_spirit_breaker_greater_bash_custom_light_attackspeed", {duration = 1})
end

function modifier_spirit_breaker_greater_bash_custom_light:OnAttackLanded(params)
    if not IsServer() then return end
    if params.target ~= self:GetParent() then return end
    if params.attacker:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then return end
    if not params.attacker:IsRealHero() then return end
    params.attacker:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_spirit_breaker_greater_bash_custom_light_attackspeed", {duration = 1})
    params.attacker:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_spirit_breaker_greater_bash_custom_light_spell_amplify_stack", {duration = self:GetAbility().modifier_spirit_breaker_13_duration})
    params.attacker:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_spirit_breaker_greater_bash_custom_light_spell_amplify", {duration = self:GetAbility().modifier_spirit_breaker_13_duration})
    local lifesteal = params.attacker:GetMaxHealth() / 100 * self:GetAbility().modifier_spirit_breaker_13_lifesteal
    params.attacker:Heal(lifesteal, self:GetAbility())
    local particle = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.attacker )
 	ParticleManager:ReleaseParticleIndex( particle )
    SendOverheadEventMessage(params.attacker, 10, params.attacker, lifesteal, nil)
end

modifier_spirit_breaker_greater_bash_custom_light_attackspeed = class({})
function modifier_spirit_breaker_greater_bash_custom_light_attackspeed:IsHidden() return true end
function modifier_spirit_breaker_greater_bash_custom_light_attackspeed:IsPurgable() return false end

function modifier_spirit_breaker_greater_bash_custom_light_attackspeed:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_EVENT_ON_ATTACK_START
    }
end

function modifier_spirit_breaker_greater_bash_custom_light_attackspeed:OnAttackStart(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target and not params.target:HasModifier("modifier_spirit_breaker_greater_bash_custom_light") then
		self:Destroy()
	end
end

function modifier_spirit_breaker_greater_bash_custom_light_attackspeed:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility().modifier_spirit_breaker_13[self:GetCaster():GetTalentLevel("modifier_spirit_breaker_13")]
end

modifier_spirit_breaker_greater_bash_custom_light_spell_amplify_stack = class({})
function modifier_spirit_breaker_greater_bash_custom_light_spell_amplify_stack:IsHidden() return true end
function modifier_spirit_breaker_greater_bash_custom_light_spell_amplify_stack:IsPurgable() return false end
function modifier_spirit_breaker_greater_bash_custom_light_spell_amplify_stack:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end


modifier_spirit_breaker_greater_bash_custom_light_spell_amplify = class({})
function modifier_spirit_breaker_greater_bash_custom_light_spell_amplify:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(1)
    self:StartIntervalThink(FrameTime())
end
function modifier_spirit_breaker_greater_bash_custom_light_spell_amplify:OnIntervalThink()
    if not IsServer() then return end
    local stack = self:GetParent():FindAllModifiersByName("modifier_spirit_breaker_greater_bash_custom_light_spell_amplify_stack")
    self:SetStackCount(#stack * self:GetAbility().modifier_spirit_breaker_13_spell[self:GetCaster():GetTalentLevel("modifier_spirit_breaker_13")])
end
function modifier_spirit_breaker_greater_bash_custom_light_spell_amplify:IsPurgable()  return false end
function modifier_spirit_breaker_greater_bash_custom_light_spell_amplify:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
end
function modifier_spirit_breaker_greater_bash_custom_light_spell_amplify:GetModifierAttackSpeedBonus_Constant()
    return self:GetStackCount()
end
function modifier_spirit_breaker_greater_bash_custom_light_spell_amplify:GetTexture() return "spirit_breaker_13" end

modifier_spirit_breaker_greater_bash_custom_stack_vision = class({})
function modifier_spirit_breaker_greater_bash_custom_stack_vision:IsPurgable() return false end
function modifier_spirit_breaker_greater_bash_custom_stack_vision:IsPurgeException() return false end
function modifier_spirit_breaker_greater_bash_custom_stack_vision:RemoveOnDeath() return false end
function modifier_spirit_breaker_greater_bash_custom_stack_vision:GetTexture() return "spirit_breaker_8" end
function modifier_spirit_breaker_greater_bash_custom_stack_vision:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(1)
end
function modifier_spirit_breaker_greater_bash_custom_stack_vision:OnRefresh()
    if not IsServer() then return end
    self:IncrementStackCount()
end

modifier_spirit_breaker_greater_bash_custom_vision = class({})
function modifier_spirit_breaker_greater_bash_custom_vision:IsHidden() return true end
function modifier_spirit_breaker_greater_bash_custom_vision:IsPurgable()
	return false
end
function modifier_spirit_breaker_greater_bash_custom_vision:OnCreated( kv )
	if not IsServer() then return end
    self:StartIntervalThink(0.1)
end
function modifier_spirit_breaker_greater_bash_custom_vision:OnIntervalThink()
    if not IsServer() then return end
    self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_truesight", {duration = 0.2})
    if self:GetParent():IsNeutralUnitType() then
        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), 100, 0.1, true)
    else
        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self:GetParent():GetCurrentVisionRange(), 0.1, true)
    end
end

modifier_spirit_breaker_greater_bash_custom_scepter_cooldown = class({})
function modifier_spirit_breaker_greater_bash_custom_scepter_cooldown:IsHidden() return true end