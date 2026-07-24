--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


pugna_rewards_of_ruin_custom = pugna_rewards_of_ruin_custom or class({})
LinkLuaModifier("modifier_pugna_rewards_of_ruin_custom", "abilities/facets/pugna_rewards_of_ruin_custom", LUA_MODIFIER_MOTION_NONE)


function pugna_rewards_of_ruin_custom:GetIntrinsicModifierName()
	return "modifier_pugna_rewards_of_ruin_custom"
end


modifier_pugna_rewards_of_ruin_custom = modifier_pugna_rewards_of_ruin_custom or class({})


function modifier_pugna_rewards_of_ruin_custom:IsPurgable() return false end
function modifier_pugna_rewards_of_ruin_custom:RemoveOnDeath() return false end


function modifier_pugna_rewards_of_ruin_custom:OnCreated()
	local ability = self:GetAbility()
	self.spell_amp_per_orb = ability:GetSpecialValueFor("spell_amp_per_orb")

	if not IsServer() then return end

	self.parent = self:GetParent()
	self.listener = EventDriver:Listen("GameLoop:orb_captured", self.OnOrbCaptured, self)
end


function modifier_pugna_rewards_of_ruin_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE, -- GetModifierSpellAmplify_Percentage
	}
end


function modifier_pugna_rewards_of_ruin_custom:CheckState()
	return {
		[MODIFIER_STATE_CASTS_IGNORE_CHANNELING] = true,
	}
end


function modifier_pugna_rewards_of_ruin_custom:GetModifierSpellAmplify_Percentage()
	return self:GetStackCount() * self.spell_amp_per_orb
end


function modifier_pugna_rewards_of_ruin_custom:OnOrbCaptured(event)
	if event.team ~= self.parent:GetTeam() then return end

	self:SetStackCount(self:GetStackCount() + event.rarity)
end