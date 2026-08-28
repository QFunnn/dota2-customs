--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/jugg"
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
		["18"] = 6,
		["19"] = 7,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 9,
		["24"] = 8,
		["25"] = 7,
		["26"] = 6,
		["27"] = 7,
		["29"] = 7,
		["30"] = 12,
		["31"] = 20,
		["32"] = 12,
		["33"] = 20,
		["34"] = 33,
		["35"] = 34,
		["36"] = 35,
		["37"] = 36,
		["38"] = 37,
		["39"] = 40,
		["40"] = 41,
		["41"] = 42,
		["42"] = 43,
		["43"] = 44,
		["44"] = 45,
		["45"] = 33,
		["46"] = 47,
		["47"] = 48,
		["48"] = 47,
		["49"] = 50,
		["50"] = 51,
		["51"] = 50,
		["52"] = 57,
		["53"] = 58,
		["54"] = 58,
		["55"] = 59,
		["57"] = 57,
		["58"] = 62,
		["59"] = 63,
		["60"] = 62,
		["61"] = 65,
		["62"] = 66,
		["63"] = 66,
		["64"] = 68,
		["65"] = 68,
		["66"] = 68,
		["67"] = 66,
		["68"] = 69,
		["69"] = 69,
		["70"] = 69,
		["71"] = 66,
		["72"] = 70,
		["73"] = 70,
		["74"] = 70,
		["75"] = 66,
		["76"] = 66,
		["77"] = 65,
		["78"] = 73,
		["79"] = 74,
		["80"] = 75,
		["81"] = 76,
		["82"] = 77,
		["83"] = 78,
		["84"] = 79,
		["87"] = 73,
		["88"] = 83,
		["89"] = 84,
		["90"] = 85,
		["91"] = 86,
		["92"] = 87,
		["93"] = 88,
		["94"] = 89,
		["95"] = 89,
		["96"] = 89,
		["97"] = 89,
		["98"] = 89,
		["99"] = 89,
		["102"] = 83,
		["103"] = 93,
		["104"] = 94,
		["105"] = 95,
		["106"] = 95,
		["107"] = 95,
		["108"] = 95,
		["109"] = 95,
		["110"] = 95,
		["111"] = 95,
		["112"] = 95,
		["114"] = 93,
		["115"] = 98,
		["116"] = 99,
		["119"] = 100,
		["120"] = 101,
		["121"] = 102,
		["122"] = 103,
		["125"] = 105,
		["126"] = 106,
		["127"] = 106,
		["128"] = 106,
		["129"] = 106,
		["130"] = 106,
		["131"] = 106,
		["133"] = 109,
		["134"] = 110,
		["135"] = 111,
		["136"] = 112,
		["138"] = 113,
		["139"] = 113,
		["140"] = 114,
		["141"] = 114,
		["143"] = 115,
		["144"] = 116,
		["145"] = 116,
		["146"] = 116,
		["147"] = 116,
		["148"] = 117,
		["149"] = 117,
		["150"] = 117,
		["151"] = 117,
		["152"] = 118,
		["153"] = 118,
		["154"] = 118,
		["155"] = 118,
		["156"] = 113,
		["160"] = 122,
		["161"] = 122,
		["162"] = 122,
		["163"] = 122,
		["164"] = 122,
		["165"] = 122,
		["167"] = 98,
		["168"] = 130,
		["169"] = 133,
		["170"] = 130,
		["171"] = 136,
		["172"] = 137,
		["173"] = 139,
		["175"] = 136,
		["176"] = 20,
		["177"] = 12,
		["178"] = 12,
		["179"] = 12,
		["180"] = 12,
		["181"] = 12,
		["182"] = 12,
		["183"] = 12,
		["184"] = 12,
		["185"] = 20,
		["187"] = 20,
		["188"] = 144,
		["189"] = 153,
		["190"] = 144,
		["191"] = 153,
		["192"] = 154,
		["193"] = 155,
		["194"] = 156,
		["195"] = 157,
		["197"] = 159,
		["198"] = 160,
		["199"] = 161,
		["200"] = 161,
		["201"] = 161,
		["202"] = 161,
		["203"] = 161,
		["204"] = 162,
		["205"] = 162,
		["206"] = 162,
		["207"] = 162,
		["208"] = 162,
		["209"] = 162,
		["210"] = 162,
		["211"] = 162,
		["213"] = 154,
		["214"] = 165,
		["215"] = 166,
		["216"] = 167,
		["218"] = 165,
		["219"] = 153,
		["220"] = 144,
		["221"] = 144,
		["222"] = 144,
		["223"] = 144,
		["224"] = 144,
		["225"] = 144,
		["226"] = 144,
		["227"] = 144,
		["228"] = 144,
		["229"] = 153,
		["231"] = 153,
		["233"] = 172,
		["234"] = 181,
		["235"] = 172,
		["236"] = 181,
		["238"] = 181,
		["239"] = 185,
		["240"] = 186,
		["241"] = 172,
		["242"] = 187,
		["243"] = 188,
		["244"] = 187,
		["245"] = 190,
		["246"] = 191,
		["247"] = 192,
		["248"] = 193,
		["249"] = 194,
		["250"] = 195,
		["252"] = 197,
		["253"] = 198,
		["254"] = 199,
		["255"] = 200,
		["257"] = 201,
		["258"] = 201,
		["259"] = 202,
		["260"] = 202,
		["261"] = 202,
		["262"] = 202,
		["263"] = 202,
		["264"] = 202,
		["265"] = 202,
		["266"] = 202,
		["267"] = 202,
		["268"] = 202,
		["269"] = 202,
		["270"] = 202,
		["271"] = 201,
		["274"] = 205,
		["275"] = 208,
		["276"] = 209,
		["277"] = 210,
		["278"] = 210,
		["279"] = 210,
		["280"] = 210,
		["281"] = 210,
		["282"] = 211,
		["283"] = 211,
		["284"] = 211,
		["285"] = 211,
		["286"] = 211,
		["287"] = 211,
		["288"] = 211,
		["289"] = 211,
		["291"] = 190,
		["292"] = 214,
		["293"] = 215,
		["294"] = 216,
		["295"] = 217,
		["296"] = 218,
		["297"] = 219,
		["298"] = 220,
		["299"] = 222,
		["300"] = 223,
		["301"] = 223,
		["303"] = 224,
		["304"] = 225,
		["305"] = 226,
		["306"] = 227,
		["307"] = 229,
		["308"] = 229,
		["309"] = 229,
		["310"] = 229,
		["311"] = 229,
		["312"] = 232,
		["313"] = 233,
		["314"] = 234,
		["316"] = 236,
		["317"] = 237,
		["318"] = 237,
		["319"] = 237,
		["320"] = 237,
		["321"] = 237,
		["322"] = 237,
		["323"] = 237,
		["324"] = 237,
		["325"] = 237,
		["326"] = 238,
		["327"] = 214,
		["328"] = 181,
		["329"] = 172,
		["330"] = 172,
		["331"] = 172,
		["332"] = 172,
		["333"] = 172,
		["334"] = 172,
		["335"] = 172,
		["336"] = 172,
		["337"] = 172,
		["338"] = 181,
		["340"] = 181,
		["342"] = 243,
		["343"] = 244,
		["344"] = 243,
		["345"] = 244,
		["346"] = 245,
		["347"] = 246,
		["348"] = 247,
		["349"] = 247,
		["350"] = 247,
		["351"] = 247,
		["352"] = 247,
		["353"] = 247,
		["354"] = 245,
		["355"] = 249,
		["356"] = 250,
		["357"] = 249,
		["358"] = 244,
		["359"] = 243,
		["360"] = 244,
		["362"] = 244,
		["363"] = 253,
		["364"] = 261,
		["365"] = 253,
		["366"] = 261,
		["368"] = 261,
		["369"] = 262,
		["370"] = 253,
		["371"] = 263,
		["372"] = 264,
		["373"] = 265,
		["375"] = 263,
		["376"] = 268,
		["377"] = 269,
		["378"] = 270,
		["379"] = 271,
		["381"] = 273,
		["382"] = 274,
		["383"] = 275,
		["385"] = 268,
		["386"] = 261,
		["387"] = 253,
		["388"] = 253,
		["389"] = 253,
		["390"] = 253,
		["391"] = 253,
		["392"] = 253,
		["393"] = 253,
		["394"] = 253,
		["395"] = 261,
		["397"] = 261,
		["398"] = 279,
		["399"] = 288,
		["400"] = 279,
		["401"] = 288,
		["403"] = 288,
		["404"] = 303,
		["405"] = 279,
		["406"] = 304,
		["407"] = 305,
		["408"] = 306,
		["409"] = 308,
		["410"] = 310,
		["411"] = 314,
		["412"] = 315,
		["413"] = 316,
		["414"] = 318,
		["415"] = 319,
		["416"] = 320,
		["417"] = 304,
		["418"] = 322,
		["419"] = 323,
		["420"] = 324,
		["421"] = 325,
		["422"] = 326,
		["423"] = 326,
		["424"] = 326,
		["425"] = 326,
		["426"] = 326,
		["428"] = 328,
		["429"] = 329,
		["430"] = 330,
		["431"] = 330,
		["432"] = 330,
		["433"] = 331,
		["434"] = 332,
		["436"] = 330,
		["437"] = 330,
		["439"] = 337,
		["440"] = 338,
		["441"] = 338,
		["442"] = 338,
		["443"] = 338,
		["444"] = 338,
		["445"] = 339,
		["446"] = 339,
		["447"] = 339,
		["448"] = 339,
		["449"] = 339,
		["450"] = 339,
		["451"] = 339,
		["452"] = 339,
		["454"] = 322,
		["455"] = 342,
		["456"] = 343,
		["457"] = 344,
		["458"] = 344,
		["459"] = 344,
		["460"] = 344,
		["462"] = 342,
		["463"] = 347,
		["464"] = 348,
		["465"] = 349,
		["466"] = 350,
		["468"] = 347,
		["469"] = 353,
		["470"] = 354,
		["471"] = 355,
		["472"] = 356,
		["473"] = 357,
		["474"] = 357,
		["476"] = 358,
		["477"] = 359,
		["478"] = 359,
		["479"] = 359,
		["480"] = 359,
		["481"] = 359,
		["482"] = 359,
		["483"] = 360,
		["484"] = 360,
		["485"] = 360,
		["486"] = 360,
		["487"] = 361,
		["488"] = 361,
		["489"] = 361,
		["490"] = 361,
		["491"] = 362,
		["492"] = 362,
		["493"] = 362,
		["494"] = 362,
		["495"] = 363,
		["496"] = 364,
		["497"] = 364,
		["498"] = 364,
		["499"] = 364,
		["500"] = 364,
		["502"] = 368,
		["503"] = 369,
		["504"] = 369,
		["505"] = 369,
		["506"] = 369,
		["507"] = 369,
		["509"] = 371,
		["510"] = 353,
		["511"] = 381,
		["512"] = 382,
		["513"] = 381,
		["514"] = 288,
		["515"] = 279,
		["516"] = 279,
		["517"] = 279,
		["518"] = 279,
		["519"] = 279,
		["520"] = 279,
		["521"] = 279,
		["522"] = 279,
		["523"] = 279,
		["524"] = 288,
		["526"] = 288,
		["528"] = 419,
		["529"] = 420,
		["530"] = 419,
		["531"] = 420,
		["532"] = 421,
		["533"] = 422,
		["534"] = 421,
		["535"] = 420,
		["536"] = 419,
		["537"] = 420,
		["539"] = 420,
		["540"] = 425,
		["541"] = 433,
		["542"] = 425,
		["543"] = 433,
		["544"] = 435,
		["545"] = 436,
		["546"] = 435,
		["547"] = 438,
		["548"] = 439,
		["549"] = 440,
		["551"] = 438,
		["552"] = 443,
		["553"] = 444,
		["554"] = 443,
		["555"] = 446,
		["556"] = 447,
		["557"] = 446,
		["558"] = 433,
		["559"] = 425,
		["560"] = 425,
		["561"] = 425,
		["562"] = 425,
		["563"] = 425,
		["564"] = 425,
		["565"] = 425,
		["566"] = 425,
		["567"] = 433,
		["569"] = 433,
		["571"] = 452,
		["572"] = 453,
		["573"] = 452,
		["574"] = 453,
		["575"] = 454,
		["576"] = 455,
		["577"] = 454,
		["578"] = 453,
		["579"] = 452,
		["580"] = 453,
		["582"] = 453,
		["583"] = 458,
		["584"] = 466,
		["585"] = 458,
		["586"] = 466,
		["587"] = 468,
		["588"] = 469,
		["589"] = 468,
		["590"] = 471,
		["591"] = 472,
		["592"] = 473,
		["594"] = 471,
		["595"] = 476,
		["596"] = 477,
		["597"] = 476,
		["598"] = 479,
		["599"] = 480,
		["600"] = 479,
		["601"] = 466,
		["602"] = 458,
		["603"] = 458,
		["604"] = 458,
		["605"] = 458,
		["606"] = 458,
		["607"] = 458,
		["608"] = 458,
		["609"] = 458,
		["610"] = 466,
		["612"] = 466,
		["613"] = 485,
		["614"] = 486,
		["615"] = 485,
		["616"] = 486,
		["617"] = 487,
		["618"] = 488,
		["619"] = 487,
		["620"] = 486,
		["621"] = 485,
		["622"] = 486,
		["624"] = 486,
		["625"] = 492,
		["626"] = 500,
		["627"] = 492,
		["628"] = 500,
		["630"] = 500,
		["631"] = 501,
		["632"] = 492,
		["633"] = 506,
		["634"] = 507,
		["635"] = 508,
		["636"] = 506,
		["637"] = 511,
		["638"] = 513,
		["639"] = 514,
		["640"] = 515,
		["641"] = 516,
		["642"] = 517,
		["643"] = 518,
		["644"] = 519,
		["645"] = 521,
		["648"] = 511,
		["649"] = 526,
		["650"] = 527,
		["651"] = 526,
		["652"] = 531,
		["653"] = 532,
		["654"] = 533,
		["655"] = 533,
		["656"] = 533,
		["657"] = 533,
		["658"] = 533,
		["659"] = 533,
		["661"] = 531,
		["662"] = 500,
		["663"] = 492,
		["664"] = 492,
		["665"] = 492,
		["666"] = 492,
		["667"] = 492,
		["668"] = 492,
		["669"] = 492,
		["670"] = 492,
		["671"] = 500,
		["673"] = 500,
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
g.jugg_talent = c()
local q = g.jugg_talent
q.name = "jugg_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_jugg_talent"
end
q = e({ j(nil) }, q)
g.jugg_talent = q
g.modifier_jugg_talent = c()
local r = g.modifier_jugg_talent
r.name = "modifier_jugg_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.skill_steal_health = self:GetAbilityTalentValue("jugg_talent_2", "skill_steal_health")
	self.crit_chance = self:GetAbilityTalentValue("jugg_talent_3", "crit_chance")
	self.talent4Chance = self:GetAbilityTalentValue("jugg_talent_4", "chance")
	self.count = self:GetAbilitySpecialValueFor("count")
	self.regen = self:GetAbilityTalentValue("jugg_talent_12", "regen")
	self.times = self:GetAbilityTalentValue("jugg_talent_12", "times")
	self.chance_bonus = self:GetAbilityTalentValue("jugg_talent_6", "chance_bonus")
	self.extra_atk_speed = self:GetAbilityTalentValue("jugg_talent_9", "extra_atk_speed")
	self.hit_pct = self:GetAbilityTalentValue("jugg_talent_10", "hit_pct")
	self.ult_count = 0
