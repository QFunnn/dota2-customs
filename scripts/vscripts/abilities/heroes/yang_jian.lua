--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/yang_jian"
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
		["14"] = 4,
		["15"] = 4,
		["16"] = 4,
		["17"] = 5,
		["18"] = 5,
		["19"] = 5,
		["20"] = 8,
		["21"] = 9,
		["22"] = 10,
		["23"] = 11,
		["24"] = 13,
		["26"] = 20,
		["27"] = 21,
		["28"] = 20,
		["29"] = 21,
		["30"] = 22,
		["31"] = 22,
		["32"] = 22,
		["33"] = 25,
		["34"] = 25,
		["35"] = 25,
		["37"] = 25,
		["38"] = 25,
		["40"] = 26,
		["41"] = 27,
		["42"] = 28,
		["45"] = 29,
		["46"] = 30,
		["47"] = 31,
		["48"] = 32,
		["49"] = 33,
		["50"] = 33,
		["53"] = 35,
		["54"] = 36,
		["55"] = 36,
		["56"] = 36,
		["57"] = 36,
		["58"] = 36,
		["59"] = 36,
		["60"] = 36,
		["61"] = 36,
		["62"] = 36,
		["63"] = 37,
		["64"] = 37,
		["65"] = 37,
		["66"] = 37,
		["67"] = 37,
		["68"] = 37,
		["69"] = 37,
		["70"] = 37,
		["71"] = 37,
		["72"] = 38,
		["73"] = 39,
		["74"] = 40,
		["75"] = 41,
		["76"] = 43,
		["77"] = 25,
		["78"] = 21,
		["79"] = 20,
		["80"] = 21,
		["82"] = 21,
		["83"] = 47,
		["84"] = 48,
		["85"] = 47,
		["86"] = 48,
		["88"] = 48,
		["89"] = 49,
		["90"] = 50,
		["91"] = 51,
		["92"] = 52,
		["93"] = 54,
		["94"] = 47,
		["95"] = 55,
		["96"] = 56,
		["97"] = 56,
		["98"] = 56,
		["99"] = 59,
		["100"] = 59,
		["101"] = 59,
		["102"] = 56,
		["103"] = 56,
		["104"] = 55,
		["105"] = 62,
		["106"] = 63,
		["107"] = 64,
		["108"] = 65,
		["109"] = 66,
		["110"] = 67,
		["111"] = 68,
		["112"] = 69,
		["113"] = 70,
		["114"] = 71,
		["115"] = 72,
		["116"] = 73,
		["117"] = 74,
		["118"] = 75,
		["119"] = 76,
		["121"] = 62,
		["122"] = 79,
		["123"] = 80,
		["124"] = 81,
		["125"] = 82,
		["126"] = 84,
		["127"] = 84,
		["128"] = 84,
		["129"] = 85,
		["130"] = 85,
		["132"] = 86,
		["133"] = 87,
		["134"] = 88,
		["135"] = 89,
		["136"] = 89,
		["137"] = 89,
		["138"] = 89,
		["139"] = 89,
		["140"] = 89,
		["143"] = 84,
		["144"] = 84,
		["145"] = 79,
		["146"] = 94,
		["147"] = 95,
		["148"] = 96,
		["149"] = 97,
		["151"] = 94,
		["152"] = 100,
		["153"] = 100,
		["154"] = 100,
		["156"] = 100,
		["157"] = 101,
		["158"] = 102,
		["159"] = 103,
		["160"] = 104,
		["161"] = 105,
		["162"] = 106,
		["163"] = 107,
		["164"] = 108,
		["165"] = 109,
		["166"] = 109,
		["168"] = 101,
		["169"] = 111,
		["170"] = 112,
		["171"] = 113,
		["174"] = 114,
		["175"] = 115,
		["176"] = 116,
		["177"] = 117,
		["178"] = 118,
		["179"] = 118,
		["180"] = 118,
		["181"] = 118,
		["182"] = 118,
		["183"] = 118,
		["184"] = 118,
		["187"] = 121,
		["190"] = 122,
		["191"] = 111,
		["192"] = 124,
		["193"] = 125,
		["194"] = 126,
		["197"] = 127,
		["198"] = 127,
		["199"] = 127,
		["200"] = 127,
		["201"] = 127,
		["202"] = 127,
		["203"] = 127,
		["204"] = 128,
		["205"] = 129,
		["206"] = 130,
		["207"] = 131,
		["208"] = 132,
		["209"] = 132,
		["210"] = 132,
		["211"] = 132,
		["213"] = 134,
		["214"] = 124,
		["215"] = 136,
		["216"] = 136,
		["217"] = 136,
		["218"] = 137,
		["219"] = 138,
		["220"] = 139,
		["221"] = 139,
		["223"] = 141,
		["224"] = 142,
		["225"] = 142,
		["227"] = 144,
		["228"] = 144,
		["230"] = 145,
		["231"] = 137,
		["232"] = 147,
		["233"] = 148,
		["234"] = 149,
		["235"] = 150,
		["236"] = 150,
		["237"] = 150,
		["238"] = 150,
		["241"] = 151,
		["244"] = 152,
		["245"] = 153,
		["246"] = 147,
		["247"] = 48,
		["248"] = 47,
		["249"] = 48,
		["251"] = 48,
		["253"] = 158,
		["254"] = 159,
		["255"] = 158,
		["256"] = 159,
		["258"] = 159,
		["259"] = 160,
		["260"] = 158,
		["261"] = 162,
		["262"] = 162,
		["263"] = 162,
		["264"] = 163,
		["265"] = 163,
		["266"] = 163,
		["267"] = 164,
		["268"] = 164,
		["269"] = 164,
		["271"] = 164,
		["272"] = 164,
		["274"] = 165,
		["275"] = 166,
		["278"] = 167,
		["279"] = 168,
		["280"] = 168,
		["282"] = 169,
		["283"] = 170,
		["284"] = 171,
		["285"] = 172,
		["286"] = 174,
		["287"] = 175,
		["288"] = 176,
		["289"] = 177,
		["290"] = 178,
		["291"] = 179,
		["293"] = 182,
		["294"] = 183,
		["295"] = 184,
		["296"] = 184,
		["298"] = 185,
		["301"] = 187,
		["302"] = 188,
		["303"] = 189,
		["304"] = 190,
		["305"] = 191,
		["308"] = 192,
		["309"] = 193,
		["310"] = 164,
		["311"] = 159,
		["312"] = 158,
		["313"] = 159,
		["315"] = 159,
		["317"] = 198,
		["318"] = 199,
		["319"] = 198,
		["320"] = 199,
		["322"] = 199,
		["323"] = 200,
		["324"] = 201,
		["325"] = 198,
		["326"] = 202,
		["327"] = 203,
		["330"] = 204,
		["331"] = 205,
		["332"] = 202,
		["333"] = 207,
		["334"] = 207,
		["335"] = 207,
		["336"] = 207,
		["337"] = 208,
		["338"] = 209,
		["339"] = 210,
		["340"] = 211,
		["341"] = 212,
		["342"] = 213,
		["343"] = 214,
		["344"] = 215,
		["345"] = 217,
		["346"] = 208,
		["347"] = 219,
		["348"] = 220,
		["349"] = 221,
		["350"] = 222,
		["351"] = 223,
		["352"] = 219,
		["353"] = 225,
		["354"] = 226,
		["355"] = 227,
		["358"] = 231,
		["359"] = 232,
		["362"] = 235,
		["363"] = 225,
		["364"] = 237,
		["365"] = 238,
		["366"] = 239,
		["367"] = 239,
		["369"] = 240,
		["371"] = 237,
		["372"] = 242,
		["373"] = 243,
		["374"] = 243,
		["375"] = 243,
		["376"] = 243,
		["377"] = 242,
		["378"] = 245,
		["379"] = 246,
		["380"] = 246,
		["382"] = 247,
		["384"] = 245,
		["385"] = 249,
		["386"] = 249,
		["387"] = 249,
		["388"] = 249,
		["389"] = 249,
		["390"] = 249,
		["391"] = 250,
		["392"] = 251,
		["395"] = 252,
		["396"] = 253,
		["397"] = 254,
		["398"] = 254,
		["400"] = 250,
		["401"] = 199,
		["402"] = 198,
		["403"] = 198,
		["404"] = 198,
		["405"] = 198,
		["406"] = 198,
		["407"] = 198,
		["408"] = 198,
		["409"] = 199,
		["411"] = 199,
		["412"] = 258,
		["413"] = 259,
		["414"] = 258,
		["415"] = 259,
		["416"] = 260,
		["417"] = 261,
		["418"] = 260,
		["419"] = 263,
		["420"] = 264,
		["421"] = 264,
		["422"] = 264,
		["423"] = 264,
		["424"] = 265,
		["425"] = 266,
		["426"] = 266,
		["427"] = 266,
		["428"] = 266,
		["429"] = 267,
		["430"] = 268,
		["431"] = 268,
		["432"] = 268,
		["433"] = 268,
		["434"] = 269,
		["435"] = 269,
		["436"] = 269,
		["437"] = 269,
		["438"] = 269,
		["439"] = 269,
		["441"] = 271,
		["442"] = 272,
		["443"] = 274,
		["444"] = 274,
		["447"] = 276,
		["448"] = 263,
		["449"] = 278,
		["450"] = 279,
		["451"] = 280,
		["452"] = 281,
		["455"] = 282,
		["456"] = 283,
		["457"] = 285,
		["458"] = 285,
		["459"] = 285,
		["460"] = 285,
		["461"] = 286,
		["462"] = 286,
		["464"] = 287,
		["465"] = 287,
		["466"] = 287,
		["467"] = 287,
		["468"] = 287,
		["469"] = 287,
		["470"] = 289,
		["471"] = 289,
		["474"] = 278,
		["475"] = 292,
		["476"] = 293,
		["477"] = 292,
		["478"] = 295,
		["479"] = 295,
		["480"] = 295,
		["481"] = 296,
		["482"] = 296,
		["483"] = 296,
		["484"] = 259,
		["485"] = 258,
		["486"] = 259,
		["488"] = 259,
		["490"] = 300,
		["491"] = 301,
		["492"] = 300,
		["493"] = 301,
		["494"] = 302,
		["495"] = 303,
		["496"] = 305,
		["497"] = 305,
		["498"] = 306,
		["499"] = 306,
		["501"] = 307,
		["502"] = 307,
		["503"] = 307,
		["504"] = 307,
		["505"] = 307,
		["507"] = 305,
		["508"] = 308,
		["509"] = 308,
		["510"] = 308,
		["512"] = 308,
		["514"] = 308,
		["515"] = 309,
		["516"] = 302,
		["517"] = 311,
		["518"] = 311,
		["519"] = 311,
		["520"] = 312,
		["521"] = 312,
		["522"] = 312,
		["523"] = 313,
		["524"] = 301,
		["525"] = 313,
		["526"] = 314,
		["527"] = 314,
		["528"] = 314,
		["529"] = 315,
		["530"] = 316,
		["533"] = 319,
		["534"] = 320,
		["535"] = 320,
		["537"] = 315,
		["538"] = 301,
		["539"] = 300,
		["540"] = 301,
		["542"] = 301,
		["543"] = 324,
		["544"] = 325,
		["545"] = 324,
		["546"] = 325,
		["547"] = 326,
		["548"] = 327,
		["551"] = 328,
		["552"] = 329,
		["553"] = 326,
		["554"] = 331,
		["555"] = 332,
		["556"] = 333,
		["559"] = 334,
		["560"] = 335,
		["561"] = 335,
		["563"] = 337,
		["564"] = 331,
		["565"] = 325,
		["566"] = 324,
		["567"] = 325,
		["569"] = 325,
		["570"] = 341,
		["571"] = 342,
		["572"] = 341,
		["573"] = 342,
		["575"] = 342,
		["576"] = 344,
		["577"] = 345,
		["578"] = 346,
		["579"] = 347,
		["580"] = 348,
		["581"] = 349,
		["582"] = 341,
		["583"] = 350,
		["584"] = 351,
		["587"] = 352,
		["588"] = 353,
		["589"] = 354,
		["590"] = 354,
		["591"] = 354,
		["592"] = 354,
		["593"] = 356,
		["594"] = 357,
		["595"] = 357,
		["596"] = 357,
		["597"] = 357,
		["598"] = 357,
		["600"] = 358,
		["601"] = 360,
		["602"] = 360,
		["603"] = 360,
		["604"] = 361,
		["605"] = 362,
		["606"] = 363,
		["607"] = 363,
		["608"] = 363,
		["609"] = 363,
		["610"] = 363,
		["611"] = 363,
		["613"] = 360,
		["614"] = 360,
		["615"] = 366,
		["616"] = 367,
		["617"] = 368,
		["618"] = 368,
		["619"] = 368,
		["620"] = 368,
		["621"] = 368,
		["622"] = 368,
		["624"] = 350,
		["625"] = 371,
		["626"] = 372,
		["627"] = 373,
		["628"] = 371,
		["629"] = 375,
		["630"] = 376,
		["633"] = 377,
		["634"] = 378,
		["635"] = 380,
		["636"] = 380,
		["637"] = 380,
		["638"] = 380,
		["639"] = 380,
		["640"] = 380,
		["641"] = 380,
		["642"] = 380,
		["643"] = 380,
		["644"] = 380,
		["645"] = 380,
		["646"] = 380,
		["647"] = 380,
		["648"] = 380,
		["649"] = 380,
		["650"] = 392,
		["653"] = 393,
		["654"] = 393,
		["656"] = 394,
		["657"] = 375,
		["658"] = 396,
		["659"] = 397,
		["662"] = 399,
		["663"] = 399,
		["664"] = 399,
		["665"] = 399,
		["666"] = 399,
		["667"] = 399,
		["668"] = 399,
		["669"] = 399,
		["670"] = 400,
		["671"] = 400,
		["672"] = 400,
		["673"] = 400,
		["674"] = 400,
		["675"] = 400,
		["676"] = 400,
		["677"] = 400,
		["678"] = 396,
		["679"] = 402,
		["680"] = 403,
		["683"] = 404,
		["684"] = 405,
		["685"] = 402,
		["686"] = 407,
		["687"] = 408,
		["688"] = 409,
		["689"] = 411,
		["690"] = 411,
		["691"] = 411,
		["692"] = 411,
		["693"] = 411,
		["694"] = 411,
		["695"] = 411,
		["697"] = 413,
		["698"] = 413,
		["700"] = 407,
		["701"] = 415,
		["702"] = 416,
		["703"] = 417,
		["706"] = 420,
		["707"] = 421,
		["708"] = 424,
		["709"] = 426,
		["712"] = 427,
		["713"] = 428,
		["714"] = 429,
		["715"] = 430,
		["716"] = 431,
		["717"] = 432,
		["718"] = 433,
		["719"] = 434,
		["720"] = 435,
		["721"] = 436,
		["722"] = 437,
		["723"] = 438,
		["724"] = 439,
		["725"] = 439,
		["726"] = 439,
		["727"] = 439,
		["728"] = 439,
		["729"] = 440,
		["732"] = 415,
		["733"] = 444,
		["734"] = 445,
		["735"] = 445,
		["736"] = 445,
		["737"] = 445,
		["738"] = 444,
		["739"] = 450,
		["740"] = 450,
		["741"] = 450,
		["742"] = 451,
		["743"] = 451,
		["744"] = 451,
		["745"] = 452,
		["746"] = 453,
		["747"] = 453,
		["749"] = 454,
		["750"] = 454,
		["751"] = 454,
		["752"] = 454,
		["753"] = 454,
		["754"] = 454,
		["755"] = 454,
		["756"] = 454,
		["757"] = 454,
		["758"] = 454,
		["759"] = 454,
		["760"] = 452,
		["761"] = 466,
		["762"] = 467,
		["765"] = 468,
		["766"] = 469,
		["767"] = 470,
		["768"] = 470,
		["770"] = 471,
		["771"] = 472,
		["774"] = 473,
		["775"] = 474,
		["776"] = 474,
		["778"] = 466,
		["779"] = 342,
		["780"] = 341,
		["781"] = 341,
		["782"] = 341,
		["783"] = 341,
		["784"] = 341,
		["785"] = 341,
		["786"] = 341,
		["787"] = 342,
		["789"] = 342,
		["791"] = 479,
		["792"] = 480,
		["793"] = 479,
		["794"] = 480,
		["795"] = 481,
		["796"] = 481,
		["797"] = 481,
		["798"] = 480,
		["799"] = 479,
		["800"] = 480,
		["802"] = 480,
		["804"] = 485,
		["805"] = 486,
		["806"] = 485,
		["807"] = 486,
		["808"] = 487,
		["809"] = 487,
		["810"] = 487,
		["811"] = 486,
		["812"] = 485,
		["813"] = 486,
		["815"] = 486,
		["816"] = 490,
		["817"] = 491,
		["818"] = 490,
		["819"] = 491,
		["820"] = 492,
		["821"] = 493,
		["822"] = 493,
		["823"] = 493,
		["824"] = 493,
		["825"] = 492,
		["826"] = 495,
		["827"] = 496,
		["830"] = 497,
		["831"] = 498,
		["834"] = 499,
		["835"] = 500,
		["836"] = 500,
		["837"] = 500,
		["838"] = 500,
		["841"] = 501,
		["842"] = 502,
		["843"] = 495,
		["844"] = 491,
		["845"] = 490,
		["846"] = 491,
		["848"] = 491,
		["850"] = 507,
		["851"] = 508,
		["852"] = 507,
		["853"] = 508,
		["854"] = 509,
		["855"] = 509,
		["856"] = 509,
		["857"] = 508,
		["858"] = 507,
		["859"] = 508,
		["861"] = 508,
		["862"] = 512,
		["863"] = 513,
		["864"] = 512,
		["865"] = 513,
		["867"] = 513,
		["868"] = 514,
		["869"] = 515,
		["870"] = 516,
		["871"] = 512,
		["872"] = 517,
		["873"] = 518,
		["874"] = 518,
		["875"] = 520,
		["876"] = 520,
		["877"] = 520,
		["878"] = 518,
		["879"] = 518,
		["880"] = 517,
		["881"] = 523,
		["882"] = 523,
		["883"] = 523,
		["884"] = 523,
		["885"] = 523,
		["886"] = 524,
		["887"] = 524,
		["888"] = 524,
		["889"] = 524,
		["890"] = 525,
		["891"] = 525,
		["892"] = 525,
		["893"] = 526,
		["894"] = 528,
		["895"] = 528,
		["896"] = 528,
		["897"] = 528,
		["898"] = 526,
		["899"] = 530,
		["900"] = 531,
		["901"] = 532,
		["902"] = 532,
		["904"] = 533,
		["905"] = 533,
		["907"] = 534,
		["908"] = 536,
		["909"] = 536,
		["911"] = 537,
		["912"] = 538,
		["913"] = 538,
		["914"] = 538,
		["915"] = 538,
		["916"] = 538,
		["917"] = 538,
		["918"] = 539,
		["919"] = 540,
		["920"] = 542,
		["922"] = 544,
		["923"] = 545,
		["924"] = 545,
		["926"] = 546,
		["927"] = 547,
		["928"] = 548,
		["929"] = 549,
		["930"] = 550,
		["931"] = 551,
		["932"] = 552,
		["933"] = 552,
		["934"] = 552,
		["935"] = 553,
		["936"] = 553,
		["937"] = 553,
		["938"] = 553,
		["941"] = 554,
		["942"] = 555,
		["943"] = 556,
		["944"] = 556,
		["946"] = 552,
		["947"] = 552,
		["949"] = 559,
		["950"] = 530,
		["951"] = 513,
		["952"] = 512,
		["953"] = 513,
		["955"] = 513,
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
local t = "models/eom/hero/marina_1/marina_1_morph.vmdl"
local u = 1
local v = 60
local w = 80
local x = {
	{ activity = ACT_DOTA_CAST_ABILITY_1, name = "ACT_DOTA_CAST_ABILITY_1", sequence = "marina_1_attack_1_copy" },
	{ activity = ACT_DOTA_CAST_ABILITY_2, name = "ACT_DOTA_CAST_ABILITY_2", sequence = "marina_1_skill_1" },
	{ activity = ACT_DOTA_CAST_ABILITY_3, name = "ACT_DOTA_CAST_ABILITY_3", sequence = "marina_1_skill_2" },
}
g.yang_jian_talent = c()
local y = g.yang_jian_talent
y.name = "yang_jian_talent"
d(y, i)
function y.prototype.GetIntrinsicModifierName(self)
	return "modifier_yang_jian_talent"
