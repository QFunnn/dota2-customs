--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
		["34"] = 30,
		["35"] = 32,
		["36"] = 33,
		["37"] = 34,
		["38"] = 35,
		["39"] = 36,
		["40"] = 37,
		["41"] = 38,
		["42"] = 39,
		["43"] = 40,
		["44"] = 30,
		["45"] = 42,
		["46"] = 43,
		["47"] = 42,
		["48"] = 45,
		["49"] = 46,
		["50"] = 45,
		["51"] = 52,
		["52"] = 53,
		["53"] = 53,
		["54"] = 54,
		["56"] = 52,
		["57"] = 57,
		["58"] = 58,
		["59"] = 57,
		["60"] = 60,
		["61"] = 61,
		["62"] = 61,
		["63"] = 63,
		["64"] = 63,
		["65"] = 63,
		["66"] = 61,
		["67"] = 64,
		["68"] = 64,
		["69"] = 64,
		["70"] = 61,
		["71"] = 61,
		["72"] = 60,
		["73"] = 67,
		["74"] = 68,
		["75"] = 69,
		["76"] = 70,
		["77"] = 71,
		["78"] = 72,
		["79"] = 73,
		["82"] = 67,
		["83"] = 77,
		["84"] = 78,
		["85"] = 79,
		["86"] = 80,
		["87"] = 81,
		["88"] = 82,
		["89"] = 83,
		["90"] = 83,
		["91"] = 83,
		["92"] = 83,
		["93"] = 83,
		["94"] = 83,
		["97"] = 77,
		["98"] = 87,
		["99"] = 88,
		["102"] = 89,
		["103"] = 90,
		["104"] = 90,
		["105"] = 90,
		["106"] = 90,
		["107"] = 90,
		["108"] = 90,
		["109"] = 92,
		["110"] = 93,
		["111"] = 93,
		["112"] = 93,
		["113"] = 93,
		["116"] = 87,
		["117"] = 101,
		["118"] = 104,
		["119"] = 101,
		["120"] = 107,
		["121"] = 108,
		["122"] = 110,
		["124"] = 107,
		["125"] = 20,
		["126"] = 12,
		["127"] = 12,
		["128"] = 12,
		["129"] = 12,
		["130"] = 12,
		["131"] = 12,
		["132"] = 12,
		["133"] = 12,
		["134"] = 20,
		["136"] = 20,
		["138"] = 116,
		["139"] = 125,
		["140"] = 116,
		["141"] = 125,
		["143"] = 125,
		["144"] = 129,
		["145"] = 130,
		["146"] = 116,
		["147"] = 131,
		["148"] = 132,
		["149"] = 131,
		["150"] = 134,
		["151"] = 135,
		["152"] = 136,
		["153"] = 137,
		["154"] = 138,
		["155"] = 139,
		["157"] = 141,
		["158"] = 142,
		["159"] = 143,
		["160"] = 144,
		["162"] = 145,
		["163"] = 145,
		["164"] = 146,
		["165"] = 146,
		["166"] = 146,
		["167"] = 146,
		["168"] = 146,
		["169"] = 146,
		["170"] = 146,
		["171"] = 146,
		["172"] = 146,
		["173"] = 146,
		["174"] = 146,
		["175"] = 146,
		["176"] = 145,
		["179"] = 149,
		["180"] = 152,
		["181"] = 153,
		["182"] = 154,
		["183"] = 154,
		["184"] = 154,
		["185"] = 154,
		["186"] = 154,
		["187"] = 155,
		["188"] = 155,
		["189"] = 155,
		["190"] = 155,
		["191"] = 155,
		["192"] = 155,
		["193"] = 155,
		["194"] = 155,
		["196"] = 134,
		["197"] = 158,
		["198"] = 159,
		["199"] = 160,
		["200"] = 161,
		["201"] = 162,
		["202"] = 163,
		["203"] = 164,
		["204"] = 166,
		["205"] = 167,
		["206"] = 167,
		["208"] = 168,
		["209"] = 169,
		["210"] = 170,
		["211"] = 171,
		["212"] = 173,
		["213"] = 173,
		["214"] = 173,
		["215"] = 173,
		["216"] = 173,
		["217"] = 176,
		["218"] = 177,
		["219"] = 178,
		["221"] = 180,
		["222"] = 181,
		["223"] = 181,
		["224"] = 181,
		["225"] = 181,
		["226"] = 181,
		["227"] = 181,
		["228"] = 181,
		["229"] = 181,
		["230"] = 181,
		["231"] = 182,
		["232"] = 158,
		["233"] = 125,
		["234"] = 116,
		["235"] = 116,
		["236"] = 116,
		["237"] = 116,
		["238"] = 116,
		["239"] = 116,
		["240"] = 116,
		["241"] = 116,
		["242"] = 116,
		["243"] = 125,
		["245"] = 125,
		["247"] = 187,
		["248"] = 188,
		["249"] = 187,
		["250"] = 188,
		["251"] = 189,
		["252"] = 190,
		["253"] = 191,
		["254"] = 191,
		["255"] = 191,
		["256"] = 191,
		["257"] = 191,
		["258"] = 191,
		["259"] = 189,
		["260"] = 193,
		["261"] = 194,
		["262"] = 193,
		["263"] = 188,
		["264"] = 187,
		["265"] = 188,
		["267"] = 188,
		["268"] = 197,
		["269"] = 205,
		["270"] = 197,
		["271"] = 205,
		["273"] = 205,
		["274"] = 206,
		["275"] = 197,
		["276"] = 207,
		["277"] = 208,
		["278"] = 209,
		["280"] = 207,
		["281"] = 212,
		["282"] = 213,
		["283"] = 214,
		["284"] = 215,
		["286"] = 217,
		["287"] = 218,
		["288"] = 219,
		["290"] = 212,
		["291"] = 205,
		["292"] = 197,
		["293"] = 197,
		["294"] = 197,
		["295"] = 197,
		["296"] = 197,
		["297"] = 197,
		["298"] = 197,
		["299"] = 197,
		["300"] = 205,
		["302"] = 205,
		["303"] = 223,
		["304"] = 232,
		["305"] = 223,
		["306"] = 232,
		["308"] = 232,
		["309"] = 246,
		["310"] = 223,
		["311"] = 247,
		["312"] = 248,
		["313"] = 250,
		["314"] = 251,
		["315"] = 252,
		["316"] = 253,
		["317"] = 256,
		["318"] = 257,
		["319"] = 258,
		["320"] = 260,
		["321"] = 261,
		["322"] = 262,
		["323"] = 247,
		["324"] = 264,
		["325"] = 265,
		["326"] = 266,
		["327"] = 267,
		["328"] = 268,
		["329"] = 268,
		["330"] = 268,
		["331"] = 268,
		["332"] = 268,
		["334"] = 270,
		["335"] = 271,
		["336"] = 272,
		["337"] = 272,
		["338"] = 272,
		["339"] = 273,
		["340"] = 274,
		["342"] = 272,
		["343"] = 272,
		["345"] = 279,
		["346"] = 280,
		["347"] = 280,
		["348"] = 280,
		["349"] = 280,
		["350"] = 280,
		["351"] = 281,
		["352"] = 281,
		["353"] = 281,
		["354"] = 281,
		["355"] = 281,
		["356"] = 281,
		["357"] = 281,
		["358"] = 281,
		["360"] = 264,
		["361"] = 284,
		["362"] = 285,
		["363"] = 286,
		["364"] = 286,
		["365"] = 286,
		["366"] = 286,
		["368"] = 284,
		["369"] = 289,
		["370"] = 290,
		["371"] = 291,
		["372"] = 292,
		["374"] = 289,
		["375"] = 295,
		["376"] = 296,
		["377"] = 297,
		["378"] = 298,
		["379"] = 299,
		["380"] = 299,
		["382"] = 300,
		["383"] = 300,
		["384"] = 300,
		["385"] = 300,
		["386"] = 300,
		["387"] = 300,
		["388"] = 301,
		["389"] = 301,
		["390"] = 301,
		["391"] = 301,
		["392"] = 302,
		["393"] = 302,
		["394"] = 302,
		["395"] = 302,
		["396"] = 303,
		["397"] = 303,
		["398"] = 303,
		["399"] = 303,
		["400"] = 304,
		["401"] = 305,
		["402"] = 305,
		["403"] = 305,
		["404"] = 305,
		["405"] = 305,
		["407"] = 309,
		["408"] = 310,
		["409"] = 310,
		["410"] = 310,
		["411"] = 310,
		["412"] = 310,
		["414"] = 312,
		["415"] = 295,
		["416"] = 322,
		["417"] = 323,
		["418"] = 322,
		["419"] = 232,
		["420"] = 223,
		["421"] = 223,
		["422"] = 223,
		["423"] = 223,
		["424"] = 223,
		["425"] = 223,
		["426"] = 223,
		["427"] = 223,
		["428"] = 223,
		["429"] = 232,
		["431"] = 232,
		["433"] = 360,
		["434"] = 361,
		["435"] = 360,
		["436"] = 361,
		["437"] = 362,
		["438"] = 363,
		["439"] = 362,
		["440"] = 361,
		["441"] = 360,
		["442"] = 361,
		["444"] = 361,
		["445"] = 366,
		["446"] = 374,
		["447"] = 366,
		["448"] = 374,
		["449"] = 376,
		["450"] = 377,
		["451"] = 376,
		["452"] = 379,
		["453"] = 380,
		["454"] = 381,
		["456"] = 379,
		["457"] = 384,
		["458"] = 385,
		["459"] = 384,
		["460"] = 387,
		["461"] = 388,
		["462"] = 387,
		["463"] = 374,
		["464"] = 366,
		["465"] = 366,
		["466"] = 366,
		["467"] = 366,
		["468"] = 366,
		["469"] = 366,
		["470"] = 366,
		["471"] = 366,
		["472"] = 374,
		["474"] = 374,
		["476"] = 393,
		["477"] = 394,
		["478"] = 393,
		["479"] = 394,
		["480"] = 395,
		["481"] = 396,
		["482"] = 395,
		["483"] = 394,
		["484"] = 393,
		["485"] = 394,
		["487"] = 394,
		["488"] = 399,
		["489"] = 407,
		["490"] = 399,
		["491"] = 407,
		["492"] = 409,
		["493"] = 410,
		["494"] = 409,
		["495"] = 412,
		["496"] = 413,
		["497"] = 414,
		["499"] = 412,
		["500"] = 417,
		["501"] = 418,
		["502"] = 417,
		["503"] = 420,
		["504"] = 421,
		["505"] = 420,
		["506"] = 407,
		["507"] = 399,
		["508"] = 399,
		["509"] = 399,
		["510"] = 399,
		["511"] = 399,
		["512"] = 399,
		["513"] = 399,
		["514"] = 399,
		["515"] = 407,
		["517"] = 407,
		["518"] = 426,
		["519"] = 427,
		["520"] = 426,
		["521"] = 427,
		["522"] = 428,
		["523"] = 429,
		["524"] = 428,
		["525"] = 427,
		["526"] = 426,
		["527"] = 427,
		["529"] = 427,
		["530"] = 433,
		["531"] = 441,
		["532"] = 433,
		["533"] = 441,
		["535"] = 441,
		["536"] = 442,
		["537"] = 433,
		["538"] = 447,
		["539"] = 448,
		["540"] = 449,
		["541"] = 447,
		["542"] = 452,
		["543"] = 454,
		["544"] = 455,
		["545"] = 456,
		["546"] = 457,
		["547"] = 458,
		["548"] = 459,
		["549"] = 460,
		["550"] = 462,
		["553"] = 452,
		["554"] = 467,
		["555"] = 468,
		["556"] = 467,
		["557"] = 472,
		["558"] = 473,
		["559"] = 474,
		["560"] = 474,
		["561"] = 474,
		["562"] = 474,
		["563"] = 474,
		["564"] = 474,
		["566"] = 472,
		["567"] = 441,
		["568"] = 433,
		["569"] = 433,
		["570"] = 433,
		["571"] = 433,
		["572"] = 433,
		["573"] = 433,
		["574"] = 433,
		["575"] = 433,
		["576"] = 441,
		["578"] = 441,
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
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.chance = self:GetAbilityTalentValue("jugg_talent_2", "chance")
	self.mana_regen = self:GetAbilityTalentValue("jugg_talent_2", "mana_regen")
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
function r.prototype.OnCritical(self, s)
	if self:GetCaster():PassivesDisabled() then
		return
	end
	if s.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		s.attacker:AddNewModifier(
			s.attacker,
			self:GetParent():FindAbilityByName("jugg_ult"),
			"modifier_jugg_ult_buff",
			{ duration = self.duration }
		)
		if self:PRD(self.chance) then
			Restore(self:GetParent(), self.mana_regen)
		end
	end
