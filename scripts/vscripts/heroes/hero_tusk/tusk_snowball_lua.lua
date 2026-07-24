--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tusk_snowball_lua", "heroes/hero_tusk/tusk_snowball_lua.lua", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_tusk_snowball_lua_ally", "heroes/hero_tusk/tusk_snowball_lua.lua",
    LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_tusk_snowball_lua_debuff", "heroes/hero_tusk/tusk_snowball_lua.lua", LUA_MODIFIER_MOTION_NONE)

if tusk_snowball_lua == nil then
    tusk_snowball_lua = class({}) ---@class tusk_snowball_lua : CDOTA_Ability_Lua
end

function tusk_snowball_lua:OnSpellStart()
    local hCaster = self:GetCaster()
    local hTarget = self:GetCursorTarget()

    hCaster:AddNewModifier(hCaster, self, "modifier_tusk_snowball_lua", { target_entindex = hTarget:entindex() })

    hCaster:EmitSound("Hero_Tusk.Snowball.Cast")
end

function tusk_snowball_lua:IsHiddenWhenStolen()
    return false
end

---------------------------------------------------------------------
if tusk_launch_snowball_lua == nil then
    tusk_launch_snowball_lua = class({}) ---@class tusk_launch_snowball_lua : CDOTA_Ability_Lua
end
function tusk_launch_snowball_lua:OnSpellStart()
    local hCaster = self:GetCaster()

    local hModifier = hCaster:FindModifierByName("modifier_tusk_snowball_lua")
    if IsValid(hModifier) then
        hModifier:Launch()
    end
end

function tusk_launch_snowball_lua:ProcsMagicStick()
    return false
end

function tusk_launch_snowball_lua:IsStealable()
    return false
end

---------------------------------------------------------------------
--Modifiers
if modifier_tusk_snowball_lua == nil then
    modifier_tusk_snowball_lua = class({}) ---@class modifier_tusk_snowball_lua : CDOTA_Modifier_Lua_Horizontal_Motion
end
function modifier_tusk_snowball_lua:IsHidden()
    return true
end

function modifier_tusk_snowball_lua:IsDebuff()
    return false
end

function modifier_tusk_snowball_lua:IsPurgable()
    return false
end

function modifier_tusk_snowball_lua:IsPurgeException()
    return false
end

function modifier_tusk_snowball_lua:IsStunDebuff()
    return false
end

function modifier_tusk_snowball_lua:AllowIllusionDuplicate()
    return false
end

function modifier_tusk_snowball_lua:RemoveOnDeath()
    return false
end

function modifier_tusk_snowball_lua:DestroyOnExpire()
    return false
end

