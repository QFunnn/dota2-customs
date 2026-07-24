--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_doom_bringer_infernal_blade_custom", "heroes/npc_dota_hero_doom_bringer_custom/doom_bringer_infernal_blade_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_doom_bringer_infernal_blade_custom_debuff", "heroes/npc_dota_hero_doom_bringer_custom/doom_bringer_infernal_blade_custom", LUA_MODIFIER_MOTION_NONE )

doom_bringer_infernal_blade_custom = class({})

doom_bringer_infernal_blade_custom.modifier_doom_bringer_8 = {1,2}
doom_bringer_infernal_blade_custom.modifier_doom_bringer_10 = {30,60}
doom_bringer_infernal_blade_custom.modifier_doom_bringer_13 = {0.5,1,1.5}
doom_bringer_infernal_blade_custom.modifier_doom_bringer_12 = {1,2}

function doom_bringer_infernal_blade_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_doom_bringer/doom_infernal_blade_debuff.vpcf', context )
    PrecacheResource( "particle", 'particles/status_fx/status_effect_burn.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_doom_bringer/doom_infernal_blade_impact.vpcf', context )
end

function doom_bringer_infernal_blade_custom:CastFilterResultTarget(target)
	if not self:GetCaster():HasModifier("modifier_doom_bringer_12") then
		if target ~= nil and target:IsMagicImmune() then
			return UF_FAIL_MAGIC_IMMUNE_ENEMY
		end
	end
	return UnitFilter(target, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, self:GetCaster():GetTeamNumber())
end

function doom_bringer_infernal_blade_custom:GetIntrinsicModifierName()
	return "modifier_doom_bringer_infernal_blade_custom"
end

function doom_bringer_infernal_blade_custom:OnOrbFire()
    if not IsServer() then return end
    if self:GetCaster():IsRangedAttacker() then
        self:UseResources(true, false, false, true)
    end
end

function doom_bringer_infernal_blade_custom:OnOrbImpact( params )
	if not IsServer() then return end
    if not params.is_ability then
        self:UseResources( true, false, false, true )
    end
	self:GetCaster():ClearActivityModifiers()
	local duration = self:GetSpecialValueFor( "burn_duration" )

	if self:GetCaster():HasModifier("modifier_doom_bringer_12") then
		duration = duration + self.modifier_doom_bringer_12[self:GetCaster():GetTalentLevel("modifier_doom_bringer_12")]
	end

	local ministun_duration = self:GetSpecialValueFor( "ministun_duration" )
	local doom_bringer_doom_custom = self:GetCaster():FindAbilityByName("doom_bringer_doom_custom")
	params.target:AddNewModifier( self:GetCaster(), self, "modifier_doom_bringer_infernal_blade_custom_debuff", { duration = duration * (1-params.target:GetStatusResistance()) } )
	params.target:AddNewModifier( self:GetCaster(), self, "modifier_stunned", { duration = ministun_duration * (1-params.target:GetStatusResistance()) } )
	
	if doom_bringer_doom_custom and doom_bringer_doom_custom:GetLevel() > 0 and self:GetCaster():HasModifier("modifier_doom_bringer_13") then
		doom_bringer_doom_custom:ApplyDoom(params.target, self.modifier_doom_bringer_13[self:GetCaster():GetTalentLevel("modifier_doom_bringer_13")])
	end

	if self:GetCaster():HasModifier("modifier_doom_bringer_8") then
		local maximum = self.modifier_doom_bringer_8[self:GetCaster():GetTalentLevel("modifier_doom_bringer_8")]
		local current = 0
		local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), params.target:GetOrigin(), nil, 300, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
		for _, enemy in pairs(enemies) do
			if enemy ~= params.target then
				enemy:AddNewModifier( self:GetCaster(), self, "modifier_doom_bringer_infernal_blade_custom_debuff", { duration = duration * (1-enemy:GetStatusResistance()) } )
				enemy:AddNewModifier( self:GetCaster(), self, "modifier_stunned", { duration = ministun_duration * (1-enemy:GetStatusResistance()) } )
				if doom_bringer_doom_custom and doom_bringer_doom_custom:GetLevel() > 0 and self:GetCaster():HasModifier("modifier_doom_bringer_13") then
					doom_bringer_doom_custom:ApplyDoom(enemy, self.modifier_doom_bringer_13[self:GetCaster():GetTalentLevel("modifier_doom_bringer_13")])
				end
				current = current + 1
				if current >= maximum then break end
			end
		end
	end
end

modifier_doom_bringer_infernal_blade_custom_debuff = class({})

function modifier_doom_bringer_infernal_blade_custom_debuff:OnCreated( kv )
	if not IsServer() then return end

	self.damage = self:GetAbility():GetSpecialValueFor( "burn_damage" )

	if self:GetCaster():HasModifier("modifier_doom_bringer_10") then
		self.damage = self.damage + self:GetAbility().modifier_doom_bringer_10[self:GetCaster():GetTalentLevel("modifier_doom_bringer_10")]
	end

	self.damage_pct = self:GetAbility():GetSpecialValueFor( "burn_damage_pct" )

	local interval = 1

	self.damageTable = 
	{
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
	}

	self:StartIntervalThink( interval )
	self:PlayEffects()
end

function modifier_doom_bringer_infernal_blade_custom_debuff:OnRefresh( kv )
	if not IsServer() then return end
	self.damage = self:GetAbility():GetSpecialValueFor( "burn_damage" )
	if self:GetCaster():HasModifier("modifier_doom_bringer_10") then
		self.damage = self.damage + self:GetAbility().modifier_doom_bringer_10[self:GetCaster():GetTalentLevel("modifier_doom_bringer_10")]
	end
	self.damage_pct = self:GetAbility():GetSpecialValueFor( "burn_damage_pct" )
	local interval = 1
	self:StartIntervalThink( interval )
	self:PlayEffects()
