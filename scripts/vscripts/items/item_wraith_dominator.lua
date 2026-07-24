--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_wraith_dominator = class({})

LinkLuaModifier("modifier_item_wraith_dominator", "items/item_wraith_dominator", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_summon_flying_movement_aura", "modifiers/modifier_summon_flying_movement_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_wraith_dominator_aura_buff", "items/item_wraith_dominator", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_wraith_dominator_active", "items/item_wraith_dominator", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_wraith_dominator_active_damage", "items/item_wraith_dominator", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_wraith_dominator_active_buff", "items/item_wraith_dominator", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_wraith_dominator_active_debuff", "items/item_wraith_dominator", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_summoner_crown_buff_agi", "items/item_summoner_crown", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_summoner_crown_buff_int", "items/item_summoner_crown", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_summoner_crown_model_size", "items/item_summoner_crown", LUA_MODIFIER_MOTION_NONE)

function item_wraith_dominator:GetIntrinsicModifierName()
	return "modifier_item_wraith_dominator"
end

function item_wraith_dominator:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():EmitSound("Item.WraithTotem.Cast")
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_wraith_dominator_active", {duration = duration})
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_wraith_dominator_active_damage", {duration = duration})
end

modifier_item_wraith_dominator = class({})

function modifier_item_wraith_dominator:IsDebuff() return false end
function modifier_item_wraith_dominator:IsHidden() return true end
function modifier_item_wraith_dominator:IsPurgable() return false end
function modifier_item_wraith_dominator:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_item_wraith_dominator:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
	}
	return funcs
end

function modifier_item_wraith_dominator:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_wraith_dominator:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_wraith_dominator:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_wraith_dominator:GetModifierHealthBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end

function modifier_item_wraith_dominator:GetModifierManaBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_mana")
end

function modifier_item_wraith_dominator:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(0.5)
	self:UpdateFlyingAura()
end

function modifier_item_wraith_dominator:OnIntervalThink()
	self:UpdateFlyingAura()
end

function modifier_item_wraith_dominator:UpdateFlyingAura()
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then return end
	local is_active = not ability:IsInBackpack()
	if is_active and not parent:HasModifier("modifier_summon_flying_movement_aura") then
		parent:AddNewModifier(parent, ability, "modifier_summon_flying_movement_aura", {})
	elseif not is_active and not self:HasOtherFlyingAuraSource(parent) then
		if parent:HasModifier("modifier_summon_flying_movement_aura") then
			parent:RemoveModifierByName("modifier_summon_flying_movement_aura")
		end
	end
end

function modifier_item_wraith_dominator:HasOtherFlyingAuraSource(parent)
	for i = 0, parent:GetNumItemsInInventory() - 1 do
		local item = parent:GetItemInSlot(i)
		if item and item ~= self:GetAbility() and not item:IsInBackpack() then
			local name = item:GetAbilityName()
			if name == "item_summoner_crown_2" or name == "item_summoner_crown_3" or name == "item_wraith_dominator" then
				return true
			end
		end
	end
	return false
end

function modifier_item_wraith_dominator:OnDestroy()
	if not IsServer() then return end
	local parent = self:GetParent()
	if parent and not parent:IsNull() and parent:HasModifier("modifier_summon_flying_movement_aura") then
		if not self:HasOtherFlyingAuraSource(parent) then
			parent:RemoveModifierByName("modifier_summon_flying_movement_aura")
		end
	end
end

function modifier_item_wraith_dominator:IsAura()
	return true
end

function modifier_item_wraith_dominator:GetModifierAura()
	return "modifier_item_wraith_dominator_aura_buff"
end

function modifier_item_wraith_dominator:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_wraith_dominator:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_item_wraith_dominator:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("aura_radius")
end

function modifier_item_wraith_dominator:GetAuraDuration()
	return 0.5
end

function modifier_item_wraith_dominator:GetAuraEntityReject(target)
    -- A6: варды — не армейские призывы, дружественная аура их не баффает (по имени, IsWard() для них = false)
    if IsWardUnit(target) then return true end
    if target:HasModifier("modifier_item_vladmir_aura") then
        return true
    else
        return false
    end
