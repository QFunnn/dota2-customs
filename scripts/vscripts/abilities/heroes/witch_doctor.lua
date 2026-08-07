--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/witch_doctor"
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
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
		["14"] = 4,
		["15"] = 4,
		["16"] = 4,
		["17"] = 5,
		["18"] = 5,
		["19"] = 5,
		["20"] = 10,
		["21"] = 11,
		["22"] = 10,
		["23"] = 11,
		["24"] = 12,
		["25"] = 13,
		["26"] = 12,
		["27"] = 11,
		["28"] = 10,
		["29"] = 11,
		["31"] = 11,
		["32"] = 17,
		["33"] = 25,
		["34"] = 17,
		["35"] = 25,
		["36"] = 49,
		["37"] = 50,
		["38"] = 51,
		["39"] = 52,
		["40"] = 53,
		["41"] = 55,
		["42"] = 57,
		["43"] = 58,
		["44"] = 61,
		["45"] = 62,
		["46"] = 49,
		["47"] = 65,
		["48"] = 65,
		["49"] = 68,
		["50"] = 69,
		["51"] = 70,
		["52"] = 71,
		["53"] = 71,
		["54"] = 71,
		["55"] = 71,
		["56"] = 71,
		["57"] = 71,
		["59"] = 73,
		["60"] = 73,
		["61"] = 73,
		["62"] = 73,
		["63"] = 73,
		["64"] = 73,
		["65"] = 73,
		["66"] = 73,
		["67"] = 73,
		["68"] = 73,
		["70"] = 75,
		["71"] = 76,
		["72"] = 77,
		["73"] = 78,
		["75"] = 80,
		["76"] = 80,
		["77"] = 80,
		["78"] = 80,
		["79"] = 80,
		["80"] = 80,
		["82"] = 68,
		["83"] = 83,
		["84"] = 84,
		["85"] = 84,
		["86"] = 84,
		["87"] = 84,
		["88"] = 84,
		["89"] = 84,
		["90"] = 84,
		["91"] = 83,
		["92"] = 92,
		["93"] = 93,
		["94"] = 94,
		["95"] = 95,
		["96"] = 96,
		["97"] = 97,
		["98"] = 97,
		["99"] = 97,
		["100"] = 97,
		["101"] = 97,
		["102"] = 97,
		["106"] = 92,
		["107"] = 102,
		["108"] = 103,
		["109"] = 104,
		["110"] = 105,
		["112"] = 102,
		["113"] = 108,
		["114"] = 109,
		["115"] = 110,
		["116"] = 111,
		["117"] = 111,
		["118"] = 111,
		["119"] = 111,
		["120"] = 111,
		["121"] = 111,
		["123"] = 111,
		["124"] = 112,
		["125"] = 113,
		["128"] = 118,
		["129"] = 119,
		["131"] = 121,
		["132"] = 122,
		["133"] = 122,
		["134"] = 122,
		["135"] = 122,
		["136"] = 122,
		["137"] = 122,
		["139"] = 124,
		["140"] = 125,
		["141"] = 125,
		["142"] = 125,
		["143"] = 125,
		["144"] = 125,
		["145"] = 125,
		["147"] = 108,
		["148"] = 128,
		["149"] = 129,
		["150"] = 130,
		["151"] = 131,
		["152"] = 131,
		["153"] = 131,
		["154"] = 131,
		["155"] = 131,
		["156"] = 131,
		["159"] = 128,
		["160"] = 135,
		["161"] = 136,
		["162"] = 135,
		["163"] = 25,
		["164"] = 17,
		["165"] = 17,
		["166"] = 17,
		["167"] = 17,
		["168"] = 17,
		["169"] = 17,
		["170"] = 17,
		["171"] = 17,
		["172"] = 25,
		["174"] = 25,
		["175"] = 140,
		["176"] = 141,
		["177"] = 140,
		["178"] = 141,
		["179"] = 142,
		["180"] = 143,
		["181"] = 144,
		["182"] = 145,
		["183"] = 146,
		["184"] = 147,
		["185"] = 148,
		["187"] = 142,
		["188"] = 141,
		["189"] = 140,
		["190"] = 141,
		["192"] = 141,
		["193"] = 155,
		["194"] = 162,
		["195"] = 155,
		["196"] = 162,
		["197"] = 170,
		["198"] = 171,
		["199"] = 172,
		["200"] = 173,
		["201"] = 174,
		["202"] = 170,
		["203"] = 176,
		["204"] = 177,
		["205"] = 178,
		["207"] = 176,
		["208"] = 181,
		["209"] = 182,
		["210"] = 183,
		["211"] = 183,
		["212"] = 183,
		["213"] = 183,
		["214"] = 183,
		["215"] = 183,
		["217"] = 181,
		["218"] = 186,
		["219"] = 187,
		["220"] = 186,
		["221"] = 192,
		["222"] = 193,
		["223"] = 194,
		["224"] = 192,
		["225"] = 196,
		["226"] = 197,
		["227"] = 198,
		["228"] = 199,
		["229"] = 199,
		["230"] = 199,
		["231"] = 199,
		["232"] = 199,
		["233"] = 199,
		["236"] = 196,
		["237"] = 203,
		["238"] = 204,
		["239"] = 205,
		["241"] = 203,
		["242"] = 162,
		["243"] = 155,
		["244"] = 155,
		["245"] = 155,
		["246"] = 155,
		["247"] = 155,
		["248"] = 155,
		["249"] = 155,
		["250"] = 162,
		["252"] = 162,
		["253"] = 215,
		["254"] = 223,
		["255"] = 215,
		["256"] = 223,
		["258"] = 223,
		["259"] = 226,
		["260"] = 215,
		["261"] = 227,
		["262"] = 228,
		["263"] = 229,
		["264"] = 227,
		["265"] = 231,
		["266"] = 232,
		["267"] = 233,
		["269"] = 231,
		["270"] = 236,
		["271"] = 237,
		["272"] = 237,
		["273"] = 237,
		["274"] = 237,
		["275"] = 236,
		["276"] = 242,
		["277"] = 243,
		["278"] = 244,
		["279"] = 245,
		["280"] = 246,
		["281"] = 247,
		["282"] = 248,
		["284"] = 242,
		["285"] = 251,
		["286"] = 252,
		["287"] = 253,
		["290"] = 256,
		["291"] = 257,
		["294"] = 260,
		["295"] = 261,
		["298"] = 264,
		["299"] = 265,
		["300"] = 266,
		["301"] = 266,
		["302"] = 266,
		["303"] = 266,
		["304"] = 266,
		["305"] = 266,
		["307"] = 268,
		["308"] = 269,
		["310"] = 271,
		["311"] = 272,
		["312"] = 273,
		["313"] = 273,
		["314"] = 273,
		["315"] = 273,
		["316"] = 273,
		["317"] = 273,
		["319"] = 275,
		["320"] = 276,
		["322"] = 251,
		["323"] = 279,
		["324"] = 280,
		["325"] = 281,
		["326"] = 282,
		["327"] = 283,
		["328"] = 284,
		["331"] = 279,
		["332"] = 223,
		["333"] = 215,
		["334"] = 215,
		["335"] = 215,
		["336"] = 215,
		["337"] = 215,
		["338"] = 215,
		["339"] = 215,
		["340"] = 215,
		["341"] = 223,
		["343"] = 223,
		["344"] = 290,
		["345"] = 298,
		["346"] = 290,
		["347"] = 298,
		["348"] = 299,
		["349"] = 300,
		["350"] = 299,
		["351"] = 302,
		["352"] = 303,
		["353"] = 302,
		["354"] = 305,
		["355"] = 306,
		["356"] = 305,
		["357"] = 298,
		["358"] = 290,
		["359"] = 290,
		["360"] = 290,
		["361"] = 290,
		["362"] = 290,
		["363"] = 290,
		["364"] = 290,
		["365"] = 290,
		["366"] = 298,
		["368"] = 298,
		["369"] = 310,
		["370"] = 318,
		["371"] = 310,
		["372"] = 318,
		["373"] = 319,
		["374"] = 320,
		["375"] = 319,
		["376"] = 322,
		["377"] = 323,
		["378"] = 322,
		["379"] = 325,
		["380"] = 326,
		["381"] = 325,
		["382"] = 318,
		["383"] = 310,
		["384"] = 310,
		["385"] = 310,
		["386"] = 310,
		["387"] = 310,
		["388"] = 310,
		["389"] = 310,
		["390"] = 310,
		["391"] = 318,
		["393"] = 318,
		["394"] = 331,
		["395"] = 339,
		["396"] = 331,
		["397"] = 339,
		["399"] = 339,
		["400"] = 340,
		["401"] = 344,
		["402"] = 331,
		["403"] = 345,
		["404"] = 346,
		["405"] = 347,
		["406"] = 345,
		["407"] = 349,
		["408"] = 350,
		["409"] = 351,
		["411"] = 349,
		["412"] = 354,
		["413"] = 355,
		["414"] = 356,
		["415"] = 356,
		["416"] = 356,
		["417"] = 356,
		["418"] = 357,
		["419"] = 358,
		["420"] = 358,
		["421"] = 358,
		["422"] = 358,
		["423"] = 358,
		["424"] = 358,
		["427"] = 354,
		["428"] = 362,
		["429"] = 363,
		["430"] = 362,
		["431"] = 367,
		["432"] = 368,
		["433"] = 367,
		["434"] = 339,
		["435"] = 331,
		["436"] = 331,
		["437"] = 331,
		["438"] = 331,
		["439"] = 331,
		["440"] = 331,
		["441"] = 331,
		["442"] = 331,
		["443"] = 339,
		["445"] = 339,
		["446"] = 371,
		["447"] = 379,
		["448"] = 371,
		["449"] = 379,
		["450"] = 380,
		["451"] = 381,
		["452"] = 382,
		["453"] = 382,
		["454"] = 382,
		["455"] = 382,
		["456"] = 382,
		["457"] = 382,
		["458"] = 383,
		["460"] = 380,
		["461"] = 386,
		["462"] = 386,
		["463"] = 379,
		["464"] = 371,
		["465"] = 371,
		["466"] = 371,
		["467"] = 371,
		["468"] = 371,
		["469"] = 371,
		["470"] = 371,
		["471"] = 371,
		["472"] = 379,
		["474"] = 379,
		["475"] = 392,
		["476"] = 400,
		["477"] = 392,
		["478"] = 400,
		["479"] = 403,
		["480"] = 404,
		["481"] = 403,
		["482"] = 406,
		["483"] = 407,
		["484"] = 408,
		["486"] = 406,
		["487"] = 411,
		["488"] = 412,
		["489"] = 411,
		["490"] = 417,
		["491"] = 418,
		["492"] = 419,
		["493"] = 420,
		["494"] = 421,
		["495"] = 421,
		["496"] = 421,
		["497"] = 421,
		["498"] = 421,
		["499"] = 421,
		["502"] = 417,
		["503"] = 425,
		["504"] = 426,
		["505"] = 425,
		["506"] = 400,
		["507"] = 392,
		["508"] = 392,
		["509"] = 392,
		["510"] = 392,
		["511"] = 392,
		["512"] = 392,
		["513"] = 392,
		["514"] = 392,
		["515"] = 400,
		["517"] = 400,
		["518"] = 431,
		["519"] = 439,
		["520"] = 431,
		["521"] = 439,
		["522"] = 449,
		["523"] = 450,
		["524"] = 451,
		["525"] = 452,
		["526"] = 453,
		["527"] = 454,
		["528"] = 449,
		["529"] = 456,
		["530"] = 457,
		["531"] = 458,
		["532"] = 459,
		["533"] = 461,
		["534"] = 462,
		["535"] = 463,
		["536"] = 464,
		["538"] = 456,
		["539"] = 467,
		["540"] = 468,
		["541"] = 469,
		["542"] = 470,
		["543"] = 471,
		["544"] = 472,
		["545"] = 473,
		["547"] = 475,
		["548"] = 476,
		["549"] = 477,
		["550"] = 478,
		["551"] = 479,
		["552"] = 479,
		["553"] = 479,
		["554"] = 479,
		["555"] = 479,
		["556"] = 479,
		["557"] = 485,
		["558"] = 486,
		["561"] = 487,
		["562"] = 488,
		["563"] = 479,
		["564"] = 479,
		["568"] = 467,
		["569"] = 495,
		["570"] = 496,
		["571"] = 495,
		["572"] = 500,
		["573"] = 501,
		["574"] = 502,
		["576"] = 500,
		["577"] = 505,
		["578"] = 506,
		["579"] = 507,
		["581"] = 505,
		["582"] = 510,
		["583"] = 511,
		["584"] = 512,
		["585"] = 512,
		["586"] = 512,
		["587"] = 512,
		["588"] = 513,
		["589"] = 517,
		["590"] = 518,
		["591"] = 518,
		["592"] = 518,
		["593"] = 518,
		["594"] = 518,
		["595"] = 518,
		["596"] = 518,
		["597"] = 518,
		["598"] = 518,
		["599"] = 519,
		["600"] = 519,
		["601"] = 519,
		["602"] = 519,
		["603"] = 519,
		["604"] = 519,
		["605"] = 519,
		["606"] = 519,
		["607"] = 519,
		["608"] = 520,
		["609"] = 520,
		["610"] = 520,
		["611"] = 520,
		["612"] = 520,
		["613"] = 520,
		["614"] = 520,
		["615"] = 520,
		["616"] = 520,
		["617"] = 521,
		["618"] = 522,
		["619"] = 523,
		["620"] = 510,
		["621"] = 525,
		["622"] = 526,
		["623"] = 527,
		["624"] = 528,
		["626"] = 530,
		["627"] = 531,
		["628"] = 532,
		["629"] = 533,
		["631"] = 535,
		["632"] = 536,
		["633"] = 537,
		["634"] = 525,
		["635"] = 439,
		["636"] = 431,
		["637"] = 431,
		["638"] = 431,
		["639"] = 431,
		["640"] = 431,
		["641"] = 431,
		["642"] = 431,
		["643"] = 431,
		["644"] = 439,
		["646"] = 439,
		["647"] = 542,
		["648"] = 550,
		["649"] = 542,
		["650"] = 550,
		["652"] = 550,
		["653"] = 554,
		["654"] = 542,
		["655"] = 555,
		["656"] = 556,
		["657"] = 557,
		["658"] = 558,
		["659"] = 555,
		["660"] = 560,
		["661"] = 561,
		["662"] = 562,
		["663"] = 563,
		["664"] = 564,
		["667"] = 560,
		["668"] = 569,
		["669"] = 570,
		["670"] = 569,
		["671"] = 574,
		["672"] = 575,
		["675"] = 576,
		["676"] = 577,
		["679"] = 578,
		["680"] = 579,
		["681"] = 580,
		["683"] = 586,
		["684"] = 591,
		["685"] = 592,
		["686"] = 593,
		["688"] = 599,
		["689"] = 574,
		["690"] = 550,
		["691"] = 542,
		["692"] = 542,
		["693"] = 542,
		["694"] = 542,
		["695"] = 542,
		["696"] = 542,
		["697"] = 542,
		["698"] = 542,
		["699"] = 550,
		["701"] = 550,
		["702"] = 604,
		["703"] = 607,
		["704"] = 604,
		["705"] = 607,
		["706"] = 608,
		["707"] = 609,
		["708"] = 610,
		["710"] = 612,
		["712"] = 608,
		["713"] = 615,
		["714"] = 616,
		["715"] = 617,
		["716"] = 618,
		["717"] = 619,
		["718"] = 620,
		["719"] = 621,
		["720"] = 622,
		["721"] = 623,
		["723"] = 625,
		["727"] = 615,
		["728"] = 630,
		["729"] = 631,
		["730"] = 632,
		["731"] = 632,
		["732"] = 632,
		["733"] = 632,
		["734"] = 633,
		["736"] = 635,
		["737"] = 636,
		["738"] = 637,
		["739"] = 637,
		["740"] = 637,
		["741"] = 637,
		["743"] = 639,
		["744"] = 630,
		["745"] = 607,
		["746"] = 604,
		["747"] = 607,
		["749"] = 607,
		["750"] = 643,
		["751"] = 649,
		["752"] = 643,
		["753"] = 649,
		["754"] = 649,
		["755"] = 643,
		["756"] = 649,
		["758"] = 649,
		["759"] = 653,
		["760"] = 659,
		["761"] = 653,
		["762"] = 659,
		["763"] = 659,
		["764"] = 653,
		["765"] = 659,
		["767"] = 659,
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
local q = require("abilities.interact_ability")
local r = q.InteractAbility
local s = q.registerInteractAbility
g.witch_doctor_talent = c()
local t = g.witch_doctor_talent
t.name = "witch_doctor_talent"
d(t, i)
function t.prototype.GetIntrinsicModifierName(self)
	return "modifier_witch_doctor_talent"
