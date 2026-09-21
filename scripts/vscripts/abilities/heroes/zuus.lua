--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/zuus"
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
		["17"] = 5,
		["19"] = 10,
		["20"] = 11,
		["21"] = 10,
		["22"] = 11,
		["23"] = 12,
		["24"] = 13,
		["25"] = 12,
		["26"] = 11,
		["27"] = 10,
		["28"] = 11,
		["30"] = 11,
		["31"] = 17,
		["32"] = 25,
		["33"] = 17,
		["34"] = 25,
		["36"] = 25,
		["37"] = 28,
		["38"] = 29,
		["39"] = 38,
		["40"] = 40,
		["41"] = 17,
		["42"] = 45,
		["43"] = 46,
		["44"] = 47,
		["45"] = 49,
		["46"] = 50,
		["47"] = 52,
		["48"] = 53,
		["49"] = 54,
		["50"] = 56,
		["51"] = 58,
		["52"] = 59,
		["53"] = 45,
		["54"] = 61,
		["55"] = 62,
		["56"] = 63,
		["58"] = 61,
		["59"] = 66,
		["60"] = 67,
		["61"] = 67,
		["62"] = 69,
		["63"] = 69,
		["64"] = 69,
		["65"] = 67,
		["66"] = 70,
		["67"] = 70,
		["68"] = 70,
		["69"] = 67,
		["70"] = 71,
		["71"] = 71,
		["72"] = 71,
		["73"] = 67,
		["74"] = 67,
		["75"] = 66,
		["76"] = 74,
		["77"] = 75,
		["78"] = 74,
		["79"] = 79,
		["80"] = 80,
		["81"] = 81,
		["82"] = 82,
		["83"] = 83,
		["84"] = 79,
		["85"] = 85,
		["86"] = 86,
		["89"] = 87,
		["92"] = 88,
		["93"] = 89,
		["94"] = 90,
		["95"] = 91,
		["96"] = 92,
		["97"] = 92,
		["98"] = 92,
		["99"] = 92,
		["100"] = 93,
		["101"] = 92,
		["102"] = 92,
		["104"] = 85,
		["105"] = 97,
		["106"] = 98,
		["107"] = 99,
		["108"] = 99,
		["109"] = 99,
		["110"] = 99,
		["112"] = 97,
		["113"] = 102,
		["114"] = 103,
		["117"] = 104,
		["118"] = 105,
		["119"] = 106,
		["122"] = 107,
		["123"] = 108,
		["126"] = 109,
		["127"] = 111,
		["128"] = 111,
		["129"] = 111,
		["130"] = 111,
		["131"] = 111,
		["132"] = 111,
		["133"] = 113,
		["134"] = 114,
		["135"] = 114,
		["136"] = 114,
		["137"] = 114,
		["138"] = 114,
		["139"] = 114,
		["140"] = 114,
		["141"] = 114,
		["142"] = 114,
		["143"] = 115,
		["144"] = 115,
		["145"] = 115,
		["146"] = 115,
		["147"] = 115,
		["148"] = 115,
		["149"] = 115,
		["150"] = 115,
		["151"] = 115,
		["152"] = 116,
		["153"] = 116,
		["154"] = 116,
		["155"] = 116,
		["156"] = 116,
		["157"] = 116,
		["158"] = 116,
		["159"] = 116,
		["160"] = 117,
		["161"] = 118,
		["162"] = 118,
		["163"] = 118,
		["164"] = 118,
		["165"] = 118,
		["166"] = 118,
		["167"] = 118,
		["168"] = 118,
		["169"] = 118,
		["170"] = 102,
		["171"] = 128,
		["172"] = 128,
		["173"] = 128,
		["175"] = 128,
		["176"] = 128,
		["178"] = 129,
		["179"] = 130,
		["180"] = 131,
		["181"] = 132,
		["184"] = 133,
		["185"] = 134,
		["186"] = 135,
		["188"] = 138,
		["189"] = 138,
		["190"] = 138,
		["191"] = 139,
		["194"] = 140,
		["197"] = 142,
		["198"] = 143,
		["199"] = 143,
		["200"] = 143,
		["201"] = 143,
		["202"] = 143,
		["203"] = 143,
		["204"] = 143,
		["205"] = 143,
		["206"] = 143,
		["207"] = 144,
		["208"] = 144,
		["209"] = 144,
		["210"] = 144,
		["211"] = 144,
		["212"] = 144,
		["213"] = 144,
		["214"] = 144,
		["215"] = 144,
		["216"] = 145,
		["217"] = 146,
		["218"] = 146,
		["219"] = 146,
		["220"] = 146,
		["221"] = 146,
		["222"] = 147,
		["223"] = 148,
		["224"] = 148,
		["225"] = 148,
		["226"] = 148,
		["227"] = 148,
		["228"] = 148,
		["229"] = 148,
		["230"] = 148,
		["231"] = 148,
		["232"] = 149,
		["233"] = 149,
		["234"] = 149,
		["235"] = 149,
		["236"] = 149,
		["237"] = 149,
		["238"] = 149,
		["239"] = 149,
		["240"] = 149,
		["241"] = 150,
		["243"] = 152,
		["244"] = 153,
		["245"] = 154,
		["246"] = 155,
		["247"] = 156,
		["248"] = 158,
		["249"] = 159,
		["250"] = 160,
		["252"] = 162,
		["253"] = 162,
		["254"] = 162,
		["255"] = 162,
		["256"] = 162,
		["257"] = 162,
		["258"] = 162,
		["259"] = 162,
		["260"] = 162,
		["261"] = 172,
		["262"] = 173,
		["263"] = 174,
		["264"] = 175,
		["265"] = 176,
		["266"] = 177,
		["267"] = 178,
		["268"] = 179,
		["269"] = 179,
		["270"] = 179,
		["271"] = 179,
		["272"] = 179,
		["273"] = 180,
		["274"] = 180,
		["275"] = 180,
		["276"] = 180,
		["277"] = 180,
		["278"] = 180,
		["279"] = 180,
		["280"] = 180,
		["281"] = 180,
		["282"] = 181,
		["283"] = 182,
		["284"] = 183,
		["285"] = 183,
		["286"] = 183,
		["287"] = 183,
		["288"] = 183,
		["289"] = 183,
		["290"] = 183,
		["291"] = 183,
		["292"] = 183,
		["293"] = 193,
		["296"] = 196,
		["297"] = 197,
		["298"] = 198,
		["299"] = 199,
		["300"] = 200,
		["301"] = 200,
		["302"] = 200,
		["303"] = 200,
		["304"] = 200,
		["305"] = 200,
		["308"] = 138,
		["309"] = 138,
		["311"] = 128,
		["312"] = 25,
		["313"] = 17,
		["314"] = 17,
		["315"] = 17,
		["316"] = 17,
		["317"] = 17,
		["318"] = 17,
		["319"] = 17,
		["320"] = 17,
		["321"] = 25,
		["323"] = 25,
		["324"] = 208,
		["325"] = 216,
		["326"] = 208,
		["327"] = 216,
		["328"] = 219,
		["329"] = 220,
		["330"] = 219,
		["331"] = 222,
		["332"] = 223,
		["333"] = 224,
		["334"] = 222,
		["335"] = 226,
		["336"] = 227,
		["337"] = 228,
		["338"] = 228,
		["339"] = 228,
		["340"] = 228,
		["342"] = 226,
		["343"] = 231,
		["344"] = 232,
		["345"] = 233,
		["346"] = 233,
		["347"] = 233,
		["348"] = 233,
		["350"] = 231,
		["351"] = 236,
		["352"] = 237,
		["353"] = 236,
		["354"] = 241,
		["355"] = 242,
		["356"] = 241,
		["357"] = 216,
		["358"] = 208,
		["359"] = 208,
		["360"] = 208,
		["361"] = 208,
		["362"] = 208,
		["363"] = 208,
		["364"] = 208,
		["365"] = 208,
		["366"] = 216,
		["368"] = 216,
		["370"] = 249,
		["371"] = 250,
		["372"] = 249,
		["373"] = 250,
		["374"] = 251,
		["375"] = 252,
		["376"] = 253,
		["377"] = 254,
		["378"] = 255,
		["379"] = 257,
		["380"] = 258,
		["381"] = 261,
		["382"] = 261,
		["383"] = 261,
		["384"] = 262,
		["387"] = 264,
		["388"] = 265,
		["389"] = 265,
		["390"] = 265,
		["391"] = 265,
		["392"] = 265,
		["393"] = 265,
		["394"] = 265,
		["395"] = 265,
		["396"] = 265,
		["397"] = 274,
		["398"] = 275,
		["399"] = 275,
		["400"] = 275,
		["401"] = 275,
		["402"] = 275,
		["403"] = 276,
		["404"] = 276,
		["405"] = 276,
		["406"] = 276,
		["407"] = 276,
		["408"] = 276,
		["409"] = 276,
		["410"] = 276,
		["411"] = 276,
		["412"] = 277,
		["413"] = 261,
		["414"] = 261,
		["415"] = 251,
		["416"] = 281,
		["417"] = 282,
		["418"] = 283,
		["419"] = 281,
		["420"] = 286,
		["421"] = 287,
		["422"] = 286,
		["423"] = 250,
		["424"] = 249,
		["425"] = 250,
		["427"] = 250,
		["428"] = 291,
		["429"] = 299,
		["430"] = 291,
		["431"] = 299,
		["432"] = 303,
		["433"] = 304,
		["434"] = 305,
		["435"] = 303,
		["436"] = 307,
		["437"] = 308,
		["438"] = 307,
		["439"] = 312,
		["440"] = 314,
		["441"] = 315,
		["442"] = 316,
		["443"] = 317,
		["444"] = 318,
		["445"] = 318,
		["446"] = 318,
		["447"] = 318,
		["448"] = 318,
		["449"] = 318,
		["452"] = 312,
		["453"] = 299,
		["454"] = 291,
		["455"] = 291,
		["456"] = 291,
		["457"] = 291,
		["458"] = 291,
		["459"] = 291,
		["460"] = 291,
		["461"] = 291,
		["462"] = 299,
		["464"] = 299,
		["465"] = 324,
		["466"] = 333,
		["467"] = 324,
		["468"] = 333,
		["469"] = 334,
		["470"] = 335,
		["471"] = 336,
		["472"] = 337,
		["473"] = 338,
		["474"] = 338,
		["475"] = 338,
		["476"] = 338,
		["477"] = 338,
		["478"] = 338,
		["479"] = 338,
		["480"] = 338,
		["481"] = 338,
		["482"] = 339,
		["483"] = 339,
		["484"] = 339,
		["485"] = 339,
		["486"] = 339,
		["487"] = 339,
		["488"] = 339,
		["489"] = 339,
		["490"] = 339,
		["492"] = 341,
		["494"] = 334,
		["495"] = 344,
		["496"] = 345,
		["497"] = 346,
		["498"] = 347,
		["499"] = 348,
		["500"] = 348,
		["501"] = 348,
		["502"] = 348,
		["503"] = 348,
		["504"] = 348,
		["505"] = 348,
		["506"] = 348,
		["507"] = 348,
		["508"] = 349,
		["509"] = 349,
		["510"] = 349,
		["511"] = 349,
		["512"] = 349,
		["513"] = 349,
		["514"] = 349,
		["515"] = 349,
		["516"] = 349,
		["518"] = 351,
		["520"] = 344,
		["521"] = 354,
		["522"] = 355,
		["524"] = 354,
		["525"] = 333,
		["526"] = 324,
		["527"] = 324,
		["528"] = 324,
		["529"] = 324,
		["530"] = 324,
		["531"] = 324,
		["532"] = 324,
		["533"] = 324,
		["534"] = 333,
		["536"] = 333,
		["538"] = 362,
		["539"] = 371,
		["540"] = 362,
		["541"] = 371,
		["542"] = 375,
		["543"] = 376,
		["544"] = 377,
		["545"] = 375,
		["546"] = 379,
		["547"] = 380,
		["548"] = 381,
		["549"] = 382,
		["550"] = 383,
		["551"] = 384,
		["552"] = 385,
		["553"] = 386,
		["554"] = 386,
		["555"] = 386,
		["556"] = 386,
		["557"] = 386,
		["558"] = 387,
		["559"] = 387,
		["560"] = 387,
		["561"] = 387,
		["562"] = 387,
		["563"] = 388,
		["564"] = 389,
		["565"] = 389,
		["566"] = 389,
		["567"] = 389,
		["568"] = 389,
		["569"] = 389,
		["570"] = 389,
		["571"] = 389,
		["573"] = 379,
		["574"] = 392,
		["575"] = 393,
		["576"] = 394,
		["577"] = 395,
		["578"] = 396,
		["581"] = 399,
		["582"] = 400,
		["583"] = 401,
		["584"] = 402,
		["585"] = 403,
		["586"] = 403,
		["587"] = 403,
		["588"] = 403,
		["589"] = 403,
		["590"] = 404,
		["591"] = 404,
		["592"] = 404,
		["593"] = 404,
		["594"] = 404,
		["595"] = 404,
		["596"] = 404,
		["597"] = 404,
		["598"] = 404,
		["599"] = 405,
		["600"] = 406,
		["601"] = 409,
		["602"] = 409,
		["603"] = 409,
		["604"] = 409,
		["605"] = 409,
		["606"] = 409,
		["607"] = 409,
		["608"] = 409,
		["609"] = 409,
		["610"] = 418,
		["611"] = 392,
		["612"] = 420,
		["613"] = 421,
		["614"] = 422,
		["615"] = 422,
		["616"] = 421,
		["617"] = 420,
		["618"] = 425,
		["619"] = 426,
		["620"] = 425,
		["621"] = 371,
		["622"] = 362,
		["623"] = 362,
		["624"] = 362,
		["625"] = 362,
		["626"] = 362,
		["627"] = 362,
		["628"] = 362,
		["629"] = 362,
		["630"] = 371,
		["632"] = 371,
		["633"] = 430,
		["634"] = 431,
		["635"] = 430,
		["636"] = 431,
		["637"] = 433,
		["638"] = 434,
		["641"] = 436,
		["642"] = 437,
		["643"] = 438,
		["644"] = 439,
		["645"] = 439,
		["646"] = 439,
		["647"] = 439,
		["648"] = 439,
		["649"] = 439,
		["650"] = 439,
		["651"] = 439,
		["652"] = 439,
		["653"] = 440,
		["654"] = 440,
		["655"] = 440,
		["656"] = 440,
		["657"] = 440,
		["658"] = 440,
		["659"] = 440,
		["660"] = 440,
		["661"] = 433,
		["662"] = 442,
		["663"] = 442,
		["664"] = 442,
		["665"] = 443,
		["666"] = 444,
		["667"] = 443,
		["668"] = 446,
		["669"] = 447,
		["670"] = 446,
		["671"] = 431,
		["672"] = 430,
		["673"] = 431,
		["675"] = 431,
		["677"] = 452,
		["678"] = 453,
		["679"] = 452,
		["680"] = 453,
		["681"] = 454,
		["682"] = 455,
		["683"] = 455,
		["685"] = 454,
		["686"] = 457,
		["687"] = 458,
		["688"] = 458,
		["690"] = 457,
		["691"] = 460,
		["692"] = 461,
		["693"] = 461,
		["694"] = 463,
		["695"] = 463,
		["696"] = 463,
		["697"] = 461,
		["698"] = 461,
		["699"] = 460,
		["700"] = 466,
		["701"] = 466,
		["702"] = 466,
		["703"] = 467,
		["704"] = 467,
		["705"] = 467,
		["706"] = 468,
		["707"] = 468,
		["708"] = 468,
		["709"] = 453,
		["710"] = 452,
		["711"] = 453,
		["713"] = 453,
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
local q = 800
g.zuus_talent = c()
local r = g.zuus_talent
r.name = "zuus_talent"
d(r, i)
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_zuus_talent"
end
r = e({ j(nil) }, r)
g.zuus_talent = r
g.modifier_zuus_talent = c()
local s = g.modifier_zuus_talent
s.name = "modifier_zuus_talent"
d(s, l)
function s.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.mana_regen_record = 0
	self.tick = 0.1
	self.tl4_counter = 0
	self.tl7_record = 0
