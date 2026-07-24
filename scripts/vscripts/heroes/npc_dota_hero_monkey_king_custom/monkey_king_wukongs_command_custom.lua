--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_monkey_king_wukongs_command_custom_soldier_active", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_wukongs_command_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_wukongs_command_custom_thinker", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_wukongs_command_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_wukongs_command_custom_soldier", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_wukongs_command_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_wukongs_command_custom_buff", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_wukongs_command_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_wukongs_command_custom_effect", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_wukongs_command_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_wukongs_command_custom_scepter", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_wukongs_command_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_wukongs_command_custom_cooldown", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_wukongs_command_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_wukongs_command_custom_rapier", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_wukongs_command_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_wukongs_command_custom_inactive", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_wukongs_command_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_wukongs_command_custom_nodraw", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_wukongs_command_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_transfiguration_custom", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_wukongs_command_custom", LUA_MODIFIER_MOTION_NONE)

monkey_king_wukongs_command_custom = class({})
monkey_king_wukongs_command_custom.soldiers_max = 16

monkey_king_wukongs_command_custom.modifier_monkey_king_3_interval = 6
monkey_king_wukongs_command_custom.modifier_monkey_king_3_duration = {1,2,3}
monkey_king_wukongs_command_custom.modifier_monkey_king_3_bonus_duration = 2
monkey_king_wukongs_command_custom.modifier_monkey_king_3_bonus_duration_strength = 50
monkey_king_wukongs_command_custom.modifier_monkey_king_5 = {-0.1,-0.2,-0.3}
monkey_king_wukongs_command_custom.modifier_monkey_king_6 = {-15,-30,-45}

function monkey_king_wukongs_command_custom:IsHiddenWhenStolen() return false end

function monkey_king_wukongs_command_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_monkey_king_6") then
        bonus = self.modifier_monkey_king_6[self:GetCaster():GetTalentLevel("modifier_monkey_king_6")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function monkey_king_wukongs_command_custom:GetIntrinsicModifierName()
    if not self:GetCaster():IsRealHero() or self:GetCaster():IsTempestDouble() then return end
    return "modifier_monkey_king_wukongs_command_custom_scepter"
end

function monkey_king_wukongs_command_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_fur_army_cast.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_fur_army_positions.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_fur_army_attack.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_fur_army_positions.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_furarmy_ring.vpcf", context )
end

function monkey_king_wukongs_command_custom:GetCastAnimation()
    return ACT_DOTA_MK_FUR_ARMY
end

function monkey_king_wukongs_command_custom:GetCastRange(vLocation, hTarget)
    return self:GetSpecialValueFor("cast_range")
end

function monkey_king_wukongs_command_custom:GetAOERadius()
    return self:GetSpecialValueFor("second_radius")
end

function monkey_king_wukongs_command_custom:OnAbilityPhaseStart()
    self:GetCaster():EmitSound("Hero_MonkeyKing.FurArmy.Channel")
    local max = self:GetSpecialValueFor("num_first_soldiers") + self:GetSpecialValueFor("num_second_soldiers")
    if not self.soldiers or #self.soldiers < max then 
        for i = 1, self.soldiers_max do
            self:CreateSoldier(i)
        end
    end
    local particle_name = "particles/units/heroes/hero_monkey_king/monkey_king_fur_army_cast.vpcf"
    self.cast_particle = ParticleManager:CreateParticle(particle_name, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.cast_particle, 0, self:GetCaster():GetAbsOrigin())
    return true
end

function monkey_king_wukongs_command_custom:OnAbilityPhaseInterrupted()
    self:GetCaster():StopSound("Hero_MonkeyKing.FurArmy.Channel")
    if self.cast_particle ~= nil then
        ParticleManager:DestroyParticle(self.cast_particle, true)
        ParticleManager:ReleaseParticleIndex(self.cast_particle)
        self.cast_particle = nil
    end
end

function monkey_king_wukongs_command_custom:OnSpellStart()
    if not IsServer() then return end
    if self.cast_particle ~= nil then
        ParticleManager:DestroyParticle(self.cast_particle, false)
        ParticleManager:ReleaseParticleIndex(self.cast_particle)
        self.cast_particle = nil
    end
    local caster = self:GetCaster()
    local position = self:GetCursorPosition()
    local cast_range = self:GetSpecialValueFor("cast_range") + caster:GetCastRangeBonus()
    caster:RemoveModifierByName("modifier_monkey_king_tree_dance_custom")
    FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), false)
    local vDirection = position - caster:GetAbsOrigin()
    vDirection.z = 0
    position = GetGroundPosition(caster:GetAbsOrigin()+vDirection:Normalized()*math.min(vDirection:Length2D(), cast_range), caster)
    local first_radius = self:GetSpecialValueFor("first_radius")
    local second_radius = self:GetSpecialValueFor("second_radius")
    local scepter_third_radius = self:GetSpecialValueFor("scepter_third_radius")
    local num_first_soldiers = self:GetSpecialValueFor("num_first_soldiers")
    local num_second_soldiers = self:GetSpecialValueFor("num_second_soldiers")
    local duration = self:GetSpecialValueFor("duration")
    local max_radius = second_radius
    if self.thinker then
        UTIL_Remove(self.thinker)
    end
    self.thinker = CreateModifierThinker(caster, self, "modifier_monkey_king_wukongs_command_custom_thinker", {duration = duration + 0.3, radius = max_radius}, position, caster:GetTeamNumber(), false)
    caster:AddNewModifier(caster, self, "modifier_monkey_king_wukongs_command_custom_buff", {duration = duration})
    local interval = FrameTime()
    for i = 1, num_second_soldiers, 1 do
        Timers:CreateTimer((i - 1)*interval, function()
            if caster:HasModifier("modifier_monkey_king_wukongs_command_custom_buff") then
                local soldier = self:GetFreeSoldier()
                local vTargetPosition = GetGroundPosition(position + second_radius*Rotation2D(Vector(0,1,0), math.rad((i-0.25)*360/num_second_soldiers)), soldier)
                soldier:RemoveModifierByName("modifier_monkey_king_wukongs_command_custom_soldier_active")
                soldier:AddNewModifier(caster, self, "modifier_monkey_king_wukongs_command_custom_soldier_active", {position = position, radius = max_radius, target_position = vTargetPosition, ultimate = true})
            end
        end)
    end
    Timers:CreateTimer(num_first_soldiers*interval, function()
        for i = 1, num_first_soldiers, 1 do
            Timers:CreateTimer((i - 1)*interval, function()
                if caster:HasModifier("modifier_monkey_king_wukongs_command_custom_buff") then
                    local soldier = self:GetFreeSoldier()
                    local vTargetPosition = GetGroundPosition(position + first_radius*Rotation2D(Vector(0,1,0), math.rad((i-0.5)*360/num_first_soldiers)), soldier)
                    soldier:RemoveModifierByName("modifier_monkey_king_wukongs_command_custom_soldier_active")
                    soldier:AddNewModifier(caster, self, "modifier_monkey_king_wukongs_command_custom_soldier_active", {position=position, radius = max_radius, target_position=vTargetPosition, ultimate = true})
                end
            end)
        end
    end)
    self.vLastPosition = position
