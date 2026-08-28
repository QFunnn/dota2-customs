--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/kunkka1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayFilter
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["15"] = 3,
		["16"] = 3,
		["17"] = 3,
		["18"] = 5,
		["19"] = 6,
		["20"] = 5,
		["21"] = 6,
		["22"] = 7,
		["23"] = 8,
		["24"] = 7,
		["25"] = 6,
		["26"] = 5,
		["27"] = 6,
		["29"] = 6,
		["30"] = 12,
		["31"] = 20,
		["32"] = 12,
		["33"] = 20,
		["35"] = 20,
		["36"] = 27,
		["37"] = 12,
		["38"] = 29,
		["39"] = 30,
		["40"] = 31,
		["41"] = 32,
		["42"] = 33,
		["43"] = 34,
		["44"] = 29,
		["45"] = 36,
		["46"] = 37,
		["47"] = 37,
		["48"] = 39,
		["49"] = 39,
		["50"] = 39,
		["51"] = 37,
		["52"] = 40,
		["53"] = 40,
		["54"] = 40,
		["55"] = 37,
		["56"] = 37,
		["57"] = 36,
		["58"] = 43,
		["59"] = 44,
		["62"] = 45,
		["63"] = 46,
		["64"] = 47,
		["65"] = 48,
		["66"] = 49,
		["67"] = 49,
		["68"] = 49,
		["69"] = 49,
		["70"] = 49,
		["71"] = 49,
		["73"] = 43,
		["74"] = 52,
		["75"] = 53,
		["76"] = 52,
		["77"] = 57,
		["78"] = 58,
		["79"] = 57,
		["80"] = 63,
		["81"] = 64,
		["82"] = 65,
		["84"] = 63,
		["85"] = 68,
		["86"] = 69,
		["87"] = 70,
		["89"] = 68,
		["90"] = 73,
		["91"] = 74,
		["92"] = 75,
		["93"] = 76,
		["95"] = 78,
		["98"] = 73,
		["99"] = 82,
		["100"] = 83,
		["101"] = 84,
		["102"] = 82,
		["103"] = 86,
		["104"] = 87,
		["105"] = 88,
		["106"] = 89,
		["109"] = 92,
		["110"] = 92,
		["111"] = 92,
		["112"] = 92,
		["113"] = 92,
		["114"] = 92,
		["115"] = 92,
		["116"] = 93,
		["117"] = 94,
		["118"] = 95,
		["119"] = 96,
		["120"] = 97,
		["122"] = 86,
		["123"] = 100,
		["124"] = 101,
		["125"] = 102,
		["126"] = 103,
		["129"] = 106,
		["130"] = 107,
		["131"] = 108,
		["132"] = 109,
		["133"] = 109,
		["134"] = 109,
		["135"] = 109,
		["136"] = 109,
		["137"] = 109,
		["138"] = 109,
		["139"] = 109,
		["140"] = 109,
		["141"] = 110,
		["142"] = 110,
		["143"] = 110,
		["144"] = 110,
		["145"] = 110,
		["146"] = 110,
		["147"] = 110,
		["148"] = 110,
		["150"] = 112,
		["151"] = 100,
		["152"] = 20,
		["153"] = 12,
		["154"] = 12,
		["155"] = 12,
		["156"] = 12,
		["157"] = 12,
		["158"] = 12,
		["159"] = 12,
		["160"] = 12,
		["161"] = 20,
		["163"] = 20,
		["164"] = 115,
		["165"] = 124,
		["166"] = 115,
		["167"] = 124,
		["168"] = 125,
		["169"] = 126,
		["170"] = 127,
		["171"] = 128,
		["173"] = 125,
		["174"] = 124,
		["175"] = 115,
		["176"] = 115,
		["177"] = 115,
		["178"] = 115,
		["179"] = 115,
		["180"] = 115,
		["181"] = 115,
		["182"] = 115,
		["183"] = 115,
		["184"] = 124,
		["186"] = 124,
		["187"] = 134,
		["188"] = 135,
		["189"] = 134,
		["190"] = 135,
		["191"] = 136,
		["192"] = 137,
		["193"] = 138,
		["194"] = 139,
		["195"] = 140,
		["196"] = 141,
		["197"] = 142,
		["198"] = 143,
		["199"] = 144,
		["200"] = 145,
		["201"] = 146,
		["202"] = 147,
		["203"] = 147,
		["204"] = 147,
		["205"] = 148,
		["206"] = 149,
		["207"] = 150,
		["208"] = 150,
		["209"] = 150,
		["210"] = 150,
		["211"] = 150,
		["212"] = 150,
		["213"] = 150,
		["214"] = 151,
		["215"] = 152,
		["216"] = 153,
		["217"] = 154,
		["219"] = 156,
		["220"] = 157,
		["222"] = 147,
		["223"] = 147,
		["224"] = 160,
		["225"] = 161,
		["226"] = 136,
		["227"] = 163,
		["228"] = 164,
		["229"] = 163,
		["230"] = 135,
		["231"] = 134,
		["232"] = 135,
		["234"] = 135,
		["235"] = 168,
		["236"] = 176,
		["237"] = 168,
		["238"] = 176,
		["240"] = 176,
		["241"] = 178,
		["242"] = 168,
		["243"] = 179,
		["244"] = 180,
		["245"] = 179,
		["246"] = 182,
		["247"] = 183,
		["248"] = 184,
		["249"] = 184,
		["250"] = 183,
		["251"] = 182,
		["252"] = 187,
		["253"] = 188,
		["254"] = 188,
		["255"] = 187,
		["256"] = 190,
		["257"] = 191,
		["258"] = 191,
		["259"] = 191,
		["260"] = 191,
		["261"] = 190,
		["262"] = 176,
		["263"] = 168,
		["264"] = 168,
		["265"] = 168,
		["266"] = 168,
		["267"] = 168,
		["268"] = 168,
		["269"] = 168,
		["270"] = 168,
		["271"] = 176,
		["273"] = 176,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
