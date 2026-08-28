--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_16"
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
		["20"] = 6,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 10,
		["27"] = 17,
		["28"] = 10,
		["29"] = 17,
		["30"] = 19,
		["31"] = 20,
		["32"] = 19,
		["33"] = 22,
		["34"] = 23,
		["35"] = 24,
		["36"] = 24,
		["37"] = 24,
		["38"] = 23,
		["39"] = 23,
		["40"] = 23,
		["41"] = 22,
		["42"] = 28,
		["43"] = 29,
		["44"] = 30,
		["45"] = 30,
		["46"] = 30,
		["47"] = 30,
		["48"] = 30,
		["49"] = 30,
		["50"] = 28,
		["51"] = 32,
		["52"] = 37,
		["53"] = 38,
		["54"] = 39,
		["55"] = 39,
		["56"] = 39,
		["57"] = 39,
		["58"] = 39,
		["59"] = 39,
		["60"] = 39,
		["61"] = 39,
		["63"] = 32,
		["64"] = 17,
		["65"] = 10,
		["66"] = 10,
		["67"] = 10,
		["68"] = 10,
		["69"] = 10,
		["70"] = 10,
		["71"] = 10,
		["72"] = 17,
		["74"] = 17,
		["75"] = 42,
		["76"] = 49,
		["77"] = 42,
		["78"] = 49,
		["79"] = 51,
		["80"] = 52,
		["81"] = 51,
		["82"] = 54,
		["83"] = 55,
		["84"] = 54,
		["85"] = 49,
		["86"] = 42,
		["87"] = 42,
		["88"] = 42,
		["89"] = 42,
		["90"] = 42,
		["91"] = 42,
		["92"] = 42,
		["93"] = 49,
		["95"] = 49,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_16 = c()
local n = g.treasure_16
n.name = "treasure_16"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_16"
end
n = e({ j(nil) }, n)
g.treasure_16 = n
g.modifier_treasure_16 = c()
local o = g.modifier_treasure_16
o.name = "modifier_treasure_16"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.healPct = self:GetAbilitySpecialValueFor("heal_damage_pct")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_TAKEDAMAGE] = { -1, -1 },
	}
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_treasure_16_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_treasure_16_buff", {})
end
function o.prototype.OnPlayerTakeDamage(self, q)
	local r = self:GetParent():GetPlayerOwnerID()
	if q.attackerID == r and q.victimID ~= r and q.damage > 0 then
		PlayerData:modifyHealth(r, math.max(1, math.floor(q.damage * self.healPct * 0.01)), true)
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_treasure_16 = o
g.modifier_treasure_16_buff = c()
local s = g.modifier_treasure_16_buff
s.name = "modifier_treasure_16_buff"
d(s, l)
function s.prototype.GetAbilitySpecialValue(self)
	self.steal = self:GetAbilitySpecialValueFor("skill_steal_health")
end
function s.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ABILITY_LIFESTEAL] = self.steal }
end
s = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	s
)
g.modifier_treasure_16_buff = s
return g