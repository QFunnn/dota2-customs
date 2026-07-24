--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_night_stalker_hunter_in_the_night_lua", "heroes/night_stalker/night_stalker_hunter_in_the_night_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if night_stalker_hunter_in_the_night_lua == nil then
    night_stalker_hunter_in_the_night_lua = class({})
end
function night_stalker_hunter_in_the_night_lua:GetBehavior()
    local hCaster = self:GetCaster()
    if hCaster:HasModifier("modifier_item_aghanims_shard") then
        return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
    end

    return tonumber(tostring(self.BaseClass.GetBehavior(self)))
end
function night_stalker_hunter_in_the_night_lua:GetCastRange(vLocation, hTarget)
    return self:GetSpecialValueFor("shard_cast_range")
end
function night_stalker_hunter_in_the_night_lua:GetIntrinsicModifierName()
    return "modifier_night_stalker_hunter_in_the_night_lua"
end
function night_stalker_hunter_in_the_night_lua:OnSpellStart()
    local hCaster = self:GetCaster()
    local hTarget = self:GetCursorTarget()
    local shard_hp_restore_pct = self:GetSpecialValueFor("shard_hp_restore_pct")
    local shard_mana_restore_pct = self:GetSpecialValueFor("shard_mana_restore_pct")

    if not IsValid(hTarget) then
        return
    end

    hCaster:HealWithParams(hCaster:GetMaxHealth() * shard_hp_restore_pct * 0.01, self, false, false, hCaster, false)
    hCaster:GiveMana(hCaster:GetMaxMana() * shard_mana_restore_pct * 0.01)

    if UnitFilter(hTarget, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, hCaster:GetTeamNumber()) == UF_SUCCESS then
        hTarget:Kill(self, hCaster)
    end

    EmitSoundOn("Hero_Nightstalker.Hunter.Target", hTarget)

    local particleID = ParticleManager:CreateParticle("particles/units/heroes/hero_night_stalker/nightstalker_shard_hunter.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
    ParticleManager:SetParticleControl(particleID, 0, hTarget:GetAbsOrigin())
    ParticleManager:SetParticleControl(particleID, 1, hCaster:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particleID)

end
---------------------------------------------------------------------
--Modifiers
if modifier_night_stalker_hunter_in_the_night_lua == nil then
    modifier_night_stalker_hunter_in_the_night_lua = class({})
end
function modifier_night_stalker_hunter_in_the_night_lua:IsHidden()
    return true
end
function modifier_night_stalker_hunter_in_the_night_lua:IsPurgable()
    return false
end
function modifier_night_stalker_hunter_in_the_night_lua:IsDebuff()
    return false
end
function modifier_night_stalker_hunter_in_the_night_lua:OnCreated(params)
    self.bonus_movement_speed_pct_night = self:GetAbility():GetSpecialValueFor("bonus_movement_speed_pct_night")
    self.bonus_attack_speed_night = self:GetAbility():GetSpecialValueFor("bonus_attack_speed_night")
    if IsServer() then
        self:StartIntervalThink(0)
        self:SetHasCustomTransmitterData(true)
        self.movespeed = 0
        self.atkspeed = 0
        self.status = 0
    end
end
function modifier_night_stalker_hunter_in_the_night_lua:OnRefresh(params)
    self.bonus_movement_speed_pct_night = self:GetAbility():GetSpecialValueFor("bonus_movement_speed_pct_night")
    self.bonus_attack_speed_night = self:GetAbility():GetSpecialValueFor("bonus_attack_speed_night")
    if IsServer() then
    end
end
function modifier_night_stalker_hunter_in_the_night_lua:OnIntervalThink()
	if not GameRulesCustom:IsDaytime() then
        self.movespeed = self.bonus_movement_speed_pct_night
    	self.atkspeed = self.bonus_attack_speed_night
		self.status = self:GetAbility():GetSpecialValueFor("bonus_status_resist_night")
    else
        self.movespeed = 0
    	self.atkspeed = 0
		self.status = 0
    end
    self:SendBuffRefreshToClients()
end
function modifier_night_stalker_hunter_in_the_night_lua:AddCustomTransmitterData()
    return {
        movespeed = self.movespeed,
        atkspeed = self.atkspeed,
        status = self.status,
    }
end
function modifier_night_stalker_hunter_in_the_night_lua:HandleCustomTransmitterData(data)
    self.movespeed = data.movespeed
    self.atkspeed = data.atkspeed
    self.status = data.status
end
function modifier_night_stalker_hunter_in_the_night_lua:OnDestroy()
    if IsServer() then
    end
end
function modifier_night_stalker_hunter_in_the_night_lua:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
    }
end
function modifier_night_stalker_hunter_in_the_night_lua:GetModifierMoveSpeedBonus_Percentage()
    return self.movespeed
end
function modifier_night_stalker_hunter_in_the_night_lua:GetModifierAttackSpeedBonus_Constant()
    return self.atkspeed
end
function modifier_night_stalker_hunter_in_the_night_lua:GetModifierStatusResistanceStacking()
    return self.status
end