--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_187"
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
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 6,
		["20"] = 6,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 9,
		["27"] = 10,
		["28"] = 9,
		["29"] = 10,
		["30"] = 11,
		["31"] = 12,
		["32"] = 13,
		["33"] = 13,
		["34"] = 12,
		["35"] = 11,
		["36"] = 16,
		["37"] = 17,
		["38"] = 18,
		["39"] = 18,
		["40"] = 18,
		["41"] = 18,
		["42"] = 18,
		["43"] = 18,
		["44"] = 16,
		["45"] = 10,
		["46"] = 9,
		["47"] = 9,
		["48"] = 9,
		["49"] = 9,
		["50"] = 9,
		["51"] = 9,
		["52"] = 9,
		["53"] = 10,
		["55"] = 10,
		["56"] = 21,
		["57"] = 29,
		["58"] = 21,
		["59"] = 29,
		["60"] = 32,
		["61"] = 33,
		["62"] = 34,
		["63"] = 34,
		["64"] = 33,
		["65"] = 32,
		["66"] = 37,
		["67"] = 38,
		["68"] = 39,
		["69"] = 37,
		["70"] = 41,
		["71"] = 42,
		["72"] = 43,
		["73"] = 43,
		["74"] = 43,
		["75"] = 44,
		["78"] = 47,
		["79"] = 48,
		["80"] = 49,
		["82"] = 43,
		["83"] = 43,
		["85"] = 41,
		["86"] = 54,
		["87"] = 55,
		["90"] = 59,
		["91"] = 60,
		["94"] = 64,
		["95"] = 65,
		["96"] = 66,
		["99"] = 70,
		["100"] = 70,
		["101"] = 70,
		["102"] = 70,
		["103"] = 70,
		["104"] = 54,
		["105"] = 29,
		["106"] = 21,
		["107"] = 21,
		["108"] = 21,
		["109"] = 21,
		["110"] = 21,
		["111"] = 21,
		["112"] = 21,
		["113"] = 21,
		["114"] = 29,
		["116"] = 29,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_187 = c()
local n = g.trait_187
n.name = "trait_187"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_187"
end
n = e({ j(nil) }, n)
g.trait_187 = n
g.modifier_trait_187 = c()
local o = g.modifier_trait_187
o.name = "modifier_trait_187"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_187_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_187_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_187 = o
g.modifier_trait_187_buff = c()
local q = g.modifier_trait_187_buff
q.name = "modifier_trait_187_buff"
d(q, l)
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function q.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.damagePct = self:GetAbilitySpecialValueFor("damage_bonus_pct")
end
function q.prototype.OnCreated(self)
	if IsServer() then
		self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL_CALCULATED, function(r, p, s, t)
			if not p.is_crit then
				return
			end
			if r:GetParent() == s and self:PRD(self.chance, "trait_187") then
				p.damage = p.damage * (1 + self.damagePct * 0.01)
				p.trait_187_proc = true
			end
		end)
	end
end
function q.prototype.OnCustomTakeDamage(self, p)
	if not p.trait_187_proc or p.attacker ~= self:GetParent() then
		return
	end
	local u = math.floor(p.damage - p.crit_damage)
	if u <= 0 then
		return
	end
	local v = self:GetAbility()
	local w = PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
	if not IsValid(v) or not w then
		return
	end
	w:modifyArtifactExtraData(v:entindex(), "trait_187_extra_damage", u)
end
q = e(
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
	q
)
g.modifier_trait_187_buff = q
return g