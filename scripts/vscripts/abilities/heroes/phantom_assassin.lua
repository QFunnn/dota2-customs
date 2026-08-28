--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/phantom_assassin"
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
		["35"] = 34,
		["36"] = 36,
		["37"] = 13,
		["38"] = 38,
		["39"] = 39,
		["40"] = 40,
		["41"] = 41,
		["42"] = 42,
		["43"] = 43,
		["44"] = 44,
		["45"] = 45,
		["46"] = 46,
		["47"] = 47,
		["48"] = 38,
		["49"] = 50,
		["50"] = 51,
		["51"] = 54,
		["52"] = 54,
		["53"] = 51,
		["54"] = 50,
		["55"] = 57,
		["56"] = 58,
		["57"] = 57,
		["58"] = 64,
		["59"] = 65,
		["60"] = 64,
		["61"] = 67,
		["62"] = 68,
		["63"] = 67,
		["64"] = 71,
		["65"] = 72,
		["68"] = 75,
		["69"] = 75,
		["70"] = 75,
		["71"] = 76,
		["72"] = 77,
		["73"] = 78,
		["74"] = 79,
		["75"] = 81,
		["76"] = 83,
		["77"] = 84,
		["78"] = 84,
		["79"] = 84,
		["80"] = 84,
		["81"] = 84,
		["82"] = 84,
		["83"] = 85,
		["84"] = 85,
		["85"] = 85,
		["86"] = 85,
		["87"] = 85,
		["88"] = 85,
		["89"] = 86,
		["92"] = 75,
		["93"] = 75,
		["94"] = 90,
		["95"] = 90,
		["96"] = 90,
		["97"] = 91,
		["98"] = 92,
		["99"] = 98,
		["100"] = 99,
		["101"] = 100,
		["102"] = 101,
		["103"] = 102,
		["104"] = 103,
		["105"] = 104,
		["110"] = 90,
		["111"] = 90,
		["112"] = 71,
		["113"] = 113,
		["114"] = 114,
		["117"] = 117,
		["118"] = 118,
		["119"] = 119,
		["120"] = 120,
		["121"] = 120,
		["122"] = 120,
		["124"] = 120,
		["125"] = 121,
		["126"] = 122,
		["127"] = 123,
		["130"] = 126,
		["131"] = 127,
		["132"] = 128,
		["135"] = 131,
		["136"] = 132,
		["138"] = 135,
		["139"] = 136,
		["140"] = 137,
		["141"] = 138,
		["142"] = 139,
		["143"] = 140,
		["144"] = 141,
		["145"] = 142,
		["146"] = 143,
		["147"] = 143,
		["148"] = 143,
		["149"] = 143,
		["150"] = 144,
		["151"] = 145,
		["153"] = 143,
		["154"] = 143,
		["157"] = 150,
		["158"] = 152,
		["161"] = 113,
		["162"] = 158,
		["163"] = 159,
		["164"] = 160,
		["165"] = 161,
		["168"] = 162,
		["169"] = 163,
		["170"] = 164,
		["171"] = 165,
		["172"] = 166,
		["173"] = 166,
		["174"] = 166,
		["175"] = 166,
		["176"] = 166,
		["177"] = 166,
		["178"] = 167,
		["179"] = 158,
		["180"] = 197,
		["181"] = 198,
		["184"] = 201,
		["185"] = 202,
		["186"] = 203,
		["187"] = 204,
		["188"] = 205,
		["191"] = 197,
		["192"] = 209,
		["193"] = 210,
		["194"] = 209,
		["195"] = 215,
		["196"] = 216,
		["197"] = 216,
		["198"] = 216,
		["199"] = 216,
		["200"] = 217,
		["201"] = 218,
		["203"] = 220,
		["204"] = 215,
		["205"] = 21,
		["206"] = 13,
		["207"] = 13,
		["208"] = 13,
		["209"] = 13,
		["210"] = 13,
		["211"] = 13,
		["212"] = 13,
		["213"] = 13,
		["214"] = 21,
		["216"] = 21,
		["218"] = 225,
		["219"] = 234,
		["220"] = 225,
		["221"] = 234,
		["222"] = 236,
		["223"] = 237,
		["224"] = 236,
		["225"] = 239,
		["226"] = 240,
		["227"] = 239,
		["228"] = 234,
		["229"] = 225,
		["230"] = 225,
		["231"] = 225,
		["232"] = 225,
		["233"] = 225,
		["234"] = 225,
		["235"] = 225,
		["236"] = 225,
		["237"] = 225,
		["238"] = 234,
		["240"] = 234,
		["242"] = 246,
		["243"] = 255,
		["244"] = 246,
		["245"] = 255,
		["247"] = 255,
		["248"] = 262,
		["249"] = 246,
		["250"] = 263,
		["251"] = 264,
		["252"] = 265,
		["253"] = 266,
		["254"] = 267,
		["255"] = 269,
		["256"] = 263,
		["257"] = 288,
		["258"] = 289,
		["259"] = 288,
		["260"] = 291,
		["261"] = 292,
		["262"] = 291,
		["263"] = 298,
		["264"] = 299,
		["265"] = 298,
		["266"] = 302,
		["267"] = 303,
		["268"] = 304,
		["270"] = 302,
		["271"] = 308,
		["272"] = 309,
		["273"] = 310,
		["274"] = 310,
		["275"] = 310,
		["277"] = 310,
		["278"] = 311,
		["279"] = 311,
		["280"] = 311,
		["281"] = 311,
		["282"] = 311,
		["283"] = 312,
		["284"] = 312,
		["285"] = 312,
		["286"] = 312,
		["287"] = 312,
		["288"] = 312,
		["289"] = 312,
		["290"] = 312,
		["291"] = 312,
		["292"] = 313,
		["293"] = 313,
		["294"] = 313,
		["295"] = 313,
		["296"] = 313,
		["297"] = 313,
		["298"] = 313,
		["299"] = 313,
		["300"] = 314,
		["302"] = 308,
		["303"] = 318,
		["304"] = 319,
		["305"] = 320,
		["306"] = 320,
		["307"] = 320,
		["309"] = 320,
		["310"] = 321,
		["311"] = 321,
		["312"] = 321,
		["313"] = 321,
		["315"] = 318,
		["316"] = 325,
		["317"] = 326,
		["318"] = 327,
		["319"] = 328,
		["320"] = 329,
		["321"] = 330,
		["322"] = 331,
		["323"] = 332,
		["325"] = 335,
		["326"] = 336,
		["328"] = 338,
		["329"] = 338,
		["330"] = 338,
		["331"] = 338,
		["332"] = 338,
		["334"] = 325,
		["335"] = 255,
		["336"] = 246,
		["337"] = 246,
		["338"] = 246,
		["339"] = 246,
		["340"] = 246,
		["341"] = 246,
		["342"] = 246,
		["343"] = 246,
		["344"] = 246,
		["345"] = 255,
		["347"] = 255,
		["348"] = 344,
		["349"] = 345,
		["350"] = 344,
		["351"] = 345,
		["352"] = 347,
		["353"] = 348,
		["354"] = 349,
		["355"] = 350,
		["356"] = 371,
		["357"] = 372,
		["358"] = 373,
		["359"] = 374,
		["360"] = 376,
		["361"] = 347,
		["362"] = 345,
		["363"] = 344,
		["364"] = 345,
		["366"] = 345,
		["368"] = 383,
		["369"] = 391,
		["370"] = 383,
		["371"] = 391,
		["372"] = 392,
		["373"] = 393,
		["374"] = 392,
		["375"] = 391,
		["376"] = 383,
		["377"] = 383,
		["378"] = 383,
		["379"] = 383,
		["380"] = 383,
		["381"] = 383,
		["382"] = 383,
		["383"] = 383,
		["384"] = 391,
		["386"] = 391,
		["388"] = 400,
		["389"] = 409,
		["390"] = 400,
		["391"] = 409,
		["392"] = 415,
		["393"] = 416,
		["394"] = 417,
		["395"] = 418,
		["396"] = 415,
		["397"] = 421,
		["398"] = 422,
		["399"] = 421,
		["400"] = 426,
		["401"] = 427,
		["402"] = 426,
		["403"] = 431,
		["404"] = 432,
		["405"] = 433,
		["407"] = 431,
		["408"] = 437,
		["409"] = 438,
		["412"] = 442,
		["413"] = 443,
		["414"] = 443,
		["415"] = 443,
		["416"] = 444,
		["417"] = 445,
		["418"] = 446,
		["419"] = 447,
		["420"] = 448,
		["421"] = 450,
		["422"] = 452,
		["423"] = 453,
		["424"] = 453,
		["425"] = 453,
		["426"] = 453,
		["427"] = 453,
		["428"] = 453,
		["429"] = 454,
		["430"] = 454,
		["431"] = 454,
		["432"] = 454,
		["433"] = 454,
		["434"] = 454,
		["435"] = 455,
		["438"] = 443,
		["439"] = 443,
		["440"] = 437,
		["441"] = 460,
		["442"] = 461,
		["443"] = 460,
		["444"] = 466,
		["445"] = 467,
		["446"] = 468,
		["448"] = 466,
		["449"] = 409,
		["450"] = 400,
		["451"] = 400,
		["452"] = 400,
		["453"] = 400,
		["454"] = 400,
		["455"] = 400,
		["456"] = 400,
		["457"] = 400,
		["458"] = 409,
		["460"] = 409,
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
g.phantom_assassin_talent = c()
local q = g.phantom_assassin_talent
q.name = "phantom_assassin_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_phantom_assassin_talent"
end
q = e({ j(nil) }, q)
g.phantom_assassin_talent = q
g.modifier_phantom_assassin_talent = c()
local r = g.modifier_phantom_assassin_talent
r.name = "modifier_phantom_assassin_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.is_crit = false
	self.shard = false
