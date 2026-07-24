--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


tidehunter_ravage_custom = class({})

LinkLuaModifier( "modifier_generic_arc_lua_tidehunter", "heroes/npc_dota_hero_tidehunter_custom/tidehunter_ravage_custom", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_generic_ring_lua", "heroes/npc_dota_hero_tidehunter_custom/tidehunter_ravage_custom", LUA_MODIFIER_MOTION_NONE )

tidehunter_ravage_custom.modifier_tidehunter_6 = {150,250}
tidehunter_ravage_custom.modifier_tidehunter_7_cooldown = -50
tidehunter_ravage_custom.modifier_tidehunter_7_stun = 1

function tidehunter_ravage_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_spell_ravage.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_spell_ravage_hit.vpcf", context )
end

function tidehunter_ravage_custom:GetCooldown(iLevel)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_tidehunter_7") then
		bonus = self.modifier_tidehunter_7_cooldown
	end
	return self.BaseClass.GetCooldown( self, iLevel ) + bonus
end

function tidehunter_ravage_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local damage = self:GetAbilityDamage()
	local damage_type = self:GetAbilityDamageType()
	local radius = self:GetSpecialValueFor( "radius" )
	local speed = self:GetSpecialValueFor( "speed" )
	local duration = self:GetSpecialValueFor( "duration" )
	local width = 250
	local height = 350
	local knock_duration = 0.5

	if self:GetCaster():HasModifier("modifier_tidehunter_7") then
		duration = duration + self.modifier_tidehunter_7_stun
	end

	if self:GetCaster():HasModifier("modifier_tidehunter_6") then
		damage = damage + ( self:GetCaster():GetStrength() / 100 * self.modifier_tidehunter_6[self:GetCaster():GetTalentLevel("modifier_tidehunter_6")])
	end

	local damageTable = {
		attacker = caster,
		damage = damage,
		damage_type = damage_type,
		ability = self,
	}

	local thinker = CreateModifierThinker(
		caster,
		self,
		"modifier_generic_ring_lua",
		{
			start_radius = width,
			end_radius = radius,
			speed = speed,
			width = width,
			target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
			target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		},
		caster:GetOrigin(),
		caster:GetTeamNumber(),
		false
	)

	ring = thinker:FindModifierByName( "modifier_generic_ring_lua" )

	ring:SetCallback( function( enemy )
		local knockback = enemy:AddNewModifier( caster, self, "modifier_generic_arc_lua_tidehunter", { duration = knock_duration * (1-enemy:GetStatusResistance()), height = height, isStun = true } )
        enemy:AddNewModifier( caster, self, "modifier_stunned", { duration = (duration+knock_duration) * (1-enemy:GetStatusResistance()) } )
		knockback:SetEndCallback( function()
			damageTable.victim = enemy
			ApplyDamage( damageTable )
			enemy:EmitSound("Hero_Tidehunter.RavageDamage")
		end)

		self:PlayEffects2( enemy )
	end)

	self:PlayEffects1( caster:GetOrigin(), radius, speed )
end

function tidehunter_ravage_custom:CreateOneRavageAttack(target)
	local damage = 75
	local duration = 1

	if self:GetLevel() > 0 then
		damage = self:GetAbilityDamage() * 0.5
		duration = self:GetSpecialValueFor( "duration" ) * 0.5
	end

	local knockback = target:AddNewModifier( self:GetCaster(), self, "modifier_generic_arc_lua_tidehunter", { duration = 0.5 * (1-target:GetStatusResistance()), height = 350, isStun = true } )
	target:AddNewModifier( self:GetCaster(), self, "modifier_stunned", { duration = (duration+0.5) * (1-target:GetStatusResistance()) } )
	if self:GetCaster():HasModifier("modifier_tidehunter_7") then
		duration = duration + self.modifier_tidehunter_7_stun
	end

	if self:GetCaster():HasModifier("modifier_tidehunter_6") then
		damage = damage + ( self:GetCaster():GetStrength() / 100 * self.modifier_tidehunter_6[self:GetCaster():GetTalentLevel("modifier_tidehunter_6")])
	end

	ApplyDamage({victim = target, attacker = self:GetCaster(), damage = damage, ability = self, damage_type = DAMAGE_TYPE_MAGICAL})

	self:PlayEffects2( target )
end

function tidehunter_ravage_custom:PlayEffects1( center, radius, speed )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_tidehunter/tidehunter_spell_ravage.vpcf", PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, center )

	for i=1,5 do
		local pos = radius/5*i
		ParticleManager:SetParticleControl( effect_cast, i, Vector( pos, 1, 1 ) )
	end

	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOnLocationWithCaster( center, "Ability.Ravage", self:GetCaster() )
end

function tidehunter_ravage_custom:PlayEffects2( enemy )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_tidehunter/tidehunter_spell_ravage_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end




















------------------

-- Created by Elfansoer
--[[
	Generic Jump Arc
	kv data (default):
	-- direction, provide just one (or none for default):
		dir_x/y (forward), for direction
		target_x/y (forward), for target point
	-- horizontal motion, provide 2 of 3, duration-only (for vertical arc), or all 3
		speed (0)
		duration (0)
		distance (0): zero means no horizontal motion
	-- vertical motion.
		height (0): max height. zero means no vertical motion
		start_offset (0), height offset from ground at start of jump
		end_offset (0), height offset from ground at end of jump
	-- arc types
		fix_end (true): if true, landing z-pos is the same as jumping z-pos, not respecting on landing terrain height (Pounce)
		fix_duration (true): if false, arc ends when unit touches ground, not respecting duration (Shield Crash)
		fix_height (true): if false, arc max height depends on jump distance, height provided is max-height (Tree Dance)
	-- other
		isStun (false), parent is stunned
		isRestricted (false), parent is command restricted
		isForward (false), lock parent forward facing
		activity (none), activity when leaping
]] 
--------------------------------------------------------------------------------
modifier_generic_arc_lua_tidehunter = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_arc_lua_tidehunter:IsHidden()
	return true
end

function modifier_generic_arc_lua_tidehunter:IsDebuff()
	return false
end

function modifier_generic_arc_lua_tidehunter:IsStunDebuff()
	return false
end

function modifier_generic_arc_lua_tidehunter:IsPurgable()
	return true
end

function modifier_generic_arc_lua_tidehunter:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_arc_lua_tidehunter:OnCreated( kv )
	if not IsServer() then return end
	self.interrupted = false
	self:SetJumpParameters( kv )
	self:Jump()
end

function modifier_generic_arc_lua_tidehunter:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_generic_arc_lua_tidehunter:OnRemoved()
end

function modifier_generic_arc_lua_tidehunter:OnDestroy()
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
function modifier_generic_arc_lua_tidehunter:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DISABLE_TURNING,
	}
	if self:GetStackCount()>0 then
		table.insert( funcs, MODIFIER_PROPERTY_OVERRIDE_ANIMATION )
	end

	return funcs