end
function y.prototype.HeavenlyEye(self, z, A)
	if z == nil then
		z = 1
	end
	if A == nil then
		A = false
	end
	local B = self:GetCaster()
	local C = B:GetEnemy()
	if not IsInjurable(B, C) then
		return
	end
	local D = B:FindAbilityByName("yang_jian_interact")
	local E = IsValid(D) and D:IsUnlocked() and D:GetToggleState()
	if A and E then
		local F = B:FindModifierByName("modifier_yang_jian_insight")
		if IsValid(F) then
			F:SetStackCount(0)
		end
	end
	local G = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_lina/lina_spell_laguna_blade.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		B
	)
	ParticleManager:SetParticleControlEnt(G, 0, B, PATTACH_POINT_FOLLOW, "attach_hitloc", B:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(G, 1, C, PATTACH_POINT_FOLLOW, "attach_hitloc", C:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(G)
	B:EmitSound("Hero_Lina.LagunaBladeImpact")
	local H = E and D:GetSpecialValueFor("talent_damge_bonus") or 0
	local I = (B:GetMaxHealth() * self:GetSpecialValueFor("damage_health_pct") * 0.01 + H) * z
	B:DealDamage(C, self, I, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
end
y = e({ j(nil) }, y)
g.yang_jian_talent = y
g.modifier_yang_jian_talent = c()
local J = g.modifier_yang_jian_talent
J.name = "modifier_yang_jian_talent"
d(J, l)
function J.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.lostHealth = 0
	self.eyeUsed = false
	self.transformationUsed = false
	self.battling = false
	self.manaTick = 0
end
function J.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function J.prototype.OnBattleStartBefore(self)
	self:StopDamageHook()
	self.battling = false
	self.lostHealth = 0
	self.eyeUsed = false
	self.transformationUsed = false
	self.manaTick = 0
	local K = self:GetParent()
	K:RemoveModifierByName("modifier_yang_jian_strike_animation")
	K:RemoveModifierByName("modifier_yang_jian_transformation")
	K:RemoveModifierByName("modifier_yang_jian_invulnerable")
	local L = K:FindAbilityByName("yang_jian_ult")
	if IsValid(L) then
		L.combo = 0
		K:AddNewModifier(K, L, "modifier_yang_jian_insight", {}):SetStackCount(0)
	end
end
function J.prototype.OnBattleStart(self)
	self.battling = true
	self:StartIntervalThink(0.1)
	self:StopDamageHook()
	self.hookID = self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE, function(M, N, O, C)
		if C == self:GetParent() then
			self:OnCustomTakeDamage(N)
		end
		if O == self:GetParent() and N.ability == self:GetAbility() then
			local D = O:FindAbilityByName("yang_jian_interact")
			if IsInjurable(O) and IsValid(D) and D:IsUnlocked() and D:GetToggleState() then
				Heal(
					O,
					N.damage * D:GetSpecialValueFor("tian_reply_health_pct") * 0.01,
					self:GetAbility():GetAbilityName(),
					"Ability"
				)
			end
		end
	end)
end
function J.prototype.StopDamageHook(self)
	if self.hookID ~= nil then
		self:unhook(self.hookID)
		self.hookID = nil
	end
end
function J.prototype.OnDestroy(self)
	if IsServer() then
		self:StopDamageHook()
	end
end
function J.prototype.OnBattleEnd(self)
	self.battling = false
	self:StopDamageHook()
	self:StartIntervalThink(-1)
	self:GetParent():RemoveModifierByName("modifier_yang_jian_strike_animation")
	self:GetParent():RemoveModifierByName("modifier_yang_jian_transformation")
	self:GetParent():RemoveModifierByName("modifier_yang_jian_invulnerable")
	local F = self:GetParent():FindModifierByName("modifier_yang_jian_insight")
	if IsValid(F) then
		F:SetStackCount(0)
	end
end
function J.prototype.OnIntervalThink(self)
	local K = self:GetParent()
	if not self.battling or not IsInjurable(K) then
		return
	end
	self.manaTick = self.manaTick + 1
	if self.manaTick >= 10 then
		self.manaTick = 0
		if not K:PassivesDisabled() then
			RestoreCustomMana(
				K,
				self:GetAbilitySpecialValueFor("base_mana")
					+ math.floor(K:GetMaxHealth() / math.max(1, self:GetAbilitySpecialValueFor("health_base")))
						* self:GetAbilitySpecialValueFor("base_mana_add")
			)
		end
	end
	if K:PassivesDisabled() then
		return
	end
	self:TryHeavenlyEye(K:GetHealth())
end
function J.prototype.OnCustomTakeDamage(self, N)
	local K = self:GetParent()
	if not self.battling or not IsInjurable(K) or K:PassivesDisabled() then
		return
	end
	self.lostHealth = self.lostHealth + math.max(0, math.min(N.damage, N.original_health - K:GetHealth()))
	local P = self:GetAbilitySpecialValueFor("health_loss")
	if P > 0 and self.lostHealth >= P then
		local Q = math.floor(self.lostHealth / P)
		self.lostHealth = self.lostHealth - Q * P
		RestoreCustomMana(K, Q * self:GetAbilitySpecialValueFor("mana_add_once"))
	end
	self:TryHeavenlyEye(K:GetHealth())
end
function J.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_AVOID_DAMAGE }
end
function J.prototype.EOM_GetModifierAvoidDamage(self, R)
	local K = self:GetParent()
	if not self.battling or K:PassivesDisabled() then
		return 0
	end
	local S = K:FindModifierByName("modifier_yang_jian_talent_5")
	if IsValid(S) and S:TryProtect(R) then
		return 1
	end
	if R.damage >= K:GetHealth() then
		self:TryHeavenlyEye(K:GetHealth() - R.damage)
	end
	return 0
end
function J.prototype.TryHeavenlyEye(self, T)
	local K = self:GetParent()
	local U = K:FindModifierByName("modifier_sect_health")
	if
		not self.battling
		or self.eyeUsed
		or K:PassivesDisabled()
		or not IsInjurable(K, K:GetEnemy())
		or IsValid(U) and U.sr_respawn_enable
	then
		return
	end
	if T >= K:GetMaxHealth() * self:GetAbilitySpecialValueFor("health_pct") * 0.01 then
		return
	end
	self.eyeUsed = true
	self:GetAbility():HeavenlyEye(1, true)
end
J = e({ m(a, { IsHidden = true, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }) }, J)
g.modifier_yang_jian_talent = J
g.yang_jian_ult = c()
local V = g.yang_jian_ult
V.name = "yang_jian_ult"
d(V, o)
function V.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.combo = 0
end
function V.prototype.GetCastAnimation(self)
	return -1
end
function V.prototype.OnSpellStart(self)
	self:Strike(self:GetCaster():GetEnemy())
end
function V.prototype.Strike(self, C, W, X)
	if W == nil then
		W = false
	end
	if X == nil then
		X = 0
	end
	local B = self:GetCaster()
	if not IsInjurable(B, C) then
		return
	end
	local Y = W and X or self.combo
	if not W then
		self.combo = (Y + 1) % 3
	end
	local I = self:GetSpecialValueFor("pi_damage")
	local Z = self:GetSpecialValueFor("pi_point")
	local _ = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
	if Y == 1 then
		I = self:GetSpecialValueFor("ci_damge_base") + C:GetHealth() * self:GetSpecialValueFor("ci_damage_pct") * 0.01
		Z = self:GetSpecialValueFor("ci_point")
	elseif Y == 2 then
		I = self:GetSpecialValueFor("sao_damage_base")
			+ B:GetMaxHealth() * self:GetSpecialValueFor("sao_damage_pct") * 0.01
		Z = self:GetSpecialValueFor("sao_point")
		_ = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE
	end
	if not W then
		local a0 = B:FindModifierByName("modifier_yang_jian_strike_animation")
		if IsValid(a0) then
			a0:QueueStrike(Y)
		else
			B:AddNewModifier(B, self, "modifier_yang_jian_strike_animation", { step = Y })
		end
	end
	local G = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_monkey_king/monkey_king_strike_hit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		C
	)
	ParticleManager:ReleaseParticleIndex(G)
	B:EmitSound("Hero_MonkeyKing.Strike.Impact")
	B:DealDamage(C, self, I, _)
	if not IsInjurable(B) then
		return
	end
	local F = B:AddNewModifier(B, self, "modifier_yang_jian_insight", {})
	F:AddInsight(Z)
