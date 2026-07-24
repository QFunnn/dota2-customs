--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_dazzle_shallow_grave_custom", "heroes/npc_dota_hero_dazzle_custom/dazzle_shallow_grave_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dazzle_shallow_grave_custom_handler", "heroes/npc_dota_hero_dazzle_custom/dazzle_shallow_grave_custom", LUA_MODIFIER_MOTION_NONE )

dazzle_shallow_grave_custom = class({})

dazzle_shallow_grave_custom.modifier_dazzle_11 = 15

function dazzle_shallow_grave_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_dazzle_11") then
        return DOTA_ABILITY_BEHAVIOR_PASSIVE
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end

function dazzle_shallow_grave_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_dazzle_11") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, level)
end

function dazzle_shallow_grave_custom:GetIntrinsicModifierName()
    return "modifier_dazzle_shallow_grave_custom_handler"
end

function dazzle_shallow_grave_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("duration")
	target:AddNewModifier( self:GetCaster(), self, "modifier_dazzle_shallow_grave", { duration = duration } )
    local dazzle_innate_weave_custom = self:GetCaster():FindAbilityByName("dazzle_innate_weave_custom")
    if dazzle_innate_weave_custom and dazzle_innate_weave_custom:GetLevel() > 0 then
        dazzle_innate_weave_custom:TargetModifier(target)
    end
end

modifier_dazzle_shallow_grave_custom = class({})
function modifier_dazzle_shallow_grave_custom:IsPurgable() return false end

function modifier_dazzle_shallow_grave_custom:OnCreated( kv )
    if not IsServer() then return end
    self.modifier_dazzle_nothl_projection_soul_clone = self:GetCaster():HasModifier("modifier_dazzle_nothl_projection_soul_clone")
    self:GetParent():EmitSound("Hero_Dazzle.Shallow_Grave")
end

function modifier_dazzle_shallow_grave_custom:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_MIN_HEALTH,
        MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_SOURCE
	}
	return funcs
end

function modifier_dazzle_shallow_grave_custom:GetMinHealth()
	return 1
end

function modifier_dazzle_shallow_grave_custom:GetEffectName()
	return "particles/units/heroes/hero_dazzle/dazzle_shallow_grave.vpcf"
end

function modifier_dazzle_shallow_grave_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_dazzle_shallow_grave_custom:GetModifierHealAmplify_PercentageSource()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("heal_amplify") * (( 100 - self:GetParent():GetHealthPercent()) / 10)
    end
end

function modifier_dazzle_shallow_grave_custom:OnDestroy()
    if not IsServer() then return end
    if self.modifier_dazzle_nothl_projection_soul_clone then
        local shallow_grave_heal = self:GetCaster():FindAbilityByName("dazzle_nothl_projection"):GetSpecialValueFor("shallow_grave_heal")
        self:GetParent():Heal(shallow_grave_heal, self:GetCaster())
    end
end

modifier_dazzle_shallow_grave_custom_handler = class({})
function modifier_dazzle_shallow_grave_custom_handler:IsPurgable() return false end
function modifier_dazzle_shallow_grave_custom_handler:IsHidden() return true end
function modifier_dazzle_shallow_grave_custom_handler:IsPurgeException() return false end
function modifier_dazzle_shallow_grave_custom_handler:RemoveOnDeath() return false end
function modifier_dazzle_shallow_grave_custom_handler:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MIN_HEALTH,
         
    }
end

function modifier_dazzle_shallow_grave_custom_handler:GetMinHealth()
    if not self:GetParent():HasModifier("modifier_dazzle_11") then return end
    if self:GetParent():HasModifier("modifier_dazzle_1") then return end
    if self:GetParent():HasModifier("modifier_dazzle_16") then return end
    if self:GetParent():HasModifier("modifier_dazzle_nothl_projection_soul_clone") then return end
    if not self:GetAbility():IsFullyCastable() then return end
    if self:GetParent():PassivesDisabled() then return end
    if not self:GetParent():IsAlive() then return end
    return 1
end

function modifier_dazzle_shallow_grave_custom_handler:OnTakeDamage(params)
    if not IsServer() then return end
    if params.attacker == self:GetCaster() then return end
    if params.unit ~= self:GetCaster() then return end
    if not self:GetParent():HasModifier("modifier_dazzle_11") then return end
    if self:GetParent():HasModifier("modifier_dazzle_1") then return end
    if self:GetParent():HasModifier("modifier_dazzle_16") then return end
    if self:GetParent():HasModifier("modifier_dazzle_nothl_projection_soul_clone") then return end
    if not self:GetAbility():IsFullyCastable() then return end
    if self:GetParent():GetHealthPercent() > self:GetAbility().modifier_dazzle_11 then return end
    if self:GetParent():PassivesDisabled() then return end
    local duration = self:GetAbility():GetSpecialValueFor("duration")
	self:GetParent():AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_dazzle_shallow_grave", { duration = duration } )
    local dazzle_innate_weave_custom = self:GetCaster():FindAbilityByName("dazzle_innate_weave_custom")
    if dazzle_innate_weave_custom and dazzle_innate_weave_custom:GetLevel() > 0 then
        dazzle_innate_weave_custom:TargetModifier(self:GetParent())
    end
    self:GetAbility():UseResources(false, false, false, true)
end