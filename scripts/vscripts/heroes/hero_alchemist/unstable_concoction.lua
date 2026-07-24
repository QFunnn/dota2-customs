--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ability_alchemist_unstable_concoction", "heroes/hero_alchemist/unstable_concoction.lua", LUA_MODIFIER_MOTION_NONE )

if ability_alchemist_unstable_concoction == nil then
	ability_alchemist_unstable_concoction = class({})
end

function ability_alchemist_unstable_concoction:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_projectile.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_projectile_linear.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_timer.vpcf", context)
end

function ability_alchemist_unstable_concoction:OnSpellStart()
	local caster = self:GetCaster()
	local Duration = self:GetSpecialValueFor("brew_explosion")

    caster:AddNewModifier(caster, self, 'modifier_ability_alchemist_unstable_concoction', {duration = Duration})
    caster:EmitSound("Hero_Alchemist.UnstableConcoction.Fuse")

    caster:StartGesture(ACT_DOTA_ALCHEMIST_CONCOCTION)

    local ThrowAbility = caster:FindAbilityByName('ability_alchemist_unstable_concoction_throw')
    if not ThrowAbility then return end
    self:GetCaster():SwapAbilities('ability_alchemist_unstable_concoction', 'ability_alchemist_unstable_concoction_throw', false, true)
    ThrowAbility:SetLevel(self:GetLevel())
end

modifier_ability_alchemist_unstable_concoction = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return true end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
		}
	end,

	GetModifierMoveSpeedBonus_Percentage 		= function(self) return self.MoveSpeed or 0 end,
})


function modifier_ability_alchemist_unstable_concoction:OnCreated(table)
	local ability = self:GetAbility()
	if ability then
		self.MoveSpeed = ability:GetSpecialValueFor("move_speed")
	end

    if not IsServer() then return end

	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_black_king_bar_immune", {duration=self:GetDuration()})

	self:OnIntervalThink()
    self:StartIntervalThink(0.5)
end

function modifier_ability_alchemist_unstable_concoction:OnDestroy()
    if not IsServer() then return end

	local parent = self:GetParent()
	if parent == nil or parent:IsNull() then return end

	local modif = parent:FindModifierByName("modifier_black_king_bar_immune")
	if modif and modif:GetAbility() == self:GetAbility() then
		modif:Destroy()
	end

	local caster = self:GetCaster()
	if caster == nil or caster:IsNull() then return end

	local ability = self:GetAbility()
	if ability == nil or ability:IsNull() then return end
	local Radius = ability:GetSpecialValueFor("radius")
	local MaxStun = ability:GetSpecialValueFor("max_stun")
	local MaxDamage = ability:GetSpecialValueFor("max_damage")

    parent:RemoveGesture(ACT_DOTA_ALCHEMIST_CONCOCTION)
    parent:StopSound("Hero_Alchemist.UnstableConcoction.Fuse")
    if not self.bIsUse then
        parent:EmitSound("Hero_Alchemist.UnstableConcoction.Throw")
        parent:EmitSound("Hero_Alchemist.UnstableConcoction.Stun")

        local ThrowAbility = caster:FindAbilityByName('ability_alchemist_unstable_concoction_throw')

        local enemies = FindUnitsInRadius(
			parent:GetTeamNumber(), 
			parent:GetAbsOrigin(), 
			nil, 
			Radius, 
			ThrowAbility:GetAbilityTargetTeam(), 
			ThrowAbility:GetAbilityTargetType(), 
			ThrowAbility:GetAbilityTargetFlags(), 
			FIND_ANY_ORDER, 
			false
		)
        for _, target in pairs(enemies) do
			target:AddNewModifier(caster, ability, 'modifier_stunned', {duration = MaxStun})

            ApplyDamage({
                victim = target,
                attacker = parent,
                ability = ability,
                damage = MaxDamage,
                damage_type = ability:GetAbilityDamageType(),
            })
        end
        parent:AddNewModifier(caster, ability, 'modifier_stunned', {duration = MaxStun})
        ApplyDamage({
            victim = parent,
            attacker = parent,
            ability = ability,
            damage = MaxDamage,
            damage_type = ability:GetAbilityDamageType()
        })
    end

    local ThrowAbility = caster:FindAbilityByName('ability_alchemist_unstable_concoction_throw')
    if not ThrowAbility then return end

    caster:SwapAbilities('ability_alchemist_unstable_concoction_throw', 'ability_alchemist_unstable_concoction', false, true)
end

function modifier_ability_alchemist_unstable_concoction:OnIntervalThink()
    if not IsServer() then return end

	local parent = self:GetParent()
	if parent == nil or parent:IsNull() then return end

    local timer = specRound(self:GetRemainingTime(), 1)
	if timer > 0 then
		local length = math.symbolsCount(timer)
		local decimal = timer - math.floor(timer)
		local fx = ParticleManager:CreateParticle('particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_timer.vpcf', PATTACH_OVERHEAD_FOLLOW, parent)
		ParticleManager:SetParticleControl(fx, 1, Vector(0,math.floor(timer),decimal + 1 > 1 and 8 or 1))
		ParticleManager:SetParticleControl(fx, 2, Vector(length + (decimal > 0 and 0 or 1),0,0))
		ParticleManager:ReleaseParticleIndex(fx)
	end
