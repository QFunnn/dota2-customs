--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_hero_level"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__Number
local f = b.__TS__DecorateLegacy
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 3,
		["13"] = 11,
		["14"] = 3,
		["15"] = 11,
		["16"] = 14,
		["17"] = 15,
		["18"] = 16,
		["20"] = 14,
		["21"] = 20,
		["22"] = 21,
		["23"] = 22,
		["25"] = 20,
		["26"] = 25,
		["27"] = 26,
		["28"] = 27,
		["29"] = 27,
		["30"] = 27,
		["31"] = 27,
		["32"] = 28,
		["33"] = 29,
		["34"] = 30,
		["36"] = 31,
		["37"] = 31,
		["38"] = 32,
		["39"] = 31,
		["44"] = 36,
		["45"] = 37,
		["46"] = 25,
		["47"] = 48,
		["48"] = 49,
		["49"] = 48,
		["50"] = 71,
		["51"] = 72,
		["52"] = 71,
		["53"] = 74,
		["54"] = 75,
		["55"] = 75,
		["56"] = 75,
		["58"] = 75,
		["59"] = 74,
		["60"] = 77,
		["61"] = 78,
		["62"] = 78,
		["63"] = 78,
		["65"] = 78,
		["66"] = 77,
		["67"] = 80,
		["68"] = 81,
		["69"] = 81,
		["70"] = 81,
		["72"] = 81,
		["73"] = 80,
		["74"] = 83,
		["75"] = 84,
		["76"] = 84,
		["77"] = 84,
		["79"] = 84,
		["80"] = 83,
		["81"] = 86,
		["82"] = 87,
		["83"] = 87,
		["84"] = 87,
		["86"] = 87,
		["87"] = 86,
		["88"] = 89,
		["89"] = 90,
		["90"] = 90,
		["91"] = 90,
		["93"] = 90,
		["94"] = 89,
		["95"] = 92,
		["96"] = 93,
		["97"] = 93,
		["98"] = 93,
		["100"] = 93,
		["101"] = 92,
		["102"] = 95,
		["103"] = 96,
		["104"] = 96,
		["105"] = 96,
		["107"] = 96,
		["108"] = 95,
		["109"] = 98,
		["110"] = 99,
		["111"] = 99,
		["112"] = 99,
		["114"] = 99,
		["115"] = 98,
		["116"] = 101,
		["117"] = 102,
		["118"] = 102,
		["119"] = 102,
		["121"] = 102,
		["122"] = 101,
		["123"] = 104,
		["124"] = 105,
		["125"] = 105,
		["126"] = 105,
		["128"] = 105,
		["129"] = 104,
		["130"] = 107,
		["131"] = 108,
		["132"] = 108,
		["133"] = 108,
		["135"] = 108,
		["136"] = 107,
		["137"] = 110,
		["138"] = 111,
		["139"] = 111,
		["140"] = 111,
		["142"] = 111,
		["143"] = 110,
		["144"] = 113,
		["145"] = 114,
		["146"] = 114,
		["147"] = 114,
		["149"] = 114,
		["150"] = 113,
		["151"] = 116,
		["152"] = 117,
		["153"] = 117,
		["154"] = 117,
		["156"] = 117,
		["157"] = 116,
		["158"] = 119,
		["159"] = 120,
		["160"] = 120,
		["161"] = 120,
		["163"] = 120,
		["164"] = 119,
		["165"] = 122,
		["166"] = 123,
		["167"] = 123,
		["168"] = 123,
		["170"] = 123,
		["171"] = 122,
		["172"] = 125,
		["173"] = 126,
		["174"] = 126,
		["175"] = 126,
		["177"] = 126,
		["178"] = 125,
		["179"] = 11,
		["180"] = 3,
		["181"] = 3,
		["182"] = 3,
		["183"] = 3,
		["184"] = 3,
		["185"] = 3,
		["186"] = 3,
		["187"] = 3,
		["188"] = 11,
		["190"] = 11,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
h.modifier_hero_level = c()
local l = h.modifier_hero_level
l.name = "modifier_hero_level"
d(l, j)
function l.prototype.OnCreated(self, m)
	if IsServer() then
		self:StartIntervalThink(0.1)
	end
