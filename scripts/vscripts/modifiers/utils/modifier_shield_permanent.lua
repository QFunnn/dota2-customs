--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_shield_permanent"
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
		["12"] = 11,
		["13"] = 3,
		["14"] = 11,
		["15"] = 13,
		["16"] = 14,
		["17"] = 13,
		["18"] = 16,
		["19"] = 17,
		["20"] = 18,
		["22"] = 16,
		["23"] = 21,
		["24"] = 22,
		["25"] = 22,
		["26"] = 22,
		["27"] = 22,
		["28"] = 23,
		["29"] = 24,
		["30"] = 25,
		["31"] = 25,
		["32"] = 25,
		["33"] = 25,
		["34"] = 25,
		["35"] = 26,
		["36"] = 26,
		["37"] = 26,
		["38"] = 26,
		["39"] = 26,
		["40"] = 26,
		["41"] = 26,
		["42"] = 26,
		["45"] = 29,
		["46"] = 30,
		["47"] = 31,
		["50"] = 21,
		["51"] = 35,
		["52"] = 36,
		["53"] = 35,
		["54"] = 40,
		["55"] = 41,
		["56"] = 40,
		["57"] = 11,
		["58"] = 3,
		["59"] = 3,
		["60"] = 3,
		["61"] = 3,
		["62"] = 3,
		["63"] = 3,
		["64"] = 3,
		["65"] = 3,
		["66"] = 11,
		["68"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_shield_permanent = c()
local k = g.modifier_shield_permanent
k.name = "modifier_shield_permanent"
d(k, i)
function k.prototype.GetTexture(self)
	return "shield_permanent"
end
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:StartIntervalThink(0)
	end
end
function k.prototype.OnIntervalThink(self)
	self:SetStackCount(
		GetModifierProperty(self:GetParent(), EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_PERMANENT)
	)
	if self:GetStackCount() > 0 then
		if self.particleID == nil then
			self.particleID = ParticleManager:CreateParticle(
				"particles/sect/sect_shield_base.vpcf",
				PATTACH_ABSORIGIN,
				self:GetParent()
			)
			self:AddParticle(self.particleID, false, false, -1, false, false)
		end
	else
		if self.particleID then
			ParticleManager:DestroyParticle(self.particleID, false)
			self.particleID = nil
		end
	end
end
function k.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ADJUST_DAMAGE }
end
function k.prototype.EOM_GetModifierAdjustDamage(self)
	return self:GetStackCount()
end
k = e(
	{
		j(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = true,
				IsPurgeException = true,
				RemoveOnDeath = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	k
)
g.modifier_shield_permanent = k
return g