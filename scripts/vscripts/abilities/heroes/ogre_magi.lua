--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/ogre_magi"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
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
		["24"] = 9,
		["25"] = 9,
		["27"] = 10,
		["28"] = 11,
		["29"] = 12,
		["30"] = 13,
		["31"] = 14,
		["33"] = 15,
		["35"] = 15,
		["36"] = 15,
		["37"] = 15,
		["39"] = 15,
		["41"] = 15,
		["43"] = 15,
		["46"] = 16,
		["47"] = 17,
		["49"] = 19,
		["50"] = 20,
		["51"] = 21,
		["52"] = 7,
		["53"] = 23,
		["54"] = 24,
		["55"] = 23,
		["56"] = 6,
		["57"] = 5,
		["58"] = 6,
		["60"] = 6,
		["61"] = 28,
		["62"] = 32,
		["63"] = 40,
		["64"] = 32,
		["65"] = 40,
		["66"] = 44,
		["67"] = 45,
		["68"] = 44,
		["69"] = 47,
		["70"] = 48,
		["71"] = 47,
		["72"] = 50,
		["73"] = 51,
		["74"] = 52,
		["75"] = 53,
		["76"] = 50,
		["77"] = 55,
		["78"] = 56,
		["79"] = 55,
		["80"] = 61,
		["81"] = 62,
		["82"] = 63,
		["84"] = 61,
		["85"] = 66,
		["86"] = 67,
		["87"] = 68,
		["88"] = 69,
		["89"] = 71,
		["90"] = 72,
		["92"] = 75,
		["93"] = 76,
		["96"] = 66,
		["97"] = 81,
		["98"] = 82,
		["99"] = 82,
		["100"] = 82,
		["101"] = 83,
		["104"] = 84,
		["105"] = 85,
		["106"] = 86,
		["107"] = 87,
		["108"] = 88,
		["109"] = 89,
		["110"] = 90,
		["111"] = 91,
		["112"] = 92,
		["113"] = 93,
		["114"] = 98,
		["115"] = 99,
		["116"] = 100,
		["117"] = 101,
		["118"] = 101,
		["119"] = 101,
		["120"] = 101,
		["121"] = 101,
		["122"] = 102,
		["123"] = 103,
		["124"] = 103,
		["125"] = 103,
		["126"] = 103,
		["127"] = 103,
		["129"] = 105,
		["130"] = 106,
		["131"] = 107,
		["132"] = 108,
		["134"] = 109,
		["135"] = 109,
		["136"] = 110,
		["137"] = 111,
		["138"] = 112,
		["139"] = 112,
		["140"] = 112,
		["141"] = 112,
		["142"] = 112,
		["143"] = 112,
		["144"] = 112,
		["145"] = 112,
		["146"] = 112,
		["147"] = 112,
		["148"] = 112,
		["149"] = 120,
		["150"] = 121,
		["151"] = 121,
		["152"] = 121,
		["153"] = 121,
		["154"] = 121,
		["155"] = 121,
		["156"] = 121,
		["157"] = 121,
		["158"] = 121,
		["159"] = 122,
		["160"] = 123,
		["161"] = 124,
		["162"] = 109,
		["165"] = 126,
		["166"] = 126,
		["167"] = 126,
		["168"] = 127,
		["169"] = 127,
		["170"] = 127,
		["171"] = 128,
		["172"] = 129,
		["174"] = 127,
		["175"] = 127,
		["176"] = 126,
		["177"] = 126,
		["179"] = 82,
		["180"] = 82,
		["181"] = 81,
		["182"] = 136,
		["183"] = 137,
		["184"] = 136,
		["185"] = 40,
		["186"] = 32,
		["187"] = 32,
		["188"] = 32,
		["189"] = 32,
		["190"] = 32,
		["191"] = 32,
		["192"] = 32,
		["193"] = 40,
		["195"] = 40,
		["196"] = 140,
		["197"] = 148,
		["198"] = 140,
		["199"] = 148,
		["200"] = 150,
		["201"] = 151,
		["202"] = 150,
		["203"] = 153,
		["204"] = 154,
		["205"] = 155,
		["206"] = 156,
		["207"] = 157,
		["208"] = 158,
		["209"] = 158,
		["210"] = 159,
		["211"] = 160,
		["213"] = 153,
		["214"] = 163,
		["215"] = 164,
		["216"] = 163,
		["217"] = 168,
		["218"] = 169,
		["219"] = 168,
		["220"] = 148,
		["221"] = 140,
		["222"] = 140,
		["223"] = 140,
		["224"] = 140,
		["225"] = 140,
		["226"] = 140,
		["227"] = 140,
		["228"] = 140,
		["229"] = 148,
		["231"] = 148,
		["232"] = 172,
		["233"] = 182,
		["234"] = 172,
		["235"] = 182,
		["236"] = 185,
		["237"] = 186,
		["238"] = 187,
		["239"] = 185,
		["240"] = 189,
		["241"] = 190,
		["242"] = 191,
		["244"] = 189,
		["245"] = 194,
		["246"] = 195,
		["247"] = 194,
		["248"] = 182,
		["249"] = 172,
		["250"] = 172,
		["251"] = 172,
		["252"] = 172,
		["253"] = 172,
		["254"] = 172,
		["255"] = 172,
		["256"] = 172,
		["257"] = 172,
		["258"] = 172,
		["259"] = 182,
		["261"] = 182,
		["262"] = 202,
		["263"] = 203,
		["264"] = 202,
		["265"] = 203,
		["266"] = 204,
		["267"] = 205,
		["268"] = 206,
		["269"] = 207,
		["270"] = 208,
		["271"] = 209,
		["272"] = 210,
		["273"] = 211,
		["274"] = 212,
		["275"] = 214,
		["276"] = 215,
		["277"] = 215,
		["278"] = 215,
		["279"] = 216,
		["280"] = 217,
		["281"] = 218,
		["282"] = 219,
		["283"] = 219,
		["284"] = 219,
		["285"] = 219,
		["286"] = 219,
		["287"] = 221,
		["288"] = 222,
		["289"] = 223,
		["290"] = 223,
		["291"] = 223,
		["292"] = 223,
		["293"] = 223,
		["294"] = 224,
		["295"] = 225,
		["296"] = 225,
		["297"] = 225,
		["298"] = 226,
		["299"] = 227,
		["300"] = 227,
		["301"] = 227,
		["302"] = 227,
		["303"] = 227,
		["304"] = 228,
		["305"] = 229,
		["306"] = 231,
		["307"] = 232,
		["308"] = 232,
		["309"] = 232,
		["310"] = 232,
		["311"] = 232,
		["312"] = 233,
		["313"] = 235,
		["314"] = 236,
		["315"] = 236,
		["316"] = 236,
		["317"] = 236,
		["318"] = 236,
		["319"] = 239,
		["320"] = 240,
		["322"] = 243,
		["324"] = 225,
		["325"] = 225,
		["326"] = 247,
		["327"] = 248,
		["330"] = 252,
		["331"] = 253,
		["335"] = 215,
		["336"] = 215,
		["337"] = 204,
		["338"] = 261,
		["339"] = 262,
		["340"] = 263,
		["341"] = 264,
		["342"] = 265,
		["343"] = 267,
		["344"] = 268,
		["345"] = 269,
		["346"] = 270,
		["347"] = 271,
		["348"] = 272,
		["349"] = 272,
		["350"] = 272,
		["351"] = 272,
		["352"] = 272,
		["353"] = 272,
		["354"] = 272,
		["355"] = 272,
		["356"] = 272,
		["357"] = 273,
		["358"] = 273,
		["359"] = 273,
		["360"] = 273,
		["361"] = 273,
		["362"] = 275,
		["363"] = 276,
		["364"] = 279,
		["365"] = 280,
		["367"] = 289,
		["368"] = 290,
		["369"] = 290,
		["370"] = 290,
		["371"] = 290,
		["372"] = 290,
		["373"] = 290,
		["374"] = 290,
		["377"] = 261,
		["378"] = 294,
		["379"] = 295,
		["380"] = 294,
		["381"] = 203,
		["382"] = 202,
		["383"] = 203,
		["385"] = 203,
		["386"] = 299,
		["387"] = 307,
		["388"] = 299,
		["389"] = 307,
		["390"] = 311,
		["391"] = 313,
		["392"] = 314,
		["393"] = 315,
		["394"] = 311,
		["395"] = 317,
		["396"] = 318,
		["397"] = 317,
		["398"] = 322,
		["399"] = 323,
		["400"] = 324,
		["402"] = 322,
		["403"] = 327,
		["404"] = 328,
		["405"] = 327,
		["406"] = 332,
		["407"] = 333,
		["408"] = 334,
		["409"] = 335,
		["411"] = 337,
		["412"] = 338,
		["414"] = 332,
		["415"] = 307,
		["416"] = 299,
		["417"] = 299,
		["418"] = 299,
		["419"] = 299,
		["420"] = 299,
		["421"] = 299,
		["422"] = 299,
		["423"] = 299,
		["424"] = 307,
		["426"] = 307,
		["428"] = 347,
		["429"] = 348,
		["430"] = 347,
		["431"] = 348,
		["432"] = 349,
		["433"] = 350,
		["434"] = 349,
		["435"] = 348,
		["436"] = 347,
		["437"] = 348,
		["439"] = 348,
		["440"] = 353,
		["441"] = 361,
		["442"] = 353,
		["443"] = 361,
		["444"] = 363,
		["445"] = 364,
		["446"] = 363,
		["447"] = 366,
		["448"] = 367,
		["449"] = 366,
		["450"] = 371,
		["451"] = 372,
		["452"] = 371,
		["453"] = 361,
		["454"] = 353,
		["455"] = 353,
		["456"] = 353,
		["457"] = 353,
		["458"] = 353,
		["459"] = 353,
		["460"] = 353,
		["461"] = 353,
		["462"] = 361,
		["464"] = 361,
		["466"] = 377,
		["467"] = 385,
		["468"] = 377,
		["469"] = 385,
		["470"] = 388,
		["471"] = 389,
		["472"] = 390,
		["473"] = 388,
		["474"] = 392,
		["475"] = 393,
		["476"] = 392,
		["477"] = 397,
		["478"] = 398,
		["479"] = 397,
		["480"] = 400,
		["481"] = 401,
		["482"] = 402,
		["483"] = 403,
		["484"] = 403,
		["485"] = 404,
		["487"] = 400,
		["488"] = 407,
		["489"] = 408,
		["490"] = 409,
		["491"] = 410,
		["492"] = 410,
		["494"] = 407,
		["495"] = 413,
		["496"] = 414,
		["497"] = 415,
		["498"] = 416,
		["499"] = 417,
		["501"] = 413,
		["502"] = 385,
		["503"] = 377,
		["504"] = 377,
		["505"] = 377,
		["506"] = 377,
		["507"] = 377,
		["508"] = 377,
		["509"] = 377,
		["510"] = 377,
		["511"] = 385,
		["513"] = 385,
		["515"] = 423,
		["516"] = 432,
		["517"] = 423,
		["518"] = 432,
		["519"] = 434,
		["520"] = 435,
		["521"] = 434,
		["522"] = 437,
		["523"] = 438,
		["524"] = 437,
		["525"] = 432,
		["526"] = 423,
		["527"] = 423,
		["528"] = 423,
		["529"] = 423,
		["530"] = 423,
		["531"] = 423,
		["532"] = 423,
		["533"] = 423,
		["534"] = 423,
		["535"] = 432,
		["537"] = 432,
		["539"] = 445,
		["540"] = 446,
		["541"] = 445,
		["542"] = 446,
		["543"] = 447,
		["544"] = 448,
		["545"] = 447,
		["546"] = 446,
		["547"] = 445,
		["548"] = 446,
		["550"] = 446,
		["551"] = 451,
		["552"] = 459,
		["553"] = 451,
		["554"] = 459,
		["555"] = 461,
		["556"] = 462,
		["557"] = 461,
		["558"] = 464,
		["559"] = 465,
		["560"] = 464,
		["561"] = 469,
		["562"] = 470,
		["563"] = 470,
		["564"] = 471,
		["566"] = 469,
		["567"] = 459,
		["568"] = 451,
		["569"] = 451,
		["570"] = 451,
		["571"] = 451,
		["572"] = 451,
		["573"] = 451,
		["574"] = 451,
		["575"] = 451,
		["576"] = 459,
		["578"] = 459,
		["580"] = 557,
		["581"] = 558,
		["582"] = 557,
		["583"] = 558,
		["584"] = 559,
		["585"] = 560,
		["586"] = 559,
		["587"] = 558,
		["588"] = 557,
		["589"] = 558,
		["591"] = 558,
		["592"] = 563,
		["593"] = 571,
		["594"] = 563,
		["595"] = 571,
		["596"] = 573,
		["597"] = 574,
		["598"] = 573,
		["599"] = 576,
		["600"] = 577,
		["601"] = 578,
		["602"] = 578,
		["603"] = 577,
		["604"] = 576,
		["605"] = 581,
		["606"] = 582,
		["607"] = 583,
		["608"] = 584,
		["609"] = 585,
		["610"] = 586,
		["611"] = 587,
		["614"] = 581,
		["615"] = 571,
		["616"] = 563,
		["617"] = 563,
		["618"] = 563,
		["619"] = 563,
		["620"] = 563,
		["621"] = 563,
		["622"] = 563,
		["623"] = 563,
		["624"] = 571,
		["626"] = 571,
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
h.ogre_magi_talent = c()
local r = h.ogre_magi_talent
r.name = "ogre_magi_talent"
d(r, j)
function r.prototype.GetMultcastTimes(self, s)
	local t = 0
	if self:GetCaster():PassivesDisabled() then
		return t
	end
	local u = self:GetCaster()
	local v = self:GetSpecialValueFor("bonus_chance")
		+ GetPhysicalCriticalChance(u) * self:GetSpecialValueFor("crit_factor")
	local w = self:GetSpecialValueFor("max_count") + self:GetTalentValue("ogre_magi_talent_1", "count_bonus")
	local x = self:GetTalentValue("ogre_magi_talent_5", "crit_chance_bonus")
	local y = v + x
	while true do
		local z = t < w
		if z then
			local A
			if s then
				A = PlayerData:PRD(u, y, "ogre_magi_talent_10", true)
			else
				A = self:PRD(y)
			end
			z = A
		end
		if not z then
			break
		end
		y = v
		t = t + 1
	end
	local B = u:GetModifierStackCount("modifier_ogre_magi_talent_6_counter", nil)
	u:RemoveModifierByNameAndCaster("modifier_ogre_magi_talent_6_counter", nil)
	return t + B