function modifier_tusk_snowball_lua:OnCreated(params)
    local hParent = self:GetParent() ---@cast hParent CDOTA_BaseNPC
    self.snowball_windup_radius = self:GetAbilitySpecialValueFor("snowball_windup_radius")
    self.snowball_windup = self:GetAbilitySpecialValueFor("snowball_windup")
    self.snowball_radius = self:GetAbilitySpecialValueFor("snowball_radius")
    self.snowball_grab_radius = self:GetAbilitySpecialValueFor("snowball_grab_radius")
    self.snowball_duration = self:GetAbilitySpecialValueFor("snowball_duration")
    self.snowball_grow_rate = self:GetAbilitySpecialValueFor("snowball_grow_rate")
    self.snowball_speed = self:GetAbilitySpecialValueFor("snowball_speed")
    self.snowball_damage = self:GetAbilitySpecialValueFor("snowball_damage")
    self.snowball_damage_bonus = self:GetAbilitySpecialValueFor("snowball_damage_bonus")
    self.stun_duration = self:GetAbilitySpecialValueFor("stun_duration")
    if not IsServer() then return end

    local ability = self:GetAbility()
    if not ability then return end
    self.damage_type = ability:GetAbilityDamageType()
    self.hTarget = EntIndexToHScript(params.target_entindex) ---@type CDOTA_BaseNPC

    if IsValid(self.hTarget) and self:ApplyHorizontalMotionController() then
        self.tAllies = {}
        self.vPosition = self.hTarget:GetAbsOrigin()

        self.hTarget:AddNewModifier(hParent, ability, "modifier_tusk_snowball_lua_debuff", nil)

        hParent:AddNoDraw()
        hParent:EmitSound("Hero_Tusk.Snowball.Loop")

        if ability ~= nil and not ability:IsHidden() then
            local tusk_launch_snowball_lua = hParent:AddAbility("tusk_launch_snowball_lua")
            if tusk_launch_snowball_lua then
                tusk_launch_snowball_lua:SetLevel(ability:GetLevel())
                hParent:SwapAbilities(ability, tusk_launch_snowball_lua, false, true)
                tusk_launch_snowball_lua:SetHidden(false)
            end
        end

        self.iStartParticleID = ParticleManager:CreateParticle(
            ParticleManager:GetParticleReplacement("particles/units/heroes/hero_tusk/tusk_snowball_start.vpcf",
                hParent),
            PATTACH_CUSTOMORIGIN, nil)
        ParticleManager:SetParticleControl(self.iStartParticleID, 0, hParent:GetAbsOrigin())
        ParticleManager:SetParticleControlEnt(self.iStartParticleID, 1, self.hTarget, PATTACH_CUSTOMORIGIN_FOLLOW,
            nil, self.hTarget:GetAbsOrigin(), true)
        ParticleManager:SetParticleControl(self.iStartParticleID, 3, Vector(1, 1, self.snowball_radius))

        self.fWindupTime = GameRulesCustom:GetGameTime() + self.snowball_windup
        self:StartIntervalThink(0)
    else
        self:Destroy()
    end
end

function modifier_tusk_snowball_lua:OnRefresh(params)
    self.snowball_windup_radius = self:GetAbilitySpecialValueFor("snowball_windup_radius")
    self.snowball_windup = self:GetAbilitySpecialValueFor("snowball_windup")
    self.snowball_radius = self:GetAbilitySpecialValueFor("snowball_radius")
    self.snowball_grab_radius = self:GetAbilitySpecialValueFor("snowball_grab_radius")
    self.snowball_duration = self:GetAbilitySpecialValueFor("snowball_duration")
    self.snowball_grow_rate = self:GetAbilitySpecialValueFor("snowball_grow_rate")
    self.snowball_speed = self:GetAbilitySpecialValueFor("snowball_speed")
    self.snowball_damage = self:GetAbilitySpecialValueFor("snowball_damage")
    self.snowball_damage_bonus = self:GetAbilitySpecialValueFor("snowball_damage_bonus")
    self.stun_duration = self:GetAbilitySpecialValueFor("stun_duration")
end

function modifier_tusk_snowball_lua:OnDestroy()
    local hParent = self:GetParent()
    if IsServer() then
        hParent:RemoveHorizontalMotionController(self)

        if IsValid(self.hTarget) then
            self.hTarget:RemoveModifierByName("modifier_tusk_snowball_lua_debuff")
        end

        local tusk_launch_snowball_lua = hParent:FindAbilityByName("tusk_launch_snowball_lua")
        if tusk_launch_snowball_lua then
            hParent:SwapAbilities(self:GetAbility(), tusk_launch_snowball_lua, true, false)
            hParent:RemoveAbility(tusk_launch_snowball_lua:GetAbilityName())
            self:GetAbility():SetHidden(false)
        end

        hParent:RemoveNoDraw()

        hParent:StopSound("Hero_Tusk.Snowball.Loop")

        if self.tAllies ~= nil then
            for n, hAlly in pairs(self.tAllies) do
                if IsValid(hAlly) and hAlly:HasModifier("modifier_tusk_snowball_lua_ally") then
                    FindClearSpaceForUnit(hAlly, hParent:GetAbsOrigin(), true)
                end
            end
        end

        if IsValid(self.hTarget) then
            if not hParent:IsChanneling() then
                ExecuteOrderFromTable({
                    UnitIndex = hParent:entindex(),
                    OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
                    TargetIndex = self.hTarget:entindex(),
                })
            end
        end

        if self.iStartParticleID ~= nil then
            ParticleManager:DestroyParticle(self.iStartParticleID, true)
            self.iStartParticleID = nil
        end

        if self.iParticleID ~= nil then
            ParticleManager:DestroyParticle(self.iParticleID, false)
            self.iParticleID = nil
        end

        if hParent:IsIllusion() then
            Illusion:ClearIllusion(hParent)
        end
    end
    -- RemoveModifierEvents(MODIFIER_EVENT_ON_ORDER, self)
