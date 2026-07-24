--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom", "abilities/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_orb", "abilities/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_debuff", "abilities/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )

drow_ranger_frost_arrows_custom = class({})

function drow_ranger_frost_arrows_custom:GetIntrinsicModifierName()
	return "modifier_drow_ranger_frost_arrows_custom_orb"
end

function drow_ranger_frost_arrows_custom:GetProjectileName()
	return "particles/units/heroes/hero_drow/drow_frost_arrow.vpcf"
end

function drow_ranger_frost_arrows_custom:GetManaCost(level)
    return self.BaseClass.GetManaCost(self, level)
end

function drow_ranger_frost_arrows_custom:OnOrbFire( params )
	self:GetCaster():EmitSound("Hero_DrowRanger.FrostArrows")
end

function drow_ranger_frost_arrows_custom:GetCastRange(vLocation, hTarget)
	return self:GetCaster():Script_GetAttackRange() + 50
end

function drow_ranger_frost_arrows_custom:OnOrbImpact( params )
	local duration = self:GetSpecialValueFor("duration")
	params.target:AddNewModifier( self:GetCaster(), self, "modifier_drow_ranger_frost_arrows_custom", { duration = duration } )
	if not params.target:IsAlive() then return end
	if self:GetCaster():HasScepter() then
		params.target:AddNewModifier( self:GetCaster(), self, "modifier_drow_ranger_frost_arrows_custom_debuff", { duration = self:GetSpecialValueFor("shard_burst_slow_duration") } )
	end
end

function drow_ranger_frost_arrows_custom:OnProjectileHit_ExtraData(target, vLocation, table)
	if not IsServer() then return end
	if target == nil then return end
	local damageTable = 
	{
		victim = target,
		attacker = self:GetCaster(),
		damage = table.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}
	ApplyDamage( damageTable )
	target:AddNewModifier(self:GetCaster(), self, "modifier_drow_ranger_frost_arrows_shard_slow", {duration = self:GetSpecialValueFor("shard_burst_slow_duration")})
end

modifier_drow_ranger_frost_arrows_custom_debuff = class({})

function modifier_drow_ranger_frost_arrows_custom_debuff:OnCreated()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.caster = self:GetCaster()
    self.shard_burst_radius = self.ability:GetSpecialValueFor("shard_burst_radius")
    self.shard_regen_reduction_pct_per_stack = self.ability:GetSpecialValueFor("shard_regen_reduction_pct_per_stack")
    self.shard_burst_damage_per_stack = self.ability:GetSpecialValueFor("shard_burst_damage_per_stack")
	if not IsServer() then return end
	self:SetStackCount(1)
    if self:GetParent():IsHero() then
	    self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_drow/drow_hypothermia_counter_stack.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
	    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )
	    self:AddParticle(self.effect_cast,false, false, -1, false, false)
    end
end

function modifier_drow_ranger_frost_arrows_custom_debuff:OnRefresh()
	if not IsServer() then return end
	if self:GetStackCount() < self:GetAbility():GetSpecialValueFor("shard_max_stacks") then
		self:IncrementStackCount()
        if self.effect_cast then
		    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )
        end
	end
end

function modifier_drow_ranger_frost_arrows_custom_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_drow_ranger_frost_arrows_custom_debuff:OnDeathEvent(params)
	if params.unit == self.parent then
		local enemies = FindUnitsInRadius( self.caster:GetTeamNumber(), self.parent:GetOrigin(), nil, self.shard_burst_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false )
		for _, enemy in pairs(enemies) do
			local info = 
			{
				Target = enemy,
				Source = self.parent,
				Ability = self.ability,	
				EffectName = "particles/units/heroes/hero_drow/drow_shard_hypothermia_projectile.vpcf",
				iMoveSpeed = self.caster:GetProjectileSpeed(),
				bDodgeable = false,
				bVisibleToEnemies = true,
				bProvidesVision = false,
				iVisionTeamNumber = self.caster:GetTeamNumber(),
				ExtraData = 
				{
					damage = self.shard_burst_damage_per_stack * self:GetStackCount(),
				}
			}
			ProjectileManager:CreateTrackingProjectile(info)
		end
	end
end

function modifier_drow_ranger_frost_arrows_custom_debuff:GetModifierLifestealRegenAmplify_Percentage()
	return self.shard_regen_reduction_pct_per_stack * self:GetStackCount()
end

function modifier_drow_ranger_frost_arrows_custom_debuff:GetModifierHealAmplify_PercentageTarget()
	return self.shard_regen_reduction_pct_per_stack * self:GetStackCount()
end

function modifier_drow_ranger_frost_arrows_custom_debuff:GetModifierHPRegenAmplify_Percentage()
	return self.shard_regen_reduction_pct_per_stack * self:GetStackCount()
end

modifier_drow_ranger_frost_arrows_custom = class({})

function modifier_drow_ranger_frost_arrows_custom:IsHidden()
	return false
end

