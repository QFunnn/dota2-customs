--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_drow_ranger_marksmanship_custom_tracker", "heroes/hero_drow_ranger/drow_ranger_marksmanship_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_marksmanship_custom_proc", "heroes/hero_drow_ranger/drow_ranger_marksmanship_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_marksmanship_custom_proc_armor", "heroes/hero_drow_ranger/drow_ranger_marksmanship_custom", LUA_MODIFIER_MOTION_NONE )

drow_ranger_marksmanship_custom = class({})

function drow_ranger_marksmanship_custom:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_marksmanship.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_marksmanship_start.vpcf", context )
end

function drow_ranger_marksmanship_custom:GetIntrinsicModifierName()
    return "modifier_drow_ranger_marksmanship_custom_tracker"
end

function drow_ranger_marksmanship_custom:GetDamage(target)
    return self:GetSpecialValueFor("bonus_damage")
end

function drow_ranger_marksmanship_custom:ApplyArmor(target)
    if not IsServer() then return end
    local caster = self:GetCaster()
    target:AddNewModifier(caster, self, "modifier_drow_ranger_marksmanship_custom_proc_armor", {duration = FrameTime()})
end

modifier_drow_ranger_marksmanship_custom_tracker = class({})
function modifier_drow_ranger_marksmanship_custom_tracker:IsHidden() return true end
function modifier_drow_ranger_marksmanship_custom_tracker:IsPurgable() return false end
function modifier_drow_ranger_marksmanship_custom_tracker:OnCreated(table)
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.damage = self.ability:GetSpecialValueFor("bonus_damage")
    self.chance = self.ability:GetSpecialValueFor("chance")
    self.agility = self.ability:GetSpecialValueFor("agility_multiplier")
    self.disable_range = self.ability:GetSpecialValueFor("disable_range")
    self.PercentAgi = 0
    self.records = {}
    if not IsServer() then return end 
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_drow/drow_marksmanship.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    self:AddParticle( self.particle, false, false, -1, false, false )
    self.agility_b = 0
    self:SetHasCustomTransmitterData(true)
    self:StartIntervalThink(0.2)
end

function modifier_drow_ranger_marksmanship_custom_tracker:OnRefresh(table)
    self.damage = self.ability:GetSpecialValueFor("bonus_damage")
    self.chance = self.ability:GetSpecialValueFor("chance")
    self.agility = self.ability:GetSpecialValueFor("agility_multiplier")
    self.disable_range = self.ability:GetSpecialValueFor("disable_range")
end

function modifier_drow_ranger_marksmanship_custom_tracker:AddCustomTransmitterData()
    self.TransmitterTable = self.TransmitterTable or {}

    self.TransmitterTable.agility_b = self.agility_b
    
    return self.TransmitterTable
end

function modifier_drow_ranger_marksmanship_custom_tracker:HandleCustomTransmitterData( data )
    self.agility_b = data.agility_b
end

function modifier_drow_ranger_marksmanship_custom_tracker:OnIntervalThink()
    if not IsServer() then return end
    self.agility_b = 0
    local agi = self:GetParent():GetAgility()
    self.agility_b = agi * self.agility / 100
    print(self.agility_b)
    self:GetParent():CalculateStatBonus(true)
    self:SendBuffRefreshToClients()
end


function modifier_drow_ranger_marksmanship_custom_tracker:CheckState()
    if not self.parent:HasModifier("modifier_drow_ranger_marksmanship_custom_proc") then return end 
    return
    {
        [MODIFIER_STATE_CANNOT_MISS] = true
    }
end


function modifier_drow_ranger_marksmanship_custom_tracker:DeclareFunctions()
    return
    {
        MODIFIER_EVENT_ON_ATTACK_START,
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
        MODIFIER_PROPERTY_PROJECTILE_NAME,
        MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS
    }
end

function modifier_drow_ranger_marksmanship_custom_tracker:GetModifierBonusStats_Agility()
	if self:GetParent():PassivesDisabled() then return end
    return self.agility_b
end

function modifier_drow_ranger_marksmanship_custom_tracker:OnAttackStart(params)
    if not IsServer() then return end
    if self.parent ~= params.attacker then return end
    self.parent:RemoveModifierByName("modifier_drow_ranger_marksmanship_custom_proc")

    -- Ванильная механика: способность НЕ срабатывает, если в радиусе
    -- disable_range от владельца есть вражеский герой.
    if self.disable_range and self.disable_range > 0 then
        local nearby_enemies = FindUnitsInRadius(
            self.parent:GetTeamNumber(),
            self.parent:GetOrigin(),
            nil,
            self.disable_range,
            DOTA_UNIT_TARGET_TEAM_ENEMY,
            DOTA_UNIT_TARGET_HERO,
            DOTA_UNIT_TARGET_FLAG_NO_INVIS,
            FIND_ANY_ORDER,
            false
        )
        if #nearby_enemies > 0 then return end
    end

    local chance = self.chance
    local proc = RollPseudoRandomPercentage(chance,4059,self.parent)
    if not proc then return end
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_drow_ranger_marksmanship_custom_proc", {})
end

function modifier_drow_ranger_marksmanship_custom_tracker:OnAttack(params)
    if not IsServer() then return end 
    if self.parent ~= params.attacker then return end 
    if not self.parent:HasModifier("modifier_drow_ranger_marksmanship_custom_proc") then return end
    self.records[params.record] = true
    self.parent:RemoveModifierByName("modifier_drow_ranger_marksmanship_custom_proc")
end

function modifier_drow_ranger_marksmanship_custom_tracker:GetModifierProcAttack_BonusDamage_Physical( params )
    if not IsServer() then return end 
    if self.parent ~= params.attacker then return end 
    local target = params.target
	if not self.records[params.record] then 
		return
	end
    self.ability:ApplyArmor(params.target)
    return self.ability:GetDamage(params.target)
end

function modifier_drow_ranger_marksmanship_custom_tracker:OnAttackRecordDestroy( params )
    self.records[params.record] = nil
end

function modifier_drow_ranger_marksmanship_custom_tracker:GetModifierProjectileName()
    if not self.parent:HasModifier("modifier_drow_ranger_marksmanship_custom_proc") then return end 
    return "particles/units/heroes/hero_drow/drow_marksmanship_attack.vpcf"
end

modifier_drow_ranger_marksmanship_custom_proc = class({})
function modifier_drow_ranger_marksmanship_custom_proc:IsHidden() return true end
function modifier_drow_ranger_marksmanship_custom_proc:IsPurgable() return false end

modifier_drow_ranger_marksmanship_custom_proc_armor = class({})
function modifier_drow_ranger_marksmanship_custom_proc_armor:IsHidden() return true end
function modifier_drow_ranger_marksmanship_custom_proc_armor:IsPurgable() return false end
function modifier_drow_ranger_marksmanship_custom_proc_armor:OnCreated()
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    self.ability = self:GetAbility()
    self.armor = self.parent:GetPhysicalArmorBaseValue()*-1
end

function modifier_drow_ranger_marksmanship_custom_proc_armor:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
end

function modifier_drow_ranger_marksmanship_custom_proc_armor:GetModifierPhysicalArmorBonus()
    return self.armor
end