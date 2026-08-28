--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/dark_willow"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIndexOf
local g = b.__TS__ArrayFilter
local h = b.__TS__Number
local i = b.__TS__ArrayForEach
local j = b.__TS__Delete
local k = b.__TS__ArraySplice
local l = b.__TS__SourceMapTraceBack
l(
	debug.getinfo(1).short_src,
	{
		["14"] = 1,
		["15"] = 1,
		["16"] = 1,
		["17"] = 2,
		["18"] = 2,
		["19"] = 2,
		["20"] = 3,
		["21"] = 3,
		["22"] = 3,
		["24"] = 8,
		["25"] = 9,
		["26"] = 8,
		["27"] = 9,
		["28"] = 10,
		["29"] = 11,
		["30"] = 10,
		["31"] = 9,
		["32"] = 8,
		["33"] = 9,
		["35"] = 9,
		["36"] = 15,
		["37"] = 23,
		["38"] = 15,
		["39"] = 23,
		["41"] = 23,
		["42"] = 34,
		["43"] = 37,
		["44"] = 38,
		["45"] = 43,
		["46"] = 44,
		["47"] = 46,
		["48"] = 47,
		["49"] = 48,
		["50"] = 15,
		["51"] = 53,
		["52"] = 54,
		["53"] = 55,
		["54"] = 56,
		["55"] = 57,
		["56"] = 58,
		["57"] = 59,
		["58"] = 63,
		["59"] = 64,
		["60"] = 66,
		["61"] = 68,
		["62"] = 69,
		["63"] = 70,
		["64"] = 72,
		["65"] = 73,
		["66"] = 75,
		["67"] = 76,
		["69"] = 53,
		["70"] = 79,
		["71"] = 80,
		["72"] = 79,
		["73"] = 84,
		["74"] = 85,
		["75"] = 86,
		["76"] = 86,
		["78"] = 88,
		["79"] = 84,
		["80"] = 90,
		["81"] = 91,
		["82"] = 92,
		["84"] = 90,
		["85"] = 95,
		["86"] = 96,
		["87"] = 96,
		["88"] = 96,
		["89"] = 99,
		["90"] = 99,
		["91"] = 99,
		["92"] = 96,
		["93"] = 100,
		["94"] = 100,
		["95"] = 100,
		["96"] = 96,
		["97"] = 101,
		["98"] = 101,
		["99"] = 101,
		["100"] = 96,
		["101"] = 102,
		["102"] = 102,
		["103"] = 102,
		["104"] = 96,
		["105"] = 96,
		["106"] = 95,
		["107"] = 105,
		["108"] = 106,
		["109"] = 107,
		["112"] = 108,
		["113"] = 109,
		["116"] = 105,
		["117"] = 113,
		["118"] = 114,
		["119"] = 115,
		["120"] = 116,
		["121"] = 117,
		["122"] = 118,
		["123"] = 119,
		["130"] = 126,
		["131"] = 127,
		["132"] = 128,
		["133"] = 128,
		["134"] = 128,
		["135"] = 128,
		["136"] = 128,
		["137"] = 128,
		["138"] = 128,
		["139"] = 128,
		["140"] = 128,
		["141"] = 113,
		["142"] = 138,
		["143"] = 139,
		["144"] = 140,
		["146"] = 138,
		["147"] = 148,
		["148"] = 149,
		["149"] = 150,
		["150"] = 151,
		["151"] = 152,
		["152"] = 153,
		["153"] = 154,
		["154"] = 148,
		["155"] = 156,
		["156"] = 157,
		["157"] = 156,
		["158"] = 159,
		["159"] = 160,
		["160"] = 161,
		["161"] = 162,
		["162"] = 163,
		["163"] = 159,
		["164"] = 165,
		["165"] = 166,
		["166"] = 167,
		["167"] = 168,
		["168"] = 169,
		["169"] = 169,
		["170"] = 169,
		["171"] = 169,
		["172"] = 170,
		["173"] = 171,
		["174"] = 172,
		["177"] = 176,
		["180"] = 165,
		["181"] = 190,
		["182"] = 190,
		["183"] = 190,
		["185"] = 191,
		["186"] = 192,
		["187"] = 193,
		["190"] = 194,
		["191"] = 195,
		["192"] = 196,
		["193"] = 201,
		["194"] = 202,
		["195"] = 203,
		["196"] = 204,
		["197"] = 205,
		["199"] = 206,
		["200"] = 206,
		["201"] = 207,
		["202"] = 206,
		["207"] = 212,
		["208"] = 213,
		["209"] = 214,
		["210"] = 215,
		["211"] = 216,
		["213"] = 217,
		["214"] = 217,
		["215"] = 218,
		["216"] = 217,
		["221"] = 224,
		["222"] = 225,
		["223"] = 226,
		["224"] = 227,
		["225"] = 228,
		["226"] = 229,
		["227"] = 229,
		["228"] = 229,
		["229"] = 229,
		["230"] = 229,
		["231"] = 229,
		["234"] = 235,
		["235"] = 236,
		["236"] = 237,
		["237"] = 238,
		["238"] = 239,
		["239"] = 240,
		["240"] = 240,
		["241"] = 240,
		["242"] = 240,
		["243"] = 240,
		["244"] = 240,
		["247"] = 190,
		["248"] = 245,
		["249"] = 246,
		["252"] = 247,
		["253"] = 247,
		["254"] = 247,
		["255"] = 247,
		["256"] = 248,
		["257"] = 249,
		["258"] = 250,
		["259"] = 251,
		["260"] = 252,
		["261"] = 253,
		["263"] = 254,
		["264"] = 254,
		["265"] = 255,
		["266"] = 255,
		["267"] = 255,
		["268"] = 255,
		["269"] = 255,
		["270"] = 256,
		["271"] = 256,
		["272"] = 256,
		["273"] = 256,
		["274"] = 256,
		["275"] = 256,
		["276"] = 257,
		["277"] = 257,
		["278"] = 255,
		["279"] = 255,
		["280"] = 254,
		["284"] = 245,
		["285"] = 263,
		["286"] = 263,
		["287"] = 263,
		["289"] = 264,
		["290"] = 265,
		["291"] = 266,
		["294"] = 267,
		["295"] = 268,
		["296"] = 269,
		["297"] = 269,
		["298"] = 269,
		["299"] = 269,
		["300"] = 269,
		["301"] = 269,
		["302"] = 269,
		["303"] = 269,
		["304"] = 269,
		["305"] = 270,
		["306"] = 270,
		["307"] = 270,
		["308"] = 270,
		["309"] = 270,
		["310"] = 270,
		["311"] = 270,
		["312"] = 270,
		["313"] = 270,
		["314"] = 271,
		["315"] = 272,
		["316"] = 273,
		["317"] = 274,
		["318"] = 263,
		["319"] = 23,
		["320"] = 15,
		["321"] = 15,
		["322"] = 15,
		["323"] = 15,
		["324"] = 15,
		["325"] = 15,
		["326"] = 15,
		["327"] = 15,
		["328"] = 23,
		["330"] = 23,
		["331"] = 280,
		["332"] = 290,
		["333"] = 280,
		["334"] = 290,
		["336"] = 290,
		["337"] = 292,
		["338"] = 280,
		["339"] = 298,
		["340"] = 299,
		["341"] = 298,
		["342"] = 301,
		["343"] = 302,
		["344"] = 301,
		["345"] = 304,
		["346"] = 305,
		["347"] = 304,
		["348"] = 307,
		["349"] = 308,
		["350"] = 309,
		["351"] = 310,
		["352"] = 311,
		["353"] = 311,
		["354"] = 311,
		["355"] = 311,
		["356"] = 311,
		["357"] = 312,
		["358"] = 312,
		["359"] = 312,
		["360"] = 312,
		["361"] = 312,
		["362"] = 313,
		["363"] = 313,
		["364"] = 313,
		["365"] = 313,
		["366"] = 313,
		["367"] = 313,
		["368"] = 313,
		["369"] = 313,
		["370"] = 314,
		["371"] = 314,
		["372"] = 314,
		["373"] = 314,
		["374"] = 314,
		["375"] = 314,
		["376"] = 314,
		["377"] = 314,
		["379"] = 307,
		["380"] = 317,
		["381"] = 318,
		["382"] = 319,
		["384"] = 317,
		["385"] = 322,
		["386"] = 323,
		["387"] = 324,
		["388"] = 324,
		["389"] = 324,
		["390"] = 325,
		["391"] = 326,
		["392"] = 324,
		["393"] = 324,
		["395"] = 322,
		["396"] = 330,
		["397"] = 331,
		["398"] = 332,
		["399"] = 332,
		["400"] = 332,
		["401"] = 332,
		["402"] = 333,
		["403"] = 334,
		["406"] = 335,
		["407"] = 336,
		["409"] = 337,
		["410"] = 337,
		["411"] = 338,
		["412"] = 339,
		["413"] = 340,
		["414"] = 340,
		["415"] = 340,
		["416"] = 340,
		["417"] = 340,
		["418"] = 340,
		["419"] = 341,
		["420"] = 342,
		["421"] = 342,
		["422"] = 343,
		["423"] = 337,
		["427"] = 346,
		["429"] = 347,
		["430"] = 347,
		["431"] = 348,
		["432"] = 349,
		["433"] = 350,
		["434"] = 351,
		["435"] = 352,
		["437"] = 347,
		["442"] = 330,
		["443"] = 358,
		["444"] = 359,
		["445"] = 360,
		["446"] = 361,
		["447"] = 362,
		["448"] = 362,
		["449"] = 362,
		["450"] = 362,
		["451"] = 362,
		["452"] = 362,
		["453"] = 362,
		["454"] = 362,
		["455"] = 362,
		["456"] = 358,
		["457"] = 364,
		["458"] = 365,
		["459"] = 364,
		["460"] = 369,
		["461"] = 370,
		["462"] = 369,
		["463"] = 290,
		["464"] = 280,
		["465"] = 280,
		["466"] = 280,
		["467"] = 280,
		["468"] = 280,
		["469"] = 280,
		["470"] = 280,
		["471"] = 280,
		["472"] = 280,
		["473"] = 290,
		["475"] = 290,
		["476"] = 375,
		["477"] = 384,
		["478"] = 375,
		["479"] = 384,
		["480"] = 393,
		["481"] = 394,
		["482"] = 395,
		["483"] = 393,
		["484"] = 397,
		["485"] = 398,
		["486"] = 399,
		["487"] = 400,
		["488"] = 401,
		["489"] = 402,
		["490"] = 403,
		["491"] = 403,
		["492"] = 403,
		["493"] = 403,
		["494"] = 403,
		["495"] = 403,
		["496"] = 403,
		["497"] = 403,
		["498"] = 403,
		["499"] = 403,
		["500"] = 410,
		["501"] = 411,
		["502"] = 412,
		["503"] = 412,
		["504"] = 412,
		["505"] = 412,
		["506"] = 412,
		["507"] = 412,
		["508"] = 412,
		["509"] = 412,
		["510"] = 412,
		["511"] = 413,
		["512"] = 413,
		["513"] = 413,
		["514"] = 413,
		["515"] = 413,
		["516"] = 413,
		["517"] = 413,
		["518"] = 413,
		["519"] = 413,
		["520"] = 414,
		["521"] = 414,
		["522"] = 414,
		["523"] = 414,
		["524"] = 414,
		["525"] = 414,
		["526"] = 420,
		["527"] = 421,
		["528"] = 422,
		["529"] = 414,
		["530"] = 424,
		["531"] = 425,
		["532"] = 426,
		["533"] = 427,
		["534"] = 428,
		["536"] = 414,
		["537"] = 414,
		["538"] = 414,
		["539"] = 414,
		["540"] = 433,
		["541"] = 434,
		["542"] = 435,
		["543"] = 436,
		["545"] = 397,
		["546"] = 439,
		["547"] = 440,
		["548"] = 441,
		["549"] = 442,
		["550"] = 443,
		["552"] = 445,
		["553"] = 446,
		["556"] = 439,
		["557"] = 450,
		["558"] = 451,
		["559"] = 452,
		["560"] = 453,
		["561"] = 454,
		["562"] = 455,
		["565"] = 458,
		["568"] = 461,
		["569"] = 462,
		["570"] = 463,
		["571"] = 465,
		["572"] = 465,
		["573"] = 465,
		["574"] = 465,
		["575"] = 465,
		["576"] = 465,
		["577"] = 471,
		["578"] = 472,
		["581"] = 473,
		["584"] = 474,
		["585"] = 475,
		["586"] = 475,
		["587"] = 475,
		["588"] = 475,
		["589"] = 475,
		["590"] = 475,
		["591"] = 475,
		["592"] = 475,
		["593"] = 475,
		["594"] = 465,
		["595"] = 465,
		["597"] = 450,
		["598"] = 384,
		["599"] = 375,
		["600"] = 375,
		["601"] = 375,
		["602"] = 375,
		["603"] = 375,
		["604"] = 375,
		["605"] = 375,
		["606"] = 375,
		["607"] = 375,
		["608"] = 384,
		["610"] = 384,
		["611"] = 492,
		["612"] = 503,
		["613"] = 492,
		["614"] = 503,
		["615"] = 504,
		["616"] = 505,
		["617"] = 506,
		["618"] = 507,
		["620"] = 504,
		["621"] = 510,
		["622"] = 511,
		["623"] = 512,
		["625"] = 510,
		["626"] = 515,
		["627"] = 516,
		["628"] = 515,
		["629"] = 520,
		["630"] = 521,
		["631"] = 520,
		["632"] = 523,
		["633"] = 524,
		["634"] = 523,
		["635"] = 528,
		["636"] = 529,
		["637"] = 528,
		["638"] = 503,
		["639"] = 492,
		["640"] = 492,
		["641"] = 492,
		["642"] = 492,
		["643"] = 492,
		["644"] = 492,
		["645"] = 492,
		["646"] = 492,
		["647"] = 492,
		["648"] = 492,
		["649"] = 492,
		["650"] = 503,
		["652"] = 503,
		["654"] = 537,
		["655"] = 538,
		["656"] = 539,
		["657"] = 544,
		["658"] = 545,
		["659"] = 544,
		["660"] = 545,
		["662"] = 545,
		["663"] = 546,
		["664"] = 544,
		["665"] = 547,
		["666"] = 548,
		["667"] = 549,
		["668"] = 550,
		["671"] = 551,
		["672"] = 552,
		["673"] = 553,
		["674"] = 556,
		["675"] = 557,
		["676"] = 558,
		["677"] = 559,
		["678"] = 561,
		["679"] = 562,
		["680"] = 563,
		["681"] = 564,
		["682"] = 565,
		["683"] = 567,
		["684"] = 568,
		["685"] = 570,
		["686"] = 571,
		["687"] = 572,
		["688"] = 573,
		["689"] = 574,
		["690"] = 574,
		["691"] = 574,
		["692"] = 574,
		["693"] = 574,
		["694"] = 575,
		["695"] = 577,
		["696"] = 578,
		["697"] = 579,
		["698"] = 580,
		["699"] = 581,
		["700"] = 582,
		["701"] = 583,
		["702"] = 584,
		["703"] = 584,
		["704"] = 584,
		["705"] = 585,
		["706"] = 586,
		["709"] = 589,
		["710"] = 590,
		["711"] = 591,
		["712"] = 592,
		["713"] = 593,
		["714"] = 593,
		["715"] = 593,
		["716"] = 593,
		["717"] = 593,
		["718"] = 593,
		["719"] = 593,
		["720"] = 593,
		["721"] = 601,
		["722"] = 602,
		["723"] = 603,
		["724"] = 603,
		["725"] = 603,
		["726"] = 603,
		["727"] = 603,
		["729"] = 593,
		["730"] = 606,
		["731"] = 607,
		["734"] = 608,
		["735"] = 609,
		["738"] = 610,
		["739"] = 611,
		["740"] = 612,
		["741"] = 613,
		["742"] = 614,
		["743"] = 614,
		["744"] = 614,
		["745"] = 614,
		["746"] = 614,
		["747"] = 615,
		["748"] = 616,
		["749"] = 618,
		["750"] = 619,
		["751"] = 620,
		["752"] = 620,
		["753"] = 620,
		["754"] = 620,
		["755"] = 620,
		["756"] = 620,
		["757"] = 620,
		["758"] = 620,
		["759"] = 620,
		["760"] = 629,
		["761"] = 633,
		["762"] = 634,
		["763"] = 635,
		["764"] = 636,
		["767"] = 593,
		["768"] = 593,
		["769"] = 584,
		["770"] = 584,
		["771"] = 547,
		["772"] = 644,
		["773"] = 645,
		["774"] = 646,
		["775"] = 647,
		["776"] = 648,
		["777"] = 649,
		["778"] = 650,
		["779"] = 651,
		["780"] = 652,
		["781"] = 653,
		["782"] = 654,
		["783"] = 655,
		["784"] = 656,
		["785"] = 656,
		["786"] = 656,
		["787"] = 656,
		["788"] = 656,
		["789"] = 661,
		["790"] = 662,
		["791"] = 663,
		["792"] = 663,
		["793"] = 663,
		["794"] = 663,
		["795"] = 663,
		["796"] = 663,
		["797"] = 663,
		["798"] = 663,
		["799"] = 663,
		["800"] = 665,
		["801"] = 666,
		["802"] = 667,
		["804"] = 656,
		["805"] = 670,
		["806"] = 671,
		["807"] = 672,
		["809"] = 656,
		["810"] = 656,
		["811"] = 644,
		["812"] = 677,
		["813"] = 677,
		["814"] = 677,
		["816"] = 678,
		["817"] = 678,
		["818"] = 678,
		["819"] = 678,
		["820"] = 680,
		["821"] = 680,
		["822"] = 680,
		["823"] = 678,
		["824"] = 678,
		["825"] = 678,
		["826"] = 678,
		["827"] = 678,
		["828"] = 678,
		["829"] = 685,
		["830"] = 685,
		["831"] = 685,
		["832"] = 685,
		["833"] = 685,
		["834"] = 685,
		["835"] = 686,
		["836"] = 686,
		["837"] = 686,
		["838"] = 686,
		["839"] = 686,
		["840"] = 686,
		["841"] = 686,
		["842"] = 686,
		["843"] = 686,
		["844"] = 687,
		["845"] = 687,
		["846"] = 687,
		["847"] = 687,
		["848"] = 687,
		["849"] = 687,
		["850"] = 687,
		["851"] = 687,
		["852"] = 687,
		["853"] = 688,
		["854"] = 688,
		["855"] = 689,
		["856"] = 677,
		["857"] = 691,
		["858"] = 692,
		["859"] = 693,
		["860"] = 694,
		["862"] = 696,
		["865"] = 697,
		["866"] = 698,
		["867"] = 691,
		["868"] = 700,
		["869"] = 701,
		["870"] = 701,
		["871"] = 701,
		["872"] = 702,
		["873"] = 701,
		["874"] = 701,
		["875"] = 700,
		["876"] = 706,
		["877"] = 707,
		["878"] = 706,
		["879"] = 545,
		["880"] = 544,
		["881"] = 545,
		["883"] = 545,
		["884"] = 710,
		["885"] = 718,
		["886"] = 710,
		["887"] = 718,
		["888"] = 718,
		["889"] = 710,
		["890"] = 710,
		["891"] = 710,
		["892"] = 710,
		["893"] = 710,
		["894"] = 710,
		["895"] = 710,
		["896"] = 710,
		["897"] = 718,
		["899"] = 718,
		["900"] = 720,
		["901"] = 732,
		["902"] = 720,
		["903"] = 732,
		["904"] = 732,
		["905"] = 720,
		["906"] = 720,
		["907"] = 720,
		["908"] = 720,
		["909"] = 720,
		["910"] = 720,
		["911"] = 720,
		["912"] = 720,
		["913"] = 720,
		["914"] = 720,
		["915"] = 720,
		["916"] = 720,
		["917"] = 732,
		["919"] = 732,
		["920"] = 734,
		["921"] = 742,
		["922"] = 734,
		["923"] = 742,
		["924"] = 743,
		["925"] = 744,
		["926"] = 745,
		["928"] = 743,
		["929"] = 742,
		["930"] = 734,
		["931"] = 734,
		["932"] = 734,
		["933"] = 734,
		["934"] = 734,
		["935"] = 734,
		["936"] = 734,
		["937"] = 734,
		["938"] = 742,
		["940"] = 742,
		["941"] = 750,
		["942"] = 763,
		["943"] = 750,
		["944"] = 763,
		["945"] = 764,
		["946"] = 765,
		["947"] = 764,
		["948"] = 763,
		["949"] = 750,
		["950"] = 750,
		["951"] = 750,
		["952"] = 750,
		["953"] = 750,
		["954"] = 750,
		["955"] = 750,
		["956"] = 750,
		["957"] = 750,
		["958"] = 750,
		["959"] = 750,
		["960"] = 750,
		["961"] = 750,
		["962"] = 763,
		["964"] = 763,
	}
)
local m = {}
local n = require("lib.dota_ts_adapter")
local o = n.BaseAbility
local p = n.registerAbility
local q = require("modifiers.eom_modifier")
local r = q.EOMModifier
local s = q.registerEOMModifier
local t = require("abilities.ability_ai")
local u = t.BaseAbilityAI
local v = t.registerAbilityAI
m.dark_willow_talent = c()
local w = m.dark_willow_talent
w.name = "dark_willow_talent"
d(w, o)
function w.prototype.GetIntrinsicModifierName(self)
	return "modifier_dark_willow_talent"
