--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/zen"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayConcat
local g = b.__TS__ArraySplice
local h = b.__TS__ArrayForEach
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 1,
		["12"] = 1,
		["13"] = 1,
		["14"] = 2,
		["15"] = 2,
		["16"] = 2,
		["17"] = 3,
		["18"] = 3,
		["19"] = 3,
		["21"] = 8,
		["22"] = 9,
		["23"] = 8,
		["24"] = 9,
		["25"] = 10,
		["26"] = 11,
		["27"] = 10,
		["28"] = 9,
		["29"] = 8,
		["30"] = 9,
		["32"] = 9,
		["33"] = 15,
		["34"] = 23,
		["35"] = 15,
		["36"] = 23,
		["38"] = 23,
		["39"] = 31,
		["40"] = 69,
		["41"] = 70,
		["42"] = 72,
		["43"] = 15,
		["44"] = 73,
		["45"] = 74,
		["46"] = 75,
		["47"] = 76,
		["48"] = 77,
		["49"] = 78,
		["50"] = 80,
		["51"] = 81,
		["52"] = 82,
		["53"] = 83,
		["54"] = 85,
		["55"] = 88,
		["56"] = 90,
		["57"] = 91,
		["58"] = 97,
		["59"] = 98,
		["60"] = 101,
		["61"] = 102,
		["62"] = 105,
		["63"] = 106,
		["64"] = 107,
		["65"] = 110,
		["66"] = 111,
		["67"] = 114,
		["68"] = 117,
		["69"] = 118,
		["70"] = 120,
		["71"] = 73,
		["72"] = 122,
		["73"] = 123,
		["74"] = 124,
		["75"] = 125,
		["76"] = 126,
		["77"] = 127,
		["78"] = 128,
		["81"] = 122,
		["82"] = 132,
		["83"] = 133,
		["84"] = 134,
		["85"] = 135,
		["87"] = 137,
		["89"] = 132,
		["90"] = 140,
		["91"] = 141,
		["92"] = 141,
		["93"] = 143,
		["94"] = 143,
		["95"] = 143,
		["96"] = 141,
		["97"] = 141,
		["98"] = 140,
		["99"] = 146,
		["100"] = 147,
		["101"] = 148,
		["102"] = 149,
		["103"] = 150,
		["104"] = 151,
		["105"] = 152,
		["106"] = 153,
		["107"] = 154,
		["108"] = 155,
		["110"] = 158,
		["111"] = 159,
		["113"] = 162,
		["114"] = 163,
		["115"] = 164,
		["116"] = 165,
		["117"] = 166,
		["119"] = 168,
		["121"] = 171,
		["122"] = 172,
		["123"] = 172,
		["124"] = 172,
		["125"] = 173,
		["126"] = 174,
		["127"] = 175,
		["128"] = 176,
		["129"] = 177,
		["130"] = 178,
		["134"] = 172,
		["135"] = 172,
		["137"] = 184,
		["138"] = 146,
		["139"] = 186,
		["140"] = 187,
		["141"] = 188,
		["142"] = 189,
		["143"] = 190,
		["144"] = 191,
		["145"] = 192,
		["146"] = 193,
		["148"] = 186,
		["149"] = 196,
		["150"] = 197,
		["151"] = 198,
		["152"] = 196,
		["153"] = 200,
		["154"] = 201,
		["155"] = 202,
		["156"] = 203,
		["157"] = 204,
		["158"] = 205,
		["159"] = 206,
		["160"] = 200,
		["161"] = 209,
		["162"] = 210,
		["163"] = 211,
		["164"] = 212,
		["165"] = 212,
		["166"] = 212,
		["167"] = 212,
		["168"] = 212,
		["169"] = 212,
		["170"] = 218,
		["171"] = 219,
		["172"] = 220,
		["173"] = 220,
		["174"] = 220,
		["175"] = 220,
		["176"] = 220,
		["177"] = 220,
		["178"] = 220,
		["179"] = 221,
		["180"] = 221,
		["181"] = 221,
		["182"] = 221,
		["183"] = 221,
		["184"] = 222,
		["185"] = 222,
		["186"] = 222,
		["187"] = 222,
		["188"] = 222,
		["189"] = 222,
		["190"] = 222,
		["191"] = 222,
		["192"] = 222,
		["193"] = 223,
		["194"] = 224,
		["195"] = 224,
		["196"] = 224,
		["197"] = 224,
		["198"] = 224,
		["200"] = 226,
		["201"] = 212,
		["202"] = 212,
		["203"] = 212,
		["204"] = 230,
		["205"] = 231,
		["206"] = 209,
		["207"] = 233,
		["208"] = 234,
		["209"] = 235,
		["210"] = 236,
		["211"] = 237,
		["214"] = 240,
		["215"] = 241,
		["218"] = 244,
		["219"] = 246,
		["220"] = 247,
		["221"] = 248,
		["222"] = 249,
		["223"] = 249,
		["224"] = 249,
		["225"] = 249,
		["226"] = 250,
		["227"] = 251,
		["228"] = 252,
		["229"] = 253,
		["230"] = 254,
		["231"] = 256,
		["232"] = 257,
		["235"] = 260,
		["236"] = 261,
		["237"] = 262,
		["239"] = 264,
		["240"] = 265,
		["243"] = 268,
		["244"] = 269,
		["246"] = 233,
		["247"] = 272,
		["248"] = 284,
		["249"] = 285,
		["250"] = 286,
		["252"] = 272,
		["253"] = 289,
		["254"] = 290,
		["255"] = 291,
		["257"] = 289,
		["258"] = 294,
		["259"] = 294,
		["260"] = 294,
		["262"] = 295,
		["263"] = 295,
		["264"] = 295,
		["265"] = 295,
		["268"] = 298,
		["269"] = 299,
		["271"] = 301,
		["274"] = 304,
		["275"] = 306,
		["276"] = 307,
		["277"] = 308,
		["279"] = 310,
		["280"] = 310,
		["281"] = 310,
		["282"] = 310,
		["283"] = 310,
		["284"] = 310,
		["285"] = 316,
		["286"] = 317,
		["287"] = 318,
		["289"] = 310,
		["290"] = 324,
		["291"] = 325,
		["292"] = 326,
		["293"] = 326,
		["294"] = 326,
		["295"] = 326,
		["296"] = 326,
		["298"] = 310,
		["299"] = 310,
		["300"] = 330,
		["301"] = 331,
		["302"] = 332,
		["303"] = 333,
		["304"] = 334,
		["305"] = 335,
		["306"] = 336,
		["307"] = 337,
		["311"] = 341,
		["312"] = 342,
		["313"] = 343,
		["314"] = 344,
		["315"] = 345,
		["316"] = 345,
		["317"] = 345,
		["318"] = 345,
		["319"] = 346,
		["320"] = 346,
		["321"] = 346,
		["322"] = 346,
		["323"] = 347,
		["324"] = 347,
		["325"] = 347,
		["326"] = 347,
		["329"] = 294,
		["330"] = 352,
		["331"] = 353,
		["332"] = 353,
		["333"] = 353,
		["334"] = 353,
		["335"] = 353,
		["336"] = 353,
		["337"] = 354,
		["338"] = 355,
		["339"] = 356,
		["340"] = 358,
		["341"] = 360,
		["343"] = 363,
		["344"] = 366,
		["346"] = 352,
		["347"] = 369,
		["348"] = 371,
		["349"] = 372,
		["350"] = 373,
		["351"] = 374,
		["352"] = 374,
		["353"] = 374,
		["354"] = 375,
		["355"] = 376,
		["356"] = 377,
		["357"] = 378,
		["358"] = 379,
		["359"] = 380,
		["360"] = 381,
		["361"] = 382,
		["362"] = 383,
		["363"] = 383,
		["364"] = 383,
		["365"] = 383,
		["366"] = 383,
		["367"] = 384,
		["368"] = 374,
		["369"] = 374,
		["370"] = 386,
		["371"] = 387,
		["372"] = 388,
		["373"] = 389,
		["374"] = 369,
		["375"] = 391,
		["376"] = 392,
		["377"] = 391,
		["378"] = 394,
		["379"] = 395,
		["380"] = 394,
		["381"] = 399,
		["382"] = 400,
		["383"] = 399,
		["384"] = 406,
		["385"] = 407,
		["386"] = 410,
		["387"] = 411,
		["388"] = 414,
		["389"] = 415,
		["390"] = 416,
		["391"] = 417,
		["392"] = 418,
		["393"] = 419,
		["394"] = 420,
		["396"] = 422,
		["397"] = 423,
		["400"] = 426,
		["401"] = 427,
		["403"] = 429,
		["404"] = 430,
		["406"] = 432,
		["407"] = 433,
		["409"] = 435,
		["410"] = 406,
		["411"] = 438,
		["412"] = 439,
		["413"] = 440,
		["415"] = 438,
		["416"] = 451,
		["417"] = 452,
		["418"] = 451,
		["419"] = 23,
		["420"] = 15,
		["421"] = 15,
		["422"] = 15,
		["423"] = 15,
		["424"] = 15,
		["425"] = 15,
		["426"] = 15,
		["427"] = 15,
		["428"] = 23,
		["430"] = 23,
		["431"] = 455,
		["432"] = 463,
		["433"] = 455,
		["434"] = 463,
		["435"] = 466,
		["436"] = 466,
		["437"] = 463,
		["438"] = 455,
		["439"] = 455,
		["440"] = 455,
		["441"] = 455,
		["442"] = 455,
		["443"] = 455,
		["444"] = 455,
		["445"] = 455,
		["446"] = 463,
		["448"] = 463,
		["450"] = 502,
		["451"] = 503,
		["452"] = 502,
		["453"] = 503,
		["454"] = 504,
		["455"] = 505,
		["456"] = 512,
		["457"] = 513,
		["458"] = 504,
		["459"] = 503,
		["460"] = 502,
		["461"] = 503,
		["463"] = 503,
		["464"] = 521,
		["465"] = 530,
		["466"] = 521,
		["467"] = 530,
		["468"] = 542,
		["469"] = 543,
		["470"] = 544,
		["471"] = 545,
		["472"] = 546,
		["473"] = 549,
		["474"] = 542,
		["475"] = 552,
		["476"] = 553,
		["477"] = 554,
		["478"] = 555,
		["479"] = 556,
		["480"] = 557,
		["481"] = 558,
		["482"] = 559,
		["483"] = 561,
		["484"] = 562,
		["486"] = 565,
		["487"] = 567,
		["488"] = 568,
		["489"] = 568,
		["490"] = 568,
		["491"] = 568,
		["492"] = 568,
		["493"] = 568,
		["494"] = 574,
		["495"] = 575,
		["496"] = 576,
		["497"] = 576,
		["498"] = 576,
		["499"] = 576,
		["500"] = 576,
		["501"] = 576,
		["502"] = 576,
		["503"] = 577,
		["504"] = 577,
		["505"] = 577,
		["506"] = 577,
		["507"] = 577,
		["508"] = 578,
		["509"] = 578,
		["510"] = 578,
		["511"] = 578,
		["512"] = 578,
		["513"] = 578,
		["514"] = 578,
		["515"] = 578,
		["516"] = 578,
		["517"] = 579,
		["518"] = 568,
		["519"] = 568,
		["520"] = 568,
		["521"] = 568,
		["522"] = 583,
		["523"] = 583,
		["524"] = 583,
		["525"] = 583,
		["526"] = 583,
		["527"] = 583,
		["528"] = 583,
		["529"] = 587,
		["530"] = 587,
		["531"] = 587,
		["532"] = 588,
		["535"] = 589,
		["536"] = 590,
		["537"] = 591,
		["540"] = 594,
		["541"] = 595,
		["542"] = 596,
		["543"] = 596,
		["544"] = 596,
		["545"] = 596,
		["546"] = 596,
		["547"] = 596,
		["548"] = 602,
		["549"] = 603,
		["550"] = 604,
		["551"] = 604,
		["552"] = 604,
		["553"] = 604,
		["554"] = 604,
		["555"] = 604,
		["556"] = 604,
		["557"] = 605,
		["558"] = 606,
		["559"] = 606,
		["560"] = 606,
		["561"] = 606,
		["562"] = 606,
		["563"] = 606,
		["564"] = 606,
		["565"] = 606,
		["566"] = 606,
		["567"] = 607,
		["568"] = 608,
		["569"] = 608,
		["570"] = 608,
		["571"] = 608,
		["572"] = 608,
		["574"] = 610,
		["575"] = 596,
		["576"] = 596,
		["577"] = 596,
		["578"] = 587,
		["579"] = 587,
		["580"] = 615,
		["581"] = 616,
		["582"] = 617,
		["584"] = 619,
		["587"] = 552,
		["588"] = 623,
		["589"] = 624,
		["590"] = 625,
		["591"] = 626,
		["593"] = 628,
		["594"] = 629,
		["596"] = 631,
		["597"] = 632,
		["600"] = 623,
		["601"] = 636,
		["602"] = 637,
		["603"] = 638,
		["604"] = 639,
		["607"] = 642,
		["608"] = 636,
		["609"] = 644,
		["610"] = 645,
		["611"] = 646,
		["614"] = 651,
		["615"] = 652,
		["616"] = 653,
		["617"] = 654,
		["618"] = 655,
		["619"] = 656,
		["620"] = 657,
		["621"] = 658,
		["622"] = 660,
		["623"] = 661,
		["627"] = 665,
		["628"] = 666,
		["629"] = 666,
		["630"] = 666,
		["631"] = 666,
		["632"] = 666,
		["633"] = 667,
		["634"] = 668,
		["635"] = 669,
		["637"] = 644,
		["638"] = 672,
		["639"] = 673,
		["640"] = 674,
		["641"] = 674,
		["642"] = 673,
		["643"] = 672,
		["644"] = 677,
		["645"] = 678,
		["646"] = 679,
		["648"] = 677,
		["649"] = 530,
		["650"] = 521,
		["651"] = 521,
		["652"] = 521,
		["653"] = 521,
		["654"] = 521,
		["655"] = 521,
		["656"] = 521,
		["657"] = 521,
		["658"] = 521,
		["659"] = 530,
		["661"] = 530,
		["662"] = 686,
		["663"] = 687,
		["664"] = 686,
		["665"] = 687,
		["666"] = 688,
		["667"] = 689,
		["668"] = 688,
		["669"] = 687,
		["670"] = 686,
		["671"] = 687,
		["673"] = 687,
		["674"] = 693,
		["675"] = 701,
		["676"] = 693,
		["677"] = 701,
		["678"] = 703,
		["679"] = 704,
		["680"] = 703,
		["681"] = 706,
		["682"] = 707,
		["683"] = 706,
		["684"] = 701,
		["685"] = 693,
		["686"] = 693,
		["687"] = 693,
		["688"] = 693,
		["689"] = 693,
		["690"] = 693,
		["691"] = 693,
		["692"] = 693,
		["693"] = 701,
		["695"] = 701,
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
j.zen_talent = c()
local t = j.zen_talent
t.name = "zen_talent"
d(t, l)
function t.prototype.GetIntrinsicModifierName(self)
	return "modifier_zen_talent"
