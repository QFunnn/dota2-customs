--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/omni_knight"
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
		["18"] = 6,
		["19"] = 7,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 9,
		["24"] = 8,
		["25"] = 7,
		["26"] = 6,
		["27"] = 7,
		["29"] = 7,
		["30"] = 12,
		["31"] = 20,
		["32"] = 12,
		["33"] = 20,
		["35"] = 20,
		["36"] = 22,
		["37"] = 24,
		["38"] = 36,
		["39"] = 40,
		["40"] = 41,
		["41"] = 42,
		["42"] = 12,
		["43"] = 45,
		["44"] = 46,
		["45"] = 47,
		["46"] = 48,
		["47"] = 49,
		["48"] = 50,
		["49"] = 51,
		["50"] = 52,
		["51"] = 55,
		["52"] = 56,
		["53"] = 57,
		["54"] = 59,
		["55"] = 60,
		["56"] = 62,
		["57"] = 45,
		["58"] = 64,
		["59"] = 65,
		["60"] = 65,
		["61"] = 65,
		["62"] = 65,
		["63"] = 69,
		["64"] = 69,
		["65"] = 69,
		["66"] = 65,
		["67"] = 70,
		["68"] = 70,
		["69"] = 70,
		["70"] = 65,
		["71"] = 71,
		["72"] = 71,
		["73"] = 71,
		["74"] = 65,
		["75"] = 72,
		["76"] = 72,
		["77"] = 72,
		["78"] = 65,
		["79"] = 65,
		["80"] = 64,
		["81"] = 75,
		["82"] = 76,
		["83"] = 75,
		["84"] = 80,
		["85"] = 81,
		["86"] = 82,
		["88"] = 80,
		["89"] = 85,
		["90"] = 86,
		["91"] = 87,
		["92"] = 88,
		["93"] = 89,
		["94"] = 90,
		["95"] = 91,
		["96"] = 92,
		["97"] = 93,
		["98"] = 94,
		["100"] = 85,
		["101"] = 97,
		["102"] = 98,
		["103"] = 99,
		["104"] = 97,
		["105"] = 101,
		["106"] = 102,
		["107"] = 103,
		["108"] = 104,
		["109"] = 105,
		["111"] = 107,
		["112"] = 108,
		["114"] = 110,
		["115"] = 101,
		["116"] = 112,
		["117"] = 113,
		["118"] = 114,
		["119"] = 112,
		["120"] = 116,
		["121"] = 117,
		["122"] = 118,
		["123"] = 116,
		["124"] = 120,
		["125"] = 121,
		["126"] = 122,
		["127"] = 120,
		["128"] = 124,
		["129"] = 125,
		["130"] = 126,
		["132"] = 124,
		["133"] = 129,
		["134"] = 130,
		["137"] = 131,
		["138"] = 129,
		["139"] = 133,
		["140"] = 134,
		["141"] = 135,
		["142"] = 136,
		["143"] = 137,
		["144"] = 138,
		["145"] = 139,
		["146"] = 139,
		["147"] = 139,
		["148"] = 139,
		["149"] = 139,
		["150"] = 139,
		["153"] = 142,
		["154"] = 143,
		["156"] = 145,
		["157"] = 145,
		["158"] = 145,
		["159"] = 145,
		["160"] = 145,
		["161"] = 145,
		["162"] = 145,
		["163"] = 145,
		["164"] = 145,
		["165"] = 147,
		["166"] = 148,
		["167"] = 148,
		["168"] = 148,
		["169"] = 148,
		["170"] = 148,
		["171"] = 148,
		["173"] = 159,
		["174"] = 160,
		["176"] = 163,
		["177"] = 164,
		["178"] = 165,
		["179"] = 166,
		["182"] = 170,
		["183"] = 171,
		["184"] = 172,
		["185"] = 172,
		["186"] = 172,
		["187"] = 172,
		["188"] = 172,
		["189"] = 172,
		["190"] = 172,
		["192"] = 174,
		["193"] = 175,
		["194"] = 175,
		["195"] = 175,
		["196"] = 175,
		["197"] = 175,
		["198"] = 175,
		["199"] = 175,
		["201"] = 177,
		["202"] = 178,
		["203"] = 178,
		["204"] = 178,
		["205"] = 178,
		["206"] = 178,
		["207"] = 178,
		["208"] = 178,
		["211"] = 181,
		["212"] = 182,
		["213"] = 183,
		["214"] = 184,
		["215"] = 185,
		["216"] = 186,
		["217"] = 186,
		["218"] = 186,
		["219"] = 186,
		["220"] = 186,
		["221"] = 187,
		["222"] = 187,
		["223"] = 187,
		["224"] = 187,
		["225"] = 187,
		["226"] = 188,
		["227"] = 133,
		["228"] = 190,
		["229"] = 191,
		["230"] = 190,
		["231"] = 193,
		["232"] = 194,
		["233"] = 195,
		["234"] = 196,
		["235"] = 197,
		["236"] = 198,
		["237"] = 199,
		["239"] = 201,
		["241"] = 193,
		["242"] = 20,
		["243"] = 12,
		["244"] = 12,
		["245"] = 12,
		["246"] = 12,
		["247"] = 12,
		["248"] = 12,
		["249"] = 12,
		["250"] = 12,
		["251"] = 20,
		["253"] = 20,
		["255"] = 207,
		["256"] = 208,
		["257"] = 207,
		["258"] = 208,
		["259"] = 209,
		["260"] = 210,
		["261"] = 211,
		["262"] = 212,
		["263"] = 213,
		["264"] = 214,
		["265"] = 215,
		["266"] = 216,
		["267"] = 217,
		["268"] = 218,
		["269"] = 219,
		["270"] = 220,
		["271"] = 221,
		["272"] = 222,
		["274"] = 224,
		["275"] = 225,
		["276"] = 225,
		["277"] = 225,
		["278"] = 225,
		["279"] = 225,
		["280"] = 230,
		["281"] = 231,
		["282"] = 232,
		["283"] = 233,
		["284"] = 234,
		["285"] = 235,
		["286"] = 237,
		["287"] = 238,
		["289"] = 241,
		["290"] = 242,
		["291"] = 242,
		["292"] = 242,
		["293"] = 242,
		["294"] = 242,
		["295"] = 242,
		["297"] = 245,
		["298"] = 246,
		["299"] = 246,
		["300"] = 246,
		["301"] = 246,
		["302"] = 246,
		["303"] = 246,
		["305"] = 249,
		["306"] = 250,
		["309"] = 225,
		["310"] = 225,
		["311"] = 209,
		["312"] = 208,
		["313"] = 207,
		["314"] = 208,
		["316"] = 208,
		["318"] = 265,
		["319"] = 273,
		["320"] = 265,
		["321"] = 273,
		["322"] = 275,
		["323"] = 276,
		["324"] = 275,
		["325"] = 278,
		["326"] = 279,
		["327"] = 278,
		["328"] = 273,
		["329"] = 265,
		["330"] = 265,
		["331"] = 265,
		["332"] = 265,
		["333"] = 265,
		["334"] = 265,
		["335"] = 265,
		["336"] = 265,
		["337"] = 273,
		["339"] = 273,
		["341"] = 342,
		["342"] = 350,
		["343"] = 342,
		["344"] = 350,
		["345"] = 351,
		["346"] = 352,
		["347"] = 353,
		["349"] = 351,
		["350"] = 356,
		["351"] = 357,
		["352"] = 358,
		["354"] = 356,
		["355"] = 361,
		["356"] = 362,
		["357"] = 361,
		["358"] = 366,
		["359"] = 367,
		["360"] = 366,
		["361"] = 350,
		["362"] = 342,
		["363"] = 342,
		["364"] = 342,
		["365"] = 342,
		["366"] = 342,
		["367"] = 342,
		["368"] = 342,
		["369"] = 342,
		["370"] = 350,
		["372"] = 350,
		["374"] = 372,
		["375"] = 373,
		["376"] = 372,
		["377"] = 373,
		["378"] = 374,
		["379"] = 375,
		["380"] = 374,
		["381"] = 373,
		["382"] = 372,
		["383"] = 373,
		["385"] = 373,
		["386"] = 378,
		["387"] = 386,
		["388"] = 378,
		["389"] = 386,
		["390"] = 388,
		["391"] = 389,
		["392"] = 388,
		["393"] = 391,
		["394"] = 392,
		["395"] = 393,
		["396"] = 393,
		["397"] = 392,
		["398"] = 391,
		["399"] = 396,
		["400"] = 397,
		["401"] = 398,
		["402"] = 399,
		["404"] = 396,
		["405"] = 386,
		["406"] = 378,
		["407"] = 378,
		["408"] = 378,
		["409"] = 378,
		["410"] = 378,
		["411"] = 378,
		["412"] = 378,
		["413"] = 378,
		["414"] = 386,
		["416"] = 386,
		["418"] = 407,
		["419"] = 414,
		["420"] = 407,
		["421"] = 414,
		["422"] = 416,
		["423"] = 417,
		["424"] = 416,
		["425"] = 419,
		["426"] = 420,
		["427"] = 419,
		["428"] = 414,
		["429"] = 407,
		["430"] = 407,
		["431"] = 407,
		["432"] = 407,
		["433"] = 407,
		["434"] = 407,
		["435"] = 407,
		["436"] = 414,
		["438"] = 414,
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
g.omni_knight_talent = c()
local q = g.omni_knight_talent
q.name = "omni_knight_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_omni_knight_talent"
end
q = e({ j(nil) }, q)
g.omni_knight_talent = q
g.modifier_omni_knight_talent = c()
local r = g.modifier_omni_knight_talent
r.name = "modifier_omni_knight_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.healRecord = 0
	self.purgeRecord = 0
	self.talent_10_counter = 0
	self.poisonRecord = 0
	self.injuryRecord = 0
	self.iceRecord = 0
