--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/sect/sect_chaos"
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
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["19"] = 5,
		["20"] = 7,
		["21"] = 4,
		["22"] = 27,
		["23"] = 28,
		["24"] = 29,
		["25"] = 30,
		["26"] = 31,
		["27"] = 32,
		["28"] = 33,
		["29"] = 34,
		["30"] = 35,
		["31"] = 36,
		["32"] = 37,
		["33"] = 38,
		["34"] = 39,
		["35"] = 40,
		["36"] = 41,
		["37"] = 42,
		["38"] = 43,
		["39"] = 44,
		["40"] = 27,
		["41"] = 46,
		["42"] = 47,
		["44"] = 48,
		["45"] = 49,
		["47"] = 50,
		["48"] = 50,
		["49"] = 50,
		["50"] = 50,
		["51"] = 50,
		["52"] = 50,
		["55"] = 52,
		["58"] = 53,
		["59"] = 54,
		["60"] = 55,
		["65"] = 59,
		["67"] = 60,
		["68"] = 60,
		["69"] = 60,
		["70"] = 60,
		["71"] = 60,
		["72"] = 60,
		["75"] = 62,
		["78"] = 63,
		["79"] = 64,
		["80"] = 65,
		["81"] = 66,
		["86"] = 70,
		["89"] = 71,
		["92"] = 72,
		["93"] = 73,
		["94"] = 74,
		["95"] = 74,
		["96"] = 74,
		["97"] = 74,
		["98"] = 74,
		["99"] = 75,
		["100"] = 75,
		["101"] = 75,
		["102"] = 75,
		["103"] = 75,
		["104"] = 76,
		["105"] = 76,
		["106"] = 76,
		["107"] = 76,
		["108"] = 76,
		["109"] = 76,
		["110"] = 76,
		["111"] = 76,
		["112"] = 76,
		["113"] = 77,
		["114"] = 78,
		["115"] = 79,
		["116"] = 80,
		["117"] = 80,
		["118"] = 80,
		["119"] = 80,
		["120"] = 80,
		["121"] = 80,
		["122"] = 80,
		["123"] = 81,
		["124"] = 82,
		["125"] = 83,
		["126"] = 84,
		["127"] = 85,
		["132"] = 89,
		["135"] = 90,
		["136"] = 91,
		["139"] = 92,
		["140"] = 93,
		["143"] = 94,
		["144"] = 95,
		["145"] = 96,
		["151"] = 46,
		["152"] = 103,
		["153"] = 104,
		["154"] = 103,
		["155"] = 5,
		["156"] = 4,
		["157"] = 5,
		["159"] = 5,
		["160"] = 108,
		["161"] = 116,
		["162"] = 108,
		["163"] = 116,
		["165"] = 116,
		["166"] = 120,
		["167"] = 108,
		["168"] = 140,
		["169"] = 141,
		["170"] = 142,
		["171"] = 144,
		["172"] = 145,
		["173"] = 146,
		["174"] = 147,
		["175"] = 148,
		["176"] = 149,
		["177"] = 150,
		["178"] = 153,
		["179"] = 154,
		["180"] = 155,
		["181"] = 156,
		["182"] = 157,
		["183"] = 159,
		["184"] = 160,
		["185"] = 161,
		["186"] = 162,
		["187"] = 163,
		["188"] = 164,
		["189"] = 140,
		["190"] = 167,
		["191"] = 168,
		["192"] = 168,
		["193"] = 168,
		["194"] = 171,
		["195"] = 171,
		["196"] = 171,
		["197"] = 168,
		["198"] = 172,
		["199"] = 172,
		["200"] = 172,
		["201"] = 168,
		["202"] = 173,
		["203"] = 173,
		["204"] = 173,
		["205"] = 168,
		["206"] = 168,
		["207"] = 167,
		["208"] = 176,
		["209"] = 177,
		["210"] = 178,
		["211"] = 180,
		["212"] = 180,
		["213"] = 180,
		["214"] = 180,
		["215"] = 180,
		["216"] = 180,
		["217"] = 182,
		["218"] = 183,
		["219"] = 183,
		["220"] = 183,
		["221"] = 183,
		["222"] = 183,
		["223"] = 183,
		["225"] = 185,
		["226"] = 187,
		["227"] = 188,
		["228"] = 188,
		["229"] = 188,
		["230"] = 188,
		["231"] = 188,
		["232"] = 188,
		["234"] = 191,
		["235"] = 192,
		["236"] = 192,
		["237"] = 192,
		["238"] = 192,
		["239"] = 192,
		["240"] = 192,
		["241"] = 193,
		["242"] = 193,
		["243"] = 193,
		["244"] = 193,
		["245"] = 193,
		["246"] = 193,
		["249"] = 197,
		["250"] = 198,
		["251"] = 198,
		["252"] = 198,
		["253"] = 198,
		["254"] = 198,
		["255"] = 198,
		["257"] = 201,
		["258"] = 202,
		["259"] = 202,
		["260"] = 202,
		["261"] = 202,
		["262"] = 202,
		["263"] = 202,
		["265"] = 205,
		["266"] = 206,
		["267"] = 206,
		["268"] = 206,
		["269"] = 206,
		["270"] = 206,
		["271"] = 206,
		["273"] = 209,
		["274"] = 210,
		["275"] = 210,
		["276"] = 210,
		["277"] = 210,
		["278"] = 210,
		["279"] = 210,
		["281"] = 213,
		["282"] = 214,
		["283"] = 216,
		["284"] = 217,
		["285"] = 218,
		["287"] = 220,
		["288"] = 222,
		["289"] = 222,
		["290"] = 222,
		["291"] = 222,
		["292"] = 222,
		["293"] = 222,
		["294"] = 222,
		["295"] = 222,
		["296"] = 224,
		["297"] = 224,
		["298"] = 224,
		["299"] = 224,
		["300"] = 224,
		["301"] = 224,
		["302"] = 224,
		["303"] = 224,
		["305"] = 176,
		["306"] = 228,
		["307"] = 229,
		["308"] = 230,
		["309"] = 231,
		["310"] = 232,
		["311"] = 233,
		["314"] = 228,
		["315"] = 237,
		["316"] = 238,
		["317"] = 239,
		["318"] = 240,
		["320"] = 237,
		["321"] = 248,
		["322"] = 249,
		["323"] = 250,
		["324"] = 251,
		["325"] = 252,
		["327"] = 248,
		["328"] = 255,
		["329"] = 256,
		["330"] = 257,
		["331"] = 258,
		["334"] = 255,
		["335"] = 267,
		["336"] = 268,
		["337"] = 267,
		["338"] = 272,
		["339"] = 273,
		["340"] = 275,
		["342"] = 272,
		["343"] = 279,
		["344"] = 280,
		["347"] = 283,
		["350"] = 286,
		["351"] = 287,
		["353"] = 287,
		["356"] = 279,
		["357"] = 291,
		["358"] = 292,
		["359"] = 293,
		["360"] = 293,
		["361"] = 293,
		["362"] = 293,
		["363"] = 293,
		["364"] = 293,
		["365"] = 293,
		["366"] = 293,
		["367"] = 293,
		["368"] = 293,
		["369"] = 291,
		["370"] = 116,
		["371"] = 108,
		["372"] = 108,
		["373"] = 108,
		["374"] = 108,
		["375"] = 108,
		["376"] = 108,
		["377"] = 108,
		["378"] = 116,
		["380"] = 116,
		["381"] = 298,
		["382"] = 305,
		["383"] = 298,
		["384"] = 305,
		["385"] = 307,
		["386"] = 308,
		["387"] = 307,
		["388"] = 310,
		["389"] = 311,
		["390"] = 310,
		["391"] = 305,
		["392"] = 298,
		["393"] = 298,
		["394"] = 298,
		["395"] = 298,
		["396"] = 298,
		["397"] = 298,
		["398"] = 298,
		["399"] = 305,
		["401"] = 305,
		["402"] = 318,
		["403"] = 325,
		["404"] = 318,
		["405"] = 325,
		["406"] = 330,
		["407"] = 331,
		["408"] = 332,
		["409"] = 333,
		["410"] = 334,
		["411"] = 330,
		["412"] = 336,
		["413"] = 337,
		["414"] = 336,
		["415"] = 342,
		["416"] = 343,
		["417"] = 344,
		["418"] = 345,
		["420"] = 347,
		["421"] = 348,
		["423"] = 350,
		["424"] = 350,
		["425"] = 350,
		["426"] = 350,
		["427"] = 342,
		["428"] = 325,
		["429"] = 318,
		["430"] = 318,
		["431"] = 318,
		["432"] = 318,
		["433"] = 318,
		["434"] = 318,
		["435"] = 318,
		["436"] = 325,
		["438"] = 325,
		["439"] = 365,
		["440"] = 372,
		["441"] = 365,
		["442"] = 372,
		["443"] = 375,
		["444"] = 376,
		["445"] = 375,
		["446"] = 378,
		["447"] = 379,
		["448"] = 380,
		["449"] = 378,
		["450"] = 382,
		["451"] = 383,
		["452"] = 384,
		["453"] = 384,
		["454"] = 383,
		["455"] = 382,
		["456"] = 387,
		["457"] = 388,
		["458"] = 390,
		["460"] = 387,
		["461"] = 393,
		["462"] = 394,
		["463"] = 393,
		["464"] = 398,
		["465"] = 399,
		["466"] = 399,
		["467"] = 399,
		["468"] = 399,
		["469"] = 398,
		["470"] = 372,
		["471"] = 365,
		["472"] = 365,
		["473"] = 365,
		["474"] = 365,
		["475"] = 365,
		["476"] = 365,
		["477"] = 365,
		["478"] = 372,
		["480"] = 372,
		["481"] = 404,
		["482"] = 411,
		["483"] = 404,
		["484"] = 411,
		["485"] = 414,
		["486"] = 415,
		["487"] = 414,
		["488"] = 417,
		["489"] = 418,
		["490"] = 419,
		["491"] = 417,
		["492"] = 421,
		["493"] = 422,
		["494"] = 423,
		["496"] = 421,
		["497"] = 426,
		["498"] = 427,
		["499"] = 428,
		["500"] = 428,
		["501"] = 427,
		["502"] = 426,
		["503"] = 431,
		["504"] = 432,
		["505"] = 433,
		["508"] = 436,
		["509"] = 437,
		["510"] = 440,
		["513"] = 431,
		["514"] = 444,
		["515"] = 445,
		["516"] = 445,
		["517"] = 445,
		["518"] = 445,
		["519"] = 445,
		["520"] = 444,
		["521"] = 447,
		["522"] = 448,
		["523"] = 448,
		["524"] = 448,
		["525"] = 448,
		["526"] = 448,
		["527"] = 448,
		["529"] = 448,
		["530"] = 449,
		["531"] = 447,
		["532"] = 451,
		["533"] = 452,
		["534"] = 451,
		["535"] = 456,
		["536"] = 457,
		["537"] = 457,
		["538"] = 457,
		["539"] = 457,
		["540"] = 456,
		["541"] = 411,
		["542"] = 404,
		["543"] = 404,
		["544"] = 404,
		["545"] = 404,
		["546"] = 404,
		["547"] = 404,
		["548"] = 404,
		["549"] = 411,
		["551"] = 411,
		["552"] = 462,
		["553"] = 469,
		["554"] = 462,
		["555"] = 469,
		["556"] = 476,
		["557"] = 477,
		["558"] = 476,
		["559"] = 479,
		["560"] = 480,
		["561"] = 481,
		["562"] = 479,
		["563"] = 483,
		["564"] = 484,
		["565"] = 485,
		["566"] = 486,
		["567"] = 487,
		["568"] = 488,
		["569"] = 489,
		["570"] = 489,
		["571"] = 489,
		["572"] = 490,
		["573"] = 491,
		["575"] = 489,
		["576"] = 489,
		["578"] = 483,
		["579"] = 496,
		["580"] = 497,
		["581"] = 498,
		["582"] = 498,
		["583"] = 498,
		["584"] = 497,
		["585"] = 499,
		["586"] = 499,
		["587"] = 499,
		["588"] = 497,
		["589"] = 497,
		["590"] = 496,
		["591"] = 502,
		["592"] = 503,
		["593"] = 504,
		["594"] = 505,
		["595"] = 506,
		["596"] = 507,
		["597"] = 507,
		["598"] = 507,
		["599"] = 508,
		["600"] = 509,
		["602"] = 511,
		["603"] = 507,
		["604"] = 507,
		["607"] = 502,
		["608"] = 516,
		["609"] = 517,
		["610"] = 517,
		["611"] = 517,
		["612"] = 517,
		["613"] = 517,
		["614"] = 517,
		["616"] = 517,
		["617"] = 518,
		["618"] = 516,
		["619"] = 521,
		["620"] = 522,
		["621"] = 523,
		["622"] = 524,
		["624"] = 521,
		["625"] = 527,
		["626"] = 528,
		["629"] = 531,
		["632"] = 534,
		["633"] = 535,
		["634"] = 536,
		["635"] = 537,
		["636"] = 538,
		["638"] = 527,
		["639"] = 469,
		["640"] = 462,
		["641"] = 462,
		["642"] = 462,
		["643"] = 462,
		["644"] = 462,
		["645"] = 462,
		["646"] = 462,
		["647"] = 469,
		["649"] = 469,
		["650"] = 543,
		["651"] = 550,
		["652"] = 543,
		["653"] = 550,
		["654"] = 552,
		["655"] = 553,
		["656"] = 552,
		["657"] = 555,
		["658"] = 556,
		["659"] = 555,
		["660"] = 550,
		["661"] = 543,
		["662"] = 543,
		["663"] = 543,
		["664"] = 543,
		["665"] = 543,
		["666"] = 543,
		["667"] = 543,
		["668"] = 550,
		["670"] = 550,
		["671"] = 562,
		["672"] = 569,
		["673"] = 562,
		["674"] = 569,
		["675"] = 571,
		["676"] = 572,
		["677"] = 571,
		["678"] = 574,
		["679"] = 575,
		["680"] = 576,
		["681"] = 576,
		["682"] = 576,
		["683"] = 576,
		["685"] = 579,
		["686"] = 579,
		["687"] = 579,
		["688"] = 579,
		["689"] = 579,
		["690"] = 580,
		["691"] = 580,
		["692"] = 580,
		["693"] = 580,
		["694"] = 580,
		["695"] = 581,
		["696"] = 581,
		["697"] = 581,
		["698"] = 581,
		["699"] = 581,
		["700"] = 582,
		["701"] = 582,
		["702"] = 582,
		["703"] = 582,
		["704"] = 582,
		["705"] = 582,
		["706"] = 582,
		["707"] = 582,
		["708"] = 583,
		["709"] = 583,
		["710"] = 583,
		["711"] = 583,
		["712"] = 583,
		["713"] = 584,
		["714"] = 584,
		["715"] = 584,
		["716"] = 584,
		["717"] = 584,
		["718"] = 584,
		["719"] = 584,
		["720"] = 584,
		["721"] = 585,
		["722"] = 585,
		["723"] = 585,
		["724"] = 585,
		["725"] = 585,
		["726"] = 586,
		["727"] = 586,
		["728"] = 586,
		["729"] = 586,
		["730"] = 586,
		["731"] = 586,
		["732"] = 586,
		["733"] = 586,
		["735"] = 574,
		["736"] = 589,
		["737"] = 590,
		["738"] = 590,
		["739"] = 590,
		["740"] = 590,
		["741"] = 590,
		["742"] = 590,
		["743"] = 590,
		["744"] = 590,
		["745"] = 589,
		["746"] = 607,
		["747"] = 608,
		["748"] = 609,
		["749"] = 609,
		["750"] = 608,
		["751"] = 607,
		["752"] = 612,
		["753"] = 613,
		["754"] = 613,
		["755"] = 613,
		["756"] = 613,
		["757"] = 614,
		["758"] = 612,
		["759"] = 616,
		["760"] = 617,
		["761"] = 618,
		["762"] = 618,
		["763"] = 618,
		["764"] = 618,
		["766"] = 616,
		["767"] = 569,
		["768"] = 562,
		["769"] = 562,
		["770"] = 562,
		["771"] = 562,
		["772"] = 562,
		["773"] = 562,
		["774"] = 562,
		["775"] = 569,
		["777"] = 569,
		["778"] = 623,
		["779"] = 630,
		["780"] = 623,
		["781"] = 630,
		["782"] = 634,
		["783"] = 636,
		["784"] = 637,
		["785"] = 634,
		["786"] = 639,
		["787"] = 640,
		["788"] = 642,
		["789"] = 642,
		["790"] = 642,
		["791"] = 642,
		["792"] = 642,
		["793"] = 643,
		["794"] = 643,
		["795"] = 643,
		["796"] = 643,
		["797"] = 643,
		["798"] = 644,
		["799"] = 644,
		["800"] = 644,
		["801"] = 644,
		["802"] = 644,
		["803"] = 644,
		["804"] = 644,
		["805"] = 644,
		["807"] = 639,
		["808"] = 653,
		["809"] = 654,
		["810"] = 653,
		["811"] = 658,
		["812"] = 659,
		["813"] = 658,
		["814"] = 661,
		["815"] = 662,
		["816"] = 663,
		["817"] = 663,
		["818"] = 662,
		["819"] = 661,
		["820"] = 666,
		["821"] = 667,
		["822"] = 672,
		["824"] = 666,
		["825"] = 630,
		["826"] = 623,
		["827"] = 623,
		["828"] = 623,
		["829"] = 623,
		["830"] = 623,
		["831"] = 623,
		["832"] = 623,
		["833"] = 630,
		["835"] = 630,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.sect_chaos = c()
