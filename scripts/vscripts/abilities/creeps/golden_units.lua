--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_golden_passive", "abilities/creeps/golden_units", LUA_MODIFIER_MOTION_NONE)

local MODIFIER_PRIORITY_MONKAGIGA_EXTEME_HYPER_ULTRA_REINFORCED_V9 = 10001

golden_passive = class({})

function golden_passive:GetIntrinsicModifierName()
	return "modifier_golden_passive"
end

--------------------------------------------------------------------------------

modifier_golden_passive = class({})

function modifier_golden_passive:IsHidden()
	return true
end

function modifier_golden_passive:IsPurgable()
	return false
end

function modifier_golden_passive:OnCreated(kv)
	if IsServer() then
		if self:GetParent():GetUnitName() == "GoldenDragon" then
			self:GetParent():SetRenderColor(255, 250, 0)
			local field_fx = ParticleManager:CreateParticle(
				"particles/golden_dragon.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				self:GetParent()
			)
			self:AddParticle(field_fx, false, false, -1, true, true)
		end
	end
end

function modifier_golden_passive:CheckState()
	local state = {}
	if IsServer() then
		state[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = false
		state[MODIFIER_STATE_NOT_ON_MINIMAP] = false
		state[MODIFIER_STATE_NO_HEALTH_BAR] = false
	end
	return state
end

function modifier_golden_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROVIDES_FOW_POSITION,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
	return funcs
end

function modifier_golden_passive:OnTakeDamage(keys)
	if IsServer() then
		local parent = self:GetParent()
		local attacker = keys.attacker
		local target = keys.unit
		local damage = keys.damage * 0.1
		if
			attacker
			and attacker:GetTeamNumber() ~= parent:GetTeamNumber()
			and parent == target
			and not attacker:IsOther()
			and attacker:GetName() ~= "npc_dota_unit_undying_zombie"
			and not attacker:IsBuilding()
		then
			ApplyDamage({
				victim = attacker,
				attacker = parent,
				damage = damage,
				damage_type = DAMAGE_TYPE_PURE,
				damage_flags = DOTA_DAMAGE_FLAG_REFLECTION,
				ability = self:GetAbility(),
			})
		end
	end
end

function modifier_golden_passive:GetModifierProvidesFOWVision(params)
	return 1
end

function modifier_golden_passive:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_golden_passive:GetStatusEffectName()
	return "particles/econ/items/effigies/status_fx_effigies/status_effect_effigy_gold_lvl2.vpcf"
end

function modifier_golden_passive:StatusEffectPriority()
	return 10
end