end
function l.prototype.OnRefresh(self, m)
	if IsServer() then
		self:StartIntervalThink(0.1)
	end
end
function l.prototype.OnIntervalThink(self)
	self.levelHealth = 0
	local n = CustomNetTables:GetTableValue("sect_data", "sect_data_" .. tostring(self:GetParent():GetPlayerOwnerID()))
		or {}
	for o in pairs(n) do
		local p = n[o]
		if p.level > 0 then
			do
				local q = 0
				while q < p.level do
					self.levelHealth = self.levelHealth + HEALTH_PER_LEVEL[q + 1]
					q = q + 1
				end
			end
		end
	end
	self:SetStackCount(self.levelHealth)
	self:StartIntervalThink(-1)
end
function l.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BASE }
end
function l.prototype.EOM_GetModifierHealthBase(self)
	return self:GetStackCount()
end
function l.prototype.EOM_GetModifierAttackDamageBase(self)
	local r = self.data.attack_damage
	if r == nil then
		r = 0
	end
	return r
end
function l.prototype.EOM_GetModifierAttackSpeedBase(self)
	local s = self.data.attack_speed
	if s == nil then
		s = 0
	end
	return s
end
function l.prototype.EOM_GetModifierPhysicalCriticalStrikeChance(self)
	local t = self.data.crit
	if t == nil then
		t = 0
	end
	return t
end
function l.prototype.EOM_GetModifierPhysicalCriticalStrikeDamage(self)
	local u = self.data.crit_damage
	if u == nil then
		u = 0
	end
	return u
end
function l.prototype.EOM_GetModifierHeal_Bonus(self)
	local v = self.data.extra_regen
	if v == nil then
		v = 0
	end
	return v
end
function l.prototype.EOM_GetModifierInjuryStackBonus(self)
	local w = self.data.extra_injury
	if w == nil then
		w = 0
	end
	return w
end
function l.prototype.EOM_GetModifierPoisonDamageBonus(self)
	local x = self.data.extra_poison
	if x == nil then
		x = 0
	end
	return x
end
function l.prototype.EOM_GetModifierIceStackBonus(self)
	local y = self.data.extra_ice
	if y == nil then
		y = 0
	end
	return y
end
function l.prototype.EOM_GetModifierShieldStackBonus(self)
	local z = self.data.extra_shield
	if z == nil then
		z = 0
	end
	return z
end
function l.prototype.EOM_GetModifierEvasion_Base(self)
	local A = self.data.evade
	if A == nil then
		A = 0
	end
	return A
end
function l.prototype.EOM_GetModifierIncomingMagicalDamagePercentage(self)
	local B = self.data.magical_resist
	if B == nil then
		B = 0
	end
	return e(-B)
end
function l.prototype.EOM_GetModifierIncomingPhysicalDamagePercentage(self)
	local C = self.data.physical_resist
	if C == nil then
		C = 0
	end
	return e(-C)
end
function l.prototype.EOM_GetModifierOutgoingPhysicalDamagePercentage(self)
	local D = self.data.physical_enhancement
	if D == nil then
		D = 0
	end
	return D
end
function l.prototype.EOM_GetModifierOutgoingMagicalDamagePercentage(self)
	local E = self.data.magical_enhancement
	if E == nil then
		E = 0
	end
	return E
end
function l.prototype.EOM_GetModifierUltiPower(self)
	local F = self.data.ultimate_amplification
	if F == nil then
		F = 0
	end
	return F
end
function l.prototype.EOM_GetModifierWispHealthPercentage(self)
	local G = self.data.wisp_health_pct
	if G == nil then
		G = 0
	end
	return G
end
function l.prototype.EOM_GetModifierHealthBonusPercentage(self)
	local H = self.data.max_hp_pct
	if H == nil then
		H = 0
	end
	return H
end
function l.prototype.EOM_GetModifierManaRegenBonus(self, m)
	local I = self.data.mana_restore
	if I == nil then
		I = 0
	end
	return I
end
l = f(
	{
		k(
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
	l
)
h.modifier_hero_level = l
return h