end
function r.prototype.GetAbilitySpecialValue(self)
	self.base_regen = self:GetAbilitySpecialValueFor("base_regen")
	self.regen = self:GetAbilitySpecialValueFor("regen")
	self.reduce = self:GetAbilitySpecialValueFor("reduce")
	self.cooldown = self:GetAbilitySpecialValueFor("cooldown")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.pure_damage_pct = self:GetAbilityTalentValue("omni_knight_talent_6", "pure_damage_pct")
	self.interval_reduce = self:GetAbilityTalentValue("omni_knight_talent_7", "interval_reduce")
	self.talent_8_value = self:GetAbilityTalentValue("omni_knight_talent_8", "value")
	self.talent_10_count = self:GetAbilityTalentValue("omni_knight_talent_10", "count")
	self["return"] = self:GetAbilityTalentValue("omni_knight_talent_11", "return")
	self.tl1_regen_pct = self:GetAbilityTalentValue("omni_knight_talent_1", "regen_pct")
	self.tl2_keep_pct = self:GetAbilityTalentValue("omni_knight_talent_2", "keep_pct")
	self.s_chance = self:GetAbilityTalentValue("omni_knight_shard", "chance")
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_HEAL] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_POISON_LOSS] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_LOSS] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_LOSS] = { -1, self:GetParent() },
	}
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_BLOCK_CHANCE }
end
function r.prototype.OnCustomAttackLanded(self, s)
	if self.s_chance > 0 and self:PRD(self.s_chance, "s_chance") then
		self:Purification(true)
	end
