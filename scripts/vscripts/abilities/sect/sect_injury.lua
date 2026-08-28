--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/sect/sect_injury"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SparseArrayNew
local g = b.__TS__SparseArrayPush
local h = b.__TS__SparseArraySpread
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 1,
		["12"] = 1,
		["13"] = 1,
		["14"] = 2,
		["15"] = 2,
		["16"] = 2,
		["17"] = 4,
		["18"] = 5,
		["19"] = 4,
		["20"] = 5,
		["22"] = 5,
		["23"] = 8,
		["24"] = 4,
		["25"] = 38,
		["26"] = 39,
		["27"] = 40,
		["28"] = 41,
		["29"] = 42,
		["30"] = 43,
		["31"] = 44,
		["32"] = 45,
		["33"] = 46,
		["34"] = 47,
		["35"] = 48,
		["36"] = 49,
		["37"] = 50,
		["38"] = 51,
		["39"] = 53,
		["40"] = 54,
		["41"] = 55,
		["42"] = 56,
		["43"] = 57,
		["44"] = 58,
		["45"] = 59,
		["46"] = 60,
		["47"] = 61,
		["48"] = 62,
		["49"] = 63,
		["50"] = 64,
		["51"] = 65,
		["52"] = 38,
		["53"] = 67,
		["54"] = 68,
		["55"] = 67,
		["56"] = 70,
		["57"] = 70,
		["58"] = 70,
		["60"] = 71,
		["61"] = 72,
		["65"] = 73,
		["66"] = 74,
		["69"] = 75,
		["70"] = 75,
		["71"] = 75,
		["72"] = 75,
		["73"] = 75,
		["74"] = 75,
		["75"] = 75,
		["79"] = 78,
		["82"] = 79,
		["83"] = 79,
		["84"] = 79,
		["85"] = 79,
		["86"] = 79,
		["87"] = 79,
		["88"] = 79,
		["92"] = 82,
		["95"] = 83,
		["96"] = 83,
		["97"] = 83,
		["98"] = 83,
		["99"] = 83,
		["100"] = 83,
		["101"] = 83,
		["105"] = 86,
		["108"] = 87,
		["109"] = 87,
		["110"] = 87,
		["111"] = 87,
		["112"] = 87,
		["113"] = 87,
		["114"] = 87,
		["118"] = 90,
		["121"] = 91,
		["125"] = 94,
		["128"] = 95,
		["129"] = 95,
		["130"] = 95,
		["131"] = 95,
		["132"] = 95,
		["133"] = 95,
		["137"] = 98,
		["140"] = 99,
		["141"] = 100,
		["142"] = 100,
		["143"] = 100,
		["144"] = 100,
		["145"] = 100,
		["146"] = 100,
		["147"] = 100,
		["148"] = 107,
		["149"] = 108,
		["150"] = 109,
		["151"] = 109,
		["152"] = 109,
		["153"] = 109,
		["154"] = 109,
		["155"] = 109,
		["156"] = 109,
		["157"] = 109,
		["158"] = 110,
		["160"] = 100,
		["161"] = 100,
		["165"] = 116,
		["168"] = 117,
		["169"] = 118,
		["170"] = 119,
		["171"] = 120,
		["172"] = 121,
		["173"] = 121,
		["174"] = 121,
		["175"] = 121,
		["176"] = 121,
		["177"] = 121,
		["178"] = 121,
		["179"] = 121,
		["180"] = 129,
		["181"] = 130,
		["182"] = 131,
		["183"] = 132,
		["184"] = 132,
		["185"] = 132,
		["186"] = 132,
		["187"] = 132,
		["188"] = 132,
		["189"] = 132,
		["190"] = 132,
		["192"] = 121,
		["193"] = 121,
		["197"] = 138,
		["200"] = 139,
		["201"] = 139,
		["202"] = 139,
		["203"] = 139,
		["204"] = 140,
		["205"] = 141,
		["206"] = 142,
		["207"] = 143,
		["208"] = 144,
		["209"] = 145,
		["211"] = 149,
		["212"] = 149,
		["213"] = 149,
		["214"] = 149,
		["215"] = 149,
		["216"] = 149,
		["217"] = 149,
		["223"] = 70,
		["224"] = 155,
		["225"] = 156,
		["226"] = 155,
		["227"] = 5,
		["228"] = 4,
		["229"] = 5,
		["231"] = 5,
		["232"] = 160,
		["233"] = 167,
		["234"] = 160,
		["235"] = 167,
		["237"] = 167,
		["238"] = 173,
		["239"] = 160,
		["240"] = 205,
		["241"] = 206,
		["242"] = 207,
		["243"] = 208,
		["244"] = 209,
		["245"] = 210,
		["246"] = 211,
		["247"] = 212,
		["248"] = 213,
		["249"] = 214,
		["250"] = 215,
		["251"] = 216,
		["252"] = 217,
		["253"] = 218,
		["254"] = 219,
		["255"] = 221,
		["256"] = 222,
		["257"] = 223,
		["258"] = 224,
		["259"] = 225,
		["260"] = 226,
		["261"] = 227,
		["262"] = 228,
		["263"] = 229,
		["264"] = 230,
		["265"] = 231,
		["266"] = 233,
		["267"] = 234,
		["268"] = 235,
		["269"] = 205,
		["270"] = 237,
		["271"] = 239,
		["272"] = 240,
		["274"] = 237,
		["275"] = 243,
		["276"] = 244,
		["277"] = 244,
		["278"] = 244,
		["279"] = 247,
		["280"] = 247,
		["281"] = 247,
		["282"] = 244,
		["283"] = 244,
		["284"] = 249,
		["285"] = 249,
		["286"] = 249,
		["287"] = 244,
		["288"] = 244,
		["289"] = 243,
		["290"] = 252,
		["291"] = 253,
		["292"] = 254,
		["293"] = 256,
		["296"] = 252,
		["297"] = 260,
		["298"] = 261,
		["299"] = 260,
		["300"] = 265,
		["301"] = 266,
		["302"] = 267,
		["303"] = 268,
		["304"] = 270,
		["305"] = 271,
		["306"] = 271,
		["307"] = 271,
		["308"] = 271,
		["309"] = 271,
		["310"] = 271,
		["312"] = 274,
		["313"] = 275,
		["314"] = 275,
		["315"] = 275,
		["316"] = 275,
		["317"] = 275,
		["318"] = 275,
		["320"] = 277,
		["321"] = 284,
		["322"] = 285,
		["323"] = 287,
		["324"] = 287,
		["325"] = 287,
		["326"] = 287,
		["327"] = 287,
		["328"] = 287,
		["329"] = 289,
		["330"] = 290,
		["331"] = 292,
		["332"] = 293,
		["333"] = 294,
		["335"] = 297,
		["336"] = 297,
		["337"] = 297,
		["338"] = 297,
		["339"] = 297,
		["340"] = 297,
		["341"] = 297,
		["342"] = 297,
		["343"] = 298,
		["344"] = 299,
		["345"] = 300,
		["346"] = 301,
		["347"] = 302,
		["348"] = 303,
		["350"] = 305,
		["351"] = 306,
		["354"] = 309,
		["355"] = 310,
		["357"] = 313,
		["358"] = 313,
		["359"] = 313,
		["360"] = 313,
		["361"] = 313,
		["362"] = 313,
		["363"] = 313,
		["364"] = 313,
		["367"] = 317,
		["368"] = 318,
		["369"] = 318,
		["370"] = 318,
		["371"] = 318,
		["372"] = 318,
		["373"] = 318,
		["376"] = 265,
		["377"] = 353,
		["378"] = 354,
		["379"] = 355,
		["380"] = 356,
		["381"] = 358,
		["382"] = 359,
		["384"] = 361,
		["385"] = 363,
		["386"] = 364,
		["387"] = 364,
		["388"] = 364,
		["389"] = 364,
		["390"] = 364,
		["391"] = 364,
		["392"] = 365,
		["393"] = 366,
		["394"] = 366,
		["395"] = 366,
		["396"] = 366,
		["397"] = 366,
		["399"] = 369,
		["400"] = 370,
		["401"] = 370,
		["402"] = 370,
		["403"] = 370,
		["404"] = 370,
		["405"] = 370,
		["407"] = 373,
		["408"] = 374,
		["409"] = 375,
		["413"] = 353,
		["414"] = 380,
		["415"] = 381,
		["416"] = 382,
		["417"] = 383,
		["418"] = 384,
		["421"] = 387,
		["422"] = 391,
		["424"] = 380,
		["425"] = 394,
		["426"] = 395,
		["427"] = 396,
		["428"] = 397,
		["429"] = 398,
		["430"] = 399,
		["431"] = 400,
		["433"] = 402,
		["435"] = 394,
		["436"] = 405,
		["437"] = 406,
		["438"] = 407,
		["439"] = 408,
		["440"] = 410,
		["441"] = 411,
		["443"] = 414,
		["444"] = 415,
		["446"] = 418,
		["447"] = 419,
		["449"] = 422,
		["450"] = 423,
		["452"] = 426,
		["453"] = 427,
		["454"] = 428,
		["455"] = 429,
		["456"] = 430,
		["459"] = 434,
		["460"] = 405,
		["461"] = 437,
		["462"] = 438,
		["465"] = 441,
		["468"] = 444,
		["469"] = 446,
		["470"] = 447,
		["472"] = 447,
		["476"] = 437,
		["477"] = 451,
		["478"] = 452,
		["479"] = 453,
		["481"] = 453,
		["482"] = 453,
		["483"] = 453,
		["485"] = 453,
		["488"] = 453,
		["489"] = 453,
		["491"] = 453,
		["492"] = 451,
		["493"] = 167,
		["494"] = 160,
		["495"] = 160,
		["496"] = 160,
		["497"] = 160,
		["498"] = 160,
		["499"] = 160,
		["500"] = 160,
		["501"] = 167,
		["503"] = 167,
		["505"] = 458,
		["506"] = 466,
		["507"] = 458,
		["508"] = 466,
		["509"] = 467,
		["510"] = 468,
		["511"] = 469,
		["513"] = 467,
		["514"] = 472,
		["515"] = 473,
		["516"] = 472,
		["517"] = 477,
		["518"] = 478,
		["519"] = 477,
		["520"] = 466,
		["521"] = 458,
		["522"] = 458,
		["523"] = 458,
		["524"] = 458,
		["525"] = 458,
		["526"] = 458,
		["527"] = 458,
		["528"] = 466,
		["530"] = 466,
		["532"] = 485,
		["533"] = 492,
		["534"] = 485,
		["535"] = 492,
		["536"] = 494,
		["537"] = 495,
		["538"] = 494,
		["539"] = 497,
		["540"] = 498,
		["541"] = 497,
		["542"] = 502,
		["543"] = 503,
		["544"] = 504,
		["546"] = 502,
		["547"] = 492,
		["548"] = 485,
		["549"] = 485,
		["550"] = 485,
		["551"] = 485,
		["552"] = 485,
		["553"] = 485,
		["554"] = 485,
		["555"] = 492,
		["557"] = 492,
		["559"] = 552,
		["560"] = 560,
		["561"] = 552,
		["562"] = 560,
		["563"] = 562,
		["564"] = 563,
		["565"] = 562,
		["566"] = 565,
		["567"] = 566,
		["568"] = 567,
		["569"] = 567,
		["570"] = 567,
		["571"] = 567,
		["572"] = 567,
		["573"] = 568,
		["574"] = 568,
		["575"] = 568,
		["576"] = 568,
		["577"] = 568,
		["578"] = 569,
		["579"] = 569,
		["580"] = 569,
		["581"] = 569,
		["582"] = 569,
		["583"] = 569,
		["584"] = 569,
		["585"] = 569,
		["587"] = 565,
		["588"] = 572,
		["589"] = 573,
		["590"] = 572,
		["591"] = 577,
		["592"] = 578,
		["593"] = 577,
		["594"] = 560,
		["595"] = 552,
		["596"] = 552,
		["597"] = 552,
		["598"] = 552,
		["599"] = 552,
		["600"] = 552,
		["601"] = 552,
		["602"] = 560,
		["604"] = 560,
		["606"] = 583,
		["607"] = 591,
		["608"] = 583,
		["609"] = 591,
		["610"] = 595,
		["611"] = 596,
		["612"] = 597,
		["613"] = 599,
		["614"] = 595,
		["615"] = 601,
		["616"] = 602,
		["617"] = 603,
		["618"] = 604,
		["619"] = 605,
		["622"] = 601,
		["623"] = 609,
		["624"] = 610,
		["625"] = 611,
		["626"] = 612,
		["627"] = 613,
		["629"] = 615,
		["631"] = 609,
		["632"] = 591,
		["633"] = 583,
		["634"] = 583,
		["635"] = 583,
		["636"] = 583,
		["637"] = 583,
		["638"] = 583,
		["639"] = 583,
		["640"] = 591,
		["642"] = 591,
		["644"] = 620,
		["645"] = 627,
		["646"] = 620,
		["647"] = 627,
		["648"] = 628,
		["649"] = 629,
		["650"] = 630,
		["651"] = 631,
		["653"] = 628,
		["654"] = 634,
		["655"] = 635,
		["656"] = 636,
		["657"] = 637,
		["659"] = 634,
		["660"] = 640,
		["661"] = 641,
		["662"] = 640,
		["663"] = 645,
		["664"] = 646,
		["665"] = 645,
		["666"] = 627,
		["667"] = 620,
		["668"] = 620,
		["669"] = 620,
		["670"] = 620,
		["671"] = 620,
		["672"] = 620,
		["673"] = 620,
		["674"] = 627,
		["676"] = 627,
		["678"] = 651,
		["679"] = 659,
		["680"] = 651,
		["681"] = 659,
		["682"] = 662,
		["683"] = 663,
		["684"] = 664,
		["685"] = 662,
		["686"] = 666,
		["687"] = 667,
		["688"] = 668,
		["690"] = 666,
		["691"] = 671,
		["692"] = 672,
		["693"] = 673,
		["694"] = 673,
		["695"] = 672,
		["696"] = 671,
		["697"] = 676,
		["698"] = 677,
		["699"] = 676,
		["700"] = 679,
		["701"] = 680,
		["702"] = 681,
		["703"] = 682,
		["704"] = 683,
		["705"] = 684,
		["706"] = 686,
		["707"] = 686,
		["708"] = 686,
		["709"] = 686,
		["710"] = 686,
		["711"] = 686,
		["712"] = 686,
		["713"] = 686,
		["714"] = 686,
		["715"] = 687,
		["716"] = 688,
		["717"] = 689,
		["718"] = 690,
		["719"] = 691,
		["720"] = 691,
		["721"] = 691,
		["722"] = 691,
		["723"] = 691,
		["724"] = 691,
		["725"] = 691,
		["726"] = 691,
		["728"] = 693,
		["730"] = 679,
		["731"] = 659,
		["732"] = 651,
		["733"] = 651,
		["734"] = 651,
		["735"] = 651,
		["736"] = 651,
		["737"] = 651,
		["738"] = 651,
		["739"] = 659,
		["741"] = 659,
		["742"] = 699,
		["743"] = 706,
		["744"] = 699,
		["745"] = 706,
		["746"] = 708,
		["747"] = 709,
		["748"] = 708,
		["749"] = 711,
		["750"] = 712,
		["751"] = 713,
		["753"] = 715,
		["754"] = 715,
		["755"] = 715,
		["756"] = 715,
		["757"] = 715,
		["758"] = 716,
		["759"] = 716,
		["760"] = 716,
		["761"] = 716,
		["762"] = 716,
		["763"] = 716,
		["764"] = 716,
		["765"] = 716,
		["767"] = 711,
		["768"] = 719,
		["769"] = 720,
		["770"] = 721,
		["772"] = 719,
		["773"] = 724,
		["774"] = 725,
		["775"] = 724,
		["776"] = 729,
		["777"] = 730,
		["778"] = 729,
		["779"] = 706,
		["780"] = 699,
		["781"] = 699,
		["782"] = 699,
		["783"] = 699,
		["784"] = 699,
		["785"] = 699,
		["786"] = 699,
		["787"] = 706,
		["789"] = 706,
	}
)
local j = {}
local k = require("lib.dota_ts_adapter")
local l = k.BaseAbility
local m = k.registerAbility
local n = require("modifiers.eom_modifier")
local o = n.EOMModifier
local p = n.registerEOMModifier
j.sect_injury = c()
local q = j.sect_injury
q.name = "sect_injury"
d(q, l)
function q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.r_158_record = 0
end
function q.prototype.GetAbilitySpecialValue(self)
	self.injury_count_bonus = self:GetSpecialValueFor("injury_count_bonus")
	self.n_84_chance = self:GetSectSpecialValueFor("84", "n_84_chance")
	self.n_84_poison = self:GetSectSpecialValueFor("84", "n_84_poison")
	self.n_94_ice_count = self:GetSectSpecialValueFor("94", "n_94_ice_count")
	self.n_94_chance = self:GetSectSpecialValueFor("94", "n_94_chance")
	self.n_109_injury = self:GetSectSpecialValueFor("109", "n_109_injury")
	self.n_109_interval = self:GetSectSpecialValueFor("109", "n_109_interval")
	self.n_110_chance = self:GetSectSpecialValueFor("110", "n_110_chance")
	self.n_111_interval = self:GetSectSpecialValueFor("111", "n_111_interval")
	self.n_111_injury = self:GetSectSpecialValueFor("111", "n_111_injury")
	self.r_112_injury = self:GetSectSpecialValueFor("112", "r_112_injury")
	self.r_113_outgoing_damage_bonus = self:GetSectSpecialValueFor("113", "r_113_outgoing_damage_bonus")
	self.r_114_injury_per_second = self:GetSectSpecialValueFor("114", "r_114_injury_per_second")
	self.r_114_effect_1 = self:GetSectSpecialValueFor("114", "effect_1")
	self.sr_115_interval = self:GetSectSpecialValueFor("115", "sr_115_interval")
	self.n_132_chance = self:GetSectSpecialValueFor("132", "n_132_chance")
	self.n_132_injury = self:GetSectSpecialValueFor("132", "n_132_injury")
	self.sr_148_interval = self:GetSectSpecialValueFor("148", "sr_148_interval")
	self.sr_148_damage = self:GetSectSpecialValueFor("148", "sr_148_damage")
	self.r_158_injury = self:GetSectSpecialValueFor("158", "r_158_injury")
	self.r_158_damage = self:GetSectSpecialValueFor("158", "r_158_damage")
	self.sr_163_pre_injury_count = self:GetSectSpecialValueFor("163", "sr_163_pre_injury_count")
	self.n_174_chance = self:GetSectSpecialValueFor("174", "n_174_chance")
	self.n_174_chaos_count = self:GetSectSpecialValueFor("174", "n_174_chaos_count")
	self.sr_196_chance = self:GetSectSpecialValueFor("196", "sr_196_chance")
	self.sr_196_stack = self:GetSectSpecialValueFor("196", "sr_196_stack")
