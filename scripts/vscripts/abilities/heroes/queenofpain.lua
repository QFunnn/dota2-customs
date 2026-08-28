--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/queenofpain"
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
		["33"] = 37,
		["34"] = 38,
		["35"] = 39,
		["36"] = 40,
		["37"] = 41,
		["38"] = 42,
		["39"] = 43,
		["40"] = 44,
		["41"] = 45,
		["42"] = 50,
		["43"] = 51,
		["44"] = 52,
		["46"] = 37,
		["47"] = 55,
		["48"] = 56,
		["49"] = 56,
		["50"] = 58,
		["51"] = 58,
		["52"] = 58,
		["53"] = 56,
		["54"] = 56,
		["55"] = 56,
		["56"] = 56,
		["57"] = 55,
		["58"] = 64,
		["59"] = 65,
		["60"] = 64,
		["61"] = 72,
		["62"] = 73,
		["63"] = 74,
		["66"] = 77,
		["67"] = 78,
		["70"] = 72,
		["71"] = 82,
		["72"] = 83,
		["73"] = 84,
		["74"] = 85,
		["75"] = 86,
		["77"] = 82,
		["78"] = 89,
		["79"] = 90,
		["80"] = 91,
		["81"] = 92,
		["82"] = 89,
		["83"] = 94,
		["84"] = 95,
		["85"] = 94,
		["86"] = 97,
		["87"] = 98,
		["88"] = 97,
		["89"] = 100,
		["90"] = 101,
		["91"] = 102,
		["92"] = 102,
		["93"] = 102,
		["94"] = 102,
		["95"] = 103,
		["96"] = 104,
		["97"] = 105,
		["100"] = 115,
		["102"] = 100,
		["103"] = 119,
		["104"] = 120,
		["105"] = 121,
		["106"] = 122,
		["107"] = 123,
		["108"] = 124,
		["110"] = 126,
		["111"] = 126,
		["112"] = 126,
		["113"] = 127,
		["114"] = 127,
		["115"] = 127,
		["116"] = 127,
		["117"] = 127,
		["118"] = 127,
		["119"] = 133,
		["120"] = 134,
		["121"] = 135,
		["122"] = 135,
		["123"] = 136,
		["124"] = 137,
		["125"] = 138,
		["127"] = 140,
		["128"] = 140,
		["129"] = 140,
		["130"] = 140,
		["131"] = 140,
		["132"] = 140,
		["133"] = 140,
		["134"] = 140,
		["135"] = 141,
		["136"] = 142,
		["138"] = 145,
		["139"] = 146,
		["142"] = 127,
		["143"] = 127,
		["144"] = 151,
		["145"] = 126,
		["146"] = 126,
		["147"] = 119,
		["148"] = 20,
		["149"] = 12,
		["150"] = 12,
		["151"] = 12,
		["152"] = 12,
		["153"] = 12,
		["154"] = 12,
		["155"] = 12,
		["156"] = 12,
		["157"] = 20,
		["159"] = 20,
		["160"] = 156,
		["161"] = 157,
		["162"] = 156,
		["163"] = 157,
		["164"] = 159,
		["165"] = 160,
		["166"] = 161,
		["167"] = 162,
		["168"] = 163,
		["169"] = 164,
		["170"] = 165,
		["171"] = 166,
		["172"] = 167,
		["173"] = 170,
		["174"] = 171,
		["175"] = 172,
		["176"] = 172,
		["177"] = 172,
		["178"] = 173,
		["179"] = 174,
		["180"] = 175,
		["181"] = 175,
		["182"] = 175,
		["183"] = 175,
		["184"] = 175,
		["185"] = 175,
		["186"] = 175,
		["188"] = 177,
		["189"] = 178,
		["190"] = 179,
		["192"] = 181,
		["194"] = 184,
		["195"] = 185,
		["196"] = 185,
		["197"] = 185,
		["198"] = 185,
		["199"] = 185,
		["200"] = 186,
		["201"] = 186,
		["202"] = 186,
		["203"] = 186,
		["204"] = 186,
		["205"] = 187,
		["206"] = 187,
		["207"] = 187,
		["208"] = 187,
		["209"] = 187,
		["210"] = 188,
		["211"] = 189,
		["212"] = 190,
		["215"] = 172,
		["216"] = 172,
		["217"] = 159,
		["218"] = 196,
		["219"] = 197,
		["220"] = 196,
		["221"] = 157,
		["222"] = 156,
		["223"] = 157,
		["225"] = 157,
		["226"] = 200,
		["227"] = 208,
		["228"] = 200,
		["229"] = 208,
		["230"] = 208,
		["231"] = 200,
		["232"] = 200,
		["233"] = 200,
		["234"] = 200,
		["235"] = 200,
		["236"] = 200,
		["237"] = 200,
		["238"] = 200,
		["239"] = 208,
		["241"] = 208,
		["242"] = 210,
		["243"] = 218,
		["244"] = 210,
		["245"] = 218,
		["247"] = 218,
		["248"] = 220,
		["249"] = 210,
		["250"] = 221,
		["251"] = 222,
		["252"] = 221,
		["253"] = 224,
		["254"] = 225,
		["255"] = 226,
		["256"] = 226,
		["257"] = 225,
		["258"] = 224,
		["259"] = 229,
		["260"] = 230,
		["263"] = 233,
		["264"] = 234,
		["265"] = 234,
		["266"] = 234,
		["267"] = 234,
		["268"] = 235,
		["269"] = 236,
		["270"] = 237,
		["271"] = 238,
		["272"] = 239,
		["273"] = 240,
		["275"] = 229,
		["276"] = 218,
		["277"] = 210,
		["278"] = 210,
		["279"] = 210,
		["280"] = 210,
		["281"] = 210,
		["282"] = 210,
		["283"] = 210,
		["284"] = 210,
		["285"] = 218,
		["287"] = 218,
		["288"] = 245,
		["289"] = 253,
		["290"] = 245,
		["291"] = 253,
		["292"] = 254,
		["293"] = 255,
		["294"] = 254,
		["295"] = 253,
		["296"] = 245,
		["297"] = 245,
		["298"] = 245,
		["299"] = 245,
		["300"] = 245,
		["301"] = 245,
		["302"] = 245,
		["303"] = 245,
		["304"] = 253,
		["306"] = 253,
		["308"] = 263,
		["309"] = 264,
		["310"] = 263,
		["311"] = 264,
		["312"] = 265,
		["313"] = 266,
		["314"] = 265,
		["315"] = 264,
		["316"] = 263,
		["317"] = 264,
		["319"] = 264,
		["320"] = 269,
		["321"] = 277,
		["322"] = 269,
		["323"] = 277,
		["324"] = 280,
		["325"] = 281,
		["326"] = 280,
		["327"] = 283,
		["328"] = 284,
		["329"] = 285,
		["330"] = 283,
		["331"] = 287,
		["332"] = 288,
		["333"] = 288,
		["334"] = 290,
		["335"] = 290,
		["336"] = 290,
		["337"] = 288,
		["338"] = 288,
		["339"] = 287,
		["340"] = 293,
		["341"] = 294,
		["342"] = 293,
		["343"] = 296,
		["344"] = 297,
		["345"] = 298,
		["347"] = 296,
		["348"] = 301,
		["349"] = 302,
		["350"] = 301,
		["351"] = 306,
		["352"] = 307,
		["353"] = 306,
		["354"] = 311,
		["355"] = 312,
		["356"] = 311,
		["357"] = 277,
		["358"] = 269,
		["359"] = 269,
		["360"] = 269,
		["361"] = 269,
		["362"] = 269,
		["363"] = 269,
		["364"] = 269,
		["365"] = 269,
		["366"] = 277,
		["368"] = 277,
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
g.queenofpain_talent = c()
local q = g.queenofpain_talent
q.name = "queenofpain_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_queenofpain_talent"
end
q = e({ j(nil) }, q)
g.queenofpain_talent = q
g.modifier_queenofpain_talent = c()
local r = g.modifier_queenofpain_talent
r.name = "modifier_queenofpain_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.poison = self:GetAbilitySpecialValueFor("poison")
	self.interval_reduce = self:GetAbilitySpecialValueFor("interval_reduce")
	self.min_interval = self:GetAbilitySpecialValueFor("min_interval")
	self.count = self:GetAbilitySpecialValueFor("count")
	self.level_factor = self:GetAbilityTalentValue("queenofpain_talent_1", "level_factor")
	self.bonus_health = self:GetAbilityTalentValue("queenofpain_talent_4", "bonus_health")
	self.regen = self:GetAbilityTalentValue("queenofpain_talent_7", "regen")
	self.tl3_chance = self:GetAbilityTalentValue("queenofpain_talent_3", "chance")
	if IsServer() then
		self.record = 0
	end
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_POISON_TAKEDAMAGE] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_POISON_GAINED] = { self:GetParent() },
	}
