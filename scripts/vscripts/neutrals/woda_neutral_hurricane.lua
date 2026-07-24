--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_hurricane", "neutrals/woda_neutral_hurricane", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

woda_neutral_hurricane = class({})

function woda_neutral_hurricane:Precache(context)
    PrecacheResource( "particle", "particles/neutral_fx/wildkin_ripper_hurricane_ambient.vpcf", context )
end

function woda_neutral_hurricane:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1)
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {})


	Timers:CreateTimer(0, function()
		if not self:GetCaster():IsAlive() then return end
		if target:IsMagicImmune() then self:GetCaster():RemoveModifierByName("modifier_neutral_cast") return end
		self:GetCaster():EmitSound("n_creep_Wildkin.SummonTornado")
		target:AddNewModifier(self:GetCaster(), self, "modifier_woda_neutral_hurricane", {duration = 0.5})
		self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
	end)
end

modifier_woda_neutral_hurricane = class({})

function modifier_woda_neutral_hurricane:OnCreated(kv)
	if not IsServer() then return end
	local point = self:GetParent():GetAbsOrigin() - self:GetCaster():GetAbsOrigin()
	point.z = 0
	self.normalized = point:Normalized()
	self.point = self:GetCaster():GetAbsOrigin() + self.normalized * self:GetAbility():GetSpecialValueFor("range")
	self:StartIntervalThink(FrameTime())
	local effect_cast = ParticleManager:CreateParticle( "particles/neutral_fx/wildkin_ripper_hurricane_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	self:AddParticle(effect_cast, false, false, -1, false, false)
end

function modifier_woda_neutral_hurricane:OnDestroy()
	if not IsServer() then return end
	FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), false)
end

function modifier_woda_neutral_hurricane:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true
	}
end

function modifier_woda_neutral_hurricane:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION
	}
end

function modifier_woda_neutral_hurricane:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

function modifier_woda_neutral_hurricane:OnIntervalThink()
	if not IsServer() then return end
	if self:GetParent():IsDebuffImmune() then return end
    local unit_location = self:GetParent():GetAbsOrigin()
    self:GetParent():SetAbsOrigin(unit_location + self.normalized * 25)
    GridNav:DestroyTreesAroundPoint(self:GetParent():GetAbsOrigin(), 150, true)
end