--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/largo"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__New
local g = b.__TS__StringStartsWith
local h = b.__TS__ArraySplice
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 1,
		["12"] = 1,
		["13"] = 2,
		["14"] = 2,
		["15"] = 2,
		["16"] = 3,
		["17"] = 3,
		["18"] = 3,
		["19"] = 4,
		["20"] = 4,
		["21"] = 4,
		["22"] = 5,
		["23"] = 5,
		["24"] = 5,
		["25"] = 5,
		["26"] = 5,
		["27"] = 5,
		["28"] = 5,
		["29"] = 10,
		["30"] = 10,
		["31"] = 10,
		["32"] = 10,
		["33"] = 10,
		["34"] = 10,
		["35"] = 10,
		["36"] = 10,
		["37"] = 18,
		["38"] = 19,
		["39"] = 18,
		["40"] = 19,
		["41"] = 20,
		["42"] = 21,
		["43"] = 22,
		["45"] = 20,
		["46"] = 25,
		["47"] = 26,
		["48"] = 25,
		["49"] = 19,
		["50"] = 18,
		["51"] = 19,
		["53"] = 19,
		["54"] = 30,
		["55"] = 38,
		["56"] = 30,
		["57"] = 38,
		["59"] = 38,
		["60"] = 72,
		["61"] = 80,
		["62"] = 81,
		["63"] = 30,
		["64"] = 83,
		["65"] = 85,
		["66"] = 87,
		["67"] = 91,
		["68"] = 92,
		["69"] = 93,
		["70"] = 96,
		["71"] = 99,
		["72"] = 104,
		["73"] = 106,
		["74"] = 107,
		["75"] = 108,
		["76"] = 110,
		["77"] = 111,
		["78"] = 115,
		["79"] = 116,
		["80"] = 118,
		["81"] = 120,
		["82"] = 122,
		["83"] = 123,
		["84"] = 124,
		["85"] = 126,
		["86"] = 128,
		["87"] = 131,
		["88"] = 132,
		["89"] = 133,
		["90"] = 136,
		["91"] = 137,
		["92"] = 83,
		["93"] = 139,
		["94"] = 140,
		["95"] = 141,
		["96"] = 139,
		["97"] = 144,
		["98"] = 145,
		["99"] = 145,
		["100"] = 145,
		["101"] = 148,
		["102"] = 148,
		["103"] = 148,
		["104"] = 145,
		["105"] = 145,
		["106"] = 145,
		["107"] = 144,
		["108"] = 153,
		["109"] = 155,
		["110"] = 157,
		["111"] = 158,
		["112"] = 159,
		["114"] = 161,
		["115"] = 153,
		["116"] = 163,
		["117"] = 164,
		["118"] = 165,
		["119"] = 166,
		["120"] = 167,
		["121"] = 168,
		["124"] = 163,
		["125"] = 172,
		["126"] = 173,
		["127"] = 174,
		["128"] = 174,
		["129"] = 174,
		["130"] = 174,
		["132"] = 176,
		["133"] = 177,
		["135"] = 172,
		["136"] = 180,
		["137"] = 181,
		["138"] = 182,
		["139"] = 183,
		["141"] = 180,
		["142"] = 186,
		["143"] = 187,
		["144"] = 188,
		["145"] = 189,
		["146"] = 186,
		["147"] = 191,
		["148"] = 192,
		["149"] = 193,
		["151"] = 195,
		["152"] = 196,
		["154"] = 191,
		["155"] = 200,
		["156"] = 201,
		["157"] = 203,
		["158"] = 205,
		["160"] = 206,
		["161"] = 212,
		["162"] = 207,
		["164"] = 208,
		["165"] = 209,
		["167"] = 209,
		["169"] = 210,
		["171"] = 210,
		["174"] = 212,
		["175"] = 213,
		["176"] = 213,
		["177"] = 216,
		["180"] = 219,
		["182"] = 220,
		["183"] = 221,
		["185"] = 221,
		["187"] = 222,
		["189"] = 222,
		["192"] = 224,
		["193"] = 225,
		["194"] = 225,
		["195"] = 229,
		["198"] = 231,
		["200"] = 232,
		["201"] = 233,
		["203"] = 233,
		["205"] = 234,
		["207"] = 234,
		["210"] = 236,
		["211"] = 237,
		["212"] = 237,
		["213"] = 240,
		["214"] = 240,
		["215"] = 240,
		["216"] = 240,
		["217"] = 240,
		["218"] = 240,
		["219"] = 240,
		["220"] = 240,
		["221"] = 240,
		["222"] = 240,
		["226"] = 245,
		["227"] = 246,
		["228"] = 247,
		["230"] = 248,
		["231"] = 249,
		["233"] = 250,
		["234"] = 251,
		["235"] = 252,
		["237"] = 254,
		["238"] = 255,
		["242"] = 258,
		["243"] = 259,
		["244"] = 260,
		["245"] = 262,
		["246"] = 263,
		["247"] = 264,
		["249"] = 266,
		["250"] = 267,
		["251"] = 268,
		["252"] = 269,
		["253"] = 270,
		["259"] = 284,
		["260"] = 286,
		["261"] = 287,
		["262"] = 287,
		["263"] = 287,
		["264"] = 287,
		["265"] = 287,
		["266"] = 288,
		["267"] = 289,
		["268"] = 289,
		["269"] = 289,
		["270"] = 289,
		["271"] = 289,
		["272"] = 290,
		["273"] = 291,
		["274"] = 291,
		["275"] = 291,
		["276"] = 291,
		["277"] = 291,
		["279"] = 293,
		["280"] = 293,
		["281"] = 293,
		["282"] = 293,
		["283"] = 293,
		["286"] = 200,
		["287"] = 298,
		["288"] = 299,
		["289"] = 300,
		["290"] = 301,
		["291"] = 302,
		["292"] = 302,
		["295"] = 298,
		["296"] = 307,
		["297"] = 308,
		["298"] = 309,
		["299"] = 310,
		["301"] = 311,
		["302"] = 312,
		["304"] = 313,
		["305"] = 314,
		["306"] = 314,
		["307"] = 314,
		["308"] = 314,
		["309"] = 314,
		["310"] = 314,
		["311"] = 314,
		["315"] = 317,
		["317"] = 318,
		["318"] = 318,
		["319"] = 318,
		["320"] = 318,
		["321"] = 318,
		["322"] = 318,
		["325"] = 320,
		["327"] = 321,
		["328"] = 322,
		["329"] = 322,
		["330"] = 322,
		["331"] = 322,
		["332"] = 322,
		["333"] = 322,
		["334"] = 322,
		["338"] = 325,
		["340"] = 326,
		["341"] = 327,
		["342"] = 327,
		["343"] = 327,
		["344"] = 327,
		["345"] = 327,
		["346"] = 327,
		["347"] = 327,
		["351"] = 330,
		["353"] = 331,
		["354"] = 331,
		["355"] = 331,
		["356"] = 331,
		["357"] = 331,
		["358"] = 331,
		["361"] = 333,
		["363"] = 334,
		["364"] = 334,
		["365"] = 334,
		["366"] = 334,
		["367"] = 334,
		["368"] = 334,
		["372"] = 307,
		["373"] = 339,
		["374"] = 340,
		["375"] = 342,
		["376"] = 343,
		["377"] = 344,
		["378"] = 344,
		["379"] = 344,
		["380"] = 344,
		["381"] = 344,
		["382"] = 344,
		["384"] = 346,
		["385"] = 347,
		["386"] = 347,
		["387"] = 347,
		["388"] = 347,
		["389"] = 347,
		["390"] = 347,
		["392"] = 349,
		["393"] = 350,
		["394"] = 351,
		["395"] = 352,
		["396"] = 353,
		["397"] = 354,
		["398"] = 355,
		["399"] = 356,
		["400"] = 356,
		["401"] = 356,
		["402"] = 357,
		["403"] = 358,
		["404"] = 359,
		["405"] = 360,
		["406"] = 360,
		["407"] = 360,
		["408"] = 360,
		["409"] = 360,
		["410"] = 360,
		["411"] = 360,
		["412"] = 360,
		["413"] = 360,
		["414"] = 361,
		["415"] = 361,
		["416"] = 361,
		["417"] = 361,
		["418"] = 361,
		["419"] = 362,
		["420"] = 362,
		["421"] = 362,
		["422"] = 362,
		["423"] = 362,
		["424"] = 362,
		["425"] = 362,
		["426"] = 362,
		["427"] = 362,
		["428"] = 363,
		["429"] = 363,
		["430"] = 363,
		["431"] = 363,
		["432"] = 363,
		["433"] = 363,
		["434"] = 364,
		["435"] = 365,
		["436"] = 366,
		["437"] = 366,
		["438"] = 366,
		["439"] = 366,
		["440"] = 366,
		["441"] = 366,
		["442"] = 366,
		["443"] = 366,
		["444"] = 366,
		["446"] = 356,
		["447"] = 356,
		["449"] = 373,
		["450"] = 374,
		["451"] = 375,
		["453"] = 377,
		["454"] = 378,
		["457"] = 381,
		["458"] = 382,
		["459"] = 382,
		["460"] = 382,
		["461"] = 382,
		["462"] = 382,
		["464"] = 383,
		["465"] = 384,
		["467"] = 385,
		["468"] = 385,
		["469"] = 385,
		["470"] = 385,
		["471"] = 385,
		["472"] = 385,
		["473"] = 391,
		["474"] = 391,
		["475"] = 391,
		["476"] = 391,
		["477"] = 391,
		["478"] = 392,
		["481"] = 394,
		["483"] = 395,
		["484"] = 397,
		["486"] = 397,
		["489"] = 399,
		["490"] = 399,
		["491"] = 399,
		["492"] = 399,
		["493"] = 399,
		["494"] = 400,
		["495"] = 400,
		["496"] = 400,
		["497"] = 400,
		["498"] = 400,
		["501"] = 402,
		["503"] = 403,
		["504"] = 403,
		["505"] = 403,
		["506"] = 403,
		["507"] = 403,
		["508"] = 403,
		["509"] = 403,
		["510"] = 403,
		["511"] = 403,
		["512"] = 403,
		["513"] = 404,
		["514"] = 404,
		["515"] = 404,
		["516"] = 404,
		["517"] = 404,
		["518"] = 405,
		["519"] = 405,
		["520"] = 405,
		["521"] = 405,
		["522"] = 405,
		["526"] = 408,
		["527"] = 339,
		["528"] = 411,
		["529"] = 412,
		["530"] = 413,
		["531"] = 414,
		["532"] = 415,
		["533"] = 416,
		["534"] = 417,
		["535"] = 419,
		["536"] = 420,
		["537"] = 421,
		["538"] = 422,
		["540"] = 425,
		["541"] = 426,
		["542"] = 427,
		["545"] = 430,
		["546"] = 431,
		["547"] = 432,
		["548"] = 433,
		["550"] = 435,
		["552"] = 411,
		["553"] = 38,
		["554"] = 30,
		["555"] = 30,
		["556"] = 30,
		["557"] = 30,
		["558"] = 30,
		["559"] = 30,
		["560"] = 30,
		["561"] = 30,
		["562"] = 38,
		["564"] = 38,
		["565"] = 438,
		["566"] = 443,
		["567"] = 450,
		["568"] = 443,
		["569"] = 450,
		["570"] = 451,
		["571"] = 453,
		["572"] = 451,
		["573"] = 455,
		["574"] = 456,
		["575"] = 457,
		["577"] = 455,
		["578"] = 460,
		["579"] = 461,
		["580"] = 462,
		["581"] = 463,
		["584"] = 460,
		["585"] = 450,
		["586"] = 443,
		["587"] = 443,
		["588"] = 443,
		["589"] = 443,
		["590"] = 443,
		["591"] = 443,
		["592"] = 443,
		["593"] = 450,
		["595"] = 450,
		["596"] = 468,
		["597"] = 475,
		["598"] = 468,
		["599"] = 475,
		["600"] = 476,
		["601"] = 478,
		["602"] = 476,
		["603"] = 480,
		["604"] = 481,
		["605"] = 482,
		["607"] = 480,
		["608"] = 485,
		["609"] = 486,
		["610"] = 487,
		["611"] = 488,
		["614"] = 485,
		["615"] = 475,
		["616"] = 468,
		["617"] = 468,
		["618"] = 468,
		["619"] = 468,
		["620"] = 468,
		["621"] = 468,
		["622"] = 468,
		["623"] = 475,
		["625"] = 475,
		["626"] = 493,
		["627"] = 500,
		["628"] = 493,
		["629"] = 500,
		["630"] = 501,
		["631"] = 503,
		["632"] = 501,
		["633"] = 505,
		["634"] = 506,
		["635"] = 507,
		["637"] = 505,
		["638"] = 510,
		["639"] = 511,
		["640"] = 512,
		["641"] = 513,
		["644"] = 510,
		["645"] = 500,
		["646"] = 493,
		["647"] = 493,
		["648"] = 493,
		["649"] = 493,
		["650"] = 493,
		["651"] = 493,
		["652"] = 493,
		["653"] = 500,
		["655"] = 500,
		["656"] = 519,
		["657"] = 527,
		["658"] = 519,
		["659"] = 527,
		["660"] = 532,
		["661"] = 534,
		["662"] = 535,
		["663"] = 532,
		["664"] = 537,
		["665"] = 538,
		["666"] = 539,
		["668"] = 537,
		["669"] = 542,
		["670"] = 543,
		["671"] = 544,
		["673"] = 542,
		["674"] = 547,
		["675"] = 548,
		["677"] = 547,
		["678"] = 552,
		["679"] = 553,
		["680"] = 552,
		["681"] = 561,
		["682"] = 563,
		["683"] = 561,
		["684"] = 527,
		["685"] = 519,
		["686"] = 519,
		["687"] = 519,
		["688"] = 519,
		["689"] = 519,
		["690"] = 519,
		["691"] = 519,
		["692"] = 519,
		["693"] = 527,
		["695"] = 527,
		["696"] = 614,
		["697"] = 622,
		["698"] = 614,
		["699"] = 622,
		["700"] = 624,
		["701"] = 625,
		["702"] = 626,
		["704"] = 624,
		["705"] = 631,
		["706"] = 632,
		["707"] = 633,
		["709"] = 631,
		["710"] = 638,
		["711"] = 639,
		["713"] = 638,
		["714"] = 643,
		["715"] = 644,
		["716"] = 643,
		["717"] = 646,
		["718"] = 647,
		["719"] = 646,
		["720"] = 651,
		["721"] = 652,
		["722"] = 651,
		["723"] = 622,
		["724"] = 614,
		["725"] = 614,
		["726"] = 614,
		["727"] = 614,
		["728"] = 614,
		["729"] = 614,
		["730"] = 614,
		["731"] = 614,
		["732"] = 622,
		["734"] = 622,
		["735"] = 658,
		["736"] = 659,
		["737"] = 658,
		["738"] = 659,
		["739"] = 660,
		["740"] = 661,
		["741"] = 662,
		["742"] = 663,
		["743"] = 664,
		["744"] = 665,
		["745"] = 666,
		["747"] = 660,
		["748"] = 659,
		["749"] = 658,
		["750"] = 659,
		["752"] = 659,
		["753"] = 672,
		["754"] = 679,
		["755"] = 672,
		["756"] = 679,
		["757"] = 681,
		["758"] = 682,
		["759"] = 681,
		["760"] = 684,
		["761"] = 685,
		["762"] = 687,
		["763"] = 688,
		["764"] = 688,
		["766"] = 691,
		["767"] = 692,
		["768"] = 692,
		["769"] = 692,
		["770"] = 692,
		["771"] = 692,
		["772"] = 692,
		["773"] = 692,
		["774"] = 692,
		["775"] = 692,
		["776"] = 693,
		["777"] = 693,
		["778"] = 693,
		["779"] = 693,
		["780"] = 693,
		["781"] = 693,
		["782"] = 693,
		["783"] = 693,
		["784"] = 693,
		["785"] = 694,
		["786"] = 694,
		["787"] = 694,
		["788"] = 694,
		["789"] = 694,
		["790"] = 694,
		["791"] = 694,
		["792"] = 694,
		["793"] = 694,
		["794"] = 695,
		["795"] = 695,
		["796"] = 695,
		["797"] = 695,
		["798"] = 695,
		["799"] = 695,
		["800"] = 695,
		["801"] = 695,
		["802"] = 695,
		["803"] = 696,
		["804"] = 696,
		["805"] = 696,
		["806"] = 696,
		["807"] = 696,
		["808"] = 696,
		["809"] = 696,
		["810"] = 696,
		["812"] = 684,
		["813"] = 699,
		["814"] = 700,
		["815"] = 701,
		["816"] = 699,
		["817"] = 703,
		["818"] = 703,
		["819"] = 706,
		["820"] = 707,
		["821"] = 709,
		["822"] = 709,
		["824"] = 706,
		["825"] = 712,
		["826"] = 713,
		["827"] = 712,
		["828"] = 717,
		["829"] = 718,
		["830"] = 717,
		["831"] = 722,
		["832"] = 723,
		["833"] = 722,
		["834"] = 679,
		["835"] = 672,
		["836"] = 672,
		["837"] = 672,
		["838"] = 672,
		["839"] = 672,
		["840"] = 672,
		["841"] = 672,
		["842"] = 679,
		["844"] = 679,
	}
)
local j = {}
local k = require("class.weight_pool")
local l = k.CWeightPool
local m = require("lib.dota_ts_adapter")
local n = m.BaseAbility
local o = m.registerAbility
local p = require("modifiers.eom_modifier")
local q = p.EOMModifier
local r = p.registerEOMModifier
local s = require("abilities.ability_ai")
local t = s.BaseAbilityAI
local u = s.registerAbilityAI
local PLAY_TYPE = PLAY_TYPE or {}
PLAY_TYPE.red = 0
PLAY_TYPE[PLAY_TYPE.red] = "red"
PLAY_TYPE.purple = 1
PLAY_TYPE[PLAY_TYPE.purple] = "purple"
PLAY_TYPE.green = 2
PLAY_TYPE[PLAY_TYPE.green] = "green"
local v = {
	"Hero_Largo.AmphibianRhapsody.Song0.Stop",
	"Hero_Largo.AmphibianRhapsody.Song1.Stop",
	"Hero_Largo.AmphibianRhapsody.Song3.Stop",
	"Hero_Largo.AmphibianRhapsody.Song4.Stop",
	"Hero_Largo.AmphibianRhapsody.Song5.Stop",
	"Hero_Largo.AmphibianRhapsody.Song6.Stop",
}
j.largo_talent = c()
local w = j.largo_talent
w.name = "largo_talent"
d(w, n)
function w.prototype.Spawn(self)
	if IsServer() then
		self:GetCaster():AddActivityModifier("attack_long_range")
	end
