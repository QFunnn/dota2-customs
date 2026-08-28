--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		["33"] = 22,
		["34"] = 23,
		["35"] = 24,
		["36"] = 12,
		["37"] = 27,
		["38"] = 28,
		["39"] = 29,
		["40"] = 27,
		["41"] = 32,
		["42"] = 33,
		["45"] = 34,
		["46"] = 32,
		["47"] = 37,
		["48"] = 38,
		["51"] = 39,
		["52"] = 39,
		["53"] = 39,
		["54"] = 39,
		["55"] = 39,
		["56"] = 37,
		["57"] = 42,
		["58"] = 43,
		["59"] = 43,
		["60"] = 45,
		["61"] = 45,
		["62"] = 45,
		["63"] = 43,
		["64"] = 43,
		["65"] = 42,
		["66"] = 50,
		["67"] = 51,
		["68"] = 52,
		["69"] = 50,
		["70"] = 55,
		["71"] = 56,
		["72"] = 57,
		["73"] = 58,
		["74"] = 59,
		["76"] = 55,
		["77"] = 67,
		["78"] = 68,
		["81"] = 69,
		["82"] = 70,
		["83"] = 71,
		["84"] = 72,
		["87"] = 75,
		["90"] = 76,
		["91"] = 77,
		["92"] = 78,
		["93"] = 80,
		["94"] = 81,
		["95"] = 81,
		["97"] = 82,
		["98"] = 82,
		["99"] = 82,
		["100"] = 82,
		["101"] = 82,
		["102"] = 83,
		["103"] = 67,
		["104"] = 86,
		["105"] = 87,
		["106"] = 86,
		["107"] = 90,
		["108"] = 91,
		["109"] = 92,
		["110"] = 93,
		["111"] = 94,
		["112"] = 90,
		["113"] = 97,
		["114"] = 98,
		["115"] = 99,
		["116"] = 100,
		["118"] = 102,
		["119"] = 102,
		["120"] = 102,
		["121"] = 102,
		["122"] = 102,
		["123"] = 97,
		["124"] = 19,
		["125"] = 12,
		["126"] = 12,
		["127"] = 12,
		["128"] = 12,
		["129"] = 12,
		["130"] = 12,
		["131"] = 12,
		["132"] = 19,
		["134"] = 19,
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
	self.soldOut = false
end
function p.prototype.GetAbilitySpecialValue(self)
	self.fragment_cost = self:GetAbilitySpecialValueFor("fragment_cost")
	self.refresh_interval = self:GetAbilitySpecialValueFor("refresh_interval")
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
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_REFRESH] = { self:GetParent(), -1 },
	}
end
function p.prototype.OnRoundChange(self, q)
	self.buyCountThisRound = 0
	self:UpdateShopData()
end
function p.prototype.OnAbilityRefresh(self, q)
	self.refreshCount = self.refreshCount + 1
	if self.refreshCount >= self.refresh_interval then
		self.refreshCount = 0
		self:RollAttributeFragment()
	end
end
function p.prototype.BuyAttributeFragment(self)
	if not IsServer() or not self.currentSlot or self.soldOut then
		return
	end
	local r = self:GetParent():GetPlayerOwnerID()
	local s = self:GetCurrentCost()
	if PlayerData:getGold(r) < s then
		ErrorMessage(r, "dota_hud_error_not_enough_gold")
		return
	end
	if not Greevil:grantAttributeFragment(r, self.currentSlot) then
		return
	end
	PlayerData:modifyGold(r, -s)
	self.buyCountThisRound = self.buyCountThisRound + 1
	self.soldOut = true
	local t = self.currentSlot.value
	if not f(ITEM_ATTRIBUTE, t) then
		t = "item_" .. t
	end
	PlayerData:modifyForgeAttribute(r, t, tonumber(self.currentSlot.special) or 0)
	self:UpdateShopData()
end
function p.prototype.GetCurrentCost(self)
	return self.fragment_cost * 2 ^ self.buyCountThisRound
end
function p.prototype.RollAttributeFragment(self)
	local r = self:GetParent():GetPlayerOwnerID()
	self.currentSlot = Greevil:rollAttributeFragment(r, self.fragment_cost)
	self.soldOut = false
	self:UpdateShopData()
end
function p.prototype.UpdateShopData(self)
	local r = self:GetParent():GetPlayerOwnerID()
	if self.currentSlot then
		self.currentSlot.cost = self:GetCurrentCost()
	end
	CustomNetTables:SetTableValue(
		"trait_172_shop",
		"player_" .. tostring(r),
		{ slot = self.currentSlot, sold_out = self.soldOut }
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