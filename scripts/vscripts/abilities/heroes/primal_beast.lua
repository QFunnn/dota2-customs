--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/primal_beast"
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
		["35"] = 29,
		["36"] = 31,
		["37"] = 46,
		["38"] = 51,
		["39"] = 58,
		["40"] = 59,
		["41"] = 13,
		["42"] = 60,
		["43"] = 61,
		["44"] = 62,
		["45"] = 63,
		["46"] = 64,
		["47"] = 65,
		["48"] = 66,
		["49"] = 67,
		["50"] = 68,
		["51"] = 69,
		["52"] = 70,
		["53"] = 71,
		["54"] = 72,
		["55"] = 73,
		["56"] = 75,
		["57"] = 76,
		["58"] = 77,
		["59"] = 79,
		["60"] = 81,
		["61"] = 82,
		["62"] = 83,
		["63"] = 85,
		["64"] = 60,
		["65"] = 88,
		["66"] = 89,
		["67"] = 90,
		["69"] = 88,
		["70"] = 100,
		["71"] = 101,
		["72"] = 100,
		["73"] = 103,
		["74"] = 114,
		["75"] = 103,
		["76"] = 117,
		["77"] = 118,
		["78"] = 117,
		["79"] = 120,
		["80"] = 121,
		["81"] = 121,
		["82"] = 121,
		["83"] = 121,
		["84"] = 125,
		["85"] = 125,
		["86"] = 125,
		["87"] = 121,
		["88"] = 121,
		["89"] = 120,
		["90"] = 128,
		["91"] = 129,
		["92"] = 130,
		["93"] = 131,
		["94"] = 132,
		["95"] = 133,
		["97"] = 128,
		["98"] = 140,
		["99"] = 141,
		["100"] = 142,
		["101"] = 140,
		["102"] = 145,
		["103"] = 146,
		["104"] = 147,
		["105"] = 148,
		["107"] = 150,
		["110"] = 153,
		["111"] = 154,
		["112"] = 155,
		["114"] = 155,
		["116"] = 156,
		["118"] = 145,
		["119"] = 160,
		["120"] = 161,
		["121"] = 162,
		["122"] = 163,
		["123"] = 164,
		["124"] = 165,
		["128"] = 160,
		["129"] = 171,
		["130"] = 172,
		["133"] = 173,
		["136"] = 174,
		["139"] = 175,
		["140"] = 176,
		["141"] = 177,
		["142"] = 178,
		["143"] = 179,
		["144"] = 180,
		["145"] = 181,
		["148"] = 184,
		["149"] = 185,
		["150"] = 186,
		["151"] = 187,
		["152"] = 188,
		["153"] = 189,
		["154"] = 190,
		["155"] = 191,
		["156"] = 192,
		["157"] = 193,
		["158"] = 194,
		["159"] = 194,
		["160"] = 194,
		["161"] = 194,
		["162"] = 194,
		["163"] = 194,
		["164"] = 194,
		["165"] = 194,
		["166"] = 194,
		["167"] = 195,
		["168"] = 195,
		["169"] = 195,
		["170"] = 196,
		["171"] = 196,
		["172"] = 196,
		["173"] = 196,
		["174"] = 196,
		["175"] = 196,
		["176"] = 202,
		["177"] = 203,
		["180"] = 204,
		["181"] = 209,
		["182"] = 209,
		["183"] = 209,
		["184"] = 209,
		["185"] = 209,
		["186"] = 209,
		["187"] = 209,
		["188"] = 209,
		["189"] = 209,
		["190"] = 210,
		["191"] = 210,
		["192"] = 210,
		["193"] = 210,
		["194"] = 210,
		["195"] = 210,
		["196"] = 211,
		["197"] = 211,
		["198"] = 211,
		["199"] = 211,
		["200"] = 211,
		["201"] = 211,
		["202"] = 196,
		["203"] = 196,
		["204"] = 195,
		["205"] = 195,
		["206"] = 215,
		["207"] = 215,
		["208"] = 215,
		["209"] = 216,
		["210"] = 215,
		["211"] = 215,
		["214"] = 220,
		["217"] = 171,
		["218"] = 225,
		["219"] = 231,
		["220"] = 232,
		["221"] = 232,
		["222"] = 232,
		["223"] = 232,
		["224"] = 232,
		["225"] = 232,
		["227"] = 234,
		["228"] = 234,
		["229"] = 234,
		["230"] = 234,
		["231"] = 235,
		["232"] = 236,
		["234"] = 238,
		["235"] = 239,
		["236"] = 240,
		["238"] = 242,
		["239"] = 243,
		["240"] = 244,
		["241"] = 246,
		["243"] = 225,
		["244"] = 250,
		["245"] = 250,
		["246"] = 250,
		["248"] = 251,
		["249"] = 252,
		["250"] = 253,
		["251"] = 254,
		["253"] = 256,
		["254"] = 257,
		["255"] = 258,
		["256"] = 259,
		["257"] = 260,
		["258"] = 264,
		["259"] = 265,
		["260"] = 266,
		["261"] = 267,
		["262"] = 268,
		["263"] = 269,
		["264"] = 269,
		["266"] = 269,
		["267"] = 269,
		["269"] = 269,
		["270"] = 269,
		["271"] = 269,
		["273"] = 269,
		["274"] = 269,
		["275"] = 269,
		["276"] = 269,
		["277"] = 269,
		["278"] = 269,
		["279"] = 269,
		["282"] = 250,
		["283"] = 274,
		["284"] = 275,
		["285"] = 276,
		["286"] = 277,
		["289"] = 280,
		["290"] = 281,
		["291"] = 282,
		["292"] = 282,
		["293"] = 282,
		["294"] = 283,
		["295"] = 284,
		["296"] = 285,
		["298"] = 282,
		["299"] = 282,
		["300"] = 288,
		["301"] = 289,
		["302"] = 290,
		["303"] = 291,
		["305"] = 292,
		["306"] = 292,
		["307"] = 293,
		["308"] = 293,
		["309"] = 293,
		["310"] = 294,
		["311"] = 295,
		["313"] = 296,
		["314"] = 296,
		["315"] = 297,
		["316"] = 298,
		["317"] = 299,
		["318"] = 300,
		["319"] = 305,
		["320"] = 305,
		["321"] = 305,
		["322"] = 305,
		["323"] = 305,
		["324"] = 306,
		["325"] = 306,
		["326"] = 306,
		["327"] = 306,
		["328"] = 306,
		["329"] = 307,
		["330"] = 307,
		["331"] = 307,
		["332"] = 307,
		["333"] = 307,
		["334"] = 296,
		["337"] = 309,
		["338"] = 309,
		["339"] = 309,
		["340"] = 309,
		["341"] = 309,
		["342"] = 309,
		["343"] = 293,
		["344"] = 293,
		["345"] = 292,
		["348"] = 274,
		["349"] = 314,
		["350"] = 315,
		["351"] = 314,
		["352"] = 330,
		["353"] = 331,
		["354"] = 332,
		["356"] = 330,
		["357"] = 21,
		["358"] = 13,
		["359"] = 13,
		["360"] = 13,
		["361"] = 13,
		["362"] = 13,
		["363"] = 13,
		["364"] = 13,
		["365"] = 13,
		["366"] = 21,
		["368"] = 21,
		["369"] = 345,
		["370"] = 353,
		["371"] = 345,
		["372"] = 353,
		["373"] = 355,
		["374"] = 356,
		["375"] = 355,
		["376"] = 358,
		["377"] = 358,
		["378"] = 361,
		["379"] = 361,
		["380"] = 364,
		["381"] = 365,
		["382"] = 364,
		["383"] = 369,
		["384"] = 370,
		["385"] = 369,
		["386"] = 353,
		["387"] = 345,
		["388"] = 345,
		["389"] = 345,
		["390"] = 345,
		["391"] = 345,
		["392"] = 345,
		["393"] = 345,
		["394"] = 345,
		["395"] = 353,
		["397"] = 353,
		["398"] = 375,
		["399"] = 383,
		["400"] = 375,
		["401"] = 383,
		["402"] = 384,
		["403"] = 385,
		["404"] = 384,
		["405"] = 383,
		["406"] = 375,
		["407"] = 375,
		["408"] = 375,
		["409"] = 375,
		["410"] = 375,
		["411"] = 375,
		["412"] = 375,
		["413"] = 375,
		["414"] = 383,
		["416"] = 383,
		["417"] = 391,
		["418"] = 399,
		["419"] = 391,
		["420"] = 399,
		["422"] = 399,
		["423"] = 400,
		["424"] = 391,
		["425"] = 404,
		["426"] = 405,
		["427"] = 404,
		["428"] = 407,
		["429"] = 408,
		["430"] = 409,
		["431"] = 410,
		["432"] = 411,
		["433"] = 412,
		["434"] = 413,
		["435"] = 414,
		["436"] = 414,
		["438"] = 416,
		["440"] = 407,
		["441"] = 419,
		["442"] = 420,
		["443"] = 421,
		["444"] = 422,
		["445"] = 423,
		["448"] = 426,
		["450"] = 427,
		["451"] = 427,
		["452"] = 428,
		["453"] = 429,
		["454"] = 429,
		["455"] = 430,
		["456"] = 431,
		["458"] = 427,
		["461"] = 434,
		["462"] = 435,
		["463"] = 436,
		["464"] = 438,
		["465"] = 439,
		["466"] = 439,
		["467"] = 439,
		["468"] = 439,
		["469"] = 439,
		["470"] = 440,
		["471"] = 440,
		["472"] = 440,
		["473"] = 440,
		["474"] = 440,
		["475"] = 441,
		["476"] = 442,
		["478"] = 444,
		["479"] = 445,
		["480"] = 446,
		["483"] = 419,
		["484"] = 399,
		["485"] = 391,
		["486"] = 391,
		["487"] = 391,
		["488"] = 391,
		["489"] = 391,
		["490"] = 391,
		["491"] = 391,
		["492"] = 391,
		["493"] = 399,
		["495"] = 399,
		["496"] = 453,
		["497"] = 454,
		["498"] = 453,
		["499"] = 454,
		["500"] = 458,
		["501"] = 459,
		["502"] = 460,
		["503"] = 461,
		["504"] = 462,
		["505"] = 458,
		["506"] = 464,
		["507"] = 465,
		["508"] = 466,
		["509"] = 467,
		["510"] = 468,
		["512"] = 470,
		["513"] = 471,
		["514"] = 472,
		["515"] = 473,
		["516"] = 473,
		["517"] = 473,
		["518"] = 473,
		["519"] = 474,
		["521"] = 476,
		["522"] = 464,
		["523"] = 478,
		["524"] = 479,
		["525"] = 478,
		["526"] = 454,
		["527"] = 453,
		["528"] = 454,
		["530"] = 454,
		["531"] = 483,
		["532"] = 491,
		["533"] = 483,
		["534"] = 491,
		["536"] = 491,
		["537"] = 500,
		["538"] = 501,
		["539"] = 483,
		["540"] = 504,
		["541"] = 505,
		["542"] = 506,
		["543"] = 507,
		["544"] = 504,
		["545"] = 512,
		["546"] = 517,
		["547"] = 512,
		["548"] = 519,
		["549"] = 520,
		["550"] = 521,
		["551"] = 522,
		["552"] = 523,
		["553"] = 524,
		["554"] = 525,
		["555"] = 525,
		["556"] = 526,
		["557"] = 526,
		["558"] = 526,
		["559"] = 526,
		["560"] = 526,
		["561"] = 526,
		["563"] = 519,
		["564"] = 530,
		["565"] = 531,
		["566"] = 532,
		["567"] = 533,
		["568"] = 534,
		["570"] = 536,
		["571"] = 536,
		["573"] = 530,
		["574"] = 540,
		["575"] = 541,
		["576"] = 541,
		["577"] = 540,
		["578"] = 544,
		["579"] = 545,
		["580"] = 546,
		["581"] = 547,
		["582"] = 551,
		["583"] = 551,
		["584"] = 551,
		["585"] = 551,
		["586"] = 551,
		["587"] = 551,
		["589"] = 552,
		["590"] = 552,
		["591"] = 553,
		["592"] = 554,
		["593"] = 555,
		["595"] = 552,
		["598"] = 558,
		["599"] = 559,
		["600"] = 559,
		["601"] = 559,
		["602"] = 559,
		["603"] = 559,
		["604"] = 560,
		["605"] = 560,
		["606"] = 560,
		["607"] = 560,
		["608"] = 560,
		["609"] = 544,
		["610"] = 563,
		["611"] = 564,
		["612"] = 565,
		["613"] = 566,
		["614"] = 567,
		["616"] = 563,
		["617"] = 491,
		["618"] = 483,
		["619"] = 483,
		["620"] = 483,
		["621"] = 483,
		["622"] = 483,
		["623"] = 483,
		["624"] = 483,
		["625"] = 483,
		["626"] = 491,
		["628"] = 491,
		["629"] = 572,
		["630"] = 580,
		["631"] = 572,
		["632"] = 580,
		["633"] = 581,
		["634"] = 582,
		["635"] = 581,
		["636"] = 584,
		["637"] = 585,
		["638"] = 584,
		["639"] = 580,
		["640"] = 572,
		["641"] = 572,
		["642"] = 572,
		["643"] = 572,
		["644"] = 572,
		["645"] = 572,
		["646"] = 572,
		["647"] = 572,
		["648"] = 580,
		["650"] = 580,
		["651"] = 589,
		["652"] = 590,
		["653"] = 589,
		["654"] = 590,
		["655"] = 591,
		["656"] = 592,
		["657"] = 591,
		["658"] = 590,
		["659"] = 589,
		["660"] = 590,
		["662"] = 590,
		["663"] = 595,
		["664"] = 603,
		["665"] = 595,
		["666"] = 603,
		["667"] = 606,
		["668"] = 607,
		["669"] = 606,
		["670"] = 613,
		["671"] = 614,
		["672"] = 615,
		["673"] = 615,
		["674"] = 616,
		["675"] = 617,
		["676"] = 618,
		["677"] = 619,
		["679"] = 621,
		["681"] = 613,
		["682"] = 625,
		["683"] = 626,
		["684"] = 625,
		["685"] = 629,
		["686"] = 630,
		["687"] = 631,
		["688"] = 632,
		["689"] = 632,
		["690"] = 632,
		["691"] = 632,
		["692"] = 632,
		["693"] = 632,
		["695"] = 629,
		["696"] = 603,
		["697"] = 595,
		["698"] = 595,
		["699"] = 595,
		["700"] = 595,
		["701"] = 595,
		["702"] = 595,
		["703"] = 595,
		["704"] = 595,
		["705"] = 603,
		["707"] = 603,
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
g.primal_beast_talent = c()
local q = g.primal_beast_talent
q.name = "primal_beast_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_primal_beast_talent"
end
q = e({ j(nil) }, q)
g.primal_beast_talent = q
g.modifier_primal_beast_talent = c()
local r = g.modifier_primal_beast_talent
r.name = "modifier_primal_beast_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.hp_has_trigger = false
	self.delay_time = false
	self.t6_has_trigger = false
	self.t7_record = 0
	self.loss_hp_record = 0
	self.can_add_stack = true