end

function modifier_generic_arc_lua_tidehunter:GetModifierDisableTurning()
	if not self.isForward then return end
	return 1
end
function modifier_generic_arc_lua_tidehunter:GetOverrideAnimation()
	return self:GetStackCount()
end
--------------------------------------------------------------------------------
-- Status Effects
function modifier_generic_arc_lua_tidehunter:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = self.isRestricted or false,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_generic_arc_lua_tidehunter:UpdateHorizontalMotion( me, dt )
	if self.fix_duration and self:GetElapsedTime()>=self.duration then return end

	-- set relative position
	local pos = me:GetOrigin() + self.direction * self.speed * dt
	me:SetOrigin( pos )
end

function modifier_generic_arc_lua_tidehunter:UpdateVerticalMotion( me, dt )
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

function modifier_generic_arc_lua_tidehunter:OnHorizontalMotionInterrupted()
	self.interrupted = true
	self:Destroy()
end

function modifier_generic_arc_lua_tidehunter:OnVerticalMotionInterrupted()
	self.interrupted = true
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Motion Helper
function modifier_generic_arc_lua_tidehunter:SetJumpParameters( kv )
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

function modifier_generic_arc_lua_tidehunter:Jump()
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

function modifier_generic_arc_lua_tidehunter:InitVerticalArc( height_start, height_max, height_end, duration )
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

