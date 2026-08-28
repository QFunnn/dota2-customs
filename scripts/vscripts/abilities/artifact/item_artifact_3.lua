--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_3"
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
		["33"] = 25,
		["34"] = 26,
		["35"] = 25,
		["36"] = 31,
		["37"] = 32,
		["38"] = 33,
		["39"] = 34,
		["40"] = 35,
		["41"] = 35,
		["42"] = 35,
		["43"] = 35,
		["44"] = 36,
		["45"] = 36,
		["46"] = 36,
		["47"] = 36,
		["48"] = 36,
		["50"] = 31,
		["51"] = 40,
		["52"] = 41,
		["53"] = 42,
		["54"] = 43,
		["55"] = 44,
		["56"] = 44,
		["57"] = 44,
		["58"] = 44,
		["59"] = 45,
		["60"] = 45,
		["61"] = 45,
		["62"] = 45,
		["63"] = 45,
		["66"] = 40,
		["67"] = 20,
		["68"] = 11,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 11,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 20,
		["79"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_3 = c()
local n = g.item_artifact_3
n.name = "item_artifact_3"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_3"
end
n = e({ j(nil) }, n)
g.item_artifact_3 = n
g.modifier_item_artifact_3 = c()
local o = g.modifier_item_artifact_3
o.name = "modifier_item_artifact_3"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold_bonus = self:GetAbilitySpecialValueFor("gold_bonus")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_TAKEDAMAGE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TEAM_MODIFY_HEALTH] = { -1, -1 },
	}
end
function o.prototype.OnPlayerTakeDamage(self, p)
	local q = self:GetParent()
	local r = q:GetPlayerOwner()
	if not PlayerData:isAlivePlayer(p.victimID) and p.victimID ~= q:GetPlayerOwnerID() then
		PlayerData:modifyGold(q:GetPlayerOwnerID(), self.gold_bonus)
		PlayerData:getplayerData(q:GetPlayerOwnerID())
			:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.gold_bonus)
	end
end
function o.prototype.OnTeamModifyHealth(self, p)
	if IsGroupMode(nil) then
		local q = self:GetParent()
		if p.isDead then
			PlayerData:modifyGold(q:GetPlayerOwnerID(), self.gold_bonus * 2)
			PlayerData:getplayerData(q:GetPlayerOwnerID())
				:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.gold_bonus * 2)
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
g.modifier_item_artifact_3 = o
return g