end

function modifier_doom_bringer_infernal_blade_custom_debuff:OnIntervalThink()
	self.damageTable.damage = self.damage + ((self.damage_pct/100) * self:GetParent():GetMaxHealth())
	ApplyDamage( self.damageTable )
end

function modifier_doom_bringer_infernal_blade_custom_debuff:GetEffectName()
	return "particles/units/heroes/hero_doom_bringer/doom_infernal_blade_debuff.vpcf"
end

function modifier_doom_bringer_infernal_blade_custom_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_burn.vpcf"
end

function modifier_doom_bringer_infernal_blade_custom_debuff:StatusEffectPriority()
	return 10
end

function modifier_doom_bringer_infernal_blade_custom_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_doom_bringer_infernal_blade_custom_debuff:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_doom_bringer/doom_infernal_blade_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self:GetParent():EmitSound("Hero_DoomBringer.InfernalBlade.Target")
end

modifier_doom_bringer_infernal_blade_custom = class({})

function modifier_doom_bringer_infernal_blade_custom:IsHidden()
	return true
end

function modifier_doom_bringer_infernal_blade_custom:IsDebuff()
	return false
end

function modifier_doom_bringer_infernal_blade_custom:IsPurgable()
	return false
end

function modifier_doom_bringer_infernal_blade_custom:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_doom_bringer_infernal_blade_custom:OnCreated( kv )
	self.ability = self:GetAbility()
	self.cast = false
	self.records = {}
end

function modifier_doom_bringer_infernal_blade_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_FAIL,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		MODIFIER_EVENT_ON_ORDER,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_EVENT_ON_ATTACK_START,
	}
	return funcs
end

function modifier_doom_bringer_infernal_blade_custom:OnAttack( params )
	if params.attacker~=self:GetParent() then return end
	self:GetParent():ClearActivityModifiers()
	if self:ShouldLaunch( params.target ) then
		self.records[params.record] = true
		if self.ability.OnOrbFire then self.ability:OnOrbFire( params ) end
	end
	self.cast = false
end

function modifier_doom_bringer_infernal_blade_custom:GetModifierProcAttack_Feedback( params )
	if self.records[params.record] then
		if self.ability.OnOrbImpact then self.ability:OnOrbImpact( params ) end
	end
end

function modifier_doom_bringer_infernal_blade_custom:OnAttackFail( params )
	if self.records[params.record] then
		if self.ability.OnOrbFail then self:GetParent():ClearActivityModifiers() self.ability:OnOrbFail( params ) end
	end
end

function modifier_doom_bringer_infernal_blade_custom:OnAttackRecordDestroy( params )
	self:GetParent():ClearActivityModifiers()
	self.records[params.record] = nil
end

function modifier_doom_bringer_infernal_blade_custom:OnOrder( params )
	if params.unit~=self:GetParent() then return end

	if params.ability then
		if params.ability==self:GetAbility() then
			self.cast = true
			return
		end

		local pass = false
		local behavior = params.ability:GetBehaviorInt()
		if self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_CHANNEL ) or 
			self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT ) or
			self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL )
		then
			local pass = true
		end

		if self.cast and (not pass) then
			self.cast = false
		end
	else
		if self.cast then
			if self:FlagExist( params.order_type, DOTA_UNIT_ORDER_MOVE_TO_POSITION ) or
				self:FlagExist( params.order_type, DOTA_UNIT_ORDER_MOVE_TO_TARGET )	or
				self:FlagExist( params.order_type, DOTA_UNIT_ORDER_ATTACK_MOVE ) or
				self:FlagExist( params.order_type, DOTA_UNIT_ORDER_ATTACK_TARGET ) or
				self:FlagExist( params.order_type, DOTA_UNIT_ORDER_STOP ) or
				self:FlagExist( params.order_type, DOTA_UNIT_ORDER_HOLD_POSITION )
			then
				self.cast = false
			end
		end
	end
end

function modifier_doom_bringer_infernal_blade_custom:GetModifierProjectileName()
	if not self.ability.GetProjectileName then return end

	if self:ShouldLaunch( self:GetCaster():GetAggroTarget() ) then
		return self.ability:GetProjectileName()
	end
end

function modifier_doom_bringer_infernal_blade_custom:OnAttackStart(params)
	if params.attacker~=self:GetParent() then return end
	if self:ShouldLaunch( params.target ) then
    	self:GetParent():EmitSound("Hero_DoomBringer.InfernalBlade.PreAttack")
    	self:GetParent():AddActivityModifier("infernal_blade")
	end
end

function modifier_doom_bringer_infernal_blade_custom:GetActivityTranslationModifiers(params)
	if self.cast then
		return "infernal_blade"
	end
end

function modifier_doom_bringer_infernal_blade_custom:ShouldLaunch( target )
	if self.ability:GetAutoCastState() then
		if self.ability.CastFilterResultTarget~=CDOTA_Ability_Lua.CastFilterResultTarget then
			if self.ability:CastFilterResultTarget( target )==UF_SUCCESS then
				self.cast = true
			end
		else
			local nResult = UnitFilter(
				target,
				self.ability:GetAbilityTargetTeam(),
				self.ability:GetAbilityTargetType(),
				self.ability:GetAbilityTargetFlags(),
				self:GetCaster():GetTeamNumber()
			)
			if nResult == UF_SUCCESS then
				self.cast = true
			end
		end
	end

	if self.cast and self.ability:IsFullyCastable() and (not self:GetParent():IsSilenced()) then
		return true
	end

	return false
end

function modifier_doom_bringer_infernal_blade_custom:FlagExist(a,b)
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end