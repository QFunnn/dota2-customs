--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_health_radiance", "items/radiance_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_health_radiance_aura", "items/radiance_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_health_radiance_burn", "items/radiance_custom", LUA_MODIFIER_MOTION_NONE )

item_health_radiance = class({})

function item_health_radiance:GetIntrinsicModifierName()
	return "modifier_item_health_radiance" 
end

function item_health_radiance:OnSpellStart()
	if IsServer() then
		if self:GetCaster():HasModifier("modifier_item_health_radiance_aura") then
			self:GetCaster():RemoveModifierByName("modifier_item_health_radiance_aura")
		else
			self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_health_radiance_aura", {})
		end
	end
end

function item_health_radiance:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_item_health_radiance_aura") then
		return "item_health_radiance"
	else
		return "health_radiance_1"
	end
end

modifier_item_health_radiance = class({})

function modifier_item_health_radiance:IsHidden() return true end
function modifier_item_health_radiance:IsPurgable() return false end
function modifier_item_health_radiance:IsPurgeException() return false end

function modifier_item_health_radiance:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_health_radiance:OnCreated(keys)
	if not IsServer() then return end
	if not self:GetParent():HasModifier("modifier_item_health_radiance_aura") then
		self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_health_radiance_aura", {})
	end
    if self:GetParent():IsIllusion() then
        Timers:CreateTimer(FrameTime(), function()
            local modifier_illusion = self:GetParent():FindModifierByName("modifier_illusion")
            if modifier_illusion then
                local caster = modifier_illusion:GetCaster()
                if not caster:HasModifier("modifier_item_health_radiance_aura") then
                    self:GetParent():RemoveModifierByName("modifier_item_health_radiance_aura")
                end
            end
        end)
    end
end

function modifier_item_health_radiance:OnDestroy(keys)
	if not IsServer() then return end
	self:GetParent():RemoveModifierByName("modifier_item_health_radiance_aura")
end

function modifier_item_health_radiance:DeclareFunctions()
	return 
	{ 
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_HEALTH_BONUS
	}
end

function modifier_item_health_radiance:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_health_radiance:GetModifierHealthBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end

modifier_item_health_radiance_aura = class({})

function modifier_item_health_radiance_aura:IsAura() return true end
function modifier_item_health_radiance_aura:IsHidden() return true end
function modifier_item_health_radiance_aura:IsDebuff() return false end
function modifier_item_health_radiance_aura:IsPurgable() return false end

function modifier_item_health_radiance_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY 
end

function modifier_item_health_radiance_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end

function modifier_item_health_radiance_aura:GetModifierAura()
	return "modifier_item_health_radiance_burn"
end

function modifier_item_health_radiance_aura:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("aura_radius")
end

function modifier_item_health_radiance_aura:GetAuraDuration()
	return 0
end

function modifier_item_health_radiance_aura:OnCreated()
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle("particles/items2_fx/radiance_owner.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	self:AddParticle(particle, false, false, -1, false, false)
end

modifier_item_health_radiance_burn = class({})

function modifier_item_health_radiance_burn:IsDebuff() return true end
function modifier_item_health_radiance_burn:IsPurgable() return false end
function modifier_item_health_radiance_burn:GetTexture() return "item_health_radiance" end

function modifier_item_health_radiance_burn:OnCreated()
	if not IsServer() then return end
    self.damage = self:GetAbility():GetSpecialValueFor("damage")
    self.base_damage = self:GetAbility():GetSpecialValueFor("base_damage")
	self.particle = ParticleManager:CreateParticle("particles/items2_fx/radiance.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	if self.particle then
		ParticleManager:SetParticleControl(self.particle, 1, self:GetCaster():GetAbsOrigin())
		self:AddParticle(self.particle, false, false, -1, false, false)
	end
	EmitSoundOnEntityForPlayer("DOTA_Item.Radiance.Target.Loop", self:GetParent(), self:GetParent():GetPlayerOwnerID())
	self:StartIntervalThink(1)
end

function modifier_item_health_radiance_burn:OnIntervalThink()
	if not IsServer() then return end
	local damage = self.damage
	local end_damage = (self:GetCaster():GetMaxHealth() / 100 * damage) + self.base_damage
	ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), ability = self:GetAbility(), damage = end_damage, damage_type = DAMAGE_TYPE_MAGICAL})
	if self.particle then
		ParticleManager:SetParticleControl(self.particle, 1, self:GetCaster():GetAbsOrigin())
	end
end

-- Мана радик

LinkLuaModifier( "modifier_item_mana_radiance", "items/radiance_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_mana_radiance_aura", "items/radiance_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_mana_radiance_burn", "items/radiance_custom", LUA_MODIFIER_MOTION_NONE )

item_mana_radiance = class({})