end
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_ogre_magi_talent"
end
r = e({ k(nil) }, r)
h.ogre_magi_talent = r
local C = {
	"models/creeps/lane_creeps/creep_radiant_melee/radiant_melee.vmdl",
	"models/creeps/lane_creeps/creep_bad_melee/creep_bad_melee.vmdl",
}
h.modifier_ogre_magi_talent = c()
local D = h.modifier_ogre_magi_talent
D.name = "modifier_ogre_magi_talent"
d(D, m)
function D.prototype.IsHidden(self)
	return self:GetStackCount() == 0
end
function D.prototype.GetTexture(self)
	return "hand_of_midas"
end
function D.prototype.GetAbilitySpecialValue(self)
	self.tl4_attackspeed_pct = self:GetAbilityTalentValue("ogre_magi_talent_4", "attackspeed_pct")
	self.tl9_health_bonus = self:GetAbilityTalentValue("ogre_magi_talent_9", "health_bonus")
	self.tl10_gold_bonus = self:GetAbilityTalentValue("ogre_magi_talent_10", "gold_bonus")
end
function D.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
	}
end
function D.prototype.OnCreated(self, E)
	if IsServer() then
		self:SetStackCount(self:loadData("talent10"))
	end
end
function D.prototype.OnBattleStartBefore(self, E)
	if IsServer() then
		local F = self:GetParent()
		local G = self:GetAbility()
		if self.tl4_attackspeed_pct > 0 then
			F:AddNewModifier(F, G, "modifier_ogre_magi_talent_4_buff", nil)
		end
		if self.tl9_health_bonus > 0 then
			F:AddNewModifier(F, G, "modifier_ogre_magi_talent_9_buff", nil)
		end
	end
