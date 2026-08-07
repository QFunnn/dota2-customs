--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_injury_custom"
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
		["15"] = 12,
		["16"] = 13,
		["17"] = 14,
		["19"] = 16,
		["20"] = 16,
		["21"] = 16,
		["22"] = 16,
		["23"] = 16,
		["24"] = 17,
		["25"] = 17,
		["26"] = 17,
		["27"] = 17,
		["28"] = 17,
		["29"] = 17,
		["30"] = 17,
		["31"] = 17,
		["33"] = 12,
		["34"] = 20,
		["35"] = 21,
		["36"] = 22,
		["38"] = 20,
		["39"] = 25,
		["40"] = 26,
		["41"] = 27,
		["42"] = 27,
		["43"] = 26,
		["44"] = 25,
		["45"] = 30,
		["46"] = 31,
		["47"] = 30,
		["48"] = 35,
		["49"] = 36,
		["50"] = 35,
		["51"] = 38,
		["52"] = 41,
		["55"] = 44,
		["56"] = 45,
		["57"] = 46,
		["58"] = 46,
		["59"] = 46,
		["60"] = 46,
		["61"] = 47,
		["62"] = 48,
		["63"] = 48,
		["64"] = 48,
		["65"] = 48,
		["66"] = 48,
		["67"] = 48,
		["68"] = 49,
		["69"] = 50,
		["70"] = 51,
		["73"] = 38,
		["74"] = 11,
		["75"] = 3,
		["76"] = 3,
		["77"] = 3,
		["78"] = 3,
		["79"] = 3,
		["80"] = 3,
		["81"] = 3,
		["82"] = 3,
		["83"] = 11,
		["85"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_injury_custom = c()
local k = g.modifier_injury_custom
k.name = "modifier_injury_custom"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:SetStackCount(l.iStackCount)
	else
		local m = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_shadow_demon/shadow_demon_shadow_poison_4stack.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		self:AddParticle(m, false, false, -1, false, false)
	end
end
function k.prototype.OnRefresh(self, l)
	if IsServer() then
		self:IncrementStackCount(l.iStackCount)
	end
end
function k.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ADJUST] = { -1, self:GetParent() } }
end
function k.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ADJUST_DAMAGE }
end
function k.prototype.EOM_GetModifierAdjustDamage(self)
	return -self:GetStackCount()
end
function k.prototype.OnAdjust(self, l)
	if
		l.damage_flags
		and bit.band(l.damage_flags, DamageFlags.DAMAGE_FLAG_KEEP_INJURY_COUNT)
			== DamageFlags.DAMAGE_FLAG_KEEP_INJURY_COUNT
	then
		return
	end
	local n = math.ceil(self:GetStackCount() * INJURY_ATTENUATION.Percentage) + INJURY_ATTENUATION.Const
	local o = 1
		+ GetModifierProperty(
				l.attacker,
				EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_ATTENUATION_PERCENTAGE,
				l
			)
			* 0.01
	n = math.max(0, math.ceil(n * o))
	if n > 0 then
		FireModifierEvent(
			EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_LOSS,
			vlua.tableadd(l, { iCount = n }),
			l.attacker,
			l.target
		)
		self:DecrementStackCount(n)
		if self:GetStackCount() <= 0 then
			self:Destroy()
		end
	end
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = true,
				IsPurgeException = true,
				RemoveOnDeath = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	k
)
g.modifier_injury_custom = k
return g