--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/crystal_maiden"
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
		["36"] = 59,
		["37"] = 14,
		["38"] = 23,
		["39"] = 24,
		["40"] = 23,
		["41"] = 60,
		["42"] = 61,
		["43"] = 62,
		["44"] = 64,
		["45"] = 65,
		["46"] = 66,
		["47"] = 68,
		["48"] = 69,
		["49"] = 70,
		["50"] = 72,
		["51"] = 73,
		["52"] = 75,
		["53"] = 78,
		["54"] = 79,
		["55"] = 81,
		["56"] = 83,
		["57"] = 86,
		["58"] = 87,
		["59"] = 88,
		["60"] = 89,
		["61"] = 91,
		["62"] = 92,
		["63"] = 93,
		["64"] = 94,
		["65"] = 95,
		["66"] = 96,
		["68"] = 60,
		["69"] = 99,
		["70"] = 100,
		["71"] = 101,
		["72"] = 102,
		["75"] = 99,
		["76"] = 106,
		["77"] = 107,
		["78"] = 108,
		["79"] = 106,
		["80"] = 110,
		["81"] = 111,
		["82"] = 112,
		["83"] = 112,
		["84"] = 112,
		["85"] = 111,
		["86"] = 113,
		["87"] = 113,
		["88"] = 113,
		["89"] = 111,
		["90"] = 114,
		["91"] = 114,
		["92"] = 114,
		["93"] = 111,
		["94"] = 115,
		["95"] = 115,
		["96"] = 115,
		["97"] = 111,
		["98"] = 116,
		["99"] = 116,
		["100"] = 116,
		["101"] = 111,
		["102"] = 111,
		["103"] = 110,
		["104"] = 119,
		["105"] = 120,
		["106"] = 120,
		["107"] = 120,
		["108"] = 120,
		["109"] = 120,
		["110"] = 121,
		["113"] = 124,
		["114"] = 125,
		["115"] = 126,
		["116"] = 127,
		["117"] = 128,
		["118"] = 128,
		["119"] = 128,
		["120"] = 128,
		["121"] = 128,
		["122"] = 128,
		["124"] = 119,
		["125"] = 132,
		["126"] = 133,
		["129"] = 134,
		["130"] = 135,
		["131"] = 136,
		["132"] = 137,
		["134"] = 132,
		["135"] = 140,
		["136"] = 141,
		["137"] = 142,
		["138"] = 143,
		["139"] = 144,
		["140"] = 145,
		["141"] = 145,
		["142"] = 145,
		["143"] = 145,
		["144"] = 145,
		["145"] = 146,
		["146"] = 147,
		["147"] = 147,
		["148"] = 147,
		["149"] = 148,
		["150"] = 149,
		["151"] = 150,
		["152"] = 151,
		["153"] = 151,
		["154"] = 151,
		["155"] = 151,
		["156"] = 151,
		["157"] = 151,
		["158"] = 151,
		["159"] = 152,
		["160"] = 153,
		["162"] = 155,
		["163"] = 156,
		["164"] = 156,
		["165"] = 156,
		["166"] = 156,
		["167"] = 156,
		["168"] = 156,
		["170"] = 158,
		["171"] = 159,
		["172"] = 159,
		["173"] = 159,
		["174"] = 159,
		["175"] = 159,
		["176"] = 159,
		["179"] = 147,
		["180"] = 147,
		["181"] = 140,
		["182"] = 164,
		["183"] = 165,
		["184"] = 164,
		["185"] = 167,
		["186"] = 169,
		["187"] = 170,
		["188"] = 171,
		["189"] = 172,
		["190"] = 173,
		["191"] = 174,
		["192"] = 175,
		["193"] = 176,
		["194"] = 176,
		["195"] = 176,
		["196"] = 176,
		["197"] = 176,
		["198"] = 176,
		["202"] = 180,
		["205"] = 181,
		["206"] = 182,
		["208"] = 167,
		["209"] = 185,
		["210"] = 186,
		["211"] = 187,
		["212"] = 188,
		["213"] = 189,
		["214"] = 190,
		["215"] = 191,
		["216"] = 192,
		["217"] = 193,
		["221"] = 185,
		["222"] = 198,
		["223"] = 199,
		["224"] = 200,
		["225"] = 201,
		["227"] = 203,
		["228"] = 204,
		["230"] = 207,
		["231"] = 208,
		["232"] = 209,
		["233"] = 209,
		["234"] = 209,
		["235"] = 210,
		["236"] = 210,
		["237"] = 210,
		["238"] = 210,
		["239"] = 210,
		["240"] = 209,
		["241"] = 209,
		["243"] = 214,
		["244"] = 215,
		["245"] = 216,
		["248"] = 198,
		["249"] = 220,
		["250"] = 221,
		["251"] = 220,
		["252"] = 225,
		["253"] = 226,
		["254"] = 225,
		["255"] = 22,
		["256"] = 14,
		["257"] = 14,
		["258"] = 14,
		["259"] = 14,
		["260"] = 14,
		["261"] = 14,
		["262"] = 14,
		["263"] = 14,
		["264"] = 22,
		["266"] = 22,
		["268"] = 231,
		["269"] = 232,
		["270"] = 231,
		["271"] = 232,
		["272"] = 233,
		["273"] = 234,
		["274"] = 235,
		["275"] = 236,
		["276"] = 237,
		["279"] = 238,
		["280"] = 239,
		["281"] = 240,
		["282"] = 241,
		["283"] = 233,
		["284"] = 244,
		["285"] = 245,
		["286"] = 246,
		["287"] = 247,
		["288"] = 248,
		["289"] = 248,
		["290"] = 248,
		["291"] = 248,
		["292"] = 249,
		["293"] = 249,
		["294"] = 249,
		["295"] = 249,
		["296"] = 244,
		["297"] = 251,
		["298"] = 251,
		["299"] = 251,
		["301"] = 252,
		["302"] = 253,
		["303"] = 254,
		["306"] = 256,
		["307"] = 257,
		["308"] = 258,
		["309"] = 260,
		["310"] = 261,
		["311"] = 263,
		["312"] = 264,
		["313"] = 265,
		["314"] = 266,
		["315"] = 267,
		["316"] = 267,
		["317"] = 267,
		["318"] = 268,
		["319"] = 269,
		["320"] = 270,
		["321"] = 271,
		["322"] = 272,
		["323"] = 273,
		["324"] = 274,
		["326"] = 276,
		["328"] = 267,
		["329"] = 267,
		["330"] = 279,
		["331"] = 279,
		["332"] = 279,
		["333"] = 280,
		["334"] = 281,
		["335"] = 282,
		["336"] = 283,
		["337"] = 284,
		["339"] = 286,
		["340"] = 287,
		["341"] = 288,
		["344"] = 291,
		["345"] = 292,
		["346"] = 293,
		["347"] = 294,
		["349"] = 296,
		["351"] = 298,
		["353"] = 279,
		["354"] = 279,
		["355"] = 251,
		["356"] = 232,
		["357"] = 231,
		["358"] = 232,
		["360"] = 232,
		["362"] = 306,
		["363"] = 307,
		["364"] = 306,
		["365"] = 307,
		["366"] = 308,
		["367"] = 309,
		["368"] = 308,
		["369"] = 307,
		["370"] = 306,
		["371"] = 307,
		["373"] = 307,
		["374"] = 312,
		["375"] = 319,
		["376"] = 312,
		["377"] = 319,
		["378"] = 322,
		["379"] = 323,
		["380"] = 324,
		["381"] = 322,
		["382"] = 326,
		["383"] = 327,
		["384"] = 328,
		["385"] = 329,
		["386"] = 330,
		["387"] = 331,
		["388"] = 332,
		["389"] = 333,
		["390"] = 334,
		["393"] = 326,
		["394"] = 338,
		["395"] = 339,
		["396"] = 339,
		["397"] = 341,
		["398"] = 341,
		["399"] = 341,
		["400"] = 339,
		["401"] = 339,
		["402"] = 338,
		["403"] = 344,
		["404"] = 345,
		["405"] = 346,
		["407"] = 344,
		["408"] = 349,
		["409"] = 350,
		["410"] = 349,
		["411"] = 319,
		["412"] = 312,
		["413"] = 312,
		["414"] = 312,
		["415"] = 312,
		["416"] = 312,
		["417"] = 312,
		["418"] = 312,
		["419"] = 319,
		["421"] = 319,
		["423"] = 355,
		["424"] = 356,
		["425"] = 355,
		["426"] = 356,
		["427"] = 357,
		["428"] = 358,
		["429"] = 357,
		["430"] = 356,
		["431"] = 355,
		["432"] = 356,
		["434"] = 356,
		["435"] = 361,
		["436"] = 368,
		["437"] = 361,
		["438"] = 368,
		["439"] = 370,
		["440"] = 371,
		["441"] = 370,
		["442"] = 373,
		["443"] = 374,
		["444"] = 375,
		["445"] = 375,
		["446"] = 374,
		["447"] = 373,
		["448"] = 378,
		["449"] = 379,
		["450"] = 380,
		["451"] = 381,
		["452"] = 381,
		["453"] = 381,
		["454"] = 381,
		["455"] = 381,
		["456"] = 381,
		["457"] = 381,
		["458"] = 381,
		["459"] = 381,
		["460"] = 381,
		["462"] = 378,
		["463"] = 368,
		["464"] = 361,
		["465"] = 361,
		["466"] = 361,
		["467"] = 361,
		["468"] = 361,
		["469"] = 361,
		["470"] = 361,
		["471"] = 368,
		["473"] = 368,
		["475"] = 387,
		["476"] = 388,
		["477"] = 387,
		["478"] = 388,
		["479"] = 389,
		["480"] = 390,
		["481"] = 389,
		["482"] = 388,
		["483"] = 387,
		["484"] = 388,
		["486"] = 388,
		["487"] = 393,
		["488"] = 401,
		["489"] = 393,
		["490"] = 401,
		["491"] = 403,
		["492"] = 404,
		["493"] = 403,
		["494"] = 406,
		["495"] = 407,
		["496"] = 408,
		["498"] = 406,
		["499"] = 411,
		["500"] = 412,
		["501"] = 411,
		["502"] = 416,
		["503"] = 417,
		["504"] = 416,
		["505"] = 401,
		["506"] = 393,
		["507"] = 393,
		["508"] = 393,
		["509"] = 393,
		["510"] = 393,
		["511"] = 393,
		["512"] = 393,
		["513"] = 393,
		["514"] = 401,
		["516"] = 401,
		["518"] = 422,
		["519"] = 423,
		["520"] = 422,
		["521"] = 423,
		["522"] = 424,
		["523"] = 425,
		["524"] = 424,
		["525"] = 423,
		["526"] = 422,
		["527"] = 423,
		["529"] = 423,
		["530"] = 428,
		["531"] = 435,
		["532"] = 428,
		["533"] = 435,
		["534"] = 438,
		["535"] = 439,
		["536"] = 440,
		["537"] = 438,
		["538"] = 442,
		["539"] = 443,
		["540"] = 444,
		["541"] = 444,
		["542"] = 443,
		["543"] = 442,
		["544"] = 447,
		["545"] = 448,
		["546"] = 449,
		["547"] = 447,
		["548"] = 451,
		["549"] = 452,
		["550"] = 453,
		["551"] = 451,
		["552"] = 455,
		["553"] = 456,
		["554"] = 455,
		["555"] = 460,
		["556"] = 461,
		["557"] = 462,
		["559"] = 460,
		["560"] = 435,
		["561"] = 428,
		["562"] = 428,
		["563"] = 428,
		["564"] = 428,
		["565"] = 428,
		["566"] = 428,
		["567"] = 428,
		["568"] = 435,
		["570"] = 435,
		["572"] = 468,
		["573"] = 469,
		["574"] = 468,
		["575"] = 469,
		["576"] = 470,
		["577"] = 471,
		["578"] = 470,
		["579"] = 469,
		["580"] = 468,
		["581"] = 469,
		["583"] = 469,
		["584"] = 474,
		["585"] = 481,
		["586"] = 474,
		["587"] = 481,
		["588"] = 485,
		["589"] = 486,
		["590"] = 487,
		["591"] = 485,
		["592"] = 489,
		["593"] = 490,
		["594"] = 491,
		["595"] = 491,
		["596"] = 490,
		["597"] = 489,
		["598"] = 494,
		["599"] = 495,
		["600"] = 496,
		["601"] = 497,
		["602"] = 498,
		["604"] = 500,
		["605"] = 501,
		["607"] = 503,
		["610"] = 494,
		["611"] = 481,
		["612"] = 474,
		["613"] = 474,
		["614"] = 474,
		["615"] = 474,
		["616"] = 474,
		["617"] = 474,
		["618"] = 474,
		["619"] = 481,
		["621"] = 481,
		["622"] = 509,
		["623"] = 516,
		["624"] = 509,
		["625"] = 516,
		["626"] = 519,
		["627"] = 520,
		["628"] = 519,
		["629"] = 522,
		["630"] = 523,
		["631"] = 524,
		["632"] = 522,
		["633"] = 526,
		["634"] = 527,
		["635"] = 528,
		["637"] = 526,
		["638"] = 531,
		["639"] = 532,
		["640"] = 533,
		["641"] = 534,
		["642"] = 534,
		["643"] = 534,
		["644"] = 534,
		["646"] = 531,
		["647"] = 537,
		["648"] = 538,
		["649"] = 537,
		["650"] = 542,
		["651"] = 543,
		["652"] = 542,
		["653"] = 516,
		["654"] = 509,
		["655"] = 509,
		["656"] = 509,
		["657"] = 509,
		["658"] = 509,
		["659"] = 509,
		["660"] = 509,
		["661"] = 516,
		["663"] = 516,
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
g.crystal_maiden_talent = c()
local q = g.crystal_maiden_talent
q.name = "crystal_maiden_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_crystal_maiden_talent"
end
q = e({ j(nil) }, q)
g.crystal_maiden_talent = q
g.modifier_crystal_maiden_talent = c()
local r = g.modifier_crystal_maiden_talent
r.name = "modifier_crystal_maiden_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.shard_trigger_explosion = true
end
function r.prototype.GetTexture(self)
	return "modifier_crystal_maiden_talent"
