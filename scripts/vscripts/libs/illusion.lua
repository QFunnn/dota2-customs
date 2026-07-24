--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if Illusion == nil then 
    Illusion = class({}) 
end

Illusion.abilityException = 
{
    ["monkey_king_wukongs_command"] = true
}

Illusion.juxtaposeException = 
{
    ["drow_ranger_marksmanship_custom"] = true,
    ["medusa_split_shot"] = true,
    ["luna_moon_glaive"] = true,
    ["abaddon_frostmourne"] = true,
}

function Illusion:InitIllusion(hIllusion)
    if not hIllusion or hIllusion:IsNull() then return end
    local hIllustionModifier = hIllusion:FindModifierByName("modifier_illusion")
    if not hIllustionModifier then return end
    local hOriginalHero = hIllustionModifier:GetCaster()
    if not hOriginalHero then return end
    
    for i=0, hIllusion:GetAbilityCount()-1 do
        local hAbility = hIllusion:GetAbilityByIndex(i)
        if hAbility and not string.find(hAbility:GetAbilityName(), "special_bonus") then
            hIllusion:RemoveAbility(hAbility:GetAbilityName())
        end
    end

    for i=0, hOriginalHero:GetAbilityCount()-1 do
        local hOriginalHeroAbility = hOriginalHero:GetAbilityByIndex(i)
        if hOriginalHeroAbility and hOriginalHeroAbility.GetAbilityName then
            local sOriginalAbilityName = hOriginalHeroAbility:GetAbilityName()
            if not string.find(sOriginalAbilityName, "special_bonus") and not Illusion.abilityException[sOriginalAbilityName] then
                if not (hIllusion:HasModifier("modifier_phantom_lancer_juxtapose_illusion") and Illusion.juxtaposeException[sOriginalAbilityName]) then
                    local hNewAbility=hIllusion:AddAbility(sOriginalAbilityName)
                    local nLevel = hOriginalHeroAbility:GetLevel()  
                    if hNewAbility and not hNewAbility:IsNull() then
                        hNewAbility:SetHidden(hOriginalHeroAbility:IsHidden())
                        hNewAbility:ClearInnateModifiers()
                        if nLevel>0 then
                            hNewAbility:SetLevel(nLevel)
                        end
                    end
                end
            end
    
            if hIllusion:HasModifier("modifier_phantom_lancer_juxtapose_illusion") then
                hIllusion:RemoveModifierByName('modifier_dragon_knight_splash_attack')
            end
            if hIllusion:HasModifier("modifier_abaddon_frostmourne") then
                hIllusion:RemoveModifierByName('modifier_abaddon_frostmourne')
            end
        end
    end

    if hOriginalHero:HasModifier("modifier_cha_top_rating") then
        hIllusion:AddNewModifier(hOriginalHero, nil, "modifier_cha_top_rating", {})
    end

    if hOriginalHero:HasModifier("modifier_player_controller") then
        hIllusion:AddNewModifier(hOriginalHero, nil, "modifier_player_controller", {})
    end

    if not hIllusion:HasModifier("modifier_player_cosmetics") and hOriginalHero:HasModifier("modifier_player_cosmetics") then
        hIllusion:AddNewModifier(hOriginalHero, nil, "modifier_player_cosmetics", {})
    end

    hIllusion:RemoveModifierByName("modifier_muerta_gunslinger")
    hIllusion:RemoveModifierByName("modifier_muerta_supernatural")
    if hIllusion:HasAbility("muerta_gunslinger") then
        hIllusion:RemoveAbility("muerta_gunslinger")
    end
    if hIllusion:HasAbility("muerta_supernatural") then
        hIllusion:RemoveAbility("muerta_supernatural")
    end
    -- A4: иллюзия (в т.ч. Reflection Терроблейда) не должна копировать Pierce the Veil
    -- (этереал-ульта Муэрты). Снимаем модификаторы и саму способность, как у gunslinger/supernatural.
    hIllusion:RemoveModifierByName("modifier_muerta_pierce_the_veil")
    hIllusion:RemoveModifierByName("modifier_muerta_pierce_the_veil_buff")
    if hIllusion:HasAbility("muerta_pierce_the_veil") then
        hIllusion:RemoveAbility("muerta_pierce_the_veil")
    end
    for _, mod in pairs(hIllusion:FindAllModifiers()) do
        if mod and mod:GetName() == "modifier_lua" then
            mod:Destroy()
        end
    end
    
    hIllusion.bTreeTempGrab = false
end