end
function D.prototype.Talent10(self)
	GameTimer(3, function()
		if not IsValid(self) then
			return
		end
		if self.tl10_gold_bonus > 0 then
			local G = self:GetAbility()
			local H = G:GetMultcastTimes(true)
			local I = 1 + H
			local F = self:GetParent()
			local J = F:GetPlayerOwnerID()
			local K = I * self.tl10_gold_bonus
			PlayerData:modifyGold(J, K)
			self:modifyData("talent10", K)
			Notification:combatToPlayer(
				J,
				{ message = "notify_bonus_gold", string_itemname_artifact = "modifier_ogre_magi_talent", int_gold = K }
			)
			self:IncrementStackCount(K)
			if H > 0 then
				local L = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_ogre_magi/ogre_magi_ulti.vpcf",
					PATTACH_OVERHEAD_FOLLOW,
					F
				)
				ParticleManager:SetParticleControl(L, 1, Vector(I, 0, 0))
				ParticleManager:ReleaseParticleIndex(L)
				EmitSoundOnLocationWithCaster(
					F:GetAbsOrigin(),
					"Hero_OgreMagi.Fireblast.x" .. tostring(Clamp(H, 1, 3)),
					F
				)
			end
			local M = F:GetAbsOrigin() + Vector(0, -150, 0)
			local N = 100
			local O = -1
			local P = {}
			do
				local Q = 0
				while Q < I do
					O = O * -1
					local R = M + vec3_left * N * math.floor((Q + 1) / 2) * O
					local S = SpawnEntityFromTableSynchronous(
						"prop_dynamic",
						{
							origin = R,
							angles = "0 90 0",
							model = C[RandomInt(0, #C - 1) + 1],
							DefaultAnim = "ACT_DOTA_DIE",
							use_animgraph = "1",
							AnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
						}
					)
					local L = ParticleManager:CreateParticle(
						"particles/items2_fx/hand_of_midas.vpcf",
						PATTACH_ABSORIGIN,
						S,
						F
					)
					ParticleManager:SetParticleControlEnt(
						L,
						1,
						F,
						PATTACH_POINT_FOLLOW,
						"attach_hitloc",
						vec3_zero,
						true
					)
					ParticleManager:ReleaseParticleIndex(L)
					S:EmitSound("DOTA_Item.Hand_Of_Midas")
					P[#P + 1] = S
					Q = Q + 1
				end
			end
			GameTimer(3, function()
				f(P, function(T, S)
					if IsValid(S) then
						S:RemoveSelf()
					end
				end)
			end)
		end
	end)
end
function D.prototype.OnRoundStart(self)
	self:Talent10()
end
D = e(
	{
		n(
			a,
			{
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
h.modifier_ogre_magi_talent = D
h.modifier_ogre_magi_talent_9_buff = c()
local U = h.modifier_ogre_magi_talent_9_buff
U.name = "modifier_ogre_magi_talent_9_buff"
d(U, m)
function U.prototype.GetAbilitySpecialValue(self)
	self.tl9_health_bonus = self:GetAbilityTalentValue("ogre_magi_talent_9", "health_bonus")
end
function U.prototype.OnCreated(self, E)
	if IsServer() then
		local J = self:GetParent():GetPlayerOwnerID()
		local V = PlayerData:getHero(J)
		local W = V and V:getAbilityData(true)
		local X = W and W.sect_ulti
		local Y = X and X.exp or 0
		local Z = Y * self.tl9_health_bonus
		self:SetStackCount(Z)
	end
end
function U.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function U.prototype.EOM_GetModifierHealthBonus(self, E)
	return self:GetStackCount()
end
U = e(
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
	U
)
h.modifier_ogre_magi_talent_9_buff = U
h.modifier_ogre_magi_talent_4_buff = c()
local _ = h.modifier_ogre_magi_talent_4_buff
_.name = "modifier_ogre_magi_talent_4_buff"
d(_, m)
function _.prototype.GetAbilitySpecialValue(self)
	self.attackspeed_pct = self:GetAbilityTalentValue("ogre_magi_talent_4", "attackspeed_pct")
	self.crit_chance = self:GetAbilityTalentValue("ogre_magi_talent_4", "crit_chance")
end
function _.prototype.OnCreated(self, E)
	if IsServer() then
		self:GetParent():EmitSound("Hero_OgreMagi.Bloodlust.Target")
	end
end
function _.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.attackspeed_pct,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS] = self.crit_chance,
	}
end
_ = e(
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
				GetEffectName = "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
			}
		),
	},
	_
)
h.modifier_ogre_magi_talent_4_buff = _
h.ogre_magi_ult = c()
local a0 = h.ogre_magi_ult
a0.name = "ogre_magi_ult"
d(a0, p)
function a0.prototype.OnSpellStart(self)
	local a1 = self:GetCaster()
	local a2 = a1:GetEnemy()
	local a3 = a1:FindAbilityByName("ogre_magi_talent")
	local a4 = (self:GetSpecialValueFor("multcast_interval") or 0.6)
		+ self:GetTalentValue("ogre_magi_talent_8", "duration")
	local a5 = self:GetTalentValue("ogre_magi_talent_3", "mana_regen_per_multi")
	local a6 = self:GetTalentValue("ogre_magi_talent_6", "crit_bonus")
	local a7 = a3:GetMultcastTimes()
	local a8 = 1
	a1:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	self:GameTimer(0.45, function()
		if IsInjurable(a1, a2) then
			a1:EmitSound("Hero_OgreMagi.Fireblast.Cast")
			self:Fireblast()
			EmitSoundOnLocationWithCaster(a2:GetAbsOrigin(), "Hero_OgreMagi.Fireblast.Target", a1)
			if a7 > 0 then
				local L = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_ogre_magi/ogre_magi_ulti.vpcf",
					PATTACH_OVERHEAD_FOLLOW,
					a2
				)
				ParticleManager:SetParticleControl(L, 1, Vector(a8, a7 + 1, a7))
				ParticleManager:ReleaseParticleIndex(L)
				self:GameTimer(a4, function()
					if a7 > 0 then
						EmitSoundOnLocationWithCaster(
							a2:GetAbsOrigin(),
							"Hero_OgreMagi.Fireblast.x" .. tostring(Clamp(a8, 1, 3)),
							a1
						)
						a8 = a8 + 1
						a7 = a7 - 1
						local a9 = ParticleManager:CreateParticle(
							"particles/units/heroes/hero_ogre_magi/ogre_magi_ultib.vpcf",
							PATTACH_OVERHEAD_FOLLOW,
							a2
						)
						ParticleManager:SetParticleControl(a9, 1, Vector(a8, a7 + 1, 0))
						ParticleManager:ReleaseParticleIndex(a9)
						self:Fireblast()
						EmitSoundOnLocationWithCaster(a2:GetAbsOrigin(), "Hero_OgreMagi.Fireblast.Target", a1)
						if a5 > 0 then
							Restore(a1, a5)
						end
						return a4
					end
				end)
				if a1:HasModifier("modifier_ogre_magi_talent_6") then
					a1:RemoveModifierByName("modifier_ogre_magi_talent_6")
				end
			else
				if a6 > 0 then
					a1:AddNewModifier(a1, self, "modifier_ogre_magi_talent_6", nil)
				end
			end
		end
	end)
