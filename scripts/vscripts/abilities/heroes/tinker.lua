--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/tinker"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIncludes
local g = b.__TS__ObjectKeys
local h = b.__TS__ArrayMap
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 1,
		["12"] = 1,
		["13"] = 1,
		["14"] = 2,
		["15"] = 2,
		["16"] = 2,
		["17"] = 3,
		["18"] = 3,
		["19"] = 3,
		["20"] = 5,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["24"] = 7,
		["25"] = 8,
		["26"] = 7,
		["27"] = 6,
		["28"] = 5,
		["29"] = 6,
		["31"] = 6,
		["32"] = 12,
		["33"] = 20,
		["34"] = 12,
		["35"] = 20,
		["37"] = 20,
		["38"] = 26,
		["39"] = 12,
		["40"] = 27,
		["41"] = 28,
		["42"] = 31,
		["43"] = 32,
		["44"] = 27,
		["45"] = 34,
		["46"] = 35,
		["47"] = 34,
		["48"] = 39,
		["49"] = 40,
		["50"] = 40,
		["51"] = 40,
		["52"] = 40,
		["53"] = 44,
		["54"] = 44,
		["55"] = 44,
		["56"] = 40,
		["57"] = 40,
		["58"] = 39,
		["59"] = 48,
		["60"] = 49,
		["61"] = 50,
		["62"] = 51,
		["63"] = 52,
		["64"] = 54,
		["65"] = 55,
		["66"] = 57,
		["67"] = 58,
		["68"] = 58,
		["69"] = 58,
		["70"] = 59,
		["71"] = 60,
		["72"] = 61,
		["74"] = 58,
		["75"] = 58,
		["76"] = 64,
		["77"] = 64,
		["78"] = 64,
		["79"] = 65,
		["80"] = 66,
		["81"] = 67,
		["83"] = 64,
		["84"] = 64,
		["85"] = 70,
		["87"] = 72,
		["88"] = 73,
		["89"] = 48,
		["90"] = 86,
		["91"] = 87,
		["92"] = 88,
		["93"] = 89,
		["94"] = 90,
		["95"] = 91,
		["96"] = 92,
		["97"] = 92,
		["98"] = 92,
		["99"] = 93,
		["100"] = 94,
		["101"] = 95,
		["103"] = 92,
		["104"] = 92,
		["105"] = 98,
		["106"] = 98,
		["107"] = 98,
		["108"] = 99,
		["109"] = 100,
		["110"] = 101,
		["112"] = 98,
		["113"] = 98,
		["114"] = 104,
		["115"] = 86,
		["116"] = 106,
		["117"] = 107,
		["118"] = 108,
		["119"] = 109,
		["120"] = 109,
		["121"] = 109,
		["122"] = 110,
		["123"] = 109,
		["124"] = 109,
		["126"] = 106,
		["127"] = 114,
		["128"] = 115,
		["129"] = 116,
		["130"] = 117,
		["131"] = 118,
		["134"] = 121,
		["135"] = 122,
		["137"] = 124,
		["138"] = 114,
		["139"] = 20,
		["140"] = 12,
		["141"] = 12,
		["142"] = 12,
		["143"] = 12,
		["144"] = 12,
		["145"] = 12,
		["146"] = 12,
		["147"] = 12,
		["148"] = 20,
		["150"] = 20,
		["152"] = 129,
		["153"] = 130,
		["154"] = 129,
		["155"] = 130,
		["156"] = 132,
		["157"] = 133,
		["158"] = 134,
		["159"] = 135,
		["160"] = 136,
		["161"] = 137,
		["162"] = 138,
		["163"] = 139,
		["164"] = 140,
		["165"] = 141,
		["166"] = 142,
		["167"] = 142,
		["168"] = 142,
		["169"] = 143,
		["170"] = 144,
		["171"] = 145,
		["172"] = 146,
		["174"] = 142,
		["175"] = 142,
		["176"] = 132,
		["177"] = 150,
		["178"] = 151,
		["179"] = 152,
		["180"] = 153,
		["181"] = 154,
		["182"] = 155,
		["183"] = 156,
		["184"] = 157,
		["185"] = 159,
		["186"] = 160,
		["187"] = 161,
		["188"] = 163,
		["189"] = 164,
		["190"] = 165,
		["191"] = 166,
		["192"] = 168,
		["193"] = 169,
		["194"] = 170,
		["195"] = 170,
		["196"] = 170,
		["197"] = 170,
		["198"] = 170,
		["199"] = 175,
		["200"] = 175,
		["201"] = 175,
		["202"] = 175,
		["203"] = 170,
		["204"] = 176,
		["205"] = 177,
		["206"] = 178,
		["207"] = 179,
		["208"] = 179,
		["209"] = 179,
		["210"] = 179,
		["211"] = 179,
		["212"] = 179,
		["213"] = 179,
		["214"] = 180,
		["215"] = 182,
		["216"] = 183,
		["218"] = 186,
		["219"] = 187,
		["220"] = 187,
		["221"] = 187,
		["222"] = 187,
		["223"] = 187,
		["224"] = 187,
		["225"] = 187,
		["227"] = 190,
		["228"] = 191,
		["229"] = 191,
		["230"] = 191,
		["231"] = 191,
		["232"] = 191,
		["233"] = 191,
		["234"] = 191,
		["236"] = 193,
		["237"] = 170,
		["238"] = 170,
		["239"] = 196,
		["240"] = 150,
		["241"] = 130,
		["242"] = 129,
		["243"] = 130,
		["245"] = 130,
		["247"] = 205,
		["248"] = 206,
		["249"] = 205,
		["250"] = 206,
		["251"] = 207,
		["252"] = 208,
		["253"] = 207,
		["254"] = 206,
		["255"] = 205,
		["256"] = 206,
		["258"] = 206,
		["259"] = 211,
		["260"] = 219,
		["261"] = 211,
		["262"] = 219,
		["263"] = 223,
		["264"] = 224,
		["265"] = 225,
		["266"] = 226,
		["267"] = 223,
		["268"] = 228,
		["269"] = 229,
		["270"] = 230,
		["271"] = 230,
		["272"] = 229,
		["273"] = 228,
		["274"] = 233,
		["275"] = 234,
		["276"] = 235,
		["277"] = 236,
		["278"] = 237,
		["279"] = 238,
		["280"] = 238,
		["282"] = 239,
		["283"] = 240,
		["284"] = 241,
		["285"] = 242,
		["286"] = 243,
		["287"] = 243,
		["288"] = 243,
		["289"] = 243,
		["290"] = 243,
		["291"] = 243,
		["292"] = 243,
		["293"] = 243,
		["294"] = 243,
		["295"] = 244,
		["296"] = 244,
		["297"] = 244,
		["298"] = 244,
		["299"] = 244,
		["300"] = 244,
		["301"] = 244,
		["302"] = 244,
		["303"] = 244,
		["304"] = 245,
		["305"] = 246,
		["306"] = 247,
		["307"] = 248,
		["308"] = 249,
		["309"] = 249,
		["310"] = 249,
		["311"] = 249,
		["312"] = 250,
		["313"] = 250,
		["316"] = 233,
		["317"] = 258,
		["318"] = 259,
		["319"] = 260,
		["320"] = 261,
		["321"] = 262,
		["322"] = 263,
		["323"] = 264,
		["324"] = 264,
		["325"] = 264,
		["326"] = 264,
		["327"] = 264,
		["328"] = 264,
		["329"] = 265,
		["332"] = 268,
		["333"] = 269,
		["335"] = 258,
		["336"] = 219,
		["337"] = 211,
		["338"] = 211,
		["339"] = 211,
		["340"] = 211,
		["341"] = 211,
		["342"] = 211,
		["343"] = 211,
		["344"] = 211,
		["345"] = 219,
		["347"] = 219,
		["349"] = 275,
		["350"] = 276,
		["351"] = 275,
		["352"] = 276,
		["353"] = 277,
		["354"] = 278,
		["355"] = 277,
		["356"] = 276,
		["357"] = 275,
		["358"] = 276,
		["360"] = 276,
		["361"] = 281,
		["362"] = 289,
		["363"] = 281,
		["364"] = 289,
		["365"] = 291,
		["366"] = 292,
		["367"] = 291,
		["368"] = 294,
		["369"] = 295,
		["370"] = 294,
		["371"] = 299,
		["372"] = 300,
		["373"] = 299,
		["374"] = 304,
		["375"] = 306,
		["376"] = 307,
		["377"] = 308,
		["378"] = 309,
		["379"] = 311,
		["380"] = 312,
		["381"] = 312,
		["382"] = 312,
		["383"] = 313,
		["384"] = 314,
		["385"] = 315,
		["387"] = 312,
		["388"] = 312,
		["389"] = 318,
		["390"] = 318,
		["391"] = 318,
		["392"] = 319,
		["393"] = 320,
		["394"] = 321,
		["396"] = 318,
		["397"] = 318,
		["398"] = 325,
		["399"] = 304,
		["400"] = 327,
		["401"] = 328,
		["402"] = 327,
		["403"] = 289,
		["404"] = 281,
		["405"] = 281,
		["406"] = 281,
		["407"] = 281,
		["408"] = 281,
		["409"] = 281,
		["410"] = 281,
		["411"] = 281,
		["412"] = 289,
		["414"] = 289,
		["416"] = 334,
		["417"] = 335,
		["418"] = 334,
		["419"] = 335,
		["420"] = 336,
		["421"] = 337,
		["422"] = 336,
		["423"] = 335,
		["424"] = 334,
		["425"] = 335,
		["427"] = 335,
		["428"] = 340,
		["429"] = 348,
		["430"] = 340,
		["431"] = 348,
		["432"] = 350,
		["433"] = 351,
		["434"] = 350,
		["435"] = 353,
		["436"] = 354,
		["437"] = 355,
		["438"] = 355,
		["439"] = 354,
		["440"] = 353,
		["441"] = 358,
		["442"] = 359,
		["443"] = 360,
		["445"] = 360,
		["448"] = 358,
		["449"] = 348,
		["450"] = 340,
		["451"] = 340,
		["452"] = 340,
		["453"] = 340,
		["454"] = 340,
		["455"] = 340,
		["456"] = 340,
		["457"] = 340,
		["458"] = 348,
		["460"] = 348,
		["462"] = 366,
		["463"] = 367,
		["464"] = 366,
		["465"] = 367,
		["466"] = 368,
		["467"] = 369,
		["468"] = 368,
		["469"] = 367,
		["470"] = 366,
		["471"] = 367,
		["473"] = 367,
		["474"] = 372,
		["475"] = 380,
		["476"] = 372,
		["477"] = 380,
		["478"] = 384,
		["479"] = 385,
		["480"] = 386,
		["481"] = 384,
		["482"] = 388,
		["483"] = 389,
		["484"] = 388,
		["485"] = 393,
		["486"] = 394,
		["487"] = 393,
		["488"] = 397,
		["489"] = 398,
		["490"] = 399,
		["491"] = 400,
		["492"] = 401,
		["493"] = 402,
		["494"] = 403,
		["495"] = 404,
		["496"] = 405,
		["497"] = 406,
		["499"] = 408,
		["500"] = 409,
		["501"] = 410,
		["502"] = 411,
		["505"] = 414,
		["507"] = 415,
		["508"] = 415,
		["509"] = 416,
		["510"] = 415,
		["513"] = 418,
		["516"] = 421,
		["517"] = 397,
		["518"] = 423,
		["519"] = 424,
		["520"] = 425,
		["521"] = 426,
		["523"] = 423,
		["524"] = 429,
		["525"] = 430,
		["526"] = 429,
		["527"] = 434,
		["528"] = 435,
		["529"] = 436,
		["531"] = 434,
		["532"] = 380,
		["533"] = 372,
		["534"] = 372,
		["535"] = 372,
		["536"] = 372,
		["537"] = 372,
		["538"] = 372,
		["539"] = 372,
		["540"] = 372,
		["541"] = 380,
		["543"] = 380,
	}
)
local j = {}
local k = require("lib.dota_ts_adapter")
local l = k.BaseAbility
local m = k.registerAbility
local n = require("modifiers.eom_modifier")
local o = n.EOMModifier
local p = n.registerEOMModifier
local q = require("abilities.ability_ai")
local r = q.BaseAbilityAI
local s = q.registerAbilityAI
j.tinker_talent = c()
local t = j.tinker_talent
t.name = "tinker_talent"
d(t, l)
function t.prototype.GetIntrinsicModifierName(self)
	return "modifier_tinker_talent"
