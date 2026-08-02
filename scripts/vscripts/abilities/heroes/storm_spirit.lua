--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/storm_spirit"
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
		["18"] = 5,
		["19"] = 6,
		["20"] = 5,
		["21"] = 6,
		["22"] = 7,
		["23"] = 8,
		["24"] = 7,
		["25"] = 6,
		["26"] = 5,
		["27"] = 6,
		["29"] = 6,
		["30"] = 12,
		["31"] = 20,
		["32"] = 12,
		["33"] = 20,
		["35"] = 20,
		["36"] = 23,
		["37"] = 12,
		["38"] = 25,
		["39"] = 26,
		["40"] = 27,
		["41"] = 25,
		["42"] = 29,
		["43"] = 30,
		["44"] = 30,
		["45"] = 32,
		["46"] = 32,
		["47"] = 32,
		["48"] = 30,
		["49"] = 33,
		["50"] = 33,
		["51"] = 33,
		["52"] = 30,
		["53"] = 30,
		["54"] = 29,
		["55"] = 36,
		["56"] = 37,
		["57"] = 36,
		["58"] = 39,
		["59"] = 40,
		["60"] = 41,
		["61"] = 42,
		["62"] = 43,
		["63"] = 44,
		["64"] = 45,
		["65"] = 46,
		["66"] = 47,
		["67"] = 48,
		["68"] = 48,
		["69"] = 48,
		["70"] = 48,
		["71"] = 48,
		["72"] = 48,
		["73"] = 48,
		["74"] = 48,
		["75"] = 48,
		["76"] = 49,
		["79"] = 39,
		["80"] = 53,
		["81"] = 54,
		["82"] = 53,
		["83"] = 56,
		["84"] = 57,
		["85"] = 58,
		["86"] = 59,
		["87"] = 60,
		["88"] = 61,
		["89"] = 62,
		["90"] = 63,
		["91"] = 64,
		["93"] = 66,
		["94"] = 66,
		["95"] = 66,
		["96"] = 66,
		["97"] = 66,
		["98"] = 66,
		["99"] = 67,
		["100"] = 68,
		["101"] = 68,
		["102"] = 68,
		["103"] = 68,
		["104"] = 68,
		["105"] = 69,
		["108"] = 56,
		["109"] = 73,
		["110"] = 74,
		["111"] = 73,
		["112"] = 78,
		["113"] = 79,
		["114"] = 78,
		["115"] = 20,
		["116"] = 12,
		["117"] = 12,
		["118"] = 12,
		["119"] = 12,
		["120"] = 12,
		["121"] = 12,
		["122"] = 12,
		["123"] = 12,
		["124"] = 20,
		["126"] = 20,
		["127"] = 85,
		["128"] = 86,
		["129"] = 85,
		["130"] = 86,
		["131"] = 91,
		["132"] = 92,
		["133"] = 91,
		["134"] = 86,
		["135"] = 85,
		["136"] = 86,
		["138"] = 86,
		["139"] = 96,
		["140"] = 104,
		["141"] = 96,
		["142"] = 104,
		["144"] = 104,
		["145"] = 106,
		["146"] = 96,
		["147"] = 107,
		["148"] = 108,
		["149"] = 107,
		["150"] = 110,
		["151"] = 111,
		["152"] = 112,
		["153"] = 112,
		["154"] = 111,
		["155"] = 110,
		["156"] = 115,
		["157"] = 116,
		["158"] = 117,
		["159"] = 117,
		["160"] = 117,
		["161"] = 118,
		["162"] = 119,
		["163"] = 120,
		["165"] = 117,
		["166"] = 117,
		["168"] = 115,
		["169"] = 125,
		["170"] = 126,
		["171"] = 127,
		["172"] = 127,
		["173"] = 127,
		["174"] = 127,
		["175"] = 127,
		["176"] = 127,
		["177"] = 127,
		["178"] = 127,
		["179"] = 127,
		["180"] = 130,
		["181"] = 130,
		["182"] = 131,
		["183"] = 131,
		["184"] = 131,
		["185"] = 131,
		["186"] = 131,
		["187"] = 131,
		["188"] = 125,
		["189"] = 104,
		["190"] = 96,
		["191"] = 96,
		["192"] = 96,
		["193"] = 96,
		["194"] = 96,
		["195"] = 96,
		["196"] = 96,
		["197"] = 96,
		["198"] = 104,
		["200"] = 104,
		["201"] = 135,
		["202"] = 143,
		["203"] = 135,
		["204"] = 143,
		["205"] = 144,
		["206"] = 145,
		["207"] = 146,
		["209"] = 148,
		["210"] = 149,
		["211"] = 150,
		["212"] = 150,
		["213"] = 150,
		["214"] = 150,
		["215"] = 150,
		["216"] = 150,
		["217"] = 150,
		["218"] = 150,
		["220"] = 144,
		["221"] = 153,
		["222"] = 154,
		["223"] = 155,
		["224"] = 156,
		["226"] = 153,
		["227"] = 159,
		["228"] = 160,
		["229"] = 161,
		["230"] = 162,
		["231"] = 163,
		["232"] = 163,
		["233"] = 163,
		["234"] = 163,
		["235"] = 168,
		["236"] = 169,
		["237"] = 163,
		["238"] = 163,
		["239"] = 159,
		["240"] = 143,
		["241"] = 135,
		["242"] = 135,
		["243"] = 135,
		["244"] = 135,
		["245"] = 135,
		["246"] = 135,
		["247"] = 135,
		["248"] = 135,
		["249"] = 143,
		["251"] = 143,
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
h.storm_spirit_talent = c()
local r = h.storm_spirit_talent
r.name = "storm_spirit_talent"
d(r, j)
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_storm_spirit_talent"
end
r = e({ k(nil) }, r)
h.storm_spirit_talent = r
h.modifier_storm_spirit_talent = c()
local s = h.modifier_storm_spirit_talent
s.name = "modifier_storm_spirit_talent"
d(s, m)
function s.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.record = 0
end
function s.prototype.GetAbilitySpecialValue(self)
	self.mana = self:GetAbilitySpecialValueFor("mana")
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function s.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_RESTORE] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
	}
