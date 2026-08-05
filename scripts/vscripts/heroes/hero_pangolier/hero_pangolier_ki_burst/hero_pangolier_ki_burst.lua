--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_hero_pangolier_ki_burst",
	"heroes/hero_pangolier/hero_pangolier_ki_burst/hero_pangolier_ki_burst",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_generic_arc_lua", "heroes/generic/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_NONE)

hero_pangolier_ki_burst = class({})

function hero_pangolier_ki_burst:OnSpellStart()
	local caster = self:GetCaster()
	local damage = self:GetSpecialValueFor("damage")
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("jump_duration")

	caster:AddNewModifier(caster, self, "modifier_hero_pangolier_ki_burst", { duration = duration })
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_2)
end

----------------------------------------------------------------------------------------

modifier_hero_pangolier_ki_burst = class({})

function modifier_hero_pangolier_ki_burst:IsHidden()
	return false
end
function modifier_hero_pangolier_ki_burst:IsPurgable()
	return false
end

function modifier_hero_pangolier_ki_burst:OnCreated()
	self.smash_particle = "particles/units/heroes/hero_pangolier/pangolier_tailthump.vpcf"
	self.smash_sound = "Hero_Pangolier.TailThump"

	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")

	if IsServer() then
		self.distance = 1
		self.direction = self:GetCaster():GetForwardVector()
		self.stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")

		if self:GetParent():IsRooted() then
			return
		end
	end
end

function modifier_hero_pangolier_ki_burst:OnDestroy()
	if not IsServer() then
		return
	end

	local smash = ParticleManager:CreateParticle(self.smash_particle, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(smash, 0, self:GetCaster():GetAbsOrigin())

	-- EmitSoundOnLocationWithCaster(self:GetCaster():GetAbsOrigin(), self.smash_sound, self:GetCaster())
	EmitSoundOn(self.smash_sound, self:GetCaster())

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetCaster():GetAbsOrigin(),
		self:GetCaster(),
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	damage_table = {
		attacker = self:GetCaster(),
		ability = self:GetAbility(),
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
	}

	for _, enemy in pairs(enemies) do
		if not enemy:IsMagicImmune() then
			enemy:AddNewModifier(
				self:GetCaster(),
				self:GetAbility(),
				"modifier_stunned",
				{ duration = self.stun_duration }
			)
			damage_table.victim = enemy
			ApplyDamage(damage_table)
		end
	end
	ParticleManager:ReleaseParticleIndex(smash)
end

function modifier_hero_pangolier_ki_burst:CheckState()
	return {
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}
end