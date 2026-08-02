--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
		["11"] = 494,
		["12"] = 1,
		["13"] = 1,
		["14"] = 1,
		["15"] = 2,
		["16"] = 2,
		["17"] = 2,
		["18"] = 3,
		["19"] = 3,
		["20"] = 3,
		["21"] = 6,
		["22"] = 7,
		["23"] = 6,
		["24"] = 7,
		["25"] = 8,
		["26"] = 9,
		["27"] = 8,
		["28"] = 7,
		["29"] = 6,
		["30"] = 7,
		["32"] = 7,
		["33"] = 13,
		["34"] = 21,
		["35"] = 13,
		["36"] = 21,
		["38"] = 21,
		["39"] = 22,
		["40"] = 23,
		["41"] = 24,
		["42"] = 37,
		["43"] = 38,
		["44"] = 54,
		["45"] = 61,
		["46"] = 68,
		["47"] = 78,
		["48"] = 13,
		["49"] = 79,
		["50"] = 80,
		["51"] = 79,
		["52"] = 83,
		["53"] = 84,
		["54"] = 83,
		["55"] = 87,
		["56"] = 88,
		["57"] = 87,
		["58"] = 91,
		["59"] = 92,
		["60"] = 91,
		["61"] = 95,
		["62"] = 95,
		["63"] = 99,
		["64"] = 100,
		["65"] = 99,
		["66"] = 103,
		["67"] = 105,
		["68"] = 106,
		["69"] = 107,
		["70"] = 108,
		["71"] = 109,
		["72"] = 111,
		["73"] = 112,
		["74"] = 114,
		["75"] = 115,
		["76"] = 116,
		["77"] = 118,
		["78"] = 120,
		["79"] = 121,
		["80"] = 123,
		["81"] = 124,
		["82"] = 125,
		["83"] = 126,
		["84"] = 127,
		["85"] = 129,
		["86"] = 132,
		["87"] = 133,
		["88"] = 134,
		["89"] = 138,
		["90"] = 103,
		["91"] = 140,
		["92"] = 141,
		["94"] = 140,
		["95"] = 150,
		["96"] = 151,
		["97"] = 150,
		["98"] = 155,
		["99"] = 156,
		["100"] = 155,
		["101"] = 159,
		["102"] = 160,
		["103"] = 159,
		["104"] = 167,
		["105"] = 168,
		["107"] = 167,
		["108"] = 176,
		["109"] = 177,
		["112"] = 180,
		["113"] = 181,
		["114"] = 182,
		["115"] = 183,
		["116"] = 183,
		["117"] = 183,
		["118"] = 183,
		["119"] = 184,
		["121"] = 185,
		["122"] = 185,
		["123"] = 186,
		["124"] = 185,
		["127"] = 189,
		["128"] = 190,
		["129"] = 191,
		["130"] = 191,
		["131"] = 191,
		["132"] = 192,
		["133"] = 192,
		["134"] = 192,
		["135"] = 192,
		["136"] = 192,
		["137"] = 192,
		["138"] = 192,
		["139"] = 191,
		["140"] = 191,
		["142"] = 176,
		["143"] = 196,
		["144"] = 197,
		["145"] = 198,
		["146"] = 199,
		["147"] = 200,
		["148"] = 196,
		["149"] = 203,
		["150"] = 204,
		["151"] = 205,
		["152"] = 206,
		["153"] = 207,
		["154"] = 208,
		["155"] = 208,
		["156"] = 208,
		["157"] = 208,
		["158"] = 208,
		["159"] = 208,
		["160"] = 209,
		["161"] = 209,
		["162"] = 209,
		["163"] = 209,
		["164"] = 209,
		["165"] = 209,
		["168"] = 212,
		["171"] = 213,
		["172"] = 214,
		["173"] = 215,
		["174"] = 216,
		["175"] = 217,
		["176"] = 218,
		["177"] = 218,
		["178"] = 218,
		["179"] = 218,
		["180"] = 218,
		["181"] = 218,
		["184"] = 203,
		["185"] = 224,
		["186"] = 224,
		["187"] = 224,
		["189"] = 225,
		["190"] = 226,
		["191"] = 227,
		["192"] = 228,
		["193"] = 229,
		["195"] = 230,
		["196"] = 230,
		["197"] = 231,
		["198"] = 230,
		["203"] = 224,
		["204"] = 237,
		["205"] = 237,
		["206"] = 237,
		["208"] = 238,
		["211"] = 239,
		["212"] = 240,
		["213"] = 241,
		["214"] = 243,
		["215"] = 244,
		["216"] = 245,
		["218"] = 246,
		["219"] = 246,
		["220"] = 247,
		["221"] = 247,
		["222"] = 247,
		["223"] = 247,
		["224"] = 247,
		["225"] = 247,
		["226"] = 247,
		["227"] = 247,
		["228"] = 247,
		["229"] = 248,
		["230"] = 249,
		["231"] = 249,
		["232"] = 246,
		["236"] = 254,
		["237"] = 254,
		["238"] = 254,
		["239"] = 254,
		["240"] = 255,
		["242"] = 256,
		["243"] = 256,
		["244"] = 257,
		["245"] = 258,
		["248"] = 256,
		["251"] = 262,
		["252"] = 263,
		["254"] = 266,
		["255"] = 266,
		["256"] = 266,
		["257"] = 266,
		["258"] = 266,
		["259"] = 266,
		["260"] = 266,
		["261"] = 266,
		["262"] = 266,
		["263"] = 266,
		["264"] = 266,
		["265"] = 266,
		["266"] = 266,
		["267"] = 266,
		["268"] = 266,
		["269"] = 266,
		["270"] = 266,
		["271"] = 282,
		["272"] = 282,
		["273"] = 286,
		["274"] = 237,
		["275"] = 289,
		["277"] = 290,
		["278"] = 290,
		["279"] = 291,
		["280"] = 292,
		["282"] = 290,
		["285"] = 295,
		["286"] = 296,
		["287"] = 289,
		["288"] = 299,
		["290"] = 300,
		["291"] = 300,
		["292"] = 301,
		["293"] = 302,
		["294"] = 303,
		["297"] = 300,
		["300"] = 299,
		["301"] = 21,
		["302"] = 13,
		["303"] = 13,
		["304"] = 13,
		["305"] = 13,
		["306"] = 13,
		["307"] = 13,
		["308"] = 13,
		["309"] = 13,
		["310"] = 21,
		["312"] = 21,
		["313"] = 313,
		["314"] = 314,
		["315"] = 313,
		["316"] = 314,
		["317"] = 316,
		["318"] = 317,
		["319"] = 318,
		["320"] = 319,
		["323"] = 320,
		["324"] = 321,
		["325"] = 323,
		["326"] = 324,
		["327"] = 325,
		["328"] = 316,
		["329"] = 314,
		["330"] = 313,
		["331"] = 314,
		["333"] = 314,
		["335"] = 333,
		["336"] = 342,
		["337"] = 333,
		["338"] = 342,
		["339"] = 349,
		["340"] = 350,
		["341"] = 349,
		["342"] = 352,
		["343"] = 353,
		["344"] = 354,
		["345"] = 355,
		["346"] = 352,
		["347"] = 360,
		["348"] = 361,
		["349"] = 362,
		["350"] = 363,
		["351"] = 368,
		["352"] = 369,
		["353"] = 369,
		["354"] = 369,
		["355"] = 369,
		["356"] = 369,
		["357"] = 370,
		["358"] = 370,
		["359"] = 370,
		["360"] = 370,
		["361"] = 370,
		["362"] = 370,
		["363"] = 370,
		["364"] = 370,
		["366"] = 372,
		["368"] = 360,
		["369"] = 375,
		["370"] = 376,
		["371"] = 381,
		["373"] = 375,
		["374"] = 384,
		["375"] = 385,
		["376"] = 385,
		["377"] = 385,
		["378"] = 385,
		["379"] = 385,
		["380"] = 385,
		["381"] = 386,
		["382"] = 387,
		["383"] = 387,
		["384"] = 387,
		["385"] = 387,
		["386"] = 387,
		["387"] = 387,
		["389"] = 384,
		["390"] = 390,
		["391"] = 391,
		["392"] = 392,
		["394"] = 390,
		["395"] = 342,
		["396"] = 333,
		["397"] = 333,
		["398"] = 333,
		["399"] = 333,
		["400"] = 333,
		["401"] = 333,
		["402"] = 333,
		["403"] = 333,
		["404"] = 333,
		["405"] = 342,
		["407"] = 342,
		["409"] = 398,
		["410"] = 406,
		["411"] = 398,
		["412"] = 406,
		["413"] = 410,
		["414"] = 411,
		["415"] = 412,
		["416"] = 410,
		["417"] = 414,
		["418"] = 415,
		["419"] = 417,
		["420"] = 418,
		["421"] = 419,
		["422"] = 419,
		["423"] = 419,
		["424"] = 419,
		["425"] = 419,
		["426"] = 419,
		["428"] = 421,
		["429"] = 422,
		["430"] = 422,
		["431"] = 422,
		["432"] = 422,
		["433"] = 422,
		["434"] = 423,
		["435"] = 423,
		["436"] = 423,
		["437"] = 423,
		["438"] = 423,
		["439"] = 414,
		["440"] = 442,
		["441"] = 443,
		["442"] = 444,
		["444"] = 442,
		["445"] = 406,
		["446"] = 398,
		["447"] = 398,
		["448"] = 398,
		["449"] = 398,
		["450"] = 398,
		["451"] = 398,
		["452"] = 398,
		["453"] = 398,
		["454"] = 406,
		["456"] = 406,
		["458"] = 450,
		["459"] = 458,
		["460"] = 450,
		["461"] = 458,
		["462"] = 459,
		["463"] = 460,
		["464"] = 461,
		["466"] = 459,
		["467"] = 464,
		["468"] = 465,
		["469"] = 465,
		["470"] = 465,
		["471"] = 465,
		["472"] = 465,
		["473"] = 465,
		["474"] = 466,
		["475"] = 466,
		["476"] = 466,
		["477"] = 466,
		["478"] = 466,
		["479"] = 466,
		["480"] = 464,
		["481"] = 458,
		["482"] = 450,
		["483"] = 450,
		["484"] = 450,
		["485"] = 450,
		["486"] = 450,
		["487"] = 450,
		["488"] = 450,
		["489"] = 450,
		["490"] = 458,
		["492"] = 458,
		["493"] = 473,
		["494"] = 474,
		["495"] = 475,
		["498"] = 494,
		["499"] = 494,
		["500"] = 526,
		["501"] = 509,
		["502"] = 510,
		["503"] = 511,
		["504"] = 515,
		["505"] = 517,
		["506"] = 527,
		["507"] = 528,
		["508"] = 529,
		["509"] = 530,
		["510"] = 531,
		["511"] = 532,
		["512"] = 533,
		["513"] = 536,
		["514"] = 537,
		["515"] = 538,
		["516"] = 539,
		["517"] = 540,
		["518"] = 541,
		["519"] = 526,
		["520"] = 544,
		["521"] = 545,
		["524"] = 548,
		["525"] = 548,
		["526"] = 548,
		["527"] = 548,
		["528"] = 548,
		["529"] = 548,
		["530"] = 548,
		["531"] = 548,
		["532"] = 548,
		["533"] = 548,
		["534"] = 548,
		["535"] = 548,
		["536"] = 548,
		["537"] = 560,
		["538"] = 561,
		["539"] = 562,
		["540"] = 565,
		["541"] = 566,
		["542"] = 569,
		["543"] = 570,
		["544"] = 544,
		["545"] = 573,
		["546"] = 574,
		["549"] = 575,
		["550"] = 576,
		["553"] = 579,
		["554"] = 579,
		["555"] = 579,
		["556"] = 580,
		["557"] = 581,
		["560"] = 582,
		["561"] = 583,
		["564"] = 586,
		["565"] = 579,
		["566"] = 579,
		["567"] = 573,
		["568"] = 590,
		["569"] = 592,
		["570"] = 593,
		["571"] = 594,
		["572"] = 595,
		["573"] = 598,
		["574"] = 598,
		["575"] = 598,
		["576"] = 598,
		["577"] = 598,
		["578"] = 598,
		["579"] = 598,
		["580"] = 598,
		["581"] = 598,
		["582"] = 598,
		["583"] = 598,
		["584"] = 598,
		["585"] = 598,
		["586"] = 609,
		["588"] = 613,
		["589"] = 614,
		["590"] = 614,
		["591"] = 614,
		["592"] = 614,
		["593"] = 614,
		["594"] = 614,
		["595"] = 614,
		["596"] = 615,
		["597"] = 616,
		["599"] = 618,
		["600"] = 619,
		["601"] = 620,
		["602"] = 621,
		["604"] = 624,
		["605"] = 625,
		["606"] = 625,
		["607"] = 625,
		["608"] = 626,
		["609"] = 625,
		["610"] = 625,
		["612"] = 629,
		["615"] = 590,
		["616"] = 634,
		["617"] = 635,
		["618"] = 634,
		["619"] = 638,
		["620"] = 639,
		["623"] = 640,
		["624"] = 643,
		["625"] = 644,
		["627"] = 648,
		["628"] = 649,
		["630"] = 651,
		["631"] = 652,
		["633"] = 656,
		["634"] = 657,
		["635"] = 657,
		["636"] = 657,
		["637"] = 657,
		["638"] = 657,
		["639"] = 657,
		["640"] = 657,
		["641"] = 657,
		["642"] = 657,
		["643"] = 657,
		["644"] = 657,
		["645"] = 666,
		["646"] = 666,
		["647"] = 666,
		["648"] = 667,
		["649"] = 668,
		["651"] = 666,
		["652"] = 666,
		["653"] = 672,
		["655"] = 676,
		["656"] = 677,
		["657"] = 678,
		["658"] = 679,
		["659"] = 680,
		["660"] = 681,
		["661"] = 682,
		["662"] = 683,
		["665"] = 638,
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
j.enigma_talent = c()
local u = j.enigma_talent
u.name = "enigma_talent"
d(u, m)
function u.prototype.GetIntrinsicModifierName(self)
	return "modifier_enigma_talent"
