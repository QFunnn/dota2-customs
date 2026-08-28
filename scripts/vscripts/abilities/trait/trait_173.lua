--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_173"
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
		["21"] = 11,
		["22"] = 10,
		["23"] = 9,
		["24"] = 8,
		["25"] = 9,
		["27"] = 9,
		["28"] = 15,
		["29"] = 22,
		["30"] = 15,
		["31"] = 22,
		["33"] = 22,
		["34"] = 26,
		["35"] = 15,
		["36"] = 28,
		["37"] = 29,
		["38"] = 30,
		["39"] = 31,
		["40"] = 28,
		["41"] = 34,
		["42"] = 35,
		["45"] = 36,
		["46"] = 37,
		["47"] = 38,
		["50"] = 39,
		["51"] = 40,
		["52"] = 41,
		["53"] = 34,
		["54"] = 43,
		["55"] = 44,
		["56"] = 43,
		["57"] = 46,
		["58"] = 47,
		["61"] = 48,
		["62"] = 49,
		["63"] = 49,
		["65"] = 46,
		["66"] = 51,
		["67"] = 52,
		["68"] = 53,
		["69"] = 54,
		["71"] = 51,
		["72"] = 57,
		["73"] = 58,
		["74"] = 59,
		["76"] = 60,
		["77"] = 60,
		["79"] = 61,
		["80"] = 62,
		["81"] = 62,
		["82"] = 62,
		["83"] = 62,
		["84"] = 62,
		["85"] = 62,
		["86"] = 62,
		["87"] = 62,
		["88"] = 67,
		["89"] = 67,
		["90"] = 67,
		["91"] = 67,
		["92"] = 67,
		["96"] = 57,
		["97"] = 22,
		["98"] = 15,
		["99"] = 15,
		["100"] = 15,
		["101"] = 15,
		["102"] = 15,
		["103"] = 15,
		["104"] = 15,
		["105"] = 22,
		["107"] = 22,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = "sect_fury"
local o = "item_fury_count"
g.trait_173 = c()
local p = g.trait_173
p.name = "trait_173"
d(p, i)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_173"
end
p = e({ j(nil) }, p)
g.trait_173 = p
g.modifier_trait_173 = c()
local q = g.modifier_trait_173
q.name = "modifier_trait_173"
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
g.modifier_trait_173 = q
return g