end

function modifier_tusk_snowball_lua:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ORDER
    }
end

function modifier_tusk_snowball_lua:Launch()
    local hParent = self:GetParent()

    ParticleManager:DestroyParticle(self.iStartParticleID, true)
    self.iStartParticleID = nil

    self.fSpeed = self.snowball_speed -- + hParent:GetTalentValue("special_bonus_unique_tusk_3")
    self.fStartTime = GameRulesCustom:GetGameTime()
    self.tTargets = {}

    local vDirection = self.vPosition - hParent:GetAbsOrigin()
    vDirection.z = 0

    self.iParticleID = ParticleManager:CreateParticle(
        ParticleManager:GetParticleReplacement("particles/units/heroes/hero_tusk/tusk_snowball.vpcf", hParent),
        PATTACH_CUSTOMORIGIN, nil)
    ParticleManager:SetParticleControl(self.iParticleID, 0, hParent:GetAttachmentOrigin(DOTA_PROJECTILE_ATTACHMENT_NONE))
    if IsValid(self.hTarget) then
        ParticleManager:SetParticleControlEnt(self.iParticleID, 1, self.hTarget, PATTACH_CUSTOMORIGIN_FOLLOW, nil,
            self.hTarget:GetAbsOrigin(), true)
    else
        ParticleManager:SetParticleControl(self.iParticleID, 1, self.vPosition)
    end
    ParticleManager:SetParticleControl(self.iParticleID, 2, Vector(self.fSpeed, 0, 0))
    ParticleManager:SetParticleControl(self.iParticleID, 3,
        Vector(self.snowball_radius, self.snowball_radius, self.snowball_radius))

    local tusk_launch_snowball_lua = hParent:FindAbilityByName("tusk_launch_snowball_lua")
    if IsValid(tusk_launch_snowball_lua) then
        local hAbility = self:GetAbility()
        if IsValid(hAbility) then
            hParent:SwapAbilities(hAbility, tusk_launch_snowball_lua, true, false)
            hAbility:SetHidden(false)
        end
        hParent:RemoveAbility(tusk_launch_snowball_lua:GetAbilityName())
    end

    self.fWindupTime = nil
    self:StartIntervalThink(-1)
end

function modifier_tusk_snowball_lua:OnIntervalThink()
    if IsServer() then
        if GameRulesCustom:GetGameTime() >= self.fWindupTime then
            self:Launch()
        end

        if IsValid(self.hTarget) then
            self.vPosition = self.hTarget:GetAbsOrigin()
        end
    end
end