function item_mana_radiance:GetIntrinsicModifierName()
	return "modifier_item_mana_radiance" 
end

function item_mana_radiance:OnSpellStart()
	if IsServer() then
		if self:GetCaster():HasModifier("modifier_item_mana_radiance_aura") then
			self:GetCaster():RemoveModifierByName("modifier_item_mana_radiance_aura")
		else
			self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_mana_radiance_aura", {})
		end
	end
end

function item_mana_radiance:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_item_mana_radiance_aura") then
		return "item_mana_radiance"
	else
		return "mana_radiance_1"
	end
end

modifier_item_mana_radiance = class({})

function modifier_item_mana_radiance:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_mana_radiance:IsHidden() return true end
function modifier_item_mana_radiance:IsPurgable() return false end
function modifier_item_mana_radiance:IsPurgeException() return false end

function modifier_item_mana_radiance:OnCreated(keys)
	if not IsServer() then return end
	if not self:GetParent():HasModifier("modifier_item_mana_radiance_aura") then
		self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_mana_radiance_aura", {})
	end
    Timers:CreateTimer(FrameTime(), function()
        if self:GetParent():IsIllusion() then
            local modifier_illusion = self:GetParent():FindModifierByName("modifier_illusion")
            if modifier_illusion then
                local caster = modifier_illusion:GetCaster()
                if not caster:HasModifier("modifier_item_mana_radiance_aura") then
                    self:GetParent():RemoveModifierByName("modifier_item_mana_radiance_aura")
                end
            end
        end
    end)
end

function modifier_item_mana_radiance:OnDestroy(keys)
	if not IsServer() then return end
	self:GetParent():RemoveModifierByName("modifier_item_mana_radiance_aura")
end

function modifier_item_mana_radiance:DeclareFunctions()
	return 
	{ 
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_MANA_BONUS
	}
end

function modifier_item_mana_radiance:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_mana_radiance:GetModifierManaBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_mana")
end

modifier_item_mana_radiance_aura = class({})

function modifier_item_mana_radiance_aura:IsAura() return true end
function modifier_item_mana_radiance_aura:IsHidden() return true end
function modifier_item_mana_radiance_aura:IsDebuff() return false end
function modifier_item_mana_radiance_aura:IsPurgable() return false end

function modifier_item_mana_radiance_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY 
end

function modifier_item_mana_radiance_aura:GetAuraDuration()
	return 0
end

function modifier_item_mana_radiance_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end

function modifier_item_mana_radiance_aura:GetModifierAura()
	return "modifier_item_mana_radiance_burn"
end

function modifier_item_mana_radiance_aura:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("aura_radius")
end

function modifier_item_mana_radiance_aura:OnCreated()
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle("particles/items2_fx/radiance_owner.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	self:AddParticle(particle, false, false, -1, false, false)
end

modifier_item_mana_radiance_burn = class({})

function modifier_item_mana_radiance_burn:IsDebuff() return true end
function modifier_item_mana_radiance_burn:IsPurgable() return false end
function modifier_item_mana_radiance_burn:GetTexture() return "item_mana_radiance" end

function modifier_item_mana_radiance_burn:OnCreated()
	if not IsServer() then return end
    self.damage = self:GetAbility():GetSpecialValueFor("damage")
    self.base_damage = self:GetAbility():GetSpecialValueFor("base_damage")
	self.particle = ParticleManager:CreateParticle("particles/items2_fx/radiance.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	if self.particle then
		ParticleManager:SetParticleControl(self.particle, 1, self:GetCaster():GetAbsOrigin())
		self:AddParticle(self.particle, false, false, -1, false, false)
	end
	EmitSoundOnEntityForPlayer("DOTA_Item.Radiance.Target.Loop", self:GetParent(), self:GetParent():GetPlayerOwnerID())
	self:StartIntervalThink(1)
end

function modifier_item_mana_radiance_burn:OnIntervalThink()
	if not IsServer() then return end
    print(self:GetCaster():IsNull())
	local damage = self.damage
	local end_damage = (self:GetCaster():GetMaxMana() / 100 * damage) + self.base_damage
	ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), ability = self:GetAbility(), damage = end_damage, damage_type = DAMAGE_TYPE_MAGICAL})
	if self.particle then
		ParticleManager:SetParticleControl(self.particle, 1, self:GetCaster():GetAbsOrigin())
	end
end

-- Обычный радик


LinkLuaModifier( "modifier_item_radiance_custom", "items/radiance_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_radiance_custom_aura", "items/radiance_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_radiance_custom_burn", "items/radiance_custom", LUA_MODIFIER_MOTION_NONE )

item_radiance_custom = class({})

function item_radiance_custom:GetIntrinsicModifierName()
	return "modifier_item_radiance_custom" 
