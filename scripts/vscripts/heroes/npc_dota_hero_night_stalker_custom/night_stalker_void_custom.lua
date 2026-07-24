--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_night_stalker_void_custom", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_void_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_night_stalker_void_custom_thinker", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_void_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_night_stalker_void_custom_thinker_debuff", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_void_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_night_stalker_void_custom_thinker_night", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_void_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_night_stalker_void_custom_thinker_night_buff", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_void_custom", LUA_MODIFIER_MOTION_NONE)

night_stalker_void_custom = class({})

night_stalker_void_custom.modifier_night_stalker_3_duration = 4
night_stalker_void_custom.modifier_night_stalker_3_radius = 450
night_stalker_void_custom.modifier_night_stalker_3 = {-3,-6,-9}
night_stalker_void_custom.modifier_night_stalker_5_radius = 450
night_stalker_void_custom.modifier_night_stalker_5_stun = 1

function night_stalker_void_custom:GetCastPoint()
    if self:GetCaster():HasModifier("modifier_night_stalker_18") then
        return 0
    end
    return self.BaseClass.GetCastPoint(self)
end

function night_stalker_void_custom:GetAOERadius()
    return self.modifier_night_stalker_5_radius
end

function night_stalker_void_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_night_stalker_5") then
        return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end

function night_stalker_void_custom:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    local point = self:GetCursorPosition()
    self:GetCaster():EmitSound("Hero_Nightstalker.Void")
    if target == nil then
        local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, self.modifier_night_stalker_5_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)
        for _, unit in pairs(units) do
            self:CastVoid(unit)
        end
    else
        if target:TriggerSpellAbsorb(self) then return end
        self:CastVoid(target, point)
    end
    if self:GetCaster():HasModifier("modifier_night_stalker_3") then
        CreateModifierThinker(self:GetCaster(), self, "modifier_night_stalker_void_custom_thinker", {duration = self.modifier_night_stalker_3_duration}, point, self:GetCaster():GetTeamNumber(), false)
        CreateModifierThinker(self:GetCaster(), self, "modifier_night_stalker_void_custom_thinker_night", {duration = self.modifier_night_stalker_3_duration}, point, self:GetCaster():GetTeamNumber(), false)
    end
end

function night_stalker_void_custom:CastVoid(target, point)
    local damage = self:GetSpecialValueFor("damage")
    local duration = self:GetSpecialValueFor("duration_day")
    if self:GetCaster():HasModifier("modifier_night_stalker_darkness_custom") or not GameRules:IsDaytime() or self:GetCaster():HasModifier("modifier_night_stalker_void_custom_thinker_night_buff") or self:GetCaster():HasModifier("modifier_night_stalker_7") then
        duration = self:GetSpecialValueFor("duration_night")
    end
    target:AddNewModifier(self:GetCaster(), self, "modifier_night_stalker_void_custom", {duration = duration * (1-target:GetStatusResistance())})
    if self:GetCaster():HasModifier("modifier_night_stalker_darkness_custom") or not GameRules:IsDaytime() or self:GetCaster():HasModifier("modifier_night_stalker_void_custom_thinker_night_buff") or self:GetCaster():HasModifier("modifier_night_stalker_7") then
        target:AddNewModifier(caster, ability, "modifier_stunned", {duration = 0.1})
    end
    ApplyDamage({victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
end

modifier_night_stalker_void_custom = class({})

function modifier_night_stalker_void_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
end

function modifier_night_stalker_void_custom:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movespeed_slow")
end

function modifier_night_stalker_void_custom:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("attackspeed_slow")
end

function modifier_night_stalker_void_custom:GetEffectName()
	return "particles/units/heroes/hero_night_stalker/nightstalker_void.vpcf"
end

function modifier_night_stalker_void_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_night_stalker_void_custom_thinker = class({})

function modifier_night_stalker_void_custom_thinker:OnCreated()
    if not IsServer() then return end
    self.targets = {}
    self.radius = self:GetAbility().modifier_night_stalker_3_radius
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_night_stalker/night_stalker_void_zone.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 1, Vector(self.radius,1,1))
    self:AddParticle(particle, false, false, -1, false, false)
    print("ffff")
end

function modifier_night_stalker_void_custom_thinker:IsAura()
    return true
end

function modifier_night_stalker_void_custom_thinker:GetModifierAura()
    return "modifier_night_stalker_void_custom_thinker_debuff"
end

function modifier_night_stalker_void_custom_thinker:GetAuraRadius()
    return self.radius
end

function modifier_night_stalker_void_custom_thinker:GetAuraDuration()
    return 0
end

function modifier_night_stalker_void_custom_thinker:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_night_stalker_void_custom_thinker:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_night_stalker_void_custom_thinker:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

modifier_night_stalker_void_custom_thinker_debuff = class({})
function modifier_night_stalker_void_custom_thinker_debuff:IsPurgable() return false end
function modifier_night_stalker_void_custom_thinker_debuff:GetTexture() return "night_stalker_3" end

function modifier_night_stalker_void_custom_thinker_debuff:OnCreated()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_night_stalker_5") then
        if not self:GetAuraOwner():IsNull() then
            local modifier_night_stalker_void_custom_thinker = self:GetAuraOwner():FindModifierByName("modifier_night_stalker_void_custom_thinker")
            if modifier_night_stalker_void_custom_thinker then
                if modifier_night_stalker_void_custom_thinker.targets[self:GetParent():entindex()] == nil then
                    self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", {duration = self:GetAbility().modifier_night_stalker_5_stun * (1-self:GetParent():GetStatusResistance())})
                    modifier_night_stalker_void_custom_thinker.targets[self:GetParent():entindex()] = true
                end
            end
        end
    end
end

function modifier_night_stalker_void_custom_thinker_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
end

function modifier_night_stalker_void_custom_thinker_debuff:GetModifierPhysicalArmorBonus()
    return self:GetAbility().modifier_night_stalker_3[self:GetCaster():GetTalentLevel("modifier_night_stalker_3")]
end

modifier_night_stalker_void_custom_thinker_night = class({})

function modifier_night_stalker_void_custom_thinker_night:OnCreated()
    if not IsServer() then return end
    self.radius = self:GetAbility().modifier_night_stalker_3_radius
end

function modifier_night_stalker_void_custom_thinker_night:IsAura()
    return true
end

function modifier_night_stalker_void_custom_thinker_night:GetModifierAura()
    return "modifier_night_stalker_void_custom_thinker_night_buff"
end

function modifier_night_stalker_void_custom_thinker_night:GetAuraRadius()
    return self.radius
end

function modifier_night_stalker_void_custom_thinker_night:GetAuraDuration()
    return 0
end

function modifier_night_stalker_void_custom_thinker_night:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_night_stalker_void_custom_thinker_night:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO
end

function modifier_night_stalker_void_custom_thinker_night:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_night_stalker_void_custom_thinker_night:GetAuraEntityReject(target)
    if target == self:GetCaster() then
        return false
    end
    return true
end

modifier_night_stalker_void_custom_thinker_night_buff = class({})
function modifier_night_stalker_void_custom_thinker_night_buff:IsPurgable() return false end
function modifier_night_stalker_void_custom_thinker_night_buff:GetTexture() return "night_stalker_3" end