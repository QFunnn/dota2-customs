--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_grimstroke/boss_grimstroke_4"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.EOMAbility
local l = j.registerEOMAbility
local m = c()
m.name = "boss_grimstroke_4"
d(m, k)
function m.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.summonRecords = {}
end
function m.prototype.OnSpellStart(self)
	local n = self:GetCaster()
	n:EmitSound("Grimstroke.Ability4")
	local o = { "grimstroke_melee", "grimstroke_melee", "grimstroke_melee", "grimstroke_ranger", "grimstroke_ranger" }
	do
		local p = 0
		while p < #o do
			local q = o[p + 1]
			local r = RandomVector(1)
			local s = RandomInt(400, 1000)
			local t = 1000
			local u = s / t
			local v = n:GetAbsOrigin() + Vector(0, 0, 200)
			local w = n:GetAbsOrigin() + r * s
			local x = ParticleManager:CreateParticle(
				"particles/units/boss/boss_grimstroke/summon_proj.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(x, 0, v)
			ParticleManager:SetParticleControl(x, 1, w)
			ParticleManager:SetParticleControl(x, 2, Vector(t, 0, 0))
			self:StartThink(u, DoUniqueString("index"), function()
				ParticleManager:DestroyParticle(x, false)
				local y = n:SummonUnit(q, w)
				if IsValid(y) then
					local z = DungeonManager:GetCurrentRoom()
					if z ~= nil then
						z:ApplyDifficultyModifiers(y)
					end
					FindClearSpaceForUnit(y, w, true)
					y:AddNewModifier(n, self, "modifier_boss_grimstroke_4", { duration = 1.5 })
					y:AddNewModifier(n, self, "modifier_boss_grimstroke_4_buff", {})
					local A = self.summonRecords
					A[#A + 1] = y
				end
				return -1
			end)
			p = p + 1
		end
	end
	n:SimulateCast({ duration = 1 })
	n:EmitSound("Hero_Grimstroke.InkCreature.Spawn")
end
function m.prototype.EventListener(self)
	return {
		entity_killed = function(B, C)
			local D = false
			local E = {}
			do
				local p = 0
				while p < #self.summonRecords do
					do
						local y = self.summonRecords[p + 1]
						if y == C.victim then
							D = true
							goto F
						end
						if IsValid(y) and y:IsAlive() then
							E[#E + 1] = y
						end
					end
					::F::
					p = p + 1
				end
			end
			if D then
				self.summonRecords = E
			end
			if C.victim == self:GetCaster() then
				self:OnDestroy()
			end
		end,
	}
end
function m.prototype.OnDestroy(self)
	local n = self:GetCaster()
	do
		local p = 0
		while p < #self.summonRecords do
			local y = self.summonRecords[p + 1]
			if IsValid(y) then
				y:Kill(self, n)
			end
			p = p + 1
		end
	end
	self.summonRecords = {}
end
m = e(
	{
		l(nil, {
			funcCondition = function(B, G)
				local H = G
				return G:GetCaster():GetCurrentActiveAbility() == nil and #H.summonRecords <= 0
			end,
		}),
	},
	m
)
local I = c()
I.name = "modifier_boss_grimstroke_4"
d(I, h)
function I.prototype.OnCreated(self, C)
	if IsServer() then
		local J = self:GetParent()
		J:AddNoDraw()
		self:SetDuration(1, true)
		local K = ParticleManager:CreateParticle(
			"particles/units/boss/boss_grimstroke/summon_spawn.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControlEnt(K, 0, J, PATTACH_ABSORIGIN_FOLLOW, nil, J:GetAbsOrigin(), false)
		self:AddParticle(K, false, false, -1, false, false)
	else
	end
end
function I.prototype.OnDestroy(self)
	if IsServer() then
		local J = self:GetParent()
		J:RemoveNoDraw()
	end
end
function I.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function I.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
I = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	I
)
local L = c()
L.name = "modifier_boss_grimstroke_4_buff"
d(L, h)
function L.prototype.GetStatusEffectName(self)
	return "particles/status_fx/status_effect_grimstroke_ink_over.vpcf"
end
function L.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_SUPER_ULTRA
end
function L.prototype.OnCreated(self, C)
	local J = self:GetParent()
	if IsServer() then
	else
	end
end
L = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	L
)
return f