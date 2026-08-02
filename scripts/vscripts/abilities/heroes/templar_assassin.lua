--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/templar_assassin"
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
		["18"] = 8,
		["19"] = 9,
		["20"] = 8,
		["21"] = 9,
		["22"] = 10,
		["23"] = 11,
		["24"] = 10,
		["25"] = 9,
		["26"] = 8,
		["27"] = 9,
		["29"] = 9,
		["30"] = 15,
		["31"] = 23,
		["32"] = 15,
		["33"] = 23,
		["35"] = 23,
		["36"] = 28,
		["37"] = 32,
		["38"] = 36,
		["39"] = 40,
		["40"] = 41,
		["41"] = 42,
		["42"] = 46,
		["43"] = 62,
		["44"] = 15,
		["45"] = 63,
		["46"] = 64,
		["47"] = 65,
		["48"] = 66,
		["49"] = 68,
		["50"] = 69,
		["51"] = 71,
		["52"] = 72,
		["53"] = 74,
		["54"] = 75,
		["55"] = 77,
		["56"] = 78,
		["57"] = 87,
		["58"] = 88,
		["59"] = 90,
		["60"] = 63,
		["61"] = 92,
		["62"] = 93,
		["63"] = 93,
		["64"] = 95,
		["65"] = 95,
		["66"] = 95,
		["67"] = 93,
		["68"] = 96,
		["69"] = 96,
		["70"] = 96,
		["71"] = 93,
		["72"] = 97,
		["73"] = 97,
		["74"] = 97,
		["75"] = 93,
		["76"] = 98,
		["77"] = 98,
		["78"] = 98,
		["79"] = 93,
		["80"] = 99,
		["81"] = 99,
		["82"] = 99,
		["83"] = 93,
		["84"] = 93,
		["85"] = 92,
		["86"] = 102,
		["87"] = 103,
		["88"] = 104,
		["89"] = 105,
		["90"] = 106,
		["91"] = 107,
		["92"] = 108,
		["93"] = 109,
		["94"] = 102,
		["95"] = 114,
		["96"] = 115,
		["97"] = 116,
		["100"] = 117,
		["101"] = 118,
		["102"] = 120,
		["103"] = 121,
		["104"] = 122,
		["105"] = 123,
		["106"] = 124,
		["109"] = 114,
		["110"] = 128,
		["111"] = 129,
		["114"] = 131,
		["115"] = 132,
		["116"] = 133,
		["118"] = 135,
		["120"] = 138,
		["121"] = 139,
		["122"] = 140,
		["123"] = 141,
		["124"] = 142,
		["126"] = 145,
		["127"] = 146,
		["128"] = 147,
		["129"] = 148,
		["130"] = 149,
		["133"] = 152,
		["134"] = 153,
		["135"] = 153,
		["136"] = 153,
		["137"] = 154,
		["138"] = 155,
		["140"] = 153,
		["141"] = 153,
		["143"] = 128,
		["144"] = 160,
		["145"] = 161,
		["146"] = 162,
		["148"] = 160,
		["149"] = 165,
		["150"] = 166,
		["153"] = 167,
		["154"] = 168,
		["155"] = 169,
		["156"] = 170,
		["157"] = 172,
		["159"] = 165,
		["160"] = 175,
		["161"] = 176,
		["162"] = 177,
		["164"] = 175,
		["165"] = 181,
		["166"] = 182,
		["167"] = 183,
		["168"] = 184,
		["169"] = 185,
		["171"] = 190,
		["172"] = 191,
		["174"] = 181,
		["175"] = 196,
		["176"] = 197,
		["177"] = 199,
		["178"] = 200,
		["179"] = 201,
		["180"] = 202,
		["181"] = 203,
		["182"] = 205,
		["183"] = 206,
		["186"] = 209,
		["188"] = 210,
		["189"] = 210,
		["190"] = 211,
		["191"] = 211,
		["192"] = 211,
		["193"] = 211,
		["194"] = 211,
		["195"] = 211,
		["196"] = 210,
		["200"] = 215,
		["201"] = 216,
		["202"] = 217,
		["203"] = 218,
		["204"] = 219,
		["205"] = 220,
		["208"] = 196,
		["209"] = 235,
		["210"] = 235,
		["211"] = 235,
		["213"] = 236,
		["214"] = 238,
		["215"] = 239,
		["216"] = 240,
		["217"] = 241,
		["218"] = 242,
		["219"] = 243,
		["222"] = 235,
		["223"] = 247,
		["224"] = 248,
		["225"] = 249,
		["226"] = 250,
		["229"] = 254,
		["230"] = 255,
		["231"] = 256,
		["232"] = 257,
		["233"] = 258,
		["234"] = 259,
		["235"] = 260,
		["236"] = 260,
		["237"] = 260,
		["238"] = 260,
		["239"] = 261,
		["242"] = 262,
		["243"] = 263,
		["244"] = 263,
		["245"] = 263,
		["246"] = 263,
		["247"] = 263,
		["248"] = 264,
		["249"] = 264,
		["250"] = 264,
		["251"] = 264,
		["252"] = 264,
		["253"] = 264,
		["254"] = 264,
		["255"] = 264,
		["256"] = 264,
		["257"] = 260,
		["258"] = 260,
		["261"] = 247,
		["262"] = 295,
		["263"] = 296,
		["264"] = 295,
		["265"] = 301,
		["266"] = 302,
		["267"] = 303,
		["269"] = 301,
		["270"] = 306,
		["271"] = 307,
		["272"] = 308,
		["274"] = 306,
		["275"] = 23,
		["276"] = 15,
		["277"] = 15,
		["278"] = 15,
		["279"] = 15,
		["280"] = 15,
		["281"] = 15,
		["282"] = 15,
		["283"] = 15,
		["284"] = 23,
		["286"] = 23,
		["288"] = 314,
		["289"] = 323,
		["290"] = 314,
		["291"] = 323,
		["292"] = 327,
		["293"] = 328,
		["294"] = 327,
		["295"] = 330,
		["296"] = 331,
		["297"] = 332,
		["298"] = 330,
		["299"] = 334,
		["300"] = 335,
		["301"] = 336,
		["302"] = 337,
		["303"] = 337,
		["304"] = 337,
		["305"] = 337,
		["307"] = 339,
		["308"] = 340,
		["309"] = 340,
		["310"] = 340,
		["311"] = 340,
		["312"] = 340,
		["313"] = 340,
		["314"] = 340,
		["315"] = 340,
		["316"] = 340,
		["317"] = 341,
		["318"] = 341,
		["319"] = 341,
		["320"] = 341,
		["321"] = 341,
		["322"] = 341,
		["323"] = 341,
		["324"] = 341,
		["325"] = 341,
		["326"] = 342,
		["327"] = 342,
		["328"] = 342,
		["329"] = 342,
		["330"] = 342,
		["331"] = 342,
		["332"] = 342,
		["333"] = 342,
		["335"] = 334,
		["336"] = 345,
		["337"] = 346,
		["338"] = 347,
		["339"] = 347,
		["340"] = 347,
		["341"] = 347,
		["343"] = 345,
		["344"] = 350,
		["345"] = 351,
		["346"] = 352,
		["348"] = 354,
		["349"] = 355,
		["350"] = 356,
		["351"] = 357,
		["353"] = 359,
		["354"] = 350,
		["355"] = 361,
		["356"] = 362,
		["357"] = 364,
		["358"] = 364,
		["359"] = 364,
		["360"] = 362,
		["361"] = 365,
		["362"] = 365,
		["363"] = 365,
		["364"] = 362,
		["365"] = 362,
		["366"] = 361,
		["367"] = 368,
		["368"] = 369,
		["369"] = 368,
		["370"] = 374,
		["371"] = 375,
		["374"] = 376,
		["375"] = 374,
		["376"] = 378,
		["377"] = 378,
		["378"] = 378,
		["380"] = 379,
		["381"] = 380,
		["382"] = 381,
		["383"] = 382,
		["385"] = 384,
		["386"] = 385,
		["388"] = 378,
		["389"] = 388,
		["390"] = 389,
		["391"] = 388,
		["392"] = 393,
		["393"] = 394,
		["394"] = 393,
		["395"] = 323,
		["396"] = 314,
		["397"] = 314,
		["398"] = 314,
		["399"] = 314,
		["400"] = 314,
		["401"] = 314,
		["402"] = 314,
		["403"] = 314,
		["404"] = 323,
		["406"] = 323,
		["408"] = 399,
		["409"] = 408,
		["410"] = 399,
		["411"] = 408,
		["412"] = 412,
		["413"] = 413,
		["414"] = 412,
		["415"] = 415,
		["416"] = 416,
		["417"] = 417,
		["418"] = 415,
		["419"] = 419,
		["420"] = 420,
		["421"] = 421,
		["422"] = 422,
		["423"] = 423,
		["424"] = 423,
		["425"] = 423,
		["426"] = 423,
		["427"] = 424,
		["428"] = 424,
		["429"] = 424,
		["430"] = 425,
		["433"] = 426,
		["434"] = 427,
		["435"] = 424,
		["436"] = 424,
		["438"] = 430,
		["439"] = 431,
		["440"] = 431,
		["441"] = 431,
		["442"] = 431,
		["443"] = 431,
		["444"] = 431,
		["445"] = 431,
		["446"] = 431,
		["447"] = 431,
		["448"] = 432,
		["449"] = 432,
		["450"] = 432,
		["451"] = 432,
		["452"] = 432,
		["453"] = 432,
		["454"] = 432,
		["455"] = 432,
		["457"] = 419,
		["458"] = 435,
		["459"] = 436,
		["460"] = 437,
		["461"] = 437,
		["462"] = 437,
		["463"] = 437,
		["465"] = 435,
		["466"] = 440,
		["467"] = 441,
		["468"] = 442,
		["470"] = 444,
		["471"] = 445,
		["472"] = 446,
		["473"] = 447,
		["475"] = 449,
		["476"] = 440,
		["477"] = 451,
		["478"] = 452,
		["479"] = 453,
		["480"] = 453,
		["481"] = 452,
		["482"] = 451,
		["483"] = 462,
		["484"] = 462,
		["485"] = 462,
		["487"] = 463,
		["488"] = 464,
		["489"] = 465,
		["490"] = 466,
		["492"] = 468,
		["493"] = 469,
		["495"] = 462,
		["496"] = 472,
		["497"] = 473,
		["498"] = 472,
		["499"] = 477,
		["500"] = 478,
		["501"] = 477,
		["502"] = 408,
		["503"] = 399,
		["504"] = 399,
		["505"] = 399,
		["506"] = 399,
		["507"] = 399,
		["508"] = 399,
		["509"] = 399,
		["510"] = 399,
		["511"] = 408,
		["513"] = 408,
		["515"] = 483,
		["516"] = 492,
		["517"] = 483,
		["518"] = 492,
		["519"] = 493,
		["520"] = 494,
		["521"] = 493,
		["522"] = 499,
		["523"] = 500,
		["524"] = 500,
		["525"] = 500,
		["526"] = 500,
		["527"] = 499,
		["528"] = 502,
		["529"] = 503,
		["530"] = 502,
		["531"] = 492,
		["532"] = 483,
		["533"] = 483,
		["534"] = 483,
		["535"] = 483,
		["536"] = 483,
		["537"] = 483,
		["538"] = 483,
		["539"] = 483,
		["540"] = 492,
		["542"] = 492,
		["544"] = 508,
		["545"] = 519,
		["546"] = 508,
		["547"] = 519,
		["549"] = 519,
		["550"] = 521,
		["551"] = 508,
		["552"] = 523,
		["553"] = 524,
		["554"] = 523,
		["555"] = 526,
		["556"] = 527,
		["557"] = 528,
		["558"] = 529,
		["559"] = 530,
		["561"] = 526,
		["562"] = 533,
		["563"] = 534,
		["566"] = 535,
		["567"] = 536,
		["568"] = 537,
		["569"] = 538,
		["570"] = 539,
		["571"] = 539,
		["572"] = 539,
		["573"] = 539,
		["574"] = 539,
		["575"] = 539,
		["576"] = 539,
		["577"] = 539,
		["578"] = 539,
		["579"] = 533,
		["580"] = 519,
		["581"] = 508,
		["582"] = 508,
		["583"] = 508,
		["584"] = 508,
		["585"] = 508,
		["586"] = 508,
		["587"] = 508,
		["588"] = 508,
		["589"] = 508,
		["590"] = 508,
		["591"] = 508,
		["592"] = 519,
		["594"] = 519,
		["596"] = 554,
		["597"] = 555,
		["598"] = 554,
		["599"] = 555,
		["600"] = 556,
		["601"] = 557,
		["602"] = 558,
		["603"] = 559,
		["606"] = 560,
		["607"] = 561,
		["610"] = 562,
		["611"] = 563,
		["612"] = 564,
		["613"] = 565,
		["614"] = 566,
		["615"] = 567,
		["616"] = 567,
		["617"] = 567,
		["618"] = 567,
		["619"] = 567,
		["620"] = 556,
		["621"] = 555,
		["622"] = 554,
		["623"] = 555,
		["625"] = 555,
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
g.templar_assassin_talent = c()
local q = g.templar_assassin_talent
q.name = "templar_assassin_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_templar_assassin_talent"
end
q = e({ j(nil) }, q)
g.templar_assassin_talent = q
g.modifier_templar_assassin_talent = c()
local r = g.modifier_templar_assassin_talent
r.name = "modifier_templar_assassin_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tl1_record = 0
	self.tl2_record = 0
	self.tl3_record = 0
	self.tl4_record = 0
	self.tl4_counter = 0
	self.tl4_enable = false
	self.tl5_record = 0
	self.s_enable = false