end
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
		+ self:GetAbilityTalentValue("crystal_maiden_talent_4", "chance")
	self.mana = self:GetAbilitySpecialValueFor("mana")
		+ self:GetAbilityTalentValue("crystal_maiden_talent_12", "mana_regen")
	self.mana_reply = self:GetAbilitySpecialValueFor("mana_reply")
		- self:GetAbilityTalentValue("crystal_maiden_talent_15", "mana_reduce")
	self.ice_star_damage = self:GetAbilitySpecialValueFor("ice_star_damage")
	self.ice = self:GetAbilitySpecialValueFor("ice")
	self.wisp_heal = self:GetAbilityTalentValue("crystal_maiden_talent_7", "wisp_heal")
	self.talent_11_chance = self:GetAbilityTalentValue("crystal_maiden_talent_11", "talent_11_chance")
	self.talent_11_heal = self:GetAbilityTalentValue("crystal_maiden_talent_11", "talent_11_heal")
	self.tl5_stun_duration = self:GetAbilityTalentValue("crystal_maiden_talent_5", "stun_duration")
	self.tl5_ice_stack = self:GetAbilityTalentValue("crystal_maiden_talent_5", "ice_stack")
	self.tl13_damage_shield = self:GetAbilityTalentValue("crystal_maiden_talent_13", "damage_shield")
	self.tl14_ult_bonus = self:GetAbilityTalentValue("crystal_maiden_talent_14", "ult_bonus")
	self.tl14_max_stack = self:GetAbilityTalentValue("crystal_maiden_talent_14", "max_stack")
	self.tl15_stun_duration = self:GetAbilityTalentValue("crystal_maiden_talent_15", "stun_duration")
	self.tl16_chance = self:GetAbilityTalentValue("crystal_maiden_talent_16", "chance")
	self.s_attack_speed = self:GetAbilityTalentValue("crystal_maiden_shard", "attack_speed")
	self.s_attack_speed_max = self:GetAbilityTalentValue("crystal_maiden_shard", "attack_speed_max")
	self.s_chance = self:GetAbilityTalentValue("crystal_maiden_shard", "chance")
	self.shard_interval = self:GetAbilityTalentValue("crystal_maiden_shard", "interval")
	self.g_mana_cost = self:GetAbilitySpecialValueFor("g_mana_cost")
	self.g_shield = self:GetAbilitySpecialValueFor("g_shield")
	if IsServer() then
		self.tl5_record = 0
		self.g_mana_record = 0
		self.mana_reply_record = 0
	end