end
function s.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage") + self:GetAbilityTalentValue("zuus_talent_2", "arc_damage")
	self.mana_threshold = self:GetAbilitySpecialValueFor("mana_threshold")
		- self:GetAbilityTalentValue("zuus_talent_6", "mana_reduce")
	self.tl3_attackspeed_pct = self:GetAbilityTalentValue("zuus_talent_3", "attackspeed_pct")
	self.tl3_acr_damage_pct = self:GetAbilityTalentValue("zuus_talent_3", "acr_damage_pct")
	self.tl4_count = self:GetAbilityTalentValue("zuus_talent_4", "count")
	self.tl4_stun_duration = self:GetAbilityTalentValue("zuus_talent_4", "stun_duration")
	self.tl4_damage = self:GetAbilityTalentValue("zuus_talent_4", "damage")
	self.tl7_count = self:GetAbilityTalentValue("zuus_talent_7", "count")
	self.s_count = self:GetAbilityTalentValue("zuus_shard", "count")
	self.s_health_pct = self:GetAbilityTalentValue("zuus_shard", "health_pct")
end
function s.prototype.OnCreated(self, t)
	if IsServer() then
		self.s_record = 0
	end
end
function s.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_RESTORE] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self:GetParent(), -1 },
	}
end
function s.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS_PERCENTAGE] = self.tl3_attackspeed_pct }
end
function s.prototype.OnBattleStartBefore(self, t)
	self.mana_regen_record = 0
	self.tl4_counter = 0
	self.tl7_record = 0
	self.s_record = self.s_count
