--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_176"
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
		["60"] = 45,
		["61"] = 46,
		["64"] = 42,
		["65"] = 50,
		["66"] = 51,
		["67"] = 52,
		["68"] = 53,
		["70"] = 50,
		["71"] = 56,
		["72"] = 57,
		["73"] = 58,
		["75"] = 59,
		["76"] = 59,
		["78"] = 60,
		["79"] = 61,
		["80"] = 61,
		["81"] = 61,
		["82"] = 61,
		["83"] = 61,
		["84"] = 61,
		["85"] = 61,
		["86"] = 61,
		["87"] = 66,
		["88"] = 66,
		["89"] = 66,
		["90"] = 66,
		["91"] = 66,
		["95"] = 56,
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
local n = "sect_shield"
local o = "item_shield_count"
g.trait_176 = c()
local p = g.trait_176
p.name = "trait_176"
d(p, i)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_176"
end
p = e({ j(nil) }, p)
g.trait_176 = p
g.modifier_trait_176 = c()
local q = g.modifier_trait_176
q.name = "modifier_trait_176"
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
g.modifier_trait_176 = q
return g