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
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local EROSION_CURRENT_HEALTH_PCT = 1
local EROSION_MAX_MANA_PCT = 1
local EROSION_STACK_INTERVAL = 3
local EROSION_MAX_STACKS = 10
____exports.modifier_env_m010_erosion = __TS__Class()
local modifier_env_m010_erosion = ____exports.modifier_env_m010_erosion
modifier_env_m010_erosion.name = "modifier_env_m010_erosion"
__TS__ClassExtends(modifier_env_m010_erosion, BaseModifier_CS)
function modifier_env_m010_erosion.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.elapsedSeconds = 0
end
function modifier_env_m010_erosion.GetLocalizationCN(self)
	return { name = "侵蚀", description = "生命和魔法正在持续流逝" }
end
function modifier_env_m010_erosion.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	self:StartIntervalThink(1)
end
function modifier_env_m010_erosion.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if
		not IsValidAlive(nil, parent)
		or not self:IsParentInM010(parent)
		or parent:HasModifier("modifier_ak_rune_purification")
	then
		self:Destroy()
		return
	end
	if self:GetStackCount() < EROSION_MAX_STACKS then
		self.elapsedSeconds = self.elapsedSeconds + 1
		if self.elapsedSeconds >= EROSION_STACK_INTERVAL then
			self.elapsedSeconds = 0
			self:IncrementStackCount()
		end
	end
	local stackCount = self:GetStackCount()
	local healthLossPct = EROSION_CURRENT_HEALTH_PCT * stackCount
	local manaLossPct = EROSION_MAX_MANA_PCT * stackCount
	local healthLoss = math.min(parent:GetHealth() - 1, parent:GetHealth() * (healthLossPct / 100))
	if healthLoss > 0 then
		Damage:ApplyDamage({
			attacker = self:GetDamageAttacker(parent),
			victim = parent,
			damage = healthLoss,
			damage_type = 4,
			damage_flag = ApplyDamageFlag.HP_LOSS,
			extra_data = {
				custom_tag = "modifier_env_m010_erosion",
				source_name = "侵蚀",
				damage_tags = bit.bor(DamageTag.DOT, DamageTag.IGNORE_FINAL_DAMAGE_FILTERS),
			},
		})
	end
	local manaLoss = parent:GetMaxMana() * (manaLossPct / 100)
	parent:SetMana(math.max(0, parent:GetMana() - manaLoss))
end
function modifier_env_m010_erosion.prototype.IsParentInM010(self, parent)
	local ____this_1
	____this_1 = parent
	local ____opt_0 = ____this_1.GetPlayerOwnerID
	local playerId = ____opt_0 and ____opt_0(____this_1)
	if playerId == nil or playerId < 0 then
		return false
	end
	local ____opt_2 = MyGameRoomManager:GetPlayerRoom(playerId)
	return (____opt_2 and ____opt_2:GetRoomId()) == "M010"
end
function modifier_env_m010_erosion.prototype.GetDamageAttacker(self, parent)
	local ____this_5
	____this_5 = parent
	local ____opt_4 = ____this_5.GetPlayerOwnerID
	local playerId = ____opt_4 and ____opt_4(____this_5)
	if playerId ~= nil and playerId >= 0 then
		local ____opt_6 = MyGameRoomManager:GetPlayerRoom(playerId)
		local roomDummy = ____opt_6 and ____opt_6:GetRoomDummy()
		if roomDummy and IsValid(nil, roomDummy) and not roomDummy:IsNull() then
			return roomDummy
		end
	end
	return parent
end
function modifier_env_m010_erosion.prototype.IsHidden(self)
	return false
end
function modifier_env_m010_erosion.prototype.IsDebuff(self)
	return true
end
function modifier_env_m010_erosion.prototype.IsPurgable(self)
	return false
end
function modifier_env_m010_erosion.prototype.RemoveOnDeath(self)
	return true
end
function modifier_env_m010_erosion.prototype.GetTexture(self)
	return "necrolyte_heartstopper_aura"
end
modifier_env_m010_erosion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_env_m010_erosion)
____exports.modifier_env_m010_erosion = modifier_env_m010_erosion
return ____exports