end
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.tl1_shield_threshold = self:GetAbilityTalentValue("templar_assassin_talent_1", "shield_threshold")
	self.tl1_psi_count = self:GetAbilityTalentValue("templar_assassin_talent_1", "psi_count")
	self.tl2_count = self:GetAbilityTalentValue("templar_assassin_talent_2", "count")
	self.tl2_psi_count = self:GetAbilityTalentValue("templar_assassin_talent_2", "psi_count")
	self.tl3_dec_count = self:GetAbilityTalentValue("templar_assassin_talent_3", "dec_count")
	self.tl3_bonus_count = self:GetAbilityTalentValue("templar_assassin_talent_3", "bonus_count")
	self.tl4_bonus_damage = self:GetAbilityTalentValue("templar_assassin_talent_4", "bonus_damage")
	self.tl4_count = self:GetAbilityTalentValue("templar_assassin_talent_4", "count")
	self.tl5_count = self:GetAbilityTalentValue("templar_assassin_talent_5", "count")
	self.tl5_damage = self:GetAbilityTalentValue("templar_assassin_talent_5", "damage")
	self.tl7_shield_count = self:GetAbilityTalentValue("templar_assassin_talent_7", "shield_count")
	self.tl8_psi_count_bonus = self:GetAbilityTalentValue("templar_assassin_talent_8", "psi_count_bonus")
	self.tl9_chance = self:GetAbilityTalentValue("templar_assassin_talent_9", "chance")
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_DAMAGE_START] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_GAINED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_START] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_STUN] = { -1, self:GetParent() },
	}
