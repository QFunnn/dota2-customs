--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_techies_land_mines_custom", "heroes/npc_dota_hero_techies_custom/techies_land_mines_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "modifier_techies_land_mines_custom_debuff", "heroes/npc_dota_hero_techies_custom/techies_land_mines_custom", LUA_MODIFIER_MOTION_NONE)

techies_land_mines_custom = class({})

techies_land_mines_custom.modifier_techies_17 = {90,180,270}
techies_land_mines_custom.modifier_techies_19 = {-0.4,-0.8}

function techies_land_mines_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_land_mine.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_land_mine_explode.vpcf", context)
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_techies.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_techies.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_techies.vpcf", context)
end

function techies_land_mines_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function techies_land_mines_custom:GetCastRange(location, target)
    return self.BaseClass.GetCastRange(self, location, target)
end

function techies_land_mines_custom:CastFilterResultLocation(point)
    if IsServer() then
        if not self:GetCaster():HasModifier("modifier_techies_18") then
            local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, self:GetSpecialValueFor("placement_radius"), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, 0, false)
            for _,unit in pairs(units) do
                if unit and unit:GetUnitName() == "npc_dota_techies_land_mine" and unit:GetOwner() == self:GetCaster() then
                    return UF_FAIL_CUSTOM
                end
            end
        end
    end
    return UF_SUCCESS
end

function techies_land_mines_custom:GetCustomCastErrorLocation(self, location)
    return "#dota_hud_error_cant_place_near_mine"
end

function techies_land_mines_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    if point == self:GetCaster():GetAbsOrigin() then
        point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector()
    end
    self:CreateMine(point)
end

function techies_land_mines_custom:CreateMine(point)
    self:GetCaster():EmitSound("Hero_Techies.RemoteMine.Plant")
    local mine = CreateUnitByName("npc_dota_techies_land_mine", point, true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
    mine:SetOwner(self:GetCaster())
    mine:AddNewModifier(self:GetCaster(), self, "modifier_techies_land_mines_custom", {})
    mine:AddNewModifier(self:GetCaster(), self, "modifier_kill", {duration = 120})
    return mine
end

modifier_techies_land_mines_custom = class({})
function modifier_techies_land_mines_custom:IsPurgable() return false end
function modifier_techies_land_mines_custom:IsPurgeException() return false end
function modifier_techies_land_mines_custom:IsHidden() return true end
function modifier_techies_land_mines_custom:OnCreated()
    self.delay_mine = self:GetAbility():GetSpecialValueFor("proximity_threshold")
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.damage = self:GetAbility():GetSpecialValueFor("damage")
    self.activation_delay = self:GetAbility():GetSpecialValueFor("activation_delay")
    if self:GetCaster():HasModifier("modifier_techies_19") then
        self.activation_delay = self.activation_delay + self:GetAbility().modifier_techies_19[self:GetCaster():GetTalentLevel("modifier_techies_19")]
    end
    self.placement_radius = self:GetAbility():GetSpecialValueFor("placement_radius")
    self.outer_damage = self:GetAbility():GetSpecialValueFor("outer_damage") / 100
    self.min_distance = self:GetAbility():GetSpecialValueFor("min_distance")
    self.burn_duration = self:GetAbility():GetSpecialValueFor("burn_duration")
    self.sound = true
    self.damage_timer = 0
    self.locked_units = 
    {
        ["npc_dota_unit_twin_gate"] = true,
        ["npc_dota_mango_tree"] = true,
        ["npc_dota_lantern"] = true,
        ["npc_dota_watch_tower"] = true,
    }
    if not IsServer() then return end
    --------------------------------------------------------------------
    -- local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_land_mine.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    -- ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    -- ParticleManager:SetParticleControl(particle, 2, Vector(0,0,0))
    -- ParticleManager:SetParticleControl(particle, 3, self:GetParent():GetAbsOrigin())
    -- self:AddParticle(particle, false, false, -1, false, false)
    --------------------------------------------------------------------
    self:GetParent():SetBaseMoveSpeed(0)
    self:GetParent():SetMoveCapability(DOTA_UNIT_CAP_MOVE_NONE)
    self:StartIntervalThink(FrameTime())
end

function modifier_techies_land_mines_custom:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetParent():IsAlive() then return end
    if self:GetElapsedTime() < self.activation_delay then return end
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false )
    for i=#enemies, 1, -1 do
        if enemies[i] and enemies[i]:IsBuilding() and self.locked_units[enemies[i]:GetUnitName()] then
            table.remove(enemies, i)
        end
    end
    if #enemies <= 0 then
        self.damage_timer = 0
        self.sound = true
        return
    end
    if self.sound then
        self.sound = false
        self:GetParent():EmitSound("Hero_Techies.RemoteMine.Priming")
    end
    for _, hero in pairs(enemies) do
        self:GetParent():AddNewModifier(hero, self:GetAbility(), "modifier_truesight", {duration = FrameTime()+FrameTime()})
    end
    if #enemies > 0 then
        self.damage_timer = self.damage_timer + FrameTime()
    end
    if self.damage_timer >= self.delay_mine then
        self:Explosion()
    end