end
t = e({ j(nil) }, t)
g.witch_doctor_talent = t
g.modifier_witch_doctor_talent = c()
local u = g.modifier_witch_doctor_talent
u.name = "modifier_witch_doctor_talent"
d(u, l)
function u.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilityTalentValue("witch_doctor_talent_8", "interval_reduce")
	self.health_regen = self:GetAbilitySpecialValueFor("health_regen")
	self.talent_magic_damage = self:GetAbilitySpecialValueFor("talent_magic_damage")
	self.max_health_reduce = self:GetAbilityTalentValue("witch_doctor_ult", "max_health_reduce")
	self.tl1_health_bonus = self:GetAbilityTalentValue("witch_doctor_talent_1", "heal_bouns")
	self.tl3_heal_chance = self:GetAbilityTalentValue("witch_doctor_talent_3", "heal_chance")
	self.tl3_heal_pct = self:GetAbilityTalentValue("witch_doctor_talent_3", "heal_pct")
	self.tl7_magic_scar = self:GetAbilityTalentValue("witch_doctor_talent_7", "magic_scar")
	self.tl8_scar_damage = self:GetAbilityTalentValue("witch_doctor_talent_8", "scar_damage")
end
function u.prototype.OnCreated(self, v) end
function u.prototype.OnIntervalThink(self)
	if IsServer() then
		if self.parent:HasModifier("modifier_witch_doctor_interact_active") then
			self.parent:DealDamage(
				self.parent:GetEnemy(),
				self:GetAbility(),
				self.health_regen + self.tl1_health_bonus * self.parent:GetMaxHealth() * 0.01,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
			)
		else
			local w = Heal
			local x = self.parent
			local y = self.health_regen + self.tl1_health_bonus * self.parent:GetMaxHealth() * 0.01
			local z = self:GetAbility()
			w(x, y, z and z:GetName(), "Ability")
		end
		local A = 0
		local B = self.parent:GetEnemy()
		if self:HasTalent("witch_doctor_talent_8") and IsValid(B) and B:IsAlive() then
			A = GetScar(B) * self.tl8_scar_damage * 0.01
		end
		self.parent:DealDamage(
			self.parent:GetEnemy(),
			self:GetAbility(),
			self.talent_magic_damage + A,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
		)
	end
