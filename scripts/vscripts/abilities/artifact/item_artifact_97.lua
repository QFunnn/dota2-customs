--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_97"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArraySome
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["15"] = 4,
		["16"] = 5,
		["17"] = 4,
		["18"] = 5,
		["19"] = 6,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 4,
		["24"] = 5,
		["26"] = 5,
		["27"] = 11,
		["28"] = 19,
		["29"] = 11,
		["30"] = 19,
		["31"] = 23,
		["32"] = 24,
		["33"] = 25,
		["34"] = 23,
		["35"] = 27,
		["36"] = 28,
		["37"] = 29,
		["38"] = 30,
		["39"] = 31,
		["40"] = 32,
		["41"] = 32,
		["42"] = 32,
		["43"] = 32,
		["44"] = 32,
		["45"] = 32,
		["46"] = 32,
		["47"] = 32,
		["48"] = 37,
		["49"] = 38,
		["50"] = 39,
		["51"] = 39,
		["52"] = 39,
		["53"] = 39,
		["54"] = 39,
		["55"] = 40,
		["56"] = 40,
		["57"] = 40,
		["58"] = 40,
		["59"] = 40,
		["60"] = 41,
		["61"] = 42,
		["62"] = 43,
		["63"] = 44,
		["64"] = 44,
		["65"] = 44,
		["66"] = 44,
		["67"] = 45,
		["70"] = 48,
		["72"] = 27,
		["73"] = 51,
		["74"] = 52,
		["75"] = 53,
		["76"] = 53,
		["77"] = 53,
		["78"] = 53,
		["79"] = 54,
		["81"] = 51,
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
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseItem
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.item_artifact_97 = c()
local o = h.item_artifact_97
o.name = "item_artifact_97"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_97"
end
o = e({ k(nil) }, o)
h.item_artifact_97 = o
h.modifier_item_artifact_97 = c()
local p = h.modifier_item_artifact_97
p.name = "modifier_item_artifact_97"
d(p, m)
function p.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
	self.refresh = self:GetAbilitySpecialValueFor("refresh")
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		local r = self:GetParent()
		local s = r:GetPlayerOwnerID()
		PlayerData:modifyGold(s, self.gold)
		Notification:combatToPlayer(
			s,
			{
				message = "notify_bonus_gold",
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
				int_gold = self.gold,
			}
		)
		PlayerData:ModifyFreeRefresh(s, self.refresh)
		PlayerData:ModifyFreeRefreshByKey(s, "item_artifact_13", self.refresh)
		PlayerData:getplayerData(s):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.gold)
		PlayerData:getplayerData(s)
			:modifyArtifactExtraData(self:GetAbility():entindex(), "free_refresh_count", self.refresh)
		Roshan:setRoshanFirstPick(s, true)
		local t = {}
		for u, v in pairs(ROSHAN_ABILITY) do
			if f(v, function(w, x)
				return x.sr ~= nil
			end) then
				t[u] = ROSHAN_ABILITY_WEIGHT[u] * 2
			end
		end
		Roshan:ModifyRoshanRewardsWeight(t, "item_artifact_97")
	end
end
function p.prototype.OnDestroy(self)
	if IsServer() then
		Roshan:setRoshanFirstPick(self:GetParent():GetPlayerOwnerID(), false)
		Roshan:RemoveSpecialRoshanRewardsWeight("item_artifact_97")
	end
end
p = e(
	{
		n(
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
	p
)
h.modifier_item_artifact_97 = p
return h