end

monkey_king_transfiguration_custom = class({})
monkey_king_transfiguration_custom.modifier_monkey_king_7 = 10

function monkey_king_transfiguration_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_monkey_king_7") then
        bonus = self.modifier_monkey_king_7
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function monkey_king_transfiguration_custom:OnSpellStart()
    if not IsServer() then return end
    local transfiguration_duration = self:GetSpecialValueFor("transfiguration_duration")
    local point = self:GetCursorPosition()
    local near_soldier = nil
    local monkey_king_wukongs_command_custom = self:GetCaster():FindAbilityByName("monkey_king_wukongs_command_custom")
    table.sort(monkey_king_wukongs_command_custom.soldiers, function(a, b)
        return (a:GetAbsOrigin() - point):Length2D() < (b:GetAbsOrigin() - point):Length2D()
    end)
    for _, soldier in pairs(monkey_king_wukongs_command_custom.soldiers) do
        if soldier and soldier:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier_active") then
            near_soldier = soldier
            break
        end
    end
    if near_soldier == nil then
        local player = PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID())
        if player then
            CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message="#dota_hud_error_no_target"})
        end
        self:EndCooldown()
        self:RefundManaCost() 
        return 
    end
    local second_point = near_soldier:GetAbsOrigin()
    local monkey_target = monkey_king_wukongs_command_custom:SpawnMonkeyKingPointScepter(second_point, transfiguration_duration + 0.1, true, true)
    local point_init = self:GetCaster():GetAbsOrigin()
    near_soldier:SetAbsOrigin(point_init)
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_monkey_king_transfiguration_custom", {duration = transfiguration_duration})
    self:GetCaster():SetAbsOrigin(second_point)
end

