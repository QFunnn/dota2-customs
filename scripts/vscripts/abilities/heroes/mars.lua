--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/mars"
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
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 8,
		["22"] = 9,
		["23"] = 10,
		["24"] = 9,
		["25"] = 8,
		["26"] = 7,
		["27"] = 8,
		["29"] = 8,
		["30"] = 14,
		["31"] = 22,
		["32"] = 14,
		["33"] = 22,
		["35"] = 22,
		["36"] = 38,
		["37"] = 14,
		["38"] = 40,
		["39"] = 42,
		["40"] = 43,
		["41"] = 44,
		["42"] = 46,
		["43"] = 47,
		["44"] = 49,
		["45"] = 51,
		["46"] = 52,
		["47"] = 53,
		["48"] = 40,
		["49"] = 55,
		["50"] = 56,
		["51"] = 57,
		["52"] = 58,
		["53"] = 59,
		["54"] = 60,
		["55"] = 61,
		["56"] = 62,
		["58"] = 55,
		["59"] = 65,
		["60"] = 66,
		["61"] = 67,
		["62"] = 68,
		["64"] = 71,
		["68"] = 65,
		["69"] = 77,
		["70"] = 78,
		["71"] = 77,
		["72"] = 82,
		["73"] = 83,
		["74"] = 83,
		["75"] = 83,
		["76"] = 86,
		["77"] = 86,
		["78"] = 86,
		["79"] = 83,
		["80"] = 83,
		["81"] = 83,
		["82"] = 82,
		["83"] = 90,
		["84"] = 91,
		["85"] = 92,
		["86"] = 93,
		["87"] = 94,
		["88"] = 95,
		["89"] = 96,
		["90"] = 97,
		["91"] = 98,
		["92"] = 99,
		["93"] = 100,
		["94"] = 101,
		["97"] = 90,
		["98"] = 105,
		["99"] = 107,
		["100"] = 108,
		["101"] = 109,
		["102"] = 110,
		["103"] = 111,
		["104"] = 112,
		["107"] = 115,
		["108"] = 116,
		["110"] = 105,
		["111"] = 120,
		["112"] = 121,
		["113"] = 122,
		["115"] = 120,
		["116"] = 125,
		["117"] = 126,
		["118"] = 127,
		["119"] = 128,
		["121"] = 125,
		["122"] = 131,
		["123"] = 132,
		["124"] = 133,
		["125"] = 134,
		["126"] = 135,
		["127"] = 135,
		["128"] = 135,
		["129"] = 135,
		["130"] = 136,
		["131"] = 137,
		["133"] = 135,
		["134"] = 135,
		["136"] = 131,
		["137"] = 142,
		["138"] = 143,
		["139"] = 144,
		["140"] = 145,
		["143"] = 148,
		["144"] = 149,
		["146"] = 151,
		["147"] = 152,
		["148"] = 154,
		["149"] = 155,
		["150"] = 155,
		["151"] = 155,
		["152"] = 155,
		["153"] = 155,
		["154"] = 155,
		["155"] = 156,
		["156"] = 156,
		["157"] = 156,
		["158"] = 156,
		["159"] = 156,
		["160"] = 157,
		["161"] = 158,
		["162"] = 159,
		["163"] = 159,
		["164"] = 159,
		["165"] = 159,
		["166"] = 159,
		["167"] = 159,
		["168"] = 160,
		["169"] = 161,
		["170"] = 162,
		["171"] = 163,
		["173"] = 165,
		["174"] = 165,
		["175"] = 165,
		["176"] = 165,
		["177"] = 165,
		["178"] = 165,
		["179"] = 165,
		["180"] = 165,
		["181"] = 165,
		["182"] = 174,
		["183"] = 175,
		["185"] = 177,
		["186"] = 142,
		["187"] = 179,
		["188"] = 180,
		["189"] = 179,
		["190"] = 22,
		["191"] = 14,
		["192"] = 14,
		["193"] = 14,
		["194"] = 14,
		["195"] = 14,
		["196"] = 14,
		["197"] = 14,
		["198"] = 14,
		["199"] = 22,
		["201"] = 22,
		["203"] = 188,
		["204"] = 189,
		["205"] = 188,
		["206"] = 189,
		["207"] = 190,
		["208"] = 191,
		["209"] = 192,
		["210"] = 193,
		["213"] = 196,
		["214"] = 199,
		["215"] = 200,
		["216"] = 201,
		["217"] = 201,
		["218"] = 201,
		["219"] = 202,
		["220"] = 203,
		["223"] = 206,
		["224"] = 207,
		["226"] = 209,
		["227"] = 210,
		["228"] = 210,
		["229"] = 210,
		["230"] = 210,
		["231"] = 210,
		["232"] = 210,
		["233"] = 213,
		["235"] = 201,
		["236"] = 201,
		["237"] = 190,
		["238"] = 219,
		["239"] = 220,
		["240"] = 221,
		["241"] = 222,
		["244"] = 225,
		["245"] = 226,
		["246"] = 229,
		["247"] = 219,
		["248"] = 234,
		["249"] = 234,
		["250"] = 234,
		["252"] = 235,
		["253"] = 236,
		["254"] = 237,
		["257"] = 240,
		["258"] = 241,
		["259"] = 242,
		["260"] = 243,
		["261"] = 244,
		["262"] = 245,
		["263"] = 246,
		["264"] = 247,
		["265"] = 248,
		["266"] = 249,
		["267"] = 249,
		["268"] = 249,
		["269"] = 249,
		["270"] = 249,
		["271"] = 249,
		["272"] = 249,
		["273"] = 249,
		["274"] = 257,
		["275"] = 258,
		["276"] = 259,
		["277"] = 260,
		["278"] = 262,
		["279"] = 263,
		["281"] = 267,
		["282"] = 270,
		["284"] = 249,
		["285"] = 249,
		["286"] = 234,
		["287"] = 275,
		["288"] = 276,
		["289"] = 275,
		["290"] = 189,
		["291"] = 188,
		["292"] = 189,
		["294"] = 189,
		["295"] = 279,
		["296"] = 287,
		["297"] = 279,
		["298"] = 287,
		["299"] = 293,
		["300"] = 294,
		["301"] = 296,
		["302"] = 293,
		["303"] = 298,
		["304"] = 299,
		["305"] = 299,
		["306"] = 299,
		["307"] = 299,
		["308"] = 298,
		["309"] = 304,
		["310"] = 305,
		["311"] = 306,
		["312"] = 307,
		["313"] = 308,
		["314"] = 309,
		["315"] = 310,
		["316"] = 311,
		["317"] = 312,
		["318"] = 313,
		["320"] = 315,
		["321"] = 316,
		["323"] = 304,
		["324"] = 319,
		["325"] = 320,
		["326"] = 321,
		["328"] = 319,
		["329"] = 324,
		["330"] = 325,
		["331"] = 324,
		["332"] = 327,
		["333"] = 328,
		["334"] = 327,
		["335"] = 287,
		["336"] = 279,
		["337"] = 279,
		["338"] = 279,
		["339"] = 279,
		["340"] = 279,
		["341"] = 279,
		["342"] = 279,
		["343"] = 279,
		["344"] = 287,
		["346"] = 287,
		["347"] = 331,
		["348"] = 340,
		["349"] = 331,
		["350"] = 340,
		["351"] = 340,
		["352"] = 331,
		["353"] = 331,
		["354"] = 331,
		["355"] = 331,
		["356"] = 331,
		["357"] = 331,
		["358"] = 331,
		["359"] = 331,
		["360"] = 331,
		["361"] = 340,
		["363"] = 340,
		["364"] = 342,
		["365"] = 350,
		["366"] = 342,
		["367"] = 350,
		["368"] = 352,
		["369"] = 353,
		["370"] = 354,
		["371"] = 355,
		["372"] = 356,
		["373"] = 357,
		["374"] = 358,
		["375"] = 359,
		["376"] = 360,
		["377"] = 361,
		["378"] = 361,
		["379"] = 361,
		["380"] = 361,
		["381"] = 361,
		["382"] = 362,
		["383"] = 363,
		["384"] = 363,
		["385"] = 363,
		["386"] = 363,
		["387"] = 363,
		["388"] = 363,
		["389"] = 363,
		["390"] = 363,
		["392"] = 352,
		["393"] = 366,
		["394"] = 367,
		["395"] = 368,
		["396"] = 369,
		["397"] = 370,
		["398"] = 371,
		["399"] = 372,
		["401"] = 366,
		["402"] = 350,
		["403"] = 342,
		["404"] = 342,
		["405"] = 342,
		["406"] = 342,
		["407"] = 342,
		["408"] = 342,
		["409"] = 342,
		["410"] = 342,
		["411"] = 350,
		["413"] = 350,
		["414"] = 376,
		["415"] = 384,
		["416"] = 376,
		["417"] = 384,
		["419"] = 384,
		["420"] = 395,
		["421"] = 376,
		["422"] = 396,
		["423"] = 397,
		["424"] = 399,
		["425"] = 400,
		["426"] = 401,
		["427"] = 403,
		["428"] = 396,
		["429"] = 405,
		["430"] = 406,
		["431"] = 407,
		["432"] = 408,
		["433"] = 409,
		["434"] = 410,
		["435"] = 411,
		["436"] = 412,
		["437"] = 413,
		["438"] = 414,
		["439"] = 415,
		["441"] = 416,
		["442"] = 416,
		["443"] = 417,
		["444"] = 418,
		["445"] = 419,
		["447"] = 421,
		["448"] = 421,
		["449"] = 421,
		["450"] = 421,
		["451"] = 421,
		["452"] = 416,
		["455"] = 423,
		["456"] = 425,
		["458"] = 405,
		["459"] = 428,
		["460"] = 429,
		["461"] = 430,
		["463"] = 428,
		["464"] = 433,
		["465"] = 434,
		["466"] = 435,
		["468"] = 433,
		["469"] = 438,
		["470"] = 439,
		["472"] = 440,
		["473"] = 440,
		["474"] = 441,
		["475"] = 442,
		["477"] = 440,
		["480"] = 446,
		["482"] = 438,
		["483"] = 449,
		["484"] = 450,
		["486"] = 451,
		["487"] = 451,
		["488"] = 452,
		["489"] = 453,
		["490"] = 453,
		["491"] = 453,
		["492"] = 453,
		["493"] = 453,
		["494"] = 453,
		["495"] = 453,
		["496"] = 453,
		["497"] = 459,
		["498"] = 460,
		["499"] = 461,
		["500"] = 462,
		["501"] = 462,
		["502"] = 462,
		["503"] = 462,
		["504"] = 462,
		["505"] = 462,
		["506"] = 463,
		["507"] = 464,
		["508"] = 451,
		["511"] = 449,
		["512"] = 467,
		["513"] = 468,
		["514"] = 467,
		["515"] = 472,
		["516"] = 473,
		["517"] = 474,
		["519"] = 472,
		["520"] = 477,
		["521"] = 478,
		["522"] = 479,
		["523"] = 480,
		["524"] = 481,
		["527"] = 484,
		["528"] = 485,
		["530"] = 486,
		["531"] = 486,
		["532"] = 487,
		["533"] = 488,
		["534"] = 489,
		["535"] = 489,
		["536"] = 489,
		["537"] = 489,
		["538"] = 489,
		["539"] = 490,
		["540"] = 490,
		["541"] = 490,
		["542"] = 490,
		["543"] = 490,
		["544"] = 490,
		["545"] = 486,
		["548"] = 492,
		["549"] = 493,
		["550"] = 493,
		["551"] = 493,
		["552"] = 493,
		["553"] = 493,
		["554"] = 493,
		["555"] = 493,
		["556"] = 493,
		["558"] = 498,
		["559"] = 498,
		["560"] = 498,
		["561"] = 498,
		["562"] = 498,
		["563"] = 498,
		["565"] = 477,
		["566"] = 501,
		["567"] = 502,
		["568"] = 501,
		["569"] = 384,
		["570"] = 376,
		["571"] = 376,
		["572"] = 376,
		["573"] = 376,
		["574"] = 376,
		["575"] = 376,
		["576"] = 376,
		["577"] = 376,
		["578"] = 384,
		["580"] = 384,
		["581"] = 507,
		["582"] = 517,
		["583"] = 507,
		["584"] = 517,
		["585"] = 517,
		["586"] = 507,
		["587"] = 507,
		["588"] = 507,
		["589"] = 507,
		["590"] = 507,
		["591"] = 507,
		["592"] = 507,
		["593"] = 507,
		["594"] = 507,
		["595"] = 507,
		["596"] = 517,
		["598"] = 517,
		["599"] = 518,
		["600"] = 526,
		["601"] = 518,
		["602"] = 526,
		["603"] = 527,
		["604"] = 528,
		["605"] = 528,
		["606"] = 528,
		["607"] = 528,
		["608"] = 528,
		["609"] = 528,
		["610"] = 528,
		["611"] = 527,
		["612"] = 526,
		["613"] = 518,
		["614"] = 518,
		["615"] = 518,
		["616"] = 518,
		["617"] = 518,
		["618"] = 518,
		["619"] = 518,
		["620"] = 518,
		["621"] = 526,
		["623"] = 526,
		["624"] = 540,
		["625"] = 541,
		["626"] = 540,
		["627"] = 541,
		["628"] = 542,
		["629"] = 543,
		["630"] = 542,
		["631"] = 541,
		["632"] = 540,
		["633"] = 541,
		["635"] = 541,
		["636"] = 546,
		["637"] = 554,
		["638"] = 546,
		["639"] = 554,
		["640"] = 556,
		["641"] = 557,
		["642"] = 556,
		["643"] = 559,
		["644"] = 560,
		["645"] = 559,
		["646"] = 564,
		["647"] = 565,
		["648"] = 566,
		["651"] = 569,
		["652"] = 570,
		["653"] = 570,
		["654"] = 570,
		["655"] = 570,
		["656"] = 570,
		["657"] = 570,
		["658"] = 570,
		["659"] = 571,
		["662"] = 564,
		["663"] = 554,
		["664"] = 546,
		["665"] = 546,
		["666"] = 546,
		["667"] = 546,
		["668"] = 546,
		["669"] = 546,
		["670"] = 546,
		["671"] = 546,
		["672"] = 554,
		["674"] = 554,
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
g.mars_talent = c()
local q = g.mars_talent
q.name = "mars_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_mars_talent"
end
q = e({ j(nil) }, q)
g.mars_talent = q
g.modifier_mars_talent = c()
local r = g.modifier_mars_talent
r.name = "modifier_mars_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.s_timer = 0
end
function r.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count") - self:GetAbilityTalentValue("mars_talent_5", "count_reduce")
	self.damage = self:GetAbilitySpecialValueFor("damage") + self:GetAbilityTalentValue("mars_talent_7", "damage")
	self.shield_damage = self:GetAbilitySpecialValueFor("shield_damage")
	self.c_crit = self:GetAbilitySpecialValueFor("c_crit")
	self.custom_mana = self:GetAbilitySpecialValueFor("custom_mana")
	self.tl1_attack_damage = self:GetAbilityTalentValue("mars_talent_1", "attack_damage")
	self.s_threshold = self:GetAbilityTalentValue("mars_shard", "threshold")
	self.s_count = self:GetAbilityTalentValue("mars_shard", "count")
	self.s_cooldown = self:GetAbilityTalentValue("mars_shard", "cooldown")
