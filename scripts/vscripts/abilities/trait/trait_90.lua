--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_90"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 2,
		["9"] = 2,
		["10"] = 2,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
		["14"] = 6,
		["15"] = 7,
		["16"] = 6,
		["17"] = 7,
		["18"] = 8,
		["19"] = 9,
		["20"] = 8,
		["21"] = 7,
		["22"] = 6,
		["23"] = 7,
		["25"] = 7,
		["26"] = 13,
		["27"] = 20,
		["28"] = 13,
		["29"] = 20,
		["30"] = 23,
		["31"] = 24,
		["32"] = 25,
		["33"] = 26,
		["35"] = 23,
		["36"] = 29,
		["37"] = 30,
		["38"] = 31,
		["39"] = 31,
		["40"] = 30,
		["41"] = 29,
		["42"] = 34,
		["43"] = 35,
		["46"] = 36,
		["49"] = 39,
		["52"] = 42,
		["53"] = 43,
		["54"] = 44,
		["55"] = 44,
		["56"] = 44,
		["57"] = 44,
		["58"] = 44,
		["59"] = 44,
		["60"] = 44,
		["61"] = 44,
		["62"] = 49,
		["63"] = 49,
		["64"] = 49,
		["65"] = 49,
		["66"] = 49,
		["68"] = 34,
		["69"] = 20,
		["70"] = 13,
		["71"] = 13,
		["72"] = 13,
		["73"] = 13,
		["74"] = 13,
		["75"] = 13,
		["76"] = 13,
		["77"] = 20,
		["79"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_90 = c()
local n = g.trait_90
n.name = "trait_90"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_90"
end
n = e({ j(nil) }, n)
g.trait_90 = n
g.modifier_trait_90 = c()
local o = g.modifier_trait_90
o.name = "modifier_trait_90"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	if IsServer() then
		self.round = Rounds:getCurrentRound()
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = { self:GetParent(), -1 } }
end
function o.prototype.OnAbilityLearn(self, p)
	if p.bGift then
		return
	end
	if KeyValues.AbilityUpgradesKvs[p.abilityname].rarity == "sr" then
		return
	end
	if Rounds:getCurrentRound() ~= self.round then
		return
	end
	if self:PRD(self.chance) then
		p.heroclass:learnAbility(p.abilityname, true)
		Notification:combatToPlayer(
			self:GetParent():GetPlayerOwnerID(),
			{
				message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[p.abilityname].rarity),
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. p.abilityname,
			}
		)
		PlayerData:getplayerData(p.heroclass.playerID)
			:addArtifactAbilities(self:GetAbility():entindex(), p.abilityname, true)
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_90 = o
return g