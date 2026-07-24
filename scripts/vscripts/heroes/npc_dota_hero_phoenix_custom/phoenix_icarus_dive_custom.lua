--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_phoenix_icarus_dive_custom_dash_dummy", "heroes/npc_dota_hero_phoenix_custom/phoenix_icarus_dive_custom", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_phoenix_icarus_dive_custom_extend_burn", "heroes/npc_dota_hero_phoenix_custom/phoenix_icarus_dive_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phoenix_icarus_dive_custom_slow_debuff", "heroes/npc_dota_hero_phoenix_custom/phoenix_icarus_dive_custom", LUA_MODIFIER_MOTION_NONE)

phoenix_icarus_dive_custom = class({})
phoenix_icarus_dive_custom.modifier_phoenix_8 = {-8,-13}
phoenix_icarus_dive_custom.modifier_phoenix_8_agility = 300
phoenix_icarus_dive_custom.modifier_phoenix_8_agility_cooldown = -5
phoenix_icarus_dive_custom.modifier_phoenix_9 = {150,225,300}
phoenix_icarus_dive_custom.modifier_phoenix_10 = {-8,-16}
phoenix_icarus_dive_custom.modifier_phoenix_13 = {20,40}

function phoenix_icarus_dive_custom:OnAbilityPhaseStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	return true
end

function phoenix_icarus_dive_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_phoenix_8") then
        bonus = self.modifier_phoenix_8[self:GetCaster():GetTalentLevel("modifier_phoenix_8")]
        if self:GetCaster():GetAgility() >= self.modifier_phoenix_8_agility then
            bonus = bonus + self.modifier_phoenix_8_agility_cooldown
        end
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function phoenix_icarus_dive_custom:GetHealthCost(level)
    if self:GetCaster():HasModifier("modifier_phoenix_8") then return end
    local hp_cost_perc = self:GetSpecialValueFor("hp_cost_perc")
    return self:GetCaster():GetHealth() / 100 * hp_cost_perc
end

