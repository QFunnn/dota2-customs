--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
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
		["67"] = 97,
		["69"] = 60,
		["70"] = 100,
		["71"] = 101,
		["72"] = 102,
		["73"] = 103,
		["76"] = 100,
		["77"] = 107,
		["78"] = 108,
		["79"] = 109,
		["80"] = 107,
		["81"] = 111,
		["82"] = 112,
		["83"] = 113,
		["84"] = 113,
		["85"] = 113,
		["86"] = 112,
		["87"] = 114,
		["88"] = 114,
		["89"] = 114,
		["90"] = 112,
		["91"] = 115,
		["92"] = 115,
		["93"] = 115,
		["94"] = 112,
		["95"] = 116,
		["96"] = 116,
		["97"] = 116,
		["98"] = 112,
		["99"] = 117,
		["100"] = 117,
		["101"] = 117,
		["102"] = 112,
		["103"] = 112,
		["104"] = 111,
		["105"] = 120,
		["106"] = 121,
		["107"] = 121,
		["108"] = 121,
		["109"] = 121,
		["110"] = 121,
		["111"] = 122,
		["114"] = 125,
		["115"] = 126,
		["116"] = 127,
		["117"] = 128,
		["118"] = 129,
		["119"] = 129,
		["120"] = 129,
		["121"] = 129,
		["122"] = 129,
		["123"] = 129,
		["125"] = 120,
		["126"] = 133,
		["127"] = 134,
		["130"] = 135,
		["131"] = 136,
		["132"] = 137,
		["133"] = 138,
		["135"] = 133,
		["136"] = 141,
		["137"] = 142,
		["138"] = 143,
		["139"] = 144,
		["140"] = 145,
		["141"] = 146,
		["142"] = 146,
		["143"] = 146,
		["144"] = 146,
		["145"] = 146,
		["146"] = 147,
		["147"] = 148,
		["148"] = 148,
		["149"] = 148,
		["150"] = 149,
		["151"] = 150,
		["152"] = 151,
		["153"] = 152,
		["154"] = 152,
		["155"] = 152,
		["156"] = 152,
		["157"] = 152,
		["158"] = 152,
		["159"] = 152,
		["160"] = 153,
		["161"] = 154,
		["163"] = 156,
		["164"] = 157,
		["165"] = 157,
		["166"] = 157,
		["167"] = 157,
		["168"] = 157,
		["169"] = 157,
		["171"] = 159,
		["172"] = 160,
		["173"] = 160,
		["174"] = 160,
		["175"] = 160,
		["176"] = 160,
		["177"] = 160,
		["180"] = 148,
		["181"] = 148,
		["182"] = 141,
		["183"] = 165,
		["184"] = 166,
		["185"] = 165,
		["186"] = 168,
		["187"] = 170,
		["188"] = 171,
		["189"] = 172,
		["190"] = 173,
		["191"] = 174,
		["192"] = 175,
		["193"] = 176,
		["194"] = 177,
		["195"] = 177,
		["196"] = 177,
		["197"] = 177,
		["198"] = 177,
		["199"] = 177,
		["203"] = 181,
		["206"] = 182,
		["207"] = 183,
		["209"] = 168,
		["210"] = 186,
		["211"] = 187,
		["212"] = 188,
		["213"] = 189,
		["214"] = 190,
		["215"] = 191,
		["216"] = 192,
		["217"] = 193,
		["218"] = 194,
		["222"] = 186,
		["223"] = 199,
		["224"] = 200,
		["225"] = 201,
		["226"] = 202,
		["228"] = 204,
		["229"] = 205,
		["231"] = 208,
		["232"] = 209,
		["233"] = 210,
		["234"] = 210,
		["235"] = 210,
		["236"] = 211,
		["237"] = 211,
		["238"] = 211,
		["239"] = 211,
		["240"] = 211,
		["241"] = 210,
		["242"] = 210,
		["244"] = 215,
		["245"] = 216,
		["246"] = 217,
		["249"] = 199,
		["250"] = 221,
		["251"] = 222,
		["252"] = 221,
		["253"] = 226,
		["254"] = 227,
		["255"] = 226,
		["256"] = 22,
		["257"] = 14,
		["258"] = 14,
		["259"] = 14,
		["260"] = 14,
		["261"] = 14,
		["262"] = 14,
		["263"] = 14,
		["264"] = 14,
		["265"] = 22,
		["267"] = 22,
		["269"] = 232,
		["270"] = 233,
		["271"] = 232,
		["272"] = 233,
		["273"] = 234,
		["274"] = 235,
		["275"] = 236,
		["276"] = 237,
		["277"] = 238,
		["280"] = 239,
		["281"] = 240,
		["282"] = 241,
		["283"] = 242,
		["284"] = 234,
		["285"] = 245,
		["286"] = 246,
		["287"] = 247,
		["288"] = 248,
		["289"] = 249,
		["290"] = 249,
		["291"] = 249,
		["292"] = 249,
		["293"] = 250,
		["294"] = 250,
		["295"] = 250,
		["296"] = 250,
		["297"] = 245,
		["298"] = 252,
		["299"] = 252,
		["300"] = 252,
		["302"] = 253,
		["303"] = 254,
		["304"] = 255,
		["307"] = 257,
		["308"] = 258,
		["309"] = 259,
		["310"] = 261,
		["311"] = 262,
		["312"] = 264,
		["313"] = 265,
		["314"] = 266,
		["315"] = 267,
		["316"] = 268,
		["317"] = 268,
		["318"] = 268,
		["319"] = 269,
		["320"] = 270,
		["321"] = 271,
		["322"] = 272,
		["323"] = 273,
		["324"] = 274,
		["325"] = 275,
		["327"] = 277,
		["329"] = 268,
		["330"] = 268,
		["331"] = 280,
		["332"] = 280,
		["333"] = 280,
		["334"] = 281,
		["335"] = 282,
		["336"] = 283,
		["337"] = 284,
		["338"] = 285,
		["340"] = 287,
		["341"] = 288,
		["342"] = 289,
		["345"] = 292,
		["346"] = 293,
		["347"] = 294,
		["348"] = 295,
		["350"] = 297,
		["352"] = 299,
		["354"] = 280,
		["355"] = 280,
		["356"] = 252,
		["357"] = 233,
		["358"] = 232,
		["359"] = 233,
		["361"] = 233,
		["363"] = 307,
		["364"] = 308,
		["365"] = 307,
		["366"] = 308,
		["367"] = 309,
		["368"] = 310,
		["369"] = 309,
		["370"] = 308,
		["371"] = 307,
		["372"] = 308,
		["374"] = 308,
		["375"] = 313,
		["376"] = 320,
		["377"] = 313,
		["378"] = 320,
		["379"] = 323,
		["380"] = 324,
		["381"] = 325,
		["382"] = 323,
		["383"] = 327,
		["384"] = 328,
		["385"] = 329,
		["386"] = 330,
		["387"] = 331,
		["388"] = 332,
		["389"] = 333,
		["390"] = 334,
		["391"] = 335,
		["394"] = 327,
		["395"] = 339,
		["396"] = 340,
		["397"] = 340,
		["398"] = 342,
		["399"] = 342,
		["400"] = 342,
		["401"] = 340,
		["402"] = 340,
		["403"] = 339,
		["404"] = 345,
		["405"] = 346,
		["406"] = 347,
		["408"] = 345,
		["409"] = 350,
		["410"] = 351,
		["411"] = 350,
		["412"] = 320,
		["413"] = 313,
		["414"] = 313,
		["415"] = 313,
		["416"] = 313,
		["417"] = 313,
		["418"] = 313,
		["419"] = 313,
		["420"] = 320,
		["422"] = 320,
		["424"] = 356,
		["425"] = 357,
		["426"] = 356,
		["427"] = 357,
		["428"] = 358,
		["429"] = 359,
		["430"] = 358,
		["431"] = 357,
		["432"] = 356,
		["433"] = 357,
		["435"] = 357,
		["436"] = 362,
		["437"] = 369,
		["438"] = 362,
		["439"] = 369,
		["440"] = 371,
		["441"] = 372,
		["442"] = 371,
		["443"] = 374,
		["444"] = 375,
		["445"] = 376,
		["446"] = 376,
		["447"] = 375,
		["448"] = 374,
		["449"] = 379,
		["450"] = 380,
		["451"] = 381,
		["452"] = 382,
		["453"] = 382,
		["454"] = 382,
		["455"] = 382,
		["456"] = 382,
		["457"] = 382,
		["458"] = 382,
		["459"] = 382,
		["460"] = 382,
		["461"] = 382,
		["463"] = 379,
		["464"] = 369,
		["465"] = 362,
		["466"] = 362,
		["467"] = 362,
		["468"] = 362,
		["469"] = 362,
		["470"] = 362,
		["471"] = 362,
		["472"] = 369,
		["474"] = 369,
		["476"] = 388,
		["477"] = 389,
		["478"] = 388,
		["479"] = 389,
		["480"] = 390,
		["481"] = 391,
		["482"] = 390,
		["483"] = 389,
		["484"] = 388,
		["485"] = 389,
		["487"] = 389,
		["488"] = 394,
		["489"] = 402,
		["490"] = 394,
		["491"] = 402,
		["492"] = 404,
		["493"] = 405,
		["494"] = 404,
		["495"] = 407,
		["496"] = 408,
		["497"] = 409,
		["499"] = 407,
		["500"] = 412,
		["501"] = 413,
		["502"] = 412,
		["503"] = 417,
		["504"] = 418,
		["505"] = 417,
		["506"] = 402,
		["507"] = 394,
		["508"] = 394,
		["509"] = 394,
		["510"] = 394,
		["511"] = 394,
		["512"] = 394,
		["513"] = 394,
		["514"] = 394,
		["515"] = 402,
		["517"] = 402,
		["519"] = 423,
		["520"] = 424,
		["521"] = 423,
		["522"] = 424,
		["523"] = 425,
		["524"] = 426,
		["525"] = 425,
		["526"] = 424,
		["527"] = 423,
		["528"] = 424,
		["530"] = 424,
		["531"] = 429,
		["532"] = 436,
		["533"] = 429,
		["534"] = 436,
		["535"] = 439,
		["536"] = 440,
		["537"] = 441,
		["538"] = 439,
		["539"] = 443,
		["540"] = 444,
		["541"] = 445,
		["542"] = 445,
		["543"] = 444,
		["544"] = 443,
		["545"] = 448,
		["546"] = 449,
		["547"] = 450,
		["548"] = 448,
		["549"] = 452,
		["550"] = 453,
		["551"] = 454,
		["552"] = 452,
		["553"] = 456,
		["554"] = 457,
		["555"] = 456,
		["556"] = 461,
		["557"] = 462,
		["558"] = 463,
		["560"] = 461,
		["561"] = 436,
		["562"] = 429,
		["563"] = 429,
		["564"] = 429,
		["565"] = 429,
		["566"] = 429,
		["567"] = 429,
		["568"] = 429,
		["569"] = 436,
		["571"] = 436,
		["573"] = 469,
		["574"] = 470,
		["575"] = 469,
		["576"] = 470,
		["577"] = 471,
		["578"] = 472,
		["579"] = 471,
		["580"] = 470,
		["581"] = 469,
		["582"] = 470,
		["584"] = 470,
		["585"] = 475,
		["586"] = 482,
		["587"] = 475,
		["588"] = 482,
		["589"] = 486,
		["590"] = 487,
		["591"] = 488,
		["592"] = 486,
		["593"] = 490,
		["594"] = 491,
		["595"] = 492,
		["596"] = 492,
		["597"] = 491,
		["598"] = 490,
		["599"] = 495,
		["600"] = 496,
		["601"] = 497,
		["602"] = 498,
		["603"] = 499,
		["605"] = 501,
		["606"] = 502,
		["608"] = 504,
		["611"] = 495,
		["612"] = 482,
		["613"] = 475,
		["614"] = 475,
		["615"] = 475,
		["616"] = 475,
		["617"] = 475,
		["618"] = 475,
		["619"] = 475,
		["620"] = 482,
		["622"] = 482,
		["623"] = 510,
		["624"] = 517,
		["625"] = 510,
		["626"] = 517,
		["627"] = 520,
		["628"] = 521,
		["629"] = 520,
		["630"] = 523,
		["631"] = 524,
		["632"] = 525,
		["633"] = 523,
		["634"] = 527,
		["635"] = 528,
		["636"] = 529,
		["638"] = 527,
		["639"] = 532,
		["640"] = 533,
		["641"] = 534,
		["642"] = 535,
		["643"] = 535,
		["644"] = 535,
		["645"] = 535,
		["647"] = 532,
		["648"] = 538,
		["649"] = 539,
		["650"] = 538,
		["651"] = 543,
		["652"] = 544,
		["653"] = 543,
		["654"] = 517,
		["655"] = 510,
		["656"] = 510,
		["657"] = 510,
		["658"] = 510,
		["659"] = 510,
		["660"] = 510,
		["661"] = 510,
		["662"] = 517,
		["664"] = 517,
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
	local s = IsServer() and PlayerData:getTraitAbility(self:GetParent():GetPlayerOwnerID()) or nil
	self.g_mana_cost = (s and s:GetAbilityName()) == "trait_189" and s:GetSpecialValueFor("mana_cost") or 0
	self.g_shield = (s and s:GetAbilityName()) == "trait_189" and s:GetSpecialValueFor("shield") or 0
	if IsServer() then
		self.tl5_record = 0
		self.g_mana_record = 0
		self.mana_reply_record = 0
	end
