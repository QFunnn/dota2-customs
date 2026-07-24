--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_dawnbreaker_fire_wreath_custom", "heroes/npc_dota_hero_dawnbreaker_custom/dawnbreaker_fire_wreath_custom", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_dawnbreaker_fire_wreath_custom_slow", "heroes/npc_dota_hero_dawnbreaker_custom/dawnbreaker_fire_wreath_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dawnbreaker_fire_wreath_custom_immune", "heroes/npc_dota_hero_dawnbreaker_custom/dawnbreaker_fire_wreath_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_arc_lua", "modifiers/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )

dawnbreaker_fire_wreath_custom = class({})
dawnbreaker_fire_wreath_custom.modifier_dawnbreaker_1 = {15,30,45}
dawnbreaker_fire_wreath_custom.modifier_dawnbreaker_2 = {40,80}
dawnbreaker_fire_wreath_custom.modifier_dawnbreaker_3 = {40,80}
dawnbreaker_fire_wreath_custom.modifier_dawnbreaker_3_kills = 4
dawnbreaker_fire_wreath_custom.modifier_dawnbreaker_4_cooldown = -1
dawnbreaker_fire_wreath_custom.modifier_dawnbreaker_4_str = {55,45}
dawnbreaker_fire_wreath_custom.modifier_dawnbreaker_6_resistance = {30,60}
dawnbreaker_fire_wreath_custom.modifier_dawnbreaker_6_slow = 35
dawnbreaker_fire_wreath_custom.modifier_dawnbreaker_6_min_speed = 215

function dawnbreaker_fire_wreath_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_dawnbreaker.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_dawnbreaker.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_dawnbreaker.vpcf", context)
end

