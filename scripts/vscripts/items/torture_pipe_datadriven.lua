--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function ToggleTorturePipe(keys)
    local hCaster = keys.caster
    local hAbility = keys.ability
    
    -- Проверяем, в каком слоте находится предмет
    -- Если предмет в слоте 8 (DOTA_ITEM_SLOT_9) у Techies - не работает
    if hCaster:HasAbility("techies_spoons_stash_custom") and hAbility:GetItemSlot() == DOTA_ITEM_SLOT_9 then
        hCaster.flDotSP = nil
        -- Удаляем только модификатор ЭТОГО предмета
        local itemName = hAbility:GetAbilityName()
        if itemName == "item_torture_pipe_1_datadriven" then
            hCaster:RemoveModifierByName("modifier_torture_pipe_1_datadriven")
        elseif itemName == "item_torture_pipe_2_datadriven" then
            hCaster:RemoveModifierByName("modifier_torture_pipe_2_datadriven")
        end
        return
    end
    
    if hCaster:HasModifier("modifier_torture_pipe_2_datadriven") then
        local hAbility = hCaster:FindModifierByName("modifier_torture_pipe_2_datadriven"):GetAbility()
        if hCaster:HasModifier("modifier_skill_overbuffed") then
            hCaster.flDotSP = hAbility:GetSpecialValueFor("dot_amplify") + 0.4
        else
            hCaster.flDotSP = hAbility:GetSpecialValueFor("dot_amplify")
        end
    elseif hCaster:HasModifier("modifier_torture_pipe_1_datadriven") then
        local hAbility = hCaster:FindModifierByName("modifier_torture_pipe_1_datadriven"):GetAbility()
        if hCaster:HasModifier("modifier_skill_overbuffed") then
            hCaster.flDotSP = hAbility:GetSpecialValueFor("dot_amplify") + 0.4
        else
            hCaster.flDotSP = hAbility:GetSpecialValueFor("dot_amplify")
        end
    else
        hCaster.flDotSP = nil
    end

    if hCaster.flDotSP ~= nil then
        --print(hCaster:GetUnitName() .. "'flDotSP: " .. hCaster.flDotSP)
    else
        --print(hCaster:GetUnitName() .. "'flDotSP is nil")
    end
end