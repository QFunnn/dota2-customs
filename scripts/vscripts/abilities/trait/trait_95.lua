--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
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
		["33"] = 27,
		["34"] = 28,
		["35"] = 29,
		["36"] = 30,
		["37"] = 31,
		["38"] = 32,
		["39"] = 33,
		["40"] = 34,
		["42"] = 27,
		["43"] = 37,
		["44"] = 38,
		["45"] = 39,
		["46"] = 39,
		["47"] = 38,
		["48"] = 37,
		["49"] = 42,
		["50"] = 43,
		["53"] = 46,
		["54"] = 47,
		["55"] = 48,
		["56"] = 48,
		["57"] = 49,
		["58"] = 50,
		["59"] = 51,
		["60"] = 52,
		["61"] = 53,
		["62"] = 54,
		["63"] = 55,
		["64"] = 55,
		["65"] = 55,
		["66"] = 55,
		["68"] = 57,
		["69"] = 58,
		["71"] = 60,
		["72"] = 61,
		["73"] = 62,
		["74"] = 63,
		["75"] = 64,
		["76"] = 65,
		["77"] = 66,
		["78"] = 67,
		["79"] = 68,
		["80"] = 68,
		["81"] = 68,
		["82"] = 68,
		["83"] = 68,
		["84"] = 72,
		["85"] = 72,
		["86"] = 72,
		["87"] = 72,
		["88"] = 72,
		["89"] = 73,
		["92"] = 74,
		["93"] = 75,
		["94"] = 75,
		["95"] = 75,
		["96"] = 75,
		["97"] = 75,
		["98"] = 75,
		["99"] = 75,
		["100"] = 76,
		["101"] = 76,
		["102"] = 76,
		["103"] = 76,
		["104"] = 76,
		["105"] = 76,
		["106"] = 76,
		["107"] = 76,
		["108"] = 81,
		["109"] = 81,
		["110"] = 81,
		["111"] = 81,
		["112"] = 81,
		["117"] = 42,
		["118"] = 20,
		["119"] = 13,
		["120"] = 13,
		["121"] = 13,
		["122"] = 13,
		["123"] = 13,
		["124"] = 13,
		["125"] = 13,
		["126"] = 20,
		["128"] = 20,
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
	self.limit = self:GetAbilitySpecialValueFor("limit")
	if IsServer() then
		self.record = self.record or 0
		self.reward_count = self.reward_count or 0
	end
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = { self:GetParent(), -1 } }
end
function r.prototype.OnAbilityLearn(self, s)
	if s.ignoreKey == "trait_95" or self.reward_count >= self.limit then
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
				local F = AbilityShop:getRandomAbility(
					t,
					math.min(self.count2, self.limit - self.reward_count),
					{ specifySect = A, isAbilityShop = false }
				)
				for G, H in ipairs(F) do
					local I
					local J
					J = H.aid
					I = H.rarity
					if self.reward_count >= self.limit then
						break
					end
					self.reward_count = self.reward_count + 1
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