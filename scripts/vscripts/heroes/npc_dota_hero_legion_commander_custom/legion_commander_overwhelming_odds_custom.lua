--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_legion_commander_overwhelming_odds_custom_buff", "heroes/npc_dota_hero_legion_commander_custom/legion_commander_overwhelming_odds_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_legion_commander_overwhelming_odds_custom_debuff", "heroes/npc_dota_hero_legion_commander_custom/legion_commander_overwhelming_odds_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_legion_commander_overwhelming_odds_custom_barrier", "heroes/npc_dota_hero_legion_commander_custom/legion_commander_overwhelming_odds_custom", LUA_MODIFIER_MOTION_NONE)

legion_commander_overwhelming_odds_custom = class({})

function legion_commander_overwhelming_odds_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_commander_odds_cast.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_commander_odds.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_commander_odds_dmga.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_commander_odds_buff.vpcf", context )
end

legion_commander_overwhelming_odds_custom.modifier_legion_commander_9 = {300,400,500}
legion_commander_overwhelming_odds_custom.modifier_legion_commander_10 = {-2.5,-5,-7.5}
legion_commander_overwhelming_odds_custom.modifier_legion_commander_14 = 4
legion_commander_overwhelming_odds_custom.modifier_legion_commander_13 = {30,45,60}
legion_commander_overwhelming_odds_custom.modifier_legion_commander_13_duration = 6

function legion_commander_overwhelming_odds_custom:GetAOERadius() 
	return self:GetSpecialValueFor("radius") 
end

function legion_commander_overwhelming_odds_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_legion_commander_10") then
	    bonus = self.modifier_legion_commander_10[self:GetCaster():GetTalentLevel("modifier_legion_commander_10")]
	end
	return self.BaseClass.GetCooldown( self, level ) + bonus
end

function legion_commander_overwhelming_odds_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_legion_commander_duel_custom") then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
	end
	if self:GetCaster():HasModifier("modifier_legion_commander_14") then
		return DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
	end
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end

function legion_commander_overwhelming_odds_custom:GetCastRange(location, target)
	if self:GetCaster():HasModifier("modifier_legion_commander_14") then
		return 999999
	end
	return self.BaseClass.GetCastRange(self, location, target)
end

function legion_commander_overwhelming_odds_custom:OnAbilityPhaseStart()
	if not IsServer() then return end
    self.cast = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_odds_cast.vpcf", PATTACH_CUSTOMORIGIN, self:GetCaster())
    ParticleManager:SetParticleControlEnt( self.cast, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), true )
	self:GetCaster():EmitSound("Hero_LegionCommander.Overwhelming.Cast")
	return true 
end

function legion_commander_overwhelming_odds_custom:OnAbilityPhaseInterrupted()
	if not IsServer() then return end
	ParticleManager:DestroyParticle(self.cast, false)
    ParticleManager:ReleaseParticleIndex(self.cast)
end

