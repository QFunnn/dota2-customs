--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_61"
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
		["30"] = 23,
		["31"] = 24,
		["32"] = 25,
		["33"] = 26,
		["34"] = 23,
		["35"] = 28,
		["36"] = 29,
		["37"] = 30,
		["38"] = 31,
		["39"] = 32,
		["40"] = 33,
		["41"] = 33,
		["42"] = 33,
		["43"] = 33,
		["44"] = 33,
		["45"] = 33,
		["46"] = 33,
		["48"] = 52,
		["49"] = 52,
		["50"] = 53,
		["51"] = 54,
		["52"] = 54,
		["53"] = 54,
		["54"] = 54,
		["55"] = 54,
		["56"] = 54,
		["57"] = 54,
		["58"] = 54,
		["59"] = 52,
		["63"] = 28,
		["64"] = 62,
		["65"] = 63,
		["66"] = 64,
		["67"] = 65,
		["68"] = 65,
		["69"] = 65,
		["70"] = 65,
		["71"] = 65,
		["72"] = 65,
		["73"] = 65,
		["75"] = 62,
		["76"] = 19,
		["77"] = 12,
		["78"] = 12,
		["79"] = 12,
		["80"] = 12,
		["81"] = 12,
		["82"] = 12,
		["83"] = 12,
		["84"] = 19,
		["86"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_61 = c()
local n = g.trait_61
n.name = "trait_61"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_61"
end
n = e({ j(nil) }, n)
g.trait_61 = n
g.modifier_trait_61 = c()
local o = g.modifier_trait_61
o.name = "modifier_trait_61"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.evade_bonus = self:GetAbilitySpecialValueFor("evade_bonus")
	self.max_stack = self:GetAbilitySpecialValueFor("max_stack")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = PlayerData:getHero(q)
		local s = "184"
		AbilityUpgrades:AddAbilityMechanicsUpgrade(
			q,
			{
				ability_name = "184",
				type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS,
				id = "184_effect_1",
				values = { evade_bonus = self.evade_bonus, max_stack = self.max_stack },
				description = "184_effect_1",
			}
		)
		do
			local t = 0
			while t < self.count do
				r:learnAbility(s, true)
				Notification:combatToPlayer(
					q,
					{
						message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[s].rarity),
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. s,
					}
				)
				t = t + 1
			end
		end
	end
end
function o.prototype.OnRemoved(self, u)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		AbilityUpgrades:RemoveAbilityMechanicsUpgrade(
			q,
			{
				ability_name = "184",
				type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS,
				id = "184_effect_1",
				values = { evade_bonus = self.evade_bonus, max_stack = self.max_stack },
				description = "184_effect_1",
			}
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
g.modifier_trait_61 = o
return g