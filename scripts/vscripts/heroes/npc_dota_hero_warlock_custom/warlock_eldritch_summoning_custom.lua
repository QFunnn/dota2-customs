--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_warlock_eldritch_summoning_custom", "heroes/npc_dota_hero_warlock_custom/warlock_eldritch_summoning_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_warlock_eldritch_summoning_custom_logic", "heroes/npc_dota_hero_warlock_custom/warlock_eldritch_summoning_custom", LUA_MODIFIER_MOTION_NONE)

warlock_eldritch_summoning_custom = class({})
warlock_eldritch_summoning_custom.modifier_warlock_11 = {0,30}
warlock_eldritch_summoning_custom.modifier_warlock_14 = 100

function warlock_eldritch_summoning_custom:SpawnImp(point)
    local golem = CreateUnitByName("npc_dota_warlock_minor_imp", point, true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
    local imp_health = self:GetSpecialValueFor("imp_health")
    local imp_speed = self:GetSpecialValueFor("imp_speed")
    if self:GetCaster():HasModifier("modifier_warlock_11") then
        imp_speed = imp_speed + self.modifier_warlock_11[self:GetCaster():GetTalentLevel("modifier_warlock_11")]
    end
	golem:AddNewModifier(self:GetCaster(), self, "modifier_kill", {duration = self:GetSpecialValueFor("minor_imp_duration")})
    golem:AddNewModifier(self:GetCaster(), self, "modifier_warlock_eldritch_summoning_custom_logic", {duration = self:GetSpecialValueFor("minor_imp_duration")})
    golem:SetOwner(self:GetCaster())
    golem:SetBaseMaxHealth(imp_health)
    golem:SetMaxHealth(imp_health)
    golem:SetHealth(imp_health)
    golem:SetBaseMoveSpeed(imp_speed)
end

function warlock_eldritch_summoning_custom:GetIntrinsicModifierName()
    return "modifier_warlock_eldritch_summoning_custom"
end

modifier_warlock_eldritch_summoning_custom = class({})
function modifier_warlock_eldritch_summoning_custom:IsPurgable() return false end
function modifier_warlock_eldritch_summoning_custom:IsPurgeException() return false end
function modifier_warlock_eldritch_summoning_custom:IsHidden() return true end
function modifier_warlock_eldritch_summoning_custom:RemoveOnDeath() return false end
function modifier_warlock_eldritch_summoning_custom:DeclareFunctions()
    return
    {
        MODIFIER_EVENT_ON_DEATH
    }
end
function modifier_warlock_eldritch_summoning_custom:OnDeath(params)
    local unit = params.unit
    if unit:GetTeamNumber() == self:GetParent():GetTeamNumber() then return end
    if self:GetCaster():HasModifier("modifier_warlock_1") then return end
    if self:GetParent():IsIllusion() then return end
    if not self:GetCaster():IsAlive() then return end
    local spawn_imp = false
    for _, mod in pairs(unit:FindAllModifiers()) do
        if mod and mod:GetAbility() and mod:GetAbility():GetCaster() == self:GetParent() and not mod:GetAbility():IsItem() then
            spawn_imp = true
            break
        end
    end
    if spawn_imp then
        self:GetAbility():SpawnImp(unit:GetAbsOrigin())
    end
end

modifier_warlock_eldritch_summoning_custom_logic = class({})
function modifier_warlock_eldritch_summoning_custom_logic:IsPurgable() return false end
function modifier_warlock_eldritch_summoning_custom_logic:IsPurgeException() return false end
function modifier_warlock_eldritch_summoning_custom_logic:IsHidden() return true end

function modifier_warlock_eldritch_summoning_custom_logic:CheckState()
    if not self:GetCaster():HasModifier("modifier_warlock_11") then return end
    return
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
    }
end

function modifier_warlock_eldritch_summoning_custom_logic:OnCreated()
    if not IsServer() then return end
    self.target = nil
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false)
    if #enemies > 0 then
        self.target = enemies[1]
    end
    self:StartIntervalThink(0.1)
end

function modifier_warlock_eldritch_summoning_custom_logic:OnIntervalThink()
    if not IsServer() then return end
    if self.target and self.target:IsNull() then
        self.target = nil
    elseif self.target and not self.target:IsAlive() then
        self.target = nil
    elseif self.target == nil then
        local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false)
        if #enemies > 0 then
            self.target = enemies[1]
        end
    else
        self:GetParent():MoveToPosition(self.target:GetAbsOrigin())
    end
    if self.target and not self.target:IsNull() and self.target:IsAlive() then
        local length = (self.target:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Length2D()
        if length <= 100 then
            self:Explosion()
            self:StartIntervalThink(-1)
        end
    end
end

function modifier_warlock_eldritch_summoning_custom_logic:Explosion()
    if not IsServer() then return end
    local damage = self:GetAbility():GetSpecialValueFor("imp_explode")
    if self:GetCaster():HasModifier("modifier_warlock_14") then
        damage = damage + (self:GetCaster():GetManaRegen() / 100 * self:GetAbility().modifier_warlock_14)
    end
    local tooltip_imp_explode_radius = self:GetAbility():GetSpecialValueFor("tooltip_imp_explode_radius")
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, tooltip_imp_explode_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING, 0, FIND_CLOSEST, false)
    for _,enemy in pairs(enemies) do
        ApplyDamage({ victim = enemy, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, attacker = self:GetParent(), ability = self:GetAbility()})
    end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_warlock/warlock_imp_explode.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:ReleaseParticleIndex(particle)
    self:GetParent():EmitSound("Warlock_Imp.Explode")
    UTIL_Remove(self:GetParent())
end