end
u = e({ n(nil) }, u)
j.enigma_talent = u
j.modifier_enigma_talent = c()
local v = j.modifier_enigma_talent
v.name = "modifier_enigma_talent"
d(v, p)
function v.prototype.____constructor(self, ...)
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
function v.prototype.GetChaosTrigger(self)
	return self.chaos_trigger
end
function v.prototype.GetCurGhostCnt(self)
	return #self.ghost_list
end
function v.prototype.GetAddChaosNum(self)
	return self.add_chaos_num + self.t5_add_ghost_chaos
end
function v.prototype.GetGhostMagicalIncoming(self)
	return self.ghost_magical_incoming
end
function v.prototype.GetGhostDuration(self) end
function v.prototype.GetMaxGhostCnt(self)
	return 20
end
function v.prototype.GetAbilitySpecialValue(self)
	self.chaos_damage_pct = self:GetAbilitySpecialValueFor("chaos_damage_pct")
	self.neutral_add_count = self:GetAbilitySpecialValueFor("neutral_add_count")
	self.begin_ghost_count = self:GetAbilitySpecialValueFor("begin_ghost_count")
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
function v.prototype.OnCreated(self, w)
	if IsServer() then
	end
end
function v.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE }
end
function v.prototype.EOM_GetModifierIncomingMagicalDamagePercentage(self)
	return -self.shard_magic_incoming * self:GetStackCount()