end
function r.prototype.OnCreated(self, t)
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
function r.prototype.OnCustomAbilityFullyCast(self, u)
	print(u.ability:GetManaCost(1), self.g_mana_cost, self.g_shield)
	if self.g_mana_cost <= 0 or self.g_shield <= 0 then
		return
	end
	self.g_mana_record = self.g_mana_record + u.ability:GetManaCost(1)
	if self.g_mana_record >= self.g_mana_cost then
		local v = math.floor(self.g_mana_record / self.g_mana_cost)
		self.g_mana_record = self.g_mana_record % self.g_mana_cost
		AddShield(self:GetParent(), v * self.g_shield, "greevil_effect_1", "Ability")
	end
end
function r.prototype.OnRestore(self, t)
	if self.mana_reply <= 0 then
		return
	end
	self.mana_reply_record = self.mana_reply_record + t.count
	if self.mana_reply_record >= self.mana_reply then
		self.mana_reply_record = self.mana_reply_record % self.mana_reply
		self:FrostNova()
	end
end
function r.prototype.FrostNova(self)
	local w = self:GetParent()
	local x = w:GetEnemy()
	EmitSoundOn("Hero_Crystal.CrystalNova", w)
	local y = ParticleManager:CreateParticle(
		"particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_cowlofice.vpcf",
		PATTACH_ABSORIGIN,
		x,
		w
	)
	ParticleManager:SetParticleControl(y, 0, x:GetAbsOrigin())
	w:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	GameTimer(0.6, function()
		if IsInjurable(x, w) then
			local z = self.parent:FindAbilityByName("crystal_maiden_crystal_nova")
			w:DealDamage(x, z, self.ice_star_damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			AddIce(w, x, self.ice, "crystal_maiden_crystal_nova", "Ability")
			if self:HasTalent("crystal_maiden_talent_13") then
				AddShield(
					w,
					self.tl13_damage_shield * self.ice_star_damage * 0.01,
					"crystal_maiden_crystal_nova",
					"Ability"
				)
			end
			if self:HasTalent("crystal_maiden_talent_14") then
				w:AddNewModifier(w, self:GetAbility(), "modifier_crystal_maiden_talent_14_buff", {})
			end
			if self:HasTalent("crystal_maiden_talent_15") then
				AddStun(self.parent, self.parent:GetEnemy(), z, self.tl15_stun_duration)
			end
		end
	end)
end
function r.prototype.OnBattleEnd(self, t)
	self:GetParent():RemoveModifierByName("modifier_crystal_maiden_talent_14_buff")
end
function r.prototype.OnIceGained(self, t)
	if self.tl5_ice_stack > 0 then
		self.tl5_record = self.tl5_record + t.iStackCount
		if self.tl5_record >= self.tl5_ice_stack then
			local w = self:GetParent()
			local x = w:GetEnemy()
			self.tl5_record = 0
			if IsInjurable(x, w) then
				AddStun(w, x, self:GetAbility(), self.tl5_stun_duration)
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
function r.prototype.OnCustomAttackLanded(self, u)
	if self.s_chance > 0 and self:PRD(self.s_chance, "s_chance") then
		local z = self:GetParent():FindAbilityByName("crystal_maiden_ult")
		if IsValid(z) then
			z:FreezingFieldExplosion(1)
			if self.shard_trigger_explosion then
				self.shard_trigger_explosion = false
				self:StartIntervalThink(self.shard_interval)
				z:FreezingFieldExplosion(z and z:GetExtraCount())
			end
		end
	end
end
function r.prototype.BrillianceAura(self)
	local w = self:GetParent()
	if self.s_attack_speed == 0 then
		Restore(w, self.mana)
	else
		local v = self:GetStackCount()
		self:SetStackCount(math.min(v + self.s_attack_speed, self.s_attack_speed_max))
	end
	local A = self.mana * self.wisp_heal * 0.01
	if self.wisp_heal > 0 then
		EachWisp(w, function(B)
			B:Heal(A, self:GetAbility(), true)
		end)
	end
	if self.talent_11_chance > 0 then
		if self:PRD(self.talent_11_chance, "talent_11") then
			Heal(w, self.talent_11_heal, "crystal_maiden_talent_11", "Ability")
		end
	end
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_TOTAL_PERCENTAGE }
end
function r.prototype.EOM_GetModifierAttackSpeedTotalPercentage(self, t)
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
local C = g.crystal_maiden_ult
C.name = "crystal_maiden_ult"
d(C, o)
function C.prototype.OnSpellStart(self)
	local D = self:GetCaster()
	D:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	local E = D:GetEnemy()
	if not IsValid(E) then
		return
	end
	local v = self:GetSpecialValueFor("count") + self:GetTalentValue("crystal_maiden_talent_10", "base_count")
	local F = v + self:GetExtraCount()
	self:FreezingFieldExplosion(F)
	D:EmitSound("hero_Crystal.freezingField.wind")