end
t = e({ m(nil) }, t)
j.zen_talent = t
j.modifier_zen_talent = c()
local u = j.modifier_zen_talent
u.name = "modifier_zen_talent"
d(u, o)
function u.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.projList = {}
	self.stunned = false
	self.isAttacking = false
	self.tick = FRAME_TIME
end
function u.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.attack = self:GetAbilitySpecialValueFor("attack")
	self.cooldown = self:GetAbilitySpecialValueFor("cooldown")
	self.orb_count = self:GetAbilityTalentValue("zen_talent_1", "orb_count")
	self.add_attack = self:GetAbilityTalentValue("zen_talent_1", "add_attack")
	self.talent_1_round_count = self:GetAbilityTalentValue("zen_talent_1", "round_count")
	self.talent_1_round_counter = 0
	self.talent_3_interval_reduce = self:GetAbilityTalentValue("zen_talent_3", "interval_reduce")
	self.bonus_count = self:GetAbilityTalentValue("zen_talent_4", "bonus_count")
	self.talent_5_chance = self:GetAbilityTalentValue("zen_talent_5", "chance")
	self.talent_5_bonus_damage = self:GetAbilityTalentValue("zen_talent_5", "bonus_damage")
	self.talent_7_charge_time = self:GetAbilityTalentValue("zen_talent_7", "charge_time")
	self.talent_7_factor = self:GetAbilityTalentValue("zen_talent_7", "factor")
	self.talent_8_count = self:GetAbilityTalentValue("zen_talent_8", "count")
	self.talent_8_debuff_reduce = self:GetAbilityTalentValue("zen_talent_8", "debuff_reduce")
	self.talent_9_count_reduce = self:GetAbilityTalentValue("zen_talent_9", "count_reduce")
	self.talent_9_damage_multi = self:GetAbilityTalentValue("zen_talent_9", "damage_multi")
	self.talent_9_interval_bonus = self:GetAbilityTalentValue("zen_talent_9", "interval_bonus")
	self.talent_10_count = self:GetAbilityTalentValue("zen_talent_10", "count")
	self.talent_10_counter = 0
	self.talent_11_level_bonus = self:GetAbilityTalentValue("zen_talent_11", "level_bonus")
	self.talent_12_chance = self:GetAbilityTalentValue("zen_talent_12", "chance")
	self.talent_12_counter = 0
	self.attack_interval = self.interval - self.talent_3_interval_reduce + self.talent_9_interval_bonus