end
function r.prototype.OnBattleStart(self, t)
	if IsServer() then
		self.healRecord = 0
		self.purgeRecord = 0
		self.poisonRecord = 0
		self.injuryRecord = 0
		self.iceRecord = 0
		self.talent_10_counter = 0
		self:SetStackCount(0)
		self:StartIntervalThink(self.interval - self.interval_reduce)
	end
end
function r.prototype.OnHeal(self, t)
	self.healRecord = self.healRecord + t.flHealAmount
	self:SetStackCount(math.floor(self.healRecord))
end
function r.prototype.getHealAmount(self)
	local u = self:GetStackCount()
	if self.tl2_keep_pct > 0 then
		self.healRecord = self.healRecord - math.floor(u * (100 - self.tl2_keep_pct) * 0.01)
		self:SetStackCount(math.floor(self.healRecord))
	else
		self.healRecord = self.healRecord - u
		self:SetStackCount(0)
	end
	return u
end
function r.prototype.OnPoisonLoss(self, t)
	self.poisonRecord = self.poisonRecord + t.iCount
	self:OnLoss(t)
end
function r.prototype.OnIceLoss(self, t)
	self.iceRecord = self.iceRecord + t.iCount
	self:OnLoss(t)
end
function r.prototype.OnInjuryLoss(self, t)
	self.injuryRecord = self.injuryRecord + t.iCount
	self:OnLoss(t)