end
function r.prototype.OnCreated(self, s)
	if IsServer() then
		if self.shard_interval > 0 then
			self:StartIntervalThink(self.shard_interval)
		end
	end
end
function r.prototype.OnIntervalThink(self)
	self.shard_trigger_explosion = true
	self:StartIntervalThink(-1)
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_RESTORE] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function r.prototype.OnCustomAbilityFullyCast(self, t)
	print(t.ability:GetManaCost(1), self.g_mana_cost, self.g_shield)
	if self.g_mana_cost <= 0 or self.g_shield <= 0 then
		return
	end
	self.g_mana_record = self.g_mana_record + t.ability:GetManaCost(1)
	if self.g_mana_record >= self.g_mana_cost then
		local u = math.floor(self.g_mana_record / self.g_mana_cost)
		self.g_mana_record = self.g_mana_record % self.g_mana_cost
		AddShield(self:GetParent(), u * self.g_shield, "greevil_effect_1", "Ability")
	end
end
function r.prototype.OnRestore(self, s)
	if self.mana_reply <= 0 then
		return
	end
	self.mana_reply_record = self.mana_reply_record + s.count
	if self.mana_reply_record >= self.mana_reply then
		self.mana_reply_record = self.mana_reply_record % self.mana_reply
		self:FrostNova()
	end