function modifier_generic_arc_lua_tidehunter:GetVerticalPos( time )
	return self.const1*time - self.const2*time*time
end

function modifier_generic_arc_lua_tidehunter:GetVerticalSpeed( time )
	return self.const1 - 2*self.const2*time
end

--------------------------------------------------------------------------------
-- Helper
function modifier_generic_arc_lua_tidehunter:SetEndCallback( func )
	self.endCallback = func
end

-- Created by Elfansoer
--[[
	Usage parameters
		kv.start_radius (0)
		kv.end_radius (0)
		kv.width (100)
		kv.speed (0)
		kv.target_team
		kv.target_type
		kv.target_flags
		kv.IsCircle (1) -- 0: expanding radius, 1: expanding donut with width (hollow inside)
	Callback set after creating modifier:
		modifier:SetCallback( function( unit ) ... end ) -- MANDATORY
		modifier:SetEndCallback( function() ... end )
]]
--------------------------------------------------------------------------------
modifier_generic_ring_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_ring_lua:IsHidden()
	return true
end

function modifier_generic_ring_lua:IsDebuff()
	return false
end

function modifier_generic_ring_lua:IsStunDebuff()
	return false
end

function modifier_generic_ring_lua:IsPurgable()
	return false
end

function modifier_generic_ring_lua:RemoveOnDeath()
	return false
end

function modifier_generic_ring_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_ring_lua:OnCreated( kv )

	if not IsServer() then return end

	-- references
	self.start_radius = kv.start_radius or 0
	self.end_radius = kv.end_radius or 0
	self.width = kv.width or 100
	self.speed = kv.speed or 0
	self.outward = self.end_radius>=self.start_radius
	if not self.outward then
		self.speed = -self.speed
	end

	self.target_team = kv.target_team or 0
	self.target_type = kv.target_type or 0
	self.target_flags = kv.target_flags or 0

	self.IsCircle = kv.IsCircle or 1

	self.targets = {}
end

function modifier_generic_ring_lua:OnRemoved()
end

function modifier_generic_ring_lua:OnDestroy()
	if self.EndCallback then
		self.EndCallback()
	end
	if not IsServer() then return end

	-- kill if thinker
	if self:GetParent():GetClassname()=="npc_dota_thinker" then
		UTIL_Remove( self:GetParent() )
	end
end

function modifier_generic_ring_lua:SetCallback( callback )
	self.Callback = callback

	-- Start interval
	self:StartIntervalThink( 0.03 )
	self:OnIntervalThink()
end

function modifier_generic_ring_lua:SetEndCallback( callback )
	self.EndCallback = callback
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_generic_ring_lua:OnIntervalThink()
	local radius = self.start_radius + self.speed * self:GetElapsedTime()
	if not self.outward and radius<self.end_radius then
		self:Destroy()
		return
	elseif self.outward and radius>self.end_radius then
		self:Destroy()
		return
	end

	-- Find targets in ring
	local targets = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		self.target_team,	-- int, team filter
		self.target_type,	-- int, type filter
		self.target_flags,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,target in pairs(targets) do

		-- only unaffected unit
		if not self.targets[target] then

			-- check if it is within circle/chakram
			if (not self.IsCircle) or (target:GetOrigin()-self:GetParent():GetOrigin()):Length2D()>(radius-self.width) then

				self.targets[target] = true

				-- do something
				self.Callback( target )
			end
		end

	end
end