end
t = e({ m(nil) }, t)
j.tinker_talent = t
j.modifier_tinker_talent = c()
local u = j.modifier_tinker_talent
u.name = "modifier_tinker_talent"
d(u, o)
function u.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.g_n_card_count = 0
end
function u.prototype.GetAbilitySpecialValue(self)
	self.factor = self:GetAbilitySpecialValueFor("factor") + self:GetAbilityTalentValue("tinker_talent_1", "factor")
	self.s_bonus = self:GetAbilityTalentValue("tinker_shard", "bonus")
	self.g_skill_damage_bonus = self:GetAbilitySpecialValueFor("g_skill_damage_bonus")
end
function u.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_CONSTANT }
end
function u.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TALENT_LEARN] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
	}
end
function u.prototype.OnBattleStartBefore(self, v)
	local w = 0
	local x = self:GetParent():GetHeroBase()
	local y = x:getAbilityUpgradeData(true)
	if self.s_bonus > 0 then
		local z = x:getTempAbilityUpgrade()
		local A = KeyValues.AbilityUpgradesKvs
		local B = {}
		h(g(y), function(C, D)
			local E = A[D] or {}
			if E.rarity == "sr" and not f(B, D) then
				B[#B + 1] = D
			end
		end)
		h(g(z), function(C, D)
			local E = A[D] or {}
			if E.rarity == "sr" and not f(B, D) then
				B[#B + 1] = D
			end
		end)
		w = #B * self.s_bonus
	end
	w = w + #g(x:getAbilityUpgradeData(true, true)) * self.factor
	self:SetStackCount(w)
end
function u.prototype.OnBattleStart(self, v)
	local x = self:GetParent():GetHeroBase()
	local y = x:getAbilityUpgradeData(true)
	local z = x:getTempAbilityUpgrade()
	local A = KeyValues.AbilityUpgradesKvs
	local F = {}
	h(g(y), function(C, D)
		local E = A[D] or {}
		if E.rarity == "n" and not f(F, D) then
			F[#F + 1] = D
		end
	end)
	h(g(z), function(C, D)
		local E = A[D] or {}
		if E.rarity == "n" and not f(F, D) then
			F[#F + 1] = D
		end
	end)
	self.g_n_card_count = #F
end
function u.prototype.OnTalentLearn(self, v)
	if v.talentName == "tinker_talent_8" then
		local G = self:GetParent():GetHeroBase()
		h(AbilityShop.pickList, function(C, H)
			G:addSectExp(H, 0)
		end)
	end
end
function u.prototype.EOM_GetModifierOutgoingDamageConstant(self, v)
	local I = 0
	if self.g_skill_damage_bonus > 0 then
		if v.ability_upgrade and KeyValues.AbilityUpgradesKvs[v.ability_upgrade].rarity == "sr" then
			I = I + self.g_skill_damage_bonus * self.g_n_card_count
		end
	end
	if v.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL then
		I = I + self:GetStackCount()
	end
	return I
end
u = e(
	{
		p(
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
	u
)
j.modifier_tinker_talent = u
j.tinker_ult = c()
local J = j.tinker_ult
J.name = "tinker_ult"
d(J, r)
function J.prototype.OnSpellStart(self)
	local K = self:GetCaster()
	local L = K:GetEnemy()
	local M = self:GetSpecialValueFor("damage")
	local N = self:GetSpecialValueFor("count") + self:GetTalentValue("tinker_talent_3", "missile_count")
	local O = self:GetSpecialValueFor("interval")
	K:AddActivityModifier("activity_ult")
	K:StartGestureWithPlaybackRate(ACT_DOTA_TELEPORT_END, 0.4)
	K:RemoveActivityModifier("activity_ult")
	local P = 0
	self:GameTimer(0, function()
		if P < N then
			P = P + 1
			self:Launch(L)
			return O
		end
	end)
end
function J.prototype.Launch(self, L)
	local K = self:GetCaster()
	local Q = K:GetAttachmentPosition("attach_ambient")
	local M = self:GetSpecialValueFor("damage")
	local R = self:GetSpecialValueFor("level_factor")
	local S = self:GetTalentValue("tinker_talent_2", "chance")
	local T = self:GetTalentValue("tinker_talent_2", "mana_regen")
	local U = self:GetTalentValue("tinker_talent_7", "missile_damage")
	local V = self:GetTalentValue("tinker_talent_9", "damage_per_stack")
	local W = self:GetTalentValue("tinker_talent_9", "max_stack")
	self.tinker_talent_9_record = self.tinker_talent_9_record or 0
	local X = self:GetTalentValue("tinker_talent_11", "chance")
	local Y = self:GetTalentValue("tinker_talent_11", "injury")
	local Z = self:GetTalentValue("tinker_talent_12", "chance")
	local _ = self:GetTalentValue("tinker_talent_12", "damage_pct")
	local a0 = PlayerData:getHero(K:GetPlayerOwnerID())
	local a1 = a0 ~= nil and a0:getLevel() or 1
	Projectile:CreateTrackingProjectile({
		EffectName = "particles/units/heroes/hero_tinker/tinker_missile.vpcf",
		hCaster = K,
		hTarget = L,
		iMoveSpeed = 600,
		vSpawnOrigin = Q + Vector(RandomInt(-150, 150), RandomInt(-150, 150), 0),
		OnProjectileHit = function(L, a2, a3)
			local a4 = M + a1 * R + U + math.min(W, self.tinker_talent_9_record) * V
			local a5 = self:HasTalent("tinker_talent_10") and DamageFlags.DAMAGE_FLAG_NO_EVASION
				or DamageFlags.DAMAGE_FLAG_NONE
			K:DealDamage(L, self, a4, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL, a5)
			EmitSoundOnLocationWithCaster(a2, "Hero_Tinker.Heat-Seeking_Missile.Impact", K)
			if S > 0 and self:PRD(S, "talent_2_chance") then
				Restore(K, T, true)
			end
			if X > 0 and self:PRD(X, "talent_11_chance") then
				AddInjury(K, L, Y, "tinker_talent_11", "Ability")
			end
			if Z > 0 and self:PRD(Z, "talent_12_chance") then
				K:DealDamage(L, self, a4 * _ * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL, a5)
			end
			self.tinker_talent_9_record = self.tinker_talent_9_record + 1
		end,
	})
	K:EmitSound("Hero_Tinker.Heat-Seeking_Missile")
end
J = e({ s(nil) }, J)
j.tinker_ult = J
j.tinker_talent_4 = c()
local a6 = j.tinker_talent_4
a6.name = "tinker_talent_4"
d(a6, l)
function a6.prototype.GetIntrinsicModifierName(self)
	return "modifier_tinker_talent_4"
end
a6 = e({ m(nil) }, a6)
j.tinker_talent_4 = a6
j.modifier_tinker_talent_4 = c()
local a7 = j.modifier_tinker_talent_4
a7.name = "modifier_tinker_talent_4"
d(a7, o)
function a7.prototype.GetAbilitySpecialValue(self)
	self.stack = self:GetAbilitySpecialValueFor("stack")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.timer = {}
end
function a7.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function a7.prototype.OnCustomTakeDamage(self, a8)
	if self.stack > 0 and a8.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL then
		self:IncrementStackCount()
		if self:GetStackCount() >= self.stack then
			self:SetStackCount(0)
			if #self.timer == 0 then
				self:StartIntervalThink(0)
			end
			local a9 = self:GetParent()
			local aa = GameRules:GetGameTime()
			local ab = 0.15
			local ac = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_tinker/tinker_laser.vpcf",
				PATTACH_CUSTOMORIGIN,
				a9
			)
			ParticleManager:SetParticleControlEnt(
				ac,
				9,
				a9,
				PATTACH_POINT_FOLLOW,
				"attach_attack2",
				vec3_invalid,
				false
			)
			ParticleManager:SetParticleControlEnt(
				ac,
				1,
				a8.target,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				vec3_invalid,
				false
			)
			ParticleManager:ReleaseParticleIndex(ac)
			EmitSoundOn("Hero_Tinker.Laser", a9)
			EmitSoundOn("Hero_Tinker.LaserImpact", a8.target)
			a9:ForcePlayActivityOnce(ACT_DOTA_CAST_ABILITY_1)
			a9:StartGestureWithPlaybackRate(
				ACT_DOTA_CAST_ABILITY_1,
				a9:GetAttackSpeed(false) * a9:GetBaseAttackTime(false) * 1.25
			)
			local ad = self.timer
			ad[#ad + 1] = { flExpireTime = aa + ab, hTarget = a8.target, flDamage = self.damage }
		end
	end
end
function a7.prototype.OnIntervalThink(self)
	local a9 = self:GetParent()
	local aa = GameRules:GetGameTime()
	for ae = #self.timer, 1, -1 do
		local af = self.timer[ae]
		if aa >= af.flExpireTime then
			a9:DealDamage(af.hTarget, self:GetAbility(), af.flDamage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			table.remove(self.timer, ae)
		end
	end
	if #self.timer == 0 then
		self:StartIntervalThink(-1)
	end
end
a7 = e(
	{
		p(
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
	a7
)
j.modifier_tinker_talent_4 = a7
j.tinker_talent_5 = c()
local ag = j.tinker_talent_5
ag.name = "tinker_talent_5"
d(ag, l)
function ag.prototype.GetIntrinsicModifierName(self)
	return "modifier_tinker_talent_5"
end
ag = e({ m(nil) }, ag)
j.tinker_talent_5 = ag
j.modifier_tinker_talent_5 = c()
local ah = j.modifier_tinker_talent_5
ah.name = "modifier_tinker_talent_5"
d(ah, o)
function ah.prototype.GetAbilitySpecialValue(self)
	self.damage_bonus = self:GetAbilitySpecialValueFor("damage_bonus")
end
function ah.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function ah.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function ah.prototype.OnBattleStartBefore(self, v)
	local x = self:GetParent():GetHeroBase()
	local y = x:getAbilityUpgradeData(true)
	local z = x:getTempAbilityUpgrade()
	local A = KeyValues.AbilityUpgradesKvs
	local B = {}
	h(g(y), function(C, D)
		local E = A[D] or {}
		if E.rarity == "sr" and not f(B, D) then
			B[#B + 1] = D
		end
	end)
	h(g(z), function(C, D)
		local E = A[D] or {}
		if E.rarity == "sr" and not f(B, D) then
			B[#B + 1] = D
		end
	end)
	self:SetStackCount(#B)
end
function ah.prototype.EOM_GetModifierOutgoingDamagePercentage(self)
	return self.damage_bonus * self:GetStackCount()
end
ah = e(
	{
		p(
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
	ah
)
j.modifier_tinker_talent_5 = ah
j.tinker_talent_6 = c()
local ai = j.tinker_talent_6
ai.name = "tinker_talent_6"
d(ai, l)
function ai.prototype.GetIntrinsicModifierName(self)
	return "modifier_tinker_talent_6"
end
ai = e({ m(nil) }, ai)
j.tinker_talent_6 = ai
j.modifier_tinker_talent_6 = c()
local aj = j.modifier_tinker_talent_6
aj.name = "modifier_tinker_talent_6"
d(aj, o)
function aj.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
end
function aj.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function aj.prototype.OnCustomTakeDamage(self, a8)
	if self.chance > 0 and a8.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL and self:PRD(self.chance) then
		local ak = self:GetParent():FindAbilityByName("tinker_ult")
		if ak ~= nil then
			ak:Launch(a8.target)
		end
	end
end
aj = e(
	{
		p(
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
	aj
)
j.modifier_tinker_talent_6 = aj
j.tinker_talent_8 = c()
local al = j.tinker_talent_8
al.name = "tinker_talent_8"
d(al, l)
function al.prototype.GetIntrinsicModifierName(self)
	return "modifier_tinker_talent_8"
end
al = e({ m(nil) }, al)
j.tinker_talent_8 = al
j.modifier_tinker_talent_8 = c()
local am = j.modifier_tinker_talent_8
am.name = "modifier_tinker_talent_8"
d(am, o)
function am.prototype.GetAbilitySpecialValue(self)
	self.exp_reduce = self:GetAbilitySpecialValueFor("exp_reduce")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function am.prototype.AddCustomTransmitterData(self)
	return { tl8_list = self.tl8_list }
end
function am.prototype.HandleCustomTransmitterData(self, an)
	self.tl8_list = an.tl8_list
end
function am.prototype.loadDataTl8(self)
	local ao = self:GetParent():GetPlayerOwnerID()
	local ap = PlayerData:loadData(ao, "tinker_talent_8")
	local aq = PlayerData:getplayerData(ao)
	if aq then
		if ap == nil then
			local ar = {}
			local as = AbilityShop.pickList
			if aq.bannedSect then
				ArrayRemove(as, aq.bannedSect)
			end
			while #ar < self.count do
				local at = as[RandomInt(0, #as - 1) + 1]
				if not f(ar, at) then
					ar[#ar + 1] = at
				end
			end
			ap = {}
			do
				local ae = 0
				while ae < #ar do
					ap[ar[ae + 1]] = true
					ae = ae + 1
				end
			end
			PlayerData:saveData(ao, "tinker_talent_8", ap)
		end
	end
	self.tl8_list = ap
end
function am.prototype.OnCreated(self, v)
	if IsServer() then
		self:loadDataTl8()
		self:SetHasCustomTransmitterData(true)
	end
end
function am.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_SECT_EXP_REDUCE }
end
function am.prototype.EOM_GetModifierSectExpReduce(self, v)
	if v and v.sect and self.tl8_list ~= nil and self.tl8_list[v.sect] then
		return self.exp_reduce
	end
end
am = e(
	{
		p(
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
	am
)
j.modifier_tinker_talent_8 = am
return j