function monkey_king_wukongs_command_custom:GetFreeSoldier()
    if not IsServer() then return end
    if not self.soldiers then return end
    local new_monkey = nil
    local max_time = 0
    local j = 0 
    for i,monkey_scepter in pairs(self.soldiers) do
        local mod = monkey_scepter:FindModifierByName("modifier_monkey_king_wukongs_command_custom_soldier_active")
        if monkey_scepter and not monkey_scepter:IsNull() and not mod then
            new_monkey = monkey_scepter
            break
        end
        if mod and mod:GetElapsedTime() > max_time then 
            max_time = mod:GetElapsedTime()
            j = i
        end
    end
    if new_monkey == nil then 
        new_monkey = self.soldiers[j] 
    end
    return new_monkey
end

function monkey_king_wukongs_command_custom:CreateSoldier(count)
    if self.soldiers == nil
        then self.soldiers = {} 
    end
    if #self.soldiers >= self.soldiers_max then return end
    local caster = self:GetCaster()
    local soldier = CreateUnitByName(caster:GetUnitName(), caster:GetAbsOrigin(), false, caster, caster:GetPlayerOwner(), caster:GetTeamNumber())
    if soldier then
        for i = 0, soldier:GetAbilityCount()-1 do
        local current_ability = soldier:GetAbilityByIndex(i)
            if current_ability and current_ability:GetAbilityName() ~= "monkey_king_jingu_mastery_custom" then
                soldier:RemoveAbility(current_ability:GetName())
            end
        end
        soldier.owner = caster
        soldier:AddNewModifier(caster, self, "modifier_monkey_king_wukongs_command_custom_soldier", nil)
        table.insert(self.soldiers, soldier)
    end
end

function monkey_king_wukongs_command_custom:SpawnMonkeyKingPointScepter(point, duration, teleport, no_particle)
    if not self:GetCaster():IsRealHero() then return end
    if not self.soldiers then return end
    local new_monkey = self:GetFreeSoldier()
    if not new_monkey then return end
    new_monkey:RemoveModifierByName("modifier_monkey_king_wukongs_command_custom_soldier_active")
    local origin = nil
    if teleport then 
        origin = point
    end
    local monkey_king_jingu_mastery_custom = new_monkey:FindAbilityByName("monkey_king_jingu_mastery_custom")
    local monkey_king_jingu_mastery_custom_caster = self:GetCaster():FindAbilityByName("monkey_king_jingu_mastery_custom")
    if monkey_king_jingu_mastery_custom then
        monkey_king_jingu_mastery_custom:SetLevel(monkey_king_jingu_mastery_custom_caster:GetLevel())
        if self:GetCaster():HasModifier("modifier_monkey_king_18") then
            new_monkey:RemoveAbilityByHandle(monkey_king_jingu_mastery_custom)
            new_monkey:RemoveModifierByName("modifier_monkey_king_jingu_mastery_custom")
        end
    end
    new_monkey:AddNewModifier(self:GetCaster(), self, "modifier_monkey_king_wukongs_command_custom_soldier_active", {position=point, radius = max_radius, target_position=point, duration = duration, ultimate = false, origin = origin, no_particle = no_particle})
    return new_monkey
end

function monkey_king_wukongs_command_custom:CreateSoldiers()
    if self:GetCaster():HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then return end
    local count = 1
    if self.soldiers == nil then 
        count = 1
        self.soldiers = {} 
    else 
        count = #self.soldiers
    end
    for i = count, self.soldiers_max do
        Timers:CreateTimer("mk"..i,
            {
                useGameTime = false,
                endTime = 0.05*i,
                callback = function()
                    self:CreateSoldier(i)
                end
            }
        )
    end
end

modifier_monkey_king_wukongs_command_custom_cooldown = class({})
function modifier_monkey_king_wukongs_command_custom_cooldown:IsPurgable() return false end
function modifier_monkey_king_wukongs_command_custom_cooldown:RemoveOnDeath() return false end
function modifier_monkey_king_wukongs_command_custom_cooldown:IsDebuff() return true end

modifier_monkey_king_wukongs_command_custom_scepter = class({})
function modifier_monkey_king_wukongs_command_custom_scepter:IsHidden() return true end
function modifier_monkey_king_wukongs_command_custom_scepter:IsPurgable() return false end
function modifier_monkey_king_wukongs_command_custom_scepter:OnCreated()
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self:StartIntervalThink(0.2)
end

