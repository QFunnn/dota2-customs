--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_visage_gravekeepers_cloak_lua", "heroes/hero_visage/visage_gravekeepers_cloak_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_visage_summon_familiars_stone_form_buff_custom", "heroes/hero_visage/visage_gravekeepers_cloak_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_visage_gravekeepers_cloak_secondary_lua", "heroes/hero_visage/visage_gravekeepers_cloak_lua", LUA_MODIFIER_MOTION_NONE )


visage_gravekeepers_cloak_lua = class({})

function visage_gravekeepers_cloak_lua:GetIntrinsicModifierName()
	return "modifier_visage_gravekeepers_cloak_lua"
end

function visage_gravekeepers_cloak_lua:GetBehavior()
	if self:GetCaster():HasShard() then return DOTA_ABILITY_BEHAVIOR_NO_TARGET end

	return DOTA_ABILITY_BEHAVIOR_PASSIVE 
end

function visage_gravekeepers_cloak_lua:OnSpellStart()

	local caster = self:GetCaster()
	if not caster or caster:IsNull() then return end
	
	if not caster:HasShard() then return end
	local shard_duration = self:GetSpecialValueFor("shard_duration")
	caster:AddNewModifier(caster, self, "modifier_visage_summon_familiars_stone_form_buff_custom", {duration = shard_duration})
	--caster:AddNewModifier(caster, self, "modifier_visage_summon_familiars_stone_form_buff", {duration = shard_duration})
	caster:StartGesture( self:GetCastAnimation() )
end



modifier_visage_gravekeepers_cloak_lua = class({})

function modifier_visage_gravekeepers_cloak_lua:IsHidden() return false end
function modifier_visage_gravekeepers_cloak_lua:IsDebuff() return false end
function modifier_visage_gravekeepers_cloak_lua:IsPurgable() return false end
function modifier_visage_gravekeepers_cloak_lua:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_visage_gravekeepers_cloak_lua:IsAura() return true end
function modifier_visage_gravekeepers_cloak_lua:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("radius") end
function modifier_visage_gravekeepers_cloak_lua:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_visage_gravekeepers_cloak_lua:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_visage_gravekeepers_cloak_lua:GetAuraSearchType() return DOTA_UNIT_TARGET_ALL end
function modifier_visage_gravekeepers_cloak_lua:GetModifierAura() return "modifier_visage_gravekeepers_cloak_secondary_lua" end

function modifier_visage_gravekeepers_cloak_lua:GetAuraEntityReject( hEntity )
	if not IsServer() then return false end

	-- reject if it's not familiar
	if hEntity:GetUnitName():find("npc_dota_visage_familiar") then
		return false
	end

	return true
end

function modifier_visage_gravekeepers_cloak_lua:OnStackCountChanged(old_stack_count)
	if IsServer() then return end

	local parent = self:GetParent()
	if not parent or parent:IsNull() then return end

	local new_stack_count = self:GetStackCount()
	if new_stack_count and new_stack_count > 0 then
		local cloak_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_visage/visage_cloak_lyr4.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
		ParticleManager:ReleaseParticleIndex(cloak_pfx)
		
		if not self.barrier_pfx then
			self.barrier_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_visage/visage_cloak_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
		end

		local rock_count = 4
		if self.barrier_pfx then
			for i = 2, 5 do		-- control points for rocks go from 2 to 5
				if new_stack_count >= rock_count * (i-1) then
					ParticleManager:SetParticleControl(self.barrier_pfx, i, Vector(1,0,0))
				else
					ParticleManager:SetParticleControl(self.barrier_pfx, i, Vector(0,0,0))
				end
			end
		end
	end
end


function modifier_visage_gravekeepers_cloak_lua:OnCreated()
	
	if not IsServer() then return end

	-- Unit identifier
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not caster or caster:IsNull() then return end
	if not ability or ability:IsNull() then return end
	local ability_level = ability:GetLevel() - 1

	-- Precache data
	self.max_layers = ability:GetSpecialValueFor("max_layers")
	self.damage_reduction = ability:GetLevelSpecialValueFor("damage_reduction", ability_level)
	self.recovery_time = ability:GetLevelSpecialValueFor("recovery_time", ability_level)
	self.minimum_damage = ability:GetSpecialValueFor("minimum_damage")
	self.radius = ability:GetSpecialValueFor("radius")
	self.max_damage_reduction = ability:GetSpecialValueFor("max_damage_reduction")
	self.hero_multiplier = ability:GetSpecialValueFor("hero_multiplier")
	
	-- Talent handler
	if not self.talent then
		self.talent = caster:FindAbilityByName("special_bonus_unique_visage_5")
	end
	
	-- if talent is upgraded before spell is learned
	if caster:HasTalent("special_bonus_unique_visage_5") then
		self.max_layers = self:GetAbility():GetSpecialValueFor("max_layers") + self.talent:GetSpecialValueFor("value")
	end
	
	-- Set to max stacks when ability is first learned
	if not self.initialize_stacks then
		self.initialize_stacks = true
		
		-- without timer OnStackCountChanged() doesn't get called
		Timers:CreateTimer(0.1, function()
			if self and not self:IsNull() then
				self:SetStackCount(self.max_layers)
			end
		end)

	end
	
	if not self.listener then
		self.listener = ListenToGameEvent(
			"dota_player_learned_ability", 
			Dynamic_Wrap(modifier_visage_gravekeepers_cloak_lua, "OnPlayerLearnedAbility"),
			self
		)	
	end
	
