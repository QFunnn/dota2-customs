--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


item_pipe_lua1 = item_pipe_lua1 or class({})
item_pipe_lua2 = item_pipe_lua1 or class({})
item_pipe_lua3 = item_pipe_lua1 or class({})

LinkLuaModifier("modifier_item_pipe_lua", "items/custom_items/item_pipe_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_pipe_aura_lua", "items/custom_items/item_pipe_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_pipe_active_lua", "items/custom_items/item_pipe_lua.lua", LUA_MODIFIER_MOTION_NONE)

function item_pipe_lua1:GetIntrinsicModifierName()
	return "modifier_item_pipe_lua"
end

function item_pipe_lua1:OnSpellStart()
	EmitSoundOn("DOTA_Item.Pipe.Activate", self:GetCaster())
	local allys = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetCaster():GetAbsOrigin(),
		self:GetCaster(),
		1200,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for _, units in pairs(allys) do
		units:AddNewModifier(self:GetCaster(), self, "modifier_item_pipe_active_lua", { duration = 12 })
	end
end

-------------------------------------------------------------------------------------

modifier_item_pipe_active_lua = class({})

function modifier_item_pipe_active_lua:OnCreated()
	self.particle = ParticleManager:CreateParticle(
		"particles/items2_fx/pipe_of_insight.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(self.particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(
		self.particle,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_origin",
		self:GetParent():GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(self.particle, 2, Vector(self:GetParent():GetModelRadius() * 1.2, 0, 0))
	self:AddParticle(self.particle, false, false, -1, false, false)

	self.barrier_block = self:GetAbility():GetSpecialValueFor("barrier_block")
end

function modifier_item_pipe_active_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_item_pipe_active_lua:OnTooltip()
	return self.barrier_block
end

function modifier_item_pipe_active_lua:GetModifierIncomingSpellDamageConstant(keys)
	if keys.damage_type == DAMAGE_TYPE_MAGICAL then
		if keys.original_damage >= self.barrier_block then
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_MAGICAL_BLOCK, self:GetParent(), self.barrier_block, nil)

			self:Destroy()
			return self.barrier_block * -1
		else
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_MAGICAL_BLOCK, self:GetParent(), keys.original_damage, nil)

			self.barrier_block = self.barrier_block - keys.original_damage
			return keys.original_damage * -1
		end
	end
end

----------------------------------------------------------------------------------

modifier_item_pipe_lua = class({})

function modifier_item_pipe_lua:IsHidden()
	return true
end

function modifier_item_pipe_lua:IsPurgable()
	return false
end

function modifier_item_pipe_lua:RemoveOnDeath()
	return false
end

function modifier_item_pipe_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_pipe_lua:GetIntrinsicModifierName()
	return "modifier_item_pipe_aura_lua"
end

function modifier_item_pipe_lua:OnCreated()
	self.health_regen = self:GetAbility():GetSpecialValueFor("health_regen")
	self.magic_resistance = self:GetAbility():GetSpecialValueFor("magic_resistance")
end

function modifier_item_pipe_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_item_pipe_lua:GetModifierConstantHealthRegen()
	return self.health_regen
end

function modifier_item_pipe_lua:GetModifierMagicalResistanceBonus()
	return self.magic_resistance
end

function modifier_item_pipe_lua:IsAura()
	return true
end
function modifier_item_pipe_lua:IsAuraActiveOnDeath()
	return false
end

function modifier_item_pipe_lua:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("aura_radius")
end
function modifier_item_pipe_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_item_pipe_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_item_pipe_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_item_pipe_lua:GetModifierAura()
	return "modifier_item_pipe_aura_lua"
end

-------------------------------------------------------------------------------------------

modifier_item_pipe_aura_lua = class({})

function modifier_item_pipe_aura_lua:OnCreated()
	if not self:GetAbility() then
		return
	end
	self.aura_health_regen = self:GetAbility():GetSpecialValueFor("aura_health_regen")
	self.magic_resistance_aura = self:GetAbility():GetSpecialValueFor("magic_resistance_aura")
end
function modifier_item_pipe_aura_lua:OnRefresh()
	self:OnCreated()
end

function modifier_item_pipe_aura_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_item_pipe_aura_lua:GetModifierConstantHealthRegen()
	return self.aura_health_regen
end

function modifier_item_pipe_aura_lua:GetModifierMagicalResistanceBonus()
	return self.magic_resistance_aura
end