end
function q.prototype.Record114Time(self)
	self.r_114_record = GameRules:GetGameTime()
end
function q.prototype.TriggerByName(self, r, s)
	if s == nil then
		s = self:GetCaster():GetEnemy()
	end
	local t = self:GetCaster()
	if not IsInjurable(s, t) then
		return
	end
	repeat
		local u = r
		local v = u == "109"
		if v then
			do
				AddInjury(t, s, self.n_109_injury, "109", "AbilityUpgrade")
				break
			end
		end
		v = v or u == "196"
		if v then
			do
				AddInjury(t, s, self.sr_196_stack, "196", "AbilityUpgrade")
				break
			end
		end
		v = v or u == "84"
		if v then
			do
				AddPoison(t, s, self.n_84_poison, "84", "AbilityUpgrade")
				break
			end
		end
		v = v or u == "94"
		if v then
			do
				AddIce(t, s, self.n_94_ice_count, "94", "AbilityUpgrade")
				break
			end
		end
		v = v or u == "132"
		if v then
			do
				AddFury(t, self.n_132_injury, "132", "AbilityUpgrade")
				break
			end
		end
		v = v or u == "174"
		if v then
			do
				AddChaos(t, GetSectChaosModifiedValue(t, self.n_174_chaos_count), "174", "AbilityUpgrade")
				break
			end
		end
		v = v or u == "158"
		if v then
			do
				local w = self
				Projectile:CreateTrackingProjectile({
					EffectName = "particles/units/heroes/hero_visage/visage_soul_assumption_bolt6.vpcf",
					hCaster = t,
					hTarget = s,
					Ability = w,
					vSpawnOrigin = t:GetAttachmentPosition("attach_attack1"),
					iMoveSpeed = 1000,
					OnProjectileHit = function(x, y, z)
						if IsInjurable(t, s) then
							t:DealDamage(s, w, self.r_158_damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL, nil, "158")
							t:EmitSound("Hero_Bane.Enfeeble.Cast")
						end
					end,
				})
				break
			end
		end
		v = v or u == "148"
		if v then
			do
				local s = t:GetEnemy()
				local A = (s:GetAbsOrigin() - t:GetAbsOrigin()):Normalized()
				local B = (s:GetAbsOrigin() - t:GetAbsOrigin()):Length2D() + 100
				t:EmitSound("Hero_ShadowDemon.ShadowPoison")
				Projectile:CreateLinearProjectile({
					EffectName = "particles/econ/items/shadow_demon/sd_ti7_shadow_poison/sd_ti7_shadow_poison_proj.vpcf",
					hCaster = t,
					vSpawnOrigin = t:GetAbsOrigin(),
					vDirection = A,
					flDistance = B,
					flRadius = 150,
					iMoveSpeed = PROJECTILE_SPEED_SLOW,
					OnProjectileHit = function(x, y, z)
						if IsInjurable(x) then
							s:AddNewModifier(t, self, "modifier_sect_injury_148_debuff", {})
							t:DealDamage(s, self, self.sr_148_damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL, nil, "148")
						end
					end,
				})
				break
			end
		end
		v = v or u == "114"
		if v then
			do
				local C = math.max(0, math.floor(GameRules:GetGameTime() - self.r_114_record))
				if C > 0 then
					ParticleManager:CreateParticle(
						"particles/gameplay/sect_injury_114_tick.vpcf",
						PATTACH_ABSORIGIN_FOLLOW,
						s
					)
					local D = self.r_114_injury_per_second * C
					if self.r_114_effect_1 > 0 then
						local E = D * self.r_114_effect_1 * 0.01
						s:AddNewModifier(t, self, "modifier_sect_injury_114_effect_1", { iStackCount = E })
					end
					AddInjury(t, s, D, "114", "AbilityUpgrade")
				end
				break
			end
		end
	until true