end
function r.prototype.GetAbilitySpecialValue(self)
	self.trigger_loss_hp_cnt = self:GetAbilitySpecialValueFor("trigger_loss_hp_cnt")
	self.add_stack = self:GetAbilitySpecialValueFor("add_stack")
	self.max_stack = self:GetAbilitySpecialValueFor("max_stack")
	self.incoming_physical_damage_pct = self:GetAbilitySpecialValueFor("incoming_physical_damage_pct")
	self.shock_wave_cnt = self:GetAbilitySpecialValueFor("shock_wave_cnt")
	self.wava_damage = self:GetAbilitySpecialValueFor("wava_damage")
	self.hp_trigger_pct = self:GetAbilitySpecialValueFor("hp_trigger_pct")
	self.t1_add_stack = self:GetAbilityTalentValue("primal_beast_talent_1", "add_stack")
	self.t2_add_wave_damage = self:GetAbilityTalentValue("primal_beast_talent_2", "add_wave_damage")
	self.t4_reduce_trigger_hp = self:GetAbilityTalentValue("primal_beast_talent_4", "reduce_trigger_hp")
	self.t4_add_damage = self:GetAbilityTalentValue("primal_beast_talent_4", "add_damage")
	self.t5_duration = self:GetAbilityTalentValue("primal_beast_talent_5", "duration")
	self.t6_reduce_sect_interval = self:GetAbilityTalentValue("primal_beast_talent_6", "reduce_sect_interval")
	self.t7_attack_cnt = self:GetAbilityTalentValue("primal_beast_talent_7", "attack_cnt")
	self.t7_stun_duration = self:GetAbilityTalentValue("primal_beast_talent_7", "stun_duration")
	self.t7_add_ult_damage_pct = self:GetAbilityTalentValue("primal_beast_talent_7", "add_ult_damage_pct")
	self.t9_passives_duration = self:GetAbilityTalentValue("primal_beast_talent_9", "passives_duration")
	self.s_chance = self:GetAbilityTalentValue("primal_beast_shard", "chance")
	self.s_damage = self:GetAbilityTalentValue("primal_beast_shard", "damage")
	self.s_duration = self:GetAbilityTalentValue("primal_beast_shard", "duration")
	self.delay_reduce_damage = self:GetAbilitySpecialValueFor("delay_reduce_damage")
