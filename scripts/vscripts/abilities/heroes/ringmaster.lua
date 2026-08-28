--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		["56"] = 69,
		["57"] = 49,
		["58"] = 71,
		["59"] = 72,
		["60"] = 73,
		["61"] = 74,
		["62"] = 75,
		["64"] = 71,
		["65"] = 78,
		["66"] = 79,
		["67"] = 80,
		["68"] = 81,
		["69"] = 82,
		["70"] = 83,
		["73"] = 86,
		["74"] = 78,
		["75"] = 88,
		["76"] = 89,
		["77"] = 89,
		["78"] = 89,
		["79"] = 92,
		["80"] = 92,
		["81"] = 92,
		["82"] = 89,
		["83"] = 93,
		["84"] = 93,
		["85"] = 93,
		["86"] = 89,
		["87"] = 89,
		["88"] = 88,
		["89"] = 96,
		["90"] = 97,
		["91"] = 98,
		["92"] = 98,
		["93"] = 98,
		["95"] = 98,
		["96"] = 99,
		["97"] = 100,
		["98"] = 101,
		["99"] = 102,
		["100"] = 104,
		["101"] = 104,
		["102"] = 104,
		["103"] = 104,
		["104"] = 104,
		["105"] = 104,
		["106"] = 107,
		["107"] = 96,
		["108"] = 109,
		["109"] = 110,
		["110"] = 112,
		["111"] = 113,
		["113"] = 116,
		["114"] = 117,
		["116"] = 109,
		["117"] = 120,
		["118"] = 121,
		["119"] = 122,
		["121"] = 124,
		["122"] = 125,
		["124"] = 127,
		["125"] = 128,
		["128"] = 131,
		["131"] = 134,
		["132"] = 135,
		["133"] = 137,
		["134"] = 138,
		["136"] = 141,
		["137"] = 142,
		["138"] = 143,
		["139"] = 144,
		["140"] = 145,
		["141"] = 145,
		["142"] = 145,
		["143"] = 146,
		["144"] = 145,
		["145"] = 145,
		["148"] = 150,
		["149"] = 120,
		["150"] = 152,
		["151"] = 153,
		["152"] = 154,
		["155"] = 157,
		["156"] = 158,
		["157"] = 159,
		["158"] = 160,
		["159"] = 161,
		["160"] = 162,
		["161"] = 162,
		["162"] = 162,
		["163"] = 162,
		["164"] = 162,
		["165"] = 162,
		["166"] = 162,
		["167"] = 162,
		["171"] = 152,
		["172"] = 167,
		["173"] = 168,
		["174"] = 169,
		["177"] = 172,
		["178"] = 173,
		["179"] = 174,
		["180"] = 175,
		["182"] = 177,
		["183"] = 178,
		["184"] = 179,
		["185"] = 180,
		["186"] = 181,
		["187"] = 182,
		["188"] = 183,
		["189"] = 183,
		["190"] = 183,
		["191"] = 183,
		["192"] = 183,
		["193"] = 183,
		["194"] = 183,
		["198"] = 167,
		["199"] = 189,
		["200"] = 190,
		["201"] = 191,
		["202"] = 192,
		["205"] = 195,
		["206"] = 196,
		["207"] = 196,
		["208"] = 196,
		["209"] = 196,
		["210"] = 196,
		["211"] = 197,
		["212"] = 197,
		["213"] = 197,
		["214"] = 197,
		["215"] = 197,
		["216"] = 198,
		["217"] = 198,
		["218"] = 198,
		["219"] = 199,
		["220"] = 200,
		["221"] = 198,
		["222"] = 198,
		["223"] = 202,
		["224"] = 203,
		["225"] = 203,
		["226"] = 203,
		["227"] = 203,
		["228"] = 203,
		["229"] = 203,
		["230"] = 203,
		["231"] = 189,
		["232"] = 206,
		["233"] = 207,
		["234"] = 208,
		["235"] = 209,
		["238"] = 212,
		["239"] = 213,
		["240"] = 214,
		["241"] = 215,
		["242"] = 217,
		["243"] = 218,
		["244"] = 219,
		["245"] = 219,
		["246"] = 219,
		["247"] = 219,
		["248"] = 219,
		["249"] = 219,
		["250"] = 219,
		["251"] = 219,
		["252"] = 219,
		["253"] = 219,
		["254"] = 219,
		["255"] = 219,
		["256"] = 229,
		["257"] = 230,
		["258"] = 230,
		["259"] = 230,
		["260"] = 230,
		["261"] = 230,
		["262"] = 230,
		["263"] = 230,
		["264"] = 230,
		["265"] = 230,
		["266"] = 231,
		["267"] = 231,
		["268"] = 231,
		["269"] = 231,
		["270"] = 231,
		["271"] = 232,
		["272"] = 232,
		["273"] = 232,
		["274"] = 232,
		["275"] = 232,
		["276"] = 232,
		["277"] = 232,
		["278"] = 232,
		["279"] = 232,
		["280"] = 206,
		["281"] = 234,
		["282"] = 235,
		["283"] = 236,
		["284"] = 237,
		["286"] = 239,
		["287"] = 234,
		["288"] = 241,
		["289"] = 242,
		["290"] = 241,
		["291"] = 246,
		["292"] = 247,
		["293"] = 246,
		["294"] = 21,
		["295"] = 13,
		["296"] = 13,
		["297"] = 13,
		["298"] = 13,
		["299"] = 13,
		["300"] = 13,
		["301"] = 13,
		["302"] = 13,
		["303"] = 21,
		["305"] = 21,
		["306"] = 251,
		["307"] = 259,
		["308"] = 251,
		["309"] = 259,
		["310"] = 262,
		["311"] = 263,
		["312"] = 265,
		["313"] = 262,
		["314"] = 267,
		["315"] = 268,
		["316"] = 269,
		["318"] = 267,
		["319"] = 272,
		["320"] = 273,
		["321"] = 272,
		["322"] = 277,
		["323"] = 278,
		["324"] = 279,
		["325"] = 280,
		["327"] = 282,
		["328"] = 277,
		["329"] = 285,
		["330"] = 286,
		["331"] = 285,
		["332"] = 259,
		["333"] = 251,
		["334"] = 251,
		["335"] = 251,
		["336"] = 251,
		["337"] = 251,
		["338"] = 251,
		["339"] = 251,
		["340"] = 251,
		["341"] = 259,
		["343"] = 259,
		["344"] = 291,
		["345"] = 292,
		["346"] = 291,
		["347"] = 292,
		["348"] = 295,
		["349"] = 296,
		["350"] = 297,
		["352"] = 299,
		["353"] = 300,
		["354"] = 301,
		["357"] = 304,
		["358"] = 305,
		["359"] = 306,
		["360"] = 306,
		["361"] = 306,
		["362"] = 306,
		["363"] = 306,
		["364"] = 306,
		["365"] = 306,
		["366"] = 306,
		["367"] = 306,
		["368"] = 307,
		["369"] = 307,
		["370"] = 308,
		["371"] = 309,
		["372"] = 312,
		["373"] = 313,
		["374"] = 314,
		["376"] = 317,
		["377"] = 317,
		["378"] = 317,
		["379"] = 318,
		["380"] = 319,
		["381"] = 320,
		["383"] = 322,
		["384"] = 317,
		["385"] = 317,
		["386"] = 295,
		["387"] = 325,
		["388"] = 326,
		["389"] = 327,
		["390"] = 328,
		["393"] = 331,
		["394"] = 332,
		["395"] = 332,
		["396"] = 332,
		["397"] = 332,
		["398"] = 332,
		["399"] = 332,
		["400"] = 332,
		["401"] = 332,
		["402"] = 332,
		["403"] = 333,
		["404"] = 333,
		["405"] = 333,
		["406"] = 333,
		["407"] = 333,
		["408"] = 333,
		["409"] = 333,
		["410"] = 333,
		["411"] = 333,
		["412"] = 334,
		["413"] = 336,
		["414"] = 337,
		["415"] = 337,
		["416"] = 337,
		["417"] = 337,
		["418"] = 337,
		["419"] = 338,
		["420"] = 339,
		["421"] = 341,
		["422"] = 342,
		["423"] = 344,
		["424"] = 345,
		["425"] = 346,
		["427"] = 349,
		["428"] = 350,
		["429"] = 351,
		["430"] = 352,
		["432"] = 354,
		["433"] = 355,
		["434"] = 356,
		["436"] = 359,
		["437"] = 360,
		["438"] = 361,
		["439"] = 362,
		["440"] = 362,
		["441"] = 362,
		["442"] = 362,
		["443"] = 362,
		["444"] = 362,
		["445"] = 362,
		["447"] = 364,
		["448"] = 364,
		["449"] = 364,
		["450"] = 364,
		["451"] = 364,
		["452"] = 364,
		["453"] = 364,
		["454"] = 364,
		["455"] = 364,
		["456"] = 373,
		["457"] = 373,
		["458"] = 373,
		["459"] = 373,
		["460"] = 373,
		["461"] = 373,
		["462"] = 373,
		["463"] = 325,
		["464"] = 375,
		["465"] = 376,
		["466"] = 375,
		["467"] = 292,
		["468"] = 291,
		["469"] = 292,
		["471"] = 292,
		["472"] = 381,
		["473"] = 389,
		["474"] = 381,
		["475"] = 389,
		["477"] = 389,
		["478"] = 396,
		["479"] = 381,
		["480"] = 397,
		["481"] = 398,
		["482"] = 397,
		["483"] = 400,
		["484"] = 401,
		["485"] = 402,
		["487"] = 400,
		["488"] = 405,
		["489"] = 406,
		["492"] = 407,
		["493"] = 408,
		["496"] = 411,
		["497"] = 412,
		["498"] = 412,
		["499"] = 412,
		["500"] = 412,
		["501"] = 412,
		["502"] = 412,
		["503"] = 412,
		["504"] = 412,
		["505"] = 412,
		["506"] = 413,
		["507"] = 413,
		["508"] = 413,
		["509"] = 413,
		["510"] = 413,
		["511"] = 414,
		["512"] = 414,
		["513"] = 414,
		["514"] = 414,
		["515"] = 414,
		["516"] = 415,
		["517"] = 415,
		["518"] = 415,
		["519"] = 415,
		["520"] = 415,
		["521"] = 416,
		["522"] = 416,
		["523"] = 416,
		["524"] = 416,
		["525"] = 416,
		["526"] = 418,
		["527"] = 419,
		["528"] = 419,
		["529"] = 419,
		["530"] = 419,
		["531"] = 419,
		["532"] = 419,
		["533"] = 419,
		["534"] = 419,
		["535"] = 419,
		["536"] = 420,
		["537"] = 420,
		["538"] = 420,
		["539"] = 420,
		["540"] = 420,
		["541"] = 421,
		["542"] = 421,
		["543"] = 421,
		["544"] = 421,
		["545"] = 421,
		["546"] = 422,
		["547"] = 422,
		["548"] = 422,
		["549"] = 422,
		["550"] = 422,
		["551"] = 423,
		["552"] = 423,
		["553"] = 423,
		["554"] = 423,
		["555"] = 423,
		["556"] = 424,
		["557"] = 424,
		["558"] = 429,
		["559"] = 405,
		["560"] = 431,
		["561"] = 432,
		["562"] = 433,
		["564"] = 434,
		["565"] = 434,
		["566"] = 435,
		["567"] = 436,
		["568"] = 437,
		["569"] = 437,
		["570"] = 437,
		["571"] = 437,
		["572"] = 437,
		["573"] = 437,
		["574"] = 437,
		["575"] = 437,
		["576"] = 437,
		["577"] = 438,
		["578"] = 439,
		["579"] = 440,
		["580"] = 441,
		["582"] = 443,
		["583"] = 444,
		["584"] = 445,
		["586"] = 434,
		["590"] = 449,
		["593"] = 431,
		["594"] = 453,
		["595"] = 454,
		["596"] = 455,
		["597"] = 455,
		["598"] = 454,
		["599"] = 453,
		["600"] = 458,
		["601"] = 459,
		["602"] = 460,
		["603"] = 461,
		["604"] = 462,
		["605"] = 463,
		["606"] = 464,
		["608"] = 466,
		["611"] = 469,
		["613"] = 470,
		["614"] = 470,
		["615"] = 471,
		["616"] = 472,
		["617"] = 473,
		["618"] = 474,
		["619"] = 470,
		["622"] = 476,
		["624"] = 458,
		["625"] = 389,
		["626"] = 381,
		["627"] = 381,
		["628"] = 381,
		["629"] = 381,
		["630"] = 381,
		["631"] = 381,
		["632"] = 381,
		["633"] = 381,
		["634"] = 389,
		["636"] = 389,
		["638"] = 482,
		["639"] = 490,
		["640"] = 482,
		["641"] = 490,
		["642"] = 491,
		["643"] = 492,
		["644"] = 493,
		["645"] = 494,
		["647"] = 491,
		["648"] = 498,
		["649"] = 499,
		["650"] = 500,
		["651"] = 501,
		["653"] = 498,
		["654"] = 504,
		["655"] = 505,
		["656"] = 506,
		["657"] = 507,
		["659"] = 504,
		["660"] = 510,
		["661"] = 511,
		["662"] = 510,
		["663"] = 513,
		["664"] = 514,
		["665"] = 513,
		["666"] = 490,
		["667"] = 482,
		["668"] = 482,
		["669"] = 482,
		["670"] = 482,
		["671"] = 482,
		["672"] = 482,
		["673"] = 482,
		["674"] = 482,
		["675"] = 490,
		["677"] = 490,
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
	end