end
function r.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS] = self.bonus_health }
end
function r.prototype.OnPoisonGained(self, s)
	if self.tl3_chance > 0 then
		if s.flag and bit.band(s.flag, PoisonFlags.POISON_FLAG_NO_EXTRA) == PoisonFlags.POISON_FLAG_NO_EXTRA then
			return
		end
		if self:PRD(self.tl3_chance, "tl3_chance") then
			self:ShadowStrike(true)
		end
	end
end
function r.prototype.OnPoisonTakeDamage(self, s)
	self.record = self.record + 1
	if self.record == self.count then
		self.record = 0
		self:IncrementStackCount()
	end
end
function r.prototype.OnBattleStart(self, s)
	self:StartIntervalThink(0.1)
	self.intervalRecord = 0
	self.damageRecord = 0
end
function r.prototype.OnBattleEnd(self, s)
	self:StartIntervalThink(-1)
end
function r.prototype.OnThink(self, t)
	self:StartThink(-1, t)
end
function r.prototype.OnIntervalThink(self)
	self.intervalRecord = self.intervalRecord + 0.1
	local u = math.max(self.min_interval, self.interval - self.interval_reduce * self:GetStackCount())
	if self.intervalRecord >= u then
		self.intervalRecord = self.intervalRecord - u
		if self:GetCaster():PassivesDisabled() then
			return
		end
		self:ShadowStrike()
	end
