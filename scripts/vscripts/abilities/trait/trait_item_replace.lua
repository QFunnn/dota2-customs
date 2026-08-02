--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_item_replace"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["15"] = 4,
		["16"] = 4,
		["17"] = 4,
		["18"] = 7,
		["19"] = 9,
		["20"] = 10,
		["21"] = 7,
		["22"] = 12,
		["23"] = 13,
		["24"] = 14,
		["25"] = 15,
		["26"] = 16,
		["28"] = 12,
		["29"] = 19,
		["30"] = 20,
		["31"] = 21,
		["32"] = 22,
		["33"] = 23,
		["35"] = 19,
		["36"] = 29,
		["37"] = 30,
		["38"] = 31,
		["39"] = 34,
		["40"] = 34,
		["41"] = 35,
		["42"] = 36,
		["43"] = 37,
		["44"] = 36,
		["45"] = 35,
		["46"] = 34,
		["47"] = 35,
		["49"] = 42,
		["50"] = 42,
		["51"] = 50,
		["52"] = 50,
		["53"] = 42,
		["54"] = 42,
		["55"] = 42,
		["56"] = 42,
		["57"] = 42,
		["58"] = 42,
		["59"] = 42,
		["60"] = 42,
		["61"] = 50,
		["63"] = 29,
		["64"] = 53,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
local o = c()
o.name = "TraitItemReplaceModifier"
d(o, m)
function o.prototype.GetAbilitySpecialValue(self)
	self.item = self:GetAbilitySpecialAddedValueFor("item", "value")
	self.level = self:GetAbilitySpecialValueFor("level")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = PlayerData:getHero(q)
		r:modifyOverrideItem(self.item, self.level, false)
	end
end
function o.prototype.OnDestroy(self)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = PlayerData:getHero(q)
		r:modifyOverrideItem(self.item, self.level, true)
	end
end
local function s(self, t)
	local u = "modifier_" .. t
	local v = t
	local w = c()
	w.name = "TraitAbility"
	d(w, j)
	function w.prototype.GetIntrinsicModifierName(self)
		return u
	end
	w = e({ k(nil, v) }, w)
	local x = c()
	x.name = "TraitModifier"
	d(x, o)
	x = e(
		{
			n(
				a,
				{
					name = u,
					IsHidden = true,
					IsDebuff = false,
					IsPurgable = false,
					IsPurgeException = false,
					AllowIllusionDuplicate = false,
				}
			),
		},
		x
	)
end
f({ "trait_132", "trait_136" }, s)
return h