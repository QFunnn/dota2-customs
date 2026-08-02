--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
		["35"] = 44,
		["36"] = 45,
		["37"] = 13,
		["38"] = 46,
		["39"] = 47,
		["40"] = 46,
		["41"] = 49,
		["42"] = 50,
		["43"] = 51,
		["44"] = 52,
		["45"] = 53,
		["46"] = 54,
		["47"] = 55,
		["48"] = 57,
		["49"] = 59,
		["50"] = 61,
		["51"] = 63,
		["52"] = 65,
		["53"] = 66,
		["54"] = 67,
		["55"] = 68,
		["56"] = 49,
		["57"] = 70,
		["58"] = 71,
		["59"] = 72,
		["60"] = 73,
		["61"] = 74,
		["63"] = 70,
		["64"] = 77,
		["65"] = 78,
		["66"] = 79,
		["67"] = 80,
		["68"] = 81,
		["69"] = 82,
		["72"] = 85,
		["73"] = 77,
		["74"] = 87,
		["75"] = 88,
		["76"] = 88,
		["77"] = 88,
		["78"] = 91,
		["79"] = 91,
		["80"] = 91,
		["81"] = 88,
		["82"] = 92,
		["83"] = 92,
		["84"] = 92,
		["85"] = 88,
		["86"] = 88,
		["87"] = 87,
		["88"] = 95,
		["89"] = 96,
		["90"] = 97,
		["91"] = 97,
		["92"] = 97,
		["94"] = 97,
		["95"] = 98,
		["96"] = 99,
		["97"] = 100,
		["98"] = 101,
		["99"] = 103,
		["100"] = 103,
		["101"] = 103,
		["102"] = 103,
		["103"] = 103,
		["104"] = 103,
		["105"] = 106,
		["106"] = 95,
		["107"] = 108,
		["108"] = 109,
		["109"] = 111,
		["110"] = 112,
		["112"] = 115,
		["113"] = 116,
		["115"] = 108,
		["116"] = 119,
		["117"] = 120,
		["118"] = 121,
		["120"] = 123,
		["121"] = 124,
		["123"] = 126,
		["124"] = 127,
		["127"] = 130,
		["130"] = 133,
		["131"] = 134,
		["132"] = 136,
		["133"] = 137,
		["135"] = 140,
		["136"] = 141,
		["137"] = 142,
		["138"] = 143,
		["139"] = 144,
		["140"] = 144,
		["141"] = 144,
		["142"] = 145,
		["143"] = 144,
		["144"] = 144,
		["147"] = 149,
		["148"] = 119,
		["149"] = 151,
		["150"] = 152,
		["151"] = 153,
		["154"] = 156,
		["155"] = 157,
		["156"] = 158,
		["157"] = 159,
		["158"] = 160,
		["159"] = 161,
		["160"] = 161,
		["161"] = 161,
		["162"] = 161,
		["163"] = 161,
		["164"] = 161,
		["165"] = 161,
		["166"] = 161,
		["170"] = 151,
		["171"] = 166,
		["172"] = 167,
		["173"] = 168,
		["176"] = 171,
		["177"] = 172,
		["178"] = 173,
		["179"] = 174,
		["181"] = 176,
		["182"] = 177,
		["183"] = 178,
		["184"] = 179,
		["185"] = 180,
		["186"] = 181,
		["187"] = 182,
		["188"] = 182,
		["189"] = 182,
		["190"] = 182,
		["191"] = 182,
		["192"] = 182,
		["193"] = 182,
		["197"] = 166,
		["198"] = 188,
		["199"] = 189,
		["200"] = 190,
		["201"] = 191,
		["204"] = 194,
		["205"] = 195,
		["206"] = 195,
		["207"] = 195,
		["208"] = 195,
		["209"] = 195,
		["210"] = 196,
		["211"] = 196,
		["212"] = 196,
		["213"] = 196,
		["214"] = 196,
		["215"] = 197,
		["216"] = 197,
		["217"] = 197,
		["218"] = 198,
		["219"] = 199,
		["220"] = 197,
		["221"] = 197,
		["222"] = 201,
		["223"] = 202,
		["224"] = 202,
		["225"] = 202,
		["226"] = 202,
		["227"] = 202,
		["228"] = 202,
		["229"] = 202,
		["230"] = 188,
		["231"] = 205,
		["232"] = 206,
		["233"] = 207,
		["234"] = 208,
		["237"] = 211,
		["238"] = 212,
		["239"] = 213,
		["240"] = 214,
		["241"] = 216,
		["242"] = 217,
		["243"] = 218,
		["244"] = 218,
		["245"] = 218,
		["246"] = 218,
		["247"] = 218,
		["248"] = 218,
		["249"] = 218,
		["250"] = 218,
		["251"] = 218,
		["252"] = 218,
		["253"] = 218,
		["254"] = 218,
		["255"] = 228,
		["256"] = 229,
		["257"] = 229,
		["258"] = 229,
		["259"] = 229,
		["260"] = 229,
		["261"] = 229,
		["262"] = 229,
		["263"] = 229,
		["264"] = 229,
		["265"] = 230,
		["266"] = 230,
		["267"] = 230,
		["268"] = 230,
		["269"] = 230,
		["270"] = 231,
		["271"] = 231,
		["272"] = 231,
		["273"] = 231,
		["274"] = 231,
		["275"] = 231,
		["276"] = 231,
		["277"] = 231,
		["278"] = 231,
		["279"] = 205,
		["280"] = 233,
		["281"] = 234,
		["282"] = 235,
		["283"] = 236,
		["285"] = 238,
		["286"] = 233,
		["287"] = 240,
		["288"] = 241,
		["289"] = 240,
		["290"] = 245,
		["291"] = 246,
		["292"] = 245,
		["293"] = 21,
		["294"] = 13,
		["295"] = 13,
		["296"] = 13,
		["297"] = 13,
		["298"] = 13,
		["299"] = 13,
		["300"] = 13,
		["301"] = 13,
		["302"] = 21,
		["304"] = 21,
		["305"] = 250,
		["306"] = 258,
		["307"] = 250,
		["308"] = 258,
		["309"] = 261,
		["310"] = 262,
		["311"] = 264,
		["312"] = 261,
		["313"] = 266,
		["314"] = 267,
		["315"] = 268,
		["317"] = 266,
		["318"] = 271,
		["319"] = 272,
		["320"] = 271,
		["321"] = 276,
		["322"] = 277,
		["323"] = 278,
		["324"] = 279,
		["326"] = 281,
		["327"] = 276,
		["328"] = 284,
		["329"] = 285,
		["330"] = 284,
		["331"] = 258,
		["332"] = 250,
		["333"] = 250,
		["334"] = 250,
		["335"] = 250,
		["336"] = 250,
		["337"] = 250,
		["338"] = 250,
		["339"] = 250,
		["340"] = 258,
		["342"] = 258,
		["343"] = 290,
		["344"] = 291,
		["345"] = 290,
		["346"] = 291,
		["347"] = 294,
		["348"] = 295,
		["349"] = 296,
		["351"] = 298,
		["352"] = 299,
		["353"] = 300,
		["356"] = 303,
		["357"] = 304,
		["358"] = 305,
		["359"] = 305,
		["360"] = 305,
		["361"] = 305,
		["362"] = 305,
		["363"] = 305,
		["364"] = 305,
		["365"] = 305,
		["366"] = 305,
		["367"] = 306,
		["368"] = 306,
		["369"] = 307,
		["370"] = 308,
		["371"] = 311,
		["372"] = 312,
		["373"] = 313,
		["375"] = 316,
		["376"] = 316,
		["377"] = 316,
		["378"] = 317,
		["379"] = 318,
		["380"] = 319,
		["382"] = 321,
		["383"] = 316,
		["384"] = 316,
		["385"] = 294,
		["386"] = 324,
		["387"] = 325,
		["388"] = 326,
		["389"] = 327,
		["392"] = 330,
		["393"] = 331,
		["394"] = 331,
		["395"] = 331,
		["396"] = 331,
		["397"] = 331,
		["398"] = 331,
		["399"] = 331,
		["400"] = 331,
		["401"] = 331,
		["402"] = 332,
		["403"] = 332,
		["404"] = 332,
		["405"] = 332,
		["406"] = 332,
		["407"] = 332,
		["408"] = 332,
		["409"] = 332,
		["410"] = 332,
		["411"] = 333,
		["412"] = 335,
		["413"] = 336,
		["414"] = 336,
		["415"] = 336,
		["416"] = 336,
		["417"] = 336,
		["418"] = 337,
		["419"] = 338,
		["420"] = 340,
		["421"] = 341,
		["422"] = 343,
		["423"] = 344,
		["424"] = 345,
		["426"] = 348,
		["427"] = 349,
		["428"] = 350,
		["429"] = 351,
		["431"] = 353,
		["432"] = 354,
		["433"] = 355,
		["435"] = 358,
		["436"] = 359,
		["437"] = 360,
		["438"] = 361,
		["439"] = 361,
		["440"] = 361,
		["441"] = 361,
		["442"] = 361,
		["443"] = 361,
		["444"] = 361,
		["446"] = 363,
		["447"] = 363,
		["448"] = 363,
		["449"] = 363,
		["450"] = 363,
		["451"] = 363,
		["452"] = 363,
		["453"] = 363,
		["454"] = 363,
		["455"] = 372,
		["456"] = 372,
		["457"] = 372,
		["458"] = 372,
		["459"] = 372,
		["460"] = 372,
		["461"] = 372,
		["462"] = 324,
		["463"] = 374,
		["464"] = 375,
		["465"] = 374,
		["466"] = 291,
		["467"] = 290,
		["468"] = 291,
		["470"] = 291,
		["471"] = 380,
		["472"] = 388,
		["473"] = 380,
		["474"] = 388,
		["476"] = 388,
		["477"] = 395,
		["478"] = 380,
		["479"] = 396,
		["480"] = 397,
		["481"] = 396,
		["482"] = 399,
		["483"] = 400,
		["484"] = 401,
		["486"] = 399,
		["487"] = 404,
		["488"] = 405,
		["491"] = 406,
		["492"] = 407,
		["495"] = 410,
		["496"] = 411,
		["497"] = 411,
		["498"] = 411,
		["499"] = 411,
		["500"] = 411,
		["501"] = 411,
		["502"] = 411,
		["503"] = 411,
		["504"] = 411,
		["505"] = 412,
		["506"] = 412,
		["507"] = 412,
		["508"] = 412,
		["509"] = 412,
		["510"] = 413,
		["511"] = 413,
		["512"] = 413,
		["513"] = 413,
		["514"] = 413,
		["515"] = 414,
		["516"] = 414,
		["517"] = 414,
		["518"] = 414,
		["519"] = 414,
		["520"] = 415,
		["521"] = 415,
		["522"] = 415,
		["523"] = 415,
		["524"] = 415,
		["525"] = 417,
		["526"] = 418,
		["527"] = 418,
		["528"] = 418,
		["529"] = 418,
		["530"] = 418,
		["531"] = 418,
		["532"] = 418,
		["533"] = 418,
		["534"] = 418,
		["535"] = 419,
		["536"] = 419,
		["537"] = 419,
		["538"] = 419,
		["539"] = 419,
		["540"] = 420,
		["541"] = 420,
		["542"] = 420,
		["543"] = 420,
		["544"] = 420,
		["545"] = 421,
		["546"] = 421,
		["547"] = 421,
		["548"] = 421,
		["549"] = 421,
		["550"] = 422,
		["551"] = 422,
		["552"] = 422,
		["553"] = 422,
		["554"] = 422,
		["555"] = 423,
		["556"] = 423,
		["557"] = 428,
		["558"] = 404,
		["559"] = 430,
		["560"] = 431,
		["561"] = 432,
		["563"] = 433,
		["564"] = 433,
		["565"] = 434,
		["566"] = 435,
		["567"] = 436,
		["568"] = 436,
		["569"] = 436,
		["570"] = 436,
		["571"] = 436,
		["572"] = 436,
		["573"] = 436,
		["574"] = 436,
		["575"] = 436,
		["576"] = 437,
		["577"] = 438,
		["578"] = 439,
		["579"] = 440,
		["581"] = 442,
		["582"] = 443,
		["583"] = 444,
		["585"] = 433,
		["589"] = 448,
		["592"] = 430,
		["593"] = 452,
		["594"] = 453,
		["595"] = 454,
		["596"] = 454,
		["597"] = 453,
		["598"] = 452,
		["599"] = 457,
		["600"] = 458,
		["601"] = 459,
		["602"] = 460,
		["603"] = 461,
		["604"] = 462,
		["605"] = 463,
		["607"] = 465,
		["610"] = 468,
		["612"] = 469,
		["613"] = 469,
		["614"] = 470,
		["615"] = 471,
		["616"] = 472,
		["617"] = 473,
		["618"] = 469,
		["621"] = 475,
		["623"] = 457,
		["624"] = 388,
		["625"] = 380,
		["626"] = 380,
		["627"] = 380,
		["628"] = 380,
		["629"] = 380,
		["630"] = 380,
		["631"] = 380,
		["632"] = 380,
		["633"] = 388,
		["635"] = 388,
		["637"] = 481,
		["638"] = 489,
		["639"] = 481,
		["640"] = 489,
		["641"] = 490,
		["642"] = 491,
		["643"] = 492,
		["644"] = 493,
		["646"] = 490,
		["647"] = 497,
		["648"] = 498,
		["649"] = 499,
		["650"] = 500,
		["652"] = 497,
		["653"] = 503,
		["654"] = 504,
		["655"] = 505,
		["656"] = 506,
		["658"] = 503,
		["659"] = 509,
		["660"] = 510,
		["661"] = 509,
		["662"] = 512,
		["663"] = 513,
		["664"] = 512,
		["665"] = 489,
		["666"] = 481,
		["667"] = 481,
		["668"] = 481,
		["669"] = 481,
		["670"] = 481,
		["671"] = 481,
		["672"] = 481,
		["673"] = 481,
		["674"] = 489,
		["676"] = 489,
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
	self.tl1_level_factor = self:GetAbilityTalentValue("ringmaster_talent_1", "level_factor")
	self.tl2_count = self:GetAbilityTalentValue("ringmaster_talent_2", "count")
	self.tl3_bonus_pct = self:GetAbilityTalentValue("ringmaster_talent_3", "bonus_pct")
	self.tl5_chance = self:GetAbilityTalentValue("ringmaster_talent_5", "chance")
	self.s_count = self:GetAbilityTalentValue("ringmaster_shard", "count")
	self.g_stack_add = self:GetAbilitySpecialValueFor("g_stack_add")
	self.g_stack_lose = self:GetAbilitySpecialValueFor("g_stack_lose")
	self.g_health_add = self:GetAbilitySpecialValueFor("g_health_add")
