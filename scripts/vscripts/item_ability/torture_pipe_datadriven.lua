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
    if hCaster:HasModifier("modifier_torture_pipe_2_datadriven") then
        local hAbility = hCaster:FindModifierByName("modifier_torture_pipe_2_datadriven"):GetAbility()
        hCaster.flDotSP = hAbility:GetSpecialValueFor("dot_amplify")
    elseif hCaster:HasModifier("modifier_torture_pipe_1_datadriven") then
        local hAbility = hCaster:FindModifierByName("modifier_torture_pipe_1_datadriven"):GetAbility()
        hCaster.flDotSP = hAbility:GetSpecialValueFor("dot_amplify")
    else
        hCaster.flDotSP = nil
    end
end