end
function r.prototype.FrostNova(self)
	local v = self:GetParent()
	local w = v:GetEnemy()
	EmitSoundOn("Hero_Crystal.CrystalNova", v)
	local x = ParticleManager:CreateParticle(
		"particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_cowlofice.vpcf",
		PATTACH_ABSORIGIN,
		w,
		v
	)
	ParticleManager:SetParticleControl(x, 0, w:GetAbsOrigin())
	v:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	GameTimer(0.6, function()
		if IsInjurable(w, v) then
			local y = self.parent:FindAbilityByName("crystal_maiden_crystal_nova")
			v:DealDamage(w, y, self.ice_star_damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			AddIce(v, w, self.ice, "crystal_maiden_crystal_nova", "Ability")
			if self:HasTalent("crystal_maiden_talent_13") then
				AddShield(
					v,
					self.tl13_damage_shield * self.ice_star_damage * 0.01,
					"crystal_maiden_crystal_nova",
					"Ability"
				)
			end
			if self:HasTalent("crystal_maiden_talent_14") then
				v:AddNewModifier(v, self:GetAbility(), "modifier_crystal_maiden_talent_14_buff", {})
			end
			if self:HasTalent("crystal_maiden_talent_15") then
				AddStun(self.parent, self.parent:GetEnemy(), y, self.tl15_stun_duration)
			end
		end
	end)
end
function r.prototype.OnBattleEnd(self, s)
	self:GetParent():RemoveModifierByName("modifier_crystal_maiden_talent_14_buff")
end
function r.prototype.OnIceGained(self, s)
	if self.tl5_ice_stack > 0 then
		self.tl5_record = self.tl5_record + s.iStackCount
		if self.tl5_record >= self.tl5_ice_stack then
			local v = self:GetParent()
			local w = v:GetEnemy()
			self.tl5_record = 0
			if IsInjurable(w, v) then
				AddStun(v, w, self:GetAbility(), self.tl5_stun_duration)
			end
		end
	end
	if self:GetCaster():PassivesDisabled() then
		return
	end
	if self:PRD(self.chance) then
		self:BrillianceAura()
	end
end
function r.prototype.OnCustomAttackLanded(self, t)
	if self.s_chance > 0 and self:PRD(self.s_chance, "s_chance") then
		local y = self:GetParent():FindAbilityByName("crystal_maiden_ult")
		if IsValid(y) then
			y:FreezingFieldExplosion(1)
			if self.shard_trigger_explosion then
				self.shard_trigger_explosion = false
				self:StartIntervalThink(self.shard_interval)
				y:FreezingFieldExplosion(y and y:GetExtraCount())
			end
		end
	end
end
function r.prototype.BrillianceAura(self)
	local v = self:GetParent()
	if self.s_attack_speed == 0 then
		Restore(v, self.mana)
	else
		local u = self:GetStackCount()
		self:SetStackCount(math.min(u + self.s_attack_speed, self.s_attack_speed_max))
	end
	local z = self.mana * self.wisp_heal * 0.01
	if self.wisp_heal > 0 then
		EachWisp(v, function(A)
			A:Heal(z, self:GetAbility(), true)
		end)
	end
	if self.talent_11_chance > 0 then
		if self:PRD(self.talent_11_chance, "talent_11") then
			Heal(v, self.talent_11_heal, "crystal_maiden_talent_11", "Ability")
		end
	end
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_TOTAL_PERCENTAGE }
end
function r.prototype.EOM_GetModifierAttackSpeedTotalPercentage(self, s)
	return self:GetStackCount()
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
g.modifier_crystal_maiden_talent = r
g.crystal_maiden_ult = c()
local B = g.crystal_maiden_ult
B.name = "crystal_maiden_ult"
d(B, o)
function B.prototype.OnSpellStart(self)
	local C = self:GetCaster()
	C:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	local D = C:GetEnemy()
	if not IsValid(D) then
		return
	end
	local u = self:GetSpecialValueFor("count") + self:GetTalentValue("crystal_maiden_talent_10", "base_count")
	local E = u + self:GetExtraCount()
	self:FreezingFieldExplosion(E)
	C:EmitSound("hero_Crystal.freezingField.wind")