end
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_sect_injury"
end
q = e({ m(nil) }, q)
j.sect_injury = q
j.modifier_sect_injury = c()
local F = j.modifier_sect_injury
F.name = "modifier_sect_injury"
d(F, o)
function F.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.r_158_record = 0
end
function F.prototype.GetAbilitySpecialValue(self)
	self.injury_count_bonus = self:GetAbilitySpecialValueFor("injury_count_bonus")
	self.n_84_chance = self:GetSectSpecialValueFor("84", "n_84_chance")
	self.n_84_poison = self:GetSectSpecialValueFor("84", "n_84_poison")
	self.n_94_chance = self:GetSectSpecialValueFor("94", "n_94_chance")
	self.n_109_injury = self:GetSectSpecialValueFor("109", "n_109_injury")
	self.n_109_interval = self:GetSectSpecialValueFor("109", "n_109_interval")
	self.n_110_chance = self:GetSectSpecialValueFor("110", "n_110_chance")
	self.n_111_interval = self:GetSectSpecialValueFor("111", "n_111_interval")
	self.n_111_injury = self:GetSectSpecialValueFor("111", "n_111_injury")
	self.r_112_injury = self:GetSectSpecialValueFor("112", "r_112_injury")
	self.r_113_outgoing_damage_bonus = self:GetSectSpecialValueFor("113", "r_113_outgoing_damage_bonus")
	self.r_114_interval = self:GetSectSpecialValueFor("114", "r_114_interval")
	self.r_114_injury_per_second = self:GetSectSpecialValueFor("114", "r_114_injury_per_second")
	self.sr_115_interval = self:GetSectSpecialValueFor("115", "sr_115_interval")
	self.n_132_chance = self:GetSectSpecialValueFor("132", "n_132_chance")
	self.n_132_injury = self:GetSectSpecialValueFor("132", "n_132_injury")
	self.sr_148_interval = self:GetSectSpecialValueFor("148", "sr_148_interval")
	self.sr_148_damage = self:GetSectSpecialValueFor("148", "sr_148_damage")
	self.r_158_injury = self:GetSectSpecialValueFor("158", "r_158_injury")
	self.r_158_damage = self:GetSectSpecialValueFor("158", "r_158_damage")
	self.sr_163_pre_injury_count = self:GetSectSpecialValueFor("163", "sr_163_pre_injury_count")
	self.n_174_chance = self:GetSectSpecialValueFor("174", "n_174_chance")
	self.n_174_chaos_count = self:GetSectSpecialValueFor("174", "n_174_chaos_count")
	self.sr_196_chance = self:GetSectSpecialValueFor("196", "sr_196_chance")
	self.sr_196_stack = self:GetSectSpecialValueFor("196", "sr_196_stack")
	self.trigger_chance = self:GetCustomAbilityValueFor("sect_injury_trigger", "chance")
	self.effect_value = self:GetCustomAbilityValueFor("sect_injury_effect", "value")
	self.ability:GetAbilitySpecialValue()