local o = require("abilities.ability_ai")
local p = o.BaseAbilityAI
local q = o.registerAbilityAI
h.kunkka1_talent = c()
local r = h.kunkka1_talent
r.name = "kunkka1_talent"
d(r, j)
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_kunkka1_talent"
end
r = e({ k(nil) }, r)
h.kunkka1_talent = r
h.modifier_kunkka1_talent = c()
local s = h.modifier_kunkka1_talent
s.name = "modifier_kunkka1_talent"
d(s, m)
function s.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.record = 0
end
function s.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.ice = self:GetAbilitySpecialValueFor("ice")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.ice_count = self:GetAbilitySpecialValueFor("ice_count")
	self.multiple = self:GetAbilitySpecialValueFor("multiple")
end
function s.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { self:GetParent(), -1 },
	}
end
function s.prototype.OnIceGained(self, t)
	if self:GetCaster():PassivesDisabled() then
		return
	end
	self.record = self.record + 1
	if self.record >= self.ice_count then
		self.record = self.record - self.ice_count
		local u = self:GetParent()
		u:AddNewModifier(u, self:GetAbility(), "modifier_kunkka1_talent_buff", {})
	end
end
function s.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROCATTACK_DAMAGE_BONUS }
end
function s.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND, MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function s.prototype.GetActivityTranslationModifiers(self)
	if self:GetStackCount() > 0 then
		return "tidebringer"
	end
end
function s.prototype.GetAttackSound(self)
	if self:GetStackCount() > 0 then
		return "Hero_Kunkka.Tidebringer.Attack"
	end
end
function s.prototype.EOM_GetModifierProcAttackDamageBonus(self)
	if self:GetStackCount() > 0 then
		if self:GetParent():HasModifier("modifier_kunkka1_talent_buff") then
			return self.damage * self.multiple
		else
			return self.damage
		end
	end
end
function s.prototype.OnBattleStart(self, t)
	self.record = 0
	self:StartIntervalThink(self.interval)
