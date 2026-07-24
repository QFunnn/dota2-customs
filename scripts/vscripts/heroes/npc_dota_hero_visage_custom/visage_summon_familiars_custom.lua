--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_visage_summon_familiars_custom", "heroes/npc_dota_hero_visage_custom/visage_summon_familiars_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_visage_summon_familiars_self_cast_custom", "heroes/npc_dota_hero_visage_custom/visage_summon_familiars_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_visage_summon_familiars_custom_armor", "heroes/npc_dota_hero_visage_custom/visage_summon_familiars_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_visage_summon_familiars_custom_cooldown", "heroes/npc_dota_hero_visage_custom/visage_summon_familiars_custom", LUA_MODIFIER_MOTION_NONE)

visage_summon_familiars_custom = class({})

visage_summon_familiars_custom.modifier_visage_3 = {1,2}
visage_summon_familiars_custom.modifier_visage_3_str = {100, 200}
visage_summon_familiars_custom.modifier_visage_9 = {-25,-50}
visage_summon_familiars_custom.modifier_visage_10 = {75,150}
visage_summon_familiars_custom.modifier_visage_11 = {15,30}
visage_summon_familiars_custom.modifier_visage_summon_familiars_custom_armor_reduction = 0.5
visage_summon_familiars_custom.modifier_visage_13_duration = {3,6}
visage_summon_familiars_custom.modifier_visage_14_range = 200
visage_summon_familiars_custom.modifier_visage_17 = {20,40}

function visage_summon_familiars_custom:GetIntrinsicModifierName()
    return "modifier_visage_summon_familiars_self_cast_custom"
end

function visage_summon_familiars_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_visage_19") then
        return DOTA_ABILITY_BEHAVIOR_PASSIVE
    end
    return self.BaseClass.GetBehavior(self)
end

function visage_summon_familiars_custom:GetFamiliarHealth()
    local familiar_health = self:GetSpecialValueFor("familiar_hp")
    if self:GetCaster():HasModifier("modifier_visage_3") then
        familiar_health = familiar_health + (self:GetCaster():GetStrength() / 100 * self.modifier_visage_3_str[self:GetCaster():GetTalentLevel("modifier_visage_3")])
    end
    return familiar_health * 0.8
end

function visage_summon_familiars_custom:GetCooldown(iLevel)
    if self:GetCaster():HasModifier("modifier_visage_19") then
        return 0
    end
    local cooldown = self.BaseClass.GetCooldown(self, iLevel)
    if self:GetCaster():HasModifier("modifier_visage_9") then
        cooldown = cooldown + self.modifier_visage_9[self:GetCaster():GetTalentLevel("modifier_visage_9")]
    end
    return math.max(cooldown, 0)
end

function visage_summon_familiars_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_visage_19") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, iLevel)
end

function visage_summon_familiars_custom:OnSpellStart()
    if not IsServer() then return end
    if self:GetAltCastState() then
        if self.familiar_table then
            for _, familiar in pairs(self.familiar_table) do
                if familiar and not familiar:IsNull() and familiar:IsAlive() and familiar:GetPlayerOwnerID() == self:GetCaster():GetPlayerOwnerID() then
                    local visage_summon_familiars_recall_custom = familiar:FindAbilityByName("visage_summon_familiars_recall_custom")
                    if visage_summon_familiars_recall_custom and visage_summon_familiars_recall_custom:IsFullyCastable() and not familiar:HasModifier("modifier_visage_summon_familiars_stone_form_custom_root") and not familiar:HasModifier("modifier_visage_summon_familiars_stone_form_custom_buff") then
                        familiar:CastAbilityImmediately(visage_summon_familiars_recall_custom, -1)
                    end
                end
            end
        end
        self:EndCooldown()
        self:RefundManaCost()
        return
    end
    self:GetCaster():EmitSound("Hero_Visage.SummonFamiliars.Cast")
    self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_4)
    local unit_count = self:GetSpecialValueFor("familiar_count")
    if self:GetCaster():HasModifier("modifier_visage_5") then
        unit_count = math.max(unit_count - 1, 1)
    end
    if self.familiar_table then
        for _, familiar in pairs(self.familiar_table) do
            if familiar and not familiar:IsNull() and familiar:IsAlive() and familiar:GetPlayerOwnerID() == self:GetCaster():GetPlayerOwnerID() then
                familiar:ForceKill(false)
            end
        end
	end
    self.familiar_table = {}
    for i = 1, unit_count do
        self:SpawnFamiliar(i, unit_count)
	end
end

