--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_roshan_bash_custom", "heroes/npc_dota_hero_arc_warden_custom/roshan_bash_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_roshan_bash_custom_active_cast", "heroes/npc_dota_hero_arc_warden_custom/roshan_bash_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_roshan_bash_custom_active", "heroes/npc_dota_hero_arc_warden_custom/roshan_bash_custom", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_roshan_bash_custom_active_cooldown", "heroes/npc_dota_hero_arc_warden_custom/roshan_bash_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_roshan_bash_custom_cooldown", "heroes/npc_dota_hero_arc_warden_custom/roshan_bash_custom", LUA_MODIFIER_MOTION_NONE )

roshan_bash_custom = class({})

roshan_bash_custom.modifier_arc_warden_2 = {150,200}
roshan_bash_custom.modifier_arc_warden_3_duration = 3
roshan_bash_custom.modifier_arc_warden_3_cooldown = 15
roshan_bash_custom.modifier_arc_warden_3_radius = 300
roshan_bash_custom.modifier_arc_warden_3_bonus_movespeed = 200
roshan_bash_custom.modifier_arc_warden_4 = {200,400}
roshan_bash_custom.modifier_arc_warden_9 = {3,6}
roshan_bash_custom.modifier_arc_warden_12 = 800
roshan_bash_custom.modifier_arc_warden_12_duration_percent = 50
roshan_bash_custom.modifier_arc_warden_12_chance = 100

function roshan_bash_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", " particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_arc_warden.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_arc_warden.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_arc_warden.vpcf", context)
end

function roshan_bash_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_arc_warden_3") then
        return DOTA_ABILITY_BEHAVIOR_POINT
    end
    return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function roshan_bash_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_arc_warden_3") then
        return "roshan_bash_active"
    end
    return "roshan_bash"
end

function roshan_bash_custom:GetCooldown(iLevel)
    if self:GetCaster():HasModifier("modifier_arc_warden_3") then
        return self.modifier_arc_warden_3_cooldown
    end
    return 0
end

function roshan_bash_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_roshan_bash_custom_active_cast", { duration = 0.75, speed = self:GetCaster():GetIdealSpeed() } )
end

function roshan_bash_custom:OnChargeFinish( interrupt, target )
	if not IsServer() then return end
	local caster = self:GetCaster()
	local charge_duration = max_duration
	local mod = caster:FindModifierByName( "modifier_abaddon_jousting_cast" )
	if mod then
		charge_duration = mod:GetElapsedTime()
		mod.charge_finish = true
		mod:Destroy()
	end
	if interrupt then return end
	caster:AddNewModifier( caster, self, "modifier_roshan_bash_custom_active", { duration = self.modifier_arc_warden_3_duration } )
end

function roshan_bash_custom:GetIntrinsicModifierName()
	return "modifier_roshan_bash_custom"
end

modifier_roshan_bash_custom = class({})
function modifier_roshan_bash_custom:IsHidden() return true end
function modifier_roshan_bash_custom:IsPurgable() return false end
function modifier_roshan_bash_custom:IsPurgeException() return false end
function modifier_roshan_bash_custom:RemoveOnDeath() return false end
function modifier_roshan_bash_custom:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
        MODIFIER_EVENT_ON_ABILITY_EXECUTED,
	}
end

function modifier_roshan_bash_custom:OnCreated()
    if not IsServer() then return end
    self.exceptions = 
    {
        ["item_clarity"] = true,
        ["item_enchanted_mango"] = true,
        ["item_bottle"] = true,
        ["item_smoke_of_deceit"] = true,
        ["item_flask"] = true,
        ["item_tango"] = true,
        ["item_faerie_fire"] = true,
        ["item_dust_custom"] = true,
        ["item_book_str"] = true,
        ["item_book_agi"] = true,
        ["item_book_int"] = true,
        ["item_power_treads"] = true,
        ["item_aghanims_treads"] = true,
        ["item_aghanims_shard_custom"] = true,
        ["item_health_radiance"] = true,
        ["item_mana_radiance"] = true,
        ["item_radiance_custom"] = true,
        ["item_spear_of_mordiggian"] = true,
        ["item_vambrace"] = true,
        ["item_ward_dispenser_custom"] = true,
        ["item_moon_aghanim"] = true,
        ["item_moon_kaya"] = true,
        ["item_moon_yasha"] = true,
        ["item_moon_sange"] = true,
        ["item_moon_aghanim"] = true,
        ["item_moon_shard"] = true,      
        ["item_royale_with_cheese"] = true,  
        ["item_talant_book"] = true,  
    }
end

