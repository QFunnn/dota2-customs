--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_bounty_hunter_shuriken_toss_custom_dummy", "heroes/npc_dota_hero_bounty_hunter_custom/bounty_hunter_shuriken_toss_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bounty_hunter_track_custom", "heroes/npc_dota_hero_bounty_hunter_custom/bounty_hunter_track_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bounty_hunter_shuriken_toss_debuff", "heroes/npc_dota_hero_bounty_hunter_custom/bounty_hunter_shuriken_toss_custom", LUA_MODIFIER_MOTION_NONE )

bounty_hunter_shuriken_toss_custom = class({})

function bounty_hunter_shuriken_toss_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_bounty_hunter/bounty_hunter_suriken_toss.vpcf', context )
end

bounty_hunter_shuriken_toss_custom.modifier_bounty_hunter_19 = {0.5,1,1.5}
bounty_hunter_shuriken_toss_custom.modifier_bounty_hunter_15_radius = 200
bounty_hunter_shuriken_toss_custom.modifier_bounty_hunter_20 = 1
bounty_hunter_shuriken_toss_custom.modifier_bounty_hunter_20_max = {100,0}
bounty_hunter_shuriken_toss_custom.modifier_bounty_hunter_20_cd = {-1,-2}
bounty_hunter_shuriken_toss_custom.modifier_bounty_hunter_2 = {0,1,2}

function bounty_hunter_shuriken_toss_custom:CastFilterResultTarget( hTarget )
    if not IsServer() then return UF_SUCCESS end
    local nResult = UnitFilter(
        hTarget,
        self:GetAbilityTargetTeam(),
        self:GetAbilityTargetType(),
        self:GetAbilityTargetFlags(),
        self:GetCaster():GetTeamNumber()
    )

    if nResult ~= UF_SUCCESS then
        return nResult
    end

    return UF_SUCCESS
end

function bounty_hunter_shuriken_toss_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_bounty_hunter_20") then
		bonus = self.modifier_bounty_hunter_20_cd[self:GetCaster():GetTalentLevel("modifier_bounty_hunter_20")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function bounty_hunter_shuriken_toss_custom:OnSpellStart(new_target)
	if not IsServer() then return end

	local target = nil

	if new_target == nil then
		target = self:GetCursorTarget()
	else
		target = new_target
	end

	if target == nil then
		local point = self:GetCursorPosition()
		target = CreateUnitByName("npc_dota_companion", point, false, nil, nil, self:GetCaster():GetTeamNumber())
		target:AddNewModifier(self, nil, "modifier_bounty_hunter_shuriken_toss_custom_dummy", {})
	end

	local projectile_speed = self:GetSpecialValueFor("speed")

    local index = DoUniqueString("bounty_hunter_shuriken_toss_custom")
    local new_index = DoUniqueString("bounty_hunter_shuriken_toss_custom_new")

    self[index] = {}
    self[new_index] = {}

    local count = 0

	local shuriken_projectile = 
	{
		Target = target,
		Source = self:GetCaster(),
		Ability = self,
		EffectName = "particles/units/heroes/hero_bounty_hunter/bounty_hunter_suriken_toss.vpcf",
		iMoveSpeed = projectile_speed,
		bDodgeable = true,
		bVisibleToEnemies = true,
		bReplaceExisting = false,
		bProvidesVision = false,
		ExtraData = {index = index, main_shuriken = true, count = count, new_index = new_index}
	}

    self[new_index][target:entindex()] = true

	ProjectileManager:CreateTrackingProjectile(shuriken_projectile)

	self:GetCaster():EmitSound("Hero_BountyHunter.Shuriken")
end


modifier_bounty_hunter_shuriken_toss_custom_dummy = class({})

function modifier_bounty_hunter_shuriken_toss_custom_dummy:IsHidden() return true end
function modifier_bounty_hunter_shuriken_toss_custom_dummy:IsPurgable() return false end

function modifier_bounty_hunter_shuriken_toss_custom_dummy:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}
end

function bounty_hunter_shuriken_toss_custom:StartShuriken(pre_target, target, index, new_index)
	if not IsServer() then return end
	local projectile_speed = self:GetSpecialValueFor("speed")

	local count = 0

	local shuriken_projectile = 
	{
		Target = target,
		Source = pre_target,
		Ability = self,
		EffectName = "particles/units/heroes/hero_bounty_hunter/bounty_hunter_suriken_toss.vpcf",
		iMoveSpeed = projectile_speed,
		bDodgeable = true,
		bVisibleToEnemies = true,
		bReplaceExisting = false,
		bProvidesVision = false,
		ExtraData = {index = index, main_shuriken = true, count = count, new_index = new_index}
	}
    self[new_index][target:entindex()] = true
	ProjectileManager:CreateTrackingProjectile(shuriken_projectile)
