--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/doom_bringer"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayConcat
local g = b.__TS__ArrayFilter
local h = b.__TS__ObjectKeys
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 3,
		["15"] = 3,
		["16"] = 3,
		["17"] = 4,
		["18"] = 4,
		["19"] = 4,
		["20"] = 6,
		["21"] = 7,
		["22"] = 6,
		["23"] = 7,
		["24"] = 8,
		["25"] = 9,
		["26"] = 8,
		["27"] = 7,
		["28"] = 6,
		["29"] = 7,
		["31"] = 7,
		["32"] = 13,
		["33"] = 21,
		["34"] = 13,
		["35"] = 21,
		["36"] = 27,
		["37"] = 28,
		["38"] = 30,
		["39"] = 31,
		["40"] = 33,
		["41"] = 27,
		["42"] = 35,
		["43"] = 36,
		["44"] = 36,
		["45"] = 36,
		["46"] = 36,
		["47"] = 36,
		["48"] = 36,
		["50"] = 36,
		["51"] = 37,
		["52"] = 35,
		["53"] = 39,
		["54"] = 40,
		["55"] = 40,
		["56"] = 40,
		["57"] = 40,
		["58"] = 40,
		["59"] = 39,
		["60"] = 42,
		["61"] = 43,
		["62"] = 43,
		["63"] = 43,
		["64"] = 43,
		["65"] = 43,
		["66"] = 43,
		["68"] = 43,
		["69"] = 44,
		["70"] = 45,
		["71"] = 45,
		["72"] = 45,
		["73"] = 45,
		["74"] = 45,
		["75"] = 45,
		["77"] = 45,
		["78"] = 46,
		["79"] = 47,
		["80"] = 48,
		["81"] = 48,
		["82"] = 48,
		["83"] = 48,
		["84"] = 48,
		["87"] = 51,
		["88"] = 52,
		["89"] = 52,
		["90"] = 52,
		["91"] = 52,
		["92"] = 52,
		["93"] = 42,
		["94"] = 54,
		["95"] = 55,
		["96"] = 55,
		["97"] = 55,
		["98"] = 55,
		["99"] = 59,
		["100"] = 59,
		["101"] = 59,
		["102"] = 55,
		["103"] = 55,
		["104"] = 55,
		["105"] = 54,
		["106"] = 63,
		["107"] = 64,
		["110"] = 67,
		["111"] = 68,
		["112"] = 69,
		["113"] = 71,
		["116"] = 74,
		["117"] = 76,
		["118"] = 77,
		["119"] = 77,
		["120"] = 77,
		["121"] = 78,
		["124"] = 81,
		["125"] = 83,
		["127"] = 83,
		["129"] = 83,
		["130"] = 84,
		["131"] = 86,
		["132"] = 88,
		["133"] = 89,
		["134"] = 89,
		["135"] = 89,
		["136"] = 90,
		["137"] = 91,
		["138"] = 92,
		["139"] = 93,
		["140"] = 93,
		["141"] = 93,
		["142"] = 93,
		["143"] = 93,
		["144"] = 93,
		["145"] = 93,
		["146"] = 93,
		["147"] = 93,
		["148"] = 94,
		["150"] = 97,
		["151"] = 89,
		["152"] = 89,
		["153"] = 99,
		["156"] = 77,
		["157"] = 77,
		["159"] = 63,
		["160"] = 105,
		["161"] = 106,
		["162"] = 107,
		["165"] = 110,
		["166"] = 114,
		["167"] = 115,
		["168"] = 116,
		["169"] = 117,
		["170"] = 118,
		["171"] = 119,
		["172"] = 120,
		["175"] = 123,
		["176"] = 124,
		["177"] = 125,
		["178"] = 126,
		["182"] = 105,
		["183"] = 131,
		["184"] = 136,
		["185"] = 137,
		["186"] = 138,
		["187"] = 139,
		["188"] = 140,
		["189"] = 141,
		["190"] = 142,
		["191"] = 144,
		["192"] = 145,
		["194"] = 146,
		["195"] = 147,
		["196"] = 148,
		["197"] = 149,
		["199"] = 151,
		["205"] = 154,
		["206"] = 154,
		["207"] = 155,
		["208"] = 156,
		["209"] = 156,
		["210"] = 156,
		["211"] = 156,
		["212"] = 157,
		["214"] = 154,
		["219"] = 162,
		["220"] = 164,
		["221"] = 165,
		["222"] = 167,
		["223"] = 168,
		["224"] = 169,
		["225"] = 170,
		["227"] = 172,
		["229"] = 131,
		["230"] = 175,
		["231"] = 176,
		["232"] = 177,
		["233"] = 178,
		["235"] = 175,
		["236"] = 181,
		["237"] = 182,
		["238"] = 183,
		["239"] = 184,
		["240"] = 185,
		["241"] = 186,
		["242"] = 187,
		["244"] = 189,
		["245"] = 190,
		["246"] = 191,
		["247"] = 191,
		["248"] = 191,
		["249"] = 191,
		["250"] = 191,
		["251"] = 191,
		["252"] = 191,
		["254"] = 181,
		["255"] = 194,
		["256"] = 194,
		["257"] = 196,
		["258"] = 196,
		["259"] = 198,
		["260"] = 199,
		["261"] = 200,
		["262"] = 201,
		["265"] = 204,
		["266"] = 205,
		["267"] = 206,
		["268"] = 207,
		["269"] = 208,
		["270"] = 209,
		["272"] = 210,
		["273"] = 210,
		["274"] = 211,
		["275"] = 212,
		["276"] = 213,
		["277"] = 213,
		["278"] = 213,
		["279"] = 213,
		["280"] = 213,
		["281"] = 214,
		["282"] = 214,
		["283"] = 214,
		["284"] = 214,
		["285"] = 214,
		["286"] = 214,
		["287"] = 214,
		["288"] = 214,
		["289"] = 210,
		["293"] = 221,
		["295"] = 226,
		["296"] = 226,
		["297"] = 226,
		["298"] = 227,
		["301"] = 230,
		["302"] = 231,
		["303"] = 232,
		["304"] = 233,
		["305"] = 233,
		["306"] = 233,
		["307"] = 233,
		["308"] = 233,
		["309"] = 233,
		["310"] = 233,
		["311"] = 233,
		["312"] = 233,
		["313"] = 234,
		["314"] = 226,
		["315"] = 226,
		["316"] = 236,
		["317"] = 237,
		["318"] = 238,
		["320"] = 240,
		["321"] = 240,
		["322"] = 240,
		["323"] = 240,
		["324"] = 240,
		["325"] = 241,
		["326"] = 198,
		["327"] = 21,
		["328"] = 13,
		["329"] = 13,
		["330"] = 13,
		["331"] = 13,
		["332"] = 13,
		["333"] = 13,
		["334"] = 13,
		["335"] = 13,
		["336"] = 21,
		["338"] = 21,
		["339"] = 246,
		["340"] = 247,
		["341"] = 246,
		["342"] = 247,
		["343"] = 248,
		["344"] = 249,
		["345"] = 250,
		["346"] = 251,
		["349"] = 254,
		["350"] = 255,
		["351"] = 255,
		["352"] = 255,
		["353"] = 256,
		["356"] = 259,
		["357"] = 259,
		["358"] = 259,
		["359"] = 259,
		["360"] = 259,
		["361"] = 259,
		["362"] = 255,
		["363"] = 255,
		["364"] = 248,
		["365"] = 247,
		["366"] = 246,
		["367"] = 247,
		["369"] = 247,
		["370"] = 266,
		["371"] = 277,
		["372"] = 266,
		["373"] = 277,
		["374"] = 285,
		["375"] = 286,
		["376"] = 287,
		["377"] = 288,
		["378"] = 289,
		["379"] = 291,
		["380"] = 293,
		["381"] = 295,
		["382"] = 296,
		["383"] = 297,
		["384"] = 285,
		["385"] = 299,
		["386"] = 300,
		["387"] = 301,
		["388"] = 302,
		["389"] = 303,
		["390"] = 304,
		["391"] = 304,
		["392"] = 304,
		["393"] = 304,
		["394"] = 304,
		["395"] = 304,
		["396"] = 305,
		["397"] = 305,
		["398"] = 305,
		["399"] = 305,
		["400"] = 305,
		["401"] = 305,
		["402"] = 305,
		["403"] = 305,
		["404"] = 306,
		["405"] = 306,
		["406"] = 306,
		["407"] = 306,
		["408"] = 307,
		["409"] = 308,
		["412"] = 299,
		["413"] = 312,
		["414"] = 313,
		["415"] = 314,
		["417"] = 312,
		["418"] = 317,
		["419"] = 318,
		["420"] = 319,
		["421"] = 320,
		["422"] = 321,
		["425"] = 324,
		["426"] = 325,
		["427"] = 326,
		["428"] = 326,
		["429"] = 326,
		["430"] = 326,
		["431"] = 326,
		["432"] = 326,
		["433"] = 327,
		["434"] = 328,
		["435"] = 328,
		["436"] = 328,
		["437"] = 328,
		["438"] = 328,
		["439"] = 328,
		["440"] = 329,
		["441"] = 330,
		["442"] = 330,
		["443"] = 330,
		["444"] = 330,
		["445"] = 330,
		["446"] = 330,
		["449"] = 333,
		["450"] = 317,
		["451"] = 335,
		["452"] = 336,
		["453"] = 337,
		["454"] = 338,
		["455"] = 339,
		["456"] = 340,
		["459"] = 343,
		["460"] = 344,
		["461"] = 344,
		["462"] = 344,
		["463"] = 344,
		["464"] = 344,
		["465"] = 345,
		["467"] = 335,
		["468"] = 348,
		["469"] = 349,
		["470"] = 348,
		["471"] = 353,
		["472"] = 354,
		["473"] = 355,
		["474"] = 355,
		["475"] = 354,
		["476"] = 353,
		["477"] = 358,
		["478"] = 359,
		["479"] = 360,
		["480"] = 361,
		["481"] = 362,
		["482"] = 363,
		["484"] = 365,
		["485"] = 366,
		["486"] = 367,
		["490"] = 371,
		["492"] = 358,
		["493"] = 374,
		["494"] = 375,
		["495"] = 375,
		["496"] = 375,
		["497"] = 375,
		["498"] = 376,
		["499"] = 374,
		["500"] = 378,
		["501"] = 379,
		["502"] = 380,
		["503"] = 380,
		["504"] = 380,
		["505"] = 380,
		["507"] = 378,
		["508"] = 277,
		["509"] = 266,
		["510"] = 266,
		["511"] = 266,
		["512"] = 266,
		["513"] = 266,
		["514"] = 266,
		["515"] = 266,
		["516"] = 266,
		["517"] = 266,
		["518"] = 266,
		["519"] = 266,
		["520"] = 277,
		["522"] = 277,
		["524"] = 386,
		["525"] = 387,
		["526"] = 386,
		["527"] = 387,
		["528"] = 388,
		["529"] = 389,
		["530"] = 388,
		["531"] = 387,
		["532"] = 386,
		["533"] = 387,
		["535"] = 387,
		["536"] = 392,
		["537"] = 400,
		["538"] = 392,
		["539"] = 400,
		["540"] = 403,
		["541"] = 404,
		["542"] = 403,
		["543"] = 406,
		["544"] = 407,
		["545"] = 406,
		["546"] = 409,
		["547"] = 410,
		["548"] = 410,
		["549"] = 412,
		["550"] = 412,
		["551"] = 412,
		["552"] = 410,
		["553"] = 410,
		["554"] = 409,
		["555"] = 415,
		["556"] = 416,
		["557"] = 417,
		["558"] = 418,
		["559"] = 419,
		["560"] = 420,
		["562"] = 422,
		["563"] = 423,
		["564"] = 424,
		["567"] = 427,
		["568"] = 428,
		["569"] = 415,
		["570"] = 430,
		["571"] = 431,
		["572"] = 430,
		["573"] = 433,
		["574"] = 434,
		["575"] = 435,
		["576"] = 436,
		["577"] = 437,
		["578"] = 438,
		["581"] = 441,
		["582"] = 442,
		["583"] = 443,
		["586"] = 433,
		["587"] = 400,
		["588"] = 392,
		["589"] = 392,
		["590"] = 392,
		["591"] = 392,
		["592"] = 392,
		["593"] = 392,
		["594"] = 392,
		["595"] = 392,
		["596"] = 400,
		["598"] = 400,
		["600"] = 451,
		["601"] = 452,
		["602"] = 451,
		["603"] = 452,
		["604"] = 453,
		["605"] = 454,
		["606"] = 453,
		["607"] = 452,
		["608"] = 451,
		["609"] = 452,
		["611"] = 452,
		["612"] = 457,
		["613"] = 465,
		["614"] = 457,
		["615"] = 465,
		["616"] = 470,
		["617"] = 471,
		["618"] = 472,
		["619"] = 470,
		["620"] = 474,
		["621"] = 475,
		["622"] = 476,
		["623"] = 477,
		["625"] = 474,
		["626"] = 480,
		["627"] = 481,
		["628"] = 481,
		["629"] = 481,
		["630"] = 481,
		["631"] = 481,
		["632"] = 481,
		["634"] = 481,
		["635"] = 480,
		["636"] = 483,
		["637"] = 484,
		["638"] = 484,
		["639"] = 484,
		["640"] = 484,
		["641"] = 484,
		["642"] = 483,
		["643"] = 486,
		["644"] = 487,
		["645"] = 486,
		["646"] = 494,
		["647"] = 495,
		["648"] = 496,
		["649"] = 497,
		["650"] = 498,
		["651"] = 499,
		["652"] = 500,
		["653"] = 501,
		["654"] = 501,
		["655"] = 501,
		["656"] = 501,
		["657"] = 502,
		["658"] = 503,
		["660"] = 504,
		["661"] = 504,
		["662"] = 505,
		["663"] = 506,
		["664"] = 507,
		["665"] = 507,
		["666"] = 507,
		["667"] = 508,
		["668"] = 509,
		["669"] = 510,
		["670"] = 511,
		["673"] = 514,
		["675"] = 515,
		["676"] = 515,
		["677"] = 516,
		["678"] = 517,
		["679"] = 518,
		["680"] = 519,
		["681"] = 520,
		["682"] = 521,
		["683"] = 522,
		["687"] = 515,
		["690"] = 527,
		["691"] = 528,
		["692"] = 529,
		["693"] = 530,
		["694"] = 531,
		["695"] = 532,
		["696"] = 532,
		["697"] = 532,
		["698"] = 532,
		["699"] = 532,
		["700"] = 532,
		["701"] = 532,
		["702"] = 532,
		["703"] = 537,
		["704"] = 537,
		["705"] = 537,
		["706"] = 537,
		["708"] = 539,
		["711"] = 545,
		["713"] = 504,
		["718"] = 494,
		["719"] = 465,
		["720"] = 457,
		["721"] = 457,
		["722"] = 457,
		["723"] = 457,
		["724"] = 457,
		["725"] = 457,
		["726"] = 457,
		["727"] = 457,
		["728"] = 465,
		["730"] = 465,
	}
)
local j = {}
local k = require("lib.dota_ts_adapter")
local l = k.BaseAbility
local m = k.registerAbility
local n = require("modifiers.eom_modifier")
local o = n.EOMModifier
local p = n.registerEOMModifier
local q = require("abilities.ability_ai")
local r = q.BaseAbilityAI
local s = q.registerAbilityAI
j.doom_bringer_talent = c()
local t = j.doom_bringer_talent
t.name = "doom_bringer_talent"
d(t, l)
function t.prototype.GetIntrinsicModifierName(self)
	return "modifier_doom_bringer_talent"
