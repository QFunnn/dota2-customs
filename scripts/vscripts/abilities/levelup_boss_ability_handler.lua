--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_levelup_boss_ability_handler",
	"abilities/levelup_boss_ability_handler",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_levelup_boss_cast_lock", "abilities/levelup_boss_ability_handler", LUA_MODIFIER_MOTION_NONE)

levelup_boss_ability_handler = class({})

local ATTACK_SOUND_BY_UNIT = {
	npc_levelup_aghanim_boss_mech = "Hero_DragonKnight.Attack",
}
local BOSS_CAST_LOCK_MODIFIER = "modifier_levelup_boss_cast_lock"

function levelup_boss_ability_handler:Spawn()
	if not IsServer() then
		return
	end
	if self:IsTrained() then
		return
	end
	self:SetLevel(1)
end

function levelup_boss_ability_handler:GetIntrinsicModifierName()
	return "modifier_levelup_boss_ability_handler"
end

function levelup_boss_ability_handler:OnProjectileHit_ExtraData(target, location, extra_data)
	if not IsServer() then
		return false
	end
	if not boss_ability_system then
		return false
	end
	return boss_ability_system:OnProjectileHit_ExtraData(self, target, location, extra_data)
end

modifier_levelup_boss_ability_handler = class({})

function modifier_levelup_boss_ability_handler:IsHidden()
	return true
end
function modifier_levelup_boss_ability_handler:IsPurgable()
	return false
end
function modifier_levelup_boss_ability_handler:RemoveOnDeath()
	return false
end

function modifier_levelup_boss_ability_handler:CheckState()
	local parent = self.parent or self:GetParent()
	local has_cast_lock = IsValid(parent) and parent:HasModifier(BOSS_CAST_LOCK_MODIFIER)
	local states = {
		[MODIFIER_STATE_STUNNED] = false,
		[MODIFIER_STATE_SILENCED] = false,
	}

	if not has_cast_lock then
		states[MODIFIER_STATE_ROOTED] = false
	end

	return states
end

function modifier_levelup_boss_ability_handler:RemoveExternalControlModifiers()
	if not IsServer() then
		return
	end
	local parent = self.parent or self:GetParent()
	if not IsValid(parent) then
		return
	end

	for _, modifier in pairs(parent:FindAllModifiers() or {}) do
		if IsValid(modifier) and modifier ~= self and modifier:GetName() ~= BOSS_CAST_LOCK_MODIFIER then
			local states = {}
			if modifier.CheckStateToTable then
				modifier:CheckStateToTable(states)
			end

			local blocks_boss_control = false
			for state_name, enabled in pairs(states) do
				local state = tonumber(state_name)
				if
					enabled ~= false
					and (
						state == MODIFIER_STATE_STUNNED
						or state == MODIFIER_STATE_ROOTED
						or state == MODIFIER_STATE_SILENCED
					)
				then
					blocks_boss_control = true
					break
				end
			end

			local modifier_name = modifier:GetName()
			if
				blocks_boss_control
				or modifier_name == "modifier_stunned"
				or modifier_name == "modifier_generic_stunned_lua"
				or modifier_name == "modifier_rooted"
				or modifier_name == "modifier_generic_root_lua"
				or modifier_name == "modifier_generic_slow_lua"
				or modifier_name == "modifier_generic_silence_lua"
			then
				modifier:Destroy()
			end
		end
	end
end

function modifier_levelup_boss_ability_handler:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	if boss_ability_system and boss_ability_system.EnsureBossAbilities then
		boss_ability_system:EnsureBossAbilities(self.parent)
	end
	self:RemoveExternalControlModifiers()
	self:StartIntervalThink(0.1)
end

function modifier_levelup_boss_ability_handler:OnRefresh()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	if boss_ability_system and boss_ability_system.EnsureBossAbilities then
		boss_ability_system:EnsureBossAbilities(self.parent)
	end
	self:RemoveExternalControlModifiers()
	self:StartIntervalThink(0.1)
end

function modifier_levelup_boss_ability_handler:OnIntervalThink()
	if not IsServer() then
		return
	end
	if not boss_ability_system then
		return
	end
	self:RemoveExternalControlModifiers()
	boss_ability_system:HandleIntervalThink(self.parent, self.ability, self)
end

function modifier_levelup_boss_ability_handler:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN,
	}
end

function modifier_levelup_boss_ability_handler:GetAttackSound()
	if not IsValid(self.parent) then
		return nil
	end
	return ATTACK_SOUND_BY_UNIT[self.parent:GetUnitName()]
end

function modifier_levelup_boss_ability_handler:GetModifierMoveSpeed_AbsoluteMin()
	local parent = self.parent or self:GetParent()
	if not IsValid(parent) then
		return 0
	end
	return parent:GetBaseMoveSpeed()
end

modifier_levelup_boss_cast_lock = class({})

function modifier_levelup_boss_cast_lock:IsHidden()
	return true
end
function modifier_levelup_boss_cast_lock:IsPurgable()
	return false
end
function modifier_levelup_boss_cast_lock:RemoveOnDeath()
	return true
end

function modifier_levelup_boss_cast_lock:CheckState()
	return {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ROOTED] = true,
	}
end