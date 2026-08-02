--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/riki_new"
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
		["24"] = 11,
		["25"] = 12,
		["26"] = 13,
		["27"] = 14,
		["28"] = 15,
		["29"] = 16,
		["30"] = 16,
		["31"] = 16,
		["32"] = 16,
		["33"] = 16,
		["34"] = 16,
		["35"] = 17,
		["36"] = 18,
		["37"] = 18,
		["38"] = 18,
		["39"] = 18,
		["40"] = 18,
		["41"] = 19,
		["43"] = 11,
		["44"] = 6,
		["45"] = 5,
		["46"] = 6,
		["48"] = 6,
		["49"] = 24,
		["50"] = 32,
		["51"] = 24,
		["52"] = 32,
		["54"] = 32,
		["55"] = 38,
		["56"] = 24,
		["57"] = 40,
		["58"] = 41,
		["59"] = 42,
		["60"] = 43,
		["61"] = 44,
		["62"] = 45,
		["63"] = 40,
		["64"] = 47,
		["65"] = 48,
		["66"] = 47,
		["67"] = 52,
		["68"] = 53,
		["69"] = 53,
		["70"] = 53,
		["71"] = 56,
		["72"] = 56,
		["73"] = 56,
		["74"] = 53,
		["75"] = 53,
		["76"] = 52,
		["77"] = 59,
		["78"] = 60,
		["81"] = 61,
		["82"] = 62,
		["83"] = 63,
		["84"] = 64,
		["85"] = 65,
		["86"] = 65,
		["87"] = 65,
		["88"] = 65,
		["89"] = 65,
		["90"] = 65,
		["91"] = 66,
		["92"] = 67,
		["93"] = 67,
		["94"] = 67,
		["95"] = 67,
		["96"] = 67,
		["97"] = 67,
		["98"] = 68,
		["101"] = 59,
		["102"] = 72,
		["103"] = 73,
		["104"] = 74,
		["106"] = 72,
		["107"] = 77,
		["108"] = 78,
		["109"] = 79,
		["110"] = 80,
		["112"] = 77,
		["113"] = 32,
		["114"] = 24,
		["115"] = 24,
		["116"] = 24,
		["117"] = 24,
		["118"] = 24,
		["119"] = 24,
		["120"] = 24,
		["121"] = 24,
		["122"] = 32,
		["124"] = 32,
		["126"] = 86,
		["127"] = 95,
		["128"] = 86,
		["129"] = 95,
		["130"] = 97,
		["131"] = 98,
		["132"] = 97,
		["133"] = 100,
		["134"] = 101,
		["135"] = 102,
		["136"] = 103,
		["137"] = 104,
		["138"] = 105,
		["139"] = 106,
		["140"] = 106,
		["141"] = 106,
		["142"] = 106,
		["143"] = 106,
		["144"] = 107,
		["145"] = 107,
		["146"] = 107,
		["147"] = 107,
		["148"] = 107,
		["149"] = 108,
		["150"] = 108,
		["151"] = 108,
		["152"] = 108,
		["153"] = 108,
		["154"] = 109,
		["155"] = 109,
		["156"] = 109,
		["157"] = 109,
		["158"] = 109,
		["159"] = 109,
		["160"] = 109,
		["161"] = 109,
		["162"] = 110,
		["163"] = 111,
		["164"] = 112,
		["165"] = 112,
		["166"] = 112,
		["167"] = 112,
		["168"] = 112,
		["169"] = 113,
		["170"] = 113,
		["171"] = 113,
		["172"] = 113,
		["173"] = 113,
		["174"] = 113,
		["175"] = 113,
		["176"] = 113,
		["177"] = 114,
		["180"] = 100,
		["181"] = 118,
		["182"] = 119,
		["183"] = 120,
		["184"] = 121,
		["185"] = 122,
		["186"] = 123,
		["187"] = 123,
		["188"] = 123,
		["189"] = 123,
		["190"] = 123,
		["191"] = 124,
		["193"] = 126,
		["194"] = 118,
		["195"] = 95,
		["196"] = 86,
		["197"] = 86,
		["198"] = 86,
		["199"] = 86,
		["200"] = 86,
		["201"] = 86,
		["202"] = 86,
		["203"] = 86,
		["204"] = 86,
		["205"] = 95,
		["207"] = 95,
		["209"] = 132,
		["210"] = 140,
		["211"] = 132,
		["212"] = 140,
		["213"] = 141,
		["214"] = 142,
		["215"] = 143,
		["216"] = 144,
		["218"] = 146,
		["219"] = 147,
		["220"] = 147,
		["221"] = 147,
		["222"] = 147,
		["223"] = 147,
		["224"] = 147,
		["225"] = 147,
		["226"] = 147,
		["228"] = 141,
		["229"] = 150,
		["230"] = 151,
		["231"] = 152,
		["232"] = 153,
		["233"] = 154,
		["236"] = 157,
		["237"] = 158,
		["238"] = 158,
		["239"] = 158,
		["240"] = 158,
		["241"] = 158,
		["242"] = 158,
		["243"] = 158,
		["244"] = 158,
		["246"] = 150,
		["247"] = 162,
		["248"] = 163,
		["249"] = 162,
		["250"] = 140,
		["251"] = 132,
		["252"] = 132,
		["253"] = 132,
		["254"] = 132,
		["255"] = 132,
		["256"] = 132,
		["257"] = 132,
		["258"] = 132,
		["259"] = 140,
		["261"] = 140,
		["262"] = 174,
		["263"] = 175,
		["264"] = 174,
		["265"] = 175,
		["266"] = 176,
		["267"] = 177,
		["268"] = 178,
		["269"] = 179,
		["270"] = 180,
		["271"] = 181,
		["272"] = 182,
		["273"] = 183,
		["275"] = 185,
		["276"] = 186,
		["277"] = 176,
		["278"] = 175,
		["279"] = 174,
		["280"] = 175,
		["282"] = 175,
		["284"] = 191,
		["285"] = 199,
		["286"] = 191,
		["287"] = 199,
		["288"] = 202,
		["289"] = 203,
		["290"] = 202,
		["291"] = 205,
		["292"] = 206,
		["293"] = 205,
		["294"] = 199,
		["295"] = 191,
		["296"] = 191,
		["297"] = 191,
		["298"] = 191,
		["299"] = 191,
		["300"] = 191,
		["301"] = 191,
		["302"] = 191,
		["303"] = 199,
		["305"] = 199,
		["307"] = 212,
		["308"] = 220,
		["309"] = 212,
		["310"] = 220,
		["311"] = 221,
		["312"] = 222,
		["313"] = 223,
		["314"] = 224,
		["315"] = 225,
		["316"] = 225,
		["317"] = 225,
		["318"] = 225,
		["319"] = 225,
		["320"] = 226,
		["321"] = 226,
		["322"] = 226,
		["323"] = 226,
		["324"] = 226,
		["325"] = 227,
		["326"] = 227,
		["327"] = 227,
		["328"] = 227,
		["329"] = 227,
		["330"] = 227,
		["331"] = 227,
		["332"] = 227,
		["334"] = 221,
		["335"] = 220,
		["336"] = 212,
		["337"] = 212,
		["338"] = 212,
		["339"] = 212,
		["340"] = 212,
		["341"] = 212,
		["342"] = 212,
		["343"] = 212,
		["344"] = 220,
		["346"] = 220,
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
g.riki_talent = c()
local q = g.riki_talent
q.name = "riki_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_riki_talent"
end
function q.prototype.Backstab(self)
	local r = self:GetCaster()
	local s = r:GetEnemy()
	if IsInjurable(s) then
		local t = self:GetSpecialValueFor("evade_factor")
		r:DealDamage(s, self, GetEvasion(r) * t, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
		local u =
			ParticleManager:CreateParticle("particles/units/heroes/hero_riki/riki_backstab.vpcf", PATTACH_ABSORIGIN, s)
		ParticleManager:SetParticleControlForward(u, 0, r:GetForwardVector())
		r:EmitSound("Hero_Riki.Backstab")
	end
end
q = e({ j(nil) }, q)
g.riki_talent = q
g.modifier_riki_talent = c()
local v = g.modifier_riki_talent
v.name = "modifier_riki_talent"
d(v, l)
function v.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.record = 0
end
function v.prototype.GetAbilitySpecialValue(self)
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
		- self:GetAbilityTalentValue("riki_talent_4", "bonus_threshold")
	self.bonus_evasion = self:GetAbilityTalentValue("riki_talent_1", "bonus_evasion")
	self.invincible_duration = self:GetAbilityTalentValue("riki_talent_5", "invincible_duration")
	self.interval = self:GetAbilityTalentValue("riki_talent_5", "interval")
	self.bonus_chance = self:GetAbilityTalentValue("riki_talent_6", "bonus_chance")
end
function v.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS] = self.bonus_evasion }
end
function v.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
	}