end
V = e({ p(nil) }, V)
g.yang_jian_ult = V
g.modifier_yang_jian_strike_animation = c()
local a1 = g.modifier_yang_jian_strike_animation
a1.name = "modifier_yang_jian_strike_animation"
d(a1, l)
function a1.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.pendingSteps = {}
	self.animationEndTime = 0
end
function a1.prototype.OnCreated(self, R)
	if not IsServer() then
		return
	end
	self:PlayStrike(R.step)
	self:StartIntervalThink(FrameTime())
end
function a1.prototype.QueueStrike(self, Y)
	local a2 = self.pendingSteps
	a2[#a2 + 1] = Y
end
function a1.prototype.PlayStrike(self, Y)
	local K = self:GetParent()
	local a0 = x[Y + 1]
	self:SetStackCount(Y + 1)
	local a3 = K:SequenceDuration(a0.sequence)
	local a4 = a3 > 0 and a3 or 1
	self.animationEndTime = GameRules:GetGameTime() + a4
	self:RemoveAttackGestures()
	K:StartGestureWithPlaybackRate(a0.activity, 1)
end
function a1.prototype.RemoveAttackGestures(self)
	local K = self:GetParent()
	K:RemoveGesture(ACT_DOTA_ATTACK)
	K:RemoveGesture(ACT_DOTA_ATTACK2)
	K:RemoveGesture(ACT_DOTA_ATTACK_EVENT)
end
function a1.prototype.OnIntervalThink(self)
	if not IsInjurable(self:GetParent()) then
		self:Destroy()
		return
	end
	if GameRules:GetGameTime() >= self.animationEndTime then
		self:FinishStrike()
		return
	end
	self:RemoveAttackGestures()
end
function a1.prototype.FinishStrike(self)
	self:GetParent():RemoveGesture(self:GetStrikeActivity())
	if #self.pendingSteps > 0 then
		self:PlayStrike(table.remove(self.pendingSteps, 1))
	else
		self:Destroy()
	end
end
function a1.prototype.EDeclareEvents(self)
	return { [MODIFIER_EVENT_ON_ATTACK_START] = { self:GetParent(), -1 } }
end
function a1.prototype.OnAttackStart(self)
	if GameRules:GetGameTime() >= self.animationEndTime then
		self:FinishStrike()
	else
		self:RemoveAttackGestures()
	end
end
function a1.prototype.GetStrikeActivity(self)
	return x[math.max(0, self:GetStackCount() - 1) + 1].activity
end
function a1.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	self.pendingSteps = {}
	if IsValid(self:GetParent()) then
		self:GetParent():RemoveGesture(self:GetStrikeActivity())
	end
end
a1 = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_SUPER_ULTRA,
			}
		),
	},
	a1
)
g.modifier_yang_jian_strike_animation = a1
g.modifier_yang_jian_insight = c()
local a5 = g.modifier_yang_jian_insight
a5.name = "modifier_yang_jian_insight"
d(a5, l)
function a5.prototype.GetTexture(self)
	return "yang_jian_eyes"