end

function specRound(num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end

function math.symbolsCount(num)
	return #(string.gsub(tostring(num),"%p+",''))
end

if ability_alchemist_unstable_concoction_throw == nil then
	ability_alchemist_unstable_concoction_throw = class({})
end

function ability_alchemist_unstable_concoction_throw:GetAOERadius() return self:GetSpecialValueFor("radius") end

function ability_alchemist_unstable_concoction_throw:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	local ProjectileSpeed = 900

	local Damage = 0
	local Stun = 0

	if not target or not target._bStealed then
		local MainModifier = caster:FindModifierByName('modifier_ability_alchemist_unstable_concoction')
		if not MainModifier then return end

		local MainAbility = caster:FindAbilityByName('ability_alchemist_unstable_concoction')
		if not MainAbility then return end

		local MinDamage = MainAbility:GetSpecialValueFor('min_damage')
		local MaxDamage = MainAbility:GetSpecialValueFor('max_damage')
		local MinStun = MainAbility:GetSpecialValueFor('min_stun')
		local MaxStun = MainAbility:GetSpecialValueFor('max_stun')

		local MaxDuration = MainAbility:GetSpecialValueFor("brew_time")
		local RemainingDuration = MainModifier:GetRemainingTime()

		local Pct = (1 - RemainingDuration/MaxDuration)
		Damage = MinDamage + (MaxDamage - MinDamage) * Pct
		Stun = MinStun + (MaxStun - MinStun) * Pct

		MainModifier.bIsUse = true
		MainModifier:Destroy()
	else
		Damage = target._StealedDamage
		Stun = target._StealedStun
	end

    caster:StartGesture(ACT_DOTA_ALCHEMIST_CONCOCTION_THROW)

	if target then
		ProjectileManager:CreateTrackingProjectile({
			Target = target,
			Source = caster,
			Ability = self,
			EffectName = "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_projectile.vpcf",
			iMoveSpeed = ProjectileSpeed,
			vSourceLoc= caster:GetAbsOrigin(),
			bDrawsOnMinimap = false,
			bDodgeable = false,
			bIsAttack = false,
			bVisibleToEnemies = true,
			bReplaceExisting = false,
			bProvidesVision = false,
			ExtraData = {
				damage = Damage,
				stun = Stun,
				is_linear = false,
			}
		})
	else
		ProjectileManager:CreateLinearProjectile({
			Ability = self,
			EffectName = "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_projectile_linear.vpcf",
			vSpawnOrigin = caster:GetAbsOrigin()+Vector(0,0,100),
			fDistance = CalculateDistance(point, caster:GetAbsOrigin()),
			fStartRadius = 0,
			fEndRadius = 0,
			Source = caster,
			bHasFrontalCone = false,
			bReplaceExisting = false,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
			iUnitTargetType = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			fExpireTime = GameRules:GetGameTime() + 10,
			vVelocity = CalculateDirection(point, caster:GetAbsOrigin()) * ProjectileSpeed,
			bProvidesVision = false,
			bDeleteOnHit = false,
			ExtraData = {
				damage = Damage,
				stun = Stun,
				is_linear = true,
			}
		})
	end
    caster:EmitSound("Hero_Alchemist.UnstableConcoction.Throw")
end

function ability_alchemist_unstable_concoction_throw:OnProjectileHit_ExtraData(hTarget, vLocation, ExtraData)
    if not ExtraData then return end

	local Damage = ExtraData.damage
	local Stun = ExtraData.stun
	local bIsLinear = ExtraData.is_linear
	if Damage == nil or Stun == nil or bIsLinear == nil then return end

	if bIsLinear == 1 and hTarget ~= nil then return end
	if bIsLinear == 0 and hTarget == nil then return end

	if bIsLinear == 0 and hTarget then
		self:GetCaster()._bStealed = true
		self:GetCaster()._StealedDamage = Damage
		self:GetCaster()._StealedStun = Stun
		hTarget:TriggerSpellReflect(self)
		self:GetCaster()._StealedDamage = nil
		self:GetCaster()._StealedStun = nil
		self:GetCaster()._bStealed = nil

		if hTarget:TriggerSpellAbsorb(self) then return end
	end

	local caster = self:GetCaster()

    local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(), 
		vLocation, 
		nil, 
		self:GetSpecialValueFor("radius"),
		self:GetAbilityTargetTeam(),
		self:GetAbilityTargetType(),
		self:GetAbilityTargetFlags(),
		FIND_ANY_ORDER, 
		false
	)

    for _, target in pairs(enemies) do
        ApplyDamage({
            victim = target,
            attacker = caster,
            ability = self,
            damage = Damage,
            damage_type = self:GetAbilityDamageType(),
        })

        target:AddNewModifier(caster, self, 'modifier_stunned', {duration = Stun})
    end

	caster:EmitSound("Hero_Alchemist.UnstableConcoction.Stun")
end