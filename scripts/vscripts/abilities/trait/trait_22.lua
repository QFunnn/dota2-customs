--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_22"
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
		["13"] = 2,
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 12,
		["27"] = 19,
		["28"] = 12,
		["29"] = 19,
		["30"] = 20,
		["31"] = 21,
		["32"] = 20,
		["33"] = 25,
		["34"] = 26,
		["35"] = 27,
		["36"] = 27,
		["37"] = 28,
		["38"] = 29,
		["39"] = 31,
		["40"] = 31,
		["41"] = 31,
		["42"] = 31,
		["43"] = 31,
		["44"] = 31,
		["46"] = 25,
		["47"] = 19,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 12,
		["54"] = 12,
		["55"] = 19,
		["57"] = 19,
		["58"] = 36,
		["59"] = 44,
		["60"] = 36,
		["61"] = 44,
		["62"] = 48,
		["63"] = 49,
		["64"] = 50,
		["65"] = 51,
		["66"] = 48,
		["67"] = 53,
		["68"] = 54,
		["69"] = 55,
		["71"] = 53,
		["72"] = 58,
		["73"] = 59,
		["74"] = 60,
		["75"] = 61,
		["77"] = 58,
		["78"] = 64,
		["79"] = 65,
		["80"] = 64,
		["81"] = 69,
		["82"] = 70,
		["83"] = 69,
		["84"] = 72,
		["85"] = 73,
		["86"] = 74,
		["87"] = 74,
		["88"] = 73,
		["89"] = 72,
		["90"] = 77,
		["91"] = 78,
		["92"] = 77,
		["93"] = 44,
		["94"] = 36,
		["95"] = 36,
		["96"] = 36,
		["97"] = 36,
		["98"] = 36,
		["99"] = 36,
		["100"] = 36,
		["101"] = 36,
		["102"] = 44,
		["104"] = 44,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_22 = c()
local n = g.trait_22
n.name = "trait_22"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_22"
end
n = e({ j(nil) }, n)
g.trait_22 = n
g.modifier_trait_22 = c()
local o = g.modifier_trait_22
o.name = "modifier_trait_22"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function o.prototype.OnBattleStart(self, p)
	local q = self:GetParent():GetPlayerOwnerID()
	local r = PlayerData:getHero(q)
	local s = r and r.hero
	local t = s and s:GetEnemy()
	if IsInjurable(s, t) then
		t:AddNewModifier(s, self:GetAbility(), "modifier_trait_22_buff", {})
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_22 = o
g.modifier_trait_22_buff = c()
local u = g.modifier_trait_22_buff
u.name = "modifier_trait_22_buff"
d(u, l)
function u.prototype.GetAbilitySpecialValue(self)
	self.reduce = self:GetAbilitySpecialValueFor("reduce")
	self.add = self:GetAbilitySpecialValueFor("add")
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function u.prototype.OnCreated(self, p)
	if IsServer() then
		self:StartIntervalThink(1)
	end
end
function u.prototype.OnIntervalThink(self)
	self:IncrementStackCount()
	if self:GetStackCount() >= self.duration then
		self:StartIntervalThink(-1)
	end
end
function u.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function u.prototype.EOM_GetModifierOutgoingDamagePercentage(self, v)
	return self:GetStackCount() * self.add - self.reduce
end
function u.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function u.prototype.OnBattleEnd(self, p)
	self:StartIntervalThink(-1)
end
u = e(
	{
		m(
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
	u
)
g.modifier_trait_22_buff = u
return g