end
function B.prototype.GetExtraCount(self)
	local C = self:GetCaster()
	local D = C:GetEnemy()
	local F = self:GetSpecialValueFor("bonus_max") + self:GetTalentValue("crystal_maiden_talent_10", "extra_count")
	local G = math.max(
		1,
		self:GetSpecialValueFor("bonus_per_ice") - self:GetTalentValue("crystal_maiden_talent_10", "threshold_reduce")
	)
	return math.min(F, math.floor(GetIce(D) / G))
end
function B.prototype.FreezingFieldExplosion(self, E, H)
	if H == nil then
		H = 100
	end
	local C = self:GetCaster()
	local D = C:GetEnemy()
	if not IsValid(D) then
		return
	end
	local I = D:GetAbsOrigin()
	local J = (self:GetSpecialValueFor("damage") + self:GetTalentValue("crystal_maiden_talent_1", "damage_bonus"))
		* H
		* 0.01
	local K = self:GetSpecialValueFor("interval")
		* (1 - self:GetTalentValue("crystal_maiden_talent_2", "interval_reduce") * 0.01)
	local L = self:GetTalentValue("crystal_maiden_talent_3", "ice_damage")
	local M = self:GetTalentValue("crystal_maiden_talent_16", "chance")
	local N = self:GetSpecialValueFor("count")
	local O = K * (1 - self:GetSpecialValueFor("default_interval_pct") * 0.01)
	local P = 0
	local Q = 0
	self:GameTimer(0, function()
		if P < E and D:IsAlive() then
			P = P + 1
			local R = I + RandomVector(150)
			local S = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil,
				C
			)
			ParticleManager:SetParticleControl(S, 0, R)
			if P <= N then
				return O
			end
			return K
		end
	end)
	self:GameTimer(0.4, function()
		if Q < E and D:IsAlive() then
			Q = Q + 1
			local T = J
			if L > 0 then
				T = T + GetIce(D) * L * 0.01
			end
			if M > 0 then
				if self:PRD(M) then
					C:FindModifierByName("modifier_crystal_maiden_talent"):FrostNova()
				end
			end
			C:DealDamage(D, self, T, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			C:EmitSound("n_creep_ice_shaman.IceBomb.Target")
			if Q <= N then
				return O
			end
			return K
		else
			C:StopSound("hero_Crystal.freezingField.wind")
		end
	end)
end
B = e({ p(nil) }, B)
g.crystal_maiden_ult = B
g.crystal_maiden_talent_3 = c()
local U = g.crystal_maiden_talent_3
U.name = "crystal_maiden_talent_3"
d(U, i)
function U.prototype.GetIntrinsicModifierName(self)
	return "modifier_crystal_maiden_talent_3"
end
U = e({ j(nil) }, U)
g.crystal_maiden_talent_3 = U
g.modifier_crystal_maiden_talent_3 = c()
local V = g.modifier_crystal_maiden_talent_3
V.name = "modifier_crystal_maiden_talent_3"
d(V, l)
function V.prototype.GetAbilitySpecialValue(self)
	self.wisp_interval = self:GetAbilitySpecialValueFor("wisp_interval")
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
end
function V.prototype.OnIntervalThink(self)
	local v = self:GetParent()
	local W = self:GetAbility()
	local X = v:GetEnemy()
	local Y = v:FindModifierByName("modifier_sect_wisp")
	if IsValid(X) and IsValid(Y) and type(W.FreezingFieldExplosion) == "function" then
		local Z = Y:GetStackCount()
		if Z > 0 then
			W:FreezingFieldExplosion(1, self.damage_pct)
		end
	end
end
function V.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function V.prototype.OnBattleStart(self, s)
	if self.wisp_interval > 0 then
		self:StartIntervalThink(self.wisp_interval)
	end
end
function V.prototype.OnBattleEnd(self, s)
	self:StartIntervalThink(-1)
end
V = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	V
)
g.modifier_crystal_maiden_talent_3 = V
g.crystal_maiden_talent_6 = c()
local _ = g.crystal_maiden_talent_6
_.name = "crystal_maiden_talent_6"
d(_, i)
function _.prototype.GetIntrinsicModifierName(self)
	return "modifier_crystal_maiden_talent_6"