end
function u.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self.parent, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKE_SCAR] = { self.parent:GetEnemy() },
	}
end
function u.prototype.OnCustomTakeDamage(self, C)
	if IsServer() then
		if
			not self.parent:HasModifier("modifier_witch_doctor_ult")
			and self.tl7_magic_scar > 0
			and C.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
		then
			local D = math.floor(C.damage * self.tl7_magic_scar * 0.01)
			if D > 0 then
				AddScar(self.parent, C.target, self:GetAbility(), D)
			end
		end
	end
end
function u.prototype.OnBattleStartBefore(self, v)
	local B = self:GetParent():GetEnemy()
	if IsValid(B) then
		self.max_stack = math.floor(B:GetMaxHealth() * self.max_health_reduce * 0.01)
	end
end
function u.prototype.OnBattleStart(self, v)
	self:StartIntervalThink(self.interval)
	if self:HasTalent("witch_doctor_shard") then
		local E = PlayerData:loadData(self.parent:GetPlayerOwnerID(), "witch_doctor_shard")
		if E == nil then
			E = 3
		end
		local F = E
		if F > 0 then
			self.parent:AddNewModifier(self.parent, self.ability, "modifier_shard_equipment", { iShardCount = F })
		end
	end
	if self.parent:FindModifierByName("modifier_sect_ulti_81_buff") then
		RestoreCustomMana(self.parent, 100)
	end
	if self:HasTalent("witch_doctor_talent_2") then
		self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_witch_doctor_talent_2", {})
	end
	if self:HasTalent("witch_doctor_talent_6") then
		self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_witch_doctor_talent_6_trigger", {})
	end