end
function r.prototype.ShadowStrike(self, v)
	local w = self:GetParent()
	local x = w:GetEnemy()
	local y = self:GetAbility()
	if not w:HasModifier("modifier_queenofpain_ult_cast") then
		w:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	end
	w:GameTimer(0.4, function()
		Projectile:CreateTrackingProjectile({
			EffectName = "particles/units/heroes/hero_queenofpain/queen_shadow_strike.vpcf",
			hCaster = w,
			vSpawnOrigin = w:GetAttachmentPosition("attach_attack1"),
			hTarget = x,
			iMoveSpeed = PROJECTILE_SPEED_NORMAL,
			OnProjectileHit = function(z, A, B)
				if IsInjurable(w, x) then
					local C = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
					local D = C and C:getLevel() or 0
					local E = PoisonFlags.POISON_FLAG_NONE
					if v then
						E = PoisonFlags.POISON_FLAG_NO_EXTRA
					end
					AddPoison(w, x, self.poison + D * self.level_factor, y:GetAbilityName(), "Ability", E)
					if self.regen > 0 then
						Heal(w, self.regen, "queenofpain_talent_7", "Ability")
					end
					if self:HasTalent("queenofpain_talent_5") then
						TriggerPoison(z)
					end
				end
			end,
		})
		w:EmitSound("Greevil.ShadowStrike")
	end)
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
g.modifier_queenofpain_talent = r
g.queenofpain_ult = c()
local F = g.queenofpain_ult
F.name = "queenofpain_ult"
d(F, o)
function F.prototype.OnSpellStart(self)
	local G = self:GetCaster()
	local x = G:GetEnemy()
	local H = self:GetSpecialValueFor("damage") + self:GetTalentValue("queenofpain_talent_2", "bonus_damage")
	local I = self:GetTalentValue("queenofpain_talent_9", "duration")
	local J = self:GetTalentValue("queenofpain_talent_10", "bonus_damage")
	local K = self:GetTalentValue("queenofpain_talent_10", "chance")
	print(K, "attenuation_chance")
	G:AddNewModifier(G, self, "modifier_queenofpain_ult_cast", { duration = 0.452 })
	G:RemoveGesture(ACT_DOTA_CAST_ABILITY_1)
	G:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	self:GameTimer(0.452, function()
		if IsInjurable(x, G) then
			if J > 0 then
				AddPoison(G, x, H * J * 0.01, "queenofpain_talent_10", "Ability")
			end
			G:DealDamage(x, self, H, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
			if self:PRD(K) then
				TriggerPoison(x, nil, nil, true)
			else
				TriggerPoison(x)
			end
			local L = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_queenofpain/queen_sonic_wave.vpcf",
				PATTACH_CUSTOMORIGIN,
				G
			)
			ParticleManager:SetParticleControl(L, 0, G:GetAttachmentPosition("mouth"))
			ParticleManager:SetParticleControlForward(L, 0, (x:GetAbsOrigin() - G:GetAbsOrigin()):Normalized())
			ParticleManager:SetParticleControl(L, 1, x:GetAbsOrigin() - G:GetAbsOrigin())
			G:EmitSound("Hero_QueenOfPain.SonicWave")
			if I > 0 then
				x:AddNewModifier(G, self, "modifier_queenofpain_ult_debuff", { duration = I })
			end
		end
	end)