end
function s.prototype.OnCustomAttackLanded(self, v)
	local u = self:GetParent()
	local w = v.target
	if not IsInjurable(u, w) or self:GetStackCount() <= 0 then
		return
	end
	AddIce(u, w, self.ice, "kunkka1_talent", "Ability")
	self:DecrementStackCount()
	u:RemoveModifierByName("modifier_kunkka1_talent_buff")
	if self:GetStackCount() <= 0 and self.particleID ~= nil then
		ParticleManager:DestroyParticle(self.particleID, false)
		self.particleID = nil
	end
end
function s.prototype.OnIntervalThink(self)
	local u = self:GetParent()
	local w = u:GetEnemy()
	if not IsInjurable(u, w) then
		return
	end
	self:IncrementStackCount()
	if self.particleID == nil then
		self.particleID = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_kunkka/kunkka_weapon_tidebringer.vpcf",
			PATTACH_ABSORIGIN,
			u
		)
		ParticleManager:SetParticleControlEnt(
			self.particleID,
			2,
			u,
			PATTACH_POINT_FOLLOW,
			"attach_sword",
			u:GetAbsOrigin(),
			false
		)
		self:AddParticle(self.particleID, false, false, -1, false, false)
	end
	u:EmitSound("Hero_Kunkaa.Tidebringer")
end
s = e(
	{
		n(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	s
)
h.modifier_kunkka1_talent = s
h.modifier_kunkka1_talent_buff = c()
local x = h.modifier_kunkka1_talent_buff
x.name = "modifier_kunkka1_talent_buff"
d(x, m)
function x.prototype.OnCreated(self, t)
	if IsServer() then
		local u = self:GetParent()
		u:EmitSound("Hero_Brewmaster.CinderBrew.Target")
	end
end
x = e(
	{
		n(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetEffectName = "particles/units/heroes/hero_brewmaster/brewmaster_drunken_haze_debuff.vpcf",
			}
		),
	},
	x
)
h.modifier_kunkka1_talent_buff = x
h.kunkka1_ult = c()
local y = h.kunkka1_ult
y.name = "kunkka1_ult"
d(y, p)
function y.prototype.OnSpellStart(self)
	local z = self:GetCaster()
	local w = z:GetEnemy()
	local A = self:GetSpecialValueFor("duration")
	local B = self:GetSpecialValueFor("ice")
	local C = self:GetSpecialValueFor("ice_damage")
	local D = (w:GetAbsOrigin() - z:GetAbsOrigin()):Normalized()
	local E = w:GetAbsOrigin() + D * -900 * A
	local F = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_kunkka/kunkka_ghost_ship.vpcf",
		PATTACH_CUSTOMORIGIN,
		z
	)
	ParticleManager:SetParticleControl(F, 0, E)
	ParticleManager:SetParticleControl(F, 1, D * 900)
	GameTimer(A, function()
		ParticleManager:DestroyParticle(F, false)
		if IsInjurable(z, w) then
			AddIce(z, w, B, "kunkka1_ult", "Ability")
			local G = self:GetSpecialValueFor("damage")
			local H = z:FindModifierByName("modifier_kunkka1_ult")
			if IsValid(H) then
				G = G + C * H:getIceCount()
			end
			z:DealDamage(w, self, G, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			z:EmitSound("Ability.Ghostship.crash")
		end
	end)
	z:EmitSound("Ability.Ghostship.bell")
	z:EmitSound("Ability.Ghostship")
end
function y.prototype.GetIntrinsicModifierName(self)
	return "modifier_kunkka1_ult"
end
y = e({ q(nil) }, y)
h.kunkka1_ult = y
h.modifier_kunkka1_ult = c()
local I = h.modifier_kunkka1_ult
I.name = "modifier_kunkka1_ult"
d(I, m)
function I.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.record = {}
end
function I.prototype.GetAbilitySpecialValue(self)
	self.ice_record = self:GetAbilitySpecialValueFor("ice_record")
end
function I.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { self:GetParent(), -1 } }
end
function I.prototype.OnIceGained(self, t)
	local J = self.record
	J[#J + 1] = GameRules:GetGameTime()
end
function I.prototype.getIceCount(self)
	return #f(self.record, function(K, L)
		return GameRules:GetGameTime() - L <= self.ice_record
	end)
end
I = e(
	{
		n(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	I
)
h.modifier_kunkka1_ult = I
return h