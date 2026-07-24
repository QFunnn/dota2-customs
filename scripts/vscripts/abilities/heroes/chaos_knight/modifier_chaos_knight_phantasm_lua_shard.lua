--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chaos_knight_phantasm_lua_shard = modifier_chaos_knight_phantasm_lua_shard or class({})


-- CHAOS BOLT SHARD HELPER
-- since vanilla chaos bolt doesn't create illusion unless vanilla phantasm is present
-- and i didn't feel like rewriting entire ability for something so minor
-- this modifier creates illusion when parent deals damage with chaos bolt


function modifier_chaos_knight_phantasm_lua_shard:IsHidden() return true end
function modifier_chaos_knight_phantasm_lua_shard:IsPurgable() return false end


function modifier_chaos_knight_phantasm_lua_shard:OnCreated()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
end


function modifier_chaos_knight_phantasm_lua_shard:OnRefresh()
	self:OnCreated()
end


function modifier_chaos_knight_phantasm_lua_shard:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE, -- GetModifierTotalDamageOutgoing_Percentage
	}
end


function modifier_chaos_knight_phantasm_lua_shard:GetModifierTotalDamageOutgoing_Percentage(params)
	local inflictor = params.inflictor

	if not IsValidEntity(inflictor) or inflictor:GetAbilityName() ~= "chaos_knight_chaos_bolt" then return end
	if not IsValidEntity(params.target) then return end
	if not IsValidEntity(self.ability) or not IsValidEntity(self.parent) then return end
	if self.ability:GetLevel() <= 0 then return end

	if not self.parent:HasShard() then return end

	local chaos_bolt_ability = self.parent:FindAbilityByName("chaos_knight_chaos_bolt")

	local shard_illusion_duration = IsValidEntity(chaos_bolt_ability) and chaos_bolt_ability:GetSpecialValueFor("illusion_duration") or 6

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