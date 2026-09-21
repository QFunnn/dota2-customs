--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
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
local i = b.__TS__ArrayFilter
local j = b.__TS__SourceMapTraceBack
j(
	debug.getinfo(1).short_src,
	{
		["12"] = 1,
		["13"] = 1,
		["14"] = 1,
		["15"] = 2,
		["16"] = 2,
		["17"] = 2,
		["18"] = 3,
		["19"] = 3,
		["20"] = 3,
		["21"] = 5,
		["22"] = 6,
		["23"] = 5,
		["24"] = 6,
		["25"] = 7,
		["26"] = 8,
		["27"] = 7,
		["28"] = 6,
		["29"] = 5,
		["30"] = 6,
		["32"] = 6,
		["33"] = 12,
		["34"] = 20,
		["35"] = 12,
		["36"] = 20,
		["38"] = 20,
		["39"] = 26,
		["40"] = 12,
		["41"] = 27,
		["42"] = 28,
		["43"] = 31,
		["44"] = 32,
		["45"] = 33,
		["46"] = 27,
		["47"] = 35,
		["48"] = 36,
		["49"] = 35,
		["50"] = 40,
		["51"] = 41,
		["52"] = 41,
		["53"] = 41,
		["54"] = 41,
		["55"] = 45,
		["56"] = 45,
		["57"] = 45,
		["58"] = 41,
		["59"] = 41,
		["60"] = 40,
		["61"] = 49,
		["62"] = 50,
		["63"] = 51,
		["64"] = 52,
		["65"] = 53,
		["66"] = 55,
		["67"] = 56,
		["68"] = 58,
		["69"] = 59,
		["70"] = 59,
		["71"] = 59,
		["72"] = 60,
		["73"] = 61,
		["74"] = 62,
		["76"] = 59,
		["77"] = 59,
		["78"] = 65,
		["79"] = 65,
		["80"] = 65,
		["81"] = 66,
		["82"] = 67,
		["83"] = 68,
		["85"] = 65,
		["86"] = 65,
		["87"] = 71,
		["89"] = 73,
		["90"] = 74,
		["91"] = 49,
		["92"] = 87,
		["93"] = 88,
		["94"] = 89,
		["95"] = 90,
		["96"] = 91,
		["97"] = 92,
		["98"] = 93,
		["99"] = 93,
		["100"] = 93,
		["101"] = 94,
		["102"] = 95,
		["103"] = 96,
		["105"] = 93,
		["106"] = 93,
		["107"] = 99,
		["108"] = 99,
		["109"] = 99,
		["110"] = 100,
		["111"] = 101,
		["112"] = 102,
		["114"] = 99,
		["115"] = 99,
		["116"] = 105,
		["117"] = 87,
		["118"] = 107,
		["119"] = 108,
		["120"] = 109,
		["121"] = 110,
		["122"] = 110,
		["123"] = 110,
		["124"] = 111,
		["125"] = 110,
		["126"] = 110,
		["128"] = 107,
		["129"] = 115,
		["130"] = 116,
		["131"] = 117,
		["132"] = 118,
		["133"] = 119,
		["136"] = 122,
		["137"] = 123,
		["139"] = 125,
		["140"] = 115,
		["141"] = 20,
		["142"] = 12,
		["143"] = 12,
		["144"] = 12,
		["145"] = 12,
		["146"] = 12,
		["147"] = 12,
		["148"] = 12,
		["149"] = 12,
		["150"] = 20,
		["152"] = 20,
		["154"] = 130,
		["155"] = 131,
		["156"] = 130,
		["157"] = 131,
		["158"] = 133,
		["159"] = 134,
		["160"] = 135,
		["161"] = 136,
		["162"] = 137,
		["163"] = 138,
		["164"] = 139,
		["165"] = 140,
		["166"] = 141,
		["167"] = 142,
		["168"] = 143,
		["169"] = 143,
		["170"] = 143,
		["171"] = 144,
		["172"] = 145,
		["173"] = 146,
		["174"] = 147,
		["176"] = 143,
		["177"] = 143,
		["178"] = 133,
		["179"] = 151,
		["180"] = 152,
		["181"] = 153,
		["182"] = 154,
		["183"] = 155,
		["184"] = 156,
		["185"] = 157,
		["186"] = 158,
		["187"] = 160,
		["188"] = 161,
		["189"] = 162,
		["190"] = 164,
		["191"] = 165,
		["192"] = 166,
		["193"] = 167,
		["194"] = 169,
		["195"] = 170,
		["196"] = 171,
		["197"] = 171,
		["198"] = 171,
		["199"] = 171,
		["200"] = 171,
		["201"] = 176,
		["202"] = 176,
		["203"] = 176,
		["204"] = 176,
		["205"] = 171,
		["206"] = 177,
		["207"] = 178,
		["208"] = 179,
		["209"] = 180,
		["210"] = 180,
		["211"] = 180,
		["212"] = 180,
		["213"] = 180,
		["214"] = 180,
		["215"] = 180,
		["216"] = 181,
		["217"] = 183,
		["218"] = 184,
		["220"] = 187,
		["221"] = 188,
		["222"] = 188,
		["223"] = 188,
		["224"] = 188,
		["225"] = 188,
		["226"] = 188,
		["227"] = 188,
		["229"] = 191,
		["230"] = 192,
		["231"] = 192,
		["232"] = 192,
		["233"] = 192,
		["234"] = 192,
		["235"] = 192,
		["236"] = 192,
		["238"] = 194,
		["239"] = 171,
		["240"] = 171,
		["241"] = 197,
		["242"] = 151,
		["243"] = 131,
		["244"] = 130,
		["245"] = 131,
		["247"] = 131,
		["249"] = 206,
		["250"] = 207,
		["251"] = 206,
		["252"] = 207,
		["253"] = 208,
		["254"] = 209,
		["255"] = 208,
		["256"] = 207,
		["257"] = 206,
		["258"] = 207,
		["260"] = 207,
		["261"] = 212,
		["262"] = 220,
		["263"] = 212,
		["264"] = 220,
		["265"] = 224,
		["266"] = 225,
		["267"] = 226,
		["268"] = 227,
		["269"] = 224,
		["270"] = 229,
		["271"] = 230,
		["272"] = 231,
		["273"] = 231,
		["274"] = 230,
		["275"] = 229,
		["276"] = 234,
		["277"] = 235,
		["278"] = 236,
		["279"] = 237,
		["280"] = 238,
		["281"] = 239,
		["282"] = 239,
		["284"] = 240,
		["285"] = 241,
		["286"] = 242,
		["287"] = 243,
		["288"] = 244,
		["289"] = 244,
		["290"] = 244,
		["291"] = 244,
		["292"] = 244,
		["293"] = 244,
		["294"] = 244,
		["295"] = 244,
		["296"] = 244,
		["297"] = 245,
		["298"] = 245,
		["299"] = 245,
		["300"] = 245,
		["301"] = 245,
		["302"] = 245,
		["303"] = 245,
		["304"] = 245,
		["305"] = 245,
		["306"] = 246,
		["307"] = 247,
		["308"] = 248,
		["309"] = 249,
		["310"] = 250,
		["311"] = 250,
		["312"] = 250,
		["313"] = 250,
		["314"] = 251,
		["315"] = 251,
		["318"] = 234,
		["319"] = 259,
		["320"] = 260,
		["321"] = 261,
		["322"] = 262,
		["323"] = 263,
		["324"] = 264,
		["325"] = 265,
		["326"] = 265,
		["327"] = 265,
		["328"] = 265,
		["329"] = 265,
		["330"] = 265,
		["331"] = 266,
		["334"] = 269,
		["335"] = 270,
		["337"] = 259,
		["338"] = 220,
		["339"] = 212,
		["340"] = 212,
		["341"] = 212,
		["342"] = 212,
		["343"] = 212,
		["344"] = 212,
		["345"] = 212,
		["346"] = 212,
		["347"] = 220,
		["349"] = 220,
		["351"] = 276,
		["352"] = 277,
		["353"] = 276,
		["354"] = 277,
		["355"] = 278,
		["356"] = 279,
		["357"] = 278,
		["358"] = 277,
		["359"] = 276,
		["360"] = 277,
		["362"] = 277,
		["363"] = 282,
		["364"] = 290,
		["365"] = 282,
		["366"] = 290,
		["367"] = 292,
		["368"] = 293,
		["369"] = 292,
		["370"] = 295,
		["371"] = 296,
		["372"] = 295,
		["373"] = 300,
		["374"] = 301,
		["375"] = 300,
		["376"] = 305,
		["377"] = 307,
		["378"] = 308,
		["379"] = 309,
		["380"] = 310,
		["381"] = 312,
		["382"] = 313,
		["383"] = 313,
		["384"] = 313,
		["385"] = 314,
		["386"] = 315,
		["387"] = 316,
		["389"] = 313,
		["390"] = 313,
		["391"] = 319,
		["392"] = 319,
		["393"] = 319,
		["394"] = 320,
		["395"] = 321,
		["396"] = 322,
		["398"] = 319,
		["399"] = 319,
		["400"] = 326,
		["401"] = 305,
		["402"] = 328,
		["403"] = 329,
		["404"] = 328,
		["405"] = 290,
		["406"] = 282,
		["407"] = 282,
		["408"] = 282,
		["409"] = 282,
		["410"] = 282,
		["411"] = 282,
		["412"] = 282,
		["413"] = 282,
		["414"] = 290,
		["416"] = 290,
		["418"] = 335,
		["419"] = 336,
		["420"] = 335,
		["421"] = 336,
		["422"] = 337,
		["423"] = 338,
		["424"] = 337,
		["425"] = 336,
		["426"] = 335,
		["427"] = 336,
		["429"] = 336,
		["430"] = 341,
		["431"] = 349,
		["432"] = 341,
		["433"] = 349,
		["434"] = 351,
		["435"] = 352,
		["436"] = 351,
		["437"] = 354,
		["438"] = 355,
		["439"] = 356,
		["440"] = 356,
		["441"] = 355,
		["442"] = 354,
		["443"] = 359,
		["444"] = 360,
		["445"] = 361,
		["447"] = 361,
		["450"] = 359,
		["451"] = 349,
		["452"] = 341,
		["453"] = 341,
		["454"] = 341,
		["455"] = 341,
		["456"] = 341,
		["457"] = 341,
		["458"] = 341,
		["459"] = 341,
		["460"] = 349,
		["462"] = 349,
		["464"] = 367,
		["465"] = 368,
		["466"] = 367,
		["467"] = 368,
		["468"] = 369,
		["469"] = 370,
		["470"] = 369,
		["471"] = 368,
		["472"] = 367,
		["473"] = 368,
		["475"] = 368,
		["476"] = 373,
		["477"] = 381,
		["478"] = 373,
		["479"] = 381,
		["480"] = 385,
		["481"] = 386,
		["482"] = 387,
		["483"] = 385,
		["484"] = 389,
		["485"] = 390,
		["486"] = 389,
		["487"] = 394,
		["488"] = 395,
		["489"] = 394,
		["490"] = 398,
		["491"] = 399,
		["492"] = 400,
		["493"] = 401,
		["494"] = 402,
		["495"] = 403,
		["496"] = 404,
		["497"] = 406,
		["498"] = 406,
		["499"] = 406,
		["500"] = 406,
		["501"] = 407,
		["502"] = 408,
		["503"] = 409,
		["504"] = 410,
		["507"] = 413,
		["509"] = 414,
		["510"] = 414,
		["511"] = 415,
		["512"] = 414,
		["515"] = 417,
		["518"] = 420,
		["519"] = 398,
		["520"] = 422,
		["521"] = 423,
		["522"] = 424,
		["523"] = 425,
		["525"] = 422,
		["526"] = 428,
		["527"] = 429,
		["528"] = 428,
		["529"] = 433,
		["530"] = 434,
		["531"] = 435,
		["533"] = 433,
		["534"] = 381,
		["535"] = 373,
		["536"] = 373,
		["537"] = 373,
		["538"] = 373,
		["539"] = 373,
		["540"] = 373,
		["541"] = 373,
		["542"] = 373,
		["543"] = 381,
		["545"] = 381,
	}
)
local k = {}
local l = require("lib.dota_ts_adapter")
local m = l.BaseAbility
local n = l.registerAbility
local o = require("modifiers.eom_modifier")
local p = o.EOMModifier
local q = o.registerEOMModifier
local r = require("abilities.ability_ai")
local s = r.BaseAbilityAI
local t = r.registerAbilityAI
k.tinker_talent = c()
local u = k.tinker_talent
u.name = "tinker_talent"
d(u, m)
function u.prototype.GetIntrinsicModifierName(self)
	return "modifier_tinker_talent"
