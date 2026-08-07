--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_39"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
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
		["28"] = 20,
		["29"] = 11,
		["30"] = 20,
		["31"] = 25,
		["32"] = 26,
		["33"] = 27,
		["34"] = 28,
		["35"] = 25,
		["36"] = 36,
		["37"] = 37,
		["38"] = 38,
		["39"] = 38,
		["40"] = 37,
		["41"] = 36,
		["42"] = 41,
		["43"] = 42,
		["44"] = 43,
		["45"] = 44,
		["46"] = 45,
		["47"] = 46,
		["48"] = 47,
		["49"] = 48,
		["50"] = 49,
		["51"] = 50,
		["52"] = 50,
		["53"] = 50,
		["54"] = 51,
		["55"] = 52,
		["56"] = 53,
		["57"] = 58,
		["58"] = 59,
		["59"] = 59,
		["60"] = 59,
		["61"] = 59,
		["62"] = 59,
		["63"] = 50,
		["64"] = 50,
		["67"] = 64,
		["68"] = 65,
		["70"] = 41,
		["71"] = 20,
		["72"] = 11,
		["73"] = 11,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 11,
		["78"] = 11,
		["79"] = 11,
		["80"] = 11,
		["81"] = 20,
		["83"] = 20,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseItem
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.item_artifact_39 = c()
local o = h.item_artifact_39
o.name = "item_artifact_39"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_39"
end
o = e({ k(nil) }, o)
h.item_artifact_39 = o
h.modifier_item_artifact_39 = c()
local p = h.modifier_item_artifact_39
p.name = "modifier_item_artifact_39"
d(p, m)
function p.prototype.GetAbilitySpecialValue(self)
	self.stack = self:GetAbilitySpecialValueFor("stack")
	self.ability_cnt_max = self:GetAbilitySpecialValueFor("ability_cnt_max")
	self.record = 0
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_RANDOM] = { self:GetParent(), -1 } }
end
function p.prototype.OnAbilityRandom(self, q)
	self.record = self.record + 1
	local r = self:GetCount("item_artifact_39_cnt") < self.ability_cnt_max
	if self.record >= self.stack and r then
		self.record = 0
		local s = self:GetParent():GetPlayerOwnerID()
		local t = PlayerData:getHero(s)
		if t then
			local u = AbilityShop:getRandomAbility(s, 1, { specifyRarity = "r" })
			f(u, function(v, w, x)
				local y = w.aid
				t:learnAbility(y, true)
				Notification:combatToPlayer(
					s,
					{
						message = "notify_artifact_ability_" .. w.rarity,
						string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_39",
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. y,
					}
				)
				self:AddCount(1, "item_artifact_39_cnt")
				PlayerData:getplayerData(s):addArtifactAbilities(self:GetAbility():entindex(), y, x == #u - 1)
			end)
		end
	end
	if r then
		self:GetAbility():SetCurrentCharges(self.record)
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	p
)
h.modifier_item_artifact_39 = p
return h