local n = g.sect_chaos
n.name = "sect_chaos"
d(n, i)
function n.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.timerInterval = 0.1
end
function n.prototype.GetAbilitySpecialValue(self)
	self.chaos_prebattle = self:GetSpecialValueFor("chaos_prebattle")
	self.chaos_damage = self:GetSpecialValueFor("chaos_damage")
	self.n_164_chaos_count = self:GetSectSpecialValueFor("164", "n_164_chaos_count")
	self.n_164_interval = self:GetSectSpecialValueFor("164", "n_164_interval")
	self.n_165_reduce_pct = self:GetSectSpecialValueFor("165", "n_165_reduce_pct")
	self.n_167_count = self:GetSectSpecialValueFor("167", "n_167_count")
	self.n_167_chaos_damage = self:GetSectSpecialValueFor("167", "n_167_chaos_damage")
	self.n_168_count = self:GetSectSpecialValueFor("168", "n_168_count")
	self.n_168_chaos_damage = self:GetSectSpecialValueFor("168", "n_168_chaos_damage")
	self.r_178_chance = self:GetSectSpecialValueFor("178", "r_178_chance")
	self.r_178_damage_bonus = self:GetSectSpecialValueFor("178", "r_178_damage_bonus")
	self.r_179_chance = self:GetSectSpecialValueFor("179", "r_179_chance")
	self.r_179_chaos_count = self:GetSectSpecialValueFor("179", "r_179_chaos_count")
	self.r_180_chaos = self:GetSectSpecialValueFor("180", "r_180_chaos")
	self.sr_181_threshold = self:GetSectSpecialValueFor("181", "sr_181_threshold")
	self.sr_182_chance = self:GetSectSpecialValueFor("182", "sr_182_chance")
	self.sr_194_chaos_damage = self:GetSectSpecialValueFor("194", "sr_194_chaos_damage")