function dawnbreaker_fire_wreath_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_dawnbreaker_4") then
        bonus = self.modifier_dawnbreaker_4_cooldown * (self:GetCaster():GetStrength() / self.modifier_dawnbreaker_4_str[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_4")])
    end
    return math.max(self.BaseClass.GetCooldown(self, iLevel) + bonus, 3)
end

function dawnbreaker_fire_wreath_custom:GetManaCost(iLevel)
    local default_manacost = self.BaseClass.GetManaCost(self, iLevel)
    if self:GetCaster():HasModifier("modifier_dawnbreaker_2") then
        default_manacost = default_manacost - (default_manacost / 100 * self.modifier_dawnbreaker_2[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_2")])
    end
    return default_manacost
end

function dawnbreaker_fire_wreath_custom:CastFilterResultLocation( vLoc )
	if self:GetCaster():HasModifier( "modifier_dawnbreaker_celestial_hammer_custom_nohammer" ) then
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end

function dawnbreaker_fire_wreath_custom:GetCustomCastErrorLocation( vLoc )
	if self:GetCaster():HasModifier( "modifier_dawnbreaker_celestial_hammer_custom_nohammer" ) then
		return "#dota_hud_error_nohammer"
	end
	return ""
end

function dawnbreaker_fire_wreath_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor( "duration" )
	local direction = point - caster:GetOrigin()
	if direction:Length2D()<1 then
		direction = caster:GetForwardVector()
	else
		direction.z = 0
		direction = direction:Normalized()
	end
	caster:AddNewModifier(caster, self, "modifier_dawnbreaker_fire_wreath_custom", {x = direction.x, y = direction.y})
end

modifier_dawnbreaker_fire_wreath_custom = class({})
function modifier_dawnbreaker_fire_wreath_custom:IsPurgable() return false end

function modifier_dawnbreaker_fire_wreath_custom:OnCreated( kv )
	self.parent = self:GetParent()

	self.swipe_radius = self:GetAbility():GetSpecialValueFor( "swipe_radius" )

	self.swipe_damage = self:GetAbility():GetSpecialValueFor( "swipe_damage" )

    if self.parent:HasModifier("modifier_dawnbreaker_1") then
        self.swipe_damage = self.swipe_damage + self:GetAbility().modifier_dawnbreaker_1[self.parent:GetTalentLevel("modifier_dawnbreaker_1")]
    end

	self.swipe_duration = self:GetAbility():GetSpecialValueFor( "sweep_stun_duration" )

	self.smash_radius = self:GetAbility():GetSpecialValueFor( "smash_radius" )

	self.smash_damage = self:GetAbility():GetSpecialValueFor( "smash_damage" )
    if self.parent:HasModifier("modifier_dawnbreaker_1") then
        self.smash_damage = self.smash_damage + self:GetAbility().modifier_dawnbreaker_1[self.parent:GetTalentLevel("modifier_dawnbreaker_1")]
    end

	self.smash_duration = self:GetAbility():GetSpecialValueFor( "smash_stun_duration" )
	self.smash_distance = self:GetAbility():GetSpecialValueFor( "smash_distance_from_hero" )

    self.buff_duration = self:GetAbility():GetSpecialValueFor( "duration" )
	self.selfstun = self:GetAbility():GetSpecialValueFor( "self_stun_duration" )
	self.attacks = self:GetAbility():GetSpecialValueFor( "total_attacks" )
	self.speed = self:GetAbility():GetSpecialValueFor( "movement_speed" )

	self.tree_radius = 100
	self.arc_height = 90
	self.arc_duration = 0.4

	if not IsServer() then return end

    local bonus_kills = 0
    local modifier_dawnbreaker_3_buff = self.parent:FindModifierByName("modifier_dawnbreaker_3_buff")
    if modifier_dawnbreaker_3_buff then
        bonus_kills = modifier_dawnbreaker_3_buff:GetStackCount()
    end

    if self.parent:HasModifier("modifier_dawnbreaker_3") then
        self.swipe_radius = self.swipe_radius + self:GetAbility().modifier_dawnbreaker_3[self.parent:GetTalentLevel("modifier_dawnbreaker_3")]
        self.swipe_radius = self.swipe_radius + (self:GetAbility().modifier_dawnbreaker_3_kills * bonus_kills)
    end
    
    if self.parent:HasModifier("modifier_dawnbreaker_3") then
        self.smash_radius = self.smash_radius + self:GetAbility().modifier_dawnbreaker_3[self.parent:GetTalentLevel("modifier_dawnbreaker_3")]
        self.smash_radius = self.smash_radius + (self:GetAbility().modifier_dawnbreaker_3_kills * bonus_kills)
    end

    self.orders = 
    {
        [DOTA_UNIT_ORDER_MOVE_TO_POSITION] = true,
        [DOTA_UNIT_ORDER_MOVE_TO_TARGET] = true,
        [DOTA_UNIT_ORDER_ATTACK_MOVE] = true,
        [DOTA_UNIT_ORDER_ATTACK_TARGET] = true,
        [DOTA_UNIT_ORDER_PICKUP_ITEM] = true,
        [DOTA_UNIT_ORDER_PICKUP_RUNE] = true,
    }
    if self:GetCaster():HasModifier("modifier_dawnbreaker_6") then
        self.modifier_dawnbreaker_fire_wreath_custom_immune = self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_dawnbreaker_fire_wreath_custom_immune", {})
    end
	self.forward = Vector( kv.x, kv.y, 0 )
	self.bonus = 0
	self.ctr = 0
	local interval = self.buff_duration / (self.attacks-1)
    self.ctr_interval = self.buff_duration / (self.attacks-1)
    self.current_interval = self.buff_duration / (self.attacks-1)
	self:ApplyHorizontalMotionController()
	self:StartIntervalThink(FrameTime())
	self:OnIntervalThink()
end

function modifier_dawnbreaker_fire_wreath_custom:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveHorizontalMotionController( self )
    if self.modifier_dawnbreaker_fire_wreath_custom_immune and not self.modifier_dawnbreaker_fire_wreath_custom_immune:IsNull() then
        self.modifier_dawnbreaker_fire_wreath_custom_immune:Destroy()
    end
end

function modifier_dawnbreaker_fire_wreath_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_SUPPRESS_CLEAVE,
        MODIFIER_PROPERTY_DISABLE_TURNING,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN,
	}
end

function modifier_dawnbreaker_fire_wreath_custom:GetModifierMoveSpeed_AbsoluteMin()
    if self:GetCaster():HasModifier("modifier_dawnbreaker_6") and IsClient() then
        return self:GetAbility().modifier_dawnbreaker_6_min_speed
    end
end

function modifier_dawnbreaker_fire_wreath_custom:GetModifierMoveSpeedBonus_Percentage()
    if self:GetCaster():HasModifier("modifier_dawnbreaker_6") and IsClient() then
        return self:GetAbility().modifier_dawnbreaker_6_slow * -1
    end
end

function modifier_dawnbreaker_fire_wreath_custom:GetModifierDisableTurning()
    return 1
end

function modifier_dawnbreaker_fire_wreath_custom:GetModifierPreAttack_BonusDamage()
	if not IsServer() then return 0 end
	return self.bonus
end

function modifier_dawnbreaker_fire_wreath_custom:GetSuppressCleave()
	return 1
end

function modifier_dawnbreaker_fire_wreath_custom:CheckState()
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_IGNORING_STOP_ORDERS] = true,
    }
end

function modifier_dawnbreaker_fire_wreath_custom:OnIntervalThink()
    if not IsServer() then return end
    self.current_interval = self.current_interval + FrameTime()
    if self.parent:IsTaunted() or self.parent:IsStunned() then
        self:Destroy()
        return
    end
    if self.current_interval >= self.ctr_interval then
        self.ctr = self.ctr + 1
        if self.ctr == 1 then
            self:GetParent():StartGesture(ACT_DOTA_OVERRIDE_ABILITY_1)
        end
        if self.ctr >= self.attacks then
            self:Smash()
            self:Destroy()
        else
            self:Swipe()
        end
        self.current_interval = 0
    end
    self:ApplyHorizontalMotionController()
end

function modifier_dawnbreaker_fire_wreath_custom:Swipe()
	local enemies = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetOrigin(), nil, self.swipe_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false)
	for _,enemy in pairs(enemies) do
		self.bonus = self.swipe_damage
		self.parent:PerformAttack( enemy, true, true, true, true, false, false, true )
		if not enemy:IsMagicImmune() then
			enemy:AddNewModifier( self.parent, self:GetAbility(), "modifier_dawnbreaker_fire_wreath_custom_slow", { duration = self.swipe_duration * (1 - enemy:GetStatusResistance()) })
		end
	end

	if #enemies>0 then
		local mod1 = self.parent:FindModifierByName( "modifier_dawnbreaker_luminosity_custom" )
		local mod2 = self.parent:FindModifierByName( "modifier_dawnbreaker_luminosity_custom_buff" )
		if mod2 then
			mod2:Destroy()
		elseif mod1 then
			mod1:Increment()
		end
	end

	self:PlayEffects1()
	self:PlayEffects2()