function modifier_tusk_snowball_lua:UpdateHorizontalMotion(me, dt)
    local hParent = self:GetParent()
    if IsServer() then
        if self.fWindupTime ~= nil then return end
        if IsValid(self.hTarget) then
            self.vPosition = self.hTarget:GetAbsOrigin()
        end

        local vStart = hParent:GetAbsOrigin()
        local vDirection = self.vPosition - hParent:GetAbsOrigin()
        vDirection.z = 0
        local vEnd = hParent:GetAbsOrigin() + vDirection:Normalized() * self.fSpeed * dt

        hParent:SetAbsOrigin(vEnd)
        GridNav:DestroyTreesAroundPoint(vEnd, self.snowball_radius, false)

        local fTime = GameRulesCustom:GetGameTime() - self.fStartTime

        local fRadius = self.snowball_radius + self.snowball_grow_rate * fTime

        local iHero = 0
        for n, hAlly in pairs(self.tAllies) do
            if IsValid(hAlly) and hAlly:HasModifier("modifier_tusk_snowball_lua_ally") and hAlly:IsRealHero() then
                iHero = iHero + 1
            end
        end
        local fDamage = self.snowball_damage
        local tTargets = FindUnitsInLine(
            hParent:GetTeamNumber(),
            vStart,
            vEnd,
            nil,
            fRadius,
            DOTA_UNIT_TARGET_TEAM_ENEMY,
            DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
            0
        )
        for n, hTarget in pairs(tTargets) do
            if TableFindKey(self.tTargets, hTarget) == nil then
                hTarget:AddNewModifier(hParent, self:GetAbility(), "modifier_stunned", {
                    duration = self.stun_duration * hTarget:GetStatusResistanceFactor(hParent)
                })

                local tDamageTable = {
                    ability = self:GetAbility(),
                    attacker = hParent,
                    victim = hTarget,
                    damage = fDamage,
                    damage_type = self.damage_type
                }
                ApplyDamage(tDamageTable)

                EmitSoundOn(hTarget:IsHero() and "Hero_Tusk.Snowball.Stun" or "Hero_Tusk.Snowball.Stun.Small", hParent)
            end
        end
        self.tTargets = tTargets

        if fTime >= self.snowball_duration or hParent:IsPositionInRange(self.vPosition, fRadius) then
            EmitSoundOn("Hero_Tusk.Snowball.ProjectileHit", hParent)

            if IsValid(self.hTarget) and IsValid(self:GetAbility()) then
                self.hTarget:TriggerSpellReflect(self:GetAbility())
            end
            self:Destroy()
        end
    end
end

function modifier_tusk_snowball_lua:OnHorizontalMotionInterrupted()
    if IsServer() then
        self:Destroy()
    end
end

function modifier_tusk_snowball_lua:CheckState()
    return {
        [MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_MUTED] = true,
        [MODIFIER_STATE_DISARMED] = true,
    }
end

function modifier_tusk_snowball_lua:DeclareFunctions()
    return {
        -- MODIFIER_EVENT_ON_ORDER
    }
end

function modifier_tusk_snowball_lua:OnOrder(params)
    if params.unit == self:GetParent() and (params.order_type == DOTA_UNIT_ORDER_MOVE_TO_TARGET or params.order_type == DOTA_UNIT_ORDER_ATTACK_TARGET) and params.target ~= nil and UnitFilter(params.target, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_OTHER, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED + DOTA_UNIT_TARGET_FLAG_CHECK_DISABLE_HELP, params.unit:GetTeamNumber()) == UF_SUCCESS then
        if params.unit:IsPositionInRange(params.target:GetAbsOrigin(), self.snowball_grab_radius) then
            params.target:AddNewModifier(params.unit, self:GetAbility(), "modifier_tusk_snowball_lua_ally", nil)
            if TableFindKey(self.tAllies, params.target) == nil then
                table.insert(self.tAllies, params.target)
            end
        end
    end
    if self.fWindupTime ~= nil and params.unit ~= self:GetParent() and params.order_type == DOTA_UNIT_ORDER_MOVE_TO_POSITION and self:GetParent():IsPositionInRange(params.new_pos, self.snowball_windup_radius) and self.snowball_windup_radius and UnitFilter(params.unit, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED, self:GetParent():GetTeamNumber()) == UF_SUCCESS then
        if self:GetParent():IsPositionInRange(params.unit:GetAbsOrigin(), self.snowball_grab_radius) then
            params.unit:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_tusk_snowball_lua_ally", nil)
            if TableFindKey(self.tAllies, params.unit) == nil then
                table.insert(self.tAllies, params.unit)
            end
        end
    end