function modifier_drow_ranger_frost_arrows_custom:IsDebuff()
	return true
end

function modifier_drow_ranger_frost_arrows_custom:IsStunDebuff()
	return false
end

function modifier_drow_ranger_frost_arrows_custom:IsPurgable()
	return true
end

function modifier_drow_ranger_frost_arrows_custom:OnCreated( kv )
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
	self.slow = self.ability:GetSpecialValueFor( "frost_arrows_movement_speed" )
    self.percent_damage = self.ability:GetSpecialValueFor("percent_damage")
	if not IsServer() then return end
	self:StartIntervalThink(1)
end

function modifier_drow_ranger_frost_arrows_custom:OnRefresh( kv )
    self.slow = self.ability:GetSpecialValueFor( "frost_arrows_movement_speed" )
    self.percent_damage = self.ability:GetSpecialValueFor("percent_damage")
end

function modifier_drow_ranger_frost_arrows_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_drow_ranger_frost_arrows_custom:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_drow_ranger_frost_arrows_custom:GetEffectName()
	return "particles/generic_gameplay/generic_slowed_cold.vpcf"
end

function modifier_drow_ranger_frost_arrows_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_drow_ranger_frost_arrows_custom:OnIntervalThink()
	if not IsServer() then return end
	local damage = self.parent:GetHealth() / 100 * self.percent_damage
	ApplyDamage({ attacker = self.caster, victim = self.parent, damage = math.max(1, damage), damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability })
end

modifier_drow_ranger_frost_arrows_custom_orb = class({})

function modifier_drow_ranger_frost_arrows_custom_orb:IsHidden()
	return true
end

function modifier_drow_ranger_frost_arrows_custom_orb:IsDebuff()
	return false
end

function modifier_drow_ranger_frost_arrows_custom_orb:IsPurgable()
	return false
end

function modifier_drow_ranger_frost_arrows_custom_orb:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_drow_ranger_frost_arrows_custom_orb:OnCreated( kv )
    self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.cast = false
    self.chance = self.ability:GetSpecialValueFor("chance")
	self.records = {}
end

function modifier_drow_ranger_frost_arrows_custom_orb:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_EVENT_ON_ATTACK_FAIL,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		MODIFIER_EVENT_ON_ORDER,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}

	return funcs
end

function modifier_drow_ranger_frost_arrows_custom_orb:AttackModifier( params )
	if params.attacker~=self.parent then return end
	if self:ShouldLaunch( params.target ) then
		self.ability:UseResources( true, false, false, true )
		self.records[params.record] = true
		if self.ability.OnOrbFire then self.ability:OnOrbFire( params ) end
	end

	self.cast = false
end

function modifier_drow_ranger_frost_arrows_custom_orb:GetModifierProcAttack_Feedback( params )
	if self.records[params.record] then
		if self.ability.OnOrbImpact then self.ability:OnOrbImpact( params ) end
	end
end
function modifier_drow_ranger_frost_arrows_custom_orb:OnAttackFail( params )
	if self.records[params.record] then
		if self.ability.OnOrbFail then self.ability:OnOrbFail( params ) end
	end
end
function modifier_drow_ranger_frost_arrows_custom_orb:OnAttackRecordDestroy( params )
	self.records[params.record] = nil
end

function modifier_drow_ranger_frost_arrows_custom_orb:OnOrder( params )
	if params.unit~=self.parent then return end

	if params.ability then
		if params.ability==self.ability then
			self.cast = true
			return
		end
		local pass = false
		local behavior = params.ability:GetBehaviorInt()
		if self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_CHANNEL ) or 
			self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT ) or
			self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL )
		then
			local pass = true -- do nothing
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

function modifier_drow_ranger_frost_arrows_custom_orb:GetModifierProjectileName()
	if self:ShouldLaunch( self.parent:GetAggroTarget() ) then
		return "particles/units/heroes/hero_drow/drow_frost_arrow.vpcf"
	end
	return "particles/units/heroes/hero_drow/drow_base_attack.vpcf"
end

function modifier_drow_ranger_frost_arrows_custom_orb:ShouldLaunch( target )
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
				self.parent:GetTeamNumber()
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

function modifier_drow_ranger_frost_arrows_custom_orb:FlagExist(a,b)
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end

function modifier_drow_ranger_frost_arrows_custom_orb:GetModifierProcAttack_BonusDamage_Physical(params)
	local damage = 0
	if self.records[params.record] then
		local bonus = 0
		local modifier_drow_ranger_frost_arrows_custom_debuff = params.target:FindModifierByName("modifier_drow_ranger_frost_arrows_custom_debuff")
		if modifier_drow_ranger_frost_arrows_custom_debuff then
			bonus = modifier_drow_ranger_frost_arrows_custom_debuff:GetStackCount() * self.ability:GetSpecialValueFor("shard_bonus_damage_per_stack")
		end
		return self.ability:GetSpecialValueFor("damage") + bonus
	end
end