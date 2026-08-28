--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_wraith_king_vampiric_aura_lua",
	"heroes/hero_skeleton/wraith_king_vampiric_aura_lua/wraith_king_vampiric_aura_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_wraith_king_vampiric_aura_lua_lifesteal",
	"heroes/hero_skeleton/wraith_king_vampiric_aura_lua/wraith_king_vampiric_aura_lua",
	LUA_MODIFIER_MOTION_NONE
)

wraith_king_vampiric_aura_lua = class({})

function wraith_king_vampiric_aura_lua:GetIntrinsicModifierName()
	return "modifier_wraith_king_vampiric_aura_lua"
end

------------------------------------------------------------------------------

modifier_wraith_king_vampiric_aura_lua = class({})

function modifier_wraith_king_vampiric_aura_lua:IsHidden()
	return true
end

function modifier_wraith_king_vampiric_aura_lua:IsAura()
	return true
end

function modifier_wraith_king_vampiric_aura_lua:GetModifierAura()
	return "modifier_wraith_king_vampiric_aura_lua_lifesteal"
end

function modifier_wraith_king_vampiric_aura_lua:GetAuraRadius()
	local abil = self:GetCaster():FindAbilityByName("special_bonus_skeleton_king_tal3")
	if abil ~= nil and abil:GetLevel() > 0 then
		return self.aura_radius
	else
		return 0
	end
end

function modifier_wraith_king_vampiric_aura_lua:GetAuraSearchTeam()
	if not self:GetParent():PassivesDisabled() then
		return DOTA_UNIT_TARGET_TEAM_FRIENDLY
	end
end

function modifier_wraith_king_vampiric_aura_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_wraith_king_vampiric_aura_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_wraith_king_vampiric_aura_lua:OnCreated(kv)
	self.aura_radius = self:GetAbility():GetSpecialValueFor("vampiric_aura_radius")
end

function modifier_wraith_king_vampiric_aura_lua:OnRefresh(kv)
	self.aura_radius = self:GetAbility():GetSpecialValueFor("vampiric_aura_radius")
end

--------------------------------------------------------------------------------

modifier_wraith_king_vampiric_aura_lua_lifesteal = class({})

function modifier_wraith_king_vampiric_aura_lua_lifesteal:IsHidden()
	return false
end

function modifier_wraith_king_vampiric_aura_lua_lifesteal:IsDebuff()
	return false
end

function modifier_wraith_king_vampiric_aura_lua_lifesteal:OnCreated(kv)
	self.aura_lifesteal = self:GetAbility():GetSpecialValueFor("vampiric_aura")
end

function modifier_wraith_king_vampiric_aura_lua_lifesteal:OnRefresh(kv)
	self.aura_lifesteal = self:GetAbility():GetSpecialValueFor("vampiric_aura")
end

function modifier_wraith_king_vampiric_aura_lua_lifesteal:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_wraith_king_vampiric_aura_lua_lifesteal:GetModifierProcAttack_Feedback(params)
	if IsServer() then
		local pass = false
		if params.target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
			if (not params.target:IsBuilding()) and (not params.target:IsOther()) then
				pass = true
			end
		end

		if pass then
			self.attack_record = params.record
		end
	end
end

function modifier_wraith_king_vampiric_aura_lua_lifesteal:OnTakeDamage(params)
	if IsServer() then
		local pass = false
		if self.attack_record and params.record == self.attack_record then
			pass = true
			self.attack_record = nil
		end

		if pass then
			local heal = params.damage * self.aura_lifesteal / 100
			self:GetParent():Heal(heal, self:GetAbility())
			self:PlayEffects(self:GetParent())
		end
	end
end

function modifier_wraith_king_vampiric_aura_lua_lifesteal:PlayEffects(target)
	local particle_cast = "particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(effect_cast, 1, target:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end