end

modifier_item_wraith_dominator_aura_buff = class({})

function modifier_item_wraith_dominator_aura_buff:IsHidden() return false end
function modifier_item_wraith_dominator_aura_buff:IsPurgable() return false end

function modifier_item_wraith_dominator_aura_buff:OnCreated()
	self.armor_aura = self:GetAbility():GetSpecialValueFor("armor_aura")
	self.mana_regen_aura = self:GetAbility():GetSpecialValueFor("mana_regen_aura")
	self.lifesteal_aura = self:GetAbility():GetSpecialValueFor("lifesteal_aura")
	self.damage_aura = self:GetAbility():GetSpecialValueFor("damage_aura")
end

function modifier_item_wraith_dominator_aura_buff:OnRefresh()
	self.armor_aura = self:GetAbility():GetSpecialValueFor("armor_aura")
	self.mana_regen_aura = self:GetAbility():GetSpecialValueFor("mana_regen_aura")
	self.lifesteal_aura = self:GetAbility():GetSpecialValueFor("lifesteal_aura")
	self.damage_aura = self:GetAbility():GetSpecialValueFor("damage_aura")
end

function modifier_item_wraith_dominator_aura_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, 
	}
end

function modifier_item_wraith_dominator_aura_buff:GetModifierConstantManaRegen()
	return self.mana_regen_aura
end

function modifier_item_wraith_dominator_aura_buff:GetModifierBaseDamageOutgoing_Percentage()
	return self.damage_aura
end

function modifier_item_wraith_dominator_aura_buff:GetModifierPhysicalArmorBonus()
	return self.armor_aura
end

function modifier_item_wraith_dominator_aura_buff:AttackLandedModifier(params)
	if IsServer() then
		local no_heal_target = 
        {
			["npc_dota_phoenix_sun"] = true,
			["npc_dota_grimstroke_ink_creature"] = true,
			["npc_dota_juggernaut_healing_ward"] = true,
			["npc_dota_healing_campfire"] = true,
			["npc_dota_pugna_nether_ward_1"] = true,
			["npc_dota_item_wraith_pact_totem"] = true,
			["npc_dota_pugna_nether_ward_2"] = true,
			["npc_dota_pugna_nether_ward_3"] = true,
			["npc_dota_pugna_nether_ward_4"] = true,
			["npc_dota_templar_assassin_psionic_trap"] = true,
			["npc_dota_weaver_swarm"] = true,
			["npc_dota_venomancer_plague_ward_1"] = true,
			["npc_dota_venomancer_plague_ward_2"] = true,
			["npc_dota_venomancer_plague_ward_3"] = true,
			["npc_dota_venomancer_plague_ward_4"] = true,
			["npc_dota_shadow_shaman_ward_1"] = true,
			["npc_dota_shadow_shaman_ward_2"] = true,
			["npc_dota_shadow_shaman_ward_3"] = true,
			["npc_dota_unit_tombstone1"] = true,
			["npc_dota_unit_tombstone2"] = true,
			["npc_dota_unit_tombstone3"] = true,
			["npc_dota_unit_tombstone4"] = true,
			["npc_dota_unit_undying_zombie"] = true,
			["npc_dota_unit_undying_zombie_torso"] = true,
			["npc_dota_clinkz_skeleton_archer"] = true,
			["npc_dota_techies_land_mine"] = true,
			["npc_dota_zeus_cloud"] = true,
			["npc_dota_rattletrap_cog"] = true,
		}
		if params.attacker == self:GetParent() then
			if params.damage <= 0 then return end
			if no_heal_target[params.target:GetUnitName()] then return end
			local lifesteal = self:GetAbility():GetSpecialValueFor("lifesteal_aura") / 100
			self:GetParent():Heal(params.damage * lifesteal, nil)
		end
	end
end

modifier_item_wraith_dominator_active = class({})

function modifier_item_wraith_dominator_active:IsPurgable() return false end
function modifier_item_wraith_dominator_active:IsHidden() return false end
function modifier_item_wraith_dominator_active:OnCreated()
	self.radius = self:GetAbility():GetSpecialValueFor("pact_aura_radius")
	self.damage = self:GetAbility():GetSpecialValueFor("aura_dps")
	if not IsServer() then return end
	
	self:StartIntervalThink(1)