function modifier_roshan_bash_custom:GetModifierProcAttack_BonusDamage_Physical(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.attacker:IsIllusion() then return end
	if params.attacker:PassivesDisabled() then return end
	if params.target:IsWard() then return end
    if self:GetParent():GetUnitName() ~= "npc_dota_hero_arc_warden" and self:GetParent():GetUnitName() ~= "npc_dota_hero_rubick" then return end
	if self:GetParent():HasModifier("modifier_item_abyssal_blade") then return end
	if self:GetParent():HasModifier("modifier_item_basher") then return end
	if self:GetParent():HasModifier("modifier_item_diffusal_basher") then return end
	if self:GetParent():HasItemInInventory("item_basher") then return end
    local chance = self:GetAbility():GetSpecialValueFor("chance")
    local damage = self:GetAbility():GetSpecialValueFor("damage")
    local stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")
    if self:GetCaster():HasModifier("modifier_arc_warden_9") then
        chance = chance + self:GetAbility().modifier_arc_warden_9[self:GetCaster():GetTalentLevel("modifier_arc_warden_9")]
    end
    if self:GetCaster():HasModifier("modifier_arc_warden_2") then
        damage = damage + (self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_arc_warden_2[self:GetCaster():GetTalentLevel("modifier_arc_warden_2")])
    end
	if RollPseudoRandomPercentage(chance, 322, self:GetParent()) and not self:GetParent():HasModifier("modifier_roshan_bash_custom_cooldown") then
		params.target:EmitSound("Roshan.Bash")
		params.target:AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_bashed", { duration = stun_duration * (1 - params.target:GetStatusResistance()) })
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_roshan_bash_custom_cooldown", {duration = 0.5 * self:GetCaster():GetCooldownReduction()})
    	return damage
	end
end

function modifier_roshan_bash_custom:OnAbilityExecuted(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if not self:GetCaster():HasModifier("modifier_arc_warden_12") then return end
    if not params.ability:IsItem() then return end
    if params.ability:IsToggle() then return end
    if self.exceptions[params.ability:GetAbilityName()] ~= nil then return end
    if self:GetParent():PassivesDisabled() then return end
    -- local chance = self:GetAbility():GetSpecialValueFor("chance")
    -- if self:GetCaster():HasModifier("modifier_arc_warden_9") then
    --     chance = chance + self:GetAbility().modifier_arc_warden_9[self:GetCaster():GetTalentLevel("modifier_arc_warden_9")]
    -- end
    if not RollPercentage(self:GetAbility().modifier_arc_warden_12_chance) then return end
    local heroes = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility().modifier_arc_warden_12, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility().modifier_arc_warden_12, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    local target = nil
    if #heroes > 0 then
        target = heroes[1]
    elseif #units > 0 then
        target = units[1]
    end
    if target ~= nil then
        local damage = self:GetAbility():GetSpecialValueFor("damage")
        if self:GetCaster():HasModifier("modifier_arc_warden_2") then
            damage = damage + (self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_arc_warden_2[self:GetCaster():GetTalentLevel("modifier_arc_warden_2")])
        end
        local stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration") / 100 * self:GetAbility().modifier_arc_warden_12_duration_percent
        target:EmitSound("Roshan.Bash")
		target:AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_bashed", { duration = stun_duration * (1 - target:GetStatusResistance()) })
        ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self:GetAbility() })
    end
end

function modifier_roshan_bash_custom:BashTarget(target)
    if not IsServer() then return end
    local damage = self:GetAbility():GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_arc_warden_2") then
        damage = damage + (self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_arc_warden_2[self:GetCaster():GetTalentLevel("modifier_arc_warden_2")])
    end
    local stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")
    target:EmitSound("Roshan.Bash")
    target:AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_bashed", { duration = stun_duration * (1 - target:GetStatusResistance()) })
    target:AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_roshan_bash_custom_active_cooldown", { duration = stun_duration })
    ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self:GetAbility() })
end

modifier_roshan_bash_custom_active = class({})
function modifier_roshan_bash_custom_active:IsPurgable() return false end
function modifier_roshan_bash_custom_active:IsPurgeException() return false end

function modifier_roshan_bash_custom_active:GetEffectName()
    return "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf"
end
  
function modifier_roshan_bash_custom_active:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

  
function modifier_roshan_bash_custom_active:OnCreated(params)
    if not IsServer() then return end

	self.turn_speed = 90
	self.radius = 300
	self.tree_radius = 100
	if not IsServer() then return end
	self.target_angle = self:GetParent():GetAnglesAsVector().y
	self.current_angle = self.target_angle
	self.face_target = true

	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
		return
	end

	self.distance_pass = 0

    self:StartIntervalThink(0.05)
end

function modifier_roshan_bash_custom_active:OnDestroy()
   if not IsServer() then return end
end

function modifier_roshan_bash_custom_active:OnIntervalThink()
    if not IsServer() then return end
    local modifier_roshan_bash_custom = self:GetParent():FindModifierByName("modifier_roshan_bash_custom")
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetCaster():GetAoeBonus(self:GetAbility().modifier_arc_warden_3_radius), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    local is_destroy = false
    for _, unit in pairs(units) do
        if not unit:HasModifier("modifier_roshan_bash_custom_active_cooldown") then
            if modifier_roshan_bash_custom then
                modifier_roshan_bash_custom:BashTarget(unit)
            end
        end
    end