end
_ = e({ j(nil) }, _)
g.crystal_maiden_talent_6 = _
g.modifier_crystal_maiden_talent_6 = c()
local a0 = g.modifier_crystal_maiden_talent_6
a0.name = "modifier_crystal_maiden_talent_6"
d(a0, l)
function a0.prototype.GetAbilitySpecialValue(self)
	self.heal_ice_loss_pct = self:GetAbilitySpecialValueFor("heal_ice_loss_pct")
end
function a0.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ICE_LOSS] = { -1, self:GetParent() } }
end
function a0.prototype.OnIceLoss(self, s)
	local W = self:GetAbility()
	if IsValid(W) and W:GetLevel() > 0 then
		local a1 = Heal
		local a2 = self:GetParent()
		local a3 = s.iCount * self.heal_ice_loss_pct * 0.01
		local a4 = self:GetAbility()
		a1(a2, a3, a4 and a4:GetAbilityName(), "Ability")
	end
end
a0 = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	a0
)
g.modifier_crystal_maiden_talent_6 = a0
g.crystal_maiden_talent_8 = c()
local a5 = g.crystal_maiden_talent_8
a5.name = "crystal_maiden_talent_8"
d(a5, i)
function a5.prototype.GetIntrinsicModifierName(self)
	return "modifier_crystal_maiden_talent_8"
