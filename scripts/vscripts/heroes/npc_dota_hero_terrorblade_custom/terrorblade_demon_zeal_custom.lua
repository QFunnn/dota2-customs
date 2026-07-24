--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_terrorblade_demon_zeal_custom", "heroes/npc_dota_hero_terrorblade_custom/terrorblade_demon_zeal_custom", LUA_MODIFIER_MOTION_NONE)

terrorblade_demon_zeal_custom = class({})

terrorblade_demon_zeal_custom.modifier_terrorblade_4 = {25,50}
terrorblade_demon_zeal_custom.modifier_terrorblade_4_hp_regen = {5,10}
terrorblade_demon_zeal_custom.modifier_terrorblade_6 = {0,10,20}

function terrorblade_demon_zeal_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/models/heroes/terrorblade/demon_zeal.vpcf", context )
end

function terrorblade_demon_zeal_custom:GetHealthCost(level)
    return self:GetSpecialValueFor("health_cost_pct") / 100 * self:GetCaster():GetHealth()
end

function terrorblade_demon_zeal_custom:OnSpellStart(new_duration)
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
    if new_duration then
        duration = new_duration
    end
    if self:GetCaster():HasModifier("modifier_terrorblade_6") then
        self:GetCaster():Purge(false, true, false, false, false)
    end
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_terrorblade_demon_zeal_custom", {duration = duration})
	self:GetCaster():EmitSound("Hero_Terrorblade.DemonZeal.Cast")
end

modifier_terrorblade_demon_zeal_custom = class({})
function modifier_terrorblade_demon_zeal_custom:IsPurgable() return false end
function modifier_terrorblade_demon_zeal_custom:IsPurgeException() return false end
function modifier_terrorblade_demon_zeal_custom:GetEffectName() return "particles/models/heroes/terrorblade/demon_zeal.vpcf" end

function modifier_terrorblade_demon_zeal_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end

function modifier_terrorblade_demon_zeal_custom:GetModifierConstantHealthRegen()
    local bonus = 0
	if self:GetCaster():HasModifier("modifier_terrorblade_4") then
		bonus = self:GetAbility().modifier_terrorblade_4_hp_regen[self:GetCaster():GetTalentLevel("modifier_terrorblade_4")]
	end
    return self:GetAbility():GetSpecialValueFor("heal_regen") + bonus
end

function modifier_terrorblade_demon_zeal_custom:GetModifierMoveSpeedBonus_Constant()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_custom_terrorblade_metamorphosis") then
		return self:GetAbility():GetSpecialValueFor("berserk_bonus_movement_speed") + bonus
	end
	return (self:GetAbility():GetSpecialValueFor("berserk_bonus_movement_speed") + bonus) * 1
end

function modifier_terrorblade_demon_zeal_custom:GetModifierAttackSpeedBonus_Constant()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_terrorblade_4") then
		bonus = self:GetAbility().modifier_terrorblade_4[self:GetCaster():GetTalentLevel("modifier_terrorblade_4")]
	end
	if self:GetCaster():HasModifier("modifier_custom_terrorblade_metamorphosis") then
		return self:GetAbility():GetSpecialValueFor("berserk_bonus_attack_speed") + bonus
	end
	return (self:GetAbility():GetSpecialValueFor("berserk_bonus_attack_speed") + bonus) * 1
end

function modifier_terrorblade_demon_zeal_custom:GetModifierStatusResistanceStacking()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_terrorblade_6") then
		bonus = self:GetAbility().modifier_terrorblade_6[self:GetCaster():GetTalentLevel("modifier_terrorblade_6")]
	end
	return bonus
end