end
function r.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetHasCustomTransmitterData(true)
	end
end
function r.prototype.GetTriggerLossHpCnt(self)
	return self.trigger_loss_hp_cnt - self.t4_reduce_trigger_hp
end
function r.prototype.GetWaveDamage(self)
	return (self.wava_damage + self.t4_add_damage) * self:GetStackCount() + self.t2_add_wave_damage
end
function r.prototype.GetIncomingPhysicalDmgPct(self)
	return self.incoming_physical_damage_pct
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { -1, self:GetParent() },
	}
end
function r.prototype.OnBattleStart(self, s)
	self.t6_has_trigger = false
	self.hp_has_trigger = false
	self.t7_record = 0
	if self.t7_attack_cnt > 0 then
		self:StartThink(0, "talent_7")
	end
end
function r.prototype.OnBattleEnd(self, s)
	self.reduce_stack = nil
	self.parent:RemoveModifierByName("modifier_reduce_stack")
end
function r.prototype.OnThink(self, t)
	if t == "talent_7" then
		if self.parent:HasModifier("modifier_primal_beast_talent_7") then
			self.parent:StartGesture(ACT_DOTA_CHANNEL_ABILITY_5)
		else
			self.parent:FadeGesture(ACT_DOTA_CHANNEL_ABILITY_5)
		end
	end
	if t == "Delay" then
		self.delay_time = false
		local u = self.reduce_stack
		if u ~= nil then
			u:SetStackCount(self:GetStackCount())
		end
		self:StartThink(-1, "Delay")
	end
