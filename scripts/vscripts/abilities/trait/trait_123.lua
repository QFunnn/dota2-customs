--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_123"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__StringSplit
local g = b.__TS__ArrayForEach
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
		["16"] = 5,
		["17"] = 6,
		["18"] = 5,
		["19"] = 6,
		["20"] = 7,
		["21"] = 8,
		["22"] = 7,
		["23"] = 6,
		["24"] = 5,
		["25"] = 6,
		["27"] = 6,
		["28"] = 12,
		["29"] = 19,
		["30"] = 12,
		["31"] = 19,
		["33"] = 19,
		["34"] = 21,
		["35"] = 12,
		["36"] = 22,
		["37"] = 23,
		["38"] = 22,
		["39"] = 25,
		["40"] = 26,
		["41"] = 27,
		["43"] = 25,
		["44"] = 30,
		["45"] = 31,
		["46"] = 30,
		["47"] = 35,
		["48"] = 36,
		["49"] = 35,
		["50"] = 38,
		["51"] = 39,
		["54"] = 40,
		["55"] = 41,
		["56"] = 42,
		["57"] = 43,
		["58"] = 44,
		["59"] = 45,
		["60"] = 46,
		["61"] = 47,
		["63"] = 49,
		["64"] = 53,
		["65"] = 53,
		["66"] = 53,
		["67"] = 53,
		["68"] = 53,
		["69"] = 53,
		["70"] = 53,
		["71"] = 54,
		["72"] = 54,
		["73"] = 54,
		["74"] = 54,
		["75"] = 54,
		["76"] = 54,
		["77"] = 54,
		["78"] = 54,
		["79"] = 59,
		["80"] = 60,
		["81"] = 60,
		["82"] = 60,
		["83"] = 60,
		["84"] = 60,
		["85"] = 53,
		["86"] = 53,
		["88"] = 38,
		["89"] = 19,
		["90"] = 12,
		["91"] = 12,
		["92"] = 12,
		["93"] = 12,
		["94"] = 12,
		["95"] = 12,
		["96"] = 12,
		["97"] = 19,
		["99"] = 19,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseAbility
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
i.trait_123 = c()
local p = i.trait_123
p.name = "trait_123"
d(p, k)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_123"
end
p = e({ l(nil) }, p)
i.trait_123 = p
i.modifier_trait_123 = c()
local q = i.modifier_trait_123
q.name = "modifier_trait_123"
d(q, n)
function q.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.trigger_cnt = 2
end
function q.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
end
function q.prototype.OnCreated(self, r)
	if IsServer() then
		self:Effect()
	end
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_SELECTED] = { self:GetParent() } }
end
function q.prototype.OnTraitSelected(self, r)
	self:Effect()
end
function q.prototype.Effect(self)
	if self.trigger_cnt <= 0 then
		return
	end
	self.trigger_cnt = self.trigger_cnt - 1
	local s = self:GetParent():GetPlayerOwnerID()
	local t = PlayerData:getHero(s)
	if t then
		local u = AbilityShop:GetRecommendSectByHeroName(t.unitName)
		local v
		if u ~= "sect_none" then
			v = f(u, "|")
		end
		local w = AbilityShop:getRandomAbility(s, self.count, { isAbilityShop = false })
		g(w, function(x, y, z)
			local A
			local B
			B = y.aid
			A = y.rarity
			Notification:combatToPlayer(
				s,
				{
					message = "notify_artifact_ability_" .. A,
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. B,
				}
			)
			t:learnAbility(B, true)
			PlayerData:getplayerData(s):addArtifactAbilities(self:GetAbility():entindex(), B, z == #w - 1)
		end)
	end
end
q = e(
	{ o(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
i.modifier_trait_123 = q
return i