end
t = e({ m(nil) }, t)
j.doom_bringer_talent = t
j.modifier_doom_bringer_talent = c()
local u = j.modifier_doom_bringer_talent
u.name = "modifier_doom_bringer_talent"
d(u, o)
function u.prototype.GetAbilitySpecialValue(self)
	self.devour_count = self:GetAbilitySpecialValueFor("devour_count")
	self.tl6_round_reduce = self:GetAbilityTalentValue("doom_bringer_talent_6", "round_reduce")
	self.round = self:GetAbilitySpecialValueFor("round") - self.tl6_round_reduce
	self.tl1_mana_base = self:GetAbilityTalentValue("doom_bringer_talent_1", "mana_base")
end
function u.prototype.isDevourCooldown(self)
	local v = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "doom_bringer_talent")
	if v == nil then
		v = 0
	end
	local w = v
	return w <= 0
end
function u.prototype.startDevourCooldown(self)
	PlayerData:saveData(self:GetParent():GetPlayerOwnerID(), "doom_bringer_talent", self.round)
end
function u.prototype.reduceDevourCooldown(self)
	local x = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "doom_bringer_talent")
	if x == nil then
		x = 0
	end
	local w = x
	if self.tl6_round_reduce > 0 then
		local y = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "doom_bringer_talent_6")
		if y == nil then
			y = 0
		end
		local z = y
		if z == 0 then
			w = w - self.tl6_round_reduce
			PlayerData:saveData(self:GetParent():GetPlayerOwnerID(), "doom_bringer_talent_6", 1)
		end
	end
	w = w - 1
	PlayerData:saveData(self:GetParent():GetPlayerOwnerID(), "doom_bringer_talent", w)
