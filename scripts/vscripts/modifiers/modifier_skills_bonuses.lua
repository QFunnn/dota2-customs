--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_skills_bonuses = class({})

function modifier_skills_bonuses:IsHidden() return true end
function modifier_skills_bonuses:IsPurgable() return false end
function modifier_skills_bonuses:IsPurgeException() return false end
function modifier_skills_bonuses:RemoveOnDeath() return false end

function modifier_skills_bonuses:OnCreated(params)
    if not IsServer() then return end

    self.Values = {}
    self.goldAccum = 0   -- накопитель дробного золота/сек (GPM не кратно 60)

    self:SetHasCustomTransmitterData( true )

    self:OnRefresh()

    self:StartIntervalThink(1)
end

function modifier_skills_bonuses:OnRefresh()
    if not IsServer() then return end

    local Hero = self:GetParent()
    for SkillName, _ in pairs(SKILLS_LIST_TABLE) do
        self.Values[SkillName] = GetPlayerSkillValue(Hero, SkillName)
    end

    Hero:CalculateStatBonus(true)
    self:SendBuffRefreshToClients()
end

function modifier_skills_bonuses:AddCustomTransmitterData()
	return self.Values
end

function modifier_skills_bonuses:HandleCustomTransmitterData( data )
    self.Values = {}

    for SkillName, Value in pairs(data) do
        self.Values[SkillName] = Value
    end
end

function modifier_skills_bonuses:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_EVASION_CONSTANT,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DIRECT_MODIFICATION,
        MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
        MODIFIER_PROPERTY_CAST_RANGE_BONUS,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_MANA_BONUS,
        MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS,
        MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
        MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
        MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_STATUS_RESISTANCE_CASTER,
        MODIFIER_PROPERTY_CASTTIME_PERCENTAGE,
    }
end

function modifier_skills_bonuses:GetValue(Name)
    if self.Values == nil then return 0 end
    local Value = self.Values[Name]
    if Value == nil then return 0 end

    return Value
end

function modifier_skills_bonuses:GetModifierStatusResistanceCaster()
    return self:GetValue("debuff_amplify") * -1
end

function modifier_skills_bonuses:GetModifierPercentageCasttime()
    return self:GetValue("cast_point")
end

function modifier_skills_bonuses:OnIntervalThink()
    -- Пересчитываем по ТЕКУЩЕМУ раунду каждую секунду (GetPlayerSkillValue → GetSkillValue,
    -- где gold_per_minute = clamp(раунд*1.5, 50, 150) за стак). НЕ используем закэшированный self.Values,
    -- иначе GPM застыл бы на раунде последнего взятого навыка.
    local gpm = GetPlayerSkillValue(self:GetCaster(), "gold_per_minute")
    if gpm > 0 then
        -- Накопитель: даём дробное золото/сек честно (50 GPM = 0.83/сек, floor терял бы всё).
        self.goldAccum = (self.goldAccum or 0) + gpm / 60
        local whole = math.floor(self.goldAccum)
        if whole > 0 then
            self.goldAccum = self.goldAccum - whole
            self:GetCaster():ModifyGoldFiltered(whole, false, 0)
        end
    end
end

function modifier_skills_bonuses:GetModifierPhysicalArmorBonus()
    return self:GetValue("armor")
end

function modifier_skills_bonuses:GetModifierMoveSpeedBonus_Constant()
    return self:GetValue("movespeed")
end

function modifier_skills_bonuses:GetModifierAttackSpeedBonus_Constant()
    return self:GetValue("attackspeed")
end

function modifier_skills_bonuses:GetModifierEvasion_Constant()
    return self:GetValue("evasion")
end

function modifier_skills_bonuses:GetModifierMagicalResistanceDirectModification()
    return self:GetValue("magical_resistance")
end

function modifier_skills_bonuses:GetModifierStatusResistanceStacking()
    return self:GetValue("status_resistance")
end

function modifier_skills_bonuses:GetModifierSpellAmplify_Percentage()
    return self:GetValue("spell_amplify")
end

function modifier_skills_bonuses:GetModifierAttackRangeBonus()
    return self:GetValue("attack_range")
end

function modifier_skills_bonuses:GetModifierCastRangeBonus()
    return self:GetValue("cast_range")
end

function modifier_skills_bonuses:GetModifierPreAttack_BonusDamage(params)
    local bonus = self:GetValue("damage")
    if _G.Players and _G.Players.QueueAttackBonus and params and params.attacker and params.target then
        _G.Players:QueueAttackBonus(params.attacker, params.target, bonus, "skills_bonuses_damage", DAMAGE_TYPE_PHYSICAL)
    end
    return bonus
end

function modifier_skills_bonuses:GetModifierHealthBonus()
    return self:GetValue("health")
end