end
function v.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self.parent },
	}
end
function v.prototype.OnBattleStartBefore(self, w)
	if IsServer() then
	end
end
function v.prototype.OnBattleStart(self, w)
	if not IsServer() then
		return
	end
	self.attack_count = 0
	self.can_create_ghost = true
	self.chaos_exp = PlayerData:getHero(self.parent:GetPlayerOwnerID()):getSectAbilityExp("sect_chaos")
	self.beginGhostCount = math.max(0, math.floor((Rounds:getCurrentRound() - 1) / 5)) * self.neutral_add_count
		+ self.begin_ghost_count
	self.beginGhostCount = math.min(4, self.beginGhostCount)
	do
		local x = 0
		while x < self.beginGhostCount do
			self:CreateEnigmaGhost()
			x = x + 1
		end
	end
	if GameState:getStateName() == "GameState_Neutral" and Rounds:getCurrentRound() ~= 20 then
		local y = self.caster:GetEnemy()
		GameTimer(0.1, function()
			self.caster:DealDamage(
				y,
				self:GetAbility(),
				y:GetHealth(),
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE,
				DamageFlags.DAMAGE_FLAG_IGNORE_BLOCK + DamageFlags.DAMAGE_FLAG_IGNORE_AVOID_DAMAGE
			)
		end)
	end