end
function r.prototype.GetAbilitySpecialValue(self)
	self.crit_damage = self:GetAbilitySpecialValueFor("crit_damage")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.attack_crit_damage = self:GetAbilityTalentValue("phantom_assassin_talent_6", "attack_crit_damage")
	self.crit_chance = self:GetAbilityTalentValue("phantom_assassin_talent_1", "crit_chance")
	self.crit_count = self:GetAbilityTalentValue("phantom_assassin_talent_3", "crit_count")
	self.attackspeed_duration = self:GetAbilityTalentValue("phantom_assassin_talent_3", "attackspeed_duration")
	self.fan_chance = self:GetAbilityTalentValue("phantom_assassin_talent_5", "fan_chance")
	self.crit_factor = self:GetAbilityTalentValue("phantom_assassin_talent_5", "crit_factor")
	self.bonus_count = self:GetAbilityTalentValue("phantom_assassin_talent_4", "bonus_count")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self:GetParent(), -1 } }
end
function r.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS,
	}
end
function r.prototype.EOM_GetModifierAttackDamageBonus(self)
	return GetPhysicalCriticalChance(self:GetParent()) * self.attack_crit_damage
end
function r.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self)
	return self.crit_chance
end
function r.prototype.OnCreated(self, s)
	if not IsServer() then
		return
	end
	self.hookID = self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_DAMAGE_START, function(t, s, u, v)
		if u == self:GetParent() then
			if self.is_crit and s.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
				self.is_crit = false
				s.is_crit = true
				u:EmitSound("Hero_PhantomAssassin.CoupDeGrace")
				local w = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					v,
					u
				)
				ParticleManager:SetParticleControlTransformForward(
					w,
					0,
					v:GetAbsOrigin(),
					(u:GetAbsOrigin() - v:GetAbsOrigin()):Normalized()
				)
				ParticleManager:SetParticleControlTransformForward(
					w,
					1,
					v:GetAbsOrigin(),
					(u:GetAbsOrigin() - v:GetAbsOrigin()):Normalized()
				)
				ParticleManager:ReleaseParticleIndex(w)
			end
		end
	end)
	self.hookID2 = self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL_CALCULATED, function(t, s, u, v)
		if u == self:GetParent() then
			if not s.is_crit and s.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK and self.bonus_count > 0 then
				self:IncrementStackCount()
				if self:GetStackCount() >= self.bonus_count then
					self:SetStackCount(0)
					local x = self:GetParent()
					local y = x:FindAbilityByName("phantom_assassin_ult")
					if IsValid(y) then
						y:OnSpellStart()
					end
				end
			end
		end
	end)