end

function modifier_dawnbreaker_fire_wreath_custom:Smash()
	local center = self.parent:GetOrigin() + self.forward*self.smash_distance
	local enemies = FindUnitsInRadius( self.parent:GetTeamNumber(), center, nil, self.smash_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	for _,enemy in pairs(enemies) do
		self.bonus = self.smash_damage
		self.parent:PerformAttack( enemy, true, true, true, true, false, false, true )
		if not enemy:IsMagicImmune() then
			enemy:AddNewModifier(self.parent,self:GetAbility(),"modifier_stunned",{ duration = self.smash_duration * (1 - enemy:GetStatusResistance()) })
			enemy:AddNewModifier(self.parent,self:GetAbility(),"modifier_generic_arc_lua",{ duration = self.arc_duration * (1 - enemy:GetStatusResistance()), height = self.arc_height, activity = ACT_DOTA_FLAIL })
		end
	end

	self.parent:AddNewModifier( self.parent, self:GetAbility(), "modifier_stunned", { duration = self.selfstun })

	if #enemies>0 then
		local mod1 = self.parent:FindModifierByName( "modifier_dawnbreaker_luminosity_custom" )
		local mod2 = self.parent:FindModifierByName( "modifier_dawnbreaker_luminosity_custom_buff" )
		if mod2 then
			mod2:Destroy()
		elseif mod1 then
			mod1:Increment()
		end
	end

    if self:GetCaster():HasModifier("modifier_dawnbreaker_7") then
        local dawnbreaker_solar_guardian_custom = self:GetCaster():FindAbilityByName("dawnbreaker_solar_guardian_custom")
        if dawnbreaker_solar_guardian_custom and dawnbreaker_solar_guardian_custom:GetLevel() > 0 then
            dawnbreaker_solar_guardian_custom:LandDamage(center)
        end
    end

	self:PlayEffects3( center )
end

function modifier_dawnbreaker_fire_wreath_custom:UpdateHorizontalMotion( me, dt )
    local speed = self.speed
    if self:GetCaster():HasModifier("modifier_dawnbreaker_6") then
        speed = math.max(self:GetCaster():GetIdealSpeed() - (self:GetCaster():GetIdealSpeed() / 100 * self:GetAbility().modifier_dawnbreaker_6_slow), self:GetAbility().modifier_dawnbreaker_6_min_speed)
    end
    local direction = self.forward
    if self.new_direction_forward then
        direction = self.new_direction_forward
    end

	local pos = me:GetOrigin() + direction * speed * dt
	if not GridNav:IsTraversable( pos ) then return end
	GridNav:DestroyTreesAroundPoint( me:GetOrigin(), self.tree_radius, true )
	pos = GetGroundPosition( pos, me )
	me:SetOrigin( pos )
end

function modifier_dawnbreaker_fire_wreath_custom:OnOrder(params)
    if params.unit ~= self:GetParent() then return end
    if not self.orders[params.order_type] then return end
    if not self:GetParent():HasModifier("modifier_dawnbreaker_6") then return end
    if params.target then
        params.new_pos = params.target:GetOrigin()
    end
    local new_direction = params.new_pos - self:GetParent():GetAbsOrigin()
    new_direction.z = 0
    local length = new_direction:Length2D()
    if length < 1 then return end
    new_direction = new_direction:Normalized()
    self.new_direction_forward = new_direction
end

function modifier_dawnbreaker_fire_wreath_custom:PlayEffects1()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dawnbreaker/dawnbreaker_fire_wreath_sweep_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_dawnbreaker_fire_wreath_custom:PlayEffects2()
	local forward = RotatePosition( Vector(0,0,0), QAngle( 0, -120, 0 ), self.forward )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dawnbreaker/dawnbreaker_fire_wreath_sweep.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true)
    ParticleManager:SetParticleControl(effect_cast, 6, Vector(self.swipe_radius/1.2, 0, 0))
	ParticleManager:SetParticleControlForward( effect_cast, 0, forward )
	self:AddParticle( effect_cast, false, false, -1, false, false)
	self.parent:EmitSound("Hero_Dawnbreaker.Fire_Wreath.Sweep")
