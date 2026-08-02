--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_fury_custom"
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
		["18"] = 16,
		["19"] = 17,
		["21"] = 19,
		["22"] = 19,
		["23"] = 19,
		["24"] = 19,
		["25"] = 19,
		["26"] = 20,
		["27"] = 20,
		["28"] = 20,
		["29"] = 20,
		["30"] = 20,
		["31"] = 20,
		["32"] = 20,
		["33"] = 20,
		["35"] = 12,
		["36"] = 23,
		["37"] = 24,
		["38"] = 25,
		["40"] = 23,
		["41"] = 28,
		["42"] = 29,
		["43"] = 30,
		["44"] = 30,
		["45"] = 29,
		["46"] = 28,
		["47"] = 33,
		["48"] = 34,
		["49"] = 35,
		["51"] = 33,
		["52"] = 38,
		["53"] = 39,
		["54"] = 40,
		["55"] = 41,
		["57"] = 44,
		["58"] = 45,
		["59"] = 45,
		["60"] = 45,
		["61"] = 45,
		["62"] = 46,
		["63"] = 47,
		["64"] = 48,
		["65"] = 49,
		["66"] = 50,
		["69"] = 38,
		["70"] = 54,
		["71"] = 55,
		["72"] = 54,
		["73"] = 67,
		["74"] = 68,
		["75"] = 67,
		["76"] = 70,
		["77"] = 71,
		["78"] = 70,
		["79"] = 74,
		["80"] = 75,
		["81"] = 75,
		["82"] = 75,
		["83"] = 75,
		["84"] = 75,
		["85"] = 75,
		["86"] = 75,
		["87"] = 75,
		["88"] = 74,
		["89"] = 78,
		["90"] = 79,
		["91"] = 79,
		["92"] = 79,
		["93"] = 79,
		["94"] = 78,
		["95"] = 11,
		["96"] = 3,
		["97"] = 3,
		["98"] = 3,
		["99"] = 3,
		["100"] = 3,
		["101"] = 3,
		["102"] = 3,
		["103"] = 3,
		["104"] = 11,
		["106"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_fury_custom = c()
local k = g.modifier_fury_custom
k.name = "modifier_fury_custom"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		local m = self:GetParent()
		self:SetStackCount(l.iStackCount)
		self:StartIntervalThink(FURY_ATTENUATION.Interval)
	else
		local n = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_huskar/huskar_burning_spear_debuff.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		self:AddParticle(n, false, false, -1, false, false)
	end
end
function k.prototype.OnRefresh(self, l)
	if IsServer() then
		self:IncrementStackCount(l.iStackCount)
	end
end
function k.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function k.prototype.OnBattleEnd(self, l)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
function k.prototype.OnIntervalThink(self)
	local o = self:GetParent()
	local p = self:GetCaster()
	if IsValid(p) then
	end
	local q = math.ceil(self:GetStackCount() * FURY_ATTENUATION.Percentage) + FURY_ATTENUATION.Const
	q = math.max(
		0,
		math.ceil(
			q * (
					1
					+ GetModifierProperty(o, EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_ATTENUATION_PERCENTAGE)
						* 0.01
				)
		)
	)
	if q > 0 then
		FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_FURY_LOSS, { iCount = q }, p, o)
		self:DecrementStackCount(q)
		if self:GetStackCount() <= 0 then
			self:Destroy()
		end
	end
end
function k.prototype.EDeclareFunctions(self)
	return {}
end
function k.prototype.EOM_GetModifierManaRegenBonus(self)
	return self:GetManaRegen()
end
function k.prototype.EOM_GetModifierAttackSpeedBonus(self)
	return self:GetAttackspeed()
end
function k.prototype.GetManaRegen(self)
	return ICE_FURY_MANA_REGEN(
		nil,
		KeyValues.UnitsKv[self:GetParent():GetUnitName()].ManaRegen,
		self:GetStackCount() + self:GetParent():GetModifierStackCount("modifier_fury_permanent", self:GetParent())
	)
end
function k.prototype.GetAttackspeed(self)
	return ICE_FURY_ATTACKSPEED(nil, self:GetStackCount())
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
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
g.modifier_fury_custom = k
return g