end
function r.prototype.OnCreated(self, s)
	if IsServer() then
		self.wheel_record = 0
		self.wheel_sec_record = 0
		self:SetStackCount(self:LoadStack())
	end
end
function r.prototype.LoadStack(self)
	local t = Rounds:getCurrentRound() * self.round_count
	if self.tl1_level_factor > 0 then
		local u = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
		if u then
			t = t + math.floor(self.tl1_level_factor * u:getLevel())
		end
	end
	return math.max(t + self.tl2_count + self.s_count + self.g_delta, 0)
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_POISON_GAINED] = { self:GetParent(), -1 },
	}
end
function r.prototype.OnBattleStartBefore(self, s)
	local v = self:GetParent():GetPlayerOwnerID()
	local w = PlayerData:loadData(v, "ringmaster_g_delta")
	if w == nil then
		w = 0
	end
	self.g_delta = w
	local x = self:LoadStack()
	self.wheel_record = 0
	self.wheel_sec_record = 0
	self:SetStackCount(x)
	self:GetParent()
		:AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_ringmaster_talent_souvenir",
			{ souvenirCount = x }
		)
	self:GetParent():SetHealth(self:GetParent():GetMaxHealth())
end
function r.prototype.OnBattleStart(self, s)
	local x = self:GetStackCount()
	if x >= self.threshold then
		self:WhoopeeCushion()
	end
	if x >= self.threshold * 2 then
		self:WonderWheel()
	end
