--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_faceless_void_time_dilation_custom", "heroes/npc_dota_hero_faceless_void_custom/faceless_void_time_dilation_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_faceless_void_time_dilation_custom_handle", "heroes/npc_dota_hero_faceless_void_custom/faceless_void_time_dilation_custom", LUA_MODIFIER_MOTION_NONE)

faceless_void_time_dilation_custom = class({})
faceless_void_time_dilation_custom.modifier_faceless_void_1 = 1
faceless_void_time_dilation_custom.modifier_faceless_void_2 = {0.3,0.6}
faceless_void_time_dilation_custom.modifier_faceless_void_4 = {0,-2,-4}
faceless_void_time_dilation_custom.modifier_faceless_void_5 = 2
faceless_void_time_dilation_custom.modifier_faceless_void_3 = {12,24,36}

function faceless_void_time_dilation_custom:Precache(context)
    PrecacheResource("particle", "particles/units/heroes/hero_faceless_void/faceless_void_backtrack.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_faceless_void/faceless_void_dialatedebuf_d.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_faceless_void/faceless_void_timedialate.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_faceless_void/faceless_void_dialatedebuf.vpcf", context)
end

function faceless_void_time_dilation_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_faceless_void_4") then
        bonus = self.modifier_faceless_void_4[self:GetCaster():GetTalentLevel("modifier_faceless_void_4")]
    end
    return self.BaseClass.GetCooldown( self, iLevel ) + bonus
end

function faceless_void_time_dilation_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_faceless_void_4") then
        return 0
    end
    return self.BaseClass.GetManaCost( self, iLevel )
end

function faceless_void_time_dilation_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_faceless_void_4") then
        return DOTA_ABILITY_BEHAVIOR_PASSIVE
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function faceless_void_time_dilation_custom:GetIntrinsicModifierName()
    return "modifier_faceless_void_time_dilation_custom_handle"
end

function faceless_void_time_dilation_custom:GetCastRange()
	if IsClient() then
		return self:GetSpecialValueFor("radius")
	end
end

function faceless_void_time_dilation_custom:OnSpellStart()
    if not IsServer() then return end
    local radius = self:GetSpecialValueFor("radius")
    local duration = self:GetSpecialValueFor("duration")
    if self:GetCaster():HasModifier("modifier_faceless_void_5") then
        duration = duration + self.modifier_faceless_void_5
    end
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    for _, unit in pairs(units) do
        	unit:AddNewModifier(self:GetCaster(), self, "modifier_faceless_void_time_dilation_custom", {duration = duration * (1-unit:GetStatusResistance())})
        	local hit_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_backtrack.vpcf", PATTACH_ABSORIGIN, unit)
			ParticleManager:SetParticleControl(hit_pfx, 0, unit:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(hit_pfx)
        	local hit_pfx_2 = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_dialatedebuf_d.vpcf", PATTACH_ABSORIGIN, unit)
			ParticleManager:ReleaseParticleIndex(hit_pfx_2)
        	unit:EmitSound("Hero_FacelessVoid.TimeDilation.Target")
    end
    local effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_timedialate.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, radius, radius))
    ParticleManager:ReleaseParticleIndex(effect_cast)
    self:GetCaster():EmitSound("Hero_FacelessVoid.TimeDilation.Cast")
end

modifier_faceless_void_time_dilation_custom = class({})

function modifier_faceless_void_time_dilation_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_faceless_void_time_dilation_custom:OnCreated()
    self.slow = self:GetAbility():GetSpecialValueFor("slow")
    self.cooldown_percentage = self:GetAbility():GetSpecialValueFor("cooldown_percentage") / 100
    if not IsServer() then return end
    self.abilities_cooldowns = {}
    self.ignored_abilities = 
    {
        ["roshan_strength_of_the_immortal_custom"] = true,
        ["chen_creep_visual_mega"] = true,
        ["high_five_custom"] = true,
    }
    local duration = self:GetAbility():GetSpecialValueFor("duration")
    for i=0, self:GetParent():GetAbilityCount()-1 do
        local ability = self:GetParent():GetAbilityByIndex(i)
        if ability and not self:GetParent():IsDebuffImmune() and ability:GetCooldownTimeRemaining() > 0 and not ability:IsToggle() and not self.ignored_abilities[ability:GetAbilityName()] then
            local new_cooldown = ability:GetCooldownTimeRemaining()
            ability:EndCooldown()
            new_cooldown = new_cooldown / (1 - self.cooldown_percentage)
            ability:StartCooldown(new_cooldown)
            self.abilities_cooldowns[ability:GetAbilityName()] = true
        end
    end
    self.damage_interval = 1.1
    self:StartIntervalThink(FrameTime())
end