end
function F.prototype.OnIntervalThink(self)
	if self.n_109_injury > 0 then
		self.ability:TriggerByName("109")
	end
end
function F.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_GAINED] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function F.prototype.OnCustomTakeDamage(self, G)
	if G and IsValid(G.attacker) then
		if self.sr_196_chance > 0 and self:PRD(self.sr_196_chance, "sr_196_chance") then
			self.ability:TriggerByName("196", G.attacker)
		end
	end
end
function F.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_STACK_BONUS] = self.injury_count_bonus }
end
function F.prototype.OnBattleStartBefore(self, H)
	local I = self:GetParent()
	self.hEnemy = I:GetEnemy()
	self.r_158_record = 0
	if IsValid(self.hEnemy) then
		self.hEnemy:AddNewModifier(I, self:GetAbility(), "modifier_injury_permanent", {})
	end
	if self.n_110_chance > 0 then
		I:AddNewModifier(I, self:GetAbility(), "modifier_sect_injury_110_debuff", { iStackCount = self.n_110_chance })
	end
	if IsInjurable(self.hEnemy) then
		if self.sr_163_pre_injury_count > 0 then
			CombatLog:recordSectAbilityCast(I, "163")
			I:AddNewModifier(I, self:GetAbility(), "modifier_sect_injury_163_buff", {})
			local J = self.sr_163_pre_injury_count
			if J > 0 then
				local K = I:FindAbilityByName("sect_injury")
				if not IsValid(K) then
					K = I:AddAbility_Engine("sect_injury")
				end
				CombatLog:recordBuff(I, self.hEnemy, "injury", J, "163", "AbilityUpgrade")
				local L = self.hEnemy:FindModifierByName("modifier_shield_custom")
				if IsValid(L) then
					local M = L:GetStackCount()
					if M <= J then
						J = J - M
						L:Destroy()
					else
						L:DecrementStackCount(J)
						J = 0
					end
				end
				if J > 0 then
					self.hEnemy:AddNewModifier(I, K, "modifier_injury_custom", { iStackCount = J })
				end
				PlayerData:addDetailData(self:GetParent(), "AbilityUpgrade", "injury", J, false, "163")
			end
		end
		if self.r_113_outgoing_damage_bonus > 0 then
			self.hEnemy:AddNewModifier(I, self:GetAbility(), "modifier_sect_injury_113_debuff", nil)
		end
	end
