--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_hero"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayIncludes
local f = b.__TS__ObjectValues
local g = b.__TS__StringSplit
local h = b.__TS__ArrayFilter
local i = b.__TS__ArrayForEach
local j = b.__TS__DecorateLegacy
local k = b.__TS__SourceMapTraceBack
k(
	debug.getinfo(1).short_src,
	{
		["13"] = 1,
		["14"] = 1,
		["15"] = 1,
		["16"] = 3,
		["17"] = 11,
		["18"] = 3,
		["19"] = 11,
		["21"] = 11,
		["22"] = 13,
		["23"] = 19,
		["24"] = 21,
		["25"] = 23,
		["26"] = 26,
		["27"] = 27,
		["28"] = 3,
		["29"] = 28,
		["30"] = 30,
		["31"] = 31,
		["32"] = 32,
		["35"] = 35,
		["36"] = 36,
		["37"] = 36,
		["38"] = 36,
		["39"] = 36,
		["40"] = 37,
		["43"] = 28,
		["44"] = 41,
		["45"] = 42,
		["46"] = 42,
		["47"] = 42,
		["48"] = 42,
		["49"] = 41,
		["50"] = 48,
		["51"] = 49,
		["52"] = 50,
		["53"] = 51,
		["54"] = 52,
		["55"] = 53,
		["56"] = 54,
		["57"] = 56,
		["59"] = 58,
		["62"] = 61,
		["63"] = 62,
		["64"] = 63,
		["65"] = 64,
		["66"] = 64,
		["67"] = 64,
		["68"] = 65,
		["69"] = 64,
		["70"] = 64,
		["73"] = 48,
		["74"] = 70,
		["75"] = 71,
		["76"] = 72,
		["77"] = 74,
		["78"] = 75,
		["79"] = 76,
		["80"] = 77,
		["81"] = 78,
		["82"] = 79,
		["83"] = 80,
		["84"] = 81,
		["86"] = 82,
		["87"] = 82,
		["88"] = 83,
		["89"] = 84,
		["90"] = 85,
		["91"] = 86,
		["93"] = 87,
		["95"] = 87,
		["96"] = 87,
		["97"] = 87,
		["99"] = 87,
		["100"] = 88,
		["104"] = 82,
		["107"] = 92,
		["108"] = 93,
		["109"] = 93,
		["114"] = 98,
		["115"] = 98,
		["116"] = 98,
		["117"] = 98,
		["119"] = 100,
		["120"] = 102,
		["121"] = 103,
		["122"] = 104,
		["123"] = 105,
		["124"] = 106,
		["125"] = 106,
		["126"] = 107,
		["129"] = 70,
		["130"] = 111,
		["131"] = 112,
		["132"] = 113,
		["133"] = 114,
		["135"] = 111,
		["136"] = 117,
		["137"] = 118,
		["138"] = 117,
		["139"] = 121,
		["140"] = 122,
		["141"] = 121,
		["142"] = 125,
		["143"] = 126,
		["144"] = 125,
		["145"] = 128,
		["146"] = 129,
		["147"] = 130,
		["148"] = 131,
		["149"] = 132,
		["150"] = 133,
		["152"] = 135,
		["153"] = 136,
		["154"] = 136,
		["155"] = 136,
		["156"] = 136,
		["157"] = 136,
		["158"] = 136,
		["159"] = 136,
		["160"] = 136,
		["162"] = 138,
		["163"] = 138,
		["164"] = 138,
		["165"] = 138,
		["166"] = 138,
		["167"] = 138,
		["168"] = 138,
		["169"] = 138,
		["171"] = 140,
		["172"] = 141,
		["173"] = 142,
		["174"] = 143,
		["175"] = 144,
		["176"] = 145,
		["177"] = 145,
		["178"] = 145,
		["179"] = 145,
		["180"] = 145,
		["181"] = 145,
		["182"] = 145,
		["183"] = 145,
		["187"] = 128,
		["188"] = 150,
		["189"] = 151,
		["190"] = 152,
		["191"] = 153,
		["192"] = 154,
		["193"] = 156,
		["195"] = 150,
		["196"] = 159,
		["197"] = 160,
		["198"] = 161,
		["199"] = 161,
		["200"] = 161,
		["201"] = 161,
		["202"] = 161,
		["203"] = 161,
		["204"] = 161,
		["205"] = 161,
		["206"] = 161,
		["207"] = 161,
		["208"] = 161,
		["209"] = 161,
		["210"] = 161,
		["211"] = 161,
		["212"] = 161,
		["213"] = 161,
		["214"] = 161,
		["215"] = 161,
		["216"] = 161,
		["217"] = 159,
		["218"] = 182,
		["219"] = 183,
		["220"] = 182,
		["221"] = 185,
		["222"] = 186,
		["223"] = 188,
		["224"] = 188,
		["225"] = 188,
		["226"] = 188,
		["227"] = 188,
		["228"] = 188,
		["229"] = 188,
		["230"] = 188,
		["231"] = 185,
		["232"] = 191,
		["233"] = 192,
		["234"] = 192,
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
		["245"] = 191,
		["246"] = 195,
		["247"] = 196,
		["248"] = 196,
		["249"] = 196,
		["250"] = 196,
		["251"] = 196,
		["252"] = 196,
		["253"] = 196,
		["254"] = 196,
		["255"] = 195,
		["256"] = 198,
		["257"] = 199,
		["258"] = 199,
		["259"] = 199,
		["260"] = 199,
		["261"] = 199,
		["262"] = 199,
		["263"] = 199,
		["264"] = 199,
		["265"] = 198,
		["266"] = 201,
		["267"] = 202,
		["268"] = 202,
		["269"] = 202,
		["270"] = 202,
		["271"] = 202,
		["272"] = 202,
		["273"] = 202,
		["274"] = 202,
		["275"] = 201,
		["276"] = 204,
		["277"] = 205,
		["278"] = 205,
		["279"] = 205,
		["280"] = 205,
		["281"] = 205,
		["282"] = 205,
		["283"] = 205,
		["284"] = 205,
		["285"] = 204,
		["286"] = 207,
		["287"] = 208,
		["288"] = 208,
		["289"] = 208,
		["290"] = 208,
		["291"] = 208,
		["292"] = 208,
		["293"] = 208,
		["294"] = 208,
		["295"] = 207,
		["296"] = 210,
		["297"] = 211,
		["298"] = 211,
		["299"] = 211,
		["300"] = 211,
		["301"] = 211,
		["302"] = 211,
		["303"] = 211,
		["304"] = 211,
		["305"] = 210,
		["306"] = 213,
		["307"] = 214,
		["308"] = 214,
		["309"] = 214,
		["310"] = 214,
		["311"] = 214,
		["312"] = 214,
		["313"] = 214,
		["314"] = 214,
		["315"] = 213,
		["316"] = 216,
		["317"] = 217,
		["318"] = 218,
		["319"] = 219,
		["321"] = 216,
		["322"] = 223,
		["323"] = 224,
		["324"] = 225,
		["325"] = 223,
		["326"] = 228,
		["327"] = 229,
		["328"] = 230,
		["329"] = 230,
		["331"] = 231,
		["332"] = 232,
		["333"] = 232,
		["335"] = 233,
		["336"] = 228,
		["337"] = 237,
		["338"] = 238,
		["339"] = 240,
		["340"] = 241,
		["341"] = 243,
		["342"] = 244,
		["343"] = 245,
		["344"] = 246,
		["345"] = 247,
		["346"] = 248,
		["347"] = 251,
		["348"] = 237,
		["349"] = 254,
		["350"] = 255,
		["351"] = 256,
		["352"] = 257,
		["353"] = 258,
		["354"] = 259,
		["356"] = 261,
		["358"] = 263,
		["359"] = 254,
		["360"] = 266,
		["361"] = 267,
		["362"] = 268,
		["363"] = 269,
		["364"] = 270,
		["367"] = 273,
		["368"] = 274,
		["371"] = 277,
		["372"] = 279,
		["373"] = 280,
		["374"] = 281,
		["375"] = 282,
		["376"] = 284,
		["378"] = 286,
		["379"] = 287,
		["380"] = 287,
		["381"] = 287,
		["382"] = 287,
		["383"] = 292,
		["384"] = 293,
		["385"] = 294,
		["387"] = 287,
		["388"] = 287,
		["390"] = 299,
		["392"] = 301,
		["393"] = 302,
		["394"] = 303,
		["395"] = 303,
		["396"] = 305,
		["397"] = 305,
		["398"] = 305,
		["399"] = 305,
		["400"] = 305,
		["401"] = 305,
		["402"] = 305,
		["403"] = 305,
		["404"] = 303,
		["405"] = 303,
		["406"] = 303,
		["407"] = 303,
		["408"] = 317,
		["409"] = 318,
		["410"] = 319,
		["413"] = 266,
		["414"] = 327,
		["415"] = 328,
		["418"] = 331,
		["419"] = 332,
		["420"] = 333,
		["421"] = 334,
		["423"] = 336,
		["424"] = 337,
		["425"] = 338,
		["426"] = 339,
		["429"] = 341,
		["430"] = 341,
		["431"] = 342,
		["432"] = 343,
		["433"] = 344,
		["434"] = 345,
		["435"] = 346,
		["436"] = 347,
		["437"] = 348,
		["438"] = 348,
		["439"] = 348,
		["440"] = 348,
		["441"] = 348,
		["443"] = 350,
		["447"] = 341,
		["450"] = 355,
		["451"] = 356,
		["452"] = 356,
		["453"] = 356,
		["454"] = 357,
		["455"] = 358,
		["456"] = 359,
		["457"] = 360,
		["459"] = 362,
		["461"] = 356,
		["462"] = 356,
		["464"] = 367,
		["465"] = 368,
		["466"] = 369,
		["467"] = 370,
		["468"] = 371,
		["469"] = 372,
		["470"] = 373,
		["472"] = 375,
		["473"] = 376,
		["474"] = 377,
		["475"] = 378,
		["476"] = 379,
		["478"] = 381,
		["481"] = 384,
		["482"] = 327,
		["483"] = 386,
		["484"] = 387,
		["485"] = 386,
		["486"] = 391,
		["487"] = 392,
		["488"] = 391,
		["489"] = 394,
		["490"] = 395,
		["491"] = 395,
		["492"] = 395,
		["493"] = 395,
		["494"] = 395,
		["495"] = 395,
		["496"] = 395,
		["497"] = 395,
		["498"] = 395,
		["499"] = 395,
		["500"] = 395,
		["501"] = 395,
		["502"] = 395,
		["503"] = 395,
		["504"] = 395,
		["505"] = 395,
		["506"] = 395,
		["507"] = 395,
		["508"] = 395,
		["509"] = 395,
		["510"] = 395,
		["511"] = 395,
		["512"] = 395,
		["513"] = 395,
		["514"] = 395,
		["515"] = 395,
		["516"] = 395,
		["517"] = 395,
		["518"] = 395,
		["519"] = 395,
		["520"] = 395,
		["521"] = 395,
		["522"] = 395,
		["523"] = 395,
		["524"] = 395,
		["525"] = 395,
		["526"] = 395,
		["527"] = 395,
		["528"] = 395,
		["529"] = 394,
		["530"] = 435,
		["531"] = 436,
		["532"] = 435,
		["533"] = 438,
		["534"] = 439,
		["535"] = 438,
		["536"] = 441,
		["537"] = 441,
		["538"] = 441,
		["540"] = 442,
		["543"] = 445,
		["544"] = 446,
		["545"] = 447,
		["546"] = 448,
		["548"] = 450,
		["549"] = 451,
		["550"] = 452,
		["552"] = 454,
		["554"] = 456,
		["555"] = 457,
		["556"] = 457,
		["557"] = 457,
		["558"] = 457,
		["559"] = 458,
		["560"] = 459,
		["561"] = 459,
		["562"] = 459,
		["563"] = 459,
		["564"] = 460,
		["566"] = 462,
		["568"] = 441,
		["569"] = 11,
		["570"] = 3,
		["571"] = 3,
		["572"] = 3,
		["573"] = 3,
		["574"] = 3,
		["575"] = 3,
		["576"] = 3,
		["577"] = 3,
		["578"] = 11,
		["580"] = 11,
	}
)
local l = {}
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
l.modifier_hero = c()
local p = l.modifier_hero
p.name = "modifier_hero"
d(p, n)
function p.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.landedTime = 0
	self.itemValues = {}
	self.sectList = {}
	self.enableSound = false
	self._ABILITY_LIST = {}
	self.GameHealPct = 0
