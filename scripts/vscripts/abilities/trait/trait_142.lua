--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_142"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 2,
		["9"] = 2,
		["10"] = 2,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
		["14"] = 6,
		["15"] = 7,
		["16"] = 6,
		["17"] = 7,
		["18"] = 8,
		["19"] = 9,
		["20"] = 8,
		["21"] = 7,
		["22"] = 6,
		["23"] = 7,
		["25"] = 7,
		["26"] = 13,
		["27"] = 20,
		["28"] = 13,
		["29"] = 20,
		["30"] = 26,
		["31"] = 27,
		["32"] = 28,
		["33"] = 29,
		["34"] = 26,
		["35"] = 31,
		["36"] = 32,
		["37"] = 33,
		["38"] = 34,
		["40"] = 31,
		["41"] = 37,
		["42"] = 38,
		["43"] = 39,
		["44"] = 39,
		["45"] = 38,
		["46"] = 37,
		["47"] = 42,
		["48"] = 43,
		["49"] = 44,
		["51"] = 44,
		["53"] = 44,
		["54"] = 44,
		["55"] = 44,
		["57"] = 44,
		["58"] = 45,
		["59"] = 46,
		["60"] = 47,
		["61"] = 48,
		["62"] = 49,
		["63"] = 50,
		["64"] = 51,
		["65"] = 52,
		["66"] = 53,
		["67"] = 54,
		["68"] = 54,
		["69"] = 54,
		["70"] = 54,
		["71"] = 54,
		["74"] = 42,
		["75"] = 20,
		["76"] = 13,
		["77"] = 13,
		["78"] = 13,
		["79"] = 13,
		["80"] = 13,
		["81"] = 13,
		["82"] = 13,
		["83"] = 20,
		["85"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_142 = c()
local n = g.trait_142
n.name = "trait_142"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_142"
end
n = e({ j(nil) }, n)
g.trait_142 = n
g.modifier_trait_142 = c()
local o = g.modifier_trait_142
o.name = "modifier_trait_142"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.n_count = self:GetAbilitySpecialValueFor("n_count")
	self.r_count = self:GetAbilitySpecialValueFor("r_count")
	self.sr_count = self:GetAbilitySpecialValueFor("sr_count")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self.record = 0
		self.current = 0
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY] = { self:GetParent(), -1 } }
end
function o.prototype.OnAbilityBuy(self, p)
	if IsServer() then
		local q = KeyValues.AbilityUpgradesKvs[p.abilityname]
		if q ~= nil then
			q = q.rarity
		end
		local r = q
		if r == nil then
			r = "n"
		end
		local s = r
		local t = self[s .. "_count"] or self.n_count
		local u = self:GetParent():GetPlayerOwnerID()
		self.current = self.current + t
		self.record = self.record + t
		if self.current >= 1 then
			local v = math.floor(self.current)
			self.current = self.current % 1
			PlayerData:ModifyFreeRefresh(u, v)
			PlayerData:ModifyFreeRefreshByKey(u, "trait_142", v)
			PlayerData:getplayerData(u)
				:modifyArtifactExtraStringData(
					self:GetAbility():entindex(),
					"free_refresh_count",
					tostring(self.record)
				)
		end
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_142 = o
return g