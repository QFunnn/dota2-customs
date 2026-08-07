--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/winter_wyvern"
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
		["17"] = 6,
		["18"] = 7,
		["19"] = 6,
		["20"] = 7,
		["21"] = 8,
		["22"] = 9,
		["23"] = 8,
		["24"] = 7,
		["25"] = 6,
		["26"] = 7,
		["28"] = 7,
		["29"] = 13,
		["30"] = 21,
		["31"] = 13,
		["32"] = 21,
		["33"] = 24,
		["34"] = 24,
		["35"] = 27,
		["36"] = 28,
		["37"] = 27,
		["38"] = 33,
		["39"] = 34,
		["42"] = 37,
		["43"] = 38,
		["44"] = 39,
		["45"] = 40,
		["46"] = 40,
		["47"] = 40,
		["48"] = 40,
		["49"] = 40,
		["50"] = 40,
		["52"] = 33,
		["53"] = 44,
		["54"] = 45,
		["55"] = 44,
		["56"] = 48,
		["57"] = 49,
		["58"] = 48,
		["59"] = 21,
		["60"] = 13,
		["61"] = 13,
		["62"] = 13,
		["63"] = 13,
		["64"] = 13,
		["65"] = 13,
		["66"] = 13,
		["67"] = 13,
		["68"] = 21,
		["70"] = 21,
		["71"] = 53,
		["72"] = 61,
		["73"] = 53,
		["74"] = 61,
		["75"] = 71,
		["76"] = 72,
		["77"] = 73,
		["78"] = 74,
		["79"] = 75,
		["80"] = 76,
		["81"] = 77,
		["82"] = 78,
		["83"] = 71,
		["84"] = 81,
		["85"] = 82,
		["88"] = 85,
		["89"] = 81,
		["90"] = 88,
		["91"] = 89,
		["92"] = 90,
		["93"] = 90,
		["94"] = 90,
		["95"] = 89,
		["96"] = 91,
		["97"] = 91,
		["98"] = 91,
		["99"] = 89,
		["100"] = 92,
		["101"] = 92,
		["102"] = 92,
		["103"] = 89,
		["104"] = 89,
		["105"] = 88,
		["106"] = 96,
		["107"] = 97,
		["110"] = 100,
		["111"] = 101,
		["113"] = 96,
		["114"] = 105,
		["115"] = 106,
		["118"] = 107,
		["119"] = 105,
		["120"] = 110,
		["121"] = 111,
		["122"] = 112,
		["123"] = 113,
		["124"] = 114,
		["125"] = 115,
		["126"] = 116,
		["127"] = 117,
		["128"] = 118,
		["129"] = 119,
		["130"] = 119,
		["131"] = 119,
		["132"] = 119,
		["133"] = 119,
		["134"] = 119,
		["135"] = 119,
		["138"] = 110,
		["139"] = 124,
		["140"] = 125,
		["143"] = 128,
		["144"] = 129,
		["145"] = 130,
		["147"] = 131,
		["148"] = 131,
		["149"] = 132,
		["150"] = 131,
		["153"] = 134,
		["156"] = 124,
		["157"] = 139,
		["158"] = 140,
		["161"] = 143,
		["164"] = 146,
		["165"] = 147,
		["166"] = 148,
		["167"] = 149,
		["168"] = 150,
		["169"] = 151,
		["170"] = 152,
		["171"] = 152,
		["172"] = 152,
		["173"] = 152,
		["174"] = 152,
		["175"] = 152,
		["178"] = 139,
		["179"] = 157,
		["180"] = 158,
		["181"] = 157,
		["182"] = 161,
		["183"] = 162,
		["184"] = 161,
		["185"] = 61,
		["186"] = 53,
		["187"] = 53,
		["188"] = 53,
		["189"] = 53,
		["190"] = 53,
		["191"] = 53,
		["192"] = 53,
		["193"] = 53,
		["194"] = 61,
		["196"] = 61,
		["197"] = 168,
		["198"] = 169,
		["199"] = 168,
		["200"] = 169,
		["202"] = 169,
		["203"] = 170,
		["204"] = 168,
		["205"] = 172,
		["206"] = 173,
		["207"] = 174,
		["208"] = 176,
		["209"] = 177,
		["210"] = 179,
		["211"] = 172,
		["212"] = 169,
		["213"] = 168,
		["214"] = 169,
		["216"] = 169,
		["218"] = 184,
		["219"] = 193,
		["220"] = 184,
		["221"] = 193,
		["222"] = 202,
		["223"] = 203,
		["224"] = 204,
		["225"] = 205,
		["226"] = 206,
		["227"] = 207,
		["228"] = 208,
		["229"] = 202,
		["230"] = 211,
		["231"] = 212,
		["232"] = 211,
		["233"] = 217,
		["234"] = 218,
		["235"] = 219,
		["236"] = 219,
		["237"] = 218,
		["238"] = 217,
		["239"] = 223,
		["240"] = 224,
		["243"] = 227,
		["244"] = 228,
		["245"] = 223,
		["246"] = 231,
		["247"] = 232,
		["248"] = 231,
		["249"] = 235,
		["250"] = 236,
		["251"] = 235,
		["252"] = 239,
		["253"] = 240,
		["254"] = 241,
		["255"] = 242,
		["256"] = 242,
		["257"] = 242,
		["258"] = 242,
		["259"] = 242,
		["260"] = 242,
		["261"] = 239,
		["262"] = 245,
		["263"] = 246,
		["266"] = 249,
		["267"] = 250,
		["269"] = 245,
		["270"] = 254,
		["271"] = 255,
		["274"] = 258,
		["275"] = 259,
		["276"] = 260,
		["277"] = 261,
		["278"] = 262,
		["279"] = 263,
		["280"] = 264,
		["281"] = 265,
		["282"] = 265,
		["283"] = 265,
		["284"] = 265,
		["285"] = 265,
		["286"] = 265,
		["287"] = 265,
		["288"] = 266,
		["289"] = 267,
		["290"] = 268,
		["291"] = 268,
		["292"] = 268,
		["293"] = 268,
		["294"] = 268,
		["295"] = 268,
		["296"] = 268,
		["297"] = 268,
		["298"] = 268,
		["299"] = 269,
		["300"] = 269,
		["301"] = 269,
		["302"] = 269,
		["303"] = 269,
		["304"] = 269,
		["305"] = 269,
		["306"] = 269,
		["307"] = 269,
		["308"] = 270,
		["309"] = 271,
		["310"] = 272,
		["315"] = 254,
		["316"] = 193,
		["317"] = 184,
		["318"] = 184,
		["319"] = 184,
		["320"] = 184,
		["321"] = 184,
		["322"] = 184,
		["323"] = 184,
		["324"] = 184,
		["325"] = 193,
		["327"] = 193,
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
g.winter_wyvern_talent = c()
local q = g.winter_wyvern_talent
q.name = "winter_wyvern_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_winter_wyvern_talent"
end
q = e({ j(nil) }, q)
g.winter_wyvern_talent = q
g.modifier_winter_wyvern_talent = c()
local r = g.modifier_winter_wyvern_talent
r.name = "modifier_winter_wyvern_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self) end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function r.prototype.OnBattleStart(self, s)
	if not IsServer() then
		return
	end
	local t = self:GetParent()
	local u = t:GetEnemy()
	if IsInjurable(u, t) then
		u:AddNewModifier(t, self:GetAbility(), "modifier_winter_wyvern_talent_debuff", {})
	end