end
function r.prototype.OnBattleEnd(self, s)
	if self.wheel_particle ~= nil then
		ParticleManager:DestroyParticle(self.wheel_particle, false)
	end
	if IsValid(self.wheel_dummy) then
		self.wheel_dummy:RemoveSelf()
	end
	self:StartIntervalThink(-1)
	if s.isNeutral then
		return
	end
	if self.parent:IsCustomIllusion() then
		return
	end
	local v = self:GetParent():GetPlayerOwnerID()
	if s.winPlayerID == v then
		self.g_delta = self.g_delta + self.g_stack_add
		PlayerData:saveData(v, "ringmaster_g_delta", self.g_delta)
	else
		local t = self:GetStackCount()
		if t >= self.g_stack_lose then
			self.g_delta = self.g_delta - self.g_stack_lose
			PlayerData:saveData(v, "ringmaster_g_delta", self.g_delta)
			GameTimer(0, function()
				PlayerData:modifyHealth(v, self.g_health_add, false, true)
			end)
		end
	end
	self:SetStackCount(self:LoadStack())
end
function r.prototype.OnPoisonGained(self, s)
	if self.tl5_chance > 0 then
		if s.flag and bit.band(s.flag, PoisonFlags.POISON_FLAG_NO_EXTRA) == PoisonFlags.POISON_FLAG_NO_EXTRA then
			return
		end
		local y = self:GetStackCount() * self.tl5_chance
		if self:PRD(y, "tl5_chance") then
			local z = self:GetParent()
			local A = z:GetEnemy()
			if IsInjurable(z, A) then
				AddPoison(
					z,
					A,
					s.iStackCount,
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
			local z = self:GetParent()
			local A = z:GetEnemy()
			if IsInjurable(z, A) then
				AddPoison(z, A, self:GetStackCountBonusValue(self.ring_poison), "ringmaster_talent_wheel", "Ability")
			end
		end
	end
end
function r.prototype.WhoopeeCushion(self)
	local z = self:GetParent()
	local A = z:GetEnemy()
	if not IsInjurable(z, A) then
		return
	end
	local B = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ringmaster/ringmaster_innate_whoopee_cushion.vpcf",
		PATTACH_CUSTOMORIGIN,
		z
	)
	ParticleManager:SetParticleControl(B, 0, A:GetAbsOrigin())
	ParticleManager:SetParticleControl(B, 1, Vector(200, 0, 0))
	GameTimer(1, function()
		ParticleManager:DestroyParticle(B, false)
		ParticleManager:ReleaseParticleIndex(B)
	end)
	A:EmitSound("Hero_Ringmaster.WhoopeeCushion.Cast")
	AddPoison(z, A, self:GetStackCountBonusValue(self.seat_poison), "ringmaster_talent_cushion", "Ability")
