--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


_G.ModifierCustomEvents = {}
_G.ModifierCustomProps = {}

CUSTOM_MODIFIER_PROPS_CAL_TYPE_ADD = 1
CUSTOM_MODIFIER_PROPS_CAL_TYPE_MAX = 2

MODIFIER_FUNCTION_CUSTOM_1 = MODIFIER_FUNCTION_LAST + 1

ModifierCustomEventsMap = {
    MODIFIER_EVENT_ON_MAGICAL_CRIT = { "OnMagicalCrit", "modifier_magic_crit" }
}

ModifierCustomPropsMap = {
    MODIFIER_PROPERTY_MAGICAL_CRIT_DAMAGE = {
        "GetModifierMagicalCritDamage", "modifier_magic_crit"
    }
}

function AddCustomModifierEvent(tBuff, sEvent)
    local hParent = tBuff:GetParent()
    if IsValid(hParent) and tBuff then
        if ModifierCustomEvents[sEvent] == nil then
            ModifierCustomEvents[sEvent] = {}
        end
        if ModifierCustomEvents[sEvent][hParent:entindex()] == nil then
            ModifierCustomEvents[sEvent][hParent:entindex()] = {}
        end
        table.insert(ModifierCustomEvents[sEvent][hParent:entindex()], tBuff)
        hParent:AddNewModifier(hParent, tBuff:GetAbility(), ModifierCustomEventsMap[sEvent][2], {})
    end
end

function RemoveCustomModifierEvent(tBuff, sEvent)
    local hParent = tBuff:GetParent()
    if IsValid(hParent) and tBuff then
        if ModifierCustomEvents[sEvent] == nil then
            ModifierCustomEvents[sEvent] = {}
        else
            if ModifierCustomEvents[sEvent][hParent:entindex()] == nil then
                ModifierCustomEvents[sEvent][hParent:entindex()] = {}
            end
            for i = #ModifierCustomEvents[sEvent][hParent:entindex()], 1, -1 do
                if ModifierCustomEvents[sEvent][hParent:entindex()][i] == tBuff then
                    table.remove(
                        ModifierCustomEvents[sEvent][hParent:entindex()], i)
                    local Modifier = hParent:FindModifierByName(
                        ModifierCustomEventsMap[sEvent][2])
                    if Modifier then
                        Modifier:DecrementStackCount()
                    end
                    break
                end
            end
        end
    end
end

function AddCustomModifierProps(tBuff, sProps)
    local hParent = tBuff:GetParent()
    if IsValid(hParent) and tBuff then
        if ModifierCustomProps[sProps] == nil then
            ModifierCustomProps[sProps] = {}
        end
        if ModifierCustomProps[sProps][hParent:entindex()] == nil then
            ModifierCustomProps[sProps][hParent:entindex()] = {}
        end
        table.insert(ModifierCustomProps[sProps][hParent:entindex()], tBuff)
        hParent:AddNewModifier(hParent, tBuff:GetAbility(), ModifierCustomPropsMap[sProps][2], {})
    end
end

function RemoveCustomModifierProps(tBuff, sProps)
    local hParent = tBuff:GetParent()
    if IsValid(hParent) and tBuff then
        if ModifierCustomProps[sProps] == nil then
            ModifierCustomProps[sProps] = {}
        else
            if ModifierCustomProps[sProps][hParent:entindex()] == nil then
                ModifierCustomProps[sProps][hParent:entindex()] = {}
            end
            for i = #ModifierCustomProps[sProps][hParent:entindex()], 1, -1 do
                if ModifierCustomProps[sProps][hParent:entindex()][i] == tBuff then
                    table.remove(
                        ModifierCustomProps[sProps][hParent:entindex()], i)
                    local Modifier = hParent:FindModifierByName(
                        ModifierCustomPropsMap[sProps][2])
                    if Modifier then
                        Modifier:DecrementStackCount()
                    end
                    break
                end
            end
        end
    end
end

function GetCustomModifierProps(hUnit, sProps, params, iCalType)
    local index = hUnit:entindex()
    local result_value = 0
    local result_buff = nil
    if index then
        if ModifierCustomProps[sProps] and ModifierCustomProps[sProps][index] then
            for _, buff in pairs(ModifierCustomProps[sProps][index]) do
                if buff[ModifierCustomPropsMap[sProps][1]] and
                    type(buff[ModifierCustomPropsMap[sProps][1]]) == "function" then
                    local value = (buff[ModifierCustomPropsMap[sProps][1]](buff,
                            params) or
                        0)
                    if iCalType == CUSTOM_MODIFIER_PROPS_CAL_TYPE_ADD then
                        result_value = result_value + value
                    elseif iCalType == CUSTOM_MODIFIER_PROPS_CAL_TYPE_MAX then
                        if value > result_value then
                            result_value = value
                            result_buff = buff
                        end
                    end
                end
            end
            return { value = result_value, buff = result_buff }
        end
    end
    return { value = result_value, buff = result_buff }
end

function FireCustomEvent(sEvent, params, hParent, tBuff)
    if IsValid(hParent) and tBuff then
        tBuff[ModifierCustomEventsMap[sEvent][1]](tBuff, params)
    else
        if ModifierCustomEvents[sEvent] == nil then
            ModifierCustomEvents[sEvent] = {}
        end
        if ModifierCustomEvents[sEvent][hParent:entindex()] == nil then
            ModifierCustomEvents[sEvent][hParent:entindex()] = {}
        end
        for i = #ModifierCustomEvents[sEvent][hParent:entindex()], 1, -1 do
            local buff = ModifierCustomEvents[sEvent][hParent:entindex()][i]
            if IsValid(buff) then
                buff[ModifierCustomEventsMap[sEvent][1]](buff, params)
            else
                table.remove(ModifierCustomEvents[sEvent][hParent:entindex()], i)
            end
        end
    end
end