end
function a5.prototype.AddInsight(self, Q)
	self:SetStackCount(math.min(self:GetAbilitySpecialValueFor("point_limit"), self:GetStackCount() + Q))
	local K = self:GetParent()
	if
		self:HasTalent("yang_jian_talent_4")
		and self:PRD(self:GetAbilityTalentValue("yang_jian_talent_4", "chance"), "yang_jian_talent_4")
	then
		local a6 = K:FindModifierByName("modifier_yang_jian_invulnerable")
		local a4 = math.max(
			self:GetAbilityTalentValue("yang_jian_talent_4", "invincible_duration"),
			IsValid(a6) and a6:GetRemainingTime() or 0
		)
		K:AddNewModifier(K, self:GetAbility(), "modifier_yang_jian_invulnerable", { duration = a4 })
	end
	if self:HasTalent("yang_jian_talent_6") then
		local A = K:FindAbilityByName("yang_jian_talent")
		if IsValid(A) then
			A:HeavenlyEye(self:GetAbilityTalentValue("yang_jian_talent_6", "chance") * 0.01)
		end
	end
	self:TryTransform()
end
function a5.prototype.TryTransform(self)
	local K = self:GetParent()
	local D = K:FindAbilityByName("yang_jian_interact")
	if
		not IsValid(D)
		or not D:IsUnlocked()
		or D:GetToggleState()
		or K:HasModifier("modifier_yang_jian_transformation")
	then
		return
	end
	local A = K:FindModifierByName("modifier_yang_jian_talent")
	local a7 = IsValid(A)
			and not A.transformationUsed
			and self:HasTalent("yang_jian_talent_3")
			and self:GetAbilityTalentValue("yang_jian_talent_3", "first_reduce")
		or 0
	if self:GetStackCount() >= math.max(0, D:GetSpecialValueFor("fa_point_stack") - a7) then
		if IsValid(A) then
			A.transformationUsed = true
		end
		local a8 = K:AddNewModifier(
			K,
			D,
			"modifier_yang_jian_transformation",
			{ duration = D:GetSpecialValueFor("fa_duration") }
		)
		if IsValid(a8) then
			a8:OnIntervalThink()
		end
	end
