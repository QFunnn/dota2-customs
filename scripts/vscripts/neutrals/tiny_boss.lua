--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tiny_boss_toss", "neutrals/tiny_boss", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tiny_boss_toss_debuff", "neutrals/tiny_boss", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier("modifier_tiny_boss_toss_arc", "neutrals/tiny_boss", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

tiny_boss_toss = class({})

function tiny_boss_toss:Precache(context)
    PrecacheResource( "particle", "particles/abilities_ranger_finder_check_ultimate_calldown.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_tiny/tiny_toss_blur.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/tiny/tiny_prestige/tiny_prestige_avalanche.vpcf", context )
    PrecacheResource( "particle", "particles/test_particle/ogre_melee_smash.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf", context )
end

function tiny_boss_toss:GetIntrinsicModifierName()
	return "modifier_tiny_boss_toss"
end

modifier_tiny_boss_toss = class({})

function modifier_tiny_boss_toss:IsHidden() return true end
function modifier_tiny_boss_toss:IsPurgable() return false end


function modifier_tiny_boss_toss:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
	}
end

function modifier_tiny_boss_toss:GetModifierStatusResistanceStacking()
	if self:GetParent():HasModifier("modifier_woda_pve_creep_upgrade_wave") then return end
	if self:GetParent():HasModifier("modifier_wodaduel_boss_multiplier") then return end
	return 75
end

function modifier_tiny_boss_toss:OnCreated()
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self:StartIntervalThink(1)
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.first_use_hp = self:GetAbility():GetSpecialValueFor("first_use_hp")
	self.second_use_hp = self:GetAbility():GetSpecialValueFor("second_use_hp")
	self.delay = self:GetAbility():GetSpecialValueFor("delay")
	self.first_use = true
	self.second_use = true
end

function modifier_tiny_boss_toss:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetParent():IsAlive() then return end
	if not self:GetAbility():IsFullyCastable() then return end
    if not self:GetParent():GetAggroTarget() then return end
    self:GetAbility():StartCooldown(15)
    self:StartToss()
end

function modifier_tiny_boss_toss:StartToss()
	if not IsServer() then return end

	self.particle = ParticleManager:CreateParticle("particles/abilities_ranger_finder_check_ultimate_calldown.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl( self.particle, 0, self:GetParent():GetAbsOrigin() )
	ParticleManager:SetParticleControl( self.particle, 1, Vector( self.radius, 0, -500 ) )
	ParticleManager:SetParticleControl( self.particle, 2, Vector( self.delay, 0, 0 ) )

	local particle = self.particle

	local parent = self:GetParent()

	Timers:CreateTimer(self.delay, function()

		if not parent:IsAlive() then
			ParticleManager:DestroyParticle(particle, true)
			return
		end

		self:GetCaster():StartGestureWithPlaybackRate(ACT_TINY_TOSS, 1)

		if self.particle then
			ParticleManager:DestroyParticle(self.particle, true)
			ParticleManager:ReleaseParticleIndex(self.particle)
		end

		local points = 
		{
			"woda_point_toss_1",
			"woda_point_toss_2",
		}

		if self:GetParent():HasModifier("modifier_wodaduel_boss_multiplier") then
			if GetMapName() == "arena" then
				points = 
				{
					"relaxarena",
				}
			end
		end

		if self:GetParent():HasModifier("modifier_woda_pve_creep_upgrade_wave") then
			points = 
			{
				"relaxarena",
			}
		end

		local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
        for i = #units, 1, -1 do
            if units[i] and units[i]:GetUnitName() == "npc_woda_wisp_death" then
                table.remove(units, i)
            end
        end
        
        for _, unit in pairs(units) do
			local current_point_name = points[RandomInt(1, #points)]
			local point = Entities:FindByName(nil, current_point_name)
			if point then
				unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_tiny_boss_toss_debuff", {x = point:GetAbsOrigin().x,y = point:GetAbsOrigin().y,z = point:GetAbsOrigin().z})
			end
		end
	end)
end

modifier_tiny_boss_toss_debuff = class({})

function modifier_tiny_boss_toss_debuff:IsHidden()
	return true
end

function modifier_tiny_boss_toss_debuff:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	local duration = self:GetAbility():GetSpecialValueFor( "duration" )
	local height = 850
	self.point = Vector(kv.x,kv.y,kv.z)
	self.radius = self:GetAbility():GetSpecialValueFor("radius")

	self.arc = self.parent:AddNewModifier(
		self.caster,
		self:GetAbility(),
		"modifier_tiny_boss_toss_arc",
		{
			duration = duration,
			distance = 0,
			height = height,
			fix_duration = false,
			isStun = true,
			activity = ACT_DOTA_FLAIL,
		}
	)

	self.arc:SetEndCallback(function( interrupted )
		self:Destroy()
		if interrupted then return end
		GridNav:DestroyTreesAroundPoint( self.parent:GetOrigin(), self.radius, false )
		FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), true)
		local sound_cast = "Ability.TossImpact"
		EmitSoundOn( "Ability.TossImpact", self.parent )
	end)

	local origin = self.point
	local direction = origin-self.parent:GetOrigin()
	local distance = direction:Length2D()
	direction.z = 0
	direction = direction:Normalized()
	self.distance = distance
	if self.distance==0 then self.distance = 1 end
	self.duration = duration
	self.speed = distance/duration
	self.accel = 100
	self.max_speed = 3000
	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
	end
	EmitSoundOn( "Ability.TossThrow", self.caster )
	EmitSoundOn( "Hero_Tiny.Toss.Target", self.parent )
end

function modifier_tiny_boss_toss_debuff:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveHorizontalMotionController( self )
end

function modifier_tiny_boss_toss_debuff:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}
	return state