end
function u.prototype.OnCreated(self, v)
	if IsServer() then
		self:SetStackCount(self:loadData("attack") + self:loadData("talent11"))
		local w = self:GetParent()
		local x = w:FindAbilityByName("zen_ult")
		if IsValid(x) then
			self.zen_ult_damage = x:GetSpecialValueFor("damage")
		end
	end
end
function u.prototype.OnDestroy(self)
	if IsServer() then
		if self.projList ~= nil then
			Projectile:DestroyPartOfSurroundProjectile(self.projList)
		end
		self.projList = {}
	end
end
function u.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function u.prototype.OnBattleStart(self, v)
	self.isAttacking = false
	self.Battling = true
	self.record = 0
	self:passiveCharge()
	local w = self:GetParent()
	local x = w:FindAbilityByName("zen_ult")
	self.talent_1_round_counter = 0
	if IsValid(x) then
		self.zen_ult_damage = x:GetSpecialValueFor("damage")
	end
	if self.orb_count > 0 then
		self:SetStackCount(self:loadData("attack"))
	end
	if self.talent_11_level_bonus > 0 then
		local y = PlayerData:getHero(w:GetPlayerOwnerID())
		local z = y ~= nil and y:getLevel() or 1
		self:saveData("talent11", z * self.talent_11_level_bonus)
		self:SetStackCount(self:loadData("talent11"))
	else
		self:saveData("talent11", 0)
	end
	if self.hookID == nil then
		self.hookID = self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_DAMAGE_START, function(A, v, B, C)
			if self.talent_10_count > 0 then
				if B == self:GetParent() and v.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
					self.talent_10_counter = self.talent_10_counter + 1
					if self.talent_10_counter >= self.talent_10_count then
						self.talent_10_counter = 0
						v.is_crit = true
					end
				end
			end
		end)
	end
	self:StartIntervalThink(self.tick)
