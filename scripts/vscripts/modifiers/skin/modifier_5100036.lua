--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100036"
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
		["35"] = 20,
		["36"] = 20,
		["37"] = 20,
		["38"] = 20,
		["39"] = 20,
		["40"] = 21,
		["41"] = 21,
		["42"] = 21,
		["43"] = 21,
		["44"] = 21,
		["45"] = 22,
		["46"] = 22,
		["47"] = 22,
		["48"] = 22,
		["49"] = 22,
		["50"] = 23,
		["51"] = 23,
		["52"] = 23,
		["53"] = 23,
		["54"] = 23,
		["55"] = 24,
		["56"] = 24,
		["57"] = 24,
		["58"] = 24,
		["59"] = 24,
		["60"] = 25,
		["61"] = 25,
		["62"] = 25,
		["63"] = 25,
		["64"] = 25,
		["65"] = 15,
		["66"] = 12,
		["67"] = 4,
		["68"] = 4,
		["69"] = 4,
		["70"] = 4,
		["71"] = 4,
		["72"] = 4,
		["73"] = 4,
		["74"] = 4,
		["75"] = 12,
		["77"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100036 = c()
local k = g.modifier_5100036
k.name = "modifier_5100036"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.modifierd = false
end
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_ringmaster/ringmaster_base_attack.vpcf",
		"models/eom/hero/ringmaster_1/particles/ringmaster_1_base_attack.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_ringmaster/ringmaster_whip_crack_impact.vpcf",
		"models/eom/hero/ringmaster_1/particles/ringmaster_1_impact.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_ringmaster/ringmaster_ult_trap.vpcf",
		"models/eom/hero/ringmaster_wheel_decoy/particle/ringmaster_1_wheel.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_ringmaster/ringmaster_whip_twirl.vpcf",
		"models/eom/hero/ringmaster_1/particles/ringmaster_1_whip_attack_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_ringmaster/ringmaster_whip.vpcf",
		"models/eom/hero/ringmaster_1/particles/ringmaster_1_whip_attack_throw_fx.vpcf"
	)
	Wearable:registerUnitModelModifier(
		self:GetParent(),
		"models/heroes/ringmaster/ringmaster_wheel_decoy.vmdl",
		"models/eom/hero/ringmaster_wheel_decoy/ringmaster_wheel_decoy.vmdl"
	)
	Wearable:registerSoundModifier(self:GetParent(), "Hero_Ringmaster.Whip.Channel", "Hero_Puck.Phase_Shift")
	Wearable:registerSoundModifier(self:GetParent(), "Hero_Ringmaster.Whip.Cast", "Hero_Enchantress.Sproink")
	Wearable:registerSoundModifier(self:GetParent(), "Hero_Ringmaster.Whip.Target", "Hero_Dark_Seer.NormalPunch.Lv1")
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
g.modifier_5100036 = k
return g