end
function r.prototype.LoadStack(self)
	local u = Rounds:getCurrentRound() * self.round_count
	if self.tl1_level_factor > 0 then
		local v = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
		if v then
			u = u + math.floor(self.tl1_level_factor * v:getLevel())
		end
	end
	return math.max(u + self.tl2_count + self.s_count + self.g_delta, 0)
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
	local w = self:GetParent():GetPlayerOwnerID()
	local x = PlayerData:loadData(w, "ringmaster_g_delta")
	if x == nil then
		x = 0
	end
	self.g_delta = x
	local y = self:LoadStack()
	self.wheel_record = 0
	self.wheel_sec_record = 0
	self:SetStackCount(y)
	self:GetParent()
		:AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_ringmaster_talent_souvenir",
			{ souvenirCount = y }
		)
	self:GetParent():SetHealth(self:GetParent():GetMaxHealth())
end
function r.prototype.OnBattleStart(self, t)
	local y = self:GetStackCount()
	if y >= self.threshold then
		self:WhoopeeCushion()
	end
	if y >= self.threshold * 2 then
		self:WonderWheel()
	end
end
function r.prototype.OnBattleEnd(self, t)
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
	local w = self:GetParent():GetPlayerOwnerID()
	if t.winPlayerID == w then
		self.g_delta = self.g_delta + self.g_stack_add
		PlayerData:saveData(w, "ringmaster_g_delta", self.g_delta)
	else
		local u = self:GetStackCount()
		if u >= self.g_stack_lose then
			self.g_delta = self.g_delta - self.g_stack_lose
			PlayerData:saveData(w, "ringmaster_g_delta", self.g_delta)
			GameTimer(0, function()
				PlayerData:modifyHealth(w, self.g_health_add, false, true)
			end)
		end
	end
	self:SetStackCount(self:LoadStack())