end

function modifier_roshan_bash_custom_active:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_DISABLE_TURNING
    }
end

function modifier_roshan_bash_custom_active:OnOrder( params )
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

function modifier_roshan_bash_custom_active:UpdateHorizontalMotion( me, dt )
	if self:GetParent():IsRooted() then
		return
	end
	self:TurnLogic( dt )
	local nextpos = me:GetOrigin() + me:GetForwardVector() * self:GetParent():GetIdealSpeed() * dt
	me:SetOrigin(nextpos)
end

function modifier_roshan_bash_custom_active:OnHorizontalMotionInterrupted()
	self:Destroy()
end

function modifier_roshan_bash_custom_active:GetModifierDisableTurning()
	return 1
end

function modifier_roshan_bash_custom_active:SetDirection( location )
	local dir = ((location-self:GetParent():GetOrigin())*Vector(1,1,0)):Normalized()
	self.target_angle = VectorToAngles( dir ).y
	self.face_target = false
end

function modifier_roshan_bash_custom_active:TurnLogic( dt )
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

function modifier_roshan_bash_custom_active:GetOverrideAnimation()
    return ACT_DOTA_RUN
end

function modifier_roshan_bash_custom_active:GetModifierMoveSpeedBonus_Constant()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_arc_warden_3") then
        bonus = bonus + self:GetAbility().modifier_arc_warden_3_bonus_movespeed
    end
    if self:GetCaster():HasModifier("modifier_arc_warden_4") then
        bonus = bonus + self:GetAbility().modifier_arc_warden_4[self:GetCaster():GetTalentLevel("modifier_arc_warden_4")]
    end
    return bonus
end

function modifier_roshan_bash_custom_active:CheckState()
    return
    {
        [MODIFIER_STATE_FAKE_ALLY] = true,
        --[MODIFIER_STATE_DEBUFF_IMMUNE] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true
    }
end

function modifier_roshan_bash_custom_active:GetModifierIgnoreMovespeedLimit()
    return 1
end

modifier_roshan_bash_custom_active_cooldown = class({})
function modifier_roshan_bash_custom_active_cooldown:IsPurgable() return false end
function modifier_roshan_bash_custom_active_cooldown:IsPurgeException() return false end
function modifier_roshan_bash_custom_active_cooldown:IsHidden() return true end

modifier_roshan_bash_custom_cooldown = class({})
function modifier_roshan_bash_custom_cooldown:IsPurgable() return false end
function modifier_roshan_bash_custom_cooldown:IsPurgeException() return false end
function modifier_roshan_bash_custom_cooldown:IsHidden() return true end

modifier_roshan_bash_custom_active_cast = class({})
function modifier_roshan_bash_custom_active_cast:IsPurgable() return false end

function modifier_roshan_bash_custom_active_cast:OnCreated( kv )
	self.turn_speed = 120
	if not IsServer() then return end
	self.origin = self:GetParent():GetOrigin()
	self.target_angle = self:GetParent():GetAnglesAsVector().y
	self.current_angle = self.target_angle
	self.face_target = true
	self:StartIntervalThink( FrameTime() )
end

function modifier_roshan_bash_custom_active_cast:OnRemoved()
	if not IsServer() then return end
	self:GetAbility():OnChargeFinish( false, self.target )
end

function modifier_roshan_bash_custom_active_cast:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_DISABLE_TURNING
	}
end

function modifier_roshan_bash_custom_active_cast:OnOrder( params )
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
    end
end

function modifier_roshan_bash_custom_active_cast:SetDirection( location )
	local dir = ((location-self:GetParent():GetOrigin())*Vector(1,1,0)):Normalized()
	self.target_angle = VectorToAngles( dir ).y
	self.face_target = false
end

function modifier_roshan_bash_custom_active_cast:GetModifierMoveSpeed_Limit()
    if IsClient() then return end
	return 0.1
end

function modifier_roshan_bash_custom_active_cast:CheckState()
	return
    {
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_roshan_bash_custom_active_cast:OnIntervalThink()
	if self.target and self.target:IsAlive() then 
		self:SetDirection(self.target:GetAbsOrigin())
	end
	if self:GetParent():IsRooted() or self:GetParent():IsStunned() or self:GetParent():IsSilenced() or
		self:GetParent():IsCurrentlyHorizontalMotionControlled() or self:GetParent():IsCurrentlyVerticalMotionControlled()
	then
		self:GetAbility():OnChargeFinish( true, self.target )
	end
	self:TurnLogic( FrameTime() )
end

function modifier_roshan_bash_custom_active_cast:TurnLogic( dt )
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

function modifier_roshan_bash_custom_active_cast:GetModifierDisableTurning()
	return 1
end