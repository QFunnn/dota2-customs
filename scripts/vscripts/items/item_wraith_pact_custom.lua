--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_wraith_pact_custom", "items/item_wraith_pact_custom.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_wraith_pact_custom_aura", "items/item_wraith_pact_custom.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_wraith_pact_custom_totem", "items/item_wraith_pact_custom.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_wraith_pact_custom_debuff", "items/item_wraith_pact_custom.lua", LUA_MODIFIER_MOTION_NONE )

if item_wraith_pact_custom == nil then
	item_wraith_pact_custom = class({})
end

function item_wraith_pact_custom:GetIntrinsicModifierName()
	return "modifier_item_wraith_pact_custom"
end

function item_wraith_pact_custom:OnSpellStart()
	local caster = self:GetCaster()
	if not caster:IsHero() then return end

	local point = self:GetCursorPosition()

	if point == nil then point = caster:GetAbsOrigin() end

	local Duration = self:GetDuration()

	local hTotem = CreateUnitByName("npc_dota_item_wraith_pact_totem", point, true, caster, caster, caster:GetTeamNumber())
	hTotem:SetControllableByPlayer(caster:GetPlayerID(), true)
	hTotem:AddNewModifier(caster, self, "modifier_kill", {duration=Duration})
	hTotem:AddNewModifier(caster, self, "modifier_item_wraith_pact_custom_totem", {duration=Duration})
end

modifier_item_wraith_pact_custom = class({
	IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
	GetAttributes			= function(self) return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_HEALTH_BONUS,
			MODIFIER_PROPERTY_MANA_BONUS,
		}
	end,

	GetModifierHealthBonus	= function(self) return self.BonusHealth or 0 end,
	GetModifierManaBonus	= function(self) return self.BonusMana or 0 end,

	IsAura					= function(self) return true end,
	GetModifierAura			= function(self) return "modifier_item_wraith_pact_custom_aura" end,
	GetAuraDuration			= function(self) return 0.5 end,
	GetAuraRadius			= function(self) return self.Radius or 0 end,
	GetAuraSearchFlags		= function(self) return DOTA_UNIT_TARGET_FLAG_NONE end,
	GetAuraSearchTeam		= function(self) return DOTA_UNIT_TARGET_TEAM_FRIENDLY end,
	GetAuraSearchType		= function(self) return DOTA_UNIT_TARGET_HEROES_AND_CREEPS end,

	GetAuraEntityReject		= function(self, target)
		if target:HasModifier("modifier_item_vladmir_aura") or target:HasModifier("modifier_item_wraith_dominator_aura_buff") then
			return true
		else
			return false
		end
	end,

	OnCreated				= function(self)
		local ability = self:GetAbility()
		if ability then
			self.BonusHealth = ability:GetSpecialValueFor("bonus_health")
			self.BonusMana = ability:GetSpecialValueFor("bonus_mana")
			self.Radius = ability:GetSpecialValueFor("aura_radius")
		end
	end,
})

modifier_item_wraith_pact_custom_aura = class({
	IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
			MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
			MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		}
	end,

	GetModifierConstantManaRegen = function(self) return self.BonusManaRegen or 0 end,
	GetModifierBaseDamageOutgoing_Percentage = function(self) return self.BonusDamagePct or 0 end,
	GetModifierPhysicalArmorBonus = function(self) return self.BonusArmor or 0 end,

	OnCreated				= function(self)
		local ability = self:GetAbility()
		if ability then
			self.BonusArmor = ability:GetSpecialValueFor("armor_aura")
			self.BonusManaRegen = ability:GetSpecialValueFor("mana_regen_aura")
			self.BonusDamagePct = ability:GetSpecialValueFor("damage_aura")

			self.LifestealPct = ability:GetSpecialValueFor("lifesteal_aura")
		end
	end,

	AttackLandedModifier	= function(self, event)
		if not IsServer() then return end

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
		if event.attacker == self:GetParent() then
			if event.damage <= 0 then return end
			if no_heal_target[event.target:GetUnitName()] then return end
			local lifesteal = self.LifestealPct / 100
			self:GetParent():Heal(event.damage * lifesteal, nil)
		end
	end,
})

