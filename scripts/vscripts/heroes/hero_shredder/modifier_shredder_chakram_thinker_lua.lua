--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_shredder_chakram_thinker_lua = class({}) ---@class CDOTA_Modifier_Lua

_STATE_LAUNCHING = "LaunchThink"
_STATE_STAYING = "StayThink"
_STATE_RETURNING = "ReturnThink"

function modifier_shredder_chakram_thinker_lua:OnCreated(kv)
	if not IsServer() then return end
	self.state = _STATE_LAUNCHING

	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	-- references
	self.damage_pass = self.ability:GetSpecialValueFor("pass_damage")
	self.damage_stay = self.ability:GetSpecialValueFor("damage_per_second")
	self.radius = self.ability:GetSpecialValueFor("radius")
	self.speed = self.ability:GetSpecialValueFor("speed")
	self.duration = self.ability:GetSpecialValueFor("pass_slow_duration")
	self.manacost = self.ability:GetSpecialValueFor("mana_per_second")
	self.max_range = self.ability:GetSpecialValueFor("break_distance")
	self.interval = self.ability:GetSpecialValueFor("damage_interval")

	self.proximity = 50
	self.caught_enemies = {}
	self.damage_table = {
		damage = self.damage_pass,
		attacker = self.caster,
		damage_type = self.ability:GetAbilityDamageType(),
		ability = self.ability,
	}
	self.point = Vector(kv.target_x, kv.target_y, kv.target_z)

	self.parent:SetDayTimeVisionRange(500)
	self.parent:SetNightTimeVisionRange(500)

	self.move_interval = FrameTime()
	self.scepter = kv.scepter

	local direction = self.point - self.parent:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

	self.disarm_modifier = self.caster:AddNewModifier(self.caster, self.ability, "modifier_shredder_chakram_disarm_lua", {})

	-- self.chakram_particle_main = ParticleManager:GetParticleReplacement("particles/units/heroes/hero_shredder/shredder_chakram.vpcf", self.caster)
	self.chakram_particle_main = ParticleManager:GetParticleReplacement("particles/units/heroes/hero_shredder/shredder_chakram.vpcf", self.caster)
	self.chakram_particle_stay = ParticleManager:GetParticleReplacement("particles/units/heroes/hero_shredder/shredder_chakram_stay.vpcf", self.caster)
	self.chakram_particle_return = ParticleManager:GetParticleReplacement("particles/units/heroes/hero_shredder/shredder_chakram_return.vpcf", self.caster)

	-- print(self.chakram_particle_main, self.chakram_particle_stay, self.chakram_particle_return)

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle(self.chakram_particle_main, PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControl(self.effect_cast, 0, self:GetParent():GetOrigin())
	ParticleManager:SetParticleControl(self.effect_cast, 1, direction * self.speed)
	ParticleManager:SetParticleControl(self.effect_cast, 16, Vector(0, 0, 0))

	if self.scepter then
		ParticleManager:SetParticleControl(self.effect_cast, 15, Vector(0, 0, 255))
		ParticleManager:SetParticleControl(self.effect_cast, 16, Vector(1, 0, 0))
	end

	self.return_ability_name = self.ability.return_ability_name
	self.parent:EmitSound("Hero_Shredder.Chakram")
	self:StartIntervalThink(self.move_interval)
end


function modifier_shredder_chakram_thinker_lua:OnIntervalThink()
	if not self.ability or self.ability:IsNull() then
		self:Destroy()
		return
	end

	self[self.state](self)
end


function modifier_shredder_chakram_thinker_lua:OnDestroy()
	if not self.caster or self.caster:IsNull() then return end

	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)

	self.parent:StopSound("Hero_Shredder.Chakram")
	if self.disarm_modifier and not self.disarm_modifier:IsNull() then self.disarm_modifier:Destroy() end
	local hParent = self:GetParent()
	UTIL_Remove(hParent)
	local returnAbility = self.caster:FindAbilityByName(self.ability.return_ability_name)
	if self.ability and returnAbility and not returnAbility:IsNull() and not self.ability:IsNull() then
		if self:GetAbility():IsHidden() then
			self.caster:SwapAbilities(
			self.ability,
			returnAbility,
			true,
			false
			)
		end

	end
end