end
function a0.prototype.Fireblast(self)
	local a1 = self:GetCaster()
	local a2 = a1:GetEnemy()
	local aa = self:GetSpecialValueFor("damage") + self:GetTalentValue("ogre_magi_talent_1", "damage_bonus")
	local ab = self:GetTalentValue("ogre_magi_talent_4", "duration")
	local ac = self:GetTalentValue("ogre_magi_talent_12", "chance")
	local ad = self:GetTalentValue("ogre_magi_talent_12", "injury")
	local ae = self:GetSpecialValueFor("stun_duration") + self:GetTalentValue("ogre_magi_talent_8", "duration")
	if IsInjurable(a1, a2) then
		local L = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_ogre_magi/ogre_magi_fireblast.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControlEnt(L, 0, a2, PATTACH_POINT_FOLLOW, "attach_hitloc", a2:GetAbsOrigin(), false)
		ParticleManager:SetParticleControl(L, 1, a2:GetAbsOrigin())
		AddStun(a1, a2, self, ae)
		a1:DealDamage(a2, self, aa, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
		if ab > 0 then
			a1:AddNewModifier(a1, self, "modifier_ogre_magi_talent_4", { duration = ab })
		end
		if ac > 0 and self:PRD(ac) then
			AddInjury(a1, a2, ad, "ogre_magi_talent_12", "Ability")
		end
	end
end
function a0.prototype.GetIntrinsicModifierName(self)
	return "modifier_ogre_magi_ult"
end
a0 = e({ q(nil) }, a0)
h.ogre_magi_ult = a0
h.modifier_ogre_magi_ult = c()
local af = h.modifier_ogre_magi_ult
af.name = "modifier_ogre_magi_ult"
d(af, m)
function af.prototype.GetAbilitySpecialValue(self)
	self.s_base_chance = self:GetAbilityTalentValue("ogre_magi_shard", "base_chance")
	self.s_chance_factor = self:GetAbilityTalentValue("ogre_magi_shard", "chance_factor")
	self.manaEnable = self:HasTalent("ogre_magi_shard")
end
function af.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_LOSS_PERCENTAGE }
end
function af.prototype.EOM_GetModifierManaLossPercentage(self, E)
	if self.manaEnable then
		return 999
	end