end
w = e({ p(nil) }, w)
m.dark_willow_talent = w
m.modifier_dark_willow_talent = c()
local x = m.modifier_dark_willow_talent
x.name = "modifier_dark_willow_talent"
d(x, r)
function x.prototype.____constructor(self, ...)
	r.prototype.____constructor(self, ...)
	self.tl4_record = 0
	self.tl5_record = 0
	self.tl5WispList = {}
	self.tl6_record = 0
	self.tl6_flag = false
	self.tick = 0.1
	self.record = 0
	self.battleEnd = true
end
function x.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilityTalentValue("dark_willow_talent_1", "interval_reduce")
	self.interval_reduce = self:GetAbilitySpecialValueFor("interval_reduce")
	self.min_interval = self:GetAbilitySpecialValueFor("min_interval")
	self.count = self:GetAbilitySpecialValueFor("count") + self:GetAbilityTalentValue("dark_willow_talent_3", "count")
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.tl4_duration = self:GetAbilityTalentValue("dark_willow_talent_4", "duration")
	self.tl4_count = self:GetAbilityTalentValue("dark_willow_talent_4", "count")
	self.tl5_count = self:GetAbilityTalentValue("dark_willow_talent_5", "count")
	self.tl6_count = self:GetAbilityTalentValue("dark_willow_talent_6", "count")
	self.tl6_duration = self:GetAbilityTalentValue("dark_willow_talent_6", "duration")
	self.tl6_damage_bonus = self:GetAbilityTalentValue("dark_willow_talent_6", "damage_bonus")
	self.s_count = self:GetAbilityTalentValue("dark_willow_shard", "count")
	self.s_stun = self:GetAbilityTalentValue("dark_willow_shard", "stun")
	if IsServer() then
		self.tl6_wisps = {}
	end