end
function r.prototype.OnCustomAbilityFullyCast(self, v)
	if self.t1_add_stack > 0 then
		if IsInjurable(self.parent) then
			self:AddModifierStack(self.t1_add_stack)
			if self:GetStackCount() >= self.max_stack then
				self:MaxStackCntTrigger()
			end
		end
	end
end
function r.prototype.OnCustomTakeDamage(self, v)
	if not IsInjurable(self.parent, v.attacker) then
		return
	end
	if self.parent:PassivesDisabled() then
		return
	end
	if not self.can_add_stack then
		return
	end
	if not self.hp_has_trigger then
		local w = self.caster
		local x = w:GetEnemy()
		local y = self.parent:GetHealth() / self.parent:GetMaxHealth()
		if y <= self.hp_trigger_pct * 0.01 then
			self.hp_has_trigger = true
			self:MaxStackCntTrigger(false)
		end
	end
	self.loss_hp_record = self.loss_hp_record + v.damage
	if self.loss_hp_record >= self:GetTriggerLossHpCnt() then
		self.loss_hp_record = self.loss_hp_record - self:GetTriggerLossHpCnt()
		self:AddModifierStack(1)
		if self:GetStackCount() < self.max_stack then
			if self.s_chance > 0 and self:PRD(self.s_chance, "primal_beast_shard") then
				local z = self.parent:GetEnemy()
				local A = self:GetCaster()
				A:StartGestureWithFade(ACT_DOTA_CAST_ABILITY_1, 0.03, 0.09)
				local B = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_pickup.vpcf",
					PATTACH_POINT_FOLLOW,
					A
				)
				ParticleManager:SetParticleControlEnt(B, 0, A, PATTACH_POINT_FOLLOW, "attach_attack1", vec3_zero, false)
				GameTimer(0.4, function()
					Projectile:CreateTrackingProjectile({
						EffectName = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_arc.vpcf",
						hCaster = A,
						vSpawnOrigin = A:GetAbsOrigin(),
						hTarget = z,
						iMoveSpeed = PROJECTILE_SPEED_NORMAL,
						OnProjectileHit = function(x, C, D)
							if not IsInjurable(self.parent, v.attacker) then
								return
							end
							local E = ParticleManager:CreateParticle(
								"particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_impact.vpcf",
								PATTACH_ABSORIGIN,
								A
							)
							ParticleManager:SetParticleControlEnt(
								E,
								3,
								z,
								PATTACH_POINT_FOLLOW,
								"attach_hitloc",
								vec3_zero,
								false
							)
							self.parent:DealDamage(
								z,
								self:GetAbility(),
								self.s_damage,
								EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
							)
							AddStun(self.parent, z, self:GetAbility(), self.s_duration)
						end,
					})
				end)
				GameTimer(1, function()
					ParticleManager:DestroyParticle(B, false)
				end)
			end
		else
			self:MaxStackCntTrigger()
		end
	end
