--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_96"
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
		["39"] = 25,
		["40"] = 32,
		["41"] = 33,
		["42"] = 34,
		["43"] = 34,
		["44"] = 33,
		["45"] = 32,
		["46"] = 37,
		["47"] = 38,
		["50"] = 41,
		["51"] = 42,
		["52"] = 43,
		["53"] = 43,
		["54"] = 44,
		["55"] = 45,
		["56"] = 46,
		["57"] = 47,
		["58"] = 48,
		["59"] = 49,
		["60"] = 49,
		["61"] = 49,
		["62"] = 49,
		["64"] = 53,
		["65"] = 54,
		["66"] = 55,
		["67"] = 56,
		["68"] = 57,
		["69"] = 58,
		["70"] = 59,
		["71"] = 60,
		["72"] = 61,
		["73"] = 64,
		["74"] = 64,
		["75"] = 64,
		["76"] = 64,
		["77"] = 64,
		["78"] = 65,
		["79"] = 65,
		["80"] = 65,
		["81"] = 65,
		["82"] = 65,
		["83"] = 65,
		["84"] = 65,
		["85"] = 66,
		["86"] = 66,
		["87"] = 66,
		["88"] = 66,
		["89"] = 66,
		["90"] = 66,
		["91"] = 66,
		["92"] = 66,
		["93"] = 71,
		["94"] = 71,
		["95"] = 71,
		["96"] = 71,
		["97"] = 71,
		["102"] = 37,
		["103"] = 20,
		["104"] = 13,
		["105"] = 13,
		["106"] = 13,
		["107"] = 13,
		["108"] = 13,
		["109"] = 13,
		["110"] = 13,
		["111"] = 20,
		["113"] = 20,
	}
)
local j = {}
local k = require("lib.dota_ts_adapter")
local l = k.BaseAbility
local m = k.registerAbility
local n = require("modifiers.eom_modifier")
local o = n.EOMModifier
local p = n.registerEOMModifier
j.trait_96 = c()
local q = j.trait_96
q.name = "trait_96"
d(q, l)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_96"
end
q = e({ m(nil) }, q)
j.trait_96 = q
j.modifier_trait_96 = c()
local r = j.modifier_trait_96
r.name = "modifier_trait_96"
d(r, o)
function r.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.count2 = self:GetAbilitySpecialValueFor("count2")
	if IsServer() then
		self.record = 0
	end
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = { self:GetParent(), -1 } }
end
function r.prototype.OnAbilityLearn(self, s)
	if s.ignoreKey == "trait_96" then
		return
	end
	local t = self:GetParent():GetPlayerOwnerID()
	local u = KeyValues.AbilityUpgradesKvs[s.abilityname].sect
	local v = PlayerData:getplayerData(t)
	local w = v and v.heroName
	local x = AbilityShop:GetRecommendSectByHeroName(w)
	local y = false
	local z
	if x ~= "sect_none" then
		z = f(x, "|")
		y = h(z, function(A, B)
			return g(u, B)
		end)
	end
	if y then
		self.record = self.record + 1
		if self.record >= self.count then
			self.record = 0
			local t = self:GetParent():GetPlayerOwnerID()
			local C = PlayerData:getplayerData(t)
			local D = C.hero
			if D then
				local E = AbilityShop:getRandomAbility(t, self.count2, { isAbilityShop = false })
				for F, G in ipairs(E) do
					local H
					local I
					I = G.aid
					H = G.rarity
					D:learnAbility(I, true, nil, nil, "trait_96")
					Notification:combatToPlayer(
						t,
						{
							message = "notify_artifact_ability_" .. H,
							string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. I,
						}
					)
					PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
						:addArtifactAbilities(self:GetAbility():entindex(), I, true)
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
j.modifier_trait_96 = r
return j