end
function r.prototype.OnPoisonGained(self, t)
	if self.tl5_chance > 0 then
		if t.flag and bit.band(t.flag, PoisonFlags.POISON_FLAG_NO_EXTRA) == PoisonFlags.POISON_FLAG_NO_EXTRA then
			return
		end
		local z = self:GetStackCount() * self.tl5_chance
		if self:PRD(z, "tl5_chance") then
			local A = self:GetParent()
			local B = A:GetEnemy()
			if IsInjurable(A, B) then
				AddPoison(
					A,
					B,
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
			local A = self:GetParent()
			local B = A:GetEnemy()
			if IsInjurable(A, B) then
				AddPoison(A, B, self:GetStackCountBonusValue(self.ring_poison), "ringmaster_talent_wheel", "Ability")
			end
		end
	end
end
function r.prototype.WhoopeeCushion(self)
	local A = self:GetParent()
	local B = A:GetEnemy()
	if not IsInjurable(A, B) then
		return
	end
	local C = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ringmaster/ringmaster_innate_whoopee_cushion.vpcf",
		PATTACH_CUSTOMORIGIN,
		A
	)
	ParticleManager:SetParticleControl(C, 0, B:GetAbsOrigin())
	ParticleManager:SetParticleControl(C, 1, Vector(200, 0, 0))
	GameTimer(1, function()
		ParticleManager:DestroyParticle(C, false)
		ParticleManager:ReleaseParticleIndex(C)
	end)
	B:EmitSound("Hero_Ringmaster.WhoopeeCushion.Cast")
	AddPoison(A, B, self:GetStackCountBonusValue(self.seat_poison), "ringmaster_talent_cushion", "Ability")
