--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
		["104"] = 54,
		["105"] = 63,
		["106"] = 64,
		["107"] = 65,
		["110"] = 68,
		["111"] = 72,
		["112"] = 73,
		["113"] = 74,
		["114"] = 75,
		["115"] = 76,
		["116"] = 77,
		["117"] = 78,
		["120"] = 81,
		["121"] = 82,
		["122"] = 83,
		["123"] = 84,
		["127"] = 63,
		["128"] = 89,
		["129"] = 94,
		["130"] = 95,
		["131"] = 96,
		["132"] = 97,
		["133"] = 98,
		["134"] = 99,
		["135"] = 100,
		["136"] = 102,
		["137"] = 103,
		["139"] = 104,
		["140"] = 105,
		["141"] = 106,
		["142"] = 107,
		["144"] = 109,
		["150"] = 112,
		["151"] = 112,
		["152"] = 113,
		["153"] = 114,
		["154"] = 114,
		["155"] = 114,
		["156"] = 114,
		["157"] = 115,
		["159"] = 112,
		["164"] = 120,
		["165"] = 122,
		["166"] = 123,
		["167"] = 125,
		["168"] = 126,
		["169"] = 127,
		["170"] = 128,
		["172"] = 130,
		["174"] = 89,
		["175"] = 133,
		["176"] = 134,
		["177"] = 135,
		["178"] = 136,
		["180"] = 133,
		["181"] = 139,
		["182"] = 140,
		["183"] = 141,
		["184"] = 142,
		["185"] = 143,
		["186"] = 144,
		["187"] = 145,
		["189"] = 147,
		["190"] = 148,
		["191"] = 149,
		["192"] = 149,
		["193"] = 149,
		["194"] = 149,
		["195"] = 149,
		["196"] = 149,
		["197"] = 149,
		["199"] = 139,
		["200"] = 152,
		["201"] = 152,
		["202"] = 154,
		["203"] = 154,
		["204"] = 156,
		["205"] = 157,
		["206"] = 158,
		["207"] = 159,
		["210"] = 162,
		["211"] = 163,
		["212"] = 164,
		["213"] = 165,
		["214"] = 166,
		["215"] = 167,
		["217"] = 168,
		["218"] = 168,
		["219"] = 169,
		["220"] = 170,
		["221"] = 171,
		["222"] = 171,
		["223"] = 171,
		["224"] = 171,
		["225"] = 171,
		["226"] = 172,
		["227"] = 172,
		["228"] = 172,
		["229"] = 172,
		["230"] = 172,
		["231"] = 172,
		["232"] = 172,
		["233"] = 172,
		["234"] = 168,
		["238"] = 179,
		["240"] = 184,
		["241"] = 184,
		["242"] = 184,
		["243"] = 185,
		["246"] = 188,
		["247"] = 189,
		["248"] = 190,
		["249"] = 191,
		["250"] = 191,
		["251"] = 191,
		["252"] = 191,
		["253"] = 191,
		["254"] = 191,
		["255"] = 191,
		["256"] = 191,
		["257"] = 191,
		["258"] = 192,
		["259"] = 184,
		["260"] = 184,
		["261"] = 194,
		["262"] = 195,
		["263"] = 196,
		["265"] = 198,
		["266"] = 198,
		["267"] = 198,
		["268"] = 198,
		["269"] = 198,
		["270"] = 199,
		["271"] = 156,
		["272"] = 21,
		["273"] = 13,
		["274"] = 13,
		["275"] = 13,
		["276"] = 13,
		["277"] = 13,
		["278"] = 13,
		["279"] = 13,
		["280"] = 13,
		["281"] = 21,
		["283"] = 21,
		["284"] = 204,
		["285"] = 205,
		["286"] = 204,
		["287"] = 205,
		["288"] = 206,
		["289"] = 207,
		["290"] = 208,
		["291"] = 209,
		["294"] = 212,
		["295"] = 213,
		["296"] = 213,
		["297"] = 213,
		["298"] = 214,
		["301"] = 217,
		["302"] = 217,
		["303"] = 217,
		["304"] = 217,
		["305"] = 217,
		["306"] = 217,
		["307"] = 213,
		["308"] = 213,
		["309"] = 206,
		["310"] = 205,
		["311"] = 204,
		["312"] = 205,
		["314"] = 205,
		["315"] = 224,
		["316"] = 235,
		["317"] = 224,
		["318"] = 235,
		["319"] = 243,
		["320"] = 244,
		["321"] = 245,
		["322"] = 246,
		["323"] = 247,
		["324"] = 249,
		["325"] = 251,
		["326"] = 253,
		["327"] = 254,
		["328"] = 255,
		["329"] = 243,
		["330"] = 257,
		["331"] = 258,
		["332"] = 259,
		["333"] = 260,
		["334"] = 261,
		["335"] = 262,
		["336"] = 262,
		["337"] = 262,
		["338"] = 262,
		["339"] = 262,
		["340"] = 262,
		["341"] = 263,
		["342"] = 263,
		["343"] = 263,
		["344"] = 263,
		["345"] = 263,
		["346"] = 263,
		["347"] = 263,
		["348"] = 263,
		["349"] = 264,
		["350"] = 264,
		["351"] = 264,
		["352"] = 264,
		["353"] = 265,
		["354"] = 266,
		["357"] = 257,
		["358"] = 270,
		["359"] = 271,
		["360"] = 272,
		["362"] = 270,
		["363"] = 275,
		["364"] = 276,
		["365"] = 277,
		["366"] = 278,
		["367"] = 279,
		["370"] = 282,
		["371"] = 283,
		["372"] = 284,
		["373"] = 284,
		["374"] = 284,
		["375"] = 284,
		["376"] = 284,
		["377"] = 284,
		["378"] = 285,
		["379"] = 286,
		["380"] = 286,
		["381"] = 286,
		["382"] = 286,
		["383"] = 286,
		["384"] = 286,
		["385"] = 287,
		["386"] = 288,
		["387"] = 288,
		["388"] = 288,
		["389"] = 288,
		["390"] = 288,
		["391"] = 288,
		["394"] = 291,
		["395"] = 275,
		["396"] = 293,
		["397"] = 294,
		["398"] = 295,
		["399"] = 296,
		["400"] = 297,
		["401"] = 298,
		["404"] = 301,
		["405"] = 302,
		["406"] = 302,
		["407"] = 302,
		["408"] = 302,
		["409"] = 302,
		["410"] = 303,
		["412"] = 293,
		["413"] = 306,
		["414"] = 307,
		["415"] = 306,
		["416"] = 311,
		["417"] = 312,
		["418"] = 313,
		["419"] = 313,
		["420"] = 312,
		["421"] = 311,
		["422"] = 316,
		["423"] = 317,
		["424"] = 318,
		["425"] = 319,
		["426"] = 320,
		["427"] = 321,
		["429"] = 323,
		["430"] = 324,
		["431"] = 325,
		["435"] = 329,
		["437"] = 316,
		["438"] = 332,
		["439"] = 333,
		["440"] = 333,
		["441"] = 333,
		["442"] = 333,
		["443"] = 334,
		["444"] = 332,
		["445"] = 336,
		["446"] = 337,
		["447"] = 338,
		["448"] = 338,
		["449"] = 338,
		["450"] = 338,
		["452"] = 336,
		["453"] = 235,
		["454"] = 224,
		["455"] = 224,
		["456"] = 224,
		["457"] = 224,
		["458"] = 224,
		["459"] = 224,
		["460"] = 224,
		["461"] = 224,
		["462"] = 224,
		["463"] = 224,
		["464"] = 224,
		["465"] = 235,
		["467"] = 235,
		["469"] = 344,
		["470"] = 345,
		["471"] = 344,
		["472"] = 345,
		["473"] = 346,
		["474"] = 347,
		["475"] = 346,
		["476"] = 345,
		["477"] = 344,
		["478"] = 345,
		["480"] = 345,
		["481"] = 350,
		["482"] = 358,
		["483"] = 350,
		["484"] = 358,
		["485"] = 361,
		["486"] = 362,
		["487"] = 361,
		["488"] = 364,
		["489"] = 365,
		["490"] = 364,
		["491"] = 367,
		["492"] = 368,
		["493"] = 368,
		["494"] = 370,
		["495"] = 370,
		["496"] = 370,
		["497"] = 368,
		["498"] = 368,
		["499"] = 367,
		["500"] = 373,
		["501"] = 374,
		["502"] = 375,
		["503"] = 376,
		["504"] = 377,
		["505"] = 378,
		["507"] = 380,
		["508"] = 381,
		["509"] = 382,
		["512"] = 385,
		["513"] = 386,
		["514"] = 373,
		["515"] = 388,
		["516"] = 389,
		["517"] = 388,
		["518"] = 391,
		["519"] = 392,
		["520"] = 393,
		["521"] = 394,
		["522"] = 395,
		["523"] = 396,
		["526"] = 399,
		["527"] = 400,
		["528"] = 401,
		["531"] = 391,
		["532"] = 358,
		["533"] = 350,
		["534"] = 350,
		["535"] = 350,
		["536"] = 350,
		["537"] = 350,
		["538"] = 350,
		["539"] = 350,
		["540"] = 350,
		["541"] = 358,
		["543"] = 358,
		["545"] = 409,
		["546"] = 410,
		["547"] = 409,
		["548"] = 410,
		["549"] = 411,
		["550"] = 412,
		["551"] = 411,
		["552"] = 410,
		["553"] = 409,
		["554"] = 410,
		["556"] = 410,
		["557"] = 415,
		["558"] = 423,
		["559"] = 415,
		["560"] = 423,
		["561"] = 428,
		["562"] = 429,
		["563"] = 430,
		["564"] = 428,
		["565"] = 432,
		["566"] = 433,
		["567"] = 434,
		["568"] = 435,
		["570"] = 432,
		["571"] = 438,
		["572"] = 439,
		["573"] = 439,
		["574"] = 439,
		["575"] = 439,
		["576"] = 439,
		["577"] = 439,
		["579"] = 439,
		["580"] = 438,
		["581"] = 441,
		["582"] = 442,
		["583"] = 442,
		["584"] = 442,
		["585"] = 442,
		["586"] = 442,
		["587"] = 441,
		["588"] = 444,
		["589"] = 445,
		["590"] = 444,
		["591"] = 452,
		["592"] = 453,
		["593"] = 454,
		["594"] = 455,
		["595"] = 456,
		["596"] = 457,
		["597"] = 458,
		["598"] = 459,
		["599"] = 459,
		["600"] = 459,
		["601"] = 459,
		["602"] = 460,
		["603"] = 461,
		["605"] = 462,
		["606"] = 462,
		["607"] = 463,
		["608"] = 464,
		["609"] = 465,
		["610"] = 465,
		["611"] = 465,
		["612"] = 466,
		["613"] = 467,
		["614"] = 468,
		["615"] = 469,
		["618"] = 472,
		["620"] = 473,
		["621"] = 473,
		["622"] = 474,
		["623"] = 475,
		["624"] = 476,
		["625"] = 477,
		["626"] = 478,
		["627"] = 479,
		["628"] = 480,
		["632"] = 473,
		["635"] = 485,
		["636"] = 486,
		["637"] = 487,
		["638"] = 488,
		["639"] = 489,
		["640"] = 490,
		["641"] = 490,
		["642"] = 490,
		["643"] = 490,
		["644"] = 490,
		["645"] = 490,
		["646"] = 490,
		["647"] = 490,
		["648"] = 495,
		["649"] = 495,
		["650"] = 495,
		["651"] = 495,
		["653"] = 497,
		["656"] = 503,
		["658"] = 462,
		["663"] = 452,
		["664"] = 423,
		["665"] = 415,
		["666"] = 415,
		["667"] = 415,
		["668"] = 415,
		["669"] = 415,
		["670"] = 415,
		["671"] = 415,
		["672"] = 415,
		["673"] = 423,
		["675"] = 423,
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
	}
