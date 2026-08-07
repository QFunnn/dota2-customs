--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_163"
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
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 12,
		["27"] = 19,
		["28"] = 12,
		["29"] = 19,
		["30"] = 23,
		["31"] = 24,
		["32"] = 25,
		["33"] = 23,
		["34"] = 28,
		["35"] = 29,
		["36"] = 28,
		["37"] = 34,
		["38"] = 35,
		["41"] = 36,
		["42"] = 37,
		["43"] = 38,
		["46"] = 40,
		["47"] = 41,
		["50"] = 43,
		["51"] = 44,
		["54"] = 46,
		["55"] = 50,
		["57"] = 51,
		["58"] = 51,
		["60"] = 52,
		["61"] = 53,
		["62"] = 53,
		["63"] = 53,
		["64"] = 53,
		["65"] = 53,
		["66"] = 53,
		["67"] = 53,
		["68"] = 53,
		["69"] = 58,
		["70"] = 58,
		["71"] = 58,
		["72"] = 58,
		["73"] = 58,
		["77"] = 34,
		["78"] = 19,
		["79"] = 12,
		["80"] = 12,
		["81"] = 12,
		["82"] = 12,
		["83"] = 12,
		["84"] = 12,
		["85"] = 12,
		["86"] = 19,
		["88"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_163 = c()
local n = g.trait_163
n.name = "trait_163"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_163"
end
n = e({ j(nil) }, n)
g.trait_163 = n
g.modifier_trait_163 = c()
local o = g.modifier_trait_163
o.name = "modifier_trait_163"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.rank = self:GetAbilitySpecialValueFor("rank")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 } }
end
function o.prototype.OnRoundChange(self, p)
	if not IsServer() then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	local r = PlayerData:getHero(q)
	if not r then
		return
	end
	local s = r:getDisplaySectList()
	if #s < self.rank then
		return
	end
	local t = s[self.rank]
	if not t then
		return
	end
	local u = AbilityShop:getRandomAbility(q, self.count, { specifySect = { t }, isAbilityShop = false })
	for v, w in ipairs(u) do
		do
			if not w then
				goto x
			end
			r:learnAbility(w.aid, true)
			Notification:combatToPlayer(
				q,
				{
					message = "notify_artifact_ability_" .. w.rarity,
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. w.aid,
				}
			)
			PlayerData:getplayerData(q):addArtifactAbilities(self:GetAbility():entindex(), w.aid, true)
		end
		::x::
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_163 = o
return g