end
function u.prototype.OnBattleEnd(self, v)
	self.Battling = false
	self.isAttacking = false
	Projectile:DestroyPartOfSurroundProjectile(self.projList)
	self.projList = {}
	self:StartIntervalThink(-1)
	if self.hookID ~= nil then
		self:unhook(self.hookID)
	end
end
function u.prototype.attackStart(self)
	self:performAttackAnimation()
	self.record = self.attack_interval
end
function u.prototype.passiveCharge(self)
	self:GetParent():RemoveModifierByName("modifier_zen_talent_buff")
	local D = self:createPassiveOrb(self:getInitOrbCount())
	self.talent_12_counter = self:getInitOrbCount()
	self.projList = f(self.projList, D)
	self.isAttacking = true
	self:attackStart()
end
function u.prototype.createPassiveOrb(self, E)
	local w = self:GetParent()
	local F = self.talent_9_damage_multi
	local D = Projectile:CreateGroupSurroundProjectile({
		hCaster = w,
		sGroupName = "zen" .. tostring(self:GetAbility():entindex()),
		flCircleRadius = 200,
		flAngularVelocity = 80,
		flOffset = 64,
		OnProjectileCreated = function(G)
			local H = G
			local I = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_zen/hero_zen_passive_orb.vpcf",
				PATTACH_CUSTOMORIGIN,
				w,
				w,
				true
			)
			ParticleManager:SetParticleControl(I, 0, H._hThinker:GetAbsOrigin())
			ParticleManager:SetParticleControlEnt(
				I,
				1,
				H._hThinker,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				H._hThinker:GetAbsOrigin(),
				false
			)
			if F > 0 then
				ParticleManager:SetParticleControl(I, 6, Vector(1, 0, 0))
			end
			H._iParticleID = I
		end,
		iCount = E,
	})
	w:EmitSound("Hero_Invoker.Invoke")
	return D