end
function r.prototype.WonderWheel(self)
	local A = self:GetParent()
	local B = A:GetEnemy()
	if not IsInjurable(A, B) then
		return
	end
	self:StartIntervalThink(self.tick)
	local D = A:GetAbsOrigin() - B:GetAbsOrigin()
	D.z = 0
	D = D:Normalized()
	local E = B:GetAbsOrigin() + D * -200
	B:EmitSound("Hero_Ringmaster.FunhouseMirror.Cast")
	self.wheel_dummy = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{
			origin = E,
			model = Wearable:getReplaceUnitModel(A, "models/heroes/ringmaster/ringmaster_wheel_decoy.vmdl"),
			StartingAnim = "ACT_DOTA_SPAWN",
			StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
			IdleAnim = "ACT_DOTA_IDLE",
			scale = "1",
			angles = VectorToAngles(D),
		}
	)
	self.wheel_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ringmaster/ringmaster_ult_trap.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil,
		A
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
function r.prototype.GetStackCountBonusValue(self, F)
	local y = self:GetStackCount()
	if self.tl3_bonus_pct > 0 then
		y = y * (1 + self.tl3_bonus_pct * 0.01)
	end
	return F * y
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
local G = g.modifier_ringmaster_talent_souvenir
G.name = "modifier_ringmaster_talent_souvenir"
d(G, l)
function G.prototype.GetAbilitySpecialValue(self)
	self.water_health = self:GetAbilitySpecialValueFor("water_health")
	self.tl3_bonus_pct = self:GetAbilityTalentValue("ringmaster_talent_3", "bonus_pct")
