--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/ringmaster"
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
		["14"] = 3,
		["15"] = 3,
		["16"] = 3,
		["17"] = 6,
		["18"] = 7,
		["19"] = 6,
		["20"] = 7,
		["21"] = 8,
		["22"] = 9,
		["23"] = 8,
		["24"] = 7,
		["25"] = 6,
		["26"] = 7,
		["28"] = 7,
		["29"] = 13,
		["30"] = 21,
		["31"] = 13,
		["32"] = 21,
		["34"] = 21,
		["35"] = 37,
		["36"] = 38,
		["37"] = 50,
		["38"] = 51,
		["39"] = 13,
		["40"] = 52,
		["41"] = 53,
		["42"] = 52,
		["43"] = 55,
		["44"] = 56,
		["45"] = 57,
		["46"] = 58,
		["47"] = 59,
		["48"] = 60,
		["49"] = 61,
		["50"] = 62,
		["51"] = 63,
		["52"] = 65,
		["53"] = 67,
		["54"] = 69,
		["55"] = 71,
		["56"] = 72,
		["57"] = 73,
		["58"] = 74,
		["59"] = 75,
		["60"] = 76,
		["61"] = 77,
		["62"] = 55,
		["63"] = 79,
		["64"] = 80,
		["65"] = 81,
		["66"] = 82,
		["67"] = 83,
		["68"] = 85,
		["69"] = 85,
		["70"] = 85,
		["71"] = 86,
		["72"] = 86,
		["74"] = 85,
		["75"] = 85,
		["77"] = 79,
		["78"] = 90,
		["79"] = 91,
		["80"] = 91,
		["82"] = 90,
		["83"] = 93,
		["84"] = 94,
		["85"] = 95,
		["86"] = 96,
		["87"] = 97,
		["88"] = 98,
		["91"] = 101,
		["92"] = 93,
		["93"] = 103,
		["94"] = 104,
		["95"] = 104,
		["96"] = 104,
		["97"] = 107,
		["98"] = 107,
		["99"] = 107,
		["100"] = 104,
		["101"] = 108,
		["102"] = 108,
		["103"] = 108,
		["104"] = 104,
		["105"] = 104,
		["106"] = 103,
		["107"] = 111,
		["108"] = 112,
		["109"] = 113,
		["110"] = 113,
		["111"] = 113,
		["113"] = 113,
		["114"] = 114,
		["115"] = 115,
		["116"] = 116,
		["117"] = 117,
		["118"] = 118,
		["119"] = 119,
		["120"] = 120,
		["121"] = 122,
		["122"] = 123,
		["123"] = 123,
		["124"] = 123,
		["125"] = 123,
		["126"] = 123,
		["127"] = 123,
		["129"] = 127,
		["131"] = 129,
		["132"] = 111,
		["133"] = 131,
		["134"] = 132,
		["135"] = 133,
		["136"] = 135,
		["137"] = 136,
		["139"] = 139,
		["140"] = 140,
		["142"] = 131,
		["143"] = 143,
		["144"] = 144,
		["145"] = 145,
		["146"] = 146,
		["147"] = 147,
		["148"] = 148,
		["150"] = 150,
		["151"] = 151,
		["153"] = 153,
		["154"] = 154,
		["157"] = 157,
		["160"] = 160,
		["161"] = 161,
		["162"] = 163,
		["163"] = 164,
		["165"] = 167,
		["166"] = 168,
		["167"] = 169,
		["168"] = 170,
		["169"] = 171,
		["170"] = 171,
		["171"] = 171,
		["172"] = 172,
		["173"] = 171,
		["174"] = 171,
		["177"] = 176,
		["178"] = 143,
		["179"] = 179,
		["180"] = 180,
		["181"] = 181,
		["182"] = 182,
		["185"] = 183,
		["188"] = 184,
		["189"] = 184,
		["190"] = 184,
		["191"] = 184,
		["192"] = 185,
		["193"] = 186,
		["194"] = 186,
		["195"] = 186,
		["196"] = 186,
		["197"] = 186,
		["198"] = 186,
		["199"] = 186,
		["200"] = 186,
		["202"] = 179,
		["203"] = 189,
		["204"] = 190,
		["205"] = 191,
		["206"] = 192,
		["207"] = 192,
		["208"] = 192,
		["209"] = 192,
		["210"] = 192,
		["211"] = 192,
		["212"] = 192,
		["213"] = 193,
		["216"] = 194,
		["217"] = 195,
		["218"] = 196,
		["219"] = 197,
		["220"] = 199,
		["221"] = 200,
		["222"] = 200,
		["223"] = 200,
		["224"] = 200,
		["225"] = 200,
		["226"] = 200,
		["229"] = 203,
		["230"] = 204,
		["232"] = 189,
		["233"] = 207,
		["234"] = 208,
		["235"] = 209,
		["238"] = 212,
		["239"] = 213,
		["240"] = 214,
		["241"] = 215,
		["242"] = 216,
		["243"] = 217,
		["244"] = 217,
		["245"] = 217,
		["246"] = 217,
		["247"] = 217,
		["248"] = 217,
		["249"] = 217,
		["250"] = 217,
		["254"] = 207,
		["255"] = 222,
		["256"] = 223,
		["257"] = 224,
		["260"] = 227,
		["261"] = 228,
		["262"] = 229,
		["263"] = 230,
		["265"] = 232,
		["266"] = 233,
		["267"] = 234,
		["268"] = 235,
		["269"] = 236,
		["270"] = 237,
		["271"] = 238,
		["272"] = 238,
		["273"] = 238,
		["274"] = 238,
		["275"] = 238,
		["276"] = 238,
		["277"] = 238,
		["281"] = 222,
		["282"] = 244,
		["283"] = 245,
		["284"] = 246,
		["285"] = 247,
		["288"] = 250,
		["289"] = 251,
		["290"] = 251,
		["291"] = 251,
		["292"] = 251,
		["293"] = 251,
		["294"] = 252,
		["295"] = 252,
		["296"] = 252,
		["297"] = 252,
		["298"] = 252,
		["299"] = 253,
		["300"] = 253,
		["301"] = 253,
		["302"] = 254,
		["303"] = 255,
		["304"] = 253,
		["305"] = 253,
		["306"] = 257,
		["307"] = 258,
		["308"] = 258,
		["309"] = 258,
		["310"] = 258,
		["311"] = 258,
		["312"] = 258,
		["313"] = 258,
		["314"] = 244,
		["315"] = 261,
		["316"] = 262,
		["317"] = 263,
		["318"] = 264,
		["321"] = 267,
		["322"] = 268,
		["323"] = 269,
		["324"] = 270,
		["325"] = 272,
		["326"] = 273,
		["327"] = 274,
		["328"] = 274,
		["329"] = 274,
		["330"] = 274,
		["331"] = 274,
		["332"] = 274,
		["333"] = 274,
		["334"] = 274,
		["335"] = 274,
		["336"] = 274,
		["337"] = 274,
		["338"] = 274,
		["339"] = 284,
		["340"] = 285,
		["341"] = 285,
		["342"] = 285,
		["343"] = 285,
		["344"] = 285,
		["345"] = 285,
		["346"] = 285,
		["347"] = 285,
		["348"] = 285,
		["349"] = 286,
		["350"] = 286,
		["351"] = 286,
		["352"] = 286,
		["353"] = 286,
		["354"] = 287,
		["355"] = 287,
		["356"] = 287,
		["357"] = 287,
		["358"] = 287,
		["359"] = 287,
		["360"] = 287,
		["361"] = 287,
		["362"] = 287,
		["363"] = 261,
		["364"] = 289,
		["365"] = 290,
		["366"] = 291,
		["367"] = 292,
		["369"] = 294,
		["370"] = 289,
		["371"] = 296,
		["372"] = 297,
		["373"] = 296,
		["374"] = 301,
		["375"] = 302,
		["376"] = 301,
		["377"] = 21,
		["378"] = 13,
		["379"] = 13,
		["380"] = 13,
		["381"] = 13,
		["382"] = 13,
		["383"] = 13,
		["384"] = 13,
		["385"] = 13,
		["386"] = 21,
		["388"] = 21,
		["389"] = 306,
		["390"] = 314,
		["391"] = 306,
		["392"] = 314,
		["393"] = 317,
		["394"] = 318,
		["395"] = 320,
		["396"] = 317,
		["397"] = 322,
		["398"] = 323,
		["399"] = 324,
		["401"] = 322,
		["402"] = 327,
		["403"] = 328,
		["404"] = 327,
		["405"] = 330,
		["406"] = 331,
		["407"] = 330,
		["408"] = 335,
		["409"] = 336,
		["410"] = 337,
		["411"] = 338,
		["413"] = 340,
		["414"] = 335,
		["415"] = 343,
		["416"] = 344,
		["417"] = 343,
		["418"] = 314,
		["419"] = 306,
		["420"] = 306,
		["421"] = 306,
		["422"] = 306,
		["423"] = 306,
		["424"] = 306,
		["425"] = 306,
		["426"] = 306,
		["427"] = 314,
		["429"] = 314,
		["431"] = 349,
		["432"] = 356,
		["433"] = 349,
		["434"] = 356,
		["435"] = 359,
		["436"] = 360,
		["437"] = 361,
		["438"] = 362,
		["439"] = 363,
		["440"] = 363,
		["441"] = 363,
		["442"] = 363,
		["443"] = 363,
		["444"] = 363,
		["445"] = 363,
		["446"] = 363,
		["447"] = 363,
		["448"] = 365,
		["449"] = 365,
		["450"] = 365,
		["451"] = 365,
		["452"] = 365,
		["453"] = 365,
		["454"] = 365,
		["455"] = 365,
		["457"] = 359,
		["458"] = 368,
		["459"] = 369,
		["460"] = 368,
		["461"] = 371,
		["462"] = 372,
		["463"] = 372,
		["464"] = 372,
		["465"] = 372,
		["466"] = 371,
		["467"] = 374,
		["468"] = 375,
		["469"] = 376,
		["470"] = 374,
		["471"] = 378,
		["472"] = 379,
		["473"] = 378,
		["474"] = 356,
		["475"] = 349,
		["476"] = 349,
		["477"] = 349,
		["478"] = 349,
		["479"] = 349,
		["480"] = 349,
		["481"] = 349,
		["482"] = 356,
		["484"] = 356,
		["485"] = 387,
		["486"] = 388,
		["487"] = 387,
		["488"] = 388,
		["489"] = 391,
		["490"] = 392,
		["491"] = 393,
		["493"] = 395,
		["494"] = 396,
		["495"] = 397,
		["498"] = 400,
		["499"] = 401,
		["500"] = 402,
		["501"] = 402,
		["502"] = 402,
		["503"] = 402,
		["504"] = 402,
		["505"] = 402,
		["506"] = 402,
		["507"] = 402,
		["508"] = 402,
		["509"] = 403,
		["510"] = 403,
		["511"] = 404,
		["512"] = 405,
		["513"] = 408,
		["514"] = 409,
		["515"] = 410,
		["517"] = 413,
		["518"] = 413,
		["519"] = 413,
		["520"] = 414,
		["521"] = 415,
		["522"] = 416,
		["524"] = 418,
		["525"] = 413,
		["526"] = 413,
		["527"] = 391,
		["528"] = 421,
		["529"] = 422,
		["530"] = 423,
		["531"] = 424,
		["534"] = 427,
		["535"] = 428,
		["536"] = 428,
		["537"] = 428,
		["538"] = 428,
		["539"] = 428,
		["540"] = 428,
		["541"] = 428,
		["542"] = 428,
		["543"] = 428,
		["544"] = 429,
		["545"] = 429,
		["546"] = 429,
		["547"] = 429,
		["548"] = 429,
		["549"] = 429,
		["550"] = 429,
		["551"] = 429,
		["552"] = 429,
		["553"] = 430,
		["554"] = 432,
		["555"] = 433,
		["556"] = 433,
		["557"] = 433,
		["558"] = 433,
		["559"] = 433,
		["560"] = 434,
		["561"] = 435,
		["562"] = 437,
		["563"] = 438,
		["564"] = 440,
		["565"] = 441,
		["566"] = 442,
		["568"] = 445,
		["569"] = 446,
		["570"] = 447,
		["571"] = 448,
		["573"] = 450,
		["574"] = 451,
		["575"] = 452,
		["577"] = 455,
		["578"] = 456,
		["579"] = 457,
		["580"] = 458,
		["581"] = 458,
		["582"] = 458,
		["583"] = 458,
		["584"] = 458,
		["585"] = 458,
		["586"] = 458,
		["588"] = 460,
		["589"] = 460,
		["590"] = 460,
		["591"] = 460,
		["592"] = 460,
		["593"] = 460,
		["594"] = 460,
		["595"] = 460,
		["596"] = 460,
		["597"] = 469,
		["598"] = 469,
		["599"] = 469,
		["600"] = 469,
		["601"] = 469,
		["602"] = 469,
		["603"] = 469,
		["604"] = 421,
		["605"] = 471,
		["606"] = 472,
		["607"] = 471,
		["608"] = 388,
		["609"] = 387,
		["610"] = 388,
		["612"] = 388,
		["613"] = 477,
		["614"] = 485,
		["615"] = 477,
		["616"] = 485,
		["618"] = 485,
		["619"] = 492,
		["620"] = 477,
		["621"] = 493,
		["622"] = 494,
		["623"] = 493,
		["624"] = 496,
		["625"] = 497,
		["626"] = 498,
		["628"] = 496,
		["629"] = 501,
		["630"] = 502,
		["633"] = 503,
		["634"] = 504,
		["637"] = 507,
		["638"] = 508,
		["639"] = 508,
		["640"] = 508,
		["641"] = 508,
		["642"] = 508,
		["643"] = 508,
		["644"] = 508,
		["645"] = 508,
		["646"] = 508,
		["647"] = 509,
		["648"] = 509,
		["649"] = 509,
		["650"] = 509,
		["651"] = 509,
		["652"] = 510,
		["653"] = 510,
		["654"] = 510,
		["655"] = 510,
		["656"] = 510,
		["657"] = 511,
		["658"] = 511,
		["659"] = 511,
		["660"] = 511,
		["661"] = 511,
		["662"] = 512,
		["663"] = 512,
		["664"] = 512,
		["665"] = 512,
		["666"] = 512,
		["667"] = 514,
		["668"] = 515,
		["669"] = 515,
		["670"] = 515,
		["671"] = 515,
		["672"] = 515,
		["673"] = 515,
		["674"] = 515,
		["675"] = 515,
		["676"] = 515,
		["677"] = 516,
		["678"] = 516,
		["679"] = 516,
		["680"] = 516,
		["681"] = 516,
		["682"] = 517,
		["683"] = 517,
		["684"] = 517,
		["685"] = 517,
		["686"] = 517,
		["687"] = 518,
		["688"] = 518,
		["689"] = 518,
		["690"] = 518,
		["691"] = 518,
		["692"] = 519,
		["693"] = 519,
		["694"] = 519,
		["695"] = 519,
		["696"] = 519,
		["697"] = 520,
		["698"] = 520,
		["699"] = 525,
		["700"] = 501,
		["701"] = 527,
		["702"] = 528,
		["703"] = 529,
		["705"] = 530,
		["706"] = 530,
		["707"] = 531,
		["708"] = 532,
		["709"] = 533,
		["710"] = 533,
		["711"] = 533,
		["712"] = 533,
		["713"] = 533,
		["714"] = 533,
		["715"] = 533,
		["716"] = 533,
		["717"] = 533,
		["718"] = 534,
		["719"] = 535,
		["720"] = 536,
		["721"] = 537,
		["723"] = 539,
		["724"] = 540,
		["725"] = 541,
		["727"] = 530,
		["731"] = 545,
		["734"] = 527,
		["735"] = 549,
		["736"] = 550,
		["737"] = 551,
		["738"] = 551,
		["739"] = 550,
		["740"] = 549,
		["741"] = 554,
		["742"] = 555,
		["743"] = 556,
		["744"] = 557,
		["745"] = 558,
		["746"] = 559,
		["747"] = 560,
		["749"] = 562,
		["752"] = 565,
		["754"] = 566,
		["755"] = 566,
		["756"] = 567,
		["757"] = 568,
		["758"] = 569,
		["759"] = 570,
		["760"] = 566,
		["763"] = 572,
		["765"] = 554,
		["766"] = 485,
		["767"] = 477,
		["768"] = 477,
		["769"] = 477,
		["770"] = 477,
		["771"] = 477,
		["772"] = 477,
		["773"] = 477,
		["774"] = 477,
		["775"] = 485,
		["777"] = 485,
		["779"] = 578,
		["780"] = 586,
		["781"] = 578,
		["782"] = 586,
		["783"] = 587,
		["784"] = 588,
		["785"] = 589,
		["786"] = 590,
		["788"] = 587,
		["789"] = 594,
		["790"] = 595,
		["791"] = 596,
		["792"] = 597,
		["794"] = 594,
		["795"] = 600,
		["796"] = 601,
		["797"] = 602,
		["798"] = 603,
		["800"] = 600,
		["801"] = 606,
		["802"] = 607,
		["803"] = 606,
		["804"] = 609,
		["805"] = 610,
		["806"] = 609,
		["807"] = 586,
		["808"] = 578,
		["809"] = 578,
		["810"] = 578,
		["811"] = 578,
		["812"] = 578,
		["813"] = 578,
		["814"] = 578,
		["815"] = 578,
		["816"] = 586,
		["818"] = 586,
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
g.ringmaster_talent = c()
local q = g.ringmaster_talent
q.name = "ringmaster_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_ringmaster_talent"
end
q = e({ j(nil) }, q)
g.ringmaster_talent = q
g.modifier_ringmaster_talent = c()
local r = g.modifier_ringmaster_talent
r.name = "modifier_ringmaster_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.lost_health_pct = 0
	self.battling = false
	self.g_delta = 0
	self.tick = 0.1
