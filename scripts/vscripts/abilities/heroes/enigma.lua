--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/enigma"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayMap
local g = b.__TS__ArrayIncludes
local h = b.__TS__New
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 517,
		["12"] = 1,
		["13"] = 1,
		["14"] = 1,
		["15"] = 2,
		["16"] = 2,
		["17"] = 2,
		["18"] = 3,
		["19"] = 3,
		["20"] = 3,
		["21"] = 5,
		["22"] = 8,
		["23"] = 9,
		["24"] = 8,
		["25"] = 9,
		["26"] = 10,
		["27"] = 11,
		["28"] = 10,
		["29"] = 9,
		["30"] = 8,
		["31"] = 9,
		["33"] = 9,
		["34"] = 15,
		["35"] = 23,
		["36"] = 15,
		["37"] = 23,
		["39"] = 23,
		["40"] = 24,
		["41"] = 25,
		["42"] = 26,
		["43"] = 40,
		["44"] = 41,
		["45"] = 57,
		["46"] = 64,
		["47"] = 71,
		["48"] = 81,
		["49"] = 15,
		["50"] = 82,
		["51"] = 83,
		["52"] = 82,
		["53"] = 86,
		["54"] = 87,
		["55"] = 86,
		["56"] = 90,
		["57"] = 91,
		["58"] = 90,
		["59"] = 94,
		["60"] = 95,
		["61"] = 94,
		["62"] = 98,
		["63"] = 99,
		["64"] = 100,
		["65"] = 100,
		["66"] = 100,
		["68"] = 100,
		["69"] = 101,
		["70"] = 98,
		["71"] = 104,
		["72"] = 104,
		["73"] = 108,
		["74"] = 109,
		["75"] = 108,
		["76"] = 112,
		["77"] = 114,
		["78"] = 115,
		["79"] = 116,
		["80"] = 117,
		["81"] = 118,
		["82"] = 119,
		["83"] = 121,
		["84"] = 122,
		["85"] = 124,
		["86"] = 125,
		["87"] = 126,
		["88"] = 128,
		["89"] = 130,
		["90"] = 131,
		["91"] = 133,
		["92"] = 134,
		["93"] = 135,
		["94"] = 136,
		["95"] = 137,
		["96"] = 139,
		["97"] = 142,
		["98"] = 143,
		["99"] = 144,
		["100"] = 148,
		["101"] = 112,
		["102"] = 150,
		["103"] = 151,
		["105"] = 150,
		["106"] = 160,
		["107"] = 161,
		["108"] = 160,
		["109"] = 165,
		["110"] = 166,
		["111"] = 165,
		["112"] = 169,
		["113"] = 170,
		["114"] = 169,
		["115"] = 177,
		["116"] = 178,
		["118"] = 177,
		["119"] = 186,
		["120"] = 187,
		["123"] = 190,
		["124"] = 191,
		["125"] = 192,
		["126"] = 193,
		["127"] = 193,
		["128"] = 193,
		["129"] = 193,
		["131"] = 195,
		["132"] = 195,
		["133"] = 196,
		["134"] = 195,
		["137"] = 199,
		["138"] = 200,
		["139"] = 201,
		["140"] = 201,
		["141"] = 201,
		["142"] = 202,
		["145"] = 203,
		["146"] = 203,
		["147"] = 203,
		["148"] = 203,
		["149"] = 203,
		["150"] = 203,
		["151"] = 203,
		["152"] = 205,
		["153"] = 206,
		["154"] = 207,
		["155"] = 207,
		["156"] = 207,
		["158"] = 207,
		["159"] = 208,
		["160"] = 208,
		["161"] = 208,
		["162"] = 208,
		["163"] = 208,
		["165"] = 201,
		["166"] = 201,
		["168"] = 186,
		["169"] = 213,
		["170"] = 214,
		["171"] = 215,
		["172"] = 216,
		["173"] = 217,
		["174"] = 213,
		["175"] = 220,
		["176"] = 221,
		["177"] = 222,
		["178"] = 223,
		["179"] = 224,
		["180"] = 225,
		["181"] = 225,
		["182"] = 225,
		["183"] = 225,
		["184"] = 225,
		["185"] = 225,
		["186"] = 226,
		["187"] = 226,
		["188"] = 226,
		["189"] = 226,
		["190"] = 226,
		["191"] = 226,
		["194"] = 229,
		["197"] = 230,
		["198"] = 231,
		["199"] = 232,
		["200"] = 233,
		["201"] = 234,
		["202"] = 235,
		["203"] = 235,
		["204"] = 235,
		["205"] = 235,
		["206"] = 235,
		["207"] = 235,
		["210"] = 220,
		["211"] = 241,
		["212"] = 241,
		["213"] = 241,
		["215"] = 242,
		["216"] = 243,
		["217"] = 244,
		["218"] = 245,
		["219"] = 246,
		["221"] = 247,
		["222"] = 247,
		["223"] = 248,
		["224"] = 247,
		["229"] = 241,
		["230"] = 254,
		["231"] = 254,
		["232"] = 254,
		["234"] = 255,
		["237"] = 256,
		["238"] = 257,
		["239"] = 258,
		["240"] = 260,
		["241"] = 261,
		["242"] = 262,
		["244"] = 263,
		["245"] = 263,
		["246"] = 264,
		["247"] = 264,
		["248"] = 264,
		["249"] = 264,
		["250"] = 264,
		["251"] = 264,
		["252"] = 264,
		["253"] = 264,
		["254"] = 264,
		["255"] = 265,
		["256"] = 266,
		["257"] = 266,
		["258"] = 263,
		["262"] = 271,
		["263"] = 271,
		["264"] = 271,
		["265"] = 271,
		["266"] = 272,
		["268"] = 273,
		["269"] = 273,
		["270"] = 274,
		["271"] = 275,
		["274"] = 273,
		["277"] = 279,
		["278"] = 280,
		["280"] = 283,
		["281"] = 283,
		["282"] = 283,
		["283"] = 283,
		["284"] = 283,
		["285"] = 283,
		["286"] = 283,
		["287"] = 283,
		["288"] = 283,
		["289"] = 283,
		["290"] = 283,
		["291"] = 283,
		["292"] = 283,
		["293"] = 283,
		["294"] = 283,
		["295"] = 283,
		["296"] = 283,
		["297"] = 299,
		["298"] = 299,
		["299"] = 303,
		["300"] = 305,
		["301"] = 306,
		["303"] = 254,
		["304"] = 310,
		["306"] = 311,
		["307"] = 311,
		["308"] = 312,
		["309"] = 313,
		["311"] = 311,
		["314"] = 316,
		["315"] = 317,
		["316"] = 310,
		["317"] = 320,
		["319"] = 321,
		["320"] = 321,
		["321"] = 322,
		["322"] = 323,
		["323"] = 324,
		["326"] = 321,
		["329"] = 320,
		["330"] = 23,
		["331"] = 15,
		["332"] = 15,
		["333"] = 15,
		["334"] = 15,
		["335"] = 15,
		["336"] = 15,
		["337"] = 15,
		["338"] = 15,
		["339"] = 23,
		["341"] = 23,
		["342"] = 334,
		["343"] = 335,
		["344"] = 334,
		["345"] = 335,
		["346"] = 337,
		["347"] = 338,
		["348"] = 339,
		["349"] = 340,
		["352"] = 341,
		["353"] = 342,
		["354"] = 343,
		["355"] = 344,
		["356"] = 346,
		["357"] = 347,
		["358"] = 348,
		["359"] = 337,
		["360"] = 335,
		["361"] = 334,
		["362"] = 335,
		["364"] = 335,
		["366"] = 356,
		["367"] = 365,
		["368"] = 356,
		["369"] = 365,
		["370"] = 372,
		["371"] = 373,
		["372"] = 372,
		["373"] = 375,
		["374"] = 376,
		["375"] = 377,
		["376"] = 378,
		["377"] = 375,
		["378"] = 383,
		["379"] = 384,
		["380"] = 385,
		["381"] = 386,
		["382"] = 391,
		["383"] = 392,
		["384"] = 392,
		["385"] = 392,
		["386"] = 392,
		["387"] = 392,
		["388"] = 393,
		["389"] = 393,
		["390"] = 393,
		["391"] = 393,
		["392"] = 393,
		["393"] = 393,
		["394"] = 393,
		["395"] = 393,
		["397"] = 395,
		["399"] = 383,
		["400"] = 398,
		["401"] = 399,
		["402"] = 404,
		["404"] = 398,
		["405"] = 407,
		["406"] = 408,
		["407"] = 408,
		["408"] = 408,
		["409"] = 408,
		["410"] = 408,
		["411"] = 408,
		["412"] = 409,
		["413"] = 410,
		["414"] = 410,
		["415"] = 410,
		["416"] = 410,
		["417"] = 410,
		["418"] = 410,
		["420"] = 407,
		["421"] = 413,
		["422"] = 414,
		["423"] = 415,
		["425"] = 413,
		["426"] = 365,
		["427"] = 356,
		["428"] = 356,
		["429"] = 356,
		["430"] = 356,
		["431"] = 356,
		["432"] = 356,
		["433"] = 356,
		["434"] = 356,
		["435"] = 356,
		["436"] = 365,
		["438"] = 365,
		["440"] = 421,
		["441"] = 429,
		["442"] = 421,
		["443"] = 429,
		["444"] = 433,
		["445"] = 434,
		["446"] = 435,
		["447"] = 433,
		["448"] = 437,
		["449"] = 438,
		["450"] = 440,
		["451"] = 441,
		["452"] = 442,
		["453"] = 442,
		["454"] = 442,
		["455"] = 442,
		["456"] = 442,
		["457"] = 442,
		["459"] = 444,
		["460"] = 445,
		["461"] = 445,
		["462"] = 445,
		["463"] = 445,
		["464"] = 445,
		["465"] = 446,
		["466"] = 446,
		["467"] = 446,
		["468"] = 446,
		["469"] = 446,
		["470"] = 437,
		["471"] = 465,
		["472"] = 466,
		["473"] = 467,
		["475"] = 465,
		["476"] = 429,
		["477"] = 421,
		["478"] = 421,
		["479"] = 421,
		["480"] = 421,
		["481"] = 421,
		["482"] = 421,
		["483"] = 421,
		["484"] = 421,
		["485"] = 429,
		["487"] = 429,
		["489"] = 473,
		["490"] = 481,
		["491"] = 473,
		["492"] = 481,
		["493"] = 482,
		["494"] = 483,
		["495"] = 484,
		["497"] = 482,
		["498"] = 487,
		["499"] = 488,
		["500"] = 488,
		["501"] = 488,
		["502"] = 488,
		["503"] = 488,
		["504"] = 488,
		["505"] = 489,
		["506"] = 489,
		["507"] = 489,
		["508"] = 489,
		["509"] = 489,
		["510"] = 489,
		["511"] = 487,
		["512"] = 481,
		["513"] = 473,
		["514"] = 473,
		["515"] = 473,
		["516"] = 473,
		["517"] = 473,
		["518"] = 473,
		["519"] = 473,
		["520"] = 473,
		["521"] = 481,
		["523"] = 481,
		["524"] = 496,
		["525"] = 497,
		["526"] = 498,
		["529"] = 517,
		["530"] = 517,
		["531"] = 549,
		["532"] = 532,
		["533"] = 533,
		["534"] = 534,
		["535"] = 538,
		["536"] = 540,
		["537"] = 550,
		["538"] = 551,
		["539"] = 552,
		["540"] = 553,
		["541"] = 554,
		["542"] = 555,
		["543"] = 556,
		["544"] = 559,
		["545"] = 560,
		["546"] = 561,
		["547"] = 562,
		["548"] = 563,
		["549"] = 564,
		["550"] = 549,
		["551"] = 567,
		["552"] = 568,
		["555"] = 571,
		["556"] = 571,
		["557"] = 571,
		["558"] = 571,
		["559"] = 571,
		["560"] = 571,
		["561"] = 571,
		["562"] = 571,
		["563"] = 571,
		["564"] = 571,
		["565"] = 571,
		["566"] = 571,
		["567"] = 571,
		["568"] = 583,
		["569"] = 584,
		["570"] = 585,
		["571"] = 588,
		["572"] = 589,
		["573"] = 592,
		["574"] = 593,
		["575"] = 567,
		["576"] = 596,
		["577"] = 597,
		["580"] = 598,
		["581"] = 599,
		["584"] = 602,
		["585"] = 602,
		["586"] = 602,
		["587"] = 603,
		["588"] = 604,
		["591"] = 605,
		["592"] = 606,
		["595"] = 609,
		["596"] = 602,
		["597"] = 602,
		["598"] = 596,
		["599"] = 613,
		["600"] = 614,
		["603"] = 615,
		["604"] = 616,
		["605"] = 617,
		["607"] = 619,
		["608"] = 613,
		["609"] = 622,
		["610"] = 624,
		["611"] = 625,
		["612"] = 626,
		["613"] = 627,
		["614"] = 630,
		["615"] = 630,
		["616"] = 630,
		["617"] = 630,
		["618"] = 630,
		["619"] = 630,
		["620"] = 630,
		["621"] = 630,
		["622"] = 630,
		["623"] = 630,
		["624"] = 630,
		["625"] = 630,
		["626"] = 630,
		["627"] = 641,
		["629"] = 645,
		["630"] = 646,
		["631"] = 646,
		["632"] = 646,
		["633"] = 646,
		["634"] = 646,
		["635"] = 646,
		["636"] = 646,
		["637"] = 647,
		["638"] = 648,
		["640"] = 650,
		["641"] = 651,
		["642"] = 652,
		["643"] = 653,
		["645"] = 656,
		["646"] = 657,
		["647"] = 657,
		["648"] = 657,
		["649"] = 658,
		["650"] = 657,
		["651"] = 657,
		["653"] = 661,
		["656"] = 622,
		["657"] = 666,
		["658"] = 667,
		["659"] = 666,
		["660"] = 670,
		["661"] = 671,
		["664"] = 672,
		["665"] = 675,
		["666"] = 676,
		["668"] = 680,
		["669"] = 681,
		["671"] = 683,
		["672"] = 684,
		["674"] = 688,
		["675"] = 689,
		["676"] = 689,
		["677"] = 689,
		["678"] = 689,
		["679"] = 689,
		["680"] = 689,
		["681"] = 689,
		["682"] = 689,
		["683"] = 689,
		["684"] = 689,
		["685"] = 689,
		["686"] = 698,
		["687"] = 698,
		["688"] = 698,
		["689"] = 699,
		["690"] = 700,
		["692"] = 698,
		["693"] = 698,
		["694"] = 704,
		["696"] = 708,
		["697"] = 709,
		["698"] = 710,
		["699"] = 711,
		["700"] = 712,
		["701"] = 713,
		["702"] = 714,
		["703"] = 715,
		["706"] = 670,
	}
)
local j = {}
local k
local l = require("lib.dota_ts_adapter")
local m = l.BaseAbility
local n = l.registerAbility
local o = require("modifiers.eom_modifier")
local p = o.EOMModifier
local q = o.registerEOMModifier
local r = require("abilities.ability_ai")
local s = r.BaseAbilityAI
local t = r.registerAbilityAI
local u = "enigma_ult_stun_count"
j.enigma_talent = c()
local v = j.enigma_talent
v.name = "enigma_talent"
d(v, m)
function v.prototype.GetIntrinsicModifierName(self)
	return "modifier_enigma_talent"