end
function C.prototype.GetExtraCount(self)
	local D = self:GetCaster()
	local E = D:GetEnemy()
	local G = self:GetSpecialValueFor("bonus_max") + self:GetTalentValue("crystal_maiden_talent_10", "extra_count")
	local H = math.max(
		1,
		self:GetSpecialValueFor("bonus_per_ice") - self:GetTalentValue("crystal_maiden_talent_10", "threshold_reduce")
	)
	return math.min(G, math.floor(GetIce(E) / H))
end
function C.prototype.FreezingFieldExplosion(self, F, I)
	if I == nil then
		I = 100
	end
	local D = self:GetCaster()
	local E = D:GetEnemy()
	if not IsValid(E) then
		return
	end
	local J = E:GetAbsOrigin()
	local K = (self:GetSpecialValueFor("damage") + self:GetTalentValue("crystal_maiden_talent_1", "damage_bonus"))
		* I
		* 0.01
	local L = self:GetSpecialValueFor("interval")
		* (1 - self:GetTalentValue("crystal_maiden_talent_2", "interval_reduce") * 0.01)
	local M = self:GetTalentValue("crystal_maiden_talent_3", "ice_damage")
	local N = self:GetTalentValue("crystal_maiden_talent_16", "chance")
	local O = self:GetSpecialValueFor("count")
	local P = L * (1 - self:GetSpecialValueFor("default_interval_pct") * 0.01)
	local Q = 0
	local R = 0
	self:GameTimer(0, function()
		if Q < F and E:IsAlive() then
			Q = Q + 1
			local S = J + RandomVector(150)
			local T = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil,
				D
			)
			ParticleManager:SetParticleControl(T, 0, S)
			if Q <= O then
				return P
			end
			return L
		end
	end)
	self:GameTimer(0.4, function()
		if R < F and E:IsAlive() then
			R = R + 1
			local U = K
			if M > 0 then
				U = U + GetIce(E) * M * 0.01
			end
			if N > 0 then
				if self:PRD(N) then
					D:FindModifierByName("modifier_crystal_maiden_talent"):FrostNova()
				end
			end
			D:DealDamage(E, self, U, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			D:EmitSound("n_creep_ice_shaman.IceBomb.Target")
			if R <= O then
				return P
			end
			return L
		else
			D:StopSound("hero_Crystal.freezingField.wind")
		end
	end)
end
C = e({ p(nil) }, C)
g.crystal_maiden_ult = C
g.crystal_maiden_talent_3 = c()
local V = g.crystal_maiden_talent_3
V.name = "crystal_maiden_talent_3"
d(V, i)
function V.prototype.GetIntrinsicModifierName(self)
	return "modifier_crystal_maiden_talent_3"
end
V = e({ j(nil) }, V)
g.crystal_maiden_talent_3 = V
g.modifier_crystal_maiden_talent_3 = c()
local W = g.modifier_crystal_maiden_talent_3
W.name = "modifier_crystal_maiden_talent_3"
d(W, l)
function W.prototype.GetAbilitySpecialValue(self)
	self.wisp_interval = self:GetAbilitySpecialValueFor("wisp_interval")
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
end
function W.prototype.OnIntervalThink(self)
	local w = self:GetParent()
	local X = self:GetAbility()
	local Y = w:GetEnemy()
	local Z = w:FindModifierByName("modifier_sect_wisp")
	if IsValid(Y) and IsValid(Z) and type(X.FreezingFieldExplosion) == "function" then
		local _ = Z:GetStackCount()
		if _ > 0 then
			X:FreezingFieldExplosion(1, self.damage_pct)
		end
	end
end
function W.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function W.prototype.OnBattleStart(self, t)
	if self.wisp_interval > 0 then
		self:StartIntervalThink(self.wisp_interval)
	end
end
function W.prototype.OnBattleEnd(self, t)
	self:StartIntervalThink(-1)
end
W = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	W
)
g.modifier_crystal_maiden_talent_3 = W
g.crystal_maiden_talent_6 = c()
local a0 = g.crystal_maiden_talent_6
a0.name = "crystal_maiden_talent_6"
d(a0, i)
function a0.prototype.GetIntrinsicModifierName(self)
	return "modifier_crystal_maiden_talent_6"