end
function r.prototype.GetTexture(self)
	return "ringmaster_talent_count"
end
function r.prototype.GetAbilitySpecialValue(self)
	self.round_count = self:GetAbilitySpecialValueFor("round_count")
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
	self.seat_poison = self:GetAbilitySpecialValueFor("seat_poison")
	self.ring_tick = self:GetAbilitySpecialValueFor("ring_tick")
	self.ring_tick2 = self:GetAbilitySpecialValueFor("ring_tick2")
	self.ring_poison = self:GetAbilitySpecialValueFor("ring_poison")
	self.car_chance = self:GetAbilitySpecialValueFor("car_chance")
	self.poison_reduce = self:GetAbilitySpecialValueFor("poison_reduce")
	self.tl1_level_factor = self:GetAbilityTalentValue("ringmaster_talent_1", "level_factor")
	self.tl2_count = self:GetAbilityTalentValue("ringmaster_talent_2", "count")
	self.tl3_bonus_pct = self:GetAbilityTalentValue("ringmaster_talent_3", "bonus_pct")
	self.tl5_chance = self:GetAbilityTalentValue("ringmaster_talent_5", "chance")
	self.s_base = self:GetAbilityTalentValue("ringmaster_shard", "base")
	self.s_duration = self:GetAbilityTalentValue("ringmaster_shard", "duration")
	local s = IsServer() and PlayerData:getTraitAbility(self:GetParent():GetPlayerOwnerID()) or nil
	self.g_stack_add = (s and s:GetAbilityName()) == "trait_197" and s:GetSpecialValueFor("stack_add") or 0
	self.g_stack_lose = (s and s:GetAbilityName()) == "trait_197" and s:GetSpecialValueFor("stack_lose") or 0
	self.g_health_add = (s and s:GetAbilityName()) == "trait_197" and s:GetSpecialValueFor("health_add") or 0
