--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_axe_counter_helix_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_axe_counter_helix_lua:IsHidden()
	return false
end

function modifier_axe_counter_helix_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_axe_counter_helix_lua:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.trigger_attacks = self:GetAbility():GetSpecialValueFor("trigger_attacks")
	if IsServer() then
		self:SetStackCount(self.trigger_attacks)
	end
end

function modifier_axe_counter_helix_lua:OnRefresh(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.trigger_attacks = self:GetAbility():GetSpecialValueFor("trigger_attacks")
end

function modifier_axe_counter_helix_lua:OnDestroy()

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_axe_counter_helix_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP
	}

	return funcs
end
function modifier_axe_counter_helix_lua:OnTooltip()
	return self:GetStackCount()
end
function modifier_axe_counter_helix_lua:OnAttackLanded(params)
	if IsServer() then
		if params.attacker:GetTeamNumber() == params.target:GetTeamNumber() then return end


		if params.attacker:IsOther() or params.attacker:IsBuilding() then return end
		if params.target ~= self:GetParent() then return end

		if self:GetParent():PassivesDisabled() then return end

		-- roll dice
		-- local flChance = self.chance
		local shard_debuff_duration = self:GetAbility():GetSpecialValueFor("shard_debuff_duration")
		local shard_max_stacks = self:GetAbility():GetSpecialValueFor("shard_max_stacks")
		local damage = self:GetAbility():GetSpecialValueFor("damage")


		--如果有碎片 概率提高10%
		-- if self:GetParent():HasModifier("modifier_item_aghanims_shard") then
		--	flChance = flChance+10
		-- end
		self:DecrementStackCount()
		if self:GetStackCount() > 0 then
			return
		else
			self:SetStackCount(self.trigger_attacks)
		end

		--冷却中不触发
		if not self:GetAbility():IsCooldownReady() then
			return
		end

		-- find enemies
		local enemies = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(), -- int, your team number
		self:GetParent():GetOrigin(), -- point, center point
		nil, -- handle, cacheUnit. (not known)
		self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, -- int, flag filter
		0, -- int, order filter
		false	-- bool, can grow cache
		)

		-- damage
		for _, enemy in pairs(enemies) do
			ApplyDamage({
				victim = enemy,
				attacker = self:GetParent(),
				damage = damage,
				damage_type = DAMAGE_TYPE_PURE,
				ability = self:GetAbility(), --Optional.
				damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
			})

			--如果有碎片，增加debuff
			if shard_debuff_duration > 0 then
				if not enemy:HasModifier("modifier_axe_counter_helix_lua_debuff") then
					local hDebuff = enemy:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_axe_counter_helix_lua_debuff", { duration = shard_debuff_duration * enemy:GetStatusResistanceFactor(self:GetParent()) })
					if hDebuff then
						hDebuff:SetStackCount(1)
					end
				else
					if enemy:FindModifierByName("modifier_axe_counter_helix_lua_debuff"):GetStackCount() < shard_max_stacks then
						enemy:FindModifierByName("modifier_axe_counter_helix_lua_debuff"):IncrementStackCount()
					end
					enemy:FindModifierByName("modifier_axe_counter_helix_lua_debuff"):SetDuration(shard_debuff_duration, true)
				end
			end
		end

		-- cooldown
		self:GetAbility():UseResources(false, false, false, true)

		-- effects
		self:PlayEffects()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_axe_counter_helix_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_axe/axe_attack_blur_counterhelix.vpcf"
	local sound_cast = "Hero_Axe.CounterHelix"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:ReleaseParticleIndex(effect_cast)

	-- Create Sound
	EmitSoundOn(sound_cast, self:GetParent())
end
function modifier_axe_counter_helix_lua:GetModifierIncomingDamage_Percentage(params)
	local hCaster = self:GetCaster()
	local shard_damage_reduction = self:GetAbilitySpecialValueFor("shard_damage_reduction")
	if IsServer() then
		if IsValid(hCaster) and params.target == hCaster and params.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK and IsValid(params.attacker) then
			if params.attacker:FindModifierByNameAndCaster("modifier_axe_counter_helix_lua_debuff", hCaster) ~= nil then
				return -params.attacker:FindModifierByNameAndCaster("modifier_axe_counter_helix_lua_debuff", hCaster):GetStackCount() * shard_damage_reduction
			end
		end
	end
end