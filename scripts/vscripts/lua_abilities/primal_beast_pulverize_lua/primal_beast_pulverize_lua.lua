--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
primal_beast_pulverize_lua = class({})
LinkLuaModifier(
	"modifier_primal_beast_pulverize_lua",
	"lua_abilities/primal_beast_pulverize_lua/modifier_primal_beast_pulverize_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_primal_beast_pulverize_lua_debuff",
	"lua_abilities/primal_beast_pulverize_lua/modifier_primal_beast_pulverize_lua_debuff",
	LUA_MODIFIER_MOTION_BOTH
)

--------------------------------------------------------------------------------
-- Init Abilities
function primal_beast_pulverize_lua:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_primal_beast.vsndevts", context)
	PrecacheResource("particle", "particles/units/heroes/hero_primal_beast/primal_beast_pulverize_hit.vpcf", context)
end

function primal_beast_pulverize_lua:Spawn()
	if not IsServer() then
		return
	end
end

function primal_beast_pulverize_lua:GetChannelAnimation()
	return ACT_DOTA_GENERIC_CHANNEL_1

	-- -- for Primal Beast model
	-- return ACT_DOTA_CHANNEL_ABILITY_5
end

--------------------------------------------------------------------------------
-- Ability Start
primal_beast_pulverize_lua.modifiers = {}
function primal_beast_pulverize_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = self:GetSpecialValueFor("channel_time")

	-- add modifier
	local mod = target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_primal_beast_pulverize_lua_debuff", -- modifier name
		{ duration = duration } -- kv
	)
	self.modifiers[mod] = true
	if caster.unluckydog_table ~= nil then
		local dog_index = 0
		for _, d in pairs(caster.unluckydog_table) do
			if d ~= nil and d:IsNull() ~= true and d:IsAlive() == true then
				local mod1 = d:AddNewModifier(
					caster, -- player source
					self, -- ability source
					"modifier_primal_beast_pulverize_lua_debuff", -- modifier name
					{ duration = duration } -- kv
				)
				d.dog_index = dog_index
				dog_index = dog_index + 1
				if mod1 ~= nil then
					self.modifiers[mod1] = true
				end
			end
		end
	end

	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_primal_beast_pulverize_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	if target:IsCreep() then
		EmitSoundOn("Hero_PrimalBeast.Pulverize.Cast.Creep", caster)
	else
		EmitSoundOn("Hero_PrimalBeast.Pulverize.Cast", caster)
	end
end

--------------------------------------------------------------------------------
-- Ability Channeling
function primal_beast_pulverize_lua:GetChannelTime()
	return self:GetSpecialValueFor("channel_time")
end

function primal_beast_pulverize_lua:OnChannelFinish(bInterrupted)
	for mod, _ in pairs(self.modifiers) do
		if not mod:IsNull() then
			mod:Destroy()
		end
	end
	self.modifiers = {}

	local self_mod = self:GetCaster():FindModifierByName("modifier_primal_beast_pulverize_lua")
	if self_mod then
		self_mod:Destroy()
	end
end

function primal_beast_pulverize_lua:RemoveModifier(mod)
	self.modifiers[mod] = nil
	local has_enemies = false
	for _, mod in pairs(self.modifiers) do
		has_enemies = true
	end

	if not has_enemies then
		self:EndChannel(true)
	end
end