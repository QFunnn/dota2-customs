--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_ursa_enrage", "neutrals/boss_ursa", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_ursa_enrage_active", "neutrals/boss_ursa", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

boss_ursa_enrage = class({})

function boss_ursa_enrage:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_ursa/ursa_enrage_hero_effect.vpcf", context )
    PrecacheResource( "particle", "particles/ursa_boss_effect.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_ursa/ursa_enrage_buff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_ursa/ursa_fury_swipes_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/abilities_ranger_finder_check_ultimate_calldown.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_ursa/ursa_earthshock.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_ursa/ursa_earthshock.vpcf", context )
end

function boss_ursa_enrage:GetIntrinsicModifierName()
	return "modifier_boss_ursa_enrage"
end

modifier_boss_ursa_enrage = class({})

function modifier_boss_ursa_enrage:IsHidden() return true end
function modifier_boss_ursa_enrage:IsPurgable() return false end
function modifier_boss_ursa_enrage:IsPurgeException() return false end

function modifier_boss_ursa_enrage:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(1)
end

function modifier_boss_ursa_enrage:OnIntervalThink()
	if not IsServer() then return end
	if self:GetAbility():IsFullyCastable() and (self:GetParent():GetAggroTarget() ~= nil or self:GetParent().hTarget ~= nil) then
		if not self:GetParent():IsAlive() then return end
		self:StartEnrage()
		self:GetAbility():StartCooldown(6)
	end
end

function modifier_boss_ursa_enrage:StartEnrage()
	if not IsServer() then return end
	self:GetCaster():Purge(false, true, false, true, false)
	self:GetCaster():AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_boss_ursa_enrage_active", { duration = self:GetAbility():GetSpecialValueFor("duration") })
	self:GetCaster():EmitSound("Hero_Ursa.Enrage")
end

modifier_boss_ursa_enrage_active = class({})

function modifier_boss_ursa_enrage_active:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING 
	}
	return funcs
end

function modifier_boss_ursa_enrage_active:GetHeroEffectName()
	return "particles/units/heroes/hero_ursa/ursa_enrage_hero_effect.vpcf"
end

function modifier_boss_ursa_enrage_active:GetStatusEffectName()
	return "particles/ursa_boss_effect.vpcf"
end

function modifier_boss_ursa_enrage_active:StatusEffectPriority()
	return 20
end

function modifier_boss_ursa_enrage_active:GetModifierIncomingDamage_Percentage( params )
	return self:GetAbility():GetSpecialValueFor("damage_reduction")
end

function modifier_boss_ursa_enrage_active:GetModifierModelScale( params )
	return 30
end

function modifier_boss_ursa_enrage_active:GetModifierStatusResistanceStacking( params )
	return self:GetAbility():GetSpecialValueFor("status_resistance")
end

function modifier_boss_ursa_enrage_active:GetEffectName()
	return "particles/units/heroes/hero_ursa/ursa_enrage_buff.vpcf"
end

function modifier_boss_ursa_enrage_active:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

LinkLuaModifier("modifier_boss_ursa_fury_swipes", "neutrals/boss_ursa", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_ursa_fury_swipes_debuff", "neutrals/boss_ursa", LUA_MODIFIER_MOTION_NONE)

boss_ursa_fury_swipes = class({})

function boss_ursa_fury_swipes:GetIntrinsicModifierName()
	return "modifier_boss_ursa_fury_swipes"
end

modifier_boss_ursa_fury_swipes = class({})

function modifier_boss_ursa_fury_swipes:IsHidden()
	return true
end

function modifier_boss_ursa_fury_swipes:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PURE
	}

	return funcs
end

function modifier_boss_ursa_fury_swipes:GetModifierProcAttack_BonusDamage_Pure(params)
	if not IsServer() then return end
	local stack = 0
	local modifier = params.target:FindModifierByNameAndCaster("modifier_boss_ursa_fury_swipes_debuff", self:GetCaster())
	local duration = self:GetAbility():GetSpecialValueFor("stack_duration")
	
	if modifier == nil then
		params.target:AddNewModifier( self:GetAbility():GetCaster(), self:GetAbility(), "modifier_boss_ursa_fury_swipes_debuff", { duration = duration * (1-params.target:GetStatusResistance()) })
		stack = 1
	else
		if modifier:GetStackCount() <= self:GetAbility():GetSpecialValueFor("max_stacks") then
			modifier:IncrementStackCount()
		end
		modifier:ForceRefresh()
		stack = modifier:GetStackCount()
	end

	return params.target:GetMaxHealth() / 100 * (stack * self:GetAbility():GetSpecialValueFor("bonus_damage_pure"))
end

modifier_boss_ursa_fury_swipes_debuff = class({})

function modifier_boss_ursa_fury_swipes_debuff:IsPurgable()
	return false
end

function modifier_boss_ursa_fury_swipes_debuff:OnCreated()
	self:SetStackCount(1)
