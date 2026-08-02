--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_117"
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
		["30"] = 22,
		["31"] = 23,
		["32"] = 22,
		["33"] = 25,
		["34"] = 26,
		["35"] = 27,
		["36"] = 28,
		["38"] = 25,
		["39"] = 31,
		["40"] = 32,
		["41"] = 33,
		["42"] = 34,
		["44"] = 31,
		["45"] = 37,
		["46"] = 38,
		["47"] = 37,
		["48"] = 42,
		["49"] = 43,
		["50"] = 44,
		["51"] = 45,
		["52"] = 46,
		["53"] = 47,
		["56"] = 50,
		["57"] = 51,
		["58"] = 52,
		["59"] = 53,
		["60"] = 54,
		["61"] = 54,
		["62"] = 54,
		["63"] = 54,
		["64"] = 54,
		["66"] = 56,
		["69"] = 42,
		["70"] = 20,
		["71"] = 12,
		["72"] = 12,
		["73"] = 12,
		["74"] = 12,
		["75"] = 12,
		["76"] = 12,
		["77"] = 12,
		["78"] = 12,
		["79"] = 20,
		["81"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_117 = c()
local n = g.item_artifact_117
n.name = "item_artifact_117"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_117"
end
n = e({ j(nil) }, n)
g.item_artifact_117 = n
g.modifier_item_artifact_117 = c()
local o = g.modifier_item_artifact_117
o.name = "modifier_item_artifact_117"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold_reduce = self:GetAbilitySpecialValueFor("gold_reduce")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		PlayerData:setRandomGoldCost(q, -self.gold_reduce)
	end
end
function o.prototype.OnDestroy(self)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		PlayerData:setRandomGoldCost(q, self.gold_reduce)
	end
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CUSTOM_SHOP_RANDOM_RESULT }
end
function o.prototype.EOM_GetModifierCustomShopRandomResult(self, p)
	if p then
		local r = {}
		for s, t in pairs(p) do
			if not t.soldOut then
				r[#r + 1] = tostring(s)
			end
		end
		local t = GetRandomElement(r)
		if t then
			local u = PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			if u then
				u:modifyArtifactExtraData(self:GetAbility():entindex(), "DOTA_Tooltip_ability_trait_103_effect", 1)
			end
			return t
		end
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
g.modifier_item_artifact_117 = o
return g