end

function modifier_visage_gravekeepers_cloak_lua:OnRefresh()
	self:OnCreated()
end

function modifier_visage_gravekeepers_cloak_lua:OnDestroy()
	if self.listener then
		StopListeningToGameEvent(self.listener)
	end
	self.initialize_stacks = nil

	if self.barrier_pfx then
		ParticleManager:DestroyParticle(self.barrier_pfx, false)
		ParticleManager:ReleaseParticleIndex(self.barrier_pfx)
		self.barrier_pfx = nil
	end
end

function modifier_visage_gravekeepers_cloak_lua:OnPlayerLearnedAbility( keys )
	local caster = self:GetCaster()
	if not caster or caster:IsNull() then return end
	if keys.PlayerID ~= caster:GetPlayerOwnerID() then return end
	-- if talent is upgraded after spell is learned
	if self and not self:IsNull() and self.talent and keys.abilityname == "special_bonus_unique_visage_5" then		-- adds gravekeepers cloak stacks
		self.max_layers = self:GetAbility():GetSpecialValueFor("max_layers") + self.talent:GetSpecialValueFor("value")
		self:SetStackCount(self:GetStackCount() + self.talent:GetSpecialValueFor("value"))
	end
end

function modifier_visage_gravekeepers_cloak_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_visage_gravekeepers_cloak_lua:GetModifierPhysicalArmorBonus()
	return self:GetParent():FindTalentValue("special_bonus_unique_visage_5")
end

function modifier_visage_gravekeepers_cloak_lua:GetModifierIncomingDamage_Percentage(keys)
	if not keys.target or keys.target:IsNull() then return end
	if not keys.attacker or keys.attacker:IsNull() then return end

	-- "Only reacts on damage instances that are greater than 40 (after all other reductions)."
	if keys.attacker == keys.target or keys.damage <= self.minimum_damage then return end	

	if bit:_and(keys.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) == DOTA_DAMAGE_FLAG_HPLOSS then return end

	local stacks = self:GetStackCount()
	if stacks > 0 then
		if keys.attacker:IsHero() then
			for i = 1, self.hero_multiplier do
				self:DecrementStackCount()
			end
			Timers:CreateTimer(self.recovery_time, function()
				if self and not self:IsNull() then
					for i = 1, self.hero_multiplier do
						if self:GetStackCount() < self.max_layers then
							self:IncrementStackCount()
						end
					end
				end
			end)
		else
			self:DecrementStackCount()
			Timers:CreateTimer(self.recovery_time, function()
				if self and not self:IsNull() then
					if self:GetStackCount() < self.max_layers then
						self:IncrementStackCount()
					end
				end
			end)
		end
	end
	return - (math.min(self.max_damage_reduction, self.damage_reduction * self:GetStackCount()))
end


modifier_visage_gravekeepers_cloak_secondary_lua = class({})

function modifier_visage_gravekeepers_cloak_secondary_lua:IsHidden() return false end
function modifier_visage_gravekeepers_cloak_secondary_lua:IsDebuff() return false end
function modifier_visage_gravekeepers_cloak_secondary_lua:IsPurgable() return false end

function modifier_visage_gravekeepers_cloak_secondary_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
end

function modifier_visage_gravekeepers_cloak_secondary_lua:OnCreated()
	if not IsServer() then return end

	local ability = self:GetAbility()
	if not ability or ability:IsNull() then return end
	local ability_level = ability:GetLevel() - 1

	self.damage_reduction = ability:GetLevelSpecialValueFor("damage_reduction", ability_level)
	self.max_damage_reduction = ability:GetSpecialValueFor("max_damage_reduction")
end

function modifier_visage_gravekeepers_cloak_secondary_lua:GetModifierIncomingDamage_Percentage(keys)
	if not keys.target or keys.target:IsNull() then return end
	if not keys.attacker or keys.attacker:IsNull() then return end

	--no minimum damage threshold on secondary modifier
	if bit:_and(keys.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) == DOTA_DAMAGE_FLAG_HPLOSS then return end

	local caster = self:GetCaster()
	if not caster or caster:IsNull() then return end
	local aura = caster:FindModifierByName("modifier_visage_gravekeepers_cloak_lua")
	if not aura or aura:IsNull() then return end

	-- still implement the cap unlike vanilla
	return - (math.min(self.max_damage_reduction, self.damage_reduction * aura:GetStackCount()))
end

modifier_visage_summon_familiars_stone_form_buff_custom = class({})

function modifier_visage_summon_familiars_stone_form_buff_custom:IsPurgable() return false end

function modifier_visage_summon_familiars_stone_form_buff_custom:OnCreated()
	self.regen = (self:GetParent():GetMaxHealth() / 100 * 35) / 6
end

function modifier_visage_summon_familiars_stone_form_buff_custom:OnDestroy()
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_visage/visage_familiar_transform.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
end

function modifier_visage_summon_familiars_stone_form_buff_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}
end

function modifier_visage_summon_familiars_stone_form_buff_custom:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}
end

function modifier_visage_summon_familiars_stone_form_buff_custom:GetModifierConstantHealthRegen()
	return self.regen
end

function modifier_visage_summon_familiars_stone_form_buff_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_earth_spirit_petrify.vpcf"
end

function modifier_visage_summon_familiars_stone_form_buff_custom:StatusEffectPriority()
	return 10
end