end

function modifier_tiny_boss_toss_debuff:UpdateHorizontalMotion( me, dt )
	local target = self.point
	local parent = self.parent:GetOrigin()
	local duration = self:GetElapsedTime()
	local direction = target-parent
	local distance = direction:Length2D()
	direction.z = 0
	direction = direction:Normalized()
	local original_distance = duration/self.duration * self.distance
	local expected_speed
	if self:GetElapsedTime()>=self.duration then
		expected_speed = self.speed
	else
		expected_speed = distance/(self.duration-self:GetElapsedTime())
	end
	if self.speed<expected_speed then
		self.speed = math.min(self.speed + self.accel, self.max_speed)
	elseif self.speed>expected_speed then
		self.speed = math.max(self.speed - self.accel, 0)
	end
	local pos = parent + direction * self.speed * dt
	me:SetOrigin( pos )
end

function modifier_tiny_boss_toss_debuff:OnHorizontalMotionInterrupted()
	self:Destroy()
end

function modifier_tiny_boss_toss_debuff:GetEffectName()
	return "particles/units/heroes/hero_tiny/tiny_toss_blur.vpcf"
end

function modifier_tiny_boss_toss_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end



modifier_tiny_boss_toss_arc = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_tiny_boss_toss_arc:IsHidden()
	return true
end

function modifier_tiny_boss_toss_arc:IsDebuff()
	return false
end

function modifier_tiny_boss_toss_arc:IsStunDebuff()
	return false
end

function modifier_tiny_boss_toss_arc:IsPurgable()
	return true
end

function modifier_tiny_boss_toss_arc:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_tiny_boss_toss_arc:OnCreated( kv )
	if not IsServer() then return end
	self.interrupted = false
	self:SetJumpParameters( kv )
	self:Jump()
end

function modifier_tiny_boss_toss_arc:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_tiny_boss_toss_arc:OnRemoved()
end

function modifier_tiny_boss_toss_arc:OnDestroy()
	if not IsServer() then return end
	local pos = self:GetParent():GetOrigin()
	self:GetParent():RemoveHorizontalMotionController( self )
	self:GetParent():RemoveVerticalMotionController( self )

	if self.end_offset~=0 then
		self:GetParent():SetOrigin( pos )
	end

	if self.endCallback then
		self.endCallback( self.interrupted )
	end
end

