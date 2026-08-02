--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/life_stealer"
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
		["14"] = 3,
		["15"] = 3,
		["16"] = 3,
		["17"] = 5,
		["18"] = 6,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 7,
		["24"] = 6,
		["25"] = 5,
		["26"] = 6,
		["28"] = 6,
		["29"] = 12,
		["30"] = 20,
		["31"] = 12,
		["32"] = 20,
		["34"] = 20,
		["35"] = 26,
		["36"] = 12,
		["37"] = 28,
		["38"] = 29,
		["39"] = 30,
		["40"] = 31,
		["41"] = 33,
		["42"] = 28,
		["43"] = 35,
		["44"] = 36,
		["45"] = 35,
		["46"] = 42,
		["47"] = 43,
		["50"] = 44,
		["51"] = 45,
		["53"] = 42,
		["54"] = 49,
		["55"] = 50,
		["56"] = 51,
		["57"] = 52,
		["60"] = 55,
		["61"] = 56,
		["62"] = 56,
		["63"] = 56,
		["64"] = 56,
		["65"] = 56,
		["66"] = 56,
		["67"] = 57,
		["68"] = 58,
		["69"] = 59,
		["70"] = 60,
		["71"] = 61,
		["72"] = 62,
		["73"] = 63,
		["74"] = 64,
		["75"] = 65,
		["78"] = 68,
		["82"] = 49,
		["83"] = 20,
		["84"] = 12,
		["85"] = 12,
		["86"] = 12,
		["87"] = 12,
		["88"] = 12,
		["89"] = 12,
		["90"] = 12,
		["91"] = 12,
		["92"] = 20,
		["94"] = 20,
		["95"] = 99,
		["96"] = 100,
		["97"] = 99,
		["98"] = 100,
		["99"] = 101,
		["100"] = 102,
		["101"] = 103,
		["102"] = 101,
		["103"] = 105,
		["104"] = 106,
		["105"] = 107,
		["106"] = 108,
		["109"] = 111,
		["110"] = 114,
		["111"] = 115,
		["112"] = 115,
		["113"] = 115,
		["114"] = 115,
		["115"] = 115,
		["116"] = 115,
		["117"] = 115,
		["118"] = 115,
		["119"] = 115,
		["120"] = 119,
		["121"] = 120,
		["122"] = 122,
		["123"] = 122,
		["124"] = 122,
		["125"] = 122,
		["126"] = 123,
		["127"] = 123,
		["128"] = 123,
		["129"] = 123,
		["130"] = 124,
		["131"] = 124,
		["132"] = 124,
		["133"] = 124,
		["134"] = 126,
		["135"] = 105,
		["136"] = 100,
		["137"] = 99,
		["138"] = 100,
		["140"] = 100,
		["141"] = 130,
		["142"] = 138,
		["143"] = 130,
		["144"] = 138,
		["145"] = 150,
		["146"] = 152,
		["147"] = 153,
		["148"] = 154,
		["149"] = 156,
		["150"] = 158,
		["151"] = 159,
		["152"] = 161,
		["153"] = 162,
		["154"] = 150,
		["155"] = 164,
		["156"] = 165,
		["157"] = 164,
		["158"] = 169,
		["159"] = 170,
		["160"] = 171,
		["161"] = 171,
		["162"] = 170,
		["163"] = 169,
		["164"] = 174,
		["165"] = 175,
		["166"] = 176,
		["167"] = 177,
		["168"] = 178,
		["171"] = 181,
		["172"] = 181,
		["173"] = 181,
		["174"] = 181,
		["175"] = 181,
		["176"] = 181,
		["177"] = 186,
		["178"] = 186,
		["179"] = 186,
		["180"] = 186,
		["181"] = 186,
		["182"] = 186,
		["183"] = 186,
		["184"] = 186,
		["185"] = 187,
		["187"] = 174,
		["188"] = 190,
		["189"] = 191,
		["190"] = 192,
		["191"] = 193,
		["192"] = 194,
		["193"] = 195,
		["194"] = 196,
		["195"] = 196,
		["196"] = 196,
		["197"] = 196,
		["198"] = 196,
		["199"] = 196,
		["203"] = 190,
		["204"] = 201,
		["205"] = 202,
		["206"] = 203,
		["207"] = 204,
		["208"] = 205,
		["209"] = 206,
		["212"] = 210,
		["213"] = 211,
		["215"] = 213,
		["216"] = 214,
		["217"] = 215,
		["219"] = 218,
		["220"] = 219,
		["221"] = 220,
		["223"] = 223,
		["224"] = 224,
		["225"] = 224,
		["226"] = 224,
		["227"] = 224,
		["228"] = 224,
		["230"] = 228,
		["231"] = 229,
		["232"] = 229,
		["233"] = 229,
		["234"] = 229,
		["235"] = 229,
		["236"] = 229,
		["239"] = 201,
		["240"] = 233,
		["241"] = 234,
		["242"] = 235,
		["244"] = 233,
		["245"] = 138,
		["246"] = 130,
		["247"] = 130,
		["248"] = 130,
		["249"] = 130,
		["250"] = 130,
		["251"] = 130,
		["252"] = 130,
		["253"] = 130,
		["254"] = 138,
		["256"] = 138,
		["257"] = 240,
		["258"] = 241,
		["259"] = 240,
		["260"] = 241,
		["261"] = 242,
		["262"] = 243,
		["263"] = 242,
		["264"] = 241,
		["265"] = 240,
		["266"] = 241,
		["268"] = 241,
		["269"] = 246,
		["270"] = 254,
		["271"] = 246,
		["272"] = 254,
		["273"] = 256,
		["274"] = 257,
		["275"] = 256,
		["276"] = 259,
		["277"] = 260,
		["278"] = 259,
		["279"] = 264,
		["280"] = 265,
		["281"] = 264,
		["282"] = 254,
		["283"] = 246,
		["284"] = 246,
		["285"] = 246,
		["286"] = 246,
		["287"] = 246,
		["288"] = 246,
		["289"] = 246,
		["290"] = 246,
		["291"] = 254,
		["293"] = 254,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = require("abilities.ability_ai")
