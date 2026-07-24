--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_invoker_tornado_lua = class({})

function modifier_invoker_tornado_lua:IsHidden()
    return false
end

function modifier_invoker_tornado_lua:IsDebuff()
    return true
end

function modifier_invoker_tornado_lua:IsStunDebuff()
    return true
end

function modifier_invoker_tornado_lua:IsPurgable()
    return true
end

function modifier_invoker_tornado_lua:IsStunDebuff()
    return true
end

function modifier_invoker_tornado_lua:IsMotionController()
    return true
end

function modifier_invoker_tornado_lua:GetMotionControllerPriority()
    return DOTA_MOTION_CONTROLLER_PRIORITY_HIGH
end

function modifier_invoker_tornado_lua:GetEffectName()
	return "particles/units/heroes/hero_invoker/invoker_tornado_child.vpcf"
end

function modifier_invoker_tornado_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_invoker_tornado_lua:OnCreated(kv)
    self:StartIntervalThink(FrameTime())
    local sound_lift = "Hero_Invoker.Tornado.Target"
    EmitSoundOn(sound_lift, self:GetParent())
    if IsServer() then
    	self:GetParent():Purge(true, false, false, false, false)
        local delay = 1
        self:GetParent():StartGesture(ACT_DOTA_FLAIL)
        self.angle = self:GetParent():GetAngles()
        self.abs = self:GetParent():GetAbsOrigin()
        self.cyc_pos = self:GetParent():GetAbsOrigin()
    end
end

function modifier_invoker_tornado_lua:OnIntervalThink()
    if not self:CheckMotionControllers() then
        self:Destroy()
        return
    end
    self:HorizontalMotion(self:GetParent(), FrameTime())
end

function modifier_invoker_tornado_lua:OnDestroy()
    local sound_lift = "Hero_Invoker.Tornado.Target"
    StopSoundOn(sound_lift, self:GetParent())
    if not IsServer() then return end
    local sound_land = "Hero_Invoker.Tornado.LandDamage"
    EmitSoundOn(sound_land, self:GetParent())
    self:GetParent():FadeGesture(ACT_DOTA_FLAIL)
    self:GetParent():SetAbsOrigin(self.abs)
    ResolveNPCPositions(self:GetParent():GetAbsOrigin(), 128)
    self:GetParent():SetAngles(self.angle[1], self.angle[2], self.angle[3])
    if self:GetCaster() and self:GetAbility() then
	    local damageTable = { victim = self:GetParent(),
	    attacker = self:GetCaster(),
	    damage = self:GetAbility():GetSpecialValueFor("base_damage"),
	    damage_type = self:GetAbility():GetAbilityDamageType(),
	    ability = self:GetAbility() }
	    ApplyDamage(damageTable)
	end
end

function modifier_invoker_tornado_lua:CheckState()
    local state =    
    {
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
    return state
end

function modifier_invoker_tornado_lua:HorizontalMotion(unit, time)
    if not IsServer() then return end
    local angle = self:GetParent():GetAngles()
    local new_angle = RotateOrientation(angle, QAngle(0, 20, 0))
    self:GetParent():SetAngles(new_angle[1], new_angle[2], new_angle[3])
    if self:GetElapsedTime() <= 0.3 then
        self.cyc_pos.z = self.cyc_pos.z + 50
        self:GetParent():SetAbsOrigin(self.cyc_pos)
    elseif self:GetDuration() - self:GetElapsedTime() < 0.3 then
        self.step = self.step or (self.cyc_pos.z - self.abs.z) / ((self:GetDuration() - self:GetElapsedTime()) / FrameTime())
        self.cyc_pos.z = self.cyc_pos.z - self.step
        self:GetParent():SetAbsOrigin(self.cyc_pos)
    else -- Random move -- 此处不用while循环就写一次 while 循环导致游戏崩溃
        local pos = GetRandomPosition2D(self:GetParent():GetAbsOrigin(), 5)
        if (pos - self.abs):Length2D() < 50  then
        	self:GetParent():SetAbsOrigin(pos)
        end
    end
end

function modifier_invoker_tornado_lua:CheckMotionControllers()
    if not IsServer() then
       return 
    end
	local parent = self:GetParent()
	local modifier_priority = self:GetMotionControllerPriority()
	local is_motion_controller = false
	local motion_controller_priority
	local found_modifier_handler
	local non_motion_controllers =
	{"modifier_brewmaster_storm_cyclone",
	 "modifier_dark_seer_vacuum",
	 "modifier_eul_cyclone",
	 "modifier_earth_spirit_rolling_boulder_caster",
	 "modifier_huskar_life_break_charge",
	 "modifier_invoker_tornado",
	 "modifier_item_forcestaff_active",
	 "modifier_rattletrap_hookshot",
	 "modifier_phoenix_icarus_dive",
	 "modifier_shredder_timber_chain",
	 "modifier_slark_pounce",
	 "modifier_spirit_breaker_charge_of_darkness",
	 "modifier_tusk_walrus_punch_air_time",
	 "modifier_earthshaker_enchant_totem_leap"}
	

	-- Fetch all modifiers
	local modifiers = parent:FindAllModifiers()	

	for _,modifier in pairs(modifiers) do		
		-- Ignore the modifier that is using this function
		if self ~= modifier then			

			-- Check if this modifier is assigned as a motion controller
			if modifier.IsMotionController then
				if modifier:IsMotionController() then
					-- Get its handle
					found_modifier_handler = modifier

					is_motion_controller = true

					-- Get the motion controller priority
					motion_controller_priority = modifier:GetMotionControllerPriority()

					-- Stop iteration					
					break
				end
			end

			-- If not, check on the list
			for _,non_imba_motion_controller in pairs(non_motion_controllers) do				
				if modifier:GetName() == non_imba_motion_controller then
					-- Get its handle
					found_modifier_handler = modifier

					is_motion_controller = true

					-- We assume that vanilla controllers are the highest priority
					motion_controller_priority = DOTA_MOTION_CONTROLLER_PRIORITY_HIGHEST

					-- Stop iteration					
					break
				end
			end
		end
	end

	-- If this is a motion controller, check its priority level
	if is_motion_controller and motion_controller_priority then

		-- If the priority of the modifier that was found is higher, override
		if motion_controller_priority > modifier_priority then			
			return false

		-- If they have the same priority levels, check which of them is older and remove it
		elseif motion_controller_priority == modifier_priority then			
			if found_modifier_handler:GetCreationTime() >= self:GetCreationTime() then				
				return false
			else				
				found_modifier_handler:Destroy()
				return true
			end

		-- If the modifier that was found is a lower priority, destroy it instead
		else			
			parent:InterruptMotionControllers(true)
			found_modifier_handler:Destroy()
			return true
		end
	else
		-- If no motion controllers were found, apply
		return true
	end
end

function GetRandomPosition2D(point, distance)
    return point + RandomVector(distance)
end