end
function n.prototype.TriggerByName(self, o, p)
	local q = self:GetCaster()
	repeat
		local r = o
		local s = r == "164"
		if s then
			AddChaos(q, GetSectChaosModifiedValue(q, self.n_164_chaos_count), "164", "AbilityUpgrade")
			break
		end
		s = s or r == "178"
		if s then
			do
				local t = q:FindModifierByName("modifier_sect_chaos_178_buff")
				if IsValid(t) then
					t:IncrementStackCount()
				end
				break
			end
		end
		s = s or r == "179"
		if s then
			AddChaos(q, GetSectChaosModifiedValue(q, self.r_179_chaos_count), "179", "AbilityUpgrade")
			break
		end
		s = s or r == "180"
		if s then
			do
				local t = q:FindModifierByName("modifier_sect_chaos_180_buff")
				if IsValid(t) then
					t:IncrementStackCount(t.r_180_chaos)
					t:SaveStack()
				end
				break
			end
		end
		s = s or r == "181"
		if s then
			do
				if not p then
					return
				end
				CombatLog:recordSectAbilityCast(q, "181")
				local u = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_axe/axe_culling_blade_kill.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					p
				)
				ParticleManager:SetParticleControl(u, 3, Vector(0, 0, 0))
				ParticleManager:SetParticleControlForward(u, 3, (p:GetAbsOrigin() - q:GetAbsOrigin()):Normalized())
				ParticleManager:SetParticleControlEnt(u, 4, p, PATTACH_ABSORIGIN_FOLLOW, nil, p:GetAbsOrigin(), true)
				ParticleManager:ReleaseParticleIndex(u)
				p:EmitSound("Hero_Axe.Culling_Blade_Success")
				local v = p:GetHealth()
				q:DealChaosDamage(p, self, v, DamageFlags.DAMAGE_FLAG_REFLECTION, "181")
				local w = q:FindModifierByName("modifier_sect_chaos_181_buff")
				if IsValid(w) and not w.sr_181_counted then
					w.sr_181_counted = true
					w:IncrementStackCount()
					w.health_threshold = w.sr_181_threshold + w:GetStackCount() * BUFF_VALUE.CullingBladeStackValue
				end
				break
			end
		end
		s = s or r == "194"
		if s then
			do
				local x = q:GetEnemy()
				if not IsInjurable(q, x) then
					return
				end
				local t = q:FindModifierByName("modifier_sect_chaos_194_buff")
				if not IsValid(t) then
					return
				end
				local y = GetChaos(x) * t.sr_194_chaos_steal * 0.01
				if y > 0 then
					AddChaos(q, y, "194", "AbilityUpgrade")
				end
				break
			end
		end
	until true