end
function r.prototype.AddModifierStack(self, F)
	if not self.reduce_stack then
		self.reduce_stack = self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_reduce_stack", {})
	end
	self:SetStackCount(math.min(self:GetStackCount() + F, self.max_stack))
	if not self.delay_time then
		self.reduce_stack:SetStackCount(self:GetStackCount())
	end
	if self.t5_duration > 0 then
		local G = self.parent:FindAbilityByName("primal_beast_ult")
		self.parent:AddNewModifier(self.parent, G, "modifier_primal_beast_ult", { duration = self.t5_duration })
	end
	if self.t9_passives_duration > 0 then
		local G = self.parent:FindAbilityByName("primal_beast_ult")
		local z = self.parent:GetEnemy()
		AddBroken(self.parent, z, G, self.t9_passives_duration)
	end
end
function r.prototype.MaxStackCntTrigger(self, H)
	if H == nil then
		H = true
	end
	if H and self.t6_reduce_sect_interval > 0 and not self.t6_has_trigger then
		self.t6_has_trigger = true
		local I = self.caster:FindModifierByName("modifier_sect_health")
		I:UpdateSectHealthInterval()
	end
	self.delay_time = true
	self:StartThink(self.delay_reduce_damage, "Delay")
	self:SpellWave()
	local w = self.caster
	local x = w:GetEnemy()
	if self.t7_attack_cnt > 0 then
		self.t7_record = self.t7_record + 1
		local J = w:FindAbilityByName("primal_beast_talent_7")
		if J then
			local K = w:FindAbilityByName("primal_beast_ult")
			local L = w.AddNewModifier
			local M = self.t7_attack_cnt
			local N
			if K ~= nil then
				N = K:GetUltDamage()
			end
			local O = N
			if O == nil then
				O = 0
			end
			L(w, w, J, "modifier_primal_beast_talent_7", { attack_cnt = M, cast_damage = O })
		end
	end
