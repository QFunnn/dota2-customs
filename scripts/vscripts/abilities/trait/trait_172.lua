--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_172"
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
		["27"] = 19,
		["28"] = 12,
		["29"] = 19,
		["31"] = 19,
		["32"] = 23,
		["33"] = 24,
		["34"] = 12,
		["35"] = 27,
		["36"] = 28,
		["37"] = 29,
		["38"] = 30,
		["39"] = 27,
		["40"] = 33,
		["41"] = 34,
		["44"] = 35,
		["45"] = 33,
		["46"] = 38,
		["47"] = 39,
		["50"] = 40,
		["51"] = 40,
		["52"] = 40,
		["53"] = 40,
		["54"] = 40,
		["55"] = 38,
		["56"] = 43,
		["57"] = 44,
		["58"] = 44,
		["59"] = 46,
		["60"] = 46,
		["61"] = 46,
		["62"] = 44,
		["63"] = 47,
		["64"] = 47,
		["65"] = 47,
		["66"] = 44,
		["67"] = 44,
		["68"] = 43,
		["69"] = 51,
		["70"] = 52,
		["71"] = 53,
		["72"] = 51,
		["73"] = 56,
		["74"] = 57,
		["75"] = 58,
		["76"] = 59,
		["77"] = 60,
		["79"] = 56,
		["80"] = 64,
		["81"] = 65,
		["82"] = 64,
		["83"] = 68,
		["84"] = 69,
		["87"] = 70,
		["90"] = 71,
		["91"] = 72,
		["92"] = 73,
		["95"] = 76,
		["98"] = 77,
		["99"] = 78,
		["100"] = 79,
		["101"] = 68,
		["102"] = 82,
		["103"] = 83,
		["104"] = 84,
		["105"] = 85,
		["106"] = 82,
		["107"] = 88,
		["108"] = 89,
		["109"] = 90,
		["110"] = 90,
		["111"] = 90,
		["112"] = 90,
		["113"] = 90,
		["114"] = 88,
		["115"] = 19,
		["116"] = 12,
		["117"] = 12,
		["118"] = 12,
		["119"] = 12,
		["120"] = 12,
		["121"] = 12,
		["122"] = 12,
		["123"] = 19,
		["125"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_172 = c()
local n = g.trait_172
n.name = "trait_172"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_172"
end
n = e({ j(nil) }, n)
g.trait_172 = n
g.modifier_trait_172 = c()
local o = g.modifier_trait_172
o.name = "modifier_trait_172"
d(o, l)
function o.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.buyCountThisRound = 0
	self.refreshCount = 0
end
function o.prototype.GetAbilitySpecialValue(self)
	self.fragment_cost = self:GetAbilitySpecialValueFor("fragment_cost")
	self.refresh_interval = self:GetAbilitySpecialValueFor("refresh_interval")
	self.max_buy_per_round = self:GetAbilitySpecialValueFor("max_buy_per_round")
end
function o.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RollAttributeFragment()
end
function o.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	CustomNetTables:SetTableValue("trait_172_shop", "player_" .. tostring(self:GetParent():GetPlayerOwnerID()), nil)
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_SHOP_REFRESH] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_SHOP_RANDOM] = { self:GetParent(), -1 },
	}
end
function o.prototype.OnRoundChange(self, p)
	self.buyCountThisRound = 0
	self:UpdateShopData()
end
function o.prototype.OnShopRefresh(self)
	self.refreshCount = self.refreshCount + 1
	if self.refreshCount >= self.refresh_interval then
		self.refreshCount = 0
		self:RollAttributeFragment()
	end
end
function o.prototype.OnShopRandom(self)
	self:OnShopRefresh()
end
function o.prototype.BuyAttributeFragment(self)
	if not IsServer() or not self.currentSlot then
		return
	end
	if self.buyCountThisRound >= self.max_buy_per_round then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	if PlayerData:getGold(q) < self.fragment_cost then
		ErrorMessage(q, "dota_hud_error_not_enough_gold")
		return
	end
	if not Greevil:grantAttributeFragment(q, self.currentSlot) then
		return
	end
	PlayerData:modifyGold(q, -self.fragment_cost)
	self.buyCountThisRound = self.buyCountThisRound + 1
	self:UpdateShopData()
end
function o.prototype.RollAttributeFragment(self)
	local q = self:GetParent():GetPlayerOwnerID()
	self.currentSlot = Greevil:rollAttributeFragment(q, self.fragment_cost)
	self:UpdateShopData()
end
function o.prototype.UpdateShopData(self)
	local q = self:GetParent():GetPlayerOwnerID()
	CustomNetTables:SetTableValue(
		"trait_172_shop",
		"player_" .. tostring(q),
		{ slot = self.currentSlot, sold_out = self.buyCountThisRound >= self.max_buy_per_round }
	)
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_172 = o
return g