end
a0 = e({ j(nil) }, a0)
g.crystal_maiden_talent_6 = a0
g.modifier_crystal_maiden_talent_6 = c()
local a1 = g.modifier_crystal_maiden_talent_6
a1.name = "modifier_crystal_maiden_talent_6"
d(a1, l)
function a1.prototype.GetAbilitySpecialValue(self)
	self.heal_ice_loss_pct = self:GetAbilitySpecialValueFor("heal_ice_loss_pct")
end
function a1.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ICE_LOSS] = { -1, self:GetParent() } }
end
function a1.prototype.OnIceLoss(self, t)
	local X = self:GetAbility()
	if IsValid(X) and X:GetLevel() > 0 then
		local a2 = Heal
		local a3 = self:GetParent()
		local a4 = t.iCount * self.heal_ice_loss_pct * 0.01
		local a5 = self:GetAbility()
		a2(a3, a4, a5 and a5:GetAbilityName(), "Ability")
	end
end
a1 = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	a1
)
g.modifier_crystal_maiden_talent_6 = a1
g.crystal_maiden_talent_8 = c()
local a6 = g.crystal_maiden_talent_8
a6.name = "crystal_maiden_talent_8"
d(a6, i)
function a6.prototype.GetIntrinsicModifierName(self)
	return "modifier_crystal_maiden_talent_8"
