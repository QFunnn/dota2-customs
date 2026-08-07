--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/modifiers/utils/modifier_fury_per.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__ClassExtends
local f = c.__TS__Decorate
local g = c.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 11,
		["13"] = 3,
		["14"] = 11,
		["16"] = 11,
		["17"] = 12,
		["18"] = 3,
		["19"] = 14,
		["20"] = 15,
		["21"] = 16,
		["22"] = 17,
		["23"] = 18,
		["24"] = 19,
		["25"] = 20,
		["27"] = 14,
		["28"] = 23,
		["29"] = 24,
		["30"] = 25,
		["31"] = 26,
		["32"] = 27,
		["33"] = 28,
		["34"] = 29,
		["36"] = 23,
		["37"] = 32,
		["38"] = 33,
		["39"] = 34,
		["40"] = 34,
		["41"] = 34,
		["42"] = 34,
		["43"] = 34,
		["44"] = 35,
		["45"] = 35,
		["46"] = 35,
		["47"] = 35,
		["48"] = 35,
		["49"] = 35,
		["50"] = 35,
		["51"] = 35,
		["53"] = 32,
		["54"] = 38,
		["55"] = 39,
		["56"] = 40,
		["57"] = 41,
		["58"] = 42,
		["60"] = 38,
		["61"] = 46,
		["62"] = 47,
		["63"] = 48,
		["64"] = 48,
		["65"] = 47,
		["66"] = 46,
		["67"] = 51,
		["68"] = 52,
		["69"] = 53,
		["71"] = 51,
		["72"] = 56,
		["73"] = 57,
		["74"] = 58,
		["75"] = 60,
		["76"] = 61,
		["77"] = 62,
		["78"] = 62,
		["79"] = 62,
		["80"] = 62,
		["81"] = 63,
		["82"] = 64,
		["83"] = 65,
		["84"] = 65,
		["85"] = 65,
		["86"] = 65,
		["87"] = 66,
		["88"] = 68,
		["91"] = 56,
		["92"] = 72,
		["93"] = 73,
		["94"] = 72,
		["95"] = 85,
		["96"] = 86,
		["97"] = 85,
		["98"] = 88,
		["99"] = 89,
		["100"] = 88,
		["101"] = 92,
		["102"] = 93,
		["103"] = 94,
		["104"] = 92,
		["105"] = 97,
		["106"] = 98,
		["107"] = 99,
		["108"] = 97,
		["109"] = 11,
		["110"] = 3,
		["111"] = 3,
		["112"] = 3,
		["113"] = 3,
		["114"] = 3,
		["115"] = 3,
		["116"] = 3,
		["117"] = 3,
		["118"] = 11,
		["120"] = 11,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
h.modifier_fury_custom = d()
local l = h.modifier_fury_custom
l.name = "modifier_fury_custom"
e(l, j)
function l.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.permanent = 0
end
function l.prototype.OnCreated(self, m)
	if IsServer() then
		local n = self:GetParent()
		self.permanent = GetModifierProperty(n, EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_PERMANENT)
		self:SetStackCount(m.iStackCount + self.permanent)
		self:StartIntervalThink(FURY_ATTENUATION.Interval)
		self:addParticle()
	end
end
function l.prototype.OnRefresh(self, m)
	if IsServer() then
		local n = self:GetParent()
		local o = GetModifierProperty(n, EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_PERMANENT)
		self:SetStackCount(self:GetStackCount() - self.permanent + m.iStackCount + o)
		self.permanent = o
		self:addParticle()
	end
end
function l.prototype.addParticle(self)
	if self:GetStackCount() > 0 and self.particle == nil then
		self.particle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_huskar/huskar_burning_spear_debuff.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		self:AddParticle(self.particle, false, false, -1, false, false)
	end
end
function l.prototype.removeParticle(self)
	if self.particle then
		ParticleManager:DestroyParticle(self.particle, false)
		ParticleManager:ReleaseParticleIndex(self.particle)
		self.particle = nil
	end
end
function l.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function l.prototype.OnBattleEnd(self, m)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
function l.prototype.OnIntervalThink(self)
	local n = self:GetParent()
	local p = self:GetCaster()
	local q = self:GetStackCount() - GetModifierProperty(n, EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_PERMANENT)
	local r = math.ceil(q * FURY_ATTENUATION.Percentage) + FURY_ATTENUATION.Const
	r = math.max(
		0,
		math.ceil(
			r * (
					1
					+ GetModifierProperty(n, EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_ATTENUATION_PERCENTAGE)
						* 0.01
				)
		)
	)
	if r > 0 then
		FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_FURY_LOSS, { iCount = r }, p, n)
		self:SetStackCount(
			math.max(
				GetModifierProperty(n, EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_PERMANENT),
				self:GetStackCount() - r
			)
		)
		if self:GetStackCount() <= 0 then
			self:removeParticle()
		end
	end
end
function l.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
	}
end
function l.prototype.EOM_GetModifierManaRegenBonus(self)
	return self:GetManaRegen()
end
function l.prototype.EOM_GetModifierAttackSpeedBonus(self)
	return self:GetAttackspeed()
end
function l.prototype.GetManaRegen(self)
	local s = self:GetStackCount()
	return s / (s + FURY_DAMAGE_REDUCTION) * 10
end
function l.prototype.GetAttackspeed(self)
	local s = self:GetStackCount()
	return s / (s + FURY_DAMAGE_REDUCTION) * 100
end
l = f(
	{
		k(
			nil,
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
	l
)
h.modifier_fury_custom = l
return h