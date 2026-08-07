--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_31"
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
		["20"] = 6,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 11,
		["27"] = 20,
		["28"] = 11,
		["29"] = 20,
		["30"] = 23,
		["31"] = 24,
		["32"] = 25,
		["33"] = 23,
		["34"] = 27,
		["35"] = 28,
		["36"] = 29,
		["37"] = 29,
		["38"] = 29,
		["39"] = 29,
		["40"] = 31,
		["41"] = 31,
		["42"] = 31,
		["43"] = 31,
		["44"] = 32,
		["45"] = 33,
		["46"] = 34,
		["47"] = 35,
		["48"] = 36,
		["50"] = 38,
		["52"] = 40,
		["55"] = 27,
		["56"] = 20,
		["57"] = 11,
		["58"] = 11,
		["59"] = 11,
		["60"] = 11,
		["61"] = 11,
		["62"] = 11,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 20,
		["68"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_31 = c()
local n = g.item_artifact_31
n.name = "item_artifact_31"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_31"
end
n = e({ j(nil) }, n)
g.item_artifact_31 = n
g.modifier_item_artifact_31 = c()
local o = g.modifier_item_artifact_31
o.name = "modifier_item_artifact_31"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold_bonus = self:GetAbilitySpecialValueFor("gold_bonus")
	self.health_damage = self:GetAbilitySpecialValueFor("health_damage")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		PlayerData:modifyGold(self:GetParent():GetPlayerOwnerID(), self.gold_bonus)
		EmitAnnouncerSoundForPlayer("General.Coins", self:GetParent():GetPlayerOwnerID())
		local q = PlayerResource:GetSelectedHeroEntity(self:GetParent():GetPlayerOwnerID())
		if q then
			local r = 0
			if self.health_damage < q:GetHealth() then
				r = q:GetHealth() - self.health_damage
			else
				r = 1
			end
			q:ModifyHealth(r, nil, true, 0)
		end
	end
end
o = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	o
)
g.modifier_item_artifact_31 = o
return g