end
function u.prototype.OnConfirmBattle(self, A)
	self.devour_result = nil
	if self:GetParent():IsCustomIllusion() then
		return
	end
	self:reduceDevourCooldown()
	if self:isDevourCooldown() then
		local B = self:GetParent()
		local C = B:GetEnemy()
		if C:IsNeutral() then
			local D = GameState:getState()
			if
				GameState:getStateName() == "GameState_ConfirmNeutral"
				or GameState:getStateName() == "GameState_Neutral"
			then
				self:DevourByData(D and D.neutralSectData)
			end
		else
			local E = C:GetPlayerOwnerID()
			local F = PlayerData:getHero(E)
			if F then
				self:DevourByData(F:getAbilityUpgradeData(false))
			end
		end
	end
end
function u.prototype.DevourByData(self, G)
	local H = {}
	if G then
		local I = {}
		local J = self:GetParent():GetPlayerOwnerID()
		local K = PlayerData:getHero(J)
		if K then
			local L = K:getAbilityUpgradeData(true, true)
			local M = self:HasTalent("doom_bringer_talent_2")
			for N, O in pairs(G) do
				do
					local P = KeyValues.AbilityUpgradesKvs[N]
					if P and (M or P.rarity == "n") then
						if L[N] ~= nil and L[N].level >= SECT_ABILITY_LEVEL[P.rarity] then
							goto Q
						end
						I[#I + 1] = tostring(N)
					end
				end
				::Q::
			end
			do
				local R = 0
				while R < self.devour_count do
					if #I > 0 then
						local S = table.remove(I, RandomInt(1, #I))
						H[#H + 1] = S
					end
					R = R + 1
				end
			end
		end
	end
	self.devour_result = H
	local T = GameState:getStateStartEndGameTime()
	local U = T[2]
	local V = 0.5
	local W = U - GameRules:GetGameTime()
	if W > V then
		self:StartIntervalThink(W - V)
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
function u.prototype.OnBattleStartBefore(self, A)
	if self.tl1_mana_base > 0 then
		local B = self:GetParent()
		local X = 1
		local K = PlayerData:getHero(B:GetPlayerOwnerID())
		if K then
			X = K:getLevel()
		end
		local Y = X * self.tl1_mana_base
		B:GiveMana(Y)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, B, Y, B:GetPlayerOwner())
	end
end
function u.prototype.OnBattleStart(self, A) end
function u.prototype.OnBattleEnd(self, A) end
function u.prototype.DevourCast(self)
	local B = self:GetParent()
	local C = B:GetEnemy()
	if not IsInjurable(C, B) then
		return
	end
	local J = B:GetPlayerOwnerID()
	B:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	if self.devour_result ~= nil and #self.devour_result > 0 then
		local K = PlayerData:getHero(J)
		local Z = PlayerData:getplayerData(J)
		self:startDevourCooldown()
		do
			local R = 0
			while R < #self.devour_result do
				local H = self.devour_result[R + 1]
				K:learnAbility(H, true, true, true)
				Z:addHeroAbilityAbilities(self:GetAbility():GetAbilityName(), H, R == #self.devour_result - 1)
				Notification:combatToPlayer(
					J,
					{
						message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[H].rarity),
						string_itemname_artifact = "DOTA_Tooltip_ability_doom_bringer_talent",
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. H,
					}
				)
				R = R + 1
			end
		end
	else
		Notification:combatToPlayer(
			J,
			{ message = "notify_enemy_ability_none", string_itemname_artifact = "DOTA_Tooltip_ability_doom_bringer_talent" }
		)
	end
	B:GameTimer(0.1, function()
		if not IsInjurable(C, B) then
			return
		end
		B:EmitSound("Hero_DoomBringer.DevourCast")
		C:EmitSound("Hero_DoomBringer.Devour")
		local _ = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_doom_bringer/doom_bringer_devour.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			C,
			B
		)
		ParticleManager:SetParticleControlEnt(_, 1, B, PATTACH_POINT_FOLLOW, "attach_mouth", B:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(_)
	end)
	local a0 = PlayerData:loadData(J, "doom_bringer_devour_list")
	if a0 == nil then
		a0 = {}
	end
	PlayerData:saveData(J, "doom_bringer_devour_list", f(a0, self.devour_result))
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
local a1 = j.doom_bringer_ult
a1.name = "doom_bringer_ult"
d(a1, r)
function a1.prototype.OnSpellStart(self)
	local a2 = self:GetCaster()
	local a3 = a2:GetEnemy()
	if not IsInjurable(a2, a3) then
		return
	end
	a2:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_6, 1.5)
	self:GameTimer(0.3, function()
		if not IsInjurable(a2, a3) then
			return
		end
		a3:AddNewModifier(
			a2,
			self,
			"modifier_doom_bringer_ult_debuff",
			{
				duration = self:GetSpecialValueFor("duration")
					+ self:GetTalentValue("doom_bringer_talent_4", "bonus_duration"),
			}
		)
	end)
end
a1 = e({ s(nil) }, a1)
j.doom_bringer_ult = a1
j.modifier_doom_bringer_ult_debuff = c()
local a4 = j.modifier_doom_bringer_ult_debuff
a4.name = "modifier_doom_bringer_ult_debuff"
d(a4, o)
function a4.prototype.GetAbilitySpecialValue(self)
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
function a4.prototype.OnCreated(self, A)
	if IsServer() then
		self.reduceRecords = {}
		self:IncrementStackCount()
		self:StartIntervalThink(self.interval)
		local a5 = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_doom_bringer/doom_bringer_doom.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent(),
			self:GetCaster()
		)
		self:AddParticle(a5, false, false, -1, false, false)
		EmitSoundOn("Hero_DoomBringer.Doom.Creep", self:GetParent())
		if self.tl3_gain_pct > 0 then
			self:StartThink(1)
		end
	end
end
function a4.prototype.OnRefresh(self, A)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function a4.prototype.OnThink(self, a6)
	local a2 = self:GetCaster()
	local B = self:GetParent()
	local a7 = self:GetAbility()
	if not (IsValid(a2) and IsValid(a7)) then
		return
	end
	for a8, a9 in pairs(self.reduceRecords) do
		if a8 == "fury" then
			AddFury(a2, a9, a7:GetAbilityName(), "Ability")
		elseif a8 == "shield" then
			AddShield(a2, a9, a7:GetAbilityName(), "Ability")
		elseif a8 == "chaos" then
			AddChaos(a2, a9, a7:GetAbilityName(), "Ability")
		end
	end
	self.reduceRecords = {}
end
function a4.prototype.OnIntervalThink(self)
	if IsServer() then
		local B = self:GetParent()
		local a2 = self:GetCaster()
		if not IsInjurable(a2, B) then
			self:Destroy()
			return
		end
		local aa = self:GetStackCount()
		a2:DealChaosDamage(B, self:GetAbility(), self.damage * aa)
		AddChaos(a2, self.chaos_count * aa, "doom_bringer_ult", "Ability")
	end
end
function a4.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_GAIN_REDUCTION_PERCENTAGE }
end
function a4.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function a4.prototype.EOM_GetModifierGainReductionPercentage(self, A)
	if A and A.type ~= "heal" then
		if IsServer() then
			if self.tl3_gain_pct > 0 then
				if self.reduceRecords[A.type] == nil then
					self.reduceRecords[A.type] = 0
				end
				local ab = A.count * self.reduce_pct * 0.01
				if ab > 0 then
					self.reduceRecords[A.type] = self.reduceRecords[A.type] + ab
				end
			end
		end
		return self.reduce_pct
	end
