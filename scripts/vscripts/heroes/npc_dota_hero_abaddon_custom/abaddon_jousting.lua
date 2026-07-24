--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_abaddon_jousting_cast", "heroes/npc_dota_hero_abaddon_custom/abaddon_jousting", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_abaddon_jousting_charge", "heroes/npc_dota_hero_abaddon_custom/abaddon_jousting", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_abaddon_jousting_slow", "heroes/npc_dota_hero_abaddon_custom/abaddon_jousting", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_abaddon_jousting_ignore_damage", "heroes/npc_dota_hero_abaddon_custom/abaddon_jousting", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_abaddon_jousting_handler", "heroes/npc_dota_hero_abaddon_custom/abaddon_jousting", LUA_MODIFIER_MOTION_BOTH)

abaddon_jousting = class({})

abaddon_jousting.modifier_abaddon_10_cooldown = -2
abaddon_jousting.modifier_abaddon_10_attackspeed = 90
abaddon_jousting.modifier_abaddon_12_duration = 2
abaddon_jousting.modifier_abaddon_12 = {-30,-60}
abaddon_jousting.modifier_abaddon_13_duration = 2
abaddon_jousting.modifier_abaddon_13 = {-20,-30,-40}

function abaddon_jousting:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_abaddon.vsndevts", context )
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_primal_beast.vsndevts", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_range_finder.vpcf", context )
    PrecacheResource( "particle", "particles/yashio/yasuo_spell_first/yasuo_spell_first_buff.vpcf", context )
    PrecacheResource( "particle", "particles/abaddon_run.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_terrorblade/terrorblade_feet_effects.vpcf", context )
end

function abaddon_jousting:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_abaddon_10") then
        bonus = (self:GetCaster():GetModifierStackCount("modifier_abaddon_jousting_handler", self:GetCaster()) / self.modifier_abaddon_10_attackspeed) * self.modifier_abaddon_10_cooldown
    end
    return math.max(2, self.BaseClass.GetCooldown(self, iLevel) + bonus)
end

function abaddon_jousting:GetIntrinsicModifierName()
    return "modifier_abaddon_jousting_handler"
end

function abaddon_jousting:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor( "chargeup_time" )
	local point = self:GetCursorPosition()
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_abaddon_jousting_cast", { duration = duration, speed = self:GetCaster():GetIdealSpeed() } )
    if self:GetCaster():HasModifier("modifier_abaddon_13") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_abaddon_jousting_ignore_damage", {})
    end
end

function abaddon_jousting:OnChargeFinish( interrupt, target )
	if not IsServer() then return end
	local caster = self:GetCaster()
	local max_duration = self:GetSpecialValueFor( "chargeup_time" )
	local max_distance = self:GetSpecialValueFor( "max_distance" )
	local charge_duration = max_duration
	local mod = caster:FindModifierByName( "modifier_abaddon_jousting_cast" )
	if mod then
		charge_duration = mod:GetElapsedTime()
		mod.charge_finish = true
		mod:Destroy()
	end
    local speed = self:GetCaster():GetMoveSpeedModifier(self:GetCaster():GetBaseMoveSpeed(), true)
	local distance = max_distance * charge_duration/max_duration
	local duration = distance/speed
	if interrupt then return end
	caster:AddNewModifier( caster, self, "modifier_abaddon_jousting_charge", { duration = duration } )
end

abaddon_jousting_cancel = class({})

function abaddon_jousting_cancel:OnSpellStart()
	local ability = self:GetCaster():FindAbilityByName("abaddon_jousting")
	if ability then
		ability:OnChargeFinish( false )
	end
end

modifier_abaddon_jousting_cast = class({})

function modifier_abaddon_jousting_cast:IsPurgable()
	return false
end

function modifier_abaddon_jousting_cast:OnCreated( kv )
	self.speed = self:GetAbility():GetSpecialValueFor("max_distance") / self:GetAbility():GetSpecialValueFor( "chargeup_time" ) 
	self.turn_speed = self:GetAbility():GetSpecialValueFor( "turn_rate" )
	self.max_time = self:GetAbility():GetSpecialValueFor( "chargeup_time" ) 
	if not IsServer() then return end
	self.anim_return = 0
	self.origin = self:GetParent():GetOrigin()
	self.charge_finish = false
	self.target_angle = self:GetParent():GetAnglesAsVector().y
	self.current_angle = self.target_angle
	self.face_target = true
	self.time = self:GetAbility():GetSpecialValueFor("max_distance") / self.speed
	self:StartIntervalThink( FrameTime() )
	self:PlayEffects1()
	self:PlayEffects2()
