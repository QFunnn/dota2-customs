--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_183"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ObjectKeys
local g = b.__TS__ArrayFilter
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
		["21"] = 6,
		["22"] = 6,
		["23"] = 5,
		["24"] = 4,
		["25"] = 5,
		["27"] = 5,
		["28"] = 9,
		["29"] = 16,
		["30"] = 9,
		["31"] = 16,
		["32"] = 18,
		["33"] = 19,
		["34"] = 18,
		["35"] = 21,
		["36"] = 22,
		["37"] = 21,
		["38"] = 24,
		["39"] = 25,
		["42"] = 28,
		["43"] = 29,
		["44"] = 30,
		["47"] = 33,
		["48"] = 33,
		["49"] = 33,
		["50"] = 33,
		["52"] = 33,
		["54"] = 33,
		["55"] = 33,
		["56"] = 33,
		["57"] = 34,
		["59"] = 35,
		["60"] = 35,
		["61"] = 36,
		["62"] = 37,
		["63"] = 38,
		["64"] = 39,
		["65"] = 39,
		["66"] = 39,
		["67"] = 39,
		["68"] = 39,
		["69"] = 39,
		["70"] = 39,
		["71"] = 39,
		["72"] = 40,
		["73"] = 40,
		["74"] = 40,
		["75"] = 40,
		["76"] = 40,
		["77"] = 35,
		["80"] = 24,
		["81"] = 16,
		["82"] = 9,
		["83"] = 9,
		["84"] = 9,
		["85"] = 9,
		["86"] = 9,
		["87"] = 9,
		["88"] = 9,
		["89"] = 16,
		["91"] = 16,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseAbility
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
i.trait_183 = c()
local p = i.trait_183
p.name = "trait_183"
d(p, k)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_183"
end
p = e({ l(nil) }, p)
i.trait_183 = p
i.modifier_trait_183 = c()
local q = i.modifier_trait_183
q.name = "modifier_trait_183"
d(q, n)
function q.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 } }
end
function q.prototype.OnRoundChange(self)
	if not IsServer() then
		return
	end
	local r = self:GetParent():GetPlayerOwnerID()
	local s = PlayerData:getHero(r)
	if not s then
		return
	end
	local t = g(f(s.abilityShopData), function(u, v)
		local w = KeyValues.AbilityUpgradesKvs[v]
		if w ~= nil then
			w = w.rarity
		end
		return w == "n"
	end)
	local x = math.min(self.count, #t)
	do
		local y = 0
		while y < x do
			local v = GetRandomElement(t)
			ArrayRemove(t, v)
			s:learnAbility(v, true)
			Notification:combatToPlayer(
				r,
				{
					message = "notify_artifact_ability_n",
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. v,
				}
			)
			PlayerData:getplayerData(r):addArtifactAbilities(self:GetAbility():entindex(), v, y == x - 1)
			y = y + 1
		end
	end
end
q = e(
	{ o(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
i.modifier_trait_183 = q
return i