--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/lycan"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["15"] = 3,
		["16"] = 3,
		["17"] = 3,
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
		["30"] = 13,
		["31"] = 21,
		["32"] = 13,
		["33"] = 21,
		["34"] = 28,
		["35"] = 29,
		["36"] = 30,
		["37"] = 31,
		["38"] = 32,
		["39"] = 33,
		["40"] = 28,
		["41"] = 36,
		["42"] = 37,
		["43"] = 37,
		["44"] = 37,
		["45"] = 37,
		["46"] = 36,
		["47"] = 43,
		["48"] = 44,
		["49"] = 43,
		["50"] = 49,
		["51"] = 50,
		["52"] = 49,
		["53"] = 56,
		["54"] = 57,
		["57"] = 61,
		["58"] = 62,
		["59"] = 63,
		["60"] = 64,
		["62"] = 56,
		["63"] = 68,
		["64"] = 69,
		["65"] = 70,
		["66"] = 71,
		["67"] = 73,
		["68"] = 74,
		["69"] = 74,
		["70"] = 74,
		["71"] = 74,
		["72"] = 74,
		["73"] = 75,
		["74"] = 75,
		["75"] = 75,
		["76"] = 75,
		["77"] = 75,
		["78"] = 76,
		["79"] = 76,
		["80"] = 76,
		["81"] = 76,
		["82"] = 76,
		["83"] = 77,
		["84"] = 79,
		["85"] = 79,
		["86"] = 79,
		["87"] = 80,
		["88"] = 81,
		["89"] = 81,
		["90"] = 81,
		["91"] = 81,
		["92"] = 81,
		["93"] = 82,
		["94"] = 82,
		["95"] = 82,
		["96"] = 82,
		["97"] = 82,
		["98"] = 83,
		["99"] = 83,
		["100"] = 83,
		["101"] = 83,
		["102"] = 83,
		["103"] = 84,
		["104"] = 79,
		["105"] = 79,
		["106"] = 88,
		["108"] = 90,
		["109"] = 90,
		["110"] = 91,
		["111"] = 90,
		["114"] = 94,
		["116"] = 68,
		["117"] = 98,
		["118"] = 99,
		["119"] = 98,
		["120"] = 102,
		["121"] = 103,
		["122"] = 102,
		["123"] = 21,
		["124"] = 13,
		["125"] = 13,
		["126"] = 13,
		["127"] = 13,
		["128"] = 13,
		["129"] = 13,
		["130"] = 13,
		["131"] = 13,
		["132"] = 21,
		["134"] = 21,
		["135"] = 108,
		["136"] = 109,
		["137"] = 108,
		["138"] = 109,
		["140"] = 109,
		["141"] = 110,
		["142"] = 108,
		["143"] = 112,
		["144"] = 113,
		["145"] = 114,
		["146"] = 116,
		["147"] = 117,
		["148"] = 118,
		["149"] = 119,
		["150"] = 120,
		["151"] = 121,
		["152"] = 122,
		["153"] = 123,
		["155"] = 126,
		["156"] = 112,
		["157"] = 109,
		["158"] = 108,
		["159"] = 109,
		["161"] = 109,
		["163"] = 131,
		["164"] = 140,
		["165"] = 131,
		["166"] = 140,
		["168"] = 140,
		["169"] = 146,
		["170"] = 153,
		["171"] = 131,
		["172"] = 155,
		["173"] = 156,
		["174"] = 157,
		["175"] = 158,
		["176"] = 159,
		["177"] = 160,
		["178"] = 161,
		["179"] = 162,
		["180"] = 163,
		["181"] = 166,
		["182"] = 167,
		["183"] = 168,
		["184"] = 169,
		["185"] = 170,
		["186"] = 171,
		["187"] = 172,
		["189"] = 155,
		["190"] = 176,
		["191"] = 177,
		["192"] = 176,
		["193"] = 182,
		["194"] = 183,
		["195"] = 182,
		["196"] = 191,
		["197"] = 192,
		["198"] = 191,
		["199"] = 197,
		["200"] = 198,
		["201"] = 197,
		["202"] = 201,
		["203"] = 202,
		["204"] = 201,
		["205"] = 205,
		["206"] = 206,
		["207"] = 206,
		["208"] = 206,
		["209"] = 206,
		["210"] = 205,
		["211"] = 209,
		["212"] = 210,
		["213"] = 209,
		["214"] = 213,
		["215"] = 214,
		["216"] = 215,
		["217"] = 217,
		["218"] = 218,
		["219"] = 219,
		["220"] = 220,
		["223"] = 222,
		["224"] = 222,
		["225"] = 223,
		["226"] = 223,
		["227"] = 223,
		["228"] = 223,
		["229"] = 223,
		["230"] = 224,
		["231"] = 224,
		["232"] = 224,
		["233"] = 224,
		["234"] = 224,
		["235"] = 224,
		["236"] = 225,
		["237"] = 225,
		["238"] = 223,
		["239"] = 223,
		["240"] = 222,
		["244"] = 213,
		["245"] = 230,
		["246"] = 231,
		["247"] = 232,
		["248"] = 232,
		["249"] = 232,
		["250"] = 232,
		["251"] = 232,
		["252"] = 232,
		["253"] = 232,
		["255"] = 230,
		["256"] = 140,
		["257"] = 131,
		["258"] = 131,
		["259"] = 131,
		["260"] = 131,
		["261"] = 131,
		["262"] = 131,
		["263"] = 131,
		["264"] = 131,
		["265"] = 140,
		["267"] = 140,
		["269"] = 238,
		["270"] = 247,
		["271"] = 238,
		["272"] = 247,
		["273"] = 248,
		["274"] = 249,
		["275"] = 248,
		["276"] = 247,
		["277"] = 238,
		["278"] = 238,
		["279"] = 238,
		["280"] = 238,
		["281"] = 238,
		["282"] = 238,
		["283"] = 238,
		["284"] = 238,
		["285"] = 238,
		["286"] = 247,
		["288"] = 247,
		["290"] = 258,
		["291"] = 259,
		["292"] = 258,
		["293"] = 259,
		["294"] = 260,
		["295"] = 261,
		["296"] = 260,
		["297"] = 259,
		["298"] = 258,
		["299"] = 259,
		["301"] = 259,
		["302"] = 264,
		["303"] = 272,
		["304"] = 264,
		["305"] = 272,
		["306"] = 274,
		["307"] = 275,
		["308"] = 274,
		["309"] = 277,
		["310"] = 278,
		["311"] = 277,
		["312"] = 282,
		["313"] = 283,
		["314"] = 282,
		["315"] = 272,
		["316"] = 264,
		["317"] = 264,
		["318"] = 264,
		["319"] = 264,
		["320"] = 264,
		["321"] = 264,
		["322"] = 264,
		["323"] = 264,
		["324"] = 272,
		["326"] = 272,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