function modifier_monkey_king_wukongs_command_custom_scepter:OnIntervalThink()
    if not IsServer() then return end
    if not self.parent:IsRealHero() then return end
    if not self.parent:HasModifier("modifier_monkey_king_3") then return end
    if self.parent:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then return end
    if not self.parent:IsAlive() then return end
    if self.parent:IsInvisible() then return end
    if self.parent:HasModifier("modifier_generic_arc_lua") then return end
    if self.parent:HasModifier("modifier_monkey_king_tree_dance_custom") then return end
    if self.parent:HasModifier("modifier_monkey_king_tree_dance_custom_jump") then return end
    if self.parent:HasModifier("modifier_monkey_king_transform") then return end
    if self.parent:HasModifier("modifier_monkey_king_transform_courier") then return end
    if self.parent:HasModifier("modifier_monkey_king_transform_runes") then return end
    if self.parent:HasModifier("modifier_monkey_king_mischief_custom") then return end
    if self.parent:HasModifier("modifier_monkey_king_wukongs_command_custom_cooldown") then return end
    if self.parent:HasModifier("modifier_wodawisp") then return end
    if self.parent:HasModifier("modifier_wodarelax") then return end
    local duration = self:GetAbility().modifier_monkey_king_3_duration[self:GetCaster():GetTalentLevel("modifier_monkey_king_3")]
    duration = duration + (math.floor(self:GetCaster():GetStrength()/self:GetAbility().modifier_monkey_king_3_bonus_duration_strength) * self:GetAbility().modifier_monkey_king_3_bonus_duration)
    self:GetAbility():SpawnMonkeyKingPointScepter(self.parent:GetAbsOrigin()+RandomVector(RandomInt(100, 300)), duration)
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_monkey_king_wukongs_command_custom_cooldown", {duration = self:GetAbility().modifier_monkey_king_3_interval})
end

modifier_monkey_king_wukongs_command_custom_soldier_active = class({})
function modifier_monkey_king_wukongs_command_custom_soldier_active:IsHidden() return true end
function modifier_monkey_king_wukongs_command_custom_soldier_active:IsPurgable() return false end
function modifier_monkey_king_wukongs_command_custom_soldier_active:OnCreated(params)
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.caster = self:GetCaster()
    self.attack_speed = self.ability:GetSpecialValueFor("attack_speed")
    if self:GetCaster():HasModifier("modifier_monkey_king_5") then
        self.attack_speed = self.attack_speed + self:GetAbility().modifier_monkey_king_5[self:GetCaster():GetTalentLevel("modifier_monkey_king_5")]
    end
    self.move_speed = 700
    if not IsServer() then return end
    self.interval_stack = 0
    if self.caster:HasModifier("modifier_monkey_king_4") then
        self.parent:AddNewModifier(self.parent, nil, "modifier_monkey_king_4", {})
    end
    if self.caster:HasModifier("modifier_monkey_king_14") then
        self.parent:AddNewModifier(self.parent, nil, "modifier_monkey_king_14", {})
    end
    if self.caster:HasModifier("modifier_monkey_king_2") then
        self.parent:AddNewModifier(self.parent, nil, "modifier_monkey_king_2", {})
    end
    local modifier_item_book_agi = self.caster:FindModifierByName("modifier_item_book_agi")
    if modifier_item_book_agi then
        local modifier_item_book_agi_clone = self.parent:AddNewModifier(self.parent, nil, "modifier_item_book_agi", {})
        if modifier_item_book_agi_clone then
            modifier_item_book_agi_clone:SetStackCount(modifier_item_book_agi:GetStackCount())
        end
    end
    local modifier_item_book_int = self.caster:FindModifierByName("modifier_item_book_int")
    if modifier_item_book_int then
        local modifier_item_book_int_clone = self.parent:AddNewModifier(self.parent, nil, "modifier_item_book_int", {})
        if modifier_item_book_int_clone then
            modifier_item_book_int_clone:SetStackCount(modifier_item_book_int:GetStackCount())
        end
    end
    local modifier_item_book_str = self.caster:FindModifierByName("modifier_item_book_str")
    if modifier_item_book_str then
        local modifier_item_book_str_clone = self.parent:AddNewModifier(self.parent, nil, "modifier_item_book_str", {})
        if modifier_item_book_str_clone then
            modifier_item_book_str_clone:SetStackCount(modifier_item_book_str:GetStackCount())
        end
    end
    self.attack_target = nil
    self.parent:RemoveModifierByName("modifier_monkey_king_wukongs_command_custom_inactive")
    for i = 0, 17 do
        local item = self.caster:GetItemInSlot(i)
        if (i <= 5 or i >= 16) and item then
            local new_item = CreateItem(item:GetName(), nil, nil)
            local soldier_item = self.parent:AddItem(new_item)
            if soldier_item:GetName() == "item_rapier" then 
                self.parent:AddNewModifier(self.parent, nil, "modifier_monkey_king_wukongs_command_custom_rapier", {})
            end
            soldier_item:SetPurchaser(nil)
            if item and item:GetCurrentCharges() > 0 and new_item and not new_item:IsNull() then
                new_item:SetCurrentCharges(item:GetCurrentCharges())
            end
            if new_item and not new_item:IsNull() then 
                self.parent:SwapItems(new_item:GetItemSlot(), i)
            end
            if new_item and (new_item:GetName() == "item_armlet" or new_item:GetName() == "item_spear_of_mordiggian") then
                if self.caster:HasModifier("modifier_item_armlet_unholy_strength") and new_item:GetName() == "item_armlet" then
                    self.parent:AddNewModifier(self.parent, new_item, "modifier_item_armlet_unholy_strength", {})
                end
                if self.caster:HasModifier("modifier_item_spear_of_mordiggian_active") and new_item:GetName() == "item_spear_of_mordiggian" then
                    self.parent:AddNewModifier(self.parent, new_item, "modifier_item_spear_of_mordiggian_active", {})
                end
            end
        end
    end
    self.attack_range = self.parent:Script_GetAttackRange()
    self.search_radius = self.attack_range + self.parent:GetHullRadius()
    for level = 1, self.caster:GetLevel() do
        if self.parent:GetLevel() < self.caster:GetLevel() then
            self.parent:HeroLevelUp(false)
        end
    end
    for __, name in pairs(basictalents) do
        local mod = self.caster:FindModifierByName(name)
        if mod then
            local old_mod = self.parent:FindModifierByName(name)
            if not old_mod then
                old_mod = self.parent:AddNewModifier(self.parent, nil, name, {})
            end
            old_mod:SetStackCount(mod:GetStackCount())
        end
    end
    self.radius = params.radius
    if self.radius == nil then
        self.radius = 600
    end
    self.position = StringToVector(params.position)
    self.target_position = StringToVector(params.target_position)
    self.target = nil
    self.ultimate = params.ultimate
    self.origin = self.caster:GetAbsOrigin()
    if params.origin ~= nil then 
        self.origin = StringToVector(params.origin)
    end
    self.parent:SetAbsOrigin(self.origin)
    self.parent:MoveToPosition(self.target_position)
    self.parent:AddNewModifier(self.caster, self.ability, "modifier_monkey_king_wukongs_command_custom_effect", nil)
    if not params.no_particle then 
        self.particleID = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_fur_army_positions.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(self.particleID, 0, self.target_position)
        self:AddParticle(self.particleID, false, false, -1, false, false)
    end
    self:StartIntervalThink(0.1)
