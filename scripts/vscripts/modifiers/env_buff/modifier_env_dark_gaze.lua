--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dark_domain = require("my_game_axe.room.dark_domain")
local IsDarkDomainUnit = ____dark_domain.IsDarkDomainUnit
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- 暗域环境 Debuff：玩家在暗域中累积黑暗凝视层数。
____exports.modifier_env_dark_gaze = __TS__Class()
local modifier_env_dark_gaze = ____exports.modifier_env_dark_gaze
modifier_env_dark_gaze.name = "modifier_env_dark_gaze"
__TS__ClassExtends(modifier_env_dark_gaze, BaseModifier_CS)
function modifier_env_dark_gaze.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.gazeBlocked = false
	self.gazeDecayPerSecond = 0
end
function modifier_env_dark_gaze.GetLocalizationCN(self)
	return { name = "黑暗凝视", description = "每层每秒流失2%%最大生命值，超过10层时死亡。" }
end
function modifier_env_dark_gaze.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.gazeBlocked = params.gaze_blocked == 1
	self.gazeDecayPerSecond = math.max(0, params.gaze_decay_per_second or 0)
	self:SetStackCount(0)
	self:StartIntervalThink(1)
end
function modifier_env_dark_gaze.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self.gazeBlocked = params.gaze_blocked == 1
	self.gazeDecayPerSecond = math.max(0, params.gaze_decay_per_second or 0)
end
function modifier_env_dark_gaze.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) or not IsDarkDomainUnit(nil, parent) then
		self:Destroy()
		return
	end
	if self.gazeDecayPerSecond > 0 then
		self:SetStackCount(math.max(0, self:GetStackCount() - self.gazeDecayPerSecond))
		return
	end
	if not self.gazeBlocked then
		self:AddStackCount(1)
	end
	local stacks = self:GetStackCount()
	if stacks > ____exports.modifier_env_dark_gaze.KILL_STACK_THRESHOLD then
		self:KillByDarkGaze(parent)
		return
	end
	if stacks <= 0 then
		return
	end
	self:ApplyGazeDamage(parent, stacks)
end
function modifier_env_dark_gaze.prototype.SetDarkDomainGazeBlocked(self, blocked, gazeDecayPerSecond)
	if gazeDecayPerSecond == nil then
		gazeDecayPerSecond = 0
	end
	self.gazeBlocked = blocked
	self.gazeDecayPerSecond = math.max(0, gazeDecayPerSecond)
end
function modifier_env_dark_gaze.prototype.ApplyGazeDamage(self, parent, stacks)
	Damage:ApplyDamage({
		attacker = self:GetDamageAttacker(parent),
		victim = parent,
		damage = parent:GetMaxHealth()
			* stacks
			* (____exports.modifier_env_dark_gaze.DAMAGE_MAX_HEALTH_PCT_PER_STACK / 100),
		damage_type = 4,
		damage_flag = ApplyDamageFlag.HP_LOSS,
		extra_data = {
			custom_tag = "modifier_env_dark_gaze",
			source_name = "黑暗凝视",
			damage_tags = DamageTag.DOT,
		},
	})
end
function modifier_env_dark_gaze.prototype.KillByDarkGaze(self, parent)
	Damage:ApplyDamage({
		attacker = self:GetDamageAttacker(parent),
		victim = parent,
		damage = parent:GetHealth() + 1,
		damage_type = 4,
		damage_flag = ApplyDamageFlag.HP_LOSS,
		extra_data = { custom_tag = "modifier_env_dark_gaze_kill", source_name = "黑暗凝视" },
	})
end
function modifier_env_dark_gaze.prototype.GetDamageAttacker(self, parent)
	local ____this_1
	____this_1 = parent
	local ____opt_0 = ____this_1.GetPlayerOwnerID
	local playerId = ____opt_0 and ____opt_0(____this_1)
	if playerId ~= nil and playerId >= 0 then
		local ____opt_2 = MyGameRoomManager:GetPlayerRoom(playerId)
		local roomDummy = ____opt_2 and ____opt_2:GetRoomDummy()
		if roomDummy and IsValid(nil, roomDummy) and not roomDummy:IsNull() then
			return roomDummy
		end
	end
	local caster = self:GetCaster()
	if caster and IsValid(nil, caster) and not caster:IsNull() then
		return caster
	end
	return parent
end
function modifier_env_dark_gaze.prototype.IsHidden(self)
	return self:GetStackCount() <= 0
end
function modifier_env_dark_gaze.prototype.IsDebuff(self)
	return true
end
function modifier_env_dark_gaze.prototype.IsPurgable(self)
	return true
end
function modifier_env_dark_gaze.prototype.IsPurgeException(self)
	return true
end
function modifier_env_dark_gaze.prototype.GetTexture(self)
	return "night_stalker_darkness"
end
modifier_env_dark_gaze.DAMAGE_MAX_HEALTH_PCT_PER_STACK = 2
modifier_env_dark_gaze.KILL_STACK_THRESHOLD = 10
modifier_env_dark_gaze = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_env_dark_gaze)
____exports.modifier_env_dark_gaze = modifier_env_dark_gaze
return ____exports