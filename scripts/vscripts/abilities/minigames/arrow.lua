--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_minigames_mirana_arrow", "abilities/minigames/arrow.lua", LUA_MODIFIER_MOTION_NONE )

if minigames_mirana_arrow == nil then
	minigames_mirana_arrow = class({})
end

function minigames_mirana_arrow:Precache(Context)
    PrecacheResource("particle", "particles/econ/items/mirana/mirana_persona/mirana_dark_moon_spell_arrow.vpcf", Context)
end

function minigames_mirana_arrow:OnSpellStart()
    self.CastPoint = self:GetCursorPosition()

    local caster = self:GetCaster()

	EmitSoundOn("Minigames.Arrow.Cast", caster)

	self:CreateArrow()
end

function minigames_mirana_arrow:OnProjectileHit_ExtraData(hTarget, vLocation, ExtraData)
    local Caster = self:GetCaster()

    if not hTarget then return end

    local StunMin = self:GetSpecialValueFor("min_stun")
    local StunMax = self:GetSpecialValueFor("max_stun")
    local MaxStunDistance = self:GetSpecialValueFor("max_stun_range")
    
    local CastLocation = Vector(ExtraData.cast_loc_x, ExtraData.cast_loc_y, ExtraData.cast_loc_z)

    local DistanceTravelled = CalculateDistance(vLocation, CastLocation)

    local FullPct = math.min(DistanceTravelled, MaxStunDistance)/MaxStunDistance

    local Stun = StunMin + (StunMax - StunMin) * FullPct

	if not hTarget:HasModifier("modifier_minigames_mirana_arrow") then
		hTarget:AddNewModifier(Caster, self, "modifier_minigames_mirana_arrow", {duration = Stun})

		EmitSoundOn("Minigames.Arrow.End", hTarget)

        local Damage = math.round(Stun) * 2

		ApplyDamage({
			victim = hTarget,
			damage = Damage,
			damage_type = DAMAGE_TYPE_PURE,
			damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
			attacker = Caster,
			ability = self
		})
	end

    return true
end

function minigames_mirana_arrow:CreateArrow()
    local Caster = self:GetCaster()

	local Direction = CalculateDirection(self.CastPoint, Caster)
	local Distance = self:GetEffectiveCastRange(Caster:GetAbsOrigin(), Caster)
	local Speed = self:GetSpecialValueFor("speed")
	local Width = self:GetSpecialValueFor("width")

    -- EmitSoundOn("RAMZES.ArrowEndCompleted", Caster)

    ProjectileManager:CreateLinearProjectile({
        Source = Caster,
        Ability = self,
        vSpawnOrigin = Caster:GetAbsOrigin(),

        bDeleteOnHit = true,
        bHasFrontalCone = false,
		bReplaceExisting = false,
        
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        
        EffectName = "particles/econ/items/mirana/mirana_persona/mirana_dark_moon_spell_arrow.vpcf",
        fDistance = Distance,
        fStartRadius = Width,
        fEndRadius = Width,
        fExpireTime = GameRules:GetGameTime()+10,
        vVelocity = Direction * Speed,
    
        bProvidesVision = false,
        ExtraData = {
            cast_loc_x = Caster:GetAbsOrigin().x,
			cast_loc_y = Caster:GetAbsOrigin().y,
			cast_loc_z = Caster:GetAbsOrigin().z
        }
    })
end

modifier_minigames_mirana_arrow = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return true end,
    IsStunDebuff            = function(self) return true end,

    CheckState              = function(self)
        return {
            [MODIFIER_STATE_STUNNED]=true
        }
    end,

    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_OVERRIDE_ANIMATION
        }
    end,

    GetOverrideAnimation    = function(self) 
        return ACT_DOTA_DISABLED
    end,

    GetEffectName           = function(self)
        return "particles/generic_gameplay/generic_stunned.vpcf"
    end,

    GetEffectAttachType     = function(self)
        return PATTACH_OVERHEAD_FOLLOW
    end,

    ShouldUseOverheadOffset = function(self)
        return true
    end,
})