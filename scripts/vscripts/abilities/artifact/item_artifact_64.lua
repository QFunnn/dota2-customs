--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_64"
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
		["30"] = 25,
		["31"] = 26,
		["32"] = 27,
		["33"] = 25,
		["34"] = 29,
		["35"] = 30,
		["36"] = 31,
		["37"] = 32,
		["38"] = 33,
		["40"] = 29,
		["41"] = 37,
		["42"] = 38,
		["43"] = 37,
		["44"] = 43,
		["45"] = 44,
		["48"] = 45,
		["49"] = 46,
		["50"] = 47,
		["51"] = 47,
		["52"] = 47,
		["53"] = 47,
		["54"] = 48,
		["55"] = 49,
		["57"] = 43,
		["58"] = 52,
		["59"] = 53,
		["60"] = 54,
		["62"] = 52,
		["63"] = 57,
		["64"] = 58,
		["65"] = 57,
		["66"] = 20,
		["67"] = 11,
		["68"] = 11,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 11,
		["74"] = 11,
		["75"] = 11,
		["76"] = 20,
		["78"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_64 = c()
local n = g.item_artifact_64
n.name = "item_artifact_64"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_64"
end
n = e({ j(nil) }, n)
g.item_artifact_64 = n
g.modifier_item_artifact_64 = c()
local o = g.modifier_item_artifact_64
o.name = "modifier_item_artifact_64"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold_bonus = self:GetAbilitySpecialValueFor("gold_bonus")
	self.rounds = self:GetAbilitySpecialValueFor("rounds") + 1
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self.enable = true
		self:SetStackCount(1)
		PlayerData:OnPrepareReady({ PlayerID = self:GetParent():GetPlayerOwnerID() })
	end
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE] = { -1, -1 },
	}
end
function o.prototype.OnRoundStart(self, p)
	if self.rounds <= 0 then
		return
	end
	self.rounds = math.max(0, self.rounds - 1)
	if self.rounds <= 0 and self.enable then
		PlayerData:modifyGold(self:GetParent():GetPlayerOwnerID(), self.gold_bonus)
		self.enable = false
		self:SetStackCount(0)
	end
end
function o.prototype.OnPrepare(self, p)
	if self.enable then
		PlayerData:OnPrepareReady({ PlayerID = self:GetParent():GetPlayerOwnerID() })
	end
end
function o.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = self.enable }
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
g.modifier_item_artifact_64 = o
return g