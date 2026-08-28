--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		["32"] = 19,
		["33"] = 20,
		["34"] = 21,
		["35"] = 19,
		["36"] = 23,
		["37"] = 24,
		["38"] = 23,
		["39"] = 26,
		["40"] = 27,
		["43"] = 30,
		["44"] = 31,
		["45"] = 32,
		["48"] = 35,
		["49"] = 36,
		["50"] = 36,
		["51"] = 36,
		["52"] = 37,
		["53"] = 38,
		["54"] = 38,
		["56"] = 39,
		["57"] = 39,
		["59"] = 39,
		["60"] = 36,
		["61"] = 36,
		["62"] = 41,
		["64"] = 42,
		["65"] = 42,
		["66"] = 43,
		["67"] = 44,
		["68"] = 45,
		["69"] = 46,
		["70"] = 46,
		["71"] = 46,
		["72"] = 46,
		["73"] = 46,
		["74"] = 46,
		["75"] = 46,
		["76"] = 46,
		["77"] = 47,
		["78"] = 47,
		["79"] = 47,
		["80"] = 47,
		["81"] = 47,
		["82"] = 42,
		["85"] = 26,
		["86"] = 16,
		["87"] = 9,
		["88"] = 9,
		["89"] = 9,
		["90"] = 9,
		["91"] = 9,
		["92"] = 9,
		["93"] = 9,
		["94"] = 16,
		["96"] = 16,
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
	self.chanceOne = self:GetAbilitySpecialValueFor("chance_one")
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
	local t = s:getAbilityUpgradeData()
	local u = g(f(s.abilityShopData), function(v, w)
		local x = KeyValues.AbilityUpgradesKvs[w]
		local y = t[w]
		local z = y and y.level or 0
		local A
		if x ~= nil then
			A = x.rarity
		end
		return A == "n" and z < x.MaxLevel
	end)
	local B = RollPercentage(self.chanceOne) and math.min(self.count, #u) or #u
	do
		local C = 0
		while C < B do
			local w = GetRandomElement(u)
			ArrayRemove(u, w)
			s:learnAbility(w, true)
			Notification:combatToPlayer(
				r,
				{
					message = "notify_artifact_ability_n",
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. w,
				}
			)
			PlayerData:getplayerData(r):addArtifactAbilities(self:GetAbility():entindex(), w, C == B - 1)
			C = C + 1
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