local o = require("abilities.ability_ai")
local p = o.BaseAbilityAI
local q = o.registerAbilityAI
h.lycan_talent = c()
local r = h.lycan_talent
r.name = "lycan_talent"
d(r, j)
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_lycan_talent"
end
r = e({ k(nil) }, r)
h.lycan_talent = r
h.modifier_lycan_talent = c()
local s = h.modifier_lycan_talent
s.name = "modifier_lycan_talent"
d(s, m)
function s.prototype.GetAbilitySpecialValue(self)
	self.wispList = {}
	self.attack_pct = self:GetAbilitySpecialValueFor("attack_pct")
		+ self:GetAbilityTalentValue("lycan_talent_1", "bonus_attack_pct")
	self.health_pct = self:GetAbilityTalentValue("lycan_talent_3", "health_pct")
	self.count = self:GetAbilityTalentValue("lycan_talent_5", "count")
	self.time = self:GetAbilityTalentValue("lycan_talent_5", "time")
end
function s.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_START] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_ATTACK_LANDED] = { self:GetParent() },
	}
end
function s.prototype.ECheckState(self)
	return { [EOMModifierStates.MODIFIER_STATE_WISP_DISARMED] = true }
end
function s.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_ATTACK,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_HEALTH_BONUS,
	}
end
function s.prototype.OnCustomAttackStart(self, t)
	if not IsServer() then
		return
	end
	local u = self:GetParent()
	local v = t.target
	if IsValid(v) and IsInjurable(v) then
		WispAttack(u)
	end