end
function r.prototype.OnCreated(self, s)
	if IsServer() then
		self.s_enable = false
		self.record = 0
		self.s_record = 0
		self.sectShieldExp = 0
		self.tl5_enable = self:HasTalent("mars_talent_5")
		self:GetParent():AddActivityModifier("attack_medium_range")
	end
end
function r.prototype.OnThink(self, t)
	if t == "mars_shard" then
		if self.s_timer < self.s_cooldown then
			self.s_timer = self.s_timer + 0.05
		else
			self:CheckEffect()
		end
		return
	end
end
function r.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_COUNTER_CRITICAL_CHANCE] = self.c_crit }
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_GAINED] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ADJUST] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 },
	}
end
function r.prototype.OnBattleStartBefore(self, s)
	self.s_record = 0
	self.record = 0
	self.s_enable = self.s_threshold > 0
	self.tl5_enable = self:HasTalent("mars_talent_5")
	self.sectShieldExp = 0
	self:StartThink(0.05, "mars_shard")
	local u = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
	if u then
		local v = u:getAbilityData()
		if v.sect_shield then
			self.sectShieldExp = v.sect_shield.exp
		end
	end
end
function r.prototype.OnShieldGained(self, s)
	local w = self:GetParent()
	if not w:PassivesDisabled() then
		self.record = self.record + 1
		if self.record == self.count then
			self.record = 0
			self:GodsRebuke()
		end
	end
	if not (w:HasModifier("modifier_mars_ult_particle") or w:HasModifier("modifier_mars_ult_cast")) then
		RestoreCustomMana(w, self.custom_mana)
	end
