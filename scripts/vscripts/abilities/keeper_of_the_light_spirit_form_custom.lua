--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_keeper_of_the_light_spirit_form_custom_fly", "abilities/keeper_of_the_light_spirit_form_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_keeper_of_the_light_spirit_form_custom", "abilities/keeper_of_the_light_spirit_form_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_infinite_form_mana_drain", "modifiers/modifier_infinite_form_mana_drain", LUA_MODIFIER_MOTION_NONE)

keeper_of_the_light_spirit_form_custom = class({})

function keeper_of_the_light_spirit_form_custom:OnToggle() 
	if not IsServer() then return end
	local modifier_keeper_of_the_light_spirit_form_custom = self:GetCaster():FindModifierByName("modifier_keeper_of_the_light_spirit_form_custom")

	if not self:GetToggleState() then
		if modifier_keeper_of_the_light_spirit_form_custom then
			modifier_keeper_of_the_light_spirit_form_custom:Destroy()
		end
	else
		self:GetCaster():RemoveModifierByName("modifier_keeper_of_the_light_spirit_form_custom")
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_keeper_of_the_light_spirit_form_custom", {})
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_keeper_of_the_light_spirit_form_custom_fly", {})
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_infinite_form_mana_drain", {}) -- [MF-16] общий дрейн 3%/сек
	end

	self:EndCooldown()
	self:StartCooldown(1) 
end

function keeper_of_the_light_spirit_form_custom:GetCooldown(iLevel)
	if self:GetCaster():HasScepter() then
		return 0
	end
	return self.BaseClass.GetCooldown(self, iLevel) 
end

function keeper_of_the_light_spirit_form_custom:GetBehavior()
  	if self:GetCaster():HasScepter() then
    	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_TOGGLE + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
   	end
 	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE 
end

function keeper_of_the_light_spirit_form_custom:OnSpellStart()
	if not IsServer() then return end
	if self:GetCaster():HasScepter() then return end
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_keeper_of_the_light_spirit_form_custom", {duration = self:GetSpecialValueFor("duration")})
end

modifier_keeper_of_the_light_spirit_form_custom_fly = class({})

function modifier_keeper_of_the_light_spirit_form_custom_fly:IsHidden() return true end
function modifier_keeper_of_the_light_spirit_form_custom_fly:IsPurgable() return false end
function modifier_keeper_of_the_light_spirit_form_custom_fly:IsPurgeException() return false end

function modifier_keeper_of_the_light_spirit_form_custom_fly:OnCreated()
	if not IsServer() then return end
    self.parent = self:GetParent()
	self:StartIntervalThink(0.5)
end

function modifier_keeper_of_the_light_spirit_form_custom_fly:OnIntervalThink()
	if not IsServer() then return end
	if not self.parent:HasModifier("modifier_keeper_of_the_light_spirit_form_custom") then
		self:Destroy()
	end
    if not self.parent:HasScepter() then
        self.parent:RemoveModifierByName("modifier_keeper_of_the_light_spirit_form_custom")
    end
end

function modifier_keeper_of_the_light_spirit_form_custom_fly:CheckState()
	if not self.parent:HasScepter() then return end
	return 
	{
		[MODIFIER_STATE_FLYING] = true,
		-- [A61] без NO_UNIT_COLLISION летающий блокирует наземного врага (коллизия на земле) → застакивание/ловушка в дуэли
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

modifier_keeper_of_the_light_spirit_form_custom = class({})
function modifier_keeper_of_the_light_spirit_form_custom:IsHidden() return false end
function modifier_keeper_of_the_light_spirit_form_custom:IsPurgable() return false end

function modifier_keeper_of_the_light_spirit_form_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_CAST_RANGE_BONUS,
        MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
        MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT
    }
end

function modifier_keeper_of_the_light_spirit_form_custom:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movement_speed")
end

function modifier_keeper_of_the_light_spirit_form_custom:GetModifierCastRangeBonus()
    return self:GetAbility():GetSpecialValueFor("cast_range")
end

function modifier_keeper_of_the_light_spirit_form_custom:GetModifierPercentageCooldown(params)
    if IsServer() then
        if params.ability and params.ability:GetAbilityName() == "puck_phase_shift_custom" then
            return 0
        end
    end
    return self:GetAbility():GetSpecialValueFor("cooldown_percent")
end

function modifier_keeper_of_the_light_spirit_form_custom:TakeDamageScriptModifier(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if self:GetParent() == params.unit then return end
    if params.unit:IsBuilding() then return end
    if params.damage <= 0 then return end
    if params.inflictor ~= nil and not self:GetParent():IsIllusion() and not self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION ) then 
    	local bonus_percentage = 0
        for _, mod in pairs(self:GetParent():FindAllModifiers()) do
            if mod.GetModifierSpellLifestealRegenAmplify_Percentage and mod:GetModifierSpellLifestealRegenAmplify_Percentage() then
                bonus_percentage = bonus_percentage + mod:GetModifierSpellLifestealRegenAmplify_Percentage()
            end
        end    
        local heal = self:GetAbility():GetSpecialValueFor("spell_lifesteal") / 100 * params.damage
        heal = heal * (bonus_percentage / 100 + 1)
        self:GetParent():Heal(heal, params.inflictor)
    end
end

function modifier_keeper_of_the_light_spirit_form_custom:GetModifierIgnoreMovespeedLimit()
    return 1
end

function modifier_keeper_of_the_light_spirit_form_custom:GetEffectName()
	return "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_spirit_form_ambient.vpcf"
end

function modifier_keeper_of_the_light_spirit_form_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_keeper_spirit_form.vpcf"
end