end
function u.prototype.OnPassiveProc(self)
	local w = self:GetParent()
	local C = w:GetEnemy()
	if not IsInjurable(C, w) or not self.Battling then
		self:StartIntervalThink(-1)
		return
	end
	if #self.projList == 0 then
		self:passiveCharge()
		return
	end
	if #self.projList > 0 then
		local J = RandomInt(0, #self.projList - 1)
		local K = self.projList[J + 1]
		local L = Projectile:getProjectileInfo(K)
		self:fireOrb(L._vPosition, w:GetEnemy())
		local M = false
		if self.talent_12_chance > 0 and self.talent_12_counter > 0 then
			self.talent_12_counter = self.talent_12_counter - 1
			local y = PlayerData:getHero(w:GetPlayerOwnerID())
			local z = y ~= nil and y:getLevel() or 1
			if self:PRD(self.talent_12_chance * z, "talent_12") then
				M = true
			end
		end
		if not M then
			g(self.projList, J, 1)
			Projectile:DestroyPartOfSurroundProjectile({ K })
		end
		if #self.projList > 0 then
			self:attackStart()
		end
	end
	if #self.projList == 0 then
		self:startPassiveCharge()
	end
end
function u.prototype.OnIntervalThink(self)
	self.record = self.record - self.tick
	if self.record <= 0 then
		self:OnPassiveProc()
	end
end
function u.prototype.performAttackAnimation(self)
	if IsServer() then
		self:GetParent():StartGestureWithFadeAndPlaybackRate(ACT_DOTA_ATTACK, 0.1, 0.2, 0.57 / self.attack_interval)
	end
end
function u.prototype.fireOrb(self, N, C, O)
	if O == nil then
		O = self:GetAbility()
	end
	if not IsInjurable(self:GetParent(), C) then
		return
	end
	if not IsValid(O) then
		O = self:GetAbility()
	end
	if not IsValid(O) then
		return
	end
	local w = self:GetParent()
	local P = O:GetAbilityName() == "zen_ult"
	if not P then
		w:EmitSound("Hero_Invoker.Attack")
	end
	Projectile:CreateTrackingProjectile({
		EffectName = P and "particles/units/heroes/hero_zen/hero_zen_ulti_attack.vpcf"
			or "particles/units/heroes/hero_zen/hero_zen_passive_attack.vpcf",
		hCaster = w,
		vSpawnOrigin = N,
		hTarget = C,
		iMoveSpeed = 2000,
		OnProjectileHit = function(Q, R, S)
			if IsInjurable(w, C) then
				DamageSystem:performAttack(w, C, { ability = O })
			end
		end,
		ParticleIDCreateCallBack = function(T, I)
			if self.talent_9_damage_multi > 0 then
				ParticleManager:SetParticleControl(I, 13, Vector(1, 0, 0))
			end
		end,
	})
	if self.orb_count > 0 then
		if self.talent_1_round_counter < self.talent_1_round_count then
			self:modifyData("talent_1", 1)
			if self:loadData("talent_1") >= self.orb_count then
				self.talent_1_round_counter = self.talent_1_round_counter + self.add_attack
				self:saveData("talent_1", 0)
				self:modifyData("attack", self.add_attack)
				self:SetStackCount(self:loadData("attack"))
			end
		end
	end
	if self.talent_8_count > 0 then
		self:modifyData("talent_8", 1)
		if self:loadData("talent_8") >= self.talent_8_count then
			self:saveData("talent_8", 0)
			ReduceIce(w, GetIce(w) * self.talent_8_debuff_reduce * 0.01)
			ReducePoison(w, GetPoison(w) * self.talent_8_debuff_reduce * 0.01)
			ReduceInjury(w, GetInjury(w) * self.talent_8_debuff_reduce * 0.01)
		end
	end
end
function u.prototype.startPassiveCharge(self)
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_zen_talent_buff", nil)
	self:GetParent():RemoveGesture(ACT_DOTA_ATTACK)
	self.isAttacking = false
	if self.talent_7_factor > 0 then
		self:GetParent()
			:StartGestureWithFadeAndPlaybackRate(
				ACT_DOTA_SPAWN,
				0,
				0,
				1.2 / (self.cooldown - self.talent_7_charge_time)
			)
		self.record = self.cooldown - self.talent_7_charge_time
	else
		self:GetParent():StartGestureWithFadeAndPlaybackRate(ACT_DOTA_SPAWN, 0, 0, 1.2 / self.cooldown)
		self.record = self.cooldown
	end
end
function u.prototype.onUlti(self)
	local w = self:GetParent()
	local U = #self.projList
	local E = U + self:getInitOrbCount()
	h(self.projList, function(T, V)
		local L = Projectile:getProjectileInfo(V)
		local I = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_invoker_kid/invoker_kid_base_attack_exort_launch.vpcf",
			PATTACH_CUSTOMORIGIN,
			w
		)
		ParticleManager:SetParticleControl(I, 0, L._vPosition)
		ParticleManager:SetParticleControl(I, 3, L._vPosition)
		ParticleManager:SetParticleControl(I, 9, L._vPosition)
		ParticleManager:ReleaseParticleIndex(I)
		local W = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_zen/zen_cast_trail.vpcf",
			PATTACH_CUSTOMORIGIN,
			w
		)
		ParticleManager:SetParticleControl(W, 0, L._vPosition)
		ParticleManager:SetParticleControl(W, 1, w:GetAbsOrigin() + Vector(0, 0, 128))
		ParticleManager:ReleaseParticleIndex(W)
	end)
	Projectile:DestroyPartOfSurroundProjectile(self.projList)
	self.projList = {}
	self:startPassiveCharge()
	return { passive = U, all = E }