end
function v.prototype.OnEvasion(self)
	if self:GetCaster():PassivesDisabled() then
		return
	end
	self:IncrementStackCount()
	if self:GetStackCount() >= self.threshold then
		self:SetStackCount(0)
		local w = self:GetParent()
		w:AddNewModifier(w, self:GetAbility(), "modifier_riki_talent_delay", { duration = 1 })
		if self.invincible_duration > 0 and GameRules:GetGameTime() > self.record + self.interval then
			w:AddNewModifier(
				w,
				self:GetAbility(),
				"modifier_riki_talent_invincible",
				{ duration = self.invincible_duration }
			)
			self.record = GameRules:GetGameTime()
		end
	end
end
function v.prototype.OnBattleStart(self, x)
	if IsServer() then
		self:SetStackCount(0)
	end
end
function v.prototype.OnCustomAttackLanded(self, y)
	local z = self:GetAbility()
	if IsBlind(y.target) or self.bonus_chance > 0 and self:PRD(self.bonus_chance, "talent_6") then
		z:Backstab()
	end
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
g.modifier_riki_talent = v
g.modifier_riki_talent_delay = c()
local A = g.modifier_riki_talent_delay
A.name = "modifier_riki_talent_delay"
d(A, l)
function A.prototype.GetAbilitySpecialValue(self)
	self.delay = 0.4