end
function r.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function r.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_SUREHIT_CHANCE,
	}
end
function r.prototype.EOM_GetModifierSurehitChance(self, s)
	local t = s and s.ability
	if (t and t:GetAbilityName()) == "jugg_talent_10" then
		return self.hit_pct
	end
end
function r.prototype.GetActivityTranslationModifiers(self)
	return "favor"
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
	}
end
function r.prototype.OnBattleStart(self, s)
	if self:HasTalent("jugg_talent_10") then
		local u = self:GetParent()
		local v = u:GetEnemy()
		local w = u:FindAbilityByName("jugg_talent_10")
		if IsInjurable(u, v) and IsValid(w) then
			v:AddNewModifier(u, w, "modifier_jugg_talent_10", nil)
		end
	end
end
function r.prototype.OnCustomTakeDamage(self, x)
	local y = self:GetParent():FindAbilityByName("jugg_ult")
	if x.ability == y and self.regen > 0 then
		self.ult_count = self.ult_count + 1
		if self.ult_count >= self.times then
			self.ult_count = 0
			Heal(self:GetParent(), self.regen, "jugg_talent_12", "Ability")
		end
	end
end
function r.prototype.OnCustomAttackLanded(self, x)
	if x.is_crit and self.skill_steal_health > 0 then
		Heal(
			self:GetParent(),
			x.damage * self.skill_steal_health * 0.01,
			"jugg_talent_2",
			"Ability",
			false,
			HealFlags.HEAL_FLAG_LIFESETEAL
		)
	end
