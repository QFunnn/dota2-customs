--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_aeon_boots", "items/item_aeon_boots", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_aeon_boots_buff", "items/item_aeon_boots", LUA_MODIFIER_MOTION_NONE)

item_aeon_boots = class({})

function item_aeon_boots:GetIntrinsicModifierName()
	return "modifier_item_aeon_boots"
end

function item_aeon_boots:OnSpellStart()
	if not IsServer() then return end
	local buff_duration = self:GetSpecialValueFor("buff_duration")
	self:GetParent():EmitSound("DOTA_Item.ComboBreaker")
	self:GetParent():Purge( false, true, false, true, true )
	self:GetParent():AddNewModifier(self:GetParent(), self, "modifier_item_aeon_boots_buff", {duration = buff_duration})
end

modifier_item_aeon_boots = class({})

function modifier_item_aeon_boots:IsHidden() return true end
function modifier_item_aeon_boots:IsPurgable() return false end
function modifier_item_aeon_boots:IsPurgeException() return false end
function modifier_item_aeon_boots:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_aeon_boots:OnCreated()
    self.health_threshold_pct = self:GetAbility():GetSpecialValueFor("health_threshold_pct")
    if not IsServer() then return end
end

function modifier_item_aeon_boots:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_MIN_HEALTH,
	}
end

function modifier_item_aeon_boots:GetModifierMoveSpeedBonus_Special_Boots()
	return self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
end

function modifier_item_aeon_boots:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_item_aeon_boots:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_aeon_boots:GetModifierHealthBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end

function modifier_item_aeon_boots:GetModifierManaBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_mana")
end

function modifier_item_aeon_boots:OnTakeDamage(params)
	if not IsServer() then return end
	if not self:GetParent():IsRealHero() then return end
	if not self:GetParent():IsAlive() then return end
	if self:GetParent() ~= params.unit then return end
    if GetMapName() ~= "arena" then
        if params.attacker then
	        if self:GetParent() == params.attacker then return end
        end
    end
	if self:GetParent():GetHealthPercent() > self.health_threshold_pct then return end
	if not self:GetAbility():IsCooldownReady() then return end
    if self:GetParent():HasModifier("modifier_phoenix_supernova_custom_death") then return end
	if self:GetParent():HasModifier("modifier_item_aeon_boots_buff") then return end
	local health_threshold_pct = self.health_threshold_pct / 100
	local buff_duration	= self:GetAbility():GetSpecialValueFor("buff_duration")
	self:GetAbility():UseResources(false, false, false, true)
	self:GetParent():Purge( false, true, false, true, true )
	self:GetParent():EmitSound("DOTA_Item.ComboBreaker")
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_aeon_boots_buff", {duration = buff_duration})
    local min_health = self:GetParent():GetMaxHealth() / 100 * self.health_threshold_pct
    self:GetParent():SetHealth(math.max(1, math.min(params.cost, min_health)))
end

function modifier_item_aeon_boots:GetMinHealth()
	if not IsServer() then return end
	if not self:GetParent():IsRealHero() then return end
	if not self:GetParent():IsAlive() then return end
	if not self:GetAbility():IsCooldownReady() then return end
	if self:GetParent():HasModifier("modifier_item_aeon_boots_buff") then return end
    if self:GetParent():HasModifier("modifier_phoenix_supernova_custom_death") then return end
	return 1
end

function modifier_item_aeon_boots:CheckState()
	return 
    {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true
	}
end

modifier_item_aeon_boots_buff = class({})

function modifier_item_aeon_boots_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	}
end

function modifier_item_aeon_boots_buff:OnCreated(kv)
	if IsServer() then
        if not self:GetAbility() then self:Destroy() end
    end

	self.status_resistance	= self:GetAbility():GetSpecialValueFor("status_resistance")

	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle("particles/items4_fx/combo_breaker_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(particle, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
	self:AddParticle(particle, false, false, -1, true, false)
end

function modifier_item_aeon_boots_buff:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_item_aeon_boots_buff:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_item_aeon_boots_buff:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_item_aeon_boots_buff:GetModifierTotalDamageOutgoing_Percentage()
	return -100
end

function modifier_item_aeon_boots_buff:GetModifierStatusResistanceStacking()
	return self.status_resistance
end