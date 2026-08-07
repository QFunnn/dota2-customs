--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_192"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ObjectKeys
local g = b.__TS__Delete
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 1,
		["13"] = 2,
		["14"] = 2,
		["15"] = 2,
		["16"] = 4,
		["17"] = 5,
		["18"] = 4,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 6,
		["23"] = 5,
		["24"] = 4,
		["25"] = 5,
		["27"] = 5,
		["28"] = 11,
		["29"] = 12,
		["30"] = 11,
		["31"] = 12,
		["33"] = 12,
		["34"] = 15,
		["35"] = 11,
		["36"] = 17,
		["37"] = 18,
		["38"] = 19,
		["39"] = 17,
		["40"] = 21,
		["41"] = 22,
		["44"] = 23,
		["46"] = 24,
		["47"] = 24,
		["48"] = 25,
		["49"] = 25,
		["51"] = 24,
		["54"] = 27,
		["55"] = 28,
		["56"] = 29,
		["59"] = 32,
		["60"] = 21,
		["61"] = 34,
		["62"] = 35,
		["63"] = 34,
		["64"] = 37,
		["65"] = 38,
		["68"] = 39,
		["69"] = 40,
		["70"] = 41,
		["71"] = 42,
		["73"] = 42,
		["75"] = 37,
		["76"] = 12,
		["77"] = 11,
		["78"] = 11,
		["79"] = 11,
		["80"] = 11,
		["81"] = 11,
		["82"] = 11,
		["83"] = 11,
		["84"] = 12,
		["86"] = 12,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseAbility
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
i.trait_192 = c()
local p = i.trait_192
p.name = "trait_192"
d(p, k)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_192"
end
p = e({ l(nil) }, p)
i.trait_192 = p
i.modifier_trait_192 = c()
local q = i.modifier_trait_192
q.name = "modifier_trait_192"
d(q, n)
function q.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.nonShardPlayers = {}
end
function q.prototype.GetAbilitySpecialValue(self)
	self.goldGet = self:GetAbilitySpecialValueFor("gold_get")
	self.healthBonus = self:GetAbilitySpecialValueFor("health_bonus")
end
function q.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local r = self:GetParent():GetPlayerOwnerID()
	do
		local s = 0
		while s < PlayerResource:GetPlayerCount() do
			if s ~= r and not PlayerData:isShardUnlock(s) then
				self.nonShardPlayers[s] = true
			end
			s = s + 1
		end
	end
	local t = #f(self.nonShardPlayers) * self:GetAbilitySpecialValueFor("gold_cost")
	if PlayerData:getGold(r) < t then
		self:Destroy()
		return
	end
	PlayerData:modifyGold(r, -t)
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BUY_SHARD] = { -1, -1 } }
end
function q.prototype.OnBuyShard(self, u)
	if not IsServer() or not self.nonShardPlayers[u.playerID] then
		return
	end
	g(self.nonShardPlayers, u.playerID)
	local r = self:GetParent():GetPlayerOwnerID()
	PlayerData:modifyGold(r, self.goldGet)
	local v = PlayerData:getHero(r)
	if v ~= nil then
		v:addProperty("item_health", self.healthBonus)
	end
end
q = e(
	{ o(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
i.modifier_trait_192 = q
return i