end

function modifier_monkey_king_wukongs_command_custom_soldier_active:CheckState()
    if self:GetStackCount() == 0 then
        return
        {
            [MODIFIER_STATE_NO_UNIT_COLLISION] = true
        }
    end
end

function modifier_monkey_king_wukongs_command_custom_soldier_active:OnIntervalThink()
    if not IsServer() then return end 
    if not IsValid(self.caster) then
        self:Destroy()
        return
    end
    if self:GetStackCount() == 0 and (self.parent:GetAbsOrigin() - self.target_position):Length2D() <= 10 then
        self:SetStackCount(1)
        FindClearSpaceForUnit(self.parent, self.target_position, false)
    end
    if self:GetStackCount() ~= 1 then return end
    if not self:CheckTarget() then 
        self:FindTarget()
    else 
        if self.parent:HasModifier("modifier_monkey_king_wukongs_command_custom_effect") then
            self.parent:RemoveModifierByName("modifier_monkey_king_wukongs_command_custom_effect")

            local particleID = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_fur_army_attack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
            ParticleManager:ReleaseParticleIndex(particleID)
        end
    end
end

function modifier_monkey_king_wukongs_command_custom_soldier_active:FindTarget()
    if not IsServer() then return end
    local targets = FindUnitsInRadius(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.search_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES+DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE+DOTA_UNIT_TARGET_FLAG_NO_INVIS+DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, FIND_CLOSEST, false)
    if #targets <= 0 then
        targets = FindUnitsInRadius(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.search_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES+DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE+DOTA_UNIT_TARGET_FLAG_NO_INVIS+DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, FIND_CLOSEST, false)
    end
    local target = targets[1]
    if target ~= nil and target:IsPositionInRange(self.position, self.radius) then
        self.attack_target = target
        self.parent:SetForceAttackTarget(self.attack_target)
        self.parent:MoveToTargetToAttack(self.attack_target)
    end 