end
v = e({ n(nil) }, v)
j.enigma_talent = v
j.modifier_enigma_talent = c()
local w = j.modifier_enigma_talent
w.name = "modifier_enigma_talent"
d(w, p)
function w.prototype.____constructor(self, ...)
	p.prototype.____constructor(self, ...)
	self.chaos_gained_record = 0
	self.position_list = {}
	self.ghost_list = {}
	self.attack_count = 0
	self.chaos_exp = 0
	self.tl7_has = false
	self.tl11_has = false
	self.t3_record = 0
	self.can_create_ghost = true
end
function w.prototype.GetChaosTrigger(self)
	return self.chaos_trigger
end
function w.prototype.GetCurGhostCnt(self)
	return #self.ghost_list
end
function w.prototype.GetAddChaosNum(self)
	return self.add_chaos_num + self.t5_add_ghost_chaos
end
function w.prototype.GetGhostMagicalIncoming(self)
	return self.ghost_magical_incoming
end
function w.prototype.GetUltStunAdd(self)
	local x = self:GetParent():GetPlayerOwnerID()
	local y = PlayerData:loadData(x, u)
	if y == nil then
		y = 0
	end
	local z = y
	return math.min(self.ult_stun_add * 4, z * self.ult_stun_add)
end
function w.prototype.GetGhostDuration(self) end
function w.prototype.GetMaxGhostCnt(self)
	return 20
