--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function Spawn( entityKeyValues )
	if not IsServer() then
		return
	end

	if thisEntity == nil then
		return
	end

    if thisEntity:GetTeam()~=DOTA_TEAM_NEUTRALS then
        return
    end
  
	thisEntity:SetContextThink( "CreepThink", CreepThink, 1.5 )
end

function CreepThink()
    if not thisEntity:IsAlive() then
        return
    end

    if GameRules:IsGamePaused() then
        return 0.1
    end

    local hTarget

              
    if thisEntity.hTarget and not thisEntity.hTarget:IsNull() and thisEntity.hTarget:IsAlive() and (not thisEntity.hTarget:IsUnselectable()) then
        hTarget=thisEntity.hTarget
    else
        local vEnemies = {}               
        
        vEnemies = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, thisEntity:GetOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_CLOSEST, false)
        for _,hEnemy in pairs(vEnemies) do
            if hEnemy and not hEnemy:IsNull() and hEnemy:IsAlive() and (not hEnemy:IsUnselectable()) then
                hTarget = hEnemy
                thisEntity.hTarget = hEnemy
                break
            end
        end
 
        if nil == hTarget then  

            thisEntity.hTarget=nil

            if not thisEntity:IsAttacking() then
                ExecuteOrderFromTable({UnitIndex = thisEntity:entindex(), OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, Position = thisEntity:GetOrigin()})
            end

            return 1.5
        end
    end

    if thisEntity:GetAggroTarget() and not thisEntity:IsSilenced() and not thisEntity:IsStunned() then
        local flAbilityCastTime = TryCastAbility(thisEntity:GetAggroTarget())
        if flAbilityCastTime then
            return flAbilityCastTime
        end
    end      

    if not thisEntity:IsAttacking() then
        if hTarget ~= nil then
            ExecuteOrderFromTable({UnitIndex = thisEntity:entindex(), OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, Position = hTarget:GetAbsOrigin()})
            thisEntity:MoveToPositionAggressive(hTarget:GetAbsOrigin())
        else
            ExecuteOrderFromTable({UnitIndex = thisEntity:entindex(), OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, Position = thisEntity:GetAbsOrigin()})
            thisEntity:MoveToPositionAggressive(thisEntity:GetAbsOrigin())
        end
    end

    return 1.5
end

function TryCastAbility(hTarget)
    local flAbilityCastTime = CastAbility(hTarget)
    if flAbilityCastTime then
        return flAbilityCastTime
    end
    return nil
end

function ContainsValue(sum,nValue)
    if type(sum) == "userdata" then
        sum = tonumber(tostring(sum))
    end
    if bit:_and(sum,nValue)==nValue then
        return true
    else
        return false
    end
end