end
function G.prototype.OnCreated(self, t)
	if IsServer() then
		self:SetStackCount(t and t.souvenirCount or 0)
	end
end
function G.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function G.prototype.GetStackCountBonusValue(self, F)
	local y = self:GetStackCount()
	if self.tl3_bonus_pct > 0 then
		y = y * (1 + self.tl3_bonus_pct * 0.01)
	end
	return F * y
end
function G.prototype.EOM_GetModifierHealthBonus(self, t)
	return self:GetStackCountBonusValue(self.water_health)
end
G = e(
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
	G
)
g.modifier_ringmaster_talent_souvenir = G
g.ringmaster_ult = c()
local H = g.ringmaster_ult
H.name = "ringmaster_ult"
d(H, o)
function H.prototype.OnSpellStart(self)
	if self.castingParticleList == nil then
		self.castingParticleList = {}
	end
	local I = self:GetCaster()
	local B = I:GetEnemy()
	if not IsInjurable(I, B) then
		return
	end
	local J = self:GetSpecialValueFor("delay")
	local C = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ringmaster/ringmaster_whip_twirl.vpcf",
		PATTACH_CUSTOMORIGIN,
		I
	)
	ParticleManager:SetParticleControlEnt(C, 0, I, PATTACH_ABSORIGIN_FOLLOW, nil, I:GetAbsOrigin(), true)
	local K = self.castingParticleList
	K[#K + 1] = C
	I:EmitSound("Hero_Ringmaster.Whip.Cast")
	I:AddNewModifier(I, self, "modifier_ringmaster_ult_cast", { duration = J })
	local L = I:FindModifierByName("modifier_ringmaster_ult")
	if IsValid(L) then
		L:OnCastWhip(B)
	end
	self:GameTimer(J, function()
		if ArrayRemove(self.castingParticleList, C) then
			ParticleManager:DestroyParticle(C, false)
			ParticleManager:ReleaseParticleIndex(C)
		end
		self:Whip()
	end)
end
function H.prototype.Whip(self)
	local I = self:GetCaster()
	local B = I:GetEnemy()
	if not IsInjurable(I, B) then
		return
	end
	local C = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ringmaster/ringmaster_whip.vpcf",
		PATTACH_CUSTOMORIGIN,
		I
	)
	ParticleManager:SetParticleControlEnt(C, 0, I, PATTACH_ABSORIGIN_FOLLOW, nil, I:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(C, 1, B, PATTACH_POINT_FOLLOW, "attach_hitloc", B:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(C)
	local M = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ringmaster/ringmaster_whip_crack_impact.vpcf",
		PATTACH_ABSORIGIN,
		B,
		I
	)
	ParticleManager:SetParticleControl(M, 1, Vector(100, 0, 0))
	ParticleManager:ReleaseParticleIndex(M)
	I:EmitSound("Hero_Ringmaster.Whip.Target")
	local N = self:GetSpecialValueFor("damage")
	local O = self:GetSpecialValueFor("poison_count")
	local P = self:GetTalentValue("ringmaster_talent_4", "poison_pct")
	if P > 0 then
		N = N + GetPoison(B) * P * 0.01
	end
	local Q = self:GetTalentValue("ringmaster_talent_6", "stack_value")
	if Q > 0 then
		if self.stackCount == nil then
			self.stackCount = 1
		end
		local y = I:GetModifierStackCount("modifier_ringmaster_talent", I) or 0
		O = O + y * Q * self.stackCount
		self.stackCount = self.stackCount + 1
	end
	local R = self:GetTalentValue("ringmaster_talent_7", "duration")
	if R > 0 then
		local S = self:GetTalentValue("ringmaster_talent_7", "stack")
		AddPoisonDeepen(I, B, self, S, R)
	end
	DamageSystem:dealDamage({
		attacker = I,
		target = B,
		ability = self,
		damage = N,
		damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
		damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
		damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
	})
	AddPoison(I, B, O, "ringmaster_ult", "Ability")
end
function H.prototype.GetIntrinsicModifierName(self)
	return "modifier_ringmaster_ult"
end
H = e({ p(nil) }, H)
g.ringmaster_ult = H
g.modifier_ringmaster_ult = c()
local T = g.modifier_ringmaster_ult
T.name = "modifier_ringmaster_ult"
d(T, l)
function T.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.cast_delay = 0.2
end
function T.prototype.GetAbilitySpecialValue(self)
	self.delay = self:GetAbilitySpecialValueFor("delay")
end
function T.prototype.OnCreated(self, t)
	if IsServer() then
		self.castIDList = {}
	end
end
function T.prototype.OnCastWhip(self, B)
	if IsClient() then
		return
	end
	local I = self:GetCaster()
	if not IsInjurable(I, B) then
		return
	end
	local U = ParticleManager:CreateParticle(
		"particles/ui_mouseactions/range_finder_generic_aoe.vpcf",
		PATTACH_CUSTOMORIGIN,
		I
	)
	ParticleManager:SetParticleControlEnt(U, 0, I, PATTACH_ABSORIGIN_FOLLOW, nil, I:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(U, 1, B:GetAbsOrigin())
	ParticleManager:SetParticleControl(U, 2, B:GetAbsOrigin())
	ParticleManager:SetParticleControl(U, 3, Vector(300, 0, 0))
	ParticleManager:SetParticleControl(U, 4, Vector(255, 255, 255))
	local M = ParticleManager:CreateParticle(
		"particles/ui_mouseactions/range_finder_generic_aoe.vpcf",
		PATTACH_CUSTOMORIGIN,
		I
	)
	ParticleManager:SetParticleControlEnt(M, 0, I, PATTACH_ABSORIGIN_FOLLOW, nil, I:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(M, 1, B:GetAbsOrigin())
	ParticleManager:SetParticleControl(M, 2, B:GetAbsOrigin())
	ParticleManager:SetParticleControl(M, 3, Vector(150, 0, 0))
	ParticleManager:SetParticleControl(M, 4, Vector(255, 255, 255))
	local V = self.castIDList
	V[#V + 1] = { id1 = U, id2 = M, time = self.delay + self.cast_delay }
	self:StartIntervalThink(FRAME_TIME)
end
function T.prototype.OnIntervalThink(self)
	if IsServer() then
		if #self.castIDList > 0 then
			do
				local W = #self.castIDList - 1
				while W >= 0 do
					self.castIDList[W + 1].time = self.castIDList[W + 1].time - FRAME_TIME
					if self.castIDList[W + 1].time > self.cast_delay then
						ParticleManager:SetParticleControl(
							self.castIDList[W + 1].id1,
							3,
							Vector(
								Clamp((self.castIDList[W + 1].time - self.cast_delay) * 100, 0, 100) * 150 * 0.01 + 150,
								0,
								0
							)
						)
					elseif self.castIDList[W + 1].time >= 0 then
						ParticleManager:DestroyParticle(self.castIDList[W + 1].id1, false)
						ParticleManager:ReleaseParticleIndex(self.castIDList[W + 1].id1)
						self.castIDList[W + 1].id1 = -1
					else
						ParticleManager:DestroyParticle(self.castIDList[W + 1].id2, false)
						ParticleManager:ReleaseParticleIndex(self.castIDList[W + 1].id2)
						table.remove(self.castIDList, W + 1)
					end
					W = W - 1
				end
			end
		else
			self:StartIntervalThink(-1)
		end
	end
end
function T.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function T.prototype.OnBattleEnd(self, t)
	local X = self:GetAbility()
	if IsValid(X) then
		if X.castingParticleList then
			for Y, C in ipairs(X.castingParticleList) do
				ParticleManager:DestroyParticle(C, false)
				ParticleManager:ReleaseParticleIndex(C)
			end
			X.castingParticleList = {}
		end
	end
	if #self.castIDList > 0 then
		do
			local W = 0
			while W < #self.castIDList do
				ParticleManager:DestroyParticle(self.castIDList[W + 1].id1, false)
				ParticleManager:ReleaseParticleIndex(self.castIDList[W + 1].id1)
				ParticleManager:DestroyParticle(self.castIDList[W + 1].id2, false)
				ParticleManager:ReleaseParticleIndex(self.castIDList[W + 1].id2)
				W = W + 1
			end
		end
		self.castIDList = {}
	end
end
T = e(
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
	T
)
g.modifier_ringmaster_ult = T
g.modifier_ringmaster_ult_cast = c()
local Z = g.modifier_ringmaster_ult_cast
Z.name = "modifier_ringmaster_ult_cast"
d(Z, l)
function Z.prototype.OnCreated(self, t)
	if IsServer() then
		self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_1)
		self:GetParent():EmitSound("Hero_Ringmaster.Whip.Channel")
	end
end
function Z.prototype.OnRefresh(self, t)
	if IsServer() then
		self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_1)
		self:GetParent():EmitSound("Hero_Ringmaster.Whip.Channel")
	end
end
function Z.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_1_END)
		self:GetParent():StopSound("Hero_Ringmaster.Whip.Channel")
	end
end
function Z.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function Z.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_CHANNEL_ABILITY_1
end
Z = e(
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
	Z
)
g.modifier_ringmaster_ult_cast = Z
return g