function modifier_tiny_boss_toss_arc:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DISABLE_TURNING,
	}
	if self:GetStackCount()>0 then
		table.insert( funcs, MODIFIER_PROPERTY_OVERRIDE_ANIMATION )
	end

	return funcs
end

function modifier_tiny_boss_toss_arc:GetModifierDisableTurning()
	if not self.isForward then return end
	return 1
end

function modifier_tiny_boss_toss_arc:GetOverrideAnimation()
	return self:GetStackCount()
end

function modifier_tiny_boss_toss_arc:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = self.isStun or false,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = self.isRestricted or false,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

function modifier_tiny_boss_toss_arc:UpdateHorizontalMotion( me, dt )
	if self.fix_duration and self:GetElapsedTime()>=self.duration then return end
	local pos = me:GetOrigin() + self.direction * self.speed * dt
	me:SetOrigin( pos )
end

function modifier_tiny_boss_toss_arc:UpdateVerticalMotion( me, dt )
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
			pos.z = ground
			me:SetOrigin( pos )
			self:Destroy()
		end
	end
end

function modifier_tiny_boss_toss_arc:OnHorizontalMotionInterrupted()
	self.interrupted = true
	self:Destroy()
end

function modifier_tiny_boss_toss_arc:OnVerticalMotionInterrupted()
	self.interrupted = true
	self:Destroy()
end

function modifier_tiny_boss_toss_arc:SetJumpParameters( kv )
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

function modifier_tiny_boss_toss_arc:Jump()
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

function modifier_tiny_boss_toss_arc:InitVerticalArc( height_start, height_max, height_end, duration )
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

function modifier_tiny_boss_toss_arc:GetVerticalPos( time )
	return self.const1*time - self.const2*time*time
end

function modifier_tiny_boss_toss_arc:GetVerticalSpeed( time )
	return self.const1 - 2*self.const2*time
end

--------------------------------------------------------------------------------
-- Helper
function modifier_tiny_boss_toss_arc:SetEndCallback( func )
	self.endCallback = func
end

LinkLuaModifier("modifier_tiny_boss_avalanche", "neutrals/tiny_boss", LUA_MODIFIER_MOTION_NONE)

tiny_boss_avalanche = class({})

function tiny_boss_avalanche:GetIntrinsicModifierName()
	return "modifier_tiny_boss_avalanche"
end

modifier_tiny_boss_avalanche = class({})

function modifier_tiny_boss_avalanche:IsHidden() return true end

function modifier_tiny_boss_avalanche:OnCreated()
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self:StartIntervalThink(0)
	self.particles = {}
end

function modifier_tiny_boss_avalanche:OnIntervalThink()
	if not IsServer() then return end
	if self:GetAbility():IsFullyCastable() and (self:GetParent():GetAggroTarget() ~= nil or self:GetParent().hTarget ~= nil) then
		self:StartAvalanch()
		self:GetCaster():StartCooldownAbil( "tiny_boss_stone_throw", 6 )
		self:GetAbility():StartCooldown(12)
	end
end

