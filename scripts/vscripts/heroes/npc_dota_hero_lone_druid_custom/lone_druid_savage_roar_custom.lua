--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lone_druid_savage_roar_custom", "heroes/npc_dota_hero_lone_druid_custom/lone_druid_savage_roar_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lone_druid_savage_roar_custom_lone_druid_13", "heroes/npc_dota_hero_lone_druid_custom/lone_druid_savage_roar_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lone_druid_savage_roar_custom_lone_druid_15_thinker", "heroes/npc_dota_hero_lone_druid_custom/lone_druid_savage_roar_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lone_druid_savage_roar_custom_lone_druid_15", "heroes/npc_dota_hero_lone_druid_custom/lone_druid_savage_roar_custom", LUA_MODIFIER_MOTION_NONE)

lone_druid_savage_roar_custom = class({})

function lone_druid_savage_roar_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_lone_druid/lone_druid_savage_roar.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_lone_druid/lone_druid_savage_roar_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_treant/treant_bramble_root.vpcf", context )
end

lone_druid_savage_roar_custom.modifier_lone_druid_12_cooldown = {-4,-8}

lone_druid_savage_roar_custom.modifier_lone_druid_13_mv = {10,20}
lone_druid_savage_roar_custom.modifier_lone_druid_13_at = {25,50}
lone_druid_savage_roar_custom.modifier_lone_druid_13_duration = 3
lone_druid_savage_roar_custom.modifier_lone_druid_14_damage = {100,150,200}
lone_druid_savage_roar_custom.modifier_lone_druid_15_duration = 12
lone_druid_savage_roar_custom.modifier_lone_druid_15_movespeeed = -25
lone_druid_savage_roar_custom.modifier_lone_druid_15_agility_damage = 60

function lone_druid_savage_roar_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_lone_druid_11") then
		return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
	end
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function lone_druid_savage_roar_custom:GetCastRange(vLocation, hTarget)
	if self:GetCaster():HasModifier("modifier_lone_druid_11") then
		return 600
	end
end

function lone_druid_savage_roar_custom:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function lone_druid_savage_roar_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_lone_druid_12") then
		bonus = self.modifier_lone_druid_12_cooldown[self:GetCaster():GetTalentLevel("modifier_lone_druid_12")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function lone_druid_savage_roar_custom:OnSpellStart(check)
	if not IsServer() then return end
	local radius = self:GetSpecialValueFor("radius")
    local duration = self:GetSpecialValueFor("duration")
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_lone_druid_13") then
    	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_lone_druid_savage_roar_custom_lone_druid_13", {duration = self.modifier_lone_druid_13_duration})
    end
    local point = self:GetCaster():GetAbsOrigin()
    self:StartSpell(point, true)
    if self:GetCaster():HasModifier("modifier_lone_druid_11") then
        point = self:GetCursorPosition()
        if self:GetCaster():IsRealHero() and check == nil then
            if not self:GetCaster():IsRooted() then
	    	    FindClearSpaceForUnit(self:GetCaster(), point, true)
            end
	    end
    end
    self:StartSpell(point)
    if check == nil then
	    if self:GetCaster():IsHero() then
	    	local ability = self:GetCaster():FindAbilityByName("lone_druid_spirit_bear_custom")
		    for _, unit in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED, FIND_ANY_ORDER, false)) do
		        if unit:GetUnitName() == "npc_dota_lone_druid_bear_custom" and unit ~= self:GetCaster() then
					local ability_cast = unit:FindAbilityByName("lone_druid_savage_roar_custom")
		    		if ability_cast then
		    			ability_cast:UseResources(false, false, false, true)
		    			ability_cast:OnSpellStart(true)
		    		end         
		        end
		    end
	    else
	    	local modifier = self:GetCaster():FindModifierByName("modifier_lone_druid_spirit_bear_custom")
	    	if modifier and modifier:GetCaster() then
	    		local ability_cast = modifier:GetCaster():FindAbilityByName("lone_druid_savage_roar_custom")
	    		if ability_cast then
	    			ability_cast:UseResources(false, false, false, true)
	    			ability_cast:OnSpellStart(true)
	    		end
	    		for _, unit in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED, FIND_ANY_ORDER, false)) do
			        if unit:GetUnitName() == "npc_dota_lone_druid_bear_custom" and unit ~= self:GetCaster() then
						local ability_cast = unit:FindAbilityByName("lone_druid_savage_roar_custom")
			    		if ability_cast then
			    			ability_cast:UseResources(false, false, false, true)
			    			ability_cast:OnSpellStart(true)
			    		end         
			        end
			    end
	    	end
	    end
	end
end

function lone_druid_savage_roar_custom:StartSpell(point, is_world)
    local radius = self:GetSpecialValueFor("radius")
    local duration = self:GetSpecialValueFor("duration")

    -- Визуал
    if is_world then
        EmitSoundOnLocationWithCaster(point, "Hero_LoneDruid.SavageRoar.Cast", self:GetCaster())
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lone_druid/lone_druid_savage_roar.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(particle, 0, point)
        ParticleManager:ReleaseParticleIndex(particle)
    else
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lone_druid/lone_druid_savage_roar.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
        ParticleManager:SetParticleControl(particle, 0, point)
        ParticleManager:ReleaseParticleIndex(particle)
        self:GetCaster():EmitSound("Hero_LoneDruid.SavageRoar.Cast")
    end

    -- Создание корней
    if self:GetCaster():HasModifier("modifier_lone_druid_15") then
    	for i = 0, 6 do
            local angle = math.rad(360 / 6 * i)
            local offset = Vector(math.cos(angle), math.sin(angle), 0) * (radius - 150)
            CreateModifierThinker(self:GetCaster(), self, "modifier_lone_druid_savage_roar_custom_lone_druid_15_thinker", {duration = self.modifier_lone_druid_15_duration}, point + offset, self:GetCaster():GetTeamNumber(), false)
        end
    end

    -- Страх и урон от 14
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
    for _,enemy in pairs(enemies) do
        enemy:AddNewModifier(self:GetCaster(), self, "modifier_lone_druid_savage_roar_custom", {duration = duration * (1 - enemy:GetStatusResistance())}) 
        if self:GetCaster():HasModifier("modifier_lone_druid_14") then
	    	local damage = self:GetCaster():GetAgility() / 100 * self.modifier_lone_druid_14_damage[self:GetCaster():GetTalentLevel("modifier_lone_druid_14")]
	    	ApplyDamage({victim = enemy, attacker = self:GetCaster(), damage = damage, ability = self, damage_type = DAMAGE_TYPE_MAGICAL})
	    end
    end
