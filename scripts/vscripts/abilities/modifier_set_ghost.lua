--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_set_ghost_guard", "abilities/modifier_set_ghost", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_set_ghost_active", "abilities/modifier_set_ghost", LUA_MODIFIER_MOTION_NONE)

local GHOST_STATUS_PARTICLE = "particles/status_fx/status_effect_wraithking_ghosts.vpcf"

local function IsGhostDisabledContext()
	if wave_manager and wave_manager.game_mode == "hardcore" then
		return true
	end
	if
		post_stage_activity_system
		and post_stage_activity_system.IsAghanimBossFightActive
		and post_stage_activity_system:IsAghanimBossFightActive()
	then
		return true
	end
	if BossRushActivity and BossRushActivity.IsActiveCombat and BossRushActivity:IsActiveCombat() then
		return true
	end
	return false
end

modifier_set_ghost_guard = class({})

function modifier_set_ghost_guard:IsHidden()
	return true
end
function modifier_set_ghost_guard:IsPurgable()
	return false
end
function modifier_set_ghost_guard:RemoveOnDeath()
	return false
end
function modifier_set_ghost_guard:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_set_ghost_guard:OnCreated()
	self.parent = self:GetParent()
end

function modifier_set_ghost_guard:OnLevelUpCustomIncomingDamage(damage, event)
	local parent = self.parent
	if not IsServer() or not IsValid(parent) then
		return damage
	end

	if parent:HasModifier("modifier_set_ghost_active") then
		return 0
	end

	local current = tonumber(parent._levelup_current_health) or 0
	if current > 0 and damage >= current then
		if IsGhostDisabledContext() then
			return damage
		end
		parent:AddNewModifier(parent, nil, "modifier_set_ghost_active", {})
		return math.max(0, current - 1)
	end

	return damage
end

modifier_set_ghost_active = class({})

function modifier_set_ghost_active:IsHidden()
	return false
end
function modifier_set_ghost_active:IsPurgable()
	return false
end
function modifier_set_ghost_active:RemoveOnDeath()
	return false
end
function modifier_set_ghost_active:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_set_ghost_active:OnCreated()
	self.parent = self:GetParent()
	if not IsServer() then
		return
	end

	local player_id = self.parent:GetPlayerOwnerID()
	local respawn_time = (services and services.GetHeroRespawnTime and services:GetHeroRespawnTime(player_id)) or 5
	respawn_time = math.max(1, respawn_time)
	local max_hp = tonumber(self.parent._levelup_max_health) or 0
	self.heal_per_tick = max_hp / respawn_time * 0.2

	self:StartIntervalThink(0.2)
end

function modifier_set_ghost_active:CheckState()
	return {
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
	}
end

function modifier_set_ghost_active:GetStatusEffectName()
	return GHOST_STATUS_PARTICLE
end

function modifier_set_ghost_active:StatusEffectPriority()
	return 10000
end

function modifier_set_ghost_active:OnIntervalThink()
	if not IsServer() then
		return
	end
	local parent = self.parent
	if not IsValid(parent) then
		self:Destroy()
		return
	end

	local max_hp = tonumber(parent._levelup_max_health) or 0
	local current = tonumber(parent._levelup_current_health) or 0
	parent:LevelUpSetHealth(math.min(max_hp, current + math.max(1, self.heal_per_tick)))

	if (tonumber(parent._levelup_current_health) or 0) >= max_hp then
		self:Destroy()
	end
end