end
function s.prototype.OnWispAttackLanded(self, w)
	self:IncrementStackCount()
	if self.count > 0 and self:GetStackCount() >= self.count then
		local u = self:GetParent()
		local x = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_lycan/lycan_howl_cast.vpcf",
			PATTACH_ABSORIGIN,
			u
		)
		ParticleManager:SetParticleControl(x, 0, u:GetAbsOrigin())
		ParticleManager:SetParticleControl(x, 1, u:GetAbsOrigin())
		ParticleManager:SetParticleControl(x, 2, u:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(x)
		EachWisp(u, function(y)
			local x = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_lycan/lycan_howl_cast.vpcf",
				PATTACH_ABSORIGIN,
				y
			)
			ParticleManager:SetParticleControl(x, 0, y:GetAbsOrigin())
			ParticleManager:SetParticleControl(x, 1, y:GetAbsOrigin())
			ParticleManager:SetParticleControl(x, 2, y:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(x)
		end)
		EmitSoundOn("Hero_Lycan.Howl.Team", u)
		do
			local z = 0
			while z < self.time do
				TriggerAllWisp(self:GetParent())
				z = z + 1
			end
		end
		self:SetStackCount(0)
	end
end
function s.prototype.EOM_GetModifierWispAttack(self, w)
	return GetAttackDamage(self:GetParent()) * self.attack_pct * 0.01
end
function s.prototype.EOM_GetModifierWispHealthBonus(self, w)
	return self:GetParent():GetMaxHealth() * self.health_pct * 0.01
end
s = e(
	{
		n(
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
	s
)
h.modifier_lycan_talent = s
h.lycan_ult = c()
local A = h.lycan_ult
A.name = "lycan_ult"
d(A, p)
function A.prototype.____constructor(self, ...)
	p.prototype.____constructor(self, ...)
	self.wisps = {}
end
function A.prototype.OnSpellStart(self)
	local B = self:GetCaster()
	local C = self:GetSpecialValueFor("duration")
	B:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	B:EmitSound("Hero_Lycan.Shapeshift.Cast")
	local x = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_lycan/lycan_shapeshift_cast.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		B
	)
	ParticleManager:ReleaseParticleIndex(x)
	local D = C
	local E = B:FindModifierByName("modifier_lycan_ult")
	if IsValid(E) then
		D = D + E:GetRemainingTime()
	end
	B:AddNewModifier(B, self, "modifier_lycan_ult", { duration = D })
end
A = e({ q(nil) }, A)
h.lycan_ult = A
h.modifier_lycan_ult = c()
local F = h.modifier_lycan_ult
F.name = "modifier_lycan_ult"
d(F, m)
function F.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.stacks = {}
	self.wisps = {}
end
function F.prototype.GetAbilitySpecialValue(self)
	self.talent_8_ulti_multi = self:GetAbilityTalentValue("lycan_talent_8", "ulti_multi")
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.attack = self:GetAbilitySpecialValueFor("attack")
	self.bonus_crit = self:GetAbilitySpecialValueFor("bonus_crit")
	self.bonus_health = self:GetAbilityTalentValue("lycan_talent_2", "bonus_health")
	self.bonus_crit_damage = self:GetAbilityTalentValue("lycan_talent_4", "bonus_crit_damage")
	self.count = self:GetAbilityTalentValue("lycan_talent_6", "count")
	self.talent_7_bonus_attack = self:GetAbilityTalentValue("lycan_talent_7", "bonus_attack")
	if self.talent_8_ulti_multi > 0 then
		self.attackspeed = self.attackspeed * self.talent_8_ulti_multi
		self.attack = self.attack * self.talent_8_ulti_multi
		self.bonus_crit = self.bonus_crit * self.talent_8_ulti_multi
		self.bonus_health = self.bonus_health * self.talent_8_ulti_multi
		self.bonus_crit_damage = self.bonus_crit_damage * self.talent_8_ulti_multi
		self.talent_7_bonus_attack = self.talent_7_bonus_attack * self.talent_8_ulti_multi
	end
end
function F.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE] = self.bonus_crit_damage }
end
function F.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
	}
end
function F.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE }
end
function F.prototype.EOM_GetModifierAttackSpeedBonus(self, w)
	return self.attackspeed * self:GetStackCount()
end
function F.prototype.EOM_GetModifierHealthBonus(self, w)
	return self.bonus_health * self:GetStackCount()
end
function F.prototype.GetModifierModelChange(self)
	return Wearable:getReplaceParticle(self:GetParent(), "models/heroes/lycan/lycan_wolf.vmdl")
end
function F.prototype.EOM_GetModifierAttackDamageBonus(self)
	return self.attack + self.talent_7_bonus_attack * self:GetStackCount()
end
function F.prototype.OnCreated(self, w)
	if IsServer() then
		self:SetStackCount(1)
		local u = self:GetParent()
		local G = self.count
		if self.talent_8_ulti_multi > 0 then
			G = G * self.talent_8_ulti_multi
		end
		do
			local H = 0
			while H < G do
				SummonWisp(u, WISP_HEALTH_BASE, nil, function(I)
					I:AddNewModifier(I, self:GetAbility(), "modifier_lycan_talent_6", {})
					local J = self.wisps
					J[#J + 1] = I
				end)
				H = H + 1
			end
		end
	end
end
function F.prototype.OnDestroy(self)
	if IsServer() then
		f(self.wisps, function(K, I)
			return KillWisp(self:GetParent(), I)
		end)
	end
end
F = e(
	{
		n(
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
	F
)
h.modifier_lycan_ult = F
h.modifier_lycan_talent_6 = c()
local L = h.modifier_lycan_talent_6
L.name = "modifier_lycan_talent_6"
d(L, m)
function L.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true }
end
L = e(
	{
		n(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetEffectName = "particles/units/heroes/hero_lycan/lycan_howl_buff.vpcf",
			}
		),
	},
	L
)
h.modifier_lycan_talent_6 = L
h.lycan_shard = c()
local M = h.lycan_shard
M.name = "lycan_shard"
d(M, j)
function M.prototype.GetIntrinsicModifierName(self)
	return "modifier_lycan_shard_1"
end
M = e({ k(nil) }, M)
h.lycan_shard = M
h.modifier_lycan_shard_1 = c()
local N = h.modifier_lycan_shard_1
N.name = "modifier_lycan_shard_1"
d(N, m)
function N.prototype.GetAbilitySpecialValue(self)
	self.attackrate = self:GetAbilitySpecialValueFor("attackrate")
end
function N.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_RATE_BONUS }
end
function N.prototype.EOM_GetModifierAttackRateBonus(self, w)
	return -self.attackrate
end
N = e(
	{
		n(
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
h.modifier_lycan_shard_1 = N
return h