end

function modifier_dawnbreaker_fire_wreath_custom:PlayEffects3( center )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dawnbreaker/dawnbreaker_fire_wreath_smash.vpcf", PATTACH_WORLDORIGIN, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 0, center )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self.parent:EmitSound("Hero_Dawnbreaker.Fire_Wreath.Smash")
end

modifier_dawnbreaker_fire_wreath_custom_slow = class({})

function modifier_dawnbreaker_fire_wreath_custom_slow:OnCreated( kv )
	self.slow = self:GetAbility():GetSpecialValueFor( "swipe_slow" )
end

function modifier_dawnbreaker_fire_wreath_custom_slow:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_dawnbreaker_fire_wreath_custom_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

modifier_dawnbreaker_fire_wreath_custom_immune = class({})

function modifier_dawnbreaker_fire_wreath_custom_immune:IsPurgable() return false end

function modifier_dawnbreaker_fire_wreath_custom_immune:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_dawnbreaker_fire_wreath_custom_immune:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_dawnbreaker_fire_wreath_custom_immune:CheckState()
    return
    {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true,
    }
end

function modifier_dawnbreaker_fire_wreath_custom_immune:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
    }
end

function modifier_dawnbreaker_fire_wreath_custom_immune:GetModifierMagicalResistanceBonus()
    return self:GetAbility().modifier_dawnbreaker_6_resistance[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_6")]
end

function modifier_dawnbreaker_fire_wreath_custom_immune:GetStatusEffectName()
    return "particles/status_fx/status_effect_avatar.vpcf"
end

function modifier_dawnbreaker_fire_wreath_custom_immune:StatusEffectPriority()
    return 99999
end