--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



modifier_generic_debuff_immune_passive = class({})

function modifier_generic_debuff_immune_passive:IsHidden() return true end
function modifier_generic_debuff_immune_passive:IsPurgable() return false end 
function modifier_generic_debuff_immune_passive:RemoveOnDeath() return false end

function modifier_generic_debuff_immune_passive:CheckState()
    return {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true
    }
end


function modifier_generic_debuff_immune_passive:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
    }
end



function modifier_generic_debuff_immune_passive:GetModifierIncomingDamage_Percentage(params)
if not IsServer() then return end
if not params.attacker then return end
if not params.inflictor then return end

if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then 
	return -100 
end

local behavior = params.inflictor:GetAbilityTargetFlags()


if bit.band(behavior, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) == 0  then

    if params.damage_type == DAMAGE_TYPE_MAGICAL then 
        return self.magic_damage
    end

    if params.damage_type == DAMAGE_TYPE_PURE then 
        return -100
    end
end

end


function modifier_generic_debuff_immune_passive:GetModifierMagicalResistanceBonus()
if not IsClient() then return end

return self.magic_damage * -1
end


function modifier_generic_debuff_immune_passive:OnCreated(table)
if not IsServer() then return end

self.magic_damage = table.magic_damage

if self.magic_damage > 0 then 
	self.magic_damage = self.magic_damage * -1
end

self:SetHasCustomTransmitterData(true)
end

function modifier_generic_debuff_immune_passive:AddCustomTransmitterData() return 
{
magic_damage = self.magic_damage,
} 
end

function modifier_generic_debuff_immune_passive:HandleCustomTransmitterData(data)
self.magic_damage  = data.magic_damage
end