--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if furion_force_of_nature_lua == nil then
    furion_force_of_nature_lua = class({}) ---@class furion_force_of_nature_lua : CDOTA_Ability_Lua
end

LinkLuaModifier("modifier_furion_force_of_nature_lua", "heroes/hero_furion/furion_force_of_nature_lua",
    LUA_MODIFIER_MOTION_NONE)

function furion_force_of_nature_lua:CastFilterResultLocation(vlocation)
    local hCaster = self:GetCaster()
    if IsServer() then
        if #(GridNav:GetAllTreesAroundPoint(vlocation, self:GetSpecialValueFor("area_of_effect"), false)) == 0 then
            return UF_FAIL_CUSTOM
        end
    end
    return UF_SUCCESS
end

function furion_force_of_nature_lua:GetCustomCastErrorLocation(vLocation)
    return "dota_hud_error_must_target_tree"
end

function furion_force_of_nature_lua:GetAOERadius()
    return self:GetSpecialValueFor("area_of_effect")
end

function furion_force_of_nature_lua:GetBehavior()
    local hCaster = self:GetCaster()
    if hCaster:HasModifier("modifier_item_aghanims_shard") then
        return tonumber(tostring(self.BaseClass.GetBehavior(self))) + DOTA_ABILITY_BEHAVIOR_AUTOCAST
    else
        return tonumber(tostring(self.BaseClass.GetBehavior(self)))
    end
end

function furion_force_of_nature_lua:OnSpellStart()
    local hCaster = self:GetCaster()
    local vLoc = self:GetCursorPosition()
    local radius = self:GetSpecialValueFor("area_of_effect")
    local duration = self:GetSpecialValueFor("duration")
    local treant_health = self:GetSpecialValueFor("treant_health")
    local treant_dmg = self:GetSpecialValueFor("treant_dmg")
    local max_treants = self:GetSpecialValueFor("max_treants")
    local shard_max_treants = self:GetSpecialValueFor("shard_max_treants")
    local max_wave_limit = self:GetSpecialValueFor("max_wave_limit")
    local attri_multi = self:GetSpecialValueFor("attri_multi")
    local trees = GridNav:GetAllTreesAroundPoint(vLoc, self:GetSpecialValueFor("area_of_effect"), false)

    if self.treants == nil then
        self.treants = {}
    end
    if self.treants_large == nil then
        self.treants_large = {}
    end

    local unit_name = "npc_dota_furion_treant"
    if self:GetAutoCastState() == true then
        unit_name = "npc_dota_furion_treant_large"
        max_treants = shard_max_treants
        treant_dmg = treant_dmg * attri_multi
        treant_health = treant_health * attri_multi
        for i = #self.treants, 1, -1 do
            if (not IsValid(self.treants[i])) or (not self.treants[i]:IsAlive()) then
                table.remove(self.treants, i)
            else
                self.treants[i]:Kill(self, hCaster)
                table.remove(self.treants, i)
            end
        end
    else
        for i = #self.treants_large, 1, -1 do
            if (not IsValid(self.treants_large[i])) or (not self.treants_large[i]:IsAlive()) then
                table.remove(self.treants_large, i)
            else
                self.treants_large[i]:Kill(self, hCaster)
                table.remove(self.treants_large, i)
            end
        end
    end


    local count = 0
    for _, tree in pairs(trees) do
        if count < max_treants then
            if IsValid(tree) then
                CreateUnitByNameAsync(unit_name, tree:GetAbsOrigin(), true, hCaster, hCaster, hCaster:GetTeamNumber(),
                    function(
                        unit)
                        unit:SetControllableByPlayer(hCaster:GetPlayerOwnerID(), false)
                        unit:AddNewModifier(hCaster, self, "modifier_furion_force_of_nature_lua", { duration = duration })
                        unit:SetBaseDamageMin(treant_dmg)
                        unit:SetBaseDamageMax(treant_dmg)
                        unit:SetBaseMaxHealth(treant_health)
                        unit:SetMaxHealth(treant_health)
                        unit:SetHealth(treant_health)
                        if IsValid(self) and self:GetAutoCastState() then
                            if unit:HasAbility("treant_large_tree_grab") then
                                unit:FindAbilityByName("treant_large_tree_grab"):SetLevel(1)
                            end
                            if unit:HasAbility("treant_large_entangle") then
                                unit:FindAbilityByName("treant_large_entangle"):SetLevel(1)
                            end
                            table.insert(self.treants_large, unit)
                            local treant_count = 0
                            for i = #self.treants_large, 1, -1 do
                                if (not IsValid(self.treants_large[i])) or (not self.treants_large[i]:IsAlive()) then
                                    table.remove(self.treants_large, i)
                                else
                                    treant_count = treant_count + 1
                                    if treant_count > max_treants * max_wave_limit then
                                        self.treants_large[i]:Kill(self, hCaster)
                                        table.remove(self.treants_large, i)
                                    end
                                end
                            end
                        else
                            table.insert(self.treants, unit)
                            local treant_count = 0
                            for i = #self.treants, 1, -1 do
                                if (not IsValid(self.treants[i])) or (not self.treants[i]:IsAlive()) then
                                    table.remove(self.treants, i)
                                else
                                    treant_count = treant_count + 1
                                    if treant_count > max_treants * max_wave_limit then
                                        self.treants[i]:Kill(self, hCaster)
                                        table.remove(self.treants, i)
                                    end
                                end
                            end
                        end
                    end)
                count = count + 1
            end
        else
            break
        end
    end

    GridNav:DestroyTreesAroundPoint(vLoc, radius, false)
end

-------------------------modifier-----------------------
modifier_furion_force_of_nature_lua = class({}) ---@class modifier_furion_force_of_nature_lua : CDOTA_Modifier_Lua
function modifier_furion_force_of_nature_lua:IsDebuff()
    return true
end

function modifier_furion_force_of_nature_lua:IsHidden()
    return true
end

function modifier_furion_force_of_nature_lua:IsPurgable()
    return false
end

function modifier_furion_force_of_nature_lua:OnDestroy()
    if IsServer() then
        self:GetParent():ForceKill(false)
    end
end

function modifier_furion_force_of_nature_lua:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_LIFETIME_FRACTION
    }

    return funcs
end

function modifier_furion_force_of_nature_lua:GetUnitLifetimeFraction(params)
    return ((self:GetDieTime() - GameRules:GetGameTime()) / self:GetDuration())
end