end
function s.prototype.OnRestore(self, t)
	if t.count <= 0 then
		return
	end
	if self:GetCaster():PassivesDisabled() then
		return
	end
	self.mana_regen_record = self.mana_regen_record + t.count
	if self.mana_regen_record >= self.mana_threshold then
		local u = math.floor(self.mana_regen_record / self.mana_threshold)
		self.mana_regen_record = self.mana_regen_record - u * self.mana_threshold
		ForWithInterval(self.tick, u, function()
			self:ArcLighting()
		end)
	end
end
function s.prototype.OnCustomAttackLanded(self, v)
	if self.tl3_acr_damage_pct > 0 then
		self:ArcLighting(self.tl3_acr_damage_pct, self:GetParent():FindAbilityByName("zuus_talent_3"))
	end
end
function s.prototype.OnEvasion(self)
	if not IsServer() or not self:HasTalent("zuus_talent_8") then
		return
	end
	local w = self:GetParent()
	local x = w:GetEnemy()
	if w:PassivesDisabled() or not IsInjurable(w, x) then
		return
	end
	local y = w:FindAbilityByName("zuus_talent_8")
	if not IsValid(y) then
		return
	end
	w:AddNewModifier(w, y, "modifier_zuus_talent_8_bonus", {})
	x:AddNewModifier(w, y, "modifier_zuus_talent_8_debuff", { duration = y:GetSpecialValueFor("duration") })
	local z =
		ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_shard_head.vpcf", PATTACH_CUSTOMORIGIN, w)
	ParticleManager:SetParticleControlEnt(z, 0, w, PATTACH_POINT_FOLLOW, "attach_hitloc", w:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(z, 1, x, PATTACH_POINT_FOLLOW, "attach_hitloc", x:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(z, 2, GetGroundPosition(w:GetAbsOrigin(), w))
	ParticleManager:ReleaseParticleIndex(z)
	DamageSystem:dealDamage({
		attacker = w,
		target = x,
		ability = y,
		damage = y:GetSpecialValueFor("damage"),
		damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
		damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
		damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
	})
end
function s.prototype.ArcLighting(self, A, B)
	if A == nil then
		A = 100
	end
	if B == nil then
		B = self:GetAbility()
	end
	if IsServer() then
		local w = self:GetParent()
		local x = w:GetEnemy()
		if not IsInjurable(w, x) then
			return
		end
		local y = self:GetAbility()
		if B == y and not w:HasModifier("modifier_zuus_ult_cast") then
			w:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 3)
		end
		GameTimer(0.06, function()
			if not (IsValid(self) and IsValid(B)) then
				return
			end
			if not IsInjurable(w, x) then
				return
			end
			local z = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_zuus/zuus_arc_lightning_head.vpcf",
				PATTACH_CUSTOMORIGIN,
				w
			)
			ParticleManager:SetParticleControlEnt(z, 0, w, PATTACH_POINT_FOLLOW, "attach_attack1", vec3_zero, true)
			ParticleManager:SetParticleControlEnt(z, 1, x, PATTACH_POINT, "attach_hitloc", vec3_zero, true)
			if w:HasModifier("modifier_5100078") then
				ParticleManager:SetParticleControl(z, 2, Vector(q, 0, 0))
				local C = ParticleManager:CreateParticle(
					"models/eom/hero/zeus_3/particles/zeus_3_skill1_glow_fx1.vpcf",
					PATTACH_CUSTOMORIGIN,
					w
				)
				ParticleManager:SetParticleControlEnt(C, 0, w, PATTACH_POINT_FOLLOW, "attach_attack1", vec3_zero, true)
				ParticleManager:SetParticleControlEnt(C, 1, w, PATTACH_POINT_FOLLOW, "attach_attack2", vec3_zero, true)
				ParticleManager:ReleaseParticleIndex(C)
			end
			ParticleManager:ReleaseParticleIndex(z)
			local D = self.damage
			local E = D * A * 0.01
			w:EmitSound("Hero_Zuus.ArcLightning.Cast")
			x:EmitSound("Hero_Zuus.ArcLightning.Target")
			if self.s_record > 0 then
				E = E + x:GetHealth() * self.s_health_pct * 0.01
				self.s_record = self.s_record - 1
			end
			DamageSystem:dealDamage({
				attacker = w,
				target = x,
				ability = B,
				damage = E,
				damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
				damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
				damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
			})
			if self.tl4_count > 0 then
				self.tl4_counter = self.tl4_counter + 1
				if self.tl4_counter >= self.tl4_count then
					self.tl4_counter = 0
					local F = w:FindAbilityByName("zuus_talent_4")
					local G = x:GetAbsOrigin()
					local z = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf",
						PATTACH_CUSTOMORIGIN,
						w
					)
					ParticleManager:SetParticleControl(
						z,
						0,
						w:HasModifier("modifier_5100078") and G or G + Vector(0, 0, 2000)
					)
					ParticleManager:SetParticleControlEnt(z, 1, x, PATTACH_POINT, "attach_hitloc", vec3_zero, true)
					ParticleManager:ReleaseParticleIndex(z)
					EmitSoundOnLocationWithCaster(G, "Hero_Zuus.LightningBolt", w)
					DamageSystem:dealDamage({
						attacker = w,
						target = x,
						ability = F,
						damage = self.tl4_damage,
						damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
						damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
						damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
					})
					AddStun(w, x, y, self.tl4_stun_duration)
				end
			end
			if self.tl7_count > 0 then
				self.tl7_record = self.tl7_record + 1
				if self.tl7_record >= self.tl7_count then
					self.tl7_record = 0
					w:AddNewModifier(w, self:GetAbility(), "modifier_zuus_talent_7", nil)
				end
			end
		end)
	end