end
function r.prototype.SpellWave(self)
	local P = 2
	local Q = self:GetStackCount() * 2
	if Q <= 0 then
		return
	end
	self.can_add_stack = false
	local R = self:GetWaveDamage()
	GameTimer(GameRules:GetGameFrameTime(), function()
		if IsValid(self.parent) then
			self.can_add_stack = true
			self:SetStackCount(0)
		end
	end)
	local w = self.caster
	local x = w:GetEnemy()
	w:EmitSound("Hero_PrimalBeast.Uproar.Cast")
	w:StartGestureWithFade(ACT_DOTA_CAST_ABILITY_3, 0.03, 0.09)
	do
		local S = 0
		while S < self.shock_wave_cnt do
			GameTimer(0.5 + S * 0.5, function()
				local T = (x:GetAbsOrigin() - w:GetAbsOrigin()):Normalized()
				local U = 360 / Q
				do
					local V = 0
					while V < Q do
						local W = V * U
						local X = QAngle(T.x, T.y + W, T.z)
						local Y = AnglesToVector(X)
						local Z = ParticleManager:CreateParticle(
							"particles/units/heroes/hero_primal_beast/primal_beast_pulverize_tectonic_shift_projectile.vpcf",
							PATTACH_ABSORIGIN,
							self.caster
						)
						ParticleManager:SetParticleControl(Z, 0, self.caster:GetAbsOrigin())
						ParticleManager:SetParticleControl(Z, 1, Vector(Y.x * 500, Y.y * 500, 0))
						ParticleManager:SetParticleControl(Z, 3, Vector(0, P, 0))
						V = V + 1
					end
				end
				w:DealDamage(x, self:GetAbility(), R, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			end)
			S = S + 1
		end
	end
end
function r.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_SECT_HEALTH_INTERVAL_BONUS,
	}
end
function r.prototype.EOM_GetModifierSectHealthIntervalBonus(self, s)
	if self.t6_has_trigger then
		return self.t6_reduce_sect_interval
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
g.modifier_primal_beast_talent = r
g.modifier_reduce_stack = c()
local _ = g.modifier_reduce_stack
_.name = "modifier_reduce_stack"
d(_, l)
function _.prototype.GetAbilitySpecialValue(self)
	self.incoming_physical_damage_pct = self:GetAbilitySpecialValueFor("incoming_physical_damage_pct")
end
function _.prototype.OnCreated(self, s) end
function _.prototype.OnDestroy(self) end
function _.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE }
end
function _.prototype.EOM_GetModifierIncomingPhysicalDamagePercentage(self, s)
	return -(self:GetStackCount() * self.incoming_physical_damage_pct)
