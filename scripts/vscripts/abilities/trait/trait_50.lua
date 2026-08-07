--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_50"
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
		["15"] = 5,
		["16"] = 6,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 8,
		["21"] = 7,
		["22"] = 6,
		["23"] = 5,
		["24"] = 6,
		["26"] = 6,
		["27"] = 12,
		["28"] = 19,
		["29"] = 12,
		["30"] = 19,
		["31"] = 21,
		["32"] = 22,
		["33"] = 21,
		["34"] = 24,
		["35"] = 25,
		["36"] = 26,
		["37"] = 27,
		["38"] = 28,
		["39"] = 29,
		["40"] = 34,
		["41"] = 34,
		["42"] = 34,
		["43"] = 34,
		["44"] = 34,
		["45"] = 34,
		["46"] = 34,
		["47"] = 35,
		["48"] = 36,
		["49"] = 36,
		["50"] = 36,
		["51"] = 36,
		["52"] = 36,
		["53"] = 36,
		["54"] = 36,
		["55"] = 36,
		["56"] = 41,
		["57"] = 41,
		["58"] = 41,
		["59"] = 41,
		["60"] = 41,
		["61"] = 34,
		["62"] = 34,
		["64"] = 24,
		["65"] = 19,
		["66"] = 12,
		["67"] = 12,
		["68"] = 12,
		["69"] = 12,
		["70"] = 12,
		["71"] = 12,
		["72"] = 12,
		["73"] = 19,
		["75"] = 19,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.trait_50 = c()
local o = h.trait_50
o.name = "trait_50"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_50"
end
o = e({ k(nil) }, o)
h.trait_50 = o
h.modifier_trait_50 = c()
local p = h.modifier_trait_50
p.name = "modifier_trait_50"
d(p, m)
function p.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		local r = self:GetParent()
		local s = r:GetPlayerOwnerID()
		local t = PlayerData:getHero(s)
		local u = AbilityShop:getRandomAbility(
			s,
			self.count,
			{ specifyRarity = "r", specifyRarityIgnoreRule = true, isAbilityShop = false }
		)
		f(u, function(v, w, x)
			local y
			local z
			z = w.aid
			y = w.rarity
			t:learnAbility(z, true)
			Notification:combatToPlayer(
				s,
				{
					message = "notify_artifact_ability_" .. y,
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. z,
				}
			)
			PlayerData:getplayerData(s):addArtifactAbilities(self:GetAbility():entindex(), z, x == #u - 1)
		end)
	end
end
p = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	p
)
h.modifier_trait_50 = p
return h