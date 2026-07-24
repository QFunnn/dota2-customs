--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_slardar_seaborn_sentinel_custom", "heroes/npc_dota_hero_slardar_custom/slardar_seaborn_sentinel_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_slardar_seaborn_sentinel_custom_buff", "heroes/npc_dota_hero_slardar_custom/slardar_seaborn_sentinel_custom", LUA_MODIFIER_MOTION_NONE)

slardar_seaborn_sentinel_custom = class({})

slardar_seaborn_sentinel_custom.modifier_slardar_7_hp_regen = 22
slardar_seaborn_sentinel_custom.modifier_slardar_7_armor = 10
slardar_seaborn_sentinel_custom.modifier_slardar_7_status_resistance = 40

function slardar_seaborn_sentinel_custom:GetIntrinsicModifierName()
    return "modifier_slardar_seaborn_sentinel_custom"
end

modifier_slardar_seaborn_sentinel_custom = class({})
function modifier_slardar_seaborn_sentinel_custom:IsHidden() return self:Check() end
function modifier_slardar_seaborn_sentinel_custom:IsPurgable() return false end
function modifier_slardar_seaborn_sentinel_custom:IsPurgeException() return false end
function modifier_slardar_seaborn_sentinel_custom:RemoveOnDeath() return false end
function modifier_slardar_seaborn_sentinel_custom:Check()
	if self:GetParent():HasModifier("modifier_slardar_slithereen_crush_custom_puddle_buff") then
		return false
	end
    local origin = self:GetParent():GetAbsOrigin()
    local input = {startpos = origin+Vector(0,0,32),endpos = origin,mask = 32768}
    TraceLine(input)
    if input.hit then
		return false
	end
	return true
end

function modifier_slardar_seaborn_sentinel_custom:OnCreated( kv )
	self.river_speed = self:GetAbility():GetSpecialValueFor("river_speed")
    self.puddle_regen = self:GetAbility():GetSpecialValueFor("puddle_regen")
    self.puddle_armor = self:GetAbility():GetSpecialValueFor("puddle_armor")
    self.river_damage_pct = self:GetAbility():GetSpecialValueFor("river_damage_pct")
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end

function modifier_slardar_seaborn_sentinel_custom:OnIntervalThink()
    if not self:Check() then
        if self.pfx then return end
        self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_slardar/slardar_sprint_river.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        self:AddParticle(self.pfx, false, false, -1, false, false)
    else
        if self.pfx then
            ParticleManager:DestroyParticle(self.pfx, false)
            self.pfx = nil
        end
    end
end

function modifier_slardar_seaborn_sentinel_custom:OnRefresh( kv )
	self.river_speed = self:GetAbility():GetSpecialValueFor("river_speed")
    self.puddle_regen = self:GetAbility():GetSpecialValueFor("puddle_regen")
    self.puddle_armor = self:GetAbility():GetSpecialValueFor("puddle_armor")
    self.river_damage_pct = self:GetAbility():GetSpecialValueFor("river_damage_pct")
end

function modifier_slardar_seaborn_sentinel_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
        MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
    }
end

function modifier_slardar_seaborn_sentinel_custom:GetModifierMoveSpeedBonus_Percentage()
	if not self:Check() then
		return self.river_speed
	end
	return 0
end

function modifier_slardar_seaborn_sentinel_custom:GetModifierPhysicalArmorBonus()
    local bonus = 0
    if self:GetParent():HasModifier("modifier_slardar_7") then
        bonus = self:GetAbility().modifier_slardar_7_armor
    end
	if not self:Check() then
		return self.puddle_armor + bonus
	end
	return 0
end

function modifier_slardar_seaborn_sentinel_custom:GetModifierConstantHealthRegen()
    local bonus = 0
    if self:GetParent():HasModifier("modifier_slardar_7") then
        bonus = self:GetAbility().modifier_slardar_7_hp_regen
    end
	if not self:Check() then
		return self.puddle_regen + bonus
	end
	return 0
end

function modifier_slardar_seaborn_sentinel_custom:GetModifierBaseDamageOutgoing_Percentage()
    if not self:Check() then
        return self.river_damage_pct
    end
    return 0
end

function modifier_slardar_seaborn_sentinel_custom:GetModifierStatusResistanceStacking()
    if not self:Check() then
        if self:GetParent():HasModifier("modifier_slardar_7") then
            return self:GetAbility().modifier_slardar_7_status_resistance
        end
    end
    return 0
end