end
function F.prototype.OnBattleStart(self, H)
	if IsServer() then
		local I = self:GetParent()
		self.hEnemy = I:GetEnemy()
		if self.n_109_interval > 0 then
			self:StartIntervalThink(self.n_109_interval)
		end
		if IsInjurable(self.hEnemy) then
			if self.r_114_interval > 0 then
				self.hEnemy:AddNewModifier(I, self:GetAbility(), "modifier_sect_injury_114_debuff", {})
				self.iParticleID = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_witchdoctor/witchdoctor_maledict.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					self.hEnemy
				)
				ParticleManager:SetParticleControl(self.iParticleID, 1, Vector(self.n_109_interval, 0, 0))
			end
			if self.sr_115_interval > 0 then
				self.hEnemy:AddNewModifier(I, self:GetAbility(), "modifier_sect_injury_115_debuff", {})
			end
			if self.sr_148_interval > 0 then
				self:StartThink(self.sr_148_interval, "sr_148_interval")
				self:OnThink("sr_148_interval")
			end
		end
	end
end
function F.prototype.OnThink(self, N)
	local I = self:GetParent()
	local O = I:GetEnemy()
	if not IsInjurable(O) then
		self:StartThink(-1, N)
		return
	end
	if N == "sr_148_interval" then
		self.ability:TriggerByName("148")
	end
