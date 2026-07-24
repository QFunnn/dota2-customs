--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_slardar_armor", "abilities/npc_slardar_armor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_slardar_armor_cd", "abilities/npc_slardar_armor", LUA_MODIFIER_MOTION_NONE)

npc_slardar_armor = class({})

function npc_slardar_armor:OnSpellStart()
    if not IsServer() then
        return
    end

	local caster = self:GetCaster()
	if not IsValidEntity(caster) then return end

	local target = self:GetCursorTarget()
	if not IsValidEntity(target) then return end

    caster:AddNewModifier(caster, self, "modifier_slardar_armor_cd", {
        duration = self:GetCooldownTimeRemaining()
    })

    if target:TriggerSpellAbsorb(self) then
        return
    end

    target:EmitSound("Hero_Slardar.Amplify_Damage")

    target:AddNewModifier(caster, self, "modifier_slardar_armor", {
        duration = self:GetSpecialValueFor("duration") * (1 - target:GetStatusResistance())
    })

end




modifier_slardar_armor = class({})

function modifier_slardar_armor:IsPurgable() return true end

function modifier_slardar_armor:IsHidden() return false end


function modifier_slardar_armor:OnCreated(table)
	local ability = self:GetAbility()
	if not IsValidEntity(ability) then return end

	local parent = self:GetParent()
	if not IsValidEntity(parent) then return end

    self.armor = -ability:GetSpecialValueFor("armor")

    if not IsServer() then
        return
    end

    local particle = "particles/units/heroes/hero_slardar/slardar_amp_damage.vpcf"
    local fx = ParticleManager:CreateParticle(particle, PATTACH_OVERHEAD_FOLLOW, parent)
    ParticleManager:SetParticleControlEnt(fx, 0, parent, PATTACH_OVERHEAD_FOLLOW, nil, parent:GetOrigin(), true)
    ParticleManager:SetParticleControlEnt(fx, 1, parent, PATTACH_OVERHEAD_FOLLOW, nil, parent:GetOrigin(), true)
    ParticleManager:SetParticleControlEnt(fx, 2, parent, PATTACH_OVERHEAD_FOLLOW, nil, parent:GetOrigin(), true)
    self:AddParticle(fx, false, false, -1, false, true)

    self:SetStackCount(1)
end


function modifier_slardar_armor:OnRefresh(table)
    if not IsServer() then
        return
    end
    self:SetStackCount(self:GetStackCount() + 1)
end



function modifier_slardar_armor:DeclareFunctions()
    return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
end

function modifier_slardar_armor:GetModifierPhysicalArmorBonus() return self.armor * self:GetStackCount() end


modifier_slardar_armor_cd = class({})

function modifier_slardar_armor_cd:IsHidden() return false end
function modifier_slardar_armor_cd:IsPurgable() return false end