end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_sect_chaos"
end
n = e({ j(nil) }, n)
g.sect_chaos = n
g.modifier_sect_chaos = c()
local z = g.modifier_sect_chaos
z.name = "modifier_sect_chaos"
d(z, l)
function z.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.timerInterval = 0.1
end
function z.prototype.GetAbilitySpecialValue(self)
	self.chaos_prebattle = self:GetAbilitySpecialValueFor("chaos_prebattle")
	self.chaos_damage = self:GetAbilitySpecialValueFor("chaos_damage")
	self.n_164_chaos_count = self:GetSectSpecialValueFor("164", "n_164_chaos_count")
	self.n_164_interval = self:GetSectSpecialValueFor("164", "n_164_interval")
	self.n_165_reduce_pct = self:GetSectSpecialValueFor("165", "n_165_reduce_pct")
	self.n_167_count = self:GetSectSpecialValueFor("167", "n_167_count")
	self.n_167_chaos_damage = self:GetSectSpecialValueFor("167", "n_167_chaos_damage")
	self.n_168_count = self:GetSectSpecialValueFor("168", "n_168_count")
	self.n_168_chaos_damage = self:GetSectSpecialValueFor("168", "n_168_chaos_damage")
	self.r_178_chance = self:GetSectSpecialValueFor("178", "r_178_chance")
	self.r_178_damage_bonus = self:GetSectSpecialValueFor("178", "r_178_damage_bonus")
	self.r_179_chance = self:GetSectSpecialValueFor("179", "r_179_chance")
	self.r_179_chaos_count = self:GetSectSpecialValueFor("179", "r_179_chaos_count")
	self.r_180_chaos = self:GetSectSpecialValueFor("180", "r_180_chaos")
	self.sr_181_threshold = self:GetSectSpecialValueFor("181", "sr_181_threshold")
	self.sr_182_chance = self:GetSectSpecialValueFor("182", "sr_182_chance")
	self.sr_194_chaos_damage = self:GetSectSpecialValueFor("194", "sr_194_chaos_damage")
	self.trigger_chance = self:GetCustomAbilityValueFor("sect_chaos_trigger", "chance")
	self.effect_value = self:GetCustomAbilityValueFor("sect_chaos_effect", "value")
	self.ability:GetAbilitySpecialValue()
