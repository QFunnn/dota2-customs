--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_enraged_wildkin_hurricane_lua", "creature_ability/enraged_wildkin_hurricane_lua.lua", LUA_MODIFIER_MOTION_HORIZONTAL)
--Abilities
if enraged_wildkin_hurricane_lua == nil then
	enraged_wildkin_hurricane_lua = class({})
end

function enraged_wildkin_hurricane_lua:OnSpellStart()
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("duration")
	EmitSoundOn("n_creep_Wildkin.SummonTornado", hCaster)
	if IsValid(hCaster) and IsValid(hTarget) and not hTarget:TriggerSpellAbsorb(self) and not hTarget:HasState(MODIFIER_STATE_DEBUFF_IMMUNE) then
		local vDir = (hCaster:GetAbsOrigin() - hTarget:GetAbsOrigin()):Normalized()
		hTarget:AddNewModifier(hCaster, self, "modifier_enraged_wildkin_hurricane_lua", { x = vDir.x, y = vDir.y, z = vDir.z, duration = duration })
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_enraged_wildkin_hurricane_lua == nil then
	modifier_enraged_wildkin_hurricane_lua = class({})
end
function modifier_enraged_wildkin_hurricane_lua:IsHidden(params)
	return false
end
function modifier_enraged_wildkin_hurricane_lua:IsDebuff(params)
	return true
end
function modifier_enraged_wildkin_hurricane_lua:IsPurgable(params)
	return true
end
function modifier_enraged_wildkin_hurricane_lua:IsPurgeException(params)
	return true
end
function modifier_enraged_wildkin_hurricane_lua:OnCreated(params)
	self.distance = self:GetAbilitySpecialValueFor("distance")
	self.speed = self:GetAbilitySpecialValueFor("speed")
	if IsServer() then
		self.dir = Vector(params.x, params.y, params.z)
		self.fTraveled = 0
		if not self:ApplyHorizontalMotionController() then
			self:Destory()
		end
	end
end
function modifier_enraged_wildkin_hurricane_lua:OnRefresh(params)
	self.distance = self:GetAbilitySpecialValueFor("distance")
	self.speed = self:GetAbilitySpecialValueFor("speed")
	if IsServer() then
	end
end
function modifier_enraged_wildkin_hurricane_lua:OnDestroy()
	if IsServer() then
		local hParent = self:GetParent()
		FindClearSpaceForUnit(hParent, hParent:GetAbsOrigin(), true)
	end
end
function modifier_enraged_wildkin_hurricane_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION
	}
end
function modifier_enraged_wildkin_hurricane_lua:OnHorizontalMotionInterrupted()
	self:Destroy()
end
function modifier_enraged_wildkin_hurricane_lua:UpdateHorizontalMotion(me, dt)
	if IsServer() then
		if self.fTraveled < self.distance then
			local vNewPos = me:GetAbsOrigin() + self.dir * self.speed * dt
			me:SetAbsOrigin(vNewPos)
			self.fTraveled = self.fTraveled + self.speed * dt
		else
			self:OnDestroy()
		end
	end
end
function modifier_enraged_wildkin_hurricane_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_enraged_wildkin_hurricane_lua:GetEffectName()
	return "particles/neutral_fx/wildkin_ripper_hurricane_ambient.vpcf"
end
function modifier_enraged_wildkin_hurricane_lua:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end