end
function r.prototype.OnCreated(self, t)
	if IsServer() then
		self.wheel_record = 0
		self.wheel_sec_record = 0
		self:SetStackCount(self:LoadStack())
		self.damage_hook = self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE, function(u, v, w, x)
			if x == self:GetParent() then
				self:OnCustomTakeDamage(v)
			end
		end)
	end
end
function r.prototype.OnDestroy(self)
	if IsServer() and self.damage_hook ~= nil then
		self:unhook(self.damage_hook)
	end
end
function r.prototype.LoadStack(self)
	local y = Rounds:getCurrentRound() * self.round_count
	if self.tl1_level_factor > 0 then
		local z = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
		if z then
			y = y + math.floor(self.tl1_level_factor * z:getLevel())
		end
	end
	return math.max(y + self.tl2_count + self.g_delta, 0)
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_POISON_GAINED] = { self:GetParent(), -1 },
	}
end
function r.prototype.OnBattleStartBefore(self, t)
	local A = self:GetParent():GetPlayerOwnerID()
	local B = PlayerData:loadData(A, "ringmaster_g_delta")
	if B == nil then
		B = 0
	end
	self.g_delta = B
	local C = self:LoadStack()
	self.wheel_record = 0
	self.wheel_sec_record = 0
	self:SetStackCount(C)
	self.lost_health_pct = 0
	self.battling = false
	self:GetParent():RemoveModifierByName("modifier_ringmaster_shard_buff")
	if C >= self.threshold then
		self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_ringmaster_talent_souvenir",
			{ souvenirCount = C }
		)
	else
		self:GetParent():RemoveModifierByName("modifier_ringmaster_talent_souvenir")
	end
	self:GetParent():SetHealth(self:GetParent():GetMaxHealth())