end
function u.prototype.getInitOrbCount(self)
	return self.count + self.bonus_count - self.talent_9_count_reduce
end
function u.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
end
function u.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROCATTACK_DAMAGE_OVERRIDE,
	}
end
function u.prototype.getOrbDamage(self, X, O)
	local w = self:GetParent()
	local Y = w:GetAttacksPerSecond(false)
	local Z = self.attackspeed * Y + self.attack * X
	local P = false
	local _ = false
	if IsValid(O) then
		local a0 = O:GetAbilityName()
		if a0 == "zen_ult" then
			P = true
			_ = true
		end
		if a0 == "zen_talent" then
			_ = true
		end
	end
	if P then
		Z = Z + self.zen_ult_damage
	end
	if self.talent_5_chance > 0 and self:PRD(self.talent_5_chance, "talent_5") then
		Z = Z * self.talent_5_bonus_damage * 0.01
	end
	if self.talent_9_damage_multi > 0 and _ then
		Z = Z * self.talent_9_damage_multi
	end
	return Z
end
function u.prototype.EOM_GetModifierProcAttackDamageOverride(self, v)
	if v.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		return self:getOrbDamage(v.damage, v.ability)
	end
end
function u.prototype.EOM_GetModifierAttackDamageBonus(self)
	return self:GetStackCount()
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
				GetPriority = MODIFIER_PRIORITY_SUPER_ULTRA,
			}
		),
	},
	u
)
j.modifier_zen_talent = u
j.modifier_zen_talent_buff = c()
local a1 = j.modifier_zen_talent_buff
a1.name = "modifier_zen_talent_buff"
d(a1, o)
function a1.prototype.GetAbilitySpecialValue(self) end
a1 = e(
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
	a1
)
j.modifier_zen_talent_buff = a1
j.zen_ult = c()
local a2 = j.zen_ult
a2.name = "zen_ult"
d(a2, r)
function a2.prototype.OnSpellStart(self)
	local a3 = self:GetCaster()
	a3:AddNewModifier(a3, self, "modifier_zen_ult", nil)
	a3:EmitSound("Hero_EarthSpirit.Magnetize.Cast")
