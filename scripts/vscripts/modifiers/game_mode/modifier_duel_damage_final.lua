--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




modifier_duel_damage_final = class({})


function modifier_duel_damage_final:IsHidden() return false end
function modifier_duel_damage_final:IsPurgable() return false end
function modifier_duel_damage_final:RemoveOnDeath() return false end


function modifier_duel_damage_final:OnCreated(table)
  self.StackOnIllusion = true
end

function modifier_duel_damage_final:GetTexture() return "buffs/duel_win" end
function modifier_duel_damage_final:GetEffectName()
return "particles/generic_gameplay/rune_doubledamage_owner.vpcf"
end


function modifier_duel_damage_final:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
}

end


function modifier_duel_damage_final:GetModifierIncomingDamage_Percentage()
    return -8
end

function modifier_duel_damage_final:GetModifierTotalDamageOutgoing_Percentage()
    return 8
end