end
function r.prototype.OnCritical(self, s)
	if not IsServer() then
		return
	end
	local x = self:GetParent()
	local y = self:GetAbility()
	if self.crit_count > 0 then
		local z = self.crit_count_record
		if z == nil then
			z = 0
		end
		self.crit_count_record = z + 1
		if self.crit_count_record >= self.crit_count then
			x:AddNewModifier(
				x,
				y,
				"modifier_phantom_assassin_talent_attackspeed",
				{ duration = self.attackspeed_duration }
			)
			self.crit_count_record = self.crit_count_record - 1
		end
	end
	if
		s.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
		or s.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL and self:HasTalent("phantom_assassin_talent_3")
	then
		if not x:PassivesDisabled() then
			x:AddNewModifier(x, y, "modifier_phantom_assassin_talent_buff", { duration = self.duration, stack = 1 })
		end
	end
	if self.fan_chance > 0 and self:PRD(self.fan_chance, "fan_chance") then
		self:FanOfKnives()
	end
	local A = self:GetAbilityTalentValue("phantom_assassin_shard", "duration")
	local B = self:GetAbilityTalentValue("phantom_assassin_shard", "count")
	if s.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK and not self.shard and B > 0 then
		local v = self.caster:GetEnemy()
		self.shard = true
		if B > 0 then
			local C = self.caster:FindModifierByName("modifier_phantom_assassin_talent")
			if IsValid(C) then
				ForWithInterval(0.1, B, function()
					if IsValid(C) then
						C:FanOfKnives()
					end
				end)
			end
		end
		if A > 0 then
			AddBroken(x, v, y, A)
		end
	end
