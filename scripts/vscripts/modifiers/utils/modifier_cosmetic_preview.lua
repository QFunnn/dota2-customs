--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_cosmetic_preview"
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
		["11"] = 4,
		["12"] = 13,
		["13"] = 4,
		["14"] = 13,
		["15"] = 15,
		["16"] = 16,
		["17"] = 15,
		["18"] = 22,
		["19"] = 23,
		["20"] = 24,
		["22"] = 22,
		["23"] = 27,
		["24"] = 28,
		["25"] = 27,
		["26"] = 33,
		["27"] = 34,
		["28"] = 33,
		["29"] = 36,
		["30"] = 37,
		["31"] = 38,
		["32"] = 36,
		["33"] = 40,
		["34"] = 41,
		["35"] = 40,
		["36"] = 45,
		["37"] = 46,
		["38"] = 45,
		["39"] = 48,
		["40"] = 49,
		["41"] = 48,
		["42"] = 53,
		["43"] = 54,
		["44"] = 53,
		["45"] = 13,
		["46"] = 4,
		["47"] = 4,
		["48"] = 4,
		["49"] = 4,
		["50"] = 4,
		["51"] = 4,
		["52"] = 4,
		["53"] = 4,
		["54"] = 13,
		["56"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_cosmetic_preview = c()
local k = g.modifier_cosmetic_preview
k.name = "modifier_cosmetic_preview"
d(k, i)
function k.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self.parent:SetBaseManaRegen(0)
	end
end
function k.prototype.EDeclareEvents(self)
	return { [MODIFIER_EVENT_ON_ATTACK_LANDED] = { self.parent, -1 }, [MODIFIER_EVENT_ON_ATTACK_START] = {
		self.parent,
		-1,
	} }
end
function k.prototype.OnAttackLanded(self, l)
	DamageSystem:performAttack(l.attacker, l.target, self.attackEventInfo, true)
end
function k.prototype.OnAttackStart(self, l)
	self.attackEventInfo = DamageSystem:parseAttackParams(l.attacker, l.target, {})
	FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_START, self.attackEventInfo, l.attacker, l.target)
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT }
end
function k.prototype.GetModifierBaseAttackTimeConstant(self)
	return GetAttackRate(self.parent)
end
function k.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_OVERRIDE] = 20 }
end
function k.prototype.ECheckState(self)
	return { [EOMModifierStates.MODIFIER_STATE_NO_HEALTH_BAR] = true }
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	k
)
g.modifier_cosmetic_preview = k
return g