end
_ = e(
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
	_
)
g.modifier_reduce_stack = _
g.modifier_primal_beast_passives_disabled = c()
local a0 = g.modifier_primal_beast_passives_disabled
a0.name = "modifier_primal_beast_passives_disabled"
d(a0, l)
function a0.prototype.CheckState(self)
	return { [MODIFIER_STATE_PASSIVES_DISABLED] = true }
end
a0 = e(
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
	a0
)
g.modifier_primal_beast_passives_disabled = a0
g.modifier_primal_beast_talent_7 = c()
local a1 = g.modifier_primal_beast_talent_7
a1.name = "modifier_primal_beast_talent_7"
d(a1, l)
function a1.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tick = 0.8
end
function a1.prototype.GetAbilitySpecialValue(self)
	self.t7_stun_duration = self:GetAbilityTalentValue("primal_beast_talent_7", "stun_duration")
end
function a1.prototype.OnCreated(self, s)
	if IsServer() then
		self.caster:EmitSound("Hero_PrimalBeast.Pulverize.Cast")
		self.damage_list = {}
		local a2 = toFiniteNumber(s.attack_cnt)
		local a3 = toFiniteNumber(s.cast_damage)
		if a2 > 0 and a3 > 0 then
			local a4 = self.damage_list
			a4[#a4 + 1] = { damage = a3, cnt = a2 }
		end
		self:StartIntervalThink(self.tick)
	end
end
function a1.prototype.OnIntervalThink(self)
	if IsServer() then
		local z = self.parent:GetEnemy()
		if not IsInjurable(self.parent, z) then
			self:Destroy()
			return
		end
		local a5 = 0
		do
			local a6 = #self.damage_list - 1
			while a6 >= 0 do
				a5 = a5 + self.damage_list[a6 + 1].damage
				local a7, a8 = self.damage_list[a6 + 1], "cnt"
				a7[a8] = a7[a8] - 1
				if self.damage_list[a6 + 1].cnt <= 0 then
					table.remove(self.damage_list, a6 + 1)
				end
				a6 = a6 - 1
			end
		end
		self.caster:EmitSound("Hero_PrimalBeast.Pulverize.Impact")
		self.caster:EmitSound("Hero_PrimalBeast.Pulverize.ImpactLayer")
		z:EmitSound("Hero_PrimalBeast.Pulverize.Stun")
		local a9 = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_primal_beast/primal_beast_pulverize_hit.vpcf",
			PATTACH_ABSORIGIN,
			self.caster
		)
		ParticleManager:SetParticleControl(a9, 0, self.caster:GetAbsOrigin() + self.caster:GetForwardVector() * 100)
		ParticleManager:SetParticleControl(a9, 1, Vector(600, 0, 0))
		if a5 > 0 then
			self.parent:DealDamage(z, self.ability, a5, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
		end
		AddStun(self.parent, z, self.ability, self.t7_stun_duration)
		if #self.damage_list == 0 then
			self:Destroy()
		end
	end
end
a1 = e(
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
	a1
)
g.modifier_primal_beast_talent_7 = a1
g.primal_beast_ult = c()
local aa = g.primal_beast_ult
aa.name = "primal_beast_ult"
d(aa, o)
function aa.prototype.OnSpellStart(self)
	local ab = self:GetSpecialValueFor("duration")
	local A = self:GetCaster()
	A:StartGestureWithFade(ACT_DOTA_CAST_ABILITY_4, 0.03, 0.09)
	A:AddNewModifier(A, self, "modifier_primal_beast_ult", { duration = ab })
end
function aa.prototype.GetUltDamage(self)
	local ac = 1
	local I = self:GetCaster():FindModifierByName("modifier_primal_beast_talent")
	if I ~= nil then
		ac = ac + I.t7_record * I.t7_add_ult_damage_pct * 0.01
	end
	local ad = self:GetSpecialValueFor("base_damage")
	local ae = self:GetSpecialValueFor("max_hp_mul_pct")
	local z = self:GetCaster():GetEnemy()
	if IsInjurable(z, self:GetCaster()) then
		return ad * ac + z:GetMaxHealth() * ae * 0.01
	end
	return 0
end
function aa.prototype.GetInterval(self)
	return self:GetSpecialValueFor("interval")
end
aa = e({ p(nil) }, aa)
g.primal_beast_ult = aa
g.modifier_primal_beast_ult = c()
local af = g.modifier_primal_beast_ult
af.name = "modifier_primal_beast_ult"
d(af, l)
function af.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.stack_time = {}
	self.lr_flag = false
end
function af.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
	self.max_hp_mul_pct = self:GetAbilitySpecialValueFor("max_hp_mul_pct")
end
function af.prototype.GetAttackInterval(self)
	return self:GetAbility():GetInterval()
end
function af.prototype.OnCreated(self, s)
	if IsServer() then
		self.caster:AddActivityModifier("heavy_steps")
		self.caster:StartGestureWithFade(ACT_DOTA_RUN, 0.03, 0.09)
		self:IncrementStackCount()
		self:StartIntervalThink(self:GetAttackInterval())
		local ag = self.stack_time
		ag[#ag + 1] = GameRules:GetGameTime() + self:GetDuration()
		self.caster:AddNewModifier(self.caster, self:GetAbility(), "modifier_primal_beast_ult_override_animation", {})
	end
end
function af.prototype.OnRefresh(self, s)
	if IsServer() then
		self:IncrementStackCount()
		if s.duration > self:GetDuration() then
			self:SetDuration(s.duration, true)
		end
		local ah = self.stack_time
		ah[#ah + 1] = GameRules:GetGameTime() + s.duration
	end
end
function af.prototype.GetDamage(self)
	local ai = self:GetAbility()
	return ai and ai:GetUltDamage() or 0
end
function af.prototype.OnIntervalThink(self)
	local A = self.caster
	local z = A:GetEnemy()
	A:EmitSound("Hero_PrimalBeast.Footsteps")
	A:DealDamage(z, self:GetAbility(), self:GetDamage() * self:GetStackCount(), EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	do
		local S = #self.stack_time - 1
		while S >= 0 do
			if self.stack_time[S + 1] <= GameRules:GetGameTime() then
				table.remove(self.stack_time, S + 1)
				self:DecrementStackCount()
			end
			S = S - 1
		end
	end
	local a9 = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_primal_beast/primal_beast_trample.vpcf",
		PATTACH_ABSORIGIN,
		A
	)
	ParticleManager:SetParticleControl(a9, 0, A:GetAbsOrigin())
	ParticleManager:SetParticleControl(a9, 1, Vector(500, 0, 0))
end
function af.prototype.OnDestroy(self)
	if IsServer() then
		self.caster:RemoveActivityModifier("heavy_steps")
		self.caster:RemoveGesture(ACT_DOTA_RUN)
		self.caster:RemoveModifierByName("modifier_primal_beast_ult_override_animation")
	end
end
af = e(
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
	af
)
g.modifier_primal_beast_ult = af
g.modifier_primal_beast_ult_override_animation = c()
local aj = g.modifier_primal_beast_ult_override_animation
aj.name = "modifier_primal_beast_ult_override_animation"
d(aj, l)
function aj.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function aj.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_RUN
end
aj = e(
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
	aj
)
g.modifier_primal_beast_ult_override_animation = aj
g.primal_beast_talent_8 = c()
local ak = g.primal_beast_talent_8
ak.name = "primal_beast_talent_8"
d(ak, i)
function ak.prototype.GetIntrinsicModifierName(self)
	return "modifier_primal_beast_talent_8"
end
ak = e({ j(nil) }, ak)
g.primal_beast_talent_8 = ak
g.modifier_primal_beast_talent_8 = c()
local al = g.modifier_primal_beast_talent_8
al.name = "modifier_primal_beast_talent_8"
d(al, l)
function al.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
	}
end
function al.prototype.OnBattleStart(self, s)
	if IsServer() then
		local am = self.parent
		local an = am and am:FindModifierByName("modifier_sect_health")
		self.trigger_cnt = self:GetAbilitySpecialValueFor("trigger_cnt")
		self.interval = self:GetAbilitySpecialValueFor("interval")
		if an then
			self.interval = an and an:GetSectHealthIntervalBonus(self:GetAbilitySpecialValueFor("interval")) or 0
		end
		self:StartIntervalThink(self.interval)
	end
end
function al.prototype.OnBattleEnd(self, s)
	self:StartIntervalThink(-1)
end
function al.prototype.OnIntervalThink(self)
	local ao = self.parent:FindAbilityByName("primal_beast_ult")
	if ao then
		self.parent:AddNewModifier(
			self.parent,
			ao,
			"modifier_primal_beast_ult",
			{ duration = ao:GetInterval() * self.trigger_cnt }
		)
	end
end
al = e(
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
	al
)
g.modifier_primal_beast_talent_8 = al
return g