end
function z.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_CHAOS_POINT_GAINED] = { self:GetParent(), -1 },
	}
end
function z.prototype.OnBattleStartBefore(self, A)
	local B = self:GetParent()
	local C = B:GetEnemy()
	B:AddNewModifier(B, self:GetAbility(), "modifier_chaos_permanent", {})
	if self.n_167_count > 0 or self.n_168_count > 0 then
		B:AddNewModifier(B, self:GetAbility(), "modifier_sect_chaos_point_damage_bonus", {})
	end
	if IsValid(C) then
		if self.n_165_reduce_pct > 0 then
			C:AddNewModifier(B, self:GetAbility(), "modifier_sect_chaos_165_debuff", {})
		end
		if self.sr_182_chance > 0 then
			C:AddNewModifier(B, self:GetAbility(), "modifier_sect_chaos_182", {})
			B:AddNewModifier(B, self:GetAbility(), "modifier_sect_chaos_182_chaos", {})
		end
	end
	if self.r_178_chance > 0 then
		B:AddNewModifier(B, self:GetAbility(), "modifier_sect_chaos_178_buff", {})
	end
	if self.r_180_chaos > 0 then
		B:AddNewModifier(B, self:GetAbility(), "modifier_sect_chaos_180_buff", {})
	end
	if self.sr_181_threshold > 0 then
		B:AddNewModifier(B, self:GetAbility(), "modifier_sect_chaos_181_buff", {})
	end
	if self.sr_194_chaos_damage > 0 then
		B:AddNewModifier(B, self:GetAbility(), "modifier_sect_chaos_194_buff", {})
	end
	local D = self.chaos_prebattle + GetChaosPreBattle(B)
	if D > 0 then
		local E = B:FindAbilityByName("sect_chaos")
		if not IsValid(E) then
			E = B:AddAbility_Engine("sect_chaos")
		end
		B:AddNewModifier(B, E, "modifier_chaos_custom", { iStackCount = D })
		CombatLog:recordBuff(B, B, "chaos", self.chaos_prebattle, "sect_chaos", "Sect")
		PlayerData:addDetailData(self:GetParent(), "Sect", "chaos", self.chaos_prebattle, false, "sect_chaos")
	end