end
u = e({ n(nil) }, u)
k.tinker_talent = u
k.modifier_tinker_talent = c()
local v = k.modifier_tinker_talent
v.name = "modifier_tinker_talent"
d(v, p)
function v.prototype.____constructor(self, ...)
	p.prototype.____constructor(self, ...)
	self.g_n_card_count = 0
end
function v.prototype.GetAbilitySpecialValue(self)
	self.factor = self:GetAbilitySpecialValueFor("factor") + self:GetAbilityTalentValue("tinker_talent_1", "factor")
	self.s_bonus = self:GetAbilityTalentValue("tinker_shard", "bonus")
	local w = IsServer() and PlayerData:getTraitAbility(self:GetParent():GetPlayerOwnerID()) or nil
	self.g_skill_damage_bonus = (w and w:GetAbilityName()) == "trait_199" and w:GetSpecialValueFor("skill_damage_bonus")
		or 0
end
function v.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_CONSTANT }
end
function v.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TALENT_LEARN] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
	}
end
function v.prototype.OnBattleStartBefore(self, x)
	local y = 0
	local z = self:GetParent():GetHeroBase()
	local A = z:getAbilityUpgradeData(true)
	if self.s_bonus > 0 then
		local B = z:getTempAbilityUpgrade()
		local C = KeyValues.AbilityUpgradesKvs
		local D = {}
		h(g(A), function(E, F)
			local G = C[F] or {}
			if G.rarity == "sr" and not f(D, F) then
				D[#D + 1] = F
			end
		end)
		h(g(B), function(E, F)
			local G = C[F] or {}
			if G.rarity == "sr" and not f(D, F) then
				D[#D + 1] = F
			end
		end)
		y = #D * self.s_bonus
	end
	y = y + #g(z:getAbilityUpgradeData(true, true)) * self.factor
	self:SetStackCount(y)
end
function v.prototype.OnBattleStart(self, x)
	local z = self:GetParent():GetHeroBase()
	local A = z:getAbilityUpgradeData(true)
	local B = z:getTempAbilityUpgrade()
	local C = KeyValues.AbilityUpgradesKvs
	local H = {}
	h(g(A), function(E, F)
		local G = C[F] or {}
		if G.rarity == "n" and not f(H, F) then
			H[#H + 1] = F
		end
	end)
	h(g(B), function(E, F)
		local G = C[F] or {}
		if G.rarity == "n" and not f(H, F) then
			H[#H + 1] = F
		end
	end)
	self.g_n_card_count = #H
end
function v.prototype.OnTalentLearn(self, x)
	if x.talentName == "tinker_talent_8" then
		local I = self:GetParent():GetHeroBase()
		h(AbilityShop.pickList, function(E, J)
			I:addSectExp(J, 0)
		end)
	end
end
function v.prototype.EOM_GetModifierOutgoingDamageConstant(self, x)
	local K = 0
	if self.g_skill_damage_bonus > 0 then
		if x.ability_upgrade and KeyValues.AbilityUpgradesKvs[x.ability_upgrade].rarity == "sr" then
			K = K + self.g_skill_damage_bonus * self.g_n_card_count
		end
	end
	if x.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL then
		K = K + self:GetStackCount()
	end
	return K
end
v = e(
	{
		q(
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
	v
)
k.modifier_tinker_talent = v
k.tinker_ult = c()
local L = k.tinker_ult
L.name = "tinker_ult"
d(L, s)
function L.prototype.OnSpellStart(self)
	local M = self:GetCaster()
	local N = M:GetEnemy()
	local O = self:GetSpecialValueFor("damage")
	local P = self:GetSpecialValueFor("count") + self:GetTalentValue("tinker_talent_3", "missile_count")
	local Q = self:GetSpecialValueFor("interval")
	M:AddActivityModifier("activity_ult")
	M:StartGestureWithPlaybackRate(ACT_DOTA_TELEPORT_END, 0.4)
	M:RemoveActivityModifier("activity_ult")
	local R = 0
	self:GameTimer(0, function()
		if R < P then
			R = R + 1
			self:Launch(N)
			return Q
		end
	end)
end
function L.prototype.Launch(self, N)
	local M = self:GetCaster()
	local S = M:GetAttachmentPosition("attach_ambient")
	local O = self:GetSpecialValueFor("damage")
	local T = self:GetSpecialValueFor("level_factor")
	local U = self:GetTalentValue("tinker_talent_2", "chance")
	local V = self:GetTalentValue("tinker_talent_2", "mana_regen")
	local W = self:GetTalentValue("tinker_talent_7", "missile_damage")
	local X = self:GetTalentValue("tinker_talent_9", "damage_per_stack")
	local Y = self:GetTalentValue("tinker_talent_9", "max_stack")
	self.tinker_talent_9_record = self.tinker_talent_9_record or 0
	local Z = self:GetTalentValue("tinker_talent_11", "chance")
	local _ = self:GetTalentValue("tinker_talent_11", "injury")
	local a0 = self:GetTalentValue("tinker_talent_12", "chance")
	local a1 = self:GetTalentValue("tinker_talent_12", "damage_pct")
	local a2 = PlayerData:getHero(M:GetPlayerOwnerID())
	local a3 = a2 ~= nil and a2:getLevel() or 1
	Projectile:CreateTrackingProjectile({
		EffectName = "particles/units/heroes/hero_tinker/tinker_missile.vpcf",
		hCaster = M,
		hTarget = N,
		iMoveSpeed = 600,
		vSpawnOrigin = S + Vector(RandomInt(-150, 150), RandomInt(-150, 150), 0),
		OnProjectileHit = function(N, a4, a5)
			local a6 = O + a3 * T + W + math.min(Y, self.tinker_talent_9_record) * X
			local a7 = self:HasTalent("tinker_talent_10") and DamageFlags.DAMAGE_FLAG_NO_EVASION
				or DamageFlags.DAMAGE_FLAG_NONE
			M:DealDamage(N, self, a6, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL, a7)
			EmitSoundOnLocationWithCaster(a4, "Hero_Tinker.Heat-Seeking_Missile.Impact", M)
			if U > 0 and self:PRD(U, "talent_2_chance") then
				Restore(M, V, true)
			end
			if Z > 0 and self:PRD(Z, "talent_11_chance") then
				AddInjury(M, N, _, "tinker_talent_11", "Ability")
			end
			if a0 > 0 and self:PRD(a0, "talent_12_chance") then
				M:DealDamage(N, self, a6 * a1 * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL, a7)
			end
			self.tinker_talent_9_record = self.tinker_talent_9_record + 1
		end,
	})
	M:EmitSound("Hero_Tinker.Heat-Seeking_Missile")
end
L = e({ t(nil) }, L)
k.tinker_ult = L
k.tinker_talent_4 = c()
local a8 = k.tinker_talent_4
a8.name = "tinker_talent_4"
d(a8, m)
function a8.prototype.GetIntrinsicModifierName(self)
	return "modifier_tinker_talent_4"
end
a8 = e({ n(nil) }, a8)
k.tinker_talent_4 = a8
k.modifier_tinker_talent_4 = c()
local a9 = k.modifier_tinker_talent_4
a9.name = "modifier_tinker_talent_4"
d(a9, p)
function a9.prototype.GetAbilitySpecialValue(self)
	self.stack = self:GetAbilitySpecialValueFor("stack")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.timer = {}
end
function a9.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function a9.prototype.OnCustomTakeDamage(self, aa)
	if self.stack > 0 and aa.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL then
		self:IncrementStackCount()
		if self:GetStackCount() >= self.stack then
			self:SetStackCount(0)
			if #self.timer == 0 then
				self:StartIntervalThink(0)
			end
			local ab = self:GetParent()
			local ac = GameRules:GetGameTime()
			local ad = 0.15
			local ae = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_tinker/tinker_laser.vpcf",
				PATTACH_CUSTOMORIGIN,
				ab
			)
			ParticleManager:SetParticleControlEnt(
				ae,
				9,
				ab,
				PATTACH_POINT_FOLLOW,
				"attach_attack2",
				vec3_invalid,
				false
			)
			ParticleManager:SetParticleControlEnt(
				ae,
				1,
				aa.target,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				vec3_invalid,
				false
			)
			ParticleManager:ReleaseParticleIndex(ae)
			EmitSoundOn("Hero_Tinker.Laser", ab)
			EmitSoundOn("Hero_Tinker.LaserImpact", aa.target)
			ab:ForcePlayActivityOnce(ACT_DOTA_CAST_ABILITY_1)
			ab:StartGestureWithPlaybackRate(
				ACT_DOTA_CAST_ABILITY_1,
				ab:GetAttackSpeed(false) * ab:GetBaseAttackTime(false) * 1.25
			)
			local af = self.timer
			af[#af + 1] = { flExpireTime = ac + ad, hTarget = aa.target, flDamage = self.damage }
		end
	end
end
function a9.prototype.OnIntervalThink(self)
	local ab = self:GetParent()
	local ac = GameRules:GetGameTime()
	for ag = #self.timer, 1, -1 do
		local ah = self.timer[ag]
		if ac >= ah.flExpireTime then
			ab:DealDamage(ah.hTarget, self:GetAbility(), ah.flDamage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			table.remove(self.timer, ag)
		end
	end
	if #self.timer == 0 then
		self:StartIntervalThink(-1)
	end
end
a9 = e(
	{
		q(
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
	a9
)
k.modifier_tinker_talent_4 = a9
k.tinker_talent_5 = c()
local ai = k.tinker_talent_5
ai.name = "tinker_talent_5"
d(ai, m)
function ai.prototype.GetIntrinsicModifierName(self)
	return "modifier_tinker_talent_5"
end
ai = e({ n(nil) }, ai)
k.tinker_talent_5 = ai
k.modifier_tinker_talent_5 = c()
local aj = k.modifier_tinker_talent_5
aj.name = "modifier_tinker_talent_5"
d(aj, p)
function aj.prototype.GetAbilitySpecialValue(self)
	self.damage_bonus = self:GetAbilitySpecialValueFor("damage_bonus")
end
function aj.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function aj.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function aj.prototype.OnBattleStartBefore(self, x)
	local z = self:GetParent():GetHeroBase()
	local A = z:getAbilityUpgradeData(true)
	local B = z:getTempAbilityUpgrade()
	local C = KeyValues.AbilityUpgradesKvs
	local D = {}
	h(g(A), function(E, F)
		local G = C[F] or {}
		if G.rarity == "sr" and not f(D, F) then
			D[#D + 1] = F
		end
	end)
	h(g(B), function(E, F)
		local G = C[F] or {}
		if G.rarity == "sr" and not f(D, F) then
			D[#D + 1] = F
		end
	end)
	self:SetStackCount(#D)
end
function aj.prototype.EOM_GetModifierOutgoingDamagePercentage(self)
	return self.damage_bonus * self:GetStackCount()
end
aj = e(
	{
		q(
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
k.modifier_tinker_talent_5 = aj
k.tinker_talent_6 = c()
local ak = k.tinker_talent_6
ak.name = "tinker_talent_6"
d(ak, m)
function ak.prototype.GetIntrinsicModifierName(self)
	return "modifier_tinker_talent_6"
end
ak = e({ n(nil) }, ak)
k.tinker_talent_6 = ak
k.modifier_tinker_talent_6 = c()
local al = k.modifier_tinker_talent_6
al.name = "modifier_tinker_talent_6"
d(al, p)
function al.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
end
function al.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function al.prototype.OnCustomTakeDamage(self, aa)
	if self.chance > 0 and aa.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL and self:PRD(self.chance) then
		local am = self:GetParent():FindAbilityByName("tinker_ult")
		if am ~= nil then
			am:Launch(aa.target)
		end
	end
end
al = e(
	{
		q(
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
	al
)
k.modifier_tinker_talent_6 = al
k.tinker_talent_8 = c()
local an = k.tinker_talent_8
an.name = "tinker_talent_8"
d(an, m)
function an.prototype.GetIntrinsicModifierName(self)
	return "modifier_tinker_talent_8"
end
an = e({ n(nil) }, an)
k.tinker_talent_8 = an
k.modifier_tinker_talent_8 = c()
local ao = k.modifier_tinker_talent_8
ao.name = "modifier_tinker_talent_8"
d(ao, p)
function ao.prototype.GetAbilitySpecialValue(self)
	self.exp_reduce = self:GetAbilitySpecialValueFor("exp_reduce")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function ao.prototype.AddCustomTransmitterData(self)
	return { tl8_list = self.tl8_list }
end
function ao.prototype.HandleCustomTransmitterData(self, ap)
	self.tl8_list = ap.tl8_list
end
function ao.prototype.loadDataTl8(self)
	local aq = self:GetParent():GetPlayerOwnerID()
	local ar = PlayerData:loadData(aq, "tinker_talent_8")
	local as = PlayerData:getplayerData(aq)
	if as then
		if ar == nil then
			local at = {}
			local au = as.bannedSect and i(AbilityShop.pickList, function(E, av)
				return av ~= as.bannedSect
			end) or AbilityShop.pickList
			while #at < self.count do
				local aw = au[RandomInt(0, #au - 1) + 1]
				if not f(at, aw) then
					at[#at + 1] = aw
				end
			end
			ar = {}
			do
				local ag = 0
				while ag < #at do
					ar[at[ag + 1]] = true
					ag = ag + 1
				end
			end
			PlayerData:saveData(aq, "tinker_talent_8", ar)
		end
	end
	self.tl8_list = ar
end
function ao.prototype.OnCreated(self, x)
	if IsServer() then
		self:loadDataTl8()
		self:SetHasCustomTransmitterData(true)
	end
end
function ao.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_SECT_EXP_REDUCE }
end
function ao.prototype.EOM_GetModifierSectExpReduce(self, x)
	if x and x.sect and self.tl8_list ~= nil and self.tl8_list[x.sect] then
		return self.exp_reduce
	end
end
ao = e(
	{
		q(
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
	ao
)
k.modifier_tinker_talent_8 = ao
return k