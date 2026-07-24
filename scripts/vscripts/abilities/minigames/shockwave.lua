--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_minigames_warrior_shockwave_pull", "abilities/minigames/shockwave.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_minigames_warrior_shockwave", "abilities/minigames/shockwave.lua", LUA_MODIFIER_MOTION_NONE )

minigames_warrior_shockwave = class({})

function minigames_warrior_shockwave:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_magnataur/magnataur_shockwave.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_magnataur/magnataur_shockwave_hit.vpcf", context)
end

function minigames_warrior_shockwave:OnAbilityPhaseStart()
	if IsServer() then
		self:GetCaster():EmitSound("Minigames.Shockwave.Cast")
		return true
	end
end

function minigames_warrior_shockwave:OnAbilityPhaseInterrupted()
	if IsServer() then
		self:GetCaster():StopSound("Minigames.Shockwave.Cast")
		return true
	end
end

function minigames_warrior_shockwave:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	if target ~= nil then
		point = target:GetAbsOrigin()
	end

	if point == nil then return end

	if point == caster:GetAbsOrigin() then
		point = point + caster:GetForwardVector()
	end

	local Speed = self:GetSpecialValueFor("speed")
	local Width = self:GetSpecialValueFor("width")

	local Direction = CalculateDirection(point, caster)
	Direction.z = 0

	caster:EmitSound("Minigames.Shockwave.Particle")

	local projectile =
	{
		Ability				= self,
		EffectName			= "particles/units/heroes/hero_magnataur/magnataur_shockwave.vpcf",
		vSpawnOrigin		= caster:GetAbsOrigin(),
		fDistance			= self:GetCastRange(caster:GetAbsOrigin(), caster),
		fStartRadius		= Width,
		fEndRadius			= Width,
		Source				= caster,
		bHasFrontalCone		= false,
		bReplaceExisting	= false,
		iUnitTargetTeam		= DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType		= DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		fExpireTime 		= GameRules:GetGameTime() + 5.0,
		bDeleteOnHit		= false,
		vVelocity			= Direction * Speed,
		bProvidesVision		= false,
	}
	ProjectileManager:CreateLinearProjectile(projectile)
end

function minigames_warrior_shockwave:OnProjectileHit(hTarget, vLocation)
	if hTarget == nil then return end

	local caster = self:GetCaster()

	if caster == nil or caster:IsNull() then return end

	caster:StopSound("Minigames.Shockwave.Particle")

	EmitSoundOn("Minigames.Shockwave.Target", hTarget)

	local Duration = self:GetSpecialValueFor("duration")
	local PullDuration = self:GetSpecialValueFor("pull_duration")
	local Damage = self:GetSpecialValueFor("damage")

	hTarget:AddNewModifier(caster, self, "modifier_minigames_warrior_shockwave_pull", {duration=PullDuration, x=vLocation.x, y=vLocation.y})
	hTarget:AddNewModifier(caster, self, "modifier_minigames_warrior_shockwave", {duration=Duration})

	ApplyDamage({
		victim = hTarget,
		damage = Damage,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		attacker = caster,
		ability = self
	})
end

modifier_minigames_warrior_shockwave_pull = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return true end,
	
    CheckState				= function(self)
		return {
			[MODIFIER_STATE_STUNNED] = true,
		}
	end,

	DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        }
    end,

    GetOverrideAnimation   = function(self)
        return ACT_DOTA_FLAIL
    end,

    OnCreated               = function(self, table)
		if not IsServer() then return end

        local ability = self:GetAbility()
		local parent = self:GetParent()
        if ability then
            self.Distance = ability:GetSpecialValueFor("pull_distance")
        end

		self.Speed = (self.Distance / self:GetDuration()) * 0.033

		self.Point = Vector(table.x, table.y, 0)

		self.Travelled = 0

		self.Direction = CalculateDirection(self.Point, parent)

		self:StartIntervalThink(0.033)
    end,
	
	OnRefresh				= function(self, table)
		if not IsServer() then return end
		
		self:OnCreated(table)
	end,

	OnDestroy               = function(self)
        if not IsServer() then return end

        local parent = self:GetParent()

		GridNav:DestroyTreesAroundPoint( parent:GetOrigin(), parent:GetHullRadius(), true )

        FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
        ResolveNPCPositions(parent:GetAbsOrigin(), 150)
    end,

    OnIntervalThink         = function(self)
        local parent = self:GetParent()
        if parent and not parent:IsNull() and parent:IsAlive() then
            if self.Travelled < self.Distance then
                local Pos = GetGroundPosition(parent:GetAbsOrigin(), parent)
                Pos = GetGroundPosition(Pos + self.Direction * self.Speed, parent)

                parent:SetAbsOrigin(Pos)

                self.Travelled = self.Travelled + self.Speed
            end
        end
    end,
})

modifier_minigames_warrior_shockwave = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return true end,

	GetEffectName			= function(self) return "particles/units/heroes/hero_magnataur/magnataur_shockwave_hit.vpcf" end,

    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        }
    end,

    GetModifierMoveSpeedBonus_Percentage   = function(self)
        return -(self.Slow or 0)
    end,

    OnCreated               = function(self)
        local ability = self:GetAbility()
        if ability then
            self.Slow = ability:GetSpecialValueFor("slow")
        end
    end,
})