end
function x.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_ATTACK }
end
function x.prototype.EOM_GetModifierWispAttack(self, y)
	if IsValid(y.wisp) and self:GetParent():HasModifier("modifier_dark_willow_talent_6") then
		local z = self.tl6_wisps
		z[#z + 1] = y.wisp
	end
	return 0
end
function x.prototype.OnCreated(self, y)
	if IsServer() then
		self.s_record = 0
	end
end
function x.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_START] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_DAMAGE_START] = { self:GetParent(), -1 },
		[MODIFIER_EVENT_ON_ATTACK] = { self:GetParent(), -1 },
	}
end
function x.prototype.OnCustomAttackStart(self, A)
	if IsServer() then
		if IsValid(A and A.ability) then
			return
		end
		if self:GetParent():HasModifier("modifier_dark_willow_talent_6") then
			self.tl6_flag = true
		end
	end
end
function x.prototype.OnDamageStart(self, A)
	if self.tl6_flag and A.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK and not IsValid(A and A.ability) then
		self.tl6_flag = false
	elseif
		#self.tl6_wisps > 0
		and A.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
		and IsValid(A.wisp)
		and A.ability_upgrade == nil
		and IsValid(A.ability)
		and A.ability:GetAbilityName() == "sect_wisp"
	then
		local B = f(self.tl6_wisps, A.wisp)
		if B > -1 then
			table.remove(self.tl6_wisps, B + 1)
		else
			return
		end
	else
		return
	end
	local C = self:GetCaster():FindAbilityByName("dark_willow_talent_6")
	A.target:EmitSound("Hero_DarkWillow.Shadow_Realm.Damage")
	DamageSystem:dealDamage({
		attacker = self:GetCaster(),
		target = A.target,
		ability = IsValid(C) and C or self:GetAbility(),
		damage = self.tl6_damage_bonus,
		damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
		damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
		damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
	})
