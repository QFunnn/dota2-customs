--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_31"
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
		["48"] = 39,
		["49"] = 37,
		["50"] = 42,
		["51"] = 43,
		["52"] = 44,
		["53"] = 45,
		["54"] = 46,
		["55"] = 47,
		["56"] = 47,
		["57"] = 47,
		["58"] = 47,
		["59"] = 47,
		["60"] = 47,
		["61"] = 47,
		["62"] = 48,
		["63"] = 48,
		["64"] = 48,
		["65"] = 48,
		["66"] = 48,
		["67"] = 48,
		["68"] = 48,
		["70"] = 42,
		["71"] = 52,
		["72"] = 53,
		["73"] = 54,
		["74"] = 55,
		["75"] = 56,
		["76"] = 56,
		["77"] = 56,
		["78"] = 56,
		["79"] = 56,
		["80"] = 56,
		["81"] = 56,
		["82"] = 57,
		["83"] = 57,
		["84"] = 57,
		["85"] = 57,
		["86"] = 57,
		["87"] = 57,
		["88"] = 57,
		["90"] = 52,
		["91"] = 61,
		["92"] = 62,
		["93"] = 62,
		["94"] = 62,
		["95"] = 62,
		["96"] = 62,
		["97"] = 62,
		["98"] = 62,
		["99"] = 62,
		["100"] = 62,
		["101"] = 72,
		["102"] = 73,
		["104"] = 75,
		["106"] = 61,
		["107"] = 33,
		["108"] = 26,
		["109"] = 26,
		["110"] = 26,
		["111"] = 26,
		["112"] = 26,
		["113"] = 26,
		["114"] = 26,
		["115"] = 33,
		["117"] = 33,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_31 = c()
local n = g.treasure_31
n.name = "treasure_31"
d(n, i)
function n.prototype.Spawn(self)
	if not IsServer() then
		return
	end
	local o = "76"
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
	return "modifier_treasure_31"
end
n = e({ j(nil) }, n)
g.treasure_31 = n
g.modifier_treasure_31 = c()
local q = g.modifier_treasure_31
q.name = "modifier_treasure_31"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.value = self:GetAbilitySpecialValueFor("value")
	self.ultiValue = self:GetAbilitySpecialValueFor("value2")
end
function q.prototype.OnCreated(self, r)
	if IsServer() then
		local p = self:GetParent():GetPlayerOwnerID()
		local s = tostring(self.ability:entindex())
		print("add", self.value, self.ultiValue)
		self:SetSpecialValueUpgrade(p, "n_76_mana_reduce_pct", self.value, true, s .. "_1")
		self:SetSpecialValueUpgrade(p, "n_76_ulti_reduce_pct", self.ultiValue, true, s .. "_2")
	end
end
function q.prototype.OnDestroy(self)
	if IsServer() then
		local p = self:GetParent():GetPlayerOwnerID()
		local s = tostring(self.ability:entindex())
		self:SetSpecialValueUpgrade(p, "n_76_mana_reduce_pct", self.value, false, s .. "_1")
		self:SetSpecialValueUpgrade(p, "n_76_ulti_reduce_pct", self.ultiValue, false, s .. "_2")
	end
end
function q.prototype.SetSpecialValueUpgrade(self, p, t, u, v, w)
	local x = {
		id = w,
		type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE,
		description = w,
		ability_name = "76",
		special_value_name = t,
		operator = ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD,
		value = u,
	}
	if v then
		AbilityUpgrades:AddSpecialValueUpgrade(p, x)
	else
		AbilityUpgrades:RemoveSpecialValueUpgrade(p, x)
	end
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_treasure_31 = q
return g