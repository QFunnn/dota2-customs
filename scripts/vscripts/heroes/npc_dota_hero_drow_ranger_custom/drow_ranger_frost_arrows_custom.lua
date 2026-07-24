--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom", "heroes/npc_dota_hero_drow_ranger_custom/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_3", "heroes/npc_dota_hero_drow_ranger_custom/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_orb", "heroes/npc_dota_hero_drow_ranger_custom/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )

drow_ranger_frost_arrows_custom = class({})

drow_ranger_frost_arrows_custom.modifier_drow_ranger_1_bonus_damage = {10,20,30}
drow_ranger_frost_arrows_custom.modifier_drow_ranger_3_str_bonus_damage = {10,20}

drow_ranger_frost_arrows_custom.modifier_drow_ranger_3_max_stack = 6
drow_ranger_frost_arrows_custom.modifier_drow_ranger_3_radius = 400
drow_ranger_frost_arrows_custom.modifier_drow_ranger_3_heal_reduce = -5
drow_ranger_frost_arrows_custom.modifier_drow_ranger_3_duration = 6

drow_ranger_frost_arrows_custom.modifier_drow_ranger_6_damage_str = {25, 50}

function drow_ranger_frost_arrows_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_crystal_maiden.vsndevts", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_frost_arrow.vpcf", context )
    PrecacheResource( "particle", "particles/generic_gameplay/generic_slowed_cold.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_marksmanship_frost_arrow.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_marksmanship_attack.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_frost_arrow.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_base_attack.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_hypothermia_counter_stack.vpcf", context )
    PrecacheResource( "particle", "particles/drow_silence.vpcf", context )
    PrecacheResource( "particle", "particles/drow_silence.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_drow_ranger.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_drow_ranger.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_drow_ranger.vpcf", context)
end


function drow_ranger_frost_arrows_custom:GetIntrinsicModifierName()
	return "modifier_drow_ranger_frost_arrows_custom_orb"
end

function drow_ranger_frost_arrows_custom:GetProjectileName()
	return "particles/units/heroes/hero_drow/drow_frost_arrow.vpcf"
end

function drow_ranger_frost_arrows_custom:GetManaCost(level)
	if self:GetCaster():HasModifier("modifier_drow_ranger_3") then
		return 0
	end
    return self.BaseClass.GetManaCost(self, level)
end

function drow_ranger_frost_arrows_custom:GetHealthCost(level)
    if self:GetCaster():HasModifier("modifier_drow_ranger_3") then
        return self.BaseClass.GetManaCost(self, level)
    end
    return 0
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
	if self:GetCaster():HasModifier("modifier_drow_ranger_4") then
		params.target:AddNewModifier( self:GetCaster(), self, "modifier_drow_ranger_frost_arrows_custom_3", { duration = self.modifier_drow_ranger_3_duration } )
	end
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
	self.slow = self:GetAbility():GetSpecialValueFor( "frost_arrows_movement_speed" )
end

function modifier_drow_ranger_frost_arrows_custom:OnRefresh( kv )
	self.slow = self:GetAbility():GetSpecialValueFor( "frost_arrows_movement_speed" )
end

function modifier_drow_ranger_frost_arrows_custom:DeclareFunctions()
	local funcs = {
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
	self.ability = self:GetAbility()
	self.cast = false
	self.records = {}
end

function modifier_drow_ranger_frost_arrows_custom_orb:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_FAIL,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		MODIFIER_EVENT_ON_ORDER,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}

	return funcs
end

function modifier_drow_ranger_frost_arrows_custom_orb:OnAttack( params )
	if params.attacker~=self:GetParent() then return end
	if self:ShouldLaunch( params.target ) then
		if not params.no_attack_cooldown then
			self.ability:UseResources( true, true, false, true )
		end
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
	local modifier_drow_ranger_marksmanship_custom = self:GetParent():FindModifierByName("modifier_drow_ranger_marksmanship_custom")

	if modifier_drow_ranger_marksmanship_custom and modifier_drow_ranger_marksmanship_custom.procs and self:ShouldLaunch( self:GetCaster():GetAggroTarget() ) then
		return "particles/units/heroes/hero_drow/drow_marksmanship_frost_arrow.vpcf"
	end

	if modifier_drow_ranger_marksmanship_custom and modifier_drow_ranger_marksmanship_custom.procs then
		return "particles/units/heroes/hero_drow/drow_marksmanship_attack.vpcf"
	end

	if self:ShouldLaunch( self:GetCaster():GetAggroTarget() ) then
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
		if self:GetCaster():HasModifier("modifier_drow_ranger_1") then
			bonus = bonus + self:GetAbility().modifier_drow_ranger_1_bonus_damage[self:GetCaster():GetTalentLevel("modifier_drow_ranger_1")]
		end
		if self:GetCaster():HasModifier("modifier_drow_ranger_3") then
			bonus = bonus + self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_drow_ranger_3_str_bonus_damage[self:GetCaster():GetTalentLevel("modifier_drow_ranger_3")]
		end
		return self:GetAbility():GetSpecialValueFor("damage") + bonus
	end