end

function modifier_boss_ursa_fury_swipes_debuff:GetEffectName()
	return "particles/units/heroes/hero_ursa/ursa_fury_swipes_debuff.vpcf"
end

function modifier_boss_ursa_fury_swipes_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

LinkLuaModifier("modifier_boss_ursa_jump", "neutrals/boss_ursa", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_ursa_jump_active", "neutrals/boss_ursa", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_boss_ursa_jump_debuff", "neutrals/boss_ursa", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

boss_ursa_jump = class({})

function boss_ursa_jump:GetIntrinsicModifierName()
	return "modifier_boss_ursa_jump"
end

modifier_boss_ursa_jump = class({})

function modifier_boss_ursa_jump:IsHidden() return true end
function modifier_boss_ursa_jump:IsPurgable() return false end
function modifier_boss_ursa_jump:IsPurgeException() return false end
function modifier_boss_ursa_jump:RemoveOnDeath() return false end

function modifier_boss_ursa_jump:OnCreated()
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self.delay = self:GetAbility():GetSpecialValueFor("delay")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.debuff_duration = self:GetAbility():GetSpecialValueFor("debuff_duration")
	self:StartIntervalThink(1)
end

function modifier_boss_ursa_jump:OnIntervalThink()
	if not IsServer() then return end
	if self:GetAbility():IsFullyCastable() and (self:GetParent():GetAggroTarget() ~= nil or self:GetParent().hTarget ~= nil) then
		if not self:GetParent():IsAlive() then return end
		self:StartJumpDelay()
		self:GetAbility():StartCooldown(9)
	end
end

function modifier_boss_ursa_jump:StartJumpDelay()
	if not IsServer() then return end

	local delay = self.delay

	local origin = self:GetParent():GetAbsOrigin() + self:GetParent():GetForwardVector() * 400
	local radius = self.radius
	
	local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_FARTHEST, false )
    for i = #enemies, 1, -1 do
        if enemies[i] and enemies[i]:GetUnitName() == "npc_woda_wisp_death" then
            table.remove(enemies, i)
        end
    end
	for count = #enemies, 1, -1 do
        if enemies[count] and not enemies[count]:IsAlive() and not enemies[count]:IsRealHero() then
            table.remove(units, count)
        end
    end
	if #enemies > 0 then
		origin = enemies[1]:GetAbsOrigin()
	end

	local particle = ParticleManager:CreateParticle("particles/abilities_ranger_finder_check_ultimate_calldown.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl( particle, 0, origin )
	ParticleManager:SetParticleControl( particle, 1, Vector( radius, 0, -300 ) )
	ParticleManager:SetParticleControl( particle, 2, Vector( delay, 0, 0 ) )

	local parent = self:GetParent()
	local ability = self:GetAbility()
	local damage_spec = self.damage
	local debuff_duration = self.debuff_duration

	Timers:CreateTimer(delay, function()
		if not parent:IsAlive() then
			if particle then
				ParticleManager:DestroyParticle(particle, true)
			end
			return 
		end
		local dir = origin - parent:GetAbsOrigin()
		dir.z = 0
		local distance = dir:Length2D()
		dir = dir:Normalized()
		parent:AddNewModifier(parent, ability, "modifier_neutral_cast", {})
		parent:SetForwardVector(Vector(dir.x,dir.y,parent:GetForwardVector().z))
		parent:FaceTowards(origin)
		parent:StartGesture(ACT_DOTA_CAST_ABILITY_1)
		local knockback = parent:AddNewModifier( parent, ability, "modifier_boss_ursa_jump_active", { distance = distance, height = 100, duration = 0.25, direction_x = dir.x, direction_y = dir.y, IsStun = true } )

		local callback = function()
			parent:RemoveModifierByName("modifier_neutral_cast")

			if particle then
				ParticleManager:DestroyParticle(particle, true)
			end

			if not parent:IsAlive() then
				return 
			end

			parent:StartGesture(ACT_DOTA_CAST1_STATUE)

			parent:EmitSound("Hero_Ursa.Earthshock")

			local effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_ursa/ursa_earthshock.vpcf", PATTACH_WORLDORIGIN, nil )
			ParticleManager:SetParticleControl( effect_cast, 0, parent:GetOrigin() )
			ParticleManager:SetParticleControl( effect_cast, 1, Vector(radius, radius, radius) )
			ParticleManager:ReleaseParticleIndex( effect_cast )

			local effect_cast_2 = ParticleManager:CreateParticle("particles/units/heroes/hero_ursa/ursa_earthshock.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent )
			ParticleManager:SetParticleControl( effect_cast_2, 0, parent:GetOrigin() )
			ParticleManager:SetParticleControl( effect_cast_2, 1, Vector(200, 200, 200) )
			ParticleManager:ReleaseParticleIndex( effect_cast_2 )

			local enemies_targets = FindUnitsInRadius( parent:GetTeamNumber(), parent:GetOrigin(), nil, 400, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false)
            for i = #enemies_targets, 1, -1 do
                if enemies_targets[i] and enemies_targets[i]:GetUnitName() == "npc_woda_wisp_death" then
                    table.remove(enemies_targets, i)
                end
            end
			for _,enemy in pairs(enemies_targets) do
				local damage = damage_spec / 100 * enemy:GetMaxHealth()
				
				local damageInfo = 
                {
                    victim = enemy,
                    attacker = parent,
                    damage = damage,
                    damage_type = DAMAGE_TYPE_PURE,
                    ability = self:GetAbility(),
                }

                ApplyDamage( damageInfo )
                
                enemy:AddNewModifier(parent, nil, "modifier_boss_ursa_jump_debuff", {duration = debuff_duration * (1-enemy:GetStatusResistance())})
			end
		end

		knockback:SetEndCallback( callback )
	end)
end

modifier_boss_ursa_jump_debuff = class({})

function modifier_boss_ursa_jump_debuff:GetTexture() return "ursa_earthshock" end

function modifier_boss_ursa_jump_debuff:IsPurgable() return false end

function modifier_boss_ursa_jump_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_boss_ursa_jump_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -50
end

modifier_boss_ursa_jump_active = class({})

function modifier_boss_ursa_jump_active:IsHidden()
	return true
end

function modifier_boss_ursa_jump_active:IsPurgable()
	return false
end

function modifier_boss_ursa_jump_active:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_boss_ursa_jump_active:OnCreated( kv )
	if IsServer() then
		self.distance = kv.distance or 0
		self.height = kv.height or -1
		self.duration = kv.duration or 0
		if kv.direction_x and kv.direction_y then
			self.direction = Vector(kv.direction_x,kv.direction_y,0):Normalized()
		else
			self.direction = -(self:GetParent():GetForwardVector())
		end
		self.tree = kv.tree_destroy_radius or self:GetParent():GetHullRadius()
		if kv.IsStun then self.stun = kv.IsStun==1 else self.stun = false end
		if kv.IsFlail then self.flail = kv.IsFlail==1 else self.flail = true end
		if self.duration == 0 then
			self:Destroy()
			return
		end
		self.parent = self:GetParent()
		self.origin = self.parent:GetOrigin()
		self.hVelocity = self.distance/self.duration
		local half_duration = self.duration/2
		self.gravity = 2*self.height/(half_duration*half_duration)
		self.vVelocity = self.gravity*half_duration
		if self.distance>0 then
			if self:ApplyHorizontalMotionController() == false then 
				self:Destroy()
				return
			end
		end
		if self.height>=0 then
			if self:ApplyVerticalMotionController() == false then 
				self:Destroy()
				return
			end
		end
		if self.flail then
			self:SetStackCount( 1 )
		elseif self.stun then
			self:SetStackCount( 2 )
		end
	else
		self.anim = self:GetStackCount()
		self:SetStackCount( 0 )
	end
end

function modifier_boss_ursa_jump_active:OnDestroy( kv )
	if not IsServer() then return end

	if not self.interrupted then
		if self.tree>0 then
			GridNav:DestroyTreesAroundPoint( self:GetParent():GetOrigin(), self.tree, true )
		end
	end

	if self.EndCallback then
		self.EndCallback( self.interrupted )
	end

	self:GetParent():InterruptMotionControllers( true )
end

function modifier_boss_ursa_jump_active:SetEndCallback( func ) 
	self.EndCallback = func
end

function modifier_boss_ursa_jump_active:CheckState()
	local state = 
	{
		[MODIFIER_STATE_STUNNED] = self.stun,
	}
	return state
end

function modifier_boss_ursa_jump_active:UpdateHorizontalMotion( me, dt )
	local parent = self:GetParent()
	local target = self.direction*self.distance*(dt/self.duration)
	parent:SetOrigin( parent:GetOrigin() + target )
end

function modifier_boss_ursa_jump_active:OnHorizontalMotionInterrupted()
	if IsServer() then
		self.interrupted = true
		self:Destroy()
	end
end

function modifier_boss_ursa_jump_active:UpdateVerticalMotion( me, dt )
	local time = dt/self.duration
	self.parent:SetOrigin( self.parent:GetOrigin() + Vector( 0, 0, self.vVelocity*dt ) )
	self.vVelocity = self.vVelocity - self.gravity*dt
end

function modifier_boss_ursa_jump_active:OnVerticalMotionInterrupted()
	if IsServer() then
		self.interrupted = true
		self:Destroy()
	end
end

function modifier_boss_ursa_jump_active:GetEffectName()
	if not IsServer() then return end
	if self.stun then
		return "particles/generic_gameplay/generic_stunned.vpcf"
	end
end

function modifier_boss_ursa_jump_active:GetEffectAttachType()
	if not IsServer() then return end
	return PATTACH_OVERHEAD_FOLLOW
end