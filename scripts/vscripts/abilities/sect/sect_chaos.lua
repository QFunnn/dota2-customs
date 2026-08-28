--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		["390"] = 312,
		["391"] = 312,
		["392"] = 311,
		["393"] = 310,
		["394"] = 315,
		["395"] = 316,
		["396"] = 315,
		["397"] = 318,
		["398"] = 319,
		["399"] = 318,
		["400"] = 305,
		["401"] = 298,
		["402"] = 298,
		["403"] = 298,
		["404"] = 298,
		["405"] = 298,
		["406"] = 298,
		["407"] = 298,
		["408"] = 305,
		["410"] = 305,
		["411"] = 326,
		["412"] = 333,
		["413"] = 326,
		["414"] = 333,
		["415"] = 338,
		["416"] = 339,
		["417"] = 340,
		["418"] = 341,
		["419"] = 342,
		["420"] = 338,
		["421"] = 344,
		["422"] = 345,
		["423"] = 344,
		["424"] = 350,
		["425"] = 351,
		["426"] = 352,
		["427"] = 353,
		["429"] = 355,
		["430"] = 356,
		["432"] = 358,
		["433"] = 358,
		["434"] = 358,
		["435"] = 358,
		["436"] = 350,
		["437"] = 333,
		["438"] = 326,
		["439"] = 326,
		["440"] = 326,
		["441"] = 326,
		["442"] = 326,
		["443"] = 326,
		["444"] = 326,
		["445"] = 333,
		["447"] = 333,
		["448"] = 373,
		["449"] = 380,
		["450"] = 373,
		["451"] = 380,
		["452"] = 383,
		["453"] = 384,
		["454"] = 383,
		["455"] = 386,
		["456"] = 387,
		["457"] = 388,
		["458"] = 386,
		["459"] = 390,
		["460"] = 391,
		["461"] = 392,
		["462"] = 392,
		["463"] = 391,
		["464"] = 390,
		["465"] = 395,
		["466"] = 396,
		["467"] = 398,
		["469"] = 395,
		["470"] = 401,
		["471"] = 402,
		["472"] = 401,
		["473"] = 406,
		["474"] = 407,
		["475"] = 407,
		["476"] = 407,
		["477"] = 407,
		["478"] = 406,
		["479"] = 380,
		["480"] = 373,
		["481"] = 373,
		["482"] = 373,
		["483"] = 373,
		["484"] = 373,
		["485"] = 373,
		["486"] = 373,
		["487"] = 380,
		["489"] = 380,
		["490"] = 412,
		["491"] = 419,
		["492"] = 412,
		["493"] = 419,
		["494"] = 422,
		["495"] = 423,
		["496"] = 422,
		["497"] = 425,
		["498"] = 426,
		["499"] = 427,
		["500"] = 425,
		["501"] = 429,
		["502"] = 430,
		["503"] = 431,
		["505"] = 429,
		["506"] = 434,
		["507"] = 435,
		["508"] = 436,
		["509"] = 436,
		["510"] = 435,
		["511"] = 434,
		["512"] = 439,
		["513"] = 440,
		["514"] = 441,
		["517"] = 444,
		["518"] = 445,
		["519"] = 448,
		["522"] = 439,
		["523"] = 452,
		["524"] = 453,
		["525"] = 453,
		["526"] = 453,
		["527"] = 453,
		["528"] = 453,
		["529"] = 452,
		["530"] = 455,
		["531"] = 456,
		["532"] = 456,
		["533"] = 456,
		["534"] = 456,
		["535"] = 456,
		["536"] = 456,
		["538"] = 456,
		["539"] = 457,
		["540"] = 455,
		["541"] = 459,
		["542"] = 460,
		["543"] = 459,
		["544"] = 464,
		["545"] = 465,
		["546"] = 465,
		["547"] = 465,
		["548"] = 465,
		["549"] = 464,
		["550"] = 419,
		["551"] = 412,
		["552"] = 412,
		["553"] = 412,
		["554"] = 412,
		["555"] = 412,
		["556"] = 412,
		["557"] = 412,
		["558"] = 419,
		["560"] = 419,
		["561"] = 470,
		["562"] = 477,
		["563"] = 470,
		["564"] = 477,
		["565"] = 484,
		["566"] = 485,
		["567"] = 484,
		["568"] = 487,
		["569"] = 488,
		["570"] = 489,
		["571"] = 487,
		["572"] = 491,
		["573"] = 492,
		["574"] = 493,
		["575"] = 494,
		["576"] = 495,
		["577"] = 496,
		["578"] = 497,
		["579"] = 497,
		["580"] = 497,
		["581"] = 498,
		["582"] = 499,
		["584"] = 497,
		["585"] = 497,
		["587"] = 491,
		["588"] = 504,
		["589"] = 505,
		["590"] = 506,
		["591"] = 506,
		["592"] = 506,
		["593"] = 505,
		["594"] = 507,
		["595"] = 507,
		["596"] = 507,
		["597"] = 505,
		["598"] = 505,
		["599"] = 504,
		["600"] = 510,
		["601"] = 511,
		["602"] = 512,
		["603"] = 513,
		["604"] = 514,
		["605"] = 515,
		["606"] = 515,
		["607"] = 515,
		["608"] = 516,
		["609"] = 517,
		["611"] = 519,
		["612"] = 515,
		["613"] = 515,
		["616"] = 510,
		["617"] = 524,
		["618"] = 525,
		["619"] = 525,
		["620"] = 525,
		["621"] = 525,
		["622"] = 525,
		["623"] = 525,
		["625"] = 525,
		["626"] = 526,
		["627"] = 524,
		["628"] = 529,
		["629"] = 530,
		["630"] = 531,
		["631"] = 532,
		["633"] = 529,
		["634"] = 535,
		["635"] = 536,
		["638"] = 539,
		["641"] = 542,
		["642"] = 543,
		["643"] = 544,
		["644"] = 545,
		["645"] = 546,
		["647"] = 535,
		["648"] = 477,
		["649"] = 470,
		["650"] = 470,
		["651"] = 470,
		["652"] = 470,
		["653"] = 470,
		["654"] = 470,
		["655"] = 470,
		["656"] = 477,
		["658"] = 477,
		["659"] = 551,
		["660"] = 558,
		["661"] = 551,
		["662"] = 558,
		["663"] = 560,
		["664"] = 561,
		["665"] = 560,
		["666"] = 563,
		["667"] = 564,
		["668"] = 563,
		["669"] = 558,
		["670"] = 551,
		["671"] = 551,
		["672"] = 551,
		["673"] = 551,
		["674"] = 551,
		["675"] = 551,
		["676"] = 551,
		["677"] = 558,
		["679"] = 558,
		["680"] = 570,
		["681"] = 577,
		["682"] = 570,
		["683"] = 577,
		["684"] = 579,
		["685"] = 580,
		["686"] = 579,
		["687"] = 582,
		["688"] = 583,
		["689"] = 584,
		["690"] = 584,
		["691"] = 584,
		["692"] = 584,
		["694"] = 587,
		["695"] = 587,
		["696"] = 587,
		["697"] = 587,
		["698"] = 587,
		["699"] = 588,
		["700"] = 588,
		["701"] = 588,
		["702"] = 588,
		["703"] = 588,
		["704"] = 589,
		["705"] = 589,
		["706"] = 589,
		["707"] = 589,
		["708"] = 589,
		["709"] = 590,
		["710"] = 590,
		["711"] = 590,
		["712"] = 590,
		["713"] = 590,
		["714"] = 590,
		["715"] = 590,
		["716"] = 590,
		["717"] = 591,
		["718"] = 591,
		["719"] = 591,
		["720"] = 591,
		["721"] = 591,
		["722"] = 592,
		["723"] = 592,
		["724"] = 592,
		["725"] = 592,
		["726"] = 592,
		["727"] = 592,
		["728"] = 592,
		["729"] = 592,
		["730"] = 593,
		["731"] = 593,
		["732"] = 593,
		["733"] = 593,
		["734"] = 593,
		["735"] = 594,
		["736"] = 594,
		["737"] = 594,
		["738"] = 594,
		["739"] = 594,
		["740"] = 594,
		["741"] = 594,
		["742"] = 594,
		["744"] = 582,
		["745"] = 597,
		["746"] = 598,
		["747"] = 598,
		["748"] = 598,
		["749"] = 598,
		["750"] = 598,
		["751"] = 598,
		["752"] = 598,
		["753"] = 598,
		["754"] = 597,
		["755"] = 615,
		["756"] = 616,
		["757"] = 617,
		["758"] = 617,
		["759"] = 616,
		["760"] = 615,
		["761"] = 620,
		["762"] = 621,
		["763"] = 621,
		["764"] = 621,
		["765"] = 621,
		["766"] = 622,
		["767"] = 620,
		["768"] = 624,
		["769"] = 625,
		["770"] = 626,
		["771"] = 626,
		["772"] = 626,
		["773"] = 626,
		["775"] = 624,
		["776"] = 577,
		["777"] = 570,
		["778"] = 570,
		["779"] = 570,
		["780"] = 570,
		["781"] = 570,
		["782"] = 570,
		["783"] = 570,
		["784"] = 577,
		["786"] = 577,
		["787"] = 631,
		["788"] = 638,
		["789"] = 631,
		["790"] = 638,
		["791"] = 642,
		["792"] = 644,
		["793"] = 645,
		["794"] = 642,
		["795"] = 647,
		["796"] = 648,
		["797"] = 650,
		["798"] = 650,
		["799"] = 650,
		["800"] = 650,
		["801"] = 650,
		["802"] = 651,
		["803"] = 651,
		["804"] = 651,
		["805"] = 651,
		["806"] = 651,
		["807"] = 652,
		["808"] = 652,
		["809"] = 652,
		["810"] = 652,
		["811"] = 652,
		["812"] = 652,
		["813"] = 652,
		["814"] = 652,
		["816"] = 647,
		["817"] = 661,
		["818"] = 662,
		["819"] = 661,
		["820"] = 666,
		["821"] = 667,
		["822"] = 666,
		["823"] = 669,
		["824"] = 670,
		["825"] = 671,
		["826"] = 671,
		["827"] = 670,
		["828"] = 669,
		["829"] = 674,
		["830"] = 675,
		["831"] = 680,
		["833"] = 674,
		["834"] = 638,
		["835"] = 631,
		["836"] = 631,
		["837"] = 631,
		["838"] = 631,
		["839"] = 631,
		["840"] = 631,
		["841"] = 631,
		["842"] = 638,
		["844"] = 638,
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
function N.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function N.prototype.OnBattleEnd(self)
	self:Destroy()
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