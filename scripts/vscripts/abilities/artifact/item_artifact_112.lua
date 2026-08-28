--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_112"
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
		["30"] = 23,
		["31"] = 24,
		["32"] = 23,
		["33"] = 26,
		["34"] = 27,
		["35"] = 27,
		["36"] = 27,
		["37"] = 27,
		["38"] = 27,
		["39"] = 26,
		["40"] = 34,
		["41"] = 35,
		["42"] = 36,
		["43"] = 37,
		["44"] = 38,
		["45"] = 38,
		["46"] = 38,
		["47"] = 38,
		["48"] = 38,
		["49"] = 38,
		["50"] = 38,
		["51"] = 39,
		["52"] = 40,
		["53"] = 41,
		["54"] = 41,
		["55"] = 41,
		["56"] = 41,
		["57"] = 41,
		["58"] = 41,
		["59"] = 41,
		["60"] = 41,
		["61"] = 46,
		["62"] = 46,
		["63"] = 46,
		["64"] = 46,
		["65"] = 46,
		["68"] = 49,
		["69"] = 50,
		["70"] = 34,
		["71"] = 52,
		["72"] = 53,
		["73"] = 54,
		["75"] = 52,
		["76"] = 57,
		["77"] = 58,
		["78"] = 59,
		["80"] = 57,
		["81"] = 62,
		["82"] = 63,
		["83"] = 64,
		["84"] = 65,
		["85"] = 66,
		["86"] = 67,
		["87"] = 68,
		["88"] = 68,
		["89"] = 68,
		["90"] = 68,
		["91"] = 68,
		["92"] = 69,
		["94"] = 62,
		["95"] = 20,
		["96"] = 12,
		["97"] = 12,
		["98"] = 12,
		["99"] = 12,
		["100"] = 12,
		["101"] = 12,
		["102"] = 12,
		["103"] = 12,
		["104"] = 20,
		["106"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_112 = c()
local n = g.item_artifact_112
n.name = "item_artifact_112"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_112"
end
n = e({ j(nil) }, n)
g.item_artifact_112 = n
g.modifier_item_artifact_112 = c()
local o = g.modifier_item_artifact_112
o.name = "modifier_item_artifact_112"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_RANDOM] = { self:GetParent() },
	}
end
function o.prototype.OnBattleEndStateEnd(self, p)
	local q = self:GetParent():GetPlayerOwnerID()
	local r = PlayerData:getplayerData(q)
	if r then
		r:modifyArtifactExtraData(self:GetAbility():entindex(), "AbilityBuyCount", 0, true, true)
		if self:GetStackCount() == 0 then
			PlayerData:modifyGold(q, self.gold)
			Notification:combatToPlayer(
				q,
				{
					message = "notify_bonus_gold",
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
					int_gold = self.gold,
				}
			)
			PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.gold)
		end
	end
	self:SetStackCount(0)
	self:GetAbility():SetCurrentCharges(0)
end
function o.prototype.OnAbilityBuy(self, p)
	if p.cost > 0 then
		self:AddStack()
	end
end
function o.prototype.OnAbilityRandom(self, p)
	if p.cost > 0 then
		self:AddStack()
	end
end
function o.prototype.AddStack(self)
	local q = self:GetParent():GetPlayerOwnerID()
	local r = PlayerData:getplayerData(q)
	if r then
		self:IncrementStackCount()
		local s = self:GetAbility()
		r:modifyArtifactExtraData(s:entindex(), "AbilityBuyCount", 1)
		s:SetCurrentCharges(self:GetStackCount())
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
g.modifier_item_artifact_112 = o
return g