modifier_item_wraith_pact_custom_totem = class({
	IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

	DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_HEALTHBAR_PIPS,
            MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
            MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
            MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE
        }
    end,

	GetAbsoluteNoDamageMagical  = function(self) return 1 end,
    GetAbsoluteNoDamagePhysical  = function(self) return 1 end,
    GetAbsoluteNoDamagePure  = function(self) return 1 end,

	GetModifierHealthBarPips = function(self)
		return self.AttacksToDestroy
	end,

	IsAura					= function(self) return true end,
	GetModifierAura			= function(self) return "modifier_item_wraith_pact_custom_debuff" end,
	GetAuraDuration			= function(self) return 0.5 end,
	GetAuraRadius			= function(self) return self.Radius or 0 end,
	GetAuraSearchFlags		= function(self) return DOTA_UNIT_TARGET_FLAG_NONE end,
	GetAuraSearchTeam		= function(self) return DOTA_UNIT_TARGET_TEAM_ENEMY end,
	GetAuraSearchType		= function(self) return DOTA_UNIT_TARGET_HEROES_AND_CREEPS end,

	OnCreated				= function(self)
		local ability = self:GetAbility()
		if ability then
			self.AttacksToDestroy = ability:GetSpecialValueFor("attacks")
			self.Radius = ability:GetSpecialValueFor("pact_aura_radius")
			self.Damage = self:GetAbility():GetSpecialValueFor("aura_dps")
		end

		if not IsServer() then return end
		
		self:StartIntervalThink(1)
	end,

	OnIntervalThink			= function(self)
		if not IsServer() then return end

		local particle = ParticleManager:CreateParticle("particles/items5_fx/wraith_pact_pulses.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 1, Vector(self.Radius,0,0))
		ParticleManager:ReleaseParticleIndex(particle)
		self:GetParent():EmitSound("Item.WraithTotem.Pulse")

		local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.Radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HEROES_AND_CREEPS, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false )
		for _, enemy in pairs(enemies) do
			if not enemy:HasModifier("modifier_oracle_false_promise_custom") then

				local fx = ParticleManager:CreateParticle("particles/items5_fx/wraith_pact_pulses_target.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, enemy)
				ParticleManager:SetParticleControlEnt(fx, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
				ParticleManager:SetParticleControlEnt(fx, 1, enemy, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
				ParticleManager:ReleaseParticleIndex(fx)

				ApplyDamage({victim = enemy, attacker = self:GetCaster(), ability = self:GetAbility(), damage = self.Damage, damage_type = DAMAGE_TYPE_MAGICAL })
			end
		end
	end,

	AttackLandedModifier	= function(self, event)
		if not IsServer() then return end

		local parent = self:GetParent()
		local target = event.target
		local attacker = event.attacker

		if target == parent and attacker then
			local damage = parent:GetMaxHealth() / self.AttacksToDestroy
			if not attacker:IsRealHero() then
				damage = damage / 2
			end

			local newHealth = parent:GetHealth() - damage
			if newHealth > 0 then
				parent:ModifyHealth(newHealth, self:GetAbility(), false, 0)
			else
				parent:Kill(nil, attacker)
			end
		end
	end,
})

modifier_item_wraith_pact_custom_debuff = class({
	IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return true end,

	DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
        }
    end,

	GetModifierTotalDamageOutgoing_Percentage  = function(self) return -self.DamagePenalty or 0 end,

	OnCreated				= function(self)
		local ability = self:GetAbility()
		if ability then
			self.DamagePenalty = ability:GetSpecialValueFor("damage_penalty_aura")
		end
	end,
})