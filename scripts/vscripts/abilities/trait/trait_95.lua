--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_95"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__StringSplit
local g = b.__TS__StringIncludes
local h = b.__TS__ArraySome
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 3,
		["15"] = 3,
		["16"] = 3,
		["17"] = 6,
		["18"] = 7,
		["19"] = 6,
		["20"] = 7,
		["21"] = 8,
		["22"] = 9,
		["23"] = 8,
		["24"] = 7,
		["25"] = 6,
		["26"] = 7,
		["28"] = 7,
		["29"] = 13,
		["30"] = 20,
		["31"] = 13,
		["32"] = 20,
		["33"] = 25,
		["34"] = 26,
		["35"] = 27,
		["36"] = 28,
		["37"] = 29,
		["38"] = 30,
		["40"] = 25,
		["41"] = 33,
		["42"] = 34,
		["43"] = 35,
		["44"] = 35,
		["45"] = 34,
		["46"] = 33,
		["47"] = 38,
		["48"] = 39,
		["51"] = 42,
		["52"] = 43,
		["53"] = 44,
		["54"] = 44,
		["55"] = 45,
		["56"] = 46,
		["57"] = 47,
		["58"] = 48,
		["59"] = 49,
		["60"] = 50,
		["61"] = 51,
		["62"] = 51,
		["63"] = 51,
		["64"] = 51,
		["66"] = 53,
		["67"] = 54,
		["69"] = 56,
		["70"] = 57,
		["71"] = 58,
		["72"] = 59,
		["73"] = 60,
		["74"] = 61,
		["75"] = 62,
		["76"] = 63,
		["77"] = 64,
		["78"] = 68,
		["79"] = 68,
		["80"] = 68,
		["81"] = 68,
		["82"] = 68,
		["83"] = 69,
		["84"] = 69,
		["85"] = 69,
		["86"] = 69,
		["87"] = 69,
		["88"] = 69,
		["89"] = 69,
		["90"] = 70,
		["91"] = 70,
		["92"] = 70,
		["93"] = 70,
		["94"] = 70,
		["95"] = 70,
		["96"] = 70,
		["97"] = 70,
		["98"] = 75,
		["99"] = 75,
		["100"] = 75,
		["101"] = 75,
		["102"] = 75,
		["107"] = 38,
		["108"] = 20,
		["109"] = 13,
		["110"] = 13,
		["111"] = 13,
		["112"] = 13,
		["113"] = 13,
		["114"] = 13,
		["115"] = 13,
		["116"] = 20,
		["118"] = 20,
	}
)
local j = {}
local k = require("lib.dota_ts_adapter")
local l = k.BaseAbility
local m = k.registerAbility
local n = require("modifiers.eom_modifier")
local o = n.EOMModifier
local p = n.registerEOMModifier
j.trait_95 = c()
local q = j.trait_95
q.name = "trait_95"
d(q, l)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_95"
end
q = e({ m(nil) }, q)
j.trait_95 = q
j.modifier_trait_95 = c()
local r = j.modifier_trait_95
r.name = "modifier_trait_95"
d(r, o)
function r.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.count2 = self:GetAbilitySpecialValueFor("count2")
	self.sect_none_add_cnt = self:GetAbilitySpecialValueFor("sect_none_add_cnt")
	if IsServer() then
		self.record = 0
	end
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = { self:GetParent(), -1 } }
end
function r.prototype.OnAbilityLearn(self, s)
	if s.ignoreKey == "trait_95" then
		return
	end
	local t = self:GetParent():GetPlayerOwnerID()
	local u = KeyValues.AbilityUpgradesKvs[s.abilityname].sect
	local v = PlayerData:getplayerData(t)
	local w = v and v.heroName
	local x = AbilityShop:GetRecommendSectByHeroName(w)
	local y = false
	local z = 0
	local A
	if x ~= "sect_none" then
		A = f(x, "|")
		y = not h(A, function(B, C)
			return g(u, C)
		end)
	else
		z = self.sect_none_add_cnt
		y = true
	end
	if y then
		self.record = self.record + 1
		if self.record >= self.count + z then
			self.record = 0
			local t = self:GetParent():GetPlayerOwnerID()
			local D = PlayerData:getplayerData(t)
			local E = D.hero
			if E then
				local F = AbilityShop:getRandomAbility(t, self.count2, { specifySect = A, isAbilityShop = false })
				for G, H in ipairs(F) do
					local I
					local J
					J = H.aid
					I = H.rarity
					E:learnAbility(J, true, nil, nil, "trait_95")
					Notification:combatToPlayer(
						t,
						{
							message = "notify_artifact_ability_" .. I,
							string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. J,
						}
					)
					PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
						:addArtifactAbilities(self:GetAbility():entindex(), J, true)
				end
			end
		end
	end
end
r = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	r
)
j.modifier_trait_95 = r
return j