end
function p.prototype.GetAbilitySpecialValue(self)
	if IsServer() then
		if e(AbilityShop.banList, "sect_regen") then
			self.GameHealPct = BUFF_VALUE.RegenDisablePct
		end
	else
		local q = CustomNetTables:GetTableValue("common", "ban_list")
		if q and e(f(q), "sect_regen") then
			self.GameHealPct = BUFF_VALUE.RegenDisablePct
		end
	end
end
function p.prototype.CheckState(self)
	return { [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true, [MODIFIER_STATE_ROOTED] = self:GetStackCount()
		== 1 }
end
function p.prototype.OnCreated(self, r)
	local s = self:GetParent()
	if IsServer() then
		self:CheckAbilityLifeStealSectAndAbility()
		s:SetBaseManaRegen(0)
		if r.bFirstSpawn == 1 then
			self.enableSound = true
			self:EmitVoiceSound("respawn", true)
		else
			self.enableSound = r.bImmediately == 1
		end
	end
	if not s:HasModifier("modifier_neutral") then
		self:SetHasCustomTransmitterData(true)
		if IsServer() then
			s:GameTimer(0.1, function()
				self:RefreshInventory()
			end)
		end
	end
end
function p.prototype.CheckAbilityLifeStealSectAndAbility(self)
	self.sectList = {}
	local t = self.parent:GetUnitName()
	local u = AbilityShop:GetRecommendSectByHeroName(t)
	if u == "sect_none" then
		local v = self.parent:GetPlayerOwnerID()
		local w = PlayerData:getHero(v)
		if #AbilityShop.pickList > 0 then
			if w then
				local x = w:getAbilityData(true)
				local y = ""
				do
					local z = 1
					while z < #AbilityShop.pickList do
						local A = AbilityShop.pickList[z + 1]
						if A ~= "sect_attack" then
							if y == "" then
								y = A
							else
								local B = x[A]
								if B then
									local C = x[A].exp
									local D = x[y]
									B = C > (D and D.exp or 0)
								end
								if B then
									y = A
								end
							end
						end
						z = z + 1
					end
				end
				if y ~= "" then
					local E = self.sectList
					E[#E + 1] = y
				end
			end
		end
	else
		self.sectList = h(g(u, "|"), function(F, G)
			return G ~= "sect_attack"
		end)
	end
	self._ABILITY_LIST = {}
	if KeyValues.CommonUnitsKv and KeyValues.CommonUnitsKv[t] then
		local H = KeyValues.CommonUnitsKv[t]
		local z = 1
		while H["DefaultAbility" .. tostring(z)] do
			local I = self._ABILITY_LIST
			I[#I + 1] = H["DefaultAbility" .. tostring(z)]
			z = z + 1
		end
	end
end
function p.prototype.OnThink(self, J)
	if J == "EnableSound" then
		self:StartThink(-1, "EnableSound")
		self.enableSound = true
	end
end
function p.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT }
end
function p.prototype.GetModifierBaseAttackTimeConstant(self)
	return GetAttackRate(self:GetParent())
end
function p.prototype.GetModifierDoNotSinkAfterDeath(self)
	return 1
end
function p.prototype.OnCustomTakeDamage(self, K)
	local L = GetModifierProperty(K.attacker, EOMModifierFunction.EOM_MODIFIER_PROPERTY_LIFESTEAL, K)
	if K.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK and L > 0 then
		local M
		if IsValid(K.ability) then
			M = K.ability:GetAbilityName()
		end
		if M then
			Heal(K.attacker, K.damage * L * 0.01, M, "Ability", false, HealFlags.HEAL_FLAG_LIFESETEAL)
		else
			Heal(K.attacker, K.damage * L * 0.01, "Attack", "Attack", false, HealFlags.HEAL_FLAG_LIFESETEAL)
		end
	elseif IsValid(K.ability) then
		local N = GetModifierProperty(K.attacker, EOMModifierFunction.EOM_MODIFIER_PROPERTY_ABILITY_LIFESTEAL, K)
		if N > 0 then
			local M = K.ability:GetAbilityName()
			if e(self._ABILITY_LIST, M) or e(self.sectList, M) then
				Heal(K.attacker, K.damage * N * 0.01, M, "Ability", false, HealFlags.HEAL_FLAG_ABILITY_LIFESETEAL)
			end
		end
	end
end
function p.prototype.OnBattleStartBefore(self, r)
	self:CheckAbilityLifeStealSectAndAbility()
	local O = PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
	if O then
		O:RefreshPermanentBuff(self:GetParent())
		self:RefreshInventory()
	end
end
function p.prototype.EDeclareEvents(self)
	local s = self:GetParent()
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { s, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { s, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { s, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_GAINED] = { s, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_GAINED] = { s, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_POISON_GAINED] = { s, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { s, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED] = { s, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_CHAOS_POINT_GAINED] = { s, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { s, s },
		[MODIFIER_EVENT_ON_ATTACK_LANDED] = { s, -1 },
		[MODIFIER_EVENT_ON_ATTACK_START] = { s, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { s, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP] = { s, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_HERO_RESPAWN] = { s, -1 },
	}
end
function p.prototype.OnAttackLanded(self, r)
	DamageSystem:performAttack(r.attacker, r.target, self.attackEventInfo, true)
end
function p.prototype.OnAttackStart(self, r)
	self.attackEventInfo = DamageSystem:parseAttackParams(r.attacker, r.target, {})
	xpcall(
		FireModifierEvent,
		debug.traceback,
		EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_START,
		self.attackEventInfo,
		r.attacker,
		r.target
	)
end
function p.prototype.OnCustomAbilityFullyCast(self, r)
	PlayerData:addDetailData(self:GetParent(), "Sect", "ulti", 1, false, "sect_ulti")
	CombatLog:recordAbilityCast(self:GetParent(), r.ability)
end
function p.prototype.OnEvasion(self)
	PlayerData:addDetailData(self:GetParent(), "Sect", "evade", 1, false, "sect_evade")
end
function p.prototype.OnShieldGained(self, r)
	PlayerData:addDetailData(self:GetParent(), r.type, "shield", r.iStackCount, false, r.origin)
end
function p.prototype.OnInjuryGained(self, r)
	PlayerData:addDetailData(self:GetParent(), r.type, "injury", r.iStackCount, false, r.origin)
end
function p.prototype.OnPoisonGained(self, r)
	PlayerData:addDetailData(self:GetParent(), r.type, "poison", r.iStackCount, false, r.origin)
end
function p.prototype.OnIceGained(self, r)
	PlayerData:addDetailData(self:GetParent(), r.type, "ice", r.iStackCount, false, r.origin)
end
function p.prototype.OnFuryGained(self, r)
	PlayerData:addDetailData(self:GetParent(), r.type, "fury", r.iStackCount, false, r.origin)
end
function p.prototype.OnChaosPointGained(self, r)
	PlayerData:addDetailData(self:GetParent(), r.type, "chaos", r.iStackCount, false, r.origin)
end
function p.prototype.OnHeroLevelUp(self, r)
	if self:GetParent() and self.levelUpSoundFrameTime ~= GameRules:GetGameTime() then
		self.levelUpSoundFrameTime = GameRules:GetGameTime()
		self:EmitVoiceSound("levelup")
	end
end
function p.prototype.OnHeroRespawn(self)
	self.enableSound = true
	self:EmitVoiceSound("respawn", true)
end
function p.prototype.generateRoundSeed(self, P)
	local Q = tonumber(Match.matchId)
	if not Q then
		Q = 142857
	end
	local R = tonumber(P)
	if not R then
		R = 142857
	end
	return Q + Rounds:getCurrentRound() + R
end
function p.prototype.OnBattleStart(self, r)
	local s = self:GetParent()
	local v = s:GetPlayerOwnerID()
	local O = PlayerData.playerData[v]
	self.attackState = "start"
	self.attackInterval = 1 / s:GetAttacksPerSecond(false)
	self.attackPoint = 1 / s:GetAttackSpeed(false) * s:GetAttackAnimationPoint()
	self.timeRecord = 0
	self.timeAnchorPointNext = self.attackPoint + FRAME_TIME * 2
	self.attackspeed = s:GetAttackSpeed(false)
	self:SetStackCount(1)
end
function p.prototype.OnBattleEnd(self, r)
	local s = self:GetParent()
	local v = s:GetPlayerOwnerID()
	if v == r.winPlayerID or v == r.losePlayerID then
		if v == r.winPlayerID and v ~= r.illusionPlayerID then
			self:EmitVoiceSound("attack")
		end
		self:StartIntervalThink(-1)
	end
	self:SetStackCount(0)
end
function p.prototype.OnIntervalThink(self)
	local s = self:GetParent()
	local S = s:GetEnemy()
	if not IsInjurable(s, S) then
		self:StartIntervalThink(-1)
		return
	end
	if s:IsDisarmed() or s:IsStunned() then
		self.timeRecord = 0
		return
	end
	self.timeRecord = self.timeRecord + FRAME_TIME * s:GetAttackSpeed(false) / 1
	if self.timeRecord >= self.timeAnchorPointNext then
		self.timeRecord = self.timeRecord - self.timeAnchorPointNext
		if self.attackState == "start" then
			if self:GetParent():GetPlayerOwnerID() == 0 then
				self.landedTime = GameRules:GetGameTime()
			end
			if s:IsRangedAttacker() then
				Projectile:CreateTrackingProjectile({
					hCaster = s,
					hTarget = S,
					iMoveSpeed = s:GetProjectileSpeed(),
					OnProjectileHit = function(T, U, V)
						if IsInjurable(T) then
							DamageSystem:performAttack(s, S, {}, true)
						end
					end,
				})
			else
				DamageSystem:performAttack(s, S, {}, true)
			end
			self.attackState = "rollback"
			self.timeAnchorPointNext = self.attackInterval - self.attackPoint
			FireModifierEvent(
				EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_START,
				{
					attacker = s,
					damage = GetAttackDamage(s),
					damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL,
					damage_category = DOTA_DAMAGE_CATEGORY_ATTACK,
					damage_flags = DOTA_DAMAGE_FLAG_NONE,
					ranged_attack = s:IsRangedAttacker(),
					target = S,
				},
				s,
				S
			)
		elseif self.attackState == "rollback" then
			self.attackState = "start"
			self.timeAnchorPointNext = self.attackPoint
		end
	end
end
function p.prototype.RefreshInventory(self)
	if self.parent:IsNeutral() then
		return
	end
	local s = self:GetParent()
	local w = s:GetHeroBase()
	for F, W in ipairs(ITEM_ATTRIBUTE) do
		self.itemValues[W] = 0
	end
	local X = DOTA_ITEM_SLOT_3
	local Y = w:getItemList()
	if Y and #Y > 0 then
		X = #Y
	end
	do
		local Z = 0
		while Z <= X do
			local _ = s:GetItemInSlot(Z)
			if IsValid(_) then
				for a0 in pairs(self.itemValues) do
					local a1 = self.itemValues[a0]
					local a2 = SPECIALLY_PROPERTY_OPERATION[a0]
					if a2 ~= nil then
						self.itemValues[a0] = a2(nil, a1, _:GetSpecialValueFor(a0))
					else
						self.itemValues[a0] = a1 + _:GetSpecialValueFor(a0)
					end
				end
			end
			Z = Z + 1
		end
	end
	for a0, a3 in pairs(w.property) do
		i(a3, function(F, a4)
			local a5 = self.itemValues[a0]
			local a2 = SPECIALLY_PROPERTY_OPERATION[a0]
			if a2 ~= nil then
				self.itemValues[a0] = a2(nil, a5, a4)
			else
				self.itemValues[a0] = a5 + a4
			end
		end)
	end
	local a6 = Greevil:getPlayerData(self.parent:GetPlayerOwnerID())
	if a6 then
		local a4 = 0
		if a6.level == 2 then
			a4 = 5
		elseif a6.level == 3 then
			a4 = 10
		end
		local a0 = "item_reduce"
		local a5 = self.itemValues[a0]
		local a2 = SPECIALLY_PROPERTY_OPERATION[a0]
		if a2 ~= nil then
			self.itemValues[a0] = a2(nil, a5, a4)
		else
			self.itemValues[a0] = a5 + a4
		end
	end
	self:ForceRefresh()
end
function p.prototype.AddCustomTransmitterData(self)
	return { itemValues = self.itemValues }
end
function p.prototype.HandleCustomTransmitterData(self, H)
	self.itemValues = H.itemValues
end
function p.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS] = self.itemValues.item_health,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER] = self.itemValues.item_ulti_power,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.itemValues.item_attackspeed,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE] = -(self.itemValues.item_reduce or 0),
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_COUNTER_CRITICAL_CHANCE] = self.itemValues.item_counter_critcal_chance
			or 0,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE] = -(
				self.itemValues.item_physical_armor or 0
			),
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE] = -(
				self.itemValues.item_magical_armor or 0
			),
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BONUS] = self.itemValues.item_mana_regen,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS] = self.itemValues.item_attack,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE] = self.itemValues.item_damage,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_PHYSICAL_DAMAGE_PERCENTAGE] = self.itemValues.item_physical_damage,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_MAGICAL_DAMAGE_PERCENTAGE] = self.itemValues.item_magical_damage,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_STACK_BONUS] = self.itemValues.item_fury_count,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_STACK_BONUS] = self.itemValues.item_ice_count,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_STACK_BONUS] = self.itemValues.item_shield_count,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_STACK_BONUS] = self.itemValues.item_injury_count,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_STACK_BONUS] = self.itemValues.item_poison_count,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_PERMANENT] = self.itemValues.item_permanent_fury,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_PERMANENT_SOURCE] = self.itemValues.item_permanent_ice,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_PERMANENT] = self.itemValues.item_permanent_shield,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_PERMANENT] = self.itemValues.item_permanent_chaos,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_PERMANENT_SOURCE] = self.itemValues.item_permanent_injury,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_PERMANENT_SOURCE] = self.itemValues.item_permanent_poison,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_DAMAGE_BONUS] = self.itemValues.item_poison_damage,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_BONUS] = self.itemValues.item_regen,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ABILITY_LIFESTEAL] = self.itemValues.item_ability_life_steal,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS] = self.itemValues.item_crit,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE] = self.itemValues.item_crit_damage,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS] = self.itemValues.item_evade,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_REGEN] = self.itemValues.item_wisp_regen,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_HEALTH_BONUS] = self.itemValues.item_wisp_health,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_INTERVAL] = -(self.itemValues.item_wisp_interval or 0),
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_LIFESTEAL] = self.itemValues.item_lifesteal,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVADE_DAMAGE_REDUCE_BONUS_PERCENT] = self.itemValues.item_evade_damage,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_STACK_BONUS] = self.itemValues.item_chaos_count,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_DAMAGE_BONUS] = self.itemValues.item_chaos_damage_bonus,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_STATE_RESISTANCE] = self.itemValues.item_state_resistance,
	}
end
function p.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_AMPLIFY }
end
function p.prototype.EOM_GetModifierHealAmplity(self, r)
	return self.GameHealPct
end
function p.prototype.EmitVoiceSound(self, a7, a8)
	if a8 == nil then
		a8 = false
	end
	if self:GetParent():IsCustomIllusion() then
		return
	end
	if a8 or self.enableSound then
		self.enableSound = false
		if self.lastSoundName then
			StopGlobalSound(self.lastSoundName)
		end
		local a9 = 1
		if a7 == "levelup" or a7 == "death" or a7 == "respawn" then
			a9 = RandomInt(1, 2)
		else
			a9 = RandomInt(1, 3)
		end
		local aa = (((self:GetParent():GetUnitName() .. "_") .. a7) .. "_") .. tostring(a9)
		EmitAnnouncerSoundForPlayer(aa, self:GetParent():GetPlayerOwnerID())
		self.lastSoundName = a7
		self:StartThink(RandomInt(5, 7), "EnableSound")
		return true
	else
		return false
	end
end
p = j(
	{
		o(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	p
)
l.modifier_hero = p
return l