--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_skeleton_king_mortal_strike_custom", "heroes/npc_dota_hero_skeleton_king_custom/skeleton_king_mortal_strike_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skeleton_king_mortal_strike_custom_debuff", "heroes/npc_dota_hero_skeleton_king_custom/skeleton_king_mortal_strike_custom", LUA_MODIFIER_MOTION_NONE )

skeleton_king_mortal_strike_custom = class({})

function skeleton_king_mortal_strike_custom:GetCooldown(level)
    local bonus = 0
	if self:GetCaster():HasModifier("modifier_skeleton_king_10") then
		bonus = self.modifier_skeleton_king_10[self:GetCaster():GetTalentLevel("modifier_skeleton_king_10")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

skeleton_king_mortal_strike_custom.modifier_skeleton_king_10 = {-0.5,-1}
skeleton_king_mortal_strike_custom.modifier_skeleton_king_13 = {30,60}

function skeleton_king_mortal_strike_custom:GetIntrinsicModifierName()
	return "modifier_skeleton_king_mortal_strike_custom"
end

modifier_skeleton_king_mortal_strike_custom = class({})
function modifier_skeleton_king_mortal_strike_custom:IsHidden() return true end
function modifier_skeleton_king_mortal_strike_custom:IsPurgable() return false end

function modifier_skeleton_king_mortal_strike_custom:GetCritDamage()
    local crit = self:GetAbility():GetSpecialValueFor("crit_mult")
    return crit
end

function modifier_skeleton_king_mortal_strike_custom:OnCreated(table)
    self.record = nil
end

function modifier_skeleton_king_mortal_strike_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
        MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
    }
end

function modifier_skeleton_king_mortal_strike_custom:GetModifierPreAttack_CriticalStrike( params )
    local crit = self:GetAbility():GetSpecialValueFor("crit_mult")
    self.record = nil
    if not IsServer() then return end
    if self:GetParent():PassivesDisabled() then return end
    if self:GetAbility():IsFullyCastable() then
        self:GetParent():RemoveGesture(ACT_DOTA_ATTACK_EVENT)
        self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_ATTACK_EVENT, self:GetParent():GetAttackSpeed(true))
        self.record = params.record
        return crit
    end
    return 0
end

function modifier_skeleton_king_mortal_strike_custom:GetModifierProcAttack_Feedback( params )
    if not IsServer() then return end
    if self.record and self.record == params.record then
        self:GetParent():EmitSound("Hero_SkeletonKing.CriticalStrike")
        self:GetAbility():UseResources(false, false, false, true)
    end
end

function modifier_skeleton_king_mortal_strike_custom:OnTakeDamage(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.record ~= self.record then return end
    if self:GetCaster():HasModifier("modifier_skeleton_king_13") then
        params.unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_skeleton_king_mortal_strike_custom_debuff", {duration = 3, damage = params.damage})
    end
end

modifier_skeleton_king_mortal_strike_custom_debuff = class({})
function modifier_skeleton_king_mortal_strike_custom_debuff:IsPurgable() return false end
function modifier_skeleton_king_mortal_strike_custom_debuff:IsPurgeException() return false end
function modifier_skeleton_king_mortal_strike_custom_debuff:OnCreated(params)
    if not IsServer() then return end
    self.damage = params.damage / 100 * self:GetAbility().modifier_skeleton_king_13[self:GetCaster():GetTalentLevel("modifier_skeleton_king_13")]
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_skeletonking/wraith_king_curse_overhead.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
    self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_skeleton_king_mortal_strike_custom_debuff:OnDestroy()
    if not IsServer() then return end
    local end_damage = ApplyDamage({attacker = self:GetCaster(), victim = self:GetParent(), damage = self.damage, damage_type = DAMAGE_TYPE_PURE, ability = self:GetAbility()})
    local modifier_skeleton_king_vampiric_aura_custom = self:GetCaster():FindModifierByName("modifier_skeleton_king_vampiric_aura_custom")
    if modifier_skeleton_king_vampiric_aura_custom then
        local ability = modifier_skeleton_king_vampiric_aura_custom:GetAbility()
        local vampiric_aura = ability:GetSpecialValueFor("vampiric_aura")
        if vampiric_aura > 0 then
            self:GetCaster():Heal(end_damage / 100 * vampiric_aura, self:GetAbility())
        end
    end
end