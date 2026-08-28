--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/sxy"
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
		["18"] = 6,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 7,
		["24"] = 6,
		["25"] = 5,
		["26"] = 6,
		["28"] = 6,
		["29"] = 12,
		["30"] = 20,
		["31"] = 12,
		["32"] = 20,
		["33"] = 44,
		["34"] = 45,
		["35"] = 47,
		["36"] = 48,
		["37"] = 49,
		["38"] = 50,
		["39"] = 51,
		["40"] = 52,
		["41"] = 53,
		["42"] = 54,
		["43"] = 56,
		["44"] = 58,
		["45"] = 59,
		["46"] = 60,
		["47"] = 61,
		["48"] = 44,
		["49"] = 65,
		["50"] = 66,
		["51"] = 67,
		["53"] = 69,
		["54"] = 65,
		["55"] = 71,
		["56"] = 72,
		["57"] = 73,
		["58"] = 73,
		["59"] = 73,
		["60"] = 72,
		["61"] = 74,
		["62"] = 74,
		["63"] = 74,
		["64"] = 72,
		["65"] = 72,
		["66"] = 72,
		["67"] = 71,
		["68"] = 78,
		["69"] = 79,
		["70"] = 80,
		["71"] = 81,
		["72"] = 82,
		["73"] = 83,
		["74"] = 85,
		["75"] = 86,
		["76"] = 87,
		["79"] = 78,
		["80"] = 91,
		["81"] = 91,
		["82"] = 91,
		["84"] = 93,
		["85"] = 94,
		["86"] = 94,
		["87"] = 94,
		["88"] = 94,
		["89"] = 94,
		["90"] = 94,
		["91"] = 94,
		["92"] = 94,
		["93"] = 94,
		["94"] = 94,
		["95"] = 94,
		["96"] = 94,
		["97"] = 94,
		["98"] = 91,
		["99"] = 103,
		["100"] = 104,
		["101"] = 105,
		["102"] = 106,
		["103"] = 108,
		["105"] = 103,
		["106"] = 111,
		["107"] = 112,
		["108"] = 113,
		["109"] = 114,
		["110"] = 115,
		["111"] = 111,
		["112"] = 118,
		["113"] = 119,
		["114"] = 118,
		["115"] = 127,
		["116"] = 128,
		["117"] = 129,
		["118"] = 127,
		["119"] = 134,
		["120"] = 135,
		["121"] = 135,
		["122"] = 135,
		["123"] = 135,
		["124"] = 136,
		["125"] = 136,
		["126"] = 136,
		["128"] = 136,
		["130"] = 136,
		["131"] = 137,
		["132"] = 134,
		["133"] = 139,
		["134"] = 140,
		["137"] = 140,
		["138"] = 140,
		["140"] = 140,
		["142"] = 140,
		["143"] = 141,
		["145"] = 143,
		["146"] = 144,
		["147"] = 145,
		["148"] = 146,
		["150"] = 148,
		["152"] = 150,
		["153"] = 139,
		["154"] = 152,
		["155"] = 153,
		["158"] = 153,
		["159"] = 153,
		["161"] = 153,
		["163"] = 153,
		["164"] = 154,
		["166"] = 156,
		["167"] = 152,
		["168"] = 20,
		["169"] = 12,
		["170"] = 12,
		["171"] = 12,
		["172"] = 12,
		["173"] = 12,
		["174"] = 12,
		["175"] = 12,
		["176"] = 12,
		["177"] = 20,
		["179"] = 20,
		["180"] = 160,
		["181"] = 172,
		["182"] = 160,
		["183"] = 172,
		["184"] = 185,
		["185"] = 186,
		["186"] = 185,
		["187"] = 188,
		["188"] = 189,
		["189"] = 190,
		["190"] = 188,
		["191"] = 193,
		["192"] = 194,
		["193"] = 195,
		["194"] = 196,
		["195"] = 197,
		["196"] = 198,
		["197"] = 199,
		["198"] = 200,
		["199"] = 201,
		["200"] = 202,
		["201"] = 203,
		["202"] = 204,
		["203"] = 204,
		["204"] = 205,
		["205"] = 205,
		["206"] = 205,
		["207"] = 205,
		["208"] = 205,
		["209"] = 205,
		["211"] = 193,
		["212"] = 210,
		["213"] = 211,
		["214"] = 212,
		["215"] = 212,
		["216"] = 212,
		["217"] = 212,
		["218"] = 212,
		["219"] = 212,
		["220"] = 213,
		["221"] = 214,
		["222"] = 215,
		["223"] = 215,
		["225"] = 217,
		["226"] = 218,
		["229"] = 210,
		["230"] = 223,
		["231"] = 224,
		["232"] = 223,
		["233"] = 227,
		["234"] = 228,
		["235"] = 229,
		["237"] = 230,
		["238"] = 230,
		["239"] = 231,
		["240"] = 231,
		["241"] = 232,
		["242"] = 233,
		["244"] = 230,
		["247"] = 236,
		["248"] = 237,
		["249"] = 238,
		["250"] = 238,
		["251"] = 238,
		["252"] = 238,
		["253"] = 238,
		["254"] = 238,
		["255"] = 238,
		["256"] = 238,
		["257"] = 238,
		["258"] = 239,
		["259"] = 239,
		["260"] = 239,
		["261"] = 239,
		["262"] = 239,
		["263"] = 239,
		["264"] = 240,
		["265"] = 241,
		["266"] = 241,
		["267"] = 241,
		["268"] = 241,
		["269"] = 241,
		["270"] = 241,
		["271"] = 227,
		["272"] = 244,
		["273"] = 245,
		["274"] = 246,
		["276"] = 247,
		["277"] = 247,
		["278"] = 248,
		["279"] = 247,
		["282"] = 250,
		["283"] = 251,
		["284"] = 252,
		["285"] = 253,
		["286"] = 254,
		["287"] = 254,
		["288"] = 254,
		["289"] = 254,
		["290"] = 254,
		["291"] = 254,
		["292"] = 254,
		["293"] = 254,
		["294"] = 254,
		["295"] = 255,
		["296"] = 255,
		["297"] = 255,
		["298"] = 255,
		["299"] = 255,
		["300"] = 255,
		["301"] = 256,
		["302"] = 257,
		["303"] = 257,
		["304"] = 257,
		["305"] = 257,
		["306"] = 257,
		["307"] = 257,
		["308"] = 258,
		["309"] = 244,
		["310"] = 261,
		["311"] = 262,
		["312"] = 261,
		["313"] = 172,
		["314"] = 160,
		["315"] = 160,
		["316"] = 160,
		["317"] = 160,
		["318"] = 160,
		["319"] = 160,
		["320"] = 160,
		["321"] = 160,
		["322"] = 160,
		["323"] = 160,
		["324"] = 160,
		["325"] = 172,
		["327"] = 172,
		["328"] = 269,
		["329"] = 270,
		["330"] = 269,
		["331"] = 270,
		["332"] = 284,
		["333"] = 285,
		["334"] = 284,
		["335"] = 288,
		["336"] = 288,
		["337"] = 288,
		["339"] = 289,
		["340"] = 290,
		["341"] = 291,
		["342"] = 292,
		["343"] = 293,
		["344"] = 296,
		["345"] = 297,
		["346"] = 298,
		["347"] = 299,
		["348"] = 300,
		["349"] = 301,
		["350"] = 302,
		["351"] = 304,
		["352"] = 305,
		["353"] = 306,
		["354"] = 307,
		["355"] = 307,
		["356"] = 307,
		["357"] = 307,
		["358"] = 307,
		["359"] = 308,
		["360"] = 308,
		["361"] = 308,
		["362"] = 309,
		["363"] = 308,
		["364"] = 308,
		["366"] = 313,
		["367"] = 314,
		["368"] = 315,
		["369"] = 316,
		["370"] = 317,
		["371"] = 317,
		["372"] = 317,
		["373"] = 317,
		["374"] = 317,
		["375"] = 317,
		["376"] = 317,
		["377"] = 321,
		["378"] = 321,
		["379"] = 321,
		["380"] = 321,
		["381"] = 321,
		["382"] = 321,
		["383"] = 321,
		["384"] = 328,
		["385"] = 329,
		["386"] = 331,
		["387"] = 321,
		["388"] = 333,
		["389"] = 334,
		["390"] = 321,
		["391"] = 336,
		["392"] = 337,
		["393"] = 338,
		["394"] = 338,
		["395"] = 338,
		["396"] = 338,
		["397"] = 338,
		["398"] = 338,
		["399"] = 338,
		["400"] = 338,
		["401"] = 338,
		["403"] = 340,
		["404"] = 321,
		["405"] = 321,
		["407"] = 288,
		["408"] = 345,
		["409"] = 346,
		["410"] = 345,
		["411"] = 354,
		["412"] = 355,
		["413"] = 356,
		["414"] = 357,
		["417"] = 358,
		["418"] = 359,
		["419"] = 360,
		["420"] = 361,
		["421"] = 362,
		["423"] = 354,
		["424"] = 366,
		["425"] = 366,
		["426"] = 366,
		["428"] = 366,
		["429"] = 366,
		["431"] = 366,
		["432"] = 366,
		["434"] = 367,
		["435"] = 368,
		["436"] = 369,
		["439"] = 370,
		["440"] = 371,
		["441"] = 372,
		["442"] = 373,
		["443"] = 374,
		["444"] = 375,
		["445"] = 378,
		["446"] = 379,
		["447"] = 380,
		["448"] = 380,
		["449"] = 380,
		["450"] = 380,
		["451"] = 380,
		["452"] = 380,
		["453"] = 382,
		["454"] = 383,
		["456"] = 366,
		["457"] = 270,
		["458"] = 269,
		["459"] = 270,
		["461"] = 270,
		["462"] = 388,
		["463"] = 398,
		["464"] = 388,
		["465"] = 398,
		["467"] = 398,
		["468"] = 402,
		["469"] = 403,
		["470"] = 388,
		["471"] = 404,
		["472"] = 405,
		["473"] = 406,
		["474"] = 407,
		["475"] = 408,
		["476"] = 409,
		["477"] = 410,
		["479"] = 412,
		["480"] = 413,
		["481"] = 414,
		["482"] = 415,
		["483"] = 416,
		["484"] = 417,
		["485"] = 417,
		["486"] = 417,
		["487"] = 418,
		["490"] = 419,
		["491"] = 420,
		["492"] = 420,
		["493"] = 420,
		["494"] = 420,
		["495"] = 420,
		["496"] = 417,
		["497"] = 417,
		["499"] = 404,
		["500"] = 425,
		["501"] = 426,
		["502"] = 427,
		["504"] = 425,
		["505"] = 430,
		["506"] = 431,
		["507"] = 432,
		["508"] = 433,
		["509"] = 434,
		["510"] = 434,
		["511"] = 435,
		["512"] = 435,
		["515"] = 437,
		["516"] = 437,
		["517"] = 437,
		["518"] = 437,
		["519"] = 430,
		["520"] = 439,
		["521"] = 440,
		["522"] = 441,
		["523"] = 442,
		["525"] = 439,
		["526"] = 398,
		["527"] = 388,
		["528"] = 388,
		["529"] = 388,
		["530"] = 388,
		["531"] = 388,
		["532"] = 388,
		["533"] = 388,
		["534"] = 388,
		["535"] = 388,
		["536"] = 388,
		["537"] = 398,
		["539"] = 398,
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
g.sxy_talent = c()
local q = g.sxy_talent
q.name = "sxy_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_sxy_talent"
end
q = e({ j(nil) }, q)
g.sxy_talent = q
g.modifier_sxy_talent = c()
local r = g.modifier_sxy_talent
r.name = "modifier_sxy_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.trigger_damage_pct = self:GetAbilitySpecialValueFor("trigger_damage_pct") * 0.01
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
		+ self:GetAbilityTalentValue("sxy_talent_5", "damage_bonus")
	self.fury_damage_pct = self:GetAbilitySpecialValueFor("fury_damage_pct")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.max_stack = self:GetAbilitySpecialValueFor("max_stack")
	self.atk_interval = self:GetAbilitySpecialValueFor("atk_interval")
	self.atk_speed_atk_pct = self:GetAbilitySpecialValueFor("atk_speed_atk_pct")
	self.damage_pct_base = self:GetAbilitySpecialValueFor("damage_pct_base")
	self.damage_pct_hero_level = self:GetAbilitySpecialValueFor("damage_pct_hero_level")
	self.reduce_atk_cnt = self:GetAbilityTalentValue("sxy_talent_2", "reduce_atk_cnt")
	self.bonus_atkSpeed = self:GetAbilityTalentValue("sxy_talent_4", "bonus_atkSpeed")
	self.ult_trigger = self:GetAbilitySpecialValueFor("ult_trigger") - self.reduce_atk_cnt
	self.reduce_pct = self:GetAbilityTalentValue("sxy_talent_3", "reduce_pct") * 0.01
	self.add_max = self:GetAbilityTalentValue("sxy_talent_3", "add_max")
