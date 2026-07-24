--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_slark_pounce_custom", "heroes/npc_dota_hero_slark_custom/slark_pounce_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slark_pounce_custom_debuff", "heroes/npc_dota_hero_slark_custom/slark_pounce_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slark_pounce_arc", "heroes/npc_dota_hero_slark_custom/slark_pounce_custom", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_slark_pounce_leashed", "heroes/npc_dota_hero_slark_custom/slark_pounce_custom", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_slark_pounce_custom_thinker", "heroes/npc_dota_hero_slark_custom/slark_pounce_custom", LUA_MODIFIER_MOTION_NONE )

slark_pounce_custom = class({})

function slark_pounce_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_slark/slark_pounce_trail.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_slark/slark_pounce_start.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_slark/slark_pounce_ground.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_slark/slark_pounce_leash.vpcf", context )
end

slark_pounce_custom.modifier_slark_8 = 50
slark_pounce_custom.modifier_slark_8_pct = {70,140}
slark_pounce_custom.modifier_slark_9 = {2,4}
slark_pounce_custom.modifier_slark_10 = {100,200,300}
slark_pounce_custom.modifier_slark_13 = {0.2,0.4}
slark_pounce_custom.modifier_slark_16 = 100
slark_pounce_custom.modifier_slark_16_pct = {100,200}
slark_pounce_custom.modifier_slark_10_stacks = {1,2,3}

function slark_pounce_custom:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster().targets_attack = {}
	local distance = self:GetSpecialValueFor("pounce_distance")
	if self:GetCaster():HasModifier("modifier_slark_10") then
		distance = distance + self.modifier_slark_10[self:GetCaster():GetTalentLevel("modifier_slark_10")]
	end
    local speed = self:GetSpecialValueFor("pounce_speed")
    local end_point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * distance

    if self:GetCaster():HasModifier("modifier_slark_16") then
    	local unit = CreateUnitByName("npc_dota_slark_visual", self:GetCaster():GetAbsOrigin(), false, nil, nil, self:GetCaster():GetTeamNumber())
    	if unit then
    		unit:AddNewModifier( self:GetCaster(), self, "modifier_slark_pounce_custom_thinker", {})
    		unit:SetAbsOrigin(self:GetCaster():GetAbsOrigin())
    		unit:SetForwardVector(self:GetCaster():GetForwardVector())
			unit:AddNewModifier( self:GetCaster(), self, "modifier_slark_pounce_custom", {})
			unit:EmitSound("Hero_Slark.Pounce.Cast")

			if self:GetCaster():HasModifier("modifier_slark_9") then
		    	self:StartShadowClones(end_point)
		    end
    		return
    	end
    end

	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_slark_pounce_custom", {})
	self:GetCaster():EmitSound("Hero_Slark.Pounce.Cast")

	if self:GetCaster():HasModifier("modifier_slark_9") then
    	self:StartShadowClones(end_point)
    end
end

