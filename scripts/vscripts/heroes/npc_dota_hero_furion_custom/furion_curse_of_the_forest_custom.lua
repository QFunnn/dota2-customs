--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_furion_curse_of_the_forest_custom",  "heroes/npc_dota_hero_furion_custom/furion_curse_of_the_forest_custom", LUA_MODIFIER_MOTION_NONE )

furion_curse_of_the_forest_custom = class({})

function furion_curse_of_the_forest_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_furion/furion_curse_of_forest_cast.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_furion/furion_curse_of_forest_debuff.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_furion.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_furion.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_furion.vpcf", context)
end

function furion_curse_of_the_forest_custom:GetCastRange(vLocation, hTarget)
    if IsClient() then
        return self:GetSpecialValueFor("range")
    end
end

function furion_curse_of_the_forest_custom:OnSpellStart()
    if not IsServer() then return end

    local duration = self:GetSpecialValueFor("duration")
    local damage_per_tree = self:GetSpecialValueFor("damage_per_tree")
    local slow_per_tree = self:GetSpecialValueFor("slow_per_tree")
    local range = self:GetSpecialValueFor("range")

    local cast_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_furion/furion_curse_of_forest_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControl(cast_particle, 0, self:GetCaster():GetAbsOrigin())
    ParticleManager:SetParticleControl(cast_particle, 1, Vector(range,range,range))

    self:GetCaster():EmitSound("Hero_Furion.CurseOfTheForest.Cast")

    local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
    for _, enemy in pairs(enemies) do
        enemy:AddNewModifier(self:GetCaster(), self, "modifier_furion_curse_of_the_forest_custom", {duration = duration * (1-enemy:GetStatusResistance())})
        enemy:EmitSound("Hero_Furion.CurseOfTheForest.Target")
    end
end

modifier_furion_curse_of_the_forest_custom = class({})

function modifier_furion_curse_of_the_forest_custom:OnCreated(params)
    if not IsServer() then return end
    self.count = 0
    self.damage = self:GetAbility():GetSpecialValueFor("damage_per_tree")
    self.slow = self:GetAbility():GetSpecialValueFor("slow_per_tree")
    self.interval = 0
    self:SetHasCustomTransmitterData(true)
    self:SendBuffRefreshToClients()
    self:StartIntervalThink(FrameTime())
end

function modifier_furion_curse_of_the_forest_custom:AddCustomTransmitterData()
    return 
    {
        slow = self.slow,
        count = self.count,
    }
end

function modifier_furion_curse_of_the_forest_custom:HandleCustomTransmitterData( data )
    self.slow = data.slow
    self.count = data.count
end

function modifier_furion_curse_of_the_forest_custom:OnIntervalThink()
    if not IsServer() then return end

    local count = 0

    local radius = self:GetAbility():GetSpecialValueFor("radius")

    local trees = GridNav:GetAllTreesAroundPoint(self:GetParent():GetAbsOrigin(), radius, false)
    local count = #trees
    for _, unit in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED, FIND_ANY_ORDER, false)) do
        if unit and unit:GetOwner() == self:GetCaster() and (unit:GetUnitName() == "npc_dota_furion_treant_1" or unit:GetUnitName() == "npc_dota_furion_treant_2" or unit:GetUnitName() == "npc_dota_furion_treant_3" or unit:GetUnitName() == "npc_dota_furion_treant_4") then  
            count = count + 1         
        end
    end

    if not self:GetParent():IsInvisible() or (self:GetParent():IsInvisible() and self:GetCaster():CanEntityBeSeenByMyTeam(self:GetParent())) then
        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), 50, FrameTime(), true)
    end

    local max = math.min(#trees, 24)

    self.count = max + count

    self.interval = self.interval + FrameTime()

    local damage = 
    {
        victim = self:GetParent(),
        attacker = self:GetCaster(),
        damage = self.damage * self.count,
        damage_type = DAMAGE_TYPE_MAGICAL,
        ability = self:GetAbility()
    }

    if self.interval >= 1 then
        self.interval = 0
        self:GetParent():EmitSound("Hero_Furion.CurseOfTheForest.Damage")
        ApplyDamage( damage )
    end

    self:SendBuffRefreshToClients()
end

function modifier_furion_curse_of_the_forest_custom:GetEffectName()
    return "particles/units/heroes/hero_furion/furion_curse_of_forest_debuff.vpcf"
end

function modifier_furion_curse_of_the_forest_custom:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_furion_curse_of_the_forest_custom:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_furion_curse_of_the_forest_custom:GetModifierMoveSpeedBonus_Percentage()
    return self.slow * self.count
end