function modifier_tiny_boss_avalanche:StartAvalanch()
	if not IsServer() then return end

	for _, particle in pairs(self.particles) do
		if particle then
			ParticleManager:DestroyParticle(particle, true )
			ParticleManager:ReleaseParticleIndex( particle )
		end
	end

	local random_point = self:GetCaster():GetAbsOrigin() + RandomVector(RandomInt(0, 300))

	local start_point = RotatePosition(random_point, QAngle(0,-135,0), random_point + self:GetCaster():GetForwardVector() * 500)
	local end_point = RotatePosition(random_point, QAngle(0,45,0), random_point + self:GetCaster():GetForwardVector() * 500)

	if RollPercentage(25) then
		start_point = RotatePosition(random_point, QAngle(0,45,0), random_point + self:GetCaster():GetForwardVector() * 500)
		end_point = RotatePosition(random_point, QAngle(0,-135,0), random_point + self:GetCaster():GetForwardVector() * 500)
	elseif RollPercentage(25) then
		start_point = RotatePosition(random_point, QAngle(0,-180,0), random_point + self:GetCaster():GetForwardVector() * 500)
		end_point = RotatePosition(random_point, QAngle(0,0,0), random_point + self:GetCaster():GetForwardVector() * 500)
	elseif RollPercentage(25) then
		start_point = RotatePosition(random_point, QAngle(0,0,0), random_point + self:GetCaster():GetForwardVector() * 500)
		end_point = RotatePosition(random_point, QAngle(0,-180,0), random_point + self:GetCaster():GetForwardVector() * 500)
	elseif RollPercentage(25) then
		start_point = RotatePosition(random_point, QAngle(0,-90,0), random_point + self:GetCaster():GetForwardVector() * 500)
		end_point = RotatePosition(random_point, QAngle(0,90,0), random_point + self:GetCaster():GetForwardVector() * 500)
	end


	local delay = self:GetAbility():GetSpecialValueFor("delay") 

	local radius = self:GetAbility():GetSpecialValueFor("radius")

	local count = (end_point - start_point):Length2D() / radius

	local forward_vector = (end_point - start_point)
	forward_vector.z = 0
	forward_vector = forward_vector:Normalized()

	for i = 0, count do
		local origin = start_point + forward_vector * ( (radius * 2) * i )
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf", PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl( particle, 0, origin )
		ParticleManager:SetParticleControl( particle, 1, Vector( self:GetAbility():GetSpecialValueFor("radius"), 0, -self:GetAbility():GetSpecialValueFor("radius") + 65 ) )
		ParticleManager:SetParticleControl( particle, 2, Vector( delay, 0, 0 ) )
		table.insert(self.particles, particle)
	end

	local particles = self.particles
	local parent = self:GetParent()

	Timers:CreateTimer(delay, function()
		for _, particle in pairs(particles) do
			if particle then
				ParticleManager:DestroyParticle(particle, true )
				ParticleManager:ReleaseParticleIndex( particle )
			end
		end
		if not parent:IsAlive() then return end
		for _, particle in pairs(self.particles) do
			if particle then
				ParticleManager:DestroyParticle(particle, true )
				ParticleManager:ReleaseParticleIndex( particle )
			end
		end
		for i = 0, count do
			local origin = start_point + forward_vector * ( (radius * 2) * i )
			self:CreateAvalanch(origin, forward_vector)
			EmitSoundOnLocationWithCaster(origin, "Ability.Avalanche", self:GetCaster())
		end
	end)
end

function modifier_tiny_boss_avalanche:CreateAvalanch(origin, forward_vector)
	if not IsServer() then return end
	local caster = self:GetCaster()
    local duration = self:GetAbility():GetSpecialValueFor("stun_duration")
    local radius = self:GetAbility():GetSpecialValueFor("radius")
    local interval = self:GetAbility():GetSpecialValueFor("tick_interval")

    local avalanche = ParticleManager:CreateParticle("particles/econ/items/tiny/tiny_prestige/tiny_prestige_avalanche.vpcf", PATTACH_CUSTOMORIGIN, nil)
    ParticleManager:SetParticleControl(avalanche, 0, origin)
    ParticleManager:SetParticleControl(avalanche, 1, Vector(radius, 1, radius))
    ParticleManager:SetParticleControlForward( avalanche, 0, forward_vector)

    local offset = 0
    local ticks = self:GetAbility():GetSpecialValueFor("tick_count")
    local hitLoc = origin

    local parent = self:GetParent()

    Timers:CreateTimer(function()
    	if not parent:IsAlive() then
    		if avalanche then
                ParticleManager:DestroyParticle(avalanche, false)
                ParticleManager:ReleaseParticleIndex(avalanche)
            end
    		return
    	end
        local enemies_tick = FindUnitsInRadius(caster:GetTeamNumber(), hitLoc, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false)
        for i = #enemies_tick, 1, -1 do
            if enemies_tick[i] and enemies_tick[i]:GetUnitName() == "npc_woda_wisp_death" then
                table.remove(enemies_tick, i)
            end
        end

        local avalanche_damage = self:GetAbility():GetSpecialValueFor("avalanche_damage")

        if self:GetParent():GetUnitName() == "boss_3" then
        	avalanche_damage = avalanche_damage / 2
        end

        for _,enemy in pairs(enemies_tick) do
        	local damage = avalanche_damage / 100 * enemy:GetMaxHealth()
            ApplyDamage({victim = enemy, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self:GetAbility()})
            
            if enemy:IsAlive() then
                enemy:AddNewModifier(caster, self, "modifier_stunned", {duration = duration * (1-enemy:GetStatusResistance())})
            end
        end

        ticks = ticks - 1

        if ticks > 0 then
            return interval
        else
            if avalanche then
                ParticleManager:DestroyParticle(avalanche, false)
                ParticleManager:ReleaseParticleIndex(avalanche)
            end
        end
    end)
