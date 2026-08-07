--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_11"
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
		["20"] = 6,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 11,
		["27"] = 20,
		["28"] = 11,
		["29"] = 20,
		["30"] = 22,
		["31"] = 23,
		["32"] = 22,
		["33"] = 25,
		["34"] = 26,
		["35"] = 25,
		["36"] = 32,
		["37"] = 33,
		["40"] = 36,
		["41"] = 37,
		["42"] = 38,
		["43"] = 39,
		["44"] = 40,
		["45"] = 41,
		["46"] = 41,
		["47"] = 41,
		["48"] = 41,
		["49"] = 42,
		["50"] = 43,
		["51"] = 44,
		["52"] = 45,
		["53"] = 46,
		["54"] = 46,
		["55"] = 46,
		["56"] = 46,
		["57"] = 47,
		["58"] = 48,
		["60"] = 32,
		["61"] = 51,
		["62"] = 52,
		["63"] = 52,
		["64"] = 52,
		["65"] = 52,
		["66"] = 53,
		["67"] = 53,
		["68"] = 53,
		["69"] = 53,
		["70"] = 53,
		["71"] = 54,
		["72"] = 55,
		["73"] = 51,
		["74"] = 20,
		["75"] = 11,
		["76"] = 11,
		["77"] = 11,
		["78"] = 11,
		["79"] = 11,
		["80"] = 11,
		["81"] = 11,
		["82"] = 11,
		["83"] = 11,
		["84"] = 20,
		["86"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_11 = c()
local n = g.item_artifact_11
n.name = "item_artifact_11"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_11"
end
n = e({ j(nil) }, n)
g.item_artifact_11 = n
g.modifier_item_artifact_11 = c()
local o = g.modifier_item_artifact_11
o.name = "modifier_item_artifact_11"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.factor = self:GetAbilitySpecialValueFor("factor")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE] = { -1, -1 },
	}
end
function o.prototype.OnBattleEnd(self, p)
	if p.isNeutral ~= nil then
		return
	end
	local q = self:GetParent()
	local r = q:GetPlayerOwnerID()
	local s = getInterestConfig(nil)
	if p.winPlayerID == r and p.losePlayerID then
		local t = PlayerData:getHero(p.losePlayerID).hero
		local u = math.min(
			s.Max + GetModifierProperty(t, EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_INTEREST_LIMIT),
			math.floor(PlayerData:getGold(p.losePlayerID) / s.Rate) * 10
		)
		self:SetStackCount(u * self.factor * 0.01)
		self:GetAbility():SetCurrentCharges(u)
	elseif p.losePlayerID == r and p.winPlayerID then
		local t = PlayerData:getHero(p.winPlayerID).hero
		local u = math.min(
			s.Max + GetModifierProperty(t, EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_INTEREST_LIMIT),
			math.floor(PlayerData:getGold(p.winPlayerID) / s.Rate) * 10
		)
		self:SetStackCount(u * self.factor * 0.01)
		self:GetAbility():SetCurrentCharges(u)
	end
end
function o.prototype.OnPrepare(self)
	PlayerData:modifyGold(self:GetParent():GetPlayerOwnerID(), self:GetStackCount())
	PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
		:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self:GetStackCount())
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
g.modifier_item_artifact_11 = o
return g