end
function v.prototype.OnBattleEnd(self, w)
	self:StartIntervalThink(-1)
	self.can_create_ghost = false
	self:GhostDestroyAll()
	self.position_list = {}
end
function v.prototype.OnCustomTakeDamage(self, z)
	if
		self.tl6_base_chance > 0
		and bit.band(z.damage_type, EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS) == EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS
	then
		if
			self:PRD(
				self.tl6_base_chance + (self.parent:HasModifier("modifier_enigma_ult") and self.tl6_chance_bonus or 0)
			)
		then
			print("午夜凋零")
			local y = self.parent:GetEnemy()
			AddStun(self.parent, y, self.caster:FindAbilityByName("enigma_midnight_withering"), self.tl6_duration)
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
	if bit.band(z.damage_type, EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS) == EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS then
		self.t3_record = self.t3_record + 1
		local y = self.parent:GetEnemy()
		if self.t3_record >= self.t3_trigger_cnt then
			self.t3_record = self.t3_record - self.t3_trigger_cnt
			y:AddNewModifier(self.caster, self:GetAbility(), "modifier_enigma_talent5", {})
		end
	end
end
function v.prototype.AddGhostAttackCount(self, A)
	if A == nil then
		A = 1
	end
	if self.tl1_attack_trigger > 0 then
		self.attack_count = self.attack_count + A
		if self.attack_count >= self.tl1_attack_trigger then
			local A = math.floor(self.attack_count / self.tl1_attack_trigger) * self.tl1_count
			self.attack_count = self.attack_count % self.tl1_attack_trigger
			do
				local x = 0
				while x < A do
					self:CreateEnigmaGhost(self.tl1_attack_count)
					x = x + 1
				end
			end
		end
	end