end
function a5.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_SUREHIT_CHANCE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end
function a5.prototype.EOM_GetModifierSurehitChance(self)
	return self:GetStackCount() * self:GetAbilitySpecialValueFor("point_hit_rate")
end
function a5.prototype.EOM_GetModifierIncomingDamagePercentage(self)
	return -self:GetStackCount() * self:GetAbilitySpecialValueFor("point_damage_reduce_pct")
end
a5 = e({ m(a, { IsHidden = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }) }, a5)
g.modifier_yang_jian_insight = a5
g.yang_jian_interact = c()
local a9 = g.yang_jian_interact
a9.name = "yang_jian_interact"
d(a9, r)
function a9.prototype.GetAbilityTextureName(self)
	local aa = self:GetCaster():GetPlayerOwnerID()
	local ab
	if IsServer() then
		local ac = PlayerData:getplayerData(aa)
		ab = ac and ac:GetInteractiveAbilityState()
	else
		local ad = CustomNetTables:GetTableValue("player_data", tostring(aa))
		ab = ad and ad.interAbilityState
	end
	local ae = ab
	local af
	if ae == nil then
		af = self:GetToggleState()
	else
		af = ae == true or ae == 1
	end
	local ag = af
	return ag and "yang_jian_eyes" or "yang_jian_fantasy"