end

modifier_drow_ranger_frost_arrows_custom_3 = class({})

function modifier_drow_ranger_frost_arrows_custom_3:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_drow/drow_hypothermia_counter_stack.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )
	self:AddParticle(self.effect_cast,false, false, -1, false, false)
end

function modifier_drow_ranger_frost_arrows_custom_3:OnRefresh()
	if not IsServer() then return end
	if self:GetStackCount() < self:GetAbility().modifier_drow_ranger_3_max_stack then
		self:IncrementStackCount()
		ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )
	end

	if self:GetStackCount() >= self:GetAbility().modifier_drow_ranger_3_max_stack then
		if self:GetCaster():HasModifier("modifier_drow_ranger_6") then
			local spawn_pfx = ParticleManager:CreateParticle("particles/drow_silence.vpcf", PATTACH_WORLDORIGIN, nil)
			ParticleManager:SetParticleControl(spawn_pfx, 0, self:GetParent():GetAbsOrigin())
			ParticleManager:SetParticleControl(spawn_pfx, 1, Vector(self:GetAbility().modifier_drow_ranger_3_radius, self:GetAbility().modifier_drow_ranger_3_radius, self:GetAbility().modifier_drow_ranger_3_radius))
			ParticleManager:ReleaseParticleIndex(spawn_pfx)

			self:GetParent():EmitSound("Hero_Crystal.CrystalNova.Yulsaria")

			local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self:GetAbility().modifier_drow_ranger_3_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false )
			for _, enemy in pairs(enemies) do
				local damage = self:GetAbility():GetSpecialValueFor("damage")

				if self:GetCaster():HasModifier("modifier_drow_ranger_1") then
					damage = damage + self:GetAbility().modifier_drow_ranger_1_bonus_damage[self:GetCaster():GetTalentLevel("modifier_drow_ranger_1")]
				end

				if self:GetCaster():HasModifier("modifier_drow_ranger_3") then
					damage = (damage + self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_drow_ranger_3_str_bonus_damage[self:GetCaster():GetTalentLevel("modifier_drow_ranger_3")]) * self:GetStackCount()
				end

				damage = damage + ( self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_drow_ranger_6_damage_str[self:GetCaster():GetTalentLevel("modifier_drow_ranger_6")])

				ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
			end

			self:Destroy()
		end
	end
end

function modifier_drow_ranger_frost_arrows_custom_3:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
		MODIFIER_EVENT_ON_DEATH
	}
end

function modifier_drow_ranger_frost_arrows_custom_3:OnDeath(params)
	if params.unit == self:GetParent() then
		local spawn_pfx = ParticleManager:CreateParticle("particles/drow_silence.vpcf", PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(spawn_pfx, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(spawn_pfx, 1, Vector(self:GetAbility().modifier_drow_ranger_3_radius, self:GetAbility().modifier_drow_ranger_3_radius, self:GetAbility().modifier_drow_ranger_3_radius))
		ParticleManager:ReleaseParticleIndex(spawn_pfx)

		self:GetParent():EmitSound("Hero_Crystal.CrystalNova.Yulsaria")

		local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self:GetAbility().modifier_drow_ranger_3_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false )
		for _, enemy in pairs(enemies) do
			local damage = self:GetAbility():GetSpecialValueFor("damage")

			if self:GetCaster():HasModifier("modifier_drow_ranger_1") then
				damage = damage + self:GetAbility().modifier_drow_ranger_1_bonus_damage[self:GetCaster():GetTalentLevel("modifier_drow_ranger_1")]
			end

			if self:GetCaster():HasModifier("modifier_drow_ranger_3") then
				damage = damage + self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_drow_ranger_3_str_bonus_damage[self:GetCaster():GetTalentLevel("modifier_drow_ranger_3")]
			end

			ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = damage * self:GetStackCount(), damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
		end
	end
end

function modifier_drow_ranger_frost_arrows_custom_3:GetModifierPropertyRestorationAmplification()
	return self:GetAbility().modifier_drow_ranger_3_heal_reduce * self:GetStackCount()
end

function modifier_drow_ranger_frost_arrows_custom_3:GetTexture()
	return "drow_ranger_4"
end