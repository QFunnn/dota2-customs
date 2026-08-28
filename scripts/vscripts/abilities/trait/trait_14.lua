--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_14"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIndexOf
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
		["31"] = 20,
		["32"] = 21,
		["33"] = 22,
		["34"] = 22,
		["35"] = 21,
		["36"] = 20,
		["37"] = 25,
		["38"] = 26,
		["39"] = 27,
		["40"] = 27,
		["41"] = 27,
		["42"] = 27,
		["43"] = 27,
		["44"] = 27,
		["45"] = 25,
		["46"] = 19,
		["47"] = 12,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 12,
		["54"] = 19,
		["56"] = 19,
		["57"] = 31,
		["58"] = 38,
		["59"] = 31,
		["60"] = 38,
		["62"] = 38,
		["63"] = 43,
		["64"] = 31,
		["65"] = 44,
		["66"] = 45,
		["67"] = 46,
		["68"] = 47,
		["69"] = 44,
		["70"] = 49,
		["71"] = 50,
		["72"] = 51,
		["73"] = 52,
		["74"] = 53,
		["75"] = 54,
		["76"] = 55,
		["77"] = 56,
		["78"] = 57,
		["79"] = 58,
		["80"] = 59,
		["81"] = 60,
		["82"] = 61,
		["83"] = 61,
		["87"] = 65,
		["88"] = 65,
		["90"] = 49,
		["91"] = 68,
		["92"] = 69,
		["93"] = 68,
		["94"] = 73,
		["95"] = 74,
		["96"] = 73,
		["97"] = 78,
		["98"] = 79,
		["99"] = 79,
		["100"] = 79,
		["101"] = 79,
		["102"] = 81,
		["104"] = 83,
		["105"] = 78,
		["106"] = 38,
		["107"] = 31,
		["108"] = 31,
		["109"] = 31,
		["110"] = 31,
		["111"] = 31,
		["112"] = 31,
		["113"] = 31,
		["114"] = 38,
		["116"] = 38,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.trait_14 = c()
local o = h.trait_14
o.name = "trait_14"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_14"
end
o = e({ k(nil) }, o)
h.trait_14 = o
h.modifier_trait_14 = c()
local p = h.modifier_trait_14
p.name = "modifier_trait_14"
d(p, m)
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function p.prototype.OnTraitInit(self, q)
	q.hero:RemoveModifierByName("modifier_trait_14_buff")
	q.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_14_buff", {})
end
p = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	p
)
h.modifier_trait_14 = p
h.modifier_trait_14_buff = c()
local r = h.modifier_trait_14_buff
r.name = "modifier_trait_14_buff"
d(r, m)
function r.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.regenAbilityList = {}
end
function r.prototype.GetAbilitySpecialValue(self)
	self.heal_pct = self:GetAbilitySpecialValueFor("heal_pct")
	self.heal_damage_pct = self:GetAbilitySpecialValueFor("heal_damage_pct")
	self.damage_reduce_pct = self:GetAbilitySpecialValueFor("damage_reduce_pct")
end
function r.prototype.OnCreated(self, q)
	if IsServer() then
		local s = self:GetParent():GetUnitName()
		local t = KeyValues.CommonUnitsKv[s]
		local u = AbilityShop:GetRecommendSectByHeroName(s)
		if (string.find(u, "sect_regen", nil, true) or 0) - 1 ~= -1 then
			local v = 1
			local w
			while t["DefaultAbility" .. tostring(v)] do
				w = t["DefaultAbility" .. tostring(v)]
				v = v + 1
				if not KeyValues.HeroTalentKv[w] then
					local x = self.regenAbilityList
					x[#x + 1] = w
				end
			end
		end
		local y = self.regenAbilityList
		y[#y + 1] = "sect_regen"
	end
end
function r.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_AMPLIFY] = self.heal_pct }
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function r.prototype.EOM_GetModifierOutgoingDamagePercentage(self, q)
	if q and q.ability ~= nil and f(self.regenAbilityList, q.ability:GetAbilityName()) ~= -1 then
		return self.heal_damage_pct - self.damage_reduce_pct
	end
	return -self.damage_reduce_pct
end
r = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	r
)
h.modifier_trait_14_buff = r
return h