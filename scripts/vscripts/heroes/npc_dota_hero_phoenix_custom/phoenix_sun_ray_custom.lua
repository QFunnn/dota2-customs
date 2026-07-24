--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_phoenix_sun_ray_custom_caster_dummy", "heroes/npc_dota_hero_phoenix_custom/phoenix_sun_ray_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phoenix_sun_ray_custom_dummy_unit_thinker", "heroes/npc_dota_hero_phoenix_custom/phoenix_sun_ray_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phoenix_sun_ray_custom_dummy_buff", "heroes/npc_dota_hero_phoenix_custom/phoenix_sun_ray_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phoenix_sun_ray_custom_buff", "heroes/npc_dota_hero_phoenix_custom/phoenix_sun_ray_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phoenix_sun_ray_custom_debuff", "heroes/npc_dota_hero_phoenix_custom/phoenix_sun_ray_custom", LUA_MODIFIER_MOTION_NONE)

phoenix_sun_ray_custom = class({})
phoenix_sun_ray_custom.modifier_phoenix_3 = {-4,-8,-12}

function phoenix_sun_ray_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_phoenix_3") then
        bonus = self.modifier_phoenix_3[self:GetCaster():GetTalentLevel("modifier_phoenix_3")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function phoenix_sun_ray_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_phoenix.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_phoenix.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_phoenix.vpcf", context)
end

function phoenix_sun_ray_custom:OnSpellStart()
    if not IsServer() then return end
	local point = self:GetCursorPosition()
    if point == self:GetCaster():GetAbsOrigin() then
        point = point + self:GetCaster():GetForwardVector()
    end
    self.point = point

    local caster = self:GetCaster()
	local pathLength = self:GetCastRange(self:GetCaster():GetAbsOrigin(), self:GetCaster()) + self:GetCaster():GetCastRangeBonus()
	local max_duration = self:GetDuration()
	local forwardMoveSpeed = self:GetSpecialValueFor("forward_move_speed")
	local turnRateInitial = self:GetSpecialValueFor("turn_rate_initial")
	local turnRate = self:GetSpecialValueFor("turn_rate")
	local initialTurnDuration = 0.5
	local vision_radius = self:GetSpecialValueFor("radius") / 2
    local radius = self:GetSpecialValueFor("radius")
    local tick_interval = self:GetSpecialValueFor("tick_interval")
	local numVision = math.ceil( pathLength / vision_radius )

	local casterOrigin = self:GetCaster():GetAbsOrigin()
	local modifier_phoenix_sun_ray_custom_caster_dummy = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_phoenix_sun_ray_custom_caster_dummy", {duration = max_duration})

	self:GetCaster().sun_ray_is_moving = false
	self:GetCaster().sun_ray_hp_at_start = self:GetCaster():GetHealth()


    turnRateInitial	= turnRateInitial / (1/30) * 0.03
    self.deltaYawMax = turnRateInitial

	local pfx = ParticleManager:CreateParticle( "particles/units/heroes/hero_phoenix/phoenix_sunray.vpcf", PATTACH_CUSTOMORIGIN, nil )
    ParticleManager:SetParticleControlEnt( pfx, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_head", self:GetCaster():GetAbsOrigin(), true )
    ParticleManager:SetParticleControlEnt( pfx, 9, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_head", self:GetCaster():GetAbsOrigin(), true )
    self.pfx = pfx
    modifier_phoenix_sun_ray_custom_caster_dummy:AddParticle(pfx, true, false, -1, false, false)

	local attach_point = caster:ScriptLookupAttachment( "attach_head" )
	StartSoundEvent("Hero_Phoenix.SunRay.Beam", self:GetCaster() )
	StartSoundEvent("Hero_Phoenix.SunRay.Cast", self:GetCaster())

	turnRate = turnRate	/ (1/30) * 0.03

	local lastAngles = caster:GetAngles()
	local isInitialTurn = true
	local elapsedTime = 0.0    

	caster:SetContextThink( DoUniqueString( "updateSunRay" ), function ( )
        local timer = FrameTime()
        if not modifier_phoenix_sun_ray_custom_caster_dummy or modifier_phoenix_sun_ray_custom_caster_dummy:IsNull() then
            StopSoundEvent( "Hero_Phoenix.SunRay.Beam", self:GetCaster() )
            return
        end

        local pos = caster:GetAbsOrigin()
        GridNav:DestroyTreesAroundPoint(pos, 128, false)

        local deltaYawMax
        if isInitialTurn then
            deltaYawMax = turnRateInitial
        else
            deltaYawMax = turnRate
        end

        self.deltaYawMax = deltaYawMax

        local currentAngles	= caster:GetAngles()
        local deltaYaw = RotationDelta( lastAngles, currentAngles ).y
        local deltaYawAbs = math.abs( deltaYaw )
        if self:GetCaster():HasModifier("modifier_phoenix_icarus_dive_custom_dash_dummy") then
            lastAngles = self:GetCaster():GetAngles()
        end

        -- if deltaYawAbs > deltaYawMax then
        --     local yawSign = (deltaYaw < 0) and -1 or 1
        --     local yaw = lastAngles.y + deltaYawMax * yawSign
        --     currentAngles.y = yaw
        --     if not self:GetCaster():HasModifier("modifier_phoenix_icarus_dive_custom_dash_dummy") then
        --         caster:SetAngles( currentAngles.x, currentAngles.y, currentAngles.z )
        --     end
        -- end

        lastAngles = currentAngles

        elapsedTime = elapsedTime + FrameTime()

        if isInitialTurn then
            if deltaYawAbs == 0 then
                isInitialTurn = false
            end
            if elapsedTime >= initialTurnDuration then
                isInitialTurn = false
            end
        end

        local casterOrigin	= caster:GetAbsOrigin()
        local casterForward	= caster:GetForwardVector()

        if caster.sun_ray_is_moving and not GameRules:IsGamePaused() and not self:GetCaster():HasModifier("modifier_phoenix_supernova_custom_buff") then
            casterOrigin = casterOrigin + casterForward * forwardMoveSpeed * FrameTime()
            casterOrigin = GetGroundPosition( casterOrigin, caster )
            if not self:GetCaster():HasModifier("modifier_phoenix_icarus_dive_custom_dash_dummy") then
                caster:SetAbsOrigin( casterOrigin )
            end
        end

        local endcapPos = casterOrigin + casterForward * pathLength
        endcapPos = GetGroundPosition( endcapPos, nil )
        endcapPos.z = endcapPos.z + 92

        if not self:GetCaster():HasModifier("modifier_phoenix_icarus_dive_custom_dash_dummy") then
            ParticleManager:SetParticleControl( pfx, 1, endcapPos )
        end

        local units = FindUnitsInLine(caster:GetTeamNumber(), caster:GetAbsOrigin() + caster:GetForwardVector() * 32 , endcapPos, nil, radius, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE)
        for _,unit in pairs(units) do
            unit:AddNewModifier(caster, self, "modifier_phoenix_sun_ray_custom_dummy_buff", { duration = tick_interval } )
        end

        for i=1, numVision do
            AddFOWViewer(caster:GetTeamNumber(), ( casterOrigin + casterForward * ( vision_radius * 2 * (i-1) ) ), vision_radius, FrameTime(), false)
        end

        return FrameTime()
	end, 0.0 )
end

modifier_phoenix_sun_ray_custom_caster_dummy = class({})
function modifier_phoenix_sun_ray_custom_caster_dummy:IsPurgable() return false end
function modifier_phoenix_sun_ray_custom_caster_dummy:IsPurgeException() return false end
function modifier_phoenix_sun_ray_custom_caster_dummy:CheckState()
	return
    { 
        [MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
    }
end

function modifier_phoenix_sun_ray_custom_caster_dummy:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
        MODIFIER_PROPERTY_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
        MODIFIER_PROPERTY_DISABLE_TURNING,
    }
end

function modifier_phoenix_sun_ray_custom_caster_dummy:GetModifierIgnoreCastAngle()
    return 1
end

function modifier_phoenix_sun_ray_custom_caster_dummy:GetModifierMoveSpeed_Absolute()
    return 0.001 -- любое маленькое фиксированное значение
end

function modifier_phoenix_sun_ray_custom_caster_dummy:GetModifierMoveSpeed_Limit()
    return 0.001 -- чтобы не мог разогнаться с haste
end


function modifier_phoenix_sun_ray_custom_caster_dummy:GetEffectName()
	return "particles/units/heroes/hero_phoenix/phoenix_sunray_mane.vpcf"
end
function modifier_phoenix_sun_ray_custom_caster_dummy:OnCreated()
	if not IsServer() then return end
    self.parent = self:GetParent()
	self:GetCaster():StartGesture(ACT_DOTA_OVERRIDE_ABILITY_3)
	StartSoundEvent("Hero_Phoenix.SunRay.Loop", self:GetCaster())
    self.tick_interval = self:GetAbility():GetSpecialValueFor("tick_interval")
	self.pfx_sunray_flare = ParticleManager:CreateParticle( "particles/units/heroes/hero_phoenix/phoenix_sunray_flare.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( self.pfx_sunray_flare, 9, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_mouth", self:GetCaster():GetAbsOrigin(), true )
    self:AddParticle(self.pfx_sunray_flare, false, false, -1, false, false)
	self:GetCaster():SwapAbilities( "phoenix_sun_ray_custom", "phoenix_sun_ray_stop_custom", false, true )
	self:GetCaster().sun_ray_is_moving = false
    local phoenix_sun_ray_stop_custom = self:GetCaster():FindAbilityByName("phoenix_sun_ray_stop_custom")
    if phoenix_sun_ray_stop_custom then
        phoenix_sun_ray_stop_custom:SetLevel(self:GetAbility():GetLevel())
    end
	local toggle_move = self:GetCaster():FindAbilityByName("phoenix_sun_ray_toggle_move_custom")
	if toggle_move then
        toggle_move:SetLevel(1)
		toggle_move:SetActivated(true)
	end
    self.turn_rate = self:GetAbility().deltaYawMax or 225
    self.turn_speed = FrameTime()*self.turn_rate
    self.current_dir = self:GetCaster():GetForwardVector()
    self:SetDirection( Vector(self:GetAbility().point.x, self:GetAbility().point.y, 0) ) 
	self:StartIntervalThink(0.01)
end

function modifier_phoenix_sun_ray_custom_caster_dummy:OnIntervalThink()
    if not IsServer() then return end
    self.tick_interval = self.tick_interval - 0.01
    if self.tick_interval <= 0 then
        self.tick_interval = self:GetAbility():GetSpecialValueFor("tick_interval")
	    self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_phoenix_sun_ray_custom_dummy_unit_thinker", { duration = self.tick_interval * 1.9 })
    end
    self.turn_rate = self:GetAbility().deltaYawMax
    self.turn_speed = 0.01*self.turn_rate
    self:TurnLogic()
    local endcapPos = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * self:GetAbility():GetCastRange(self:GetCaster():GetAbsOrigin(), self:GetCaster())
    endcapPos = GetGroundPosition( endcapPos, nil )
    endcapPos.z = endcapPos.z + 92
    ParticleManager:SetParticleControl(self:GetAbility().pfx, 1, endcapPos )
    if not self.parent:HasModifier("modifier_phoenix_supernova_custom_buff") then
        if self.parent:IsStunned() or self.parent:IsHexed() or self.parent:IsSilenced() then
            self:Destroy()
        end
    end
end

function modifier_phoenix_sun_ray_custom_caster_dummy:OnDestroy()
	if not IsServer() then return end
	self:GetCaster():RemoveGesture(ACT_DOTA_OVERRIDE_ABILITY_3)
	StartSoundEvent("Hero_Phoenix.SunRay.Stop", self:GetCaster())
	StopSoundEvent( "Hero_Phoenix.SunRay.Loop", self:GetCaster())
	self:GetCaster().sun_ray_is_moving = false
	local toggle_move = self:GetCaster():FindAbilityByName("phoenix_sun_ray_toggle_move_custom")
	if toggle_move then
		toggle_move:SetActivated(false)
	end
	self:GetCaster():SwapAbilities( "phoenix_sun_ray_stop_custom", "phoenix_sun_ray_custom", false, true )
	FindClearSpaceForUnit(self:GetCaster(), self:GetCaster():GetAbsOrigin() , false)
end

function modifier_phoenix_sun_ray_custom_caster_dummy:OnOrder( params )
    if params.unit~=self:GetParent() then return end
    if  params.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION or
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

function modifier_phoenix_sun_ray_custom_caster_dummy:GetModifierDisableTurning()
    return 1
end

function modifier_phoenix_sun_ray_custom_caster_dummy:SetDirection( vec )
    if vec.x == self:GetCaster():GetAbsOrigin().x and vec.y == self:GetCaster():GetAbsOrigin().y then 
        vec = self:GetCaster():GetAbsOrigin() + 100*self:GetCaster():GetForwardVector()
    end
    self.target_dir = ((vec-self.parent:GetOrigin())*Vector(1,1,0)):Normalized()
    self.face_target = false
end

function modifier_phoenix_sun_ray_custom_caster_dummy:TurnLogic()
    if self:GetCaster():HasModifier("modifier_phoenix_icarus_dive_custom_dash_dummy") then
        self.current_dir = self:GetCaster():GetForwardVector()
        return 
    end
    if self.face_target then return end
    local current_angle = VectorToAngles( self.current_dir ).y
    local target_angle = VectorToAngles( self.target_dir ).y
    local angle_diff = AngleDiff( current_angle, target_angle )
    local sign = -1
    if angle_diff<0 then sign = 1 end
    if math.abs( angle_diff ) < 1.1 * self.turn_speed then
        self.current_dir = self.target_dir
        self.face_target = true
    else
        self.current_dir = RotatePosition( Vector(0,0,0), QAngle(0, sign*self.turn_speed, 0), self.current_dir )
    end
    local a = self.parent:IsCurrentlyHorizontalMotionControlled()
    local b = self.parent:IsCurrentlyVerticalMotionControlled()
    if not (a or b) then
        self.parent:SetForwardVector( self.current_dir )
    end
end

modifier_phoenix_sun_ray_custom_dummy_unit_thinker = class({})
function modifier_phoenix_sun_ray_custom_dummy_unit_thinker:IsHidden() return true end
function modifier_phoenix_sun_ray_custom_dummy_unit_thinker:IsPurgable() return false end
function modifier_phoenix_sun_ray_custom_dummy_unit_thinker:IsPurgeException() return false end
function modifier_phoenix_sun_ray_custom_dummy_unit_thinker:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end
function modifier_phoenix_sun_ray_custom_dummy_unit_thinker:OnRefresh()
	if not IsServer() then return end
	self:IncrementStackCount()
end

modifier_phoenix_sun_ray_custom_dummy_buff = class({})
function modifier_phoenix_sun_ray_custom_dummy_buff:IsDebuff() return false end
function modifier_phoenix_sun_ray_custom_dummy_buff:IsHidden() return true end
function modifier_phoenix_sun_ray_custom_dummy_buff:IsPurgable() return false end
function modifier_phoenix_sun_ray_custom_dummy_buff:IsPurgeException() return false end
function modifier_phoenix_sun_ray_custom_dummy_buff:OnCreated()
	self.tick_interval = self:GetAbility():GetSpecialValueFor("tick_interval")
	if not IsServer() then return end
	self:StartIntervalThink( self.tick_interval )
end
function modifier_phoenix_sun_ray_custom_dummy_buff:OnIntervalThink()
	if not IsServer() then return end
	if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
        if self:GetCaster():HasModifier("modifier_phoenix_6") then
            self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_phoenix_dying_light_custom_debuff", { duration = self.tick_interval * 1.9 * (1 - self:GetParent():GetStatusResistance()) } )
        end
		self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_phoenix_sun_ray_custom_debuff", { duration = self.tick_interval * 1.9 * (1 - self:GetParent():GetStatusResistance()) } )
	else
		self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_phoenix_sun_ray_custom_buff", { duration = self.tick_interval * 1.9 } )
	end
end

modifier_phoenix_sun_ray_custom_debuff = class({})
function modifier_phoenix_sun_ray_custom_debuff:IsHidden() return true end
function modifier_phoenix_sun_ray_custom_debuff:IsPurgable() return false end
function modifier_phoenix_sun_ray_custom_debuff:IsPurgeException() return false end
function modifier_phoenix_sun_ray_custom_debuff:GetEffectName() return "particles/units/heroes/hero_phoenix/phoenix_sunray_debuff.vpcf" end

function modifier_phoenix_sun_ray_custom_debuff:OnCreated()
	self.tick_interval = self:GetAbility():GetSpecialValueFor("tick_interval")
	self.base_damage = self:GetAbility():GetSpecialValueFor("base_damage")
	self.hp_perc_damage	= self:GetAbility():GetSpecialValueFor("hp_perc_damage") / 100
	if not IsServer() then return end
	self.duration = self:GetAbility():GetDuration()
	local ability = self:GetAbility()
	self:StartIntervalThink( self.tick_interval )
end

function modifier_phoenix_sun_ray_custom_debuff:OnIntervalThink()
	if not IsServer() then return end
	local ability = self:GetAbility()
	local caster = self:GetCaster()
	if not caster:HasModifier("modifier_phoenix_sun_ray_custom_dummy_unit_thinker") then return end
	local num_stack = caster:FindModifierByName("modifier_phoenix_sun_ray_custom_dummy_unit_thinker"):GetStackCount()
    local tick_sum = math.floor(self.duration / self.tick_interval)
    if self:GetCaster():HasModifier("modifier_phoenix_3") then
        num_stack = tick_sum-1
    end
	local taker = self:GetParent()
	local taker_health = taker:GetMaxHealth()
	local base_dmg = self.base_damage
	local total_damage_base = (base_dmg * self.tick_interval) + ((base_dmg / tick_sum * self.tick_interval) * num_stack)
    local total_damage_perc = (taker_health * self.hp_perc_damage * self.tick_interval) + ((taker_health * self.hp_perc_damage / tick_sum * self.tick_interval) * num_stack)
	local damageTable = { victim = taker, attacker = self:GetCaster(), damage = total_damage_base + total_damage_perc, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()}
    ApplyDamage(damageTable)
	local pfx = ParticleManager:CreateParticle( "particles/units/heroes/hero_phoenix/phoenix_sunray_debuff.vpcf", PATTACH_ABSORIGIN, taker )
	ParticleManager:SetParticleControlEnt( pfx, 1, taker, PATTACH_POINT_FOLLOW, "attach_hitloc", taker:GetAbsOrigin(), true )
	ParticleManager:DestroyParticle( pfx, false )
	ParticleManager:ReleaseParticleIndex( pfx )
end

modifier_phoenix_sun_ray_custom_buff = class({})
function modifier_phoenix_sun_ray_custom_buff:IsDebuff() return false end
function modifier_phoenix_sun_ray_custom_buff:IsHidden() return true end
function modifier_phoenix_sun_ray_custom_buff:IsPurgable() return false end
function modifier_phoenix_sun_ray_custom_buff:IsPurgeException() return false end
function modifier_phoenix_sun_ray_custom_buff:GetEffectName() return "particles/units/heroes/hero_phoenix/phoenix_sunray_beam_friend.vpcf" end

function modifier_phoenix_sun_ray_custom_buff:OnCreated()
	self.tick_interval = self:GetAbility():GetSpecialValueFor("tick_interval")
	self.base_heal = self:GetAbility():GetSpecialValueFor("base_heal")
	self.hp_perc_heal = self:GetAbility():GetSpecialValueFor("hp_perc_heal") / 100
	self.explode_min_time = self:GetAbility():GetSpecialValueFor("explode_min_time")
	self.explode_dmg = self:GetAbility():GetSpecialValueFor("explode_dmg")
	self.explode_radius	= self:GetAbility():GetSpecialValueFor("explode_radius")
	self.hp_cost_perc_per_second = self:GetAbility():GetSpecialValueFor("hp_cost_perc_per_second")
	if not IsServer() then return end
    self.duration = self:GetAbility():GetDuration()
	if self:GetStackCount() < 1 then
		self:SetStackCount(1)
	end
	local ability = self:GetAbility()
	self:StartIntervalThink( self.tick_interval )
end

function modifier_phoenix_sun_ray_custom_buff:OnRefresh()
	if not IsServer() then return end
	self:IncrementStackCount()
end

function modifier_phoenix_sun_ray_custom_buff:OnIntervalThink()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not caster:HasModifier("modifier_phoenix_sun_ray_custom_dummy_unit_thinker") then return end
	local num_stack = caster:FindModifierByName("modifier_phoenix_sun_ray_custom_dummy_unit_thinker"):GetStackCount()
	local taker = self:GetParent()
    local tick_sum = math.floor(self.duration / self.tick_interval)
    if self:GetCaster():HasModifier("modifier_phoenix_3") then
        num_stack = tick_sum-1
    end
    local taker_health = taker:GetMaxHealth()
	local base_dmg = self.base_heal
	local total_damage_base = (base_dmg * self.tick_interval) + ((base_dmg / tick_sum * self.tick_interval) * num_stack)
    local total_damage_perc = (taker_health * self.hp_perc_heal * self.tick_interval) + ((taker_health * self.hp_perc_heal / tick_sum * self.tick_interval) * num_stack)
    local total_heal = total_damage_base + total_damage_perc
	if taker ~= self:GetCaster() then
		taker:Heal(total_heal, self:GetCaster())
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, taker, total_heal, nil)
		local pfx = ParticleManager:CreateParticle( "particles/units/heroes/hero_phoenix/phoenix_sunray_beam_friend.vpcf", PATTACH_ABSORIGIN, taker )
		ParticleManager:SetParticleControlEnt( pfx, 1, taker, PATTACH_POINT_FOLLOW, "attach_hitloc", taker:GetAbsOrigin(), true )
		ParticleManager:ReleaseParticleIndex( pfx )
	else
		local heal_cost_pct = self.hp_cost_perc_per_second / 100
		local tick_per_sec = 1 / self.tick_interval
		local heal_cost_per_tick = heal_cost_pct / tick_per_sec
		local heal_cost_this_time = caster:GetHealth() * heal_cost_per_tick
		caster:SetHealth( math.max(caster:GetHealth() - heal_cost_this_time, 1) )
	end
end

phoenix_sun_ray_stop_custom = class({})
function phoenix_sun_ray_stop_custom:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():RemoveModifierByName("modifier_phoenix_sun_ray_custom_caster_dummy")
end

phoenix_sun_ray_toggle_move_custom = class({})

function phoenix_sun_ray_toggle_move_custom:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
end

function phoenix_sun_ray_toggle_move_custom:Spawn()
    if not IsServer() then return end
    self:SetHidden(false)
end

function phoenix_sun_ray_toggle_move_custom:OnSpellStart()
	if not IsServer() then return end
	if self:GetCaster().sun_ray_is_moving then
		self:GetCaster().sun_ray_is_moving = false
	else
		self:GetCaster().sun_ray_is_moving = true
	end
end