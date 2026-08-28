--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_effect/greevil_effect_15"
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
		["19"] = 4,
		["20"] = 5,
		["21"] = 12,
		["22"] = 21,
		["23"] = 12,
		["24"] = 21,
		["25"] = 25,
		["26"] = 26,
		["27"] = 27,
		["28"] = 25,
		["29"] = 29,
		["30"] = 29,
		["31"] = 32,
		["32"] = 33,
		["33"] = 32,
		["34"] = 37,
		["35"] = 38,
		["36"] = 39,
		["38"] = 41,
		["39"] = 37,
		["40"] = 43,
		["41"] = 44,
		["42"] = 43,
		["43"] = 48,
		["44"] = 49,
		["45"] = 50,
		["46"] = 51,
		["47"] = 52,
		["48"] = 52,
		["49"] = 52,
		["50"] = 52,
		["51"] = 53,
		["54"] = 48,
		["55"] = 21,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 12,
		["63"] = 12,
		["64"] = 12,
		["65"] = 21,
		["67"] = 21,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = require("abilities.greevil_effect.greevil_effect_base")
local l = k.GreevilEffectBase
g.greevil_effect_15 = c()
local m = g.greevil_effect_15
m.name = "greevil_effect_15"
d(m, l)
function m.prototype.spawn(self)
	self:AddBattleBuff("modifier_greevil_effect_15")
	l.prototype.spawn(self)
end
g.modifier_greevil_effect_15 = c()
local n = g.modifier_greevil_effect_15
n.name = "modifier_greevil_effect_15"
d(n, i)
function n.prototype.GetAbilitySpecialValue(self)
	self.skill_steal_health = self:GetGreevilEffectValueFor("greevil_effect_15", "skill_steal_health")
	self.heal_damage_pct = self:GetGreevilEffectValueFor("greevil_effect_15", "heal_damage_pct")
end
function n.prototype.OnCreated(self, o) end
function n.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ABILITY_LIFESTEAL }
end
function n.prototype.EOM_GetModifierAbilityLifesteal(self, o)
	if self.skill_steal_health > 0 and o.ability then
		return self.skill_steal_health
	end
	return 0
end
function n.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_TAKEDAMAGE] = { -1, -1 } }
end
function n.prototype.OnPlayerTakeDamage(self, p)
	local q = self.parent:GetPlayerOwnerID()
	if p.attackerID == q and p.victimID ~= q then
		if p.damage > 0 then
			local r = math.max(1, math.floor(p.damage * self.heal_damage_pct * 0.01))
			PlayerData:modifyHealth(q, r, true)
		end
	end
end
n = e(
	{
		j(
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
	n
)
g.modifier_greevil_effect_15 = n
return g