--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100033"
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
		["12"] = 12,
		["13"] = 4,
		["14"] = 12,
		["16"] = 12,
		["17"] = 14,
		["18"] = 4,
		["19"] = 15,
		["20"] = 16,
		["21"] = 16,
		["22"] = 16,
		["23"] = 16,
		["24"] = 16,
		["25"] = 17,
		["26"] = 17,
		["27"] = 17,
		["28"] = 17,
		["29"] = 17,
		["30"] = 18,
		["31"] = 18,
		["32"] = 18,
		["33"] = 18,
		["34"] = 18,
		["35"] = 15,
		["36"] = 30,
		["37"] = 31,
		["38"] = 32,
		["39"] = 32,
		["40"] = 32,
		["41"] = 31,
		["42"] = 33,
		["43"] = 33,
		["44"] = 33,
		["45"] = 31,
		["46"] = 31,
		["47"] = 30,
		["48"] = 36,
		["49"] = 37,
		["50"] = 36,
		["51"] = 41,
		["52"] = 42,
		["53"] = 41,
		["54"] = 47,
		["55"] = 48,
		["56"] = 49,
		["57"] = 50,
		["59"] = 47,
		["60"] = 53,
		["61"] = 54,
		["62"] = 55,
		["63"] = 56,
		["64"] = 57,
		["67"] = 53,
		["68"] = 61,
		["69"] = 62,
		["70"] = 63,
		["72"] = 65,
		["73"] = 61,
		["74"] = 67,
		["75"] = 68,
		["76"] = 69,
		["78"] = 71,
		["79"] = 67,
		["80"] = 12,
		["81"] = 4,
		["82"] = 4,
		["83"] = 4,
		["84"] = 4,
		["85"] = 4,
		["86"] = 4,
		["87"] = 4,
		["88"] = 4,
		["89"] = 12,
		["91"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100033 = c()
local k = g.modifier_5100033
k.name = "modifier_5100033"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.modifierd = false
end
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_lion/lion_base_attack.vpcf",
		"models/eom/hero/lion_1/particles/lion_1_base_attack_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_lion/lion_spell_mana_drain.vpcf",
		"models/eom/hero/lion_1/particles/lion_1_mana_drain_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_lion/lion_spell_finger_of_death.vpcf",
		"models/eom/hero/lion_1/particles/lion_1_finger_of_death_fx.vpcf"
	)
end
function k.prototype.EDeclareEvents(self)
	return {
		[MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY] = { self:GetParent(), -1 },
		[MODIFIER_EVENT_ON_ATTACKED] = { self:GetParent(), -1 },
	}
end
function k.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROJECTILE_NAME }
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND }
end
function k.prototype.OnAttacked(self, m)
	if IsServer() then
		self:GetParent():RemoveActivityModifier("sword")
		self.modifierd = false
	end
end
function k.prototype.OnAttackRecordDestroy(self, m)
	if IsServer() then
		if RollPercentage(50) then
			self:GetParent():AddActivityModifier("sword")
			self.modifierd = true
		end
	end
end
function k.prototype.GetAttackSound(self)
	if self.modifierd then
		return "Hero_DragonKnight.Attack"
	end
	return "Hero_Muerta.Attack"
end
function k.prototype.EOM_GetModifierProjectileName(self)
	if self.modifierd then
		return "particles/units/heroes/hero_queenofpain/void_attack.vpcf"
	end
	return "models/eom/hero/lion_1/particles/lion_1_base_attack_fx.vpcf"
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
				RemoveOnDeath = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	k
)
g.modifier_5100033 = k
return g