end
function r.prototype.OnAdjust(self, s)
	if self.s_threshold > 0 and s.adjust_damage > 0 then
		self.s_record = self.s_record + s.adjust_damage
	end
end
function r.prototype.OnBattleEnd(self, s)
	local x = self.parent:GetPlayerOwnerID()
	if s.illusionPlayerID ~= x and (s.losePlayerID == x or s.winPlayerID == x) then
		self:StartThink(-1, "mars_shard")
	end
end
function r.prototype.CheckEffect(self)
	if self.s_record >= self.s_threshold then
		self.s_timer = 0
		self.s_record = 0
		ForWithInterval(0.25, self.s_count, function()
			if IsValid(self) then
				self:GodsRebuke()
			end
		end)
	end
end
function r.prototype.GodsRebuke(self)
	local w = self:GetParent()
	local y = w:GetEnemy()
	if not IsInjurable(w, y) then
		return
	end
	if not w:HasModifier("modifier_mars_ult_cast") then
		w:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 2)
	end
	w:EmitSound("Hero_Mars.Shield.Cast")
	y:EmitSound("Hero_Mars.Shield.Crit")
	local z = ParticleManager:CreateParticle(
		"particles/econ/items/mars/mars_fall20_immortal_shield/mars_fall20_immortal_shield_bash.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControlTransformForward(
		z,
		0,
		w:GetAbsOrigin(),
		(y:GetAbsOrigin() - w:GetAbsOrigin()):Normalized()
	)
	ParticleManager:SetParticleControl(z, 1, Vector(500, 500, 500))
	ParticleManager:ReleaseParticleIndex(z)
	local A = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_mars/mars_shield_bash_crit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		y,
		w
	)
	ParticleManager:SetParticleControlTransform(z, 1, y:GetAbsOrigin(), VectorAngles(y:GetForwardVector() * -1))
	ParticleManager:ReleaseParticleIndex(A)
	local B = self.damage + self.sectShieldExp * self.shield_damage
	if self.tl1_attack_damage > 0 then
		B = B + GetAttackDamage(w) * self.tl1_attack_damage * 0.01
	end
	local C = {
		attacker = w,
		target = y,
		ability = self:GetAbility(),
		damage = B,
		damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL,
		damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
		damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
	}
	if self.tl5_enable then
		C.is_crit = true
	end
	DamageSystem:dealDamage(C)
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_PERMANENT }
end
r = e(
	{
		m(
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
	r
)
g.modifier_mars_talent = r
g.mars_ult = c()
local D = g.mars_ult
D.name = "mars_ult"
d(D, o)
function D.prototype.OnSpellStart(self)
	local E = self:GetCaster()
	local y = E:GetEnemy()
	if not IsInjurable(E, y) then
		return
	end
	E:AddNewModifier(E, self, "modifier_mars_ult_cast", { duration = 0.6 })
	E:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 2)
	local F = false
	self:GameTimer(0.2, function()
		if not IsInjurable(E, y) then
			E:RemoveModifierByName("modifier_mars_ult_particle")
			return
		end
		if F or E:HasModifier("modifier_mars_ult_buff") then
			self:Effect()
		else
			F = true
			E:AddNewModifier(
				E,
				self,
				"modifier_mars_ult_particle",
				{ duration = self:GetSpecialValueFor("duration") + 0.5 }
			)
			return 0.5
		end
	end)
end
function D.prototype.Effect(self)
	local E = self:GetCaster()
	local y = E:GetEnemy()
	if not IsInjurable(E, y) then
		return
	end
	local G = self:GetSpecialValueFor("duration")
	E:AddNewModifier(E, self, "modifier_mars_ult_buff", { duration = G })
	E:AddNewModifier(E, self, "modifier_mars_ult_particle", { duration = G })
end
function D.prototype.Spear(self, H)
	if H == nil then
		H = false
	end
	local E = self:GetCaster()
	local y = E:GetEnemy()
	if not IsInjurable(E, y) then
		return
	end
	E:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_5, 2)
	local I = y:GetAbsOrigin() - E:GetAbsOrigin()
	local J = I:Length2D() + 100
	I.z = 0
	I = I:Normalized()
	E:EmitSound("Hero_Mars.Spear")
	local K = self:GetSpecialValueFor("lance_damage") * (1 + self:GetTalentValue("mars_talent_2", "bonus_pct") * 0.01)
	local L = self:GetSpecialValueFor("stun")
	local M = E:FindAbilityByName("mars_ult_ui")
	Projectile:CreateLinearProjectile({
		EffectName = "particles/units/heroes/hero_mars/mars_spear.vpcf",
		hCaster = E,
		vSpawnOrigin = E:GetAbsOrigin(),
		vDirection = I,
		flDistance = J,
		flRadius = 150,
		iMoveSpeed = 1800,
		OnProjectileHit = function(N, O, P)
			if IsInjurable(E, N) and IsValid(self) then
				N:EmitSound("Hero_Mars.Spear.Root")
				E:DealDamage(N, M, K, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
				if self:HasTalent("mars_talent_3") then
					DamageSystem:performAttack(E, N, { ability = M })
				end
				N:AddNewModifier(E, self, "modifier_mars_ult_lance", { duration = L })
				AddStun(E, N, M, L)
			end
		end,
	})
end
function D.prototype.GetIntrinsicModifierName(self)
	return "modifier_mars_ult"
end
D = e({ p(nil) }, D)
g.mars_ult = D
g.modifier_mars_ult = c()
local Q = g.modifier_mars_ult
Q.name = "modifier_mars_ult"
d(Q, l)
function Q.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.tl8_chance = self:GetAbilityTalentValue("mars_talent_8", "chance")
end
function Q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_GAINED] = { self:GetParent() },
	}
