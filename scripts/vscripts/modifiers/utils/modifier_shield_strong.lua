--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_shield_strong"
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
		["15"] = 14,
		["16"] = 15,
		["17"] = 16,
		["19"] = 18,
		["20"] = 18,
		["21"] = 18,
		["22"] = 18,
		["23"] = 18,
		["24"] = 19,
		["25"] = 19,
		["26"] = 19,
		["27"] = 19,
		["28"] = 19,
		["29"] = 19,
		["30"] = 19,
		["31"] = 19,
		["32"] = 19,
		["33"] = 20,
		["34"] = 20,
		["35"] = 20,
		["36"] = 20,
		["37"] = 20,
		["38"] = 21,
		["39"] = 21,
		["40"] = 21,
		["41"] = 21,
		["42"] = 21,
		["43"] = 21,
		["44"] = 21,
		["45"] = 21,
		["47"] = 14,
		["48"] = 24,
		["49"] = 25,
		["50"] = 26,
		["51"] = 27,
		["52"] = 28,
		["53"] = 29,
		["56"] = 24,
		["57"] = 33,
		["58"] = 34,
		["59"] = 33,
		["60"] = 13,
		["61"] = 4,
		["62"] = 4,
		["63"] = 4,
		["64"] = 4,
		["65"] = 4,
		["66"] = 4,
		["67"] = 4,
		["68"] = 4,
		["69"] = 4,
		["70"] = 13,
		["72"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_shield_strong = c()
local k = g.modifier_shield_strong
k.name = "modifier_shield_strong"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:StartIntervalThink(BUFF_VALUE.StrongShieldReduceTick)
	else
		local m = ParticleManager:CreateParticle(
			"particles/sect/sect_shield_base.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(
			m,
			1,
			self:GetParent(),
			PATTACH_ABSORIGIN_FOLLOW,
			nil,
			self:GetParent():GetAbsOrigin(),
			false
		)
		ParticleManager:SetParticleControl(m, 3, Vector(50, 255, 255))
		self:AddParticle(m, false, false, -1, false, false)
	end
end
function k.prototype.OnIntervalThink(self)
	if IsServer() then
		local n = self:GetParent()
		local o = n:FindModifierByName("modifier_shield_custom")
		if IsValid(o) then
			o:ShieldAttenuation()
		end
	end
end
function k.prototype.ECheckState(self)
	return { [EOMModifierStates.MODIFIER_STATE_STRONG_SHIELD] = true }
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetStatusEffectName = "particles/status_fx/status_effect_keeper_dazzle.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_HIGH,
			}
		),
	},
	k
)
g.modifier_shield_strong = k
return g