local o = n.BaseAbilityAI
local p = n.registerAbilityAI
g.life_stealer_talent = c()
local q = g.life_stealer_talent
q.name = "life_stealer_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_life_stealer_talent"
end
q = e({ j(nil) }, q)
g.life_stealer_talent = q
g.modifier_life_stealer_talent = c()
local r = g.modifier_life_stealer_talent
r.name = "modifier_life_stealer_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tl2_counter = 0
end
function r.prototype.GetAbilitySpecialValue(self)
	self.factor = self:GetAbilitySpecialValueFor("factor")
	self.chance = self:GetAbilitySpecialValueFor("chance")
		+ self:GetAbilityTalentValue("life_stealer_talent_6", "bonus_chance")
	self.heal_pct = self:GetAbilitySpecialValueFor("heal_pct")
	self.tl2_count = self:GetAbilityTalentValue("life_stealer_talent_2", "count")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent() } }
end
function r.prototype.OnCustomAttackLanded(self, s)
	if self:GetCaster():PassivesDisabled() then
		return
	end
	if self:PRD(self.chance, "chance") then
		self:talentEffect()
	end
end
function r.prototype.talentEffect(self)
	local t = self:GetParent()
	local u = t:GetEnemy()
	if not IsInjurable(t, u) then
		return
	end
	local v = u:GetMaxHealth() * self.factor * 0.01
	t:DealDamage(u, self:GetAbility(), v, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	Heal(t, v * self.heal_pct * 0.01, "life_stealer_talent", "Ability")
	if self.tl2_count > 0 then
		self.tl2_counter = self.tl2_counter + 1
		if self.tl2_counter >= self.tl2_count then
			self.tl2_counter = 0
			if not IsValid(self.ultAbility) then
				self.ultAbility = t:FindAbilityByName("life_stealer_ult")
				if IsValid(self.ultAbility) then
					self.ultAbility:OnSpellStart()
				end
			else
				self.ultAbility:OnSpellStart()
			end
		end
	end
end
r = e(
	{
		m(
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
	r
)
g.modifier_life_stealer_talent = r
g.life_stealer_ult = c()
local w = g.life_stealer_ult
w.name = "life_stealer_ult"
d(w, o)
function w.prototype.OnSpellStart(self)
	local x = self:GetSpecialValueFor("duration") + self:GetTalentValue("life_stealer_talent_7", "duration")
	self:Rage(x)
end
function w.prototype.Rage(self, x)
	local y = self:GetCaster()
	local z = y:GetEnemy()
	if not IsInjurable(y, z) then
		return
	end
	local A = self:GetSpecialValueFor("debuff_reduce_pct")
	local B = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_life_stealer/life_stealer_infest_cast_mid.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		y
	)
	ParticleManager:SetParticleControlEnt(B, 1, z, PATTACH_POINT_FOLLOW, "attach_hitloc", z:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(B)
	y:EmitSound("Hero_LifeStealer.Infest")
	ReduceIce(y, GetIce(y) * A * 0.01)
	ReducePoison(y, GetPoison(y) * A * 0.01)
	ReduceInjury(y, GetInjury(y) * A * 0.01)
	y:AddNewModifier(y, self, "modifier_life_stealer_ult", { duration = x })
end
w = e({ p(nil) }, w)
g.life_stealer_ult = w
g.modifier_life_stealer_ult = c()
local C = g.modifier_life_stealer_ult
C.name = "modifier_life_stealer_ult"
d(C, l)
function C.prototype.GetAbilitySpecialValue(self)
	self.regen = self:GetAbilitySpecialValueFor("regen")
		+ self:GetAbilityTalentValue("life_stealer_talent_3", "regen_bonus")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.heal_bonus = self:GetAbilitySpecialValueFor("heal_bonus")
	self.tl4_heal_per_second = self:GetAbilityTalentValue("life_stealer_talent_4", "heal_per_second")
	self.tl12_damage_pct = self:GetAbilityTalentValue("life_stealer_talent_12", "damage_pct")
	self.healRecord = 0
	self.s_duration = self:GetAbilityTalentValue("life_stealer_shard", "duration")
	self.s_chance = self:GetAbilityTalentValue("life_stealer_shard", "chance")
end
function C.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_BONUS] = self.heal_bonus }
end
function C.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_HEAL] = { self:GetParent(), -1 } }
end
function C.prototype.OnCreated(self, D)
	if IsServer() then
		local z = self:GetParent():GetEnemy()
		if not IsInjurable(z) then
			self:Destroy()
			return
		end
		local E = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_life_stealer/life_stealer_infested_unit.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			z,
			self:GetParent()
		)
		self:AddParticle(E, false, false, 0, false, false)
		self:StartIntervalThink(self.interval)
	end