end
a6 = e({ j(nil) }, a6)
g.crystal_maiden_talent_8 = a6
g.modifier_crystal_maiden_talent_8 = c()
local a7 = g.modifier_crystal_maiden_talent_8
a7.name = "modifier_crystal_maiden_talent_8"
d(a7, l)
function a7.prototype.GetAbilitySpecialValue(self)
	self.ulti_power_per_victory = self:GetAbilitySpecialValueFor("ulti_power_per_victory")
end
function a7.prototype.OnCreated(self, t)
	if IsServer() then
		self:SetStackCount(PlayerData:getTotalWin(self:GetParent():GetPlayerOwnerID()) * self.ulti_power_per_victory)
	end
end
function a7.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER }
end
function a7.prototype.EOM_GetModifierUltiPower(self)
	return self:GetStackCount()
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
g.modifier_crystal_maiden_talent_8 = a7
g.crystal_maiden_talent_9 = c()
local a8 = g.crystal_maiden_talent_9
a8.name = "crystal_maiden_talent_9"
d(a8, i)
function a8.prototype.GetIntrinsicModifierName(self)
	return "modifier_crystal_maiden_talent_9"
end
a8 = e({ j(nil) }, a8)
g.crystal_maiden_talent_9 = a8
g.modifier_crystal_maiden_talent_9 = c()
local a9 = g.modifier_crystal_maiden_talent_9
a9.name = "modifier_crystal_maiden_talent_9"
d(a9, l)
function a9.prototype.GetAbilitySpecialValue(self)
	self.fury_disrupt_chance = self:GetAbilitySpecialValueFor("fury_disrupt_chance")
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function a9.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 } }
end
function a9.prototype.OnCustomAbilityFullyCast(self, u)
	self:SetStackCount(1)
	self:StartIntervalThink(self.duration)
