--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require( 'talents_values')


function C_DOTA_BaseNPC:IsOnDuel()
return false
end 

function C_DOTA_BaseNPC:PrintTalents()
DeepPrintTable(active_talents)
end

function C_DOTA_BaseNPC:IsCreepHero()
return self:HasModifier("modifier_life_stealer_infest_custom_legendary_creep") or (self:IsCreep() and self:IsConsideredHero())
end


function C_DOTA_BaseNPC:IsTree()
return false
end

function C_DOTA_BaseNPC:IsUnit()
return not self:IsNull() 
    and (self:IsHero() or self:IsCreep() or self.is_crystal) 
    and self:GetUnitName() ~= "npc_teleport" 
    and not self.is_hero_icon 
    and self:GetUnitName() ~= "npc_dota_donate_item_illusion"
    and not self:HasModifier("modifier_bounty_map")
end


function C_DOTA_BaseNPC:IsTempest()
return self:HasModifier("modifier_arc_warden_tempest_double_custom") or self:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier")
end

function C_DOTA_BaseNPC:TalentLevel(talent)

local player_id = self:GetUnitName() -- self:GetPlayerOwnerID()


if self:HasModifier(talent) then 
    return self:GetModifierStackCount(talent, self)
end 

if not active_talents[player_id] then return 0 end
if not active_talents[player_id][talent] then return 0 end

return active_talents[player_id][talent].level
end




function C_DOTA_BaseNPC:HasTalent(talent)
if not self or self:IsNull() then return false end

local player_id = self:GetUnitName() -- self:GetPlayerOwnerID()

if self:HasModifier(talent) then return true end
if not active_talents[player_id] then return false end
if not active_talents[player_id][talent] then return false end

if (self:IsIllusion() or self:IsTempest()) and (not active_talents[player_id][talent].allow_illusion or active_talents[player_id][talent].allow_illusion ~= 1) then 
    return false
end

return true
end

function C_DOTA_BaseNPC:AddTalent(talent, new_level)
if self:IsRealHero() and not self:IsTempest() then
    local player_id = self:GetUnitName() -- self:GetPlayerOwnerID()

    if not active_talents[player_id] then 
        active_talents[player_id] = {}
    end 

    if not active_talents[player_id][talent] then 
        active_talents[player_id][talent] = {}
        active_talents[player_id][talent].level = 1

        if self:GetTalentValue(talent, "allow_illusion") ~= 0 then 
            active_talents[player_id][talent].allow_illusion = self:GetTalentValue(talent, "allow_illusion")
        end
    else 
        active_talents[player_id][talent].level = active_talents[player_id][talent].level + 1
    end

    if new_level then 
        active_talents[player_id][talent].level = new_level
    end
end

local update_mod = self:GetTalentValue(talent, "update_mod")

if update_mod and update_mod == "modifier_general_stats" then
    local ability = self:FindAbilityByName("custom_general_talents")
    if ability and ability.UpdateTalents then
        ability:UpdateTalents(talent)
    end
else
    if self.base_abilities then
        for _,name in pairs(self.base_abilities) do
            local ability = self:FindAbilityByName(name)
            if ability and ability.UpdateTalents and ability:IsTrained() then
                ability:UpdateTalents(talent)
            end
        end
    end
end

end



function C_DOTA_BaseNPC:GetTalentValue(name, property, ignore_level)

local hero_table = nil

if ingame_talents[self:GetUnitName()] and ingame_talents[self:GetUnitName()][name] then
    hero_table = ingame_talents[self:GetUnitName()]
elseif ingame_talents["general"][name] then 
    hero_table = ingame_talents["general"]
elseif ingame_talents["broodmother_spiders"] and ingame_talents["broodmother_spiders"][name] then
    hero_table = ingame_talents["broodmother_spiders"]
elseif ingame_talents["invoker_spells"] and ingame_talents["invoker_spells"][name] then
    hero_table = ingame_talents["invoker_spells"]
elseif ingame_talents["patrol"][name] then
    hero_table = ingame_talents["patrol"]
elseif talents_heroes[name] and ingame_talents[talents_heroes[name]] then
    hero_table = ingame_talents[talents_heroes[name]]
end

if not hero_table then return 0 end

