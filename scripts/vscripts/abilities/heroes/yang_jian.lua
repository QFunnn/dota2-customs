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
		["31"] = 23,
		["32"] = 22,
		["33"] = 27,
		["34"] = 27,
		["35"] = 27,
		["37"] = 27,
		["38"] = 27,
		["40"] = 28,
		["41"] = 29,
		["42"] = 30,
		["45"] = 31,
		["46"] = 32,
		["47"] = 33,
		["48"] = 34,
		["49"] = 35,
		["50"] = 35,
		["53"] = 37,
		["54"] = 38,
		["55"] = 38,
		["56"] = 38,
		["57"] = 38,
		["58"] = 38,
		["59"] = 38,
		["60"] = 38,
		["61"] = 38,
		["62"] = 38,
		["63"] = 39,
		["64"] = 39,
		["65"] = 39,
		["66"] = 39,
		["67"] = 39,
		["68"] = 39,
		["69"] = 39,
		["70"] = 39,
		["71"] = 39,
		["72"] = 40,
		["73"] = 41,
		["74"] = 42,
		["75"] = 43,
		["76"] = 45,
		["77"] = 27,
		["78"] = 21,
		["79"] = 20,
		["80"] = 21,
		["82"] = 21,
		["83"] = 49,
		["84"] = 55,
		["85"] = 49,
		["86"] = 55,
		["88"] = 55,
		["89"] = 56,
		["90"] = 57,
		["91"] = 58,
		["92"] = 59,
		["93"] = 61,
		["94"] = 49,
		["95"] = 62,
		["96"] = 63,
		["97"] = 63,
		["98"] = 63,
		["99"] = 66,
		["100"] = 66,
		["101"] = 66,
		["102"] = 63,
		["103"] = 63,
		["104"] = 62,
		["105"] = 69,
		["106"] = 70,
		["107"] = 71,
		["108"] = 72,
		["109"] = 73,
		["110"] = 74,
		["111"] = 75,
		["112"] = 76,
		["113"] = 77,
		["114"] = 78,
		["115"] = 79,
		["116"] = 80,
		["117"] = 81,
		["118"] = 82,
		["119"] = 83,
		["121"] = 69,
		["122"] = 86,
		["123"] = 87,
		["124"] = 88,
		["125"] = 89,
		["126"] = 91,
		["127"] = 91,
		["128"] = 91,
		["129"] = 92,
		["130"] = 92,
		["132"] = 93,
		["133"] = 94,
		["134"] = 95,
		["135"] = 96,
		["136"] = 96,
		["137"] = 96,
		["138"] = 96,
		["139"] = 96,
		["140"] = 96,
		["143"] = 91,
		["144"] = 91,
		["145"] = 86,
		["146"] = 101,
		["147"] = 102,
		["148"] = 103,
		["149"] = 104,
		["151"] = 101,
		["152"] = 107,
		["153"] = 108,
		["154"] = 108,
		["156"] = 107,
		["157"] = 110,
		["158"] = 111,
		["159"] = 112,
		["160"] = 113,
		["161"] = 114,
		["162"] = 115,
		["163"] = 116,
		["164"] = 117,
		["165"] = 118,
		["166"] = 118,
		["168"] = 110,
		["169"] = 120,
		["170"] = 121,
		["171"] = 122,
		["174"] = 123,
		["175"] = 124,
		["176"] = 125,
		["177"] = 126,
		["178"] = 127,
		["179"] = 127,
		["180"] = 127,
		["181"] = 127,
		["182"] = 127,
		["183"] = 127,
		["184"] = 127,
		["187"] = 130,
		["190"] = 131,
		["191"] = 120,
		["192"] = 133,
		["193"] = 134,
		["194"] = 135,
		["197"] = 136,
		["198"] = 136,
		["199"] = 136,
		["200"] = 136,
		["201"] = 136,
		["202"] = 136,
		["203"] = 136,
		["204"] = 137,
		["205"] = 138,
		["206"] = 139,
		["207"] = 140,
		["208"] = 141,
		["209"] = 141,
		["210"] = 141,
		["211"] = 141,
		["213"] = 143,
		["214"] = 133,
		["215"] = 145,
		["216"] = 146,
		["217"] = 145,
		["218"] = 148,
		["219"] = 149,
		["220"] = 150,
		["221"] = 150,
		["223"] = 152,
		["224"] = 153,
		["225"] = 153,
		["227"] = 155,
		["228"] = 155,
		["230"] = 156,
		["231"] = 148,
		["232"] = 158,
		["233"] = 159,
		["234"] = 160,
		["235"] = 161,
		["236"] = 161,
		["237"] = 161,
		["238"] = 161,
		["241"] = 162,
		["244"] = 163,
		["245"] = 164,
		["246"] = 158,
		["247"] = 55,
		["248"] = 49,
		["249"] = 55,
		["251"] = 55,
		["253"] = 169,
		["254"] = 170,
		["255"] = 169,
		["256"] = 170,
		["258"] = 170,
		["259"] = 171,
		["260"] = 169,
		["261"] = 173,
		["262"] = 174,
		["263"] = 173,
		["264"] = 176,
		["265"] = 177,
		["266"] = 176,
		["267"] = 179,
		["268"] = 179,
		["269"] = 179,
		["271"] = 179,
		["272"] = 179,
		["274"] = 180,
		["275"] = 181,
		["278"] = 182,
		["279"] = 183,
		["280"] = 183,
		["282"] = 184,
		["283"] = 185,
		["284"] = 186,
		["285"] = 187,
		["286"] = 189,
		["287"] = 190,
		["288"] = 191,
		["289"] = 192,
		["290"] = 193,
		["291"] = 194,
		["293"] = 197,
		["294"] = 198,
		["295"] = 199,
		["296"] = 199,
		["298"] = 200,
		["301"] = 202,
		["302"] = 203,
		["303"] = 204,
		["304"] = 205,
		["305"] = 206,
		["308"] = 207,
		["309"] = 208,
		["310"] = 179,
		["311"] = 170,
		["312"] = 169,
		["313"] = 170,
		["315"] = 170,
		["317"] = 213,
		["318"] = 220,
		["319"] = 213,
		["320"] = 220,
		["322"] = 220,
		["323"] = 221,
		["324"] = 222,
		["325"] = 213,
		["326"] = 223,
		["327"] = 224,
		["330"] = 225,
		["331"] = 226,
		["332"] = 223,
		["333"] = 228,
		["334"] = 229,
		["335"] = 229,
		["336"] = 228,
		["337"] = 231,
		["338"] = 232,
		["339"] = 233,
		["340"] = 234,
		["341"] = 235,
		["342"] = 236,
		["343"] = 237,
		["344"] = 238,
		["345"] = 240,
		["346"] = 231,
		["347"] = 242,
		["348"] = 243,
		["349"] = 244,
		["350"] = 245,
		["351"] = 246,
		["352"] = 242,
		["353"] = 248,
		["354"] = 249,
		["355"] = 250,
		["358"] = 254,
		["359"] = 255,
		["362"] = 258,
		["363"] = 248,
		["364"] = 260,
		["365"] = 261,
		["366"] = 262,
		["367"] = 262,
		["369"] = 263,
		["371"] = 260,
		["372"] = 265,
		["373"] = 266,
		["374"] = 266,
		["375"] = 266,
		["376"] = 266,
		["377"] = 265,
		["378"] = 268,
		["379"] = 269,
		["380"] = 269,
		["382"] = 270,
		["384"] = 268,
		["385"] = 272,
		["386"] = 273,
		["387"] = 273,
		["388"] = 273,
		["389"] = 273,
		["390"] = 272,
		["391"] = 275,
		["392"] = 276,
		["395"] = 277,
		["396"] = 278,
		["397"] = 279,
		["398"] = 279,
		["400"] = 275,
		["401"] = 220,
		["402"] = 213,
		["403"] = 213,
		["404"] = 213,
		["405"] = 213,
		["406"] = 213,
		["407"] = 213,
		["408"] = 213,
		["409"] = 220,
		["411"] = 220,
		["412"] = 283,
		["413"] = 289,
		["414"] = 283,
		["415"] = 289,
		["416"] = 290,
		["417"] = 291,
		["418"] = 290,
		["419"] = 293,
		["420"] = 294,
		["421"] = 294,
		["422"] = 294,
		["423"] = 294,
		["424"] = 295,
		["425"] = 296,
		["426"] = 296,
		["427"] = 296,
		["428"] = 296,
		["429"] = 297,
		["430"] = 298,
		["431"] = 298,
		["432"] = 298,
		["433"] = 298,
		["434"] = 299,
		["435"] = 299,
		["436"] = 299,
		["437"] = 299,
		["438"] = 299,
		["439"] = 299,
		["441"] = 301,
		["442"] = 302,
		["443"] = 304,
		["444"] = 304,
		["447"] = 306,
		["448"] = 293,
		["449"] = 308,
		["450"] = 309,
		["451"] = 310,
		["452"] = 311,
		["455"] = 312,
		["456"] = 313,
		["457"] = 315,
		["458"] = 315,
		["459"] = 315,
		["460"] = 315,
		["461"] = 316,
		["462"] = 316,
		["464"] = 317,
		["465"] = 317,
		["466"] = 317,
		["467"] = 317,
		["468"] = 317,
		["469"] = 317,
		["470"] = 319,
		["471"] = 319,
		["474"] = 308,
		["475"] = 322,
		["476"] = 323,
		["477"] = 322,
		["478"] = 325,
		["479"] = 326,
		["480"] = 325,
		["481"] = 328,
		["482"] = 329,
		["483"] = 328,
		["484"] = 289,
		["485"] = 283,
		["486"] = 289,
		["488"] = 289,
		["490"] = 334,
		["491"] = 338,
		["492"] = 334,
		["493"] = 338,
		["494"] = 339,
		["495"] = 340,
		["496"] = 342,
		["497"] = 342,
		["498"] = 343,
		["499"] = 343,
		["501"] = 344,
		["502"] = 344,
		["503"] = 344,
		["504"] = 344,
		["505"] = 344,
		["507"] = 342,
		["508"] = 345,
		["509"] = 345,
		["510"] = 345,
		["512"] = 345,
		["514"] = 345,
		["515"] = 346,
		["516"] = 339,
		["517"] = 348,
		["518"] = 349,
		["519"] = 348,
		["520"] = 351,
		["521"] = 352,
		["522"] = 351,
		["523"] = 354,
		["524"] = 338,
		["525"] = 354,
		["526"] = 357,
		["527"] = 358,
		["528"] = 357,
		["529"] = 360,
		["530"] = 361,
		["533"] = 364,
		["534"] = 365,
		["535"] = 365,
		["537"] = 360,
		["538"] = 338,
		["539"] = 334,
		["540"] = 338,
		["542"] = 338,
		["543"] = 369,
		["544"] = 375,
		["545"] = 369,
		["546"] = 375,
		["547"] = 376,
		["548"] = 377,
		["551"] = 378,
		["552"] = 379,
		["553"] = 376,
		["554"] = 381,
		["555"] = 382,
		["556"] = 383,
		["559"] = 384,
		["560"] = 385,
		["561"] = 385,
		["563"] = 387,
		["564"] = 381,
		["565"] = 375,
		["566"] = 369,
		["567"] = 375,
		["569"] = 375,
		["570"] = 391,
		["571"] = 398,
		["572"] = 391,
		["573"] = 398,
		["575"] = 398,
		["576"] = 400,
		["577"] = 401,
		["578"] = 402,
		["579"] = 403,
		["580"] = 404,
		["581"] = 405,
		["582"] = 391,
		["583"] = 406,
		["584"] = 407,
		["587"] = 408,
		["588"] = 409,
		["589"] = 410,
		["590"] = 410,
		["591"] = 410,
		["592"] = 410,
		["593"] = 412,
		["594"] = 413,
		["595"] = 413,
		["596"] = 413,
		["597"] = 413,
		["598"] = 413,
		["600"] = 414,
		["601"] = 416,
		["602"] = 416,
		["603"] = 416,
		["604"] = 417,
		["605"] = 418,
		["606"] = 419,
		["607"] = 419,
		["608"] = 419,
		["609"] = 419,
		["610"] = 419,
		["611"] = 419,
		["613"] = 416,
		["614"] = 416,
		["615"] = 422,
		["616"] = 423,
		["617"] = 424,
		["618"] = 424,
		["619"] = 424,
		["620"] = 424,
		["621"] = 424,
		["622"] = 424,
		["624"] = 406,
		["625"] = 427,
		["626"] = 428,
		["627"] = 429,
		["628"] = 427,
		["629"] = 431,
		["630"] = 432,
		["633"] = 433,
		["634"] = 434,
		["635"] = 436,
		["636"] = 436,
		["637"] = 436,
		["638"] = 436,
		["639"] = 436,
		["640"] = 436,
		["641"] = 436,
		["642"] = 436,
		["643"] = 436,
		["644"] = 436,
		["645"] = 436,
		["646"] = 436,
		["647"] = 436,
		["648"] = 436,
		["649"] = 436,
		["650"] = 448,
		["653"] = 449,
		["654"] = 449,
		["656"] = 450,
		["657"] = 431,
		["658"] = 452,
		["659"] = 453,
		["662"] = 455,
		["663"] = 455,
		["664"] = 455,
		["665"] = 455,
		["666"] = 455,
		["667"] = 455,
		["668"] = 455,
		["669"] = 455,
		["670"] = 456,
		["671"] = 456,
		["672"] = 456,
		["673"] = 456,
		["674"] = 456,
		["675"] = 456,
		["676"] = 456,
		["677"] = 456,
		["678"] = 452,
		["679"] = 458,
		["680"] = 459,
		["683"] = 460,
		["684"] = 461,
		["685"] = 458,
		["686"] = 463,
		["687"] = 464,
		["688"] = 465,
		["689"] = 467,
		["690"] = 467,
		["691"] = 467,
		["692"] = 467,
		["693"] = 467,
		["694"] = 467,
		["695"] = 467,
		["697"] = 469,
		["698"] = 469,
		["700"] = 463,
		["701"] = 471,
		["702"] = 472,
		["703"] = 473,
		["706"] = 476,
		["707"] = 477,
		["708"] = 480,
		["709"] = 482,
		["712"] = 483,
		["713"] = 484,
		["714"] = 485,
		["715"] = 486,
		["716"] = 487,
		["717"] = 488,
		["718"] = 489,
		["719"] = 490,
		["720"] = 491,
		["721"] = 492,
		["722"] = 493,
		["723"] = 494,
		["724"] = 495,
		["725"] = 495,
		["726"] = 495,
		["727"] = 495,
		["728"] = 495,
		["729"] = 496,
		["732"] = 471,
		["733"] = 500,
		["734"] = 501,
		["735"] = 501,
		["736"] = 501,
		["737"] = 501,
		["738"] = 500,
		["739"] = 506,
		["740"] = 507,
		["741"] = 506,
		["742"] = 509,
		["743"] = 510,
		["744"] = 509,
		["745"] = 512,
		["746"] = 513,
		["747"] = 513,
		["749"] = 514,
		["750"] = 514,
		["751"] = 514,
		["752"] = 514,
		["753"] = 514,
		["754"] = 514,
		["755"] = 514,
		["756"] = 514,
		["757"] = 514,
		["758"] = 514,
		["759"] = 514,
		["760"] = 512,
		["761"] = 526,
		["762"] = 527,
		["765"] = 528,
		["766"] = 529,
		["767"] = 530,
		["768"] = 530,
		["770"] = 531,
		["771"] = 532,
		["774"] = 533,
		["775"] = 534,
		["776"] = 534,
		["778"] = 526,
		["779"] = 398,
		["780"] = 391,
		["781"] = 391,
		["782"] = 391,
		["783"] = 391,
		["784"] = 391,
		["785"] = 391,
		["786"] = 391,
		["787"] = 398,
		["789"] = 398,
		["791"] = 539,
		["792"] = 545,
		["793"] = 539,
		["794"] = 545,
		["795"] = 546,
		["796"] = 547,
		["797"] = 546,
		["798"] = 545,
		["799"] = 539,
		["800"] = 545,
		["802"] = 545,
		["804"] = 554,
		["805"] = 555,
		["806"] = 554,
		["807"] = 555,
		["808"] = 556,
		["809"] = 557,
		["810"] = 556,
		["811"] = 555,
		["812"] = 554,
		["813"] = 555,
		["815"] = 555,
		["816"] = 561,
		["817"] = 567,
		["818"] = 561,
		["819"] = 567,
		["820"] = 568,
		["821"] = 569,
		["822"] = 569,
		["823"] = 569,
		["824"] = 569,
		["825"] = 568,
		["826"] = 571,
		["827"] = 572,
		["830"] = 573,
		["831"] = 574,
		["834"] = 575,
		["835"] = 576,
		["836"] = 576,
		["837"] = 576,
		["838"] = 576,
		["841"] = 577,
		["842"] = 578,
		["843"] = 571,
		["844"] = 567,
		["845"] = 561,
		["846"] = 567,
		["848"] = 567,
		["850"] = 583,
		["851"] = 584,
		["852"] = 583,
		["853"] = 584,
		["854"] = 585,
		["855"] = 586,
		["856"] = 585,
		["857"] = 584,
		["858"] = 583,
		["859"] = 584,
		["861"] = 584,
		["862"] = 590,
		["863"] = 596,
		["864"] = 590,
		["865"] = 596,
		["867"] = 596,
		["868"] = 597,
		["869"] = 598,
		["870"] = 599,
		["871"] = 590,
		["872"] = 600,
		["873"] = 601,
		["874"] = 601,
		["875"] = 601,
		["876"] = 604,
		["877"] = 604,
		["878"] = 604,
		["879"] = 601,
		["880"] = 601,
		["881"] = 600,
		["882"] = 607,
		["883"] = 608,
		["884"] = 609,
		["885"] = 610,
		["886"] = 607,
		["887"] = 612,
		["888"] = 613,
		["889"] = 614,
		["892"] = 615,
		["893"] = 615,
		["894"] = 615,
		["895"] = 615,
		["896"] = 615,
		["897"] = 615,
		["898"] = 612,
		["899"] = 617,
		["900"] = 618,
		["901"] = 619,
		["902"] = 617,
		["903"] = 621,
		["904"] = 622,
		["905"] = 623,
		["906"] = 623,
		["908"] = 624,
		["909"] = 624,
		["911"] = 625,
		["912"] = 627,
		["913"] = 627,
		["915"] = 628,
		["916"] = 629,
		["917"] = 629,
		["918"] = 629,
		["919"] = 629,
		["920"] = 629,
		["921"] = 629,
		["922"] = 630,
		["923"] = 631,
		["924"] = 633,
		["926"] = 635,
		["927"] = 636,
		["928"] = 636,
		["930"] = 637,
		["931"] = 638,
		["932"] = 639,
		["933"] = 640,
		["934"] = 641,
		["935"] = 642,
		["936"] = 643,
		["937"] = 643,
		["938"] = 643,
		["939"] = 644,
		["940"] = 644,
		["941"] = 644,
		["942"] = 644,
		["945"] = 645,
		["946"] = 646,
		["947"] = 647,
		["948"] = 647,
		["950"] = 643,
		["951"] = 643,
		["953"] = 650,
		["954"] = 621,
		["955"] = 596,
		["956"] = 590,
		["957"] = 596,
		["959"] = 596,
		["961"] = 655,
		["962"] = 661,
		["963"] = 655,
		["964"] = 661,
		["965"] = 662,
		["966"] = 663,
		["967"] = 662,
		["968"] = 665,
		["969"] = 666,
		["970"] = 667,
		["971"] = 665,
		["972"] = 661,
		["973"] = 655,
		["974"] = 661,
		["976"] = 661,
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
function as.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ALL_BLOCK_CHANCE] = 100 }
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
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function aw.prototype.OnBattleStartBefore(self)
	self.used = false
	self.battling = true
	self.battleId = self.battleId + 1
end
function aw.prototype.OnBattleStart(self)
	local K = self:GetParent()
	if self:GetSectSpecialValueFor("197", "sr_197_health") <= 0 then
		return
	end
	K:AddNewModifier(K, self:GetAbility(), "modifier_yang_jian_strength_gain_buff", { duration = 8 })
end
function aw.prototype.OnBattleEnd(self)
	self.battling = false
	self.battleId = self.battleId + 1
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
g.modifier_yang_jian_strength_gain_buff = c()
local aB = g.modifier_yang_jian_strength_gain_buff
aB.name = "modifier_yang_jian_strength_gain_buff"
d(aB, l)
function aB.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function aB.prototype.EOM_GetModifierOutgoingDamagePercentage(self)
	local T = self:GetParent():FindModifierByName("modifier_sect_health")
	return IsValid(T) and T:GetIndomitableSoulDamageReduction() or 0
end
aB = e({ m(a, { IsHidden = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }) }, aB)
g.modifier_yang_jian_strength_gain_buff = aB
return g