end
function r.prototype.WonderWheel(self)
	local z = self:GetParent()
	local A = z:GetEnemy()
	if not IsInjurable(z, A) then
		return
	end
	self:StartIntervalThink(self.tick)
	local C = z:GetAbsOrigin() - A:GetAbsOrigin()
	C.z = 0
	C = C:Normalized()
	local D = A:GetAbsOrigin() + C * -200
	A:EmitSound("Hero_Ringmaster.FunhouseMirror.Cast")
	self.wheel_dummy = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{
			origin = D,
			model = Wearable:getReplaceUnitModel(z, "models/heroes/ringmaster/ringmaster_wheel_decoy.vmdl"),
			StartingAnim = "ACT_DOTA_SPAWN",
			StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
			IdleAnim = "ACT_DOTA_IDLE",
			scale = "1",
			angles = VectorToAngles(C),
		}
	)
	self.wheel_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ringmaster/ringmaster_ult_trap.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil,
		z
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
function r.prototype.GetStackCountBonusValue(self, E)
	local x = self:GetStackCount()
	if self.tl3_bonus_pct > 0 then
		x = x * (1 + self.tl3_bonus_pct * 0.01)
	end
	return E * x
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
local F = g.modifier_ringmaster_talent_souvenir
F.name = "modifier_ringmaster_talent_souvenir"
d(F, l)
function F.prototype.GetAbilitySpecialValue(self)
	self.water_health = self:GetAbilitySpecialValueFor("water_health")
	self.tl3_bonus_pct = self:GetAbilityTalentValue("ringmaster_talent_3", "bonus_pct")