end
function r.prototype.OnCreated(self, s)
	if IsServer() then
		self.data = 0
	end
	self.atk_record = 0
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 },
	}
end
function r.prototype.OnCustomTakeDamage(self, t)
	local u = t.attacker
	local v = u:GetEnemy()
	local w = t.damage
	local x = v:GetMaxHealth()
	local y = w / x
	if t.target == v and y >= self.trigger_damage_pct - self.reduce_pct and self then
		if IsInjurable(v, u) then
			self:AddSxyTalentModifer(u, v, w)
		end
	end
end
function r.prototype.AddSxyTalentModifer(self, u, v, z)
	if z == nil then
		z = 0
	end
	local A = self.max_stack + self.add_max
	v:AddNewModifier(
		u,
		self:GetAbility(),
		"modifier_sxy_talent_debuff",
		{
			base_damage = self.base_damage,
			fury_damage_pct = self.fury_damage_pct,
			max_stack = A,
			atk_interval = self.atk_interval,
			trigger_damage = z,
			duration = self.duration,
		}
	)
end
function r.prototype.OnCustomAttackLanded(self, t)
	self.atk_record = self.atk_record + 1
	if self.atk_record >= self.ult_trigger then
		self.atk_record = 0
		self:SpellUlt()
	end
end
function r.prototype.SpellUlt(self)
	local u = self:GetParent()
	local B = u:FindAbilityByName("sxy_ult")
	local C = self.damage_pct_base + self.damage_pct_hero_level * 2
	B:SxyUlt(C)