function CastAbility(hTarget)
    for i=1,thisEntity:GetAbilityCount() do
        local hAbility=thisEntity:GetAbilityByIndex(i-1)
        if hAbility and not hAbility:IsPassive() and hAbility:IsFullyCastable() and not thisEntity:IsStunned() and not thisEntity:IsSilenced() then
            ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            if ContainsValue(hAbility:GetBehavior(),DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) and not ContainsValue(hAbility:GetBehavior(),DOTA_ABILITY_BEHAVIOR_ATTACK) then
                if hTarget:IsPositionInRange(thisEntity:GetAbsOrigin(), hAbility:GetCastRange(thisEntity:GetAbsOrigin(), hTarget)) then
                    if ContainsValue(hAbility:GetAbilityTargetTeam(),DOTA_UNIT_TARGET_TEAM_ENEMY) or ContainsValue(hAbility:GetAbilityTargetTeam(),DOTA_UNIT_TARGET_TEAM_CUSTOM) then
                        if not hTarget:IsMagicImmune() then
                            thisEntity:SetCursorCastTarget(hTarget)
                            thisEntity:CastAbilityImmediately(hAbility, 0)
                        end
                        return hAbility:GetCastPoint()+RandomFloat(0.1, 0.3)
                    end
                
                    if ContainsValue(hAbility:GetAbilityTargetTeam(),DOTA_UNIT_TARGET_TEAM_FRIENDLY) then
                        thisEntity:SetCursorCastTarget(thisEntity)
                        -- target
                        thisEntity:CastAbilityImmediately(hAbility, 0)
                        return hAbility:GetCastPoint()+RandomFloat(0.1, 0.3)
                    end
                end
            end
            ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            if ContainsValue(hAbility:GetBehavior(),DOTA_ABILITY_BEHAVIOR_POINT) then
                local vLeadingOffset = hTarget:GetForwardVector() * RandomInt( 25, 75 )
                local vTargetPos = hTarget:GetOrigin() + vLeadingOffset
                if hTarget:IsPositionInRange(thisEntity:GetAbsOrigin(), hAbility:GetCastRange(thisEntity:GetAbsOrigin(), hTarget)) then
                    thisEntity:SetCursorPosition(vTargetPos)
                    -- position
                    thisEntity:CastAbilityImmediately(hAbility, 0)
                    return hAbility:GetCastPoint()+RandomFloat(0.1, 0.3)
                end
            end
            ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            if ContainsValue(hAbility:GetBehavior(),DOTA_ABILITY_BEHAVIOR_NO_TARGET) and not ContainsValue(hAbility:GetBehavior(),DOTA_ABILITY_BEHAVIOR_AUTOCAST) then
                if hAbility:GetSpecialValueFor("radius") == nil or hAbility:GetSpecialValueFor("radius") == 0 then
                    thisEntity:CastAbilityImmediately(hAbility, 0)
                    return hAbility:GetCastPoint()+RandomFloat(0.1, 0.3)
                else
                    local position = hTarget:GetAbsOrigin()
                    if (thisEntity:GetAbsOrigin() - position):Length2D() <= hAbility:GetSpecialValueFor("radius") then
                        thisEntity:CastAbilityImmediately(hAbility, 0)
                        return hAbility:GetCastPoint()+RandomFloat(0.1, 0.3)
                    end
                end
            end
        end
    end
end

-- Не трогай уши отрежут

bit={data32={}}

for i=1,32 do
    bit.data32[i]=2^(32-i)
end

function bit:d2b(arg)
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

function    bit:b2d(arg)
    local   nr=0
    for i=1,32 do
        if arg[i] ==1 then
        nr=nr+2^(32-i)
        end
    end
    return  nr
end   --bit:b2d

function    bit:_xor(a,b)
    local   op1=self:d2b(a)
    local   op2=self:d2b(b)
    local   r={}

    for i=1,32 do
        if op1[i]==op2[i] then
            r[i]=0
        else
            r[i]=1
        end
    end
    return  self:b2d(r)
end --bit:xor

function    bit:_and(a,b)
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
    
end --bit:_and

function    bit:_or(a,b)
    local   op1=self:d2b(a)
    local   op2=self:d2b(b)
    local   r={}
    
    for i=1,32 do
        if  op1[i]==1 or   op2[i]==1   then
            r[i]=1
        else
            r[i]=0
        end
    end
    return  self:b2d(r)
end --bit:_or

function    bit:_not(a)
    local   op1=self:d2b(a)
    local   r={}

    for i=1,32 do
        if  op1[i]==1   then
            r[i]=0
        else
            r[i]=1
        end
    end
    return  self:b2d(r)
end --bit:_not

function    bit:_rshift(a,n)
    local   op1=self:d2b(a)
    local   r=self:d2b(0)
    
    if n < 32 and n > 0 then
        for i=1,n do
            for i=31,1,-1 do
                op1[i+1]=op1[i]
            end
            op1[1]=0
        end
    r=op1
    end
    return  self:b2d(r)
end --bit:_rshift

function    bit:_lshift(a,n)
    local   op1=self:d2b(a)
    local   r=self:d2b(0)
    
    if n < 32 and n > 0 then
        for i=1,n   do
            for i=1,31 do
                op1[i]=op1[i+1]
            end
            op1[32]=0
        end
    r=op1
    end
    return  self:b2d(r)
end

function    bit:print(ta)
    local   sr=""
    for i=1,32 do
        sr=sr..ta[i]
    end
    print(sr)
end