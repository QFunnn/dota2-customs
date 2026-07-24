--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_centaur_return_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_centaur_return_lua:IsHidden()
	return false
end

function modifier_centaur_return_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_centaur_return_lua:OnCreated( kv )
	-- references
	self.base_damage = self:GetAbility():GetSpecialValueFor( "return_damage" ) -- special value
	self.strength_pct = self:GetAbility():GetSpecialValueFor( "strength_pct" ) -- special value
end

function modifier_centaur_return_lua:OnRefresh( kv )
	-- references
	self.base_damage = self:GetAbility():GetSpecialValueFor( "return_damage" ) -- special value
	self.strength_pct = self:GetAbility():GetSpecialValueFor( "strength_pct" ) -- special value
end

function modifier_centaur_return_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_centaur_return_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACKED,
	}

	return funcs
end
function modifier_centaur_return_lua:OnAttacked( params )
	if IsServer() then
		if self:GetParent():IsIllusion() or self:GetParent():PassivesDisabled() then
			return
		end
		if params.unit==self:GetParent() or self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION ) then
			return
		end

		if params.target~=self:GetParent() then
			return
		end

		if self:GetParent() and self:GetParent():IsRealHero() and self:GetParent().GetStrength then
			-- get damage
			local damage = self.base_damage + self:GetParent():GetStrength()*(self.strength_pct/100)
	        
	        local talent = self:GetAbility():GetCaster():FindAbilityByName("special_bonus_unique_centaur_3")
		    if talent and talent:GetLevel() > 0 then
		        damage = damage + talent:GetSpecialValueFor("value")
		    end

			-- Apply Damage
			local damageTable = {
				victim = params.attacker,
				attacker = self:GetAbility():GetCaster(),
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				damage_flags = DOTA_DAMAGE_FLAG_REFLECTION,
				ability = self:GetAbility(), --Optional.
			}
			ApplyDamage(damageTable)

			-- Play effects
			if params.attacker:IsConsideredHero() then
				self:PlayEffects( params.attacker )
			end
		end
	end
end

-- Helper: Flag operations
function modifier_centaur_return_lua:FlagExist(a,b)--Bitwise Exist
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end

--------------------------------------------------------------------------------
-- Graphics & Animations

function modifier_centaur_return_lua:PlayEffects( target )
	local particle_cast = "particles/units/heroes/hero_centaur/centaur_return.vpcf"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetOrigin(), -- unknown
		true -- unknown, true
	)
end