end
function Q.prototype.OnBattleStartBefore(self, s)
	local w = self:GetParent()
	local y = w:GetEnemy()
	if IsInjurable(w, y) then
		local R = y:GetAbsOrigin() - w:GetAbsOrigin()
		local S = R:Length2D() / 2
		R.z = 0
		R = R:Normalized()
		self.battleDir = R
		self.centerPos = w:GetAbsOrigin() + R * S
	else
		self.battleDir = w:GetForwardVector()
		self.centerPos = w:GetAbsOrigin() + self.battleDir * 300
	end
end
function Q.prototype.OnShieldGained(self, s)
	if
		self.tl8_chance > 0
		and not self:GetParent():HasModifier("modifier_mars_ult_buff")
		and self:PRD(self.tl8_chance, "tl8_chance")
	then
		self:GetAbility():Spear(true)
	end
end
function Q.prototype.GetBattleCenterPos(self)
	return self.centerPos
end
function Q.prototype.GetBattleDirection(self)
	return self.battleDir
end
Q = e(
	{
		m(
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
	Q
)
g.modifier_mars_ult = Q
g.modifier_mars_ult_cast = c()
local T = g.modifier_mars_ult_cast
T.name = "modifier_mars_ult_cast"
d(T, l)
T = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				IsIndependent = true,
			}
		),
	},
	T
)
g.modifier_mars_ult_cast = T
g.modifier_mars_ult_particle = c()
local U = g.modifier_mars_ult_particle
U.name = "modifier_mars_ult_particle"
d(U, l)
function U.prototype.OnCreated(self, s)
	if IsServer() then
		local w = self:GetParent()
		local V = w:FindModifierByName("modifier_mars_ult")
		self.centerPos = V:GetBattleCenterPos()
		w:EmitSound("Hero_Mars.ArenaOfBlood.Start", self.centerPos)
		w:EmitSound("Hero_Mars.ArenaOfBlood", self.centerPos)
		local W = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_mars/mars_arena_of_blood.vpcf",
			PATTACH_CUSTOMORIGIN,
			w
		)
		ParticleManager:SetParticleControl(W, 0, self.centerPos)
		ParticleManager:SetParticleControl(W, 1, Vector(700, 0, 0))
		ParticleManager:SetParticleControl(W, 2, self.centerPos)
		self:AddParticle(W, false, false, -1, false, false)
	end