end
function u.prototype.OnTakeScar(self, v)
	if IsServer() then
		if self.tl3_heal_chance ~= 0 and self:PRD(self.tl3_heal_chance) then
			Heal(self.parent:GetEnemy(), v.stack * self.tl3_heal_pct * 0.01, "witch_doctor_talent_3", "Ability")
		end
	end
end
function u.prototype.OnBattleEnd(self, v)
	self:StartIntervalThink(-1)
end
u = e(
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
	u
)
g.modifier_witch_doctor_talent = u
g.witch_doctor_ult = c()
local G = g.witch_doctor_ult
G.name = "witch_doctor_ult"
d(G, o)
function G.prototype.OnSpellStart(self)
	local H = self:GetCaster()
	if not H:HasModifier("modifier_witch_doctor_ult") then
		H:StartGesture(ACT_DOTA_SPAWN)
		H:EmitSound("Hero_WitchDoctor.Maledict_CastFail")
		local I = self:GetSpecialValueFor("ult_duration")
		H:AddNewModifier(H, self, "modifier_witch_doctor_ult", { duration = I + 0.1 })
	end
end
G = e({ p(nil) }, G)
g.witch_doctor_ult = G
g.modifier_witch_doctor_ult = c()
local J = g.modifier_witch_doctor_ult
J.name = "modifier_witch_doctor_ult"
d(J, l)
function J.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.magic_damage = self:GetAbilitySpecialValueFor("magic_damage")
		+ self:GetAbilityTalentValue("witch_doctor_talent_4", "damage")
	self.change_scar = self:GetAbilitySpecialValueFor("change_scar")
		+ self:GetAbilityTalentValue("witch_doctor_talent_7", "magic_scar")
	self.tl4_damage_bonus = self:GetAbilityTalentValue("witch_doctor_talent_4", "damage_bonus")