end
function u.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_CONFIRM_BATTLE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TREASURE_START] = {},
	}
end
function u.prototype.OnTreasureStart(self)
	if not IsServer() then
		return
	end
	local A = GameState:getState()
	if A and A:getStateName() == "GameState_Treasure" then
		local B = self:GetParent()
		if B:IsCustomIllusion() then
			return
		end
		local C = B:GetPlayerOwnerID()
		A:SetPlayerOperateEnable(C, false)
		GameTimer(3, function()
			if not IsValid(self) then
				return
			end
			if A and A:getStateName() == "GameState_Treasure" then
				local D = A.packages[C]
				if D ~= nil then
					D = D.slots
				end
				local E = D
				local F = RandomInt(0, #E - 1)
				local G = A:getTreasureSlotReward(C, F)
				if G and A:settleTreasureReward(C, G, "DOTA_Tooltip_ability_doom_bringer_talent") then
					GameTimer(0.1, function()
						if IsValid(B) then
							B:EmitSound("Hero_DoomBringer.DevourCast")
							local H = ParticleManager:CreateParticle(
								"particles/units/heroes/hero_doom_bringer/doom_bringer_devour.vpcf",
								PATTACH_ABSORIGIN_FOLLOW,
								B,
								B
							)
							ParticleManager:SetParticleControlEnt(
								H,
								1,
								B,
								PATTACH_POINT_FOLLOW,
								"attach_mouth",
								B:GetAbsOrigin(),
								true
							)
							ParticleManager:ReleaseParticleIndex(H)
						end
						A:SetPlayerOperateEnable(C, true)
					end)
					B:StartGesture(ACT_DOTA_CAST_ABILITY_1)
				end
			end
		end)
	end
end
function u.prototype.OnConfirmBattle(self, I)
	self.devour_result = nil
	if self:GetParent():IsCustomIllusion() then
		return
	end
	self:reduceDevourCooldown()
	if self:isDevourCooldown() then
		local B = self:GetParent()
		local J = B:GetEnemy()
		if J:IsNeutral() then
			local A = GameState:getState()
			if
				GameState:getStateName() == "GameState_ConfirmNeutral"
				or GameState:getStateName() == "GameState_Neutral"
			then
				self:DevourByData(A and A.neutralSectData)
			end
		else
			local K = J:GetPlayerOwnerID()
			local L = PlayerData:getHero(K)
			if L then
				self:DevourByData(L:getAbilityUpgradeData(false))
			end
		end
	end
end
function u.prototype.DevourByData(self, M)
	local N = {}
	if M then
		local O = {}
		local P = self:GetParent():GetPlayerOwnerID()
		local Q = PlayerData:getHero(P)
		if Q then
			local R = Q:getAbilityUpgradeData(true, true)
			local S = self:HasTalent("doom_bringer_talent_2")
			for T, U in pairs(M) do
				do
					local V = KeyValues.AbilityUpgradesKvs[T]
					if V and (S or V.rarity == "n") then
						if R[T] ~= nil and R[T].level >= SECT_ABILITY_LEVEL[V.rarity] then
							goto W
						end
						O[#O + 1] = tostring(T)
					end
				end
				::W::
			end
			do
				local X = 0
				while X < self.devour_count do
					if #O > 0 then
						local Y = table.remove(O, RandomInt(1, #O))
						N[#N + 1] = Y
					end
					X = X + 1
				end
			end
		end
	end
	self.devour_result = N
	local Z = GameState:getStateStartEndGameTime()
	local _ = Z[2]
	local a0 = 0.5
	local a1 = _ - GameRules:GetGameTime()
	if a1 > a0 then
		self:StartIntervalThink(a1 - a0)
	else
		self:DevourCast()
	end
end
function u.prototype.OnIntervalThink(self)
	if IsServer() then
		self:StartIntervalThink(-1)
		self:DevourCast()
	end
end
function u.prototype.OnBattleStartBefore(self, I)
	if self.tl1_mana_base > 0 then
		local B = self:GetParent()
		local a2 = 1
		local Q = PlayerData:getHero(B:GetPlayerOwnerID())
		if Q then
			a2 = Q:getLevel()
		end
		local a3 = a2 * self.tl1_mana_base
		B:GiveMana(a3)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, B, a3, B:GetPlayerOwner())
	end
end
function u.prototype.OnBattleStart(self, I) end
function u.prototype.OnBattleEnd(self, I) end
function u.prototype.DevourCast(self)
	local B = self:GetParent()
	local J = B:GetEnemy()
	if not IsInjurable(J, B) then
		return
	end
	local P = B:GetPlayerOwnerID()
	B:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	if self.devour_result ~= nil and #self.devour_result > 0 then
		local Q = PlayerData:getHero(P)
		local a4 = PlayerData:getplayerData(P)
		self:startDevourCooldown()
		do
			local X = 0
			while X < #self.devour_result do
				local N = self.devour_result[X + 1]
				Q:learnAbility(N, true, true, true)
				a4:addHeroAbilityAbilities(self:GetAbility():GetAbilityName(), N, X == #self.devour_result - 1)
				Notification:combatToPlayer(
					P,
					{
						message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[N].rarity),
						string_itemname_artifact = "DOTA_Tooltip_ability_doom_bringer_talent",
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. N,
					}
				)
				X = X + 1
			end
		end
	else
		Notification:combatToPlayer(
			P,
			{ message = "notify_enemy_ability_none", string_itemname_artifact = "DOTA_Tooltip_ability_doom_bringer_talent" }
		)
	end
	B:GameTimer(0.1, function()
		if not IsInjurable(J, B) then
			return
		end
		B:EmitSound("Hero_DoomBringer.DevourCast")
		J:EmitSound("Hero_DoomBringer.Devour")
		local H = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_doom_bringer/doom_bringer_devour.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			J,
			B
		)
		ParticleManager:SetParticleControlEnt(H, 1, B, PATTACH_POINT_FOLLOW, "attach_mouth", B:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(H)
	end)
	local a5 = PlayerData:loadData(P, "doom_bringer_devour_list")
	if a5 == nil then
		a5 = {}
	end
	PlayerData:saveData(P, "doom_bringer_devour_list", f(a5, self.devour_result))
	self.devour_result = nil
end
u = e(
	{
		p(
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
	u
)
j.modifier_doom_bringer_talent = u
j.doom_bringer_ult = c()
local a6 = j.doom_bringer_ult
a6.name = "doom_bringer_ult"
d(a6, r)
function a6.prototype.OnSpellStart(self)
	local a7 = self:GetCaster()
	local a8 = a7:GetEnemy()
	if not IsInjurable(a7, a8) then
		return
	end
	a7:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_6, 1.5)
	self:GameTimer(0.3, function()
		if not IsInjurable(a7, a8) then
			return
		end
		a8:AddNewModifier(
			a7,
			self,
			"modifier_doom_bringer_ult_debuff",
			{
				duration = self:GetSpecialValueFor("duration")
					+ self:GetTalentValue("doom_bringer_talent_4", "bonus_duration"),
			}
		)
	end)
end
a6 = e({ s(nil) }, a6)
j.doom_bringer_ult = a6
j.modifier_doom_bringer_ult_debuff = c()
local a9 = j.modifier_doom_bringer_ult_debuff
a9.name = "modifier_doom_bringer_ult_debuff"
d(a9, o)
function a9.prototype.GetAbilitySpecialValue(self)
	self.chaos_count = self:GetAbilitySpecialValueFor("chaos_count")
	self.reduce_pct = self:GetAbilitySpecialValueFor("reduce_pct")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.tl3_gain_pct = self:GetAbilityTalentValue("doom_bringer_talent_3", "gain_pct")
	self.tl5_bonus_pct = self:GetAbilityTalentValue("doom_bringer_talent_5", "bonus_pct")
	self.chaos_count = self.chaos_count * (1 + self.tl5_bonus_pct * 0.01)
	self.reduce_pct = self.reduce_pct * (1 + self.tl5_bonus_pct * 0.01)
	self.damage = self.damage * (1 + self.tl5_bonus_pct * 0.01)
end
function a9.prototype.OnCreated(self, I)
	if IsServer() then
		self.reduceRecords = {}
		self:IncrementStackCount()
		self:StartIntervalThink(self.interval)
		local aa = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_doom_bringer/doom_bringer_doom.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent(),
			self:GetCaster()
		)
		self:AddParticle(aa, false, false, -1, false, false)
		EmitSoundOn("Hero_DoomBringer.Doom.Creep", self:GetParent())
		if self.tl3_gain_pct > 0 then
			self:StartThink(1)
		end
	end
end
function a9.prototype.OnRefresh(self, I)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function a9.prototype.OnThink(self, ab)
	local a7 = self:GetCaster()
	local B = self:GetParent()
	local ac = self:GetAbility()
	if not (IsValid(a7) and IsValid(ac)) then
		return
	end
	for ad, ae in pairs(self.reduceRecords) do
		if ad == "fury" then
			AddFury(a7, ae, ac:GetAbilityName(), "Ability")
		elseif ad == "shield" then
			AddShield(a7, ae, ac:GetAbilityName(), "Ability")
		elseif ad == "chaos" then
			AddChaos(a7, ae, ac:GetAbilityName(), "Ability")
		end
	end
	self.reduceRecords = {}
end
function a9.prototype.OnIntervalThink(self)
	if IsServer() then
		local B = self:GetParent()
		local a7 = self:GetCaster()
		if not IsInjurable(a7, B) then
			self:Destroy()
			return
		end
		local af = self:GetStackCount()
		a7:DealChaosDamage(B, self:GetAbility(), self.damage * af)
		AddChaos(a7, self.chaos_count * af, "doom_bringer_ult", "Ability")
	end
end
function a9.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_GAIN_REDUCTION_PERCENTAGE }
end
function a9.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function a9.prototype.EOM_GetModifierGainReductionPercentage(self, I)
	if I and I.type ~= "heal" then
		if IsServer() then
			if self.tl3_gain_pct > 0 then
				if self.reduceRecords[I.type] == nil then
					self.reduceRecords[I.type] = 0
				end
				local ag = I.count * self.reduce_pct * 0.01
				if ag > 0 then
					self.reduceRecords[I.type] = self.reduceRecords[I.type] + ag
				end
			end
		end
		return self.reduce_pct
	end
end
function a9.prototype.OnBattleEnd(self, I)
	StopSoundOn("Hero_DoomBringer.Doom.Creep", self:GetParent())
	self:Destroy()
end
function a9.prototype.OnDestroy(self)
	if IsServer() then
		StopSoundOn("Hero_DoomBringer.Doom.Creep", self:GetParent())
	end
end
a9 = e(
	{
		p(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetStatusEffectName = "particles/status_fx/status_effect_doom.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_HIGH,
				IsIndependent = true,
			}
		),
	},
	a9
)
j.modifier_doom_bringer_ult_debuff = a9
j.doom_bringer_talent_7 = c()
local ah = j.doom_bringer_talent_7
ah.name = "doom_bringer_talent_7"
d(ah, l)
function ah.prototype.GetIntrinsicModifierName(self)
	return "modifier_doom_bringer_talent_7"
end
ah = e({ m(nil) }, ah)
j.doom_bringer_talent_7 = ah
j.modifier_doom_bringer_talent_7 = c()
local ai = j.modifier_doom_bringer_talent_7
ai.name = "modifier_doom_bringer_talent_7"
d(ai, o)
function ai.prototype.GetTexture(self)
	return "modifier_doom_bringer_talent_7"
end
function ai.prototype.GetAbilitySpecialValue(self)
	self.value = self:GetAbilitySpecialValueFor("value")
end
function ai.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function ai.prototype.OnBattleStart(self, I)
	self.record_gold = 0
	local P = self:GetParent():GetPlayerOwnerID()
	local a5 = PlayerData:loadData(P, "doom_bringer_devour_list")
	if a5 == nil then
		a5 = {}
	end
	for U, T in ipairs(a5) do
		if KeyValues.AbilityUpgradesKvs[T] ~= nil and type(KeyValues.AbilityUpgradesKvs[T].cost) == "number" then
			self.record_gold = self.record_gold + KeyValues.AbilityUpgradesKvs[T].cost
		end
	end
	self:SetStackCount(math.floor(self.record_gold / self.value))
	self:StartIntervalThink(1)
end
function ai.prototype.OnBattleEnd(self, I)
	self:StartIntervalThink(-1)
end
function ai.prototype.OnIntervalThink(self)
	if IsServer() then
		local B = self:GetParent()
		local J = B:GetEnemy()
		if not IsInjurable(B, J) then
			self:StartIntervalThink(-1)
			return
		end
		local aj = self:GetStackCount()
		if aj > 0 then
			AddChaos(B, aj, "doom_bringer_talent", "Ability")
		end
	end
end
ai = e(
	{
		p(
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
	ai
)
j.modifier_doom_bringer_talent_7 = ai
j.doom_bringer_shard = c()
local ak = j.doom_bringer_shard
ak.name = "doom_bringer_shard"
d(ak, l)
function ak.prototype.GetIntrinsicModifierName(self)
	return "modifier_doom_bringer_shard"
end
ak = e({ m(nil) }, ak)
j.doom_bringer_shard = ak
j.modifier_doom_bringer_shard = c()
local al = j.modifier_doom_bringer_shard
al.name = "modifier_doom_bringer_shard"
d(al, o)
function al.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function al.prototype.OnCreated(self, I)
	if IsServer() then
		self.stack = self:loadStack()
		self:Effect()
	end
end
function al.prototype.loadStack(self)
	local am = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "doom_bringer_shard")
	if am == nil then
		am = 0
	end
	return am
end
function al.prototype.saveStack(self, an)
	PlayerData:saveData(self:GetParent():GetPlayerOwnerID(), "doom_bringer_shard", an)
end
function al.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function al.prototype.Effect(self)
	local ao = Rounds:getCurrentRound()
	local ap = math.floor(ao / self.round)
	local aq = ap - self.stack
	if aq > 0 then
		self:saveStack(ap)
		local C = self:GetParent():GetPlayerOwnerID()
		local ar = g(PlayerData:getAlivePlayerIDList(), function(as, Y)
			return Y ~= C
		end)
		if #ar > 0 then
			local at = self.count * aq
			do
				local X = 0
				while X < at do
					local au = PlayerData:getHero(C):getAbilityUpgradeData()
					local av = {}
					for T, aw in pairs(au) do
						local a2
						a2 = aw.level
						local ax = KeyValues.AbilityUpgradesKvs[T]
						local ay = SECT_ABILITY_LEVEL[ax.rarity]
						if a2 >= ay then
							av[tostring(T)] = true
						end
					end
					local az = {}
					do
						local X = 0
						while X < #ar do
							local aA = ar[X + 1]
							local aB = PlayerData:getHero(aA)
							if aB then
								local aC = aB:getAbilityUpgradeData()
								for T, U in pairs(aC) do
									if not av[T] then
										az[T] = true
									end
								end
							end
							X = X + 1
						end
					end
					local O = h(az)
					if #O > 0 then
						local ac = O[RandomInt(0, #O - 1) + 1]
						if ac then
							PlayerData:getHero(C):learnAbility(ac, true)
							Notification:combatToPlayer(
								C,
								{
									message = "notify_artifact_ability_"
										.. tostring(KeyValues.AbilityUpgradesKvs[ac].rarity),
									string_itemname_artifact = "HeroShard",
									string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. ac,
								}
							)
							PlayerData:getplayerData(C):addHeroAbilityAbilities(self:GetAbility():GetAbilityName(), ac)
						else
							Notification:combatToPlayer(
								C,
								{ message = "notify_enemy_ability_none", string_itemname_artifact = "HeroShard" }
							)
						end
					else
						Notification:combatToPlayer(
							C,
							{ message = "notify_enemy_ability_none", string_itemname_artifact = "HeroShard" }
						)
					end
					X = X + 1
				end
			end
		end
	end
end
al = e(
	{
		p(
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
	al
)
j.modifier_doom_bringer_shard = al
return j