function modifier_faceless_void_time_dilation_custom:OnIntervalThink()
    if not IsServer() then return end
    local abilities_cooldown = 0
    for i=0, self:GetParent():GetAbilityCount()-1 do
        local ability = self:GetParent():GetAbilityByIndex(i)
        if ability and not self:GetParent():IsDebuffImmune() and ability:GetCooldownTimeRemaining() > 0 and not self.ignored_abilities[ability:GetAbilityName()] then
            abilities_cooldown = abilities_cooldown + 1
        end
    end
    if self:GetCaster():HasModifier("modifier_faceless_void_1") then
        abilities_cooldown = abilities_cooldown + self:GetAbility().modifier_faceless_void_1
    end
    self:SetStackCount(abilities_cooldown)
    self.damage_interval = self.damage_interval - FrameTime()
    if self.damage_interval <= 0 then
        self.damage_interval = 1.1
        local damage = self:GetAbility():GetSpecialValueFor("damage_per_stack")
        local base_damage = 0
        if self:GetCaster():HasModifier("modifier_faceless_void_3") then
            base_damage = self:GetAbility().modifier_faceless_void_3[self:GetCaster():GetTalentLevel("modifier_faceless_void_3")]
        end
        if self:GetCaster():HasModifier("modifier_faceless_void_2") then
            damage = damage + (self:GetCaster():GetMaxHealth() / 100 * self:GetAbility().modifier_faceless_void_2[self:GetCaster():GetTalentLevel("modifier_faceless_void_2")])
        end
        damage = damage * self:GetStackCount()
        ApplyDamage({attacker = self:GetCaster(), victim = self:GetParent(), ability = self:GetAbility(), damage = damage+base_damage, damage_type = DAMAGE_TYPE_MAGICAL})
    end
end

function modifier_faceless_void_time_dilation_custom:OnDestroy()
    if not IsServer() then return end
    for i=0, self:GetParent():GetAbilityCount()-1 do
        local ability = self:GetParent():GetAbilityByIndex(i)
        if ability and ability:GetCooldownTimeRemaining() > 0 and not ability:IsToggle() and not self.ignored_abilities[ability:GetAbilityName()] then
            if self.abilities_cooldowns[ability:GetAbilityName()] then
                local new_cooldown = ability:GetCooldownTimeRemaining()
                ability:EndCooldown()
                new_cooldown = new_cooldown * (1 - self.cooldown_percentage)
                ability:StartCooldown(new_cooldown)
            end
        end
    end
end

function modifier_faceless_void_time_dilation_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
end

function modifier_faceless_void_time_dilation_custom:OnAbilityFullyCast(params)
    if not IsServer() then return end

    if params.unit ~= self:GetParent() then return end
    if params.ability == nil then return end
    local ability = params.ability
    Timers:CreateTimer(FrameTime(), function()
        if ability and not ability:IsItem() and ability:GetCooldownTimeRemaining() > 0 and not self:GetParent():IsDebuffImmune() and not ability:IsToggle() and not self.ignored_abilities[ability:GetAbilityName()] then
            local new_cooldown = ability:GetCooldownTimeRemaining()
            ability:EndCooldown()
            new_cooldown = new_cooldown / (1 - self.cooldown_percentage)
            ability:StartCooldown(new_cooldown)
            self.abilities_cooldowns[ability:GetAbilityName()] = true
        end
    end)
end

function modifier_faceless_void_time_dilation_custom:GetModifierMoveSpeedBonus_Percentage()
    return self.slow * self:GetStackCount()
end

function modifier_faceless_void_time_dilation_custom:GetModifierAttackSpeedBonus_Constant()
    return self.slow * self:GetStackCount()
end

function modifier_faceless_void_time_dilation_custom:GetEffectName()
	return "particles/units/heroes/hero_faceless_void/faceless_void_dialatedebuf.vpcf" 
end

function modifier_faceless_void_time_dilation_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW 
end

modifier_faceless_void_time_dilation_custom_handle = class({})
function modifier_faceless_void_time_dilation_custom_handle:IsHidden() return true end
function modifier_faceless_void_time_dilation_custom_handle:IsPurgable() return false end
function modifier_faceless_void_time_dilation_custom_handle:IsPurgeException() return false end
function modifier_faceless_void_time_dilation_custom_handle:RemoveOnDeath() return false end
function modifier_faceless_void_time_dilation_custom_handle:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end
function modifier_faceless_void_time_dilation_custom_handle:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetCaster():IsAlive() then return end
    if self:GetCaster():HasModifier("modifier_wodawisp") then return end
	if self:GetCaster():HasModifier("modifier_wodarelax") then return end
    if not self:GetCaster():HasModifier("modifier_faceless_void_4") then return end
    if self:GetAbility():IsFullyCastable() then
        self:GetAbility():OnSpellStart()
        self:GetAbility():UseResources(false, false, false, true)
    end
end