--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_45"
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
		["30"] = 22,
		["31"] = 23,
		["32"] = 22,
		["33"] = 25,
		["34"] = 26,
		["35"] = 25,
		["36"] = 32,
		["37"] = 33,
		["38"] = 34,
		["39"] = 35,
		["40"] = 36,
		["41"] = 37,
		["42"] = 38,
		["43"] = 38,
		["44"] = 38,
		["45"] = 38,
		["46"] = 39,
		["47"] = 39,
		["48"] = 39,
		["49"] = 39,
		["50"] = 39,
		["52"] = 32,
		["53"] = 42,
		["54"] = 43,
		["55"] = 45,
		["56"] = 46,
		["57"] = 47,
		["58"] = 47,
		["59"] = 47,
		["60"] = 47,
		["61"] = 48,
		["62"] = 48,
		["63"] = 48,
		["64"] = 48,
		["65"] = 48,
		["67"] = 42,
		["68"] = 19,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 11,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 19,
		["79"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_45 = c()
local n = g.item_artifact_45
n.name = "item_artifact_45"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_45"
end
n = e({ j(nil) }, n)
g.item_artifact_45 = n
g.modifier_item_artifact_45 = c()
local o = g.modifier_item_artifact_45
o.name = "modifier_item_artifact_45"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold_per_hp = self:GetAbilitySpecialValueFor("gold_per_hp")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_TAKEDAMAGE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_MODIFY_HEALTH] = { -1, -1 },
	}
end
function o.prototype.OnPlayerModifyHealth(self, p)
	local q = self:GetParent():GetPlayerOwnerID()
	if q == p.playerID and p.modified_value < 0 then
		local r = math.abs(p.modified_value)
		local s = self.gold_per_hp * r
		local t = self:GetParent()
		PlayerData:modifyGold(t:GetPlayerOwnerID(), s)
		PlayerData:getplayerData(t:GetPlayerOwnerID())
			:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", s)
	end
end
function o.prototype.OnPlayerTakeDamage(self, p)
	local t = self:GetParent()
	if PlayerData:isAlivePlayer(p.victimID) and p.victimID == t:GetPlayerOwnerID() then
		local s = self.gold_per_hp * p.damage
		PlayerData:modifyGold(t:GetPlayerOwnerID(), s)
		PlayerData:getplayerData(t:GetPlayerOwnerID())
			:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", s)
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
g.modifier_item_artifact_45 = o
return g