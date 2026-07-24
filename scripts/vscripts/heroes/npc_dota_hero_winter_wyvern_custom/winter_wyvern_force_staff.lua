--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


winter_wyvern_force_staff = class({})

function winter_wyvern_force_staff:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/econ/events/winter_major_2016/force_staff_wm_2016.vpcf", context)
end

function winter_wyvern_force_staff:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    local modifier_force_boots_active = target:AddNewModifier(self:GetCaster(), self, "modifier_force_boots_active", {push_length = self:GetSpecialValueFor("push_length"), duration = self:GetSpecialValueFor("push_duration")})
    target:RemoveGesture(ACT_DOTA_DISABLED)
    target:EmitSound("DOTA_Item.ForceStaff.Activate")
    if modifier_force_boots_active then
        local particle = ParticleManager:CreateParticle("particles/econ/events/winter_major_2016/force_staff_wm_2016.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
        modifier_force_boots_active:AddParticle(particle, false, false, -1, false, false)
    end
end