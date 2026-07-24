--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_dark_seer_wall_of_replica_lua_empower = modifier_dark_seer_wall_of_replica_lua_empower or class({})


function modifier_dark_seer_wall_of_replica_lua_empower:IsPurgable() return false end
function modifier_dark_seer_wall_of_replica_lua_empower:GetPriority() return 9999 end


function modifier_dark_seer_wall_of_replica_lua_empower:OnCreated()
	local ability = self:GetAbility()

	self.damage_per_stack = ability:GetSpecialValueFor("damage_per_wall")
	self.model_scale_per_stack = ability:GetSpecialValueFor("model_scale_per_wall")
end


function modifier_dark_seer_wall_of_replica_lua_empower:OnStackCountChanged()
	if not IsServer() then return end

	self:GetParent():SetModelScale(1 + self.model_scale_per_stack * self:GetStackCount())
end


function modifier_dark_seer_wall_of_replica_lua_empower:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE, -- GetModifierTotalDamageOutgoing_Percentage
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE, -- GetModifierIncomingDamage_Percentage
		MODIFIER_PROPERTY_TOOLTIP,
	}
end


function modifier_dark_seer_wall_of_replica_lua_empower:GetModifierTotalDamageOutgoing_Percentage()
	return self:GetStackCount() * self.damage_per_stack
end


-- illusion takes less damage with every extra wall powering it
-- meaning 2 walls = 50%, 3 walls = 33%, 4 walls = 25% damage taken
-- resulting in -50%, -67%, -75% incoming damage
function modifier_dark_seer_wall_of_replica_lua_empower:GetModifierIncomingDamage_Percentage()
	local walls = self:GetStackCount()
	if walls == 0 then return 0 end
	return - (100 - 100 / (walls + 1))
end


function modifier_dark_seer_wall_of_replica_lua_empower:OnTooltip()
	return self:GetStackCount() + 1
end