end
function w.prototype.GetIntrinsicModifierName(self)
	return "modifier_largo_talent"
end
w = e({ o(nil) }, w)
j.largo_talent = w
j.modifier_largo_talent = c()
local x = j.modifier_largo_talent
x.name = "modifier_largo_talent"
d(x, q)
function x.prototype.____constructor(self, ...)
	q.prototype.____constructor(self, ...)
	self.haveSect = {}
	self.beatCount = 0
	self.MusicCount = 0
end
function x.prototype.GetAbilitySpecialValue(self)
	self.heal_custom_mama = self:GetAbilitySpecialValueFor("heal_custom_mama")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.add_custom_mama = self:GetAbilitySpecialValueFor("add_custom_mama")
	self.sect_stack = self:GetAbilitySpecialValueFor("sect_stack")
	self.add_hp = self:GetAbilitySpecialValueFor("add_hp")
	self.tl3_add_custom_mama = self:GetAbilityTalentValue("largo_talent_3", "add_custom_mama")
	self.count = self:GetAbilitySpecialValueFor("count")
	self.red_duration = self:GetAbilitySpecialValueFor("red_duration")
	self.reply_ability_chance_base = self:GetAbilitySpecialValueFor("reply_ability_chance_base")
	self.reply_ability_chance_add = self:GetAbilitySpecialValueFor("reply_ability_chance_add")
	self.reply_ability_count = self:GetAbilitySpecialValueFor("reply_ability_count")
	self.double_add_hp = self:GetAbilitySpecialValueFor("double_add_hp")
	self.add_hp_bonus = self:GetAbilitySpecialValueFor("add_hp_bonus")
	self.tl1_magic_damage = self:GetAbilityTalentValue("largo_talent_1", "magic_damage")
	self.tl1_add_chance = self:GetAbilityTalentValue("largo_talent_1", "add_chance")
	self.tl2_reduce_interval = self:GetAbilityTalentValue("largo_talent_2", "reduce_interval")
	self.tl4_bonus = self:GetAbilityTalentValue("largo_talent_4", "bonus")
	self.tl4_cost_mama = self:GetAbilityTalentValue("largo_talent_4", "cost_mama")
	self.tl4_damage = self:GetAbilityTalentValue("largo_talent_4", "damage")
	self.tl4_reply_health = self:GetAbilityTalentValue("largo_talent_4", "reply_health")
	self.tl5_chance = self:GetAbilityTalentValue("largo_talent_5", "play_chance")
	self.tl6_duration = self:GetAbilityTalentValue("largo_talent_6", "duration")
	self.shard_consume = self:GetAbilityTalentValue("largo_shard", "consume")
	self.shard_damage = self:GetAbilityTalentValue("largo_shard", "damage")
	self.shard_reply_health = self:GetAbilityTalentValue("largo_shard", "reply_health")
	self.ult_interval_reduce = self:GetAbilityTalentValue("largo_ult", "interval_reduce")
	self.ult_reduce_custom_mama = self:GetAbilityTalentValue("largo_ult", "reduce_custom_mama")
