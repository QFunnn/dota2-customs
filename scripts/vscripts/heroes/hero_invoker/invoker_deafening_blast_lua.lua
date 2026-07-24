--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


invoker_deafening_blast_lua = class({})

LinkLuaModifier("modifier_invoker_deafening_blast_lua_knockback", "heroes/hero_invoker/modifier_invoker_deafening_blast_lua_knockback", LUA_MODIFIER_MOTION_HORIZONTAL)

function invoker_deafening_blast_lua:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    self.caster_origin = self:GetCaster():GetOrigin()
    self.radius_start = self:GetSpecialValueFor("radius_start")
    self.radius_end = self:GetSpecialValueFor("radius_end")
    self.speed = self:GetSpecialValueFor("travel_speed")
    self.distance = self:GetSpecialValueFor("travel_distance")
    self.damage = self:GetSpecialValueFor("damage")
    self.knockback_duration = self:GetSpecialValueFor("knockback_duration")
    self.disarm_duration = self:GetSpecialValueFor("disarm_duration")

    self.damageTable = 
    {
        attacker = self:GetCaster(),
        damage = self.damage,
        damage_type = self:GetAbilityDamageType(),
        ability = self,
    }

    self:GetCaster():EmitSound("Hero_Invoker.DeafeningBlast")

    self.heroes_target = {}

    local talent = caster:FindAbilityByName("special_bonus_unique_invoker_2")
    if talent and talent:GetLevel() > 0 then
        local direction = point - self.caster_origin
        for i = 1, 12 do
            local direction = RotatePosition(Vector(0, 0, 0), QAngle(0, 30*i, 0), self:GetCaster():GetForwardVector())
            self:CastDeafeningBlast(self.caster_origin + direction)
        end
    else
        self:CastDeafeningBlast(point)
    end
end

function invoker_deafening_blast_lua:GetCastAnimation()
    return ACT_DOTA_CAST_DEAFENING_BLAST
end

function invoker_deafening_blast_lua:CastDeafeningBlast(cast_point)
    local particle = "particles/units/heroes/hero_invoker/invoker_deafening_blast.vpcf"
    local direction = cast_point - self.caster_origin
    direction.z = 0
    direction = direction:Normalized()
    local deafening_blast_projectile = 
    {
        Ability = self,
        EffectName = particle,
        vSpawnOrigin = self.caster_origin,
        fDistance = self.distance,
        fStartRadius = self.radius_start,
        fEndRadius = self.radius_end,
        Source = self:GetCaster(),
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        bDeleteOnHit = false,
        vVelocity = direction * self.speed,
        fExpireTime = GameRules:GetGameTime() + 10
    }
    ProjectileManager:CreateLinearProjectile(deafening_blast_projectile)
end

function invoker_deafening_blast_lua:OnProjectileHit(hTarget, vLocation)
    if not hTarget then
        return nil
    end
    if self.heroes_target[hTarget:entindex()] == nil then
        self.damageTable.victim = hTarget
        ApplyDamage(self.damageTable)
        hTarget:AddNewModifier(self:GetCaster(), self, "modifier_invoker_deafening_blast_disarm", { duration = self.disarm_duration })
        hTarget:AddNewModifier(self:GetCaster(), self, "modifier_invoker_deafening_blast_knockback", { duration = self.knockback_duration })
        self.heroes_target[hTarget:entindex()] = true
    end
    return false
end