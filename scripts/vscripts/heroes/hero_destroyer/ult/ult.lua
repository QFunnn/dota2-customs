--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_hero_destroyer_ult", "heroes/hero_destroyer/ult/ult", LUA_MODIFIER_MOTION_NONE)

hero_destroyer_ult = class({})

function hero_destroyer_ult:OnSpellStart()
	local damage = self:GetSpecialValueFor("damage")
	local str_mult = self:GetSpecialValueFor("str_mult")

	if self:GetCaster():FindAbilityByName("special_bonus_destroyer_tal4") ~= nil then
		if self:GetCaster():FindAbilityByName("special_bonus_destroyer_tal4"):GetLevel() > 0 then
			str_mult = 100
		end
	end

	local try_damage = damage + self:GetCaster():GetStrength() / 100 * str_mult

	local projectile_name = "particles/units/heroes/hero_earthshaker/earthshaker_echoslam.vpcf"
	local projectile_speed = 600

	local info = {
		Ability = self,
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = true,
		bReplaceExisting = false,
	}
	ProjectileManager:CreateTrackingProjectile(info)

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetCaster():GetOrigin(),
		nil,
		self:GetSpecialValueFor("radius"),
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		local damageTable = {
			victim = enemy,
			attacker = self:GetCaster(),
			damage = try_damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
			ability = self, --Optional.
		}
		ApplyDamage(damageTable)
		enemy:AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_stunned",
			{ duration = self:GetSpecialValueFor("duration") }
		)
		-- enemy:AddNewModifier(self:GetCaster(), self, "modifier_hero_destroyer_ult", {duration = self:GetSpecialValueFor("duration")})
	end
	self:PlayEffects()
end

function hero_destroyer_ult:PlayEffects()
	-- StartAnimation(self:GetCaster(), {duration = 0.5, activity = ACT_DOTA_CAST_ABILITY_3})--ACT_DOTA_MOMENT_OF_COURAGE

	local particle_cast = "particles/destr2.vpcf"
	local sound_cast = "Hero_EarthShaker.EchoSlam"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self:GetSpecialValueFor("radius"), 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn(sound_cast, self:GetCaster())
end

-----------------------------------------------------------

modifier_hero_destroyer_ult = class({})

function modifier_hero_destroyer_ult:IsHidden()
	return false
end
function modifier_hero_destroyer_ult:IsDebuff()
	return true
end
function modifier_hero_destroyer_ult:IsPurgable()
	return true
end

function modifier_hero_destroyer_ult:OnCreated(kv)
	if not IsServer() then
		return
	end
	local enemies = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(),
		self:GetParent():GetOrigin(),
		self:GetParent(),
		1000,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	if #enemies > 1 then
		self.target = enemies[2]
		self:GetParent():SetForceAttackTargetAlly(self.target)
		self:GetParent():MoveToTargetToAttack(self.target)
	end
	self:StartIntervalThink(0.1)
end

function modifier_hero_destroyer_ult:OnIntervalThink()
	if self.target ~= nil and self.target:IsAlive() then
		return
	else
		local enemies = FindUnitsInRadius(
			self:GetParent():GetTeamNumber(),
			self:GetParent():GetOrigin(),
			self:GetParent(),
			1000,
			DOTA_UNIT_TARGET_TEAM_BOTH,
			DOTA_UNIT_TARGET_ALL,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_CLOSEST,
			false
		)
		if #enemies > 1 then
			self.target = enemies[2]
			self:GetParent():SetForceAttackTargetAlly(self.target)
			self:GetParent():MoveToTargetToAttack(self.target)
		end
	end
end

function modifier_hero_destroyer_ult:OnDestroy()
	self:GetParent():SetForceAttackTargetAlly(nil)
end

function modifier_hero_destroyer_ult:CheckState()
	return {
		[MODIFIER_STATE_SPECIALLY_DENIABLE] = true,
		[MODIFIER_STATE_ATTACK_ALLIES] = true,
	}
end