end
function r.prototype.OnCritical(self, s)
	if self:GetCaster():PassivesDisabled() then
		return
	end
	if s.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		local z = self:GetParent()
		local A = z:FindAbilityByName("jugg_ult")
		if not IsValid(A) then
			return
		end
		if self:PRD(self.talent4Chance, "jugg_talent_4") then
			s.attacker:AddNewModifier(
				s.attacker,
				A,
				"modifier_jugg_ult_buff",
				{ duration = A:GetSpecialValueFor("duration") }
			)
		end
		local B = IsValid(s.target) and s.target or z:GetEnemy()
		if IsValid(B) then
			local C = A:GetSpecialValueFor("damage")
				+ self:GetAbilityTalentValue("jugg_talent_1", "damage_bonus")
				+ GetAttackDamage(z) * self:GetAbilityTalentValue("jugg_talent_3", "attack_bonus_pct") * 0.01
			local D = z:FindModifierByName("modifier_jugg_shard")
			do
				local E = 0
				while E < self.count do
					if D ~= nil then
						D:AddShardTirggerRecord()
					end
					z:DealDamage(B, A, C, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
					ReduceIce(z, GetIce(z) * A:GetSpecialValueFor("reduce_pct") * 0.01)
					ReducePoison(z, GetPoison(z) * A:GetSpecialValueFor("reduce_pct") * 0.01)
					ReduceInjury(z, GetInjury(z) * A:GetSpecialValueFor("reduce_pct") * 0.01)
					E = E + 1
				end
			end
		end
		z:AddNewModifier(z, self:GetAbility(), "modifier_jugg_talent_effect", { duration = 0.3 })
	end
end
function r.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self, s)
	return self.chance_bonus + self.crit_chance
