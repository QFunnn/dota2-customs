--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/events"
local b = require("lualib_bundle")
local c = b.__TS__ArrayFilter
local d = b.__TS__ArraySplice
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["7"] = 6,
		["8"] = 6,
		["9"] = 6,
		["10"] = 6,
		["11"] = 6,
		["12"] = 6,
		["13"] = 6,
		["14"] = 6,
		["15"] = 6,
		["16"] = 6,
		["17"] = 6,
		["18"] = 6,
		["19"] = 6,
		["20"] = 6,
		["21"] = 6,
		["22"] = 6,
		["23"] = 6,
		["24"] = 6,
		["25"] = 6,
		["26"] = 6,
		["27"] = 6,
		["28"] = 6,
		["29"] = 6,
		["30"] = 6,
		["31"] = 6,
		["32"] = 6,
		["33"] = 6,
		["34"] = 6,
		["35"] = 6,
		["36"] = 6,
		["37"] = 6,
		["38"] = 6,
		["39"] = 6,
		["40"] = 6,
		["41"] = 6,
		["42"] = 6,
		["43"] = 6,
		["44"] = 6,
		["45"] = 6,
		["46"] = 6,
		["47"] = 6,
		["48"] = 6,
		["49"] = 6,
		["50"] = 6,
		["51"] = 6,
		["52"] = 6,
		["53"] = 6,
		["54"] = 6,
		["55"] = 6,
		["56"] = 6,
		["57"] = 6,
		["58"] = 6,
		["59"] = 6,
		["60"] = 6,
		["61"] = 6,
		["62"] = 6,
		["63"] = 6,
		["64"] = 6,
		["65"] = 6,
		["66"] = 6,
		["67"] = 6,
		["68"] = 6,
		["69"] = 6,
		["70"] = 6,
		["71"] = 6,
		["72"] = 6,
		["73"] = 6,
		["74"] = 6,
		["75"] = 6,
		["76"] = 6,
		["77"] = 6,
		["78"] = 6,
		["79"] = 6,
		["80"] = 6,
		["81"] = 6,
		["82"] = 6,
		["83"] = 6,
		["84"] = 6,
		["85"] = 6,
		["86"] = 6,
		["87"] = 6,
		["88"] = 6,
		["89"] = 6,
		["90"] = 6,
		["91"] = 6,
		["92"] = 6,
		["93"] = 6,
		["94"] = 6,
		["95"] = 6,
		["96"] = 6,
		["97"] = 6,
		["98"] = 6,
		["99"] = 6,
		["100"] = 6,
		["101"] = 6,
		["102"] = 6,
		["103"] = 6,
		["104"] = 6,
		["105"] = 6,
		["106"] = 6,
		["107"] = 6,
		["108"] = 6,
		["109"] = 6,
		["110"] = 6,
		["111"] = 6,
		["112"] = 6,
		["113"] = 6,
		["114"] = 6,
		["115"] = 6,
		["116"] = 6,
		["117"] = 6,
		["118"] = 6,
		["119"] = 6,
		["120"] = 6,
		["121"] = 6,
		["122"] = 6,
		["123"] = 6,
		["124"] = 6,
		["125"] = 6,
		["126"] = 6,
		["127"] = 6,
		["128"] = 6,
		["129"] = 6,
		["130"] = 6,
		["131"] = 6,
		["132"] = 6,
		["133"] = 6,
		["134"] = 6,
		["135"] = 6,
		["136"] = 6,
		["137"] = 6,
		["138"] = 6,
		["139"] = 6,
		["140"] = 6,
		["141"] = 6,
		["142"] = 6,
		["143"] = 6,
		["144"] = 6,
		["145"] = 6,
		["146"] = 6,
		["147"] = 6,
		["148"] = 6,
		["149"] = 6,
		["150"] = 6,
		["151"] = 6,
		["152"] = 6,
		["153"] = 6,
		["154"] = 6,
		["155"] = 6,
		["156"] = 6,
		["157"] = 6,
		["158"] = 6,
		["159"] = 6,
		["160"] = 6,
		["161"] = 6,
		["162"] = 6,
		["163"] = 6,
		["164"] = 6,
		["165"] = 6,
		["166"] = 6,
		["167"] = 6,
		["168"] = 6,
		["169"] = 6,
		["170"] = 6,
		["171"] = 6,
		["172"] = 6,
		["173"] = 6,
		["174"] = 6,
		["175"] = 6,
		["176"] = 6,
		["177"] = 6,
		["179"] = 181,
		["180"] = 181,
		["181"] = 181,
		["182"] = 181,
		["183"] = 181,
		["184"] = 181,
		["185"] = 181,
		["186"] = 181,
		["187"] = 181,
		["188"] = 181,
		["189"] = 181,
		["190"] = 181,
		["191"] = 181,
		["192"] = 181,
		["193"] = 181,
		["194"] = 181,
		["195"] = 181,
		["196"] = 181,
		["197"] = 181,
		["198"] = 181,
		["199"] = 181,
		["200"] = 181,
		["201"] = 181,
		["202"] = 181,
		["203"] = 181,
		["204"] = 181,
		["205"] = 181,
		["206"] = 181,
		["207"] = 181,
		["208"] = 181,
		["209"] = 181,
		["210"] = 181,
		["211"] = 181,
		["212"] = 181,
		["213"] = 181,
		["214"] = 181,
		["215"] = 181,
		["216"] = 181,
		["217"] = 181,
		["218"] = 181,
		["219"] = 181,
		["220"] = 181,
		["221"] = 181,
		["222"] = 181,
		["223"] = 181,
		["224"] = 181,
		["225"] = 181,
		["226"] = 181,
		["227"] = 181,
		["228"] = 181,
		["229"] = 181,
		["230"] = 181,
		["231"] = 181,
		["232"] = 181,
		["233"] = 181,
		["234"] = 181,
		["235"] = 181,
		["236"] = 181,
		["237"] = 181,
		["238"] = 181,
		["239"] = 181,
		["240"] = 181,
		["241"] = 181,
		["242"] = 181,
		["243"] = 181,
		["244"] = 181,
		["245"] = 181,
		["246"] = 181,
		["247"] = 181,
		["248"] = 181,
		["249"] = 181,
		["250"] = 181,
		["251"] = 181,
		["252"] = 181,
		["253"] = 181,
		["254"] = 181,
		["255"] = 181,
		["256"] = 181,
		["257"] = 181,
		["258"] = 181,
		["259"] = 181,
		["260"] = 181,
		["261"] = 181,
		["262"] = 181,
		["263"] = 181,
		["264"] = 181,
		["265"] = 181,
		["266"] = 181,
		["267"] = 181,
		["268"] = 181,
		["269"] = 181,
		["270"] = 181,
		["271"] = 181,
		["272"] = 181,
		["273"] = 181,
		["274"] = 181,
		["275"] = 181,
		["276"] = 181,
		["277"] = 181,
		["278"] = 181,
		["279"] = 181,
		["280"] = 181,
		["281"] = 181,
		["282"] = 181,
		["283"] = 181,
		["284"] = 181,
		["285"] = 181,
		["286"] = 181,
		["287"] = 181,
		["288"] = 181,
		["289"] = 181,
		["290"] = 181,
		["291"] = 181,
		["292"] = 181,
		["293"] = 181,
		["294"] = 181,
		["295"] = 181,
		["296"] = 181,
		["297"] = 181,
		["298"] = 181,
		["299"] = 181,
		["300"] = 181,
		["301"] = 181,
		["302"] = 181,
		["303"] = 181,
		["304"] = 181,
		["305"] = 181,
		["306"] = 181,
		["307"] = 319,
		["308"] = 320,
		["309"] = 321,
		["310"] = 322,
		["311"] = 323,
		["313"] = 325,
		["314"] = 326,
		["316"] = 328,
		["317"] = 328,
		["318"] = 329,
		["319"] = 329,
		["320"] = 329,
		["321"] = 329,
		["322"] = 330,
		["324"] = 342,
		["325"] = 343,
		["326"] = 344,
		["328"] = 346,
		["329"] = 347,
		["331"] = 350,
		["332"] = 350,
		["333"] = 351,
		["334"] = 351,
		["335"] = 351,
		["336"] = 351,
		["337"] = 352,
		["340"] = 367,
		["341"] = 368,
		["343"] = 370,
		["344"] = 371,
		["346"] = 373,
		["347"] = 373,
		["349"] = 319,
		["350"] = 389,
		["351"] = 390,
		["352"] = 391,
		["353"] = 392,
		["354"] = 393,
		["356"] = 395,
		["357"] = 396,
		["359"] = 399,
		["361"] = 401,
		["362"] = 402,
		["363"] = 403,
		["365"] = 405,
		["366"] = 406,
		["368"] = 409,
		["371"] = 412,
		["372"] = 413,
		["374"] = 415,
		["375"] = 416,
		["377"] = 418,
		["379"] = 389,
		["380"] = 423,
		["381"] = 424,
		["382"] = 425,
		["383"] = 426,
		["384"] = 426,
		["385"] = 427,
		["386"] = 428,
		["387"] = 429,
		["388"] = 430,
		["391"] = 434,
		["392"] = 436,
		["394"] = 438,
		["399"] = 443,
		["400"] = 444,
		["401"] = 444,
		["402"] = 445,
		["403"] = 446,
		["404"] = 447,
		["405"] = 448,
		["408"] = 452,
		["409"] = 454,
		["411"] = 456,
		["416"] = 461,
		["417"] = 462,
		["418"] = 463,
		["419"] = 464,
		["420"] = 465,
		["421"] = 467,
		["423"] = 469,
		["427"] = 473,
		["428"] = 474,
		["429"] = 475,
		["430"] = 476,
		["431"] = 477,
		["432"] = 477,
		["433"] = 477,
		["434"] = 477,
		["435"] = 477,
		["438"] = 423,
		["439"] = 482,
		["440"] = 483,
		["441"] = 484,
		["443"] = 486,
		["444"] = 487,
		["446"] = 489,
		["447"] = 490,
		["448"] = 490,
		["449"] = 491,
		["450"] = 482,
		["451"] = 493,
		["452"] = 494,
		["453"] = 495,
		["454"] = 496,
		["455"] = 497,
		["456"] = 498,
		["460"] = 493,
	}
)
EOMModifierEvents = EOMModifierEvents or {}
EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_START = 577
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_START] = "MODIFIER_EVENT_ON_ATTACK_START"
EOMModifierEvents.MODIFIER_EVENT_ON_HERO_SPAWN = 578
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_HERO_SPAWN] = "MODIFIER_EVENT_ON_HERO_SPAWN"
EOMModifierEvents.MODIFIER_EVENT_ON_HERO_RESPAWN = 579
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_HERO_RESPAWN] = "MODIFIER_EVENT_ON_HERO_RESPAWN"
EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT = 580
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = "MODIFIER_EVENT_ON_TRAIT_INIT"
EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_SELECTED = 581
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_SELECTED] = "MODIFIER_EVENT_ON_TRAIT_SELECTED"
EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP = 582
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP] = "MODIFIER_EVENT_ON_HERO_LEVEL_UP"
EOMModifierEvents.MODIFIER_EVENT_ON_PREDAMAGE = 583
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_PREDAMAGE] = "MODIFIER_EVENT_ON_PREDAMAGE"
EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE = 584
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = "MODIFIER_EVENT_ON_TAKEDAMAGE"
EOMModifierEvents.MODIFIER_EVENT_ON_LOG_DAMAGE = 585
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_LOG_DAMAGE] = "MODIFIER_EVENT_ON_LOG_DAMAGE"
EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED = 586
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = "MODIFIER_EVENT_ON_ATTACK_LANDED"
EOMModifierEvents.MODIFIER_EVENT_ON_ILLUSION_ATTACK = 587
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_ILLUSION_ATTACK] = "MODIFIER_EVENT_ON_ILLUSION_ATTACK"
EOMModifierEvents.MODIFIER_EVENT_ON_KILLED = 588
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_KILLED] = "MODIFIER_EVENT_ON_KILLED"
EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST = 589
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = "MODIFIER_EVENT_ON_ABILITY_FULLY_CAST"
EOMModifierEvents.MODIFIER_EVENT_ON_FAKE_ATTACK = 590
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_FAKE_ATTACK] = "MODIFIER_EVENT_ON_FAKE_ATTACK"
EOMModifierEvents.MODIFIER_EVENT_ON_STUN = 591
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_STUN] = "MODIFIER_EVENT_ON_STUN"
EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE = 592
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = "MODIFIER_EVENT_ON_ROUND_CHANGE"
EOMModifierEvents.MODIFIER_EVENT_BEFORE_PREPARE = 593
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_BEFORE_PREPARE] = "MODIFIER_EVENT_BEFORE_PREPARE"
EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE = 594
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE] = "MODIFIER_EVENT_ON_PREPARE"
EOMModifierEvents.MODIFIER_EVENT_ON_CONFIRM_BATTLE = 595
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_CONFIRM_BATTLE] = "MODIFIER_EVENT_ON_CONFIRM_BATTLE"
EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE = 596
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = "MODIFIER_EVENT_ON_BATTLE_START_BEFORE"
EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START = 597
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = "MODIFIER_EVENT_ON_BATTLE_START"
EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END = 598
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = "MODIFIER_EVENT_ON_BATTLE_END"
EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END = 599
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END] = "MODIFIER_EVENT_ON_BATTLE_END_STATE_END"
EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED = 600
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = "MODIFIER_EVENT_ON_ICE_GAINED"
EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED = 601
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED] = "MODIFIER_EVENT_ON_FURY_GAINED"
EOMModifierEvents.MODIFIER_EVENT_ON_POISON_GAINED = 602
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_POISON_GAINED] = "MODIFIER_EVENT_ON_POISON_GAINED"
EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_GAINED = 603
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_GAINED] = "MODIFIER_EVENT_ON_SHIELD_GAINED"
EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_GAINED = 604
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_GAINED] = "MODIFIER_EVENT_ON_INJURY_GAINED"
EOMModifierEvents.MODIFIER_EVENT_ON_CHAOS_POINT_GAINED = 605
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_CHAOS_POINT_GAINED] = "MODIFIER_EVENT_ON_CHAOS_POINT_GAINED"
EOMModifierEvents.MODIFIER_EVENT_ON_ICE_LOSS = 606
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_LOSS] = "MODIFIER_EVENT_ON_ICE_LOSS"
EOMModifierEvents.MODIFIER_EVENT_ON_FURY_LOSS = 607
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_FURY_LOSS] = "MODIFIER_EVENT_ON_FURY_LOSS"
EOMModifierEvents.MODIFIER_EVENT_ON_POISON_LOSS = 608
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_POISON_LOSS] = "MODIFIER_EVENT_ON_POISON_LOSS"
EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_LOSS = 609
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_LOSS] = "MODIFIER_EVENT_ON_SHIELD_LOSS"
EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_LOSS = 610
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_LOSS] = "MODIFIER_EVENT_ON_INJURY_LOSS"
EOMModifierEvents.MODIFIER_EVENT_ON_DAMAGE_START = 611
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_DAMAGE_START] = "MODIFIER_EVENT_ON_DAMAGE_START"
EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL_CALCULATED = 612
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL_CALCULATED] = "MODIFIER_EVENT_ON_CRITICAL_CALCULATED"
EOMModifierEvents.MODIFIER_EVENT_ON_EVASION = 613
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = "MODIFIER_EVENT_ON_EVASION"
EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL = 614
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = "MODIFIER_EVENT_ON_CRITICAL"
EOMModifierEvents.MODIFIER_EVENT_ON_BLOCK = 615
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_BLOCK] = "MODIFIER_EVENT_ON_BLOCK"
EOMModifierEvents.MODIFIER_EVENT_ON_HEAL = 616
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_HEAL] = "MODIFIER_EVENT_ON_HEAL"
EOMModifierEvents.MODIFIER_EVENT_ON_RESTORE = 617
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_RESTORE] = "MODIFIER_EVENT_ON_RESTORE"
EOMModifierEvents.MODIFIER_EVENT_BEFORE_ADJUST = 618
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_BEFORE_ADJUST] = "MODIFIER_EVENT_BEFORE_ADJUST"
EOMModifierEvents.MODIFIER_EVENT_ON_ADJUST = 619
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_ADJUST] = "MODIFIER_EVENT_ON_ADJUST"
EOMModifierEvents.MODIFIER_EVENT_ON_PARRY = 620
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_PARRY] = "MODIFIER_EVENT_ON_PARRY"
EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START = 621
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = "MODIFIER_EVENT_ON_ROUND_START"
EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_END = 622
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_END] = "MODIFIER_EVENT_ON_ROUND_END"
EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN = 623
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = "MODIFIER_EVENT_ON_ABILITY_LEARN"
EOMModifierEvents.MODIFIER_EVENT_ON_TALENT_LEARN = 624
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_TALENT_LEARN] = "MODIFIER_EVENT_ON_TALENT_LEARN"
EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_REFRESH = 625
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_REFRESH] = "MODIFIER_EVENT_ON_ABILITY_REFRESH"
EOMModifierEvents.MODIFIER_EVENT_ON_SHOP_REFRESH = 626
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_SHOP_REFRESH] = "MODIFIER_EVENT_ON_SHOP_REFRESH"
EOMModifierEvents.MODIFIER_EVENT_ON_CUSTOM_ABILITY_BUY = 627
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_CUSTOM_ABILITY_BUY] = "MODIFIER_EVENT_ON_CUSTOM_ABILITY_BUY"
EOMModifierEvents.MODIFIER_EVENT_ON_SHOP_RANDOM = 628
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_SHOP_RANDOM] = "MODIFIER_EVENT_ON_SHOP_RANDOM"
EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_RANDOM = 629
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_RANDOM] = "MODIFIER_EVENT_ON_ABILITY_RANDOM"
EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_TAKEDAMAGE = 630
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_TAKEDAMAGE] = "MODIFIER_EVENT_ON_PLAYER_TAKEDAMAGE"
EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_MODIFY_HEALTH = 631
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_MODIFY_HEALTH] = "MODIFIER_EVENT_ON_PLAYER_MODIFY_HEALTH"
EOMModifierEvents.MODIFIER_EVENT_ON_TEAM_MODIFY_HEALTH = 632
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_TEAM_MODIFY_HEALTH] = "MODIFIER_EVENT_ON_TEAM_MODIFY_HEALTH"
EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_KILLED = 633
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_KILLED] = "MODIFIER_EVENT_ON_PLAYER_KILLED"
EOMModifierEvents.MODIFIER_EVENT_ON_POISON_TAKEDAMAGE = 634
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_POISON_TAKEDAMAGE] = "MODIFIER_EVENT_ON_POISON_TAKEDAMAGE"
EOMModifierEvents.MODIFIER_EVENT_ON_WISP_SPAWN = 635
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_SPAWN] = "MODIFIER_EVENT_ON_WISP_SPAWN"
EOMModifierEvents.MODIFIER_EVENT_ON_WISP_DIE = 636
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_DIE] = "MODIFIER_EVENT_ON_WISP_DIE"
EOMModifierEvents.MODIFIER_EVENT_ON_WISP_HEAL = 637
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_HEAL] = "MODIFIER_EVENT_ON_WISP_HEAL"
EOMModifierEvents.MODIFIER_EVENT_ON_FIRST_WISP_SPAWN = 638
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_FIRST_WISP_SPAWN] = "MODIFIER_EVENT_ON_FIRST_WISP_SPAWN"
EOMModifierEvents.MODIFIER_EVENT_ON_SHARE_DAMAGE = 639
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_SHARE_DAMAGE] = "MODIFIER_EVENT_ON_SHARE_DAMAGE"
EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY = 640
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY] = "MODIFIER_EVENT_ON_ABILITY_BUY"
EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FREE = 641
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FREE] = "MODIFIER_EVENT_ON_ABILITY_FREE"
EOMModifierEvents.MODIFIER_EVENT_ON_SECT_LEVEL_UP = 642
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_SECT_LEVEL_UP] = "MODIFIER_EVENT_ON_SECT_LEVEL_UP"
EOMModifierEvents.MODIFIER_EVENT_ON_WISP_ATTACK_LANDED = 643
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_ATTACK_LANDED] = "MODIFIER_EVENT_ON_WISP_ATTACK_LANDED"
EOMModifierEvents.MODIFIER_EVENT_ON_GET_INTEREST = 644
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_GET_INTEREST] = "MODIFIER_EVENT_ON_GET_INTEREST"
EOMModifierEvents.MODIFIER_EVENT_ON_SELECT_ARTIFACT = 645
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_SELECT_ARTIFACT] = "MODIFIER_EVENT_ON_SELECT_ARTIFACT"
EOMModifierEvents.MODIFIER_EVENT_ON_BUY_EFFECT_CARD = 646
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_BUY_EFFECT_CARD] = "MODIFIER_EVENT_ON_BUY_EFFECT_CARD"
EOMModifierEvents.MODIFIER_EVENT_ON_WISP_SCAPEGOAT = 647
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_SCAPEGOAT] = "MODIFIER_EVENT_ON_WISP_SCAPEGOAT"
EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_GOLD_MODIFY = 648
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_GOLD_MODIFY] = "MODIFIER_EVENT_ON_PLAYER_GOLD_MODIFY"
EOMModifierEvents.MODIFIER_EVENT_ON_ROSHAN_TREASURE = 649
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_ROSHAN_TREASURE] = "MODIFIER_EVENT_ON_ROSHAN_TREASURE"
EOMModifierEvents.MODIFIER_EVENT_ON_SILENCE_END = 650
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_SILENCE_END] = "MODIFIER_EVENT_ON_SILENCE_END"
EOMModifierEvents.MODIFIER_EVENT_ON_SILENCE_ADD = 651
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_SILENCE_ADD] = "MODIFIER_EVENT_ON_SILENCE_ADD"
EOMModifierEvents.MODIFIER_EVENT_ON_SELECT_NEUTRAL_EQUIP = 652
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_SELECT_NEUTRAL_EQUIP] = "MODIFIER_EVENT_ON_SELECT_NEUTRAL_EQUIP"
EOMModifierEvents.MODIFIER_EVENT_ON_CHANGE_INTERACT_ABILITY = 653
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_CHANGE_INTERACT_ABILITY] =
	"MODIFIER_EVENT_ON_CHANGE_INTERACT_ABILITY"