function phoenix_icarus_dive_custom:OnSpellStart()
	if not IsServer() then return end
    self:GetCaster():StartGesture(ACT_DOTA_OVERRIDE_ABILITY_1)
    local point = self:GetCursorPosition()
    if point == self:GetCaster():GetAbsOrigin() then
        point = point + self:GetCaster():GetForwardVector()
    end
    
    local dash_length = self:GetSpecialValueFor("dash_length")
    local dash_width = self:GetSpecialValueFor("dash_width")
    local hit_radius = self:GetSpecialValueFor("hit_radius")
    local burn_duration = self:GetSpecialValueFor("burn_duration")
    local dive_duration = self:GetSpecialValueFor("dive_duration")

    local pfx = ParticleManager:CreateParticle( "particles/units/heroes/hero_phoenix/phoenix_icarus_dive.vpcf", PATTACH_WORLDORIGIN, nil )

	local direction = (point - self:GetCaster():GetAbsOrigin()):Normalized()
	self:GetCaster():SetForwardVector(direction)

    local modifier_phoenix_icarus_dive_custom_dash_dummy = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_phoenix_icarus_dive_custom_dash_dummy", {duration = dive_duration})
    modifier_phoenix_icarus_dive_custom_dash_dummy:AddParticle(pfx, false, false, -1, false, false)

	local casterOrigin = self:GetCaster():GetAbsOrigin()
	local casterAngles = self:GetCaster():GetAngles()
	local forwardDir = self:GetCaster():GetForwardVector()
	local rightDir = self:GetCaster():GetRightVector()
	local ellipseCenter	= casterOrigin + forwardDir * ( dash_length / 2 )
	local startTime = GameRules:GetGameTime()

	self:GetCaster():SetContextThink(DoUniqueString("updateIcarusDive"), function()
		ParticleManager:SetParticleControl(pfx, 0, self:GetCaster():GetAbsOrigin() + self:GetCaster():GetRightVector() * 32 )
		local elapsedTime = GameRules:GetGameTime() - startTime
		local progress = elapsedTime / dive_duration
		self.progress = progress

		--if imba_phoenix_check_for_canceled( caster ) then
		--	caster:RemoveModifierByName("modifier_phoenix_icarus_dive_custom_dash_dummy")
		--end

		if not modifier_phoenix_icarus_dive_custom_dash_dummy or modifier_phoenix_icarus_dive_custom_dash_dummy:IsNull() then
			return
		end

		local theta = -2 * math.pi * progress
		local x =  math.sin( theta ) * dash_width * 0.5
		local y = -math.cos( theta ) * dash_length * 0.5

		local pos = ellipseCenter + rightDir * x + forwardDir * y
		local yaw = casterAngles.y + 90 + progress * -360

		pos = GetGroundPosition( pos, self:GetCaster() )
		self:GetCaster():SetOrigin( pos )
		self:GetCaster():SetAbsAngles( casterAngles.x, yaw, casterAngles.z )

		GridNav:DestroyTreesAroundPoint(pos, 80, false)

        local phoenix_sun_ray_custom = self:GetCaster():FindAbilityByName("phoenix_sun_ray_custom")
        if self:GetCaster():HasModifier("modifier_phoenix_sun_ray_custom_caster_dummy") and phoenix_sun_ray_custom and phoenix_sun_ray_custom.pfx then
            local pathLength = phoenix_sun_ray_custom:GetCastRange(self:GetCaster():GetAbsOrigin(), self:GetCaster())
            local endcapPos = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * pathLength
            endcapPos = GetGroundPosition( endcapPos, nil )
            endcapPos.z = endcapPos.z + 92
            ParticleManager:SetParticleControl( phoenix_sun_ray_custom.pfx, 1, endcapPos )
        end

		local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, hit_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)

		for _,enemy in pairs(enemies) do
			enemy:AddNewModifier(self:GetCaster(), self, "modifier_phoenix_icarus_dive_custom_slow_debuff", {duration = burn_duration * (1 - enemy:GetStatusResistance())} )
		end

		return 0.03
	end, 0 )
end

modifier_phoenix_icarus_dive_custom_dash_dummy = class({})
function modifier_phoenix_icarus_dive_custom_dash_dummy:IsHidden() return true  end
function modifier_phoenix_icarus_dive_custom_dash_dummy:IsPurgable() return false end
function modifier_phoenix_icarus_dive_custom_dash_dummy:IsPurgeException() return false end
function modifier_phoenix_icarus_dive_custom_dash_dummy:GetEffectName() return "particles/units/heroes/hero_phoenix/phoenix_supernova_radiance_streak_light.vpcf" end

function modifier_phoenix_icarus_dive_custom_dash_dummy:DeclareFunctions()
	return
    {
        MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
    }
end

function modifier_phoenix_icarus_dive_custom_dash_dummy:GetModifierAttackSpeedBonus_Constant()
    if self:GetParent():HasModifier("modifier_phoenix_9") then
        return self:GetAbility().modifier_phoenix_9[self:GetParent():GetTalentLevel("modifier_phoenix_9")]
    end
end

function modifier_phoenix_icarus_dive_custom_dash_dummy:GetModifierAttackRangeBonus()
    if self:GetParent():HasModifier("modifier_phoenix_9") then
        return self:GetAbility().modifier_phoenix_9[self:GetParent():GetTalentLevel("modifier_phoenix_9")]
    end
end

function modifier_phoenix_icarus_dive_custom_dash_dummy:GetModifierIncomingDamage_Percentage()
    if self:GetParent():HasModifier("modifier_phoenix_10") then
        return self:GetAbility().modifier_phoenix_10[self:GetParent():GetTalentLevel("modifier_phoenix_10")]
    end
end

function modifier_phoenix_icarus_dive_custom_dash_dummy:GetModifierIgnoreCastAngle() 
    return 360 
