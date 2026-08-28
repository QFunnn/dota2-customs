--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_effect/greevil_effect_5"
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
		["13"] = 4,
		["14"] = 4,
		["15"] = 4,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 5,
		["20"] = 8,
		["21"] = 9,
		["24"] = 12,
		["25"] = 13,
		["28"] = 16,
		["29"] = 17,
		["30"] = 19,
		["31"] = 20,
		["32"] = 22,
		["33"] = 23,
		["34"] = 24,
		["37"] = 8,
		["38"] = 30,
		["39"] = 37,
		["40"] = 30,
		["41"] = 37,
		["42"] = 41,
		["43"] = 42,
		["44"] = 41,
		["45"] = 44,
		["46"] = 45,
		["47"] = 46,
		["49"] = 44,
		["50"] = 49,
		["51"] = 50,
		["52"] = 51,
		["54"] = 49,
		["55"] = 55,
		["56"] = 56,
		["57"] = 55,
		["58"] = 59,
		["59"] = 60,
		["60"] = 59,
		["61"] = 37,
		["62"] = 30,
		["63"] = 30,
		["64"] = 30,
		["65"] = 30,
		["66"] = 30,
		["67"] = 30,
		["68"] = 30,
		["69"] = 37,
		["71"] = 37,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = require("abilities.greevil_effect.greevil_effect_base")
local l = k.GreevilEffectBase
g.greevil_effect_5 = c()
local m = g.greevil_effect_5
m.name = "greevil_effect_5"
d(m, l)
function m.prototype.spawn(self)
	self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END, self.OnBattleEnd)
end
function m.prototype.OnBattleEnd(self, n)
	if n.isNeutral ~= nil then
		return
	end
	local o = self:getPlayerID()
	if n.illusionPlayerID == o then
		return
	end
	local p = self:getSpecialValueFor("free_refresh_count")
	if n.losePlayerID == o then
		PlayerData:ModifyFreeRefresh(o, p)
	elseif n.winPlayerID == o then
		local q = PlayerResource:GetSelectedHeroEntity(o)
		if IsValid(q) then
			self:AddCourierBuff("modifier_greevil_effect_5", {})
		end
	end
end
g.modifier_greevil_effect_5 = c()
local r = g.modifier_greevil_effect_5
r.name = "modifier_greevil_effect_5"
d(r, i)
function r.prototype.GetAbilitySpecialValue(self)
	self.interest_limit = self:GetGreevilEffectValueFor("greevil_effect_5", "interest_limit")
end
function r.prototype.OnCreated(self, n)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function r.prototype.OnRefresh(self, n)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_INTEREST_LIMIT }
end
function r.prototype.EOM_GetModifierExtraInterest_Limit(self, s)
	return self:GetStackCount() * self.interest_limit
end
r = e(
	{ j(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	r
)
g.modifier_greevil_effect_5 = r
return g