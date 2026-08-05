--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


modifier_lifestealer_open_wounds_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_lifestealer_open_wounds_lua:IsHidden()
	return false
end

function modifier_lifestealer_open_wounds_lua:IsDebuff()
	return true
end

function modifier_lifestealer_open_wounds_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_lifestealer_open_wounds_lua:OnCreated(kv)
	self.heal = self:GetAbility():GetSpecialValueFor("heal_percent") / 100 -- special value
	self.step = 1

	if self:GetCaster():FindAbilityByName("special_bonus_lifestealer_int1") ~= nil then
		if self:GetCaster():FindAbilityByName("special_bonus_lifestealer_int1"):GetLevel() > 0 then
			self.heal = (self:GetAbility():GetSpecialValueFor("heal_percent") + 25) / 100
		end
	end

	self:StartIntervalThink(1)
end

function modifier_lifestealer_open_wounds_lua:OnRefresh(kv)
	self.heal = self:GetAbility():GetSpecialValueFor("heal_percent") / 100 -- special value

	if self:GetCaster():FindAbilityByName("special_bonus_lifestealer_int1") ~= nil then
		if self:GetCaster():FindAbilityByName("special_bonus_lifestealer_int1"):GetLevel() > 0 then
			self.heal = (self:GetAbility():GetSpecialValueFor("heal_percent") + 25) / 100
		end
	end

	self.step = 1
end

function modifier_lifestealer_open_wounds_lua:OnIntervalThink()
	self.step = self.step + 1
end

function modifier_lifestealer_open_wounds_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_EVENT_ON_ATTACKED,
	}

	return funcs
end

function modifier_lifestealer_open_wounds_lua:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetLevelSpecialValueFor("slow_steps", self.step)
end

function modifier_lifestealer_open_wounds_lua:OnAttacked(params)
	if IsServer() then
		if params.target ~= self:GetParent() then
			return
		end
		if params.attacker:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
			return
		end

		params.attacker:Heal(self.heal * params.damage, self:GetCaster())

		self:PlayEffects(params.attacker)
	end
end
--------------------------------------------------------------------
-- Graphics & Animations
function modifier_lifestealer_open_wounds_lua:GetEffectName()
	return "particles/units/heroes/hero_life_stealer/life_stealer_open_wounds.vpcf"
end

function modifier_lifestealer_open_wounds_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_lifestealer_open_wounds_lua:PlayEffects(target)
	-- Get Resources
	local particle_cast = "particles/generic_gameplay/generic_lifesteal.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	-- ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	-- ParticleManager:SetParticleControlEnt(
	-- 	effect_cast,
	-- 	iControlPoint,
	-- 	hTarget,
	-- 	PATTACH_NAME,
	-- 	"attach_name",
	-- 	vOrigin, -- unknown
	-- 	bool -- unknown, true
	-- )
	ParticleManager:ReleaseParticleIndex(effect_cast)
end