function slark_pounce_custom:StartShadowClones(point)
	if self:GetCaster():GetTalentLevel("modifier_slark_9") > 0 then
		local unit = CreateUnitByName("npc_dota_slark_visual", self:GetCaster():GetAbsOrigin(), false, nil, nil, self:GetCaster():GetTeamNumber())
    	if unit then
    		unit:AddNewModifier( self:GetCaster(), self, "modifier_slark_pounce_custom_thinker", {})
    		unit:SetAbsOrigin(self:GetCaster():GetAbsOrigin())
    		local end_point = point + self:GetCaster():GetLeftVector() * 200
    		local direction = (end_point - unit:GetAbsOrigin())
    		direction.z = 0
    		direction = direction:Normalized()
    		unit:SetForwardVector(direction)
    		unit:EmitSound("Hero_Slark.Pounce.Cast")
			unit:AddNewModifier( self:GetCaster(), self, "modifier_slark_pounce_custom", {})
    	end
    	local unit_bonus = CreateUnitByName("npc_dota_slark_visual", self:GetCaster():GetAbsOrigin(), false, nil, nil, self:GetCaster():GetTeamNumber())
    	if unit_bonus then
    		unit_bonus:AddNewModifier( self:GetCaster(), self, "modifier_slark_pounce_custom_thinker", {})
    		unit_bonus:SetAbsOrigin(self:GetCaster():GetAbsOrigin())
    		local end_point = point + self:GetCaster():GetRightVector() * 200
    		local direction = (end_point - unit_bonus:GetAbsOrigin())
    		direction.z = 0
    		direction = direction:Normalized()
    		unit_bonus:SetForwardVector(direction)
    		unit:EmitSound("Hero_Slark.Pounce.Cast")
			unit_bonus:AddNewModifier( self:GetCaster(), self, "modifier_slark_pounce_custom", {})
    	end
    end
	if self:GetCaster():GetTalentLevel("modifier_slark_9") > 1 then
		local unit = CreateUnitByName("npc_dota_slark_visual", self:GetCaster():GetAbsOrigin(), false, nil, nil, self:GetCaster():GetTeamNumber())
    	if unit then
    		unit:AddNewModifier( self:GetCaster(), self, "modifier_slark_pounce_custom_thinker", {})
    		unit:SetAbsOrigin(self:GetCaster():GetAbsOrigin())
    		local end_point = point + self:GetCaster():GetLeftVector() * 400
    		local direction = (end_point - unit:GetAbsOrigin())
    		direction.z = 0
    		direction = direction:Normalized()
    		unit:SetForwardVector(direction)
    		unit:EmitSound("Hero_Slark.Pounce.Cast")
			unit:AddNewModifier( self:GetCaster(), self, "modifier_slark_pounce_custom", {})
    	end
    	local unit_bonus = CreateUnitByName("npc_dota_slark_visual", self:GetCaster():GetAbsOrigin(), false, nil, nil, self:GetCaster():GetTeamNumber())
    	if unit_bonus then
    		unit_bonus:AddNewModifier( self:GetCaster(), self, "modifier_slark_pounce_custom_thinker", {})
    		unit_bonus:SetAbsOrigin(self:GetCaster():GetAbsOrigin())
    		local end_point = point + self:GetCaster():GetRightVector() * 400
    		local direction = (end_point - unit_bonus:GetAbsOrigin())
    		direction.z = 0
    		direction = direction:Normalized()
    		unit_bonus:SetForwardVector(direction)
    		unit:EmitSound("Hero_Slark.Pounce.Cast")
			unit_bonus:AddNewModifier( self:GetCaster(), self, "modifier_slark_pounce_custom", {})
    	end
	end
end

modifier_slark_pounce_custom_thinker = class({})
function modifier_slark_pounce_custom_thinker:IsHidden() return true end
function modifier_slark_pounce_custom_thinker:IsPurgable() return false end
function modifier_slark_pounce_custom_thinker:RemoveOnDeath() return false end
function modifier_slark_pounce_custom_thinker:IsPurgeException() return false end
function modifier_slark_pounce_custom_thinker:CheckState()
    return 
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
    }
end

modifier_slark_pounce_custom = class({})

function modifier_slark_pounce_custom:IsHidden()
	return true
end

function modifier_slark_pounce_custom:IsPurgable()
	return false
end

function modifier_slark_pounce_custom:IsPurgeException() return false end

function modifier_slark_pounce_custom:OnCreated( kv )
	if not IsServer() then return end

	local speed = self:GetAbility():GetSpecialValueFor( "pounce_speed" )
	local distance = self:GetAbility():GetSpecialValueFor( "pounce_distance" )
	self.radius = self:GetAbility():GetSpecialValueFor( "pounce_radius" )
	self.leash_radius = self:GetAbility():GetSpecialValueFor( "leash_radius" )
	self.leash_duration = self:GetAbility():GetSpecialValueFor( "leash_duration" )

	if self:GetCaster():HasModifier("modifier_slark_10") then
		distance = distance + self:GetAbility().modifier_slark_10[self:GetCaster():GetTalentLevel("modifier_slark_10")]
		speed = 933 + 177 * self:GetCaster():GetTalentLevel("modifier_slark_10")
	end
	if self:GetCaster():HasModifier("modifier_slark_13") then
		self.leash_duration = self.leash_duration + self:GetAbility().modifier_slark_13[self:GetCaster():GetTalentLevel("modifier_slark_13")]
	end

	local duration = distance / speed

	local height = 160

	self:GetCaster():StartGesture(ACT_DOTA_SLARK_POUNCE)

	self.arc = self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_slark_pounce_arc", { speed = speed, duration = duration, distance = distance, height = height })

	self.arc:SetEndCallback(function( interrupted )
		if self:IsNull() then return end
		self.arc = nil
		self:Destroy()
	end)

	self:SetDuration( duration, true )
	self:GetAbility():SetActivated( false )
	self:StartIntervalThink( 0.1 )
	self:OnIntervalThink()
	self:PlayEffects()
