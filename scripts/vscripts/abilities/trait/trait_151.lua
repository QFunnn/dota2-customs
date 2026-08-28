--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_151"
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
		["14"] = 6,
		["15"] = 7,
		["16"] = 6,
		["17"] = 7,
		["18"] = 8,
		["19"] = 9,
		["20"] = 8,
		["21"] = 11,
		["22"] = 12,
		["24"] = 11,
		["25"] = 7,
		["26"] = 6,
		["27"] = 7,
		["29"] = 7,
		["30"] = 17,
		["31"] = 24,
		["32"] = 17,
		["33"] = 24,
		["34"] = 26,
		["35"] = 27,
		["36"] = 26,
		["37"] = 29,
		["38"] = 30,
		["39"] = 29,
		["40"] = 34,
		["41"] = 35,
		["42"] = 34,
		["43"] = 40,
		["44"] = 41,
		["45"] = 42,
		["46"] = 43,
		["47"] = 44,
		["48"] = 50,
		["49"] = 50,
		["50"] = 50,
		["51"] = 50,
		["52"] = 50,
		["53"] = 50,
		["55"] = 40,
		["56"] = 24,
		["57"] = 17,
		["58"] = 17,
		["59"] = 17,
		["60"] = 17,
		["61"] = 17,
		["62"] = 17,
		["63"] = 17,
		["64"] = 24,
		["66"] = 24,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_151 = c()
local n = g.trait_151
n.name = "trait_151"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_151"
end
function n.prototype.Spawn(self)
	if IsServer() then
	end
end
n = e({ j(nil) }, n)
g.trait_151 = n
g.modifier_trait_151 = c()
local o = g.modifier_trait_151
o.name = "modifier_trait_151"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gain_gold = self:GetAbilitySpecialValueFor("gain_gold")
end
function o.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_CUSTOM_SHOP_EXTRA_SLOT_COUNT] = 1 }
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY] = { self.caster } }
end
function o.prototype.OnAbilityBuy(self, p)
	local q = self.caster:GetPlayerOwnerID()
	if p.playerhero:GetPlayerOwnerID() == q then
		local r = p.cost * self.gain_gold * 0.01
		PlayerData:modifyGold(q, r)
		PlayerData:getplayerData(self:GetCaster():GetPlayerOwnerID())
			:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", r, true)
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_151 = o
return g