end

LinkLuaModifier("modifier_tiny_boss_stone_throw", "neutrals/tiny_boss", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tiny_boss_stone_throw_stone", "neutrals/tiny_boss", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tiny_boss_stone_throw_buff", "neutrals/tiny_boss", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_tiny_boss_stone_throw_debuff", "neutrals/tiny_boss", LUA_MODIFIER_MOTION_BOTH)

tiny_boss_stone_throw = class({})

function tiny_boss_stone_throw:GetIntrinsicModifierName()
	return "modifier_tiny_boss_stone_throw"
end

modifier_tiny_boss_stone_throw = class({})

function modifier_tiny_boss_stone_throw:IsHidden() return true end
function modifier_tiny_boss_stone_throw:IsPurgable() return false end
function modifier_tiny_boss_stone_throw:IsPurgeException() return false end

function modifier_tiny_boss_stone_throw:OnCreated()
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self:StartIntervalThink(0)
end

function modifier_tiny_boss_stone_throw:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetCaster():AbilityIsCooldown("tiny_boss_avalanche") then return end
	if self:GetAbility():IsFullyCastable() and (self:GetParent():GetAggroTarget() ~= nil or self:GetParent().hTarget ~= nil) then
		if not self:GetParent():IsAlive() then return end
		self:PickupStone()
		self:GetCaster():StartCooldownAbil( "tiny_boss_avalanche", 6 )
		self:GetAbility():StartCooldown(12)
	end
end

function modifier_tiny_boss_stone_throw:PickupStone()
	if not IsServer() then return end
	local stone = CreateUnitByName("npc_dota_storegga_rock2", self:GetParent():GetAbsOrigin(), false, self:GetParent(), self:GetParent(), self:GetParent():GetTeamNumber())
	stone:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_tiny_boss_stone_throw_stone", {})
	self:GetCaster():AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_tiny_boss_stone_throw_buff", {} )
    local debuff = stone:AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_tiny_boss_stone_throw_debuff", {} ) 
    self:GetAbility().debuff = debuff
    self:GetAbility().stone = stone
    local origin = self:GetParent():GetAbsOrigin()

    local radius_check = 1200

    if self:GetParent():HasModifier("modifier_wodaduel_boss_multiplier") then
	    if GetMapName() == "arena" then
	    	radius_check = -1
	    end
	end
	
	local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, radius_check, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_FARTHEST, false )
    for i = #enemies, 1, -1 do
        if enemies[i] and enemies[i]:GetUnitName() == "npc_woda_wisp_death" then
            table.remove(enemies, i)
        end
    end
	for count = #enemies, 1, -1 do
        if enemies[count] and not enemies[count]:IsAlive() then
            table.remove(units, count)
        end
    end
	
	if #enemies > 0 then
		origin = enemies[1]:GetAbsOrigin()
	end

	local particle = ParticleManager:CreateParticle("particles/abilities_ranger_finder_check_ultimate_calldown.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl( particle, 0, origin )
	ParticleManager:SetParticleControl( particle, 1, Vector( 200, 0, -500 ) )
	ParticleManager:SetParticleControl( particle, 2, Vector( (origin - self:GetCaster():GetOrigin()):Length2D() / 2500, 0, 0 ) )
	debuff:AddParticle(particle, false, false, -1, false, false)

	local parent = self:GetParent()

	Timers:CreateTimer(1, function()
		if not parent:IsAlive() then
			ParticleManager:DestroyParticle(particle, true)
			if stone then
				UTIL_Remove(stone)
			end
			return
		end
		self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 0.5)
		self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_neutral_cast", {})

		Timers:CreateTimer(0.1, function()
	    	self.attach = self:GetCaster():ScriptLookupAttachment( "attach_attack2" )
	        self.vSpawnLocation = self:GetCaster():GetAttachmentOrigin( self.attach )
	        self.vDirection = origin - self.vSpawnLocation
	        self.flDist = self.vDirection:Length2D()
	        self.vDirection.z = 0.0
	        self.vDirection = self.vDirection:Normalized()
	        self.vEndPos = self:GetCaster():GetOrigin() + self.vDirection * self.flDist  
	        local info = 
	        {
	            EffectName = "",
	            Ability = self:GetAbility(),
	            vSpawnOrigin = self.vSpawnLocation, 
	            fStartRadius = 200,
	            fEndRadius = 200,
	            vVelocity = self.vDirection * 2500,
	            fDistance = self.flDist,
	            Source = self:GetCaster(),
	            iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	            iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	        }

	        debuff:SetDuration(-1, true)
	        debuff.nProjHandle = ProjectileManager:CreateLinearProjectile( info )
	        debuff.flHeight = self.vSpawnLocation.z - GetGroundHeight( self:GetCaster():GetOrigin(), self:GetCaster() )
	        debuff.flTime = self.flDist  / 2500
	        self:GetCaster():RemoveModifierByName( "modifier_tiny_boss_stone_throw_buff" )
	        self:GetCaster():EmitSound("Hero_Tiny.Toss.Target")
	        self:GetParent():RemoveModifierByName("modifier_neutral_cast")
	    end)
	end)
