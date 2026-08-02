--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_92"
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
		["33"] = 21,
		["34"] = 24,
		["35"] = 12,
		["36"] = 25,
		["37"] = 26,
		["38"] = 27,
		["39"] = 25,
		["40"] = 29,
		["41"] = 30,
		["42"] = 31,
		["43"] = 31,
		["44"] = 30,
		["45"] = 29,
		["46"] = 34,
		["47"] = 35,
		["48"] = 36,
		["49"] = 37,
		["50"] = 38,
		["51"] = 39,
		["52"] = 44,
		["53"] = 45,
		["54"] = 46,
		["55"] = 47,
		["56"] = 48,
		["57"] = 48,
		["58"] = 48,
		["59"] = 48,
		["60"] = 48,
		["61"] = 48,
		["62"] = 48,
		["63"] = 49,
		["64"] = 50,
		["65"] = 55,
		["66"] = 48,
		["67"] = 48,
		["70"] = 34,
		["71"] = 21,
		["72"] = 12,
		["73"] = 12,
		["74"] = 12,
		["75"] = 12,
		["76"] = 12,
		["77"] = 12,
		["78"] = 12,
		["79"] = 12,
		["80"] = 12,
		["81"] = 21,
		["83"] = 21,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseItem
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.item_artifact_92 = c()
local o = h.item_artifact_92
o.name = "item_artifact_92"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_92"
end
o = e({ k(nil) }, o)
h.item_artifact_92 = o
h.modifier_item_artifact_92 = c()
local p = h.modifier_item_artifact_92
p.name = "modifier_item_artifact_92"
d(p, m)
function p.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.record = 0
end
function p.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.ability_count = self:GetAbilitySpecialValueFor("ability_count")
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BUY_EFFECT_CARD] = { self:GetParent(), -1 } }
end
function p.prototype.OnBuyEffectCard(self, q)
	self.record = self.record + 1
	if self.record >= self.ability_count then
		self.record = 0
		local r = self:GetParent():GetPlayerOwnerID()
		local s = AbilityShop:getRandomAbility(
			r,
			self.count,
			{ isAbilityShop = false, specifyRarity = "n", specifyRarityIgnoreRule = true }
		)
		local t = PlayerData:getplayerData(r)
		local u = self:GetAbility():entindex()
		local v = t.hero
		if #s > 0 and v then
			f(s, function(w, x, y)
				local z
				local A
				A = x.aid
				z = x.rarity
				v:learnAbility(A, true)
				Notification:combatToPlayer(
					r,
					{
						message = "notify_artifact_ability_" .. z,
						string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_92",
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. A,
					}
				)
				t:addArtifactAbilities(u, A, y == #s - 1)
			end)
		end
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
h.modifier_item_artifact_92 = p
return h