end
function J.prototype.OnCreated(self, v)
	if IsServer() then
		self:StartIntervalThink(self.interval)
	end
end
function J.prototype.OnIntervalThink(self)
	if IsServer() then
		self.parent:DealDamage(
			self.parent:GetEnemy(),
			self:GetAbility(),
			self.magic_damage,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
		)
	end
end
function J.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self.parent, -1 },
	}
end
function J.prototype.OnBattleEnd(self, v)
	self:StartIntervalThink(-1)
	self.parent:RemoveModifierByName("modifier_witch_doctor_ult")
end
function J.prototype.OnCustomTakeDamage(self, C)
	if IsServer() then
		if C.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL then
			AddScar(
				self.parent,
				self.parent:GetEnemy(),
				self:GetAbility(),
				math.floor(C.damage * self.change_scar * 0.01)
			)
		end
	end
end
function J.prototype.OnDestroy(self)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
J = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	J
)
g.modifier_witch_doctor_ult = J
g.modifier_witch_doctor_talent_2 = c()
local K = g.modifier_witch_doctor_talent_2
K.name = "modifier_witch_doctor_talent_2"
d(K, l)
function K.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.last_trigger_pct = 0
end
function K.prototype.GetAbilitySpecialValue(self)
	self.tl2_regen_steal = self:GetAbilityTalentValue("witch_doctor_talent_2", "regen_extra_steal")
	self.tl2_scar_pct = self:GetAbilityTalentValue("witch_doctor_talent_2", "scar_pct")