end
function r.prototype.EOM_GetModifierAttackSpeedBonus(self, s)
	if self:GetParent():HasModifier("modifier_jugg_ult_buff") then
		return self.extra_atk_speed
	end
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
g.modifier_jugg_talent = r
g.modifier_jugg_talent_effect = c()
local F = g.modifier_jugg_talent_effect
F.name = "modifier_jugg_talent_effect"
d(F, l)
function F.prototype.OnCreated(self, s)
	if IsServer() then
		self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_OVERRIDE_ABILITY_1, 2)
		self:GetParent():EmitSound("Hero_Axe.CounterHelix")
	else
		local u = self:GetParent()
		local G = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_juggernaut/juggernaut_blade_fury.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			u
		)
		ParticleManager:SetParticleControl(G, 5, Vector(300, 300, 300))
		self:AddParticle(G, false, false, -1, false, false)
	end
end
function F.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():RemoveGesture(ACT_DOTA_OVERRIDE_ABILITY_1)
	end
end
F = e(
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	F
)
g.modifier_jugg_talent_effect = F
g.modifier_jugg_talent_10 = c()
local H = g.modifier_jugg_talent_10
H.name = "modifier_jugg_talent_10"
d(H, l)
function H.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tPosition = {}
	self.radius = 400
end
function H.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilityTalentValue("jugg_talent_10", "count")
end
function H.prototype.OnCreated(self, s)
	if IsServer() then
		local z = self:GetParent()
		local I = self:GetDuration()
		if self.ability:GetAbilityName() == "jugg_shard" then
			self.count = self:GetAbilityTalentValue("jugg_shard", "steal_hp_cnt")
		end
		self:SetStackCount(self.count)
		self.vCenter = z:GetAbsOrigin()
		self.vInitDirection = self.vCenter + RandomVector(self.radius)
		self.tPosition = {}
		do
			local E = 0
			while E < self:GetStackCount() do
				table.insert(
					self.tPosition,
					RotatePosition(self.vCenter, QAngle(0, E * 360 / self:GetStackCount(), 0), self.vInitDirection)
				)
				E = E + 1
			end
		end
		self:StartIntervalThink(0.1)
		local G =
			ParticleManager:CreateParticle("particles/sect/sect_attack_139_circle.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(G, 0, self.vCenter)
		ParticleManager:SetParticleControl(G, 1, Vector(self.radius, 1, 1))
		self:AddParticle(G, false, false, -1, false, false)
	end
end
function H.prototype.OnIntervalThink(self)
	local J = self:GetCaster()
	local z = self:GetParent()
	local K = self:GetAbility()
	local L = ParticleManager:CreateParticle("particles/sect/sect_139_path.vpcf", PATTACH_CUSTOMORIGIN, nil)
	local M = self.tPosition[self:GetStackCount()]
	local N = M + (self.vCenter - M):Normalized() * self.radius * 2
	local D = z:FindModifierByName("modifier_jugg_shard")
	if D ~= nil then
		D:AddShardTirggerRecord()
	end
	z:EmitSound("Hero_Juggernaut.OmniSlash.Damage")
	ParticleManager:SetParticleControl(L, 0, M)
	ParticleManager:SetParticleControl(L, 1, N)
	ParticleManager:ReleaseParticleIndex(L)
	DamageSystem:performAttack(J, z, { ability = self:GetAbility() })
	self:DecrementStackCount()
	if self:GetStackCount() <= 0 then
		self:Destroy()
	end
	local G = ParticleManager:CreateParticle("particles/sect/sect_attack_139_flame.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControlEnt(G, 4, z, PATTACH_POINT_FOLLOW, "attach_hitloc", z:GetAbsOrigin(), false)
	ParticleManager:ReleaseParticleIndex(G)
end
H = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	H
)
g.modifier_jugg_talent_10 = H
g.jugg_ult = c()
local O = g.jugg_ult
O.name = "jugg_ult"
d(O, o)
function O.prototype.OnSpellStart(self)
	local J = self:GetCaster()
	J:AddNewModifier(J, self, "modifier_jugg_ult_buff", { duration = self:GetSpecialValueFor("duration") })
end
function O.prototype.GetIntrinsicModifierName(self)
	return "modifier_jugg_ult"
end
O = e({ p(nil) }, O)
g.jugg_ult = O
g.modifier_jugg_ult = c()
local P = g.modifier_jugg_ult
P.name = "modifier_jugg_ult"
d(P, l)
function P.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.animation = false
end
function P.prototype.OnCreated(self, s)
	if IsServer() then
		self:StartIntervalThink(0)
	end
end
function P.prototype.OnIntervalThink(self)
	if self.animation == false and self:GetParent():HasModifier("modifier_jugg_ult_buff") then
		self:GetParent():StartGesture(ACT_DOTA_OVERRIDE_ABILITY_1)
		self.animation = true
	end
	if self.animation and not self:GetParent():HasModifier("modifier_jugg_ult_buff") then
		self:GetParent():RemoveGesture(ACT_DOTA_OVERRIDE_ABILITY_1)
		self.animation = false
	end
end
P = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	P
)
g.modifier_jugg_ult = P
g.modifier_jugg_ult_buff = c()
local Q = g.modifier_jugg_ult_buff
Q.name = "modifier_jugg_ult_buff"
d(Q, l)
function Q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tl5_interval_reduce = 0
end
function Q.prototype.GetAbilitySpecialValue(self)
	self.talent3AttackBonusPct = self:GetAbilityTalentValue("jugg_talent_3", "attack_bonus_pct")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.reduce_pct = self:GetAbilitySpecialValueFor("reduce_pct")
	self.damage = self:GetAbilitySpecialValueFor("damage") + self:GetAbilityTalentValue("jugg_talent_1", "damage_bonus")
	self.damage_reduce_pct = self:GetAbilityTalentValue("jugg_talent_10", "damage_reduce_pct")
	self.chance = self:GetAbilityTalentValue("jugg_talent_11", "chance")
	self.count = self:GetAbilityTalentValue("jugg_talent_11", "count")
	self.tl5_max_reduce = self:GetAbilityTalentValue("jugg_talent_5", "max_reduce")
	self.tl5_min_reduce = self:GetAbilityTalentValue("jugg_talent_5", "min_reduce")
	self.tl5_attackspeed_max = self:GetAbilityTalentValue("jugg_talent_5", "attackspeed_max")
