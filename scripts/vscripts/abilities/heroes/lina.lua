--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/lina"
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
		["34"] = 20,
		["35"] = 34,
		["36"] = 37,
		["37"] = 12,
		["38"] = 38,
		["39"] = 39,
		["40"] = 40,
		["41"] = 41,
		["42"] = 42,
		["43"] = 44,
		["44"] = 45,
		["45"] = 46,
		["46"] = 47,
		["47"] = 48,
		["48"] = 50,
		["49"] = 51,
		["50"] = 38,
		["51"] = 53,
		["52"] = 54,
		["53"] = 55,
		["54"] = 55,
		["55"] = 55,
		["56"] = 54,
		["57"] = 54,
		["58"] = 54,
		["59"] = 53,
		["60"] = 67,
		["61"] = 68,
		["62"] = 67,
		["63"] = 70,
		["64"] = 71,
		["65"] = 72,
		["67"] = 70,
		["68"] = 75,
		["69"] = 76,
		["72"] = 77,
		["73"] = 78,
		["74"] = 79,
		["75"] = 80,
		["78"] = 83,
		["79"] = 75,
		["80"] = 85,
		["81"] = 87,
		["82"] = 88,
		["83"] = 89,
		["84"] = 90,
		["85"] = 91,
		["86"] = 92,
		["87"] = 94,
		["88"] = 95,
		["89"] = 96,
		["90"] = 96,
		["91"] = 96,
		["92"] = 96,
		["93"] = 96,
		["94"] = 97,
		["95"] = 97,
		["96"] = 97,
		["97"] = 97,
		["98"] = 97,
		["99"] = 98,
		["100"] = 98,
		["101"] = 98,
		["102"] = 98,
		["103"] = 98,
		["104"] = 98,
		["105"] = 99,
		["106"] = 99,
		["107"] = 99,
		["108"] = 99,
		["109"] = 99,
		["110"] = 99,
		["111"] = 100,
		["112"] = 101,
		["115"] = 107,
		["116"] = 108,
		["117"] = 109,
		["118"] = 110,
		["119"] = 110,
		["120"] = 110,
		["121"] = 110,
		["122"] = 110,
		["123"] = 110,
		["124"] = 110,
		["125"] = 110,
		["126"] = 118,
		["127"] = 119,
		["128"] = 120,
		["129"] = 120,
		["130"] = 120,
		["131"] = 120,
		["132"] = 120,
		["133"] = 120,
		["135"] = 110,
		["136"] = 110,
		["137"] = 124,
		["138"] = 125,
		["139"] = 126,
		["142"] = 85,
		["143"] = 20,
		["144"] = 12,
		["145"] = 12,
		["146"] = 12,
		["147"] = 12,
		["148"] = 12,
		["149"] = 12,
		["150"] = 12,
		["151"] = 12,
		["152"] = 20,
		["154"] = 20,
		["155"] = 133,
		["156"] = 134,
		["157"] = 133,
		["158"] = 134,
		["159"] = 135,
		["160"] = 136,
		["161"] = 137,
		["162"] = 138,
		["163"] = 139,
		["164"] = 140,
		["165"] = 142,
		["166"] = 143,
		["167"] = 143,
		["168"] = 143,
		["169"] = 144,
		["170"] = 145,
		["171"] = 145,
		["172"] = 145,
		["173"] = 145,
		["174"] = 145,
		["175"] = 145,
		["176"] = 146,
		["177"] = 147,
		["178"] = 147,
		["179"] = 147,
		["180"] = 147,
		["181"] = 147,
		["182"] = 147,
		["183"] = 147,
		["184"] = 147,
		["185"] = 147,
		["186"] = 148,
		["187"] = 148,
		["188"] = 148,
		["189"] = 148,
		["190"] = 148,
		["191"] = 148,
		["192"] = 148,
		["193"] = 148,
		["194"] = 148,
		["195"] = 149,
		["197"] = 143,
		["198"] = 143,
		["199"] = 152,
		["200"] = 135,
		["201"] = 134,
		["202"] = 133,
		["203"] = 134,
		["205"] = 134,
		["206"] = 162,
		["207"] = 171,
		["208"] = 162,
		["209"] = 171,
		["210"] = 174,
		["211"] = 175,
		["212"] = 176,
		["213"] = 174,
		["214"] = 178,
		["215"] = 179,
		["216"] = 180,
		["218"] = 178,
		["219"] = 183,
		["220"] = 184,
		["221"] = 185,
		["222"] = 183,
		["223"] = 171,
		["224"] = 162,
		["225"] = 162,
		["226"] = 162,
		["227"] = 162,
		["228"] = 162,
		["229"] = 162,
		["230"] = 162,
		["231"] = 162,
		["232"] = 162,
		["233"] = 171,
		["235"] = 171,
		["236"] = 190,
		["237"] = 198,
		["238"] = 190,
		["239"] = 198,
		["240"] = 202,
		["241"] = 205,
		["242"] = 202,
		["243"] = 213,
		["244"] = 214,
		["245"] = 213,
		["246"] = 218,
		["247"] = 219,
		["248"] = 218,
		["249"] = 198,
		["250"] = 190,
		["251"] = 190,
		["252"] = 190,
		["253"] = 190,
		["254"] = 190,
		["255"] = 190,
		["256"] = 190,
		["257"] = 190,
		["258"] = 198,
		["260"] = 198,
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
g.lina_talent = c()
local q = g.lina_talent
q.name = "lina_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_lina_talent"
end
q = e({ j(nil) }, q)
g.lina_talent = q
g.modifier_lina_talent = c()
local r = g.modifier_lina_talent
r.name = "modifier_lina_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.shard_trigger = true
	self.record = 0