end
function U.prototype.OnDestroy(self)
	if IsServer() then
		local w = self:GetParent()
		w:StopSound("Hero_Mars.ArenaOfBlood.Start")
		w:StopSound("Hero_Mars.ArenaOfBlood")
		w:EmitSound("Hero_Mars.ArenaOfBlood.End", self.centerPos)
		w:EmitSound("Hero_Mars.ArenaOfBlood.Crumble", self.centerPos)
	end
end
U = e(
	{
		m(
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
	U
)
g.modifier_mars_ult_particle = U
g.modifier_mars_ult_buff = c()
local X = g.modifier_mars_ult_buff
X.name = "modifier_mars_ult_buff"
d(X, l)
function X.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.attackPointTime = 0.3
end
function X.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.damage = self:GetAbilitySpecialValueFor("damage")
		* (1 + self:GetAbilityTalentValue("mars_talent_2", "bonus_pct") * 0.01)
	self.tick = self:GetAbilitySpecialValueFor("tick")
	self.shield = self:GetAbilitySpecialValueFor("shield")
		* (1 + self:GetAbilityTalentValue("mars_talent_2", "bonus_pct") * 0.01)
	self.tl8_enable = self:HasTalent("mars_talent_8")
end
function X.prototype.OnCreated(self, s)
	if IsServer() then
		self:IncrementStackCount()
		self.soldiers = {}
		local V = self:GetParent():FindModifierByName("modifier_mars_ult")
		self.centerPos = V:GetBattleCenterPos()
		self.soldierPos = {}
		local R = V:GetBattleDirection()
		local Y = 700
		local Z = self.centerPos + R * Y
		local _ = 360 / 14
		do
			local a0 = 0
			while a0 < 3 do
				local a1 = _ * math.floor((a0 + 1) / 2)
				if a0 % 2 == 0 then
					a1 = -a1
				end
				self.soldierPos[a0 + 1] = RotatePosition(self.centerPos, QAngle(0, a1, 0), Z)
				a0 = a0 + 1
			end
		end
		self:createSolder()
		self:StartIntervalThink(self.tick)
	end
end
function X.prototype.OnRefresh(self, s)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function X.prototype.OnIntervalThink(self)
	if IsServer() then
		self:SoldierAttack()
	end
end
function X.prototype.OnDestroy(self)
	if IsServer() then
		do
			local a0 = 0
			while a0 < #self.soldiers do
				if IsValid(self.soldiers[a0 + 1]) then
					self.soldiers[a0 + 1]:ForceKill(false)
				end
				a0 = a0 + 1
			end
		end
		self:GetParent():RemoveModifierByName("modifier_mars_ult_particle")
	end
end
function X.prototype.createSolder(self)
	local w = self:GetParent()
	do
		local a2 = 0
		while a2 < #self.soldierPos do
			local a3 = self.soldierPos[a2 + 1]
			local a4 = CreateUnitFromTable(
				{ MapUnitName = "npc_mars_soldier", StatusHealth = 100, teamnumber = w:GetTeam() },
				a3
			)
			local a5 = self.centerPos - a3
			a5.z = 0
			a5 = a5:Normalized()
			a4:AddNewModifier(w, self:GetAbility(), "modifier_mars_ult_soldier", nil)
			a4:SetForwardVector(a5)
			self.soldiers[a2 + 1] = a4
			a2 = a2 + 1
		end
	end
end
function X.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_GAINED] = { self:GetParent() } }
end
function X.prototype.OnShieldGained(self, s)
	if self:PRD(self.chance) then
		self:GetAbility():Spear(self.tl8_enable)
	end
