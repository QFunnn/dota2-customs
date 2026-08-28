--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		["44"] = 33,
		["45"] = 27,
		["46"] = 35,
		["47"] = 36,
		["48"] = 35,
		["49"] = 40,
		["50"] = 41,
		["51"] = 41,
		["52"] = 41,
		["53"] = 41,
		["54"] = 45,
		["55"] = 45,
		["56"] = 45,
		["57"] = 41,
		["58"] = 41,
		["59"] = 40,
		["60"] = 49,
		["61"] = 50,
		["62"] = 51,
		["63"] = 52,
		["64"] = 53,
		["65"] = 55,
		["66"] = 56,
		["67"] = 58,
		["68"] = 59,
		["69"] = 59,
		["70"] = 59,
		["71"] = 60,
		["72"] = 61,
		["73"] = 62,
		["75"] = 59,
		["76"] = 59,
		["77"] = 65,
		["78"] = 65,
		["79"] = 65,
		["80"] = 66,
		["81"] = 67,
		["82"] = 68,
		["84"] = 65,
		["85"] = 65,
		["86"] = 71,
		["88"] = 73,
		["89"] = 74,
		["90"] = 49,
		["91"] = 87,
		["92"] = 88,
		["93"] = 89,
		["94"] = 90,
		["95"] = 91,
		["96"] = 92,
		["97"] = 93,
		["98"] = 93,
		["99"] = 93,
		["100"] = 94,
		["101"] = 95,
		["102"] = 96,
		["104"] = 93,
		["105"] = 93,
		["106"] = 99,
		["107"] = 99,
		["108"] = 99,
		["109"] = 100,
		["110"] = 101,
		["111"] = 102,
		["113"] = 99,
		["114"] = 99,
		["115"] = 105,
		["116"] = 87,
		["117"] = 107,
		["118"] = 108,
		["119"] = 109,
		["120"] = 110,
		["121"] = 110,
		["122"] = 110,
		["123"] = 111,
		["124"] = 110,
		["125"] = 110,
		["127"] = 107,
		["128"] = 115,
		["129"] = 116,
		["130"] = 117,
		["131"] = 118,
		["132"] = 119,
		["135"] = 122,
		["136"] = 123,
		["138"] = 125,
		["139"] = 115,
		["140"] = 20,
		["141"] = 12,
		["142"] = 12,
		["143"] = 12,
		["144"] = 12,
		["145"] = 12,
		["146"] = 12,
		["147"] = 12,
		["148"] = 12,
		["149"] = 20,
		["151"] = 20,
		["153"] = 130,
		["154"] = 131,
		["155"] = 130,
		["156"] = 131,
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
		["167"] = 143,
		["168"] = 143,
		["169"] = 143,
		["170"] = 144,
		["171"] = 145,
		["172"] = 146,
		["173"] = 147,
		["175"] = 143,
		["176"] = 143,
		["177"] = 133,
		["178"] = 151,
		["179"] = 152,
		["180"] = 153,
		["181"] = 154,
		["182"] = 155,
		["183"] = 156,
		["184"] = 157,
		["185"] = 158,
		["186"] = 160,
		["187"] = 161,
		["188"] = 162,
		["189"] = 164,
		["190"] = 165,
		["191"] = 166,
		["192"] = 167,
		["193"] = 169,
		["194"] = 170,
		["195"] = 171,
		["196"] = 171,
		["197"] = 171,
		["198"] = 171,
		["199"] = 171,
		["200"] = 176,
		["201"] = 176,
		["202"] = 176,
		["203"] = 176,
		["204"] = 171,
		["205"] = 177,
		["206"] = 178,
		["207"] = 179,
		["208"] = 180,
		["209"] = 180,
		["210"] = 180,
		["211"] = 180,
		["212"] = 180,
		["213"] = 180,
		["214"] = 180,
		["215"] = 181,
		["216"] = 183,
		["217"] = 184,
		["219"] = 187,
		["220"] = 188,
		["221"] = 188,
		["222"] = 188,
		["223"] = 188,
		["224"] = 188,
		["225"] = 188,
		["226"] = 188,
		["228"] = 191,
		["229"] = 192,
		["230"] = 192,
		["231"] = 192,
		["232"] = 192,
		["233"] = 192,
		["234"] = 192,
		["235"] = 192,
		["237"] = 194,
		["238"] = 171,
		["239"] = 171,
		["240"] = 197,
		["241"] = 151,
		["242"] = 131,
		["243"] = 130,
		["244"] = 131,
		["246"] = 131,
		["248"] = 206,
		["249"] = 207,
		["250"] = 206,
		["251"] = 207,
		["252"] = 208,
		["253"] = 209,
		["254"] = 208,
		["255"] = 207,
		["256"] = 206,
		["257"] = 207,
		["259"] = 207,
		["260"] = 212,
		["261"] = 220,
		["262"] = 212,
		["263"] = 220,
		["264"] = 224,
		["265"] = 225,
		["266"] = 226,
		["267"] = 227,
		["268"] = 224,
		["269"] = 229,
		["270"] = 230,
		["271"] = 231,
		["272"] = 231,
		["273"] = 230,
		["274"] = 229,
		["275"] = 234,
		["276"] = 235,
		["277"] = 236,
		["278"] = 237,
		["279"] = 238,
		["280"] = 239,
		["281"] = 239,
		["283"] = 240,
		["284"] = 241,
		["285"] = 242,
		["286"] = 243,
		["287"] = 244,
		["288"] = 244,
		["289"] = 244,
		["290"] = 244,
		["291"] = 244,
		["292"] = 244,
		["293"] = 244,
		["294"] = 244,
		["295"] = 244,
		["296"] = 245,
		["297"] = 245,
		["298"] = 245,
		["299"] = 245,
		["300"] = 245,
		["301"] = 245,
		["302"] = 245,
		["303"] = 245,
		["304"] = 245,
		["305"] = 246,
		["306"] = 247,
		["307"] = 248,
		["308"] = 249,
		["309"] = 250,
		["310"] = 250,
		["311"] = 250,
		["312"] = 250,
		["313"] = 251,
		["314"] = 251,
		["317"] = 234,
		["318"] = 259,
		["319"] = 260,
		["320"] = 261,
		["321"] = 262,
		["322"] = 263,
		["323"] = 264,
		["324"] = 265,
		["325"] = 265,
		["326"] = 265,
		["327"] = 265,
		["328"] = 265,
		["329"] = 265,
		["330"] = 266,
		["333"] = 269,
		["334"] = 270,
		["336"] = 259,
		["337"] = 220,
		["338"] = 212,
		["339"] = 212,
		["340"] = 212,
		["341"] = 212,
		["342"] = 212,
		["343"] = 212,
		["344"] = 212,
		["345"] = 212,
		["346"] = 220,
		["348"] = 220,
		["350"] = 276,
		["351"] = 277,
		["352"] = 276,
		["353"] = 277,
		["354"] = 278,
		["355"] = 279,
		["356"] = 278,
		["357"] = 277,
		["358"] = 276,
		["359"] = 277,
		["361"] = 277,
		["362"] = 282,
		["363"] = 290,
		["364"] = 282,
		["365"] = 290,
		["366"] = 292,
		["367"] = 293,
		["368"] = 292,
		["369"] = 295,
		["370"] = 296,
		["371"] = 295,
		["372"] = 300,
		["373"] = 301,
		["374"] = 300,
		["375"] = 305,
		["376"] = 307,
		["377"] = 308,
		["378"] = 309,
		["379"] = 310,
		["380"] = 312,
		["381"] = 313,
		["382"] = 313,
		["383"] = 313,
		["384"] = 314,
		["385"] = 315,
		["386"] = 316,
		["388"] = 313,
		["389"] = 313,
		["390"] = 319,
		["391"] = 319,
		["392"] = 319,
		["393"] = 320,
		["394"] = 321,
		["395"] = 322,
		["397"] = 319,
		["398"] = 319,
		["399"] = 326,
		["400"] = 305,
		["401"] = 328,
		["402"] = 329,
		["403"] = 328,
		["404"] = 290,
		["405"] = 282,
		["406"] = 282,
		["407"] = 282,
		["408"] = 282,
		["409"] = 282,
		["410"] = 282,
		["411"] = 282,
		["412"] = 282,
		["413"] = 290,
		["415"] = 290,
		["417"] = 335,
		["418"] = 336,
		["419"] = 335,
		["420"] = 336,
		["421"] = 337,
		["422"] = 338,
		["423"] = 337,
		["424"] = 336,
		["425"] = 335,
		["426"] = 336,
		["428"] = 336,
		["429"] = 341,
		["430"] = 349,
		["431"] = 341,
		["432"] = 349,
		["433"] = 351,
		["434"] = 352,
		["435"] = 351,
		["436"] = 354,
		["437"] = 355,
		["438"] = 356,
		["439"] = 356,
		["440"] = 355,
		["441"] = 354,
		["442"] = 359,
		["443"] = 360,
		["444"] = 361,
		["446"] = 361,
		["449"] = 359,
		["450"] = 349,
		["451"] = 341,
		["452"] = 341,
		["453"] = 341,
		["454"] = 341,
		["455"] = 341,
		["456"] = 341,
		["457"] = 341,
		["458"] = 341,
		["459"] = 349,
		["461"] = 349,
		["463"] = 367,
		["464"] = 368,
		["465"] = 367,
		["466"] = 368,
		["467"] = 369,
		["468"] = 370,
		["469"] = 369,
		["470"] = 368,
		["471"] = 367,
		["472"] = 368,
		["474"] = 368,
		["475"] = 373,
		["476"] = 381,
		["477"] = 373,
		["478"] = 381,
		["479"] = 385,
		["480"] = 386,
		["481"] = 387,
		["482"] = 385,
		["483"] = 389,
		["484"] = 390,
		["485"] = 389,
		["486"] = 394,
		["487"] = 395,
		["488"] = 394,
		["489"] = 398,
		["490"] = 399,
		["491"] = 400,
		["492"] = 401,
		["493"] = 402,
		["494"] = 403,
		["495"] = 404,
		["496"] = 405,
		["497"] = 406,
		["498"] = 407,
		["500"] = 409,
		["501"] = 410,
		["502"] = 411,
		["503"] = 412,
		["506"] = 415,
		["508"] = 416,
		["509"] = 416,
		["510"] = 417,
		["511"] = 416,
		["514"] = 419,
		["517"] = 422,
		["518"] = 398,
		["519"] = 424,
		["520"] = 425,
		["521"] = 426,
		["522"] = 427,
		["524"] = 424,
		["525"] = 430,
		["526"] = 431,
		["527"] = 430,
		["528"] = 435,
		["529"] = 436,
		["530"] = 437,
		["532"] = 435,
		["533"] = 381,
		["534"] = 373,
		["535"] = 373,
		["536"] = 373,
		["537"] = 373,
		["538"] = 373,
		["539"] = 373,
		["540"] = 373,
		["541"] = 373,
		["542"] = 381,
		["544"] = 381,
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
	local v = IsServer() and PlayerData:getTraitAbility(self:GetParent():GetPlayerOwnerID()) or nil
	self.g_skill_damage_bonus = (v and v:GetAbilityName()) == "trait_199" and v:GetSpecialValueFor("skill_damage_bonus")
		or 0
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
function u.prototype.OnBattleStartBefore(self, w)
	local x = 0
	local y = self:GetParent():GetHeroBase()
	local z = y:getAbilityUpgradeData(true)
	if self.s_bonus > 0 then
		local A = y:getTempAbilityUpgrade()
		local B = KeyValues.AbilityUpgradesKvs
		local C = {}
		h(g(z), function(D, E)
			local F = B[E] or {}
			if F.rarity == "sr" and not f(C, E) then
				C[#C + 1] = E
			end
		end)
		h(g(A), function(D, E)
			local F = B[E] or {}
			if F.rarity == "sr" and not f(C, E) then
				C[#C + 1] = E
			end
		end)
		x = #C * self.s_bonus
	end
	x = x + #g(y:getAbilityUpgradeData(true, true)) * self.factor
	self:SetStackCount(x)
end
function u.prototype.OnBattleStart(self, w)
	local y = self:GetParent():GetHeroBase()
	local z = y:getAbilityUpgradeData(true)
	local A = y:getTempAbilityUpgrade()
	local B = KeyValues.AbilityUpgradesKvs
	local G = {}
	h(g(z), function(D, E)
		local F = B[E] or {}
		if F.rarity == "n" and not f(G, E) then
			G[#G + 1] = E
		end
	end)
	h(g(A), function(D, E)
		local F = B[E] or {}
		if F.rarity == "n" and not f(G, E) then
			G[#G + 1] = E
		end
	end)
	self.g_n_card_count = #G
end
function u.prototype.OnTalentLearn(self, w)
	if w.talentName == "tinker_talent_8" then
		local H = self:GetParent():GetHeroBase()
		h(AbilityShop.pickList, function(D, I)
			H:addSectExp(I, 0)
		end)
	end
end
function u.prototype.EOM_GetModifierOutgoingDamageConstant(self, w)
	local J = 0
	if self.g_skill_damage_bonus > 0 then
		if w.ability_upgrade and KeyValues.AbilityUpgradesKvs[w.ability_upgrade].rarity == "sr" then
			J = J + self.g_skill_damage_bonus * self.g_n_card_count
		end
	end
	if w.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL then
		J = J + self:GetStackCount()
	end
	return J
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
local K = j.tinker_ult
K.name = "tinker_ult"
d(K, r)
function K.prototype.OnSpellStart(self)
	local L = self:GetCaster()
	local M = L:GetEnemy()
	local N = self:GetSpecialValueFor("damage")
	local O = self:GetSpecialValueFor("count") + self:GetTalentValue("tinker_talent_3", "missile_count")
	local P = self:GetSpecialValueFor("interval")
	L:AddActivityModifier("activity_ult")
	L:StartGestureWithPlaybackRate(ACT_DOTA_TELEPORT_END, 0.4)
	L:RemoveActivityModifier("activity_ult")
	local Q = 0
	self:GameTimer(0, function()
		if Q < O then
			Q = Q + 1
			self:Launch(M)
			return P
		end
	end)
end
function K.prototype.Launch(self, M)
	local L = self:GetCaster()
	local R = L:GetAttachmentPosition("attach_ambient")
	local N = self:GetSpecialValueFor("damage")
	local S = self:GetSpecialValueFor("level_factor")
	local T = self:GetTalentValue("tinker_talent_2", "chance")
	local U = self:GetTalentValue("tinker_talent_2", "mana_regen")
	local V = self:GetTalentValue("tinker_talent_7", "missile_damage")
	local W = self:GetTalentValue("tinker_talent_9", "damage_per_stack")
	local X = self:GetTalentValue("tinker_talent_9", "max_stack")
	self.tinker_talent_9_record = self.tinker_talent_9_record or 0
	local Y = self:GetTalentValue("tinker_talent_11", "chance")
	local Z = self:GetTalentValue("tinker_talent_11", "injury")
	local _ = self:GetTalentValue("tinker_talent_12", "chance")
	local a0 = self:GetTalentValue("tinker_talent_12", "damage_pct")
	local a1 = PlayerData:getHero(L:GetPlayerOwnerID())
	local a2 = a1 ~= nil and a1:getLevel() or 1
	Projectile:CreateTrackingProjectile({
		EffectName = "particles/units/heroes/hero_tinker/tinker_missile.vpcf",
		hCaster = L,
		hTarget = M,
		iMoveSpeed = 600,
		vSpawnOrigin = R + Vector(RandomInt(-150, 150), RandomInt(-150, 150), 0),
		OnProjectileHit = function(M, a3, a4)
			local a5 = N + a2 * S + V + math.min(X, self.tinker_talent_9_record) * W
			local a6 = self:HasTalent("tinker_talent_10") and DamageFlags.DAMAGE_FLAG_NO_EVASION
				or DamageFlags.DAMAGE_FLAG_NONE
			L:DealDamage(M, self, a5, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL, a6)
			EmitSoundOnLocationWithCaster(a3, "Hero_Tinker.Heat-Seeking_Missile.Impact", L)
			if T > 0 and self:PRD(T, "talent_2_chance") then
				Restore(L, U, true)
			end
			if Y > 0 and self:PRD(Y, "talent_11_chance") then
				AddInjury(L, M, Z, "tinker_talent_11", "Ability")
			end
			if _ > 0 and self:PRD(_, "talent_12_chance") then
				L:DealDamage(M, self, a5 * a0 * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL, a6)
			end
			self.tinker_talent_9_record = self.tinker_talent_9_record + 1
		end,
	})
	L:EmitSound("Hero_Tinker.Heat-Seeking_Missile")
end
K = e({ s(nil) }, K)
j.tinker_ult = K
j.tinker_talent_4 = c()
local a7 = j.tinker_talent_4
a7.name = "tinker_talent_4"
d(a7, l)
function a7.prototype.GetIntrinsicModifierName(self)
	return "modifier_tinker_talent_4"
end
a7 = e({ m(nil) }, a7)
j.tinker_talent_4 = a7
j.modifier_tinker_talent_4 = c()
local a8 = j.modifier_tinker_talent_4
a8.name = "modifier_tinker_talent_4"
d(a8, o)
function a8.prototype.GetAbilitySpecialValue(self)
	self.stack = self:GetAbilitySpecialValueFor("stack")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.timer = {}
end
function a8.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function a8.prototype.OnCustomTakeDamage(self, a9)
	if self.stack > 0 and a9.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL then
		self:IncrementStackCount()
		if self:GetStackCount() >= self.stack then
			self:SetStackCount(0)
			if #self.timer == 0 then
				self:StartIntervalThink(0)
			end
			local aa = self:GetParent()
			local ab = GameRules:GetGameTime()
			local ac = 0.15
			local ad = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_tinker/tinker_laser.vpcf",
				PATTACH_CUSTOMORIGIN,
				aa
			)
			ParticleManager:SetParticleControlEnt(
				ad,
				9,
				aa,
				PATTACH_POINT_FOLLOW,
				"attach_attack2",
				vec3_invalid,
				false
			)
			ParticleManager:SetParticleControlEnt(
				ad,
				1,
				a9.target,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				vec3_invalid,
				false
			)
			ParticleManager:ReleaseParticleIndex(ad)
			EmitSoundOn("Hero_Tinker.Laser", aa)
			EmitSoundOn("Hero_Tinker.LaserImpact", a9.target)
			aa:ForcePlayActivityOnce(ACT_DOTA_CAST_ABILITY_1)
			aa:StartGestureWithPlaybackRate(
				ACT_DOTA_CAST_ABILITY_1,
				aa:GetAttackSpeed(false) * aa:GetBaseAttackTime(false) * 1.25
			)
			local ae = self.timer
			ae[#ae + 1] = { flExpireTime = ab + ac, hTarget = a9.target, flDamage = self.damage }
		end
	end
end
function a8.prototype.OnIntervalThink(self)
	local aa = self:GetParent()
	local ab = GameRules:GetGameTime()
	for af = #self.timer, 1, -1 do
		local ag = self.timer[af]
		if ab >= ag.flExpireTime then
			aa:DealDamage(ag.hTarget, self:GetAbility(), ag.flDamage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			table.remove(self.timer, af)
		end
	end
	if #self.timer == 0 then
		self:StartIntervalThink(-1)
	end
end
a8 = e(
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
	a8
)
j.modifier_tinker_talent_4 = a8
j.tinker_talent_5 = c()
local ah = j.tinker_talent_5
ah.name = "tinker_talent_5"
d(ah, l)
function ah.prototype.GetIntrinsicModifierName(self)
	return "modifier_tinker_talent_5"
end
ah = e({ m(nil) }, ah)
j.tinker_talent_5 = ah
j.modifier_tinker_talent_5 = c()
local ai = j.modifier_tinker_talent_5
ai.name = "modifier_tinker_talent_5"
d(ai, o)
function ai.prototype.GetAbilitySpecialValue(self)
	self.damage_bonus = self:GetAbilitySpecialValueFor("damage_bonus")
end
function ai.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function ai.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function ai.prototype.OnBattleStartBefore(self, w)
	local y = self:GetParent():GetHeroBase()
	local z = y:getAbilityUpgradeData(true)
	local A = y:getTempAbilityUpgrade()
	local B = KeyValues.AbilityUpgradesKvs
	local C = {}
	h(g(z), function(D, E)
		local F = B[E] or {}
		if F.rarity == "sr" and not f(C, E) then
			C[#C + 1] = E
		end
	end)
	h(g(A), function(D, E)
		local F = B[E] or {}
		if F.rarity == "sr" and not f(C, E) then
			C[#C + 1] = E
		end
	end)
	self:SetStackCount(#C)
end
function ai.prototype.EOM_GetModifierOutgoingDamagePercentage(self)
	return self.damage_bonus * self:GetStackCount()
end
ai = e(
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
	ai
)
j.modifier_tinker_talent_5 = ai
j.tinker_talent_6 = c()
local aj = j.tinker_talent_6
aj.name = "tinker_talent_6"
d(aj, l)
function aj.prototype.GetIntrinsicModifierName(self)
	return "modifier_tinker_talent_6"
end
aj = e({ m(nil) }, aj)
j.tinker_talent_6 = aj
j.modifier_tinker_talent_6 = c()
local ak = j.modifier_tinker_talent_6
ak.name = "modifier_tinker_talent_6"
d(ak, o)
function ak.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
end
function ak.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function ak.prototype.OnCustomTakeDamage(self, a9)
	if self.chance > 0 and a9.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL and self:PRD(self.chance) then
		local al = self:GetParent():FindAbilityByName("tinker_ult")
		if al ~= nil then
			al:Launch(a9.target)
		end
	end
end
ak = e(
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
	ak
)
j.modifier_tinker_talent_6 = ak
j.tinker_talent_8 = c()
local am = j.tinker_talent_8
am.name = "tinker_talent_8"
d(am, l)
function am.prototype.GetIntrinsicModifierName(self)
	return "modifier_tinker_talent_8"
end
am = e({ m(nil) }, am)
j.tinker_talent_8 = am
j.modifier_tinker_talent_8 = c()
local an = j.modifier_tinker_talent_8
an.name = "modifier_tinker_talent_8"
d(an, o)
function an.prototype.GetAbilitySpecialValue(self)
	self.exp_reduce = self:GetAbilitySpecialValueFor("exp_reduce")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function an.prototype.AddCustomTransmitterData(self)
	return { tl8_list = self.tl8_list }
end
function an.prototype.HandleCustomTransmitterData(self, ao)
	self.tl8_list = ao.tl8_list
end
function an.prototype.loadDataTl8(self)
	local ap = self:GetParent():GetPlayerOwnerID()
	local aq = PlayerData:loadData(ap, "tinker_talent_8")
	local ar = PlayerData:getplayerData(ap)
	if ar then
		if aq == nil then
			local as = {}
			local at = AbilityShop.pickList
			if ar.bannedSect then
				ArrayRemove(at, ar.bannedSect)
			end
			while #as < self.count do
				local au = at[RandomInt(0, #at - 1) + 1]
				if not f(as, au) then
					as[#as + 1] = au
				end
			end
			aq = {}
			do
				local af = 0
				while af < #as do
					aq[as[af + 1]] = true
					af = af + 1
				end
			end
			PlayerData:saveData(ap, "tinker_talent_8", aq)
		end
	end
	self.tl8_list = aq
end
function an.prototype.OnCreated(self, w)
	if IsServer() then
		self:loadDataTl8()
		self:SetHasCustomTransmitterData(true)
	end
end
function an.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_SECT_EXP_REDUCE }
end
function an.prototype.EOM_GetModifierSectExpReduce(self, w)
	if w and w.sect and self.tl8_list ~= nil and self.tl8_list[w.sect] then
		return self.exp_reduce
	end
end
an = e(
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
	an
)
j.modifier_tinker_talent_8 = an
return j