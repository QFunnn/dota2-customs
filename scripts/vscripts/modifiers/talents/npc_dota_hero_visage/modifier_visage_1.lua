--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_visage_1=class({})

function modifier_visage_1:IsHidden() return true end
function modifier_visage_1:IsPurgable() return false end
function modifier_visage_1:IsPurgeException() return false end
function modifier_visage_1:RemoveOnDeath() return false end

function modifier_visage_1:OnCreated()
	self.damage_per_layer = {5,10}
	self.radius = 600
	if not IsServer() then return end
    self.damage_think = 0
    self.pfx_radius = self:GetParent():GetAoeBonus(self.radius)
	self:SetStackCount(1)
	self:StartIntervalThink(FrameTime())
end

function modifier_visage_1:OnRefresh()
	self.damage_per_layer = {5,10}
	self.radius = 600
    self.pfx_radius = self:GetParent():GetAoeBonus(self.radius)
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_visage_1:OnIntervalThink()
	if not IsServer() then return end
    if not self.particle then
        self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_visage/visage_cloak_ambient_damage.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControl(self.particle, 10, Vector(self.pfx_radius, 0, 0))
        ParticleManager:SetParticleControl(self.particle, 2, Vector(0, 0, 0))
        self:AddParticle(self.particle, false, false, -1, false, false)
    end
    if self:GetParent():GetAoeBonus(self.radius) ~= self.pfx_radius then
        self.pfx_radius = self:GetParent():GetAoeBonus(self.radius)
        if self.particle then
            ParticleManager:DestroyParticle(self.particle, true)
        end
        self.particle = nil
        print("change radius")
    end
    local radius_cast = self:GetParent():GetAoeBonus(self.radius)
    self.damage_think = self.damage_think + FrameTime()
    local layers = self:GetParent():GetModifierStackCount("modifier_visage_gravekeepers_cloak_custom", self:GetParent())
    if not self:GetParent():IsAlive() or self:GetParent():PassivesDisabled() then
        layers = 0
    end
    if self.particle then
        ParticleManager:SetParticleControl(self.particle, 2, Vector(layers > 0 and 1 or 0, 0, 0))
    end
    if self.damage_think >= 1 then
        self.damage_think = 0
        if not self:GetParent():IsAlive() or self:GetParent():PassivesDisabled() then return end
        if layers <= 0 then return end
        local visage_gravekeepers_cloak_custom = self:GetParent():FindModifierByName("modifier_visage_gravekeepers_cloak_custom")
        local damage = self.damage_per_layer[self:GetStackCount()] * layers
        local enemies = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, radius_cast, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
        for _, enemy in pairs(enemies) do
            ApplyDamage({victim = enemy, attacker = self:GetParent(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = visage_gravekeepers_cloak_custom, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK})
        end
    end
end