end
function X.prototype.SoldierAttack(self)
	local w = self:GetParent()
	local y = w:GetEnemy()
	if not IsInjurable(w, y) then
		self:Destroy()
		return
	end
	y:EmitSound("Hero_Mars.Phalanx.Attack")
	y:EmitSound("Hero_Mars.Phalanx.Target")
	do
		local a0 = 0
		while a0 < #self.soldiers do
			self.soldiers[a0 + 1]:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 2)
			local W = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_mars/mars_arena_of_blood_spear.vpcf",
				PATTACH_ABSORIGIN,
				self.soldiers[a0 + 1]
			)
			ParticleManager:SetParticleControlForward(W, 0, self.soldiers[a0 + 1]:GetForwardVector())
			ParticleManager:SetParticleControlTransform(
				W,
				0,
				self.soldiers[a0 + 1]:GetAbsOrigin(),
				VectorAngles(self.soldiers[a0 + 1]:GetForwardVector())
			)
			a0 = a0 + 1
		end
	end
	if self:HasTalent("mars_talent_6") then
		DamageSystem:performAttack(w, y, { damage = self.damage, ability = self:GetAbility() })
	else
		w:DealDamage(y, self:GetAbility(), self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
	end
end
function X.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_PERMANENT] = self.shield }
end
X = e(
	{
		m(
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
	X
)
g.modifier_mars_ult_buff = X
g.modifier_mars_ult_lance = c()
local a6 = g.modifier_mars_ult_lance
a6.name = "modifier_mars_ult_lance"
d(a6, l)
a6 = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetEffectName = "particles/units/heroes/hero_mars/mars_spear_impact_debuff.vpcf",
				GetEffectAttachType = PATTACH_OVERHEAD_FOLLOW,
			}
		),
	},
	a6
)
g.modifier_mars_ult_lance = a6
g.modifier_mars_ult_soldier = c()
local a7 = g.modifier_mars_ult_soldier
a7.name = "modifier_mars_ult_soldier"
d(a7, l)
function a7.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_TEAM_SELECT] = true,
		[MODIFIER_STATE_STUNNED] = true,
	}
