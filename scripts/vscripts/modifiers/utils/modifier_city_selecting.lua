--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_city_selecting"
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
		["11"] = 3,
		["12"] = 13,
		["13"] = 3,
		["14"] = 13,
		["15"] = 15,
		["16"] = 16,
		["17"] = 17,
		["18"] = 18,
		["19"] = 19,
		["20"] = 20,
		["21"] = 21,
		["22"] = 21,
		["23"] = 21,
		["24"] = 21,
		["25"] = 21,
		["26"] = 21,
		["27"] = 21,
		["28"] = 21,
		["29"] = 21,
		["30"] = 22,
		["31"] = 22,
		["32"] = 22,
		["33"] = 22,
		["34"] = 22,
		["35"] = 22,
		["36"] = 22,
		["37"] = 22,
		["38"] = 22,
		["39"] = 23,
		["40"] = 23,
		["41"] = 23,
		["42"] = 23,
		["43"] = 23,
		["44"] = 23,
		["45"] = 23,
		["46"] = 23,
		["47"] = 27,
		["49"] = 15,
		["50"] = 30,
		["51"] = 31,
		["52"] = 33,
		["54"] = 30,
		["55"] = 36,
		["56"] = 37,
		["57"] = 36,
		["58"] = 42,
		["59"] = 43,
		["60"] = 42,
		["61"] = 47,
		["62"] = 48,
		["63"] = 47,
		["64"] = 13,
		["65"] = 3,
		["66"] = 3,
		["67"] = 3,
		["68"] = 3,
		["69"] = 3,
		["70"] = 3,
		["71"] = 3,
		["72"] = 3,
		["73"] = 3,
		["74"] = 3,
		["75"] = 13,
		["77"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_city_selecting = c()
local k = g.modifier_city_selecting
k.name = "modifier_city_selecting"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		local m = self:GetParent()
		self.modelScale = m:GetModelScale()
		m:SetModelScale(2)
		local n = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_legion_commander/legion_commander_press_owner.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			m
		)
		ParticleManager:SetParticleControlEnt(n, 1, m, PATTACH_POINT_FOLLOW, "attach_hitloc", m:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(n, 2, m, PATTACH_POINT_FOLLOW, "attach_hitloc", m:GetAbsOrigin(), true)
		self:AddParticle(n, false, false, -1, false, false)
		m:EmitSound("Hero_Oracle.FortunesEnd.Attack")
	end
end
function k.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():SetModelScale(self:GetParent():GetDefaultModelScale())
	end
end
function k.prototype.CheckState(self)
	return { [MODIFIER_STATE_FROZEN] = true, [MODIFIER_STATE_STUNNED] = true }
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE }
end
function k.prototype.GetModifierModelScale(self)
	return 1.5
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
				GetStatusEffectName = "particles/status_fx/status_effect_phantom_lancer_illstrong.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_ULTRA,
			}
		),
	},
	k
)
g.modifier_city_selecting = k
return g