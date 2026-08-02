--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/drow_ranger"
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
		["29"] = 11,
		["30"] = 19,
		["31"] = 11,
		["32"] = 19,
		["34"] = 19,
		["35"] = 29,
		["36"] = 11,
		["37"] = 31,
		["38"] = 32,
		["39"] = 33,
		["40"] = 35,
		["41"] = 36,
		["42"] = 37,
		["43"] = 38,
		["44"] = 31,
		["45"] = 40,
		["46"] = 41,
		["49"] = 42,
		["50"] = 43,
		["51"] = 43,
		["52"] = 43,
		["53"] = 44,
		["54"] = 45,
		["56"] = 46,
		["57"] = 47,
		["58"] = 43,
		["59"] = 43,
		["61"] = 40,
		["62"] = 51,
		["63"] = 52,
		["64"] = 52,
		["65"] = 54,
		["66"] = 54,
		["67"] = 54,
		["68"] = 52,
		["69"] = 52,
		["70"] = 51,
		["71"] = 57,
		["72"] = 58,
		["73"] = 59,
		["75"] = 57,
		["76"] = 62,
		["77"] = 63,
		["80"] = 64,
		["81"] = 62,
		["82"] = 66,
		["83"] = 67,
		["84"] = 68,
		["85"] = 69,
		["86"] = 70,
		["87"] = 70,
		["88"] = 70,
		["89"] = 71,
		["90"] = 71,
		["91"] = 71,
		["92"] = 70,
		["93"] = 70,
		["94"] = 70,
		["95"] = 70,
		["96"] = 70,
		["97"] = 70,
		["98"] = 70,
		["99"] = 77,
		["100"] = 77,
		["101"] = 77,
		["102"] = 77,
		["103"] = 77,
		["104"] = 78,
		["105"] = 78,
		["106"] = 78,
		["107"] = 78,
		["108"] = 78,
		["109"] = 78,
		["110"] = 78,
		["111"] = 78,
		["112"] = 78,
		["113"] = 79,
		["114"] = 79,
		["115"] = 79,
		["116"] = 79,
		["117"] = 79,
		["118"] = 80,
		["119"] = 80,
		["120"] = 80,
		["121"] = 80,
		["122"] = 80,
		["123"] = 80,
		["124"] = 80,
		["125"] = 80,
		["126"] = 80,
		["127"] = 82,
		["128"] = 66,
		["129"] = 84,
		["130"] = 85,
		["131"] = 86,
		["132"] = 87,
		["133"] = 89,
		["134"] = 90,
		["135"] = 91,
		["136"] = 92,
		["138"] = 94,
		["140"] = 84,
		["141"] = 97,
		["142"] = 98,
		["145"] = 99,
		["146"] = 97,
		["147"] = 101,
		["148"] = 102,
		["149"] = 101,
		["150"] = 107,
		["151"] = 108,
		["152"] = 107,
		["153"] = 110,
		["154"] = 111,
		["155"] = 111,
		["156"] = 111,
		["157"] = 111,
		["158"] = 110,
		["159"] = 113,
		["160"] = 113,
		["161"] = 113,
		["163"] = 114,
		["164"] = 115,
		["165"] = 116,
		["166"] = 117,
		["167"] = 118,
		["168"] = 119,
		["169"] = 120,
		["170"] = 121,
		["171"] = 121,
		["172"] = 121,
		["173"] = 121,
		["174"] = 121,
		["175"] = 121,
		["176"] = 121,
		["177"] = 122,
		["179"] = 113,
		["180"] = 19,
		["181"] = 11,
		["182"] = 11,
		["183"] = 11,
		["184"] = 11,
		["185"] = 11,
		["186"] = 11,
		["187"] = 11,
		["188"] = 11,
		["189"] = 19,
		["191"] = 19,
		["192"] = 128,
		["193"] = 129,
		["194"] = 128,
		["195"] = 129,
		["196"] = 130,
		["197"] = 131,
		["198"] = 132,
		["199"] = 133,
		["200"] = 135,
		["201"] = 136,
		["202"] = 137,
		["203"] = 138,
		["204"] = 139,
		["205"] = 140,
		["206"] = 141,
		["207"] = 142,
		["208"] = 143,
		["209"] = 143,
		["210"] = 143,
		["211"] = 143,
		["212"] = 143,
		["213"] = 143,
		["214"] = 143,
		["215"] = 143,
		["216"] = 151,
		["217"] = 152,
		["218"] = 153,
		["219"] = 154,
		["220"] = 155,
		["222"] = 143,
		["223"] = 143,
		["226"] = 130,
		["227"] = 129,
		["228"] = 128,
		["229"] = 129,
		["231"] = 129,
		["232"] = 166,
		["233"] = 175,
		["234"] = 166,
		["235"] = 175,
		["236"] = 184,
		["237"] = 185,
		["238"] = 186,
		["239"] = 187,
		["240"] = 189,
		["241"] = 190,
		["242"] = 191,
		["243"] = 192,
		["244"] = 184,
		["245"] = 194,
		["246"] = 195,
		["249"] = 196,
		["250"] = 197,
		["251"] = 198,
		["252"] = 194,
		["253"] = 200,
		["254"] = 201,
		["257"] = 202,
		["258"] = 200,
		["259"] = 204,
		["260"] = 205,
		["261"] = 206,
		["262"] = 207,
		["263"] = 208,
		["264"] = 209,
		["265"] = 210,
		["268"] = 213,
		["269"] = 214,
		["270"] = 215,
		["272"] = 217,
		["273"] = 217,
		["274"] = 218,
		["275"] = 218,
		["276"] = 218,
		["277"] = 218,
		["278"] = 218,
		["279"] = 218,
		["280"] = 218,
		["281"] = 220,
		["282"] = 220,
		["283"] = 220,
		["284"] = 220,
		["285"] = 224,
		["286"] = 224,
		["287"] = 224,
		["288"] = 224,
		["289"] = 220,
		["290"] = 220,
		["291"] = 220,
		["292"] = 220,
		["293"] = 228,
		["294"] = 229,
		["295"] = 230,
		["296"] = 231,
		["297"] = 232,
		["300"] = 220,
		["301"] = 220,
		["302"] = 217,
		["305"] = 238,
		["306"] = 239,
		["307"] = 240,
		["308"] = 241,
		["310"] = 204,
		["311"] = 244,
		["312"] = 245,
		["315"] = 246,
		["316"] = 244,
		["317"] = 248,
		["318"] = 249,
		["319"] = 250,
		["320"] = 250,
		["321"] = 250,
		["322"] = 249,
		["323"] = 251,
		["324"] = 251,
		["325"] = 251,
		["326"] = 249,
		["327"] = 249,
		["328"] = 248,
		["329"] = 254,
		["330"] = 255,
		["331"] = 256,
		["332"] = 254,
		["333"] = 258,
		["334"] = 259,
		["335"] = 258,
		["336"] = 263,
		["337"] = 264,
		["338"] = 263,
		["339"] = 266,
		["340"] = 267,
		["341"] = 268,
		["342"] = 269,
		["343"] = 270,
		["344"] = 271,
		["345"] = 272,
		["346"] = 273,
		["350"] = 266,
		["351"] = 175,
		["352"] = 166,
		["353"] = 166,
		["354"] = 166,
		["355"] = 166,
		["356"] = 166,
		["357"] = 166,
		["358"] = 166,
		["359"] = 166,
		["360"] = 166,
		["361"] = 175,
		["363"] = 175,
		["364"] = 280,
		["365"] = 288,
		["366"] = 280,
		["367"] = 288,
		["368"] = 290,
		["369"] = 291,
		["370"] = 290,
		["371"] = 293,
		["372"] = 294,
		["373"] = 293,
		["374"] = 288,
		["375"] = 280,
		["376"] = 280,
		["377"] = 280,
		["378"] = 280,
		["379"] = 280,
		["380"] = 280,
		["381"] = 280,
		["382"] = 280,
		["383"] = 288,
		["385"] = 288,
		["386"] = 300,
		["387"] = 301,
		["388"] = 300,
		["389"] = 301,
		["390"] = 302,
		["391"] = 303,
		["392"] = 302,
		["393"] = 301,
		["394"] = 300,
		["395"] = 301,
		["397"] = 301,
		["398"] = 307,
		["399"] = 315,
		["400"] = 307,
		["401"] = 315,
		["402"] = 318,
		["403"] = 319,
		["404"] = 320,
		["405"] = 318,
		["406"] = 322,
		["407"] = 323,
		["408"] = 324,
		["409"] = 324,
		["410"] = 324,
		["411"] = 323,
		["412"] = 325,
		["413"] = 325,
		["414"] = 325,
		["415"] = 323,
		["416"] = 323,
		["417"] = 322,
		["418"] = 328,
		["419"] = 329,
		["420"] = 330,
		["421"] = 328,
		["422"] = 332,
		["423"] = 333,
		["424"] = 334,
		["425"] = 335,
		["426"] = 336,
		["427"] = 337,
		["428"] = 338,
		["429"] = 339,
		["433"] = 332,
		["434"] = 315,
		["435"] = 307,
		["436"] = 307,
		["437"] = 307,
		["438"] = 307,
		["439"] = 307,
		["440"] = 307,
		["441"] = 307,
		["442"] = 307,
		["443"] = 315,
		["445"] = 315,
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
g.drow_ranger_talent = c()
local q = g.drow_ranger_talent
q.name = "drow_ranger_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_drow_ranger_talent"
end
q = e({ j(nil) }, q)
g.drow_ranger_talent = q
g.modifier_drow_ranger_talent = c()
local r = g.modifier_drow_ranger_talent
r.name = "modifier_drow_ranger_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.hillOffset = 100
end
function r.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.ice = self:GetAbilitySpecialValueFor("ice")
	self.effect_pct = self:GetAbilityTalentValue("drow_ranger_talent_4", "effect_pct")
	self.damage_pct = self:GetAbilityTalentValue("drow_ranger_talent_5", "damage_pct")
	self.chance = self:GetAbilityTalentValue("drow_ranger_talent_6", "chance")
	self.bonus_damage = self:GetAbilityTalentValue("drow_ranger_talent_6", "bonus_damage")
