--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_tinker_warp_grenade_custom_debuff", "heroes/npc_dota_hero_tinker_custom/tinker_warp_grenade_custom", LUA_MODIFIER_MOTION_NONE )

tinker_warp_grenade_custom = class({})

function tinker_warp_grenade_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_tinker/tinker_shard_warp_flare.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_tinker/tinker_shard_warp_start_b.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_tinker/tinker_shard_warp_debuff.vpcf", context )
end

function tinker_warp_grenade_custom:OnSpellStart()
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    local info = 
    {
        EffectName = "particles/units/heroes/hero_tinker/tinker_shard_warp_flare.vpcf",
        Ability = self,
        iMoveSpeed = 1900,
        Source = caster,
        bDodgeable = true,
        Target = target,
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
        ExtraData = {start_x = caster:GetAbsOrigin().x, start_y = caster:GetAbsOrigin().y}
    }
    caster:EmitSound("Hero_Tinker.Warp.Cast")
    ProjectileManager:CreateTrackingProjectile(info)
end

function tinker_warp_grenade_custom:OnProjectileHit_ExtraData(target, vLocation, data)
    if not target then return end
    if target:TriggerSpellAbsorb(self) then return end
    local start_origin = Vector(data.start_x, data.start_y, 0)
    local caster = self:GetCaster()
    local damage = self:GetSpecialValueFor("damage")
    local bonus_distance = self:GetSpecialValueFor("bonus_distance")
    local max_distance = self:GetSpecialValueFor("max_distance")
    local debuff_duration = self:GetSpecialValueFor("debuff_duration")
    target:EmitSound("Hero_Tinker.Warp.Target")

    local direction = target:GetAbsOrigin() - start_origin
    direction.z = 0
    local distance = direction:Length2D()
    direction = direction:Normalized()
    local cast_range = self:GetCastRange(Vector(0,0,0), nil) + self:GetCaster():GetCastRangeBonus()

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_tinker/tinker_shard_warp_start_b.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
    ParticleManager:SetParticleControlForward(particle, 0, direction)
    ParticleManager:ReleaseParticleIndex(particle)

    ApplyDamage({victim = target, attacker = caster, damage = damage, ability = self, damage_type = DAMAGE_TYPE_MAGICAL})

    local distance_active = bonus_distance + (cast_range - distance)
    distance_active = math.min(max_distance, distance_active)
    local point = target:GetAbsOrigin() + direction * distance_active
    if not target:IsDebuffImmune() then
        FindClearSpaceForUnit(target, point, true)
    end
    target:AddNewModifier(caster, self, "modifier_tinker_warp_grenade_custom_debuff", {duration = debuff_duration * (1 - target:GetStatusResistance())})
end


modifier_tinker_warp_grenade_custom_debuff = class({})
function modifier_tinker_warp_grenade_custom_debuff:IsPurgable() return true end
function modifier_tinker_warp_grenade_custom_debuff:OnCreated(table)
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.range_reduction = self.ability:GetSpecialValueFor("range_reduction") * (-1)
end

function modifier_tinker_warp_grenade_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS_PERCENTAGE
    }
end

function modifier_tinker_warp_grenade_custom_debuff:GetModifierCastRangeBonusStacking(params)
    if params.ability then
        local data = GetAbilityKeyValuesByName(params.ability:GetName())
        if data and data.AbilityCastRange then
            local numbers_c = self:split(data.AbilityCastRange, " " )
            return (numbers_c[math.min(params.ability:GetLevel(), #numbers_c)] * self.range_reduction / 100)
        end
        if data and data.AbilityValues and data.AbilityValues.AbilityCastRange then
            local numbers_c = self:split(data.AbilityValues.AbilityCastRange, " " )
            return (numbers_c[math.min(params.ability:GetLevel(), #numbers_c)] * self.range_reduction / 100)
        end
    end
end

function modifier_tinker_warp_grenade_custom_debuff:split( inputStr, delimiter )
  local d = delimiter or '%s' 
    local t={} 
    for field,s in string.gmatch(inputStr, "([^"..delimiter.."]*)("..delimiter.."?)") do 
        table.insert(t,field) 
        if s=="" then 
            return t 
        end 
    end
end

function modifier_tinker_warp_grenade_custom_debuff:GetModifierAttackRangeBonusPercentage()
    return self.range_reduction
end

function modifier_tinker_warp_grenade_custom_debuff:GetEffectName()
    return "particles/units/heroes/hero_tinker/tinker_shard_warp_debuff.vpcf"
end

function modifier_tinker_warp_grenade_custom_debuff:CheckState()
    return
    {
        [MODIFIER_STATE_ROOTED] = true
    }
end