end
function K.prototype.OnCreated(self, v)
	if IsServer() then
		self.last_trigger_pct = 0
	end
end
function K.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKE_SCAR] = { self.parent:GetEnemy() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
	}
end
function K.prototype.OnTakeScar(self, v)
	if IsServer() then
		local B = self.parent:GetEnemy()
		local L = B:FindModifierByName("modifier_scar_custom")
		local M = L:GetScarPct()
		local N = math.floor(M / self.tl2_scar_pct) * self.tl2_regen_steal
		self:StealRegen(N)
	end
end
function K.prototype.StealRegen(self, N)
	local B = self.parent:GetEnemy()
	if not IsValid(B) then
		return
	end
	local O = GetHealBonus(B)
	if O <= 0 then
		return
	end
	local P = math.min(N, O)
	if P <= 0 then
		return
	end
	local Q = self.parent:FindModifierByName("modifier_witch_doctor_talent_2_buff")
	if not IsValid(Q) then
		Q = self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_witch_doctor_talent_2_buff", {})
	end
	if IsValid(Q) then
		Q:SetStackCount(P)
	end
	local R = B:FindModifierByName("modifier_witch_doctor_talent_2_debuff")
	if not IsValid(R) then
		R = B:AddNewModifier(self.parent, self:GetAbility(), "modifier_witch_doctor_talent_2_debuff", {})
	end
	if IsValid(R) then
		R:SetStackCount(P)
	end
end
function K.prototype.OnBattleEnd(self, v)
	if IsServer() then
		self.parent:RemoveModifierByName("modifier_witch_doctor_talent_2_buff")
		local B = self.parent:GetEnemy()
		if IsValid(B) then
			B:RemoveModifierByName("modifier_witch_doctor_talent_2_debuff")
		end
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
g.modifier_witch_doctor_talent_2 = K
g.modifier_witch_doctor_talent_2_buff = c()
local S = g.modifier_witch_doctor_talent_2_buff
S.name = "modifier_witch_doctor_talent_2_buff"
d(S, l)
function S.prototype.GetTexture(self)
	return "witch_doctor_talent_2"
end
function S.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_BONUS }
end
function S.prototype.EOM_GetModifierHeal_Bonus(self, v)
	return self:GetStackCount()
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
g.modifier_witch_doctor_talent_2_buff = S
g.modifier_witch_doctor_talent_2_debuff = c()
local T = g.modifier_witch_doctor_talent_2_debuff
T.name = "modifier_witch_doctor_talent_2_debuff"
d(T, l)
function T.prototype.GetTexture(self)
	return "witch_doctor_talent_2"
end
function T.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_BONUS }
end
function T.prototype.EOM_GetModifierHeal_Bonus(self, v)
	return -self:GetStackCount()
end
T = e(
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
	T
)
g.modifier_witch_doctor_talent_2_debuff = T
g.modifier_witch_doctor_scar_debuff = c()
local U = g.modifier_witch_doctor_scar_debuff
U.name = "modifier_witch_doctor_scar_debuff"
d(U, l)
function U.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.max_stack = 0
	self.count = 0
end
function U.prototype.GetAbilitySpecialValue(self)
	self.tl3_heal_chance = self:GetAbilityTalentValue("witch_doctor_talent_3", "heal_chance")
	self.tl3_heal_pct = self:GetAbilityTalentValue("witch_doctor_talent_3", "heal_pct")
end
function U.prototype.OnCreated(self, v)
	if IsServer() then
		self.max_stack = v.max_stack
	end
end
function U.prototype.OnRefresh(self, v)
	if IsServer() then
		self:SetStackCount(math.min(self:GetStackCount() + v.damage, self.max_stack))
		if self.tl3_heal_chance ~= 0 and self:PRD(self.tl3_heal_chance) then
			Heal(self.parent:GetEnemy(), v.damage * self.tl3_heal_pct * 0.01, "witch_doctor_talent_3", "Ability")
		end
	end
end
function U.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function U.prototype.EOM_GetModifierHealthBonus(self)
	return -self:GetStackCount()
