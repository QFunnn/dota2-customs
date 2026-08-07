--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_174"
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
		["28"] = 12,
		["29"] = 19,
		["30"] = 12,
		["31"] = 19,
		["33"] = 19,
		["34"] = 23,
		["35"] = 12,
		["36"] = 25,
		["37"] = 26,
		["38"] = 27,
		["39"] = 28,
		["40"] = 25,
		["41"] = 31,
		["42"] = 32,
		["45"] = 33,
		["46"] = 34,
		["47"] = 35,
		["50"] = 36,
		["51"] = 37,
		["52"] = 38,
		["53"] = 31,
		["54"] = 40,
		["55"] = 41,
		["56"] = 40,
		["57"] = 43,
		["58"] = 44,
		["61"] = 45,
		["62"] = 46,
		["63"] = 46,
		["65"] = 43,
		["66"] = 48,
		["67"] = 49,
		["68"] = 50,
		["69"] = 51,
		["71"] = 48,
		["72"] = 54,
		["73"] = 55,
		["74"] = 56,
		["76"] = 57,
		["77"] = 57,
		["79"] = 58,
		["80"] = 59,
		["81"] = 59,
		["82"] = 59,
		["83"] = 59,
		["84"] = 59,
		["85"] = 59,
		["86"] = 59,
		["87"] = 59,
		["88"] = 64,
		["89"] = 64,
		["90"] = 64,
		["91"] = 64,
		["92"] = 64,
		["96"] = 54,
		["97"] = 19,
		["98"] = 12,
		["99"] = 12,
		["100"] = 12,
		["101"] = 12,
		["102"] = 12,
		["103"] = 12,
		["104"] = 12,
		["105"] = 19,
		["107"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = "sect_ice"
local o = "item_ice_count"
g.trait_174 = c()
local p = g.trait_174
p.name = "trait_174"
d(p, i)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_174"
end
p = e({ j(nil) }, p)
g.trait_174 = p
g.modifier_trait_174 = c()
local q = g.modifier_trait_174
q.name = "modifier_trait_174"
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
	if r.player_id ~= self:GetParent():GetPlayerOwnerID() then
		return
	end
	local t = PlayerData:getHero(r.player_id)
	if t then
		self:TryGrantRare(t, r.player_id)
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
g.modifier_trait_174 = q
return g