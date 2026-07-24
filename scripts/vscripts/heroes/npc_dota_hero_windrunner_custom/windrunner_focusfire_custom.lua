--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_windrunner_focusfire_custom", "heroes/npc_dota_hero_windrunner_custom/windrunner_focusfire_custom" , LUA_MODIFIER_MOTION_NONE )

windrunner_focusfire_custom = class({})

function windrunner_focusfire_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb( self ) then return end
	local duration = self:GetSpecialValueFor("duration")

	local found = false
	local modifiers = caster:FindAllModifiersByName( "modifier_windrunner_focusfire_custom" )
	for _,modifier in pairs(modifiers) do
		if modifier.target==target then
			modifier:ForceRefresh()
			found = true
			break
		end
	end

	if not found then
		local ent = target:entindex()
		caster:AddNewModifier( caster, self, "modifier_windrunner_focusfire_custom", { duration = duration, target = ent } )
	end

	caster:MoveToTargetToAttack(target)

	self:GetCaster():EmitSound("Ability.Focusfire")
end

modifier_windrunner_focusfire_custom = class({})

function modifier_windrunner_focusfire_custom:IsPurgable()
	return false
end

function modifier_windrunner_focusfire_custom:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_windrunner_focusfire_custom:OnCreated( kv )
	self.reduction = self:GetAbility():GetSpecialValueFor( "focusfire_damage_reduction" )
	if not IsServer() then return end
	self.bonus = self:GetAbility():GetSpecialValueFor( "bonus_attack_speed" )
	self.target = EntIndexToHScript( kv.target )
	self.turning = 1
	self:StartIntervalThink( FrameTime() )
	self:OnIntervalThink()
end

function modifier_windrunner_focusfire_custom:OnRefresh( kv )
	self.reduction = self:GetAbility():GetSpecialValueFor( "focusfire_damage_reduction" )
	if not IsServer() then return end
	self.turning = 1
	self.bonus = self:GetAbility():GetSpecialValueFor( "bonus_attack_speed" )
end

function modifier_windrunner_focusfire_custom:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_EVENT_ON_ORDER,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_DISABLE_TURNING
	}
	return funcs
end

function modifier_windrunner_focusfire_custom:GetModifierDisableTurning()
	return self.turning
end

function modifier_windrunner_focusfire_custom:GetModifierAttackSpeedBonus_Constant()
	if IsClient() then
		return self.bonus
	end
	if not IsServer() then return end
	local aggro = self:GetParent():GetAggroTarget()
	if aggro and aggro~=self.target then return end
	return self.bonus
end

function modifier_windrunner_focusfire_custom:GetModifierDamageOutgoing_Percentage()
	if IsClient() then
		return self.reduction
	end
	if not IsServer() then return end
	local aggro = self:GetParent():GetAggroTarget()
	if aggro and aggro~=self.target then return end
	return self.reduction
end

function modifier_windrunner_focusfire_custom:OnOrder( params )
	if not IsServer() then return end
	if params.unit~=self:GetParent() then return end

	if params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET and params.target==self.target then
		self.follow = true
	else
		self.follow = false
	end

	if params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET and params.target~=self.target then
		self.attacking = false
		self.turning = 0
	elseif params.order_type==DOTA_UNIT_ORDER_HOLD_POSITION then
		self.attacking = false
		self.turning = 0
	elseif params.order_type==DOTA_UNIT_ORDER_CONTINUE then
		self.attacking = false
		self.turning = 0
	elseif params.order_type==DOTA_UNIT_ORDER_STOP then
		self.attacking = false
		self.turning = 0
	elseif params.order_type==DOTA_UNIT_ORDER_MOVE_TO_DIRECTION then

	elseif params.order_type==DOTA_UNIT_ORDER_CAST_POSITION then

	elseif params.order_type==DOTA_UNIT_ORDER_CAST_TARGET then

	elseif params.order_type==DOTA_UNIT_ORDER_CAST_NO_TARGET then

	elseif params.order_type==DOTA_UNIT_ORDER_TRAIN_ABILITY then

	else
		self.attacking = true
		self.turning = 1
	end
end

function modifier_windrunner_focusfire_custom:OnIntervalThink()
	if self.target:IsNull() or (not self.target:IsAlive() and not self.target:IsReincarnating()) then
		self:StartIntervalThink(-1)
		self:Destroy()
		return
	end

	local distance = (self.target:GetOrigin()-self:GetParent():GetOrigin()):Length2D()
	local range = self:GetParent():Script_GetAttackRange(  )

	self.inRange = distance<=range

	if not self.inRange or not self.target:IsAlive() or self:GetParent():IsDisarmed() or self:GetParent():IsStunned() or not self:GetParent():CanEntityBeSeenByMyTeam(self.target) or self:GetParent():IsChanneling() or self.target:IsAttackImmune() or self.target:IsInvulnerable() then
		self.turning = 0
	end

	if self.inRange and self.attacking and self.target:IsAlive() and self:GetParent():AttackReady() and not self:GetParent():IsDisarmed() and not self:GetParent():IsStunned() and self:GetParent():CanEntityBeSeenByMyTeam(self.target) and not self:GetParent():IsChanneling() and not self.target:IsAttackImmune() and not self.target:IsInvulnerable() then
		if self.follow then
			self:GetParent():MoveToNPC( self.target )
		end
		self:GetParent():PerformAttack( self.target, true, true, false, false, true, false, false )
		local direction = self.target:GetAbsOrigin() - self:GetParent():GetAbsOrigin()
		direction.z = 0
		direction = direction:Normalized()
		if not self:GetParent():IsCurrentlyHorizontalMotionControlled() and not self:GetParent():IsCurrentlyVerticalMotionControlled() then
			self:GetParent():SetForwardVector(direction)
			self:GetParent():FaceTowards(self.target:GetAbsOrigin())
		end
	end
end

function modifier_windrunner_focusfire_custom:GetActivityTranslationModifiers()
	return "focusfire"
end