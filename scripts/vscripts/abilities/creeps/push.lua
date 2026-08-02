--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_push", "abilities/creeps/push", LUA_MODIFIER_MOTION_NONE)

push = class({})

function push:GetIntrinsicModifierName()
	return "modifier_push"
end

---------------------------------------------------------------------------------

modifier_push = class({})

function modifier_push:IsHidden()
	return true
end

function modifier_push:IsPurgable()
	return false
end

function modifier_push:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MIN_HEALTH,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_push:CheckState()
	return {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
	}
end

function modifier_push:GetMinHealth()
	return 1
end

function modifier_push:ApplyPush(attacker)
	if not IsServer() then
		return
	end

	local parent = self:GetParent()

	if parent:GetName() == "only_trap_push" and attacker:GetUnitName() ~= "npc_dota_simple_trap" then
		return
	end

	if
		attacker
		and attacker ~= parent
		and attacker:GetUnitName() ~= "npc_dota_unit_undying_zombie"
		and not parent:HasModifier("modifier_knockback")
	then
		local origin = attacker:GetAbsOrigin()

		parent:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_knockback", {
			center_x = origin.x + 0.1,
			center_y = origin.y + 0.1,
			center_z = origin.z,
			duration = 0.4,
			knockback_duration = 0.4,
			knockback_distance = 50,
			knockback_height = 0,
			should_stun = 0,
		})
	end
end

function modifier_push:OnTakeDamage(params)
	if params.unit == self:GetParent() then
		self:ApplyPush(params.attacker)
	end
end