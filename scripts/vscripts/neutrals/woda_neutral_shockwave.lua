--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

woda_neutral_shockwave = class({})

function woda_neutral_shockwave:Precache(context)
    PrecacheResource( "particle", "particles/generic_gameplay/generic_has_quest.vpcf", context )
    PrecacheResource( "particle", "particles/neutral_fx/satyr_hellcaller.vpcf", context )
end

function woda_neutral_shockwave:OnSpellStart()
	if not IsServer() then return end
	local point = self:GetCursorPosition()

    self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {})
    self.sign = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_has_quest.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetCaster())

    Timers:CreateTimer(1, function()
        local direction = (point - self:GetCaster():GetAbsOrigin()) + self:GetCaster():GetForwardVector() * 10
        direction.z = 0.0

        if self.sign then
            ParticleManager:DestroyParticle(self.sign, true)
        end

        if not self:GetCaster():IsAlive() then return end

        self:GetCaster():EmitSound("n_creep_SatyrHellcaller.Shockwave")

        direction = direction:Normalized()

        local info = {
            EffectName = "particles/neutral_fx/satyr_hellcaller.vpcf",
            Ability = self,
            vSpawnOrigin = self:GetCaster():GetOrigin(), 
            fStartRadius = 180,
            fEndRadius = 200,
            vVelocity = direction * 900,
            fDistance = 1200,
            Source = self:GetCaster(),
            bDeleteOnHit = false,
            fExpireTime = GameRules:GetGameTime() + 4,
            iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
            iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
        }
        ProjectileManager:CreateLinearProjectile(info)
        self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
    end)
end

function woda_neutral_shockwave:OnProjectileHit(target, vLocation)
	if not IsServer() then return end
	if target == nil then return end
    if target:IsMagicImmune() then return end
	local damage = target:GetMana() / 100 * self:GetSpecialValueFor("damage")
	ApplyDamage({victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
end