end
function Q.prototype.OnCreated(self, s)
	local z = self:GetParent()
	if IsServer() then
		if self.tl5_attackspeed_max > 0 then
			self.tl5_interval_reduce = Clamp(
				GetAttackspeed(self.parent) / self.tl5_attackspeed_max * (self.tl5_max_reduce - self.tl5_min_reduce)
					+ self.tl5_min_reduce,
				self.tl5_min_reduce,
				self.tl5_max_reduce
			)
		end
		self:StartIntervalThink(self.interval - self.tl5_interval_reduce)
		z:EmitSound("Hero_Juggernaut.BladeFuryStart")
		GameTimer(self:GetDuration(), function()
			if IsValid(z) then
				z:StopSound("Hero_Juggernaut.BladeFuryStart")
			end
		end)
	else
		local G = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_juggernaut/juggernaut_blade_fury.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			z
		)
		ParticleManager:SetParticleControl(G, 5, Vector(300, 300, 300))
		self:AddParticle(G, false, false, -1, false, false)
	end
end
function Q.prototype.OnRefresh(self, s)
	if IsServer() then
		self:SetDuration(self:GetRemainingTime() + s.duration, false)
	end
end
function Q.prototype.OnRemoved(self, R)
	if IsServer() then
		local z = self:GetParent()
		z:StopSound("Hero_Juggernaut.BladeFuryStart")
	end