end
function r.prototype.OnCreated(self, s)
	if not IsServer() then
		return
	end
	if self.chance > 0 then
		self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_DAMAGE_START, function(t, s, u, v)
			if
				u == self.parent
				and s.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
				and bit.band(s.damage_flags, DamageFlags.DAMAGE_FLAG_NO_DAMAGE_INCOMING) ~= DamageFlags.DAMAGE_FLAG_NO_DAMAGE_INCOMING
				and self:PRD(self.chance)
			then
				s.damage_flags = s.damage_flags + DamageFlags.DAMAGE_FLAG_NO_DAMAGE_INCOMING
			end
			s.damage_flags = s.damage_flags + DamageFlags.DAMAGE_FLAG_NO_EVASION_DAMAGE_INCOMING
			s.damage = s.damage + self.bonus_damage
		end)
	end
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetCaster(), -1 },
	}
end
function r.prototype.OnBattleStartBefore(self, s)
	if self:HasTalent("drow_ranger_talent_2") then
		self:CreateHilltop()
	end
end
function r.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:DestroyHilltop()
end
function r.prototype.CreateHilltop(self)
	local w = self:GetCaster()
	w:EmitSound("Hero_Drow.Glacier")
	w:SetAbsOrigin(w:GetAbsOrigin() + Vector(0, 0, self.hillOffset))
	self.hill = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{
			origin = GetGroundPosition(w:GetAbsOrigin(), w) + Vector(0, 0, self.hillOffset),
			model = "models/heroes/drow/drow_glacier_hilltop_model.vmdl",
			StartingAnim = "drow_glacier_spawn",
			scale = "4",
			angles = VectorToAngles(w:GetRightVector()),
		}
	)
	local x = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_drow/drow_glacier_hilltop.vpcf",
		PATTACH_CUSTOMORIGIN,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		x,
		0,
		self.hill,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		self.hill:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(x, 1, self.hill:GetAbsOrigin() + self.hill:GetForwardVector() * 100)
	ParticleManager:SetParticleControlEnt(x, 2, w, PATTACH_POINT_FOLLOW, "bow_bot", w:GetAbsOrigin(), true)
	self.hill._AMBIENT_PARTICLEID = x
