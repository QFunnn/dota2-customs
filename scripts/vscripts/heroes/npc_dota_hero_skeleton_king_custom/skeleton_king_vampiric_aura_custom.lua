--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skeleton_king_vampiric_aura_custom", "heroes/npc_dota_hero_skeleton_king_custom/skeleton_king_vampiric_aura_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_skeleton_king_vampiric_aura_custom_aura", "heroes/npc_dota_hero_skeleton_king_custom/skeleton_king_vampiric_aura_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_skeleton_king_vampiric_aura_custom_ghost_buff", "heroes/npc_dota_hero_skeleton_king_custom/skeleton_king_vampiric_aura_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_skeleton_king_vampiric_aura_custom_ghost_buff_death", "heroes/npc_dota_hero_skeleton_king_custom/skeleton_king_vampiric_aura_custom", LUA_MODIFIER_MOTION_NONE )

skeleton_king_vampiric_aura_custom = class({})
skeleton_king_vampiric_aura_custom.modifier_skeleton_king_14 = 1

function skeleton_king_vampiric_aura_custom:GetIntrinsicModifierName()
    if self:GetCaster():IsIllusion() then return end
	return "modifier_skeleton_king_vampiric_aura_custom_aura"
end

modifier_skeleton_king_vampiric_aura_custom_aura = class({})
function modifier_skeleton_king_vampiric_aura_custom_aura:IsHidden() return true end
function modifier_skeleton_king_vampiric_aura_custom_aura:IsPurgable() return false end
function modifier_skeleton_king_vampiric_aura_custom_aura:IsAura() return true end
function modifier_skeleton_king_vampiric_aura_custom_aura:GetAuraRadius() return 1200 end
function modifier_skeleton_king_vampiric_aura_custom_aura:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_skeleton_king_vampiric_aura_custom_aura:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_skeleton_king_vampiric_aura_custom_aura:GetModifierAura() return "modifier_skeleton_king_vampiric_aura_custom" end
function modifier_skeleton_king_vampiric_aura_custom_aura:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_INVULNERABLE end

modifier_skeleton_king_vampiric_aura_custom = class({})
function modifier_skeleton_king_vampiric_aura_custom:IsHidden() return true end
function modifier_skeleton_king_vampiric_aura_custom:IsPurgable() return false end
function modifier_skeleton_king_vampiric_aura_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_LIFESTEAL,
        MODIFIER_PROPERTY_MIN_HEALTH,
    }
end

function modifier_skeleton_king_vampiric_aura_custom:GetModifierProperty_PhysicalLifesteal(params)
    if self:GetParent():IsRealHero() and self:GetParent() ~= self:GetCaster() then return end
    if self:GetParent():HasModifier("modifier_skeleton_king_2") then return end
    if params.inflictor ~= nil or self:GetParent():HasModifier("modifier_skeleton_vampiric_aura_ghost") then

    else
        if self:GetParent():HasModifier("modifier_skeleton_vampiric_aura_ghost") then return end
        local vampiric_aura = self:GetAbility():GetSpecialValueFor("vampiric_aura")
        return vampiric_aura
    end
end

function modifier_skeleton_king_vampiric_aura_custom:GetMinHealth()
	if self:GetParent():IsIllusion() then return end
	if self:GetParent():HasModifier("modifier_skeleton_king_vampiric_aura_custom_ghost_buff") then return end
    if self:GetParent():HasModifier("modifier_skeleton_king_vampiric_aura_custom_ghost_buff_death") then return end
    local only_caster = not self:GetCaster():HasModifier("modifier_skeleton_king_14")
    if only_caster and self:GetParent() ~= self:GetCaster() then return end
    local skeleton_king_reincarnation_custom = self:GetParent():FindAbilityByName("skeleton_king_reincarnation_custom")
    if self:GetParent():HasModifier("modifier_skeleton_king_5") or (skeleton_king_reincarnation_custom and (skeleton_king_reincarnation_custom:GetLevel() <= 0 or not skeleton_king_reincarnation_custom:IsFullyCastable() or skeleton_king_reincarnation_custom:IsHidden())) or self:GetParent() ~= self:GetCaster() then
	    return 1
    end