end
function r.prototype.OnBattleStartBefore(self, s)
	self.tl1_record = 0
	self.tl2_record = 0
	self.tl3_record = 0
	self.tl4_record = 0
	self.tl4_counter = 0
	self.tl5_record = 0
	self.s_enable = self:HasTalent("templar_assassin_shard")
end
function r.prototype.OnCustomAttackStart(self, t)
	if IsServer() then
		if IsValid(t and t.ability) then
			return
		end
		local u = self:GetParent()
		u:RemoveModifierByName("modifier_templar_assassin_talent_4_buff")
		if self.tl4_counter > 0 then
			self.tl4_counter = self.tl4_counter - 1
			self.tl4_enable = true
			local v = self:GetAbility()
			u:AddNewModifier(u, v, "modifier_templar_assassin_talent_4_buff", nil)
		end
	end
end
function r.prototype.OnDamageStart(self, t)
	if t.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then
		return
	end
	if IsValid(t and t.ability) and t.ability == self:GetAbility() then
		if self.tl4_enable then
			t.target:EmitSound("Hero_TemplarAssassin.Meld.Attack")
		end
		self.tl4_enable = false
	end
	local w = 0
	local x = 0
	if not self:GetCaster():PassivesDisabled() and self:PRD(self.chance, "talent") then
		w = w + 1
		x = x + 1
	end
	if self.tl2_count > 0 then
		self.tl2_record = self.tl2_record + 1
		if self.tl2_record >= self.tl2_count then
			self.tl2_record = 0
			x = x + 1
		end
	end
	if w > 0 or x > 0 then
		GameTimer(FRAME_TIME, function()
			if IsValid(self) then
				self:AddPsiPower(x, w)
			end
		end)
	end