end
function w.prototype.GetAbilitySpecialValue(self)
	self.chaos_damage_pct = self:GetAbilitySpecialValueFor("chaos_damage_pct")
	self.neutral_add_count = self:GetAbilitySpecialValueFor("neutral_add_count")
	self.begin_ghost_count = self:GetAbilitySpecialValueFor("begin_ghost_count")
		+ self:GetAbilityTalentValue("enigma_talent_9", "ghost_add")
	self.ult_stun_add = self:GetAbilitySpecialValueFor("ult_stun_add")
	self.ghost_attack_interval = self:GetAbilitySpecialValueFor("ghost_attack_interval")
		- self:GetAbilityTalentValue("enigma_talent_8", "attack_interval_reduce")
	self.ghost_damage_base = self:GetAbilitySpecialValueFor("ghost_damage_base")
	self.tl7_mana_reply = self:GetAbilityTalentValue("enigma_talent_7", "mana_reply")
	self.ghost_attack_count = self:GetAbilitySpecialValueFor("ghost_attack_count")
		+ self:GetAbilityTalentValue("enigma_talent_3", "attack_count_add")
	self.tl1_attack_trigger = self:GetAbilityTalentValue("enigma_talent_1", "attack_trigger")
	self.tl1_count = self:GetAbilityTalentValue("enigma_talent_1", "count")
	self.tl1_attack_count = self:GetAbilityTalentValue("enigma_talent_1", "attack_count")
	self.tl2_damage = self:GetAbilityTalentValue("enigma_talent_2", "damage")
	self.chaos_trigger = self:GetAbilitySpecialValueFor("chaos_trigger")
	self.ghost_magical_incoming = self:GetAbilitySpecialValueFor("ghost_magical_incoming")
	self.add_chaos_interval = self:GetAbilitySpecialValueFor("add_chaos_interval")
	self.add_chaos_num = self:GetAbilitySpecialValueFor("add_chaos_num")
	self.max_ghost_cnt = self:GetAbilitySpecialValueFor("max_ghost_cnt")
	self.t5_add_ghost_chaos = self:GetAbilityTalentValue("enigma_talent_5", "add_ghost_chaos")
	self.t5_add_ghost_max = self:GetAbilityTalentValue("enigma_talent_5", "add_ghost_max")
	self.t3_trigger_cnt = self:GetAbilityTalentValue("enigma_talent_3", "trigger_cnt")
	self.tl6_base_chance = self:GetAbilityTalentValue("enigma_talent_6", "base_chance")
	self.tl6_chance_bonus = self:GetAbilityTalentValue("enigma_talent_6", "chance_bonus")
	self.tl6_duration = self:GetAbilityTalentValue("enigma_talent_6", "stun_duration")
	self.shard_magic_incoming = self:GetAbilityTalentValue("enigma_shard", "magic_incoming")