function visage_summon_familiars_custom:SpawnFamiliar(num, unit_count, new_point)
    local side_offset = 0
    if unit_count > 1 then
        side_offset = (math.max(unit_count - 1, 0) * 120) * (-0.5 + (math.max(num - 1, 0) / (unit_count - 1)))
    end
    local spawn_location = self:GetCaster():GetAbsOrigin() + (self:GetCaster():GetForwardVector() * 200) + (self:GetCaster():GetRightVector() * side_offset)
    if new_point then
        spawn_location = new_point
    end
    local familiar = CreateUnitByName("npc_dota_visage_familiar"..math.min(self:GetLevel(), 3), spawn_location, true, nil, nil, self:GetCaster():GetTeamNumber())
    familiar:SetOwner(self:GetCaster())
    familiar.owner = self:GetCaster()
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_visage/visage_summon_familiars.vpcf", PATTACH_ABSORIGIN, familiar)
    ParticleManager:ReleaseParticleIndex(particle)
    
    local familiar_health = self:GetSpecialValueFor("familiar_hp")

    familiar:AddNewModifier(self:GetCaster(), self, "modifier_visage_summon_familiars_custom", {count = num, unit_count = unit_count})
    familiar:SetForwardVector(self:GetCaster():GetForwardVector())
    familiar:SetOwner(self:GetCaster())
    familiar:SetControllableByPlayer(self:GetCaster():GetPlayerOwnerID(), true)
    familiar:SetBaseMaxHealth(familiar_health)
    familiar:SetMaxHealth(familiar_health)
    familiar:SetHealth(familiar_health)
    familiar:SetPhysicalArmorBaseValue(self:GetSpecialValueFor("familiar_armor"))
    familiar:SetMinimumGoldBounty(self:GetSpecialValueFor("familiar_bounty"))
    familiar:SetMaximumGoldBounty(self:GetSpecialValueFor("familiar_bounty"))
    familiar:SetBaseMoveSpeed(self:GetSpecialValueFor("familiar_base_movespeed"))
    familiar:SetBaseDamageMin(self:GetSpecialValueFor("familiar_attack_damage"))
    familiar:SetBaseDamageMax(self:GetSpecialValueFor("familiar_attack_damage"))

    for ability_index=0, familiar:GetAbilityCount() - 1 do
        local ability = familiar:GetAbilityByIndex(ability_index)
        if ability then
            ability:SetLevel(self:GetLevel())
        end
    end
    if self:GetCaster():HasModifier("modifier_visage_5") then
        familiar:AddNewModifier(self:GetCaster(), self, "modifier_visage_summon_familiars_custom_cooldown", {})
    end
    if not self.familiar_table then
        self.familiar_table = {}
    end
    table.insert(self.familiar_table, familiar)
    return familiar
end

modifier_visage_summon_familiars_custom = class({})
function modifier_visage_summon_familiars_custom:IsHidden() return true end
function modifier_visage_summon_familiars_custom:IsPurgable() return false end
function modifier_visage_summon_familiars_custom:IsPurgeException() return false end
function modifier_visage_summon_familiars_custom:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end
function modifier_visage_summon_familiars_custom:OnIntervalThink()
    if not IsServer() then return end
    local visage_gravekeepers_cloak_custom = self:GetCaster():FindAbilityByName("visage_gravekeepers_cloak_custom")
    local visage_gravekeepers_cloak_custom_familiar = self:GetParent():FindAbilityByName("visage_gravekeepers_cloak_custom")
    if visage_gravekeepers_cloak_custom and visage_gravekeepers_cloak_custom_familiar then
        visage_gravekeepers_cloak_custom_familiar:SetLevel(visage_gravekeepers_cloak_custom:GetLevel())
    end
    local visage_summon_familiars_stone_form_custom = self:GetCaster():FindAbilityByName("visage_summon_familiars_stone_form_custom")
    local visage_summon_familiars_stone_form_custom_familiar = self:GetParent():FindAbilityByName("visage_summon_familiars_stone_form_custom")
    if visage_summon_familiars_stone_form_custom and visage_summon_familiars_stone_form_custom_familiar then
        visage_summon_familiars_stone_form_custom_familiar:SetLevel(visage_summon_familiars_stone_form_custom:GetLevel())
    end
    if self:GetCaster():HasModifier("modifier_visage_5") then
        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_visage_summon_familiars_custom_cooldown", {})
    end
    self:GetParent():CalculateGenericBonuses()
end
function modifier_visage_summon_familiars_custom:CheckState()
    return
    {
        [MODIFIER_STATE_FLYING] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_visage_summon_familiars_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS,
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
    }
end

