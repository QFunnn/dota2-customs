--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_minigames_warrior_dagger", "abilities/minigames/dagger.lua", LUA_MODIFIER_MOTION_NONE )

minigames_warrior_dagger = class({})

function minigames_warrior_dagger:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_stifling_dagger.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_stifling_dagger_debuff.vpcf", context)
end

function minigames_warrior_dagger:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local Speed = self:GetSpecialValueFor("speed")

	if target == nil then return end

	ProjectileManager:CreateTrackingProjectile({
		EffectName = "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_stifling_dagger.vpcf",
		Dodgeable = true,
		Ability = self,
		ProvidesVision = false,
		bVisibleToEnemies = true,
		iMoveSpeed = Speed,
		Source = caster,
		Target = target,
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
		bReplaceExisting = false
	})

	EmitSoundOn("Minigames.Dagger.Cast", caster)
end

function minigames_warrior_dagger:OnProjectileHit(hTarget, vLocation)
	if hTarget == nil then return end

	local caster = self:GetCaster()

	if caster == nil or caster:IsNull() then return end

	local Duration = self:GetSpecialValueFor("duration")
	local Damage = self:GetSpecialValueFor("damage")

	hTarget:AddNewModifier(caster, self, "modifier_minigames_warrior_dagger", {duration=Duration})

	EmitSoundOn("Minigames.Dagger.Target", hTarget)

	ApplyDamage({
		victim = hTarget,
		damage = Damage,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		attacker = caster,
		ability = self
	})
end

modifier_minigames_warrior_dagger = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return true end,

	GetEffectName			= function(self) return "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_stifling_dagger_debuff.vpcf" end,

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