end

function modifier_abaddon_jousting_cast:OnRemoved()
	if not IsServer() then return end
    self:GetCaster():RemoveModifierByName("modifier_abaddon_jousting_ignore_damage")
    if self:GetCaster():HasModifier("modifier_abaddon_13") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_abaddon_jousting_ignore_damage", {duration = self:GetAbility().modifier_abaddon_13_duration})
    end
	if not self.charge_finish then
		self:GetAbility():OnChargeFinish( false, self.target )
	end
end

function modifier_abaddon_jousting_cast:DeclareFunctions()
	return
    {
		MODIFIER_EVENT_ON_ORDER,
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
	}
end

function modifier_abaddon_jousting_cast:OnOrder( params )
	if params.unit~=self:GetParent() then return end
	if 	params.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION or
		params.order_type==DOTA_UNIT_ORDER_MOVE_TO_DIRECTION
	then
		self:SetDirection( params.new_pos )
	elseif 
		params.order_type==DOTA_UNIT_ORDER_MOVE_TO_TARGET or
		params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET
	then
		self:SetDirection( params.target:GetOrigin() )
	elseif
		params.order_type==DOTA_UNIT_ORDER_STOP or 
		params.order_type==DOTA_UNIT_ORDER_HOLD_POSITION
	then
		self:GetAbility():OnChargeFinish( false, self.target )
	end	
end

function modifier_abaddon_jousting_cast:SetDirection( location )
	local dir = ((location-self:GetParent():GetOrigin())*Vector(1,1,0)):Normalized()
	self.target_angle = VectorToAngles( dir ).y
	self.face_target = false
end

function modifier_abaddon_jousting_cast:GetModifierMoveSpeed_Limit()
    if IsClient() then return end
	return 0.1
end