end
function a4.prototype.OnBattleEnd(self, A)
	StopSoundOn("Hero_DoomBringer.Doom.Creep", self:GetParent())
	self:Destroy()
end
function a4.prototype.OnDestroy(self)
	if IsServer() then
		StopSoundOn("Hero_DoomBringer.Doom.Creep", self:GetParent())
	end
end
a4 = e(
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
	a4
)
j.modifier_doom_bringer_ult_debuff = a4
j.doom_bringer_talent_7 = c()
local ac = j.doom_bringer_talent_7
ac.name = "doom_bringer_talent_7"
d(ac, l)
function ac.prototype.GetIntrinsicModifierName(self)
	return "modifier_doom_bringer_talent_7"
end
ac = e({ m(nil) }, ac)
j.doom_bringer_talent_7 = ac
j.modifier_doom_bringer_talent_7 = c()
local ad = j.modifier_doom_bringer_talent_7
ad.name = "modifier_doom_bringer_talent_7"
d(ad, o)
function ad.prototype.GetTexture(self)
	return "modifier_doom_bringer_talent_7"
end
function ad.prototype.GetAbilitySpecialValue(self)
	self.value = self:GetAbilitySpecialValueFor("value")
end
function ad.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function ad.prototype.OnBattleStart(self, A)
	self.record_gold = 0
	local J = self:GetParent():GetPlayerOwnerID()
	local a0 = PlayerData:loadData(J, "doom_bringer_devour_list")
	if a0 == nil then
		a0 = {}
	end
	for O, N in ipairs(a0) do
		if KeyValues.AbilityUpgradesKvs[N] ~= nil and type(KeyValues.AbilityUpgradesKvs[N].cost) == "number" then
			self.record_gold = self.record_gold + KeyValues.AbilityUpgradesKvs[N].cost
		end
	end
	self:SetStackCount(math.floor(self.record_gold / self.value))
	self:StartIntervalThink(1)
