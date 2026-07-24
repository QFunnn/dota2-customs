--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_nevermore_necromastery_auto = modifier_nevermore_necromastery_auto or class({})

function modifier_nevermore_necromastery_auto:IsHidden() return true end
function modifier_nevermore_necromastery_auto:IsPurgable() return false end
function modifier_nevermore_necromastery_auto:RemoveOnDeath() return false end

function modifier_nevermore_necromastery_auto:OnCreated()
	if not IsServer() then return end
	self.init = false
	self.parent = self:GetParent()
	self.interval = 6.0

	self:StartIntervalThink(FrameTime())
end

function modifier_nevermore_necromastery_auto:OnIntervalThink()

	local ability = self.parent:FindAbilityByName("nevermore_necromastery")

	if not IsValidEntity(ability) then return end

	if not self.init and ability:GetLevel() > 0 then
		self.init = true
		self:StartIntervalThink(self.interval)
		return
	end

	local max_souls = ability:GetSpecialValueFor("necromastery_max_souls")

	local modifier = self.parent:FindModifierByName("modifier_nevermore_necromastery")

	if modifier and modifier:GetStackCount() < max_souls then
		modifier:IncrementStackCount()
	end
end