local talent_table = hero_table[name]

if not talent_table then return 0 end

local value = talent_table[property]

if not value then return 0 end

if ignore_level and ignore_level == true and type(value) ~= "table" then 
    return value
end 

if not self:HasTalent(name) then return 0 end
if property == "update_mod" then
    return value
end

local level = self:TalentLevel(name)

if level == 0 then return 0 end

if type(value) == "table" then
    return value[level]
else
    if property == "general_bonus" then 
        return value*level
    else
        return value
    end
end

return 0
end



function C_DOTA_BaseNPC:UpdateTalentsClient()


end




function C_DOTA_BaseNPC:UpdateUIshort(params)

end


function C_DOTA_BaseNPC:UpdateUIlong(params)

end



function C_DOTA_BaseNPC:GetId()
local id = self:GetPlayerOwnerID()
if self.owner then
    id = self.owner:GetPlayerOwnerID()
end
return id
end


function C_DOTA_BaseNPC:GetValueQuas(ability, value)
local quas = self:FindAbilityByName("invoker_quas_custom")
local level = 0
if quas then
    level = quas:GetLevel() - 1
    if self.invoke_ability and self.invoke_ability.talents.has_r4 == 1 then  
        level = level + self.invoke_ability.talents.r4_level
    end 
else
    local quas_mod = self:GetUpgradeStack("modifier_morphling_replicate_custom_quas")
    if quas_mod then
        level = math.max(0, quas_mod - 1)
    end
end
if self:HasTalent("modifier_slark_essence_7") or self:HasTalent("modifier_terror_reflection_7") then
    level = 7
end
return ability:GetLevelSpecialValueFor(value, level)
end


function C_DOTA_BaseNPC:GetValueWex(ability, value)
local wex = self:FindAbilityByName("invoker_wex_custom")
local level = 0
if wex then
    level = wex:GetLevel() - 1
    if self.invoke_ability and self.invoke_ability.talents.has_r4 == 1 then  
        level = level + self.invoke_ability.talents.r4_level
    end   
else
    local wex_mod = self:GetUpgradeStack("modifier_morphling_replicate_custom_wex")
    if wex_mod then
        level = math.max(0, wex_mod - 1)
    end
end
if self:HasTalent("modifier_slark_essence_7") then
    level = 7
end
return ability:GetLevelSpecialValueFor(value, level)
end


function C_DOTA_BaseNPC:GetValueExort(ability, value)
local exort = self:FindAbilityByName("invoker_exort_custom")
local level = 0

if exort then
    level = exort:GetLevel() - 1
    if self.invoke_ability and self.invoke_ability.talents.has_r4 == 1 then  
        level = level + self.invoke_ability.talents.r4_level
    end 
else
    local exort_mod = self:GetUpgradeStack("modifier_morphling_replicate_custom_exort")
    if exort_mod then
        level = math.max(0, exort_mod - 1)
    end
end
if self:HasTalent("modifier_slark_essence_7") then
    level = 7
end
return ability:GetLevelSpecialValueFor(value, level)
end


function C_DOTA_Ability_Lua:Init()
if not self:GetCaster() then return end
self.caster = self:GetCaster()
self.ability = self
self.parent = self:GetCaster()
end

function C_DOTA_BaseNPC:CheckCd(name, cd)

end

function C_DOTA_BaseNPC:AddAttackEvent_out(new_mod) end
function C_DOTA_BaseNPC:AddAttackEvent_inc(new_mod) end

function C_DOTA_BaseNPC:AddAttackStartEvent_out(mod) end
function C_DOTA_BaseNPC:AddAttackStartEvent_inc(mod) end

function C_DOTA_BaseNPC:AddAttackRecordEvent_out(mod) end
function C_DOTA_BaseNPC:AddAttackRecordEvent_inc(mod) end

function C_DOTA_BaseNPC:AddAttackFailEvent_out(mod) end
function C_DOTA_BaseNPC:AddAttackFailEvent_inc(mod) end

function C_DOTA_BaseNPC:AddRecordDestroyEvent(mod) end
function C_DOTA_BaseNPC:AddAttackCreateEvent(mod) end

function C_DOTA_BaseNPC:AddDamageEvent_out(new_mod) end
function C_DOTA_BaseNPC:AddDamageEvent_inc(new_mod) end

