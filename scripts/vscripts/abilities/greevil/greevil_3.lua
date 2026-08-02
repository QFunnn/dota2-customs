--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil/greevil_3"
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
		["14"] = 4,
		["15"] = 14,
		["16"] = 4,
		["17"] = 14,
		["18"] = 15,
		["19"] = 16,
		["20"] = 17,
		["22"] = 15,
		["23"] = 14,
		["24"] = 4,
		["25"] = 4,
		["26"] = 4,
		["27"] = 4,
		["28"] = 4,
		["29"] = 4,
		["30"] = 4,
		["31"] = 4,
		["32"] = 4,
		["33"] = 4,
		["34"] = 14,
		["36"] = 14,
		["37"] = 22,
		["38"] = 23,
		["39"] = 22,
		["40"] = 23,
		["41"] = 24,
		["42"] = 25,
		["43"] = 24,
		["44"] = 23,
		["45"] = 22,
		["46"] = 23,
		["48"] = 23,
		["49"] = 29,
		["50"] = 37,
		["51"] = 29,
		["52"] = 37,
		["53"] = 38,
		["54"] = 39,
		["55"] = 38,
		["56"] = 43,
		["57"] = 44,
		["58"] = 43,
		["59"] = 37,
		["60"] = 29,
		["61"] = 29,
		["62"] = 29,
		["63"] = 29,
		["64"] = 29,
		["65"] = 29,
		["66"] = 29,
		["67"] = 29,
		["68"] = 37,
		["70"] = 37,
		["71"] = 48,
		["72"] = 56,
		["73"] = 48,
		["74"] = 56,
		["75"] = 66,
		["76"] = 67,
		["77"] = 68,
		["78"] = 69,
		["79"] = 66,
		["80"] = 76,
		["81"] = 77,
		["82"] = 78,
		["83"] = 79,
		["85"] = 76,
		["86"] = 83,
		["87"] = 84,
		["88"] = 85,
		["89"] = 86,
		["90"] = 87,
		["91"] = 88,
		["92"] = 89,
		["93"] = 90,
		["94"] = 91,
		["95"] = 92,
		["96"] = 92,
		["97"] = 92,
		["98"] = 93,
		["101"] = 94,
		["102"] = 95,
		["103"] = 96,
		["104"] = 96,
		["105"] = 96,
		["106"] = 96,
		["107"] = 96,
		["108"] = 96,
		["109"] = 96,
		["110"] = 96,
		["111"] = 96,
		["112"] = 97,
		["113"] = 98,
		["114"] = 98,
		["115"] = 98,
		["116"] = 98,
		["117"] = 98,
		["118"] = 98,
		["119"] = 98,
		["120"] = 98,
		["121"] = 98,
		["122"] = 92,
		["123"] = 92,
		["125"] = 83,
		["126"] = 140,
		["127"] = 141,
		["128"] = 142,
		["129"] = 143,
		["130"] = 140,
		["131"] = 149,
		["132"] = 150,
		["133"] = 149,
		["134"] = 152,
		["135"] = 152,
		["136"] = 158,
		["137"] = 159,
		["138"] = 158,
		["139"] = 56,
		["140"] = 48,
		["141"] = 48,
		["142"] = 48,
		["143"] = 48,
		["144"] = 48,
		["145"] = 48,
		["146"] = 48,
		["147"] = 48,
		["148"] = 56,
		["150"] = 56,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.modifier_skin_greevil_3 = c()
local n = g.modifier_skin_greevil_3
n.name = "modifier_skin_greevil_3"
d(n, l)
function n.prototype.OnCreated(self, o)
	if IsServer() then
		self.parent:SetSkin(3)
	end
end
n = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetStatusEffectName = "particles/gameplay/greevil_amibent_status_3.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_ULTRA,
				RemoveOnDeath = false,
			}
		),
	},
	n
)
g.modifier_skin_greevil_3 = n
g.greevil_3 = c()
local p = g.greevil_3
p.name = "greevil_3"
d(p, i)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_greevil_3"
end
p = e({ j(nil) }, p)
g.greevil_3 = p
g.modifier_greevil_3 = c()
local q = g.modifier_greevil_3
q.name = "modifier_greevil_3"
d(q, l)
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function q.prototype.OnBattleStartBefore(self, o)
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_greevil_3_battle_buff", {})
end
q = e(
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
	q
)
g.modifier_greevil_3 = q
g.modifier_greevil_3_battle_buff = c()
local r = g.modifier_greevil_3_battle_buff
r.name = "modifier_greevil_3_battle_buff"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.damege_pct = self:GetAbilitySpecialValueFor("damege_pct")
end
function r.prototype.OnCreated(self, o)
	if IsServer() then
		self.damage_accumulated = 0
		self:StartIntervalThink(self.interval)
	end
end
function r.prototype.OnIntervalThink(self)
	local s = self:GetParent()
	local t = self.damage_accumulated
	self.damage_accumulated = 0
	if t > 0 then
		local u = s:GetEnemy()
		local v = s:GetCaster()
		s:StartGesture(ACT_DOTA_CAST_ABILITY_3)
		local w = t * self.damege_pct * 0.01
		GameTimer(0.3, function()
			if not IsInjurable(v, u) then
				return
			end
			s:EmitSound("Hero_Dawnbreaker.Fire_Wreath.Sweep")
			local x = ParticleManager:CreateParticle(
				"particles/gameplay/greevil_ability/greevil_3_impact.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				u
			)
			ParticleManager:SetParticleControlEnt(
				x,
				0,
				u,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				u:GetAbsOrigin(),
				true
			)
			ParticleManager:ReleaseParticleIndex(x)
			DamageSystem:dealDamage({
				attacker = v,
				target = u,
				ability = self.ability,
				damage = w,
				damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
				damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
				damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
			})
		end)
	end
end
function r.prototype.EDeclareEvents(self)
	local s = self:GetParent()
	local v = s:GetCaster()
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { v },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { v },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { v, v },
	}
end
function r.prototype.OnCustomAttackLanded(self, y)
	self.damage_accumulated = self.damage_accumulated + y.damage
end
function r.prototype.OnCustomTakeDamage(self, y) end
function r.prototype.OnBattleEnd(self, o)
	self:StartIntervalThink(-1)
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
g.modifier_greevil_3_battle_buff = r
return g