end

function modifier_monkey_king_wukongs_command_custom_soldier_active:CheckTarget()
    if not IsServer() then return end
    if not self.attack_target or self.attack_target:IsNull() or not self.attack_target:IsAlive() or ((self.attack_target:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > (35 + self.search_radius)) or not self.attack_target:IsPositionInRange(self.position, self.radius) then
        if self.parent:GetForceAttackTarget() then
            self.parent:Stop()
            self.parent:SetForceAttackTarget(nil)
        end
        if not self.parent:HasModifier("modifier_monkey_king_wukongs_command_custom_effect") then
            self.parent:AddNewModifier(self.caster, self.ability, "modifier_monkey_king_wukongs_command_custom_effect", nil)
        end
        return false
    end 
    self.parent:SetForceAttackTarget(self.attack_target)
    self.parent:MoveToTargetToAttack(self.attack_target)
    return true
end


function modifier_monkey_king_wukongs_command_custom_soldier_active:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
        MODIFIER_PROPERTY_FIXED_ATTACK_RATE,
    }
end


function modifier_monkey_king_wukongs_command_custom_soldier_active:GetModifierFixedAttackRate()
    return self.attack_speed
end

function modifier_monkey_king_wukongs_command_custom_soldier_active:GetModifierMoveSpeed_Absolute()
    return self.move_speed
end

function modifier_monkey_king_wukongs_command_custom_soldier_active:GetActivityTranslationModifiers()
    return "run_fast"
end

function modifier_monkey_king_wukongs_command_custom_soldier_active:OnDestroy()
    if not IsServer() then return end
    if self.particleID then 
        ParticleManager:SetParticleControl(self.particleID, 0, self.parent:GetAbsOrigin())
    else 
        local particle_name = "particles/units/heroes/hero_monkey_king/monkey_king_fur_army_positions.vpcf"
        self.particleID = ParticleManager:CreateParticle(particle_name, PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(self.particleID, 0, self.parent:GetAbsOrigin())
        ParticleManager:DestroyParticle(self.particleID, false)
        ParticleManager:ReleaseParticleIndex(self.particleID)
    end 
    for _,mod in pairs(self.parent:FindAllModifiersByName("modifier_monkey_king_wukongs_command_custom_rapier")) do 
        mod:Destroy()
    end
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_monkey_king_wukongs_command_custom_inactive", {})
end

modifier_monkey_king_wukongs_command_custom_inactive = class({})
function modifier_monkey_king_wukongs_command_custom_inactive:IsHidden() return true end
function modifier_monkey_king_wukongs_command_custom_inactive:IsPurgable() return false end
function modifier_monkey_king_wukongs_command_custom_inactive:CheckState()
    return
    {
        [MODIFIER_STATE_STUNNED] = true,
    }
end

function modifier_monkey_king_wukongs_command_custom_inactive:OnCreated()
    if not IsServer() then return end 
    self.parent = self:GetParent()
    for i = 0, 18 do
        local item = self.parent:GetItemInSlot(i)
        if item then
            item:Destroy()
        end
    end
    ProjectileManager:ProjectileDodge(self.parent)
    self.mod = self.parent:AddNewModifier(self.parent, nil, "modifier_monkey_king_wukongs_command_custom_nodraw", {})
    self.parent:RemoveModifierByName("modifier_monkey_king_jingu_mastery_custom_buff")
    self.parent:RemoveModifierByName("modifier_monkey_king_jingu_mastery_custom_hit")
    self.parent:SetDayTimeVisionRange(0)
    self.parent:SetNightTimeVisionRange(0)
    self.parent:Stop()
    self.parent:SetForceAttackTarget(nil)
    self.parent:SetOrigin(Vector(-7500.25, 7594.84, 15))
end 

function modifier_monkey_king_wukongs_command_custom_inactive:OnDestroy()
    if not IsServer() then return end 
    self.parent:SetDayTimeVisionRange(600)
    self.parent:SetNightTimeVisionRange(600)
    if self.mod and not self.mod:IsNull() then 
        self.mod:SetDuration(0.1, false)
    end
end 

modifier_monkey_king_wukongs_command_custom_nodraw = class({})
function modifier_monkey_king_wukongs_command_custom_nodraw:IsHidden() return false end
function modifier_monkey_king_wukongs_command_custom_nodraw:IsPurgable() return false end
function modifier_monkey_king_wukongs_command_custom_nodraw:OnCreated()
    if not IsServer() then return end 
    self.parent = self:GetParent()
    self.parent:AddNoDraw()
end 

function modifier_monkey_king_wukongs_command_custom_nodraw:OnDestroy()
    if not IsServer() then return end 
    self.parent:RemoveNoDraw()
end 

modifier_monkey_king_wukongs_command_custom_thinker = class({})
function modifier_monkey_king_wukongs_command_custom_thinker:IsHidden() return true end
function modifier_monkey_king_wukongs_command_custom_thinker:IsPurgable() return false end
function modifier_monkey_king_wukongs_command_custom_thinker:OnCreated(params)
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    self.ability = self:GetAbility()
    self.scepter_delay = 0
    if not IsServer() then return end 
    self.radius = params.radius
    self.parent:EmitSound("Hero_MonkeyKing.FurArmy")
    local particleID = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_furarmy_ring.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particleID, 0, self.parent:GetAbsOrigin())
    ParticleManager:SetParticleControl(particleID, 1, Vector(self.radius,self.radius,self.radius))
    self:AddParticle(particleID, false, false, -1, false, false)
    self.leash_targets = {}
    self:StartIntervalThink(1)
    self.modifier_monkey_king_7 = self:GetCaster():HasModifier("modifier_monkey_king_7")
    if not self.modifier_monkey_king_7 then
        self:GetCaster():SwapAbilities("monkey_king_wukongs_command_custom", "monkey_king_transfiguration_custom", false, true)
        local monkey_king_transfiguration_custom = self:GetCaster():FindAbilityByName("monkey_king_transfiguration_custom")
        if not monkey_king_transfiguration_custom:IsTrained() then
            monkey_king_transfiguration_custom:SetLevel(1)
        end
    end
