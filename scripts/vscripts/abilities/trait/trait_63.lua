--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_63"
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
		["39"] = 31,
		["40"] = 31,
		["41"] = 31,
		["42"] = 31,
		["43"] = 31,
		["44"] = 31,
		["45"] = 31,
		["47"] = 40,
		["48"] = 40,
		["49"] = 41,
		["50"] = 42,
		["51"] = 42,
		["52"] = 42,
		["53"] = 42,
		["54"] = 42,
		["55"] = 42,
		["56"] = 42,
		["57"] = 42,
		["58"] = 40,
		["62"] = 26,
		["63"] = 50,
		["64"] = 51,
		["65"] = 52,
		["66"] = 53,
		["67"] = 53,
		["68"] = 53,
		["69"] = 53,
		["70"] = 53,
		["71"] = 53,
		["72"] = 53,
		["74"] = 50,
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
g.trait_63 = c()
local n = g.trait_63
n.name = "trait_63"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_63"
end
n = e({ j(nil) }, n)
g.trait_63 = n
g.modifier_trait_63 = c()
local o = g.modifier_trait_63
o.name = "modifier_trait_63"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = PlayerData:getHero(q)
		local s = "150"
		AbilityUpgrades:AddAbilityMechanicsUpgrade(
			q,
			{
				ability_name = "150",
				type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS,
				id = "150_effect_1",
				values = { effect_1 = self.damage },
				description = "150_effect_1",
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
				ability_name = "150",
				type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS,
				id = "150_effect_1",
				values = { effect_1 = self.damage },
				description = "150_effect_1",
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
g.modifier_trait_63 = o
return g