function modifier_skills_bonuses:GetModifierManaBonus()
    return self:GetValue("mana")
end

function modifier_skills_bonuses:GetModifierProjectileSpeedBonus()
    return self:GetValue("projectile_speed")
end

function modifier_skills_bonuses:GetModifierPercentageManacostStacking()
    return self:GetValue("manacost_pct")
end

function modifier_skills_bonuses:GetModifierHealthRegenPercentage()
    return self:GetValue("health_regen_pct")
end

function modifier_skills_bonuses:GetModifierTotalPercentageManaRegen()
    return self:GetValue("mana_regen_pct")
end

function modifier_skills_bonuses:GetModifierAvoidDamage()
    local Chance = self:GetValue("universal_evasion")
    if Chance > 0 then
        if RollPercentage(Chance) then
            return 1
        end
    end
    return 0
end

function modifier_skills_bonuses:GetModifierIncomingDamage_Percentage()
    return self:GetValue("total_block") * -1
end

function modifier_skills_bonuses:GetModifierPreAttack_CriticalStrike(params)
    local Chance = self:GetValue("critical_strike")
    if Chance > 0 then
        if RollPercentage(Chance) then
            if _G.Players and _G.Players.QueueCritBonus and params and params.attacker and params.target then
                _G.Players:QueueCritBonus(params.attacker, params.target, 160, "skills_bonuses_crit")
            end
            return 160
        end
    end
    return 0
end

function modifier_skills_bonuses:FlagExist(a,b)
    local p,c,d=1,0,b
    while a>0 and b>0 do
        local ra,rb=a%2,b%2
        if ra+rb>1 then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    return c==d
end

function modifier_skills_bonuses:GetModifierTotalDamageOutgoing_Percentage(params)
    local Chance = self:GetValue("magical_critical_strike")
    if Chance <= 0 then return end

    if params.damage_type == DAMAGE_TYPE_MAGICAL then 
        if params.target == nil then return end
        if params.inflictor == nil then return end
        if self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS ) then return end
        if self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION ) then return end
        if RollPercentage(Chance) and not self:GetParent():HasModifier("modifier_magical_critical_strike_custom") and self:GetParent():IsAlive() then
            self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_magical_critical_strike_custom", {duration = 0.6})
            local critical_damage = 160
            SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, params.target, params.original_damage + (params.original_damage / 100 * (critical_damage - 100)), nil)
            return critical_damage - 100
        end
    end
end

function modifier_skills_bonuses:GetModifierBonusStats_Strength()
    local bonus = self:GetValue("all_atributes")
    if self:GetValue("main_atributes") > 0 and (self:GetParent():GetPrimaryAttribute() == 0 or self:GetParent():GetPrimaryAttribute() == 3) then
        bonus = bonus + self:GetValue("main_atributes")
    end
    if self:GetValue("other_atributes") > 0 and self:GetParent():GetPrimaryAttribute() ~= 0 then
        bonus = bonus + self:GetValue("other_atributes")
    end

    return bonus
end

function modifier_skills_bonuses:GetModifierBonusStats_Agility()
    local bonus = self:GetValue("all_atributes")
    if self:GetValue("main_atributes") > 0 and (self:GetParent():GetPrimaryAttribute() == 1 or self:GetParent():GetPrimaryAttribute() == 3) then
        bonus = bonus + self:GetValue("main_atributes")
    end
    if self:GetValue("other_atributes") > 0 and self:GetParent():GetPrimaryAttribute() ~= 1 then
        bonus = bonus + self:GetValue("other_atributes")
    end

    return bonus
end

function modifier_skills_bonuses:GetModifierBonusStats_Intellect()
    local bonus = self:GetValue("all_atributes")
    if self:GetValue("main_atributes") > 0 and (self:GetParent():GetPrimaryAttribute() == 2 or self:GetParent():GetPrimaryAttribute() == 3) then
        bonus = bonus + self:GetValue("main_atributes")
    end
    if self:GetValue("other_atributes") > 0 and self:GetParent():GetPrimaryAttribute() ~= 2 then
        bonus = bonus + self:GetValue("other_atributes")
    end

    return bonus
end

function modifier_skills_bonuses:TakeDamageScriptModifier(params)
    local Lifesteal = self:GetValue("lifesteal")
    local SpellLifesteal = self:GetValue("spell_lifesteal")
    if params.inflictor == nil and not self:GetParent():IsIllusion() and not self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION ) and Lifesteal > 0 then 
        local heal =  Lifesteal * 0.01 * params.damage
        self:GetParent():Heal(heal, nil)
    end
    if params.inflictor ~= nil and not self:GetParent():IsIllusion() and not self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION ) and SpellLifesteal > 0 then 
        local heal = SpellLifesteal * 0.01 * params.damage
        self:GetParent():Heal(heal, params.inflictor)
    end
end