end
function x.prototype.OnAttack(self, A)
	if self.tl6_flag then
		A.attacker:EmitSound("Hero_DarkWillow.Shadow_Realm.Attack")
	end
end
function x.prototype.OnBattleStartBefore(self, y)
	self.tl4_record = 0
	self.tl5_record = 0
	self.tl6_record = 0
	self.record = 0
	self.tl6_wisps = {}
	self.battleEnd = false
end
function x.prototype.OnBattleStart(self, y)
	self:StartIntervalThink(self.tick)
end
function x.prototype.OnBattleEnd(self, y)
	self.battleEnd = true
	self.tl6_wisps = {}
	self:StartIntervalThink(-1)
	self:GetParent():RemoveModifierByName("modifier_dark_willow_talent_6")
end
function x.prototype.OnIntervalThink(self)
	if IsServer() then
		local D = self:GetParent()
		self.record = self.record + self.tick
		local E = math.max(self.min_interval, self.interval - GetWispCount(D) * self.interval_reduce)
		if self.record >= E then
			self.record = 0
			if D:PassivesDisabled() then
				return
			end
			self:addBramble(self.count)
		end
	end
end
function x.prototype.addBramble(self, F)
	if F == nil then
		F = 1
	end
	local D = self:GetParent()
	local G = D:GetEnemy()
	if not IsInjurable(D, G) then
		return
	end
	local H = self:GetAbility()
	D:EmitSound("Hero_DarkWillow.Brambles.Cast")
	G:AddNewModifier(D, H, "modifier_dark_willow_talent_debuff", { duration = self.duration, add_count = F })
	if self.tl4_count > 0 then
		self.tl4_record = self.tl4_record + F
		if self.tl4_record >= self.tl4_count then
			local I = math.floor(self.tl4_record / self.tl4_count)
			self.tl4_record = self.tl4_record % self.tl4_count
			do
				local J = 0
				while J < I do
					self:Bedlam()
					J = J + 1
				end
			end
		end
	end
	if self.tl5_count > 0 then
		self.tl5_record = self.tl5_record + F
		if self.tl5_record >= self.tl5_count then
			local I = math.floor(self.tl5_record / self.tl5_count)
			self.tl5_record = self.tl5_record % self.tl5_count
			do
				local J = 0
				while J < I do
					self:Talent5()
					J = J + 1
				end
			end
		end
	end
	if self.tl6_count > 0 then
		self.tl6_record = self.tl6_record + F
		local D = self:GetParent()
		if not D:HasModifier("modifier_dark_willow_talent_6") and self.tl6_record >= self.tl6_count then
			self.tl6_record = 0
			D:AddNewModifier(D, self:GetAbility(), "modifier_dark_willow_talent_6", { duration = self.tl6_duration })
		end
	end
	if self.s_count > 0 then
		self.s_record = self.s_record + F
		if self.s_record >= self.s_count then
			local I = math.floor(self.s_record / self.s_count)
			self.s_record = self.s_record % self.s_count
			AddStun(D, G, self:GetAbility(), self.s_stun * I)
		end
	end
