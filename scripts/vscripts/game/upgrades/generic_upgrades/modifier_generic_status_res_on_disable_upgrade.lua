--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_status_res_on_disable_upgrade = modifier_generic_status_res_on_disable_upgrade or class(modifier_base_generic_upgrade)


LinkLuaModifier("modifier_generic_status_res_on_disable_bonus", "game/upgrades/generic_upgrades/modifier_generic_status_res_on_disable_upgrade", LUA_MODIFIER_MOTION_NONE)





function modifier_generic_status_res_on_disable_upgrade:RecalculateBonusPerUpgrade()
	self.parent = self:GetParent()

	self.stack_duration = self:GetUpgradeValueFor("fixed_stack_duration")

	self.status_res_per_stack = self:CalculateBonusPerUpgrade("status_res_per_stack")
end


function modifier_generic_status_res_on_disable_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()

	-- CheckStateToTable returns keys as strings (for some reason)
	self.state_hexed = tostring(MODIFIER_STATE_HEXED)
	self.state_rooted = tostring(MODIFIER_STATE_ROOTED)
	self.state_feared = tostring(MODIFIER_STATE_FEARED)

	if not IsServer() then return end

	self.listener = EventDriver:Listen("Events:modifier_added", self.OnModifierAdded, self)
end


function modifier_generic_status_res_on_disable_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_status_res_on_disable_upgrade:OnModifierAdded(event)
	if not IsValidEntity(event.unit) or event.unit ~= self.parent then return end

	local is_stun = event.modifier:IsStunDebuff()

	local state = {}
	event.modifier:CheckStateToTable(state)

	if is_stun or state[self.state_hexed] or state[self.state_feared] or state[self.state_rooted] then
		local modifier = self.parent:FindModifierByName("modifier_generic_status_res_on_disable_bonus")

		if not modifier or modifier:IsNull() then
			modifier = self.parent:AddNewModifier(self.parent, nil, "modifier_generic_status_res_on_disable_bonus", {duration = -1})
		end

		-- Add may fail on invulnerable or dead heroes
		if modifier and not modifier:IsNull() then
			modifier:AddIndependentStacks(self.status_res_per_stack, self.stack_duration, nil, true)
		end
	end
end





modifier_generic_status_res_on_disable_bonus = modifier_generic_status_res_on_disable_bonus or class({})


function modifier_generic_status_res_on_disable_bonus:GetTexture() return "item_titan_sliver" end
function modifier_generic_status_res_on_disable_bonus:IsPurgable() return false end


function modifier_generic_status_res_on_disable_bonus:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	}
end


function modifier_generic_status_res_on_disable_bonus:GetModifierStatusResistanceStacking()
	return self:GetStackCount()
end


function modifier_generic_status_res_on_disable_bonus:OnCreated()
	local parent = self:GetParent()

	self.effect_cast = ParticleManager:CreateParticle("particles/custom/generics/status_res_on_debuff/generic_status_res_on_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(self.effect_cast, 0, parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
	ParticleManager:SetParticleControlEnt(self.effect_cast, 1, parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
	ParticleManager:SetParticleControl(self.effect_cast, 3, Vector(1, 1, 1))
	ParticleManager:SetParticleControl(self.effect_cast, 5, Vector(1, 1, 1))
	ParticleManager:SetParticleControl(self.effect_cast, 8, Vector(0, 0, 0))

	self:AddParticle(self.effect_cast, false, false, -1, false, false)
end


function modifier_generic_status_res_on_disable_bonus:OnStackCountChanged()
	local stacks = self:GetStackCount()

	ParticleManager:SetParticleControl(self.effect_cast, 3, Vector(stacks, 1, 1))
	ParticleManager:SetParticleControl(self.effect_cast, 8, Vector(stacks, 0, 0))
end