end
function z.prototype.OnBattleStart(self, A)
	if IsServer() then
		local B = self:GetParent()
		local C = B:GetEnemy()
		if self.n_164_interval > 0 then
			self:StartThink(self.n_164_interval, "n_164")
		end
	end
end
function z.prototype.OnBattleEnd(self, A)
	if IsServer() then
		self:StartIntervalThink(-1)
		self:StartThink(-1, "n_164")
	end
end
function z.prototype.OnCustomTakeDamage(self, F)
	if self:PRD(self.r_179_chance, "r_179_chance") then
		local G = self:GetParent()
		local p = F.target
		self.ability:TriggerByName("179")
	end
end
function z.prototype.OnThink(self, H)
	if H == "n_164" then
		if self.n_164_chaos_count > 0 then
			self.ability:TriggerByName("164")
		end
	end
end
function z.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_DAMAGE_BONUS] = self.chaos_damage }
end
function z.prototype.OnChaosPointGained(self, A)
	if A then
		self:customAbilityTrigger()
	end
end
function z.prototype.customAbilityTrigger(self)
	if self:GetParent():IsNeutral() then
		return
	end
	if self:GetParent():GetHeroBase():getCustomAbilityTrigger() ~= "sect_chaos" then
		return
	end
	if self.trigger_chance > 0 and self:PRD(self.trigger_chance, "trigger_chance") then
		local I = self:GetParent():GetHeroBase():getCustomAbilityEffectModifier()
		if I ~= nil then
			I:customAbilityEffect()
		end
	end
end
function z.prototype.customAbilityEffect(self)
	self:GetParent():GetHeroBase():addCustomAbilityTriggerCount()
	local J = AddChaos
	local K = self:GetParent()
	local L = self.effect_value
	local M = self:GetAbility()
	J(K, L, M and M:GetAbilityName() or "", "Sect")
end
z = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	z
)
g.modifier_sect_chaos = z
g.modifier_sect_chaos_165_debuff = c()
local N = g.modifier_sect_chaos_165_debuff
N.name = "modifier_sect_chaos_165_debuff"
d(N, l)
function N.prototype.GetAbilitySpecialValue(self)
	self.n_165_reduce_pct = self:GetSectSpecialValueFor("165", "n_165_reduce_pct")
end
function N.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_SECT_GAIN_PERCENTAGE] = -self.n_165_reduce_pct }
end
N = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	N
)
g.modifier_sect_chaos_165_debuff = N
g.modifier_sect_chaos_point_damage_bonus = c()
local O = g.modifier_sect_chaos_point_damage_bonus
O.name = "modifier_sect_chaos_point_damage_bonus"
d(O, l)
function O.prototype.GetAbilitySpecialValue(self)
	self.n_167_count = self:GetSectSpecialValueFor("167", "n_167_count")
	self.n_167_chaos_damage = self:GetSectSpecialValueFor("167", "n_167_chaos_damage")
	self.n_168_count = self:GetSectSpecialValueFor("168", "n_168_count")
	self.n_168_chaos_damage = self:GetSectSpecialValueFor("168", "n_168_chaos_damage")