end
function r.prototype.GetAbilitySpecialValue(self)
	self.fury_gain = self:GetAbilitySpecialValueFor("fury_gain")
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.damage = self:GetAbilitySpecialValueFor("damage") + self:GetAbilityTalentValue("lina_talent_4", "bonus_damage")
	self.fury_extra_pct = self:GetAbilitySpecialValueFor("fury_extra_pct")
	self.bonus_chance = self:GetAbilityTalentValue("lina_talent_1", "bonus_chance")
	self.mana_regen = self:GetAbilityTalentValue("lina_talent_2", "mana_regen")
	self.bonus_fury_pct = self:GetAbilityTalentValue("lina_talent_3", "bonus_fury_pct")
	self.stun_duration = self:GetAbilityTalentValue("lina_talent_6", "stun_duration")
	self.count = self:GetAbilityTalentValue("lina_talent_6", "count")
	self.shard_fury_need = self:GetAbilityTalentValue("lina_shard", "fury_need")
	self.shard_duration = self:GetAbilityTalentValue("lina_shard", "duration")
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
	}
end
function r.prototype.OnBattleStart(self, s)
	self.record = 0
end
function r.prototype.onEvent(self)
	if self:PRD(self.chance + self.bonus_chance) then
		self:dragonSlave()
	end
end
function r.prototype.OnFuryGained(self, s)
	if self:GetCaster():PassivesDisabled() then
		return
	end
	if IsServer() then
		if self.shard_trigger and GetFury(self.parent) > self.shard_fury_need and self.parent:IsAlive() then
			self.parent:AddNewModifier(self.parent, nil, "modifier_lina_shard", { duration = self.shard_duration })
			self.shard_trigger = false
		end
	end
	self:onEvent()
