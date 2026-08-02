--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_treant/boss_treant_2"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFilter
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("abilities.eom_ability")
local i = h.EOMAbility
local j = h.registerEOMAbility
local k = c()
k.name = "boss_treant_2"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.summonRecords = {}
end
function k.prototype.OnAbilityPhaseStart(self)
	local l = self:GetCaster()
	local m = self:GetCursorPosition()
	local n = self:GetSpecialValueFor("radius")
	self:CircleWarning(m, n, self:GetCastPoint())
	l:EmitSound(KeyValues:GetAttackSoundSet(l, "SoundSet") .. ".PreAttack")
	return true
end
function k.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles(true)
end
function k.prototype.SummonTreant(self, m)
	local o = self:GetSpecialValueFor("treant_limit")
	self.summonRecords = e(self.summonRecords, function(p, q)
		return IsValid(q) and q:IsAlive()
	end)
	if #self.summonRecords >= o then
		return
	end
	local l = self:GetCaster()
	local r = l:SummonUnit("shredder_treant", m)
	if r ~= nil then
		local s = DungeonManager:GetCurrentRoom()
		if s ~= nil then
			s:ApplyDifficultyModifiers(r)
		end
		FindClearSpaceForUnit(r, m, true)
		local t = self.summonRecords
		t[#t + 1] = r
	end
end
function k.prototype.DealAOEDamage(self, m, n, u)
	local l = self:GetCaster()
	local v = FindEnemiesInRadius(l, m, n)
	l:DealDamage(v, self, u)
	self:SummonTreant(m)
	local w = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_centaur/centaur_warstomp.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(w, 0, m)
	ParticleManager:SetParticleControl(w, 1, Vector(n, n, n))
	self:AddParticle(w)
	l:EmitSound("Hero_Centaur.HoofStomp")
end
function k.prototype.OnSpellStart(self)
	self:DestroyWarningParticles()
	local l = self:GetCaster()
	local m = self:GetCursorPosition()
	local x = self:GetSpecialValueFor("count")
	local n = self:GetSpecialValueFor("radius")
	local y = self:GetSpecialValueFor("radius2")
	local u = self:GetSpecialValueFor("damage")
	local z = self:GetSpecialValueFor("radius3")
	self:DealAOEDamage(m, n, u)
	if x >= 2 then
		self:CircleWarning(m, y, 1)
	end
	l:SimulateCast({
		castAnimation = ACT_SCRIPT_CUSTOM_2,
		duration = 0.6,
		OnFinish = function()
			if x >= 2 then
				l:SimulateCast({
					castPoint = 0.4,
					castAnimation = ACT_SCRIPT_CUSTOM_3,
					duration = 1,
					OnSpellStart = function()
						self:DealAOEDamage(m, y, u)
						if x >= 3 then
							self:CircleWarning(m, z, 1)
						end
					end,
					OnFinish = function()
						if x >= 3 then
							l:SimulateCast({
								castPoint = 0.4,
								castAnimation = ACT_SCRIPT_CUSTOM_3,
								duration = 1,
								OnSpellStart = function()
									self:DealAOEDamage(m, z, u)
								end,
							})
						end
					end,
				})
			end
		end,
	})
end
function k.prototype.EventListener(self)
	return {
		entity_killed = function(p, A)
			if A.victim == self:GetCaster() then
				self:OnDestroy()
			end
		end,
	}
end
function k.prototype.OnDestroy(self)
	local l = self:GetCaster()
	for p, r in ipairs(self.summonRecords) do
		if IsValid(r) then
			r:Kill(self, l)
		end
	end
	self.summonRecords = {}
end
k = f({ j(nil, {}) }, k)
return g