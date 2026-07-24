--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_sand_king_caustic_finale_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sand_king_caustic_finale_lua_debuff:IsHidden()
	return false
end

function modifier_sand_king_caustic_finale_lua_debuff:IsDebuff()
	return true
end

function modifier_sand_king_caustic_finale_lua_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
function modifier_sand_king_caustic_finale_lua_debuff:OnCreated( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "caustic_finale_radius" ) 
	self.base_damage = self:GetAbility():GetSpecialValueFor( "caustic_finale_damage_base" ) 
	self.pct_damage = self:GetAbility():GetSpecialValueFor( "caustic_finale_damage_pct" ) 
	self.slow = self:GetAbility():GetSpecialValueFor( "caustic_finale_slow" )
	if kv.has_talent then
	  self.slow = self.slow -8
    end

    if IsServer() then
		ParticleManager:ReleaseParticleIndex( ParticleManager:CreateParticle( "particles/units/heroes/hero_sandking/sandking_caustic_finale_debuff.vpcf", PATTACH_ABSORIGIN, self:GetParent() ) )
	end
end

function modifier_sand_king_caustic_finale_lua_debuff:OnRefresh( kv )
	
end

function modifier_sand_king_caustic_finale_lua_debuff:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sand_king_caustic_finale_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}

	return funcs
end


function modifier_sand_king_caustic_finale_lua_debuff:GetModifierMoveSpeedBonus_Percentage()    
	return self.slow
end

function modifier_sand_king_caustic_finale_lua_debuff:OnDeathEvent( params )
	if IsServer() then
		if params.unit~=self:GetParent() then return end

		-- check if denied
		if params.unit:GetTeamNumber()==params.attacker:GetTeamNumber() then return end

		self:Explode( params.unit )
	end
end

--------------------------------------------------------------------------------
-- Helper function
function modifier_sand_king_caustic_finale_lua_debuff:Explode( hVictim )
	-- find enemies
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetParent():GetOrigin(),
		nil,
		self.radius,	
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

    
	for _,hEnemy in pairs(enemies) do       
        local damageTable = {
           victim = hEnemy,
		   attacker = self:GetCaster(),
		   damage = self.base_damage + hVictim:GetMaxHealth()*(self.pct_damage/100),
		   damage_type = DAMAGE_TYPE_MAGICAL,
		   ability = self:GetAbility(), --Optional.
	    }
		ApplyDamage(damageTable)
	end

	-- effects
	self:PlayEffects()

	-- destroy
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_sand_king_caustic_finale_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_viper/viper_corrosive_debuff.vpcf"
end

function modifier_sand_king_caustic_finale_lua_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_sand_king_caustic_finale_lua_debuff:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_sandking/sandking_caustic_finale_explode.vpcf"
	local sound_cast = "Ability.SandKing_CausticFinale"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end