end

function modifier_monkey_king_wukongs_command_custom_thinker:OnDestroy()
    if not IsServer() then return end
    if not self.modifier_monkey_king_7 then
        self:GetCaster():SwapAbilities("monkey_king_transfiguration_custom", "monkey_king_wukongs_command_custom", false, true)
    end
    for n, soldier in pairs(self.ability.soldiers) do
        local mod = soldier:FindModifierByName("modifier_monkey_king_wukongs_command_custom_soldier_active")
        if mod and mod.ultimate == 1 then 
            soldier:RemoveModifierByName("modifier_monkey_king_wukongs_command_custom_soldier_active")
        end
    end
    if not IsValid(self.caster) or not IsValid(self.parent)  then
        return
    end
    self.caster:RemoveModifierByName("modifier_monkey_king_wukongs_command_custom_buff")
    self.parent:StopSound("Hero_MonkeyKing.FurArmy")
    EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "Hero_MonkeyKing.FurArmy.End", self.caster)
    self.parent:RemoveSelf()
end

function modifier_monkey_king_wukongs_command_custom_thinker:OnIntervalThink()
    if not IsServer() then return end
    if not IsValid(self.caster) or not IsValid(self.parent) then
        self:Destroy()
        return
    end
    local caster_near = self.caster:IsPositionInRange(self.parent:GetAbsOrigin(), self.radius)
    if not self.caster:HasModifier("modifier_monkey_king_wukongs_command_custom_buff") or (not caster_near) then
        self:Destroy()
    end
    self:StartIntervalThink(0.1)
end

function modifier_monkey_king_wukongs_command_custom_thinker:CheckState()
    return 
    {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
    }
end

modifier_monkey_king_wukongs_command_custom_soldier = class({})
function modifier_monkey_king_wukongs_command_custom_soldier:IsHidden() return true end
function modifier_monkey_king_wukongs_command_custom_soldier:IsPurgable() return false end
function modifier_monkey_king_wukongs_command_custom_soldier:OnCreated(params)
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    if not IsServer() then return end 
    self.parent:AddNewModifier(self.parent, nil, "modifier_monkey_king_wukongs_command_custom_inactive", {})
    self.jingu = self.caster:FindModifierByName("modifier_monkey_king_jingu_mastery_custom_thinker")
    self.command = self.caster:FindModifierByName("modifier_monkey_king_wukongs_command_custom_scepter")
    self.primal = self.caster:FindModifierByName("modifier_monkey_king_primal_spring_custom_tracker")
end

function modifier_monkey_king_wukongs_command_custom_soldier:CheckState()
    return 
    {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_UNSLOWABLE] = true,
        [MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_UNTARGETABLE] = true,
    }
end


function modifier_monkey_king_wukongs_command_custom_soldier:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
        MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
        MODIFIER_PROPERTY_TEMPEST_DOUBLE,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
    }
end