end
function r.prototype.OnBattleStart(self, t)
	self.battling = true
	local C = self:GetStackCount()
	if C >= self.threshold * 2 then
		self:WhoopeeCushion()
	end
	if C >= self.threshold * 3 then
		self:WonderWheel()
	end
end
function r.prototype.OnBattleEnd(self, t)
	self.battling = false
	self.lost_health_pct = 0
	self:GetParent():RemoveModifierByName("modifier_ringmaster_shard_buff")
	if self.wheel_particle ~= nil then
		ParticleManager:DestroyParticle(self.wheel_particle, false)
	end
	if IsValid(self.wheel_dummy) then
		self.wheel_dummy:RemoveSelf()
	end
	self:StartIntervalThink(-1)
	if t.isNeutral then
		return
	end
	if self.parent:IsCustomIllusion() then
		return
	end
	local A = self:GetParent():GetPlayerOwnerID()
	if t.winPlayerID == A then
		self.g_delta = self.g_delta + self.g_stack_add
		PlayerData:saveData(A, "ringmaster_g_delta", self.g_delta)
	else
		local y = self:GetStackCount()
		if y >= self.g_stack_lose then
			self.g_delta = self.g_delta - self.g_stack_lose
			PlayerData:saveData(A, "ringmaster_g_delta", self.g_delta)
			GameTimer(0, function()
				PlayerData:modifyHealth(A, self.g_health_add, false, true)
			end)
		end
	end
	self:SetStackCount(self:LoadStack())
