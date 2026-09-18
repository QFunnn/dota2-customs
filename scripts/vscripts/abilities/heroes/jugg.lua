--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
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
		["404"] = 302,
		["405"] = 279,
		["406"] = 303,
		["407"] = 304,
		["408"] = 305,
		["409"] = 308,
		["410"] = 312,
		["411"] = 313,
		["412"] = 314,
		["413"] = 316,
		["414"] = 317,
		["415"] = 318,
		["416"] = 303,
		["417"] = 320,
		["418"] = 321,
		["419"] = 322,
		["420"] = 323,
		["421"] = 324,
		["422"] = 324,
		["423"] = 324,
		["424"] = 324,
		["425"] = 324,
		["427"] = 326,
		["428"] = 327,
		["429"] = 328,
		["430"] = 328,
		["431"] = 328,
		["432"] = 329,
		["433"] = 330,
		["435"] = 328,
		["436"] = 328,
		["438"] = 335,
		["439"] = 336,
		["440"] = 336,
		["441"] = 336,
		["442"] = 336,
		["443"] = 336,
		["444"] = 337,
		["445"] = 337,
		["446"] = 337,
		["447"] = 337,
		["448"] = 337,
		["449"] = 337,
		["450"] = 337,
		["451"] = 337,
		["453"] = 320,
		["454"] = 340,
		["455"] = 341,
		["456"] = 342,
		["457"] = 342,
		["458"] = 342,
		["459"] = 342,
		["461"] = 340,
		["462"] = 345,
		["463"] = 346,
		["464"] = 347,
		["465"] = 348,
		["467"] = 345,
		["468"] = 351,
		["469"] = 352,
		["470"] = 353,
		["471"] = 354,
		["472"] = 355,
		["473"] = 355,
		["475"] = 356,
		["476"] = 357,
		["477"] = 357,
		["478"] = 357,
		["479"] = 357,
		["480"] = 357,
		["481"] = 357,
		["482"] = 358,
		["483"] = 359,
		["484"] = 359,
		["485"] = 359,
		["486"] = 359,
		["487"] = 359,
		["489"] = 363,
		["490"] = 364,
		["491"] = 364,
		["492"] = 364,
		["493"] = 364,
		["494"] = 364,
		["496"] = 366,
		["497"] = 351,
		["498"] = 376,
		["499"] = 377,
		["500"] = 376,
		["501"] = 288,
		["502"] = 279,
		["503"] = 279,
		["504"] = 279,
		["505"] = 279,
		["506"] = 279,
		["507"] = 279,
		["508"] = 279,
		["509"] = 279,
		["510"] = 279,
		["511"] = 288,
		["513"] = 288,
		["515"] = 414,
		["516"] = 415,
		["517"] = 414,
		["518"] = 415,
		["519"] = 416,
		["520"] = 417,
		["521"] = 416,
		["522"] = 415,
		["523"] = 414,
		["524"] = 415,
		["526"] = 415,
		["527"] = 420,
		["528"] = 428,
		["529"] = 420,
		["530"] = 428,
		["531"] = 430,
		["532"] = 431,
		["533"] = 430,
		["534"] = 433,
		["535"] = 434,
		["536"] = 435,
		["538"] = 433,
		["539"] = 438,
		["540"] = 439,
		["541"] = 438,
		["542"] = 441,
		["543"] = 442,
		["544"] = 441,
		["545"] = 428,
		["546"] = 420,
		["547"] = 420,
		["548"] = 420,
		["549"] = 420,
		["550"] = 420,
		["551"] = 420,
		["552"] = 420,
		["553"] = 420,
		["554"] = 428,
		["556"] = 428,
		["558"] = 447,
		["559"] = 448,
		["560"] = 447,
		["561"] = 448,
		["562"] = 449,
		["563"] = 450,
		["564"] = 449,
		["565"] = 448,
		["566"] = 447,
		["567"] = 448,
		["569"] = 448,
		["570"] = 453,
		["571"] = 461,
		["572"] = 453,
		["573"] = 461,
		["574"] = 463,
		["575"] = 464,
		["576"] = 463,
		["577"] = 466,
		["578"] = 467,
		["579"] = 468,
		["581"] = 466,
		["582"] = 471,
		["583"] = 472,
		["584"] = 471,
		["585"] = 474,
		["586"] = 475,
		["587"] = 474,
		["588"] = 461,
		["589"] = 453,
		["590"] = 453,
		["591"] = 453,
		["592"] = 453,
		["593"] = 453,
		["594"] = 453,
		["595"] = 453,
		["596"] = 453,
		["597"] = 461,
		["599"] = 461,
		["600"] = 480,
		["601"] = 481,
		["602"] = 480,
		["603"] = 481,
		["604"] = 482,
		["605"] = 483,
		["606"] = 482,
		["607"] = 481,
		["608"] = 480,
		["609"] = 481,
		["611"] = 481,
		["612"] = 487,
		["613"] = 495,
		["614"] = 487,
		["615"] = 495,
		["617"] = 495,
		["618"] = 496,
		["619"] = 487,
		["620"] = 501,
		["621"] = 502,
		["622"] = 503,
		["623"] = 501,
		["624"] = 506,
		["625"] = 508,
		["626"] = 509,
		["627"] = 510,
		["628"] = 511,
		["629"] = 512,
		["630"] = 513,
		["631"] = 514,
		["632"] = 516,
		["635"] = 506,
		["636"] = 521,
		["637"] = 522,
		["638"] = 521,
		["639"] = 526,
		["640"] = 527,
		["641"] = 528,
		["642"] = 528,
		["643"] = 528,
		["644"] = 528,
		["645"] = 528,
		["646"] = 528,
		["648"] = 526,
		["649"] = 495,
		["650"] = 487,
		["651"] = 487,
		["652"] = 487,
		["653"] = 487,
		["654"] = 487,
		["655"] = 487,
		["656"] = 487,
		["657"] = 487,
		["658"] = 495,
		["660"] = 495,
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