end
U = e(
	{
		m(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	U
)
g.modifier_witch_doctor_scar_debuff = U
g.modifier_talent_4 = c()
local V = g.modifier_talent_4
V.name = "modifier_talent_4"
d(V, l)
function V.prototype.OnCreated(self, v)
	if IsServer() then
		self.parent:DealDamage(
			self.parent:GetEnemy(),
			self:GetAbility(),
			v.damage,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
		)
		self:OnDestroy()
	end
end
function V.prototype.OnDestroy(self) end
V = e(
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
	V
)
g.modifier_talent_4 = V
g.modifier_witch_doctor_talent_6_trigger = c()
local W = g.modifier_witch_doctor_talent_6_trigger
W.name = "modifier_witch_doctor_talent_6_trigger"
d(W, l)
function W.prototype.GetAbilitySpecialValue(self)
	self.health_pct = self:GetAbilityTalentValue("witch_doctor_talent_6", "health_pct")
end
function W.prototype.OnCreated(self, v)
	if IsServer() then
		self.triggered = false
	end
end
function W.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
	}
end
function W.prototype.OnCustomTakeDamage(self, C)
	if IsServer() then
		if not self.triggered and self.health_pct > 0 and self.parent:GetHealthPercent() < self.health_pct then
			self.triggered = true
			self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_witch_doctor_talent_6", {})
		end
	end
end
function W.prototype.OnBattleEnd(self, v)
	self.parent:RemoveModifierByName("modifier_witch_doctor_talent_6_trigger")
end
W = e(
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
	W
)
g.modifier_witch_doctor_talent_6_trigger = W
g.modifier_witch_doctor_talent_6 = c()
local X = g.modifier_witch_doctor_talent_6
X.name = "modifier_witch_doctor_talent_6"
d(X, l)
function X.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilityTalentValue("witch_doctor_talent_6", "interval")
	self.damage_base = self:GetAbilityTalentValue("witch_doctor_talent_6", "damage_base")
	self.damage_bonus = self:GetAbilityTalentValue("witch_doctor_talent_6", "damage_bonus")
	self.duration = self:GetAbilityTalentValue("witch_doctor_talent_6", "duration")
	self.talent_ability = self.parent:FindAbilityByName("witch_doctor_deadwisp")
end
function X.prototype.OnCreated(self, v)
	if IsServer() then
		self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 2.3)
		self.parent:EmitSound("Hero_Witchdoctor.Projection")
		self:CreateDummy()
		self:StartThink(self.interval, "Attack")
		self:StartThink(self.duration + 0.1, "Kill")
		self:SetStackCount(0)
	end
end
function X.prototype.OnThink(self, Y)
	if IsServer() then
		local Z = self.parent
		local B = self.parent:GetEnemy()
		local _ = self:GetAbility()
		if Y == "Kill" then
			self:Destroy()
		end
		if Y == "Attack" then
			if B:IsAlive() then
				local a0 = self.damage_base + GetScar(B) * self.damage_bonus * 0.01
				self.dummy:EmitSound("Hero_WitchDoctor_Ward.Attack")
				Projectile:CreateTrackingProjectile({
					EffectName = "particles/units/heroes/hero_witchdoctor/witchdoctor_ward_attack.vpcf",
					hCaster = Z,
					vSpawnOrigin = self.dummy:GetAbsOrigin() + Vector(0, 0, 100),
					hTarget = B,
					iMoveSpeed = 1200,
					OnProjectileHit = function(a1, a2, a3)
						if not (IsInjurable(B, Z) and IsValid(_)) then
							return
						end
						B:EmitSound("Hero_WitchDoctor_Ward.ProjectileImpact")
						Z:DealDamage(B, self.talent_ability, a0, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
					end,
				})
			end
		end
	end
end
function X.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent } }
end
function X.prototype.OnBattleEnd(self, v)
	if IsServer() then
		self:DestroyDummy()
	end
end
function X.prototype.OnDestroy(self)
	if IsServer() then
		self:DestroyDummy()
	end