end
function af.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent() } }
end
function af.prototype.OnCustomAttackLanded(self, ag)
	local v = self.s_base_chance
	if self.s_chance_factor > 0 then
		v = v + GetPhysicalCriticalChance(self:GetParent()) * self.s_chance_factor
	end
	if v > 0 and self:PRD(v, "s_chance") then
		self:GetAbility():OnSpellStart()
	end
end
af = e(
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
	af
)
h.modifier_ogre_magi_ult = af
h.ogre_magi_talent_2 = c()
local ah = h.ogre_magi_talent_2
ah.name = "ogre_magi_talent_2"
d(ah, j)
function ah.prototype.GetIntrinsicModifierName(self)
	return "modifier_ogre_magi_talent_2"
end
ah = e({ k(nil) }, ah)
h.ogre_magi_talent_2 = ah
h.modifier_ogre_magi_talent_2 = c()
local ai = h.modifier_ogre_magi_talent_2
ai.name = "modifier_ogre_magi_talent_2"
d(ai, m)
function ai.prototype.GetAbilitySpecialValue(self)
	self.mana_regen_ps = self:GetAbilitySpecialValueFor("mana_regen_ps")
end
function ai.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BONUS }
end
function ai.prototype.EOM_GetModifierManaRegenBonus(self)
	return self.mana_regen_ps
