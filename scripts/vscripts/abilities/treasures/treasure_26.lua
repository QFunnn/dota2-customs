--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_26"
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
		["22"] = 10,
		["23"] = 11,
		["24"] = 12,
		["25"] = 13,
		["26"] = 13,
		["27"] = 13,
		["28"] = 13,
		["29"] = 13,
		["30"] = 13,
		["31"] = 13,
		["32"] = 13,
		["33"] = 6,
		["34"] = 19,
		["35"] = 20,
		["36"] = 19,
		["37"] = 5,
		["38"] = 4,
		["39"] = 5,
		["41"] = 5,
		["42"] = 23,
		["43"] = 30,
		["44"] = 23,
		["45"] = 30,
		["46"] = 33,
		["47"] = 34,
		["48"] = 33,
		["49"] = 36,
		["50"] = 37,
		["51"] = 38,
		["52"] = 39,
		["53"] = 40,
		["54"] = 40,
		["55"] = 40,
		["56"] = 40,
		["57"] = 40,
		["58"] = 40,
		["59"] = 40,
		["60"] = 40,
		["61"] = 40,
		["63"] = 36,
		["64"] = 51,
		["65"] = 52,
		["66"] = 53,
		["67"] = 54,
		["68"] = 54,
		["69"] = 54,
		["70"] = 54,
		["71"] = 54,
		["72"] = 54,
		["73"] = 54,
		["74"] = 54,
		["75"] = 54,
		["77"] = 51,
		["78"] = 30,
		["79"] = 23,
		["80"] = 23,
		["81"] = 23,
		["82"] = 23,
		["83"] = 23,
		["84"] = 23,
		["85"] = 23,
		["86"] = 30,
		["88"] = 30,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_26 = c()
local n = g.treasure_26
n.name = "treasure_26"
d(n, i)
function n.prototype.Spawn(self)
	if not IsServer() then
		return
	end
	local o = "5"
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
	return "modifier_treasure_26"
end
n = e({ j(nil) }, n)
g.treasure_26 = n
g.modifier_treasure_26 = c()
local q = g.modifier_treasure_26
q.name = "modifier_treasure_26"
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
				ability_name = "5",
				special_value_name = "n_5_chance",
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
				ability_name = "5",
				special_value_name = "n_5_chance",
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
g.modifier_treasure_26 = q
return g