end
function r.prototype.dragonSlave(self)
	local t = self:GetParent()
	local u = t:GetEnemy()
	if IsInjurable(u, t) then
		if self.count > 0 then
			self.record = self.record + 1
			if self.record >= self.count then
				t:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1)
				local v = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_lina/lina_spell_light_strike_array.vpcf",
					PATTACH_CUSTOMORIGIN,
					t
				)
				ParticleManager:SetParticleControl(v, 0, u:GetAbsOrigin())
				ParticleManager:SetParticleControl(v, 1, Vector(275, 275, 275))
				t:DealDamage(
					u,
					self:GetAbility(),
					self.damage + (self.fury_extra_pct + self.bonus_fury_pct) * GetFury(t) * 0.01,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
				)
				AddStun(t, u, self:GetAbility(), self.stun_duration)
				t:EmitSound("Ability.LightStrikeArray")
				self.record = self.record - self.count
			end
		end
		t:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
		local w = (u:GetAbsOrigin() - t:GetAbsOrigin()):Normalized()
		local x = (u:GetAbsOrigin() - t:GetAbsOrigin()):Length2D() + 100
		Projectile:CreateLinearProjectile({
			EffectName = "particles/units/heroes/hero_lina/dragon_slave.vpcf",
			hCaster = t,
			vSpawnOrigin = t:GetAbsOrigin(),
			vDirection = w,
			flDistance = x,
			flRadius = 150,
			iMoveSpeed = 900,
			OnProjectileHit = function(y, z, A)
				if IsInjurable(u) then
					t:DealDamage(
						u,
						self:GetAbility(),
						self.damage + (self.fury_extra_pct + self.bonus_fury_pct) * GetFury(t) * 0.01,
						EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
					)
				end
			end,
		})
		t:EmitSound("Hero_Lina.DragonSlave")
		if self.mana_regen > 0 then
			Restore(t, self.mana_regen)
		end
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
g.modifier_lina_talent = r
g.lina_ult = c()
local B = g.lina_ult
B.name = "lina_ult"
d(B, o)
function B.prototype.OnSpellStart(self)
	local C = self:GetCaster()
	local u = self:GetTarget()
	local D = self:GetSpecialValueFor("damage")
	local E = self:GetSpecialValueFor("fury_extra_pct") + self:GetTalentValue("lina_talent_5", "bonus_fury_pct")
	local F = self:GetSpecialValueFor("duration")
	C:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	C:GameTimer(0.45, function()
		if IsInjurable(C, u) then
			C:DealDamage(
				u,
				self,
				D + E * GetFury(C) * 0.01,
				self:HasTalent("lina_talent_5") and EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE
					or EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
			)
			local v = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_lina/lina_spell_laguna_blade.vpcf",
				PATTACH_CUSTOMORIGIN,
				C
			)
			ParticleManager:SetParticleControlEnt(
				v,
				0,
				C,
				PATTACH_POINT_FOLLOW,
				"attach_attack1",
				C:GetAbsOrigin(),
				false
			)
			ParticleManager:SetParticleControlEnt(
				v,
				1,
				u,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				u:GetAbsOrigin(),
				false
			)
			C:EmitSound("Ability.LagunaBlade")
		end
	end)
	C:AddNewModifier(C, self, "modifier_lina_ult", { duration = F })
end
B = e({ p(nil) }, B)
g.lina_ult = B
g.modifier_lina_ult = c()
local G = g.modifier_lina_ult
G.name = "modifier_lina_ult"
d(G, l)
function G.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.fury_per_tick = self:GetAbilitySpecialValueFor("fury_per_tick")
end
function G.prototype.OnCreated(self, s)
	if IsServer() then
		self:StartIntervalThink(self.interval)
	end
end
function G.prototype.OnIntervalThink(self)
	local t = self:GetParent()
	AddFury(t, self.fury_per_tick, "lina_ult", "Ability")
end
G = e(
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
	G
)
g.modifier_lina_ult = G
g.modifier_lina_shard = c()
local H = g.modifier_lina_shard
H.name = "modifier_lina_shard"
d(H, l)
function H.prototype.GetAbilitySpecialValue(self)
	self.magical_crit = self:GetAbilityTalentValue("lina_shard", "magical_crit")
end
function H.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MAGICAL_CRITICALSTRIKE_CHANCE }
end
function H.prototype.EOM_GetModifierMagicalCriticalStrikeChance(self, s)
	return self.magical_crit
end
H = e(
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
	H
)
g.modifier_lina_shard = H
return g