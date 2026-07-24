--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_shivas_guard_2", "items/item_shivas_guard_2", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_shivas_guard_2_aura", "items/item_shivas_guard_2", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_shivas_guard_2_debuff", "items/item_shivas_guard_2", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_shivas_guard_2_discord_debuff", "items/item_shivas_guard_2", LUA_MODIFIER_MOTION_NONE)

item_shivas_guard_2 = class({})

function item_shivas_guard_2:GetIntrinsicModifierName()
	return "modifier_item_shivas_guard_2"
end

function item_shivas_guard_2:OnSpellStart()
	if not IsServer() then return end
	local ability = self
	local caster = ability:GetCaster()
	local blast_radius = ability:GetSpecialValueFor("blast_radius")
	local blast_speed = ability:GetSpecialValueFor("blast_speed")
	local blast_debuff_duration = ability:GetSpecialValueFor("blast_debuff_duration")
	local damage = ability:GetSpecialValueFor("blast_damage")
	local discord_duration = ability:GetSpecialValueFor("discord_duration")
	local blast_duration = blast_radius / blast_speed
	local current_loc = caster:GetAbsOrigin()
	caster:EmitSound("DOTA_Item.ShivasGuard.Activate")
	local blast_pfx = ParticleManager:CreateParticle("particles/items2_fx/shivas_guard_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(blast_pfx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(blast_pfx, 1, Vector(blast_radius, blast_duration * 1.33, blast_speed))
	ParticleManager:ReleaseParticleIndex(blast_pfx)
	local targets_hit = {}
	local current_radius = 0
	local tick_interval = 0.1
	Timers:CreateTimer(tick_interval, function()
		AddFOWViewer(caster:GetTeamNumber(), current_loc, current_radius, 0.1, false)
		current_radius = current_radius + blast_speed * tick_interval
		current_loc = caster:GetAbsOrigin()
		local nearby_enemies = FindUnitsInRadius(caster:GetTeamNumber(), current_loc, nil, current_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		for _, enemy in pairs(nearby_enemies) do
			local enemy_has_been_hit = false
			for _, enemy_hit in pairs(targets_hit) do
				if enemy == enemy_hit then enemy_has_been_hit = true end
			end
			if not enemy_has_been_hit then
				if enemy:IsHero() then
					local hit_pfx = ParticleManager:CreateParticle("particles/items2_fx/shivas_guard_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
					ParticleManager:SetParticleControl(hit_pfx, 0, enemy:GetAbsOrigin())
					ParticleManager:SetParticleControl(hit_pfx, 1, enemy:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(hit_pfx)
				end
				enemy:AddNewModifier(caster, self, "modifier_item_shivas_guard_2_discord_debuff", {duration = discord_duration})
				enemy:AddNewModifier(caster, self, "modifier_item_shivas_guard_2_debuff", {duration = blast_debuff_duration})
				ApplyDamage({attacker = caster, victim = enemy, ability = ability, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
				targets_hit[#targets_hit + 1] = enemy
			end
		end
		if current_radius < blast_radius then
			return tick_interval
		end
	end)
end

modifier_item_shivas_guard_2 = class({})

function modifier_item_shivas_guard_2:IsHidden() return true end
function modifier_item_shivas_guard_2:IsPurgable() return false end
function modifier_item_shivas_guard_2:RemoveOnDeath() return false end

function modifier_item_shivas_guard_2:OnCreated()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	self.aura_radius = self.ability:GetSpecialValueFor("aura_radius")
	self.bonus_armor = self.ability:GetSpecialValueFor("bonus_armor")
	self.bonus_intellect = self.ability:GetSpecialValueFor("bonus_intellect")
	self.bonus_attribute_agi = self.ability:GetSpecialValueFor("bonus_attribute_agi")
	self.bonus_attribute_str = self.ability:GetSpecialValueFor("bonus_attribute_str")
	self.bonus_cooldown = self.ability:GetSpecialValueFor("bonus_cooldown")
	self.bonus_castrange = self.ability:GetSpecialValueFor("bonus_castrange")
	self.bonus_health = self.ability:GetSpecialValueFor("bonus_health")
	self.bonus_mana = self.ability:GetSpecialValueFor("bonus_mana")
	self.bonus_manaregen = self.ability:GetSpecialValueFor("bonus_manaregen")

	-- AoE bonus backdoor: attach vanilla engine-internal modifier_item_shivas_guard
	-- to the wielder, with a separate hidden donor ability as source. The donor
	-- has only `bonus_aoe` in its AbilityValues — vanilla mod reads everything else
	-- as 0, so it contributes ONLY +AoE bonus on the wielder's spells.
	if IsServer() and self.parent and not self.parent:IsNull() then
		local donor = self.parent:FindAbilityByName("shivas_guard_2_aoe_donor")
		if not donor then
			donor = self.parent:AddAbility("shivas_guard_2_aoe_donor")
		end
		if donor and not donor:IsNull() then
			if donor:GetLevel() == 0 then donor:SetLevel(1) end
			local already_attached = false
			for _, mod in ipairs(self.parent:FindAllModifiersByName("modifier_item_shivas_guard")) do
				if mod:GetAbility() == donor then
					already_attached = true
					break
				end
			end
			if not already_attached then
				self.parent:AddNewModifier(self.parent, donor, "modifier_item_shivas_guard", {})
			end
		end
	end
end

function modifier_item_shivas_guard_2:OnDestroy()
	if not IsServer() then return end
	if not self.parent or self.parent:IsNull() then return end

	-- Only clean up if this was the LAST shiva_2 modifier on the hero
	local other_count = 0
	for _, mod in ipairs(self.parent:FindAllModifiersByName("modifier_item_shivas_guard_2")) do
		if mod ~= self then other_count = other_count + 1 end
	end
	if other_count > 0 then return end

	local donor = self.parent:FindAbilityByName("shivas_guard_2_aoe_donor")
	if donor and not donor:IsNull() then
		for _, mod in ipairs(self.parent:FindAllModifiersByName("modifier_item_shivas_guard")) do
			if mod:GetAbility() == donor then
				mod:Destroy()
				break
			end
		end
	end
	if self.parent:HasAbility("shivas_guard_2_aoe_donor") then
		self.parent:RemoveAbility("shivas_guard_2_aoe_donor")
	end
end

function modifier_item_shivas_guard_2:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	}
end

function modifier_item_shivas_guard_2:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end

function modifier_item_shivas_guard_2:GetModifierBonusStats_Intellect()
	return self.bonus_intellect
end

function modifier_item_shivas_guard_2:GetModifierBonusStats_Agility()
	return self.bonus_attribute_agi
end

function modifier_item_shivas_guard_2:GetModifierBonusStats_Strength()
	return self.bonus_attribute_str
end

function modifier_item_shivas_guard_2:GetModifierPercentageCooldown()
	if self:GetParent():HasItemInInventory("item_octarine_core") then return 0 end
	return self.bonus_cooldown
end

function modifier_item_shivas_guard_2:GetModifierCastRangeBonus()
	return self.bonus_castrange
end

function modifier_item_shivas_guard_2:GetModifierHealthBonus()
	return self.bonus_health
end

function modifier_item_shivas_guard_2:GetModifierManaBonus()
	return self.bonus_mana
end

function modifier_item_shivas_guard_2:GetModifierConstantManaRegen()
	return self.bonus_manaregen
end

function modifier_item_shivas_guard_2:GetEffectName()
	return "particles/items_fx/aura_shivas.vpcf"
end

function modifier_item_shivas_guard_2:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_shivas_guard_2:IsAura() return true end
function modifier_item_shivas_guard_2:IsAuraActiveOnDeath()	return false end
function modifier_item_shivas_guard_2:GetAuraRadius() return self.aura_radius end
function modifier_item_shivas_guard_2:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_item_shivas_guard_2:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_item_shivas_guard_2:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_item_shivas_guard_2:GetModifierAura()	return "modifier_item_shivas_guard_2_aura" end
function modifier_item_shivas_guard_2:GetAuraEntityReject(target)
	if target:HasModifier("modifier_item_shivas_guard_aura") then
		return true
	end
	return false
end


modifier_item_shivas_guard_2_aura = class({})

function modifier_item_shivas_guard_2_aura:IsHidden() return false end

function modifier_item_shivas_guard_2_aura:OnCreated()
	self.aura_attack_speed = self:GetAbility():GetSpecialValueFor("aura_attack_speed")
	self.hp_regen_degen_aura = self:GetAbility():GetSpecialValueFor("hp_regen_degen_aura")
end

function modifier_item_shivas_guard_2_aura:DeclareFunctions()
	return  {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_item_shivas_guard_2_aura:GetModifierAttackSpeedBonus_Constant()
	return self.aura_attack_speed
end

function modifier_item_shivas_guard_2_aura:GetModifierLifestealRegenAmplify_Percentage()
	return self.hp_regen_degen_aura
end

function modifier_item_shivas_guard_2_aura:GetModifierHealAmplify_PercentageTarget()
	return self.hp_regen_degen_aura
end

function modifier_item_shivas_guard_2_aura:GetModifierHPRegenAmplify_Percentage()
	return self.hp_regen_degen_aura
end

modifier_item_shivas_guard_2_discord_debuff = class({})

function modifier_item_shivas_guard_2_discord_debuff:IsPurgable() return false end

function modifier_item_shivas_guard_2_discord_debuff:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_item_shivas_guard_2_discord_debuff:OnCreated()
	if not IsServer() then return end
	self.discord_effect = self:GetAbility():GetSpecialValueFor("discord_effect")
	self:StartIntervalThink(0.1)
end

function modifier_item_shivas_guard_2_discord_debuff:OnIntervalThink()
	if not IsServer() then return end
	if self:GetParent():HasModifier("modifier_item_veil_of_discord_debuff") then
		self:GetParent():RemoveModifierByName("modifier_item_veil_of_discord_debuff")
	end
end

function modifier_item_shivas_guard_2_discord_debuff:GetModifierIncomingDamage_Percentage(keys)
	if keys.damage_category == DOTA_DAMAGE_CATEGORY_SPELL then
		return self.discord_effect
	end
end

modifier_item_shivas_guard_2_debuff = class({})

function modifier_item_shivas_guard_2_debuff:OnCreated()
	if not IsServer() then return end
	self.damage = self:GetAbility():GetSpecialValueFor("persentage_damage")
	self:StartIntervalThink(1)
end

function modifier_item_shivas_guard_2_debuff:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetParent():IsAncient() then
		if self:GetParent():HasModifier("modifier_item_shivas_guard_blast") then
			self:GetParent():RemoveModifierByName("modifier_item_shivas_guard_blast")
		end
	end
end

function modifier_item_shivas_guard_2_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_item_shivas_guard_2_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("blast_movement_speed")
end