end

function bounty_hunter_shuriken_toss_custom:StartCreepShuriken(pre_target, target, index, count, new_index)
	if not IsServer() then return end
	local projectile_speed = self:GetSpecialValueFor("speed")

	local shuriken_projectile = 
	{
		Target = target,
		Source = pre_target,
		Ability = self,
		EffectName = "particles/units/heroes/hero_bounty_hunter/bounty_hunter_suriken_toss.vpcf",
		iMoveSpeed = projectile_speed,
		bDodgeable = true,
		bVisibleToEnemies = true,
		bReplaceExisting = false,
		bProvidesVision = false,
		ExtraData = {index = index, main_shuriken = false, new_index = new_index}
	}

	ProjectileManager:CreateTrackingProjectile(shuriken_projectile)
end

function bounty_hunter_shuriken_toss_custom:OnProjectileHit_ExtraData(target, location, ExtraData)
    if not IsServer() then return end
    if target == nil then return end
    self[ExtraData.index][target:entindex()] = true

    local damage = self:GetSpecialValueFor("bonus_damage")
    local duration = self:GetSpecialValueFor("ministun")
    local slow_duration = self:GetSpecialValueFor("slow_duration")

    if self:GetCaster():HasModifier("modifier_bounty_hunter_19") then
    	slow_duration = (slow_duration + self.modifier_bounty_hunter_19[self:GetCaster():GetTalentLevel("modifier_bounty_hunter_19")]) * (1 - target:GetStatusResistance())
    end

    local bounce_aoe = self:GetSpecialValueFor("bounce_aoe")

    if self:GetCaster():HasModifier("modifier_bounty_hunter_20") then
        local gold_cap = self.modifier_bounty_hunter_20_max[self:GetCaster():GetTalentLevel("modifier_bounty_hunter_20")]
        local player_networth = 0
        if PLAYERS_NETWORTHS[self:GetCaster():GetPlayerOwnerID()] then
            player_networth = PLAYERS_NETWORTHS[self:GetCaster():GetPlayerOwnerID()].networths
        end
        local new_bonus_damage = player_networth / 100 * self.modifier_bounty_hunter_20
        if gold_cap > 0 then
            new_bonus_damage = math.min(new_bonus_damage, gold_cap)
        end
    	damage = damage + new_bonus_damage
    end

    target:EmitSound("Hero_BountyHunter.Shuriken.Impact")

	if target:TriggerSpellAbsorb(self) then
		return nil
	end
    
    if self:GetCaster():HasModifier("modifier_bounty_hunter_2") then
        self:GetCaster():PerformAttack(target, true, true, true, false, false, false, true)
    end

    ApplyDamage({attacker = self:GetCaster(), victim = target, ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})

    target:AddNewModifier(self:GetCaster(), self, "modifier_bounty_hunter_shuriken_toss_debuff", {duration = slow_duration * (1 - target:GetStatusResistance())})

    if ExtraData.main_shuriken ~= 0 then
	    local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, bounce_aoe, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false )


		for _, unit in pairs(units) do
			if unit:HasModifier("modifier_bounty_hunter_track_custom") and self[ExtraData.index][unit:entindex()] == nil then
				self:StartShuriken(target, unit, ExtraData.index, ExtraData.new_index)
				break
			end
		end
	end

	if target:GetUnitName() == "npc_dota_companion" then
		UTIL_Remove(target)
	end
end

function bounty_hunter_shuriken_toss_custom:OnProjectileThink_ExtraData(vLocation, ExtraData)
    if self:GetCaster():HasModifier("modifier_bounty_hunter_15") then
        local radius_bonus = self.modifier_bounty_hunter_15_radius
        local units_bonus = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), vLocation, nil, radius_bonus, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false )
        for _, unit_bonus in pairs(units_bonus) do
            local damage = self:GetSpecialValueFor("bonus_damage")
            if self:GetCaster():HasModifier("modifier_bounty_hunter_20") then
                damage = damage + (self.modifier_bounty_hunter_20 / 100 * math.min(self:GetCaster():GetGold(), self.modifier_bounty_hunter_20_max[self:GetCaster():GetTalentLevel("modifier_bounty_hunter_20")]) )
            end
            if self[ExtraData.new_index][unit_bonus:entindex()] == nil then
                self[ExtraData.new_index][unit_bonus:entindex()] = true
                ApplyDamage({attacker = self:GetCaster(), victim = unit_bonus, ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
            end
        end
    end
end

modifier_bounty_hunter_shuriken_toss_debuff = class({})

function modifier_bounty_hunter_shuriken_toss_debuff:OnCreated()
	self.slow = self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_bounty_hunter_shuriken_toss_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_bounty_hunter_shuriken_toss_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end
