--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_67"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__StringSplit
local g = b.__TS__ArrayMap
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 2,
		["11"] = 2,
		["12"] = 2,
		["13"] = 3,
		["14"] = 3,
		["15"] = 3,
		["16"] = 5,
		["17"] = 6,
		["18"] = 5,
		["19"] = 6,
		["20"] = 7,
		["21"] = 8,
		["22"] = 7,
		["23"] = 6,
		["24"] = 5,
		["25"] = 6,
		["27"] = 6,
		["28"] = 12,
		["29"] = 21,
		["30"] = 12,
		["31"] = 21,
		["32"] = 25,
		["33"] = 26,
		["34"] = 27,
		["35"] = 28,
		["36"] = 25,
		["37"] = 30,
		["38"] = 31,
		["39"] = 32,
		["40"] = 32,
		["41"] = 31,
		["42"] = 30,
		["43"] = 35,
		["44"] = 36,
		["47"] = 37,
		["48"] = 38,
		["49"] = 39,
		["50"] = 41,
		["51"] = 41,
		["52"] = 41,
		["53"] = 42,
		["54"] = 43,
		["56"] = 41,
		["57"] = 41,
		["58"] = 47,
		["59"] = 48,
		["60"] = 49,
		["61"] = 50,
		["62"] = 50,
		["63"] = 51,
		["64"] = 52,
		["67"] = 55,
		["70"] = 59,
		["71"] = 60,
		["72"] = 61,
		["73"] = 62,
		["74"] = 62,
		["75"] = 62,
		["76"] = 62,
		["77"] = 62,
		["78"] = 62,
		["82"] = 65,
		["83"] = 66,
		["85"] = 68,
		["86"] = 68,
		["87"] = 68,
		["88"] = 68,
		["89"] = 69,
		["90"] = 69,
		["91"] = 69,
		["92"] = 69,
		["93"] = 69,
		["94"] = 70,
		["95"] = 70,
		["96"] = 70,
		["97"] = 70,
		["99"] = 35,
		["100"] = 21,
		["101"] = 12,
		["102"] = 12,
		["103"] = 12,
		["104"] = 12,
		["105"] = 12,
		["106"] = 12,
		["107"] = 12,
		["108"] = 12,
		["109"] = 12,
		["110"] = 21,
		["112"] = 21,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseItem
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
i.item_artifact_67 = c()
local p = i.item_artifact_67
p.name = "item_artifact_67"
d(p, k)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_67"
end
p = e({ l(nil) }, p)
i.item_artifact_67 = p
i.modifier_item_artifact_67 = c()
local q = i.modifier_item_artifact_67
q.name = "modifier_item_artifact_67"
d(q, n)
function q.prototype.GetAbilitySpecialValue(self)
	self.require_stack = self:GetAbilitySpecialValueFor("require_stack")
	self.bonus_gold = self:GetAbilitySpecialValueFor("bonus_gold")
	self.sects = {}
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = { self:GetParent(), -1 } }
end
function q.prototype.OnAbilityLearn(self, r)
	if r.bGift then
		return
	end
	local s = r.abilityUpgradeInfo.sect
	local t = f(s, "|")
	t = quickSortStrings(nil, t)
	g(t, function(u, v, w)
		if not self.sects[v] then
			self.sects[v] = 0
		end
	end)
	local x = {}
	for v in pairs(self.sects) do
		if (string.find(s, v, nil, true) or 0) - 1 ~= -1 then
			local y, z = self.sects, v
			y[z] = y[z] + 1
			if self.sects[v] >= self.require_stack then
				x[#x + 1] = v
			end
		else
			self.sects[v] = 0
		end
	end
	r.heroclass:removeSectModifiers(self:GetAbility():GetName())
	if #x == 0 then
		for v in pairs(self.sects) do
			if self.sects[v] > 0 then
				r.heroclass:addSectModifier(v, self:GetAbility():GetName(), self.sects[v])
			end
		end
	else
		for v in pairs(self.sects) do
			self.sects[v] = 0
		end
		PlayerData:modifyGold(self:GetParent():GetPlayerOwnerID(), self.bonus_gold)
		PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.bonus_gold)
		EmitAnnouncerSoundForPlayer("General.Coins", self:GetParent():GetPlayerOwnerID())
	end
end
q = e(
	{
		o(
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
	q
)
i.modifier_item_artifact_67 = q
return i