end
function r.prototype.TransferPoison(self)
	local D = self:GetParent()
	local E = D:GetEnemy()
	if self:GetStackCount() < self.threshold * 4 or not IsInjurable(D, E) then
		return
	end
	if not self:PRD(self.car_chance, "car_chance") then
		return
	end
	local C = ReducePoison(D, GetPoison(D) * self.poison_reduce * 0.01)
	if C > 0 then
		AddPoison(D, E, C, "ringmaster_talent", "Ability", PoisonFlags.POISON_FLAG_IGNORE_ADJUST)
	end
end
function r.prototype.OnCustomTakeDamage(self, v)
	local D = self:GetParent()
	local C = self:GetStackCount()
	local F = math.max(0, math.min(v.damage, v.original_health - D:GetHealth()))
	if not self.battling or D:PassivesDisabled() or F <= 0 or not IsInjurable(D) then
		return
	end
	if self.s_base > 0 and C > 0 then
		self.lost_health_pct = self.lost_health_pct + F / D:GetMaxHealth() * 100
		local G = self.s_base / C
		if self.lost_health_pct >= G then
			self.lost_health_pct = self.lost_health_pct % G
			D:AddNewModifier(D, self:GetAbility(), "modifier_ringmaster_shard_buff", { duration = self.s_duration })
		end
	end
	if v.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_POISON then
		self:TransferPoison()
	end
end
function r.prototype.OnPoisonGained(self, t)
	if self.tl5_chance > 0 then
		if t.flag and bit.band(t.flag, PoisonFlags.POISON_FLAG_NO_EXTRA) == PoisonFlags.POISON_FLAG_NO_EXTRA then
			return
		end
		local H = self:GetStackCount() * self.tl5_chance
		if self:PRD(H, "tl5_chance") then
			local D = self:GetParent()
			local E = D:GetEnemy()
			if IsInjurable(D, E) then
				AddPoison(
					D,
					E,
					t.iStackCount,
					"ringmaster_talent_5",
					"Ability",
					PoisonFlags.POISON_FLAG_IGNORE_ADJUST + PoisonFlags.POISON_FLAG_NO_EXTRA
				)
			end
		end
	end