function C_DOTA_BaseNPC:AddHealEvent_inc(new_mod) end

function C_DOTA_BaseNPC:AddSpellStartEvent(mod) end
function C_DOTA_BaseNPC:AddSpellEvent(mod) end
function C_DOTA_BaseNPC:AddDeathEvent(mod) end
function C_DOTA_BaseNPC:AddRespawnEvent(mod) end
function C_DOTA_BaseNPC:AddOrderEvent(mod) end

function C_DOTA_BaseNPC:AddPercentStat(stat, amount, mod) end



function C_DOTA_BaseNPC:IsTalentIllusion()
return self:HasModifier("modifier_skeleton_king_hellfire_blast_custom_illusion") 
end


function C_DOTA_BaseNPC:GetUpgradeStack( mod )
if self:HasModifier(mod) then 
			
	return self:GetModifierStackCount(mod, self)
else return 0 end 

end

function C_DOTA_BaseNPC:HasShard()
    if self:HasModifier("modifier_item_aghanims_shard") then
        return true
    end

    return false
end



function C_DOTA_BaseNPC:GetDisplayAttackSpeedClient()

    return self:GetDisplayAttackSpeed()
end






function C_DOTA_BaseNPC:UpgradeIllusion(mod, stack  )

    local i = self:AddNewModifier(self, nil, mod, {})

    i:SetStackCount(stack)
end


function C_DOTA_BaseNPC:SetQuest(table)

self.quest = {}
self.quest.name = table.name and table.name or ""
self.quest.exp = table.exp and table.exp or 0
self.quest.shards = table.shards and table.shards or 0
self.quest.icon = table.icon and table.icon or ""
self.quest.goal = table.goal and table.goal or 0
self.quest.legendary = table.legendary
self.quest.number = table.number and table.number or 0
self.quest.progress = 0
self.quest.completed = 0

end






function C_DOTA_BaseNPC:QuestCompleted()

local complete = false

if self.quest and self.quest.completed == 1 then 
    complete = true
end

return complete
end



function C_DOTA_BaseNPC:GetQuest()
local name = nil 

if self.quest and self.quest.name then 
    name = self.quest.name
end

return name
end



function C_DOTA_BaseNPC:IsPatrolCreep()
if self:GetUnitName() == "patrol_melee_good" or 
    self:GetUnitName() == "patrol_range_good" or 
    self:GetUnitName() == "patrol_melee_bad" or
    self:GetUnitName() == "patrol_range_bad" then return true end

return false

end


function C_DOTA_BaseNPC:GenericParticle()

end


function C_DOTA_BaseNPC:GenericHeal(heal, ability, no_text)

end


function C_DOTA_BaseNPC:HasAbility(name)
local ability = self:FindAbilityByName(name)
if ability then
    return true
else
    return false
end

end

C_DOTA_BaseNPC_Hero.GetIntellect_old = C_DOTA_BaseNPC_Hero.GetIntellect
function C_DOTA_BaseNPC_Hero:GetIntellect(arg, is_ogre)
if IsValid(self.ogre_innate) and not is_ogre then
    return self:GetStrength()
end
return self:GetIntellect_old(arg)
end

function C_DOTABaseAbility:IsTrained()
return self:GetLevel() > 0
end

function C_DOTABaseAbility:GetState()
return self:GetAutoCastState()
end

C_DOTA_Ability_Lua.GetCastRangeBonus = function(self, hTarget)
    if(not self or self:IsNull() == true) then
        return 0
    end
    local caster = self:GetCaster()
    if(not caster or caster:IsNull() == true) then
        return 0
    end
    return caster:GetCastRangeBonus()
end
 
C_DOTABaseAbility.GetCastRangeBonus = function(self, hTarget)
    if(not self or self:IsNull() == true) then
        return 0
    end
    local caster = self:GetCaster()
    if(not caster or caster:IsNull() == true) then
        return 0
    end
    return caster:GetCastRangeBonus()
end



function C_DOTA_Item:EndCd(new_cd)

end

function C_DOTA_Ability_Lua:EndCd(new_cd)

end

function C_DOTABaseAbility:EndCd(new_cd)

end