end
s = e(
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
	s
)
g.modifier_zuus_talent = s
g.modifier_zuus_talent_7 = c()
local H = g.modifier_zuus_talent_7
H.name = "modifier_zuus_talent_7"
d(H, l)
function H.prototype.GetTexture(self)
	return "zuus_arc_lightning"
end
function H.prototype.GetAbilitySpecialValue(self)
	self.ult_bonus = self:GetAbilityTalentValue("zuus_talent_7", "ult_bonus")
	self.max_count = self:GetAbilityTalentValue("zuus_talent_7", "max_count")
end
function H.prototype.OnCreated(self, t)
	if IsServer() then
		self:SetStackCount(math.min(self.max_count, self:GetStackCount() + 1))
	end
end
function H.prototype.OnRefresh(self, t)
	if IsServer() then
		self:SetStackCount(math.min(self.max_count, self:GetStackCount() + 1))
	end
end
function H.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER }
end
function H.prototype.EOM_GetModifierUltiPower(self)
	return self:GetStackCount() * self.ult_bonus
end
H = e(
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
	H
)
g.modifier_zuus_talent_7 = H
g.zuus_ult = c()
local I = g.zuus_ult
I.name = "zuus_ult"
d(I, o)
function I.prototype.OnSpellStart(self)
	local J = self:GetCaster()
	local x = J:GetEnemy()
	local K = 0.5
	local E = self:getThundergodsWrathDamage()
	J:EmitSound("Hero_Zuus.GodsWrath.PreCast")
	J:AddNewModifier(J, self, "modifier_zuus_ult_cast", { duration = K })
	self:GameTimer(K, function()
		if not IsInjurable(J, x) then
			return
		end
		x:EmitSound("Hero_Zuus.LightningBolt")
		DamageSystem:dealDamage({
			attacker = J,
			target = x,
			ability = self,
			damage = E,
			damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
			damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
		})
		local z = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_zuus/zuus_thundergods_wrath.vpcf",
			PATTACH_CUSTOMORIGIN,
			J
		)
		ParticleManager:SetParticleControl(
			z,
			0,
			J:HasModifier("modifier_5100078") and x:GetAbsOrigin() or x:GetAbsOrigin() + Vector(0, 0, 2000)
		)
		ParticleManager:SetParticleControlEnt(z, 1, x, PATTACH_POINT, "attach_hitloc", vec3_zero, true)
		ParticleManager:ReleaseParticleIndex(z)
	end)