end
a2 = e({ s(nil) }, a2)
j.zen_ult = a2
j.modifier_zen_ult = c()
local a4 = j.modifier_zen_ult
a4.name = "modifier_zen_ult"
d(a4, o)
function a4.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.interval_slow_multi = self:GetAbilitySpecialValueFor("interval_slow_multi")
	self.talent_9_damage_multi = self:GetAbilityTalentValue("zen_talent_9", "damage_multi")
	self.talent_12_chance = self:GetAbilityTalentValue("zen_talent_12", "chance")
end
function a4.prototype.OnCreated(self, v)
	if IsServer() then
		local E = 0
		local a5 = 0
		self.talentModifier = self:GetParent():FindModifierByName("modifier_zen_talent")
		if IsValid(self.talentModifier) then
			local a6 = self.talentModifier:onUlti()
			a5 = self.talentModifier.attack_interval / self.interval_slow_multi
			E = a6.all
			self.passiveCount = a6.all
		end
		if E > 0 then
			local w = self:GetParent()
			local a7 = Projectile:CreateGroupSurroundProjectile({
				hCaster = w,
				sGroupName = "zen_ulti" .. tostring(self:GetAbility():entindex()),
				flCircleRadius = 120,
				flAngularVelocity = 80,
				flOffset = 328,
				OnProjectileCreated = function(G)
					local H = G
					local I = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_zen/zen_apex_wex_orb.vpcf",
						PATTACH_CUSTOMORIGIN,
						w,
						w,
						true
					)
					ParticleManager:SetParticleControl(I, 0, H._hThinker:GetAbsOrigin())
					ParticleManager:SetParticleControlEnt(
						I,
						1,
						H._hThinker,
						PATTACH_ABSORIGIN_FOLLOW,
						nil,
						H._hThinker:GetAbsOrigin(),
						false
					)
					H._iParticleID = I
				end,
				iCount = 1,
			})
			self.mainProjID = a7[1]
			self.dummy = SpawnEntityFromTableSynchronous(
				"prop_dynamic",
				{ origin = w:GetAbsOrigin(), model = "models/development/invisiblebox.vmdl" }
			)
			GameTimer(0.03, function()
				if not IsValid(self) then
					return
				end
				local H = Projectile:getProjectileInfo(self.mainProjID)
				if H == nil then
					self:Destroy()
					return
				end
				local a8 = H._vPosition
				self.dummy:SetAbsOrigin(a8)
				self.secProjList = Projectile:CreateGroupSurroundProjectile({
					hCaster = self.dummy,
					sGroupName = "zen_ulti_" .. tostring(self.dummy:entindex()),
					flCircleRadius = 100,
					flAngularVelocity = 60,
					flOffset = 0,
					OnProjectileCreated = function(G)
						local H = G
						local I = ParticleManager:CreateParticle(
							"particles/units/heroes/hero_zen/zen_ulti.vpcf",
							PATTACH_CUSTOMORIGIN,
							w,
							w,
							true
						)
						ParticleManager:SetParticleControl(I, 0, a8)
						ParticleManager:SetParticleControlEnt(
							I,
							1,
							H._hThinker,
							PATTACH_ABSORIGIN_FOLLOW,
							nil,
							H._hThinker:GetAbsOrigin(),
							false
						)
						if self.talent_9_damage_multi > 0 then
							ParticleManager:SetParticleControl(I, 6, Vector(0.5, 0, 0))
						end
						H._iParticleID = I
					end,
					iCount = E,
				})
			end)
			w:EmitSound("Hero_Invoker.Invoke")
			self:StartIntervalThink(0)
			self:StartThink(a5)
		else
			self:Destroy()
		end
	end
