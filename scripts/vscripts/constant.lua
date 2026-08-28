--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "constant"
local b = require("lualib_bundle")
local c = b.__TS__ObjectKeys
local d = b.__TS__StringIncludes
local e = b.__TS__ArrayFilter
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["12"] = 1,
		["15"] = 1,
		["18"] = 1,
		["19"] = 8,
		["20"] = 12,
		["21"] = 12,
		["22"] = 12,
		["23"] = 23,
		["24"] = 28,
		["25"] = 31,
		["26"] = 33,
		["27"] = 35,
		["28"] = 49,
		["30"] = 52,
		["31"] = 53,
		["32"] = 52,
		["34"] = 57,
		["35"] = 57,
		["36"] = 57,
		["37"] = 57,
		["38"] = 57,
		["39"] = 57,
		["40"] = 57,
		["41"] = 57,
		["42"] = 57,
		["44"] = 67,
		["45"] = 70,
		["46"] = 71,
		["47"] = 72,
		["48"] = 70,
		["49"] = 76,
		["50"] = 76,
		["51"] = 76,
		["52"] = 76,
		["53"] = 76,
		["54"] = 76,
		["55"] = 76,
		["56"] = 81,
		["58"] = 86,
		["60"] = 88,
		["62"] = 90,
		["64"] = 92,
		["66"] = 98,
		["68"] = 100,
		["69"] = 102,
		["70"] = 104,
		["71"] = 105,
		["72"] = 106,
		["73"] = 107,
		["74"] = 108,
		["75"] = 110,
		["76"] = 111,
		["78"] = 113,
		["79"] = 114,
		["80"] = 116,
		["81"] = 117,
		["82"] = 118,
		["83"] = 119,
		["84"] = 121,
		["85"] = 122,
		["86"] = 125,
		["87"] = 127,
		["88"] = 128,
		["89"] = 129,
		["90"] = 131,
		["91"] = 133,
		["92"] = 134,
		["93"] = 136,
		["94"] = 138,
		["95"] = 140,
		["96"] = 143,
		["97"] = 150,
		["98"] = 151,
		["99"] = 155,
		["100"] = 158,
		["101"] = 159,
		["102"] = 160,
		["103"] = 163,
		["104"] = 164,
		["105"] = 165,
		["106"] = 166,
		["107"] = 167,
		["110"] = 171,
		["111"] = 171,
		["112"] = 171,
		["113"] = 171,
		["114"] = 171,
		["115"] = 171,
		["116"] = 171,
		["117"] = 171,
		["119"] = 181,
		["120"] = 182,
		["122"] = 185,
		["123"] = 186,
		["124"] = 187,
		["125"] = 190,
		["126"] = 193,
		["127"] = 194,
		["128"] = 195,
		["129"] = 196,
		["130"] = 197,
		["131"] = 198,
		["132"] = 210,
		["133"] = 211,
		["134"] = 212,
		["136"] = 215,
		["138"] = 217,
		["140"] = 219,
		["142"] = 221,
		["143"] = 223,
		["144"] = 223,
		["145"] = 223,
		["146"] = 223,
		["147"] = 223,
		["148"] = 228,
		["149"] = 228,
		["150"] = 228,
		["151"] = 228,
		["152"] = 228,
		["153"] = 228,
		["154"] = 228,
		["155"] = 228,
		["156"] = 228,
		["157"] = 228,
		["158"] = 228,
		["159"] = 251,
		["160"] = 251,
		["161"] = 251,
		["162"] = 251,
		["163"] = 251,
		["165"] = 279,
		["166"] = 281,
		["167"] = 281,
		["168"] = 281,
		["169"] = 281,
		["170"] = 281,
		["171"] = 279,
		["173"] = 331,
		["174"] = 332,
		["175"] = 333,
		["176"] = 334,
		["177"] = 335,
		["178"] = 337,
		["179"] = 338,
		["180"] = 339,
		["181"] = 340,
		["182"] = 341,
		["184"] = 343,
		["185"] = 343,
		["186"] = 344,
		["187"] = 345,
		["189"] = 346,
		["190"] = 347,
		["193"] = 348,
		["194"] = 349,
		["198"] = 352,
		["201"] = 353,
		["202"] = 354,
		["206"] = 357,
		["209"] = 358,
		["210"] = 359,
		["214"] = 362,
		["217"] = 363,
		["218"] = 364,
		["223"] = 368,
		["224"] = 369,
		["225"] = 343,
		["229"] = 371,
		["230"] = 371,
		["231"] = 372,
		["232"] = 373,
		["234"] = 374,
		["235"] = 375,
		["238"] = 376,
		["239"] = 377,
		["243"] = 380,
		["246"] = 381,
		["247"] = 382,
		["251"] = 385,
		["254"] = 386,
		["255"] = 387,
		["259"] = 390,
		["262"] = 391,
		["263"] = 392,
		["267"] = 395,
		["270"] = 396,
		["271"] = 397,
		["276"] = 401,
		["277"] = 402,
		["278"] = 371,
		["283"] = 409,
		["284"] = 409,
		["285"] = 409,
		["286"] = 409,
		["287"] = 409,
		["288"] = 409,
		["289"] = 409,
		["290"] = 409,
		["291"] = 409,
		["292"] = 409,
		["293"] = 409,
		["295"] = 444,
		["297"] = 448,
		["298"] = 448,
		["299"] = 448,
		["300"] = 448,
		["301"] = 448,
		["302"] = 448,
		["303"] = 448,
		["304"] = 448,
		["305"] = 448,
		["306"] = 448,
		["307"] = 482,
		["308"] = 482,
		["309"] = 482,
		["310"] = 482,
		["311"] = 482,
		["312"] = 482,
		["313"] = 448,
		["314"] = 448,
		["315"] = 448,
		["316"] = 448,
		["317"] = 448,
		["318"] = 448,
		["319"] = 448,
		["320"] = 448,
		["321"] = 448,
		["322"] = 448,
		["323"] = 448,
		["324"] = 448,
		["325"] = 448,
		["326"] = 448,
		["327"] = 448,
		["328"] = 448,
		["329"] = 555,
		["330"] = 555,
		["331"] = 555,
		["332"] = 555,
		["333"] = 555,
		["334"] = 555,
		["335"] = 555,
		["337"] = 561,
		["338"] = 562,
		["340"] = 564,
		["341"] = 569,
		["343"] = 575,
		["344"] = 583,
		["345"] = 591,
		["346"] = 592,
		["347"] = 591,
		["348"] = 595,
		["349"] = 597,
		["350"] = 599,
		["352"] = 606,
		["353"] = 606,
		["354"] = 606,
		["355"] = 606,
		["356"] = 606,
		["357"] = 606,
		["358"] = 606,
		["359"] = 606,
		["360"] = 606,
		["361"] = 621,
		["362"] = 621,
		["363"] = 621,
		["364"] = 621,
		["365"] = 621,
		["366"] = 621,
		["367"] = 621,
		["368"] = 621,
		["369"] = 621,
		["370"] = 637,
		["371"] = 638,
		["372"] = 637,
		["374"] = 664,
		["375"] = 671,
		["376"] = 671,
		["377"] = 671,
		["378"] = 671,
		["379"] = 671,
		["380"] = 671,
		["381"] = 671,
		["382"] = 670,
		["383"] = 679,
		["384"] = 679,
		["385"] = 679,
		["386"] = 679,
		["387"] = 679,
		["388"] = 679,
		["389"] = 670,
		["390"] = 686,
		["391"] = 686,
		["392"] = 686,
		["393"] = 686,
		["394"] = 686,
		["395"] = 686,
		["396"] = 686,
		["397"] = 670,
		["398"] = 670,
		["399"] = 670,
		["400"] = 670,
		["401"] = 703,
		["402"] = 709,
		["403"] = 709,
		["404"] = 709,
		["405"] = 709,
		["406"] = 709,
		["407"] = 709,
		["409"] = 737,
		["410"] = 751,
		["412"] = 753,
		["414"] = 760,
		["416"] = 767,
		["418"] = 769,
		["420"] = 781,
		["421"] = 782,
		["422"] = 781,
		["423"] = 784,
		["424"] = 785,
		["425"] = 784,
		["426"] = 788,
		["428"] = 790,
		["430"] = 803,
		["432"] = 805,
		["434"] = 814,
		["436"] = 822,
		["438"] = 829,
		["440"] = 831,
		["442"] = 833,
		["444"] = 835,
		["446"] = 837,
		["448"] = 839,
		["450"] = 842,
		["452"] = 844,
		["453"] = 846,
		["454"] = 846,
		["455"] = 846,
		["456"] = 846,
		["457"] = 846,
		["458"] = 846,
		["459"] = 846,
		["460"] = 852,
		["461"] = 852,
		["462"] = 852,
		["463"] = 852,
		["464"] = 852,
		["465"] = 852,
		["466"] = 852,
		["467"] = 859,
		["468"] = 861,
		["470"] = 864,
		["472"] = 866,
		["473"] = 869,
		["474"] = 876,
		["475"] = 880,
		["476"] = 880,
		["477"] = 880,
		["478"] = 880,
		["479"] = 880,
		["480"] = 880,
		["482"] = 909,
		["483"] = 911,
		["484"] = 911,
		["485"] = 911,
		["486"] = 911,
		["487"] = 911,
		["488"] = 911,
		["489"] = 911,
		["490"] = 911,
		["491"] = 911,
		["492"] = 911,
		["493"] = 911,
		["494"] = 911,
		["495"] = 911,
		["496"] = 911,
		["497"] = 911,
		["498"] = 911,
		["499"] = 911,
		["500"] = 911,
		["501"] = 911,
		["502"] = 911,
		["503"] = 911,
		["504"] = 911,
		["505"] = 911,
		["506"] = 911,
		["507"] = 911,
		["508"] = 911,
		["509"] = 911,
		["510"] = 911,
		["511"] = 911,
		["512"] = 911,
		["513"] = 911,
		["514"] = 911,
		["515"] = 911,
		["516"] = 946,
		["517"] = 948,
		["518"] = 948,
		["519"] = 948,
		["520"] = 948,
		["521"] = 948,
		["522"] = 948,
		["523"] = 948,
		["524"] = 948,
		["525"] = 948,
		["526"] = 948,
		["527"] = 948,
		["528"] = 948,
		["529"] = 948,
		["530"] = 948,
		["531"] = 948,
		["532"] = 948,
		["533"] = 948,
		["534"] = 948,
		["535"] = 948,
		["536"] = 948,
		["537"] = 948,
		["538"] = 948,
		["539"] = 948,
		["540"] = 948,
		["541"] = 946,
		["542"] = 975,
		["543"] = 975,
		["544"] = 975,
		["545"] = 975,
		["546"] = 975,
		["547"] = 975,
		["548"] = 975,
		["549"] = 975,
		["550"] = 975,
		["551"] = 975,
		["552"] = 975,
		["553"] = 975,
		["554"] = 975,
		["555"] = 975,
		["556"] = 975,
		["557"] = 975,
		["558"] = 975,
		["559"] = 975,
		["560"] = 975,
		["561"] = 975,
		["562"] = 975,
		["563"] = 975,
		["564"] = 975,
		["565"] = 975,
		["566"] = 946,
		["567"] = 1002,
		["568"] = 1002,
		["569"] = 1002,
		["570"] = 1002,
		["571"] = 1002,
		["572"] = 1002,
		["573"] = 1002,
		["574"] = 1002,
		["575"] = 1002,
		["576"] = 1002,
		["577"] = 1002,
		["578"] = 1002,
		["579"] = 1002,
		["580"] = 1002,
		["581"] = 1002,
		["582"] = 1002,
		["583"] = 1002,
		["584"] = 1002,
		["585"] = 1002,
		["586"] = 1002,
		["587"] = 1002,
		["588"] = 1002,
		["589"] = 1002,
		["590"] = 1002,
		["591"] = 946,
		["593"] = 1031,
		["594"] = 1031,
		["595"] = 1031,
		["596"] = 1031,
		["597"] = 1031,
		["598"] = 1031,
		["599"] = 1031,
		["601"] = 1037,
		["602"] = 1038,
		["604"] = 1040,
		["605"] = 1041,
		["607"] = 1043,
		["609"] = 1045,
		["611"] = 1047,
		["613"] = 1049,
		["615"] = 1051,
		["616"] = 1052,
		["618"] = 1054,
		["619"] = 1059,
		["621"] = 1065,
		["623"] = 1083,
		["624"] = 1083,
		["625"] = 1083,
		["626"] = 1083,
		["627"] = 1083,
		["628"] = 1083,
		["629"] = 1083,
		["631"] = 1091,
		["632"] = 1091,
		["633"] = 1091,
		["634"] = 1091,
		["635"] = 1091,
		["636"] = 1091,
		["637"] = 1091,
		["639"] = 1099,
		["641"] = 1105,
		["643"] = 1114,
		["644"] = 1178,
		["645"] = 1179,
		["646"] = 1180,
		["648"] = 1182,
		["650"] = 1184,
		["651"] = 1185,
		["652"] = 1187,
		["653"] = 1192,
		["654"] = 1201,
		["655"] = 1201,
		["656"] = 1201,
		["657"] = 1201,
		["658"] = 1201,
		["659"] = 1201,
		["660"] = 1201,
		["661"] = 1201,
		["662"] = 1201,
		["663"] = 1200,
		["664"] = 1227,
		["665"] = 1227,
		["666"] = 1227,
		["667"] = 1227,
		["668"] = 1227,
		["669"] = 1227,
		["670"] = 1227,
		["671"] = 1227,
		["672"] = 1227,
		["673"] = 1200,
		["674"] = 1253,
		["675"] = 1253,
		["676"] = 1253,
		["677"] = 1253,
		["678"] = 1253,
		["679"] = 1253,
		["680"] = 1253,
		["681"] = 1253,
		["682"] = 1253,
		["683"] = 1200,
		["684"] = 1279,
		["685"] = 1279,
		["686"] = 1279,
		["687"] = 1279,
		["688"] = 1279,
		["689"] = 1279,
		["690"] = 1279,
		["691"] = 1279,
		["692"] = 1279,
		["693"] = 1200,
		["694"] = 1305,
		["695"] = 1305,
		["696"] = 1305,
		["697"] = 1305,
		["698"] = 1305,
		["699"] = 1305,
		["700"] = 1305,
		["701"] = 1305,
		["702"] = 1305,
		["703"] = 1200,
		["704"] = 1200,
		["706"] = 1333,
		["707"] = 1333,
		["708"] = 1333,
		["709"] = 1333,
		["710"] = 1333,
		["711"] = 1333,
		["712"] = 1333,
		["713"] = 1340,
		["714"] = 1340,
		["715"] = 1340,
		["716"] = 1340,
		["717"] = 1340,
		["718"] = 1340,
		["719"] = 1340,
		["720"] = 1348,
		["721"] = 1354,
		["723"] = 1356,
		["725"] = 1358,
		["726"] = 1384,
		["728"] = 1403,
		["729"] = 1403,
		["730"] = 1403,
		["731"] = 1403,
		["732"] = 1403,
		["733"] = 1403,
		["734"] = 1403,
		["735"] = 1403,
		["736"] = 1403,
		["737"] = 1403,
		["738"] = 1403,
		["739"] = 1403,
		["740"] = 1403,
		["741"] = 1403,
		["742"] = 1403,
		["743"] = 1403,
		["744"] = 1403,
		["745"] = 1403,
		["746"] = 1403,
		["747"] = 1403,
		["748"] = 1403,
		["749"] = 1403,
		["750"] = 1403,
		["751"] = 1403,
		["752"] = 1403,
		["753"] = 1403,
		["754"] = 1403,
		["755"] = 1403,
		["756"] = 1403,
		["757"] = 1403,
		["758"] = 1403,
		["759"] = 1403,
		["760"] = 1403,
		["761"] = 1403,
		["762"] = 1403,
		["763"] = 1403,
		["764"] = 1403,
		["765"] = 1403,
		["766"] = 1403,
		["767"] = 1403,
		["768"] = 1403,
		["769"] = 1403,
		["770"] = 1403,
		["771"] = 1403,
		["772"] = 1403,
		["773"] = 1403,
		["774"] = 1403,
		["775"] = 1403,
		["776"] = 1403,
		["777"] = 1403,
		["778"] = 1403,
		["779"] = 1403,
		["780"] = 1403,
		["781"] = 1403,
		["782"] = 1403,
		["783"] = 1403,
		["784"] = 1403,
		["785"] = 1403,
		["786"] = 1403,
		["787"] = 1403,
		["788"] = 1403,
		["789"] = 1403,
		["790"] = 1403,
		["791"] = 1403,
		["792"] = 1403,
		["793"] = 1403,
		["794"] = 1403,
		["795"] = 1403,
		["796"] = 1403,
		["797"] = 1403,
		["798"] = 1403,
		["799"] = 1403,
		["800"] = 1403,
		["801"] = 1403,
		["802"] = 1403,
		["803"] = 1403,
		["804"] = 1403,
		["805"] = 1403,
		["806"] = 1403,
		["807"] = 1403,
		["808"] = 1403,
		["809"] = 1403,
		["810"] = 1403,
		["811"] = 1403,
		["812"] = 1403,
		["813"] = 1403,
		["814"] = 1403,
		["815"] = 1403,
		["816"] = 1403,
		["817"] = 1403,
		["818"] = 1403,
		["819"] = 1403,
		["820"] = 1403,
		["821"] = 1403,
		["822"] = 1403,
		["823"] = 1403,
		["824"] = 1403,
		["825"] = 1403,
		["826"] = 1403,
		["827"] = 1403,
		["828"] = 1403,
		["829"] = 1403,
		["830"] = 1403,
		["831"] = 1403,
		["832"] = 1403,
		["833"] = 1403,
		["834"] = 1403,
		["835"] = 1403,
		["836"] = 1403,
		["837"] = 1403,
		["838"] = 1403,
		["839"] = 1403,
		["840"] = 1403,
		["841"] = 1403,
		["842"] = 1403,
		["843"] = 1403,
		["844"] = 1403,
		["845"] = 1403,
		["846"] = 1403,
		["847"] = 1403,
		["848"] = 1403,
		["849"] = 1403,
		["850"] = 1403,
		["851"] = 1403,
		["852"] = 1403,
		["853"] = 1403,
		["854"] = 1403,
		["855"] = 1403,
		["856"] = 1403,
		["857"] = 1403,
		["858"] = 1403,
		["859"] = 1403,
		["860"] = 1403,
		["861"] = 1403,
		["863"] = 1620,
		["865"] = 1623,
		["866"] = 1623,
		["867"] = 1623,
		["868"] = 1623,
		["869"] = 1623,
		["870"] = 1623,
		["871"] = 1623,
		["872"] = 1623,
		["873"] = 1623,
		["874"] = 1623,
		["875"] = 1623,
		["876"] = 1623,
		["877"] = 1623,
		["878"] = 1623,
		["879"] = 1623,
		["880"] = 1640,
		["881"] = 1640,
		["882"] = 1640,
		["883"] = 1640,
		["884"] = 1640,
		["885"] = 1645,
		["886"] = 1645,
		["887"] = 1645,
		["888"] = 1645,
		["889"] = 1645,
		["890"] = 1645,
		["891"] = 1645,
		["892"] = 1645,
		["893"] = 1645,
		["894"] = 1645,
		["895"] = 1645,
		["896"] = 1645,
		["897"] = 1645,
		["898"] = 1645,
		["899"] = 1645,
		["900"] = 1645,
		["901"] = 1645,
		["902"] = 1645,
		["903"] = 1645,
		["904"] = 1645,
		["905"] = 1645,
		["906"] = 1645,
		["907"] = 1645,
		["908"] = 1645,
		["909"] = 1645,
		["910"] = 1645,
		["911"] = 1645,
		["912"] = 1645,
		["913"] = 1645,
		["914"] = 1645,
		["915"] = 1645,
		["916"] = 1645,
		["917"] = 1645,
		["918"] = 1645,
		["919"] = 1645,
		["920"] = 1645,
		["921"] = 1645,
		["922"] = 1645,
		["923"] = 1645,
		["924"] = 1686,
		["925"] = 1686,
		["926"] = 1686,
		["927"] = 1686,
		["928"] = 1686,
		["929"] = 1686,
		["930"] = 1686,
		["931"] = 1686,
		["932"] = 1686,
		["933"] = 1686,
		["934"] = 1686,
		["935"] = 1686,
		["936"] = 1686,
		["937"] = 1701,
		["938"] = 1701,
		["939"] = 1701,
		["940"] = 1701,
		["941"] = 1701,
		["942"] = 1701,
		["943"] = 1701,
		["944"] = 1710,
		["945"] = 1710,
		["946"] = 1710,
		["947"] = 1710,
		["948"] = 1710,
		["949"] = 1710,
		["950"] = 1710,
		["951"] = 1719,
		["952"] = 1719,
		["953"] = 1719,
		["954"] = 1719,
		["955"] = 1719,
		["956"] = 1724,
		["957"] = 1724,
		["958"] = 1724,
		["959"] = 1724,
		["960"] = 1724,
		["962"] = 1730,
		["963"] = 1731,
		["964"] = 1732,
		["966"] = 1735,
		["968"] = 1753,
		["970"] = 1760,
		["971"] = 1760,
		["972"] = 1760,
		["973"] = 1760,
		["974"] = 1760,
		["975"] = 1760,
		["976"] = 1760,
		["977"] = 1760,
		["978"] = 1760,
		["979"] = 1760,
		["980"] = 1760,
		["981"] = 1760,
		["982"] = 1760,
		["983"] = 1760,
		["984"] = 1760,
		["985"] = 1760,
		["986"] = 1760,
		["987"] = 1760,
		["988"] = 1760,
		["989"] = 1760,
		["990"] = 1760,
		["991"] = 1760,
		["992"] = 1760,
		["993"] = 1760,
		["994"] = 1760,
		["995"] = 1760,
		["996"] = 1760,
		["997"] = 1760,
		["998"] = 1760,
		["999"] = 1760,
		["1000"] = 1760,
		["1001"] = 1760,
		["1002"] = 1760,
		["1003"] = 1760,
		["1004"] = 1760,
		["1005"] = 1760,
		["1006"] = 1760,
		["1007"] = 1760,
		["1008"] = 1760,
		["1009"] = 1760,
		["1011"] = 1839,
		["1014"] = 1845,
		["1015"] = 1845,
		["1016"] = 1845,
		["1017"] = 1845,
		["1018"] = 1845,
		["1019"] = 1845,
		["1020"] = 1845,
		["1021"] = 1845,
		["1022"] = 1845,
		["1023"] = 1845,
		["1024"] = 1845,
		["1025"] = 1845,
		["1026"] = 1845,
		["1027"] = 1845,
		["1028"] = 1845,
		["1029"] = 1845,
		["1030"] = 1845,
		["1031"] = 1845,
		["1032"] = 1845,
		["1033"] = 1845,
		["1034"] = 1845,
		["1035"] = 1845,
		["1036"] = 1845,
		["1037"] = 1845,
		["1038"] = 1845,
		["1039"] = 1845,
		["1040"] = 1845,
		["1041"] = 1845,
		["1042"] = 1845,
		["1043"] = 1845,
		["1044"] = 1845,
		["1045"] = 1845,
		["1046"] = 1845,
		["1047"] = 1845,
		["1048"] = 1845,
		["1049"] = 1845,
		["1050"] = 1845,
		["1051"] = 1845,
		["1052"] = 1845,
		["1055"] = 1895,
		["1057"] = 1898,
		["1060"] = 1910,
		["1061"] = 1910,
		["1062"] = 1910,
		["1063"] = 1910,
		["1064"] = 1910,
		["1065"] = 1910,
		["1066"] = 1910,
		["1067"] = 1910,
		["1068"] = 1910,
		["1071"] = 1921,
		["1074"] = 1936,
		["1075"] = 1936,
		["1076"] = 1936,
		["1077"] = 1936,
		["1078"] = 1936,
		["1079"] = 1936,
		["1080"] = 1936,
		["1081"] = 1936,
		["1082"] = 1936,
		["1083"] = 1936,
		["1084"] = 1936,
		["1085"] = 1936,
		["1086"] = 1936,
		["1087"] = 1936,
		["1088"] = 1936,
		["1089"] = 1936,
		["1090"] = 1936,
		["1091"] = 1936,
		["1092"] = 1936,
		["1093"] = 1936,
		["1094"] = 1936,
		["1095"] = 1936,
		["1096"] = 1936,
		["1102"] = 1978,
		["1103"] = 1978,
		["1104"] = 1978,
		["1105"] = 1978,
		["1106"] = 1978,
		["1107"] = 1978,
		["1108"] = 1978,
		["1109"] = 1978,
		["1110"] = 1978,
		["1111"] = 1978,
		["1115"] = 2019,
		["1120"] = 2029,
		["1121"] = 2031,
		["1122"] = 2032,
		["1124"] = 2035,
		["1125"] = 2036,
		["1127"] = 2039,
		["1128"] = 2040,
		["1130"] = 2043,
		["1131"] = 2029,
		["1138"] = 2053,
		["1139"] = 2054,
		["1140"] = 2055,
		["1141"] = 2056,
		["1142"] = 2058,
		["1143"] = 2059,
		["1144"] = 2060,
		["1145"] = 2061,
		["1146"] = 2063,
		["1147"] = 2063,
		["1148"] = 2063,
		["1149"] = 2063,
		["1150"] = 2064,
		["1151"] = 2065,
		["1152"] = 2066,
		["1155"] = 2069,
		["1156"] = 2070,
		["1159"] = 2074,
		["1160"] = 2053,
		["1172"] = 2089,
		["1173"] = 2089,
		["1174"] = 2089,
		["1176"] = 2090,
		["1177"] = 2091,
		["1178"] = 2092,
		["1179"] = 2093,
		["1180"] = 2094,
		["1181"] = 2097,
		["1182"] = 2098,
		["1183"] = 2099,
		["1184"] = 2100,
		["1185"] = 2101,
		["1186"] = 2102,
		["1188"] = 2106,
		["1189"] = 2107,
		["1190"] = 2108,
		["1191"] = 2109,
		["1192"] = 2112,
		["1193"] = 2114,
		["1194"] = 2115,
		["1195"] = 2116,
		["1196"] = 2118,
		["1197"] = 2119,
		["1198"] = 2120,
		["1199"] = 2122,
		["1200"] = 2123,
		["1202"] = 2126,
		["1203"] = 2128,
		["1204"] = 2129,
		["1205"] = 2130,
		["1206"] = 2131,
		["1207"] = 2132,
		["1208"] = 2134,
		["1209"] = 2135,
		["1210"] = 2136,
		["1214"] = 2141,
		["1215"] = 2089,
		["1217"] = 2150,
		["1218"] = 2151,
		["1219"] = 2151,
		["1220"] = 2151,
		["1221"] = 2151,
		["1222"] = 2151,
		["1223"] = 2150,
		["1224"] = 2158,
		["1225"] = 2158,
		["1226"] = 2158,
		["1227"] = 2158,
		["1228"] = 2158,
		["1229"] = 2150,
		["1230"] = 2170,
		["1231"] = 2171,
		["1232"] = 2172,
		["1233"] = 2175,
		["1235"] = 2177,
		["1248"] = 2194,
		["1249"] = 2194,
		["1250"] = 2194,
		["1251"] = 2194,
		["1252"] = 2194,
		["1253"] = 2194,
		["1254"] = 2194,
		["1255"] = 2194,
		["1256"] = 2194,
		["1257"] = 2194,
		["1258"] = 2194,
		["1259"] = 2194,
		["1261"] = 2208,
		["1262"] = 2209,
		["1264"] = 2212,
		["1265"] = 2214,
		["1267"] = 2221,
		["1268"] = 2223,
		["1269"] = 2223,
		["1270"] = 2223,
		["1271"] = 2223,
		["1272"] = 2223,
		["1273"] = 2223,
		["1274"] = 2223,
		["1275"] = 2223,
		["1276"] = 2222,
		["1277"] = 2224,
		["1278"] = 2224,
		["1279"] = 2224,
		["1280"] = 2224,
		["1281"] = 2224,
		["1282"] = 2224,
		["1283"] = 2224,
		["1284"] = 2224,
		["1285"] = 2221,
		["1286"] = 2227,
		["1287"] = 2227,
		["1288"] = 2227,
		["1289"] = 2227,
		["1290"] = 2227,
		["1291"] = 2227,
		["1292"] = 2227,
		["1293"] = 2227,
		["1294"] = 2226,
		["1295"] = 2228,
		["1296"] = 2228,
		["1297"] = 2228,
		["1298"] = 2228,
		["1299"] = 2228,
		["1300"] = 2228,
		["1301"] = 2228,
		["1302"] = 2228,
		["1303"] = 2228,
		["1304"] = 2221,
		["1309"] = 2237,
		["1310"] = 2245,
		["1311"] = 2245,
		["1312"] = 2245,
		["1313"] = 2245,
		["1314"] = 2245,
		["1315"] = 2245,
		["1316"] = 2245,
		["1317"] = 2245,
		["1318"] = 2245,
		["1319"] = 2245,
		["1320"] = 2245,
		["1321"] = 2245,
		["1322"] = 2245,
		["1323"] = 2245,
		["1324"] = 2245,
		["1325"] = 2245,
		["1326"] = 2344,
		["1327"] = 2345,
		["1328"] = 2349,
		["1329"] = 2365,
		["1330"] = 2366,
		["1331"] = 2367,
		["1333"] = 2370,
		["1334"] = 2372,
		["1335"] = 2374,
		["1337"] = 2377,
		["1338"] = 2378,
		["1342"] = 2384,
		["1343"] = 2385,
		["1344"] = 2385,
		["1345"] = 2385,
		["1346"] = 2385,
		["1347"] = 2385,
		["1348"] = 2385,
		["1349"] = 2385,
		["1350"] = 2385,
		["1351"] = 2385,
		["1352"] = 2385,
		["1353"] = 2385,
		["1354"] = 2385,
		["1355"] = 2385,
		["1356"] = 2385,
		["1357"] = 2385,
		["1358"] = 2385,
		["1359"] = 2385,
		["1360"] = 2385,
		["1361"] = 2385,
		["1362"] = 2385,
		["1363"] = 2385,
		["1364"] = 2385,
		["1365"] = 2385,
		["1366"] = 2385,
		["1367"] = 2385,
		["1368"] = 2385,
		["1369"] = 2385,
		["1370"] = 2385,
		["1371"] = 2385,
		["1372"] = 2385,
		["1373"] = 2385,
		["1374"] = 2385,
		["1375"] = 2385,
		["1376"] = 2385,
		["1377"] = 2385,
		["1378"] = 2385,
		["1379"] = 2385,
		["1380"] = 2385,
		["1381"] = 2385,
		["1382"] = 2384,
		["1383"] = 2421,
		["1384"] = 2422,
	}
)
ACT_DOTA_LARGO_ULT_STRUM_SUCCESS = 1774
ACT_DOTA_LARGO_ULT_STRUM_FAIL = 1775
ACT_DOTA_LARGO_ULT_TOGGLE_ON = 1777
ACT_DOTA_LARGO_ULT_TOGGLE_OFF = 1778
CENTER_MAP_CONFIG = { position = Vector(-1216, 960, 0), name = "prefabs/base_dprewar_1" }
DEFAULT_BANNED_HEROES = {}
_G.vec3_invalid = Vector(3.402823466e+38, 3.402823466e+38, 3.402823466e+38)
GAME_SEASON = 108
BATTLEPASS_SEASON = 9
FU_CARD_ACTIVITY_CONFIG = {
	[7026] = { red_envelope_id = 1100129, limit = 600, state = false },
	[16002] = { red_envelope_id = 1100147, limit = 200, state = false },
}
TOOLMODE_ROOKIE_ENABLE = false
function IsTurboMode(self)
	return GetMapName() == "turbo_map"
