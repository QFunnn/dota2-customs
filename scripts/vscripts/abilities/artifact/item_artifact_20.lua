--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_20"
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
		["27"] = 20,
		["28"] = 12,
		["29"] = 20,
		["30"] = 26,
		["31"] = 27,
		["32"] = 28,
		["33"] = 29,
		["34"] = 30,
		["35"] = 31,
		["36"] = 26,
		["37"] = 33,
		["38"] = 34,
		["39"] = 33,
		["40"] = 39,
		["41"] = 40,
		["42"] = 39,
		["43"] = 45,
		["44"] = 46,
		["45"] = 47,
		["46"] = 48,
		["47"] = 49,
		["48"] = 50,
		["49"] = 51,
		["50"] = 51,
		["51"] = 51,
		["52"] = 51,
		["53"] = 51,
		["54"] = 51,
		["55"] = 51,
		["56"] = 51,
		["57"] = 56,
		["58"] = 56,
		["59"] = 56,
		["60"] = 56,
		["61"] = 56,
		["62"] = 56,
		["63"] = 56,
		["66"] = 45,
		["67"] = 20,
		["68"] = 12,
		["69"] = 12,
		["70"] = 12,
		["71"] = 12,
		["72"] = 12,
		["73"] = 12,
		["74"] = 12,
		["75"] = 12,
		["76"] = 20,
		["78"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_20 = c()
local n = g.item_artifact_20
n.name = "item_artifact_20"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_20"
end
n = e({ j(nil) }, n)
g.item_artifact_20 = n
g.modifier_item_artifact_20 = c()
local o = g.modifier_item_artifact_20
o.name = "modifier_item_artifact_20"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.bonus_2 = self:GetAbilitySpecialValueFor("bonus_2")
	self.bonus_3 = self:GetAbilitySpecialValueFor("bonus_3")
	self.bonus_4 = self:GetAbilitySpecialValueFor("bonus_4")
	self.txt_bonus_pct = self:GetAbilitySpecialValueFor("txt_bonus_pct")
	self.buy_sr_gain_gold = self:GetAbilitySpecialValueFor("buy_sr_gain_gold")
end
function o.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_LEGEND_CHANCE_BONUS] = self.txt_bonus_pct }
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY] = { self.parent } }
end
function o.prototype.OnAbilityBuy(self, p)
	if IsServer() then
		local q = KeyValues.AbilityUpgradesKvs[p.abilityname]
		local r = self.parent:GetPlayerOwnerID()
		if q.rarity == "sr" then
			PlayerData:modifyGold(r, self.buy_sr_gain_gold)
			Notification:combatToPlayer(
				r,
				{
					message = "notify_bonus_gold",
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
					int_gold = self.buy_sr_gain_gold,
				}
			)
			PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
				:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.buy_sr_gain_gold, true, false)
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
			}
		),
	},
	o
)
g.modifier_item_artifact_20 = o
return g