end
function Q.prototype.OnIntervalThink(self)
	local z = self:GetParent()
	local B = z:GetEnemy()
	local D = z:FindModifierByName("modifier_jugg_shard")
	if D ~= nil then
		D:AddShardTirggerRecord()
	end
	local C = self.damage + GetAttackDamage(z) * self.talent3AttackBonusPct * 0.01
	z:DealDamage(B, self:GetAbility(), C, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
	ReduceIce(z, GetIce(z) * self.reduce_pct * 0.01)
	ReducePoison(z, GetPoison(z) * self.reduce_pct * 0.01)
	ReduceInjury(z, GetInjury(z) * self.reduce_pct * 0.01)
	if self:PRD(self.chance) then
		DamageSystem:performAttack(z, B, { ability = self:GetAbility() })
	end
	if self.tl5_attackspeed_max > 0 then
		self.tl5_interval_reduce = Clamp(
			GetAttackspeed(self.parent) / self.tl5_attackspeed_max * (self.tl5_max_reduce - self.tl5_min_reduce)
				+ self.tl5_min_reduce,
			self.tl5_min_reduce,
			self.tl5_max_reduce
		)
	end
	self:StartIntervalThink(self.interval - self.tl5_interval_reduce)
end
function Q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
Q = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	Q
)
g.modifier_jugg_ult_buff = Q
g.jugg_talent_7 = c()
local S = g.jugg_talent_7
S.name = "jugg_talent_7"
d(S, i)
function S.prototype.GetIntrinsicModifierName(self)
	return "modifier_jugg_talent_7"