end
function a9.prototype.GetIntrinsicModifierName(self)
	return "modifier_yang_jian_interact"
end
function a9.prototype.IsUnlocked(self)
	return self:HasTalent("yang_jian_talent_1") or self:HasTalent("yang_jian_talent_2")
end
function a9.prototype.CustomToggleEnable(self)
	return self:IsUnlocked() and r.prototype.CustomToggleEnable(self)
end
function a9.prototype.OnSpellStart(self)
	self:RestoreToggleState()
end
function a9.prototype.RestoreToggleState(self)
	if not IsServer() or not self:IsUnlocked() then
		return
	end
	local ah = PlayerData:getplayerData(self:GetCaster():GetPlayerOwnerID())
	if ah and self:GetToggleState() ~= ah:GetInteractiveAbilityState() then
		self:ToggleAbility()
	end
end
a9 = e({ s(nil, { InactiveTextureName = "yang_jian_fantasy", ActiveTextureName = "yang_jian_eyes" }) }, a9)
g.yang_jian_interact = a9
g.modifier_yang_jian_interact = c()
local ai = g.modifier_yang_jian_interact
ai.name = "modifier_yang_jian_interact"
d(ai, l)
function ai.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:OnIntervalThink()
	self:StartIntervalThink(0.1)
end
function ai.prototype.OnIntervalThink(self)
	local aj = self:GetAbility()
	if not IsValid(aj) then
		return
	end
	local ak = aj:IsUnlocked()
	if aj:IsActivated() ~= ak then
		aj:SetActivated(ak)
	end
	aj:RestoreToggleState()