end
ai = e(
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
	ai
)
h.modifier_ogre_magi_talent_2 = ai
h.modifier_ogre_magi_talent_4 = c()
local aj = h.modifier_ogre_magi_talent_4
aj.name = "modifier_ogre_magi_talent_4"
d(aj, m)
function aj.prototype.GetAbilitySpecialValue(self)
	self.damage_bonus = self:GetAbilitySpecialValueFor("damage_bonus")
	self.timer = {}
end
function aj.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function aj.prototype.EOM_GetModifierOutgoingDamagePercentage(self)
	return self.damage_bonus * self:GetStackCount()
end
function aj.prototype.OnCreated(self, E)
	if IsServer() then
		self:IncrementStackCount()
		local ak = self.timer
		ak[#ak + 1] = self:GetDieTime()
		self:StartIntervalThink(0)
	end
end
function aj.prototype.OnRefresh(self, E)
	if IsServer() then
		self:IncrementStackCount()
		local al = self.timer
		al[#al + 1] = self:GetDieTime()
	end
end
function aj.prototype.OnIntervalThink(self)
	local am = GameRules:GetGameTime()
	while #self.timer > 0 and am >= self.timer[1] do
		table.remove(self.timer)
		self:DecrementStackCount()
	end
end
aj = e(
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
	aj
)
h.modifier_ogre_magi_talent_4 = aj
h.modifier_ogre_magi_talent_6 = c()
local an = h.modifier_ogre_magi_talent_6
an.name = "modifier_ogre_magi_talent_6"
d(an, m)
function an.prototype.GetAbilitySpecialValue(self)
	self.crit_bonus = self:GetAbilityTalentValue("ogre_magi_talent_6", "crit_bonus")
end
function an.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS] = self.crit_bonus }
end
an = e(
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	an
)
h.modifier_ogre_magi_talent_6 = an
h.ogre_magi_talent_7 = c()
local ao = h.ogre_magi_talent_7
ao.name = "ogre_magi_talent_7"
d(ao, j)
function ao.prototype.GetIntrinsicModifierName(self)
	return "modifier_ogre_magi_talent_7"
