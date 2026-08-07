--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_70"
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
		["30"] = 22,
		["31"] = 23,
		["32"] = 24,
		["33"] = 22,
		["34"] = 26,
		["35"] = 27,
		["36"] = 28,
		["37"] = 29,
		["38"] = 30,
		["39"] = 30,
		["40"] = 30,
		["41"] = 30,
		["42"] = 30,
		["43"] = 30,
		["44"] = 30,
		["45"] = 40,
		["47"] = 41,
		["48"] = 41,
		["49"] = 42,
		["50"] = 43,
		["51"] = 43,
		["52"] = 43,
		["53"] = 43,
		["54"] = 43,
		["55"] = 43,
		["56"] = 43,
		["57"] = 43,
		["58"] = 41,
		["62"] = 26,
		["63"] = 51,
		["64"] = 52,
		["65"] = 53,
		["66"] = 54,
		["67"] = 54,
		["68"] = 54,
		["69"] = 54,
		["70"] = 54,
		["71"] = 54,
		["72"] = 54,
		["74"] = 51,
		["75"] = 19,
		["76"] = 12,
		["77"] = 12,
		["78"] = 12,
		["79"] = 12,
		["80"] = 12,
		["81"] = 12,
		["82"] = 12,
		["83"] = 19,
		["85"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_70 = c()
local n = g.trait_70
n.name = "trait_70"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_70"
end
n = e({ j(nil) }, n)
g.trait_70 = n
g.modifier_trait_70 = c()
local o = g.modifier_trait_70
o.name = "modifier_trait_70"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.life_steal = self:GetAbilitySpecialValueFor("life_steal")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = PlayerData:getHero(q)
		AbilityUpgrades:AddAbilityMechanicsUpgrade(
			q,
			{
				ability_name = "15",
				type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS,
				id = "15_effect_1",
				values = { effect_1 = self.life_steal },
				description = "15_effect_1",
			}
		)
		local s = "15"
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
				ability_name = "15",
				type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS,
				id = "15_effect_1",
				values = { effect_1 = self.life_steal },
				description = "15_effect_1",
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
g.modifier_trait_70 = o
return g