end
a5 = e({ j(nil) }, a5)
g.crystal_maiden_talent_8 = a5
g.modifier_crystal_maiden_talent_8 = c()
local a6 = g.modifier_crystal_maiden_talent_8
a6.name = "modifier_crystal_maiden_talent_8"
d(a6, l)
function a6.prototype.GetAbilitySpecialValue(self)
	self.ulti_power_per_victory = self:GetAbilitySpecialValueFor("ulti_power_per_victory")
end
function a6.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(PlayerData:getTotalWin(self:GetParent():GetPlayerOwnerID()) * self.ulti_power_per_victory)
	end
end
function a6.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER }
end
function a6.prototype.EOM_GetModifierUltiPower(self)
	return self:GetStackCount()
end
a6 = e(
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
	a6
)
g.modifier_crystal_maiden_talent_8 = a6
g.crystal_maiden_talent_9 = c()
local a7 = g.crystal_maiden_talent_9
a7.name = "crystal_maiden_talent_9"
d(a7, i)
function a7.prototype.GetIntrinsicModifierName(self)
	return "modifier_crystal_maiden_talent_9"
end
a7 = e({ j(nil) }, a7)
g.crystal_maiden_talent_9 = a7
g.modifier_crystal_maiden_talent_9 = c()
local a8 = g.modifier_crystal_maiden_talent_9
a8.name = "modifier_crystal_maiden_talent_9"
d(a8, l)
function a8.prototype.GetAbilitySpecialValue(self)
	self.fury_disrupt_chance = self:GetAbilitySpecialValueFor("fury_disrupt_chance")
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function a8.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 } }
end
function a8.prototype.OnCustomAbilityFullyCast(self, t)
	self:SetStackCount(1)
	self:StartIntervalThink(self.duration)