end

function modifier_item_wraith_dominator_active:OnIntervalThink()
	if not IsServer() then return end

	local particle = ParticleManager:CreateParticle("particles/items5_fx/wraith_pact_pulses.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(self.radius,0,0))
    ParticleManager:ReleaseParticleIndex(particle)
	self:GetParent():EmitSound("Item.WraithTotem.Pulse")

	local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false )
	for _, enemy in pairs(enemies) do
        if not enemy:HasModifier("modifier_oracle_false_promise_custom") then

			local fx = ParticleManager:CreateParticle("particles/items5_fx/wraith_pact_pulses_target.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, enemy)
			ParticleManager:SetParticleControlEnt(fx, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
			ParticleManager:SetParticleControlEnt(fx, 1, enemy, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
			ParticleManager:ReleaseParticleIndex(fx)

		    ApplyDamage({victim = enemy, attacker = self:GetCaster(), ability = self:GetAbility(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL })
        end
	end
end

function modifier_item_wraith_dominator_active:IsAura()
	return true
end

function modifier_item_wraith_dominator_active:GetModifierAura()
	return "modifier_item_wraith_dominator_active_debuff"
end

function modifier_item_wraith_dominator_active:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_item_wraith_dominator_active:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_item_wraith_dominator_active:GetAuraRadius()
	return self.radius
end

function modifier_item_wraith_dominator_active:GetAuraDuration()
	return 0.5
end

function modifier_item_wraith_dominator_active:GetAuraEntityReject(target)
    if target:HasModifier("modifier_item_wraith_pact_custom_debuff") then
        return true
    else
        return false
    end
end

modifier_item_wraith_dominator_active_debuff = class({})
function modifier_item_wraith_dominator_active_debuff:IsHidden() return false end
function modifier_item_wraith_dominator_active_debuff:IsPurgable() return false end

function modifier_item_wraith_dominator_active_debuff:OnCreated()
	self.damage_reduce = self:GetAbility():GetSpecialValueFor("damage_penalty_aura")
end

function modifier_item_wraith_dominator_active_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	}
	return funcs
end

function modifier_item_wraith_dominator_active_debuff:GetModifierTotalDamageOutgoing_Percentage()
	return self.damage_reduce
end

modifier_item_wraith_dominator_active_damage = class({})
function modifier_item_wraith_dominator_active_damage:IsHidden() return true end
function modifier_item_wraith_dominator_active_damage:IsPurgable() return false end

function modifier_item_wraith_dominator_active_damage:OnCreated()
	self.radius = self:GetAbility():GetSpecialValueFor("pact_aura_radius")
	self.damage = self:GetAbility():GetSpecialValueFor("bonus_damage_aura_active")
	if not IsServer() then return end
end

function modifier_item_wraith_dominator_active_damage:IsAura()
	return true
end

function modifier_item_wraith_dominator_active_damage:GetModifierAura()
	return "modifier_item_wraith_dominator_active_buff"
end

function modifier_item_wraith_dominator_active_damage:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_wraith_dominator_active_damage:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_item_wraith_dominator_active_damage:GetAuraRadius()
	return self.radius
end

function modifier_item_wraith_dominator_active_damage:GetAuraDuration()
	return 0.5
end

function modifier_item_wraith_dominator_active_damage:GetAuraEntityReject(target)
	-- A6: варды — не армейские призывы, дружественную damage-ауру не получают (по имени)
	if IsWardUnit(target) then return true end
	return false
end

modifier_item_wraith_dominator_active_buff = class({})
function modifier_item_wraith_dominator_active_buff:IsHidden() return false end
function modifier_item_wraith_dominator_active_buff:OnCreated()
	self.bonus_damage_aura_active = self:GetAbility():GetSpecialValueFor("bonus_damage_aura_active")
end

function modifier_item_wraith_dominator_active_buff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
	}
end

function modifier_item_wraith_dominator_active_buff:GetModifierDamageOutgoing_Percentage()
	return self.bonus_damage_aura_active
end