end
function w.prototype.OnCreated(self, A)
	if IsServer() then
	end
end
function w.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE }
end
function w.prototype.EOM_GetModifierIncomingMagicalDamagePercentage(self)
	return -self.shard_magic_incoming * self:GetStackCount()
end
function w.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self.parent },
	}
end
function w.prototype.OnBattleStartBefore(self, A)
	if IsServer() then
	end
end
function w.prototype.OnBattleStart(self, A)
	if not IsServer() then
		return
	end
	self.attack_count = 0
	self.can_create_ghost = true
	self.chaos_exp = PlayerData:getHero(self.parent:GetPlayerOwnerID()):getSectAbilityExp("sect_chaos")
	self.beginGhostCount = math.max(0, math.floor((Rounds:getCurrentRound() - 1) / 5)) * self.neutral_add_count
		+ self.begin_ghost_count
	do
		local B = 0
		while B < self.beginGhostCount do
			self:CreateEnigmaGhost()
			B = B + 1
		end
	end
	if GameState:getStateName() == "GameState_Neutral" or GameState:getStateName() == "GameState_Treasure" then
		local C = self.caster:GetEnemy()
		GameTimer(0.1, function()
			if not C:IsAlive() then
				return
			end
			self.caster:DealDamage(
				C,
				self:GetAbility(),
				C:GetHealth(),
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE,
				DamageFlags.DAMAGE_FLAG_IGNORE_BLOCK + DamageFlags.DAMAGE_FLAG_IGNORE_AVOID_DAMAGE
			)
			if not C:IsAlive() then
				local x = self.parent:GetPlayerOwnerID()
				local D = PlayerData:loadData(x, u)
				if D == nil then
					D = 0
				end
				local z = D
				PlayerData:saveData(x, u, math.min(4, z + 1))
			end
		end)
	end
