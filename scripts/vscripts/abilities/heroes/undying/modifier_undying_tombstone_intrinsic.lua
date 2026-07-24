--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_undying_tombstone_intrinsic_lua = class({})

function modifier_undying_tombstone_intrinsic_lua:IsPurgable() return false end
function modifier_undying_tombstone_intrinsic_lua:IsHidden() return true end


function modifier_undying_tombstone_intrinsic_lua:OnCreated()
	self:OnRefresh()
end


function modifier_undying_tombstone_intrinsic_lua:OnRefresh()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.debuff_duration = self.ability:GetSpecialValueFor("slow_duration")
end


if not IsServer() then return end


function modifier_undying_tombstone_intrinsic_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK
	}
end


function modifier_undying_tombstone_intrinsic_lua:OnDeath(params)
	if params.unit ~= self.parent then return end
	if self.parent:IsIllusion() then return end
	if self.ability:GetSpecialValueFor("spawn_on_death") <= 0 then return end
	if self.ability:GetLevel() == 0 then return end

	self.parent:SetCursorPosition(self.parent:GetAbsOrigin())
	self.ability:OnSpellStart()
end


function modifier_undying_tombstone_intrinsic_lua:GetModifierProcAttack_Feedback(params)
	if self.parent:IsIllusion() then return end
	if not self.parent:HasModifier("modifier_undying_flesh_golem") then return end
	if self.ability:GetLevel() == 0 then return end

	local spawn_zombie_on_attack = self.ability:GetSpecialValueFor("spawn_zombie_on_attack") == 1
	if not spawn_zombie_on_attack then print("no zombie on attack?") return end

	self.ability:SpawnOrUpgradeZombie(params.target, self.parent)
end