end
function x.prototype.Talent5(self)
	if self.battleEnd then
		return
	end
	self.tl5WispList = g(self.tl5WispList, function(K, L)
		return IsInjurable(L)
	end)
	local M = self:GetAbilityTalentValue("dark_willow_talent_5", "max")
	if #self.tl5WispList < M then
		local N = self:GetAbilityTalentValue("dark_willow_talent_5", "wisp_health")
		local F = self:GetAbilityTalentValue("dark_willow_talent_5", "count")
		local O = self:GetCaster()
		F = math.min(F, M - #self.tl5WispList)
		do
			local J = 0
			while J < F do
				SummonWisp(O, N, nil, function(P)
					P:AddNewModifier(O, self:GetAbility(), "modifier_dark_willow_talent_5", nil)
					local Q = self.tl5WispList
					Q[#Q + 1] = P
				end)
				J = J + 1
			end
		end
	end
end
function x.prototype.Bedlam(self, O)
	if O == nil then
		O = self:GetParent()
	end
	local D = self:GetParent()
	local G = D:GetEnemy()
	if not IsInjurable(D, G) then
		return
	end
	local R = O:GetAbsOrigin()
	local S = ParticleManager:CreateParticle(
		"particles/econ/items/dark_willow/dark_willow_immortal_2021/dw_2021_willow_wisp_aoe_cast.vpcf",
		PATTACH_CUSTOMORIGIN,
		D
	)
	ParticleManager:SetParticleControlEnt(S, 1, O, PATTACH_POINT, "attach_hitloc", O:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(S, 2, G, PATTACH_POINT, "attach_hitloc", G:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(S)
	EmitSoundOnLocationWithCaster(R, "Hero_DarkWillow.WispStrike.Cast", D)
	local H = self:GetAbility()
	G:AddNewModifier(D, H, "modifier_dark_willow_talent_4", { duration = self.tl4_duration })
end
x = e(
	{
		s(
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
	x
)
m.modifier_dark_willow_talent = x
m.modifier_dark_willow_talent_debuff = c()
local T = m.modifier_dark_willow_talent_debuff
T.name = "modifier_dark_willow_talent_debuff"
d(T, r)
function T.prototype.____constructor(self, ...)
	r.prototype.____constructor(self, ...)
	self.placement_range = { 160, 480, 480 }
end
function T.prototype.GetTexture(self)
	return "dark_willow_talent"
end
function T.prototype.GetAbilitySpecialValue(self)
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
end
function T.prototype.IndependentMaxCount(self)
	return self:GetAbilitySpecialValueFor("max_count")
		+ self:GetAbilityTalentValue("dark_willow_talent_3", "limit_bonus")
end
function T.prototype.OnCreated(self, y)
	if IsServer() then
		self.particleList = {}
		self:IncrementStackCount(h(y and y.add_count or 1))
		local U = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_dark_willow/dark_willow_bramble_ember.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		local V = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_dark_willow/dark_willow_bramble_swirl_dark.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		self:AddParticle(U, false, false, -1, false, false)
		self:AddParticle(V, false, false, -1, false, false)
	end
end
function T.prototype.OnRefresh(self, y)
	if IsServer() then
		self:IncrementStackCount(h(y and y.add_count or 1))
	end
end
function T.prototype.OnDestroy(self)
	if IsServer() then
		i(self.particleList, function(K, W, B)
			ParticleManager:DestroyParticle(W, false)
			ParticleManager:ReleaseParticleIndex(W)
		end)
	end
end
function T.prototype.OnStackCountChanged(self, X)
	if IsServer() then
		local F = math.min(self:IndependentMaxCount(), self:GetStackCount())
		local Y = F - #self.particleList
		if Y == 0 then
			return
		end
		if Y > 0 then
			local Z = #self.particleList
			do
				local J = 0
				while J < Y do
					local B = Z + J + 1
					local R = self:GetParticlePosition(B)
					local S = ParticleManager:CreateParticle(
						"particles/econ/items/dark_willow/dark_willow_chakram_immortal/dark_willow_chakram_immortal_bramble_wraith.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil,
						self:GetCaster()
					)
					ParticleManager:SetParticleControl(S, 0, R)
					local _ = self.particleList
					_[#_ + 1] = S
					self:GetParent():EmitSound("Hero_DarkWillow.Bramble.Target")
					J = J + 1
				end
			end
		else
			Y = math.abs(Y)
			do
				local J = 0
				while J < Y do
					local S = self.particleList[#self.particleList]
					j(self.particleList, #self.particleList)
					if S ~= nil then
						ParticleManager:DestroyParticle(S, false)
						ParticleManager:ReleaseParticleIndex(S)
					end
					J = J + 1
				end
			end
		end
	end
end
function T.prototype.GetParticlePosition(self, B)
	local a0 = self:GetParent():GetAbsOrigin()
	local a1 = math.ceil(B / 4)
	local a2 = (B % 4 * 90 + (a1 - 1) * 45) % 360
	return RotatePosition(
		a0,
		QAngle(0, a2, 0),
		a0 + Vector(self.placement_range[Clamp(a1, 1, #self.placement_range)], 0, 0)
	)
end
function T.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function T.prototype.EOM_GetModifierIncomingDamagePercentage(self, y)
	return self:GetStackCount() * self.damage_pct
end
T = e(
	{
		s(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				IsIndependent = true,
			}
		),
	},
	T
)
m.modifier_dark_willow_talent_debuff = T
m.modifier_dark_willow_talent_4 = c()
local a3 = m.modifier_dark_willow_talent_4
a3.name = "modifier_dark_willow_talent_4"
d(a3, r)
function a3.prototype.GetAbilitySpecialValue(self)
	self.total_damage = self:GetAbilityTalentValue("dark_willow_talent_4", "damage")
	self.tick = self:GetAbilityTalentValue("dark_willow_talent_4", "tick")
end
function a3.prototype.OnCreated(self, y)
	if IsServer() then
		self.count = math.floor(self:GetDuration() / self.tick)
		self.counter = self.count
		local O = self:GetCaster()
		local D = self:GetParent()
		local a4 = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{
				origin = D:GetAbsOrigin(),
				model = Wearable:getReplaceUnitModel(O, "models/heroes/dark_willow/dark_willow_wisp.vmdl"),
				DefaultAnim = "ACT_DOTA_ATTACK",
				use_animgraph = "1",
				AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			}
		)
		self.dummy = a4
		local S = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_dark_willow/dark_willow_willowisp_ambient.vpcf",
			PATTACH_CUSTOMORIGIN,
			self.dummy,
			O
		)
		ParticleManager:SetParticleControlEnt(S, 0, self.dummy, PATTACH_POINT_FOLLOW, "attach_hitloc", vec3_zero, true)
		ParticleManager:SetParticleControlEnt(S, 1, self.dummy, PATTACH_POINT_FOLLOW, "attach_hitloc", vec3_zero, true)
		local a5 = Projectile:CreateGroupSurroundProjectile({
			hCaster = D,
			sGroupName = "dark_willow_talent_4" .. tostring(self:GetAbility():entindex()),
			flCircleRadius = 120,
			flAngularVelocity = 300,
			flOffset = 328,
			OnProjectileCreated = function(a6)
				local a7 = a6
				a7._iParticleID = S
			end,
			OnProjectileThink = function(a8, a6)
				if IsValid(a4) then
					local a7 = a6
					a4:SetForwardVector(
						(AnglesToVector(QAngle(0, a7.flAngle + 90, 0)) * a7.flCircleRadius):Normalized()
					)
					a4:SetAbsOrigin(a8)
				end
			end,
			iCount = 1,
		})
		self.projectileID = a5[1]
		self.damage = self.total_damage / self.count
		self.sourceAbility = O:FindAbilityByName("dark_willow_talent_4")
		self:OnIntervalThink()
		self:StartIntervalThink(self.tick)
	end
end
function a3.prototype.OnDestroy(self)
	if IsServer() then
		self:OnIntervalThink()
		if self.projectileID ~= nil then
			Projectile:DestroyPartOfSurroundProjectile({ self.projectileID })
		end
		if IsValid(self.dummy) then
			self.dummy:RemoveSelf()
		end
	end
end
function a3.prototype.OnIntervalThink(self)
	if IsServer() then
		local O = self:GetCaster()
		local D = self:GetParent()
		if not IsInjurable(O, D) or not IsValid(self.dummy) then
			self:Destroy()
			return
		end
		if self.counter <= 0 then
			return
		end
		self.counter = self.counter - 1
		local H = self.sourceAbility
		local a9 = self.damage
		Projectile:CreateTrackingProjectile({
			EffectName = "particles/units/heroes/hero_dark_willow/dark_willow_willowisp_base_attack.vpcf",
			hCaster = O,
			vSpawnOrigin = self.dummy:GetAbsOrigin(),
			hTarget = D,
			iMoveSpeed = 1200,
			OnProjectileHit = function(aa, a8, a6)
				if not IsValid(H) then
					return
				end
				if not IsInjurable(O, D) then
					return
				end
				D:EmitSound("Hero_DarkWillow.WillOWisp.Damage")
				DamageSystem:dealDamage({
					attacker = O,
					target = D,
					ability = H,
					damage = a9,
					damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
					damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
					damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
				})
			end,
		})
	end
end
a3 = e(
	{
		s(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	a3
)
m.modifier_dark_willow_talent_4 = a3
m.modifier_dark_willow_talent_6 = c()
local ab = m.modifier_dark_willow_talent_6
ab.name = "modifier_dark_willow_talent_6"
d(ab, r)
function ab.prototype.OnCreated(self, y)
	if IsServer() then
		self:GetParent():EmitSound("Hero_DarkWillow.Shadow_Realm")
		self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 3)
	end
end
function ab.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():StopSound("Hero_DarkWillow.Shadow_Realm")
	end
end
function ab.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PROJECTILE_NAME }
end
function ab.prototype.GetModifierProjectileName(self)
	return "particles/units/heroes/hero_dark_willow/dark_willow_shadow_attack.vpcf"
end
function ab.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_PROJECTILE_NAME }
end
function ab.prototype.EOM_GetModifierWispProjectileName(self, y)
	return "particles/units/heroes/hero_dark_willow/dark_willow_shadow_attack.vpcf"
end
ab = e(
	{
		s(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
				GetEffectName = "particles/units/heroes/hero_dark_willow/dark_willow_shadow_realm.vpcf",
				GetStatusEffectName = "particles/status_fx/status_effect_dark_willow_shadow_realm.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_NORMAL,
			}
		),
	},
	ab
)
m.modifier_dark_willow_talent_6 = ab
local ac = 400
local ad = 2000
local ae = 600
m.dark_willow_ult = c()
local af = m.dark_willow_ult
af.name = "dark_willow_ult"
d(af, u)
function af.prototype.____constructor(self, ...)
	u.prototype.____constructor(self, ...)
	self.DWWDummyList = {}
end
function af.prototype.OnSpellStart(self)
	local O = self:GetCaster()
	local G = O:GetEnemy()
	if not IsInjurable(O, G) then
		return
	end
	local H = self
	local ag = 1
	O:AddNewModifier(O, H, "modifier_dark_willow_ult_cast", { duration = ag })
	local ah = O:GetAttachmentPosition("attach_hitloc") + Vector(0, 0, 300)
	local ai = G:GetAbsOrigin()
	local aj = ai - ah
	local ak = -aj.z
	local al = self:SpawnDWWDummy(ah, "ACT_DOTA_IDLE")
	local am = aj
	am.z = 0
	am = am:Normalized()
	al:SetForwardVector(am)
	local an = self:GetSpecialValueFor("wisp_factor")
	local ao = self:GetSpecialValueFor("duration")
	local ap = self:GetTalentValue("dark_willow_talent_7", "count")
	local a9 = self:GetSpecialValueFor("damage") + self:GetTalentValue("dark_willow_talent_2", "damage_bonus")
	local S = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_dark_willow/dark_willow_wisp_spell_marker.vpcf",
		PATTACH_CUSTOMORIGIN,
		O
	)
	ParticleManager:SetParticleControl(S, 0, ai)
	ParticleManager:SetParticleControl(S, 1, Vector(ac, ac, ac))
	ParticleManager:ReleaseParticleIndex(S)
	local aq = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_dark_willow/dark_willow_wisp_spell_channel.vpcf",
		PATTACH_CUSTOMORIGIN,
		O
	)
	ParticleManager:SetParticleControl(aq, 0, ah)
	ParticleManager:ReleaseParticleIndex(aq)
	O:EmitSound("Hero_DarkWillow.Fear.Cast")
	EmitSoundOnLocationWithCaster(ai, "Hero_DarkWillow.Fear.Wisp", O)
	O:RemoveGesture(ACT_DOTA_CAST_ABILITY_1)
	O:StartGesture(ACT_DOTA_CAST_ABILITY_5)
	self:GameTimer(ag, function()
		self:DisposeDWWDummy(al)
		if not IsInjurable(O, G) then
			return
		end
		al = self:SpawnDWWDummy(ah, "ACT_DOTA_RUN")
		local ar = aj:Length2D() / ad
		local as = ak / ar
		local at = GameRules:GetGameTime()
		Projectile:CreateLinearProjectile({
			EffectName = "particles/econ/items/dark_willow/dark_willow_immortal_2021/dw_2021_willow_wisp_bedlam_projectile.vpcf",
			hCaster = O,
			vSpawnOrigin = ah,
			vDirection = aj:Normalized(),
			flDistance = aj:Length2D(),
			flRadius = 0,
			iMoveSpeed = ad,
			OnProjectileThink = function(a8, au)
				if IsValid(al) then
					al:SetAbsOrigin(Vector(a8.x, a8.y, ah.z - (GameRules:GetGameTime() - at) * as))
				end
			end,
			OnProjectileDestroy = function(a8, a6)
				if not IsValid(H) then
					return
				end
				H:DisposeDWWDummy(al)
				if not IsInjurable(O, G) then
					return
				end
				local R = G:GetAbsOrigin()
				EmitSoundOnLocationWithCaster(R, "Hero_DarkWillow.Fear.Location", O)
				local av = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_dark_willow/dark_willow_wisp_spell.vpcf",
					PATTACH_CUSTOMORIGIN,
					O
				)
				ParticleManager:SetParticleControl(av, 0, R)
				ParticleManager:SetParticleControl(av, 1, Vector(ac, 2, 1000))
				ParticleManager:ReleaseParticleIndex(av)
				local aw = 1 + GetWispCount(O) * an * 0.01
				G:EmitSound("Hero_DarkWillow.Fear.Target")
				H:TrackReturn(R)
				DamageSystem:dealDamage({
					attacker = O,
					target = G,
					ability = H,
					damage = a9 * aw,
					damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
					damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
					damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
				})
				G:AddNewModifier(O, H, "modifier_dark_willow_ult_debuff", { duration = ao * aw })
				if ap > 0 then
					local ax = O:FindModifierByName("modifier_dark_willow_talent")
					if IsValid(ax) then
						ax:addBramble(ap)
					end
				end
			end,
		})
	end)
end
function af.prototype.TrackReturn(self, ay)
	local al = self:SpawnDWWDummy(ay, "ACT_DOTA_CAST_ABILITY_5")
	local O = self:GetCaster()
	local H = self
	local az = O:GetAttachmentPosition("attach_hitloc")
	local aA = az.z
	local aj = az - ay
	local at = GameRules:GetGameTime()
	local ao = aj:Length2D() / ae
	local as = -aj.z / ao
	local aB = aA > ay.z and ay.z or aA
	local M = aA > ay.z and aA or ay.z
	Projectile:CreateTrackingProjectile({
		hCaster = O,
		vSpawnOrigin = ay,
		hTarget = O,
		iMoveSpeed = ae,
		OnProjectileThink = function(a8, a6)
			if IsValid(al) then
				al:SetAbsOrigin(Vector(a8.x, a8.y, Clamp(ay.z - (GameRules:GetGameTime() - at) * as, aB, M)))
				local aC = a8 - a6.vTarget
				aC.z = 0
				al:SetForwardVector(aC:Normalized())
			end
		end,
		OnProjectileDestroy = function(a8, a6)
			if IsValid(H) then
				H:DisposeDWWDummy(al)
			end
		end,
	})
end
function af.prototype.SpawnDWWDummy(self, a0, aD)
	if aD == nil then
		aD = "ACT_DOTA_RUN"
	end
	local a4 = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{
			origin = a0,
			model = Wearable:getReplaceUnitModel(self:GetCaster(), "models/heroes/dark_willow/dark_willow_wisp.vmdl"),
			DefaultAnim = aD,
			use_animgraph = "1",
			AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
		}
	)
	a4._AMBIENT_PARTICLE = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_dark_willow/dark_willow_willowisp_ambient.vpcf",
		PATTACH_CUSTOMORIGIN,
		a4,
		self:GetCaster()
	)
	ParticleManager:SetParticleControlEnt(
		a4._AMBIENT_PARTICLE,
		0,
		a4,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		vec3_zero,
		true
	)
	ParticleManager:SetParticleControlEnt(
		a4._AMBIENT_PARTICLE,
		1,
		a4,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		vec3_zero,
		true
	)
	local aE = self.DWWDummyList
	aE[#aE + 1] = a4
	return a4
end
function af.prototype.DisposeDWWDummy(self, a4)
	local B = f(self.DWWDummyList, a4)
	if B ~= -1 then
		k(self.DWWDummyList, B, 1)
	end
	if not IsValid(a4) then
		return
	end
	ParticleManager:DestroyParticle(a4._AMBIENT_PARTICLE, false)
	a4:RemoveSelf()
end
function af.prototype.DisposeAllDWWDummy(self)
	i(self.DWWDummyList, function(K, a4)
		self:DisposeDWWDummy(a4)
	end)
end
function af.prototype.GetIntrinsicModifierName(self)
	return "modifier_dark_willow_ult"
end
af = e({ v(nil) }, af)
m.dark_willow_ult = af
m.modifier_dark_willow_ult_cast = c()
local aF = m.modifier_dark_willow_ult_cast
aF.name = "modifier_dark_willow_ult_cast"
d(aF, r)
aF = e(
	{
		s(
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
	aF
)
m.modifier_dark_willow_ult_cast = aF
m.modifier_dark_willow_talent_5 = c()
local aG = m.modifier_dark_willow_talent_5
aG.name = "modifier_dark_willow_talent_5"
d(aG, r)
aG = e(
	{
		s(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetEffectAttachType = PATTACH_OVERHEAD_FOLLOW,
				GetEffectName = "particles/econ/items/dark_willow/dark_willow_immortal_2021/dw_2021_willow_wisp_spell_debuff.vpcf",
				GetStatusEffectName = "particles/econ/items/effigies/status_fx_effigies/status_effect_aghs_elite_statue.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	aG
)
m.modifier_dark_willow_talent_5 = aG
m.modifier_dark_willow_ult = c()
local aH = m.modifier_dark_willow_ult
aH.name = "modifier_dark_willow_ult"
d(aH, r)
function aH.prototype.OnRemoved(self, aI)
	if IsServer() then
		self:GetAbility():DisposeAllDWWDummy()
	end
end
aH = e(
	{
		s(
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
	aH
)
m.modifier_dark_willow_ult = aH
m.modifier_dark_willow_ult_debuff = c()
local aJ = m.modifier_dark_willow_ult_debuff
aJ.name = "modifier_dark_willow_ult_debuff"
d(aJ, r)
function aJ.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE] = -self:GetAbilitySpecialValueFor(
			"damage_reduce_pct"
		),
	}
end
aJ = e(
	{
		s(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetEffectName = "particles/units/heroes/hero_dark_willow/dark_willow_wisp_spell_debuff.vpcf",
				GetEffectAttachType = PATTACH_OVERHEAD_FOLLOW,
				GetStatusEffectName = "particles/status_fx/status_effect_dark_willow_wisp_fear.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_LOW,
				ShouldUseOverheadOffset = true,
			}
		),
	},
	aJ
)
m.modifier_dark_willow_ult_debuff = aJ
return m