--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_naga_siren_harpoon", "heroes/npc_dota_hero_naga_siren_custom/naga_siren_harpoon", LUA_MODIFIER_MOTION_BOTH)

naga_siren_harpoon = class({})

function naga_siren_harpoon:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    self:GetCaster():EmitSound("Item.Harpoon.Cast")
    if target:TriggerSpellAbsorb(self) then
        return nil
    end
    local projectile =
    {
        Target = target,
        Source = self:GetCaster(),
        Ability = self,
        EffectName = "particles/items_fx/harpoon_projectile.vpcf",
        iMoveSpeed = self:GetSpecialValueFor("projectile_speed"),
        vSourceLoc = self:GetCaster():GetAbsOrigin(),
        bDodgeable = false,
        bProvidesVision = false,
    }
    ProjectileManager:CreateTrackingProjectile( projectile )
end

function naga_siren_harpoon:OnProjectileHit(hTarget, vLocation)
    if not IsServer() then return end
    if not hTarget then return end 
    local dis = (hTarget:GetAbsOrigin() - self:GetCaster():GetAbsOrigin()):Length2D()
    if dis <= self:GetSpecialValueFor("min_distance") then return end 
    hTarget:EmitSound('Item.Harpoon.Target')
    hTarget:AddNewModifier(self:GetCaster(), self, "modifier_naga_siren_harpoon", {duration = self:GetSpecialValueFor("pull_duration"), target = self:GetCaster():entindex()})
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_naga_siren_harpoon", {duration = self:GetSpecialValueFor("pull_duration"), target = hTarget:entindex()})
end 

modifier_naga_siren_harpoon = class({})
function modifier_naga_siren_harpoon:IsDebuff() return false end
function modifier_naga_siren_harpoon:IsHidden() return true end
function modifier_naga_siren_harpoon:GetStatusEffectName() return "particles/status_fx/status_effect_forcestaff.vpcf" end
function modifier_naga_siren_harpoon:StatusEffectPriority() return 100 end

function modifier_naga_siren_harpoon:OnCreated(params)
    if not IsServer() then return end
    self.target = EntIndexToHScript(params.target)
    self.pfx = ParticleManager:CreateParticle("particles/items_fx/harpoon_pull.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    self:GetParent():StartGesture(ACT_DOTA_FLAIL)
    self.angle = (self.target:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Normalized()
    self.point = (self:GetParent():GetAbsOrigin() + self.target:GetAbsOrigin()) / 2
    self.point = self.point - (self.target:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Normalized()*50
    self.speed = (self:GetParent():GetAbsOrigin() - self.point):Length2D()/self:GetRemainingTime()
    if self:ApplyHorizontalMotionController() == false then
        self:Destroy()
    end
end

function modifier_naga_siren_harpoon:OnDestroy()
    if not IsServer() then return end
    self:GetParent():InterruptMotionControllers( true )
    if self.pfx then
        ParticleManager:DestroyParticle(self.pfx, false)
        ParticleManager:ReleaseParticleIndex(self.pfx)
    end
    self:GetParent():FadeGesture(ACT_DOTA_FLAIL)
    ResolveNPCPositions(self:GetParent():GetAbsOrigin(), 128)
end

function modifier_naga_siren_harpoon:UpdateHorizontalMotion( me, dt )
    if not IsServer() then return end
    if not self.target or self.target:IsNull() or not self.target:IsAlive() then
        self:Destroy()
        return
    end
    local origin = self:GetParent():GetOrigin()
    local direction = self.point - origin
    direction.z = 0
    local distance = direction:Length2D()
    direction = direction:Normalized()
    local flPad = self:GetParent():GetPaddedCollisionRadius()
    if distance<flPad then
        self:Destroy()
    elseif distance>1500 then
        self:Destroy()
    end
    GridNav:DestroyTreesAroundPoint(origin, 80, false)
    local target = origin + direction * self.speed * dt
    self:GetParent():SetOrigin( target )
    self:GetParent():FaceTowards( self.target:GetOrigin() )
end

function modifier_naga_siren_harpoon:OnHorizontalMotionInterrupted()
    self:Destroy()
end