end

function modifier_slark_pounce_custom:OnDestroy()
	if not IsServer() then return end
	self:GetAbility():SetActivated( true )
	GridNav:DestroyTreesAroundPoint( self:GetParent():GetOrigin(), 100, false )
	if self.arc and not self.arc:IsNull() then
		self.arc:Destroy()
	end
	self:GetCaster():FadeGesture(ACT_DOTA_SLARK_POUNCE)
	if self:GetParent() ~= self:GetCaster() then
		UTIL_Remove(self:GetParent())
	end
end

function modifier_slark_pounce_custom:CheckState()
	local state = 
	{
		[MODIFIER_STATE_DISARMED] = true,
	}
	return state
end

function modifier_slark_pounce_custom:OnIntervalThink()
	if not IsServer() then return end

	local enemies_damage = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false )
	for _, enemy_dmg in pairs(enemies_damage) do
		if self:GetCaster():HasModifier("modifier_slark_8") or self:GetCaster():HasModifier("modifier_slark_16") then
			if self:GetCaster().targets_attack[enemy_dmg:entindex()] == nil then
				self:GetCaster().targets_attack[enemy_dmg:entindex()] = true
				if self:GetCaster():HasModifier("modifier_slark_8") then
					local damage = self:GetAbility().modifier_slark_8 + (self:GetCaster():GetAgility() / 100 * self:GetAbility().modifier_slark_8_pct[self:GetCaster():GetTalentLevel("modifier_slark_8")])
					ApplyDamage({attacker = self:GetCaster(), victim = enemy_dmg, ability = self:GetAbility(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
				end
				if self:GetCaster():HasModifier("modifier_slark_16") then
					local damage = self:GetAbility().modifier_slark_16 + (self:GetCaster():GetIntellect(false) / 100 * self:GetAbility().modifier_slark_16_pct[self:GetCaster():GetTalentLevel("modifier_slark_16")])
					ApplyDamage({attacker = self:GetCaster(), victim = enemy_dmg, ability = self:GetAbility(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
				end
			end
		end
	end

	local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, FIND_CLOSEST, false )
	local target
	for _,enemy in pairs(enemies) do
		if not enemy:IsIllusion() then
			local nexts = true
			if self:GetCaster() ~= self:GetParent() and (enemy:HasModifier("modifier_slark_pounce_custom_debuff") ) then
				print("lallalalalala")
				nexts = false
			end
			if nexts then
				target = enemy
				break
			end
		end
	end

	if not target then return end
	self:GetParent():MoveToTargetToAttack(target)
	target:AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_slark_pounce_custom_debuff", { duration = self.leash_duration, radius = self.leash_radius, purgable = false })
	target:EmitSound("Hero_Slark.Pounce.Impact")

    
    local essence_stacks = self:GetAbility():GetSpecialValueFor("essence_stacks")
    if self:GetCaster():HasModifier("modifier_slark_10") then
        essence_stacks = essence_stacks + self:GetAbility().modifier_slark_10_stacks[self:GetCaster():GetTalentLevel("modifier_slark_10")]
    end
    local modifier_slark_essence_shift_custom = self:GetCaster():FindModifierByName("modifier_slark_essence_shift_custom")
    if modifier_slark_essence_shift_custom and self:GetAbility():GetLevel() > 1 then
        for i=1, essence_stacks do
            modifier_slark_essence_shift_custom:AttackTarget(target, true)
        end
    end
	if self.arc and not self.arc:IsNull() then
		self.arc:Destroy()
	end
	self:SetDuration(FrameTime(), false)
end

function modifier_slark_pounce_custom:GetEffectName()
	return "particles/units/heroes/hero_slark/slark_pounce_trail.vpcf"
end

function modifier_slark_pounce_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_slark_pounce_custom:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_slark/slark_pounce_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

modifier_slark_pounce_custom_debuff = class({})

function modifier_slark_pounce_custom_debuff:IsPurgable()
	return false
end

function modifier_slark_pounce_custom_debuff:OnCreated( kv )
	if not IsServer() then return end
	self.radius = kv.radius

	self.leash = self:GetParent():AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_slark_pounce_leashed", kv )

	self.leash:SetEndCallback(function()
		if self:IsNull() then return end
		self.leash = nil
		self:Destroy()
	end)

	self:PlayEffects1()
	self:PlayEffects2()
end

function modifier_slark_pounce_custom_debuff:OnRefresh(kv)
	if not IsServer() then return end
	self.radius = kv.radius
	self.leash = self:GetParent():AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_slark_pounce_leashed", kv )
	self.leash:SetEndCallback(function()
		if self:IsNull() then return end
		self.leash = nil
		self:Destroy()
	end)
end

function modifier_slark_pounce_custom_debuff:OnDestroy()
	if not IsServer() then return end
	if self.leash and not self.leash:IsNull() then
		self.leash:Destroy()
	end
	local sound_cast = "Hero_Slark.Pounce.Leash"
	local sound_end = "Hero_Slark.Pounce.End"
	self:GetParent():StopSound("Hero_Slark.Pounce.Leash")
	self:GetParent():EmitSound("Hero_Slark.Pounce.End")
end

function modifier_slark_pounce_custom_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost.vpcf"
end

function modifier_slark_pounce_custom_debuff:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

function modifier_slark_pounce_custom_debuff:PlayEffects1()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_slark/slark_pounce_ground.vpcf", PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetCaster(), PATTACH_WORLDORIGIN, "attach_hitloc", Vector(0,0,0), true)
	ParticleManager:SetParticleControl( effect_cast, 3, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 4, Vector( self.radius, 0, 0 ) )
	self:AddParticle( effect_cast, false, false, -1, false, false  )
	self:GetParent():EmitSound("Hero_Slark.Pounce.Leash")
end

function modifier_slark_pounce_custom_debuff:PlayEffects2()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_slark/slark_pounce_leash.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( effect_cast, 3, self:GetParent():GetOrigin() )
	self:AddParticle( effect_cast, false, false, -1, false, false)
end

modifier_slark_pounce_arc = class({})

function modifier_slark_pounce_arc:IsHidden()
	return true
end

function modifier_slark_pounce_arc:IsDebuff()
	return false
end

function modifier_slark_pounce_arc:IsStunDebuff()
	return false
end

function modifier_slark_pounce_arc:IsPurgable()
	return false
end

function modifier_slark_pounce_arc:IsPurgeException() return false end

function modifier_slark_pounce_arc:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_slark_pounce_arc:OnCreated( kv )
	if not IsServer() then return end
	self.interrupted = false
	self:SetJumpParameters( kv )
	self:Jump()
end

function modifier_slark_pounce_arc:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_slark_pounce_arc:OnDestroy()
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

function modifier_slark_pounce_arc:GetModifierDisableTurning()
	if not self.isForward then return end
	return 1
end

function modifier_slark_pounce_arc:GetOverrideAnimation()
	return self:GetStackCount()
end

function modifier_slark_pounce_arc:CheckState()
    return {[MODIFIER_STATE_DISARMED] = true,[MODIFIER_STATE_NO_UNIT_COLLISION] = true,}
end

function modifier_slark_pounce_arc:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_EVENT_ON_ORDER
    }
end

function modifier_slark_pounce_arc:GetActivityTranslationModifiers()
    return "leash"
end

function modifier_slark_pounce_arc:GetOverrideAnimation()
    return ACT_DOTA_SLARK_POUNCE
end

function modifier_slark_pounce_arc:UpdateHorizontalMotion( me, dt )
	if self.fix_duration and self:GetElapsedTime()>=self.duration then return end
	local pos = me:GetOrigin() + self.direction * self.speed * dt
    if me:GetIdealSpeed() < 100 then return end
	me:SetOrigin( pos )
end

function modifier_slark_pounce_arc:UpdateVerticalMotion( me, dt )
	if self.fix_duration and self:GetElapsedTime()>=self.duration then return end
	local pos = me:GetOrigin()
	local time = self:GetElapsedTime()
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

function modifier_slark_pounce_arc:OnHorizontalMotionInterrupted()
	self.interrupted = true
	self:Destroy()
end

function modifier_slark_pounce_arc:OnVerticalMotionInterrupted()
	self.interrupted = true
	self:Destroy()
end

function modifier_slark_pounce_arc:SetJumpParameters( kv )
	self.parent = self:GetParent()

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

function modifier_slark_pounce_arc:Jump()
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

function modifier_slark_pounce_arc:InitVerticalArc( height_start, height_max, height_end, duration )
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

function modifier_slark_pounce_arc:GetVerticalPos( time )
	return self.const1*time - self.const2*time*time
end

function modifier_slark_pounce_arc:GetVerticalSpeed( time )
	return self.const1 - 2*self.const2*time
end

function modifier_slark_pounce_arc:SetEndCallback( func )
	self.endCallback = func
end

modifier_slark_pounce_leashed = class({})

function modifier_slark_pounce_leashed:IsHidden()
	return true
end

function modifier_slark_pounce_leashed:IsDebuff()
	return true
end

function modifier_slark_pounce_leashed:IsStunDebuff()
	return false
end

function modifier_slark_pounce_leashed:IsPurgable()
	if not IsServer() then return end
	return self.purgable
end

function modifier_slark_pounce_leashed:OnCreated( kv )
	if not IsServer() then return end
	self.parent = self:GetParent()
	self.rooted = true
	self.purgable = true
	if kv.rooted then self.rooted = kv.rooted==1 end
	if kv.purgable then self.purgable = kv.purgable==1 end
	if self.rooted then self:SetStackCount(1) end
	self.radius = kv.radius or 300
	if kv.center_x and kv.center_y then
		self.center = Vector( kv.center_x, kv.center_y, 0 )
	else
		self.center = self:GetParent():GetOrigin()
	end
	self.max_speed = 550
	self.min_speed = 0.1
	self.max_min = self.max_speed-self.min_speed
	self.half_width = 50
end

function modifier_slark_pounce_leashed:OnDestroy()
	if not IsServer() then return end
	if self.endCallback then
		self.endCallback()
	end
end

function modifier_slark_pounce_leashed:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
	}
	return funcs
end

function modifier_slark_pounce_leashed:GetModifierMoveSpeed_Limit( params )
	if not IsServer() then return end
	local parent_vector = self.parent:GetOrigin()-self.center
	local parent_direction = parent_vector:Normalized()
	local actual_distance = parent_vector:Length2D()
	local wall_distance = self.radius-actual_distance
	if wall_distance<(-self.half_width) then
		self:Destroy()
		return 0
	end
	local parent_angle = VectorToAngles(parent_direction).y
	local unit_angle = self:GetParent():GetAnglesAsVector().y
	local wall_angle = math.abs( AngleDiff( parent_angle, unit_angle ) )
	local limit = 0
	if wall_angle<=90 then
		if wall_distance<0 then
			limit = self.min_speed
		else
			limit = (wall_distance/self.half_width)*self.max_min + self.min_speed
		end
	end

	return limit
end

function modifier_slark_pounce_leashed:CheckState()
	local state = 
	{
		[MODIFIER_STATE_TETHERED] = self:GetStackCount() == 1,
	}
	return state
end

function modifier_slark_pounce_leashed:SetEndCallback( func )
	self.endCallback = func
end