end
function I.prototype.getThundergodsWrathDamage(self)
	local L = self:GetCaster():FindModifierByName("modifier_zuus_talent_8_bonus")
	return self:GetSpecialValueFor("damage")
		+ self:GetTalentValue("zuus_talent_1", "ult_damage")
		+ (IsValid(L) and L:GetStackCount() * self:GetTalentValue("zuus_talent_8", "damage_bonus") or 0)
end
function I.prototype.GetIntrinsicModifierName(self)
	return "modifier_zuus_ult"
end
I = e({ p(nil) }, I)
g.zuus_ult = I
g.modifier_zuus_ult = c()
local M = g.modifier_zuus_ult
M.name = "modifier_zuus_ult"
d(M, l)
function M.prototype.GetAbilitySpecialValue(self)
	self.tl5_interval = self:GetAbilityTalentValue("zuus_talent_5", "interval")
	self.tl5_stun_duration = self:GetAbilityTalentValue("zuus_talent_5", "stun_duration")
end
function M.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function M.prototype.OnBattleStart(self, t)
	if self.tl5_interval > 0 then
		local J = self:GetCaster()
		local x = J:GetEnemy()
		if IsInjurable(x, J) then
			x:AddNewModifier(J, self:GetAbility(), "modifier_zuus_talent_5_debuff", nil)
		end
	end