end

function item_radiance_custom:OnSpellStart()
	if IsServer() then
		if self:GetCaster():HasModifier("modifier_item_radiance_custom_aura") then
			self:GetCaster():RemoveModifierByName("modifier_item_radiance_custom_aura")
		else
			self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_radiance_custom_aura", {})
		end
	end
end

function item_radiance_custom:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_item_radiance_custom_aura") then
		return "item_radiance"
	else
		return "item_radiance_inactive"
	end
end

modifier_item_radiance_custom = class({})

function modifier_item_radiance_custom:IsHidden() return true end
function modifier_item_radiance_custom:IsPurgable() return false end
function modifier_item_radiance_custom:IsPurgeException() return false end

function modifier_item_radiance_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_radiance_custom:OnCreated(keys)
	if not IsServer() then return end
	if not self:GetParent():HasModifier("modifier_item_radiance_custom_aura") then
		self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_radiance_custom_aura", {})
	end
    Timers:CreateTimer(FrameTime(), function()
        if self:GetParent():IsIllusion() then
            local modifier_illusion = self:GetParent():FindModifierByName("modifier_illusion")
            if modifier_illusion then
                local caster = modifier_illusion:GetCaster()
                if not caster:HasModifier("modifier_item_radiance_custom_aura") then
                    self:GetParent():RemoveModifierByName("modifier_item_radiance_custom_aura")
                end
            end
        end
    end)
end

function modifier_item_radiance_custom:OnDestroy(keys)
	if not IsServer() then return end
	self:GetParent():RemoveModifierByName("modifier_item_radiance_custom_aura")
end

function modifier_item_radiance_custom:DeclareFunctions()
	return 
	{ 
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_EVASION_CONSTANT
	}
end

function modifier_item_radiance_custom:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_radiance_custom:GetModifierEvasion_Constant()
	return self:GetAbility():GetSpecialValueFor("evasion")
end

modifier_item_radiance_custom_aura = class({})

function modifier_item_radiance_custom_aura:IsAura() return true end
function modifier_item_radiance_custom_aura:IsHidden() return true end
function modifier_item_radiance_custom_aura:IsDebuff() return false end
function modifier_item_radiance_custom_aura:IsPurgable() return false end

function modifier_item_radiance_custom_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY 
end

function modifier_item_radiance_custom_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end

function modifier_item_radiance_custom_aura:GetModifierAura()
	return "modifier_item_radiance_custom_burn"
end

function modifier_item_radiance_custom_aura:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("aura_radius")
end

function modifier_item_radiance_custom_aura:GetAuraDuration()
	return 0
end

function modifier_item_radiance_custom_aura:OnCreated()
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle("particles/items2_fx/radiance_owner.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	self:AddParticle(particle, false, false, -1, false, false)
end

modifier_item_radiance_custom_burn = class({})

function modifier_item_radiance_custom_burn:IsDebuff() return true end
function modifier_item_radiance_custom_burn:IsPurgable() return false end
function modifier_item_radiance_custom_burn:GetTexture() return "item_radiance" end

function modifier_item_radiance_custom_burn:OnCreated()
	if not IsServer() then return end
    self.damage_per_evasion = self:GetAbility():GetSpecialValueFor("damage_per_evasion")
    self.base_damage = self:GetAbility():GetSpecialValueFor("base_damage")
	self.particle = ParticleManager:CreateParticle("particles/items2_fx/radiance.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	if self.particle then
		ParticleManager:SetParticleControl(self.particle, 1, self:GetCaster():GetAbsOrigin())
		self:AddParticle(self.particle, false, false, -1, false, false)
	end
	EmitSoundOnEntityForPlayer("DOTA_Item.Radiance.Target.Loop", self:GetParent(), self:GetParent():GetPlayerOwnerID())
	self:StartIntervalThink(1)
end

function modifier_item_radiance_custom_burn:OnIntervalThink()
	if not IsServer() then return end
	local damage_per_evasion = self.damage_per_evasion
    local evasion = self:GetCaster():GetEvasion()
    if self:GetCaster():HasModifier("modifier_windrunner_windrun_custom") then
        evasion = evasion / 2
    end
	local end_damage = (evasion * 100 * damage_per_evasion) + self.base_damage
	ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), ability = self:GetAbility(), damage = end_damage, damage_type = DAMAGE_TYPE_MAGICAL})
	if self.particle then
		ParticleManager:SetParticleControl(self.particle, 1, self:GetCaster():GetAbsOrigin())
	end
end

function modifier_item_radiance_custom_burn:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MISS_PERCENTAGE
	}
end

function modifier_item_radiance_custom_burn:GetModifierMiss_Percentage()
	return self:GetAbility():GetSpecialValueFor("blind_pct")
end