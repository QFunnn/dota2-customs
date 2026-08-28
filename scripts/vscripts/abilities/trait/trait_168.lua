--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_168"
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
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 12,
		["27"] = 19,
		["28"] = 12,
		["29"] = 19,
		["30"] = 24,
		["31"] = 25,
		["32"] = 26,
		["33"] = 27,
		["34"] = 24,
		["35"] = 30,
		["36"] = 31,
		["37"] = 30,
		["38"] = 36,
		["39"] = 37,
		["42"] = 38,
		["45"] = 40,
		["46"] = 41,
		["47"] = 42,
		["50"] = 44,
		["51"] = 45,
		["54"] = 47,
		["55"] = 48,
		["58"] = 50,
		["59"] = 54,
		["61"] = 55,
		["62"] = 55,
		["64"] = 56,
		["65"] = 57,
		["66"] = 57,
		["67"] = 57,
		["68"] = 57,
		["69"] = 57,
		["70"] = 57,
		["71"] = 57,
		["72"] = 57,
		["73"] = 62,
		["74"] = 62,
		["75"] = 62,
		["76"] = 62,
		["77"] = 62,
		["81"] = 36,
		["82"] = 19,
		["83"] = 12,
		["84"] = 12,
		["85"] = 12,
		["86"] = 12,
		["87"] = 12,
		["88"] = 12,
		["89"] = 12,
		["90"] = 19,
		["92"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_168 = c()
local n = g.trait_168
n.name = "trait_168"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_168"
end
n = e({ j(nil) }, n)
g.trait_168 = n
g.modifier_trait_168 = c()
local o = g.modifier_trait_168
o.name = "modifier_trait_168"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.rank = self:GetAbilitySpecialValueFor("rank")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 } }
end
function o.prototype.OnRoundChange(self, p)
	if not IsServer() then
		return
	end
	if not self:PRD(self.chance, "trait_168") then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	local r = PlayerData:getHero(q)
	if not r then
		return
	end
	local s = r:getDisplaySectList()
	if #s < self.rank then
		return
	end
	local t = s[self.rank]
	if not t then
		return
	end
	local u = AbilityShop:getRandomAbility(q, self.count, { specifySect = { t }, isAbilityShop = false })
	for v, w in ipairs(u) do
		do
			if not w then
				goto x
			end
			r:learnAbility(w.aid, true)
			Notification:combatToPlayer(
				q,
				{
					message = "notify_artifact_ability_" .. w.rarity,
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. w.aid,
				}
			)
			PlayerData:getplayerData(q):addArtifactAbilities(self:GetAbility():entindex(), w.aid, true)
		end
		::x::
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_168 = o
return g