end
ao = e({ k(nil) }, ao)
h.ogre_magi_talent_7 = ao
h.modifier_ogre_magi_talent_7 = c()
local ap = h.modifier_ogre_magi_talent_7
ap.name = "modifier_ogre_magi_talent_7"
d(ap, m)
function ap.prototype.GetAbilitySpecialValue(self)
	self.fireblast_crit_damage_bonus = self:GetAbilitySpecialValueFor("fireblast_crit_damage_bonus")
end
function ap.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE }
end
function ap.prototype.EOM_GetModifierPhysicalCriticalStrikeDamage(self, E)
	local aq = E and E.ability
	if (aq and aq:GetAbilityName()) == "ogre_magi_ult" then
		return self.fireblast_crit_damage_bonus
	end
end
ap = e(
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
	ap
)
h.modifier_ogre_magi_talent_7 = ap
h.ogre_magi_talent_11 = c()
local ar = h.ogre_magi_talent_11
ar.name = "ogre_magi_talent_11"
d(ar, j)
function ar.prototype.GetIntrinsicModifierName(self)
	return "modifier_ogre_magi_talent_11"
end
ar = e({ k(nil) }, ar)
h.ogre_magi_talent_11 = ar
h.modifier_ogre_magi_talent_11 = c()
local as = h.modifier_ogre_magi_talent_11
as.name = "modifier_ogre_magi_talent_11"
d(as, m)
function as.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
end
function as.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self:GetParent(), -1 } }
end
function as.prototype.OnCritical(self, ag)
	if self.chance > 0 and self:PRD(self.chance) then
		local F = self:GetParent()
		local at = F:GetEnemy()
		local G = F:FindAbilityByName("ogre_magi_ult")
		if IsValid(G) and IsInjurable(F, at) then
			G:Fireblast()
		end
	end
end
as = e(
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
	as
)
h.modifier_ogre_magi_talent_11 = as
return h