end
function x.prototype.OnCreated(self, y)
	self.hCaster = self:GetCaster()
	self.pool = f(l, { red = 33, purple = 33, green = 33 })
end
function x.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_HEAL] = { self:GetParent() },
	}
end
function x.prototype.OnBattleStartBefore(self, y)
	self:GetSect()
	local z = self.parent:GetHeroBase():getAbilityData()
	if z.sect_regen then
		self.regen_exp = z.sect_regen.exp
	end
	self.shard_link_ability = self.parent:FindAbilityByName("largo_catchy_lick")
end
function x.prototype.OnBattleStart(self, y)
	if IsServer() then
		self.record = {}
		self:StartIntervalThink(self.interval - self.tl2_reduce_interval)
		if self.parent:FindModifierByName("modifier_sect_ulti_81_buff") then
			RestoreCustomMana(self.parent, 100)
		end
	end
end
function x.prototype.OnHeal(self, y)
	if self.tl5_chance > 0 and self:PRD(self.tl5_chance) then
		self:StartThink(self.interval - self.tl2_reduce_interval, "MorePlay_" .. DoUniqueString(""))
	end
	if not self.parent:HasModifier("modifier_largo_ult") then
		RestoreCustomMana(self.hCaster, self.heal_custom_mama)
	end
end
function x.prototype.OnThink(self, A)
	if g(A, "MorePlay_") then
		self:PlayingMusic()
		self:StartThink(-1, A)
	end
