--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
		["36"] = 64,
		["37"] = 67,
		["38"] = 68,
		["39"] = 69,
		["40"] = 67,
		["41"] = 73,
		["42"] = 73,
		["43"] = 73,
		["44"] = 73,
		["45"] = 73,
		["46"] = 73,
		["47"] = 73,
		["48"] = 78,
		["50"] = 83,
		["52"] = 85,
		["54"] = 87,
		["56"] = 89,
		["58"] = 95,
		["60"] = 97,
		["61"] = 99,
		["62"] = 101,
		["63"] = 102,
		["64"] = 103,
		["65"] = 104,
		["66"] = 105,
		["67"] = 107,
		["68"] = 108,
		["70"] = 110,
		["71"] = 111,
		["72"] = 113,
		["73"] = 114,
		["74"] = 115,
		["75"] = 116,
		["76"] = 118,
		["77"] = 119,
		["78"] = 122,
		["79"] = 124,
		["80"] = 125,
		["81"] = 126,
		["82"] = 128,
		["83"] = 130,
		["84"] = 131,
		["85"] = 133,
		["86"] = 135,
		["87"] = 137,
		["88"] = 140,
		["89"] = 147,
		["90"] = 148,
		["91"] = 152,
		["92"] = 155,
		["93"] = 156,
		["94"] = 157,
		["95"] = 160,
		["96"] = 161,
		["97"] = 162,
		["98"] = 163,
		["99"] = 164,
		["102"] = 168,
		["103"] = 168,
		["104"] = 168,
		["105"] = 168,
		["106"] = 168,
		["107"] = 168,
		["108"] = 168,
		["109"] = 168,
		["111"] = 178,
		["112"] = 179,
		["114"] = 182,
		["115"] = 183,
		["116"] = 184,
		["117"] = 187,
		["118"] = 190,
		["119"] = 191,
		["120"] = 192,
		["121"] = 193,
		["122"] = 194,
		["123"] = 195,
		["124"] = 207,
		["125"] = 208,
		["126"] = 209,
		["128"] = 212,
		["130"] = 214,
		["132"] = 216,
		["134"] = 218,
		["135"] = 220,
		["136"] = 220,
		["137"] = 220,
		["138"] = 220,
		["139"] = 220,
		["140"] = 225,
		["141"] = 225,
		["142"] = 225,
		["143"] = 225,
		["144"] = 225,
		["145"] = 225,
		["146"] = 225,
		["147"] = 225,
		["148"] = 225,
		["149"] = 225,
		["150"] = 225,
		["151"] = 248,
		["152"] = 248,
		["153"] = 248,
		["154"] = 248,
		["155"] = 248,
		["157"] = 276,
		["158"] = 278,
		["159"] = 278,
		["160"] = 278,
		["161"] = 278,
		["162"] = 278,
		["163"] = 276,
		["165"] = 328,
		["166"] = 329,
		["167"] = 330,
		["168"] = 331,
		["169"] = 332,
		["170"] = 334,
		["171"] = 335,
		["172"] = 336,
		["173"] = 337,
		["174"] = 338,
		["176"] = 340,
		["177"] = 340,
		["178"] = 341,
		["179"] = 342,
		["181"] = 343,
		["182"] = 344,
		["185"] = 345,
		["186"] = 346,
		["190"] = 349,
		["193"] = 350,
		["194"] = 351,
		["198"] = 354,
		["201"] = 355,
		["202"] = 356,
		["206"] = 359,
		["209"] = 360,
		["210"] = 361,
		["215"] = 365,
		["216"] = 366,
		["217"] = 340,
		["221"] = 368,
		["222"] = 368,
		["223"] = 369,
		["224"] = 370,
		["226"] = 371,
		["227"] = 372,
		["230"] = 373,
		["231"] = 374,
		["235"] = 377,
		["238"] = 378,
		["239"] = 379,
		["243"] = 382,
		["246"] = 383,
		["247"] = 384,
		["251"] = 387,
		["254"] = 388,
		["255"] = 389,
		["259"] = 392,
		["262"] = 393,
		["263"] = 394,
		["268"] = 398,
		["269"] = 399,
		["270"] = 368,
		["275"] = 406,
		["276"] = 406,
		["277"] = 406,
		["278"] = 406,
		["279"] = 406,
		["280"] = 406,
		["281"] = 406,
		["282"] = 406,
		["283"] = 406,
		["284"] = 406,
		["285"] = 406,
		["287"] = 441,
		["289"] = 445,
		["290"] = 445,
		["291"] = 445,
		["292"] = 445,
		["293"] = 445,
		["294"] = 445,
		["295"] = 445,
		["296"] = 445,
		["297"] = 445,
		["298"] = 445,
		["299"] = 479,
		["300"] = 479,
		["301"] = 479,
		["302"] = 479,
		["303"] = 479,
		["304"] = 479,
		["305"] = 445,
		["306"] = 445,
		["307"] = 445,
		["308"] = 445,
		["309"] = 445,
		["310"] = 445,
		["311"] = 445,
		["312"] = 445,
		["313"] = 445,
		["314"] = 445,
		["315"] = 445,
		["316"] = 445,
		["317"] = 445,
		["318"] = 445,
		["319"] = 543,
		["320"] = 543,
		["321"] = 543,
		["322"] = 543,
		["323"] = 543,
		["324"] = 543,
		["325"] = 543,
		["327"] = 549,
		["328"] = 550,
		["330"] = 552,
		["331"] = 557,
		["333"] = 563,
		["334"] = 571,
		["335"] = 579,
		["336"] = 580,
		["337"] = 579,
		["338"] = 583,
		["339"] = 585,
		["340"] = 587,
		["342"] = 594,
		["343"] = 594,
		["344"] = 594,
		["345"] = 594,
		["346"] = 594,
		["347"] = 594,
		["348"] = 594,
		["349"] = 594,
		["350"] = 594,
		["351"] = 609,
		["352"] = 609,
		["353"] = 609,
		["354"] = 609,
		["355"] = 609,
		["356"] = 609,
		["357"] = 609,
		["358"] = 609,
		["359"] = 609,
		["360"] = 625,
		["361"] = 626,
		["362"] = 625,
		["364"] = 652,
		["365"] = 659,
		["366"] = 659,
		["367"] = 659,
		["368"] = 659,
		["369"] = 659,
		["370"] = 659,
		["371"] = 658,
		["372"] = 666,
		["373"] = 666,
		["374"] = 666,
		["375"] = 666,
		["376"] = 666,
		["377"] = 666,
		["378"] = 658,
		["379"] = 673,
		["380"] = 673,
		["381"] = 673,
		["382"] = 673,
		["383"] = 673,
		["384"] = 673,
		["385"] = 658,
		["386"] = 658,
		["387"] = 658,
		["388"] = 658,
		["389"] = 688,
		["390"] = 694,
		["391"] = 694,
		["392"] = 694,
		["393"] = 694,
		["394"] = 694,
		["395"] = 694,
		["397"] = 722,
		["398"] = 736,
		["400"] = 738,
		["402"] = 745,
		["404"] = 752,
		["406"] = 754,
		["408"] = 766,
		["409"] = 767,
		["410"] = 766,
		["411"] = 769,
		["412"] = 770,
		["413"] = 769,
		["414"] = 773,
		["416"] = 775,
		["418"] = 788,
		["420"] = 790,
		["422"] = 799,
		["424"] = 807,
		["426"] = 814,
		["428"] = 816,
		["430"] = 818,
		["432"] = 820,
		["434"] = 822,
		["436"] = 824,
		["438"] = 827,
		["440"] = 829,
		["441"] = 831,
		["442"] = 831,
		["443"] = 831,
		["444"] = 831,
		["445"] = 831,
		["446"] = 831,
		["447"] = 831,
		["448"] = 837,
		["449"] = 837,
		["450"] = 837,
		["451"] = 837,
		["452"] = 837,
		["453"] = 837,
		["454"] = 837,
		["455"] = 844,
		["456"] = 846,
		["458"] = 849,
		["460"] = 851,
		["461"] = 854,
		["462"] = 861,
		["463"] = 865,
		["464"] = 865,
		["465"] = 865,
		["466"] = 865,
		["467"] = 865,
		["468"] = 865,
		["470"] = 894,
		["471"] = 896,
		["472"] = 896,
		["473"] = 896,
		["474"] = 896,
		["475"] = 896,
		["476"] = 896,
		["477"] = 896,
		["478"] = 896,
		["479"] = 896,
		["480"] = 896,
		["481"] = 896,
		["482"] = 896,
		["483"] = 896,
		["484"] = 896,
		["485"] = 896,
		["486"] = 896,
		["487"] = 896,
		["488"] = 896,
		["489"] = 896,
		["490"] = 896,
		["491"] = 896,
		["492"] = 896,
		["493"] = 896,
		["494"] = 896,
		["495"] = 896,
		["496"] = 896,
		["497"] = 896,
		["498"] = 896,
		["499"] = 896,
		["500"] = 896,
		["501"] = 896,
		["502"] = 896,
		["503"] = 896,
		["504"] = 931,
		["505"] = 933,
		["506"] = 933,
		["507"] = 933,
		["508"] = 933,
		["509"] = 933,
		["510"] = 933,
		["511"] = 933,
		["512"] = 933,
		["513"] = 933,
		["514"] = 933,
		["515"] = 933,
		["516"] = 933,
		["517"] = 933,
		["518"] = 933,
		["519"] = 933,
		["520"] = 933,
		["521"] = 933,
		["522"] = 933,
		["523"] = 933,
		["524"] = 933,
		["525"] = 933,
		["526"] = 933,
		["527"] = 933,
		["528"] = 933,
		["529"] = 931,
		["530"] = 960,
		["531"] = 960,
		["532"] = 960,
		["533"] = 960,
		["534"] = 960,
		["535"] = 960,
		["536"] = 960,
		["537"] = 960,
		["538"] = 960,
		["539"] = 960,
		["540"] = 960,
		["541"] = 960,
		["542"] = 960,
		["543"] = 960,
		["544"] = 960,
		["545"] = 960,
		["546"] = 960,
		["547"] = 960,
		["548"] = 960,
		["549"] = 960,
		["550"] = 960,
		["551"] = 960,
		["552"] = 960,
		["553"] = 960,
		["554"] = 931,
		["555"] = 987,
		["556"] = 987,
		["557"] = 987,
		["558"] = 987,
		["559"] = 987,
		["560"] = 987,
		["561"] = 987,
		["562"] = 987,
		["563"] = 987,
		["564"] = 987,
		["565"] = 987,
		["566"] = 987,
		["567"] = 987,
		["568"] = 987,
		["569"] = 987,
		["570"] = 987,
		["571"] = 987,
		["572"] = 987,
		["573"] = 987,
		["574"] = 987,
		["575"] = 987,
		["576"] = 987,
		["577"] = 987,
		["578"] = 987,
		["579"] = 931,
		["581"] = 1016,
		["582"] = 1016,
		["583"] = 1016,
		["584"] = 1016,
		["585"] = 1016,
		["586"] = 1016,
		["587"] = 1016,
		["589"] = 1022,
		["590"] = 1023,
		["592"] = 1025,
		["593"] = 1026,
		["595"] = 1028,
		["597"] = 1030,
		["599"] = 1032,
		["601"] = 1034,
		["603"] = 1036,
		["604"] = 1037,
		["606"] = 1039,
		["607"] = 1044,
		["609"] = 1050,
		["611"] = 1068,
		["612"] = 1068,
		["613"] = 1068,
		["614"] = 1068,
		["615"] = 1068,
		["616"] = 1068,
		["617"] = 1068,
		["619"] = 1076,
		["620"] = 1076,
		["621"] = 1076,
		["622"] = 1076,
		["623"] = 1076,
		["624"] = 1076,
		["625"] = 1076,
		["627"] = 1084,
		["629"] = 1090,
		["631"] = 1099,
		["632"] = 1163,
		["633"] = 1164,
		["634"] = 1165,
		["636"] = 1168,
		["637"] = 1169,
		["638"] = 1171,
		["639"] = 1176,
		["640"] = 1185,
		["641"] = 1185,
		["642"] = 1185,
		["643"] = 1185,
		["644"] = 1185,
		["645"] = 1185,
		["646"] = 1185,
		["647"] = 1185,
		["648"] = 1185,
		["649"] = 1184,
		["650"] = 1211,
		["651"] = 1211,
		["652"] = 1211,
		["653"] = 1211,
		["654"] = 1211,
		["655"] = 1211,
		["656"] = 1211,
		["657"] = 1211,
		["658"] = 1211,
		["659"] = 1184,
		["660"] = 1237,
		["661"] = 1237,
		["662"] = 1237,
		["663"] = 1237,
		["664"] = 1237,
		["665"] = 1237,
		["666"] = 1237,
		["667"] = 1237,
		["668"] = 1237,
		["669"] = 1184,
		["670"] = 1263,
		["671"] = 1263,
		["672"] = 1263,
		["673"] = 1263,
		["674"] = 1263,
		["675"] = 1263,
		["676"] = 1263,
		["677"] = 1263,
		["678"] = 1263,
		["679"] = 1184,
		["680"] = 1289,
		["681"] = 1289,
		["682"] = 1289,
		["683"] = 1289,
		["684"] = 1289,
		["685"] = 1289,
		["686"] = 1289,
		["687"] = 1289,
		["688"] = 1289,
		["689"] = 1184,
		["690"] = 1184,
		["692"] = 1317,
		["693"] = 1317,
		["694"] = 1317,
		["695"] = 1317,
		["696"] = 1317,
		["697"] = 1317,
		["698"] = 1317,
		["699"] = 1324,
		["700"] = 1324,
		["701"] = 1324,
		["702"] = 1324,
		["703"] = 1324,
		["704"] = 1324,
		["705"] = 1324,
		["706"] = 1332,
		["707"] = 1338,
		["709"] = 1340,
		["711"] = 1342,
		["712"] = 1368,
		["714"] = 1387,
		["715"] = 1387,
		["716"] = 1387,
		["717"] = 1387,
		["718"] = 1387,
		["719"] = 1387,
		["720"] = 1387,
		["721"] = 1387,
		["722"] = 1387,
		["723"] = 1387,
		["724"] = 1387,
		["725"] = 1387,
		["726"] = 1387,
		["727"] = 1387,
		["728"] = 1387,
		["729"] = 1387,
		["730"] = 1387,
		["731"] = 1387,
		["732"] = 1387,
		["733"] = 1387,
		["734"] = 1387,
		["735"] = 1387,
		["736"] = 1387,
		["737"] = 1387,
		["738"] = 1387,
		["739"] = 1387,
		["740"] = 1387,
		["741"] = 1387,
		["742"] = 1387,
		["743"] = 1387,
		["744"] = 1387,
		["745"] = 1387,
		["746"] = 1387,
		["747"] = 1387,
		["748"] = 1387,
		["749"] = 1387,
		["750"] = 1387,
		["751"] = 1387,
		["752"] = 1387,
		["753"] = 1387,
		["754"] = 1387,
		["755"] = 1387,
		["756"] = 1387,
		["757"] = 1387,
		["758"] = 1387,
		["759"] = 1387,
		["760"] = 1387,
		["761"] = 1387,
		["762"] = 1387,
		["763"] = 1387,
		["764"] = 1387,
		["765"] = 1387,
		["766"] = 1387,
		["767"] = 1387,
		["768"] = 1387,
		["769"] = 1387,
		["770"] = 1387,
		["771"] = 1387,
		["772"] = 1387,
		["773"] = 1387,
		["774"] = 1387,
		["775"] = 1387,
		["776"] = 1387,
		["777"] = 1387,
		["778"] = 1387,
		["779"] = 1387,
		["780"] = 1387,
		["781"] = 1387,
		["782"] = 1387,
		["783"] = 1387,
		["784"] = 1387,
		["785"] = 1387,
		["786"] = 1387,
		["787"] = 1387,
		["788"] = 1387,
		["789"] = 1387,
		["790"] = 1387,
		["791"] = 1387,
		["792"] = 1387,
		["793"] = 1387,
		["794"] = 1387,
		["795"] = 1387,
		["796"] = 1387,
		["797"] = 1387,
		["798"] = 1387,
		["799"] = 1387,
		["800"] = 1387,
		["801"] = 1387,
		["802"] = 1387,
		["803"] = 1387,
		["804"] = 1387,
		["805"] = 1387,
		["806"] = 1387,
		["807"] = 1387,
		["808"] = 1387,
		["809"] = 1387,
		["810"] = 1387,
		["811"] = 1387,
		["812"] = 1387,
		["813"] = 1387,
		["814"] = 1387,
		["815"] = 1387,
		["816"] = 1387,
		["817"] = 1387,
		["818"] = 1387,
		["819"] = 1387,
		["820"] = 1387,
		["821"] = 1387,
		["822"] = 1387,
		["823"] = 1387,
		["824"] = 1387,
		["825"] = 1387,
		["826"] = 1387,
		["827"] = 1387,
		["828"] = 1387,
		["829"] = 1387,
		["830"] = 1387,
		["831"] = 1387,
		["832"] = 1387,
		["833"] = 1387,
		["834"] = 1387,
		["835"] = 1387,
		["836"] = 1387,
		["837"] = 1387,
		["838"] = 1387,
		["839"] = 1387,
		["840"] = 1387,
		["841"] = 1387,
		["842"] = 1387,
		["843"] = 1387,
		["844"] = 1387,
		["845"] = 1387,
		["846"] = 1387,
		["847"] = 1387,
		["849"] = 1604,
		["851"] = 1607,
		["852"] = 1607,
		["853"] = 1607,
		["854"] = 1607,
		["855"] = 1607,
		["856"] = 1607,
		["857"] = 1607,
		["858"] = 1607,
		["859"] = 1607,
		["860"] = 1607,
		["861"] = 1607,
		["862"] = 1607,
		["863"] = 1607,
		["864"] = 1607,
		["865"] = 1607,
		["866"] = 1624,
		["867"] = 1624,
		["868"] = 1624,
		["869"] = 1624,
		["870"] = 1624,
		["871"] = 1629,
		["872"] = 1629,
		["873"] = 1629,
		["874"] = 1629,
		["875"] = 1629,
		["876"] = 1629,
		["877"] = 1629,
		["878"] = 1629,
		["879"] = 1629,
		["880"] = 1629,
		["881"] = 1629,
		["882"] = 1629,
		["883"] = 1629,
		["884"] = 1629,
		["885"] = 1629,
		["886"] = 1629,
		["887"] = 1629,
		["888"] = 1629,
		["889"] = 1629,
		["890"] = 1629,
		["891"] = 1629,
		["892"] = 1629,
		["893"] = 1629,
		["894"] = 1629,
		["895"] = 1629,
		["896"] = 1629,
		["897"] = 1629,
		["898"] = 1629,
		["899"] = 1629,
		["900"] = 1629,
		["901"] = 1629,
		["902"] = 1629,
		["903"] = 1629,
		["904"] = 1629,
		["905"] = 1629,
		["906"] = 1629,
		["907"] = 1629,
		["908"] = 1629,
		["909"] = 1629,
		["910"] = 1670,
		["911"] = 1670,
		["912"] = 1670,
		["913"] = 1670,
		["914"] = 1670,
		["915"] = 1670,
		["916"] = 1670,
		["917"] = 1670,
		["918"] = 1670,
		["919"] = 1670,
		["920"] = 1670,
		["921"] = 1670,
		["922"] = 1670,
		["923"] = 1685,
		["924"] = 1685,
		["925"] = 1685,
		["926"] = 1685,
		["927"] = 1685,
		["928"] = 1685,
		["929"] = 1685,
		["930"] = 1694,
		["931"] = 1694,
		["932"] = 1694,
		["933"] = 1694,
		["934"] = 1694,
		["935"] = 1694,
		["936"] = 1694,
		["938"] = 1704,
		["939"] = 1705,
		["940"] = 1706,
		["942"] = 1709,
		["944"] = 1727,
		["946"] = 1734,
		["947"] = 1734,
		["948"] = 1734,
		["949"] = 1734,
		["950"] = 1734,
		["951"] = 1734,
		["952"] = 1734,
		["953"] = 1734,
		["954"] = 1734,
		["955"] = 1734,
		["956"] = 1734,
		["957"] = 1734,
		["958"] = 1734,
		["959"] = 1734,
		["960"] = 1734,
		["961"] = 1734,
		["962"] = 1734,
		["963"] = 1734,
		["964"] = 1734,
		["965"] = 1734,
		["966"] = 1734,
		["967"] = 1734,
		["968"] = 1734,
		["969"] = 1734,
		["970"] = 1734,
		["971"] = 1734,
		["972"] = 1734,
		["973"] = 1734,
		["974"] = 1734,
		["975"] = 1734,
		["976"] = 1734,
		["977"] = 1734,
		["978"] = 1734,
		["979"] = 1734,
		["980"] = 1734,
		["981"] = 1734,
		["982"] = 1734,
		["983"] = 1734,
		["984"] = 1734,
		["986"] = 1812,
		["989"] = 1824,
		["990"] = 1824,
		["991"] = 1824,
		["992"] = 1824,
		["993"] = 1824,
		["994"] = 1824,
		["995"] = 1824,
		["996"] = 1824,
		["997"] = 1824,
		["1000"] = 1835,
		["1003"] = 1850,
		["1004"] = 1850,
		["1005"] = 1850,
		["1006"] = 1850,
		["1007"] = 1850,
		["1008"] = 1850,
		["1009"] = 1850,
		["1010"] = 1850,
		["1011"] = 1850,
		["1012"] = 1850,
		["1013"] = 1850,
		["1014"] = 1850,
		["1015"] = 1850,
		["1016"] = 1850,
		["1017"] = 1850,
		["1018"] = 1850,
		["1019"] = 1850,
		["1020"] = 1850,
		["1021"] = 1850,
		["1022"] = 1850,
		["1023"] = 1850,
		["1024"] = 1850,
		["1025"] = 1850,
		["1031"] = 1892,
		["1032"] = 1892,
		["1033"] = 1892,
		["1034"] = 1892,
		["1035"] = 1892,
		["1036"] = 1892,
		["1037"] = 1892,
		["1038"] = 1892,
		["1039"] = 1892,
		["1040"] = 1892,
		["1044"] = 1933,
		["1049"] = 1943,
		["1050"] = 1945,
		["1051"] = 1946,
		["1053"] = 1949,
		["1054"] = 1950,
		["1056"] = 1953,
		["1057"] = 1954,
		["1059"] = 1957,
		["1060"] = 1943,
		["1067"] = 1967,
		["1068"] = 1968,
		["1069"] = 1969,
		["1070"] = 1970,
		["1071"] = 1972,
		["1072"] = 1973,
		["1073"] = 1974,
		["1074"] = 1975,
		["1075"] = 1977,
		["1076"] = 1977,
		["1077"] = 1977,
		["1078"] = 1977,
		["1079"] = 1978,
		["1080"] = 1979,
		["1081"] = 1980,
		["1084"] = 1983,
		["1085"] = 1984,
		["1088"] = 1988,
		["1089"] = 1967,
		["1101"] = 2003,
		["1102"] = 2003,
		["1103"] = 2003,
		["1105"] = 2004,
		["1106"] = 2005,
		["1107"] = 2006,
		["1108"] = 2007,
		["1109"] = 2008,
		["1110"] = 2011,
		["1111"] = 2012,
		["1112"] = 2013,
		["1113"] = 2014,
		["1114"] = 2015,
		["1115"] = 2016,
		["1117"] = 2020,
		["1118"] = 2021,
		["1119"] = 2022,
		["1120"] = 2023,
		["1121"] = 2026,
		["1122"] = 2028,
		["1123"] = 2029,
		["1124"] = 2030,
		["1125"] = 2032,
		["1126"] = 2033,
		["1127"] = 2034,
		["1128"] = 2036,
		["1129"] = 2037,
		["1131"] = 2040,
		["1132"] = 2042,
		["1133"] = 2043,
		["1134"] = 2044,
		["1135"] = 2045,
		["1136"] = 2046,
		["1137"] = 2048,
		["1138"] = 2049,
		["1139"] = 2050,
		["1143"] = 2055,
		["1144"] = 2003,
		["1146"] = 2064,
		["1147"] = 2065,
		["1148"] = 2065,
		["1149"] = 2065,
		["1150"] = 2065,
		["1151"] = 2065,
		["1152"] = 2064,
		["1153"] = 2072,
		["1154"] = 2072,
		["1155"] = 2072,
		["1156"] = 2072,
		["1157"] = 2072,
		["1158"] = 2064,
		["1159"] = 2084,
		["1160"] = 2085,
		["1161"] = 2086,
		["1162"] = 2089,
		["1164"] = 2091,
		["1177"] = 2108,
		["1178"] = 2108,
		["1179"] = 2108,
		["1180"] = 2108,
		["1181"] = 2108,
		["1182"] = 2108,
		["1183"] = 2108,
		["1184"] = 2108,
		["1185"] = 2108,
		["1186"] = 2108,
		["1187"] = 2108,
		["1188"] = 2108,
		["1190"] = 2122,
		["1191"] = 2123,
		["1193"] = 2126,
		["1194"] = 2128,
		["1196"] = 2135,
		["1197"] = 2137,
		["1198"] = 2137,
		["1199"] = 2137,
		["1200"] = 2137,
		["1201"] = 2137,
		["1202"] = 2137,
		["1203"] = 2137,
		["1204"] = 2137,
		["1205"] = 2136,
		["1206"] = 2138,
		["1207"] = 2138,
		["1208"] = 2138,
		["1209"] = 2138,
		["1210"] = 2138,
		["1211"] = 2138,
		["1212"] = 2138,
		["1213"] = 2138,
		["1214"] = 2135,
		["1215"] = 2141,
		["1216"] = 2141,
		["1217"] = 2141,
		["1218"] = 2141,
		["1219"] = 2141,
		["1220"] = 2141,
		["1221"] = 2141,
		["1222"] = 2141,
		["1223"] = 2140,
		["1224"] = 2142,
		["1225"] = 2142,
		["1226"] = 2142,
		["1227"] = 2142,
		["1228"] = 2142,
		["1229"] = 2142,
		["1230"] = 2142,
		["1231"] = 2142,
		["1232"] = 2142,
		["1233"] = 2135,
		["1238"] = 2151,
		["1239"] = 2159,
		["1240"] = 2159,
		["1241"] = 2159,
		["1242"] = 2159,
		["1243"] = 2159,
		["1244"] = 2159,
		["1245"] = 2159,
		["1246"] = 2159,
		["1247"] = 2159,
		["1248"] = 2159,
		["1249"] = 2159,
		["1250"] = 2159,
		["1251"] = 2159,
		["1252"] = 2159,
		["1253"] = 2159,
		["1254"] = 2159,
		["1255"] = 2258,
		["1256"] = 2259,
		["1257"] = 2263,
		["1258"] = 2279,
		["1259"] = 2280,
		["1260"] = 2281,
		["1262"] = 2284,
		["1263"] = 2286,
		["1264"] = 2288,
		["1266"] = 2291,
		["1267"] = 2292,
		["1271"] = 2298,
		["1272"] = 2299,
		["1273"] = 2299,
		["1274"] = 2299,
		["1275"] = 2299,
		["1276"] = 2299,
		["1277"] = 2299,
		["1278"] = 2299,
		["1279"] = 2299,
		["1280"] = 2299,
		["1281"] = 2299,
		["1282"] = 2299,
		["1283"] = 2299,
		["1284"] = 2299,
		["1285"] = 2299,
		["1286"] = 2299,
		["1287"] = 2299,
		["1288"] = 2299,
		["1289"] = 2299,
		["1290"] = 2299,
		["1291"] = 2299,
		["1292"] = 2299,
		["1293"] = 2299,
		["1294"] = 2299,
		["1295"] = 2299,
		["1296"] = 2299,
		["1297"] = 2299,
		["1298"] = 2299,
		["1299"] = 2299,
		["1300"] = 2299,
		["1301"] = 2299,
		["1302"] = 2299,
		["1303"] = 2299,
		["1304"] = 2299,
		["1305"] = 2299,
		["1306"] = 2299,
		["1307"] = 2299,
		["1308"] = 2299,
		["1309"] = 2299,
		["1310"] = 2298,
		["1311"] = 2334,
		["1312"] = 2335,
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
GAMEPLAY_MODULE_LIST = { rune_task = false, card_effect = false, city_effect = true, greevil = true }
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
HERO_LOCK_EXTRA_COUNT_MAX = 7
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
		}
	)
end
if IsServer() then
	UpdateConstantConfig(nil)
end