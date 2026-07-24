--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


invoker_deafening_blast_lua = class({})
LinkLuaModifier("modifier_invoker_deafening_blast_lua_knockback", "heroes/hero_invoker/modifier_invoker_deafening_blast_lua_knockback", LUA_MODIFIER_MOTION_HORIZONTAL)
--------------------------------------------------------------------------------
-- Ability Start
function invoker_deafening_blast_lua:OnSpellStart()
    -- unit identifier
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
    local ring_blast = self:GetSpecialValueFor("ring_blast")

    self.damageTable = {
        -- victim = target,
        attacker = self:GetCaster(),
        damage = self.damage,
        damage_type = self:GetAbilityDamageType(),
        ability = self, --Optional.
    }

    local sound_cast = "Hero_Invoker.DeafeningBlast"
    -- Create Sound
    EmitSoundOnLocationWithCaster(self.caster_origin, sound_cast, self:GetCaster())

    if self.blast_index == nil then
        self.targets_array = {}
        self.blast_index = 1
    else
        if self.blast_index > 20 then
            self.blast_index = 1
        else
            self.blast_index = self.blast_index + 1
        end
    end
    self.targets_array[self.blast_index] = {}


    if ring_blast > 0 then
        local direction = point - self.caster_origin
        for i = 1, 12 do
            local direction = RotatePosition(Vector(0, 0, 0), QAngle(0, 30 * i, 0), self:GetCaster():GetForwardVector())
            self:CastDeafeningBlast(self.caster_origin + direction, self.blast_index)
        end
    else
        self:CastDeafeningBlast(point, self.blast_index)
    end
end

function invoker_deafening_blast_lua:GetCastAnimation()
    return ACT_DOTA_CAST_DEAFENING_BLAST
end

function invoker_deafening_blast_lua:CastDeafeningBlast(cast_point, blast_index)
    -- Get Resources
    local particle = "particles/units/heroes/hero_invoker/invoker_deafening_blast.vpcf"

    local direction = cast_point - self.caster_origin
    direction.z = 0
    direction = direction:Normalized()

    local deafening_blast_projectile = {
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
        fExpireTime = GameRules:GetGameTime() + 10,
        ExtraData = {
            blast_index = blast_index,
            dir_x = direction.x,
            dir_y = direction.y,
            dir_z = direction.z,
        },
    }

    ProjectileManager:CreateLinearProjectile(deafening_blast_projectile)
end


function invoker_deafening_blast_lua:OnProjectileHit_ExtraData(hTarget, vLocation, tExtradata)
    local hCaster = self:GetCaster()
    -- If no target was hit, do nothing
    if not hTarget then
        return nil
    end

    local dir = Vector(tExtradata.dir_x, tExtradata.dir_y, tExtradata.dir_z)

    local blast_index = tExtradata.blast_index
    local bAlreadyhurt = false
    for i = 1, #self.targets_array[blast_index] do
        if self.targets_array[blast_index][i] == hTarget then
            bAlreadyhurt = true
        end
    end

    if bAlreadyhurt then
        return
    else
        table.insert(self.targets_array[blast_index], hTarget)
    end

    --只受一次伤害
    -- if not hTarget:HasModifier("modifier_invoker_deafening_blast_disarm") then
    self.damageTable.victim = hTarget
    ApplyDamage(self.damageTable)
    hTarget:AddNewModifier(self:GetCaster(), self, "modifier_invoker_deafening_blast_disarm", { duration = self.disarm_duration * hTarget:GetStatusResistanceFactor(hCaster) })
    hTarget:AddNewModifier(self:GetCaster(), self, "modifier_invoker_deafening_blast_lua_knockback", { duration = self.knockback_duration * hTarget:GetStatusResistanceFactor(hCaster), x = dir.x, y = dir.y, z = dir.z })
    -- end

    return false
end