end
function r.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_OVERRIDE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_FORCE_OVERRIDE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_RATE_BONUS,
	}
end
function r.prototype.EOM_GetModifierAttackRateBonus(self, s)
	local D = GetBaseAttackRate(self.parent)
	return 1 / (1 / D + self.bonus_atkSpeed) - D
end
function r.prototype.EOM_GetModifierAttackDamageBonus(self)
	local E = GetAttackspeed(self:GetParent(), { _sxy = 1 })
	local F
	if E >= 0 then
		F = E
	else
		F = 0
	end
	E = F
	return E * self.atk_speed_atk_pct * 0.01
end
function r.prototype.EOM_GetModifierAttackSpeedBonusOverride(self, s)
	local G = s
	if G then
		local H
		if s ~= nil then
			H = s._sxy
		end
		G = H
	end
	if G then
		return 0
	end
	local I = 0
	if IsServer() then
		I = GetFury(self:GetCaster())
		self:SetStackCount(I)
	else
		I = self:GetStackCount()
	end
	return ICE_FURY_ATTACKSPEED(nil, I)
end
function r.prototype.EOM_GetModifierAttackSpeedBonusOverride_Force(self, s)
	local J = s
	if J then
		local K
		if s ~= nil then
			K = s._sxy
		end
		J = K
	end
	if J then
		return 0
	end
	return 1
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
g.modifier_sxy_talent = r
g.modifier_sxy_talent_debuff = c()
local L = g.modifier_sxy_talent_debuff
L.name = "modifier_sxy_talent_debuff"
d(L, l)
function L.prototype.GetTexture(self)
	return "bloodseeker_rupture"
