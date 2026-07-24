--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_skeleton_king_vampiric_aura_auto = modifier_skeleton_king_vampiric_aura_auto or class({})

function modifier_skeleton_king_vampiric_aura_auto:IsHidden() return true end
function modifier_skeleton_king_vampiric_aura_auto:IsPurgable() return false end
function modifier_skeleton_king_vampiric_aura_auto:RemoveOnDeath() return false end

function modifier_skeleton_king_vampiric_aura_auto:OnCreated()
	if not IsServer() then return end
	self.init = false

	Timers:CreateTimer(0, function()
		return self:OnIntervalThink()
	end)
end

function modifier_skeleton_king_vampiric_aura_auto:OnIntervalThink()
	local max_charges = 0
	local parent = self:GetParent()
	local ability = parent:FindAbilityByName("skeleton_king_bone_guard")
	if not IsValidEntity(ability) then return 0 end

	local interval = ability:GetSpecialValueFor("auto_charge_interval")

	if ability:GetLevel() <= 0 then return 0 end

	max_charges = ability:GetSpecialValueFor("max_skeleton_charges")

	local modifier = parent:FindModifierByName("modifier_skeleton_king_bone_guard")

	if modifier and modifier:GetStackCount() < max_charges then
		modifier:IncrementStackCount()
	end

	return interval
end