end
M = e(
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
	M
)
g.modifier_zuus_ult = M
g.modifier_zuus_ult_cast = c()
local N = g.modifier_zuus_ult_cast
N.name = "modifier_zuus_ult_cast"
d(N, l)
function N.prototype.OnCreated(self, t)
	local w = self:GetParent()
	if IsClient() then
		local O = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_zuus/zuus_thundergods_wrath_start.vpcf",
			PATTACH_ABSORIGIN,
			w
		)
		ParticleManager:SetParticleControlEnt(O, 1, w, PATTACH_POINT_FOLLOW, "attach_attack1", vec3_zero, true)
		ParticleManager:SetParticleControlEnt(O, 2, w, PATTACH_POINT_FOLLOW, "attach_attack2", vec3_zero, true)
	else
		w:StartGesture(ACT_DOTA_CAST_ABILITY_5)
	end
end
function N.prototype.OnRefresh(self, t)
	local w = self:GetParent()
	if IsClient() then
		local O = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_zuus/zuus_thundergods_wrath_start.vpcf",
			PATTACH_ABSORIGIN,
			w
		)
		ParticleManager:SetParticleControlEnt(O, 1, w, PATTACH_POINT_FOLLOW, "attach_attack1", vec3_zero, true)
		ParticleManager:SetParticleControlEnt(O, 2, w, PATTACH_POINT_FOLLOW, "attach_attack2", vec3_zero, true)
	else
		w:StartGesture(ACT_DOTA_CAST_ABILITY_5)
	end