end

function modifier_techies_land_mines_custom:Explosion()
    if not IsServer() then return end
    self:GetParent():EmitSound("Hero_Techies.StickyBomb.Detonate")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_land_mine_explode.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 2, Vector(self.radius, 1, 1))
    ParticleManager:ReleaseParticleIndex(particle)
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
    for _,enemy in pairs(enemies) do
        enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_techies_land_mines_custom_debuff", {duration = self.burn_duration * (1-enemy:GetStatusResistance())})
        local damage = self:GetDamageMine(enemy)
        if self:GetParent():HasModifier("modifier_invulnerable") then
            local techies_minefield_sign_custom = self:GetCaster():FindAbilityByName("techies_minefield_sign_custom")
            if techies_minefield_sign_custom then
                local bonus_mine_damage_pct = techies_minefield_sign_custom:GetSpecialValueFor("bonus_mine_damage_pct")
                damage = damage + (damage * (bonus_mine_damage_pct / 100))
            end
        end
        ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
    end
    AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self.radius, 1, false)
    self:GetParent():ForceKill(false)
    self:Destroy()
end

function modifier_techies_land_mines_custom:GetDamageMine(target)
    local damage = self.damage
    if self:GetCaster():HasModifier("modifier_techies_17") then
        damage = damage + (self:GetCaster():GetAgility() / 100 * self:GetAbility().modifier_techies_17[self:GetCaster():GetTalentLevel("modifier_techies_17")])
    end
    local length = (self:GetParent():GetAbsOrigin() - target:GetAbsOrigin()):Length2D()
    local max_distance = self.radius
    if length <= self.min_distance then
        return damage
    elseif length >= max_distance then
        return damage / 100 * self.outer_damage
    else
        return damage * ((max_distance - length) / (max_distance - self.min_distance) * self.outer_damage + self.outer_damage)
    end
end

function modifier_techies_land_mines_custom:CheckState()
    local state = 
    {
        [MODIFIER_STATE_INVISIBLE] = self:GetElapsedTime() >= self.activation_delay,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_ROOTED] = true,
    }
    return state
end

function modifier_techies_land_mines_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
    }
end

function modifier_techies_land_mines_custom:GetAbsoluteNoDamageMagical(params)
    if params.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then return end
    return 1
end

function modifier_techies_land_mines_custom:GetAbsoluteNoDamagePure(params)
    if params.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then return end
    return 1
end

function modifier_techies_land_mines_custom:GetAbsoluteNoDamagePhysical(params)
    if params.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then return end
    return 1
end

modifier_techies_land_mines_custom_debuff = class({})

function modifier_techies_land_mines_custom_debuff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_techies_land_mines_custom_debuff:OnCreated()
    self.mres_reduction = self:GetAbility():GetSpecialValueFor("mres_reduction") 
end

function modifier_techies_land_mines_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
    }
end

function modifier_techies_land_mines_custom_debuff:GetModifierMagicalResistanceBonus()
    return self.mres_reduction
end

function modifier_techies_land_mines_custom_debuff:GetEffectName()
    return "particles/items2_fx/veil_of_discord_debuff.vpcf"
end