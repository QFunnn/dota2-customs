--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_135"
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
		["30"] = 21,
		["31"] = 22,
		["32"] = 21,
		["33"] = 24,
		["34"] = 25,
		["35"] = 26,
		["36"] = 27,
		["37"] = 27,
		["38"] = 27,
		["39"] = 27,
		["40"] = 27,
		["41"] = 27,
		["42"] = 27,
		["43"] = 37,
		["44"] = 38,
		["45"] = 39,
		["46"] = 40,
		["47"] = 40,
		["48"] = 40,
		["49"] = 40,
		["50"] = 40,
		["51"] = 40,
		["52"] = 40,
		["53"] = 40,
		["54"] = 45,
		["55"] = 45,
		["56"] = 45,
		["57"] = 45,
		["58"] = 45,
		["60"] = 24,
		["61"] = 49,
		["62"] = 50,
		["63"] = 51,
		["64"] = 52,
		["65"] = 52,
		["66"] = 52,
		["67"] = 52,
		["68"] = 52,
		["69"] = 52,
		["70"] = 52,
		["72"] = 49,
		["73"] = 19,
		["74"] = 12,
		["75"] = 12,
		["76"] = 12,
		["77"] = 12,
		["78"] = 12,
		["79"] = 12,
		["80"] = 12,
		["81"] = 19,
		["83"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_135 = c()
local n = g.trait_135
n.name = "trait_135"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_135"
end
n = e({ j(nil) }, n)
g.trait_135 = n
g.modifier_trait_135 = c()
local o = g.modifier_trait_135
o.name = "modifier_trait_135"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.bonus_tick = self:GetAbilitySpecialValueFor("bonus_tick")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		AbilityUpgrades:AddAbilityMechanicsUpgrade(
			q,
			{
				ability_name = "sect_health",
				type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS,
				id = "trait_135",
				values = { bonus_tick = self.bonus_tick },
				description = "trait_135",
			},
			true
		)
		local r = "47"
		PlayerData:getHero(q):learnAbility(r, true)
		local s = KeyValues.AbilityUpgradesKvs[r]
		Notification:combatToPlayer(
			q,
			{
				message = "notify_artifact_ability_" .. tostring(s.rarity),
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. r,
			}
		)
		PlayerData:getplayerData(q):addArtifactAbilities(self:GetAbility():entindex(), r, true)
	end
end
function o.prototype.OnRemoved(self, t)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		AbilityUpgrades:RemoveAbilityMechanicsUpgrade(
			q,
			{
				ability_name = "sect_health",
				type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS,
				id = "trait_135",
				values = { bonus_tick = self.bonus_tick },
				description = "trait_135",
			},
			true
		)
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_135 = o
return g