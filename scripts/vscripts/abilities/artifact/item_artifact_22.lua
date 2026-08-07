--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_22"
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
		["30"] = 22,
		["31"] = 23,
		["32"] = 22,
		["33"] = 30,
		["34"] = 31,
		["35"] = 32,
		["36"] = 33,
		["37"] = 34,
		["38"] = 35,
		["41"] = 30,
		["42"] = 39,
		["43"] = 40,
		["44"] = 39,
		["45"] = 45,
		["46"] = 46,
		["47"] = 47,
		["48"] = 48,
		["49"] = 49,
		["50"] = 50,
		["51"] = 51,
		["52"] = 52,
		["53"] = 52,
		["54"] = 52,
		["55"] = 52,
		["56"] = 52,
		["57"] = 52,
		["58"] = 52,
		["59"] = 52,
		["60"] = 57,
		["61"] = 57,
		["62"] = 57,
		["63"] = 57,
		["64"] = 57,
		["66"] = 45,
		["67"] = 61,
		["68"] = 62,
		["69"] = 63,
		["70"] = 64,
		["71"] = 65,
		["72"] = 67,
		["74"] = 61,
		["75"] = 20,
		["76"] = 11,
		["77"] = 11,
		["78"] = 11,
		["79"] = 11,
		["80"] = 11,
		["81"] = 11,
		["82"] = 11,
		["83"] = 11,
		["84"] = 11,
		["85"] = 20,
		["87"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_22 = c()
local n = g.item_artifact_22
n.name = "item_artifact_22"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_22"
end
n = e({ j(nil) }, n)
g.item_artifact_22 = n
g.modifier_item_artifact_22 = c()
local o = g.modifier_item_artifact_22
o.name = "modifier_item_artifact_22"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold_bonus = self:GetAbilitySpecialValueFor("gold_bonus")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = PlayerData:getHero(q)
		if r then
			self:SetStackCount(r:getLevel() * self.gold_bonus)
		end
	end
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE] = { -1, -1 },
	}
end
function o.prototype.OnPrepare(self, p)
	local q = self:GetParent():GetPlayerOwnerID()
	local s = PlayerData:getplayerData(q)
	local t = self:GetAbility()
	local u = self:GetStackCount()
	if u > 0 then
		PlayerData:modifyGold(q, u)
		Notification:combatToPlayer(
			q,
			{
				message = "notify_bonus_gold",
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. t:GetAbilityName(),
				int_gold = u,
			}
		)
		s:modifyArtifactExtraData(t:entindex(), "bonus_gold", u)
	end
end
function o.prototype.OnBattleStart(self, p)
	local q = self:GetParent():GetPlayerOwnerID()
	if PlayerData:isAlivePlayer(q) then
		local r = PlayerData:getHero(q)
		self:SetStackCount(r:getLevel() * self.gold_bonus)
		self:GetAbility():SetCurrentCharges(self:GetStackCount())
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
g.modifier_item_artifact_22 = o
return g