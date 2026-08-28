--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_16"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__StringSplit
local g = b.__TS__ArrayIncludes
local h = b.__TS__ArrayForEach
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 1,
		["12"] = 1,
		["13"] = 1,
		["14"] = 2,
		["15"] = 2,
		["16"] = 2,
		["17"] = 5,
		["18"] = 6,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 7,
		["24"] = 6,
		["25"] = 5,
		["26"] = 6,
		["28"] = 6,
		["29"] = 12,
		["30"] = 19,
		["31"] = 12,
		["32"] = 19,
		["33"] = 21,
		["34"] = 22,
		["35"] = 21,
		["36"] = 24,
		["37"] = 25,
		["38"] = 24,
		["39"] = 29,
		["40"] = 30,
		["41"] = 31,
		["42"] = 32,
		["45"] = 33,
		["48"] = 34,
		["51"] = 35,
		["52"] = 36,
		["53"] = 37,
		["54"] = 37,
		["55"] = 37,
		["56"] = 37,
		["57"] = 38,
		["58"] = 38,
		["59"] = 39,
		["60"] = 39,
		["61"] = 39,
		["63"] = 39,
		["65"] = 38,
		["66"] = 42,
		["67"] = 43,
		["68"] = 43,
		["69"] = 43,
		["70"] = 43,
		["71"] = 43,
		["72"] = 43,
		["73"] = 43,
		["74"] = 44,
		["77"] = 45,
		["78"] = 46,
		["79"] = 47,
		["80"] = 48,
		["81"] = 53,
		["82"] = 53,
		["83"] = 53,
		["84"] = 53,
		["85"] = 53,
		["87"] = 43,
		["88"] = 43,
		["90"] = 29,
		["91"] = 19,
		["92"] = 12,
		["93"] = 12,
		["94"] = 12,
		["95"] = 12,
		["96"] = 12,
		["97"] = 12,
		["98"] = 12,
		["99"] = 19,
		["101"] = 19,
	}
)
local j = {}
local k = require("lib.dota_ts_adapter")
local l = k.BaseAbility
local m = k.registerAbility
local n = require("modifiers.eom_modifier")
local o = n.EOMModifier
local p = n.registerEOMModifier
j.trait_16 = c()
local q = j.trait_16
q.name = "trait_16"
d(q, l)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_16"
end
q = e({ m(nil) }, q)
j.trait_16 = q
j.modifier_trait_16 = c()
local r = j.modifier_trait_16
r.name = "modifier_trait_16"
d(r, o)
function r.prototype.GetAbilitySpecialValue(self)
	self.max_count = self:GetAbilitySpecialValueFor("max_count")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP] = { -1, -1 } }
end
function r.prototype.OnHeroLevelUp(self, s)
	local t = self:GetParent()
	local u = self:GetParent():GetPlayerOwnerID()
	if s.player_id ~= t:GetPlayerOwnerID() then
		return
	end
	if self:GetStackCount() >= self.max_count then
		return
	end
	if s.up_lvl <= 0 then
		return
	end
	local v = PlayerData:getHero(u)
	local w = s.up_lvl
	local x = f(AbilityShop:GetRecommendSectByHeroName(v.unitName), "|")
	local y = AbilityShop
	local z = AbilityShop.getRandomAbility
	local A
	if g(x, "sect_none") then
		A = nil
	else
		A = x
	end
	local B = z(y, u, w, { specifySect = A, isAbilityShop = false })
	if #B > 0 then
		h(B, function(C, D)
			local E
			local F
			F = D.aid
			E = D.rarity
			if self:GetStackCount() >= self.max_count then
				return
			end
			if F then
				self:IncrementStackCount()
				PlayerData:getHero(u):learnAbility(F, true)
				Notification:combatToPlayer(
					u,
					{
						message = "notify_artifact_ability_" .. E,
						string_itemname_artifact = "DOTA_Tooltip_ability_trait_16",
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. F,
					}
				)
				PlayerData:getplayerData(u):addArtifactAbilities(self:GetAbility():entindex(), F, true)
			end
		end)
	end
end
r = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	r
)
j.modifier_trait_16 = r
return j