end
function w.prototype.OnBattleEnd(self, A)
	self:StartIntervalThink(-1)
	self.can_create_ghost = false
	self:GhostDestroyAll()
	self.position_list = {}
end
function w.prototype.OnCustomTakeDamage(self, E)
	if
		self.tl6_base_chance > 0
		and bit.band(E.damage_type, EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS) == EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS
	then
		if
			self:PRD(
				self.tl6_base_chance + (self.parent:HasModifier("modifier_enigma_ult") and self.tl6_chance_bonus or 0)
			)
		then
			print("午夜凋零")
			local C = self.parent:GetEnemy()
			AddStun(self.parent, C, self.caster:FindAbilityByName("enigma_midnight_withering"), self.tl6_duration)
			self.parent:AddNewModifier(
				self.caster,
				self:GetAbility(),
				"modifier_enigma_talent5",
				{ duration = self.tl6_duration }
			)
		end
	end
	if self.t3_trigger_cnt <= 0 then
		return
	end
	if bit.band(E.damage_type, EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS) == EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS then
		self.t3_record = self.t3_record + 1
		local C = self.parent:GetEnemy()
		if self.t3_record >= self.t3_trigger_cnt then
			self.t3_record = self.t3_record - self.t3_trigger_cnt
			C:AddNewModifier(self.caster, self:GetAbility(), "modifier_enigma_talent5", {})
		end
	end