end
function a8.prototype.OnIntervalThink(self)
	self:SetStackCount(0)
	self:StartIntervalThink(-1)
end
function a8.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_FURY_PERCENTAGE }
end
function a8.prototype.EOM_GetModifierIgnoreFuryPercent(self, s)
	if self:GetStackCount() == 1 then
		return self.fury_disrupt_chance
	end
end
a8 = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	a8
)
g.modifier_crystal_maiden_talent_9 = a8
g.crystal_maiden_talent_12 = c()
local a9 = g.crystal_maiden_talent_12
a9.name = "crystal_maiden_talent_12"
d(a9, i)
function a9.prototype.GetIntrinsicModifierName(self)
	return "modifier_crystal_maiden_talent_12"
end
a9 = e({ j(nil) }, a9)
g.crystal_maiden_talent_12 = a9
g.modifier_crystal_maiden_talent_12 = c()
local aa = g.modifier_crystal_maiden_talent_12
aa.name = "modifier_crystal_maiden_talent_12"
d(aa, l)
function aa.prototype.GetAbilitySpecialValue(self)
	self.talent_12_chance = self:GetAbilitySpecialValueFor("talent_12_chance")
	self.talent_12_wisp_health = self:GetAbilitySpecialValueFor("talent_12_wisp_health")
end
function aa.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 } }
end
function aa.prototype.OnCustomAbilityFullyCast(self, t)
	local v = self:GetParent()
	if self.talent_12_wisp_health > 0 and self:PRD(self.talent_12_chance) then
		if not v:HasAbility("sect_wisp") then
			v:AddAbility("sect_wisp")
		end
		if IsValid(self.wisp) and self.wisp:IsAlive() then
			self.wisp:SetHealth(self.wisp:GetMaxHealth())
		else
			self.wisp = SummonWisp(v, self.talent_12_wisp_health)
		end
	end
end
aa = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	aa
)
g.modifier_crystal_maiden_talent_12 = aa
g.modifier_crystal_maiden_talent_14_buff = c()
local ab = g.modifier_crystal_maiden_talent_14_buff
ab.name = "modifier_crystal_maiden_talent_14_buff"
d(ab, l)
function ab.prototype.GetTexture(self)
	return "crystal_maiden_crystal_nova"
end
function ab.prototype.GetAbilitySpecialValue(self)
	self.tl14_ult_bonus = self:GetAbilityTalentValue("crystal_maiden_talent_14", "ult_bonus")
	self.tl14_max_stack = self:GetAbilityTalentValue("crystal_maiden_talent_14", "max_stack")
end
function ab.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(self.tl14_ult_bonus)
	end
end
function ab.prototype.OnRefresh(self, s)
	if IsServer() then
		local ac = self.tl14_max_stack * self.tl14_ult_bonus
		self:SetStackCount(math.min(self:GetStackCount() + self.tl14_ult_bonus, ac))
	end
end
function ab.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER }
end
function ab.prototype.EOM_GetModifierUltiPower(self)
	return self:GetStackCount()
end
ab = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	ab
)
g.modifier_crystal_maiden_talent_14_buff = ab
return g