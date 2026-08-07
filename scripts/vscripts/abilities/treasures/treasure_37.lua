--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_37"
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
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["22"] = 11,
		["23"] = 12,
		["24"] = 13,
		["25"] = 14,
		["26"] = 14,
		["27"] = 14,
		["28"] = 14,
		["29"] = 14,
		["30"] = 14,
		["31"] = 14,
		["32"] = 14,
		["33"] = 6,
		["34"] = 21,
		["35"] = 22,
		["36"] = 21,
		["37"] = 5,
		["38"] = 4,
		["39"] = 5,
		["41"] = 5,
		["42"] = 26,
		["43"] = 33,
		["44"] = 26,
		["45"] = 33,
		["46"] = 37,
		["47"] = 38,
		["48"] = 37,
		["49"] = 41,
		["50"] = 42,
		["51"] = 43,
		["52"] = 44,
		["53"] = 45,
		["54"] = 45,
		["55"] = 45,
		["56"] = 45,
		["57"] = 45,
		["58"] = 45,
		["59"] = 45,
		["60"] = 45,
		["61"] = 45,
		["63"] = 41,
		["64"] = 57,
		["65"] = 58,
		["66"] = 59,
		["67"] = 60,
		["68"] = 60,
		["69"] = 60,
		["70"] = 60,
		["71"] = 60,
		["72"] = 60,
		["73"] = 60,
		["74"] = 60,
		["75"] = 60,
		["77"] = 57,
		["78"] = 33,
		["79"] = 26,
		["80"] = 26,
		["81"] = 26,
		["82"] = 26,
		["83"] = 26,
		["84"] = 26,
		["85"] = 26,
		["86"] = 33,
		["88"] = 33,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_37 = c()
local n = g.treasure_37
n.name = "treasure_37"
d(n, i)
function n.prototype.Spawn(self)
	if not IsServer() then
		return
	end
	local o = "133"
	local p = self:GetCaster():GetPlayerOwnerID()
	PlayerData:getHero(p):learnAbility(o, true)
	Notification:combatToPlayer(
		p,
		{
			message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[o].rarity),
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbilityName(),
			string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. o,
		}
	)
end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_37"
end
n = e({ j(nil) }, n)
g.treasure_37 = n
g.modifier_treasure_37 = c()
local q = g.modifier_treasure_37
q.name = "modifier_treasure_37"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.value = self:GetAbilitySpecialValueFor("value")
end
function q.prototype.OnCreated(self, r)
	if IsServer() then
		local p = self:GetParent():GetPlayerOwnerID()
		self.key = tostring(self.ability:entindex())
		AbilityUpgrades:AddSpecialValueUpgrade(
			p,
			{
				id = self.key,
				type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE,
				description = self.key,
				ability_name = "133",
				special_value_name = "n_133_chance",
				operator = ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD,
				value = self.value,
			}
		)
	end
end
function q.prototype.OnDestroy(self)
	if IsServer() then
		local p = self:GetParent():GetPlayerOwnerID()
		AbilityUpgrades:RemoveSpecialValueUpgrade(
			p,
			{
				id = self.key,
				type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE,
				description = self.key,
				ability_name = "133",
				special_value_name = "n_133_chance",
				operator = ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD,
				value = self.value,
			}
		)
	end
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_treasure_37 = q
return g