end
function v.prototype.CreateEnigmaGhost(self, B)
	if B == nil then
		B = 0
	end
	if not self.can_create_ghost then
		return
	end
	local y = self.caster:GetEnemy()
	local C = self.caster:GetAbsOrigin()
	local D = y:GetAbsOrigin() - C
	if #self.position_list == 0 then
		D.z = 0
		D = D:Normalized()
		do
			local x = 0
			while x < self:GetMaxGhostCnt() do
				local E = RotatePosition(vec3_zero, QAngle(0, x * 360 / self:GetMaxGhostCnt(), 0), D)
				local F = C + E * 150
				local G = self.position_list
				G[#G + 1] = F
				x = x + 1
			end
		end
	end
	local H = f(self.ghost_list, function(I, J)
		return J.index
	end)
	local K = 0
	do
		local x = 0
		while x < #self.position_list do
			if not g(H, x) then
				K = x
				break
			end
			x = x + 1
		end
	end
	if self:HasTalent("enigma_talent_11") then
		B = 0
	end
	local L = h(
		k,
		{
			parent = self.caster,
			enemy = y,
			buff = self,
			ability = self:GetAbility(),
			position = self.position_list[K + 1],
			direction = D,
			index = K,
			attack_interval = self.ghost_attack_interval,
			attack_damage = self.ghost_damage_base + self.tl2_damage * self.chaos_exp,
			attack_count = B,
			chaos_damage_bonus_pct = self.chaos_damage_pct,
			attack_mana_reply = self.tl7_mana_reply,
		}
	)
	local M = self.ghost_list
	M[#M + 1] = { ghost = L, index = K }
	self:SetStackCount(#self.ghost_list)
end
function v.prototype.GhostDestroyAll(self)
	do
		local x = #self.ghost_list - 1
		while x >= 0 do
			if not self.ghost_list[x + 1].ghost.disposed then
				self.ghost_list[x + 1].ghost:dispose(true)
			end
			x = x - 1
		end
	end
	self.ghost_list = {}
	self:SetStackCount(#self.ghost_list)
end
function v.prototype.GhostDestroy(self, N)
	do
		local x = #self.ghost_list - 1
		while x >= 0 do
			if self.ghost_list[x + 1].index == N then
				table.remove(self.ghost_list, x + 1)
				self:SetStackCount(#self.ghost_list)
				break
			end
			x = x - 1
		end
	end
end
v = e(
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
	v
)
j.modifier_enigma_talent = v
j.enigma_ult = c()
local O = j.enigma_ult
O.name = "enigma_ult"
d(O, s)
function O.prototype.OnSpellStart(self)
	local P = self:GetCaster()
	local y = P:GetEnemy()
	if not IsInjurable(P, y) then
		return
	end
	local Q = self:GetSpecialValueFor("stun_time") + self:GetTalentValue("enigma_talent_4", "add_ult_stun_time")
	P:StartGestureWithFade(ACT_DOTA_CAST_ABILITY_1, 0, 0.2)
	local R = self:GetSpecialValueFor("duration") + self:GetTalentValue("enigma_talent_4", "add_ult_duration")
	AddStun(P, y, self, Q)
	y:AddNewModifier(P, self, "modifier_enigma_ult", { duration = R })
end
O = e({ t(nil) }, O)
j.enigma_ult = O
j.modifier_enigma_ult = c()
local S = j.modifier_enigma_ult
S.name = "modifier_enigma_ult"
d(S, p)
function S.prototype.GetChaosDamage(self)
	return self.chaos_damage
end
function S.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.chaos_damage = self:GetAbilitySpecialValueFor("chaos_damage")
	self.t1_add_chaos_point = self:GetAbilityTalentValue("enigma_talent_1", "add_chaos_point")
end
function S.prototype.OnCreated(self, w)
	if IsServer() then
		self:IncrementStackCount()
		self:StartIntervalThink(self.interval)
		local T = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_enigma/enigma_blackhole.vpcf",
			PATTACH_ABSORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControl(T, 0, self.parent:GetAbsOrigin())
		self:AddParticle(T, false, false, -1, false, false)
	else
		EmitSoundOn("Hero_Enigma.Black_Hole", self.parent)
	end
end
function S.prototype.OnRefresh(self, w)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function S.prototype.OnIntervalThink(self)
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
function S.prototype.OnDestroy(self)
	if IsClient() then
		StopSoundOn("Hero_Enigma.Black_Hole", self.parent)
	end
end
S = e(
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
	S
)
j.modifier_enigma_ult = S
j.modifier_enigma_talent5 = c()
local U = j.modifier_enigma_talent5
U.name = "modifier_enigma_talent5"
d(U, p)
function U.prototype.GetAbilitySpecialValue(self)
	self.base_damage = self:GetAbilityTalentValue("enigma_talent_6", "damage_base")
	self.damage_bonus = self:GetAbilityTalentValue("enigma_talent_6", "damage_bonus_pct")
end
function U.prototype.OnCreated(self, w)
	if IsServer() then
		local y = self.parent:GetEnemy()
		local V = self.base_damage + y:GetHealth() * self.damage_bonus * 0.01
		self.parent:DealDamage(
			y,
			self.caster:FindAbilityByName("enigma_midnight_withering"),
			V,
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
function U.prototype.OnDestroy(self)
	if IsServer() then
		ParticleManager:DestroyParticle(self.fpx, true)
	end
end
U = e(
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
	U
)
j.modifier_enigma_talent5 = U
j.modifier_enigma_talent6 = c()
local W = j.modifier_enigma_talent6
W.name = "modifier_enigma_talent6"
d(W, p)
function W.prototype.OnCreated(self, w)
	if IsServer() then
		self:StartIntervalThink(1)
	end
end
function W.prototype.OnIntervalThink(self)
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
W = e(
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
	W
)
j.modifier_enigma_talent6 = W
local X = "models/heroes/enigma/eidelon.vmdl"
local Y = 0.5
local Z = 0.8
k = c()
k.name = "EnigmaGhost"
function k.prototype.____constructor(self, _)
	self.attack_point = 0
	self.attack_backswing = 0
	self.animation_rate = 1
	self.record_attack_count = 0
	self.disposed = false
	self.parent = _.parent
	self.enemy = _.enemy
	self.ability = _.ability
	self.position = _.position
	self.direction = _.direction
	self.index = _.index
	self.buff = _.buff
	self.attack_interval = _.attack_interval
	self.attack_damage = _.attack_damage
	self.attack_count = _.attack_count
	self.chaos_damage_bonus_pct = _.chaos_damage_bonus_pct
	self.attack_mana_reply = _.attack_mana_reply
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
			model = Wearable:getReplaceUnitModel(self.parent, X),
			StartingAnim = "ACT_DOTA_SPAWN",
			StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
			DefaultAnim = "ACT_DOTA_IDLE",
			AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			use_animgraph = "1",
		}
	)
	local a0 = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_enigma/enigma_demonic_conversion.vpcf",
		PATTACH_ABSORIGIN,
		self.ghostDummy
	)
	ParticleManager:SetParticleControl(a0, 0, self.position)
	ParticleManager:ReleaseParticleIndex(a0)
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
function k.prototype.OnShardAttack(self)
	if self.ghostDummy and IsValid(self.ghostDummy) then
		local a1 = self.ghostDummy
		local a2 = self.position
		local a3 = self.direction
		self.ghostDummy = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{
				origin = a2,
				angles = VectorToAngles(a3),
				model = Wearable:getReplaceUnitModel(self.parent, X),
				StartingAnim = "ACT_DOTA_ATTACK",
				StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
				DefaultAnim = "ACT_DOTA_IDLE",
				use_animgraph = "1",
				AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			}
		)
		UTIL_Remove(a1)
	end
	local V = self.attack_damage + GetChaosDamageBonus(self.parent) * self.chaos_damage_bonus_pct * 0.01
	self.parent:DealDamage(
		self.enemy,
		self.ability,
		V,
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
function k.prototype.dispose(self, a4)
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
		local a5 = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{
				origin = self.position,
				angles = VectorToAngles(self.direction),
				model = Wearable:getReplaceUnitModel(self.parent, X),
				DefaultAnim = "ACT_DOTA_DIE",
				use_animgraph = "1",
				AnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
			}
		)
		GameTimer(1, function()
			if a5 and IsValid(a5) then
				UTIL_Remove(a5)
			end
		end)
		UTIL_Remove(self.ghostDummy)
	end
	self.ghostDummy = nil
	self.ambientParticle = nil
	self.attackParticle = nil
	self.attack_timer = nil
	if not a4 then
		local a6 = self.parent:FindModifierByName("modifier_enigma_talent")
		if a6 then
			a6:GhostDestroy(self.index)
		end
	end
end
return j