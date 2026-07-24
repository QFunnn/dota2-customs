--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_kunkka_attacker_thinker", "heroes/npc_dota_hero_kunkka_custom/kunkka_attacker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kunkka_attacker_cast", "heroes/npc_dota_hero_kunkka_custom/kunkka_attacker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kunkka_attacker_delay", "heroes/npc_dota_hero_kunkka_custom/kunkka_attacker", LUA_MODIFIER_MOTION_NONE)

kunkka_attacker = class({})

function kunkka_attacker:OnSpellStart()
	if not IsServer() then return end

	local point = self:GetCursorPosition()

	local thinker = CreateUnitByName("npc_dota_kunkka_mark", point, false, nil, nil, DOTA_TEAM_NEUTRALS)
	thinker:AddNewModifier(self:GetCaster(), self, "modifier_kunkka_attacker_thinker", {})
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_kunkka_attacker_delay", {duration = self:GetSpecialValueFor("delay"), target = thinker:entindex()})
end

modifier_kunkka_attacker_delay = class({})
function modifier_kunkka_attacker_delay:IsPurgable() return false end
function modifier_kunkka_attacker_delay:IsPurgeException() return false end

function modifier_kunkka_attacker_delay:OnCreated(params)
	if not IsServer() then return end
	self:GetAbility():SetActivated(false)
	self.target = params.target
end

function modifier_kunkka_attacker_delay:OnDestroy()
	if not IsServer() then return end
	local duration = (1 / self:GetCaster():GetAttacksPerSecond(true)) - 0.25
	if duration <= 0 then
		duration = FrameTime()
	end
	if not self:GetCaster():IsAlive() then
		self:GetAbility():SetActivated(true)
	end
	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_kunkka_attacker_cast", {duration = duration, target = self.target})
end

modifier_kunkka_attacker_cast = class({})
function modifier_kunkka_attacker_cast:IsPurgable() return false end
function modifier_kunkka_attacker_cast:IsPurgeException() return false end

function modifier_kunkka_attacker_cast:OnCreated( params )
	self.turn_speed = 720
	if not IsServer() then return end
	self:GetCaster():Stop()
	self:GetCaster():AddActivityModifier("Espada_pistola")
	self:GetCaster():AddActivityModifier("tidebringer")
	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, self:GetCaster():GetAttackSpeed(true))
	self.anim_return = 0
	self.target_angle = self:GetParent():GetAnglesAsVector().y
	self.current_angle = self.target_angle
	self.face_target = true
	self.target = EntIndexToHScript(params.target)
	self:StartIntervalThink( FrameTime() )
end

function modifier_kunkka_attacker_cast:OnDestroy()
	if not IsServer() then return end
	local kunkka_tidebringer_custom = self:GetCaster():FindAbilityByName("kunkka_tidebringer_custom")
	local thinker = self.target
	if kunkka_tidebringer_custom then
		self:GetParent().mark = true
		--kunkka_tidebringer_custom:OnOrbImpact( {target = thinker, attacker = self:GetCaster(), damage = self:GetCaster():GetAverageTrueAttackDamage(nil)}, true )
		self:GetCaster():PerformAttack(thinker, true, true, true, true, false, false, true)
        self:GetCaster():PerformAttack(thinker, true, true, true, true, false, false, true)
		self:GetParent().mark = false
	end
	self:GetCaster():Stop()
	Timers:CreateTimer(FrameTime(), function()
		thinker:StartGesture(ACT_DOTA_FLINCH)
		local modifier_kunkka_attacker_thinker = thinker:FindModifierByName("modifier_kunkka_attacker_thinker")
		if modifier_kunkka_attacker_thinker then
			modifier_kunkka_attacker_thinker:SetDuration(0.5, true)
		end
	end)
	self:GetAbility():SetActivated(true)
end

function modifier_kunkka_attacker_cast:OnIntervalThink()
	if not IsServer() then return end

	if self.target then 
		self:SetDirection(self.target:GetAbsOrigin())
	end

	self:TurnLogic( FrameTime() )
end

function modifier_kunkka_attacker_cast:TurnLogic( dt )
	if self.face_target then return end
	local angle_diff = AngleDiff( self.current_angle, self.target_angle )
	local turn_speed = self.turn_speed*dt

	local sign = -1
	if angle_diff<0 then sign = 1 end

	if math.abs( angle_diff )<1.1*turn_speed then
		self.current_angle = self.target_angle
		self.face_target = true
	else
		self.current_angle = self.current_angle + sign*turn_speed
	end

	local angles = self:GetParent():GetAnglesAsVector()
	self:GetParent():SetLocalAngles( angles.x, self.current_angle, angles.z )
end

function modifier_kunkka_attacker_cast:SetDirection( location )
	local dir = ((location-self:GetParent():GetOrigin())*Vector(1,1,0)):Normalized()
	self.target_angle = VectorToAngles( dir ).y
	self.face_target = false
end

function modifier_kunkka_attacker_cast:GetModifierMoveSpeed_Limit()
	return 0.1
end

function modifier_kunkka_attacker_cast:CheckState()
	return
	{
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
	}
end

function modifier_kunkka_attacker_cast:DeclareFunctions()
	local funcs = 
	{
    	MODIFIER_PROPERTY_DISABLE_TURNING,
	}
	return funcs
end

function modifier_kunkka_attacker_cast:GetModifierDisableTurning()
	return self.rotate
end

modifier_kunkka_attacker_thinker = class({})
function modifier_kunkka_attacker_thinker:IsHidden() return true end
function modifier_kunkka_attacker_thinker:IsPurgable() return false end
function modifier_kunkka_attacker_thinker:IsPurgeException() return false end

function modifier_kunkka_attacker_thinker:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
	self.fow = AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), 300, 10, true)
end

function modifier_kunkka_attacker_thinker:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetCaster():IsAlive() then
		self:Destroy()
	end
end

function modifier_kunkka_attacker_thinker:OnDestroy()
	if not IsServer() then return end
	self:GetParent():ForceKill(false)
	if self.fow then
		RemoveFOWViewer(self:GetCaster():GetTeamNumber(), self.fow)
	end
end

function modifier_kunkka_attacker_thinker:CheckState()
	return 
	{
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end

function modifier_kunkka_attacker_thinker:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
	}
	return funcs
end

function modifier_kunkka_attacker_thinker:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_kunkka_attacker_thinker:GetAbsoluteNoDamageMagical()
	return 1
end

function modifier_kunkka_attacker_thinker:GetAbsoluteNoDamagePure()
	return 1
end