end
function r.prototype.OnLoss(self, t)
	if self:GetAbility():IsCooldownReady() then
		self.purgeRecord = self.purgeRecord + t.iCount
	end
end
function r.prototype.OnIntervalThink(self)
	if self:GetParent():PassivesDisabled() then
		return
	end
	self:Purification()
end
function r.prototype.Purification(self, v)
	local w = self:GetCaster()
	local x = w:GetEnemy()
	local y = self:GetAbility()
	local z = self.base_regen + self.purgeRecord / self.reduce * self.regen
	if v then
		Heal(w, z, y:GetAbilityName(), "Ability")
		return
	end
	if self.tl1_regen_pct > 0 then
		z = z + math.floor(self.healRecord * self.tl1_regen_pct * 0.01)
	end
	Heal(w, math.min(z, w:GetMaxHealth()), y:GetAbilityName(), "Ability")
	if self.pure_damage_pct > 0 then
		w:DealDamage(w:GetEnemy(), y, z * self.pure_damage_pct * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
	end
	if self.talent_8_value > 0 then
		ReduceDebuff(w, 0, self.talent_8_value)
	end
	if self.talent_10_count > 0 then
		self.talent_10_counter = self.talent_10_count
		if self.talent_10_pctl == nil then
			self.talent_10_pctl = ParticleManager:CreateParticle(
				"particles/econ/items/omniknight/omni_ti8_head/omniknight_repel_buff_ti8.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				w
			)
		end
	end
	if self["return"] > 0 then
		if self.poisonRecord > 0 then
			AddPoison(w, x, math.floor(self.poisonRecord * self["return"] * 0.01), "omni_knight_talent_11", "Ability")
		end
		if self.injuryRecord > 0 then
			AddInjury(w, x, math.floor(self.injuryRecord * self["return"] * 0.01), "omni_knight_talent_11", "Ability")
		end
		if self.iceRecord > 0 then
			AddIce(w, x, math.floor(self.iceRecord * self["return"] * 0.01), "omni_knight_talent_11", "Ability")
		end
	end
	self.poisonRecord = 0
	self.injuryRecord = 0
	self.iceRecord = 0
	self.purgeRecord = 0
	local A = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_omniknight/omniknight_purification.vpcf",
		PATTACH_CUSTOMORIGIN,
		w
	)
	ParticleManager:SetParticleControl(A, 0, w:GetAbsOrigin())
	ParticleManager:SetParticleControl(A, 1, Vector(200, 200, 200))
	w:EmitSound("Greevil.Purification")
end
function r.prototype.OnBattleEnd(self)
	self:StartIntervalThink(-1)
end
function r.prototype.EOM_GetModifierPhysicalBlockChance(self, t)
	if t and self.talent_10_counter > 0 then
		self.talent_10_counter = self.talent_10_counter - 1
		if self.talent_10_counter <= 0 and self.talent_10_pctl ~= nil then
			ParticleManager:DestroyParticle(self.talent_10_pctl, false)
			ParticleManager:ReleaseParticleIndex(self.talent_10_pctl)
			self.talent_10_pctl = nil
		end
		return 100
	end
