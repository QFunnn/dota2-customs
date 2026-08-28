--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_chaos_knight_phantasm_lua_shard = modifier_chaos_knight_phantasm_lua_shard or class({})

-- CHAOS BOLT SHARD HELPER
-- since vanilla chaos bolt doesn't create illusion unless vanilla phantasm is present
-- and i didn't feel like rewriting entire ability for something so minor
-- this modifier creates illusion when parent deals damage with chaos bolt

function modifier_chaos_knight_phantasm_lua_shard:IsHidden()
	return true
end
function modifier_chaos_knight_phantasm_lua_shard:IsPurgable()
	return false
end

function modifier_chaos_knight_phantasm_lua_shard:OnCreated()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	self.caster = self:GetParent()

	self.is_spawned_shard_illusion = false
end

function modifier_chaos_knight_phantasm_lua_shard:OnRefresh()
	self:OnCreated()
end

function modifier_chaos_knight_phantasm_lua_shard:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE, -- GetModifierTotalDamageOutgoing_Percentage
		MODIFIER_EVENT_ON_ABILITY_EXECUTED, -- OnAbilityExecuted
	}
end

function modifier_chaos_knight_phantasm_lua_shard:OnAbilityExecuted(keys)
	if not IsServer() then
		return
	end
	if not self.caster or self.caster:IsNull() then
		return
	end
	if self.caster ~= keys.unit then
		return
	end
	if keys.ability:GetAbilityName() ~= "chaos_knight_chaos_bolt" then
		return
	end

	self.is_spawned_shard_illusion = false
end

function modifier_chaos_knight_phantasm_lua_shard:GetModifierTotalDamageOutgoing_Percentage(params)
	local inflictor = params.inflictor

	if not IsValidEntity(inflictor) or inflictor:GetAbilityName() ~= "chaos_knight_chaos_bolt" then
		return
	end
	if not IsValidEntity(params.target) then
		return
	end
	if not IsValidEntity(self.ability) or not IsValidEntity(self.parent) then
		return
	end
	if self.ability:GetLevel() <= 0 then
		return
	end

	if not self.parent:HasShard() then
		return
	end
	if self.is_spawned_shard_illusion then
		return
	end

	self.is_spawned_shard_illusion = true

	local chaos_bolt_ability = self.parent:FindAbilityByName("chaos_knight_chaos_bolt")

	local shard_illusion_duration = IsValidEntity(chaos_bolt_ability)
			and chaos_bolt_ability:GetSpecialValueFor("illusion_duration")
		or 6

	local illusions = self.ability:CreateIllusionsAt(self.parent, 1, shard_illusion_duration)

	local attack_order_table = {
		UnitIndex = nil,
		OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
		TargetIndex = params.target:GetEntityIndex(),
	}

	for _, illusion in pairs(illusions or {}) do
		if IsValidEntity(illusion) then
			attack_order_table.UnitIndex = illusion:GetEntityIndex()
			ExecuteOrderFromTable(attack_order_table)

			FindClearRandomPositionAroundUnit(illusion, params.target, 128)
		end
	end
end