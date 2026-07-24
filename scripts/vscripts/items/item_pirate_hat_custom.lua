--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_pirate_hat_custom", "items/item_pirate_hat_custom", LUA_MODIFIER_MOTION_NONE)

item_pirate_hat_custom = class({})

function item_pirate_hat_custom:GetIntrinsicModifierName()
    return "modifier_item_pirate_hat_custom"
end

function item_pirate_hat_custom:OnSpellStart()
    if not IsServer() then return end
    self.point = self:GetCursorPosition()
    self.pfx = ParticleManager:CreateParticle("particles/econ/events/ti9/shovel_dig.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(self.pfx, 0, self:GetCursorPosition())
	EmitSoundOn("SeasonalConsumable.TI9.Shovel.Dig", self:GetCaster())
end

function item_pirate_hat_custom:OnChannelFinish(bInterrupted)
    if not IsServer() then return end
    if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
	end
	StopSoundOn("SeasonalConsumable.TI9.Shovel.Dig", self:GetCaster())
    if bInterrupted then
        return
    end
    local pfx2 = ParticleManager:CreateParticle("particles/econ/events/ti9/shovel_revealed_generic.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(pfx2, 0, self:GetCursorPosition())
    ParticleManager:ReleaseParticleIndex(pfx2)
    CreateRune(self.point, DOTA_RUNE_BOUNTY)
end

modifier_item_pirate_hat_custom = class({})

function modifier_item_pirate_hat_custom:IsHidden() return true end
function modifier_item_pirate_hat_custom:IsPurgable() return false end
function modifier_item_pirate_hat_custom:RemoveOnDeath() return false end
function modifier_item_pirate_hat_custom:IsPurgeException() return false end


function modifier_item_pirate_hat_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
end

function modifier_item_pirate_hat_custom:GetModifierAttackSpeedPercentage()
    return self:GetAbility():GetSpecialValueFor("base_attack_speed")
end

function modifier_item_pirate_hat_custom:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end

function modifier_item_pirate_hat_custom:GetModifierMoveSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("bonus_ms")
end