end
function r.prototype.OnCustomTakeDamage(self, t)
	if self.tl9_chance > 0 and self:PRD(self.tl9_chance, "tl9_chance") then
		self:AddPsiPower(0, 1)
	end
end
function r.prototype.OnShieldGained(self, s)
	if self.tl1_shield_threshold == 0 then
		return
	end
	self.tl1_record = self.tl1_record + s.iStackCount
	if self.tl1_record >= self.tl1_shield_threshold then
		local y = math.floor(self.tl1_record / self.tl1_shield_threshold)
		self.tl1_record = self.tl1_record - self.tl1_shield_threshold * y
		self:AddPsiPower(0, y * self.tl1_psi_count)
	end
end
function r.prototype.OnStun(self, t)
	if self.s_enable then
		self:AddPsiPower(1, 1)
	end
end
function r.prototype.AddPsiPower(self, z, A)
	local u = self:GetParent()
	local v = self:GetAbility()
	if z ~= nil and z > 0 then
		u:AddNewModifier(u, v, "modifier_templar_assassin_psi_blade", { add_count = z + self.tl8_psi_count_bonus })
	end
	if A ~= nil and A > 0 then
		u:AddNewModifier(u, v, "modifier_templar_assassin_psi_shield", { add_count = A + self.tl8_psi_count_bonus })
	end
