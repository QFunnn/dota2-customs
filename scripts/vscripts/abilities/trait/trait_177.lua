--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_177"
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
		["16"] = 8,
		["17"] = 9,
		["18"] = 8,
		["19"] = 9,
		["20"] = 10,
		["21"] = 10,
		["22"] = 10,
		["23"] = 9,
		["24"] = 8,
		["25"] = 9,
		["27"] = 9,
		["28"] = 13,
		["29"] = 20,
		["30"] = 13,
		["31"] = 20,
		["33"] = 20,
		["34"] = 24,
		["35"] = 13,
		["36"] = 26,
		["37"] = 27,
		["38"] = 28,
		["39"] = 29,
		["40"] = 26,
		["41"] = 32,
		["42"] = 33,
		["45"] = 34,
		["46"] = 35,
		["47"] = 36,
		["50"] = 37,
		["51"] = 38,
		["52"] = 39,
		["53"] = 32,
		["54"] = 41,
		["55"] = 41,
		["56"] = 41,
		["57"] = 42,
		["58"] = 43,
		["59"] = 44,
		["60"] = 44,
		["61"] = 44,
		["64"] = 42,
		["65"] = 47,
		["66"] = 48,
		["67"] = 49,
		["68"] = 50,
		["70"] = 47,
		["71"] = 53,
		["72"] = 54,
		["73"] = 55,
		["75"] = 56,
		["76"] = 56,
		["78"] = 57,
		["79"] = 58,
		["80"] = 58,
		["81"] = 58,
		["82"] = 58,
		["83"] = 58,
		["84"] = 58,
		["85"] = 58,
		["86"] = 58,
		["87"] = 63,
		["88"] = 63,
		["89"] = 63,
		["90"] = 63,
		["91"] = 63,
		["95"] = 53,
		["96"] = 20,
		["97"] = 13,
		["98"] = 13,
		["99"] = 13,
		["100"] = 13,
		["101"] = 13,
		["102"] = 13,
		["103"] = 13,
		["104"] = 20,
		["106"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = "sect_ulti"
local o = "item_ulti_power"
g.trait_177 = c()
local p = g.trait_177
p.name = "trait_177"
d(p, i)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_177"
end
p = e({ j(nil) }, p)
g.trait_177 = p
g.modifier_trait_177 = c()
local q = g.modifier_trait_177
q.name = "modifier_trait_177"
d(q, l)
function q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.rareGranted = false
end
function q.prototype.GetAbilitySpecialValue(self)
	self.stack = self:GetAbilitySpecialValueFor("stack")
	self.count = self:GetAbilitySpecialValueFor("count")
	self.r_count = self:GetAbilitySpecialValueFor("r_count")
end
function q.prototype.OnCreated(self, r)
	if not IsServer() then
		return
	end
	local s = self:GetParent():GetPlayerOwnerID()
	local t = PlayerData:getHero(s)
	if not t then
		return
	end
	t:addProperty(o, self.stack)
	self:GrantCards(t, s, "n", self.count)
	self:TryGrantRare(t, s)
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP] = { -1, -1 } }
end
function q.prototype.OnHeroLevelUp(self, r)
	if r.player_id == self:GetParent():GetPlayerOwnerID() then
		local t = PlayerData:getHero(r.player_id)
		if t then
			self:TryGrantRare(t, r.player_id)
		end
	end
end
function q.prototype.TryGrantRare(self, t, s)
	if not self.rareGranted and t:getLevel() >= 15 then
		self.rareGranted = true
		self:GrantCards(t, s, "r", self.r_count)
	end
end
function q.prototype.GrantCards(self, t, s, u, v)
	local w = AbilityShop:getRandomAbility(
		s,
		v,
		{ specifySect = { n }, specifyRarity = u, specifyRarityIgnoreRule = true, isAbilityShop = false }
	)
	for x, y in ipairs(w) do
		do
			if not y then
				goto z
			end
			t:learnAbility(y.aid, true)
			Notification:combatToPlayer(
				s,
				{
					message = "notify_artifact_ability_" .. y.rarity,
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. y.aid,
				}
			)
			PlayerData:getplayerData(s):addArtifactAbilities(self:GetAbility():entindex(), y.aid, true)
		end
		::z::
	end
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_trait_177 = q
return g