end
GAMEPLAY_MODULE_LIST = {
	rune_task = true,
	card_effect = false,
	city_effect = true,
	greevil = false,
	mergeability = false,
	roshan = false,
	treasure = true,
}
TEAM_ABILITY_BLESS_CD_ROUNDS = 3
function GourpModeSetting(self)
	GAMEPLAY_MODULE_LIST.card_effect = true
	CARD_EFFECT_REFRESH_COUNT = { [0] = 2 }
end
TEAM_PORTAL_STATE = TEAM_PORTAL_STATE or {}
TEAM_PORTAL_STATE.ENABLE = 0
TEAM_PORTAL_STATE[TEAM_PORTAL_STATE.ENABLE] = "ENABLE"
TEAM_PORTAL_STATE.DISABLE = 1
TEAM_PORTAL_STATE[TEAM_PORTAL_STATE.DISABLE] = "DISABLE"
TEAM_PORTAL_STATE.ACTIVATE = 2
TEAM_PORTAL_STATE[TEAM_PORTAL_STATE.ACTIVATE] = "ACTIVATE"
FRAME_LIMIT_TICK = 5
CREATEPARTICLE_FRAME_ALL_LIMIT_ENABLE = true
CREATEPARTICLE_FRAME_ALL_LIMIT_COUNTER = 0
CREATEPARTICLE_FRAME_ALL_LIMIT_MAX = 50
DYNAMIC_PRECACHE_RECORD = {}
OVERHEAD_EVENT_MESSAGE_LIMIT_RECORD = {}
OVERHEAD_EVENT_MESSAGE_LIMIT_COUNT = 5
LOGIC_VERSION = 1
vec3_zero = Vector(0, 0, 0)
vec3_left = Vector(-1, 0, 0)
vec3_right = Vector(1, 0, 0)
vec3_top = Vector(0, 1, 0)
vec3_bottom = Vector(0, -1, 0)
GAME_SPEED_DEFAULT = 1
GAME_SPEED_FAST = 4
FRAME_TIME = 0.033333
GLOBAL_PING_INTERVAL = 15
SYNC_LOG_ALL_MODE = false
SYNC_LOGIC_DEBUG_FAST_MODE = false
AUTO_RESTART_ROOM_PLAY = false
AUTO_RESTART_PLAYER_AMOUNT = 3
AUTO_MATCH_PLAY = false
AUTO_BOT8_PLAY = false
LOCAL_PLAYER_AUTO_LEARN_SKILL = true
UNIT_BASE_ATTACK_SPEED = 100
UNIT_MIN_ATTACK_SPEED = 20
NEW_PLAYER_MODE = false
TEST_STEAM_ID = {}
MAX_HEALTH = bit.bxor(2, 31 - 1)
MAX_MANA = bit.bxor(2, 16 - 1)
INIT_GAME_HEALTH = 50
INIT_GAME_HEALTH_TURBO = 20
INIT_GAME_HEALTH_TEAM = 80
FINAL_VS_EXTRA_DAMAGE = { [0] = 2, [16] = 4, [21] = 6, [26] = 8 }
CORRECT_GOLD = 50000
MAX_GOLD = 9999999
AI_TIMER_TICK_TIME = 0.1
NEW_PLAYER_MODE_MAX_PLAYERS = 4
MAX_PLAYERS = 8
MAX_SPECTATORS = 8
HERO_MAX_LEVEL = 100
HERO_XP_PER_LEVEL_TABLE = { 0 }
for g = #HERO_XP_PER_LEVEL_TABLE, HERO_MAX_LEVEL - 1, 1 do
	local h = (HERO_XP_PER_LEVEL_TABLE[g] or 0) * 1 + g * 0 + 10100
	HERO_XP_PER_LEVEL_TABLE[#HERO_XP_PER_LEVEL_TABLE + 1] = h
end
RARITY_COLOR = {
	[0] = Vector(76, 71, 70),
	[1] = Vector(23, 128, 50),
	[2] = Vector(74, 100, 190),
	[3] = Vector(140, 47, 210),
	[4] = Vector(190, 105, 20),
	[5] = Vector(255, 0, 0),
}
PHYSICAL_ARMOR_FACTOR = 0.06
MAGICAL_ARMOR_FACTOR = 0.06
MAXIMUM_ATTACK_SPEED = 600
MINIMUM_ATTACK_SPEED = 20
MINIMUM_ATTACK_RATE = 0.7
SPELL_LIFESTEAL_CREATURE_FACTOR = 0.2
ATTRIBUTE_STRENGTH_HP = 1.8
ATTRIBUTE_STRENGTH_HP_REGEN = 0.06
ATTRIBUTE_STRENGTH_IGNORE_DAMAGE = 0.00125
ATTRIBUTE_AGILITY_ATTACK_DAMAGE = 0.6
ATTRIBUTE_AGILITY_PHYSICAL_DAMAGE_PERCENT = 0.001
ATTRIBUTE_INTELLECT_MAGICAL_DAMAGE_PERCENT = 0.002
PLAYER_TEAM = DOTA_TEAM_GOODGUYS
ENEMY_TEAM = DOTA_TEAM_BADGUYS
SPECTATOR_TEAM = DOTA_TEAM_BADGUYS
PRE_GAME_TIME = 0
HERO_SELECTION_TIME = 30
MAX_DIFFICULTY = 18
CUSTOM_PAUSE_CD = 60
ABILITY_UPGRADES_OP = ABILITY_UPGRADES_OP or {}
ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD = 0
ABILITY_UPGRADES_OP[ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD] = "ABILITY_UPGRADES_OP_ADD"
ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_MUL = 1
ABILITY_UPGRADES_OP[ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_MUL] = "ABILITY_UPGRADES_OP_MUL"
ABILITY_UPGRADES_TYPE = ABILITY_UPGRADES_TYPE or {}
ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE = 0
ABILITY_UPGRADES_TYPE[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE] = "ABILITY_UPGRADES_TYPE_SPECIAL_VALUE"
ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE_PROPERTY = 1
ABILITY_UPGRADES_TYPE[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE_PROPERTY] =
	"ABILITY_UPGRADES_TYPE_SPECIAL_VALUE_PROPERTY"
ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_STATS = 2
ABILITY_UPGRADES_TYPE[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_STATS] = "ABILITY_UPGRADES_TYPE_STATS"
ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS = 3
ABILITY_UPGRADES_TYPE[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS] =
	"ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS"
ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ADD_ABILITY = 4
ABILITY_UPGRADES_TYPE[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ADD_ABILITY] = "ABILITY_UPGRADES_TYPE_ADD_ABILITY"
ABILITY_UPGRADES_KEY = ABILITY_UPGRADES_KEY or {}
ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA = 0
ABILITY_UPGRADES_KEY[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA] = "UPGRADES_KEY_DATA"
ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT = 1
ABILITY_UPGRADES_KEY[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT] = "UPGRADES_KEY_CACHED_RESULT"
NEW_ABILITY_SHOP_CONFIG = {
	Multiplier = 100,
	sect_lv = { [0] = { r = 0, sr = 0 }, [1] = { r = 0, sr = 0 }, [2] = { r = 0, sr = 0 }, [3] = { r = 0, sr = 0 }, [4] = {
		r = 0,
		sr = 0,
	} },
	hero_lv = {
		{ start_lv = 0, end_lv = 5, r = 0, sr = 0 },
		{ start_lv = 5, end_lv = 10, r = 0, sr = 0 },
		{ start_lv = 10, end_lv = 15, r = 0, sr = 0 },
		{ start_lv = 15, end_lv = 20, r = 0, sr = 0 },
	},
}
do
	local i = 0.5
	local j = 0.5
	local k = 0.5
	local l = 0.08
	local m = 0.08
	local n = 1.4
	local o = 1.3
	local p = 1.2
	local q = 0.3
	local r = 0.25
	do
		local s = 0
		while s < #NEW_ABILITY_SHOP_CONFIG.hero_lv do
			local t = 0
			local u = 0
			repeat
				local v = s
				local w = v == 0
				if w then
					do
						t = i
						u = 0
						break
					end
				end
				w = w or v == 1
				if w then
					do
						t = j
						u = l
						break
					end
				end
				w = w or v == 2
				if w then
					do
						t = k
						u = m
						break
					end
				end
				w = w or v == 3
				if w then
					do
						t = 0
						u = m
						break
					end
				end
			until true
			NEW_ABILITY_SHOP_CONFIG.hero_lv[s + 1].r = t
			NEW_ABILITY_SHOP_CONFIG.hero_lv[s + 1].sr = u
			s = s + 1
		end
	end
	do
		local x = 0
		while x < #c(NEW_ABILITY_SHOP_CONFIG.sect_lv) do
			local t = 0
			local u = 0
			repeat
				local y = x
				local z = y == 0
				if z then
					do
						t = 0
						u = 0
						break
					end
				end
				z = z or y == 1
				if z then
					do
						t = 0
						u = 0
						break
					end
				end
				z = z or y == 2
				if z then
					do
						t = n
						u = 0
						break
					end
				end
				z = z or y == 3
				if z then
					do
						t = n + o
						u = q
						break
					end
				end
				z = z or y == 4
				if z then
					do
						t = n + o + p
						u = q + r
						break
					end
				end
			until true
			NEW_ABILITY_SHOP_CONFIG.sect_lv[x].r = t
			NEW_ABILITY_SHOP_CONFIG.sect_lv[x].sr = u
			x = x + 1
		end
	end
end
HERO_SHOW_CONFIG = {
	CAMERA_DISTANCE = 1600,
	CAMERA_YAW = 0,
	CAMERA_PITCH = 60,
	CAMERA_HEIGHT = 0,
	HERO_FACE_TOWARDS_POSITION = Vector(-0, -1200, 0),
	HERO_SHOW_INTERVAL = 0.25,
	HERO_SHOW_DELAY = 1,
	HERO_SHOW_GLOBAL_SOUND = "versus_screen.radiant",
	HERO_SHOW_ANIMATION = ACT_DOTA_SPAWN,
}
HERO_BAN_SLOT_AMOUNTS = 4
GAME_STATE_CONFIG = {
	GameState_None = {},
	GameState_ExtraBattlePrepare = { duration = 3 },
	GameState_HeroBan = { duration = 40 },
	GameState_HeroSelection = { duration = 40, duration_fast = 8 },
	GameState_GreevilEgg = { duration = 15, duration_fast = 15, warnCountdown = 5 },
	GameState_CitySelection = { duration = 15, duration_fast = 15, warnCountdown = 5 },
	GameState_CityEnd = { duration = 5, duration_fast = 5 },
	GameState_FinalVS = { duration = 5, duration_fast = 5 },
	GameState_HeroShow = { duration = 8, duration_fast = 8 },
	GameState_Prepare = { duration = 20, max_duration = 35, duration_add = 1, duration_fast = 15, warnCountdown = 10 },
	GameState_AfterPrepare = { duration = 5, duration_fast = 3 },
	GameState_ConfirmBattle = { duration = 5, duration_fast = 3 },
	GameState_Battle = { duration = 50, duration_fast = 50 },
	GameState_BattleEnd = { duration = 3, duration_fast = 2 },
	GameState_ArtifactSelection = { duration = 20, duration_fast = 9, warnCountdown = 5 },
	GameState_ConfirmNeutral = { duration = 5, duration_fast = 3 },
	GameState_ConfirmRoshan = { duration = 5, duration_fast = 3 },
	GameState_Neutral = { duration = 50, duration_fast = 50, speedUpTime = 20 },
	GameState_SpecialSelection = { duration = 15, duration_fast = 10, speedUpTime = 5, warnCountdown = 5 },
	GameState_Trait = { duration = 20, duration_fast = 10 },
	GameState_RuneTask = { duration = 20, duration_fast = 10 },
	GameState_RoshanTreasure = {},
	GameState_Treasure = { duration = 50, duration_fast = 50, warnCountdown = 5 },
	GameState_SwtichRound = { duration = 15, duration_fast = 15 },
}
PlayerCameraType = PlayerCameraType or {}
PlayerCameraType.NORMAL = 0
PlayerCameraType[PlayerCameraType.NORMAL] = "NORMAL"
PlayerCameraType.PUBLIC = 1
PlayerCameraType[PlayerCameraType.PUBLIC] = "PUBLIC"
PlayerCameraType.PREVIEW = 2
PlayerCameraType[PlayerCameraType.PREVIEW] = "PREVIEW"
PLAYER_START_GOLD = 300
PLAYER_START_GOLD_TURBO = 700
GOLD_PER_ROUND = { [1] = 250, [11] = 250, [21] = 250 }
GOLD_PER_ROUND_TURBO = { [1] = 350, [6] = 400, [11] = 450 }
GOLD_INTEREST_CONFIG = { Rate = 100, Max = 100, Gold = 10 }
GOLD_INTEREST_CONFIG_TURBO = { Rate = 100, Max = 100, Gold = 10 }
function getInterestConfig(self)
	return IsTurboMode(nil) and GOLD_INTEREST_CONFIG_TURBO or GOLD_INTEREST_CONFIG
end
REFRESH_COST = 20
RANDOM_COST = 100
ABILITY_COST = { n = 100, r = 200, sr = 300 }
GOLD_BATTLE_CONFIG =
	{ Base = 0, WinBase = 50, WinStack = 25, MaxWinStack = 150, LosePerHP = 20, LoseStack = 20, MaxLoseStack = 100 }
GOLD_BATTLE_CONFIG_TURBO =
	{ Base = 0, WinBase = 100, WinStack = 40, MaxWinStack = 120, LosePerHP = 50, LoseStack = 30, MaxLoseStack = 120 }
function getGoldBattleConfig(self)
	return IsTurboMode(nil) and GOLD_BATTLE_CONFIG_TURBO or GOLD_BATTLE_CONFIG
end
PLAYER_DAMAGE_CONFIG = {
	BaseDamage = { [1] = 2, [10] = 2, [15] = 2, [20] = 3, [24] = 4, [28] = 6 },
	MaxDamage = { [1] = 6, [10] = 8, [15] = 9, [20] = 13, [25] = 50 },
	LevelDamage = { [5] = 1, [10] = 2, [15] = 2, [20] = 3, [24] = 4, [28] = 6 },
	WinDamage = 1,
	MaxWinDamage = { [1] = 4, [10] = 4, [15] = 4, [20] = 5 },
}
PLAYER_DAMAGE_CONFIG_TURBO = {
	BaseDamage = { [1] = 2, [10] = 4, [15] = 6 },
	MaxDamage = { [1] = 10, [5] = 10, [10] = 10, [15] = 12 },
	LevelDamage = { [5] = 0, [10] = 0, [15] = 0, [20] = 1 },
	WinDamage = 0,
	MaxWinDamage = { [1] = 1, [10] = 2, [15] = 3 },
}
SECT_DATA = { [0] = { MaxExp = 4 }, [1] = { MaxExp = 10 }, [2] = { MaxExp = 20 }, [3] = { MaxExp = 40 } }
SECT_MAX_EXP = { 4, 10, 20, 40 }
SECT_EXP = { n = 1, r = 2, sr = 4 }
SECT_ABILITY_LEVEL = { n = 5, r = 3, sr = 1 }
POISON_INTERVAL = 1
POISON_ATTENUATION = { Const = 1, Percentage = 0.3 }
ICE_FURY_MANA_REGEN = function(A, B, C)
	return B * C / (C + 125)
end
ICE_FURY_ATTACKSPEED = function(A, C)
	return 150 * C / (C + 250)
end
ICE_DAMAGE_INCREASE = 250
ICE_ATTENUATION = { Interval = 1, Const = 1, Percentage = 0.3 }
FURY_DAMAGE_REDUCTION = 250
FURY_ATTENUATION = { Interval = 1, Const = 1, Percentage = 0.3 }
SHIELD_ATTENUATION = { Const = 1, Percentage = 0.3 }
INJURY_ATTENUATION = { Const = 1, Percentage = 0.3 }
WISP_HEALTH_BASE = 100
WISP_SHARE_BASE = 50
WISP_BASE_DAMAGE = 20
WISP_PROJECTILE_SPEED = 900
WISP_ATTACK_RATE = 1.5
WISP_MIN_ATTACK_RATE = 0.1
CHAOS_THRESHOLD = 100
CHAOS_DAMAGE = 60
PROJECTILE_TYPE = PROJECTILE_TYPE or {}
PROJECTILE_TYPE.PROJECTILE_TYPE_LINEAR = 0
PROJECTILE_TYPE[PROJECTILE_TYPE.PROJECTILE_TYPE_LINEAR] = "PROJECTILE_TYPE_LINEAR"
PROJECTILE_TYPE.PROJECTILE_TYPE_TRACKING = 1
PROJECTILE_TYPE[PROJECTILE_TYPE.PROJECTILE_TYPE_TRACKING] = "PROJECTILE_TYPE_TRACKING"
PROJECTILE_TYPE.PROJECTILE_TYPE_SURROUND = 2
PROJECTILE_TYPE[PROJECTILE_TYPE.PROJECTILE_TYPE_SURROUND] = "PROJECTILE_TYPE_SURROUND"
AI_SEARCH_BEHAVIOR = AI_SEARCH_BEHAVIOR or {}
AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_NONE = 0
AI_SEARCH_BEHAVIOR[AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_NONE] = "AI_SEARCH_BEHAVIOR_NONE"
AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_MOST_AOE_TARGET = 1
AI_SEARCH_BEHAVIOR[AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_MOST_AOE_TARGET] = "AI_SEARCH_BEHAVIOR_MOST_AOE_TARGET"
AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_MOST_LINE_TARGET = 2
AI_SEARCH_BEHAVIOR[AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_MOST_LINE_TARGET] = "AI_SEARCH_BEHAVIOR_MOST_LINE_TARGET"
SPEED_UP_DAMAGE_PCT = 6
SPEED_UP_TIME = 20
BAN_SECT_COUNT = 5
SECT_NONE_BAND_COUNT = 1
ABILITY_SHOP_RARITY_WEIGHT = { n = 15, r = 9, sr = 3 }
SECT_LEVEL_FACTOR = {
	[0] = { n = 15, r = 0, sr = 0 },
	[1] = { n = 15, r = 0, sr = 0 },
	[2] = { n = 15, r = 7, sr = 0 },
	[3] = { n = 15, r = 10, sr = 3 },
	[4] = { n = 15, r = 12, sr = 6 },
}
HEALTH_PER_LEVEL = { 100, 200, 300, 500 }
ATTRIBUTE_TYPE = ATTRIBUTE_TYPE or {}
ATTRIBUTE_TYPE.ATTACK = 0
ATTRIBUTE_TYPE[ATTRIBUTE_TYPE.ATTACK] = "ATTACK"
ATTRIBUTE_TYPE.ATTACKSPEED = 1
ATTRIBUTE_TYPE[ATTRIBUTE_TYPE.ATTACKSPEED] = "ATTACKSPEED"
ATTRIBUTE_TYPE.CRIT_CHANCE = 2
ATTRIBUTE_TYPE[ATTRIBUTE_TYPE.CRIT_CHANCE] = "CRIT_CHANCE"
ATTRIBUTE_TYPE.CRIT_DAMAGE = 3
ATTRIBUTE_TYPE[ATTRIBUTE_TYPE.CRIT_DAMAGE] = "CRIT_DAMAGE"
ATTRIBUTE_TYPE.REGEN = 4
ATTRIBUTE_TYPE[ATTRIBUTE_TYPE.REGEN] = "REGEN"
ATTRIBUTE_TYPE.INJURY = 5
ATTRIBUTE_TYPE[ATTRIBUTE_TYPE.INJURY] = "INJURY"
ATTRIBUTE_TYPE.POISON = 6
ATTRIBUTE_TYPE[ATTRIBUTE_TYPE.POISON] = "POISON"
ATTRIBUTE_TYPE.ICE = 7
ATTRIBUTE_TYPE[ATTRIBUTE_TYPE.ICE] = "ICE"
ATTRIBUTE_TYPE.SHIELD = 8
ATTRIBUTE_TYPE[ATTRIBUTE_TYPE.SHIELD] = "SHIELD"
ATTRIBUTE_TYPE.EVASION = 9
ATTRIBUTE_TYPE[ATTRIBUTE_TYPE.EVASION] = "EVASION"
ATTRIBUTE_TYPE.MAGICAL_RESISTANCE = 10
ATTRIBUTE_TYPE[ATTRIBUTE_TYPE.MAGICAL_RESISTANCE] = "MAGICAL_RESISTANCE"
ATTRIBUTE_TYPE.PHYSICAL_RESISTANCE = 11
ATTRIBUTE_TYPE[ATTRIBUTE_TYPE.PHYSICAL_RESISTANCE] = "PHYSICAL_RESISTANCE"
ATTRIBUTE_TYPE.MANA_REGEN = 12
ATTRIBUTE_TYPE[ATTRIBUTE_TYPE.MANA_REGEN] = "MANA_REGEN"
ATTRIBUTE_TYPE.ULTI_AMPLIFY = 13
ATTRIBUTE_TYPE[ATTRIBUTE_TYPE.ULTI_AMPLIFY] = "ULTI_AMPLIFY"
ATTRIBUTE_TYPE.WISP_HEALTH = 14
ATTRIBUTE_TYPE[ATTRIBUTE_TYPE.WISP_HEALTH] = "WISP_HEALTH"
ATTRIBUTE_TYPE.HEALTH = 15
ATTRIBUTE_TYPE[ATTRIBUTE_TYPE.HEALTH] = "HEALTH"
HERO_ATTRIBUTE_TYPE = {
	DAMAGE = {
		[2] = { [ATTRIBUTE_TYPE.ATTACK] = 2 },
		[3] = { [ATTRIBUTE_TYPE.INJURY] = 2 },
		[4] = { [ATTRIBUTE_TYPE.ATTACKSPEED] = 5 },
		[5] = { [ATTRIBUTE_TYPE.CRIT_DAMAGE] = 10 },
		[6] = { [ATTRIBUTE_TYPE.CRIT_CHANCE] = 2 },
		[7] = { [ATTRIBUTE_TYPE.INJURY] = 2 },
		[8] = { [ATTRIBUTE_TYPE.ICE] = 2 },
		[9] = { [ATTRIBUTE_TYPE.POISON] = 2 },
		[10] = { [ATTRIBUTE_TYPE.ATTACK] = 6 },
		[11] = { [ATTRIBUTE_TYPE.ULTI_AMPLIFY] = 10 },
		[12] = { [ATTRIBUTE_TYPE.ATTACKSPEED] = 10 },
		[13] = { [ATTRIBUTE_TYPE.CRIT_CHANCE] = 3 },
		[14] = { [ATTRIBUTE_TYPE.CRIT_DAMAGE] = 20 },
		[15] = { [ATTRIBUTE_TYPE.INJURY] = 6 },
		[16] = { [ATTRIBUTE_TYPE.ICE] = 6 },
		[17] = { [ATTRIBUTE_TYPE.POISON] = 6 },
		[18] = { [ATTRIBUTE_TYPE.ATTACK] = 12 },
		[19] = { [ATTRIBUTE_TYPE.CRIT_CHANCE] = 5 },
		[20] = { [ATTRIBUTE_TYPE.CRIT_DAMAGE] = 60 },
		[21] = { [ATTRIBUTE_TYPE.HEALTH] = 5 },
		[22] = { [ATTRIBUTE_TYPE.HEALTH] = 5 },
		[23] = { [ATTRIBUTE_TYPE.HEALTH] = 5 },
		[24] = { [ATTRIBUTE_TYPE.HEALTH] = 5 },
		[25] = { [ATTRIBUTE_TYPE.HEALTH] = 5 },
	},
	DEFENSE = {
		[2] = { [ATTRIBUTE_TYPE.SHIELD] = 2 },
		[3] = { [ATTRIBUTE_TYPE.REGEN] = 2 },
		[4] = { [ATTRIBUTE_TYPE.PHYSICAL_RESISTANCE] = 2 },
		[5] = { [ATTRIBUTE_TYPE.MAGICAL_RESISTANCE] = 5 },
		[6] = { [ATTRIBUTE_TYPE.EVASION] = 4 },
		[7] = { [ATTRIBUTE_TYPE.ICE] = 3 },
		[8] = { [ATTRIBUTE_TYPE.SHIELD] = 4 },
		[9] = { [ATTRIBUTE_TYPE.REGEN] = 4 },
		[10] = { [ATTRIBUTE_TYPE.WISP_HEALTH] = 6 },
		[11] = { [ATTRIBUTE_TYPE.ULTI_AMPLIFY] = 10 },
		[12] = { [ATTRIBUTE_TYPE.HEALTH] = 10 },
		[13] = { [ATTRIBUTE_TYPE.PHYSICAL_RESISTANCE] = 10 },
		[14] = { [ATTRIBUTE_TYPE.MAGICAL_RESISTANCE] = 10 },
		[15] = { [ATTRIBUTE_TYPE.ICE] = 6 },
		[16] = { [ATTRIBUTE_TYPE.SHIELD] = 6 },
		[17] = { [ATTRIBUTE_TYPE.REGEN] = 6 },
		[18] = { [ATTRIBUTE_TYPE.EVASION] = 6 },
		[19] = { [ATTRIBUTE_TYPE.PHYSICAL_RESISTANCE] = 10 },
		[20] = { [ATTRIBUTE_TYPE.MAGICAL_RESISTANCE] = 10 },
		[21] = { [ATTRIBUTE_TYPE.HEALTH] = 5 },
		[22] = { [ATTRIBUTE_TYPE.HEALTH] = 5 },
		[23] = { [ATTRIBUTE_TYPE.HEALTH] = 5 },
		[24] = { [ATTRIBUTE_TYPE.HEALTH] = 5 },
		[25] = { [ATTRIBUTE_TYPE.HEALTH] = 5 },
	},
	ABILITY = {
		[2] = { [ATTRIBUTE_TYPE.MANA_REGEN] = 1 },
		[3] = { [ATTRIBUTE_TYPE.INJURY] = 2 },
		[4] = { [ATTRIBUTE_TYPE.ULTI_AMPLIFY] = 5 },
		[5] = { [ATTRIBUTE_TYPE.CRIT_DAMAGE] = 10 },
		[6] = { [ATTRIBUTE_TYPE.CRIT_CHANCE] = 2 },
		[7] = { [ATTRIBUTE_TYPE.INJURY] = 2 },
		[8] = { [ATTRIBUTE_TYPE.ICE] = 2 },
		[9] = { [ATTRIBUTE_TYPE.POISON] = 2 },
		[10] = { [ATTRIBUTE_TYPE.MANA_REGEN] = 3 },
		[11] = { [ATTRIBUTE_TYPE.ULTI_AMPLIFY] = 10 },
		[12] = { [ATTRIBUTE_TYPE.ULTI_AMPLIFY] = 10 },
		[13] = { [ATTRIBUTE_TYPE.CRIT_CHANCE] = 3 },
		[14] = { [ATTRIBUTE_TYPE.CRIT_DAMAGE] = 20 },
		[15] = { [ATTRIBUTE_TYPE.INJURY] = 6 },
		[16] = { [ATTRIBUTE_TYPE.ICE] = 6 },
		[17] = { [ATTRIBUTE_TYPE.POISON] = 6 },
		[18] = { [ATTRIBUTE_TYPE.MANA_REGEN] = 6 },
		[19] = { [ATTRIBUTE_TYPE.CRIT_CHANCE] = 5 },
		[20] = { [ATTRIBUTE_TYPE.CRIT_DAMAGE] = 60 },
		[21] = { [ATTRIBUTE_TYPE.HEALTH] = 5 },
		[22] = { [ATTRIBUTE_TYPE.HEALTH] = 5 },
		[23] = { [ATTRIBUTE_TYPE.HEALTH] = 5 },
		[24] = { [ATTRIBUTE_TYPE.HEALTH] = 5 },
		[25] = { [ATTRIBUTE_TYPE.HEALTH] = 5 },
	},
}
CUSTOM_ABILITY_TYPE = CUSTOM_ABILITY_TYPE or {}
CUSTOM_ABILITY_TYPE.ABILITY_TYPE_NONE = 0
CUSTOM_ABILITY_TYPE[CUSTOM_ABILITY_TYPE.ABILITY_TYPE_NONE] = "ABILITY_TYPE_NONE"
CUSTOM_ABILITY_TYPE.ABILITY_TYPE_TALENT = 1
CUSTOM_ABILITY_TYPE[CUSTOM_ABILITY_TYPE.ABILITY_TYPE_TALENT] = "ABILITY_TYPE_TALENT"
CUSTOM_ABILITY_TYPE.ABILITY_TYPE_UI_HIDDEN = 2
CUSTOM_ABILITY_TYPE[CUSTOM_ABILITY_TYPE.ABILITY_TYPE_UI_HIDDEN] = "ABILITY_TYPE_UI_HIDDEN"
TRAIT_ROUND = { 18 }
TRAIT_ROUND_TURBO = { 10 }
ARTIFACT_ROUND = { 3, 8, 13 }
ARTIFACT_ROUND_TURBO = { 1, 4, 7 }
ARTIFACT_SELECTION_COUNT = 3
ARTIFACT_REFRESH_COUNT = 1
EQUIPMENT_REFRESH_COUNT = 1
RUNE_ROUND = { 9, 18 }
NEUTRAL_ROUND = { 5, 10, 15 }
NEUTRAL_ROUND_TURBO = { 3, 6, 9 }
NEUTRAL_LEVEL = { [NEUTRAL_ROUND[1]] = 6, [NEUTRAL_ROUND[2]] = 9, [NEUTRAL_ROUND[3]] = 12 }
NEUTRAL_LEVEL_TURBO = { [NEUTRAL_ROUND_TURBO[1]] = 6, [NEUTRAL_ROUND_TURBO[2]] = 9, [NEUTRAL_ROUND_TURBO[3]] = 12 }
NEUTRAL_RECOMMEND_LEVEL = {
	[NEUTRAL_ROUND[1]] = { [3] = 1, [6] = 2, [9] = 3 },
	[NEUTRAL_ROUND[2]] = { [6] = 3, [9] = 4, [12] = 6 },
	[NEUTRAL_ROUND[3]] = { [9] = 6, [12] = 9, [15] = 12 },
}
NEUTRAL_DAMAGE = { [3] = 1, [6] = 2, [9] = 3, [12] = 4, [15] = 5 }
NEUTRAL_DROP_ITEM_LEVEL = { [3] = 1, [6] = 1, [9] = 2, [12] = 3, [15] = 5 }
NEUTRAL_LOSS_ITEM_LEVEL = { [NEUTRAL_ROUND[1]] = 1, [NEUTRAL_ROUND[2]] = 2, [NEUTRAL_ROUND[3]] = 3 }
NEUTRAL_REFRESH_CONFIG = { Base = 40, Stack = 15, Max = 100 }
NEUTRAL_SECT_INFO = {
	[NEUTRAL_ROUND[1]] = {
		[3] = { Method = "Random", Gold = 600 },
		[6] = { Method = "Percent", Value = 40, Gold = 900 },
		[9] = { Method = "Percent", Value = 60, Gold = 1200 },
	},
	[NEUTRAL_ROUND[2]] = {
		[6] = { Method = "Random", Gold = 1800 },
		[9] = { Method = "Percent", Value = 40, Gold = 2400 },
		[12] = { Method = "Percent", Value = 60, Gold = 3200 },
	},
	[NEUTRAL_ROUND[3]] = {
		[9] = { Method = "Random", Gold = 3600 },
		[12] = { Method = "Percent", Value = 50, Gold = 4800 },
		[15] = { Method = "Percent", Value = 70, Gold = 7200 },
	},
}
NEUTRAL_SECT_INFO[NEUTRAL_ROUND_TURBO[1]] = NEUTRAL_SECT_INFO[NEUTRAL_ROUND[1]]
NEUTRAL_SECT_INFO[NEUTRAL_ROUND_TURBO[2]] = NEUTRAL_SECT_INFO[NEUTRAL_ROUND[2]]
NEUTRAL_SECT_INFO[NEUTRAL_ROUND_TURBO[3]] = NEUTRAL_SECT_INFO[NEUTRAL_ROUND[3]]
TREASURE_ROUND = { 10, 20 }
ROSHAN_ROUND = 20
ROSHAN_UNIT = "neu_roshan"
ROSHAN_SECT_INFO = { Method = "Percent", Value = 70, Gold = 8000 }
ROSHAN_ABILITY = {
	["1"] = { { sr = 1 }, { r = 2 }, { r = 2 }, { n = 4 }, { n = 4 }, { n = 4 }, { gold = 450 }, { gold = 450 } },
	["2"] = { { r = 2 }, { r = 2 }, { r = 2 }, { n = 4 }, { n = 4 }, { n = 4 }, { gold = 400 }, { gold = 400 } },
	["3"] = { { r = 2 }, { r = 2 }, { r = 2 }, { n = 4 }, { n = 4 }, { n = 4 }, { n = 4 }, { gold = 400 } },
	["4"] = { { r = 2 }, { r = 2 }, { n = 4 }, { n = 4 }, { n = 4 }, { n = 4 }, { gold = 350 }, { gold = 350 } },
	["5"] = { { sr = 1 }, { sr = 1 }, { r = 2 }, { r = 2 }, { r = 2 }, { r = 2 }, { gold = 450 }, { gold = 450 } },
}
ROSHAN_ABILITY_WEIGHT = { ["1"] = 10, ["2"] = 20, ["3"] = 20, ["4"] = 20, ["5"] = 10 }
ROSHAN_ABILITY_MIN_ROUND = { ["1"] = 12, ["2"] = 1, ["3"] = 1, ["4"] = 1, ["5"] = 12 }
SECT_COUNT = { n = 15, r = 9, sr = 4 }
SECT_ADJUST_ROUND = 6
SECT_ADJUST_DIFF = 10
SECT_ADJUST_OVERLOAD = {
	[10] = { adjust = 10, level = 1, color = "#a2ff92" },
	[20] = { adjust = 20, level = 2, color = "#a2ff92" },
	[35] = { adjust = 40, level = 3, color = "#61fc46" },
	[50] = { adjust = 60, level = 4, color = "#26ff00" },
}
SECT_OVERLOAD = {
	{ threshold = 35, adjust = 15, color = "#FFFF00" },
	{ threshold = 25, adjust = 35, color = "#FFA900" },
	{ threshold = 15, adjust = 75, color = "#FF0000" },
}
BUFF_VALUE = {
	LockReduce = 30,
	LockManaRegenBaseReduce = 3,
	BlindChance = 50,
	CritDamage = 150,
	EvadeDamageReduce = 60,
	RegenDisablePct = -30,
	PoisonInterval = POISON_INTERVAL,
	PoisonConst = POISON_ATTENUATION.Const,
	PoisonPercentage = POISON_ATTENUATION.Percentage,
	IceConst = ICE_ATTENUATION.Const,
	IcePercentage = ICE_ATTENUATION.Percentage,
	IceInterval = ICE_ATTENUATION.Interval,
	FuryConst = FURY_ATTENUATION.Const,
	FuryPercentage = FURY_ATTENUATION.Percentage,
	FuryInterval = FURY_ATTENUATION.Interval,
	ShieldConst = SHIELD_ATTENUATION.Const,
	ShieldPercentage = SHIELD_ATTENUATION.Percentage,
	InjuryConst = INJURY_ATTENUATION.Const,
	InjuryPercentage = INJURY_ATTENUATION.Percentage,
	WispHealth = WISP_HEALTH_BASE,
	WispShare = WISP_SHARE_BASE,
	WispDamage = WISP_BASE_DAMAGE,
	ChaosThreshold = CHAOS_THRESHOLD,
	ChaosDamage = CHAOS_DAMAGE,
	fury_interval = 0.4,
	fury_base_damage = 20,
	fury_damage_pct = 20,
	ice_energy_reduce_base = 10,
	ice_energy_reduce_pct = 0.2,
	poison_buff = 1,
	DrunkReduce = 40,
	DrunkDuration = 8,
	LosePerHP = 15,
	OverloadPhyDmg = 6,
	OverloadIntervalReduce = 0.2,
	FrozenCurseDamage = 20,
	FrozenCurseDebuffValue = 30,
	SuperNovaHealth = 2400,
	SuperNovaDPS = 60,
	SuperNovaDamageReduce = 18,
	SuperNovaDuration = 3,
	SuperNovaSpawnHealthPct = 100,
	SuperNovaFuryCount = 500,
	ColdEmbraceDamageReduce = 70,
	ColdEmbraceIceReduce = 30,
	ColdEmbraceRegenBase = 120,
	ColdEmbraceRegenPct = 40,
	ColdEmbraceDuration = 3,
	ColdEmbraceIceTick = 0.5,
	ColdEmbraceIceBonus = 48,
	CullingBladeStackValue = 0.5,
	StrongShieldReduceTick = 0.6,
	RuneDamageReduce = 5,
	UnblockDemonRegenBase = 40,
	UnblockDemonRegen = 4,
	UnblockDemonManaLimit = 300,
	UnblockDemonConvertPhy = 1,
	UnblockDemonConvertChaos = 6,
	UnblockDemonConvertManaRegen = 8,
	RemnantFury = 60,
	RemnantDmg = 60,
	RemnantCount = 3,
	RemnantFuryDamage = 120,
	RainOfDestinyThreshold = 40,
	RainOfDestinyRegen = 30,
	RainOfDestinyDamage = 40,
	FanOfKnivesCritFactor = 2.2,
	BurningBodyConvert = 25,
	BurningBodyDuration = 3,
	BurningBodyThreshold = 50,
	BurningBodyMagicReduce = 1,
	BurningBodyMax = 18,
	FleshGolemDuration = 1.5,
	FleshGolemChance = 25,
	PhantomEdgeDuration = 4,
	PhantomEdgeAttackDamage = 10,
	PhantomEdgeAttackSpeed = 40,
	AnilePhysicalDmgReducePct = 30,
	AnileMagicalDmgAddPct = 30,
	AnileSelfAddHealPct = 30,
	SiphoningReduceWispInterval = 0.5,
	SiphoningReduceIncomingDamagePct = 30,
	BloodyStormAtkInterval = 0.5,
	BloodyStormDuration = 1.5,
	BloodyStormBaseDamage = 200,
	BloodyStormFuryDamagePct = 50,
	CustomManaModelFire = 5,
	CustomManaModelPoison = 4,
	CustomManaModelIce = 5,
	EnigmaCurseDuration = 3,
	EnigmaCurseStun = 0.3,
	EnigmaCurseChaosDmg = 80,
	MidnightWitheringInterval = 0.3,
	MidnightWitheringBaseDmg = 40,
	MidnightWitheringHpDmgPct = 5,
	RingMoonConstantAtk = 10,
	RingMoonLevelAtkMul = 1,
	RingMoonCollectionExpend = 1,
	SoulChainDamageReducePct = 15,
	SoulChainEvade = 8,
	SoulChainDuration = 4,
	HostileShadowDuration = 3,
	HostileShadowInterval = 1,
	HostileShadowDamage = 240,
	FuryCampaignGoal1 = 300,
	FuryCampaignGoal2 = 400,
	FuryCampaignGoal3 = 800,
	FuryCampaignGoal4 = 1600,
	FuryCampaignGoal5 = 3200,
	IceCampaignGoal1 = 300,
	IceCampaignGoal2 = 400,
	IceCampaignGoal3 = 800,
	IceCampaignGoal4 = 1600,
	IceCampaignGoal5 = 3200,
	InjuryCampaignGoal1 = 200,
	InjuryCampaignGoal2 = 300,
	InjuryCampaignGoal3 = 600,
	InjuryCampaignGoal4 = 1200,
	InjuryCampaignGoal5 = 2400,
	ShieldCampaignGoal1 = 150,
	ShieldCampaignGoal2 = 200,
	ShieldCampaignGoal3 = 400,
	ShieldCampaignGoal4 = 800,
	ShieldCampaignGoal5 = 1600,
	CampaignGold1 = 50,
	CampaignGold2 = 100,
	CampaignGold3 = 150,
	CampaignGold4 = 200,
	CampaignGold5 = 300,
	ScarHealthPct = 4,
	ScarMaxCount = 10,
	ScarMaxHealthPct = 40,
}
TALENT_REQUIRE_LEVEL = { 5, 10, 15 }
EOM_DAMAGE_TYPES = EOM_DAMAGE_TYPES or {}
EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE = 0
EOM_DAMAGE_TYPES[EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE] = "DAMAGE_TYPE_NONE"
EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL = 1
EOM_DAMAGE_TYPES[EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL] = "DAMAGE_TYPE_PHYSICAL"
EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL = 2
EOM_DAMAGE_TYPES[EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL] = "DAMAGE_TYPE_MAGICAL"
EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE = 4
EOM_DAMAGE_TYPES[EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE] = "DAMAGE_TYPE_PURE"
EOM_DAMAGE_TYPES.DAMAGE_TYPE_POISON = 8
EOM_DAMAGE_TYPES[EOM_DAMAGE_TYPES.DAMAGE_TYPE_POISON] = "DAMAGE_TYPE_POISON"
EOM_DAMAGE_TYPES.DAMAGE_TYPE_INJURY = 16
EOM_DAMAGE_TYPES[EOM_DAMAGE_TYPES.DAMAGE_TYPE_INJURY] = "DAMAGE_TYPE_INJURY"
EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS = 32
EOM_DAMAGE_TYPES[EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS] = "DAMAGE_TYPE_CHAOS"
EOM_ATTACK_FLAGS = EOM_ATTACK_FLAGS or {}
EOM_ATTACK_FLAGS.ATTACK_FLAG_NONE = 0
EOM_ATTACK_FLAGS[EOM_ATTACK_FLAGS.ATTACK_FLAG_NONE] = "ATTACK_FLAG_NONE"
EOM_ATTACK_FLAGS.ATTACK_FLAG_ZEN_ORB = 1
EOM_ATTACK_FLAGS[EOM_ATTACK_FLAGS.ATTACK_FLAG_ZEN_ORB] = "ATTACK_FLAG_ZEN_ORB"
DamageFlags = DamageFlags or {}
DamageFlags.DAMAGE_FLAG_NONE = 0
DamageFlags[DamageFlags.DAMAGE_FLAG_NONE] = "DAMAGE_FLAG_NONE"
DamageFlags.DAMAGE_FLAG_BYPASSES_ADJUST = 1
DamageFlags[DamageFlags.DAMAGE_FLAG_BYPASSES_ADJUST] = "DAMAGE_FLAG_BYPASSES_ADJUST"
DamageFlags.DAMAGE_FLAG_REFLECTION = 2
DamageFlags[DamageFlags.DAMAGE_FLAG_REFLECTION] = "DAMAGE_FLAG_REFLECTION"
DamageFlags.DAMAGE_FLAG_HPLOSS = 4
DamageFlags[DamageFlags.DAMAGE_FLAG_HPLOSS] = "DAMAGE_FLAG_HPLOSS"
DamageFlags.DAMAGE_FLAG_NO_LETHAL = 8
DamageFlags[DamageFlags.DAMAGE_FLAG_NO_LETHAL] = "DAMAGE_FLAG_NO_LETHAL"
DamageFlags.DAMAGE_FLAG_NO_CRIT = 16
DamageFlags[DamageFlags.DAMAGE_FLAG_NO_CRIT] = "DAMAGE_FLAG_NO_CRIT"
DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING = 32
DamageFlags[DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING] = "DAMAGE_FLAG_NO_DAMAGE_OUTGOING"
DamageFlags.DAMAGE_FLAG_NO_DAMAGE_INCOMING = 64
DamageFlags[DamageFlags.DAMAGE_FLAG_NO_DAMAGE_INCOMING] = "DAMAGE_FLAG_NO_DAMAGE_INCOMING"
DamageFlags.DAMAGE_FLAG_NO_LIFESTEAL = 128
DamageFlags[DamageFlags.DAMAGE_FLAG_NO_LIFESTEAL] = "DAMAGE_FLAG_NO_LIFESTEAL"
DamageFlags.DAMAGE_FLAG_NO_EVASION = 256
DamageFlags[DamageFlags.DAMAGE_FLAG_NO_EVASION] = "DAMAGE_FLAG_NO_EVASION"
DamageFlags.DAMAGE_FLAG_NO_EXTRA = 512
DamageFlags[DamageFlags.DAMAGE_FLAG_NO_EXTRA] = "DAMAGE_FLAG_NO_EXTRA"
DamageFlags.DAMAGE_FLAG_KEZ = 1024
DamageFlags[DamageFlags.DAMAGE_FLAG_KEZ] = "DAMAGE_FLAG_KEZ"
DamageFlags.DAMAGE_FLAG_KEEP_INJURY_COUNT = 2048
DamageFlags[DamageFlags.DAMAGE_FLAG_KEEP_INJURY_COUNT] = "DAMAGE_FLAG_KEEP_INJURY_COUNT"
DamageFlags.DAMAGE_FLAG_IGNORE_BLOCK = 4096
DamageFlags[DamageFlags.DAMAGE_FLAG_IGNORE_BLOCK] = "DAMAGE_FLAG_IGNORE_BLOCK"
DamageFlags.DAMAGE_FLAG_NO_EVASION_DAMAGE_INCOMING = 8192
DamageFlags[DamageFlags.DAMAGE_FLAG_NO_EVASION_DAMAGE_INCOMING] = "DAMAGE_FLAG_NO_EVASION_DAMAGE_INCOMING"
DamageFlags.DAMAGE_FLAG_PURE_INCOMING = 16384
DamageFlags[DamageFlags.DAMAGE_FLAG_PURE_INCOMING] = "DAMAGE_FLAG_PURE_INCOMING"
DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK = 32768
DamageFlags[DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK] = "DAMAGE_FLAG_SPECIAL_ATTACK"
DamageFlags.DAMAGE_FLAG_IGNORE_AVOID_DAMAGE = 65536
DamageFlags[DamageFlags.DAMAGE_FLAG_IGNORE_AVOID_DAMAGE] = "DAMAGE_FLAG_IGNORE_AVOID_DAMAGE"
DamageFlags.DAMAGE_FLAG_IGNORE_CHAOS_EXTRA = 131072
DamageFlags[DamageFlags.DAMAGE_FLAG_IGNORE_CHAOS_EXTRA] = "DAMAGE_FLAG_IGNORE_CHAOS_EXTRA"
HealFlags = HealFlags or {}
HealFlags.HEAL_FLAG_NONE = 0
HealFlags[HealFlags.HEAL_FLAG_NONE] = "HEAL_FLAG_NONE"
HealFlags.HEAL_FLAG_IGNORE_ADJUST = 1
HealFlags[HealFlags.HEAL_FLAG_IGNORE_ADJUST] = "HEAL_FLAG_IGNORE_ADJUST"
HealFlags.HEAL_FLAG_RAIN = 2
HealFlags[HealFlags.HEAL_FLAG_RAIN] = "HEAL_FLAG_RAIN"
HealFlags.HEAL_FLAG_IGNORE_DISTURB = 4
HealFlags[HealFlags.HEAL_FLAG_IGNORE_DISTURB] = "HEAL_FLAG_IGNORE_DISTURB"
HealFlags.HEAL_FLAG_LIFESETEAL = 8
HealFlags[HealFlags.HEAL_FLAG_LIFESETEAL] = "HEAL_FLAG_LIFESETEAL"
HealFlags.HEAL_FLAG_ABILITY_LIFESETEAL = 16
HealFlags[HealFlags.HEAL_FLAG_ABILITY_LIFESETEAL] = "HEAL_FLAG_ABILITY_LIFESETEAL"
ShieldFlags = ShieldFlags or {}
ShieldFlags.FLAG_NONE = 0
ShieldFlags[ShieldFlags.FLAG_NONE] = "FLAG_NONE"
ShieldFlags.FLAG_NO_EXTRA = 1
ShieldFlags[ShieldFlags.FLAG_NO_EXTRA] = "FLAG_NO_EXTRA"
ShieldFlags.FLAG_IGNORE_BONUS = 2
ShieldFlags[ShieldFlags.FLAG_IGNORE_BONUS] = "FLAG_IGNORE_BONUS"
PoisonFlags = PoisonFlags or {}
PoisonFlags.POISON_FLAG_NONE = 0
PoisonFlags[PoisonFlags.POISON_FLAG_NONE] = "POISON_FLAG_NONE"
PoisonFlags.POISON_FLAG_IGNORE_ADJUST = 1
PoisonFlags[PoisonFlags.POISON_FLAG_IGNORE_ADJUST] = "POISON_FLAG_IGNORE_ADJUST"
PoisonFlags.POISON_FLAG_NO_EXTRA = 2
PoisonFlags[PoisonFlags.POISON_FLAG_NO_EXTRA] = "POISON_FLAG_NO_EXTRA"
IceFlags = IceFlags or {}
IceFlags.ICE_FLAG_NONE = 0
IceFlags[IceFlags.ICE_FLAG_NONE] = "ICE_FLAG_NONE"
IceFlags.ICE_FLAG_NO_EXTRA = 1
IceFlags[IceFlags.ICE_FLAG_NO_EXTRA] = "ICE_FLAG_NO_EXTRA"
InjuryFlags = InjuryFlags or {}
InjuryFlags.INJURY_FLAG_NONE = 0
InjuryFlags[InjuryFlags.INJURY_FLAG_NONE] = "INJURY_FLAG_NONE"
InjuryFlags.INJURY_FLAG_NO_EXTRA = 1
InjuryFlags[InjuryFlags.INJURY_FLAG_NO_EXTRA] = "INJURY_FLAG_NO_EXTRA"
PROJECTILE_SPEED_SLOW = 600
PROJECTILE_SPEED_NORMAL = 1200
PROJECTILE_SPEED_FAST = 1800
BOT_HARD = { hard = { [0] = 10, [10] = 20, [20] = 30 }, hard1 = { [0] = 10, [10] = 20, [20] = 50 }, hard2 = {
	[0] = 20,
	[10] = 50,
	[20] = 100,
} }
BOT_LUCK = { hard = 20, hard1 = 50, hard2 = 80 }
ITEM_ATTRIBUTE = {
	"item_counter_critcal_chance",
	"item_ability_life_steal",
	"item_reduce",
	"item_health",
	"item_ulti_power",
	"item_attackspeed",
	"item_physical_armor",
	"item_magical_armor",
	"item_mana_regen",
	"item_attack",
	"item_attack_pct",
	"item_physical_damage",
	"item_magical_damage",
	"item_damage",
	"item_fury_count",
	"item_ice_count",
	"item_shield_count",
	"item_injury_count",
	"item_poison_count",
	"item_permanent_fury",
	"item_permanent_ice",
	"item_permanent_shield",
	"item_permanent_injury",
	"item_permanent_poison",
	"item_poison_damage",
	"item_permanent_chaos",
	"item_regen",
	"item_crit",
	"item_crit_damage",
	"item_evade",
	"item_wisp_regen",
	"item_wisp_health",
	"item_wisp_interval",
	"item_lifesteal",
	"item_evade_damage",
	"item_chaos_count",
	"item_chaos_damage_bonus",
	"item_state_resistance",
}
FORGE_FRAGMENT_REWARD = { buy = 1, legendary = 5, maxlevel = 3, levelup = 5 }
FORGE_ATTRIBUTE_VALUES = {
	item_health = 80,
	item_wisp_health = 80,
	item_attack = 10,
	item_damage = 10,
	item_physical_damage = 10,
	item_magical_damage = 10,
	item_ulti_power = 10,
	item_crit_damage = 10,
	item_chaos_damage_bonus = 10,
	item_permanent_fury = 10,
	item_permanent_ice = 10,
	item_attackspeed = 5,
	item_lifesteal = 5,
	item_ability_life_steal = 5,
	item_evade = 5,
	item_counter_critcal_chance = 5,
	item_state_resistance = 5,
	item_physical_armor = 5,
	item_magical_armor = 5,
	item_crit = 5,
	item_evade_damage = 5,
	item_permanent_shield = 4,
	item_permanent_injury = 4,
	item_permanent_poison = 4,
	item_permanent_chaos = 4,
	item_regen = 4,
	item_wisp_regen = 4,
	item_poison_damage = 4,
	item_reduce = 4,
	item_fury_count = 3,
	item_ice_count = 3,
	item_shield_count = 3,
	item_injury_count = 3,
	item_poison_count = 3,
	item_chaos_count = 3,
	item_mana_regen = 2,
	item_wisp_interval = 1,
}
FORGE_ATTRIBUTE_EXCLUDE = {}
SPECIALLY_PROPERTY_OPERATION = { item_evasion = SubtractionMultiplicationPercentage }
BUNNY_MODEL_TYPE = BUNNY_MODEL_TYPE or {}
BUNNY_MODEL_TYPE.OTHER = 0
BUNNY_MODEL_TYPE[BUNNY_MODEL_TYPE.OTHER] = "OTHER"
BUNNY_MODEL_TYPE.EOM = 1
BUNNY_MODEL_TYPE[BUNNY_MODEL_TYPE.EOM] = "EOM"
BUNNY_MODEL_TYPE.CREEP = 2
BUNNY_MODEL_TYPE[BUNNY_MODEL_TYPE.CREEP] = "CREEP"
BUNNY_MODEL_TYPE.JINITAIMEI = 3
BUNNY_MODEL_TYPE[BUNNY_MODEL_TYPE.JINITAIMEI] = "JINITAIMEI"
BUNNY_IDLE_ANIMATION_LIST = {
	[BUNNY_MODEL_TYPE.EOM] = {
		"ACT_DOTA_IDLE",
		"ACT_DOTA_CAST_ABILITY_1",
		"ACT_DOTA_CAST_ABILITY_2",
		"ACT_DOTA_CAST_ABILITY_3",
	},
	[BUNNY_MODEL_TYPE.CREEP] = { "ACT_DOTA_IDLE", "ACT_DOTA_RELAX_LOOP" },
	[BUNNY_MODEL_TYPE.OTHER] = { "ACT_DOTA_IDLE" },
	[BUNNY_MODEL_TYPE.JINITAIMEI] = { "ACT_DOTA_IDLE" },
}
EOM_BUNNY_GROUP = {
	["models/eom/hero/tunvlang_1_5s/tunvlang_2_blue_skin.vmdl"] = "default",
	["models/eom/hero/tunvlang_1_5s/tunvlang_2_golden_skin.vmdl"] = "default",
	["models/eom/hero/tunvlang_1_5s/tunvlang_2_pink_skin.vmdl"] = "default",
	["models/eom/hero/tunvlang_1_5s/tunvlang_2_white_skin.vmdl"] = "default",
	["models/eom/hero/tunvlang_2/tunvlang_2.vmdl"] = "default",
	["models/eom/hero/tunvlang_meimo/tunvlang_meimo.vmdl"] = "meiji",
	["models/eom/hero/tunvlang_meimoblue/tunvlang_blue_meimo.vmdl"] = "meiji",
	["models/eom/hero/tunvlang_meimogreen/tunvlang_green_meimo.vmdl"] = "meiji",
	["models/eom/hero/tunvlang_meimored/tunvlang_meimored.vmdl"] = "meiji",
	["models/eom/hero/tunvlang_meimopink/tunvlang_pink_meimo.vmdl"] = "meijipink",
	["models/eom/hero/racing_girl_1/racing_girl_1.vmdl"] = "racegirl",
	["models/eom/hero/racing_girl_2/racing_girl_2.vmdl"] = "racegirl",
	["models/eom/hero/racing_girl_3/racing_girl_3.vmdl"] = "racegirl",
	["models/eom/hero/racing_girl_4/racing_girl_4.vmdl"] = "racegirl",
	["models/eom/hero/queenofpain_2/yingyuantuananim/queenofpain_2_yingyuanskin.vmdl"] = "racegirlpro",
	["models/eom/courier/jinitaimei_2/jinitaimei_yingyuan.vmdl"] = "shengdankunkun",
	["models/eom/hero/shengdan_girl_1/shengdan_girl_1.vmdl"] = "elk_girl",
	["models/eom/hero/shengdanyingyuantuan_props_1/shengdanyyt_milu_1/shengdanyyt_milu_1.vmdl"] = "elk_normal",
	["models/eom/hero/shengdanyingyuantuan_props_1/shengdanyyt_santaclaus_1/shengdanyyt_santaclaus_1.vmdl"] = "elk_normal",
	["models/eom/hero/shengdanyingyuantuan_props_1/shengdanyyt_shengdanshu_1/shengdanyyt_shengdanshu_1.vmdl"] = "elk_normal",
	["models/eom/hero/shengdanyingyuantuan_props_1/shengdanyyt_yayabaijian_1/shengdanyyt_yayabaijian_1.vmdl"] = "elk_normal",
}
BUNNY_GIRL_ANIMATION_DURATION_CONFIG = {
	meiji = { ACT_DOTA_CAST_ABILITY_1 = 4.13, ACT_DOTA_CAST_ABILITY_2 = 20 },
	meijipink = { ACT_DOTA_CAST_ABILITY_1 = 4.13, ACT_DOTA_CAST_ABILITY_2 = 20, ACT_DOTA_CAST_ABILITY_3 = 5.67 },
	default = { ACT_DOTA_CAST_ABILITY_1 = 3.2, ACT_DOTA_CAST_ABILITY_2 = 8.3, ACT_DOTA_CAST_ABILITY_3 = 5.2 },
	racegirl = { ACT_DOTA_CAST_ABILITY_1 = 16.1 },
	racegirlpro = { ACT_DOTA_CAST_ABILITY_1 = 16.1, ACT_DOTA_CAST_ABILITY_2 = 3.03, ACT_DOTA_CAST_ABILITY_3 = 5.27 },
	shengdankunkun = { ACT_DOTA_IDLE = 150 },
	elk_girl = { ACT_DOTA_CAST_ABILITY_1 = 1.5, ACT_DOTA_CAST_ABILITY_2 = 3.67, ACT_DOTA_CAST_ABILITY_3 = 8 },
	elk_normal = { ACT_DOTA_IDLE = 150 },
}
BUNNY_GIRL_IDLE_DURATION_CONFIG = { racegirlpro = 5, elk_girl = 3 }
function GetSupportGroupTypeByModelName(self, D)
	if (D or "") == "models/eom/courier/jinitaimei_2/jinitaimei_yingyuan.vmdl" then
		return BUNNY_MODEL_TYPE.JINITAIMEI
	end
	if d(D or "", "/eom/") then
		return BUNNY_MODEL_TYPE.EOM
	end
	if d(D or "", "/creeps/") then
		return BUNNY_MODEL_TYPE.CREEP
	end
	return BUNNY_MODEL_TYPE.OTHER
end
function getEOMStyleAnimationData(self, D, E, F)
	local G = F
	local H = "ACT_DOTA_IDLE"
	local I = 0
	local J = EOM_BUNNY_GROUP[D]
	if J ~= nil then
		local K = BUNNY_GIRL_ANIMATION_DURATION_CONFIG[J]
		if K ~= nil then
			local L = e(E, function(A, M)
				return type(K and K[M]) == "number"
			end)
			if #L > 0 then
				H = L[RandomInt(0, #L - 1) + 1]
				I = K[H] or 0
			end
		end
		if BUNNY_GIRL_IDLE_DURATION_CONFIG[J] ~= nil then
			G = BUNNY_GIRL_IDLE_DURATION_CONFIG[J]
		end
	end
	return { startAnimName = H, startAnimDuration = I, idleAnimDuration = G }
end
function GetSupportGroupAnimationDataByModelName(self, D, N)
	if N == nil then
		N = "ACT_DOTA_IDLE"
	end
	local O = GetSupportGroupTypeByModelName(nil, D)
	local I = 0
	local G = 0
	local H = "ACT_DOTA_IDLE"
	local P = "ACT_DOTA_IDLE"
	if O == BUNNY_MODEL_TYPE.EOM or O == BUNNY_MODEL_TYPE.JINITAIMEI then
		local F = O == BUNNY_MODEL_TYPE.EOM and 2 or 100
		local Q = getEOMStyleAnimationData(nil, D, BUNNY_IDLE_ANIMATION_LIST[BUNNY_MODEL_TYPE.EOM], F)
		H = Q.startAnimName
		I = Q.startAnimDuration
		G = Q.idleAnimDuration
	else
		local R = BUNNY_IDLE_ANIMATION_LIST[O]
		H = R[RandomInt(0, #R - 1) + 1]
		I = 1
		G = 8
		if N == "ACT_DOTA_RELAX_END" then
			I = 0
			P = "ACT_DOTA_IDLE"
		elseif N == "ACT_DOTA_RELAX_START" then
			I = 0
			P = "ACT_DOTA_RELAX_LOOP"
		elseif H == N then
			I = 0
			P = H
		else
			if H == "ACT_DOTA_RELAX_LOOP" then
				H = "ACT_DOTA_RELAX_START"
				P = "ACT_DOTA_RELAX_LOOP"
				I = 0.8
				G = 0
			elseif H == "ACT_DOTA_IDLE" then
				H = "ACT_DOTA_RELAX_END"
				I = 0.67
				G = 0
			end
		end
	end
	return { startAnimName = H, startAnimDuration = I, idleAnimName = P, idleAnimDuration = G }
end
CAMERA_CONFIG = {
	default = { distance = 1590, pitch = 60, yOffset = -340, yOffset_live = -100, distance_live = 1790 },
	close = { distance = 1270, pitch = 52, yOffset = -200, yOffset_live = -50, distance_live = 1470 },
}
COSMETIC_DEFAULT_PROJECTILE =
	"particles/econ/items/crystal_maiden/ti7_immortal_shoulder/cm_ti7_immortal_base_attack.vpcf"
COSMETIC_DEFAULT_PROJECTILE_LAUNCH_SOUND = "Hero_Melee.Miss"
COSMETIC_DEFAULT_PROJECTILE_LANDED_SOUND = "Hero_Range.Miss"
HERO_COLLECTION_COUNT = 2
CARD_EFFECT_REFRESH_COUNT = { [0] = 3, [11] = 2 }
LAND_PARTICLE_LIST = {
	bloodied_hills = "particles/eom/events/s3_territory_fx/territory_hill_blood_fx.vpcf",
	void_rift = "particles/eom/events/s3_territory_fx/territory_cranny_void_fx.vpcf",
	glacial_remnants = "particles/eom/events/s3_territory_fx/territory_sacrifice_glacier_fx.vpcf",
	silvernight_forest = "particles/eom/events/s3_territory_fx/territory_night_forest_fx.vpcf",
	druidic_plateau = "particles/eom/events/s3_territory_fx/territory_durude_highland_fx.vpcf",
	violet_plateau = "particles/eom/events/s3_territory_fx/territory_highland_violet_fx.vpcf",
	hovin_woodlands = "particles/eom/events/s3_territory_fx/territory_hoeven_forest_fx.vpcf",
	river_three_paths = "particles/eom/events/s3_territory_fx/territory_ghostdom_river_fx.vpcf",
	prison_desolation = "particles/eom/events/s3_territory_fx/territory_evil_prison_fx.vpcf",
	sunken_city = "particles/eom/events/s3_territory_fx/territory_sink_cities_fx.vpcf",
}
HERO_LOCK_DEFAULT_COUNT = 30
HERO_LOCK_EXTRA_COUNT_MAX = 10
RUNE_TASK_ROUNDS = { 1, 11 }
RUNE_TASK_AUTO_DATA = { [1] = 10, [11] = 20 }
ROOKIE_GUIDE_GAME_SECT = {
	{
		sects = {
			"sect_regen",
			"sect_health",
			"sect_attack",
			"sect_injury",
			"sect_ulti",
			"sect_poison",
			"sect_fury",
			"sect_wisp",
		},
		hero = { "omni_knight", "nevermore", "furion", "magnataur", "queenofpain", "pangolier", "viper", "luna" },
	},
	{
		sects = {
			"sect_crit",
			"sect_health",
			"sect_regen",
			"sect_shield",
			"sect_ice",
			"sect_wisp",
			"sect_poison",
			"sect_injury",
		},
		hero = { "lich", "legion_commander", "omni_knight", "furion", "queenofpain", "viper", "razor", "ursa", "tinker" },
	},
}
ROOKIE_GUIDE_HERO_CONFIG = {
	omni_knight = { talent_tree = { 1, 1, 2 }, sects = { "sect_regen" }, card = "sect_regen", trait = "trait_14" },
	nevermore = { talent_tree = { 1, 1, 1 }, sects = { "sect_attack" }, card = "sect_attack", trait = "trait_70" },
	furion = { talent_tree = { 1, 1, 2 }, sects = { "sect_wisp" }, card = "sect_wisp", trait = "trait_78" },
	magnataur = { talent_tree = { 1, 1, 1 }, sects = { "sect_health", "sect_attack" }, card = "sect_health", trait = "trait_74" },
	pangolier = { talent_tree = { 2, 2, 2 }, sects = { "sect_injury", "sect_attack" }, card = "sect_injury", trait = "trait_2" },
	viper = { talent_tree = { 2, 2, 2 }, sects = { "sect_poison" }, card = "sect_poison", trait = "trait_20" },
	luna = { talent_tree = { 2, 2, 2 }, sects = { "sect_attack" }, card = "sect_attack", trait = "trait_70" },
	life_stealer = { talent_tree = { 2, 1, 2 }, sects = { "sect_ulti", "sect_regen" }, card = "sect_regen", trait = "trait_14" },
	skywrath_mage = { talent_tree = { 2, 2, 2 }, sects = { "sect_regen" }, card = "sect_regen", trait = "trait_14" },
	queenofpain = { talent_tree = { 1, 1, 1 }, sects = { "sect_poison", "sect_health" }, card = "sect_poison", trait = "trait_32" },
	lich = { talent_tree = { 1, 1, 1 }, sects = { "sect_ice", "sect_health" }, card = "sect_ice", trait = "trait_108" },
	legion_commander = {
		talent_tree = { 1, 2, 2 },
		sects = { "sect_crit", "sect_shield", "sect_regen" },
		card = "sect_shield",
		trait = "trait_125",
	},
	razor = { talent_tree = { 1, 2, 1 }, sects = { "sect_injury", "sect_crit" }, card = "sect_injury", trait = "trait_123" },
	ursa = { talent_tree = { 1, 2, 2 }, sects = { "sect_attack", "sect_injury", "sect_health" }, card = "sect_injury", trait = "trait_7" },
	tinker = { talent_tree = { 2, 2, 2 }, sects = {}, card = "sect_regen", trait = "trait_37" },
}
ROOKIE_GUIDE_ARTIFACT = "item_artifact_32"
ARTIFACT_HEALTH_LIMIT = 40
SHARD_LEVEL_COST = { [1] = { origin = 800, min = 200 }, [2] = { origin = 1000, min = 400 } }
if GAMEPLAY_MODULE_LIST.card_effect then
	SHARD_LEVEL_COST[1].origin = 900
	SHARD_LEVEL_COST[2].origin = 1100
end
SHARD_DISCOUNT_ROUND = 50
SHARD_DISCOUNT_STREAK = 50
SHARD_DISCOUNT_CARD_EFFECT = 20
ROOKIE_GUIDE_RUNE_TASK_LIST = { "3", "5", "7", "1" }
ROOKIE_GUIDE_RUNE_TASK = "3"
function UpdateConstantConfig(self)
	CustomNetTables:SetTableValue(
		"common",
		"constant",
		{
			BUFF_VALUE = BUFF_VALUE,
			GOLD_PER_ROUND = IsTurboMode(nil) and GOLD_PER_ROUND_TURBO or GOLD_PER_ROUND,
			GOLD_BATTLE_CONFIG = getGoldBattleConfig(nil),
			GOLD_INTEREST_CONFIG = getInterestConfig(nil),
			ABILITY_COST = ABILITY_COST,
			TALENT_REQUIRE_LEVEL = TALENT_REQUIRE_LEVEL,
			SECT_ADJUST_ROUND = SECT_ADJUST_ROUND,
			NEUTRAL_REFRESH_CONFIG = NEUTRAL_REFRESH_CONFIG,
			NEW_PLAYER_MODE = NEW_PLAYER_MODE,
			HERO_SHOW_CONFIG = HERO_SHOW_CONFIG,
			NEUTRAL_LEVEL = NEUTRAL_LEVEL,
			HERO_COLLECTION_COUNT = HERO_COLLECTION_COUNT,
			TRAIT_ROUND = IsTurboMode(nil) and TRAIT_ROUND_TURBO or TRAIT_ROUND,
			CAMERA_CONFIG = CAMERA_CONFIG,
			ARTIFACT_ROUND = IsTurboMode(nil) and ARTIFACT_ROUND_TURBO or ARTIFACT_ROUND,
			NEUTRAL_ROUND = IsTurboMode(nil) and NEUTRAL_ROUND_TURBO or NEUTRAL_ROUND,
			RUNE_TASK_ROUNDS = RUNE_TASK_ROUNDS,
			HEALTH_PER_LEVEL = HEALTH_PER_LEVEL,
			GAME_STATE_CONFIG = GAME_STATE_CONFIG,
			SECT_COUNT = SECT_COUNT,
			CARD_EFFECT_REFRESH_COUNT = CARD_EFFECT_REFRESH_COUNT,
			HERO_BAN_SLOT_AMOUNTS = HERO_BAN_SLOT_AMOUNTS,
			SHARD_LEVEL_COST = SHARD_LEVEL_COST,
			RUNE_TASK_AUTO_DATA = RUNE_TASK_AUTO_DATA,
			ROOKIE_GUIDE_RUNE_TASK = ROOKIE_GUIDE_RUNE_TASK,
			ROOKIE_GUIDE_HERO_CONFIG = ROOKIE_GUIDE_HERO_CONFIG,
			ROOKIE_GUIDE_ARTIFACT = ROOKIE_GUIDE_ARTIFACT,
			GAMEPLAY_MODULE_LIST = GAMEPLAY_MODULE_LIST,
			GAME_SEASON = ServiceServer and ServiceServer.getGameSeason or GAME_SEASON,
			BATTLEPASS_SEASON = ServiceServer and ServiceServer.getBPSeason or BATTLEPASS_SEASON,
			DEFAULT_BANNED_HEROES = DEFAULT_BANNED_HEROES,
			TEAM_ABILITY_BLESS_CD_ROUNDS = TEAM_ABILITY_BLESS_CD_ROUNDS,
			FORGE_ATTRIBUTE_VALUES = FORGE_ATTRIBUTE_VALUES,
		}
	)
end
if IsServer() then
	UpdateConstantConfig(nil)
end