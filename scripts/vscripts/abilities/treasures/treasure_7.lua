--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_7"
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
		["26"] = 10,
		["27"] = 17,
		["28"] = 10,
		["29"] = 17,
		["31"] = 17,
		["32"] = 18,
		["33"] = 10,
		["34"] = 19,
		["35"] = 23,
		["36"] = 19,
		["37"] = 27,
		["38"] = 28,
		["39"] = 29,
		["41"] = 27,
		["42"] = 31,
		["43"] = 34,
		["44"] = 35,
		["46"] = 31,
		["47"] = 37,
		["48"] = 38,
		["50"] = 38,
		["51"] = 38,
		["53"] = 38,
		["56"] = 40,
		["57"] = 41,
		["58"] = 42,
		["59"] = 43,
		["60"] = 44,
		["61"] = 37,
		["62"] = 17,
		["63"] = 10,
		["64"] = 10,
		["65"] = 10,
		["66"] = 10,
		["67"] = 10,
		["68"] = 10,
		["69"] = 10,
		["70"] = 17,
		["72"] = 17,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_7 = c()
local n = g.treasure_7
n.name = "treasure_7"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_7"
end
n = e({ j(nil) }, n)
g.treasure_7 = n
g.modifier_treasure_7 = c()
local o = g.modifier_treasure_7
o.name = "modifier_treasure_7"
d(o, l)
function o.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.triggered = false
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP] = { -1, -1 } }
end
function o.prototype.OnCreated(self)
	if IsServer() then
		self:tryTrigger()
	end
end
function o.prototype.OnHeroLevelUp(self, p)
	if p.player_id == self:GetParent():GetPlayerOwnerID() then
		self:tryTrigger()
	end
end
function o.prototype.tryTrigger(self)
	local q = self.triggered
	if not q then
		local r = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
		q = (r and r:getLevel() or 1) < self:GetAbilitySpecialValueFor("level_target")
	end
	if q then
		return
	end
	self.triggered = true
	local s = self:GetParent():GetPlayerOwnerID()
	local t = self:GetAbilitySpecialValueFor("free_refresh_count")
	PlayerData:ModifyFreeRefresh(s, t)
	PlayerData:ModifyFreeRefreshByKey(s, "treasure_7", t)
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_treasure_7 = o
return g