function modifier_shredder_chakram_thinker_lua:LaunchThink()
	local close = self:Move(self.point)
	if not close then return end

	self.state = _STATE_STAYING
	self.damage_table.damage = self.damage_stay * self.interval
	self:StartIntervalThink(self.interval)

	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)

	self.effect_cast = ParticleManager:CreateParticle(self.chakram_particle_stay, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.effect_cast, 0, self.parent:GetOrigin())
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.radius, 0, 0))
	ParticleManager:SetParticleControl(self.effect_cast, 16, Vector(0, 0, 0))

	if self.scepter then
		ParticleManager:SetParticleControl(self.effect_cast, 15, Vector(0, 0, 255))
		ParticleManager:SetParticleControl(self.effect_cast, 16, Vector(1, 0, 0))
	end
end


function modifier_shredder_chakram_thinker_lua:StayThink()
	local origin = self.parent:GetOrigin()
	local mana = self.caster:GetMana()

	if (self.caster:GetOrigin() - origin):Length2D() > self.max_range
	or mana < self.manacost * self.interval or (not self.caster:IsAlive()) then
		self:Return()
		return
	end

	self.caster:SpendMana(self.manacost * self.interval, self.ability)

	self:Damage(self.parent:GetAbsOrigin(), true)
end


function modifier_shredder_chakram_thinker_lua:ReturnThink()
	local close = self:Move(self.caster:GetAbsOrigin())
	if not close then return end

	self:Destroy()
end


function modifier_shredder_chakram_thinker_lua:Return()
	if self.state == _STATE_RETURNING then return end
	self.state = _STATE_RETURNING
	self:StartIntervalThink(self.move_interval)
	self.caught_enemies = {}
	self.damage_table.damage = self.damage_pass

	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)

	self.effect_cast = ParticleManager:CreateParticle(self.chakram_particle_return, PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControl(self.effect_cast, 0, self:GetParent():GetOrigin())
	ParticleManager:SetParticleControlEnt(self.effect_cast, 6, self.caster, PATTACH_ABSORIGIN_FOLLOW, nil, self.caster:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(self.effect_cast, 2, Vector(self.speed, 0, 0))
	ParticleManager:SetParticleControl(self.effect_cast, 16, Vector(0, 0, 0))

	if self.scepter then
		ParticleManager:SetParticleControl(self.effect_cast, 15, Vector(0, 0, 255))
		ParticleManager:SetParticleControl(self.effect_cast, 16, Vector(1, 0, 0))
	end

	self.parent:EmitSound("Hero_Shredder.Chakram.Return")
end


function modifier_shredder_chakram_thinker_lua:Move(target_point)

	if (not self.parent) or (self.parent:IsNull()) then
		return true
	end

	local current_location = self.parent:GetAbsOrigin()
	local direction = (target_point - current_location):Normalized()
	local target = current_location + direction * self.speed * self.move_interval

	self.parent:SetOrigin(target)

	self:Damage(target)

	return (target - target_point):Length2D() < self.proximity
end


function modifier_shredder_chakram_thinker_lua:Damage(target_point, is_staying)
	local enemies = FindUnitsInRadius(
	self.caster:GetTeamNumber(),
	target_point,
	nil,
	self.radius,
	DOTA_UNIT_TARGET_TEAM_ENEMY,
	DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	0,
	0,
	false
	)

	local function _damage(enemy)
		self.damage_table.victim = enemy
		if self.state ~= _STATE_STAYING then
			ApplyDamage({
				attacker = self:GetCaster(),
				victim = enemy,
				ability = self:GetAbility(),
				damage = self:GetAbility():GetSpecialValueFor("pass_damage"),
				damage_type = DAMAGE_TYPE_PURE,
				damage_flags = DOTA_DAMAGE_FLAG_NO_DOT
			})
		else
			ApplyDamage({
				attacker = self:GetCaster(),
				victim = enemy,
				ability = self:GetAbility(),
				damage = self:GetAbility():GetSpecialValueFor("damage_per_second"),
				damage_type = DAMAGE_TYPE_PURE,
				damage_flags = DOTA_DAMAGE_FLAG_NONE
			})
		end


		enemy:AddNewModifier(self.caster, self.ability, "modifier_shredder_chakram_slow_lua", { duration = self.duration })

		enemy:EmitSound("Hero_Shredder.Chakram.Target")
	end

	for _, enemy in pairs(enemies) do
		if is_staying then
			_damage(enemy)
		elseif not self.caught_enemies[enemy] then
			_damage(enemy)
			self.caught_enemies[enemy] = true
		end
	end

	GridNav:DestroyTreesAroundPoint(target_point, self.radius, false)
end