end
function C.prototype.OnDestroy(self)
	if IsServer() then
		local F = self:GetParent()
		local z = F:GetEnemy()
		if IsInjurable(F, z) then
			if self.tl12_damage_pct > 0 then
				F:DealDamage(
					z,
					self:GetAbility(),
					self.healRecord * self.tl12_damage_pct * 0.01,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
				)
			end
		end
	end
end
function C.prototype.OnIntervalThink(self)
	if IsServer() then
		local F = self:GetParent()
		local z = F:GetEnemy()
		if not IsInjurable(z, F) then
			self:Destroy()
			return
		end
		if not IsValid(self.talentModifier) then
			self.talentModifier = F:FindModifierByName("modifier_life_stealer_talent")
		end
		local G = self.regen
		if self.tl4_heal_per_second > 0 then
			G = G + F:GetMaxHealth() * self.tl4_heal_per_second * 0.01
		end
		Heal(F, G, "life_stealer_ult", "Ability")
		if IsValid(self.talentModifier) then
			self.talentModifier:talentEffect()
		end
		if self:HasTalent("life_stealer_talent_5") then
			DamageSystem:performAttack(F, z, { ability = self:GetAbility() })
		end
		if self.s_chance > 0 and self:PRD(self.s_chance, "s_chance") then
			AddDisarm(F, z, self:GetAbility(), self.s_duration)
		end
	end
end
function C.prototype.OnHeal(self, D)
	if self.tl12_damage_pct > 0 then
		self.healRecord = self.healRecord + D.flHealAmount
	end
end
C = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	C
)
g.modifier_life_stealer_ult = C
g.life_stealer_talent_1 = c()
local H = g.life_stealer_talent_1
H.name = "life_stealer_talent_1"
d(H, i)
function H.prototype.GetIntrinsicModifierName(self)
	return "modifier_life_stealer_talent_1"
end
H = e({ j(nil) }, H)
g.life_stealer_talent_1 = H
g.modifier_life_stealer_talent_1 = c()
local I = g.modifier_life_stealer_talent_1
I.name = "modifier_life_stealer_talent_1"
d(I, l)
function I.prototype.GetAbilitySpecialValue(self)
	self.attacks_bonus = self:GetAbilitySpecialValueFor("attacks_bonus")
end
function I.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function I.prototype.EOM_GetModifierAttackSpeedBonus(self, D)
	return GetHealBonus(self:GetParent()) * self.attacks_bonus
end
I = e(
	{
		m(
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
g.modifier_life_stealer_talent_1 = I
return g