end
function a9.prototype.OnIntervalThink(self)
	self:SetStackCount(0)
	self:StartIntervalThink(-1)
end
function a9.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_FURY_PERCENTAGE }
end
function a9.prototype.EOM_GetModifierIgnoreFuryPercent(self, t)
	if self:GetStackCount() == 1 then
		return self.fury_disrupt_chance
	end
end
a9 = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	a9
)
g.modifier_crystal_maiden_talent_9 = a9
g.crystal_maiden_talent_12 = c()
local aa = g.crystal_maiden_talent_12
aa.name = "crystal_maiden_talent_12"
d(aa, i)
function aa.prototype.GetIntrinsicModifierName(self)
	return "modifier_crystal_maiden_talent_12"
end
aa = e({ j(nil) }, aa)
g.crystal_maiden_talent_12 = aa
g.modifier_crystal_maiden_talent_12 = c()
local ab = g.modifier_crystal_maiden_talent_12
ab.name = "modifier_crystal_maiden_talent_12"
d(ab, l)
function ab.prototype.GetAbilitySpecialValue(self)
	self.talent_12_chance = self:GetAbilitySpecialValueFor("talent_12_chance")
	self.talent_12_wisp_health = self:GetAbilitySpecialValueFor("talent_12_wisp_health")
end
function ab.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 } }
end
function ab.prototype.OnCustomAbilityFullyCast(self, u)
	local w = self:GetParent()
	if self.talent_12_wisp_health > 0 and self:PRD(self.talent_12_chance) then
		if not w:HasAbility("sect_wisp") then
			w:AddAbility("sect_wisp")
		end
		if IsValid(self.wisp) and self.wisp:IsAlive() then
			self.wisp:SetHealth(self.wisp:GetMaxHealth())
		else
			self.wisp = SummonWisp(w, self.talent_12_wisp_health)
		end
	end
