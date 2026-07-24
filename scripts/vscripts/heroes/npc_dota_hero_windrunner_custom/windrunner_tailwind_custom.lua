--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_windrunner_tailwind_custom", "heroes/npc_dota_hero_windrunner_custom/windrunner_tailwind_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_windrunner_tailwind_custom_buff", "heroes/npc_dota_hero_windrunner_custom/windrunner_tailwind_custom", LUA_MODIFIER_MOTION_NONE)

windrunner_tailwind_custom = class({})
windrunner_tailwind_custom.modifier_windrunner_12 = {4,8,12}

function windrunner_tailwind_custom:GetIntrinsicModifierName()
    return "modifier_windrunner_tailwind_custom"
end

modifier_windrunner_tailwind_custom = class({})
function modifier_windrunner_tailwind_custom:IsHidden() return true end
function modifier_windrunner_tailwind_custom:IsPurgable() return false end
function modifier_windrunner_tailwind_custom:IsPurgeException() return false end
function modifier_windrunner_tailwind_custom:RemoveOnDeath() return false end


function modifier_windrunner_tailwind_custom:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
        MODIFIER_EVENT_ON_ABILITY_EXECUTED,
	}
end

function modifier_windrunner_tailwind_custom:GetModifierMoveSpeed_Limit()
	return self:GetAbility():GetSpecialValueFor("max_movespeed")
end

function modifier_windrunner_tailwind_custom:GetModifierIgnoreMovespeedLimit()
	return 1
end

function modifier_windrunner_tailwind_custom:OnAbilityExecuted(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if params.ability == nil then return end
    if params.ability:IsItem() then return end
    if params.ability:GetName() == "windrunner_powershot_custom" then return end
    if params.ability:GetName() == "windrunner_ultra_powershot_custom" then return end
    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_windrunner_tailwind_custom_buff", {duration = self:GetAbility():GetSpecialValueFor("duration")})
end

function modifier_windrunner_tailwind_custom:ApplyBonus()
    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_windrunner_tailwind_custom_buff", {duration = self:GetAbility():GetSpecialValueFor("duration")})
end

function modifier_windrunner_tailwind_custom:GetModifierTotal_ConstantBlock(kv)
    if IsServer() then
        local target = self:GetParent()
        if self:GetCaster():HasModifier("modifier_windrunner_12") and self:GetCaster():HasModifier("modifier_windrunner_tailwind_custom_buff") then
            if kv.damage > 0 and RollPercentage(self:GetAbility().modifier_windrunner_12[self:GetCaster():GetTalentLevel("modifier_windrunner_12")]) then
                SendOverheadEventMessage(nil, OVERHEAD_ALERT_BLOCK, target, kv.damage, nil)
                local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_backtrack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
                ParticleManager:ReleaseParticleIndex(particle)
                return kv.damage
            end
        end
    end
end

modifier_windrunner_tailwind_custom_buff = class({})

function modifier_windrunner_tailwind_custom_buff:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_windrunner_tailwind_custom_buff:OnCreated()
    local ability = self:GetAbility()
    self.movespeed_bonus = ability and ability:GetSpecialValueFor("movespeed_bonus") 
    if not IsServer() then return end
    self:IncrementStackCount()
end

function modifier_windrunner_tailwind_custom_buff:OnRefresh()
    local ability = self:GetAbility()
    self.movespeed_bonus = ability and ability:GetSpecialValueFor("movespeed_bonus")
    if not IsServer() then return end
    self:IncrementStackCount()
end

function modifier_windrunner_tailwind_custom_buff:GetModifierMoveSpeedBonus_Percentage()
    local duration = self:GetDuration()
    if duration <= 0 then
        return self.movespeed_bonus * self:GetStackCount()
    end
    local multiplier = 1
    local half_duration = duration / 2
    local elapsed = self:GetElapsedTime()
    if elapsed > half_duration then
        multiplier = math.max(0, self:GetRemainingTime() / half_duration)
    end
    return self.movespeed_bonus * self:GetStackCount() * multiplier
end