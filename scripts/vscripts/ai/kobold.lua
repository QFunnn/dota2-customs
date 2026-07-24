--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



find_behavior={data32={}}
for i=1,32 do
    find_behavior.data32[i]=2^(32-i)
end

function find_behavior:d2b(arg)
    local   tr={}
    for i=1,32 do
        if arg >= self.data32[i] then
        tr[i]=1
        arg=arg-self.data32[i]
        else
        tr[i]=0
        end
    end
    return   tr
end   --bit:d2b

function   find_behavior:b2d(arg)
    local   nr=0
    for i=1,32 do
        if arg[i] ==1 then
        nr=nr+2^(32-i)
        end
    end
    return  nr
end



function    find_behavior:_and(a,b)
    local   op1=self:d2b(a)
    local   op2=self:d2b(b)
    local   r={}

    for i=1,32 do
        if op1[i]==1 and op2[i]==1  then
            r[i]=1
        else
            r[i]=0
        end
    end
    return  self:b2d(r)

end


function ContainsValue(sum,nValue)

  if type(sum) == "userdata" then
     sum = tonumber(tostring(sum))
  end

  if find_behavior:_and(sum,nValue)==nValue then
        return true
  else
        return false
  end

end


check_mods =
{
 {"npc_werewolf_rupture", "modifier_bloodseeker_rupture"},
 {"npc_ogre_root", "modifier_ogre_root"},
 {"npc_centaur_double", "modifier_centaur_double_slow"},
 {"npc_satyr_purge","modifier_satyr_slow"},
 {"npc_satyr_stomp","modifier_stomp_break"},
 {"npc_arc_field","modifier_arc_field_buf"},
 {"npc_dazzle_grave","modifier_dazzle_grave"},
 {"npc_frostbitten_heal","modifier_frostbitten_heal"},
 {"npc_silencer_lastword","modifier_silencer_lastword_debuff"}
}

check_mods_friend =
{
 {"npc_frostbitten_spam", "modifier_frostbitten_spam"}
}

not_require_attack =
{
 ["npc_troll_summon"] = true,
 ["npc_skelet_aura"] = true,

}

check_self =
{
 "npc_arc_field",

}

require_friend =
{
 "npc_wolf_howl",

}

radius_check =
{
 "npc_arc_knockback",

}


check_health =
{
 ["npc_cone_armor"] = true

}


dont_check_order =
{
 ["npc_cone_armor"] = true,
 ["npc_skelet_aura"] = true,
 ["npc_treant_passive"] = true,

}

new_return =
{
	{"npc_wolf_howl",0.5},
    {"npc_satyr_manaburn",0.5},
    {"npc_frostbitten_spam",0.5},
    {"npc_frostbitten_heal",0.5},
    {"npc_dazzle_grave",0.7},
}

function check_mod_ally( entity, ability )
local name = ability:GetAbilityName()
local flag = false
local mod = ""

for i = 1,#check_mods_friend do
    if check_mods_friend[i][1] == name
        then
            mod = check_mods_friend[i][2]
            flag = true
            break
        end
end

if flag == false then
    return true
end


for i = 1,#entity.ally do
    if entity.ally[i].ability ~= nil and not entity.ally[i]:IsNull() then
        if entity.ally[i]:IsAlive() and entity.ally[i]:HasModifier(mod) and entity.number > entity.ally[i].number then
            return false
        end
     end
end

return true

end

function check_mod( ability )
local name = ability:GetAbilityName()
	for i = 1,#check_mods do
		if check_mods[i][1] == name then return check_mods[i][2] end
	end
return "-1"
end

function check_radius( ability )
local name = ability:GetAbilityName()
    for i = 1,#radius_check do
        if radius_check[i] == name then return true end
    end
return false
end


function check_self_buff( ability )
local name = ability:GetAbilityName()
    for i = 1,#check_self do
        if check_self[i] == name then return true end
    end
return false
end


function check_friend( ability )
local name = ability:GetAbilityName()
	for i = 1,#require_friend do
		if require_friend[i] == name then return true end
	end
return false
end

function check_return( ability )
local name = ability:GetAbilityName()
	for i = 1,#new_return do
		if new_return[i][1] == name then return new_return[i][2] end
	end
return -1
end

function check_order( entity )

local ability = entity.ability

if dont_check_order[ability:GetName()] then 
    return true