end
function r.prototype.DestroyHilltop(self)
	if IsValidEntity(self.hill) then
		local w = self:GetCaster()
		w:SetAbsOrigin(w:GetAbsOrigin() + Vector(0, 0, -self.hillOffset))
		local y = self.hill._AMBIENT_PARTICLEID
		if y ~= nil then
			ParticleManager:DestroyParticle(y, true)
			ParticleManager:ReleaseParticleIndex(y)
		end
		self.hill:RemoveSelf()
	end
end
function r.prototype.OnCustomAttackLanded(self, z)
	if self.parent:PassivesDisabled() then
		return
	end
	self:ForstArrow()
end
function r.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PROJECTILE_NAME, MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND }
end
function r.prototype.GetAttackSound(self)
	return "Hero_DrowRanger.FrostArrows"
end
function r.prototype.GetModifierProjectileName(self)
	return Wearable:getReplaceParticle(self:GetParent(), "particles/units/heroes/hero_drow/drow_frost_arrow.vpcf")
end
function r.prototype.ForstArrow(self, A, B)
	if A == nil then
		A = 0
	end
	local C = self:GetParent()
	local v = C:GetEnemy()
	local D = self:GetAbility()
	if IsInjurable(C, v) then
		local E = 1 + self.effect_pct * 0.01
		local F = self.damage * (1 + A * 0.01)
		local G = GetIce(v) * self.damage_pct * 0.01 * (1 + A * 0.01)
		AddIce(C, v, self.ice * (1 + A * 0.01) * E, "drow_ranger_talent", "Ability")
		C:DealDamage(v, B or D, (F + G) * E, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
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
g.modifier_drow_ranger_talent = r
g.drow_ranger_ult = c()
local H = g.drow_ranger_ult
H.name = "drow_ranger_ult"
d(H, o)
function H.prototype.OnSpellStart(self)
	local u = self:GetCaster()
	local I = self:GetSpecialValueFor("duration")
	u:AddNewModifier(u, self, "modifier_drow_ranger_ult", { duration = I })
	local J = self:GetTalentValue("drow_ranger_shard", "duration")
	if J > 0 then
		local K = u:GetEnemy()
		if IsInjurable(u, K) then
			local L = K:GetAbsOrigin() - u:GetAbsOrigin()
			L.z = 0
			L = L:Normalized()
			u:EmitSound("Hero_DrowRanger.Silence")
			Projectile:CreateLinearProjectile({
				EffectName = "particles/units/heroes/hero_drow/drow_silence_wave.vpcf",
				hCaster = u,
				vSpawnOrigin = u:GetAbsOrigin(),
				vDirection = L,
				flDistance = 800,
				flRadius = 450,
				iMoveSpeed = PROJECTILE_SPEED_FAST,
				OnProjectileHit = function(v, M, N)
					if IsValid(self) and IsInjurable(v) then
						AddSilence(u, v, self, J)
						print("add modifier_drow_ranger_shard", J, self)
						v:AddNewModifier(u, self, "modifier_drow_ranger_shard", { duration = J })
					end
				end,
			})
		end
	end
end
H = e({ p(nil) }, H)
g.drow_ranger_ult = H
g.modifier_drow_ranger_ult = c()
local O = g.modifier_drow_ranger_ult
O.name = "modifier_drow_ranger_ult"
d(O, l)
function O.prototype.GetAbilitySpecialValue(self)
	self.wave = self:GetAbilitySpecialValueFor("wave")
		+ self:GetAbilityTalentValue("drow_ranger_talent_2", "bonus_count")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.arrow_count_per_wave = 4
	self.bonus_pct = self:GetAbilityTalentValue("drow_ranger_talent_1", "bonus_pct")
	self.interval_ice = self:GetAbilityTalentValue("drow_ranger_talent_3", "interval_ice")
	self.ice_record = 0
end
function O.prototype.OnCreated(self, s)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(self.duration / self.wave)
	self:GetCaster():EmitSound("Hero_DrowRanger.Multishot.Channel")
	self:IncrementStackCount()
end
function O.prototype.OnRefresh(self, s)
	if not IsServer() then
		return
	end
	self:IncrementStackCount()
end
function O.prototype.OnIntervalThink(self)
	local C = self:GetParent()
	local P = false
	local Q = 50
	local L = C:GetForwardVector()
	local R = C:FindModifierByName("modifier_drow_ranger_talent")
	if not IsValid(R) then
		return
	end
	local S = self:HasTalent("drow_ranger_talent_1") and 200 or 100
	local T = self:GetStackCount()
	local D = self:GetAbility()
	do
		local U = 0
		while U < self.arrow_count_per_wave do
			local V = Script_RemapValClamped(U, 0, 3, 2, -1)
			Projectile:CreateLinearProjectile({
				EffectName = "particles/units/heroes/hero_drow/drow_multishot_proj_linear_proj.vpcf",
				hCaster = C,
				vSpawnOrigin = C:GetAttachmentPosition("attach_attack1"),
				vDirection = Rotation2D(nil, L, -math.rad(Q / 5 * V)),
				flDistance = 800,
				flRadius = 250,
				iMoveSpeed = 1200,
				OnProjectileHit = function(v, M, N)
					if not P and IsInjurable(v) then
						P = true
						if IsValid(R) and IsValid(D) then
							R:ForstArrow((self.bonus_pct + self.damage) * T, D)
						end
					end
				end,
			})
			U = U + 1
		end
	end
	self.wave = self.wave - 1
	if self.wave <= 0 then
		self:StartIntervalThink(-1)
		self:Destroy()
	end
end
function O.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:GetCaster():StopSound("Hero_DrowRanger.Multishot.Channel")
end
function O.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { self:GetParent(), -1 },
	}