end
function F.prototype.OnBattleEnd(self, H)
	if IsServer() then
		self.hEnemy = nil
		self:StartIntervalThink(-1)
		if self.iParticleID then
			ParticleManager:DestroyParticle(self.iParticleID, false)
			self.iParticleID = nil
		end
		self:StartThink(-1, "sr_148_interval")
	end
end
function F.prototype.OnInjuryGained(self, H)
	local t = self:GetParent()
	local P = t:GetEnemy()
	local w = self:GetAbility()
	if self.n_84_chance > 0 and IsValid(P) and self:PRD(self.n_84_chance, "modifier_sect_injury_84") then
		self.ability:TriggerByName("84", P)
	end
	if self.n_94_chance > 0 and IsValid(P) and self:PRD(self.n_94_chance, "modifier_sect_injury_94") then
		self.ability:TriggerByName("94", P)
	end
	if self.n_132_chance > 0 and self:PRD(self.n_132_chance, "n_132_chance") then
		self.ability:TriggerByName("132")
	end
	if self.n_174_chance > 0 and IsValid(P) and self:PRD(self.n_174_chance, "n_174_chance") then
		self.ability:TriggerByName("174")
	end
	if self.r_158_injury > 0 then
		self.r_158_record = self.r_158_record + H.iStackCount
		if self.r_158_record >= self.r_158_injury then
			self.r_158_record = self.r_158_record - self.r_158_injury
			self.ability:TriggerByName("158", P)
		end
	end
	self:customAbilityTrigger()
