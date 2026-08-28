--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_56"
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
		["26"] = 5,
		["27"] = 4,
		["28"] = 5,
		["30"] = 5,
		["31"] = 16,
		["32"] = 24,
		["33"] = 16,
		["34"] = 24,
		["35"] = 27,
		["36"] = 28,
		["37"] = 29,
		["38"] = 27,
		["39"] = 31,
		["40"] = 32,
		["41"] = 31,
		["42"] = 36,
		["43"] = 37,
		["44"] = 38,
		["45"] = 36,
		["46"] = 40,
		["47"] = 41,
		["48"] = 42,
		["49"] = 43,
		["50"] = 44,
		["52"] = 46,
		["53"] = 40,
		["54"] = 24,
		["55"] = 16,
		["56"] = 16,
		["57"] = 16,
		["58"] = 16,
		["59"] = 16,
		["60"] = 16,
		["61"] = 16,
		["62"] = 16,
		["63"] = 24,
		["65"] = 24,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_56 = c()
local n = g.item_artifact_56
n.name = "item_artifact_56"
d(n, i)
function n.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(self:GetSpecialValueFor("count"))
	end
end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_56"
end
n = e({ j(nil) }, n)
g.item_artifact_56 = n
g.modifier_item_artifact_56 = c()
local o = g.modifier_item_artifact_56
o.name = "modifier_item_artifact_56"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.round_count = self.count
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function o.prototype.OnRoundStart(self)
	self.round_count = self.count
	self:GetAbility():SetCurrentCharges(self.round_count)
end
function o.prototype.use(self)
	if self.round_count > 0 then
		self.round_count = self.round_count - 1
		self:GetAbility():SetCurrentCharges(self.round_count)
		return true
	end
	return false
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
			}
		),
	},
	o
)
g.modifier_item_artifact_56 = o
return g