end
function r.prototype.OnDecrementPsiShield(self, y, B)
	self:AddPisUseCount(y, "shield")
	if self.tl3_dec_count > 0 then
		self.tl3_record = self.tl3_record + y
		if self.tl3_record >= self.tl3_dec_count then
			local C = math.floor(self.tl3_record / self.tl3_dec_count)
			self.tl3_record = self.tl3_record - C * self.tl3_dec_count
			local x = C * self.tl3_bonus_count
			self:AddPsiPower(x)
		end
	end
	if self.tl7_shield_count > 0 then
		do
			local D = 0
			while D < y do
				AddShield(self:GetParent(), self.tl7_shield_count, "templar_assassin_talent", "Ability")
				D = D + 1
			end
		end
	end
	if self.tl4_count > 0 then
		self.tl4_record = self.tl4_record + y
		if self.tl4_record >= self.tl4_count then
			local C = math.floor(self.tl4_record / self.tl4_count)
			self.tl4_record = self.tl4_record - C * self.tl4_count
			self.tl4_counter = self.tl4_counter + C
		end
	end
end
function r.prototype.OnDecrementPsiBlade(self, y)
	if y == nil then
		y = 1
	end
	self:AddPisUseCount(y, "blade")
	if self.tl4_count > 0 then
		self.tl4_record = self.tl4_record + y
		if self.tl4_record >= self.tl4_count then
			local C = math.floor(self.tl4_record / self.tl4_count)
			self.tl4_record = self.tl4_record - C * self.tl4_count
			self.tl4_counter = self.tl4_counter + C
		end
	end
end
function r.prototype.AddPisUseCount(self, y, E)
	local u = self:GetParent()
	local F = u:GetEnemy()
	if not IsInjurable(u, F) then
		return
	end
	if self.tl5_count > 0 and E == "shield" then
		self.tl5_record = self.tl5_record + y
		if self.tl5_record >= self.tl5_count then
			local C = math.floor(self.tl5_record / self.tl5_count)
			self.tl5_record = self.tl5_record - C * self.tl5_count
			local v = u:FindAbilityByName("templar_assassin_talent_5")
			ForWithInterval(0.1, C, function()
				if not (IsInjurable(u, F) and IsValid(v) and IsValid(self)) then
					return
				end
				ParticleManager:CreateParticle(
					"particles/econ/items/lanaya/lanaya_epit_trap/templar_assassin_epit_trap_explode.vpcf",
					PATTACH_ABSORIGIN,
					F,
					u
				)
				EmitSoundOnLocationWithCaster(F:GetAbsOrigin(), "Hero_TemplarAssassin.Trap.Explode", u)
				DamageSystem:dealDamage({
					attacker = u,
					target = F,
					ability = v,
					damage = self.tl5_damage,
					damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL,
					damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
					damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
				})
			end)
		end
	end
end
function r.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROCATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_SOURCE_ABILITY,
	}
end
function r.prototype.EOM_GetModifierProcAttackDamageBonus(self, s)
	if s and IsValid(s and s.ability) and (s and s.ability) == self:GetAbility() and self.tl4_enable then
		return self.tl4_bonus_damage
	end