end
function X.prototype.CreateDummy(self)
	local Z = self:GetParent()
	local a4 = GetGroundPosition(Z:GetAbsOrigin() + Z:GetForwardVector() * 100, nil)
	local a5 = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{ origin = a4, model = "models/heroes/witchdoctor/witchdoctor_ward.vmdl" }
	)
	local a6 = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_witchdoctor/witchdoctor_ward_skull.vpcf",
		PATTACH_CUSTOMORIGIN,
		Z
	)
	ParticleManager:SetParticleControlEnt(a6, 0, a5, PATTACH_POINT_FOLLOW, "attach_attack1", a5:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(a6, 1, a5, PATTACH_ABSORIGIN_FOLLOW, nil, a5:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(a6, 2, a5, PATTACH_ABSORIGIN_FOLLOW, nil, a5:GetAbsOrigin(), true)
	a5:EmitSound("Hero_WitchDoctor.Death_WardBuild")
	self.particle_id = a6
	self.dummy = a5
end
function X.prototype.DestroyDummy(self)
	if self.particle_id then
		ParticleManager:DestroyParticle(self.particle_id, false)
		self.particle_id = nil
	end
	if IsValid(self.dummy) then
		self.dummy:StopSound("Hero_WitchDoctor.Death_WardBuild")
		self.dummy:RemoveSelf()
		self.dummy = nil
	end
	self:StartThink(-1, "Attack")
	self:StartThink(-1, "Kill")
	self:StartIntervalThink(-1)
end
X = e(
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
	X
)
g.modifier_witch_doctor_talent_6 = X
g.modifier_shard_equipment = c()
local a7 = g.modifier_shard_equipment
a7.name = "modifier_shard_equipment"
d(a7, l)
function a7.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.recodeCount = -1
end
function a7.prototype.GetAbilitySpecialValue(self)
	self.win_gold = self:GetAbilityTalentValue("witch_doctor_shard", "win_gold")
	self.loss_ability = self:GetAbilityTalentValue("witch_doctor_shard", "loss_ability")
	self.count = self:GetAbilityTalentValue("witch_doctor_shard", "count")
end
function a7.prototype.OnCreated(self, v)
	if IsServer() then
		self.recodeCount = v.iShardCount
		if self.recodeCount == nil or self.recodeCount <= 0 then
			self:Destroy()
		end
	end
end
function a7.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent } }
end
function a7.prototype.OnBattleEnd(self, v)
	if v.isNeutral then
		return
	end
	local a8 = self.parent:GetPlayerOwnerID()
	if v.illusionPlayerID == a8 then
		return
	end
	if v.winPlayerID == a8 then
		PlayerData:modifyGold(a8, self.win_gold)
		Notification:combatToPlayer(
			a8,
			{
				message = "notify_bonus_gold",
				string_itemname_artifact = "DOTA_Tooltip_ability_witch_doctor_shard",
				int_gold = self.win_gold,
			}
		)
	else
		local a9 = AbilityShop:getRandomAbility(
			a8,
			self.loss_ability,
			{ specifySect = AbilityShop.pickList, isAbilityShop = false, specifyRarityIgnoreRule = true }
		)
		local _ = a9[1]
		PlayerData:getHero(a8):learnAbility(_.aid, true)
		Notification:combatToPlayer(
			a8,
			{
				message = "notify_artifact_ability_" .. _.rarity,
				string_itemname_artifact = "DOTA_Tooltip_ability_witch_doctor_shard",
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. _.aid,
			}
		)
	end
	PlayerData:saveData(a8, "witch_doctor_shard", self.recodeCount - 1)
end
a7 = e(
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
	a7
)
g.modifier_shard_equipment = a7
g.witch_doctor_interact = c()
local aa = g.witch_doctor_interact
aa.name = "witch_doctor_interact"
d(aa, r)
function aa.prototype.GetAbilityTextureName(self)
	if self:GetToggleState() and self:HasTalent("witch_doctor_shard") then
		return "witch_doctor_voodoo_switcheroo"
	else
		return "witch_doctor_paralyzing_cask"
	end
end
function aa.prototype.OnToggle(self)
	if IsServer() then
		local ab = self:GetCaster()
		if self:HasTalent("witch_doctor_shard") then
			local ac = self:GetToggleState()
			ab:RemoveModifierByName("modifier_witch_doctor_interact_inactive")
			ab:RemoveModifierByName("modifier_witch_doctor_interact_active")
			if ac then
				ab:AddNewModifier(ab, self, "modifier_witch_doctor_interact_active", nil)
			else
				ab:AddNewModifier(ab, self, "modifier_witch_doctor_interact_inactive", nil)
			end
		end
	end
end
function aa.prototype.CustomToggleEnable(self)
	if not self:HasTalent("witch_doctor_shard") then
		ErrorMessage(self:GetCaster():GetPlayerOwnerID(), "error_disabled_shard")
		return false
	end
	local ad = GameState:isCeaseFireState()
	if not ad then
		ErrorMessage(self:GetCaster():GetPlayerOwnerID(), "error_disabled_battling")
	end
	return ad
end
aa = e({ s(nil, {}) }, aa)
g.witch_doctor_interact = aa
g.modifier_witch_doctor_interact_active = c()
local ae = g.modifier_witch_doctor_interact_active
ae.name = "modifier_witch_doctor_interact_active"
d(ae, l)
ae = e({ m(a, { IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false }) }, ae)
g.modifier_witch_doctor_interact_active = ae
g.modifier_witch_doctor_interact_inactive = c()
local af = g.modifier_witch_doctor_interact_inactive
af.name = "modifier_witch_doctor_interact_inactive"
d(af, l)
af = e({ m(a, { IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false }) }, af)
g.modifier_witch_doctor_interact_inactive = af
return g