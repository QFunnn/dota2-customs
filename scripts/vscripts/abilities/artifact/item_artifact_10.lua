--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_10"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 8,
		["22"] = 6,
		["23"] = 11,
		["24"] = 12,
		["25"] = 11,
		["26"] = 14,
		["27"] = 15,
		["28"] = 16,
		["29"] = 17,
		["30"] = 18,
		["33"] = 21,
		["34"] = 21,
		["35"] = 21,
		["36"] = 21,
		["37"] = 22,
		["38"] = 23,
		["40"] = 25,
		["41"] = 14,
		["42"] = 27,
		["43"] = 28,
		["44"] = 27,
		["45"] = 5,
		["46"] = 4,
		["47"] = 5,
		["49"] = 5,
		["50"] = 32,
		["51"] = 41,
		["52"] = 32,
		["53"] = 41,
		["54"] = 45,
		["55"] = 46,
		["56"] = 47,
		["57"] = 48,
		["58"] = 45,
		["59"] = 50,
		["60"] = 51,
		["61"] = 52,
		["63"] = 50,
		["64"] = 55,
		["65"] = 56,
		["66"] = 55,
		["67"] = 62,
		["68"] = 63,
		["71"] = 66,
		["72"] = 67,
		["73"] = 68,
		["74"] = 68,
		["75"] = 68,
		["76"] = 68,
		["77"] = 69,
		["78"] = 70,
		["79"] = 71,
		["81"] = 73,
		["82"] = 74,
		["83"] = 75,
		["85"] = 62,
		["86"] = 78,
		["87"] = 79,
		["88"] = 80,
		["89"] = 81,
		["90"] = 82,
		["91"] = 83,
		["93"] = 78,
		["94"] = 86,
		["95"] = 87,
		["96"] = 88,
		["97"] = 89,
		["98"] = 89,
		["99"] = 89,
		["100"] = 89,
		["101"] = 90,
		["102"] = 90,
		["103"] = 90,
		["104"] = 90,
		["105"] = 90,
		["106"] = 91,
		["107"] = 91,
		["108"] = 91,
		["109"] = 91,
		["110"] = 92,
		["111"] = 93,
		["112"] = 86,
		["113"] = 41,
		["114"] = 32,
		["115"] = 32,
		["116"] = 32,
		["117"] = 32,
		["118"] = 32,
		["119"] = 32,
		["120"] = 32,
		["121"] = 32,
		["122"] = 32,
		["123"] = 41,
		["125"] = 41,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_10 = c()
local n = g.item_artifact_10
n.name = "item_artifact_10"
d(n, i)
function n.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(self:GetSpecialValueFor("init_gold"))
	end
end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_10"
end
function n.prototype.CastFilterResult(self)
	if IsServer() then
		if GameState:getStateName() ~= "GameState_Prepare" then
			self.error = "error_only_prepare_state_can_select"
			return UF_FAIL_CUSTOM
		end
	end
	if self:GetCaster():GetModifierStackCount(self:GetIntrinsicModifierName(), self:GetCaster()) == 0 then
		self.error = "error_no_enough_gold"
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end
function n.prototype.GetCustomCastError(self)
	return self.error
end
n = e({ j(nil) }, n)
g.item_artifact_10 = n
g.modifier_item_artifact_10 = c()
local o = g.modifier_item_artifact_10
o.name = "modifier_item_artifact_10"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.init_gold = self:GetAbilitySpecialValueFor("init_gold")
	self.max_gold = self:GetAbilitySpecialValueFor("max_gold")
	self.re_pct = self:GetAbilitySpecialValueFor("re_pct")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self:SetStackCount(self.init_gold)
	end
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 },
	}
end
function o.prototype.OnBattleEnd(self, q)
	if q.isNeutral ~= nil then
		return
	end
	local r = self:GetParent():GetPlayerOwnerID()
	if q.winPlayerID == r and q.illusionPlayerID ~= q.winPlayerID then
		self:SetStackCount(math.min(self:GetStackCount() * 2, self.max_gold))
	elseif q.losePlayerID == r and q.illusionPlayerID ~= q.losePlayerID then
		self:SetStackCount(math.floor(self:GetStackCount() * self.re_pct * 0.01))
		self:Settlement()
	end
	self:GetAbility():SetCurrentCharges(self:GetStackCount())
	if self:GetStackCount() == self.max_gold then
		self:Settlement()
	end
end
function o.prototype.OnRoundStart(self)
	if self:GetStackCount() == 0 then
		self:SetStackCount(self.init_gold)
		self:GetAbility():SetCurrentCharges(self:GetStackCount())
	elseif self:GetStackCount() == self.max_gold then
		self:Settlement()
	end
end
function o.prototype.Settlement(self)
	local s = self:GetParent()
	local t = self:GetStackCount()
	PlayerData:modifyGold(s:GetPlayerOwnerID(), t)
	PlayerData:getplayerData(s:GetPlayerOwnerID())
		:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", t)
	EmitAnnouncerSoundForPlayer("General.Coins", self:GetParent():GetPlayerOwnerID())
	self:SetStackCount(0)
	self:GetAbility():SetCurrentCharges(0)
end
o = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	o
)
g.modifier_item_artifact_10 = o
return g