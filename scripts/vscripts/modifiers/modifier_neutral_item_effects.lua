--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local function create_armor_modifier(class_table, stacking)
	function class_table:IsHidden()
		return false
	end
	function class_table:IsDebuff()
		return true
	end
	function class_table:IsPurgable()
		return false
	end
	function class_table:RemoveOnDeath()
		return true
	end

	function class_table:OnCreated(kv)
		self.armor_per_stack = math.max(0, tonumber(kv.armor_per_stack) or 0)
		self.armor_reduction = math.max(0, tonumber(kv.armor_reduction) or 0)
		self.max_stacks = math.max(1, math.floor(tonumber(kv.max_stacks) or 1))
		if IsServer() then
			self:SetStackCount(1)
		end
	end

	function class_table:OnRefresh(kv)
		self.armor_per_stack = math.max(0, tonumber(kv.armor_per_stack) or self.armor_per_stack or 0)
		self.armor_reduction = math.max(0, tonumber(kv.armor_reduction) or self.armor_reduction or 0)
		self.max_stacks = math.max(1, math.floor(tonumber(kv.max_stacks) or self.max_stacks or 1))
		if IsServer() and stacking then
			self:SetStackCount(math.min(self.max_stacks, self:GetStackCount() + 1))
		end
	end

	function class_table:GetLevelUpCustomArmorReduction()
		if self.armor_reduction > 0 then
			return self.armor_reduction
		end
		return (self.armor_per_stack or 0) * math.max(1, self:GetStackCount())
	end
end

modifier_neutral_stygian_desolator_armor = class({})
create_armor_modifier(modifier_neutral_stygian_desolator_armor, true)

modifier_neutral_princes_knife_armor = class({})
create_armor_modifier(modifier_neutral_princes_knife_armor, false)

modifier_neutral_star_mace_armor = class({})
create_armor_modifier(modifier_neutral_star_mace_armor, true)

modifier_neutral_minotaur_horn_status_guard = class({})
function modifier_neutral_minotaur_horn_status_guard:IsHidden()
	return false
end
function modifier_neutral_minotaur_horn_status_guard:IsPurgable()
	return false
end
function modifier_neutral_minotaur_horn_status_guard:RemoveOnDeath()
	return true
end
function modifier_neutral_minotaur_horn_status_guard:OnCreated(kv)
	self.status_resistance = tonumber(kv.status_resistance) or 0
end
function modifier_neutral_minotaur_horn_status_guard:OnRefresh(kv)
	self.status_resistance = tonumber(kv.status_resistance) or self.status_resistance or 0
end
function modifier_neutral_minotaur_horn_status_guard:DeclareFunctions()
	return { MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING }
end
function modifier_neutral_minotaur_horn_status_guard:GetModifierStatusResistanceStacking()
	return self.status_resistance or 0
end
modifier_neutral_helm_damage_immunity = class({})
function modifier_neutral_helm_damage_immunity:IsHidden()
	return false
end
function modifier_neutral_helm_damage_immunity:IsPurgable()
	return false
end
function modifier_neutral_helm_damage_immunity:RemoveOnDeath()
	return true
end
function modifier_neutral_helm_damage_immunity:CheckState()
	return { [MODIFIER_STATE_INVULNERABLE] = true }
end
function modifier_neutral_helm_damage_immunity:OnLevelUpCustomIncomingDamage()
	return 0
end