--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_rubick_flash_bolt_custom_fly", "heroes/npc_dota_hero_rubick_custom/rubick_flash_bolt_custom", LUA_MODIFIER_MOTION_BOTH)

rubick_flash_bolt_custom = class({})

function rubick_flash_bolt_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_stormspirit/stormspirit_ball_lightning.vpcf", context)
end

function rubick_flash_bolt_custom:GetCastRange(vLocation, hTarget)
    if IsClient() then
        return self:GetSpecialValueFor("cast_range")
    end
end

function rubick_flash_bolt_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function rubick_flash_bolt_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local direction = (point - self:GetCaster():GetAbsOrigin())
    direction.z = 0
    local length = direction:Length2D()
    direction = direction:Normalized()
    local cast_range = self:GetSpecialValueFor("cast_range") + self:GetCaster():GetCastRangeBonus()
    if length > cast_range then
        point = self:GetCaster():GetAbsOrigin() + direction * cast_range
    end
    self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_rubick_flash_bolt_custom_fly", {x = point.x, y = point.y})
end

modifier_rubick_flash_bolt_custom_fly = class({})
function modifier_rubick_flash_bolt_custom_fly:IsHidden() return true end
function modifier_rubick_flash_bolt_custom_fly:IsPurgable() return false end

function modifier_rubick_flash_bolt_custom_fly:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.team = self.parent:GetTeamNumber()
	self.speed = 2000
	if not IsServer() then return end
	self.center = Vector( kv.x, kv.y, 0 )
	self.origin = self:GetParent():GetOrigin()
	self.tree = 100
    self.targets = {}
	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
		return
	end
	self:PlayEffects()
end

function modifier_rubick_flash_bolt_custom_fly:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveHorizontalMotionController( self )
	self:GetParent():StopSound("Hero_StormSpirit.BallLightning.Loop")
end

function modifier_rubick_flash_bolt_custom_fly:UpdateHorizontalMotion( me, dt )
	local origin = me:GetOrigin()
	local direction = self.center - origin
	local distance = direction:Length2D()
	direction.z = 0
	direction = direction:Normalized()
	local target = origin + direction*self.speed*dt
	me:SetOrigin( target )
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    local rubick_fade_bolt_custom = self:GetCaster():FindAbilityByName("rubick_fade_bolt_custom")
    if rubick_fade_bolt_custom then
        for _, unit in pairs(units) do
            if not self.targets[unit:entindex()] then
                self.targets[unit:entindex()] = true
                rubick_fade_bolt_custom:UseFadeBolt(self:GetCaster(), unit, nil, 0, nil, true, true, true)    
            end 
        end
    end
	GridNav:DestroyTreesAroundPoint( me:GetOrigin(), self.tree, false )
    if self.effect_cast then
	    ParticleManager:SetParticleControl( self.effect_cast, 1, origin )
    end
	if distance < 100 then
		self:Destroy()
		return
	end
end

function modifier_rubick_flash_bolt_custom_fly:OnHorizontalMotionInterrupted()
	self:Destroy()
end

function modifier_rubick_flash_bolt_custom_fly:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_stormspirit/stormspirit_ball_lightning.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
	ParticleManager:SetParticleControl( effect_cast, 1, self.parent:GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 60, Vector(20,200,20) )
    ParticleManager:SetParticleControl( effect_cast, 61, Vector(1,0,0) )
	self:AddParticle( effect_cast, false, false, -1, false, false )
	self.effect_cast = effect_cast
	self:GetParent():EmitSound("Hero_StormSpirit.BallLightning")
	self:GetParent():EmitSound( "Hero_StormSpirit.BallLightning.Loop")
end