end
function F.prototype.customAbilityTrigger(self)
	if self:GetParent():IsNeutral() then
		return
	end
	if self:GetParent():GetHeroBase():getCustomAbilityTrigger() ~= "sect_injury" then
		return
	end
	if self.trigger_chance > 0 then
		if self.trigger_chance > 0 and self:PRD(self.trigger_chance, "trigger_chance") then
			local Q = self:GetParent():GetHeroBase():getCustomAbilityEffectModifier()
			if Q ~= nil then
				Q:customAbilityEffect()
			end
		end
	end
end
function F.prototype.customAbilityEffect(self)
	self:GetParent():GetHeroBase():addCustomAbilityTriggerCount()
	local R = AddInjury
	local S = f(self:GetParent(), self:GetParent():GetEnemy(), self.effect_value)
	local T = self:GetAbility()
	g(S, T and T:GetAbilityName() or "", "Sect")
	R(h(S))
end
F = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	F
)
j.modifier_sect_injury = F
j.modifier_sect_injury_110_debuff = c()
local U = j.modifier_sect_injury_110_debuff
U.name = "modifier_sect_injury_110_debuff"
d(U, o)
function U.prototype.OnCreated(self, H)
	if IsServer() then
		self:IncrementStackCount(H.iStackCount)
	end
end
function U.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_INJURY_PERCENTAGE }
end
function U.prototype.EOM_GetModifierIgnoreInjuryPercent(self, H)
	return self:GetStackCount()
end
U = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	U
)
j.modifier_sect_injury_110_debuff = U
j.modifier_sect_injury_163_buff = c()
local V = j.modifier_sect_injury_163_buff
V.name = "modifier_sect_injury_163_buff"
d(V, o)
function V.prototype.GetAbilitySpecialValue(self)
	self.sr_163_chance = self:GetSectSpecialValueFor("163", "sr_163_chance")
end
function V.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_ATTENUATION_PERCENTAGE }
end
function V.prototype.EOM_GetModifierInjuryAttenuationPercent(self, H)
	if H and self:PRD(self.sr_163_chance) then
		return -100
	end
end
V = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	V
)
j.modifier_sect_injury_163_buff = V
j.modifier_sect_injury_113_debuff = c()
local W = j.modifier_sect_injury_113_debuff
W.name = "modifier_sect_injury_113_debuff"
d(W, o)
function W.prototype.GetAbilitySpecialValue(self)
	self.r_113_outgoing_damage_bonus = self:GetSectSpecialValueFor("113", "r_113_outgoing_damage_bonus")
end
function W.prototype.OnCreated(self, H)
	if IsClient() then
		local X = ParticleManager:CreateParticle(
			"particles/items3_fx/star_emblem.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControl(X, 1, self:GetParent():GetAbsOrigin())
		self:AddParticle(X, false, false, -1, false, false)
	end
end
function W.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_PERMANENT }
end
function W.prototype.EOM_GetModifierInjuryPermanent(self, H)
	return self.r_113_outgoing_damage_bonus