end

	for i = 1,#entity.ally do

		if entity.ally[i].ability ~= nil and not entity.ally[i]:IsNull() then

			if entity.ally[i]:IsAlive() and entity.ally[i].ability:GetAbilityName() == ability:GetAbilityName() and entity.number > entity.ally[i].number then

				if entity.ally[i].ability:GetCooldownTimeRemaining() == 0 then return false  end
			end

		end

	end
return true
end





function Spawn( entityKeyValues )
if not IsServer() then  return end
if not IsValidEntity(thisEntity) then return end


thisEntity.init = false
thisEntity.tower = nil
thisEntity.ability = nil
thisEntity.abilityBehavior = ''
for i = 0,thisEntity:GetAbilityCount()-1 do
	local a = thisEntity:GetAbilityByIndex(i)
	if not a then break end

	if not ContainsValue(a:GetBehavior(), DOTA_ABILITY_BEHAVIOR_PASSIVE) then  thisEntity.ability = a else break end


	if ContainsValue(thisEntity.ability:GetBehavior(), DOTA_ABILITY_BEHAVIOR_NO_TARGET) then  thisEntity.abilityBehavior = "NoTarget" end
	if ContainsValue(thisEntity.ability:GetBehavior(), DOTA_ABILITY_BEHAVIOR_POINT) then thisEntity.abilityBehavior = "Point" end

	if ContainsValue(thisEntity.ability:GetBehavior(), DOTA_ABILITY_BEHAVIOR_UNIT_TARGET)
		 and ContainsValue(thisEntity.ability:GetAbilityTargetTeam(),  DOTA_UNIT_TARGET_TEAM_FRIENDLY) then thisEntity.abilityBehavior = "TargetFriendly" end


	if ContainsValue(thisEntity.ability:GetBehavior(), DOTA_ABILITY_BEHAVIOR_UNIT_TARGET)
  and ContainsValue(thisEntity.ability:GetAbilityTargetTeam(),  DOTA_UNIT_TARGET_TEAM_ENEMY) then thisEntity.abilityBehavior = "TargetEnemy" end
  break
end


thisEntity:SetContextThink( "bevavior", function()

    local _, result = xpcall(bevavior, function(a,b,c) print(a,b,c) end)
    return result or 1
end, 0.1 )

end


function bevavior()
if not IsValidEntity(thisEntity) then return end
if not thisEntity.host_team then return 0.5 end

if not towers[thisEntity.host_team] or not towers[thisEntity.host_team]:IsAlive() then
    thisEntity:AddNewModifier(thisEntity, nil, "modifier_death", {})
    thisEntity:Kill(nil, nil)
    return 1
end

if not thisEntity.init then
    thisEntity.init = true

    thisEntity.start_abs = thisEntity:GetAbsOrigin()
    thisEntity.tower = towers[thisEntity.host_team]
    thisEntity.tower_location = towers[thisEntity.host_team]:GetAbsOrigin()
end

if thisEntity.ally == nil and not thisEntity.summoned then return 0.5 end
if GameRules:IsGamePaused() == true then return 0.5 end
if thisEntity:IsChanneling() then return 0.5 end


if thisEntity:HasModifier("modifier_return_to_path") then return 0.3 end
local path_dist = thisEntity:GetPathPoint(true)
if path_dist >= 700 then
    thisEntity:AddNewModifier(thisEntity, nil, "modifier_return_to_path", {duration = 6})
    return 1
end

if (not thisEntity:IsAlive()) then return -1 end
if not IsValidEntity(thisEntity.tower) then return -1 end
if not thisEntity.tower:IsAlive() then return -1 end

---------------------------------------------------------------------------------------------------

local enemy_for_ability = nil
local friends_for_ability = nil
local enemy_for_attack = nil

enemy_for_ability = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE , FIND_CLOSEST, false)
friends_for_ability = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, 1000, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE , FIND_ANY_ORDER, false)
enemy_for_attack = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_CLOSEST, false)

local control = false
if thisEntity:IsSilenced() or thisEntity:IsHexed() then
    control = true
end


if thisEntity.ability ~= nil and control == false then

local nReturn = thisEntity.ability:GetCastPoint()*1.5
if check_return(thisEntity.ability) ~= -1 then nReturn = check_return(thisEntity.ability) end