end
a7 = e(
	{
		m(
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
	a7
)
g.modifier_mars_ult_soldier = a7
g.mars_talent_4 = c()
local a8 = g.mars_talent_4
a8.name = "mars_talent_4"
d(a8, i)
function a8.prototype.GetIntrinsicModifierName(self)
	return "modifier_mars_talent_4"
end
a8 = e({ j(nil) }, a8)
g.mars_talent_4 = a8
g.modifier_mars_talent_4 = c()
local a9 = g.modifier_mars_talent_4
a9.name = "modifier_mars_talent_4"
d(a9, l)
function a9.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
end
function a9.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_STACK_BONUS_PERCENTAGE_BEFORE_EVENT }
end
function a9.prototype.EOM_GetModifierShieldStackBonusPercentBeforeEvent(self, s)
	if s.count > 0 then
		if s.flag and bit.band(s.flag, ShieldFlags.FLAG_NO_EXTRA) == ShieldFlags.FLAG_NO_EXTRA then
			return
		end
		if self:PRD(self.chance, "tl4_chance") then
			AddShield(self:GetCaster(), s.count, "mars_talent_4", "Ability", ShieldFlags.FLAG_IGNORE_BONUS)
			return -1000
		end
	end
end
a9 = e(
	{
		m(
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
	a9
)
g.modifier_mars_talent_4 = a9
return g