end
W = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	W
)
j.modifier_sect_injury_113_debuff = W
j.modifier_sect_injury_114_debuff = c()
local Y = j.modifier_sect_injury_114_debuff
Y.name = "modifier_sect_injury_114_debuff"
d(Y, o)
function Y.prototype.GetAbilitySpecialValue(self)
	self.r_114_interval = self:GetSectSpecialValueFor("114", "r_114_interval")
	self.r_114_injury_per_second = self:GetSectSpecialValueFor("114", "r_114_injury_per_second")
	self.r_114_effect_1 = self:GetSectSpecialValueFor("114", "effect_1")
end
function Y.prototype.OnCreated(self, H)
	if IsServer() then
		self:GetAbility():Record114Time()
		if self.r_114_interval > 0 then
			self:StartIntervalThink(self.r_114_interval)
		end
	end
end
function Y.prototype.OnIntervalThink(self)
	local Z = self:GetCaster()
	local I = self:GetParent()
	if IsInjurable(Z, I) then
		self:GetAbility():TriggerByName("114")
	else
		self:Destroy()
	end
end
Y = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	Y
)
j.modifier_sect_injury_114_debuff = Y
j.modifier_sect_injury_114_effect_1 = c()
local _ = j.modifier_sect_injury_114_effect_1
_.name = "modifier_sect_injury_114_effect_1"
d(_, o)
function _.prototype.OnCreated(self, H)
	if IsServer() then
		local a0 = H and H.iStackCount or 0
		self:IncrementStackCount(a0)
	end
end
function _.prototype.OnRefresh(self, H)
	if IsServer() then
		local a0 = H and H.iStackCount or 0
		self:IncrementStackCount(a0)
	end
end
function _.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_PERMANENT }
end
function _.prototype.EOM_GetModifierInjuryPermanent(self, H)
	return self:GetStackCount()
end
_ = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	_
)
j.modifier_sect_injury_114_effect_1 = _
j.modifier_sect_injury_115_debuff = c()
local a1 = j.modifier_sect_injury_115_debuff
a1.name = "modifier_sect_injury_115_debuff"
d(a1, o)
function a1.prototype.GetAbilitySpecialValue(self)
	self.sr_115_interval = self:GetSectSpecialValueFor("115", "sr_115_interval")
	self.sr_115_damage = self:GetSectSpecialValueFor("115", "sr_115_damage")
end
function a1.prototype.OnCreated(self, H)
	if IsServer() then
		self:StartIntervalThink(self.sr_115_interval)
	end
end
function a1.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function a1.prototype.OnBattleEnd(self)
	self:StartIntervalThink(-1)
end
function a1.prototype.OnIntervalThink(self)
	local Z = self:GetCaster()
	local I = self:GetParent()
	local a2 = I:GetAbsOrigin()
	if IsValid(Z) then
		local a3 = ParticleManager:CreateParticle(
			"particles/econ/items/zeus/arcana_chariot/zeus_arcana_thundergods_wrath_start.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControlEnt(a3, 0, I, PATTACH_ABSORIGIN_FOLLOW, nil, a2, false)
		ParticleManager:SetParticleControl(a3, 1, a2)
		ParticleManager:SetParticleControl(a3, 2, a2)
		ParticleManager:SetParticleControl(a3, 3, a2)
		Z:EmitSound("Hero_Razor.Storm.Cast")
		Z:DealDamage(
			I,
			self:GetAbility(),
			self.sr_115_damage,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
			DamageFlags.DAMAGE_FLAG_REFLECTION
				+ DamageFlags.DAMAGE_FLAG_HPLOSS
				+ DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING
				+ DamageFlags.DAMAGE_FLAG_KEEP_INJURY_COUNT,
			"115"
		)
	else
		self:Destroy()
	end
end
a1 = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	a1
)
j.modifier_sect_injury_115_debuff = a1
j.modifier_sect_injury_148_debuff = c()
local a4 = j.modifier_sect_injury_148_debuff
a4.name = "modifier_sect_injury_148_debuff"
d(a4, o)
function a4.prototype.GetAbilitySpecialValue(self)
	self.sr_148_injury = self:GetSectSpecialValueFor("148", "sr_148_injury")
end
function a4.prototype.OnCreated(self, H)
	if IsServer() then
		self:SetStackCount(1)
	else
		local X = ParticleManager:CreateParticle(
			"particles/sect/sect_injury_148.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		self:AddParticle(X, false, false, -1, false, false)
	end
end
function a4.prototype.OnRefresh(self, H)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function a4.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_PERMANENT }
end
function a4.prototype.EOM_GetModifierInjuryPermanent(self, H)
	return self.sr_148_injury * self:GetStackCount()
end
a4 = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	a4
)
j.modifier_sect_injury_148_debuff = a4
return j