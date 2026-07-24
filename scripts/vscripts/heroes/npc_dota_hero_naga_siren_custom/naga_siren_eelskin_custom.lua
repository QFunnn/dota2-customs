--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_naga_siren_eelskin_custom", "heroes/npc_dota_hero_naga_siren_custom/naga_siren_eelskin_custom", LUA_MODIFIER_MOTION_NONE)

naga_siren_eelskin_custom = class({})

function naga_siren_eelskin_custom:GetIntrinsicModifierName()
    return "modifier_naga_siren_eelskin_custom"
end

modifier_naga_siren_eelskin_custom = class({})
function modifier_naga_siren_eelskin_custom:IsHidden() return true end
function modifier_naga_siren_eelskin_custom:IsPurgable() return false end
function modifier_naga_siren_eelskin_custom:IsPurgeException() return false end
function modifier_naga_siren_eelskin_custom:RemoveOnDeath() return false end

function modifier_naga_siren_eelskin_custom:OnCreated()
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
	if not IsServer() then return end
    self.evasion = 0
    self.bonus = self:GetAbility():GetSpecialValueFor("evasion_per_naga")
    self:StartIntervalThink(0.5)
    self:SetHasCustomTransmitterData( true )
    self:SendBuffRefreshToClients()
end

function modifier_naga_siren_eelskin_custom:OnRefresh()
	if not IsServer() then return end
    self.bonus = self:GetAbility():GetSpecialValueFor("evasion_per_naga")
end

function modifier_naga_siren_eelskin_custom:OnIntervalThink()
    if not IsServer() then return end
    local count = 1
    local units = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)
    for _, unit in pairs(units) do
        if unit and unit:IsAlive() and unit:IsIllusion() and unit:GetUnitName() == self:GetParent():GetUnitName() then
            count = count + 1
        end
    end
    self.evasion = self.bonus * count
    self:SendBuffRefreshToClients()
end

function modifier_naga_siren_eelskin_custom:AddCustomTransmitterData()
	local data = 
    {
		evasion = self.evasion,
	}
	return data
end

function modifier_naga_siren_eelskin_custom:HandleCustomTransmitterData( data )
	self.evasion = data.evasion
end

function modifier_naga_siren_eelskin_custom:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
        MODIFIER_PROPERTY_EVASION_CONSTANT,
	}
end

function modifier_naga_siren_eelskin_custom:GetModifierEvasion_Constant()
    if self:GetParent():HasModifier("modifier_naga_siren_14") then return end
    return self.evasion
end

function modifier_naga_siren_eelskin_custom:GetModifierTotal_ConstantBlock(kv)
    if IsServer() then
        if not self:GetParent():HasModifier("modifier_naga_siren_14") then return end
        local target = self:GetParent()
        if kv.damage > 0 and RollPercentage(self.evasion) then
            SendOverheadEventMessage(nil, OVERHEAD_ALERT_BLOCK, target, kv.damage, nil)
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_backtrack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
            ParticleManager:ReleaseParticleIndex(particle)
            return kv.damage
        end
    end
end