end
function r.prototype.EOM_GetModifierAttackSourceAbility(self, s)
	if s and self.tl4_enable then
		return self:GetAbility()
	end
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
g.modifier_templar_assassin_talent = r
g.modifier_templar_assassin_psi_blade = c()
local G = g.modifier_templar_assassin_psi_blade
G.name = "modifier_templar_assassin_psi_blade"
d(G, l)
function G.prototype.GetTexture(self)
	return "templar_assassin_refraction_damage"
end
function G.prototype.GetAbilitySpecialValue(self)
	self.attack = self:GetAbilitySpecialValueFor("attack")
	self.max_count = self:GetAbilitySpecialValueFor("max_count")
		+ self:GetAbilityTalentValue("templar_assassin_talent_8", "psi_max_count")
end
function G.prototype.OnCreated(self, s)
	local u = self:GetParent()
	if IsServer() then
		self:SetStackCount(math.min(self.max_count, self:GetStackCount() + (s and s.add_count or 1)))
	else
		local H = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_templar_assassin/templar_assassin_refraction_dmg.vpcf",
			PATTACH_CUSTOMORIGIN,
			u
		)
		ParticleManager:SetParticleControlEnt(H, 2, u, PATTACH_POINT_FOLLOW, "attach_attack1", vec3_zero, true)
		ParticleManager:SetParticleControlEnt(H, 3, u, PATTACH_POINT_FOLLOW, "attach_attack2", vec3_zero, true)
		self:AddParticle(H, false, false, -1, false, false)
	end
end
function G.prototype.OnRefresh(self, s)
	if IsServer() then
		self:SetStackCount(math.min(self.max_count, self:GetStackCount() + (s and s.add_count or 1)))
	end
end
function G.prototype.getIntrinsicModifier(self)
	if IsValid(self.intrinsicModifier) then
		return self.intrinsicModifier
	end
	local u = self:GetParent()
	self.intrinsicModifier = u:FindModifierByName("modifier_templar_assassin_talent")
	if IsValid(self.intrinsicModifier) then
		return self.intrinsicModifier
	end
	self:Destroy()
end
function G.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_DAMAGE_START] = { self:GetParent(), -1 },
	}
end
function G.prototype.OnCustomAttackStart(self, t)
	self:GetParent():EmitSound("Hero_TemplarAssassin.Refraction.Damage")
end
function G.prototype.OnDamageStart(self, t)
	if t.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then
		return
	end
	self:DecrementPsiBlade()
end
function G.prototype.DecrementPsiBlade(self, y)
	if y == nil then
		y = 1
	end
	self:DecrementStackCount(y)
	local I = self:getIntrinsicModifier()
	if IsValid(I) then
		I:OnDecrementPsiBlade(y)
	end
	if self:GetStackCount() == 0 then
		self:Destroy()
	end
end
function G.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS }
end
function G.prototype.EOM_GetModifierAttackDamageBonus(self)
	return self:GetStackCount() * self.attack
end
G = e(
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
	G
)
g.modifier_templar_assassin_psi_blade = G
g.modifier_templar_assassin_psi_shield = c()
local J = g.modifier_templar_assassin_psi_shield
J.name = "modifier_templar_assassin_psi_shield"
d(J, l)
function J.prototype.GetTexture(self)
	return "templar_assassin_refraction"
end
function J.prototype.GetAbilitySpecialValue(self)
	self.shield = self:GetAbilitySpecialValueFor("shield")
	self.max_count = self:GetAbilitySpecialValueFor("max_count")
		+ self:GetAbilityTalentValue("templar_assassin_talent_8", "psi_max_count")
end
function J.prototype.OnCreated(self, s)
	local u = self:GetParent()
	if IsServer() then
		self:getIntrinsicModifier()
		self:SetStackCount(math.min(self.max_count, self:GetStackCount() + (s and s.add_count or 1)))
		self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_ADJUST, function(K, s, L, M)
			if M ~= u then
				return
			end
			self:GetParent():EmitSound("Hero_TemplarAssassin.Refraction.Absorb")
			self:DecrementPsiShield()
		end)
	else
		local H = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_templar_assassin/templar_assassin_psi_shield.vpcf",
			PATTACH_CUSTOMORIGIN,
			u
		)
		ParticleManager:SetParticleControlEnt(
			H,
			1,
			u,
			PATTACH_ABSORIGIN_FOLLOW,
			nil,
			u:GetAbsOrigin() + Vector(0, 0, 32),
			true
		)
		self:AddParticle(H, false, false, -1, false, false)
	end