end
function r.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self, s)
	return self.chance_bonus
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
g.modifier_jugg_talent_10 = c()
local z = g.modifier_jugg_talent_10
z.name = "modifier_jugg_talent_10"
d(z, l)
function z.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tPosition = {}
	self.radius = 400
end
function z.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilityTalentValue("jugg_talent_10", "count")
end
function z.prototype.OnCreated(self, s)
	if IsServer() then
		local A = self:GetParent()
		local B = self:GetDuration()
		if self.ability:GetAbilityName() == "jugg_shard" then
			self.count = self:GetAbilityTalentValue("jugg_shard", "steal_hp_cnt")
		end
		self:SetStackCount(self.count)
		self.vCenter = A:GetAbsOrigin()
		self.vInitDirection = self.vCenter + RandomVector(self.radius)
		self.tPosition = {}
		do
			local C = 0
			while C < self:GetStackCount() do
				table.insert(
					self.tPosition,
					RotatePosition(self.vCenter, QAngle(0, C * 360 / self:GetStackCount(), 0), self.vInitDirection)
				)
				C = C + 1
			end
		end
		self:StartIntervalThink(0.1)
		local D =
			ParticleManager:CreateParticle("particles/sect/sect_attack_139_circle.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(D, 0, self.vCenter)
		ParticleManager:SetParticleControl(D, 1, Vector(self.radius, 1, 1))
		self:AddParticle(D, false, false, -1, false, false)
	end
end
function z.prototype.OnIntervalThink(self)
	local E = self:GetCaster()
	local A = self:GetParent()
	local F = self:GetAbility()
	local G = ParticleManager:CreateParticle("particles/sect/sect_139_path.vpcf", PATTACH_CUSTOMORIGIN, nil)
	local H = self.tPosition[self:GetStackCount()]
	local I = H + (self.vCenter - H):Normalized() * self.radius * 2
	local J = A:FindModifierByName("modifier_jugg_shard")
	if J ~= nil then
		J:AddShardTirggerRecord()
	end
	A:EmitSound("Hero_Juggernaut.OmniSlash.Damage")
	ParticleManager:SetParticleControl(G, 0, H)
	ParticleManager:SetParticleControl(G, 1, I)
	ParticleManager:ReleaseParticleIndex(G)
	DamageSystem:performAttack(E, A, { ability = self:GetAbility() })
	self:DecrementStackCount()
	if self:GetStackCount() <= 0 then
		self:Destroy()
	end
	local D = ParticleManager:CreateParticle("particles/sect/sect_attack_139_flame.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControlEnt(D, 4, A, PATTACH_POINT_FOLLOW, "attach_hitloc", A:GetAbsOrigin(), false)
	ParticleManager:ReleaseParticleIndex(D)
end
z = e(
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
	z
)
g.modifier_jugg_talent_10 = z
g.jugg_ult = c()
local K = g.jugg_ult
K.name = "jugg_ult"
d(K, o)
function K.prototype.OnSpellStart(self)
	local E = self:GetCaster()
	E:AddNewModifier(E, self, "modifier_jugg_ult_buff", { duration = self:GetSpecialValueFor("duration") })
end
function K.prototype.GetIntrinsicModifierName(self)
	return "modifier_jugg_ult"
end
K = e({ p(nil) }, K)
g.jugg_ult = K
g.modifier_jugg_ult = c()
local L = g.modifier_jugg_ult
L.name = "modifier_jugg_ult"
d(L, l)
function L.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.animation = false
end
function L.prototype.OnCreated(self, s)
	if IsServer() then
		self:StartIntervalThink(0)
	end
end
function L.prototype.OnIntervalThink(self)
	if self.animation == false and self:GetParent():HasModifier("modifier_jugg_ult_buff") then
		self:GetParent():StartGesture(ACT_DOTA_OVERRIDE_ABILITY_1)
		self.animation = true
	end
	if self.animation and not self:GetParent():HasModifier("modifier_jugg_ult_buff") then
		self:GetParent():RemoveGesture(ACT_DOTA_OVERRIDE_ABILITY_1)
		self.animation = false
	end
end
L = e(
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
	L
)
g.modifier_jugg_ult = L
g.modifier_jugg_ult_buff = c()
local M = g.modifier_jugg_ult_buff
M.name = "modifier_jugg_ult_buff"
d(M, l)
function M.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tl5_interval_reduce = 0
end
function M.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.reduce_pct = self:GetAbilitySpecialValueFor("reduce_pct")
	self.tl3_attack_speed_bonus = self:GetAbilityTalentValue("jugg_talent_3", "attack_speed_bonus")
	self.damage = self:GetAbilitySpecialValueFor("damage") + self:GetAbilityTalentValue("jugg_talent_1", "damage_bonus")
	self.crit_damage_bonus = self:GetAbilityTalentValue("jugg_talent_4", "crit_damage_bonus")
	self.damage_reduce_pct = self:GetAbilityTalentValue("jugg_talent_10", "damage_reduce_pct")
	self.chance = self:GetAbilityTalentValue("jugg_talent_11", "chance")
	self.count = self:GetAbilityTalentValue("jugg_talent_11", "count")
	self.tl5_max_reduce = self:GetAbilityTalentValue("jugg_talent_5", "max_reduce")
	self.tl5_min_reduce = self:GetAbilityTalentValue("jugg_talent_5", "min_reduce")
	self.tl5_attackspeed_max = self:GetAbilityTalentValue("jugg_talent_5", "attackspeed_max")
end
function M.prototype.OnCreated(self, s)
	local A = self:GetParent()
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
		A:EmitSound("Hero_Juggernaut.BladeFuryStart")
		GameTimer(self:GetDuration(), function()
			if IsValid(A) then
				A:StopSound("Hero_Juggernaut.BladeFuryStart")
			end
		end)
	else
		local D = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_juggernaut/juggernaut_blade_fury.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			A
		)
		ParticleManager:SetParticleControl(D, 5, Vector(300, 300, 300))
		self:AddParticle(D, false, false, -1, false, false)
	end
end
function M.prototype.OnRefresh(self, s)
	if IsServer() then
		self:SetDuration(self:GetRemainingTime() + s.duration, false)
	end
end
function M.prototype.OnRemoved(self, N)
	if IsServer() then
		local A = self:GetParent()
		A:StopSound("Hero_Juggernaut.BladeFuryStart")
	end
end
function M.prototype.OnIntervalThink(self)
	local A = self:GetParent()
	local O = A:GetEnemy()
	local J = A:FindModifierByName("modifier_jugg_shard")
	if J ~= nil then
		J:AddShardTirggerRecord()
	end
	A:DealDamage(O, self:GetAbility(), self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
	ReduceIce(A, GetIce(A) * self.reduce_pct * 0.01)
	ReducePoison(A, GetPoison(A) * self.reduce_pct * 0.01)
	ReduceInjury(A, GetInjury(A) * self.reduce_pct * 0.01)
	if self:PRD(self.chance) then
		DamageSystem:performAttack(A, O, { ability = self:GetAbility() })
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
function M.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
M = e(
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
	M
)
g.modifier_jugg_ult_buff = M
g.jugg_talent_7 = c()
local P = g.jugg_talent_7
P.name = "jugg_talent_7"
d(P, i)
function P.prototype.GetIntrinsicModifierName(self)
	return "modifier_jugg_talent_7"
end
P = e({ j(nil) }, P)
g.jugg_talent_7 = P
g.modifier_jugg_talent_7 = c()
local Q = g.modifier_jugg_talent_7
Q.name = "modifier_jugg_talent_7"
d(Q, l)
function Q.prototype.GetAbilitySpecialValue(self)
	self.ulti_power_per_victory = self:GetAbilitySpecialValueFor("ulti_power_per_victory")
end
function Q.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(PlayerData:getTotalWin(self:GetParent():GetPlayerOwnerID()) * self.ulti_power_per_victory)
	end
end
function Q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER }
end
function Q.prototype.EOM_GetModifierUltiPower(self)
	return self:GetStackCount()
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
g.modifier_jugg_talent_7 = Q
g.jugg_talent_8 = c()
local R = g.jugg_talent_8
R.name = "jugg_talent_8"
d(R, i)
function R.prototype.GetIntrinsicModifierName(self)
	return "modifier_jugg_talent_8"
end
R = e({ j(nil) }, R)
g.jugg_talent_8 = R
g.modifier_jugg_talent_8 = c()
local S = g.modifier_jugg_talent_8
S.name = "modifier_jugg_talent_8"
d(S, l)
function S.prototype.GetAbilitySpecialValue(self)
	self.atk_speed_per_victory = self:GetAbilitySpecialValueFor("atk_speed_per_victory")
end
function S.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(PlayerData:getTotalWin(self:GetParent():GetPlayerOwnerID()) * self.atk_speed_per_victory)
	end
end
function S.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function S.prototype.EOM_GetModifierAttackDamageBonus(self)
	return self:GetStackCount()
end
S = e(
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
	S
)
g.modifier_jugg_talent_8 = S
g.jugg_shard = c()
local T = g.jugg_shard
T.name = "jugg_shard"
d(T, i)
function T.prototype.GetIntrinsicModifierName(self)
	return "modifier_jugg_shard"
end
T = e({ j(nil) }, T)
g.jugg_shard = T
g.modifier_jugg_shard = c()
local U = g.modifier_jugg_shard
U.name = "modifier_jugg_shard"
d(U, l)
function U.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.record = 0
end
function U.prototype.GetAbilitySpecialValue(self)
	self.shard_trigger = self:GetAbilityTalentValue("jugg_shard", "trigger")
	self.shard_steal_hp_pct = self:GetAbilityTalentValue("jugg_shard", "steal_hp_pct")
end
function U.prototype.AddShardTirggerRecord(self)
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
function U.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self.parent, -1 } }
end
function U.prototype.OnCustomAttackLanded(self, x)
	if x and IsValid(x.ability) and x.ability:GetAbilityName() == "jugg_shard" then
		Heal(self.parent, x.damage * self.shard_steal_hp_pct * 0.01, self:GetAbility():GetAbilityName(), "Ability")
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
g.modifier_jugg_shard = U
return g