end
ai = e({ m(a, { IsHidden = true, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }) }, ai)
g.modifier_yang_jian_interact = ai
g.modifier_yang_jian_transformation = c()
local al = g.modifier_yang_jian_transformation
al.name = "modifier_yang_jian_transformation"
d(al, l)
function al.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.nextStrikeTime = 0
	self.remainingStrikes = 0
	self.automaticCombo = 0
	self.avatarPlaybackRate = 1
	self.avatarAnimationEndTime = 0
	self.autoStriking = false
end
function al.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:CreateAvatar("marina_1_idle")
	self.nextStrikeTime = GameRules:GetGameTime()
	self.remainingStrikes = math.max(0, math.ceil(self:GetAbilitySpecialValueFor("fa_duration")))
	local am = 0.85
	for an, ao in ipairs(x) do
		am = math.max(am, self:GetParent():SequenceDuration(ao.sequence))
	end
	self.avatarPlaybackRate = am / 0.85
	self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE, function(M, N, O)
		local K = self:GetParent()
		if self.autoStriking and O == K and N.ability == K:FindAbilityByName("yang_jian_ult") and IsInjurable(K) then
			AddShield(
				K,
				N.damage * self:GetAbilitySpecialValueFor("fa_damage_shield") * 0.01,
				self:GetAbility():GetAbilityName(),
				"Ability"
			)
		end
	end)
	self:StartIntervalThink(FrameTime())
	if self:HasTalent("yang_jian_talent_3") then
		AddShield(
			self:GetParent(),
			self:GetAbilityTalentValue("yang_jian_talent_3", "shield_count"),
			"yang_jian_talent_3",
			"Ability"
		)
	end
end
function al.prototype.GetAvatarPosition(self)
	local K = self:GetParent()
	return K:GetAbsOrigin() + K:GetForwardVector() * -v + Vector(0, 0, w)
end
function al.prototype.CreateAvatar(self, a0)
	if not IsServer() then
		return
	end
	local K = self:GetParent()
	local z = K:GetModelScale() * u
	local ap = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{
			model = t,
			origin = self:GetAvatarPosition(),
			angles = VectorToAngles(K:GetForwardVector()),
			scales = (((tostring(z) .. " ") .. tostring(z)) .. " ") .. tostring(z),
			StartingAnim = a0,
			StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
			IdleAnim = "marina_1_idle",
			AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			use_animgraph = "0",
			solid = "0",
		}
	)
	if not IsValid(ap) then
		return
	end
	if IsValid(self.avatar) then
		UTIL_Remove(self.avatar)
	end
	self.avatar = ap
end
function al.prototype.PlayAvatarAttack(self, a0, aq)
	if not IsValid(self.avatar) then
		return
	end
	DoEntFireByInstanceHandle(self.avatar, "SetAnimationNotLooping", a0, 0, self:GetParent(), self:GetParent())
	DoEntFireByInstanceHandle(self.avatar, "SetPlaybackRate", tostring(aq), 0, self:GetParent(), self:GetParent())
end
function al.prototype.SyncAvatar(self)
	if not IsServer() or not IsValid(self.avatar) then
		return
	end
	self.avatar:SetAbsOrigin(self:GetAvatarPosition())
	self.avatar:SetForwardVector(self:GetParent():GetForwardVector())
end
function al.prototype.EnsurePermanentShield(self)
	local K = self:GetParent()
	local ar = K:FindModifierByName("modifier_shield_permanent")
	if not IsValid(ar) then
		ar = K:AddNewModifier(K, self:GetAbility(), "modifier_shield_permanent", {})
	end
	if IsValid(ar) then
		ar:OnIntervalThink()
	end
end
function al.prototype.OnIntervalThink(self)
	if not IsValid(self:GetParent()) or not self:GetParent():IsAlive() then
		self:Destroy()
		return
	end
	self:SyncAvatar()
	self:EnsurePermanentShield()
	if self.remainingStrikes > 0 and GameRules:GetGameTime() >= self.nextStrikeTime then
		if GameRules:GetGameTime() < self.avatarAnimationEndTime then
			return
		end
		self.nextStrikeTime = self.nextStrikeTime + 1
		self.remainingStrikes = self.remainingStrikes - 1
		local K = self:GetParent()
		local L = K:FindAbilityByName("yang_jian_ult")
		if IsValid(L) then
			local Y = self.automaticCombo
			self.automaticCombo = (Y + 1) % 3
			local a0 = x[Y + 1]
			local a4 = K:SequenceDuration(a0.sequence)
			self.avatarAnimationEndTime = GameRules:GetGameTime() + (a4 > 0 and a4 or 1) / self.avatarPlaybackRate
			self:PlayAvatarAttack(a0.sequence, self.avatarPlaybackRate)
			self.autoStriking = true
			L:Strike(K:GetEnemy(), true, Y)
			self.autoStriking = false
		end
	end
