--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_30"
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
		["20"] = 8,
		["22"] = 6,
		["23"] = 11,
		["24"] = 11,
		["25"] = 17,
		["26"] = 18,
		["27"] = 17,
		["28"] = 5,
		["29"] = 4,
		["30"] = 5,
		["32"] = 5,
		["33"] = 22,
		["34"] = 31,
		["35"] = 22,
		["36"] = 31,
		["37"] = 34,
		["38"] = 35,
		["39"] = 36,
		["40"] = 34,
		["41"] = 38,
		["42"] = 39,
		["43"] = 40,
		["44"] = 41,
		["45"] = 42,
		["46"] = 43,
		["48"] = 38,
		["49"] = 47,
		["50"] = 48,
		["51"] = 47,
		["52"] = 52,
		["53"] = 53,
		["54"] = 54,
		["55"] = 54,
		["56"] = 53,
		["57"] = 52,
		["58"] = 58,
		["59"] = 59,
		["60"] = 60,
		["61"] = 61,
		["62"] = 61,
		["63"] = 61,
		["64"] = 61,
		["66"] = 58,
		["67"] = 31,
		["68"] = 22,
		["69"] = 22,
		["70"] = 22,
		["71"] = 22,
		["72"] = 22,
		["73"] = 22,
		["74"] = 22,
		["75"] = 22,
		["76"] = 22,
		["77"] = 31,
		["79"] = 31,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_30 = c()
local n = g.item_artifact_30
n.name = "item_artifact_30"
d(n, i)
function n.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(self:GetSpecialValueFor("refresh"))
	end
end
function n.prototype.OnSpellStart(self) end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_30"
end
n = e({ j(nil) }, n)
g.item_artifact_30 = n
g.modifier_item_artifact_30 = c()
local o = g.modifier_item_artifact_30
o.name = "modifier_item_artifact_30"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.refresh = self:GetAbilitySpecialValueFor("refresh")
	self.shop_product_add = self:GetAbilitySpecialValueFor("shop_product_add")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent()
		local r = q:GetPlayerOwnerID()
		PlayerData:ModifyFreeRefresh(r, self.refresh)
		PlayerData:ModifyFreeRefreshByKey(r, "item_artifact_30", self.refresh)
	end
end
function o.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_CUSTOM_SHOP_EXTRA_SLOT_COUNT] = self.shop_product_add }
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_REFRESH] = { self:GetParent(), -1 } }
end
function o.prototype.OnAbilityRefresh(self, p)
	if IsServer() then
		local s = self:GetAbility()
		s:SetCurrentCharges(PlayerData:GetFreeRefreshByKey(self:GetCaster():GetPlayerOwnerID(), "item_artifact_30"))
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
g.modifier_item_artifact_30 = o
return g