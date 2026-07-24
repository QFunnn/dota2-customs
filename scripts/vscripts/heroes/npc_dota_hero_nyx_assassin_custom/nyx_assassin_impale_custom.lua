--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )

nyx_assassin_impale_custom = class({})

nyx_assassin_impale_custom.modifier_nyx_assassin_1 = {50,100}
nyx_assassin_impale_custom.modifier_nyx_assassin_5 = {10,20,30}

function nyx_assassin_impale_custom:GetCooldown(iLevel)
    return self.BaseClass.GetCooldown(self, iLevel)
end

function nyx_assassin_impale_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    self:CastImpale(point)
end

function nyx_assassin_impale_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_nyx_assassin.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_nyx_assassin.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_nyx_assassin.vpcf", context)
end

function nyx_assassin_impale_custom:CastImpale(point)
    local width = self:GetSpecialValueFor("width")
    local length = self:GetSpecialValueFor("length") + self:GetCaster():GetCastRangeBonus()
    local speed = self:GetSpecialValueFor("speed")

    local direction = point - self:GetCaster():GetAbsOrigin()
    direction.z = 0
    local distance = direction:Length2D()
    direction = direction:Normalized()

    local projectile = 
    { 
        Ability = self,
        EffectName = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_impale.vpcf",
        vSpawnOrigin = self:GetCaster():GetAbsOrigin(),
        fDistance = length,
        fStartRadius = width,
        fEndRadius = width,
        Source = self:GetCaster(),
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        bDeleteOnHit = false,
        vVelocity = direction * speed,
        bProvidesVision = false,
    }
    self:GetCaster():EmitSound("Hero_NyxAssassin.Impale")
    ProjectileManager:CreateLinearProjectile(projectile)

    if self:GetCaster():HasModifier("modifier_nyx_assassin_5") then
        if RollPercentage(self.modifier_nyx_assassin_5[self:GetCaster():GetTalentLevel("modifier_nyx_assassin_5")]) then
            Timers:CreateTimer(0.1, function()
                local particle = ParticleManager:CreateParticle("particles/items2_fx/refresher_red.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
                ParticleManager:SetParticleControlEnt(particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
                ParticleManager:ReleaseParticleIndex(particle)
                self:EndCooldown()
            end)
        end
    end
end

function nyx_assassin_impale_custom:OnProjectileHit(target, location)
	if not target then return nil end
    local duration = self:GetSpecialValueFor("duration")
    local impale_damage = self:GetSpecialValueFor("impale_damage")
    if self:GetCaster():HasModifier("modifier_nyx_assassin_1") then
        impale_damage = impale_damage + (self:GetCaster():GetStrength() / 100 * self.modifier_nyx_assassin_1[self:GetCaster():GetTalentLevel("modifier_nyx_assassin_1")])
    end
    target:EmitSound("Hero_NyxAssassin.Impale.Target")

	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_impale_hit.vpcf", PATTACH_ABSORIGIN, target)
	ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)

    target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = duration * (1 - target:GetStatusResistance())})

    ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = impale_damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })

    if not target:IsDebuffImmune() then
        target:AddNewModifier( self:GetCaster(), self, "modifier_generic_knockback_lua", { duration = 0.5 * (1 - target:GetStatusResistance()), distance = 0, height = 250, IsStun = true})
    end

	Timers:CreateTimer(0.5, function()
		target:RemoveGesture(ACT_DOTA_FLAIL)
        target:EmitSound("Hero_NyxAssassin.Impale.TargetLand")
	end)
end