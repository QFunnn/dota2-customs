--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_effect/greevil_effect_12"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ObjectEntries
local f = b.__TS__DecorateLegacy
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 4,
		["15"] = 4,
		["16"] = 4,
		["17"] = 4,
		["18"] = 5,
		["19"] = 7,
		["20"] = 5,
		["21"] = 12,
		["22"] = 21,
		["23"] = 12,
		["24"] = 21,
		["25"] = 24,
		["26"] = 25,
		["27"] = 24,
		["28"] = 27,
		["29"] = 28,
		["30"] = 29,
		["31"] = 30,
		["33"] = 27,
		["34"] = 33,
		["35"] = 34,
		["36"] = 35,
		["39"] = 36,
		["40"] = 37,
		["41"] = 38,
		["42"] = 39,
		["43"] = 39,
		["44"] = 39,
		["45"] = 40,
		["46"] = 41,
		["47"] = 42,
		["50"] = 45,
		["51"] = 33,
		["52"] = 47,
		["53"] = 48,
		["54"] = 47,
		["55"] = 52,
		["56"] = 53,
		["57"] = 52,
		["58"] = 21,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 12,
		["63"] = 12,
		["64"] = 12,
		["65"] = 12,
		["66"] = 12,
		["67"] = 12,
		["68"] = 21,
		["70"] = 21,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("abilities.greevil_effect.greevil_effect_base")
local m = l.GreevilEffectBase
h.greevil_effect_12 = c()
local n = h.greevil_effect_12
n.name = "greevil_effect_12"
d(n, m)
function n.prototype.spawn(self)
	self:AddBattleBuff("modifier_greevil_effect_12")
end
h.modifier_greevil_effect_12 = c()
local o = h.modifier_greevil_effect_12
o.name = "modifier_greevil_effect_12"
d(o, j)
function o.prototype.GetAbilitySpecialValue(self)
	self.damage_bonus = self:GetGreevilEffectValueFor("greevil_effect_12", "damage_bonus")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		print("modifier_greevil_effect_12 created")
		self:UpdateStackCount()
	end
end
function o.prototype.UpdateStackCount(self)
	local q = self:GetParent():GetHeroBase()
	if not q then
		return
	end
	local r = q:getAbilityUpgradeData(true, true)
	local s = KeyValues.AbilityUpgradesKvs
	local t = 0
	for u, v in ipairs(e(r)) do
		local w = v[1]
		local x = v[2]
		local y = s[w]
		if y and y.rarity == "n" and x.level >= SECT_ABILITY_LEVEL.n then
			t = t + 1
		end
	end
	self:SetStackCount(t)
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function o.prototype.EOM_GetModifierOutgoingDamagePercentage(self)
	return self.damage_bonus * self:GetStackCount()
end
o = f(
	{
		k(
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
h.modifier_greevil_effect_12 = o
return h