end
function x.prototype.OnBattleEnd(self, y)
	self:SetStackCount(0)
	self:StartIntervalThink(-1)
	self.parent:RemoveModifierByName("modifier_largo_ult")
end
function x.prototype.OnIntervalThink(self)
	if self.parent:HasModifier("modifier_largo_ult") then
		self:StartIntervalThink((self.interval - self.tl2_reduce_interval) * (1 - self.ult_interval_reduce * 0.01))
	end
	if not self.parent:PassivesDisabled() then
		self:PlayingMusic()
	end
end
function x.prototype.PlayingMusic(self)
	self.beatCount = self.beatCount + 1
	local B = self:GetPlayingColor()
	self.hCaster:EmitSound("Hero_Largo.InstrumentBash.Layer")
	repeat
		local C = B
		local D
		local E = C == PLAY_TYPE.red
		if E then
			if not self.parent:HasModifier("modifier_largo_talent_note_red") then
				local F = self.parent:FindModifierByName("modifier_largo_talent_note_green")
				if F ~= nil then
					F:Destroy()
				end
				local G = self.parent:FindModifierByName("modifier_largo_talent_note_purple")
				if G ~= nil then
					G:Destroy()
				end
			end
			D = self.parent:AddNewModifier(self.parent, self.ability, "modifier_largo_talent_note_red", nil)
			local H = self.record
			H[#H + 1] = B
			RestoreCustomMana(self.hCaster, self.add_custom_mama * (1 + self.tl4_bonus * 0.01))
			break
		end
		E = E or C == PLAY_TYPE.purple
		if E then
			if not self.parent:HasModifier("modifier_largo_talent_note_purple") then
				local I = self.parent:FindModifierByName("modifier_largo_talent_note_green")
				if I ~= nil then
					I:Destroy()
				end
				local J = self.parent:FindModifierByName("modifier_largo_talent_note_red")
				if J ~= nil then
					J:Destroy()
				end
			end
			D = self.parent:AddNewModifier(self.parent, self.ability, "modifier_largo_talent_note_purple", nil)
			local K = self.record
			K[#K + 1] = B
			self:AddSect()
			break
		end
		E = E or C == PLAY_TYPE.green
		if E then
			if not self.parent:HasModifier("modifier_largo_talent_note_green") then
				local L = self.parent:FindModifierByName("modifier_largo_talent_note_red")
				if L ~= nil then
					L:Destroy()
				end
				local M = self.parent:FindModifierByName("modifier_largo_talent_note_purple")
				if M ~= nil then
					M:Destroy()
				end
			end
			D = self.parent:AddNewModifier(self.parent, self.ability, "modifier_largo_talent_note_green", nil)
			local N = self.record
			N[#N + 1] = B
			local O = Heal
			local P = self.hCaster
			local Q = self.add_hp * (1 + self.tl4_bonus * 0.01)
			local R = self:GetAbility()
			O(P, Q, R and R:GetName(), "Ability")
			break
		end
	until true
	local S = false
	self:IncrementStackCount()
	if #self.record >= self.count then
		repeat
			local T = #self.record
			local U = T == 2
			if U then
				if self.record[1] == self.record[2] then
					S = true
					self:MusicTrigger(self.record[1])
				end
				self:SetStackCount(1)
				h(self.record, 0, #self.record, self.record[2])
				break
			end
			do
				if self.record[1] == self.record[2] or self.record[1] == self.record[3] then
					S = true
					self:MusicTrigger(self.record[1])
				elseif self.record[2] == self.record[3] then
					S = true
					self:MusicTrigger(self.record[2])
				end
				self:SetStackCount(1)
				if self.count == 3 then
					h(self.record, 0, 1)
				elseif self.count == 2 then
					h(self.record, 0, #self.record, self.record[3])
				end
				break
			end
		until true
	end
	if not S then
		local V = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_largo/largo_amphibian_rhapsody_aoe_wide_rings.vpcf",
			PATTACH_ABSORIGIN,
			self.hCaster
		)
		ParticleManager:SetParticleControl(V, 1, Vector(800, 0, 0))
		if B == PLAY_TYPE.red then
			ParticleManager:SetParticleControl(V, 11, Vector(1, 0, 0))
		elseif B == PLAY_TYPE.purple then
			ParticleManager:SetParticleControl(V, 11, Vector(1, 0, 1))
		else
			ParticleManager:SetParticleControl(V, 11, Vector(0, 1, 0))
		end
	end
end
function x.prototype.GetSect(self)
	local W = AbilityShop.pickList
	for X, Y in ipairs(W) do
		if
			Y == "sect_ice"
			or Y == "sect_fury"
			or Y == "sect_injury"
			or Y == "sect_poison"
			or Y == "sect_shield"
			or Y == "sect_chaos"
		then
			local Z = self.haveSect
			Z[#Z + 1] = Y
		end
	end
end
function x.prototype.AddSect(self)
	local _ = self.parent
	local a0 = _:GetEnemy()
	local a1 = self.haveSect[math.floor(#self.haveSect * math.random()) + 1]
	repeat
		local a2 = a1
		local a3 = a2 == "sect_ice"
		if a3 then
			if IsValid(a0) and IsInjurable(a0) then
				AddIce(_, a0, self.sect_stack * (1 + self.tl4_bonus * 0.01), self.ability:GetAbilityName(), "Ability")
			end
			break
		end
		a3 = a3 or a2 == "sect_fury"
		if a3 then
			AddFury(_, self.sect_stack * (1 + self.tl4_bonus * 0.01), self.ability:GetAbilityName(), "Ability")
			break
		end
		a3 = a3 or a2 == "sect_injury"
		if a3 then
			if IsValid(a0) and IsInjurable(a0) then
				AddInjury(
					_,
					a0,
					self.sect_stack * (1 + self.tl4_bonus * 0.01),
					self.ability:GetAbilityName(),
					"Ability"
				)
			end
			break
		end
		a3 = a3 or a2 == "sect_poison"
		if a3 then
			if IsValid(a0) and IsInjurable(a0) then
				AddPoison(
					_,
					a0,
					self.sect_stack * (1 + self.tl4_bonus * 0.01),
					self.ability:GetAbilityName(),
					"Ability"
				)
			end
			break
		end
		a3 = a3 or a2 == "sect_shield"
		if a3 then
			AddShield(_, self.sect_stack * (1 + self.tl4_bonus * 0.01), self.ability:GetAbilityName(), "Ability")
			break
		end
		a3 = a3 or a2 == "sect_chaos"
		if a3 then
			AddChaos(_, self.sect_stack * (1 + self.tl4_bonus * 0.01), self.ability:GetAbilityName(), "Ability")
			break
		end
	until true
end
function x.prototype.MusicTrigger(self, B)
	self.MusicCount = self.MusicCount + 1
	self.hCaster:StartGesture(ACT_DOTA_TRANSITION)
	if self.tl1_magic_damage > 0 then
		self.parent:DealDamage(
			self.parent:GetEnemy(),
			self:GetAbility(),
			self.tl1_magic_damage,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
		)
	end
	if self.tl6_duration > 0 then
		self.parent:AddNewModifier(
			self.hCaster,
			self:GetAbility(),
			"modifier_largo_talent_6",
			{ duration = self.tl6_duration }
		)
	end
	if self.parent:HasModifier("modifier_largo_ult") then
		ReduceCustomMana(self.parent, self.ult_reduce_custom_mama)
		if self.shard_consume > 0 then
			local a4 = self.parent
			local a5 = a4:GetEnemy()
			a4:StartGesture(ACT_DOTA_CAST_ABILITY_1)
			a4:EmitSound("Hero_Largo.CatchyLick.Cast")
			GameTimer(0.1, function()
				if IsValid(self) and IsValid(self.ability) and IsInjurable(a4, a5) then
					a4:EmitSound("Hero_Largo.CatchyLick.Target.Ally")
					local a6 = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_largo/largo_catchy_lick.vpcf",
						PATTACH_ABSORIGIN,
						a4
					)
					ParticleManager:SetParticleControlEnt(
						a6,
						0,
						self.parent,
						PATTACH_POINT_FOLLOW,
						"attach_mouth",
						vec3_zero,
						false
					)
					ParticleManager:SetParticleControlForward(
						a6,
						1,
						(a5:GetAbsOrigin() - self.parent:GetAbsOrigin()):Normalized()
					)
					ParticleManager:SetParticleControlEnt(
						a6,
						1,
						a5,
						PATTACH_POINT_FOLLOW,
						"attach_hitloc",
						vec3_zero,
						true
					)
					ParticleManager:SetParticleControlTransform(
						a6,
						11,
						self.parent:GetAttachmentPosition("attach_mouth"),
						VectorAngles((a5:GetAbsOrigin() - self.parent:GetAbsOrigin()):Normalized())
					)
					self.parent:DealDamage(
						a5,
						self.shard_link_ability,
						self.shard_damage,
						EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
					)
					a4:EmitSound("Hero_Largo.CatchyLick.Target")
					local a7 = Heal
					local a8 = self.shard_reply_health
					local a9 = self.shard_link_ability
					a7(a4, a8, a9 and a9:GetName(), "Ability")
				end
			end)
		end
		if self.parent:GetMana() <= 0 then
			self.parent:SetMana(0)
			self.parent:RemoveModifierByName("modifier_largo_ult")
		end
		if self.tl3_add_custom_mama > 0 then
			RestoreCustomMana(self.parent, self.tl3_add_custom_mama)
		end
	end
	local aa = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_largo/largo_amphibian_rhapsody_aoe.vpcf",
		PATTACH_ABSORIGIN,
		self.hCaster
	)
	ParticleManager:SetParticleControl(aa, 1, Vector(400, 0, 0))
	repeat
		local ab = B
		local ac = ab == PLAY_TYPE.red
		if ac then
			self.hCaster:AddNewModifier(
				self.hCaster,
				self:GetAbility(),
				"modifier_talent_red",
				{ duration = self.red_duration }
			)
			ParticleManager:SetParticleControl(aa, 0, self.hCaster:GetAbsOrigin())
			ParticleManager:SetParticleControl(aa, 3, vec3_zero)
			break
		end
		ac = ac or ab == PLAY_TYPE.purple
		if ac then
			if self:PRD(self.reply_ability_chance_base + self.reply_ability_chance_add * self.regen_exp) then
				local ad = self.hCaster:FindModifierByName("modifier_sect_regen")
				if ad ~= nil then
					ad:GetHealAbility(math.floor(self.reply_ability_count))
				end
			end
			ParticleManager:SetParticleControl(aa, 0, self.hCaster:GetAbsOrigin())
			ParticleManager:SetParticleControl(aa, 3, Vector(3, 3, 0))
			break
		end
		ac = ac or ab == PLAY_TYPE.green
		if ac then
			local ae = Heal
			local af = self.hCaster
			local ag = self.double_add_hp + self.parent:GetHealthDeficit() * self.add_hp_bonus * 0.01
			local ah = self:GetAbility()
			ae(af, ag, ah and ah:GetName(), "Ability")
			ParticleManager:SetParticleControl(aa, 0, self.hCaster:GetAbsOrigin())
			ParticleManager:SetParticleControl(aa, 3, Vector(1, 1, 0))
			break
		end
	until true
	self.parent:EmitSound(v[RandomInt(0, #v - 1) + 1])
end
function x.prototype.GetPlayingColor(self)
	local B = self.pool:random()
	if self.tl1_add_chance > 0 then
		if B == "red" then
			self.pool:set("red", 33 * (1 + self.tl1_add_chance * 0.01))
			self.pool:set("purple", 33 * (1 - self.tl1_add_chance * 0.01 / 2))
			self.pool:set("green", 33 * (1 - self.tl1_add_chance * 0.01 / 2))
		elseif B == "purple" then
			self.pool:set("purple", 33 * (1 + self.tl1_add_chance * 0.01))
			self.pool:set("red", 33 * (1 - self.tl1_add_chance * 0.01 / 2))
			self.pool:set("green", 33 * (1 - self.tl1_add_chance * 0.01 / 2))
		else
			self.pool:set("green", 33 * (1 + self.tl1_add_chance * 0.01))
			self.pool:set("red", 33 * (1 - self.tl1_add_chance * 0.01 / 2))
			self.pool:set("purple", 33 * (1 - self.tl1_add_chance * 0.01 / 2))
		end
	end
	if B == "red" then
		return PLAY_TYPE.red
	elseif B == "purple" then
		return PLAY_TYPE.purple
	else
		return PLAY_TYPE.green
	end
end
x = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	x
)
j.modifier_largo_talent = x
local ai = {
	[PLAY_TYPE.red] = "largo_song_fight_song_rhythm",
	[PLAY_TYPE.green] = "largo_song_good_vibrations_rhythm",
	[PLAY_TYPE.purple] = "largo_song_double_time_rhythm",
}
j.modifier_largo_talent_note_purple = c()
local aj = j.modifier_largo_talent_note_purple
aj.name = "modifier_largo_talent_note_purple"
d(aj, q)
function aj.prototype.GetTexture(self)
	return ai[PLAY_TYPE.purple]
end
function aj.prototype.OnCreated(self, y)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function aj.prototype.OnRefresh(self, y)
	if IsServer() then
		if self:GetStackCount() < 3 then
			self:IncrementStackCount()
		end
	end
end
aj = e(
	{ r(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	aj
)
j.modifier_largo_talent_note_purple = aj
j.modifier_largo_talent_note_green = c()
local ak = j.modifier_largo_talent_note_green
ak.name = "modifier_largo_talent_note_green"
d(ak, q)
function ak.prototype.GetTexture(self)
	return ai[PLAY_TYPE.green]
end
function ak.prototype.OnCreated(self, y)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function ak.prototype.OnRefresh(self, y)
	if IsServer() then
		if self:GetStackCount() < 3 then
			self:IncrementStackCount()
		end
	end
end
ak = e(
	{ r(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	ak
)
j.modifier_largo_talent_note_green = ak
j.modifier_largo_talent_note_red = c()
local al = j.modifier_largo_talent_note_red
al.name = "modifier_largo_talent_note_red"
d(al, q)
function al.prototype.GetTexture(self)
	return ai[PLAY_TYPE.red]
end
function al.prototype.OnCreated(self, y)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function al.prototype.OnRefresh(self, y)
	if IsServer() then
		if self:GetStackCount() < 3 then
			self:IncrementStackCount()
		end
	end
end
al = e(
	{ r(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	al
)
j.modifier_largo_talent_note_red = al
j.modifier_talent_red = c()
local am = j.modifier_talent_red
am.name = "modifier_talent_red"
d(am, q)
function am.prototype.GetAbilitySpecialValue(self)
	self.factor = self:GetAbilitySpecialValueFor("factor")
	self.reply = self:GetAbilitySpecialValueFor("reply")
end
function am.prototype.OnCreated(self, y)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function am.prototype.OnRefresh(self, y)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function am.prototype.OnDestroy(self)
	if IsServer() then
	end
end
function am.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_MAGICAL_DAMAGE_PERCENTAGE }
end
function am.prototype.EOM_GetModifierOutgoingMagicalDamagePercentage(self, y)
	return self.factor * self:GetStackCount()
end
am = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				IsIndependent = true,
			}
		),
	},
	am
)
j.modifier_talent_red = am
j.modifier_largo_talent_6 = c()
local an = j.modifier_largo_talent_6
an.name = "modifier_largo_talent_6"
d(an, q)
function an.prototype.OnCreated(self, y)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function an.prototype.OnRefresh(self, y)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function an.prototype.OnDestroy(self)
	if IsServer() then
	end
end
function an.prototype.GetAbilitySpecialValue(self)
	self.tl6_damage_reduce = self:GetAbilityTalentValue("largo_talent_6", "damage_reduce")
end
function an.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function an.prototype.EOM_GetModifierIncomingDamagePercentage(self, y)
	return -self.tl6_damage_reduce * self:GetStackCount()
end
an = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				IsIndependent = true,
			}
		),
	},
	an
)
j.modifier_largo_talent_6 = an
j.largo_ult = c()
local ao = j.largo_ult
ao.name = "largo_ult"
d(ao, t)
function ao.prototype.OnSpellStart(self)
	local ap = self:GetCaster()
	ap:StartGesture(ACT_DOTA_CAST_ABILITY_3)
	ap:EmitSound("Hero_Largo.CroakOfGenius.Cast")
	ap:EmitSound("Hero_Largo.CroakOfGenius.Target")
	if not ap:HasModifier("modifier_largo_ult") then
		ap:AddNewModifier(ap, self, "modifier_largo_ult", {})
	end
end
ao = e({ u(nil) }, ao)
j.largo_ult = ao
j.modifier_largo_ult = c()
local aq = j.modifier_largo_ult
aq.name = "modifier_largo_ult"
d(aq, q)
function aq.prototype.GetAbilitySpecialValue(self)
	self.reply = self:GetAbilitySpecialValueFor("reply")
end
function aq.prototype.OnCreated(self, y)
	if IsServer() then
		self:StartThink(FRAME_TIME)
		local ar, as = self.parent:FindModifierByName("modifier_largo_talent"), "count"
		ar[as] = ar[as] + 1
	else
		local at = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_largo/largo_croak_genius_buff.vpcf",
			PATTACH_CUSTOMORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControlEnt(
			at,
			0,
			self.parent,
			PATTACH_ABSORIGIN_FOLLOW,
			nil,
			self.parent:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			at,
			1,
			self.parent,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self.parent:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			at,
			3,
			self.parent,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self.parent:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			at,
			10,
			self.parent,
			PATTACH_ABSORIGIN_FOLLOW,
			nil,
			self.parent:GetAbsOrigin(),
			true
		)
		self:AddParticle(at, false, false, -1, false, false)
	end
end
function aq.prototype.OnThink(self, A)
	self:StartThink(-1)
	self.parent:FindModifierByName("modifier_largo_talent"):MusicTrigger(math.floor(math.random() * 3))
end
function aq.prototype.OnRefresh(self, y) end
function aq.prototype.OnDestroy(self)
	if IsServer() then
		local au, av = self.parent:FindModifierByName("modifier_largo_talent"), "count"
		au[av] = au[av] - 1
	end
end
function aq.prototype.ECheckState(self)
	return { [EOMModifierStates.MODIFIER_STATE_CUSTOM_ULT] = true }
end
function aq.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_BONUS }
end
function aq.prototype.EOM_GetModifierHealthBonus(self)
	return self.reply
end
aq = e(
	{ r(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	aq
)
j.modifier_largo_ult = aq
return j