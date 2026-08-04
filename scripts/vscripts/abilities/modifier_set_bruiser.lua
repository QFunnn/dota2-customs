--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_set_bruiser", "abilities/modifier_set_bruiser", LUA_MODIFIER_MOTION_NONE)

local BRUISER_EPICENTER_PARTICLE = "particles/units/heroes/hero_sandking/sandking_epicenter.vpcf"

modifier_set_bruiser = class({})

function modifier_set_bruiser:IsHidden()
	return false
end
function modifier_set_bruiser:IsPurgable()
	return false
end
function modifier_set_bruiser:RemoveOnDeath()
	return false
end
function modifier_set_bruiser:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_set_bruiser:OnCreated(params)
	self.parent = self:GetParent()
	self.model_scale = tonumber(params and params.model_scale_pct) or 20
	self.move_speed = -math.abs(tonumber(params and params.move_speed_pct) or -25)
	self.aoe_attack_pct = tonumber(params and params.aoe_attack_pct) or 100
	self.radius = tonumber(params and params.radius) or 350
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1.0)
end

function modifier_set_bruiser:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_set_bruiser:GetModifierModelScale()
	return self.model_scale
end

function modifier_set_bruiser:GetModifierMoveSpeedBonus_Percentage()
	return self.move_speed
end

function modifier_set_bruiser:OnIntervalThink()
	if not IsServer() then
		return
	end
	local parent = self.parent
	if not IsValid(parent) or not parent:IsAlive() then
		return
	end
	if parent:HasModifier("modifier_set_ghost_active") then
		return
	end
	if afk_mode_system and afk_mode_system.IsActive and afk_mode_system:IsActive() then
		return
	end
	if wave_manager and wave_manager.IsPostStageActive and wave_manager:IsPostStageActive() then
		return
	end

	local hero_handler = parent.GetLevelUpHeroHandlerModifier and parent:GetLevelUpHeroHandlerModifier() or nil
	local base_attack_damage = (
		hero_handler and (hero_handler:GetCustomDamageBonus() + hero_handler:GetCustomProcAttackPhysicalBonus())
	) or 0
	local damage = base_attack_damage * (self.aoe_attack_pct / 100)
	if damage <= 0 then
		return
	end

	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		if IsValid(enemy) and enemy:IsAlive() then
			ApplyDamage({
				victim = enemy,
				attacker = parent,
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				raw_final_damage = true,
			})
		end
	end

	local pfx = ParticleManager:CreateParticle(BRUISER_EPICENTER_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(pfx, 1, Vector(self.radius, self.radius, self.radius))
	ParticleManager:ReleaseParticleIndex(pfx)
end