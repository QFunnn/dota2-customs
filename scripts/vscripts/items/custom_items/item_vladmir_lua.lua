--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


item_vladmir_lua1 = item_vladmir_lua1 or class({})
item_vladmir_lua2 = item_vladmir_lua1 or class({})
item_vladmir_lua3 = item_vladmir_lua1 or class({})

----------------------------------------------------------------------сука он не хочет работать как надо
LinkLuaModifier("modifier_item_vladmir_lua", "items/custom_items/item_vladmir_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_vladmir_aura_lua", "items/custom_items/item_vladmir_lua.lua", LUA_MODIFIER_MOTION_NONE)

modifier_item_vladmir_lua = class({})
modifier_item_vladmir_aura_lua = class({})

function item_vladmir_lua1:GetIntrinsicModifierName()
	return "modifier_item_vladmir_lua"
end

function modifier_item_vladmir_lua:IsHidden()
	return true
end
function modifier_item_vladmir_lua:IsPurgable()
	return false
end
function modifier_item_vladmir_lua:RemoveOnDeath()
	return false
end

function modifier_item_vladmir_lua:OnCreated()
	--	if not IsServer() then return end
	self.armor_aura = self:GetAbility():GetSpecialValueFor("armor_aura")
	self.mana_regen_aura = self:GetAbility():GetSpecialValueFor("mana_regen_aura")
	self.lifesteal_aura = self:GetAbility():GetSpecialValueFor("lifesteal_aura")
	self.damage_aura = self:GetAbility():GetSpecialValueFor("damage_aura")
	self.aura_radius = self:GetAbility():GetSpecialValueFor("aura_radius")
end

function modifier_item_vladmir_lua:GetAuraRadius()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("aura_radius")
	end
end

function modifier_item_vladmir_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end

function modifier_item_vladmir_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_vladmir_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_item_vladmir_lua:GetModifierAura()
	return "modifier_item_vladmir_aura_lua"
end

function modifier_item_vladmir_lua:IsAura()
	return true
end

------------------------------------------------------------------------------------------------

function modifier_item_vladmir_aura_lua:IsHidden()
	return false
end
function modifier_item_vladmir_aura_lua:IsPurgable()
	return false
end
function modifier_item_vladmir_aura_lua:RemoveOnDeath()
	return false
end
function modifier_item_vladmir_aura_lua:IsAuraActiveOnDeath()
	return false
end

function modifier_item_vladmir_aura_lua:OnCreated()
	--	if not IsServer() then return end
	if not self:GetAbility() then
		return
	end
	self.armor_aura = self:GetAbility():GetSpecialValueFor("armor_aura")
	self.mana_regen_aura = self:GetAbility():GetSpecialValueFor("mana_regen_aura")
	self.lifesteal_aura = self:GetAbility():GetSpecialValueFor("lifesteal_aura")
	self.damage_aura = self:GetAbility():GetSpecialValueFor("damage_aura")
	self.aura_radius = self:GetAbility():GetSpecialValueFor("aura_radius")
end
function modifier_item_vladmir_aura_lua:OnRefresh()
	self:OnCreated()
end

function modifier_item_vladmir_aura_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_UNIQUE,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_ATTRIBUTE_NONE,
	}
end

function modifier_item_vladmir_aura_lua:OnTooltip()
	return self.lifesteal_aura
end

function modifier_item_vladmir_aura_lua:GetModifierBaseDamageOutgoing_Percentage()
	return self.damage_aura
end

function modifier_item_vladmir_aura_lua:GetModifierPhysicalArmorBonusUnique()
	return self.armor_aura
end

function modifier_item_vladmir_aura_lua:GetModifierConstantManaRegen()
	return self.mana_regen_aura
end

function modifier_item_vladmir_aura_lua:GetModifierProcAttack_Feedback(params)
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

function modifier_item_vladmir_aura_lua:OnTakeDamage(params)
	if IsServer() then
		local pass = false
		if self.attack_record and params.record == self.attack_record then
			pass = true
			self.attack_record = nil
		end

		if pass then
			local heal = params.damage * self.lifesteal_aura / 100
			self:GetParent():Heal(heal, self:GetAbility())
			if not self:GetParent():IsCreep() then
				self:PlayEffects(self:GetParent())
			end
		end
	end
end

function modifier_item_vladmir_aura_lua:PlayEffects(target)
	local particle_cast = "particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(effect_cast, 1, target:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end