end
function N.prototype.OnDestroy(self)
	if IsServer() then
	end
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
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	N
)
g.modifier_zuus_ult_cast = N
g.modifier_zuus_talent_5_debuff = c()
local P = g.modifier_zuus_talent_5_debuff
P.name = "modifier_zuus_talent_5_debuff"
d(P, l)
function P.prototype.GetAbilitySpecialValue(self)
	self.tl5_interval = self:GetAbilityTalentValue("zuus_talent_5", "interval")
	self.tl5_stun_duration = self:GetAbilityTalentValue("zuus_talent_5", "stun_duration")
end
function P.prototype.OnCreated(self, t)
	if IsServer() then
		local J = self:GetCaster()
		self:StartIntervalThink(self.tl5_interval)
		self.damage_position = J:GetAbsOrigin() + Vector(0, 0, 500)
		EmitSoundOnLocationWithCaster(self.damage_position, "Hero_Zuus.Cloud.Cast", J)
		local z =
			ParticleManager:CreateParticle("particles/units/heroes/hero_zeus/zeus_cloud.vpcf", PATTACH_CUSTOMORIGIN, J)
		ParticleManager:SetParticleControl(z, 0, J:GetAbsOrigin())
		ParticleManager:SetParticleControl(z, 1, Vector(300, 0, 0))
		ParticleManager:SetParticleControl(z, 2, self.damage_position)
		self:AddParticle(z, false, false, -1, false, false)
	end