end

---------------------------------------------------------------------
if modifier_tusk_snowball_lua_ally == nil then
    modifier_tusk_snowball_lua_ally = class({})
end
function modifier_tusk_snowball_lua_ally:IsHidden()
    return false
end

function modifier_tusk_snowball_lua_ally:IsDebuff()
    return false
end

function modifier_tusk_snowball_lua_ally:IsPurgable()
    return false
end

function modifier_tusk_snowball_lua_ally:IsPurgeException()
    return false
end

function modifier_tusk_snowball_lua_ally:IsStunDebuff()
    return false
end

function modifier_tusk_snowball_lua_ally:AllowIllusionDuplicate()
    return false
end

function modifier_tusk_snowball_lua_ally:OnCreated(params)
    if IsServer() then
        local hCaster = self:GetCaster()
        local hParent = self:GetParent()

        if self:ApplyHorizontalMotionController() then
            local iParticleID = ParticleManager:CreateParticle(
                ParticleManager:GetParticleReplacement("particles/units/heroes/hero_tusk/tusk_snowball_load.vpcf",
                    hCaster),
                PATTACH_CUSTOMORIGIN, nil)
            ParticleManager:SetParticleControlEnt(iParticleID, 0, hParent, PATTACH_POINT_FOLLOW, "attach_hitloc",
                hParent:GetAbsOrigin(), true)
            ParticleManager:SetParticleControlEnt(iParticleID, 1, hParent, PATTACH_POINT_FOLLOW, "attach_hitloc",
                hParent:GetAbsOrigin(), true)
            ParticleManager:SetParticleControl(iParticleID, 2, hCaster:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(iParticleID)

            EmitSoundOnLocationWithCaster(hParent:GetAbsOrigin(), "Hero_Tusk.Snowball.Ally", hCaster)

            hParent:AddNoDraw()
        else
            self:Destroy()
        end
    end
end

function modifier_tusk_snowball_lua_ally:OnDestroy()
    if IsServer() then
        local hParent = self:GetParent()
        hParent:RemoveNoDraw()

        hParent:RemoveHorizontalMotionController(self)
    end
end

function modifier_tusk_snowball_lua_ally:UpdateHorizontalMotion(me, dt)
    if IsServer() then
        local hCaster = self:GetCaster()
        local hParent = self:GetParent()

        hParent:SetAbsOrigin(hCaster:GetAbsOrigin())
    end
end

function modifier_tusk_snowball_lua_ally:OnHorizontalMotionInterrupted()
    if IsServer() then
        self:Destroy()
    end
end

function modifier_tusk_snowball_lua_ally:CheckState()
    return {
        [MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    }
end

---------------------------------------------------------------------
if modifier_tusk_snowball_lua_debuff == nil then
    modifier_tusk_snowball_lua_debuff = class({})
end
function modifier_tusk_snowball_lua_debuff:IsHidden()
    return true
end

function modifier_tusk_snowball_lua_debuff:IsDebuff()
    return true
end

function modifier_tusk_snowball_lua_debuff:IsPurgable()
    return false
end

function modifier_tusk_snowball_lua_debuff:IsPurgeException()
    return false
end

function modifier_tusk_snowball_lua_debuff:IsStunDebuff()
    return false
end

function modifier_tusk_snowball_lua_debuff:AllowIllusionDuplicate()
    return false
end

function modifier_tusk_snowball_lua_debuff:GetEffectName()
    return ParticleManager:GetParticleReplacement("particles/units/heroes/hero_tusk/tusk_snowball_target.vpcf",
        self:GetCaster())
end

function modifier_tusk_snowball_lua_debuff:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

function modifier_tusk_snowball_lua_debuff:ShouldUseOverheadOffset()
    return true
end

function modifier_tusk_snowball_lua_debuff:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_PROVIDES_FOW_POSITION
    }
end

function modifier_tusk_snowball_lua_debuff:GetModifierProvidesFOWVision(params)
    return 1
end