end
ab = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	ab
)
g.modifier_crystal_maiden_talent_12 = ab
g.modifier_crystal_maiden_talent_14_buff = c()
local ac = g.modifier_crystal_maiden_talent_14_buff
ac.name = "modifier_crystal_maiden_talent_14_buff"
d(ac, l)
function ac.prototype.GetTexture(self)
	return "crystal_maiden_crystal_nova"
end
function ac.prototype.GetAbilitySpecialValue(self)
	self.tl14_ult_bonus = self:GetAbilityTalentValue("crystal_maiden_talent_14", "ult_bonus")
	self.tl14_max_stack = self:GetAbilityTalentValue("crystal_maiden_talent_14", "max_stack")
end
function ac.prototype.OnCreated(self, t)
	if IsServer() then
		self:SetStackCount(self.tl14_ult_bonus)
	end
end
function ac.prototype.OnRefresh(self, t)
	if IsServer() then
		local ad = self.tl14_max_stack * self.tl14_ult_bonus
		self:SetStackCount(math.min(self:GetStackCount() + self.tl14_ult_bonus, ad))
	end
end
function ac.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER }
end
function ac.prototype.EOM_GetModifierUltiPower(self)
	return self:GetStackCount()
end
ac = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	ac
)
g.modifier_crystal_maiden_talent_14_buff = ac
return g