end
function F.prototype.GetIntrinsicModifierName(self)
	return "modifier_queenofpain_ult"
end
F = e({ p(nil) }, F)
g.queenofpain_ult = F
g.modifier_queenofpain_ult_cast = c()
local M = g.modifier_queenofpain_ult_cast
M.name = "modifier_queenofpain_ult_cast"
d(M, l)
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
g.modifier_queenofpain_ult_cast = M
g.modifier_queenofpain_ult = c()
local N = g.modifier_queenofpain_ult
N.name = "modifier_queenofpain_ult"
d(N, l)
function N.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.record = 0
end
function N.prototype.GetAbilitySpecialValue(self)
	self.health_pct = self:GetAbilityTalentValue("queenofpain_talent_11", "health_pct")
end
function N.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() } }
end
function N.prototype.OnCustomTakeDamage(self, O)
	if self.health_pct == 0 then
		return
	end
	local w = self:GetParent()
	local H = math.max(0, O.original_health - w:GetHealth())
	local P = w:GetMaxHealth() * self.health_pct * 0.01
	self.record = self.record + H
	if self.record >= P then
		self.record = self.record - P
		local y = self:GetAbility()
		y:OnSpellStart()
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
g.modifier_queenofpain_ult = N
g.modifier_queenofpain_ult_debuff = c()
local Q = g.modifier_queenofpain_ult_debuff
Q.name = "modifier_queenofpain_ult_debuff"
d(Q, l)
function Q.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_ATTENUATION_PERCENTAGE] = -1000 }
end
Q = e(
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
	Q
)
g.modifier_queenofpain_ult_debuff = Q
g.queenofpain_shard = c()
local R = g.queenofpain_shard
R.name = "queenofpain_shard"
d(R, i)
function R.prototype.GetIntrinsicModifierName(self)
	return "modifier_queenofpain_shard"
end
R = e({ j(nil) }, R)
g.queenofpain_shard = R
g.modifier_queenofpain_shard = c()
local S = g.modifier_queenofpain_shard
S.name = "modifier_queenofpain_shard"
d(S, l)
function S.prototype.GetTexture(self)
	return "modifier_queenofpain_shard"
end
function S.prototype.GetAbilitySpecialValue(self)
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
	self.poison_damage = self:GetAbilitySpecialValueFor("poison_damage")
end
function S.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function S.prototype.OnBattleStartBefore(self, s)
	self:SetStackCount(0)
end
function S.prototype.OnCustomTakeDamage(self, O)
	if O.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL then
		self:IncrementStackCount()
	end
end
function S.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE] = self.damage_pct }
end
function S.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_DAMAGE_BONUS }
end
function S.prototype.EOM_GetModifierPoisonDamageBonus(self, s)
	return self:GetStackCount()
end
S = e(
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
	S
)
g.modifier_queenofpain_shard = S
return g