end
S = e({ j(nil) }, S)
g.jugg_talent_7 = S
g.modifier_jugg_talent_7 = c()
local T = g.modifier_jugg_talent_7
T.name = "modifier_jugg_talent_7"
d(T, l)
function T.prototype.GetAbilitySpecialValue(self)
	self.ulti_power_per_victory = self:GetAbilitySpecialValueFor("ulti_power_per_victory")
end
function T.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(PlayerData:getTotalWin(self:GetParent():GetPlayerOwnerID()) * self.ulti_power_per_victory)
	end
end
function T.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER }
end
function T.prototype.EOM_GetModifierUltiPower(self)
	return self:GetStackCount()
end
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
			}
		),
	},
	T
)
g.modifier_jugg_talent_7 = T
g.jugg_talent_8 = c()
local U = g.jugg_talent_8
U.name = "jugg_talent_8"
d(U, i)
function U.prototype.GetIntrinsicModifierName(self)
	return "modifier_jugg_talent_8"
end
U = e({ j(nil) }, U)
g.jugg_talent_8 = U
g.modifier_jugg_talent_8 = c()
local V = g.modifier_jugg_talent_8
V.name = "modifier_jugg_talent_8"
d(V, l)
function V.prototype.GetAbilitySpecialValue(self)
	self.atk_speed_per_victory = self:GetAbilitySpecialValueFor("atk_speed_per_victory")
