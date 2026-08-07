--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil/greevil_2"
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
		["75"] = 59,
		["76"] = 60,
		["77"] = 61,
		["78"] = 59,
		["79"] = 63,
		["80"] = 64,
		["81"] = 65,
		["82"] = 66,
		["83"] = 67,
		["85"] = 63,
		["86"] = 70,
		["87"] = 71,
		["88"] = 72,
		["89"] = 73,
		["90"] = 70,
		["91"] = 77,
		["92"] = 78,
		["95"] = 79,
		["96"] = 80,
		["97"] = 81,
		["98"] = 82,
		["99"] = 83,
		["100"] = 84,
		["101"] = 85,
		["102"] = 85,
		["103"] = 85,
		["104"] = 86,
		["105"] = 87,
		["106"] = 88,
		["107"] = 89,
		["108"] = 90,
		["109"] = 91,
		["110"] = 91,
		["111"] = 91,
		["112"] = 91,
		["113"] = 91,
		["114"] = 91,
		["115"] = 91,
		["116"] = 91,
		["117"] = 91,
		["118"] = 92,
		["119"] = 92,
		["120"] = 92,
		["121"] = 92,
		["122"] = 92,
		["123"] = 92,
		["124"] = 92,
		["125"] = 92,
		["126"] = 92,
		["127"] = 93,
		["128"] = 94,
		["129"] = 95,
		["130"] = 96,
		["131"] = 96,
		["132"] = 96,
		["133"] = 96,
		["134"] = 96,
		["137"] = 85,
		["138"] = 85,
		["141"] = 77,
		["142"] = 56,
		["143"] = 48,
		["144"] = 48,
		["145"] = 48,
		["146"] = 48,
		["147"] = 48,
		["148"] = 48,
		["149"] = 48,
		["150"] = 48,
		["151"] = 56,
		["153"] = 56,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.modifier_skin_greevil_2 = c()
local n = g.modifier_skin_greevil_2
n.name = "modifier_skin_greevil_2"
d(n, l)
function n.prototype.OnCreated(self, o)
	if IsServer() then
		self.parent:SetSkin(2)
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
				GetStatusEffectName = "particles/gameplay/greevil_amibent_status_2.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_ULTRA,
				RemoveOnDeath = false,
			}
		),
	},
	n
)
g.modifier_skin_greevil_2 = n
g.greevil_2 = c()
local p = g.greevil_2
p.name = "greevil_2"
d(p, i)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_greevil_2"
end
p = e({ j(nil) }, p)
g.greevil_2 = p
g.modifier_greevil_2 = c()
local q = g.modifier_greevil_2
q.name = "modifier_greevil_2"
d(q, l)
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function q.prototype.OnBattleStartBefore(self, o)
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_greevil_2_battle_buff", {})
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
g.modifier_greevil_2 = q
g.modifier_greevil_2_battle_buff = c()
local r = g.modifier_greevil_2_battle_buff
r.name = "modifier_greevil_2_battle_buff"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.mana = self:GetAbilitySpecialValueFor("mana")
	self.chance = self:GetAbilitySpecialValueFor("chance")
end
function r.prototype.OnCreated(self, o)
	if IsServer() then
		local s = self:GetParent()
		local t = s:GetCaster()
		Restore(t, self.mana)
	end
end
function r.prototype.EDeclareEvents(self)
	local u = self:GetParent()
	local t = u:GetCaster()
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { t, -1 } }
end
function r.prototype.OnCustomAbilityFullyCast(self, v)
	if v.multicast then
		return
	end
	if v.ability:GetAbilityIndex() == 1 then
		if self:PRD(self.chance) then
			local u = self:GetParent()
			local t = u:GetCaster()
			local w = u:GetEnemy()
			u:StartGesture(ACT_DOTA_CAST_ABILITY_2)
			GameTimer(0.3, function()
				if IsInjurable(t, w) then
					local x = t:GetAbilityByIndex(1)
					if x then
						u:EmitSound("Hero_Zuus.Righteous.Layer")
						local y = ParticleManager:CreateParticle(
							"particles/econ/items/zeus/zeus_ti8_immortal_arms/zeus_ti8_immortal_arc.vpcf",
							PATTACH_CUSTOMORIGIN,
							u
						)
						ParticleManager:SetParticleControlEnt(
							y,
							0,
							u,
							PATTACH_POINT_FOLLOW,
							"attach_attack2",
							u:GetAbsOrigin(),
							true
						)
						ParticleManager:SetParticleControlEnt(
							y,
							1,
							t,
							PATTACH_POINT_FOLLOW,
							"attach_hitloc",
							t:GetAbsOrigin(),
							true
						)
						x:OnSpellStart()
						FireModifierEvent(
							EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
							{ ability = x, unit = t, target = w, multicast = true },
							t,
							w
						)
						local z = ParticleManager:CreateParticle(
							"particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf",
							PATTACH_OVERHEAD_FOLLOW,
							t
						)
						ParticleManager:SetParticleControl(z, 1, Vector(2, 0, 0))
					end
				end
			end)
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
g.modifier_greevil_2_battle_buff = r
return g