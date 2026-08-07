--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_72"
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
		["31"] = 24,
		["32"] = 25,
		["33"] = 26,
		["34"] = 27,
		["35"] = 24,
		["36"] = 29,
		["37"] = 30,
		["38"] = 31,
		["39"] = 31,
		["40"] = 31,
		["41"] = 31,
		["43"] = 29,
		["44"] = 34,
		["45"] = 35,
		["46"] = 36,
		["47"] = 36,
		["48"] = 36,
		["49"] = 35,
		["50"] = 37,
		["51"] = 37,
		["52"] = 37,
		["53"] = 35,
		["54"] = 35,
		["55"] = 34,
		["56"] = 40,
		["57"] = 41,
		["58"] = 42,
		["59"] = 43,
		["60"] = 44,
		["61"] = 45,
		["62"] = 46,
		["63"] = 47,
		["64"] = 48,
		["65"] = 48,
		["66"] = 48,
		["67"] = 49,
		["68"] = 50,
		["69"] = 51,
		["70"] = 56,
		["71"] = 56,
		["72"] = 56,
		["73"] = 56,
		["74"] = 56,
		["75"] = 48,
		["76"] = 48,
		["79"] = 60,
		["80"] = 40,
		["81"] = 62,
		["82"] = 63,
		["83"] = 64,
		["84"] = 64,
		["85"] = 64,
		["86"] = 64,
		["87"] = 64,
		["89"] = 62,
		["90"] = 20,
		["91"] = 11,
		["92"] = 11,
		["93"] = 11,
		["94"] = 11,
		["95"] = 11,
		["96"] = 11,
		["97"] = 11,
		["98"] = 11,
		["99"] = 11,
		["100"] = 20,
		["102"] = 20,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseItem
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.item_artifact_72 = c()
local o = h.item_artifact_72
o.name = "item_artifact_72"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_72"
end
o = e({ k(nil) }, o)
h.item_artifact_72 = o
h.modifier_item_artifact_72 = c()
local p = h.modifier_item_artifact_72
p.name = "modifier_item_artifact_72"
d(p, m)
function p.prototype.GetAbilitySpecialValue(self)
	self.stack = self:GetAbilitySpecialValueFor("stack")
	self.random_gold_reduce = self:GetAbilitySpecialValueFor("random_gold_reduce")
	self.record = 0
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		PlayerData:setRandomGoldCost(self:GetParent():GetPlayerOwnerID(), -self.random_gold_reduce)
	end
end
function p.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_SHOP_RANDOM] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_RANDOM] = { self:GetParent(), -1 },
	}
end
function p.prototype.OnAbilityRandom(self, q)
	self.record = self.record + 1
	if self.record >= self.stack then
		self.record = 0
		local r = self:GetParent():GetPlayerOwnerID()
		local s = PlayerData:getHero(r)
		if s then
			local t = AbilityShop:getRandomAbility(r, 1, { specifyRarity = "r" })
			f(t, function(u, v, w)
				local x = v.aid
				s:learnAbility(x, true)
				Notification:combatToPlayer(
					r,
					{
						message = "notify_artifact_ability_" .. v.rarity,
						string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_39",
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. x,
					}
				)
				PlayerData:getplayerData(r):addArtifactAbilities(self:GetAbility():entindex(), x, w == #t - 1)
			end)
		end
	end
	self:GetAbility():SetCurrentCharges(self.record)
end
function p.prototype.OnShopRandom(self)
	if self.random_gold_reduce > 0 then
		PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			:modifyArtifactExtraData(self:GetAbility():entindex(), "gold_reduce", self.random_gold_reduce)
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
h.modifier_item_artifact_72 = p
return h