end
function L.prototype.GetAbilitySpecialValue(self)
	self.add_fury_count = self:GetAbilitySpecialValueFor("add_fury_count")
	self.damage_pct = self:GetAbilityTalentValue("sxy_talent_5", "damage_pct")
end
function L.prototype.OnCreated(self, s)
	if IsServer() then
		self.tickStack = {}
		self.base_damage = s.base_damage
		self.fury_damage_pct = s.fury_damage_pct
		self.max_stack = s.max_stack
		self.atk_interval = s.atk_interval
		self.trigger_damage = s.trigger_damage
		self.atk_cnt = s.duration / self.atk_interval
		self:IncrementStackCount()
		self:StartIntervalThink(self.atk_interval)
		local M = self.tickStack
		M[#M + 1] = self.atk_cnt
		AddFury(self.caster, self.add_fury_count, self:GetAbility():GetName(), "Ability")
	end
end
function L.prototype.OnRefresh(self, s)
	if IsServer() then
		AddFury(self.caster, self.add_fury_count, self:GetAbility():GetName(), "Ability")
		if not self:HasAchieveMaxStack() then
			self:IncrementStackCount()
			local N = self.tickStack
			N[#N + 1] = self.atk_cnt
		end
		if s.trigger_damage > 0 then
			self.trigger_damage = s.trigger_damage
		end
	end
end
function L.prototype.OnIntervalThink(self)
	self:DebuffAtk()
end
function L.prototype.DebuffAtk(self)
	local u = self:GetCaster()
	local O = self:GetParent()
	do
		local P = #self.tickStack - 1
		while P >= 0 do
			local Q, R = self.tickStack, P + 1
			Q[R] = Q[R] - 1
			if self.tickStack[P + 1] <= 0 then
				table.remove(self.tickStack, P + 1)
			end
			P = P - 1
		end
	end
	local w = (
		self.base_damage
		+ GetFury(u) * self.fury_damage_pct * 0.01
		+ self.damage_pct * self.trigger_damage * 0.01
	) * self:GetStackCount()
	local S =
		ParticleManager:CreateParticle("particles/generic_gameplay/bleeding_trigger.vpcf", PATTACH_CUSTOMORIGIN, O)
	ParticleManager:SetParticleControlEnt(S, 0, O, PATTACH_POINT_FOLLOW, "attach_hitloc", O:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlTransformForward(S, 1, O:GetAbsOrigin(), CalcDirection2D(u, O))
	ParticleManager:ReleaseParticleIndex(S)
	u:DealDamage(self:GetParent(), self:GetAbility(), w, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
end
function L.prototype.ClearModifier(self)
	self:StartIntervalThink(-1)
	local T = 0
	do
		local P = #self.tickStack - 1
		while P >= 0 do
			T = T + self.tickStack[P + 1]
			P = P - 1
		end
	end
	local u = self:GetCaster()
	local O = self:GetParent()
	local w = (
		self.base_damage
		+ GetFury(u) * self.fury_damage_pct * 0.01
		+ self.damage_pct * self.trigger_damage * 0.01
	) * T
	local S =
		ParticleManager:CreateParticle("particles/generic_gameplay/bleeding_trigger.vpcf", PATTACH_CUSTOMORIGIN, O)
	ParticleManager:SetParticleControlEnt(S, 0, O, PATTACH_POINT_FOLLOW, "attach_hitloc", O:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlTransformForward(S, 1, O:GetAbsOrigin(), CalcDirection2D(u, O))
	ParticleManager:ReleaseParticleIndex(S)
	u:DealDamage(self:GetParent(), self:GetAbility(), w, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	O:RemoveModifierByName("modifier_sxy_talent_debuff")
end
function L.prototype.HasAchieveMaxStack(self)
	return self:GetStackCount() >= self.max_stack
end
L = e(
	{
		m(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetEffectName = "particles/generic_gameplay/bleeding.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
				IsIndependent = true,
			}
		),
	},
	L
)
g.modifier_sxy_talent_debuff = L
g.sxy_ult = c()
local U = g.sxy_ult
U.name = "sxy_ult"
d(U, o)
function U.prototype.OnSpellStart(self)
	self:SxyUlt()
end
function U.prototype.SxyUlt(self, C)
	if C == nil then
		C = 100
	end
	local u = self:GetCaster()
	local v = u:GetEnemy()
	self.damage1 = self:GetSpecialValueFor("damage")
	self.fury_pct = self:GetSpecialValueFor("fury_pct")
	self.sup_fury_pct = self:GetSpecialValueFor("sup_fury_pct")
	self.add_stack = self:GetTalentValue("sxy_talent_1", "add_stack")
	self.tl6_hp_damage_pct = self:GetTalentValue("sxy_talent_6", "hp_dmg_pct")
	self.tl6_add_fury_pct = self:GetTalentValue("sxy_talent_6", "add_fury_pct")
	self.tl7_ulti_bonus = self:GetTalentValue("sxy_talent_7", "ulti_bonus")
	self.atk_damage_pct = self:GetTalentValue("sxy_shard", "atk_damage_pct")
	local V = v:FindModifierByName("modifier_sxy_talent_debuff")
	u:StartGestureWithFadeAndPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 0.03, 0.06, 1.4)
	if not V or not (V and V:HasAchieveMaxStack()) then
		self:Atk(1, false, C)
		local W = ParticleManager:CreateParticle(
			"eom/t7_character/t7_daqiao/particles/daqiao_skill.vpcf",
			PATTACH_CUSTOMORIGIN,
			u
		)
		ParticleManager:SetParticleControl(W, 0, u:GetAbsOrigin() + Vector(0, 0, 100))
		GameTimer(BUFF_VALUE.BloodyStormAtkInterval, function()
			ParticleManager:DestroyParticle(W, true)
		end)
	else
		local X = u:GetAbsOrigin()
		local Y = v:GetAbsOrigin() - X
		Y.z = 0
		Y = Y:Normalized()
		local Z = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{ origin = u:GetAbsOrigin(), model = "models/development/invisiblebox.vmdl" }
		)
		Projectile:CreateLinearProjectile({
			hCaster = u,
			vSpawnOrigin = X,
			vDirection = Y,
			flDistance = 600,
			flRadius = 250,
			iMoveSpeed = PROJECTILE_SPEED_FAST,
			OnProjectileCreated = function(_)
				local a0 = ParticleManager:CreateParticle(
					"eom/t7_character/t7_daqiao/particles/daqiao_skill.vpcf",
					PATTACH_POINT_FOLLOW,
					Z
				)
				_._iParticleID = a0
			end,
			OnProjectileThink = function(a1, _)
				Z:SetAbsOrigin(a1 + Vector(0, 0, 100))
			end,
			OnProjectileDestroy = function(a1, _)
				if IsInjurable(u, v) then
					self:AddUltModifier(
						u,
						"modifier_sxy_ult",
						self.damage1,
						self.fury_pct,
						BUFF_VALUE.BloodyStormAtkInterval,
						BUFF_VALUE.BloodyStormDuration,
						v:GetAbsOrigin()
					)
				end
				UTIL_Remove(Z)
			end,
		})
	end
end
function U.prototype.AddUltModifier(self, u, a2, w, a3, a4, a5, a6)
	u:AddNewModifier(u, self, a2, { base_damage = w, fury_damage_pct = a3, atk_interval = a4, duration = a5 })
end
function U.prototype.AddSxyTalenStack(self)
	local u = self:GetCaster()
	local v = u:GetEnemy()
	if not IsInjurable(u, v) then
		return
	end
	local a7 = self.add_stack
	local a8 = u:FindModifierByName("modifier_sxy_talent")
	while a7 > 0 do
		a8:AddSxyTalentModifer(u, v)
		a7 = a7 - 1
	end
end
function U.prototype.Atk(self, a9, aa, C)
	if a9 == nil then
		a9 = 1
	end
	if aa == nil then
		aa = false
	end
	if C == nil then
		C = 100
	end
	local u = self:GetCaster()
	local v = u:GetEnemy()
	if not IsInjurable(u, v) then
		return
	end
	u:EmitSound("Hero_Axe.CounterHelix_Blood_Chaser")
	local ab = aa and BUFF_VALUE.BloodyStormBaseDamage or self.damage1
	local ac = aa and BUFF_VALUE.BloodyStormFuryDamagePct or self.fury_pct
	ac = ac + self.tl6_add_fury_pct
	local ad = aa and u:FindAbilityByName("sxy_ult_sup") or self
	local w = ab + ac * GetFury(u) * 0.01
	local ae = aa and 1 or C * 0.01
	local af = 1 + self.tl7_ulti_bonus * 0.01
	u:DealDamage(
		v,
		ad,
		(w + GetAttackDamage(u) * self.atk_damage_pct * 0.01) * a9 * ae * af,
		EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
	)
	if not aa then
		self:AddSxyTalenStack()
	end
end
U = e({ p(nil) }, U)
g.sxy_ult = U
g.modifier_sxy_ult = c()
local ag = g.modifier_sxy_ult
ag.name = "modifier_sxy_ult"
d(ag, l)
function ag.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.record = 0
	self.clear_trigger = 3
end
function ag.prototype.OnCreated(self, s)
	if IsServer() then
		local u = self:GetCaster()
		self.atk_interval = s.atk_interval
		self:IncrementStackCount()
		if s.duration > s.atk_interval then
			self:StartIntervalThink(self.atk_interval)
		end
		self.clear_trigger = math.floor(s.duration / s.atk_interval)
		self.ability:Atk()
		local O = self:GetParent()
		local v = O:GetEnemy()
		local ah = v
		GameTimer(0.1, function()
			if not IsInjurable(u) then
				return
			end
			self.fpx = ParticleManager:CreateParticle(
				"eom/t7_character/t7_daqiao/particles/daqiao_skill.vpcf",
				PATTACH_CUSTOMORIGIN,
				ah
			)
			ParticleManager:SetParticleControl(self.fpx, 0, ah:GetAbsOrigin() + Vector(0, 0, 100))
		end)
	end
end
function ag.prototype.OnRefresh(self, s)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function ag.prototype.OnIntervalThink(self)
	self.record = self.record + 1
	if self.record >= self.clear_trigger then
		self.record = self.record - self.clear_trigger
		local ai = self.caster:GetEnemy()
		local V = ai and ai:FindModifierByName("modifier_sxy_talent_debuff")
		if V ~= nil then
			V:ClearModifier()
		end
	end
	self.ability:Atk(self:GetStackCount(), true)
end
function ag.prototype.OnDestroy(self)
	if self.fpx then
		ParticleManager:DestroyParticle(self.fpx, true)
		self.fpx = nil
	end
end
ag = e(
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
				StatusEffectPriority = MODIFIER_PRIORITY_NORMAL,
				IsIndependent = true,
			}
		),
	},
	ag
)
g.modifier_sxy_ult = ag
return g