function modifier_visage_summon_familiars_custom:GetModifierExtraHealthBonus()
    local hero = self:GetCaster()
    if hero and not hero:IsNull() and hero:HasModifier("modifier_visage_3") then
        return hero:GetStrength() * self:GetAbility().modifier_visage_3[hero:GetTalentLevel("modifier_visage_3")]
    end
    return 0
end

function modifier_visage_summon_familiars_custom:GetModifierAttackRangeBonus()
    local hero = self:GetCaster()
    if not hero or hero:IsNull() then return 0 end
    local bonus = 0
    if hero:HasModifier("modifier_visage_10") then
        bonus = bonus + hero:GetAgility() / 100 * self:GetAbility().modifier_visage_10[hero:GetTalentLevel("modifier_visage_10")]
    end
    if hero:HasModifier("modifier_visage_14") then
        bonus = bonus + self:GetAbility().modifier_visage_14_range
    end
    return bonus
end

function modifier_visage_summon_familiars_custom:GetModifierPreAttack_BonusDamage()
    local hero = self:GetCaster()
    if not hero or hero:IsNull() then return 0 end
    local bonus = 0
    if hero:HasModifier("modifier_visage_17") then
        bonus = bonus + hero:GetIntellect(false) / 100 * self:GetAbility().modifier_visage_17[hero:GetTalentLevel("modifier_visage_17")]
    end
    return bonus
end

function modifier_visage_summon_familiars_custom:GetModifierBaseAttack_BonusDamage()
    local hero = self:GetCaster()
    if not hero or hero:IsNull() then return 0 end
    local bonus = 0
    if hero:HasModifier("modifier_visage_11") then
        bonus = bonus + self:GetAbility().modifier_visage_11[hero:GetTalentLevel("modifier_visage_11")]
    end
    return bonus
end

function modifier_visage_summon_familiars_custom:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    local hero = self:GetCaster()
    if not hero or hero:IsNull() or not hero:HasModifier("modifier_visage_13") then return end
    local target = params.target
    if not target or target:IsNull() or target == self:GetParent() then return end
    if target:GetTeamNumber() == self:GetParent():GetTeamNumber() then return end
    if target:IsBuilding() then return end
    local duration = self:GetAbility().modifier_visage_13_duration[hero:GetTalentLevel("modifier_visage_13")]
    target:AddNewModifier(hero, self:GetAbility(), "modifier_visage_summon_familiars_custom_armor", {duration = duration * (1 - target:GetStatusResistance())})
end

modifier_visage_summon_familiars_custom_armor = class({})
function modifier_visage_summon_familiars_custom_armor:IsHidden() return false end
function modifier_visage_summon_familiars_custom_armor:IsPurgable() return true end
function modifier_visage_summon_familiars_custom_armor:GetTexture() return "visage_13" end

function modifier_visage_summon_familiars_custom_armor:OnCreated()
	if not IsServer() then return end
	self:IncrementStackCount()
    Timers:CreateTimer(self:GetDuration(), function()
        if self and not self:IsNull() then
            self:DecrementStackCount()
            if self:GetStackCount() <= 0 then
                self:Destroy()
            end
        end
    end)
end

function modifier_visage_summon_familiars_custom_armor:OnRefresh()
	if not IsServer() then return end
    self:OnCreated()
end

function modifier_visage_summon_familiars_custom_armor:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
end

function modifier_visage_summon_familiars_custom_armor:GetModifierPhysicalArmorBonus()
    return -self:GetAbility().modifier_visage_summon_familiars_custom_armor_reduction * self:GetStackCount()
end

modifier_visage_summon_familiars_self_cast_custom = class({})
function modifier_visage_summon_familiars_self_cast_custom:IsHidden() return true end
function modifier_visage_summon_familiars_self_cast_custom:IsPurgable() return false end
function modifier_visage_summon_familiars_self_cast_custom:IsPurgeException() return false end
function modifier_visage_summon_familiars_self_cast_custom:RemoveOnDeath() return false end
function modifier_visage_summon_familiars_self_cast_custom:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
end
function modifier_visage_summon_familiars_self_cast_custom:OnIntervalThink()
    if not IsServer() then return end
    if self:GetStackCount() == 0 and self:GetAbility():GetAltCastState() then
        self:SetStackCount(1)
    elseif self:GetStackCount() == 1 and not self:GetAbility():GetAltCastState() then
        self:SetStackCount(0)
    end
end

modifier_visage_summon_familiars_custom_cooldown = class({})
function modifier_visage_summon_familiars_custom_cooldown:IsHidden() return true end
function modifier_visage_summon_familiars_custom_cooldown:IsPurgable() return false end
function modifier_visage_summon_familiars_custom_cooldown:IsPurgeException() return false end
function modifier_visage_summon_familiars_custom_cooldown:RemoveOnDeath() return false end