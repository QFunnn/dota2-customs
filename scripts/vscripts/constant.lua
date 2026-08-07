--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
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
		["381"] = 670,
		["382"] = 678,
		["383"] = 678,
		["384"] = 678,
		["385"] = 678,
		["386"] = 678,
		["387"] = 678,
		["388"] = 670,
		["389"] = 685,
		["390"] = 685,
		["391"] = 685,
		["392"] = 685,
		["393"] = 685,
		["394"] = 685,
		["395"] = 670,
		["396"] = 670,
		["397"] = 670,
		["398"] = 670,
		["399"] = 700,
		["400"] = 706,
		["401"] = 706,
		["402"] = 706,
		["403"] = 706,
		["404"] = 706,
		["405"] = 706,
		["407"] = 734,
		["408"] = 748,
		["410"] = 750,
		["412"] = 757,
		["414"] = 764,
		["416"] = 766,
		["418"] = 778,
		["419"] = 779,
		["420"] = 778,
		["421"] = 781,
		["422"] = 782,
		["423"] = 781,
		["424"] = 785,
		["426"] = 787,
		["428"] = 800,
		["430"] = 802,
		["432"] = 811,
		["434"] = 819,
		["436"] = 826,
		["438"] = 828,
		["440"] = 830,
		["442"] = 832,
		["444"] = 834,
		["446"] = 836,
		["448"] = 839,
		["450"] = 841,
		["451"] = 843,
		["452"] = 843,
		["453"] = 843,
		["454"] = 843,
		["455"] = 843,
		["456"] = 843,
		["457"] = 843,
		["458"] = 849,
		["459"] = 849,
		["460"] = 849,
		["461"] = 849,
		["462"] = 849,
		["463"] = 849,
		["464"] = 849,
		["465"] = 856,
		["466"] = 858,
		["468"] = 861,
		["470"] = 863,
		["471"] = 866,
		["472"] = 873,
		["473"] = 877,
		["474"] = 877,
		["475"] = 877,
		["476"] = 877,
		["477"] = 877,
		["478"] = 877,
		["480"] = 906,
		["481"] = 908,
		["482"] = 908,
		["483"] = 908,
		["484"] = 908,
		["485"] = 908,
		["486"] = 908,
		["487"] = 908,
		["488"] = 908,
		["489"] = 908,
		["490"] = 908,
		["491"] = 908,
		["492"] = 908,
		["493"] = 908,
		["494"] = 908,
		["495"] = 908,
		["496"] = 908,
		["497"] = 908,
		["498"] = 908,
		["499"] = 908,
		["500"] = 908,
		["501"] = 908,
		["502"] = 908,
		["503"] = 908,
		["504"] = 908,
		["505"] = 908,
		["506"] = 908,
		["507"] = 908,
		["508"] = 908,
		["509"] = 908,
		["510"] = 908,
		["511"] = 908,
		["512"] = 908,
		["513"] = 908,
		["514"] = 943,
		["515"] = 945,
		["516"] = 945,
		["517"] = 945,
		["518"] = 945,
		["519"] = 945,
		["520"] = 945,
		["521"] = 945,
		["522"] = 945,
		["523"] = 945,
		["524"] = 945,
		["525"] = 945,
		["526"] = 945,
		["527"] = 945,
		["528"] = 945,
		["529"] = 945,
		["530"] = 945,
		["531"] = 945,
		["532"] = 945,
		["533"] = 945,
		["534"] = 945,
		["535"] = 945,
		["536"] = 945,
		["537"] = 945,
		["538"] = 945,
		["539"] = 943,
		["540"] = 972,
		["541"] = 972,
		["542"] = 972,
		["543"] = 972,
		["544"] = 972,
		["545"] = 972,
		["546"] = 972,
		["547"] = 972,
		["548"] = 972,
		["549"] = 972,
		["550"] = 972,
		["551"] = 972,
		["552"] = 972,
		["553"] = 972,
		["554"] = 972,
		["555"] = 972,
		["556"] = 972,
		["557"] = 972,
		["558"] = 972,
		["559"] = 972,
		["560"] = 972,
		["561"] = 972,
		["562"] = 972,
		["563"] = 972,
		["564"] = 943,
		["565"] = 999,
		["566"] = 999,
		["567"] = 999,
		["568"] = 999,
		["569"] = 999,
		["570"] = 999,
		["571"] = 999,
		["572"] = 999,
		["573"] = 999,
		["574"] = 999,
		["575"] = 999,
		["576"] = 999,
		["577"] = 999,
		["578"] = 999,
		["579"] = 999,
		["580"] = 999,
		["581"] = 999,
		["582"] = 999,
		["583"] = 999,
		["584"] = 999,
		["585"] = 999,
		["586"] = 999,
		["587"] = 999,
		["588"] = 999,
		["589"] = 943,
		["591"] = 1028,
		["592"] = 1028,
		["593"] = 1028,
		["594"] = 1028,
		["595"] = 1028,
		["596"] = 1028,
		["597"] = 1028,
		["599"] = 1034,
		["600"] = 1035,
		["602"] = 1037,
		["603"] = 1038,
		["605"] = 1040,
		["607"] = 1042,
		["609"] = 1044,
		["611"] = 1046,
		["613"] = 1048,
		["614"] = 1049,
		["616"] = 1051,
		["617"] = 1056,
		["619"] = 1062,
		["621"] = 1080,
		["622"] = 1080,
		["623"] = 1080,
		["624"] = 1080,
		["625"] = 1080,
		["626"] = 1080,
		["627"] = 1080,
		["629"] = 1088,
		["630"] = 1088,
		["631"] = 1088,
		["632"] = 1088,
		["633"] = 1088,
		["634"] = 1088,
		["635"] = 1088,
		["637"] = 1096,
		["639"] = 1102,
		["641"] = 1111,
		["642"] = 1175,
		["643"] = 1176,
		["644"] = 1177,
		["646"] = 1179,
		["648"] = 1181,
		["649"] = 1182,
		["650"] = 1184,
		["651"] = 1189,
		["652"] = 1198,
		["653"] = 1198,
		["654"] = 1198,
		["655"] = 1198,
		["656"] = 1198,
		["657"] = 1198,
		["658"] = 1198,
		["659"] = 1198,
		["660"] = 1198,
		["661"] = 1197,
		["662"] = 1224,
		["663"] = 1224,
		["664"] = 1224,
		["665"] = 1224,
		["666"] = 1224,
		["667"] = 1224,
		["668"] = 1224,
		["669"] = 1224,
		["670"] = 1224,
		["671"] = 1197,
		["672"] = 1250,
		["673"] = 1250,
		["674"] = 1250,
		["675"] = 1250,
		["676"] = 1250,
		["677"] = 1250,
		["678"] = 1250,
		["679"] = 1250,
		["680"] = 1250,
		["681"] = 1197,
		["682"] = 1276,
		["683"] = 1276,
		["684"] = 1276,
		["685"] = 1276,
		["686"] = 1276,
		["687"] = 1276,
		["688"] = 1276,
		["689"] = 1276,
		["690"] = 1276,
		["691"] = 1197,
		["692"] = 1302,
		["693"] = 1302,
		["694"] = 1302,
		["695"] = 1302,
		["696"] = 1302,
		["697"] = 1302,
		["698"] = 1302,
		["699"] = 1302,
		["700"] = 1302,
		["701"] = 1197,
		["702"] = 1197,
		["704"] = 1330,
		["705"] = 1330,
		["706"] = 1330,
		["707"] = 1330,
		["708"] = 1330,
		["709"] = 1330,
		["710"] = 1330,
		["711"] = 1337,
		["712"] = 1337,
		["713"] = 1337,
		["714"] = 1337,
		["715"] = 1337,
		["716"] = 1337,
		["717"] = 1337,
		["718"] = 1345,
		["719"] = 1351,
		["721"] = 1353,
		["723"] = 1355,
		["724"] = 1381,
		["726"] = 1400,
		["727"] = 1400,
		["728"] = 1400,
		["729"] = 1400,
		["730"] = 1400,
		["731"] = 1400,
		["732"] = 1400,
		["733"] = 1400,
		["734"] = 1400,
		["735"] = 1400,
		["736"] = 1400,
		["737"] = 1400,
		["738"] = 1400,
		["739"] = 1400,
		["740"] = 1400,
		["741"] = 1400,
		["742"] = 1400,
		["743"] = 1400,
		["744"] = 1400,
		["745"] = 1400,
		["746"] = 1400,
		["747"] = 1400,
		["748"] = 1400,
		["749"] = 1400,
		["750"] = 1400,
		["751"] = 1400,
		["752"] = 1400,
		["753"] = 1400,
		["754"] = 1400,
		["755"] = 1400,
		["756"] = 1400,
		["757"] = 1400,
		["758"] = 1400,
		["759"] = 1400,
		["760"] = 1400,
		["761"] = 1400,
		["762"] = 1400,
		["763"] = 1400,
		["764"] = 1400,
		["765"] = 1400,
		["766"] = 1400,
		["767"] = 1400,
		["768"] = 1400,
		["769"] = 1400,
		["770"] = 1400,
		["771"] = 1400,
		["772"] = 1400,
		["773"] = 1400,
		["774"] = 1400,
		["775"] = 1400,
		["776"] = 1400,
		["777"] = 1400,
		["778"] = 1400,
		["779"] = 1400,
		["780"] = 1400,
		["781"] = 1400,
		["782"] = 1400,
		["783"] = 1400,
		["784"] = 1400,
		["785"] = 1400,
		["786"] = 1400,
		["787"] = 1400,
		["788"] = 1400,
		["789"] = 1400,
		["790"] = 1400,
		["791"] = 1400,
		["792"] = 1400,
		["793"] = 1400,
		["794"] = 1400,
		["795"] = 1400,
		["796"] = 1400,
		["797"] = 1400,
		["798"] = 1400,
		["799"] = 1400,
		["800"] = 1400,
		["801"] = 1400,
		["802"] = 1400,
		["803"] = 1400,
		["804"] = 1400,
		["805"] = 1400,
		["806"] = 1400,
		["807"] = 1400,
		["808"] = 1400,
		["809"] = 1400,
		["810"] = 1400,
		["811"] = 1400,
		["812"] = 1400,
		["813"] = 1400,
		["814"] = 1400,
		["815"] = 1400,
		["816"] = 1400,
		["817"] = 1400,
		["818"] = 1400,
		["819"] = 1400,
		["820"] = 1400,
		["821"] = 1400,
		["822"] = 1400,
		["823"] = 1400,
		["824"] = 1400,
		["825"] = 1400,
		["826"] = 1400,
		["827"] = 1400,
		["828"] = 1400,
		["829"] = 1400,
		["830"] = 1400,
		["831"] = 1400,
		["832"] = 1400,
		["833"] = 1400,
		["834"] = 1400,
		["835"] = 1400,
		["836"] = 1400,
		["837"] = 1400,
		["838"] = 1400,
		["839"] = 1400,
		["840"] = 1400,
		["841"] = 1400,
		["842"] = 1400,
		["843"] = 1400,
		["844"] = 1400,
		["845"] = 1400,
		["846"] = 1400,
		["847"] = 1400,
		["848"] = 1400,
		["849"] = 1400,
		["850"] = 1400,
		["851"] = 1400,
		["852"] = 1400,
		["853"] = 1400,
		["854"] = 1400,
		["855"] = 1400,
		["856"] = 1400,
		["857"] = 1400,
		["858"] = 1400,
		["859"] = 1400,
		["861"] = 1617,
		["863"] = 1620,
		["864"] = 1620,
		["865"] = 1620,
		["866"] = 1620,
		["867"] = 1620,
		["868"] = 1620,
		["869"] = 1620,
		["870"] = 1620,
		["871"] = 1620,
		["872"] = 1620,
		["873"] = 1620,
		["874"] = 1620,
		["875"] = 1620,
		["876"] = 1620,
		["877"] = 1620,
		["878"] = 1637,
		["879"] = 1637,
		["880"] = 1637,
		["881"] = 1637,
		["882"] = 1637,
		["883"] = 1642,
		["884"] = 1642,
		["885"] = 1642,
		["886"] = 1642,
		["887"] = 1642,
		["888"] = 1642,
		["889"] = 1642,
		["890"] = 1642,
		["891"] = 1642,
		["892"] = 1642,
		["893"] = 1642,
		["894"] = 1642,
		["895"] = 1642,
		["896"] = 1642,
		["897"] = 1642,
		["898"] = 1642,
		["899"] = 1642,
		["900"] = 1642,
		["901"] = 1642,
		["902"] = 1642,
		["903"] = 1642,
		["904"] = 1642,
		["905"] = 1642,
		["906"] = 1642,
		["907"] = 1642,
		["908"] = 1642,
		["909"] = 1642,
		["910"] = 1642,
		["911"] = 1642,
		["912"] = 1642,
		["913"] = 1642,
		["914"] = 1642,
		["915"] = 1642,
		["916"] = 1642,
		["917"] = 1642,
		["918"] = 1642,
		["919"] = 1642,
		["920"] = 1642,
		["921"] = 1642,
		["922"] = 1683,
		["923"] = 1683,
		["924"] = 1683,
		["925"] = 1683,
		["926"] = 1683,
		["927"] = 1683,
		["928"] = 1683,
		["929"] = 1683,
		["930"] = 1683,
		["931"] = 1683,
		["932"] = 1683,
		["933"] = 1683,
		["934"] = 1683,
		["935"] = 1698,
		["936"] = 1698,
		["937"] = 1698,
		["938"] = 1698,
		["939"] = 1698,
		["940"] = 1698,
		["941"] = 1698,
		["942"] = 1707,
		["943"] = 1707,
		["944"] = 1707,
		["945"] = 1707,
		["946"] = 1707,
		["947"] = 1707,
		["948"] = 1707,
		["950"] = 1717,
		["951"] = 1718,
		["952"] = 1719,
		["954"] = 1722,
		["956"] = 1740,
		["958"] = 1747,
		["959"] = 1747,
		["960"] = 1747,
		["961"] = 1747,
		["962"] = 1747,
		["963"] = 1747,
		["964"] = 1747,
		["965"] = 1747,
		["966"] = 1747,
		["967"] = 1747,
		["968"] = 1747,
		["969"] = 1747,
		["970"] = 1747,
		["971"] = 1747,
		["972"] = 1747,
		["973"] = 1747,
		["974"] = 1747,
		["975"] = 1747,
		["976"] = 1747,
		["977"] = 1747,
		["978"] = 1747,
		["979"] = 1747,
		["980"] = 1747,
		["981"] = 1747,
		["982"] = 1747,
		["983"] = 1747,
		["984"] = 1747,
		["985"] = 1747,
		["986"] = 1747,
		["987"] = 1747,
		["988"] = 1747,
		["989"] = 1747,
		["990"] = 1747,
		["991"] = 1747,
		["992"] = 1747,
		["993"] = 1747,
		["994"] = 1747,
		["995"] = 1747,
		["996"] = 1747,
		["997"] = 1747,
		["999"] = 1826,
		["1002"] = 1832,
		["1003"] = 1832,
		["1004"] = 1832,
		["1005"] = 1832,
		["1006"] = 1832,
		["1007"] = 1832,
		["1008"] = 1832,
		["1009"] = 1832,
		["1010"] = 1832,
		["1011"] = 1832,
		["1012"] = 1832,
		["1013"] = 1832,
		["1014"] = 1832,
		["1015"] = 1832,
		["1016"] = 1832,
		["1017"] = 1832,
		["1018"] = 1832,
		["1019"] = 1832,
		["1020"] = 1832,
		["1021"] = 1832,
		["1022"] = 1832,
		["1023"] = 1832,
		["1024"] = 1832,
		["1025"] = 1832,
		["1026"] = 1832,
		["1027"] = 1832,
		["1028"] = 1832,
		["1029"] = 1832,
		["1030"] = 1832,
		["1031"] = 1832,
		["1032"] = 1832,
		["1033"] = 1832,
		["1034"] = 1832,
		["1035"] = 1832,
		["1036"] = 1832,
		["1037"] = 1832,
		["1038"] = 1832,
		["1039"] = 1832,
		["1040"] = 1832,
		["1043"] = 1882,
		["1045"] = 1885,
		["1048"] = 1897,
		["1049"] = 1897,
		["1050"] = 1897,
		["1051"] = 1897,
		["1052"] = 1897,
		["1053"] = 1897,
		["1054"] = 1897,
		["1055"] = 1897,
		["1056"] = 1897,
		["1059"] = 1908,
		["1062"] = 1923,
		["1063"] = 1923,
		["1064"] = 1923,
		["1065"] = 1923,
		["1066"] = 1923,
		["1067"] = 1923,
		["1068"] = 1923,
		["1069"] = 1923,
		["1070"] = 1923,
		["1071"] = 1923,
		["1072"] = 1923,
		["1073"] = 1923,
		["1074"] = 1923,
		["1075"] = 1923,
		["1076"] = 1923,
		["1077"] = 1923,
		["1078"] = 1923,
		["1079"] = 1923,
		["1080"] = 1923,
		["1081"] = 1923,
		["1082"] = 1923,
		["1083"] = 1923,
		["1084"] = 1923,
		["1090"] = 1965,
		["1091"] = 1965,
		["1092"] = 1965,
		["1093"] = 1965,
		["1094"] = 1965,
		["1095"] = 1965,
		["1096"] = 1965,
		["1097"] = 1965,
		["1098"] = 1965,
		["1099"] = 1965,
		["1103"] = 2006,
		["1108"] = 2016,
		["1109"] = 2018,
		["1110"] = 2019,
		["1112"] = 2022,
		["1113"] = 2023,
		["1115"] = 2026,
		["1116"] = 2027,
		["1118"] = 2030,
		["1119"] = 2016,
		["1126"] = 2040,
		["1127"] = 2041,
		["1128"] = 2042,
		["1129"] = 2043,
		["1130"] = 2045,
		["1131"] = 2046,
		["1132"] = 2047,
		["1133"] = 2048,
		["1134"] = 2050,
		["1135"] = 2050,
		["1136"] = 2050,
		["1137"] = 2050,
		["1138"] = 2051,
		["1139"] = 2052,
		["1140"] = 2053,
		["1143"] = 2056,
		["1144"] = 2057,
		["1147"] = 2061,
		["1148"] = 2040,
		["1160"] = 2076,
		["1161"] = 2076,
		["1162"] = 2076,
		["1164"] = 2077,
		["1165"] = 2078,
		["1166"] = 2079,
		["1167"] = 2080,
		["1168"] = 2081,
		["1169"] = 2084,
		["1170"] = 2085,
		["1171"] = 2086,
		["1172"] = 2087,
		["1173"] = 2088,
		["1174"] = 2089,
		["1176"] = 2093,
		["1177"] = 2094,
		["1178"] = 2095,
		["1179"] = 2096,
		["1180"] = 2099,
		["1181"] = 2101,
		["1182"] = 2102,
		["1183"] = 2103,
		["1184"] = 2105,
		["1185"] = 2106,
		["1186"] = 2107,
		["1187"] = 2109,
		["1188"] = 2110,
		["1190"] = 2113,
		["1191"] = 2115,
		["1192"] = 2116,
		["1193"] = 2117,
		["1194"] = 2118,
		["1195"] = 2119,
		["1196"] = 2121,
		["1197"] = 2122,
		["1198"] = 2123,
		["1202"] = 2128,
		["1203"] = 2076,
		["1205"] = 2137,
		["1206"] = 2138,
		["1207"] = 2138,
		["1208"] = 2138,
		["1209"] = 2138,
		["1210"] = 2138,
		["1211"] = 2137,
		["1212"] = 2145,
		["1213"] = 2145,
		["1214"] = 2145,
		["1215"] = 2145,
		["1216"] = 2145,
		["1217"] = 2137,
		["1218"] = 2157,
		["1219"] = 2158,
		["1220"] = 2159,
		["1221"] = 2162,
		["1223"] = 2164,
		["1236"] = 2181,
		["1237"] = 2181,
		["1238"] = 2181,
		["1239"] = 2181,
		["1240"] = 2181,
		["1241"] = 2181,
		["1242"] = 2181,
		["1243"] = 2181,
		["1244"] = 2181,
		["1245"] = 2181,
		["1246"] = 2181,
		["1247"] = 2181,
		["1249"] = 2195,
		["1250"] = 2196,
		["1252"] = 2199,
		["1253"] = 2201,
		["1255"] = 2208,
		["1256"] = 2210,
		["1257"] = 2210,
		["1258"] = 2210,
		["1259"] = 2210,
		["1260"] = 2210,
		["1261"] = 2210,
		["1262"] = 2210,
		["1263"] = 2210,
		["1264"] = 2209,
		["1265"] = 2211,
		["1266"] = 2211,
		["1267"] = 2211,
		["1268"] = 2211,
		["1269"] = 2211,
		["1270"] = 2211,
		["1271"] = 2211,
		["1272"] = 2211,
		["1273"] = 2208,
		["1274"] = 2214,
		["1275"] = 2214,
		["1276"] = 2214,
		["1277"] = 2214,
		["1278"] = 2214,
		["1279"] = 2214,
		["1280"] = 2214,
		["1281"] = 2214,
		["1282"] = 2213,
		["1283"] = 2215,
		["1284"] = 2215,
		["1285"] = 2215,
		["1286"] = 2215,
		["1287"] = 2215,
		["1288"] = 2215,
		["1289"] = 2215,
		["1290"] = 2215,
		["1291"] = 2215,
		["1292"] = 2208,
		["1297"] = 2224,
		["1298"] = 2232,
		["1299"] = 2232,
		["1300"] = 2232,
		["1301"] = 2232,
		["1302"] = 2232,
		["1303"] = 2232,
		["1304"] = 2232,
		["1305"] = 2232,
		["1306"] = 2232,
		["1307"] = 2232,
		["1308"] = 2232,
		["1309"] = 2232,
		["1310"] = 2232,
		["1311"] = 2232,
		["1312"] = 2232,
		["1313"] = 2232,
		["1314"] = 2331,
		["1315"] = 2332,
		["1316"] = 2336,
		["1317"] = 2352,
		["1318"] = 2353,
		["1319"] = 2354,
		["1321"] = 2357,
		["1322"] = 2359,
		["1323"] = 2361,
		["1325"] = 2364,
		["1326"] = 2365,
		["1330"] = 2371,
		["1331"] = 2372,
		["1332"] = 2372,
		["1333"] = 2372,
		["1334"] = 2372,
		["1335"] = 2372,
		["1336"] = 2372,
		["1337"] = 2372,
		["1338"] = 2372,
		["1339"] = 2372,
		["1340"] = 2372,
		["1341"] = 2372,
		["1342"] = 2372,
		["1343"] = 2372,
		["1344"] = 2372,
		["1345"] = 2372,
		["1346"] = 2372,
		["1347"] = 2372,
		["1348"] = 2372,
		["1349"] = 2372,
		["1350"] = 2372,
		["1351"] = 2372,
		["1352"] = 2372,
		["1353"] = 2372,
		["1354"] = 2372,
		["1355"] = 2372,
		["1356"] = 2372,
		["1357"] = 2372,
		["1358"] = 2372,
		["1359"] = 2372,
		["1360"] = 2372,
		["1361"] = 2372,
		["1362"] = 2372,
		["1363"] = 2372,
		["1364"] = 2372,
		["1365"] = 2372,
		["1366"] = 2372,
		["1367"] = 2372,
		["1368"] = 2372,
		["1369"] = 2372,
		["1370"] = 2371,
		["1371"] = 2408,
		["1372"] = 2409,
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
	[7024] = { red_envelope_id = 1100127, limit = 600, state = false },
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
	BaseDamage = { [1] = 2, [10] = 2, [15] = 3, [20] = 3, [25] = 4 },
	MaxDamage = { [1] = 6, [10] = 8, [15] = 10, [20] = 15, [25] = 50 },
	LevelDamage = { [5] = 1, [10] = 2, [15] = 2, [20] = 3, [25] = 4 },
	WinDamage = 1,
	MaxWinDamage = { [1] = 4, [10] = 4, [15] = 4 },
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