end
function O.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_DAMAGE_BONUS }
end
function O.prototype.EOM_GetModifierChaosDamageBonus(self, A)
	local P = 0
	if self.n_167_count > 0 then
		return math.floor(GetEvasion(self:GetParent()) / self.n_167_count) * self.n_167_chaos_damage
	end
	if self.n_168_count > 0 then
		return math.floor(GetPhysicalCriticalChance(self:GetParent()) / self.n_168_count) * self.n_168_chaos_damage
	end
	return GetSectChaosModifiedValue(self:GetParent(), P)
end
O = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	O
)
g.modifier_sect_chaos_point_damage_bonus = O
g.modifier_sect_chaos_178_buff = c()
local Q = g.modifier_sect_chaos_178_buff
Q.name = "modifier_sect_chaos_178_buff"
d(Q, l)
function Q.prototype.GetTexture(self)
	return "sect_chaos_178"
end
function Q.prototype.GetAbilitySpecialValue(self)
	self.r_178_chance = self:GetSectSpecialValueFor("178", "r_178_chance")
	self.r_178_damage_bonus = self:GetSectSpecialValueFor("178", "r_178_damage_bonus")
end
function Q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function Q.prototype.OnCustomTakeDamage(self, F)
	if F and F.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS and self:PRD(self.r_178_chance) then
		self:GetAbility():TriggerByName("178")
	end
end
function Q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_POINT_DAMAGE_BONUS }
end
function Q.prototype.EOM_GetModifierChaosPointDamageBonus(self)
	return GetSectChaosModifiedValue(self:GetParent(), self:GetStackCount() * self.r_178_damage_bonus)
end
Q = e(
	{ m(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	Q
)
g.modifier_sect_chaos_178_buff = Q
g.modifier_sect_chaos_180_buff = c()
local R = g.modifier_sect_chaos_180_buff
R.name = "modifier_sect_chaos_180_buff"
d(R, l)
function R.prototype.GetTexture(self)
	return "sect_chaos_180"
end
function R.prototype.GetAbilitySpecialValue(self)
	self.r_180_chaos = self:GetSectSpecialValueFor("180", "r_180_chaos")
	self.r_180_chaos_bonus = self:GetSectSpecialValueFor("180", "r_180_chaos_bonus")
end
function R.prototype.OnCreated(self, A)
	if IsServer() then
		self:SetStackCount(self:LoadStack())
	end
end
function R.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function R.prototype.OnBattleEnd(self, A)
	if IsServer() then
		if A.isNeutral ~= nil then
			return
		end
		local S = self:GetParent():GetPlayerOwnerID()
		if A.winPlayerID == S and not self:GetParent():IsCustomIllusion() then
			self:GetAbility():TriggerByName("180")
		end
	end
end
function R.prototype.SaveStack(self)
	PlayerData:saveData(self:GetParent():GetPlayerOwnerID(), "sect_chaos_180", self:GetStackCount())
end
function R.prototype.LoadStack(self)
	local T = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "sect_chaos_180")
	if T == nil then
		T = 0
	end
	local P = T
	return P
end
function R.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_DAMAGE_BONUS }
end
function R.prototype.EOM_GetModifierChaosDamageBonus(self, A)
	return GetSectChaosModifiedValue(self:GetParent(), self:GetStackCount() + self.r_180_chaos_bonus)
end
R = e(
	{ m(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	R
)
g.modifier_sect_chaos_180_buff = R
g.modifier_sect_chaos_181_buff = c()
local U = g.modifier_sect_chaos_181_buff
U.name = "modifier_sect_chaos_181_buff"
d(U, l)
function U.prototype.GetTexture(self)
	return "sect_chaos_181"
end
function U.prototype.GetAbilitySpecialValue(self)
	self.sr_181_threshold = self:GetSectSpecialValueFor("181", "sr_181_threshold")
	self.sr_181_interval = self:GetSectSpecialValueFor("181", "sr_181_interval")
end
function U.prototype.OnCreated(self, A)
	if IsServer() then
		self.sr_181_counted = false
		self.sr_181_enable = true
		self:SetStackCount(self:LoadStack())
		self.health_threshold = self.sr_181_threshold + self:GetStackCount() * BUFF_VALUE.CullingBladeStackValue
		self.hookID = self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE, function(V, A, q, W)
			if q == self:GetParent() then
				self:CullingBladeKill(A)
			end
		end)
	end
end
function U.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
	}
end
function U.prototype.OnBattleEnd(self, A)
	if IsServer() then
		local X = self:GetParent():GetPlayerOwnerID()
		if A.illusionPlayerID ~= X then
			local Y = self:GetStackCount()
			GameTimer(0, function()
				if IsValid(self) then
					Y = self:GetStackCount()
				end
				PlayerData:saveData(X, "sect_chaos_181", Y)
			end)
		end
	end
end
function U.prototype.LoadStack(self)
	local Z = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "sect_chaos_181")
	if Z == nil then
		Z = 0
	end
	local P = Z
	return P