end
function s.prototype.OnBattleStart(self, t)
	self.record = 0
end
function s.prototype.OnRestore(self, t)
	self.record = self.record + t.count
	if self.record >= self.mana then
		local u = math.floor(self.record / self.mana)
		self.record = self.record % self.mana
		self:IncrementStackCount(u)
		if self.particleID == nil then
			local v = self:GetParent()
			local w = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_stormspirit/stormspirit_overload_ambient.vpcf",
				PATTACH_CUSTOMORIGIN,
				v
			)
			ParticleManager:SetParticleControlEnt(
				w,
				0,
				v,
				PATTACH_POINT_FOLLOW,
				"attach_attack1",
				v:GetAbsOrigin(),
				false
			)
			self.particleID = w
		end
	end
end
function s.prototype.OnCustomAttackLanded(self, x)
	self:overload()
end
function s.prototype.overload(self)
	if self:GetStackCount() > 0 then
		local v = self:GetParent()
		local y = v:GetEnemy()
		if IsInjurable(v, y) then
			self:DecrementStackCount()
			if self:GetStackCount() <= 0 and self.particleID ~= nil then
				ParticleManager:DestroyParticle(self.particleID, false)
				self.particleID = nil
			end
			v:DealDamage(y, self:GetAbility(), self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			local w = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_stormspirit/stormspirit_overload_discharge.vpcf",
				PATTACH_CUSTOMORIGIN,
				v
			)
			ParticleManager:SetParticleControl(w, 0, y:GetAbsOrigin())
			v:EmitSound("Hero_StormSpirit.Overload")
		end
	end
end
function s.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BONUS }
end
function s.prototype.EOM_GetModifierManaRegenBonus(self)
	return self:GetStackCount()
end
s = e(
	{
		n(
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
h.modifier_storm_spirit_talent = s
h.storm_spirit_ult = c()
local z = h.storm_spirit_ult
z.name = "storm_spirit_ult"
d(z, p)
function z.prototype.GetIntrinsicModifierName(self)
	return "modifier_storm_spirit_ult"
end
z = e({ q(nil) }, z)
h.storm_spirit_ult = z
h.modifier_storm_spirit_ult = c()
local A = h.modifier_storm_spirit_ult
A.name = "modifier_storm_spirit_ult"
d(A, m)
function A.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.remnants = {}
end
function A.prototype.GetAbilitySpecialValue(self)
	self.reduce_pct = BUFF_VALUE.DrunkReduce + self:GetAbilityTalentValue("storm_spirit_talent_6", "rum_reduce_pct")
end
function A.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 } }
end
function A.prototype.OnDestroy(self)
	if IsServer() then
		f(self.remnants, function(B, C)
			if IsValid(C) and C:IsAlive() then
				C:RemoveAllModifiers(0, false, true, true)
				C:ForceKill(false)
			end
		end)
	end
end
function A.prototype.OnCustomAbilityFullyCast(self, x)
	local v = self:GetParent()
	local D = CreateUnitByNameWithNewData(
		"storm_spirit",
		v:GetAbsOrigin() + RandomVector(100),
		true,
		v,
		v,
		v:GetTeamNumber(),
		{}
	)
	local E = self.remnants
	E[#E + 1] = D
	D:AddNewModifier(v, self:GetAbility(), "modifier_storm_spirit_remnant", { duration = 3 })
end
A = e(
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
	A
)
h.modifier_storm_spirit_ult = A
h.modifier_storm_spirit_remnant = c()
local F = h.modifier_storm_spirit_remnant
F.name = "modifier_storm_spirit_remnant"
d(F, m)
function F.prototype.OnCreated(self, t)
	if IsServer() then
		self:StartIntervalThink(self:GetCaster():GetSecondsPerAttack(true))
	else
		local v = self:GetParent()
		local w = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_stormspirit/stormspirit_static_remnant.vpcf",
			PATTACH_ABSORIGIN,
			v
		)
		self:AddParticle(w, false, false, -1, false, false)
	end
end
function F.prototype.OnDestroy(self)
	if IsServer() then
		local v = self:GetParent()
		v:ForceKill(false)
	end
end
function F.prototype.OnIntervalThink(self)
	self:StartIntervalThink(self:GetCaster():GetSecondsPerAttack(true))
	local G = self:GetCaster()
	local y = G:GetEnemy()
	Projectile:CreateTrackingProjectile({
		hCaster = G,
		hTarget = y,
		iMoveSpeed = G:GetProjectileSpeed(),
		OnProjectileHit = function(H, I, J)
			DamageSystem:performAttack(G, y)
		end,
	})
end
F = e(
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
	F
)
h.modifier_storm_spirit_remnant = F
return h