--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_58"
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
		["27"] = 19,
		["28"] = 11,
		["29"] = 19,
		["30"] = 24,
		["31"] = 25,
		["32"] = 26,
		["33"] = 27,
		["34"] = 24,
		["35"] = 29,
		["36"] = 30,
		["37"] = 31,
		["38"] = 32,
		["39"] = 32,
		["40"] = 32,
		["41"] = 32,
		["42"] = 32,
		["44"] = 29,
		["45"] = 35,
		["46"] = 36,
		["47"] = 35,
		["48"] = 40,
		["49"] = 41,
		["50"] = 42,
		["51"] = 42,
		["52"] = 42,
		["53"] = 42,
		["54"] = 42,
		["56"] = 40,
		["57"] = 45,
		["58"] = 46,
		["59"] = 45,
		["60"] = 61,
		["61"] = 62,
		["62"] = 63,
		["63"] = 64,
		["64"] = 65,
		["65"] = 66,
		["66"] = 67,
		["67"] = 67,
		["68"] = 67,
		["69"] = 67,
		["70"] = 67,
		["71"] = 68,
		["72"] = 68,
		["73"] = 68,
		["74"] = 68,
		["75"] = 68,
		["76"] = 68,
		["77"] = 68,
		["78"] = 68,
		["79"] = 73,
		["81"] = 61,
		["82"] = 19,
		["83"] = 11,
		["84"] = 11,
		["85"] = 11,
		["86"] = 11,
		["87"] = 11,
		["88"] = 11,
		["89"] = 11,
		["90"] = 11,
		["91"] = 19,
		["93"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_58 = c()
local n = g.item_artifact_58
n.name = "item_artifact_58"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_58"
end
n = e({ j(nil) }, n)
g.item_artifact_58 = n
g.modifier_item_artifact_58 = c()
local o = g.modifier_item_artifact_58
o.name = "modifier_item_artifact_58"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
	self.count = self:GetAbilitySpecialValueFor("count")
	self.min_health = self:GetAbilitySpecialValueFor("min_health")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self:SetStackCount(self.count)
		PlayerData:saveData(self.parent:GetPlayerOwnerID(), "AnotherLife", 1)
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 } }
end
function o.prototype.OnRoundChange(self, p)
	if self:GetStackCount() == 0 then
		PlayerData:saveData(self.parent:GetPlayerOwnerID(), "AnotherLife", 0)
	end
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PLAYER_AVOID_LETHAL_DAMAGE }
end
function o.prototype.EOM_GetModifierPlayerAvoidLethalDamage(self, p)
	if self:GetStackCount() > 0 then
		local q = self:GetParent()
		local r = q:GetPlayerOwnerID()
		self:DecrementStackCount()
		PlayerData:modifyGold(r, self.gold)
		PlayerData:getplayerData(r):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.gold)
		Notification:combatToPlayer(
			r,
			{
				message = "notify_bonus_gold",
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
				int_gold = self.gold,
			}
		)
		return 1
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
g.modifier_item_artifact_58 = o
return g