end
function al.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS_PERCENTAGE] = self:GetAbilitySpecialValueFor(
			"fa_max_health_pct"
		),
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_PERMANENT] = self:GetAbilitySpecialValueFor("fa_shield"),
	}
end
function al.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE }
end
function al.prototype.GetModifierModelScale(self)
	return 30
end
function al.prototype.CheckState(self)
	if not self:HasTalent("yang_jian_talent_3") then
		return {}
	end
	return {
		[MODIFIER_STATE_STUNNED] = false,
		[MODIFIER_STATE_HEXED] = false,
		[MODIFIER_STATE_ROOTED] = false,
		[MODIFIER_STATE_SILENCED] = false,
		[MODIFIER_STATE_DISARMED] = false,
		[MODIFIER_STATE_FEARED] = false,
		[MODIFIER_STATE_TAUNTED] = false,
		[MODIFIER_STATE_PASSIVES_DISABLED] = false,
		[MODIFIER_STATE_MUTED] = false,
	}
end
function al.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	self.remainingStrikes = 0
	if IsValid(self.avatar) then
		UTIL_Remove(self.avatar)
	end
	self.avatar = nil
	if not IsValid(self:GetParent()) then
		return
	end
	local F = self:GetParent():FindModifierByName("modifier_yang_jian_insight")
	if IsValid(F) then
		F:SetStackCount(0)
	end
end
al = e(
	{
		m(
			a,
			{
				IsHidden = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_SUPER_ULTRA,
			}
		),
	},
	al
)
g.modifier_yang_jian_transformation = al
g.modifier_yang_jian_invulnerable = c()
local as = g.modifier_yang_jian_invulnerable
as.name = "modifier_yang_jian_invulnerable"
d(as, l)
function as.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true }
end
as = e({ m(a, { IsHidden = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }) }, as)
g.modifier_yang_jian_invulnerable = as
g.yang_jian_shard = c()
local at = g.yang_jian_shard
at.name = "yang_jian_shard"
d(at, i)
function at.prototype.GetIntrinsicModifierName(self)
	return "modifier_yang_jian_shard"
end
at = e({ j(nil) }, at)
g.yang_jian_shard = at
g.modifier_yang_jian_shard = c()
local au = g.modifier_yang_jian_shard
au.name = "modifier_yang_jian_shard"
d(au, l)
function au.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self:GetParent(), -1 } }
end
function au.prototype.OnEvasion(self)
	if not IsServer() then
		return
	end
	local K = self:GetParent()
	if not IsInjurable(K) or K:PassivesDisabled() then
		return
	end
	local L = K:FindAbilityByName("yang_jian_ult")
	if not IsValid(L) or not self:PRD(self:GetAbilitySpecialValueFor("chance"), "yang_jian_shard") then
		return
	end
	local F = K:AddNewModifier(K, L, "modifier_yang_jian_insight", {})
	F:AddInsight(self:GetAbilitySpecialValueFor("count"))
end
au = e({ m(a, { IsHidden = true, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }) }, au)
g.modifier_yang_jian_shard = au
g.yang_jian_talent_5 = c()
local av = g.yang_jian_talent_5
av.name = "yang_jian_talent_5"
d(av, i)
function av.prototype.GetIntrinsicModifierName(self)
	return "modifier_yang_jian_talent_5"
end
av = e({ j(nil) }, av)
g.yang_jian_talent_5 = av
g.modifier_yang_jian_talent_5 = c()
local aw = g.modifier_yang_jian_talent_5
aw.name = "modifier_yang_jian_talent_5"
d(aw, l)
function aw.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.used = false
	self.battling = false
	self.battleId = 0
end
function aw.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function aw.prototype.OnBattleStartBefore(self)
	self.used = false
	self.battling = true
	self.battleId = self.battleId + 1
end
function aw.prototype.OnBattleEnd(self)
	self.battling = false
	self.battleId = self.battleId + 1
end
function aw.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_CONSTANT }
end
function aw.prototype.EOM_GetModifierOutgoingDamageConstant(self)
	return GetSectHealthModifiedValue(self:GetParent(), self:GetSectSpecialValueFor("197", "sr_197_health"))
end
function aw.prototype.TryProtect(self, R)
	local K = self:GetParent()
	if not self.battling or self.used or K:PassivesDisabled() or R.damage < K:GetHealth() then
		return false
	end
	if bit.band(R.damage_flags, DamageFlags.DAMAGE_FLAG_NO_LETHAL) ~= 0 or K:HasModifier("modifier_sect_regen_143") then
		return false
	end
	local T = K:FindModifierByName("modifier_sect_health")
	if IsValid(T) and T.sr_respawn_enable then
		return false
	end
	self.used = true
	K:AddNewModifier(
		K,
		self:GetAbility(),
		"modifier_yang_jian_invulnerable",
		{ duration = self:GetAbilitySpecialValueFor("invincible_duration") }
	)
	K:SetHealth(1)
	if IsValid(T) and T.sr_58_health_pct > 0 then
		T.sr_respawn_enable = true
	end
	local A = K:FindModifierByName("modifier_yang_jian_talent")
	if IsValid(A) then
		A:TryHeavenlyEye(K:GetHealth())
	end
	local ax = K:FindAbilityByName("sect_health")
	if IsValid(ax) and self:GetSectSpecialValueFor("153", "sr_153_interval") > 0 then
		local Q = self:GetAbilitySpecialValueFor("gu_damage_count")
		local ay = self:GetAbilitySpecialValueFor("gu_duration") / math.max(1, Q)
		local az = self.battleId
		local aA = Q
		K:GameTimer(ay, function()
			if
				not IsValid(self)
				or not self.battling
				or self.battleId ~= az
				or not IsValid(ax)
				or not IsInjurable(K, K:GetEnemy())
			then
				return
			end
			ax:TriggerByName("153")
			aA = aA - 1
			if aA > 0 then
				return ay
			end
		end)
	end
	return true
end
aw = e({ m(a, { IsHidden = true, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }) }, aw)
g.modifier_yang_jian_talent_5 = aw
return g