end
function r.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function r.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_winter_wyvern/wyvern_arctic_burn_buff.vpcf"
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
g.modifier_winter_wyvern_talent = r
g.modifier_winter_wyvern_talent_debuff = c()
local v = g.modifier_winter_wyvern_talent_debuff
v.name = "modifier_winter_wyvern_talent_debuff"
d(v, l)
function v.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
	self.ice_factor = self:GetAbilitySpecialValueFor("ice_factor")
		+ self:GetAbilityTalentValue("winter_wyvern_talent_2", "bonus_ice_factor")
	self.hp_loss_pct = self:GetAbilityTalentValue("winter_wyvern_talent_4", "hp_loss_pct")
	self.heal_pct = self:GetAbilityTalentValue("winter_wyvern_talent_5", "heal_pct")
	self.bonus_burn_threshold = self:GetAbilityTalentValue("winter_wyvern_talent_6", "bonus_burn_threshold")
	self.bonus_burn_count = self:GetAbilityTalentValue("winter_wyvern_talent_6", "bonus_burn_count")
end
function v.prototype.OnCreated(self, s)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(self.interval)
end
function v.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function v.prototype.OnBattleEnd(self, s)
	if not IsServer() then
		return
	end
	if IsValid(self) then
		self:Destroy()
	end
end
function v.prototype.OnIntervalThink(self)
	if self:GetCaster():PassivesDisabled() then
		return
	end
	self:burn()