end
function r.prototype.OnIntervalThink(self)
	if IsServer() then
		if self:GetParent():PassivesDisabled() then
			return
		end
		self.wheel_record = self.wheel_record + self.tick
		if self.wheel_record >= self.ring_tick then
			self.wheel_record = 0
			self:WhoopeeCushion()
		end
		self.wheel_sec_record = self.wheel_sec_record + self.tick
		if self.wheel_sec_record >= self.ring_tick2 then
			self.wheel_sec_record = 0
			local D = self:GetParent()
			local E = D:GetEnemy()
			if IsInjurable(D, E) then
				AddPoison(D, E, self:GetStackCountBonusValue(self.ring_poison), "ringmaster_talent_wheel", "Ability")
			end
		end
	end
end
function r.prototype.WhoopeeCushion(self)
	local D = self:GetParent()
	local E = D:GetEnemy()
	if not IsInjurable(D, E) then
		return
	end
	local I = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ringmaster/ringmaster_innate_whoopee_cushion.vpcf",
		PATTACH_CUSTOMORIGIN,
		D
	)
	ParticleManager:SetParticleControl(I, 0, E:GetAbsOrigin())
	ParticleManager:SetParticleControl(I, 1, Vector(200, 0, 0))
	GameTimer(1, function()
		ParticleManager:DestroyParticle(I, false)
		ParticleManager:ReleaseParticleIndex(I)
	end)
	E:EmitSound("Hero_Ringmaster.WhoopeeCushion.Cast")
	AddPoison(D, E, self:GetStackCountBonusValue(self.seat_poison), "ringmaster_talent_cushion", "Ability")
end
function r.prototype.WonderWheel(self)
	local D = self:GetParent()
	local E = D:GetEnemy()
	if not IsInjurable(D, E) then
		return
	end
	self:StartIntervalThink(self.tick)
	local J = D:GetAbsOrigin() - E:GetAbsOrigin()
	J.z = 0
	J = J:Normalized()
	local K = E:GetAbsOrigin() + J * -200
	E:EmitSound("Hero_Ringmaster.FunhouseMirror.Cast")
	self.wheel_dummy = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{
			origin = K,
			model = Wearable:getReplaceUnitModel(D, "models/heroes/ringmaster/ringmaster_wheel_decoy.vmdl"),
			StartingAnim = "ACT_DOTA_SPAWN",
			StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
			IdleAnim = "ACT_DOTA_IDLE",
			scale = "1",
			angles = VectorToAngles(J),
		}
	)
	self.wheel_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ringmaster/ringmaster_ult_trap.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil,
		D
	)
	ParticleManager:SetParticleControlEnt(
		self.wheel_particle,
		0,
		self.wheel_dummy,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		self.wheel_dummy:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(self.wheel_particle, 3, Vector(100, 100, 100))
	ParticleManager:SetParticleControlEnt(
		self.wheel_particle,
		4,
		self.wheel_dummy,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		self.wheel_dummy:GetAbsOrigin(),
		true
	)
end
function r.prototype.GetStackCountBonusValue(self, L)
	local C = self:GetStackCount()
	if self.tl3_bonus_pct > 0 then
		C = C * (1 + self.tl3_bonus_pct * 0.01)
	end
	return L * C
end
function r.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function r.prototype.GetActivityTranslationModifiers(self)
	return "walk"
end
r = e(
	{
		m(
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
	r
)
g.modifier_ringmaster_talent = r
g.modifier_ringmaster_talent_souvenir = c()
local M = g.modifier_ringmaster_talent_souvenir
M.name = "modifier_ringmaster_talent_souvenir"
d(M, l)
function M.prototype.GetAbilitySpecialValue(self)
	self.water_health = self:GetAbilitySpecialValueFor("water_health")
	self.tl3_bonus_pct = self:GetAbilityTalentValue("ringmaster_talent_3", "bonus_pct")
end
function M.prototype.OnCreated(self, t)
	if IsServer() then
		self:SetStackCount(t and t.souvenirCount or 0)
	end
end
function M.prototype.OnRefresh(self, t)
	self:OnCreated(t)
end
function M.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function M.prototype.GetStackCountBonusValue(self, L)
	local C = self:GetStackCount()
	if self.tl3_bonus_pct > 0 then
		C = C * (1 + self.tl3_bonus_pct * 0.01)
	end
	return L * C
end
function M.prototype.EOM_GetModifierHealthBonus(self, t)
	return self:GetStackCountBonusValue(self.water_health)
end
M = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	M
)
g.modifier_ringmaster_talent_souvenir = M
g.modifier_ringmaster_shard_buff = c()
local N = g.modifier_ringmaster_shard_buff
N.name = "modifier_ringmaster_shard_buff"
d(N, l)
function N.prototype.OnCreated(self)
	if IsServer() then
		local D = self:GetParent()
		local O = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_ringmaster/ringmaster_escape_act_target.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			D
		)
		ParticleManager:SetParticleControlEnt(O, 0, D, PATTACH_ABSORIGIN_FOLLOW, nil, D:GetAbsOrigin(), true)
		self:AddParticle(O, false, false, -1, false, false)
	end
end
function N.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE }
end
function N.prototype.GetModifierModelChange(self)
	return Wearable:getReplaceUnitModel(self:GetParent(), "models/heroes/ringmaster/ringmaster_box.vmdl")
