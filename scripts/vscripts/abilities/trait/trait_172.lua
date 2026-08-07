--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_172"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIncludes
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
		["15"] = 5,
		["16"] = 6,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 8,
		["21"] = 7,
		["22"] = 6,
		["23"] = 5,
		["24"] = 6,
		["26"] = 6,
		["27"] = 12,
		["28"] = 19,
		["29"] = 12,
		["30"] = 19,
		["32"] = 19,
		["33"] = 23,
		["34"] = 24,
		["35"] = 12,
		["36"] = 27,
		["37"] = 28,
		["38"] = 29,
		["39"] = 30,
		["40"] = 27,
		["41"] = 33,
		["42"] = 34,
		["45"] = 35,
		["46"] = 33,
		["47"] = 38,
		["48"] = 39,
		["51"] = 40,
		["52"] = 40,
		["53"] = 40,
		["54"] = 40,
		["55"] = 40,
		["56"] = 38,
		["57"] = 43,
		["58"] = 44,
		["59"] = 44,
		["60"] = 46,
		["61"] = 46,
		["62"] = 46,
		["63"] = 44,
		["64"] = 47,
		["65"] = 47,
		["66"] = 47,
		["67"] = 44,
		["68"] = 44,
		["69"] = 43,
		["70"] = 51,
		["71"] = 52,
		["72"] = 53,
		["73"] = 51,
		["74"] = 56,
		["75"] = 57,
		["76"] = 58,
		["77"] = 59,
		["78"] = 60,
		["80"] = 56,
		["81"] = 64,
		["82"] = 65,
		["83"] = 64,
		["84"] = 68,
		["85"] = 69,
		["88"] = 70,
		["91"] = 71,
		["92"] = 72,
		["93"] = 73,
		["96"] = 76,
		["99"] = 77,
		["100"] = 78,
		["101"] = 80,
		["102"] = 81,
		["103"] = 81,
		["105"] = 82,
		["106"] = 82,
		["107"] = 82,
		["108"] = 82,
		["109"] = 82,
		["110"] = 83,
		["111"] = 68,
		["112"] = 86,
		["113"] = 87,
		["114"] = 88,
		["115"] = 89,
		["116"] = 86,
		["117"] = 92,
		["118"] = 93,
		["119"] = 94,
		["120"] = 94,
		["121"] = 94,
		["122"] = 94,
		["123"] = 94,
		["124"] = 92,
		["125"] = 19,
		["126"] = 12,
		["127"] = 12,
		["128"] = 12,
		["129"] = 12,
		["130"] = 12,
		["131"] = 12,
		["132"] = 12,
		["133"] = 19,
		["135"] = 19,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.trait_172 = c()
local o = h.trait_172
o.name = "trait_172"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_172"
end
o = e({ k(nil) }, o)
h.trait_172 = o
h.modifier_trait_172 = c()
local p = h.modifier_trait_172
p.name = "modifier_trait_172"
d(p, m)
function p.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.buyCountThisRound = 0
	self.refreshCount = 0
end
function p.prototype.GetAbilitySpecialValue(self)
	self.fragment_cost = self:GetAbilitySpecialValueFor("fragment_cost")
	self.refresh_interval = self:GetAbilitySpecialValueFor("refresh_interval")
	self.max_buy_per_round = self:GetAbilitySpecialValueFor("max_buy_per_round")
end
function p.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RollAttributeFragment()
end
function p.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	CustomNetTables:SetTableValue("trait_172_shop", "player_" .. tostring(self:GetParent():GetPlayerOwnerID()), nil)
end
function p.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_SHOP_REFRESH] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_SHOP_RANDOM] = { self:GetParent(), -1 },
	}
end
function p.prototype.OnRoundChange(self, q)
	self.buyCountThisRound = 0
	self:UpdateShopData()
end
function p.prototype.OnShopRefresh(self)
	self.refreshCount = self.refreshCount + 1
	if self.refreshCount >= self.refresh_interval then
		self.refreshCount = 0
		self:RollAttributeFragment()
	end
end
function p.prototype.OnShopRandom(self)
	self:OnShopRefresh()
end
function p.prototype.BuyAttributeFragment(self)
	if not IsServer() or not self.currentSlot then
		return
	end
	if self.buyCountThisRound >= self.max_buy_per_round then
		return
	end
	local r = self:GetParent():GetPlayerOwnerID()
	if PlayerData:getGold(r) < self.fragment_cost then
		ErrorMessage(r, "dota_hud_error_not_enough_gold")
		return
	end
	if not Greevil:grantAttributeFragment(r, self.currentSlot) then
		return
	end
	PlayerData:modifyGold(r, -self.fragment_cost)
	self.buyCountThisRound = self.buyCountThisRound + 1
	local s = self.currentSlot.value
	if not f(ITEM_ATTRIBUTE, s) then
		s = "item_" .. s
	end
	PlayerData:modifyForgeAttribute(r, s, tonumber(self.currentSlot.special) or 0)
	self:UpdateShopData()
end
function p.prototype.RollAttributeFragment(self)
	local r = self:GetParent():GetPlayerOwnerID()
	self.currentSlot = Greevil:rollAttributeFragment(r, self.fragment_cost)
	self:UpdateShopData()
end
function p.prototype.UpdateShopData(self)
	local r = self:GetParent():GetPlayerOwnerID()
	CustomNetTables:SetTableValue(
		"trait_172_shop",
		"player_" .. tostring(r),
		{ slot = self.currentSlot, sold_out = self.buyCountThisRound >= self.max_buy_per_round }
	)
end
p = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	p
)
h.modifier_trait_172 = p
return h