end
function v.prototype.burn(self)
	local w = self:GetCaster()
	local t = self:GetParent()
	local x = self:GetAbility()
	if IsValid(x) and IsInjurable(w, t) then
		local y = self.base_damage + GetIce(t) * self.ice_factor * 0.01
		w:DealDamage(t, x, y, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
		if IsInjurable(t) and self.hp_loss_pct > 0 then
			local z = t:GetHealth() * self.hp_loss_pct * 0.01
			w:DealDamage(t, x, z, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, DamageFlags.DAMAGE_FLAG_HPLOSS)
		end
	end
end
function v.prototype.OnIceGained(self, s)
	if not IsServer() then
		return
	end
	if self.bonus_burn_threshold > 0 then
		self.ice_count = (self.ice_count or 0) + s.iStackCount
		while self.ice_count >= self.bonus_burn_threshold do
			do
				local A = 0
				while A < self.bonus_burn_count do
					self:burn()
					A = A + 1
				end
			end
			self.ice_count = self.ice_count - self.bonus_burn_threshold
		end
	end
end
function v.prototype.OnCustomTakeDamage(self, B)
	if not IsServer() then
		return
	end
	if self.heal_pct <= 0 then
		return
	end
	local w = self:GetCaster()
	local x = self:GetAbility()
	local C = B.ability
	local y = B.damage
	if IsValid(C) and IsValid(x) and x == C then
		if y > 0 then
			Heal(w, y * self.heal_pct * 0.01, x:GetAbilityName(), "Ability")
		end
	end
end
function v.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function v.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_winter_wyvern/wyvern_arctic_burn_slow.vpcf"
end
v = e(
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
	v
)
g.modifier_winter_wyvern_talent_debuff = v
g.winter_wyvern_ult = c()
local D = g.winter_wyvern_ult
D.name = "winter_wyvern_ult"
d(D, o)
function D.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.wisps = {}
end
function D.prototype.OnSpellStart(self)
	local w = self:GetCaster()
	local E = self:GetSpecialValueFor("duration")
	w:StartGesture(ACT_DOTA_CAST_ABILITY_3)
	w:EmitSound("Hero_Winter_Wyvern.ColdEmbrace.Cast")
	w:AddNewModifier(w, self, "modifier_winter_wyvern_ult", { duration = E })
end
D = e({ p(nil) }, D)
g.winter_wyvern_ult = D
g.modifier_winter_wyvern_ult = c()
local F = g.modifier_winter_wyvern_ult
F.name = "modifier_winter_wyvern_ult"
d(F, l)
function F.prototype.GetAbilitySpecialValue(self)
	self.base_heal = self:GetAbilitySpecialValueFor("base_heal")
	self.heal_pct = self:GetAbilitySpecialValueFor("heal_pct")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.heal_factor = self:GetAbilitySpecialValueFor("heal_factor")
	self.ice_factor = self:GetAbilityTalentValue("winter_wyvern_talent_1", "ice_factor")
	self.damage_reduce = self:GetAbilityTalentValue("winter_wyvern_talent_3", "damage_reduce")
end
function F.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE] = -self.damage_reduce }
end
function F.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_HEAL] = { self:GetParent(), self:GetParent() } }
end
function F.prototype.OnCreated(self, s)
	if not IsServer() then
		return
	end
	self:GetParent():EmitSound("Hero_Winter_Wyvern.ColdEmbrace")
	self:StartIntervalThink(self.interval)
end
function F.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_winter_wyvern/wyvern_cold_embrace_buff.vpcf"
end
function F.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function F.prototype.OnIntervalThink(self)
	local t = self:GetParent()
	local x = self:GetAbility()
	Heal(t, self.base_heal + (t:GetMaxHealth() - t:GetHealth()) * self.heal_pct * 0.01, x:GetAbilityName(), "Ability")
end
function F.prototype.OnHeal(self, s)
	if not IsServer() then
		return
	end
	if s.origin == "winter_wyvern_ult" then
		self.heal_amount = (self.heal_amount or 0) + (s.flHealAmount or 0)
	end
end
function F.prototype.OnRemoved(self, G)
	if not IsServer() then
		return
	end
	if (self.heal_amount or 0) > 0 then
		local t = self:GetParent()
		local u = t:GetEnemy()
		local x = self:GetAbility()
		if IsInjurable(u) then
			local H = self.heal_amount * self.heal_factor * 0.01
			if H > 0 then
				AddIce(t, u, H, x:GetAbilityName(), "Ability")
				if IsInjurable(u) and self.ice_factor > 0 then
					local I = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_winter_wyvern/wyvern_splinter_blast_explosion.vpcf",
						PATTACH_ABSORIGIN_FOLLOW,
						u
					)
					ParticleManager:SetParticleControlEnt(
						I,
						1,
						u,
						PATTACH_POINT_FOLLOW,
						"attach_hitloc",
						Vector(0, 0, 0),
						true
					)
					ParticleManager:SetParticleControlEnt(
						I,
						3,
						u,
						PATTACH_POINT_FOLLOW,
						"attach_hitloc",
						Vector(0, 0, 0),
						true
					)
					ParticleManager:ReleaseParticleIndex(I)
					u:EmitSound("Hero_Winter_Wyvern.SplinterBlast.Splinter")
					t:DealDamage(u, x, H * self.ice_factor * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
				end
			end
		end
	end
end
F = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	F
)
g.modifier_winter_wyvern_ult = F
return g