EOMModifierEvents.MODIFIER_EVENT_ON_CLEAR_TALENT = 654
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_CLEAR_TALENT] = "MODIFIER_EVENT_ON_CLEAR_TALENT"
EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN_FOR_TEAMMEAT = 655
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN_FOR_TEAMMEAT] =
	"MODIFIER_EVENT_ON_ABILITY_LEARN_FOR_TEAMMEAT"
EOMModifierEvents.MODIFIER_EVENT_ON_DRAW_ATTRIBUTE = 656
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_DRAW_ATTRIBUTE] = "MODIFIER_EVENT_ON_DRAW_ATTRIBUTE"
EOMModifierEvents.MODIFIER_EVENT_ON_SCAR_ENOUGH = 657
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_SCAR_ENOUGH] = "MODIFIER_EVENT_ON_SCAR_ENOUGH"
EOMModifierEvents.MODIFIER_EVENT_ON_TAKE_SCAR = 658
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_TAKE_SCAR] = "MODIFIER_EVENT_ON_TAKE_SCAR"
EOMModifierEvents.MODIFIER_EVENT_ON_SHOW_GREEVIL = 659
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_SHOW_GREEVIL] = "MODIFIER_EVENT_ON_SHOW_GREEVIL"
EOMModifierEvents.MODIFIER_EVENT_ON_BUY_SHARD = 660
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_BUY_SHARD] = "MODIFIER_EVENT_ON_BUY_SHARD"
EOMModifierEvents.MODIFIER_EVENT_ON_BUY_GREEVIL_ATTRIBUTE = 661
EOMModifierEvents[EOMModifierEvents.MODIFIER_EVENT_ON_BUY_GREEVIL_ATTRIBUTE] = "MODIFIER_EVENT_ON_BUY_GREEVIL_ATTRIBUTE"
EOMModifierEventsFunctionName = {
	[MODIFIER_EVENT_ON_SPELL_TARGET_READY] = "OnSpellTargetReady",
	[MODIFIER_EVENT_ON_ATTACK_RECORD] = "OnAttackRecord",
	[MODIFIER_EVENT_ON_ATTACK_START] = "OnAttackStart",
	[MODIFIER_EVENT_ON_ATTACK] = "OnAttack",
	[MODIFIER_EVENT_ON_ATTACK_LANDED] = "OnAttackLanded",
	[MODIFIER_EVENT_ON_ATTACK_FAIL] = "OnAttackFail",
	[MODIFIER_EVENT_ON_ATTACK_ALLIED] = "OnAttackAllied",
	[MODIFIER_EVENT_ON_PROJECTILE_DODGE] = "OnProjectileDodge",
	[MODIFIER_EVENT_ON_ORDER] = "OnOrder",
	[MODIFIER_EVENT_ON_UNIT_MOVED] = "OnUnitMoved",
	[MODIFIER_EVENT_ON_ABILITY_START] = "OnAbilityStart",
	[MODIFIER_EVENT_ON_ABILITY_EXECUTED] = "OnAbilityExecuted",
	[MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = "OnAbilityFullyCast",
	[MODIFIER_EVENT_ON_BREAK_INVISIBILITY] = "OnBreakInvisibility",
	[MODIFIER_EVENT_ON_ABILITY_END_CHANNEL] = "OnAbilityEndChannel",
	[MODIFIER_EVENT_ON_TAKEDAMAGE] = "OnTakeDamage",
	[MODIFIER_EVENT_ON_DEATH_PREVENTED] = "OnDamagePrevented",
	[MODIFIER_EVENT_ON_STATE_CHANGED] = "OnStateChanged",
	[MODIFIER_EVENT_ON_PROCESS_CLEAVE] = "OnProcessCleave",
	[MODIFIER_EVENT_ON_DAMAGE_CALCULATED] = "OnDamageCalculated",
	[MODIFIER_EVENT_ON_MAGIC_DAMAGE_CALCULATED] = "OnMagicDamageCalculated",
	[MODIFIER_EVENT_ON_ATTACKED] = "OnAttacked",
	[MODIFIER_EVENT_ON_DEATH] = "OnDeath",
	[MODIFIER_EVENT_ON_RESPAWN] = "OnRespawn",
	[MODIFIER_EVENT_ON_SPENT_MANA] = "OnSpentMana",
	[MODIFIER_EVENT_ON_TELEPORTING] = "OnTeleporting",
	[MODIFIER_EVENT_ON_TELEPORTED] = "OnTeleported",
	[MODIFIER_EVENT_ON_SET_LOCATION] = "OnSetLocation",
	[MODIFIER_EVENT_ON_HEALTH_GAINED] = "OnHealthGained",
	[MODIFIER_EVENT_ON_MANA_GAINED] = "OnManaGained",
	[MODIFIER_EVENT_ON_TAKEDAMAGE_KILLCREDIT] = "OnTakeDamageKillCredit",
	[MODIFIER_EVENT_ON_HERO_KILLED] = "OnHeroKilled",
	[MODIFIER_EVENT_ON_HEAL_RECEIVED] = "OnHealReceived",
	[MODIFIER_EVENT_ON_BUILDING_KILLED] = "OnBuildingKilled",
	[MODIFIER_EVENT_ON_MODEL_CHANGED] = "OnModelChanged",
	[MODIFIER_EVENT_ON_MODIFIER_ADDED] = "OnModifierAdded",
	[MODIFIER_EVENT_ON_DOMINATED] = "OnDominated",
	[MODIFIER_EVENT_ON_ASSIST] = "OnAssist",
	[MODIFIER_EVENT_ON_ATTACK_FINISHED] = "OnAttackFinished",
	[MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY] = "OnAttackRecordDestroy",
	[MODIFIER_EVENT_ON_PROJECTILE_OBSTRUCTION_HIT] = "OnProjectileObstructionHit",
	[EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP] = "OnHeroLevelUp",
	[EOMModifierEvents.MODIFIER_EVENT_ON_HERO_SPAWN] = "OnHeroSpawn",
	[EOMModifierEvents.MODIFIER_EVENT_ON_HERO_RESPAWN] = "OnHeroRespawn",
	[EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = "OnTraitInit",
	[EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_SELECTED] = "OnTraitSelected",
	[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_START] = "OnCustomAttackStart",
	[EOMModifierEvents.MODIFIER_EVENT_ON_FAKE_ATTACK] = "OnFakeAttack",
	[EOMModifierEvents.MODIFIER_EVENT_ON_STUN] = "OnStun",
	[EOMModifierEvents.MODIFIER_EVENT_ON_PREDAMAGE] = "OnPreDamage",
	[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = "OnCustomTakeDamage",
	[EOMModifierEvents.MODIFIER_EVENT_ON_LOG_DAMAGE] = "OnLogDamage",
	[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = "OnCustomAttackLanded",
	[EOMModifierEvents.MODIFIER_EVENT_ON_ILLUSION_ATTACK] = "OnIllusionAttack",
	[EOMModifierEvents.MODIFIER_EVENT_ON_KILLED] = "OnKilled",
	[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = "OnCustomAbilityFullyCast",
	[EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE] = "OnPrepare",
	[EOMModifierEvents.MODIFIER_EVENT_ON_CONFIRM_BATTLE] = "OnConfirmBattle",
	[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = "OnRoundChange",
	[EOMModifierEvents.MODIFIER_EVENT_BEFORE_PREPARE] = "OnBeforePrepare",
	[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = "OnBattleStartBefore",
	[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = "OnBattleStart",
	[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = "OnBattleEnd",
	[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END] = "OnBattleEndStateEnd",
	[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = "OnIceGained",
	[EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED] = "OnFuryGained",
	[EOMModifierEvents.MODIFIER_EVENT_ON_POISON_GAINED] = "OnPoisonGained",
	[EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_GAINED] = "OnShieldGained",
	[EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_GAINED] = "OnInjuryGained",
	[EOMModifierEvents.MODIFIER_EVENT_ON_CHAOS_POINT_GAINED] = "OnChaosPointGained",
	[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_LOSS] = "OnIceLoss",
	[EOMModifierEvents.MODIFIER_EVENT_ON_FURY_LOSS] = "OnFuryLoss",
	[EOMModifierEvents.MODIFIER_EVENT_ON_POISON_LOSS] = "OnPoisonLoss",
	[EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_LOSS] = "OnShieldLoss",
	[EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_LOSS] = "OnInjuryLoss",
	[EOMModifierEvents.MODIFIER_EVENT_ON_DAMAGE_START] = "OnDamageStart",
	[EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL_CALCULATED] = "OnCriticalCalculated",
	[EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = "OnEvasion",
	[EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = "OnCritical",
	[EOMModifierEvents.MODIFIER_EVENT_ON_BLOCK] = "OnBlock",
	[EOMModifierEvents.MODIFIER_EVENT_ON_HEAL] = "OnHeal",
	[EOMModifierEvents.MODIFIER_EVENT_ON_RESTORE] = "OnRestore",
	[EOMModifierEvents.MODIFIER_EVENT_ON_ADJUST] = "OnAdjust",
	[EOMModifierEvents.MODIFIER_EVENT_ON_PARRY] = "OnParry",
	[EOMModifierEvents.MODIFIER_EVENT_BEFORE_ADJUST] = "BeforeAdjust",
	[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = "OnRoundStart",
	[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_END] = "OnRoundEnd",
	[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = "OnAbilityLearn",
	[EOMModifierEvents.MODIFIER_EVENT_ON_TALENT_LEARN] = "OnTalentLearn",
	[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_REFRESH] = "OnAbilityRefresh",
	[EOMModifierEvents.MODIFIER_EVENT_ON_SHOP_REFRESH] = "OnShopRefresh",
	[EOMModifierEvents.MODIFIER_EVENT_ON_CUSTOM_ABILITY_BUY] = "OnCustomAbilityBuy",
	[EOMModifierEvents.MODIFIER_EVENT_ON_SHOP_RANDOM] = "OnShopRandom",
	[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_RANDOM] = "OnAbilityRandom",
	[EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_TAKEDAMAGE] = "OnPlayerTakeDamage",
	[EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_MODIFY_HEALTH] = "OnPlayerModifyHealth",
	[EOMModifierEvents.MODIFIER_EVENT_ON_TEAM_MODIFY_HEALTH] = "OnTeamModifyHealth",
	[EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_KILLED] = "OnPlayerKilled",
	[EOMModifierEvents.MODIFIER_EVENT_ON_POISON_TAKEDAMAGE] = "OnPoisonTakeDamage",
	[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_SPAWN] = "OnWispSpawn",
	[EOMModifierEvents.MODIFIER_EVENT_ON_FIRST_WISP_SPAWN] = "OnFirstWispSpawn",
	[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_DIE] = "OnWispDie",
	[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_HEAL] = "OnWispHeal",
	[EOMModifierEvents.MODIFIER_EVENT_ON_SHARE_DAMAGE] = "OnShareDamage",
	[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY] = "OnAbilityBuy",
	[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FREE] = "OnAbilityFree",
	[EOMModifierEvents.MODIFIER_EVENT_ON_SECT_LEVEL_UP] = "OnSectLevelUp",
	[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_ATTACK_LANDED] = "OnWispAttackLanded",
	[EOMModifierEvents.MODIFIER_EVENT_ON_GET_INTEREST] = "OnGetInterest",
	[EOMModifierEvents.MODIFIER_EVENT_ON_SELECT_ARTIFACT] = "OnSelectArtifact",
	[EOMModifierEvents.MODIFIER_EVENT_ON_BUY_EFFECT_CARD] = "OnBuyEffectCard",
	[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_SCAPEGOAT] = "OnWispScapegoat",
	[EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_GOLD_MODIFY] = "OnPlayerGoldModify",
	[EOMModifierEvents.MODIFIER_EVENT_ON_ROSHAN_TREASURE] = "OnRoshanTreasure",
	[EOMModifierEvents.MODIFIER_EVENT_ON_SILENCE_END] = "OnSilenceEnd",
	[EOMModifierEvents.MODIFIER_EVENT_ON_SILENCE_ADD] = "OnSilenceAdd",
	[EOMModifierEvents.MODIFIER_EVENT_ON_SELECT_NEUTRAL_EQUIP] = "OnSelectNeutalEquip",
	[EOMModifierEvents.MODIFIER_EVENT_ON_CHANGE_INTERACT_ABILITY] = "OnChangeInteractAbility",
	[EOMModifierEvents.MODIFIER_EVENT_ON_CLEAR_TALENT] = "OnClearTalent",
	[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN_FOR_TEAMMEAT] = "OnAbilityLearnForTeammeat",
	[EOMModifierEvents.MODIFIER_EVENT_ON_DRAW_ATTRIBUTE] = "OnDrawAttribute",
	[EOMModifierEvents.MODIFIER_EVENT_ON_SCAR_ENOUGH] = "OnScarEnough",
	[EOMModifierEvents.MODIFIER_EVENT_ON_TAKE_SCAR] = "OnTakeScar",
	[EOMModifierEvents.MODIFIER_EVENT_ON_SHOW_GREEVIL] = "OnShowGreevil",
	[EOMModifierEvents.MODIFIER_EVENT_ON_BUY_SHARD] = "OnBuyShard",
	[EOMModifierEvents.MODIFIER_EVENT_ON_BUY_GREEVIL_ATTRIBUTE] = "OnBuyGreevilAttribute",
}
function AddModifierEvents(f, g, h, i)
	if IsValid(i) or IsValid(h) then
		if IsValid(h) then
			if type(h.tSourceModifierEvents) == "nil" then
				h.tSourceModifierEvents = {}
			end
			if type(h.tSourceModifierEvents[f]) == "nil" then
				h.tSourceModifierEvents[f] = {}
			end
			local j = h.tSourceModifierEvents[f]
			j[#j + 1] = g
			h.tSourceModifierEvents[f] = c(h.tSourceModifierEvents[f], function(k, l)
				return IsValid(l)
			end)
			h.tSourceModifierEvents[f] = copyAndSort(nil, h.tSourceModifierEvents[f])
		end
		if IsValid(i) then
			if type(i.tTargetModifierEvents) == "nil" then
				i.tTargetModifierEvents = {}
			end
			if type(i.tTargetModifierEvents[f]) == "nil" then
				i.tTargetModifierEvents[f] = {}
			end
			local m = i.tTargetModifierEvents[f]
			m[#m + 1] = g
			i.tTargetModifierEvents[f] = c(i.tTargetModifierEvents[f], function(k, l)
				return IsValid(l)
			end)
			i.tTargetModifierEvents[f] = copyAndSort(nil, i.tTargetModifierEvents[f])
		end
	else
		if _G.tModifierEvents == nil then
			_G.tModifierEvents = {}
		end
		if type(tModifierEvents[f]) == "nil" then
			tModifierEvents[f] = {}
		end
		local n = tModifierEvents[f]
		n[#n + 1] = g
	end
end
function RemoveModifierEvents(f, g, h, i)
	if IsValid(i) or IsValid(h) then
		if IsValid(h) then
			if type(h.tSourceModifierEvents) == "nil" then
				h.tSourceModifierEvents = {}
			end
			if type(h.tSourceModifierEvents[f]) == "nil" then
				h.tSourceModifierEvents[f] = {}
			end
			ArrayRemove(h.tSourceModifierEvents[f], g)
		end
		if IsValid(i) then
			if type(i.tTargetModifierEvents) == "nil" then
				i.tTargetModifierEvents = {}
			end
			if type(i.tTargetModifierEvents[f]) == "nil" then
				i.tTargetModifierEvents[f] = {}
			end
			ArrayRemove(i.tTargetModifierEvents[f], g)
		end
	else
		if _G.tModifierEvents == nil then
			_G.tModifierEvents = {}
		end
		if type(tModifierEvents[f]) == "nil" then
			tModifierEvents[f] = {}
		end
		ArrayRemove(tModifierEvents[f], g)
	end
end
function FireModifierEvent(f, o, h, i)
	local p = EOMModifierEventsFunctionName[f]
	if IsValid(h) then
		local q = h.tSourceModifierEvents
		local r = q and q[f]
		if r then
			for s = #r - 1, 0, -1 do
				local g = r[s + 1]
				if not IsValid(h) then
					break
				end
				if IsValid(g) and type(g[p]) == "function" then
					g[p](g, o)
				else
					d(r, s, 1)
				end
			end
		end
	end
	if IsValid(i) then
		local t = i.tTargetModifierEvents
		local r = t and t[f]
		if r then
			for s = #r - 1, 0, -1 do
				local g = r[s + 1]
				if not IsValid(i) then
					break
				end
				if IsValid(g) and type(g[p]) == "function" then
					g[p](g, o)
				else
					d(r, s, 1)
				end
			end
		end
	end
	local r = tModifierEvents and tModifierEvents[f]
	if r then
		for s = #r - 1, 0, -1 do
			local g = r[s + 1]
			if IsValid(g) and type(g[p]) == "function" then
				g[p](g, o)
			else
				d(r, s, 1)
			end
		end
	end
	local u = tGlobalModifierEvents and tGlobalModifierEvents[f]
	if u then
		for s = #u - 1, 0, -1 do
			local v = u[s + 1]
			v.callback(v.context, o, IsValid(h) and (h and h:GetPlayerOwnerID()) or nil)
		end
	end
end
function ModifierEvent(f, w, x)
	if _G.tGlobalModifierEvents == nil then
		_G.tGlobalModifierEvents = {}
	end
	if type(tGlobalModifierEvents[f]) == "nil" then
		tGlobalModifierEvents[f] = {}
	end
	local y = DoUniqueString("global_modifier_event")
	local z = tGlobalModifierEvents[f]
	z[#z + 1] = { context = x, callback = w, id = y }
	return y
end
function RemoveModifierEvent(f, y)
	local u = tGlobalModifierEvents and tGlobalModifierEvents[f]
	if u then
		for s = #u - 1, 0, -1 do
			if u[s + 1].id == y then
				table.remove(u, s + 1)
			end
		end
	end
end