end
r = e(
	{
		m(
			a,
			{
				IsHidden = false,
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
g.modifier_omni_knight_talent = r
g.omni_knight_ult = c()
local B = g.omni_knight_ult
B.name = "omni_knight_ult"
d(B, o)
function B.prototype.OnSpellStart(self)
	local C = self:GetCaster()
	local D = C:GetEnemy()
	local E = self:GetSpecialValueFor("damage")
	local F = self:GetSpecialValueFor("damage_bonus") + self:GetTalentValue("omni_knight_talent_3", "damage_bonus_pct")
	local G = self:GetTalentValue("omni_knight_talent_4", "duration")
	local H = self:GetTalentValue("omni_knight_talent_5", "heal_pct")
	local I = self:GetTalentValue("omni_knight_talent_11", "chance")
	local J = self:GetTalentValue("omni_knight_talent_11", "max_health_reduce")
	local K = self:GetTalentValue("omni_knight_talent_9", "duration")
	C:EmitSound("Hero_Omniknight.HammerOfPurity.Heal")
	local L = 0
	if C:HasModifier("modifier_omni_knight_talent") then
		L = C:FindModifierByName("modifier_omni_knight_talent"):getHealAmount()
	end
	C:StartGesture(ACT_DOTA_ATTACK)
	Projectile:CreateTrackingProjectile({
		EffectName = "particles/units/heroes/hero_omniknight/omniknight_hammer_of_purity_projectile.vpcf",
		hCaster = C,
		hTarget = D,
		iMoveSpeed = 600,
		OnProjectileHit = function(D, M, N)
			if IsInjurable(D) then
				local O = E + F * L * 0.01
				C:DealDamage(D, self, O, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
				EmitSoundOnLocationWithCaster(M, "Hero_Omniknight.HammerOfPurity.Crit", C)
				ParticleManager:CreateParticle(
					"particles/units/heroes/hero_omniknight/omniknight_shard_hammer_of_purity_heal.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					C
				)
				if G > 0 then
					D:AddNewModifier(C, self, "modifier_omni_knight_talent_4", { duration = G })
				end
				if H > 0 then
					Heal(C, O * H * 0.01, self:GetAbilityName(), "Ability")
				end
				if I > 0 and self:PRD(I) then
					D:AddNewModifier(
						C,
						self,
						"modifier_omni_knight_talent_11",
						{ iStackCount = math.floor(J * O * 0.01) }
					)
				end
				if K > 0 then
					D:AddNewModifier(C, self, "modifier_omni_knight_talent_9", { duration = K })
				end
			end
		end,
	})
end
B = e({ p(nil) }, B)
g.omni_knight_ult = B
g.modifier_omni_knight_talent_4 = c()
local P = g.modifier_omni_knight_talent_4
P.name = "modifier_omni_knight_talent_4"
d(P, l)
function P.prototype.GetAbilitySpecialValue(self)
	self.attackspeed_reduce = self:GetAbilityTalentValue("omni_knight_talent_4", "attackspeed_reduce")
end
function P.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = -self.attackspeed_reduce }
end
P = e(
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
	P
)
g.modifier_omni_knight_talent_4 = P
g.modifier_omni_knight_talent_11 = c()
local Q = g.modifier_omni_knight_talent_11
Q.name = "modifier_omni_knight_talent_11"
d(Q, l)
function Q.prototype.OnCreated(self, t)
	if IsServer() then
		self:IncrementStackCount(t.iStackCount)
	end
end
function Q.prototype.OnRefresh(self, t)
	if IsServer() then
		self:IncrementStackCount(t.iStackCount)
	end
end
function Q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function Q.prototype.EOM_GetModifierHealthBonus(self)
	return -self:GetStackCount()
end
Q = e(
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
	Q
)
g.modifier_omni_knight_talent_11 = Q
g.omni_knight_talent_12 = c()
local R = g.omni_knight_talent_12
R.name = "omni_knight_talent_12"
d(R, i)
function R.prototype.GetIntrinsicModifierName(self)
	return "modifier_omni_knight_talent_12"
end
R = e({ j(nil) }, R)
g.omni_knight_talent_12 = R
g.modifier_omni_knight_talent_12 = c()
local S = g.modifier_omni_knight_talent_12
S.name = "modifier_omni_knight_talent_12"
d(S, l)
function S.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
end
function S.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function S.prototype.OnCustomAttackLanded(self, s)
	if self.chance > 0 and self:PRD(self.chance) then
		local T = self:GetParent():FindModifierByName("modifier_omni_knight_talent")
		T:OnIntervalThink()
	end
end
S = e(
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
	S
)
g.modifier_omni_knight_talent_12 = S
g.modifier_omni_knight_talent_9 = c()
local U = g.modifier_omni_knight_talent_9
U.name = "modifier_omni_knight_talent_9"
d(U, l)
function U.prototype.GetAbilitySpecialValue(self)
	self.damage_reduce = self:GetAbilityTalentValue("omni_knight_talent_9", "damage_reduce")
end
function U.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE] = -self.damage_reduce }
end
U = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	U
)
g.modifier_omni_knight_talent_9 = U
return g