end
function r.prototype.FanOfKnives(self)
	local x = self:GetParent()
	local v = x:GetEnemy()
	if not IsInjurable(x, v) then
		return
	end
	local y = self:GetAbility()
	x:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	local w = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_shard_fan_of_knives.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		x
	)
	ParticleManager:ReleaseParticleIndex(w)
	x:DealDamage(
		v,
		y,
		GetPhysicalCriticalChance(x) * BUFF_VALUE.FanOfKnivesCritFactor,
		EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
	)
	x:EmitSound("Hero_PhantomAssassin.FanOfKnives.Cast")
end
function r.prototype.OnCustomTakeDamage(self, D)
	if not IsServer() then
		return
	end
	if not D.is_crit then
		if
			D.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
			or D.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL and self:HasTalent("phantom_assassin_talent_3")
		then
			local x = self:GetParent()
			local y = self:GetAbility()
			x:AddNewModifier(x, y, "modifier_phantom_assassin_talent_buff", { stack = 1 })
		end
	end
end
function r.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE }
end
function r.prototype.GetModifierPreAttack_CriticalStrike(self, s)
	if self:PRD(GetPhysicalCriticalChance(self:GetParent()), "GetPhysicalCriticalChance") then
		self.is_crit = true
		return 200
	end
	return 0
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
g.modifier_phantom_assassin_talent = r
g.modifier_phantom_assassin_talent_attackspeed = c()
local E = g.modifier_phantom_assassin_talent_attackspeed
E.name = "modifier_phantom_assassin_talent_attackspeed"
d(E, l)
function E.prototype.GetAbilitySpecialValue(self)
	self.attackspeed = self:GetAbilityTalentValue("phantom_assassin_talent_3", "attackspeed")
end
function E.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.attackspeed }
end
E = e(
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	E
)
g.modifier_phantom_assassin_talent_attackspeed = E
g.modifier_phantom_assassin_talent_buff = c()
local F = g.modifier_phantom_assassin_talent_buff
F.name = "modifier_phantom_assassin_talent_buff"
d(F, l)
function F.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.record = 0
end
function F.prototype.GetAbilitySpecialValue(self)
	self.buff_attack = self:GetAbilitySpecialValueFor("buff_attack")
	self.buff_crit_damage = self:GetAbilitySpecialValueFor("buff_crit_damage")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.max_stack = self:GetAbilitySpecialValueFor("max_stack")
	self.attack_rate = self:GetAbilityTalentValue("phantom_assassin_talent_2", "attack_rate")
end
function F.prototype.EOM_GetModifierAttackDamageBonus(self)
	return self:GetStackCount() * self.buff_attack
end
function F.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_EVASION,
	}
end
function F.prototype.EOM_GetModifierIgnoreEvasion(self, s)
	return self:GetStackCount() * self.attack_rate
end
function F.prototype.EOM_GetModifierPhysicalCriticalStrikeDamage(self, s)
	if s and s.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		return self:GetStackCount() * self.buff_crit_damage
	end
