--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_gold_modifier", "abilities/creeps/gold_treasure.lua", LUA_MODIFIER_MOTION_NONE)

gold_treasure = class({})

function gold_treasure:GetIntrinsicModifierName()
	return "modifier_gold_modifier"
end

--------------------------------------------------------------------------------

modifier_gold_modifier = class({})

function modifier_gold_modifier:IsHidden()
	return true
end
function modifier_gold_modifier:IsPurgable()
	return false
end
function modifier_gold_modifier:RemoveOnDeath()
	return false
end

function modifier_gold_modifier:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_gold_modifier:OnTakeDamage(params)
	if not IsServer() then
		return
	end
	if params.unit ~= self:GetParent() then
		return
	end
	local caster = self:GetParent()
	local ability = self:GetAbility()
	local gold_value = ability:GetSpecialValueFor("gold_value")

	local item = CreateItem("item_bag_of_gold", nil, nil)
	item:SetCurrentCharges(gold_value)

	local spawn_pos = caster:GetAbsOrigin()
	local target_pos = spawn_pos + RandomVector(RandomFloat(150, 250))

	local container = CreateItemOnPositionSync(spawn_pos, item)

	item:LaunchLoot(true, 250, 0.75, target_pos, nil)
	caster:EmitSound("General.Coins")
end