end
function F.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(s and s.souvenirCount or 0)
	end
end
function F.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function F.prototype.GetStackCountBonusValue(self, E)
	local x = self:GetStackCount()
	if self.tl3_bonus_pct > 0 then
		x = x * (1 + self.tl3_bonus_pct * 0.01)
	end
	return E * x
end
function F.prototype.EOM_GetModifierHealthBonus(self, s)
	return self:GetStackCountBonusValue(self.water_health)
end
F = e(
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
	F
)
g.modifier_ringmaster_talent_souvenir = F
g.ringmaster_ult = c()
local G = g.ringmaster_ult
G.name = "ringmaster_ult"
d(G, o)
function G.prototype.OnSpellStart(self)
	if self.castingParticleList == nil then
		self.castingParticleList = {}
	end
	local H = self:GetCaster()
	local A = H:GetEnemy()
	if not IsInjurable(H, A) then
		return
	end
	local I = self:GetSpecialValueFor("delay")
	local B = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ringmaster/ringmaster_whip_twirl.vpcf",
		PATTACH_CUSTOMORIGIN,
		H
	)
	ParticleManager:SetParticleControlEnt(B, 0, H, PATTACH_ABSORIGIN_FOLLOW, nil, H:GetAbsOrigin(), true)
	local J = self.castingParticleList
	J[#J + 1] = B
	H:EmitSound("Hero_Ringmaster.Whip.Cast")
	H:AddNewModifier(H, self, "modifier_ringmaster_ult_cast", { duration = I })
	local K = H:FindModifierByName("modifier_ringmaster_ult")
	if IsValid(K) then
		K:OnCastWhip(A)
	end
	self:GameTimer(I, function()
		if ArrayRemove(self.castingParticleList, B) then
			ParticleManager:DestroyParticle(B, false)
			ParticleManager:ReleaseParticleIndex(B)
		end
		self:Whip()
	end)
end
function G.prototype.Whip(self)
	local H = self:GetCaster()
	local A = H:GetEnemy()
	if not IsInjurable(H, A) then
		return
	end
	local B = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ringmaster/ringmaster_whip.vpcf",
		PATTACH_CUSTOMORIGIN,
		H
	)
	ParticleManager:SetParticleControlEnt(B, 0, H, PATTACH_ABSORIGIN_FOLLOW, nil, H:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(B, 1, A, PATTACH_POINT_FOLLOW, "attach_hitloc", A:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(B)
	local L = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ringmaster/ringmaster_whip_crack_impact.vpcf",
		PATTACH_ABSORIGIN,
		A,
		H
	)
	ParticleManager:SetParticleControl(L, 1, Vector(100, 0, 0))
	ParticleManager:ReleaseParticleIndex(L)
	H:EmitSound("Hero_Ringmaster.Whip.Target")
	local M = self:GetSpecialValueFor("damage")
	local N = self:GetSpecialValueFor("poison_count")
	local O = self:GetTalentValue("ringmaster_talent_4", "poison_pct")
	if O > 0 then
		M = M + GetPoison(A) * O * 0.01
	end
	local P = self:GetTalentValue("ringmaster_talent_6", "stack_value")
	if P > 0 then
		if self.stackCount == nil then
			self.stackCount = 1
		end
		local x = H:GetModifierStackCount("modifier_ringmaster_talent", H) or 0
		N = N + x * P * self.stackCount
		self.stackCount = self.stackCount + 1
	end
	local Q = self:GetTalentValue("ringmaster_talent_7", "duration")
	if Q > 0 then
		local R = self:GetTalentValue("ringmaster_talent_7", "stack")
		AddPoisonDeepen(H, A, self, R, Q)
	end
	DamageSystem:dealDamage({
		attacker = H,
		target = A,
		ability = self,
		damage = M,
		damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
		damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
		damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
	})
	AddPoison(H, A, N, "ringmaster_ult", "Ability")
end
function G.prototype.GetIntrinsicModifierName(self)
	return "modifier_ringmaster_ult"
end
G = e({ p(nil) }, G)
g.ringmaster_ult = G
g.modifier_ringmaster_ult = c()
local S = g.modifier_ringmaster_ult
S.name = "modifier_ringmaster_ult"
d(S, l)
function S.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.cast_delay = 0.2
end
function S.prototype.GetAbilitySpecialValue(self)
	self.delay = self:GetAbilitySpecialValueFor("delay")
end
function S.prototype.OnCreated(self, s)
	if IsServer() then
		self.castIDList = {}
	end
end
function S.prototype.OnCastWhip(self, A)
	if IsClient() then
		return
	end
	local H = self:GetCaster()
	if not IsInjurable(H, A) then
		return
	end
	local T = ParticleManager:CreateParticle(
		"particles/ui_mouseactions/range_finder_generic_aoe.vpcf",
		PATTACH_CUSTOMORIGIN,
		H
	)
	ParticleManager:SetParticleControlEnt(T, 0, H, PATTACH_ABSORIGIN_FOLLOW, nil, H:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(T, 1, A:GetAbsOrigin())
	ParticleManager:SetParticleControl(T, 2, A:GetAbsOrigin())
	ParticleManager:SetParticleControl(T, 3, Vector(300, 0, 0))
	ParticleManager:SetParticleControl(T, 4, Vector(255, 255, 255))
	local L = ParticleManager:CreateParticle(
		"particles/ui_mouseactions/range_finder_generic_aoe.vpcf",
		PATTACH_CUSTOMORIGIN,
		H
	)
	ParticleManager:SetParticleControlEnt(L, 0, H, PATTACH_ABSORIGIN_FOLLOW, nil, H:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(L, 1, A:GetAbsOrigin())
	ParticleManager:SetParticleControl(L, 2, A:GetAbsOrigin())
	ParticleManager:SetParticleControl(L, 3, Vector(150, 0, 0))
	ParticleManager:SetParticleControl(L, 4, Vector(255, 255, 255))
	local U = self.castIDList
	U[#U + 1] = { id1 = T, id2 = L, time = self.delay + self.cast_delay }
	self:StartIntervalThink(FRAME_TIME)
end
function S.prototype.OnIntervalThink(self)
	if IsServer() then
		if #self.castIDList > 0 then
			do
				local V = #self.castIDList - 1
				while V >= 0 do
					self.castIDList[V + 1].time = self.castIDList[V + 1].time - FRAME_TIME
					if self.castIDList[V + 1].time > self.cast_delay then
						ParticleManager:SetParticleControl(
							self.castIDList[V + 1].id1,
							3,
							Vector(
								Clamp((self.castIDList[V + 1].time - self.cast_delay) * 100, 0, 100) * 150 * 0.01 + 150,
								0,
								0
							)
						)
					elseif self.castIDList[V + 1].time >= 0 then
						ParticleManager:DestroyParticle(self.castIDList[V + 1].id1, false)
						ParticleManager:ReleaseParticleIndex(self.castIDList[V + 1].id1)
						self.castIDList[V + 1].id1 = -1
					else
						ParticleManager:DestroyParticle(self.castIDList[V + 1].id2, false)
						ParticleManager:ReleaseParticleIndex(self.castIDList[V + 1].id2)
						table.remove(self.castIDList, V + 1)
					end
					V = V - 1
				end
			end
		else
			self:StartIntervalThink(-1)
		end
	end
end
function S.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function S.prototype.OnBattleEnd(self, s)
	local W = self:GetAbility()
	if IsValid(W) then
		if W.castingParticleList then
			for X, B in ipairs(W.castingParticleList) do
				ParticleManager:DestroyParticle(B, false)
				ParticleManager:ReleaseParticleIndex(B)
			end
			W.castingParticleList = {}
		end
	end
	if #self.castIDList > 0 then
		do
			local V = 0
			while V < #self.castIDList do
				ParticleManager:DestroyParticle(self.castIDList[V + 1].id1, false)
				ParticleManager:ReleaseParticleIndex(self.castIDList[V + 1].id1)
				ParticleManager:DestroyParticle(self.castIDList[V + 1].id2, false)
				ParticleManager:ReleaseParticleIndex(self.castIDList[V + 1].id2)
				V = V + 1
			end
		end
		self.castIDList = {}
	end
end
S = e(
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
	S
)
g.modifier_ringmaster_ult = S
g.modifier_ringmaster_ult_cast = c()
local Y = g.modifier_ringmaster_ult_cast
Y.name = "modifier_ringmaster_ult_cast"
d(Y, l)
function Y.prototype.OnCreated(self, s)
	if IsServer() then
		self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_1)
		self:GetParent():EmitSound("Hero_Ringmaster.Whip.Channel")
	end
end
function Y.prototype.OnRefresh(self, s)
	if IsServer() then
		self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_1)
		self:GetParent():EmitSound("Hero_Ringmaster.Whip.Channel")
	end
end
function Y.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_1_END)
		self:GetParent():StopSound("Hero_Ringmaster.Whip.Channel")
	end
end
function Y.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function Y.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_CHANNEL_ABILITY_1
end
Y = e(
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
	Y
)
g.modifier_ringmaster_ult_cast = Y
return g