end
function U.prototype.OnIntervalThink(self)
	if IsServer() then
		self.sr_181_enable = true
		self:StartIntervalThink(-1)
	end
end
function U.prototype.CullingBladeKill(self, F)
	if F.damage_type ~= EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS then
		return
	end
	if
		F.damage_flags ~= nil
		and bit.band(F.damage_flags, DamageFlags.DAMAGE_FLAG_REFLECTION) == DamageFlags.DAMAGE_FLAG_REFLECTION
	then
		return
	end
	local p = F.target
	if self.sr_181_enable and p:GetHealthPercent() <= self.health_threshold then
		self.sr_181_enable = false
		self:StartIntervalThink(self.sr_181_interval)
		self:GetAbility():TriggerByName("181", p)
	end
end
U = e(
	{ m(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	U
)
g.modifier_sect_chaos_181_buff = U
g.modifier_sect_chaos_182_chaos = c()
local _ = g.modifier_sect_chaos_182_chaos
_.name = "modifier_sect_chaos_182_chaos"
d(_, l)
function _.prototype.GetAbilitySpecialValue(self)
	self.sr_182_chaos_count = self:GetSectSpecialValueFor("182", "sr_182_chaos_count")
end
function _.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_PERMANENT] = self.sr_182_chaos_count }
end
_ = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	_
)
g.modifier_sect_chaos_182_chaos = _
g.modifier_sect_chaos_182 = c()
local a0 = g.modifier_sect_chaos_182
a0.name = "modifier_sect_chaos_182"
d(a0, l)
function a0.prototype.GetAbilitySpecialValue(self)
	self.sr_182_chance = self:GetSectSpecialValueFor("182", "sr_182_chance")
end
function a0.prototype.OnCreated(self, A)
	if IsServer() then
		EmitSoundOn("Hero_DoomBringer.Doom.Creep", self:GetParent())
	else
		local a1 = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_doom_bringer/doom_bringer_doom_aura.vpcf",
			PATTACH_WORLDORIGIN,
			self:GetCaster()
		)
		ParticleManager:SetParticleControl(a1, 0, Vector(0, 0, 0) + self:GetCaster():GetAbsOrigin())
		ParticleManager:SetParticleControl(a1, 1, Vector(400, 400, 400))
		self:AddParticle(a1, false, false, -1, false, false)
		local a2 = ParticleManager:CreateParticle(
			"particles/status_fx/status_effect_doom.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetCaster()
		)
		self:AddParticle(a2, false, true, MODIFIER_PRIORITY_SUPER_ULTRA, false, false)
		local a3 = ParticleManager:CreateParticle(
			"particles/status_fx/status_effect_doom.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		self:AddParticle(a3, false, true, MODIFIER_PRIORITY_SUPER_ULTRA, false, false)
	end
end
function a0.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_SHIELD_PERCENTAGE] = self.sr_182_chance,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_FURY_PERCENTAGE] = self.sr_182_chance,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_INJURY_PERCENTAGE] = self.sr_182_chance,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_POISON_PERCENTAGE] = self.sr_182_chance,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_ICE_PERCENTAGE] = self.sr_182_chance,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_CHAOS_POINT_PERCENTAGE] = self.sr_182_chance,
	}
end
function a0.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function a0.prototype.OnBattleEnd(self, A)
	StopSoundOn("Hero_DoomBringer.Doom.Creep", self:GetParent())
	self:Destroy()
end
function a0.prototype.OnDestroy(self)
	if IsServer() then
		StopSoundOn("Hero_DoomBringer.Doom.Creep", self:GetParent())
	end
end
a0 = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	a0
)
g.modifier_sect_chaos_182 = a0
g.modifier_sect_chaos_194_buff = c()
local a4 = g.modifier_sect_chaos_194_buff
a4.name = "modifier_sect_chaos_194_buff"
d(a4, l)
function a4.prototype.GetAbilitySpecialValue(self)
	self.sr_194_chaos_steal = self:GetSectSpecialValueFor("194", "sr_194_chaos_steal")
	self.sr_194_add_chaos_cnt = self:GetSectSpecialValueFor("194", "add_chaos_cnt")
end
function a4.prototype.OnCreated(self, A)
	if not IsServer() then
		local a1 = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_enigma/enigma_midnight_pulse.vpcf",
			PATTACH_ABSORIGIN,
			self:GetCaster()
		)
		ParticleManager:SetParticleControl(a1, 1, Vector(400, 400, 400))
		self:AddParticle(a1, false, false, -1, false, false)
	end
end
function a4.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_STACK_BONUS }
end
function a4.prototype.EOM_GetModifierChaosStackBonus(self, A)
	return self.sr_194_add_chaos_cnt
end
function a4.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function a4.prototype.OnCustomTakeDamage(self, F)
	if F.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS then
		self:GetAbility():TriggerByName("194")
	end
end
a4 = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	a4
)
g.modifier_sect_chaos_194_buff = a4
return g