end

function modifier_skeleton_king_vampiric_aura_custom:OnTakeDamage(params)
	if not IsServer() then return end
	if params.unit ~= self:GetParent() then return end
	if self:GetParent():GetHealth() > 1 then return end
    if self:GetParent():IsIllusion() then return end
    local only_caster = not self:GetCaster():HasModifier("modifier_skeleton_king_14")
    if only_caster and self:GetParent() ~= self:GetCaster() then return end
    local skeleton_king_reincarnation_custom = self:GetParent():FindAbilityByName("skeleton_king_reincarnation_custom")
    if self:GetParent():HasModifier("modifier_skeleton_king_5") or (skeleton_king_reincarnation_custom and (skeleton_king_reincarnation_custom:GetLevel() <= 0 or not skeleton_king_reincarnation_custom:IsFullyCastable() or skeleton_king_reincarnation_custom:IsHidden())) or self:GetParent() ~= self:GetCaster() then
        if self:GetParent():HasModifier("modifier_skeleton_king_vampiric_aura_custom_ghost_buff") then return end
        if self:GetParent():HasModifier("modifier_skeleton_king_vampiric_aura_custom_ghost_buff_death") then return end
        self:GetParent():EmitSound("Hero_SkeletonKing.Reincarnate.Ghost")
        local duration = self:GetAbility():GetSpecialValueFor("duration")
        print(duration)
        if self:GetCaster():HasModifier("modifier_skeleton_king_14") then
            duration = duration + self:GetAbility().modifier_skeleton_king_14
        end
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_skeleton_king_vampiric_aura_custom_ghost_buff", {duration = duration, attacker = params.attacker:entindex()})
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_skeleton_king_vampiric_aura_custom_ghost_buff_death", {duration = duration + 1})
        self:GetParent():Purge(false, true, false, true, true)
    end
end

modifier_skeleton_king_vampiric_aura_custom_ghost_buff = class({})
function modifier_skeleton_king_vampiric_aura_custom_ghost_buff:IsHidden() return false end
function modifier_skeleton_king_vampiric_aura_custom_ghost_buff:IsPurgable() return false end

function modifier_skeleton_king_vampiric_aura_custom_ghost_buff:OnCreated(params)
    if not IsServer() then return end
    self.attacker = EntIndexToHScript(params.attacker)
end

function modifier_skeleton_king_vampiric_aura_custom_ghost_buff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MIN_HEALTH,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_skeleton_king_vampiric_aura_custom_ghost_buff:GetMinHealth()
	return 1
end

function modifier_skeleton_king_vampiric_aura_custom_ghost_buff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("scepter_move_speed_pct")
end

function modifier_skeleton_king_vampiric_aura_custom_ghost_buff:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("scepter_attack_speed")
end

function modifier_skeleton_king_vampiric_aura_custom_ghost_buff:OnDestroy()
	if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_wodarelax") then return end
    if self.close_death then return end
    self:GetParent():Kill(self:GetAbility(), self.attacker)
end

function modifier_skeleton_king_vampiric_aura_custom_ghost_buff:GetStatusEffectName()
    return "particles/status_fx/status_effect_wraithking_ghosts.vpcf"
end

function modifier_skeleton_king_vampiric_aura_custom_ghost_buff:StatusEffectPriority()
    return 99999 
end

modifier_skeleton_king_vampiric_aura_custom_ghost_buff_death = class({})
function modifier_skeleton_king_vampiric_aura_custom_ghost_buff_death:IsHidden() return true end
function modifier_skeleton_king_vampiric_aura_custom_ghost_buff_death:IsPurgeException() return false end
function modifier_skeleton_king_vampiric_aura_custom_ghost_buff_death:IsPurgable() return false end