if thisEntity.ability:IsFullyCastable() then

	if thisEntity.abilityBehavior == "TargetEnemy" then

		if IsValidEntity(enemy_for_ability[1])
		and check_order(thisEntity)
		and not enemy_for_ability[1]:HasModifier(check_mod(thisEntity.ability))
        and check_mod_ally(thisEntity, thisEntity.ability)
		and ((thisEntity:GetAbsOrigin() - enemy_for_ability[1]:GetAbsOrigin()):Length2D()  <= thisEntity.ability:GetCastRange(thisEntity:GetAbsOrigin(), thisEntity)
		or ((thisEntity.ability:GetName() == "npc_werewolf_rupture") and (thisEntity:GetAbsOrigin() - enemy_for_ability[1]:GetAbsOrigin()):Length2D()  <= thisEntity.ability:GetSpecialValueFor("range")) )
            then

			thisEntity:CastAbilityOnTarget(enemy_for_ability[1], thisEntity.ability, 1)
    		return nReturn
		end
	end


	if thisEntity.abilityBehavior == "NoTarget" then

		if ((thisEntity:GetAttackTarget() ~= nil and not thisEntity:GetAttackTarget():HasModifier(check_mod(thisEntity.ability)) )
         or not_require_attack[thisEntity.ability:GetName()])

        and (not check_health[thisEntity.ability:GetName()] or (thisEntity:GetHealthPercent() <= thisEntity.ability:GetSpecialValueFor("thealth")))

        and ( (not check_self_buff(thisEntity.ability)) or  (not thisEntity:HasModifier(check_mod(thisEntity.ability))) )

        and ( ( not check_radius(thisEntity.ability) or not_require_attack[thisEntity.ability:GetName()] )
         or ( (thisEntity:GetAbsOrigin() - thisEntity:GetAttackTarget():GetAbsOrigin()):Length2D()  <= thisEntity.ability:GetSpecialValueFor("radius_to_use")) )

        and check_order(thisEntity)

		and ((not check_friend(thisEntity.ability)) or (#friends_for_ability > 1))
			then

			thisEntity:CastAbilityNoTarget(thisEntity.ability, 1)
			 return nReturn
		end

	end


	if thisEntity.abilityBehavior == "Point" then

		if IsValidEntity(enemy_for_ability[1]) and check_order(thisEntity)
		and (thisEntity:GetAbsOrigin() - enemy_for_ability[1]:GetAbsOrigin()):Length2D()  <= thisEntity.ability:GetCastRange(thisEntity:GetAbsOrigin(), thisEntity)
			then

			thisEntity:CastAbilityOnPosition(enemy_for_ability[1]:GetAbsOrigin(), thisEntity.ability, 1)
    		return nReturn
		end
	end


    if thisEntity.abilityBehavior == "TargetFriendly" then


    if check_order(thisEntity) then

        if IsValidEntity(friends_for_ability[1]) then
            for _,friend in pairs(friends_for_ability) do


                if friend:GetHealthPercent() <= thisEntity.ability:GetSpecialValueFor("thealth") and friend:GetUnitName() ~= "npc_psi_blades_crystal" and friend:GetUnitName() ~= "npc_psi_blades_crystal_mini"
                and (thisEntity:GetAbsOrigin() - friend:GetAbsOrigin()):Length2D()  <= thisEntity.ability:GetCastRange(thisEntity:GetAbsOrigin(), thisEntity)
                and not friend:HasModifier(check_mod(thisEntity.ability))
                  then
                    thisEntity:CastAbilityOnTarget(friend, thisEntity.ability, 1)
                    return nReturn
                  end
            end
         end

     end
    end



end
end

local enemy = nil



if IsValidEntity(enemy_for_attack[1]) 
    and not enemy_for_attack[1]:IgnoredByCreeps()
    and (enemy_for_attack[1]:GetAbsOrigin() - thisEntity.tower:GetAbsOrigin()):Length2D() > 800 then
    enemy = enemy_for_attack[1]
end

for _, target in pairs(enemy_for_attack) do

    if IsValidEntity(target) 
    and not target:IgnoredByCreeps()
    and (target:GetAbsOrigin() - thisEntity.tower:GetAbsOrigin()):Length2D() > 800  
    and not target:IsInvulnerable() 
    and not target:IsAttackImmune() then
        enemy = target
        break
    end

end




if IsValidEntity(enemy) and (thisEntity:GetAbsOrigin() - thisEntity.tower_location):Length2D() > 1000 then
    thisEntity:SetForceAttackTarget(enemy)
else
    thisEntity:SetForceAttackTarget(thisEntity.tower)
end



return 0.5


end