end
function F.prototype.OnCreated(self, s)
	if IsServer() then
		local G = s.stack
		if G == nil then
			G = 1
		end
		local H = G
		self.particleID = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_phantom_assassin/phantom_assassin_talent_mark.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(
			self.particleID,
			3,
			self:GetParent(),
			PATTACH_OVERHEAD_FOLLOW,
			"",
			self:GetParent():GetAbsOrigin(),
			false
		)
		self:AddParticle(self.particleID, false, false, -1, false, false)
		self:SetStackCount(math.min(self.max_stack, H))
	end
end
function F.prototype.OnRefresh(self, s)
	if IsServer() then
		local I = s.stack
		if I == nil then
			I = 1
		end
		local H = I
		self:SetStackCount(math.min(self.max_stack, self:GetStackCount() + H))
	end
end
function F.prototype.OnStackCountChanged(self, J)
	if IsServer() then
		local K = self:GetStackCount()
		local L = math.floor(K / 10)
		local M = K % 10
		local N = K % 10
		if L >= 1 then
			N = 0
		else
			L = 0
			M = 0
		end
		ParticleManager:SetParticleControl(self.particleID, 1, Vector(L, M, N))
	end
end
F = e(
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
				IsIndependent = true,
			}
		),
	},
	F
)
g.modifier_phantom_assassin_talent_buff = F
g.phantom_assassin_ult = c()
local O = g.phantom_assassin_ult
O.name = "phantom_assassin_ult"
d(O, o)
function O.prototype.OnSpellStart(self)
	local u = self:GetCaster()
	local P = self:GetSpecialValueFor("duration")
	local v = u:GetEnemy()
	local w = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_phantom_strike_start.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		u
	)
	ParticleManager:ReleaseParticleIndex(w)
	local Q = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_phantom_strike_end.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		v,
		u
	)
	ParticleManager:ReleaseParticleIndex(Q)
	u:AddNewModifier(u, self, "modifier_phantom_assassin_ult", { duration = P })
end
O = e({ p(nil) }, O)
g.phantom_assassin_ult = O
g.modifier_phantom_assassin_shard = c()
local R = g.modifier_phantom_assassin_shard
R.name = "modifier_phantom_assassin_shard"
d(R, l)
function R.prototype.CheckState(self)
	return { [MODIFIER_STATE_PASSIVES_DISABLED] = true }
end
R = e(
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
			}
		),
	},
	R
)
g.modifier_phantom_assassin_shard = R
g.modifier_phantom_assassin_ult = c()
local S = g.modifier_phantom_assassin_ult
S.name = "modifier_phantom_assassin_ult"
d(S, l)
function S.prototype.GetAbilitySpecialValue(self)
	self.attack_speed = self:GetAbilitySpecialValueFor("attack_speed")
	self.crit_damage = self:GetAbilitySpecialValueFor("crit_damage")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function S.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.attack_speed }
end
function S.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE }
end
function S.prototype.EOM_GetModifierPhysicalCriticalStrikeDamage(self, s)
	if s and s.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		return self.crit_damage
	end
end
function S.prototype.OnCreated(self, s)
	if not IsServer() then
		return
	end
	self:SetStackCount(self.count)
	self.hookID = self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_DAMAGE_START, function(t, s, u, v)
		if u == self:GetParent() then
			local y = self:GetAbility()
			if IsValid(y) and self:GetStackCount() > 0 and s.damage_type == DAMAGE_TYPE_PHYSICAL then
				s.is_crit = true
				self:DecrementStackCount()
				u:EmitSound("Hero_PhantomAssassin.CoupDeGrace")
				local w = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					v,
					u
				)
				ParticleManager:SetParticleControlTransformForward(
					w,
					0,
					v:GetAbsOrigin(),
					(u:GetAbsOrigin() - v:GetAbsOrigin()):Normalized()
				)
				ParticleManager:SetParticleControlTransformForward(
					w,
					1,
					v:GetAbsOrigin(),
					(u:GetAbsOrigin() - v:GetAbsOrigin()):Normalized()
				)
				ParticleManager:ReleaseParticleIndex(w)
			end
		end
	end)
end
function S.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE }
end
function S.prototype.GetModifierPreAttack_CriticalStrike(self)
	if self:GetStackCount() > 0 then
		return 200
	end
end
S = e(
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
			}
		),
	},
	S
)
g.modifier_phantom_assassin_ult = S
return g