end
function ad.prototype.OnBattleEnd(self, A)
	self:StartIntervalThink(-1)
end
function ad.prototype.OnIntervalThink(self)
	if IsServer() then
		local B = self:GetParent()
		local C = B:GetEnemy()
		if not IsInjurable(B, C) then
			self:StartIntervalThink(-1)
			return
		end
		local ae = self:GetStackCount()
		if ae > 0 then
			AddChaos(B, ae, "doom_bringer_talent", "Ability")
		end
	end
end
ad = e(
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
	ad
)
j.modifier_doom_bringer_talent_7 = ad
j.doom_bringer_shard = c()
local af = j.doom_bringer_shard
af.name = "doom_bringer_shard"
d(af, l)
function af.prototype.GetIntrinsicModifierName(self)
	return "modifier_doom_bringer_shard"
end
af = e({ m(nil) }, af)
j.doom_bringer_shard = af
j.modifier_doom_bringer_shard = c()
local ag = j.modifier_doom_bringer_shard
ag.name = "modifier_doom_bringer_shard"
d(ag, o)
function ag.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function ag.prototype.OnCreated(self, A)
	if IsServer() then
		self.stack = self:loadStack()
		self:Effect()
	end
end
function ag.prototype.loadStack(self)
	local ah = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "doom_bringer_shard")
	if ah == nil then
		ah = 0
	end
	return ah