end
function O.prototype.OnBattleEnd(self, s)
	self:StartIntervalThink(-1)
	self:Destroy()
end
function O.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function O.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_CHANNEL_ABILITY_3
end
function O.prototype.OnIceGained(self, s)
	if self.interval_ice > 0 then
		self.ice_record = self.ice_record + 1
		if self.ice_record >= self.interval_ice then
			self.ice_record = 0
			local W = self:GetAbility()
			if IsValid(W) then
				W:OnSpellStart()
			end
		end
	end
end
O = e(
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
				IsIndependent = true,
			}
		),
	},
	O
)
g.modifier_drow_ranger_ult = O
g.modifier_drow_ranger_shard = c()
local X = g.modifier_drow_ranger_shard
X.name = "modifier_drow_ranger_shard"
d(X, l)
function X.prototype.GetAbilitySpecialValue(self)
	self.evasion_reduce = self:GetAbilityTalentValue("drow_ranger_shard", "evasion_reduce")
end
function X.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS] = -self.evasion_reduce }
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
g.modifier_drow_ranger_shard = X
g.drow_ranger_talent_3 = c()
local Y = g.drow_ranger_talent_3
Y.name = "drow_ranger_talent_3"
d(Y, i)
function Y.prototype.GetIntrinsicModifierName(self)
	return "modifier_drow_ranger_talent_3"
end
Y = e({ j(nil) }, Y)
g.drow_ranger_talent_3 = Y
g.modifier_drow_ranger_talent_3 = c()
local Z = g.modifier_drow_ranger_talent_3
Z.name = "modifier_drow_ranger_talent_3"
d(Z, l)
function Z.prototype.GetAbilitySpecialValue(self)
	self.interval_ice = self:GetAbilityTalentValue("drow_ranger_talent_3", "interval_ice")
	self.ice_record = 0
end
function Z.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { self:GetParent(), -1 },
	}
end
function Z.prototype.OnBattleEnd(self, s)
	self:StartIntervalThink(-1)
	self:Destroy()
end
function Z.prototype.OnIceGained(self, s)
	if self.interval_ice > 0 then
		self.ice_record = self.ice_record + 1
		if self.ice_record >= self.interval_ice then
			self.ice_record = 0
			local W = self:GetParent():FindAbilityByName("drow_ranger_ult")
			if IsValid(W) then
				W:OnSpellStart()
			end
		end
	end
end
Z = e(
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
	Z
)
g.modifier_drow_ranger_talent_3 = Z
return g