end
function a4.prototype.OnDestroy(self)
	if IsServer() then
		if self.mainProjID ~= nil then
			Projectile:DestroyPartOfSurroundProjectile({ self.mainProjID })
		end
		if self.secProjList ~= nil then
			Projectile:DestroyPartOfSurroundProjectile(self.secProjList)
		end
		if IsValid(self.dummy) then
			UTIL_Remove(self.dummy)
		end
	end
end
function a4.prototype.OnIntervalThink(self)
	local H = Projectile:getProjectileInfo(self.mainProjID)
	if H == nil then
		self:Destroy()
		return
	end
	self.dummy:SetAbsOrigin(H._vPosition)
end
function a4.prototype.OnThink(self, a9)
	if not IsValid(self.talentModifier) or not IsValid(self.dummy) or #self.secProjList == 0 then
		self:Destroy()
		return
	end
	local J = RandomInt(0, #self.secProjList - 1)
	local K = self.secProjList[J + 1]
	local M = false
	if self.passiveCount > 0 then
		self.passiveCount = self.passiveCount - 1
		if self.talent_12_chance > 0 then
			local y = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
			local z = y ~= nil and y:getLevel() or 1
			if self:PRD(self.talent_12_chance * z, "talent_12") then
				M = true
			end
		end
	end
	local L = Projectile:getProjectileInfo(K)
	self.talentModifier:fireOrb(L._vPosition, self:GetParent():GetEnemy(), self:GetAbility())
	if not M then
		g(self.secProjList, J, 1)
		Projectile:DestroyPartOfSurroundProjectile({ K })
	end
end
function a4.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function a4.prototype.OnBattleEnd(self, v)
	if IsServer() then
		self:OnDestroy()
	end
end
a4 = e(
	{
		p(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	a4
)
j.modifier_zen_ult = a4
j.zen_shard = c()
local aa = j.zen_shard
aa.name = "zen_shard"
d(aa, l)
function aa.prototype.GetIntrinsicModifierName(self)
	return "modifier_zen_shard"
end
aa = e({ m(nil) }, aa)
j.zen_shard = aa
j.modifier_zen_shard = c()
local ab = j.modifier_zen_shard
ab.name = "modifier_zen_shard"
d(ab, o)
function ab.prototype.GetAbilitySpecialValue(self)
	self.buff_per = self:GetAbilitySpecialValueFor("buff_per")
end
function ab.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_STACK_BONUS_PERCENTAGE] = -self.buff_per,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_STACK_BONUS_PERCENTAGE] = -self.buff_per,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_STACK_BONUS_PERCENTAGE] = -self.buff_per,
	}
end
ab = e(
	{
		p(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_SUPER_ULTRA,
			}
		),
	},
	ab
)
j.modifier_zen_shard = ab
return j