end

function modifier_phoenix_icarus_dive_custom_dash_dummy:OnCreated()
	if not IsServer() then return end
	EmitSoundOn("Hero_Phoenix.IcarusDive.Cast", self:GetCaster())
    local phoenix_icarus_dive_stop_custom = self:GetCaster():FindAbilityByName("phoenix_icarus_dive_stop_custom")
    if phoenix_icarus_dive_stop_custom then
        phoenix_icarus_dive_stop_custom:SetLevel(self:GetAbility():GetLevel())
    end
    self:GetCaster():SwapAbilities("phoenix_icarus_dive_custom", "phoenix_icarus_dive_stop_custom", false, true)
    local phoenix_sun_ray_custom = self:GetCaster():FindAbilityByName("phoenix_sun_ray_custom")
    if phoenix_sun_ray_custom then
        phoenix_sun_ray_custom:SetActivated(false)
    end
    if not self:ApplyHorizontalMotionController() then
        self:Destroy()
    end
end

function modifier_phoenix_icarus_dive_custom_dash_dummy:OnHorizontalMotionInterrupted()
    if IsServer() then
        self.interrupted = true
        self:Destroy()
    end
end

function modifier_phoenix_icarus_dive_custom_dash_dummy:OnDestroy()
	if not IsServer() then return end
    self:GetCaster():SwapAbilities("phoenix_icarus_dive_stop_custom", "phoenix_icarus_dive_custom", false, true)
	StopSoundOn("Hero_Phoenix.IcarusDive.Cast", self:GetCaster())
	EmitSoundOn("Hero_Phoenix.IcarusDive.Stop", self:GetCaster())
	self:GetCaster():RemoveGesture(ACT_DOTA_OVERRIDE_ABILITY_1)
    FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
    local phoenix_sun_ray_custom = self:GetCaster():FindAbilityByName("phoenix_sun_ray_custom")
    if phoenix_sun_ray_custom then
        phoenix_sun_ray_custom:SetActivated(true)
    end
end

modifier_phoenix_icarus_dive_custom_slow_debuff = class({})

function modifier_phoenix_icarus_dive_custom_slow_debuff:OnCreated()
    self.damage_per_second = self:GetAbility():GetSpecialValueFor("damage_per_second")
    self.burn_tick_interval = self:GetAbility():GetSpecialValueFor("burn_tick_interval")
    self.slow_movement_speed_pct = self:GetAbility():GetSpecialValueFor("slow_movement_speed_pct")
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_phoenix_13") then
        self.damage_per_second = self.damage_per_second + (self:GetCaster():GetAgility() / 100 * self:GetAbility().modifier_phoenix_13[self:GetCaster():GetTalentLevel("modifier_phoenix_13")])
    end
    self:StartIntervalThink( self.burn_tick_interval )
end

function modifier_phoenix_icarus_dive_custom_slow_debuff:DeclareFunctions()
	return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_phoenix_icarus_dive_custom_slow_debuff:GetEffectName() return "particles/units/heroes/hero_phoenix/phoenix_icarus_dive_burn_debuff.vpcf" end
function modifier_phoenix_icarus_dive_custom_slow_debuff:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end
function modifier_phoenix_icarus_dive_custom_slow_debuff:GetModifierMoveSpeedBonus_Percentage()	return self.slow_movement_speed_pct end

function modifier_phoenix_icarus_dive_custom_slow_debuff:OnIntervalThink()
	if not IsServer() then return end
	ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = self.damage_per_second * self.burn_tick_interval, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
end

phoenix_icarus_dive_stop_custom = class({})

function phoenix_icarus_dive_stop_custom:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():RemoveModifierByName("modifier_phoenix_icarus_dive_custom_dash_dummy")
end

function phoenix_icarus_dive_stop_custom:GetCastAnimation()
	return ACT_DOTA_CAST_ABILITY_1
end