end
function J.prototype.OnRefresh(self, s)
	if IsServer() then
		self:SetStackCount(math.min(self.max_count, self:GetStackCount() + (s and s.add_count or 1)))
	end
end
function J.prototype.getIntrinsicModifier(self)
	if IsValid(self.intrinsicModifier) then
		return self.intrinsicModifier
	end
	local u = self:GetParent()
	self.intrinsicModifier = u:FindModifierByName("modifier_templar_assassin_talent")
	if IsValid(self.intrinsicModifier) then
		return self.intrinsicModifier
	end
	self:Destroy()
end
function J.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() } }
end
function J.prototype.DecrementPsiShield(self, y)
	if y == nil then
		y = 1
	end
	self:DecrementStackCount(y)
	local I = self:getIntrinsicModifier()
	if IsValid(I) then
		I:OnDecrementPsiShield(y, self.shield)
	end
	if self:GetStackCount() == 0 then
		self:Destroy()
	end
end
function J.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_PERMANENT }
end
function J.prototype.EOM_GetModifierShieldPermanent(self, s)
	return self:GetStackCount() * self.shield
end
J = e(
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
	J
)
g.modifier_templar_assassin_psi_shield = J
g.modifier_templar_assassin_talent_4_buff = c()
local N = g.modifier_templar_assassin_talent_4_buff
N.name = "modifier_templar_assassin_talent_4_buff"
d(N, l)
function N.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PROJECTILE_NAME, MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function N.prototype.GetModifierProjectileName(self)
	return Wearable:getReplaceParticle(
		self:GetParent(),
		"particles/units/heroes/hero_templar_assassin/templar_assassin_meld_attack.vpcf"
	)
end
function N.prototype.GetActivityTranslationModifiers(self)
	return "meld"
end
N = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
			}
		),
	},
	N
)
g.modifier_templar_assassin_talent_4_buff = N
g.modifier_templar_assassin_talent_6_debuff = c()
local O = g.modifier_templar_assassin_talent_6_debuff
O.name = "modifier_templar_assassin_talent_6_debuff"
d(O, l)
function O.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tick = 1
end
function O.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilityTalentValue("templar_assassin_talent_6", "damage")
end
function O.prototype.OnCreated(self, s)
	if IsServer() then
		self.count = math.floor(self:GetDuration() / self.tick)
		self.damage = self.damage / self.count
		self:StartIntervalThink(self.count)
	end
end
function O.prototype.OnIntervalThink(self)
	if self.count <= 0 then
		return
	end
	self.count = self.count - 1
	local u = self:GetParent()
	local P = self:GetCaster()
	local v = P:FindAbilityByName("templar_assassin_talent_6")
	DamageSystem:dealDamage({
		attacker = P,
		target = u,
		ability = v,
		damage = self.damage,
		damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
		damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
		damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
	})
end
O = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
				GetEffectName = "particles/econ/items/lanaya/lanaya_epit_trap/templar_assassin_epit_trap_slow.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
			}
		),
	},
	O
)
g.modifier_templar_assassin_talent_6_debuff = O
g.templar_assassin_ult = c()
local Q = g.templar_assassin_ult
Q.name = "templar_assassin_ult"
d(Q, o)
function Q.prototype.OnSpellStart(self)
	local P = self:GetCaster()
	local F = P:GetEnemy()
	if not IsInjurable(P, F) then
		return
	end
	local I = P:FindModifierByName("modifier_templar_assassin_talent")
	if not IsValid(I) then
		return
	end
	local y = self:GetSpecialValueFor("psi_count")
	I:AddPsiPower(y, y)
	local H = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_templar_assassin/templar_assassin_psi_shield_c.vpcf",
		PATTACH_CUSTOMORIGIN,
		P
	)
	P:StartGesture(ACT_DOTA_CAST_REFRACTION)
	P:EmitSound("Hero_TemplarAssassin.Refraction")
	ParticleManager:SetParticleControl(H, 1, P:GetAbsOrigin())
end
Q = e({ p(nil) }, Q)
g.templar_assassin_ult = Q
return g