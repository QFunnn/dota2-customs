--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_alchemist_unstable_concoction_lua_disarm",
	"heroes/hero_alchemist/alchemist_unstable_concoction_throw_lua/alchemist_unstable_concoction_throw_lua",
	LUA_MODIFIER_MOTION_NONE
)

--------------------------------------------------------------------------------

alchemist_unstable_concoction_throw_lua = class({})

function alchemist_unstable_concoction_throw_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function alchemist_unstable_concoction_throw_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local projectile_name = "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_projectile.vpcf"
	local projectile_speed = self:GetSpecialValueFor("speed")

	local function launch()
		ProjectileManager:CreateTrackingProjectile({
			Target = target,
			Source = caster,
			Ability = self,
			EffectName = projectile_name,
			iMoveSpeed = projectile_speed,
			bDodgeable = false,
			ExtraData = {},
		})
		EmitSoundOn("Hero_Alchemist.UnstableConcoction.Throw", caster)
	end

	launch()

	local talent = caster:FindAbilityByName("special_bonus_alchemist_agi6")
	if talent and talent:GetLevel() > 0 then
		Timers:CreateTimer(1, function()
			launch()
		end)
	end
end

function alchemist_unstable_concoction_throw_lua:OnProjectileHit_ExtraData(target, location, ExtraData)
	if not target then
		return
	end

	local min_stun = self:GetSpecialValueFor("min_stun")
	local max_stun = self:GetSpecialValueFor("max_stun")
	local min_damage = self:GetSpecialValueFor("min_damage")
	local max_damage = self:GetSpecialValueFor("max_damage")
	local radius = self:GetSpecialValueFor("radius")

	local stun = RandomFloat(min_stun, max_stun)
	local damage = RandomFloat(min_damage, max_damage)
	local damageTable = {
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		ability = self, --Optional.
	}

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(), -- int, your team number
		target:GetOrigin(), -- point, center point
		nil, -- handle, cacheUnit. (not known)
		radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
		DOTA_UNIT_TARGET_ALL, -- int, type filter
		DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO, -- int, flag filter
		0, -- int, order filter
		false -- bool, can grow cache
	)

	for _, enemy in pairs(enemies) do
		-- damage
		damageTable.victim = enemy
		ApplyDamage(damageTable)

		enemy:AddNewModifier(self:GetCaster(), self, "modifier_stunned", { duration = stun })
		enemy:AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_alchemist_unstable_concoction_lua_disarm",
			{ duration = stun }
		)
	end

	-- Play effects
	self:PlayEffects(target)
end

function alchemist_unstable_concoction_throw_lua:PlayEffects(target)
	local particle_cast = "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_explosion.vpcf"
	local sound_cast = "Hero_Alchemist.UnstableConcoction.Stun"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn(sound_cast, target)
end

--------------------------------------------------------
--------------------------------------------------------

if modifier_alchemist_unstable_concoction_lua_disarm == nil then
	modifier_alchemist_unstable_concoction_lua_disarm = class({})
end
function modifier_alchemist_unstable_concoction_lua_disarm:IsHidden()
	return false
end
function modifier_alchemist_unstable_concoction_lua_disarm:IsDebuff()
	return true
end
function modifier_alchemist_unstable_concoction_lua_disarm:IsPurgable()
	return true
end

function modifier_alchemist_unstable_concoction_lua_disarm:OnCreated()
	self.armor_reduction = -1 * self:GetAbility():GetSpecialValueFor("disarm")
end

function modifier_alchemist_unstable_concoction_lua_disarm:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
	return funcs
end

function modifier_alchemist_unstable_concoction_lua_disarm:GetModifierPhysicalArmorBonus()
	return self.armor_reduction
end