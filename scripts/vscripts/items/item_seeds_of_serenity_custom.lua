--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_seeds_of_serenity_custom", "items/item_seeds_of_serenity_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_seeds_of_serenity_custom_thinker", "items/item_seeds_of_serenity_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_seeds_of_serenity_custom_buff", "items/item_seeds_of_serenity_custom", LUA_MODIFIER_MOTION_NONE)

item_seeds_of_serenity_custom = class({})

function item_seeds_of_serenity_custom:GetIntrinsicModifierName()
	return "modifier_item_seeds_of_serenity_custom"
end

function item_seeds_of_serenity_custom:OnSpellStart()
	if not IsServer() then return end
	local point = self:GetCursorPosition()
	EmitSoundOnLocationWithCaster(point, "Item.SeedsOfSerenity", self:GetCaster())
	CreateModifierThinker(self:GetCaster(), self, "modifier_item_seeds_of_serenity_custom_thinker", {duration = self:GetSpecialValueFor("duration")}, point, self:GetCaster():GetTeamNumber(), false)
end

function item_seeds_of_serenity_custom:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

modifier_item_seeds_of_serenity_custom = class({})

function modifier_item_seeds_of_serenity_custom:IsHidden() return true end
function modifier_item_seeds_of_serenity_custom:IsPurgable() return false end
function modifier_item_seeds_of_serenity_custom:IsPurgeException() return false end
function modifier_item_seeds_of_serenity_custom:RemoveOnDeath() return false end

function modifier_item_seeds_of_serenity_custom:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_HEALTH_BONUS,
	}
end

function modifier_item_seeds_of_serenity_custom:GetModifierHealthBonus()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end

modifier_item_seeds_of_serenity_custom_thinker = class({})

function modifier_item_seeds_of_serenity_custom_thinker:IsHidden() return true end
function modifier_item_seeds_of_serenity_custom_thinker:IsPurgable() return false end

function modifier_item_seeds_of_serenity_custom_thinker:OnCreated()
	if not IsServer() then return end
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	local particle = ParticleManager:CreateParticle("particles/items_fx/seeds_of_serenity.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 2, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(self:GetAbility():GetSpecialValueFor("radius"),self:GetAbility():GetSpecialValueFor("radius"),self:GetAbility():GetSpecialValueFor("radius")))
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_item_seeds_of_serenity_custom_thinker:IsAura()
	return true
end

function modifier_item_seeds_of_serenity_custom_thinker:GetModifierAura()
	return "modifier_item_seeds_of_serenity_custom_buff"
end

function modifier_item_seeds_of_serenity_custom_thinker:GetAuraRadius()
	return self.radius
end

function modifier_item_seeds_of_serenity_custom_thinker:GetAuraDuration()
	return 0.5
end

function modifier_item_seeds_of_serenity_custom_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_seeds_of_serenity_custom_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_item_seeds_of_serenity_custom_buff = class({})

function modifier_item_seeds_of_serenity_custom_buff:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
	}
end

function modifier_item_seeds_of_serenity_custom_buff:GetModifierHealthRegenPercentage()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("aura_health_regen")
end