end

modifier_lone_druid_savage_roar_custom = class({})

function modifier_lone_druid_savage_roar_custom:OnCreated()
	if not IsServer() then return end
	local pos = (self:GetParent():GetAbsOrigin() - self:GetCaster():GetAbsOrigin())
	pos.z = 0
	pos = pos:Normalized()

	self.position = self:GetParent():GetAbsOrigin() + pos * 3000

	if not self:GetParent():IsHero() then
		self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_disarmed", {duration = 0.1})
		self:GetParent():SetAggroTarget(nil)
	end

    if self:GetParent():IsDebuffImmune() then return end
	self:GetParent():MoveToPosition( self.position )
    self:StartIntervalThink(0.1)
end

function modifier_lone_druid_savage_roar_custom:OnIntervalThink()
	if not IsServer() then return end
    if self:GetParent():IsDebuffImmune() then return end
	self:GetParent():MoveToPosition( self.position )
end

function modifier_lone_druid_savage_roar_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_lone_druid_savage_roar_custom:GetModifierMoveSpeedBonus_Percentage()
	if self:GetParent():HasModifier("modifier_lone_druid_savage_roar_custom_lone_druid_15") then return 0 end
	return self:GetAbility():GetSpecialValueFor("bonus_speed")
end

function modifier_lone_druid_savage_roar_custom:GetEffectName()
    return "particles/units/heroes/hero_lone_druid/lone_druid_savage_roar_debuff.vpcf"
end

function modifier_lone_druid_savage_roar_custom:StatusEffectPriority()
    return 10
end

function modifier_lone_druid_savage_roar_custom:GetStatusEffectName()
    return "particles/status_fx/status_effect_lone_druid_savage_roar.vpcf"
end

function modifier_lone_druid_savage_roar_custom:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_lone_druid_savage_roar_custom:CheckState()
    if self:GetParent():IsDebuffImmune() then return end
    local state = 
    {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_FEARED] = true,
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_SILENCED] = true,
    }
    return state
end

function modifier_lone_druid_savage_roar_custom:OnDestroy()
    if not IsServer() then return end
    if self:GetParent():IsDebuffImmune() then return end
    self:GetParent():Stop()
end


modifier_lone_druid_savage_roar_custom_lone_druid_13 = class({})

function modifier_lone_druid_savage_roar_custom_lone_druid_13:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_lone_druid_savage_roar_custom_lone_druid_13:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility().modifier_lone_druid_13_mv[self:GetCaster():GetTalentLevel("modifier_lone_druid_13")]
end

function modifier_lone_druid_savage_roar_custom_lone_druid_13:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility().modifier_lone_druid_13_at[self:GetCaster():GetTalentLevel("modifier_lone_druid_13")]
end

modifier_lone_druid_savage_roar_custom_lone_druid_15_thinker = class({})

function modifier_lone_druid_savage_roar_custom_lone_druid_15_thinker:OnCreated()
	if not IsServer() then return end
	local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_treant/treant_bramble_root.vpcf", PATTACH_ABSORIGIN, self:GetParent())
	ParticleManager:SetParticleControl(iParticleID, 0, self:GetParent():GetAbsOrigin())
	self:AddParticle(iParticleID, false, false, -1, false, false)
end

function modifier_lone_druid_savage_roar_custom_lone_druid_15_thinker:IsAura()
	return true
end

function modifier_lone_druid_savage_roar_custom_lone_druid_15_thinker:GetModifierAura()
    return "modifier_lone_druid_savage_roar_custom_lone_druid_15"
end

function modifier_lone_druid_savage_roar_custom_lone_druid_15_thinker:GetAuraRadius()
    return 110
end

function modifier_lone_druid_savage_roar_custom_lone_druid_15_thinker:GetAuraDuration()
    return 0.1
end

function modifier_lone_druid_savage_roar_custom_lone_druid_15_thinker:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_lone_druid_savage_roar_custom_lone_druid_15_thinker:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_lone_druid_savage_roar_custom_lone_druid_15 = class({})

function modifier_lone_druid_savage_roar_custom_lone_druid_15:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(0.5)
end

function modifier_lone_druid_savage_roar_custom_lone_druid_15:OnIntervalThink()
	if not IsServer() then return end
	local damage = self:GetCaster():GetAgility() / 100 * self:GetAbility().modifier_lone_druid_15_agility_damage
	ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = damage * 0.5, ability = self:GetAbility(), damage_type = DAMAGE_TYPE_MAGICAL})
end

function modifier_lone_druid_savage_roar_custom_lone_druid_15:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_lone_druid_savage_roar_custom_lone_druid_15:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility().modifier_lone_druid_15_movespeeed
end

function modifier_lone_druid_savage_roar_custom_lone_druid_15:GetTexture() return "lone_druid_15" end