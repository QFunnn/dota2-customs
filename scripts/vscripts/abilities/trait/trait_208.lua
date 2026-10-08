--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_208"
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
		["15"] = 7,
		["16"] = 8,
		["17"] = 7,
		["18"] = 8,
		["19"] = 9,
		["20"] = 10,
		["21"] = 9,
		["22"] = 8,
		["23"] = 7,
		["24"] = 8,
		["26"] = 8,
		["27"] = 14,
		["28"] = 21,
		["29"] = 14,
		["30"] = 21,
		["31"] = 26,
		["32"] = 27,
		["33"] = 28,
		["34"] = 29,
		["35"] = 30,
		["36"] = 26,
		["37"] = 32,
		["38"] = 33,
		["41"] = 34,
		["42"] = 35,
		["43"] = 38,
		["44"] = 38,
		["45"] = 38,
		["46"] = 38,
		["47"] = 38,
		["48"] = 38,
		["49"] = 38,
		["51"] = 50,
		["52"] = 50,
		["53"] = 51,
		["54"] = 52,
		["55"] = 52,
		["56"] = 52,
		["57"] = 52,
		["58"] = 52,
		["59"] = 52,
		["60"] = 52,
		["61"] = 52,
		["62"] = 50,
		["65"] = 32,
		["66"] = 59,
		["67"] = 60,
		["70"] = 61,
		["71"] = 62,
		["72"] = 62,
		["73"] = 62,
		["74"] = 62,
		["75"] = 62,
		["76"] = 62,
		["77"] = 62,
		["78"] = 59,
		["79"] = 21,
		["80"] = 14,
		["81"] = 14,
		["82"] = 14,
		["83"] = 14,
		["84"] = 14,
		["85"] = 14,
		["86"] = 14,
		["87"] = 21,
		["89"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = "80"
g.trait_208 = c()
local o = g.trait_208
o.name = "trait_208"
d(o, i)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_208"
end
o = e({ j(nil) }, o)
g.trait_208 = o
g.modifier_trait_208 = c()
local p = g.modifier_trait_208
p.name = "modifier_trait_208"
d(p, l)
function p.prototype.GetAbilitySpecialValue(self)
	self.card_count = self:GetAbilitySpecialValueFor("card_count")
	self.reduce_lv1 = self:GetAbilitySpecialValueFor("reduce_lv1")
	self.reduce_lv2 = self:GetAbilitySpecialValueFor("reduce_lv2")
	self.reduce_lv3 = self:GetAbilitySpecialValueFor("reduce_lv3")
end
function p.prototype.OnCreated(self, q)
	if not IsServer() then
		return
	end
	local r = self:GetParent():GetPlayerOwnerID()
	local s = PlayerData:getHero(r)
	AbilityUpgrades:AddAbilityMechanicsUpgrade(
		r,
		{
			ability_name = n,
			type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS,
			id = "80_effect_2",
			values = {
				effect_2 = self.reduce_lv3,
				reduce_lv1 = self.reduce_lv1,
				reduce_lv2 = self.reduce_lv2,
				reduce_lv3 = self.reduce_lv3,
			},
			description = "80_effect_2",
		}
	)
	do
		local t = 0
		while t < self.card_count do
			s:learnAbility(n, true)
			Notification:combatToPlayer(
				r,
				{
					message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[n].rarity),
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. n,
				}
			)
			t = t + 1
		end
	end
end
function p.prototype.OnRemoved(self, u)
	if not IsServer() then
		return
	end
	local r = self:GetParent():GetPlayerOwnerID()
	AbilityUpgrades:RemoveAbilityMechanicsUpgrade(
		r,
		{
			ability_name = n,
			type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS,
			id = "80_effect_2",
			values = { effect_2 = self.reduce_lv3 },
			description = "80_effect_2",
		}
	)
end
p = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	p
)
g.modifier_trait_208 = p
return g