end

function tiny_boss_stone_throw:OnProjectileHit( hTarget, vLocation )
    if not IsServer() then return end

    if hTarget ~= nil then
        return
    end

    EmitSoundOnLocationWithCaster( vLocation, "Ability.TossImpact", self:GetCaster() )
    EmitSoundOnLocationWithCaster( vLocation, "OgreTank.GroundSmash", self:GetCaster() )
    
    if self.stone ~= nil then
        if self.debuff and not self.debuff:IsNull() then
            self.debuff:Destroy()
        end

        local nFXIndex = ParticleManager:CreateParticle( "particles/test_particle/ogre_melee_smash.vpcf", PATTACH_WORLDORIGIN, nil  )
        ParticleManager:SetParticleControl( nFXIndex, 0, GetGroundPosition( vLocation, self.stone ) )
        ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 200, 200, 200 ) )
        ParticleManager:ReleaseParticleIndex( nFXIndex )

        self.stone:AddNewModifier(self.stone, self, "modifier_kill", {duration = 1.5})

        local damage = self:GetSpecialValueFor("damage")

        if self:GetCaster():GetUnitName() == "boss_3" then
        	damage = damage / 2
        end

        local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), vLocation, self:GetCaster(), 200, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
        for i = #enemies, 1, -1 do
            if enemies[i] and enemies[i]:GetUnitName() == "npc_woda_wisp_death" then
                table.remove(enemies, i)
            end
        end
        for _,enemy in pairs( enemies ) do
            if enemy ~= nil and enemy:IsInvulnerable() == false and enemy ~= self.stone then
                local damageInfo = 
                {
                    victim = enemy,
                    attacker = self:GetCaster(),
                    damage = damage / 100 * enemy:GetMaxHealth(),
                    damage_type = DAMAGE_TYPE_PURE,
                    ability = self,
                }

                ApplyDamage( damageInfo )

                if not enemy:IsAlive() then
                    local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf", PATTACH_CUSTOMORIGIN, nil )
                    ParticleManager:SetParticleControlEnt( nFXIndex, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetOrigin(), true )
                    ParticleManager:SetParticleControl( nFXIndex, 1, enemy:GetOrigin() )
                    ParticleManager:SetParticleControlForward( nFXIndex, 1, -self:GetCaster():GetForwardVector() )
                    ParticleManager:SetParticleControlEnt( nFXIndex, 10, enemy, PATTACH_ABSORIGIN_FOLLOW, nil, enemy:GetOrigin(), true )
                    ParticleManager:ReleaseParticleIndex( nFXIndex )
                    enemy:EmitSound("Dungeon.BloodSplatterImpact")
                else
                    enemy:AddNewModifier( self:GetCaster(), self, "modifier_stunned", { duration = self:GetSpecialValueFor("stun_duration") * (1-enemy:GetStatusResistance()) } )
                end
            end
        end
    end