end
function P.prototype.OnIntervalThink(self)
	local J = self:GetCaster()
	local w = self:GetParent()
	if not IsInjurable(J, w) then
		self:Destroy()
		return
	end
	local y = self:GetAbility()
	local E = y:getThundergodsWrathDamage()
	local Q = J:FindAbilityByName("zuus_talent_5")
	local z = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf",
		PATTACH_CUSTOMORIGIN,
		J
	)
	ParticleManager:SetParticleControl(
		z,
		0,
		J:HasModifier("modifier_5100078") and w:GetAbsOrigin() or self.damage_position
	)
	ParticleManager:SetParticleControlEnt(z, 1, w, PATTACH_POINT, "attach_hitloc", vec3_zero, true)
	ParticleManager:ReleaseParticleIndex(z)
	EmitSoundOnLocationWithCaster(self.damage_position, "Hero_Zuus.LightningBolt.Cloud", J)
	DamageSystem:dealDamage({
		attacker = J,
		target = w,
		ability = Q,
		damage = E,
		damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
		damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
		damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
	})
	AddStun(J, w, Q, self.tl5_stun_duration)
end
function P.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function P.prototype.OnBattleEnd(self, t)
	self:Destroy()
end
P = e(
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
	P
)
g.modifier_zuus_talent_5_debuff = P
g.modifier_zuus_talent_8_debuff = c()
local R = g.modifier_zuus_talent_8_debuff
R.name = "modifier_zuus_talent_8_debuff"
d(R, l)
function R.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	local w = self:GetParent()
	local z = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_zuus/zuus_shard_slow.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		w
	)
	ParticleManager:SetParticleControlEnt(z, 0, w, PATTACH_POINT_FOLLOW, "attach_hitloc", w:GetAbsOrigin(), true)
	self:AddParticle(z, false, false, -1, false, false)
end
function R.prototype.GetTexture(self)
	return "zuus_heavenly_jump"
end
function R.prototype.GetAbilitySpecialValue(self)
	self.attackspeed_down = self:GetAbilitySpecialValueFor("attackspeed_down")
end
function R.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = -self.attackspeed_down }
end
R = e({ m(a, { IsHidden = false, IsDebuff = true, IsPurgable = true, AllowIllusionDuplicate = false }) }, R)
g.modifier_zuus_talent_8_debuff = R
g.modifier_zuus_talent_8_bonus = c()
local S = g.modifier_zuus_talent_8_bonus
S.name = "modifier_zuus_talent_8_bonus"
d(S, l)
function S.prototype.OnCreated(self)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function S.prototype.OnRefresh(self)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function S.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function S.prototype.OnBattleStartBefore(self)
	self:Destroy()
end
function S.prototype.OnBattleEnd(self)
	self:Destroy()
end
function S.prototype.GetTexture(self)
	return "zuus_heavenly_jump"
end
S = e({ m(a, { IsHidden = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }) }, S)
g.modifier_zuus_talent_8_bonus = S
return g