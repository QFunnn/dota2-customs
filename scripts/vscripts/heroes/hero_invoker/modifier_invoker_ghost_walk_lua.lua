--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_invoker_ghost_walk_lua_buff = class({})
function modifier_invoker_ghost_walk_lua_buff:IsHidden() return true end
function modifier_invoker_ghost_walk_lua_buff:OnDestroy()
    if not IsServer() then return end
    self:GetParent():RemoveModifierByName("modifier_invoker_ghost_walk_lua")
end

modifier_invoker_ghost_walk_lua = class({})

function modifier_invoker_ghost_walk_lua:IsPurgable()
    return false
end

function modifier_invoker_ghost_walk_lua:OnCreated()
    self.radius = self:GetAbility():GetSpecialValueFor( "area_of_effect" )
    self.aura_duration = self:GetAbility():GetSpecialValueFor( "aura_fade_time" )
    self.self_slow = self:GetAbility():GetSpecialValueFor("self_slow")
    self.enemy_slow = self:GetAbility():GetSpecialValueFor("enemy_slow")
    self.health_regen = self:GetAbility():GetSpecialValueFor("health_regen")
    self.mana_regen = self:GetAbility():GetSpecialValueFor("mana_regen")
end

function modifier_invoker_ghost_walk_lua:OnRefresh()
    self.radius = self:GetAbility():GetSpecialValueFor( "area_of_effect" )
    self.aura_duration = self:GetAbility():GetSpecialValueFor( "aura_fade_time" )
    self.self_slow = self:GetAbility():GetSpecialValueFor("self_slow")
    self.enemy_slow = self:GetAbility():GetSpecialValueFor("enemy_slow")
    self.health_regen = self:GetAbility():GetSpecialValueFor("health_regen")
    self.mana_regen = self:GetAbility():GetSpecialValueFor("mana_regen")
end

function modifier_invoker_ghost_walk_lua:IsAura()
    return true
end

function modifier_invoker_ghost_walk_lua:GetModifierAura()
    return "modifier_invoker_ghost_walk_lua_debuff"
end

function modifier_invoker_ghost_walk_lua:GetAuraRadius()
    return self.radius
end

function modifier_invoker_ghost_walk_lua:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_invoker_ghost_walk_lua:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_invoker_ghost_walk_lua:GetAuraDuration()
    return self.aura_duration
end

function modifier_invoker_ghost_walk_lua:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
        MODIFIER_EVENT_ON_ABILITY_EXECUTED,
        MODIFIER_EVENT_ON_ATTACK
    }
    return funcs
end

function modifier_invoker_ghost_walk_lua:GetModifierConstantHealthRegen()
    return self.health_regen
end

function modifier_invoker_ghost_walk_lua:GetModifierConstantManaRegen()
    return self.mana_regen
end

function modifier_invoker_ghost_walk_lua:GetModifierMoveSpeedBonus_Percentage()
    return self.self_slow
end

function modifier_invoker_ghost_walk_lua:GetModifierInvisibilityLevel()
    return 1
end

function modifier_invoker_ghost_walk_lua:GetModifierInvisibilityLevel()
	return 1
end

function modifier_invoker_ghost_walk_lua:OnAbilityExecuted( params )
	if IsServer() then
		if params.unit~=self:GetParent() then return end
		self:Destroy()
	end
end

function modifier_invoker_ghost_walk_lua:OnAttack( params )
	if IsServer() then
		if params.attacker~=self:GetParent() then return end
		self:Destroy()
	end
end

function modifier_invoker_ghost_walk_lua:CheckState()
	local state = 
    {
		[MODIFIER_STATE_INVISIBLE] = true,
	}
	return state
end