end
function w.prototype.AddGhostAttackCount(self, z)
	if z == nil then
		z = 1
	end
	if self.tl1_attack_trigger > 0 then
		self.attack_count = self.attack_count + z
		if self.attack_count >= self.tl1_attack_trigger then
			local z = math.floor(self.attack_count / self.tl1_attack_trigger) * self.tl1_count
			self.attack_count = self.attack_count % self.tl1_attack_trigger
			do
				local B = 0
				while B < z do
					self:CreateEnigmaGhost(self.tl1_attack_count)
					B = B + 1
				end
			end
		end
	end
end
function w.prototype.CreateEnigmaGhost(self, F)
	if F == nil then
		F = 0
	end
	if not self.can_create_ghost then
		return
	end
	local C = self.caster:GetEnemy()
	local G = self.caster:GetAbsOrigin()
	local H = C:GetAbsOrigin() - G
	if #self.position_list == 0 then
		H.z = 0
		H = H:Normalized()
		do
			local B = 0
			while B < self:GetMaxGhostCnt() do
				local I = RotatePosition(vec3_zero, QAngle(0, B * 360 / self:GetMaxGhostCnt(), 0), H)
				local J = G + I * 150
				local K = self.position_list
				K[#K + 1] = J
				B = B + 1
			end
		end
	end
	local L = f(self.ghost_list, function(M, N)
		return N.index
	end)
	local O = 0
	do
		local B = 0
		while B < #self.position_list do
			if not g(L, B) then
				O = B
				break
			end
			B = B + 1
		end
	end
	if self:HasTalent("enigma_talent_11") then
		F = 0
	end
	local P = h(
		k,
		{
			parent = self.caster,
			enemy = C,
			buff = self,
			ability = self:GetAbility(),
			position = self.position_list[O + 1],
			direction = H,
			index = O,
			attack_interval = self.ghost_attack_interval,
			attack_damage = self.ghost_damage_base + self.tl2_damage * self.chaos_exp,
			attack_count = F,
			chaos_damage_bonus_pct = self.chaos_damage_pct,
			attack_mana_reply = self.tl7_mana_reply,
		}
	)
	local Q = self.ghost_list
	Q[#Q + 1] = { ghost = P, index = O }
	self:SetStackCount(#self.ghost_list)
	if self:HasTalent("enigma_talent_9") then
		P:AttackImmediately()
	end
end
function w.prototype.GhostDestroyAll(self)
	do
		local B = #self.ghost_list - 1
		while B >= 0 do
			if not self.ghost_list[B + 1].ghost.disposed then
				self.ghost_list[B + 1].ghost:dispose(true)
			end
			B = B - 1
		end
	end
	self.ghost_list = {}
	self:SetStackCount(#self.ghost_list)
end
function w.prototype.GhostDestroy(self, R)
	do
		local B = #self.ghost_list - 1
		while B >= 0 do
			if self.ghost_list[B + 1].index == R then
				table.remove(self.ghost_list, B + 1)
				self:SetStackCount(#self.ghost_list)
				break
			end
			B = B - 1
		end
	end
end
w = e(
	{
		q(
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
	w
)
j.modifier_enigma_talent = w
j.enigma_ult = c()
local S = j.enigma_ult
S.name = "enigma_ult"
d(S, s)
function S.prototype.OnSpellStart(self)
	local T = self:GetCaster()
	local C = T:GetEnemy()
	if not IsInjurable(T, C) then
		return
	end
	local U = T:FindModifierByName("modifier_enigma_talent")
	local V = IsValid(U) and U:GetUltStunAdd() or 0
	local W = self:GetSpecialValueFor("stun_time") + self:GetTalentValue("enigma_talent_4", "add_ult_stun_time") + V
	T:StartGestureWithFade(ACT_DOTA_CAST_ABILITY_1, 0, 0.2)
	local X = self:GetSpecialValueFor("duration") + self:GetTalentValue("enigma_talent_4", "add_ult_duration")
	AddStun(T, C, self, W)
	C:AddNewModifier(T, self, "modifier_enigma_ult", { duration = X })
end
S = e({ t(nil) }, S)
j.enigma_ult = S
j.modifier_enigma_ult = c()
local Y = j.modifier_enigma_ult
Y.name = "modifier_enigma_ult"
d(Y, p)
function Y.prototype.GetChaosDamage(self)
	return self.chaos_damage
end
function Y.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.chaos_damage = self:GetAbilitySpecialValueFor("chaos_damage")
	self.t1_add_chaos_point = self:GetAbilityTalentValue("enigma_talent_1", "add_chaos_point")
end
function Y.prototype.OnCreated(self, A)
	if IsServer() then
		self:IncrementStackCount()
		self:StartIntervalThink(self.interval)
		local Z = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_enigma/enigma_blackhole.vpcf",
			PATTACH_ABSORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControl(Z, 0, self.parent:GetAbsOrigin())
		self:AddParticle(Z, false, false, -1, false, false)
	else
		EmitSoundOn("Hero_Enigma.Black_Hole", self.parent)
	end
end
function Y.prototype.OnRefresh(self, A)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function Y.prototype.OnIntervalThink(self)
	self.caster:DealDamage(
		self.parent,
		self:GetAbility(),
		self:GetChaosDamage() * self:GetStackCount(),
		EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS
	)
	if self.t1_add_chaos_point > 0 then
		AddChaos(self.caster, self.t1_add_chaos_point, self:GetAbility():GetAbilityName(), "Ability")
	end
end
function Y.prototype.OnDestroy(self)
	if IsClient() then
		StopSoundOn("Hero_Enigma.Black_Hole", self.parent)
	end
end
Y = e(
	{
		q(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				IsIndependent = true,
			}
		),
	},
	Y
)
j.modifier_enigma_ult = Y
j.modifier_enigma_talent5 = c()
local _ = j.modifier_enigma_talent5
_.name = "modifier_enigma_talent5"
d(_, p)
function _.prototype.GetAbilitySpecialValue(self)
	self.base_damage = self:GetAbilityTalentValue("enigma_talent_6", "damage_base")
	self.damage_bonus = self:GetAbilityTalentValue("enigma_talent_6", "damage_bonus_pct")
end
function _.prototype.OnCreated(self, A)
	if IsServer() then
		local C = self.parent:GetEnemy()
		local a0 = self.base_damage + C:GetHealth() * self.damage_bonus * 0.01
		self.parent:DealDamage(
			C,
			self.caster:FindAbilityByName("enigma_midnight_withering"),
			a0,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
		)
	end
	self.fpx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_enigma/enigma_midnight_pulse.vpcf",
		PATTACH_ABSORIGIN,
		self.parent
	)
	ParticleManager:SetParticleControl(self.fpx, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.fpx, 1, Vector(600, 0, 0))
end
function _.prototype.OnDestroy(self)
	if IsServer() then
		ParticleManager:DestroyParticle(self.fpx, true)
	end
end
_ = e(
	{
		q(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	_
)
j.modifier_enigma_talent5 = _
j.modifier_enigma_talent6 = c()
local a1 = j.modifier_enigma_talent6
a1.name = "modifier_enigma_talent6"
d(a1, p)
function a1.prototype.OnCreated(self, A)
	if IsServer() then
		self:StartIntervalThink(1)
	end
end
function a1.prototype.OnIntervalThink(self)
	self.caster:DealDamage(
		self.parent,
		self.caster:FindAbilityByName("enigma_curse"),
		BUFF_VALUE.EnigmaCurseChaosDmg,
		EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS
	)
	AddStun(
		self.caster,
		self.caster:GetEnemy(),
		self.caster:FindAbilityByName("enigma_curse"),
		BUFF_VALUE.EnigmaCurseStun
	)
end
a1 = e(
	{
		q(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	a1
)
j.modifier_enigma_talent6 = a1
local a2 = "models/heroes/enigma/eidelon.vmdl"
local a3 = 0.5
local a4 = 0.8
k = c()
k.name = "EnigmaGhost"
function k.prototype.____constructor(self, a5)
	self.attack_point = 0
	self.attack_backswing = 0
	self.animation_rate = 1
	self.record_attack_count = 0
	self.disposed = false
	self.parent = a5.parent
	self.enemy = a5.enemy
	self.ability = a5.ability
	self.position = a5.position
	self.direction = a5.direction
	self.index = a5.index
	self.buff = a5.buff
	self.attack_interval = a5.attack_interval
	self.attack_damage = a5.attack_damage
	self.attack_count = a5.attack_count
	self.chaos_damage_bonus_pct = a5.chaos_damage_bonus_pct
	self.attack_mana_reply = a5.attack_mana_reply
	self:spawn()
end
function k.prototype.spawn(self)
	if self.disposed then
		return
	end
	self.ghostDummy = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{
			origin = self.position,
			angles = VectorToAngles(self.direction),
			model = Wearable:getReplaceUnitModel(self.parent, a2),
			StartingAnim = "ACT_DOTA_SPAWN",
			StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
			DefaultAnim = "ACT_DOTA_IDLE",
			AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			use_animgraph = "1",
		}
	)
	local a6 = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_enigma/enigma_demonic_conversion.vpcf",
		PATTACH_ABSORIGIN,
		self.ghostDummy
	)
	ParticleManager:SetParticleControl(a6, 0, self.position)
	ParticleManager:ReleaseParticleIndex(a6)
	self.ambientParticle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_enigma/enigma_eidolon_ambient.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(self.ambientParticle, 0, self.position)
	EmitSoundOn("Hero_Enigma.Demonic_Conversion", self.ghostDummy)
	self:StartShardAttack()
end
function k.prototype.StartShardAttack(self)
	if self.disposed then
		return
	end
	if not IsInjurable(self.enemy, self.parent) then
		self:dispose()
		return
	end
	self.attack_timer = GameTimer(self.attack_interval, function()
		self.attack_timer = nil
		if self.disposed then
			return
		end
		if not IsInjurable(self.enemy, self.parent) then
			self:dispose()
			return
		end
		self:OnShardAttack()
	end)
end
function k.prototype.AttackImmediately(self)
	if self.disposed then
		return
	end
	if self.attack_timer ~= nil then
		StopTimer(self.attack_timer)
		self.attack_timer = nil
	end
	self:OnShardAttack()
end
function k.prototype.OnShardAttack(self)
	if self.ghostDummy and IsValid(self.ghostDummy) then
		local a7 = self.ghostDummy
		local a8 = self.position
		local a9 = self.direction
		self.ghostDummy = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{
				origin = a8,
				angles = VectorToAngles(a9),
				model = Wearable:getReplaceUnitModel(self.parent, a2),
				StartingAnim = "ACT_DOTA_ATTACK",
				StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
				DefaultAnim = "ACT_DOTA_IDLE",
				use_animgraph = "1",
				AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			}
		)
		UTIL_Remove(a7)
	end
	local a0 = self.attack_damage + GetChaosDamageBonus(self.parent) * self.chaos_damage_bonus_pct * 0.01
	self.parent:DealDamage(
		self.enemy,
		self.ability,
		a0,
		EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS,
		DamageFlags.DAMAGE_FLAG_IGNORE_CHAOS_EXTRA
	)
	if self.attack_mana_reply > 0 and self.parent:IsAlive() then
		Restore(self.parent, self.attack_mana_reply)
	end
	self.record_attack_count = self.record_attack_count + 1
	if self.attack_count == 0 then
		self.buff:AddGhostAttackCount()
		self:StartShardAttack()
	else
		if self.record_attack_count >= self.attack_count then
			GameTimer(0.3, function()
				self:dispose()
			end)
		else
			self:StartShardAttack()
		end
	end
end
function k.prototype.isExpired(self)
	return GameRules:GetGameTime() >= self.expireTime
end
function k.prototype.dispose(self, aa)
	if self.disposed then
		return
	end
	self.disposed = true
	if self.attack_timer ~= nil then
		StopTimer(self.attack_timer)
	end
	if self.ambientParticle then
		ParticleManager:DestroyParticle(self.ambientParticle, false)
	end
	if self.attackParticle then
		ParticleManager:DestroyParticle(self.attackParticle, false)
	end
	if self.ghostDummy and IsValid(self.ghostDummy) then
		local ab = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{
				origin = self.position,
				angles = VectorToAngles(self.direction),
				model = Wearable:getReplaceUnitModel(self.parent, a2),
				DefaultAnim = "ACT_DOTA_DIE",
				use_animgraph = "1",
				AnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
			}
		)
		GameTimer(1, function()
			if ab and IsValid(ab) then
				UTIL_Remove(ab)
			end
		end)
		UTIL_Remove(self.ghostDummy)
	end
	self.ghostDummy = nil
	self.ambientParticle = nil
	self.attackParticle = nil
	self.attack_timer = nil
	if not aa then
		local ac = self.parent:FindModifierByName("modifier_enigma_talent")
		if ac then
			ac:GhostDestroy(self.index)
		end
	end
end
return j