function modifier_monkey_king_wukongs_command_custom_soldier:GetModifierTempestDouble() 
    return 1 
end

function modifier_monkey_king_wukongs_command_custom_soldier:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_monkey_king_wukongs_command_custom_soldier:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_monkey_king_wukongs_command_custom_soldier:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_monkey_king_wukongs_command_custom_soldier:GetActivityTranslationModifiers()
    if self.parent:HasModifier("modifier_monkey_king_mischief_anim") then return end
    return "fur_army_soldier"
end

function modifier_monkey_king_wukongs_command_custom_soldier:GetDisableAutoAttack()
    return 1
end

modifier_monkey_king_wukongs_command_custom_buff = class({})
function modifier_monkey_king_wukongs_command_custom_buff:IsHidden() return false end
function modifier_monkey_king_wukongs_command_custom_buff:IsPurgable() return false end
function modifier_monkey_king_wukongs_command_custom_buff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    }
end

function modifier_monkey_king_wukongs_command_custom_buff:OnCreated(table)
    self.parent = self:GetParent()
    self.armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_monkey_king_wukongs_command_custom_buff:GetModifierPhysicalArmorBonus()
    return self.armor
end

modifier_monkey_king_wukongs_command_custom_effect = class({})
function modifier_monkey_king_wukongs_command_custom_effect:IsHidden() return true end
function modifier_monkey_king_wukongs_command_custom_effect:IsPurgable() return false end
function modifier_monkey_king_wukongs_command_custom_effect:GetStatusEffectName()
    return "particles/status_fx/status_effect_monkey_king_fur_army.vpcf"
end

function modifier_monkey_king_wukongs_command_custom_effect:StatusEffectPriority()
    return MODIFIER_PRIORITY_ILLUSION
end

modifier_monkey_king_wukongs_command_custom_rapier = class({})
function modifier_monkey_king_wukongs_command_custom_rapier:IsHidden() return true end
function modifier_monkey_king_wukongs_command_custom_rapier:IsPurgable() return false end
function modifier_monkey_king_wukongs_command_custom_rapier:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_monkey_king_wukongs_command_custom_rapier:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
end

function modifier_monkey_king_wukongs_command_custom_rapier:GetModifierPreAttack_BonusDamage()
    return 300
end

modifier_monkey_king_transfiguration_custom = class({})
function modifier_monkey_king_transfiguration_custom:IsHidden() return false end
function modifier_monkey_king_transfiguration_custom:IsPurgable() return false end
function modifier_monkey_king_transfiguration_custom:CheckState()
    return
    {
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_MUTED] = true,
        [MODIFIER_STATE_SILENCED] = true,
        [MODIFIER_STATE_ROOTED] = true,
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    }
end
function modifier_monkey_king_transfiguration_custom:OnCreated()
    if not IsServer() then return end
    self:GetParent():AddNoDraw()
    self:GetParent():EmitSound("Hero_MonkeyKing.Transfigure.On")
end
function modifier_monkey_king_transfiguration_custom:OnDestroy()
    if not IsServer() then return end
    self:GetParent():RemoveNoDraw()
    self:GetParent():EmitSound("Hero_MonkeyKing.Transfigure.Off")
end

function string.split(str, delimiter)
	if str == nil or str == "" or delimiter == nil then
		return nil
	end

	local result = {}
	for match in (str..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end
	return result
end

function string.gsplit(str)
	local str_tb = {}
	if string.len(str) ~= 0 then
		for i=1,string.len(str) do
			new_str= string.sub(str,i,i)			
			if (string.byte(new_str) >=48 and string.byte(new_str) <=57) or (string.byte(new_str)>=65 and string.byte(new_str)<=90) or (string.byte(new_str)>=97 and string.byte(new_str)<=122) then
				table.insert(str_tb,string.sub(str,i,i))				
			else
				return nil
			end
		end
		return str_tb
	else
		return nil
	end
end

function IsValid(h)
	return h ~= nil and not h:IsNull()
end

function Rotation2D(vVector, radian)
	local fLength2D = vVector:Length2D()
	local vUnitVector2D = vVector / fLength2D
	local fCos = math.cos(radian)
	local fSin = math.sin(radian)
	return Vector(vUnitVector2D.x*fCos-vUnitVector2D.y*fSin, vUnitVector2D.x*fSin+vUnitVector2D.y*fCos, vUnitVector2D.z)*fLength2D
end

function StringToVector(str)
	if str == nil then return end
	local table = string.split(str, " ")
	return Vector(tonumber(table[1]), tonumber(table[2]), tonumber(table[3])) or nil
end