function modifier_abaddon_jousting_cast:CheckState()
	return
    {
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_abaddon_jousting_cast:OnIntervalThink()
	if self.target and self.target:IsAlive() then 
		self:SetDirection(self.target:GetAbsOrigin())
	end
	if self:GetParent():IsRooted() or self:GetParent():IsStunned() or self:GetParent():IsSilenced() or
		self:GetParent():IsCurrentlyHorizontalMotionControlled() or self:GetParent():IsCurrentlyVerticalMotionControlled()
	then
		self:GetAbility():OnChargeFinish( true, self.target )
	end
	self:TurnLogic( FrameTime() )
	self:SetEffects()
end

function modifier_abaddon_jousting_cast:TurnLogic( dt )
	if self.face_target then return end
	local angle_diff = AngleDiff( self.current_angle, self.target_angle )
	local turn_speed = self.turn_speed*dt

	local sign = -1
	if angle_diff<0 then sign = 1 end

	if math.abs( angle_diff )<1.1*turn_speed then
		self.current_angle = self.target_angle
		self.face_target = true
	else
		self.current_angle = self.current_angle + sign*turn_speed
	end

	local angles = self:GetParent():GetAnglesAsVector()
	self:GetParent():SetLocalAngles( angles.x, self.current_angle, angles.z )
end

function modifier_abaddon_jousting_cast:PlayEffects1()
	self.effect_cast = ParticleManager:CreateParticleForPlayer( "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_range_finder.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), self:GetParent():GetPlayerOwner() )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
	self:AddParticle( self.effect_cast, true, false, -1, false, false )
	self:SetEffects()
end

function modifier_abaddon_jousting_cast:SetEffects()
	local time = self:GetElapsedTime()
	local k =  time/self.max_time
	local speed_time = k*self.time
	local target_pos = self.origin + self:GetParent():GetForwardVector() * self.speed * speed_time
    ParticleManager:SetParticleControl( self.effect_cast, 1, target_pos )
end

function modifier_abaddon_jousting_cast:PlayEffects2()
	--local effect_cast = ParticleManager:CreateParticle( "particles/ui_mouseactions/range_finder_cone.vpcf", PATTACH_POINT_FOLLOW, self:GetParent() )
	--ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	--ParticleManager:SetParticleControlEnt( effect_cast, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	--self:AddParticle( effect_cast, false, false, -1, false, false )
end

modifier_abaddon_jousting_charge = class({})

function modifier_abaddon_jousting_charge:IsPurgable()
	return false
end

function modifier_abaddon_jousting_charge:CheckState()
	return
	{
		[MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        [MODIFIER_STATE_UNSLOWABLE] = self:GetCaster():HasModifier("modifier_abaddon_9"),
	}
end

function modifier_abaddon_jousting_charge:OnCreated( kv )
	self.turn_speed = self:GetAbility():GetSpecialValueFor( "turn_rate" )
	self.radius = self:GetAbility():GetSpecialValueFor( "width" )
	self.tree_radius = 100
	if not IsServer() then return end
	self.target_angle = self:GetParent():GetAnglesAsVector().y
	self.current_angle = self.target_angle
	self.face_target = true
	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
		return
	end
    self:GetCaster():EmitSound("Hero_Abaddon.Taunt_2022")
    local particle = ParticleManager:CreateParticle("particles/yashio/yasuo_spell_first/yasuo_spell_first_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 1, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetCaster():GetAbsOrigin(), true)
    self:AddParticle(particle, false, false, -1, false, false)

    local particle2 = ParticleManager:CreateParticle("particles/abaddon_run.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt(particle2, 0, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle2, 1, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetCaster():GetAbsOrigin(), true)
    self:AddParticle(particle2, false, false, -1, false, false)

    local feet = ParticleManager:CreateParticle("particles/units/heroes/hero_terrorblade/terrorblade_feet_effects.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    self:AddParticle(feet, false, false, -1, false, false)

    self.targets = {}
	self.distance_pass = 0
end

function modifier_abaddon_jousting_charge:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_DISABLE_TURNING,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_MOVESPEED_MAX,
        MODIFIER_PROPERTY_MOVESPEED_LIMIT,
	}
end

function modifier_abaddon_jousting_charge:GetModifierIgnoreMovespeedLimit()
    if self:GetParent():HasModifier("modifier_rune_haste") then return 1 end
    if not self:GetCaster():HasModifier("modifier_abaddon_9") then return end
    return 1
end

function modifier_abaddon_jousting_charge:GetModifierMoveSpeed_Max( params )
    if self:GetParent():HasModifier("modifier_rune_haste") then return end
	if not self:GetCaster():HasModifier("modifier_abaddon_9") then return end
    return 5000
end

function modifier_abaddon_jousting_charge:GetModifierMoveSpeed_Limit( params )
    if self:GetParent():HasModifier("modifier_rune_haste") then return end
	if not self:GetCaster():HasModifier("modifier_abaddon_9") then return end
    return 5000
end

function modifier_abaddon_jousting_charge:GetOverrideAnimation()
    return ACT_DOTA_RUN
end

function modifier_abaddon_jousting_charge:OnOrder( params )
	if params.unit~=self:GetParent() then return end
	if params.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION then
		self:SetDirection( params.new_pos )
	elseif
		params.order_type==DOTA_UNIT_ORDER_MOVE_TO_DIRECTION
	then
		self:SetDirection( params.new_pos )
	elseif 
		params.order_type==DOTA_UNIT_ORDER_MOVE_TO_TARGET or
		params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET
	then
		self:SetDirection( params.target:GetOrigin() )
	elseif
		params.order_type==DOTA_UNIT_ORDER_STOP or 
		params.order_type==DOTA_UNIT_ORDER_CAST_TARGET or
		params.order_type==DOTA_UNIT_ORDER_CAST_POSITION or
		params.order_type==DOTA_UNIT_ORDER_HOLD_POSITION
	then
		self:Destroy()
	end	
end

function modifier_abaddon_jousting_charge:GetModifierDisableTurning()
	return 1
end

function modifier_abaddon_jousting_charge:SetDirection( location )
	local dir = ((location-self:GetParent():GetOrigin())*Vector(1,1,0)):Normalized()
	self.target_angle = VectorToAngles( dir ).y
	self.face_target = false
end

function modifier_abaddon_jousting_charge:TurnLogic( dt )
	if self.face_target then return end
	local angle_diff = AngleDiff( self.current_angle, self.target_angle )
	local turn_speed = self.turn_speed*dt

	local sign = -1
	if angle_diff<0 then sign = 1 end

	if math.abs( angle_diff )<1.1*turn_speed then
		self.current_angle = self.target_angle
		self.face_target = true
	else
		self.current_angle = self.current_angle + sign*turn_speed
	end

	local angles = self:GetParent():GetAnglesAsVector()
	self:GetParent():SetLocalAngles( angles.x, self.current_angle, angles.z )
end

function modifier_abaddon_jousting_charge:HitLogic()
	GridNav:DestroyTreesAroundPoint( self:GetParent():GetOrigin(), self.tree_radius, false )
    local units = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
    for _, unit in pairs(units) do
        if self.targets[unit:entindex()] == nil then
            self.targets[unit:entindex()] = true
            if self:GetCaster():HasModifier("modifier_abaddon_12") then
                unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_abaddon_jousting_slow", {duration = self:GetAbility().modifier_abaddon_12_duration})
            end
            ApplyDamage({ victim = unit, attacker = self:GetParent(), damage = self:GetAbility():GetSpecialValueFor( "damage_from_speed" ) / 100 * self:GetCaster():GetIdealSpeed(), damage_type = DAMAGE_TYPE_PURE, ability = self:GetAbility() })
        end
    end
end

function modifier_abaddon_jousting_charge:UpdateHorizontalMotion( me, dt )
	if self:GetParent():IsRooted() then
		return
	end
	self:HitLogic()
	self:TurnLogic( dt )
	local nextpos = me:GetOrigin() + me:GetForwardVector() * self:GetParent():GetIdealSpeed() * dt
	me:SetOrigin(nextpos)
end

function modifier_abaddon_jousting_charge:OnHorizontalMotionInterrupted()
	self:Destroy()
end

function modifier_abaddon_jousting_charge:PlayEffects( target, radius )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	target:EmitSound("Hero_PrimalBeast.Onslaught.Hit")
end

function modifier_abaddon_jousting_charge:OnDestroy()
	if not IsServer() then return end
    self:GetCaster():StopSound("Hero_Abaddon.Taunt_2022")
	self:GetParent():RemoveHorizontalMotionController(self)
	FindClearSpaceForUnit( self:GetParent(), self:GetParent():GetOrigin(), false )
    if self:GetCaster():HasModifier("modifier_abaddon_13") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_abaddon_jousting_ignore_damage", {duration = self:GetAbility().modifier_abaddon_13_duration})
    end
end

modifier_abaddon_jousting_slow = class({})

function modifier_abaddon_jousting_slow:GetTexture() return "abaddon_12" end

function modifier_abaddon_jousting_slow:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_abaddon_jousting_slow:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility().modifier_abaddon_12[self:GetCaster():GetTalentLevel("modifier_abaddon_12")]
end

function modifier_abaddon_jousting_slow:GetStatusEffectName()
    return "particles/status_fx/status_effect_brewmaster_thunder_clap.vpcf"
end

function modifier_abaddon_jousting_slow:GetEffectName()
    return "particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap_debuff.vpcf"
end

function modifier_abaddon_jousting_slow:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_abaddon_jousting_slow:StatusEffectPriority()
    return 3
end

modifier_abaddon_jousting_ignore_damage = class({})
function modifier_abaddon_jousting_ignore_damage:GetTexture() return "abaddon_13" end
function modifier_abaddon_jousting_ignore_damage:IsPurgable() return false end
function modifier_abaddon_jousting_ignore_damage:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
    }
end

function modifier_abaddon_jousting_ignore_damage:GetModifierIncomingDamage_Percentage()
    return self:GetAbility().modifier_abaddon_13[self:GetCaster():GetTalentLevel("modifier_abaddon_13")]
end

modifier_abaddon_jousting_handler = class({})
function modifier_abaddon_jousting_handler:IsHidden() return true end
function modifier_abaddon_jousting_handler:IsPurgable() return false end
function modifier_abaddon_jousting_handler:IsPurgeException() return false end
function modifier_abaddon_jousting_handler:RemoveOnDeath() return false end
function modifier_abaddon_jousting_handler:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(1)
end
function modifier_abaddon_jousting_handler:OnIntervalThink()
    if not IsServer() then return end
    local abilities_harpoon = {}
    for _, mod in pairs(self:GetParent():FindAllModifiersByName("modifier_item_harpoon_echosabre_component")) do
        table.insert(abilities_harpoon, mod:GetAbility())
        mod:Destroy()
    end
    self:GetParent().jousting = true
    self:SetStackCount(self:GetCaster():GetDisplayAttackSpeed())
    self:GetParent().jousting = nil
    for _, ability in pairs(abilities_harpoon) do
        if ability ~= nil and not ability:IsNull() and ability:GetContainer() == nil then
            self:GetParent():AddNewModifier(self:GetParent(), ability, "modifier_item_harpoon_echosabre_component", {})
        end
    end
end