end
function ag.prototype.saveStack(self, ai)
	PlayerData:saveData(self:GetParent():GetPlayerOwnerID(), "doom_bringer_shard", ai)
end
function ag.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function ag.prototype.Effect(self)
	local aj = Rounds:getCurrentRound()
	local ak = math.floor(aj / self.round)
	local al = ak - self.stack
	if al > 0 then
		self:saveStack(ak)
		local am = self:GetParent():GetPlayerOwnerID()
		local an = g(PlayerData:getAlivePlayerIDList(), function(ao, S)
			return S ~= am
		end)
		if #an > 0 then
			local ap = self.count * al
			do
				local R = 0
				while R < ap do
					local aq = PlayerData:getHero(am):getAbilityUpgradeData()
					local ar = {}
					for N, as in pairs(aq) do
						local X
						X = as.level
						local at = KeyValues.AbilityUpgradesKvs[N]
						local au = SECT_ABILITY_LEVEL[at.rarity]
						if X >= au then
							ar[tostring(N)] = true
						end
					end
					local av = {}
					do
						local R = 0
						while R < #an do
							local aw = an[R + 1]
							local ax = PlayerData:getHero(aw)
							if ax then
								local ay = ax:getAbilityUpgradeData()
								for N, O in pairs(ay) do
									if not ar[N] then
										av[N] = true
									end
								end
							end
							R = R + 1
						end
					end
					local I = h(av)
					if #I > 0 then
						local a7 = I[RandomInt(0, #I - 1) + 1]
						if a7 then
							PlayerData:getHero(am):learnAbility(a7, true)
							Notification:combatToPlayer(
								am,
								{
									message = "notify_artifact_ability_"
										.. tostring(KeyValues.AbilityUpgradesKvs[a7].rarity),
									string_itemname_artifact = "HeroShard",
									string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. a7,
								}
							)
							PlayerData:getplayerData(am):addHeroAbilityAbilities(self:GetAbility():GetAbilityName(), a7)
						else
							Notification:combatToPlayer(
								am,
								{ message = "notify_enemy_ability_none", string_itemname_artifact = "HeroShard" }
							)
						end
					else
						Notification:combatToPlayer(
							am,
							{ message = "notify_enemy_ability_none", string_itemname_artifact = "HeroShard" }
						)
					end
					R = R + 1
				end
			end
		end
	end
end
ag = e(
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
	ag
)
j.modifier_doom_bringer_shard = ag
return j