end
function A.prototype.OnCreated(self, x)
	if IsServer() then
		local w = self:GetParent()
		local B = w:GetEnemy()
		if IsInjurable(B) then
			local u = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_riki/riki_tricks.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(u, 0, B:GetAbsOrigin())
			ParticleManager:SetParticleControl(u, 1, Vector(400, 400, 400))
			ParticleManager:SetParticleControl(u, 2, Vector(1, 0, 0))
			self:AddParticle(u, false, false, -1, false, false)
			w:EmitSound("Hero_Riki.TricksOfTheTrade.Cast")
			local C = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_riki/riki_blink_strike.vpcf",
				PATTACH_ABSORIGIN,
				w
			)
			ParticleManager:SetParticleControl(C, 1, B:GetAbsOrigin())
			self:AddParticle(C, false, false, -1, false, false)
			self:StartIntervalThink(self.delay)
		end
	end
end
function A.prototype.OnIntervalThink(self)
	local w = self:GetParent()
	local B = w:GetEnemy()
	local z = self:GetAbility()
	if IsInjurable(B) then
		DamageSystem:performAttack(w, B, { ability = self:GetAbility() })
		z:Backstab()
	end
	self:StartIntervalThink(-1)
end
A = e(
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	A
)
g.modifier_riki_talent_delay = A
g.modifier_riki_talent_invincible = c()
local D = g.modifier_riki_talent_invincible
D.name = "modifier_riki_talent_invincible"
d(D, l)
function D.prototype.OnCreated(self, x)
	local w = self:GetParent()
	if IsServer() then
		w:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 2)
	else
		local u = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_riki/riki_tricks_cast.vpcf",
			PATTACH_ABSORIGIN,
			w
		)
		self:AddParticle(u, false, false, -1, false, false)
	end
end
function D.prototype.OnDestroy(self)
	local w = self:GetParent()
	if IsServer() then
		if IsInjurable(w) then
			w:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4_END, 2)
		end
	else
		local u = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_riki/riki_tricks_end.vpcf",
			PATTACH_ABSORIGIN,
			w
		)
		self:AddParticle(u, false, false, -1, false, false)
	end
end
function D.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_INJURY_PERCENTAGE] = 100,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_POISON_PERCENTAGE] = 100,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_ICE_PERCENTAGE] = 100,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ALL_BLOCK_CHANCE] = 100,
	}
end
D = e(
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
	D
)
g.modifier_riki_talent_invincible = D
g.riki_ult = c()
local E = g.riki_ult
E.name = "riki_ult"
d(E, o)
function E.prototype.OnSpellStart(self)
	local F = self:GetCaster()
	local G = F:GetEnemy()
	local H = self:GetTalentValue("riki_talent_2", "bonus_attackspeed")
	local I = self:GetSpecialValueFor("duration") + self:GetTalentValue("riki_talent_3", "bonus_duration")
	F:EmitSound("Hero_Riki.Smoke_Screen")
	if H > 0 then
		F:AddNewModifier(F, self, "modifier_riki_ult_buff", { duration = I })
	end
	G:AddNewModifier(F, self, "modifier_riki_ult_debuff", { duration = I })
	G:AddNewModifier(F, self, "modifier_blind_custom", { duration = I })
end
E = e({ p(nil) }, E)
g.riki_ult = E
g.modifier_riki_ult_buff = c()
local J = g.modifier_riki_ult_buff
J.name = "modifier_riki_ult_buff"
d(J, l)
function J.prototype.GetAbilitySpecialValue(self)
	self.bonus_attackspeed = self:GetAbilityTalentValue("riki_talent_2", "bonus_attackspeed")
end
function J.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.bonus_attackspeed }
end
J = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	J
)
g.modifier_riki_ult_buff = J
g.modifier_riki_ult_debuff = c()
local K = g.modifier_riki_ult_debuff
K.name = "modifier_riki_ult_debuff"
d(K, l)
function K.prototype.OnCreated(self, x)
	if IsServer() then
		local w = self:GetParent()
		local u = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_riki/riki_smokebomb.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(u, 0, w:GetAbsOrigin())
		ParticleManager:SetParticleControl(u, 1, Vector(300, 300, 300))
		self:AddParticle(u, false, false, -1, false, false)
	end
end
K = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	K
)
g.modifier_riki_ult_debuff = K
return g