function legion_commander_overwhelming_odds_custom:OnSpellStart( point_new, check )
	if not IsServer() then return end

	local point = self:GetCaster():GetAbsOrigin()

	if self:GetCaster():HasModifier("modifier_legion_commander_14") and not self:GetCaster():HasModifier("modifier_legion_commander_duel_custom") then
		point = self:GetCursorPosition()
	end

	if point_new ~= nil then
		point = point_new
	end

	local damage = self:GetSpecialValueFor("damage")
	local damage_per_unit = self:GetSpecialValueFor("damage_per_unit")
	local damage_per_hero = self:GetSpecialValueFor("damage_per_hero")
	local illusion_dmg_pct = self:GetSpecialValueFor("illusion_dmg_pct")
	local bonus_speed_creeps = self:GetSpecialValueFor("bonus_speed_creeps")
	local bonus_speed_heroes = self:GetSpecialValueFor("bonus_speed_heroes")
	local duration = self:GetSpecialValueFor("duration")
	local radius = self:GetSpecialValueFor("radius")
    local slow_duration = self:GetSpecialValueFor("slow_duration")

	if self:GetCaster():HasModifier("modifier_legion_commander_14") then
		AddFOWViewer(self:GetCaster():GetTeamNumber(), point, radius, 3, false)
	end

	EmitSoundOnLocationWithCaster(point, "Hero_LegionCommander.Overwhelming.Location", self:GetCaster())

	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_legion_commander/legion_commander_odds.vpcf", PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( particle, 0, point )
    ParticleManager:SetParticleControl( particle, 1, self:GetCaster():GetAbsOrigin() )
    ParticleManager:SetParticleControl( particle, 2, point )
    ParticleManager:SetParticleControl( particle, 3, point )
    ParticleManager:SetParticleControl( particle, 4, Vector( radius, radius, radius ) )
    ParticleManager:SetParticleControl( particle, 6, point )
    ParticleManager:ReleaseParticleIndex( particle )

	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_DAMAGE_FLAG_NONE, FIND_ANY_ORDER, false)
	local enemies_creeps = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_DAMAGE_FLAG_NONE, FIND_ANY_ORDER, false)
	local enemies_heroes = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_DAMAGE_FLAG_NONE, FIND_ANY_ORDER, false)

	local damage_type = DAMAGE_TYPE_MAGICAL

	if self:GetCaster():HasModifier("modifier_legion_commander_9") then
		damage_type = DAMAGE_TYPE_PHYSICAL
		damage = damage + (self:GetCaster():GetPhysicalArmorValue(false) / 100 * self.modifier_legion_commander_9[self:GetCaster():GetTalentLevel("modifier_legion_commander_9")])
	end

	local full_damage = damage + (#enemies_creeps * damage_per_unit) + (#enemies_heroes * damage_per_hero)
    local heroes_damage_to_barrier = 0
    
	for _,enemy in ipairs(enemies) do 

		enemy:EmitSound("Hero_LegionCommander.Overwhelming.Creep")

		local particle_peffect = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_odds_dmga.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
		ParticleManager:SetParticleControlEnt(particle_peffect , 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(particle_peffect , 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
    	ParticleManager:SetParticleControl(particle_peffect, 3, self:GetCaster():GetAbsOrigin())
    	ParticleManager:ReleaseParticleIndex(particle_peffect)

        enemy:AddNewModifier(self:GetCaster(), self, "modifier_legion_commander_overwhelming_odds_custom_debuff", {duration = slow_duration * (1 - enemy:GetStatusResistance())})

		if enemy:IsIllusion() then 
			ApplyDamage({victim = enemy, damage = full_damage + (enemy:GetMaxHealth() / 100 * illusion_dmg_pct), damage_type = damage_type, attacker = self:GetCaster(), ability = self})
		else
			local end_damage_line = ApplyDamage({victim = enemy, damage = full_damage, damage_type = damage_type, attacker = self:GetCaster(), ability = self})
            heroes_damage_to_barrier = heroes_damage_to_barrier + end_damage_line
		end

		if self:GetCaster():HasModifier("modifier_legion_commander_11") then
			self:GetCaster():PerformAttack(enemy, true, true, true, true, false, false, true)
		end
	end

	local buff = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_legion_commander_overwhelming_odds_custom_buff", {duration = duration})

    if self:GetCaster():HasModifier("modifier_legion_commander_13") then
        local shield_duration = self.modifier_legion_commander_13_duration
        if heroes_damage_to_barrier > 0 then
            local barrier = heroes_damage_to_barrier / 100 * self.modifier_legion_commander_13[self:GetCaster():GetTalentLevel("modifier_legion_commander_13")]
            self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_legion_commander_overwhelming_odds_custom_barrier", {duration = shield_duration, barrier = barrier})
        end
    end

	if check == nil then
		if self:GetCaster():HasModifier("modifier_legion_commander_14") then
			Timers:CreateTimer(self.modifier_legion_commander_14, function()
				self:OnSpellStart( point, true )
			end)
		end
	end
end

modifier_legion_commander_overwhelming_odds_custom_buff = class({})

function modifier_legion_commander_overwhelming_odds_custom_buff:IsHidden() return false end
function modifier_legion_commander_overwhelming_odds_custom_buff:IsPurgable() return true end

function modifier_legion_commander_overwhelming_odds_custom_buff:OnCreated(table)
	if not IsServer() then return end
	self.poof = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_odds_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(self.poof, 0, self:GetParent():GetAbsOrigin())
	self:AddParticle(self.poof, false, false, -1, false, false)
end

function modifier_legion_commander_overwhelming_odds_custom_buff:DeclareFunctions()
	return
	{
	 	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	 	MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
end

function modifier_legion_commander_overwhelming_odds_custom_buff:GetModifierAttackSpeedBonus_Constant() 
	return self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end

function modifier_legion_commander_overwhelming_odds_custom_buff:GetActivityTranslationModifiers() 
	return "overwhelmingodds" 
end

modifier_legion_commander_overwhelming_odds_custom_debuff = class({})

function modifier_legion_commander_overwhelming_odds_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_legion_commander_overwhelming_odds_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movement_slow")
end

modifier_legion_commander_overwhelming_odds_custom_barrier = class({})

function modifier_legion_commander_overwhelming_odds_custom_barrier:OnCreated(params)
    if not IsServer() then return end
    self.max_shield = params.barrier
    self.shield = params.barrier
    self:SetHasCustomTransmitterData(true)
end

function modifier_legion_commander_overwhelming_odds_custom_barrier:AddCustomTransmitterData() 
    return 
    { 
        shield = self.shield,
        max_shield = self.max_shield,
    }
end

function modifier_legion_commander_overwhelming_odds_custom_barrier:HandleCustomTransmitterData(data)
    self.shield = data.shield
    self.max_shield = data.max_shield
end

function modifier_legion_commander_overwhelming_odds_custom_barrier:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
    }
end

function modifier_legion_commander_overwhelming_odds_custom_barrier:GetModifierIncomingDamageConstant(params)
    if IsClient() then 
        if params.report_max then 
            return self.max_shield
        else 
            return self.shield
        end
    end
    if not IsServer() then return end
    local damage = math.min(params.damage, self.shield)
    self.shield = math.max(0, self.shield - damage)
    if self.shield <= 0 then
        self:Destroy()
    end
    self:SendBuffRefreshToClients()
    return -damage
end