end
function N.prototype.GetAbilitySpecialValue(self)
	self.damage_reduce = self:GetAbilityTalentValue("ringmaster_shard", "damage_reduce")
	self.damage_pct = self:GetAbilityTalentValue("ringmaster_shard", "damage_pct")
end
function N.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE] = -self.damage_reduce,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE] = self.damage_pct,
	}
end
N = e(
	{ m(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	N
)
g.modifier_ringmaster_shard_buff = N
g.ringmaster_ult = c()
local P = g.ringmaster_ult
P.name = "ringmaster_ult"
d(P, o)
function P.prototype.OnSpellStart(self)
	if self.castingParticleList == nil then
		self.castingParticleList = {}
	end
	local Q = self:GetCaster()
	local E = Q:GetEnemy()
	if not IsInjurable(Q, E) then
		return
	end
	local R = self:GetSpecialValueFor("delay")
	local I = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ringmaster/ringmaster_whip_twirl.vpcf",
		PATTACH_CUSTOMORIGIN,
		Q
	)
	ParticleManager:SetParticleControlEnt(I, 0, Q, PATTACH_ABSORIGIN_FOLLOW, nil, Q:GetAbsOrigin(), true)
	local S = self.castingParticleList
	S[#S + 1] = I
	Q:EmitSound("Hero_Ringmaster.Whip.Cast")
	Q:AddNewModifier(Q, self, "modifier_ringmaster_ult_cast", { duration = R })
	local T = Q:FindModifierByName("modifier_ringmaster_ult")
	if IsValid(T) then
		T:OnCastWhip(E)
	end
	self:GameTimer(R, function()
		if ArrayRemove(self.castingParticleList, I) then
			ParticleManager:DestroyParticle(I, false)
			ParticleManager:ReleaseParticleIndex(I)
		end
		self:Whip()
	end)
end
function P.prototype.Whip(self)
	local Q = self:GetCaster()
	local E = Q:GetEnemy()
	if not IsInjurable(Q, E) then
		return
	end
	local I = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ringmaster/ringmaster_whip.vpcf",
		PATTACH_CUSTOMORIGIN,
		Q
	)
	ParticleManager:SetParticleControlEnt(I, 0, Q, PATTACH_ABSORIGIN_FOLLOW, nil, Q:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(I, 1, E, PATTACH_POINT_FOLLOW, "attach_hitloc", E:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(I)
	local U = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ringmaster/ringmaster_whip_crack_impact.vpcf",
		PATTACH_ABSORIGIN,
		E,
		Q
	)
	ParticleManager:SetParticleControl(U, 1, Vector(100, 0, 0))
	ParticleManager:ReleaseParticleIndex(U)
	Q:EmitSound("Hero_Ringmaster.Whip.Target")
	local V = self:GetSpecialValueFor("damage")
	local W = self:GetSpecialValueFor("poison_count")
	local X = self:GetTalentValue("ringmaster_talent_4", "poison_pct")
	if X > 0 then
		V = V + GetPoison(E) * X * 0.01
	end
	local Y = self:GetTalentValue("ringmaster_talent_6", "stack_value")
	if Y > 0 then
		if self.stackCount == nil then
			self.stackCount = 1
		end
		local C = Q:GetModifierStackCount("modifier_ringmaster_talent", Q) or 0
		W = W + C * Y * self.stackCount
		self.stackCount = self.stackCount + 1
	end
	local Z = self:GetTalentValue("ringmaster_talent_7", "duration")
	if Z > 0 then
		local _ = self:GetTalentValue("ringmaster_talent_7", "stack")
		AddPoisonDeepen(Q, E, self, _, Z)
	end
	DamageSystem:dealDamage({
		attacker = Q,
		target = E,
		ability = self,
		damage = V,
		damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
		damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
		damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
	})
	AddPoison(Q, E, W, "ringmaster_ult", "Ability")
end
function P.prototype.GetIntrinsicModifierName(self)
	return "modifier_ringmaster_ult"
end
P = e({ p(nil) }, P)
g.ringmaster_ult = P
g.modifier_ringmaster_ult = c()
local a0 = g.modifier_ringmaster_ult
a0.name = "modifier_ringmaster_ult"
d(a0, l)
function a0.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.cast_delay = 0.2
end
function a0.prototype.GetAbilitySpecialValue(self)
	self.delay = self:GetAbilitySpecialValueFor("delay")
end
function a0.prototype.OnCreated(self, t)
	if IsServer() then
		self.castIDList = {}
	end
end
function a0.prototype.OnCastWhip(self, E)
	if IsClient() then
		return
	end
	local Q = self:GetCaster()
	if not IsInjurable(Q, E) then
		return
	end
	local a1 = ParticleManager:CreateParticle(
		"particles/ui_mouseactions/range_finder_generic_aoe.vpcf",
		PATTACH_CUSTOMORIGIN,
		Q
	)
	ParticleManager:SetParticleControlEnt(a1, 0, Q, PATTACH_ABSORIGIN_FOLLOW, nil, Q:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(a1, 1, E:GetAbsOrigin())
	ParticleManager:SetParticleControl(a1, 2, E:GetAbsOrigin())
	ParticleManager:SetParticleControl(a1, 3, Vector(300, 0, 0))
	ParticleManager:SetParticleControl(a1, 4, Vector(255, 255, 255))
	local U = ParticleManager:CreateParticle(
		"particles/ui_mouseactions/range_finder_generic_aoe.vpcf",
		PATTACH_CUSTOMORIGIN,
		Q
	)
	ParticleManager:SetParticleControlEnt(U, 0, Q, PATTACH_ABSORIGIN_FOLLOW, nil, Q:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(U, 1, E:GetAbsOrigin())
	ParticleManager:SetParticleControl(U, 2, E:GetAbsOrigin())
	ParticleManager:SetParticleControl(U, 3, Vector(150, 0, 0))
	ParticleManager:SetParticleControl(U, 4, Vector(255, 255, 255))
	local a2 = self.castIDList
	a2[#a2 + 1] = { id1 = a1, id2 = U, time = self.delay + self.cast_delay }
	self:StartIntervalThink(FRAME_TIME)
end
function a0.prototype.OnIntervalThink(self)
	if IsServer() then
		if #self.castIDList > 0 then
			do
				local a3 = #self.castIDList - 1
				while a3 >= 0 do
					self.castIDList[a3 + 1].time = self.castIDList[a3 + 1].time - FRAME_TIME
					if self.castIDList[a3 + 1].time > self.cast_delay then
						ParticleManager:SetParticleControl(
							self.castIDList[a3 + 1].id1,
							3,
							Vector(
								Clamp((self.castIDList[a3 + 1].time - self.cast_delay) * 100, 0, 100) * 150 * 0.01 + 150,
								0,
								0
							)
						)
					elseif self.castIDList[a3 + 1].time >= 0 then
						ParticleManager:DestroyParticle(self.castIDList[a3 + 1].id1, false)
						ParticleManager:ReleaseParticleIndex(self.castIDList[a3 + 1].id1)
						self.castIDList[a3 + 1].id1 = -1
					else
						ParticleManager:DestroyParticle(self.castIDList[a3 + 1].id2, false)
						ParticleManager:ReleaseParticleIndex(self.castIDList[a3 + 1].id2)
						table.remove(self.castIDList, a3 + 1)
					end
					a3 = a3 - 1
				end
			end
		else
			self:StartIntervalThink(-1)
		end
	end
end
function a0.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function a0.prototype.OnBattleEnd(self, t)
	local a4 = self:GetAbility()
	if IsValid(a4) then
		if a4.castingParticleList then
			for a5, I in ipairs(a4.castingParticleList) do
				ParticleManager:DestroyParticle(I, false)
				ParticleManager:ReleaseParticleIndex(I)
			end
			a4.castingParticleList = {}
		end
	end
	if #self.castIDList > 0 then
		do
			local a3 = 0
			while a3 < #self.castIDList do
				ParticleManager:DestroyParticle(self.castIDList[a3 + 1].id1, false)
				ParticleManager:ReleaseParticleIndex(self.castIDList[a3 + 1].id1)
				ParticleManager:DestroyParticle(self.castIDList[a3 + 1].id2, false)
				ParticleManager:ReleaseParticleIndex(self.castIDList[a3 + 1].id2)
				a3 = a3 + 1
			end
		end
		self.castIDList = {}
	end
end
a0 = e(
	{
		m(
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
	a0
)
g.modifier_ringmaster_ult = a0
g.modifier_ringmaster_ult_cast = c()
local a6 = g.modifier_ringmaster_ult_cast
a6.name = "modifier_ringmaster_ult_cast"
d(a6, l)
function a6.prototype.OnCreated(self, t)
	if IsServer() then
		self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_1)
		self:GetParent():EmitSound("Hero_Ringmaster.Whip.Channel")
	end
end
function a6.prototype.OnRefresh(self, t)
	if IsServer() then
		self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_1)
		self:GetParent():EmitSound("Hero_Ringmaster.Whip.Channel")
	end
end
function a6.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_1_END)
		self:GetParent():StopSound("Hero_Ringmaster.Whip.Channel")
	end
end
function a6.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function a6.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_CHANNEL_ABILITY_1
end
a6 = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	a6
)
g.modifier_ringmaster_ult_cast = a6
return g