end
function V.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(PlayerData:getTotalWin(self:GetParent():GetPlayerOwnerID()) * self.atk_speed_per_victory)
	end
end
function V.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function V.prototype.EOM_GetModifierAttackDamageBonus(self)
	return self:GetStackCount()
end
V = e(
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
	V
)
g.modifier_jugg_talent_8 = V
g.jugg_shard = c()
local W = g.jugg_shard
W.name = "jugg_shard"
d(W, i)
function W.prototype.GetIntrinsicModifierName(self)
	return "modifier_jugg_shard"
end
W = e({ j(nil) }, W)
g.jugg_shard = W
g.modifier_jugg_shard = c()
local X = g.modifier_jugg_shard
X.name = "modifier_jugg_shard"
d(X, l)
function X.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.record = 0
end
function X.prototype.GetAbilitySpecialValue(self)
	self.shard_trigger = self:GetAbilityTalentValue("jugg_shard", "trigger")
	self.shard_steal_hp_pct = self:GetAbilityTalentValue("jugg_shard", "steal_hp_pct")
end
function X.prototype.AddShardTirggerRecord(self)
	self.record = self.record + 1
	if self.record >= self.shard_trigger then
		self.record = self.record - self.shard_trigger
		local u = self:GetParent()
		local v = u:GetEnemy()
		local w = u:FindAbilityByName("jugg_shard")
		if IsInjurable(u, v) and IsValid(w) then
			v:AddNewModifier(u, w, "modifier_jugg_talent_10", { duration = 1 })
		end
	end
end
function X.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self.parent, -1 } }
end
function X.prototype.OnCustomAttackLanded(self, x)
	if x and IsValid(x.ability) and x.ability:GetAbilityName() == "jugg_shard" then
		Heal(self.parent, x.damage * self.shard_steal_hp_pct * 0.01, self:GetAbility():GetAbilityName(), "Ability")
	end
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
g.modifier_jugg_shard = X
return g