end

modifier_tiny_boss_stone_throw_buff = class({})

function modifier_tiny_boss_stone_throw_buff:IsHidden()
    return true
end

function modifier_tiny_boss_stone_throw_buff:IsPurgable()
    return false
end

function modifier_tiny_boss_stone_throw_buff:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
    }
    return funcs
end

function modifier_tiny_boss_stone_throw_buff:GetActivityTranslationModifiers( params )
    return "tree"
end

modifier_tiny_boss_stone_throw_debuff = class({})

function modifier_tiny_boss_stone_throw_debuff:GetAttributes()
    return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_tiny_boss_stone_throw_debuff:IsPurgable()
    return false
end

function modifier_tiny_boss_stone_throw_debuff:OnCreated( kv )
    if not IsServer() then return end
    if self:ApplyHorizontalMotionController() == false or self:ApplyVerticalMotionController() == false then 
        if not self:IsNull() then
            self:Destroy()
        end
        return
    end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
    self.nProjHandle = -1
    self.flTime = 0.0
    self.flHeight = 0.0
    self:StartIntervalThink(0)
end

function modifier_tiny_boss_stone_throw_debuff:OnIntervalThink()
	if not IsServer() then return end
	if self.nProjHandle == -1 then
		local attach = self:GetCaster():ScriptLookupAttachment( "attach_attack2" )
        local vLocation = self:GetCaster():GetAttachmentOrigin( attach )
        self:GetParent():SetOrigin( vLocation )
	end
end

function modifier_tiny_boss_stone_throw_debuff:OnDestroy()
    if not IsServer() then return end
    self:GetParent():RemoveHorizontalMotionController( self )
    self:GetParent():RemoveVerticalMotionController( self )
    self:GetAbility():UseResources(false, false, false, true)
end

function modifier_tiny_boss_stone_throw_debuff:UpdateHorizontalMotion( me, dt )
    if not IsServer() then return end
    local vLocation = nil
    if self.nProjHandle == -1 then
        local attach = self:GetCaster():ScriptLookupAttachment( "attach_attack2" )
        vLocation = self:GetCaster():GetAttachmentOrigin( attach )
    else
        vLocation = ProjectileManager:GetLinearProjectileLocation( self.nProjHandle )
    end
    vLocation.z = 0.0
    me:SetOrigin( vLocation )
end

function modifier_tiny_boss_stone_throw_debuff:UpdateVerticalMotion( me, dt )
    if not IsServer() then return end
    local vMyPos = me:GetOrigin()
    if self.nProjHandle == -1 then
        local attach = self:GetCaster():ScriptLookupAttachment( "attach_attack2" )
        local vLocation = self:GetCaster():GetAttachmentOrigin( attach )
        vMyPos.z = vLocation.z
    else
        local flGroundHeight = GetGroundHeight( vMyPos, me )
        local flHeightChange = dt * self.flTime * self.flHeight * 1.3
        vMyPos.z = math.max( vMyPos.z - flHeightChange, flGroundHeight )
    end
    me:SetOrigin( vMyPos )
end

modifier_tiny_boss_stone_throw_stone = class({})
function modifier_tiny_boss_stone_throw_stone:IsHidden() return true end
function modifier_tiny_boss_stone_throw_stone:IsPurgeException() return false end
function modifier_tiny_boss_stone_throw_stone:IsPurgable() return false end
function modifier_tiny_boss_stone_throw_stone:CheckState()
	return 
	{
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end