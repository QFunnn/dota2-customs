--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_hero_pangolier_broken_wings",
	"heroes/hero_pangolier/hero_pangolier_broken_wings/hero_pangolier_broken_wings",
	LUA_MODIFIER_MOTION_NONE
)

hero_pangolier_broken_wings = class({})

function hero_pangolier_broken_wings:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail.vpcf", context)
end

function hero_pangolier_broken_wings:CastFilterResult()
	if IsServer() then
		if self:IsInAbilityPhase() then
		else
			self.aggro = self:GetCaster():GetAggroTarget()
		end
	end

	return UF_SUCCESS
end

function hero_pangolier_broken_wings:OnAbilityPhaseStart()
	if IsServer() then
		if self.aggro then
			self:GetCaster():FaceTowards(self.aggro:GetOrigin())
		end
	end

	return true
end

function hero_pangolier_broken_wings:OnSpellStart()
	local caster = self:GetCaster()
	local range = self:GetSpecialValueFor("range")
	local width = self:GetSpecialValueFor("width")
	local damage = self:GetSpecialValueFor("bonus_damage")
	local recast_timer = self:GetSpecialValueFor("recast_timer")
	local recast_number = self:GetSpecialValueFor("recast_number")

	caster:EmitSound("Hero_Juggernaut.OmniSlash")

	local ability = self:GetCaster():FindAbilityByName("pango_4")
	if ability ~= nil and ability:GetLevel() > 0 then
		recast_number = recast_number + 1
	end

	local origin = caster:GetOrigin()
	local direction = caster:GetForwardVector()

	if self.aggro then
		direction = self.aggro:GetOrigin() - origin
		direction.z = 0
		direction = direction:Normalized()
	end

	local obs = Entities:FindAllByClassname("point_simple_obstruction")
	local obstraction = false

	for i = 0, range, 5 do
		point = caster:GetOrigin() + direction * i

		for i = 1, #obs do
			local dist = (point - obs[i]:GetAbsOrigin()):Length2D()
			if dist < 80 then
				obstraction = true
			end
		end

		local isTraversable = GridNav:IsTraversable(point)
		if isTraversable == false or obstraction == true then
			break
		end
	end

	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		origin,
		point,
		nil,
		width,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0
	)

	local damageTable = {
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}

	for _, enemy in pairs(enemies) do
		caster:PerformAttack(enemy, true, true, true, true, false, false, true)
		damageTable.victim = enemy
		caster:SetAggroTarget(enemy)
		ApplyDamage(damageTable)
	end

	FindClearSpaceForUnit(caster, point, true)

	if self.aggro then
		caster:SetForwardVector(-direction)
		caster:SetAggroTarget(self.aggro)
		caster:MoveToTargetToAttack(self.aggro)
	end

	local modifier = caster:AddNewModifier(caster, self, "modifier_hero_pangolier_broken_wings", {
		duration = recast_timer,
		number = recast_number - 1,
	})
	if modifier:GetStackCount() > 0 then
		self:EndCooldown()
	else
		modifier:Destroy()
	end
	self:PlayEffects(origin)
end

function hero_pangolier_broken_wings:PlayEffects(origin)
	local particle_cast = "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 0, origin)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetCaster(),
		PATTACH_ABSORIGIN,
		"attach_hitloc",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

-------------------------------------------------------------------------
-------------------------------------------------------------------------

modifier_hero_pangolier_broken_wings = class({})

function modifier_hero_pangolier_broken_wings:IsHidden()
	return false
end

function modifier_hero_pangolier_broken_wings:IsDebuff()
	return false
end

function modifier_hero_pangolier_broken_wings:IsPurgable()
	return false
end

function modifier_hero_pangolier_broken_wings:OnCreated(kv)
	if IsServer() then
		self:SetStackCount(kv.number)
	end
end

function modifier_hero_pangolier_broken_wings:OnRefresh(kv)
	if IsServer() then
		self:DecrementStackCount()
	end
end

function modifier_hero_pangolier_broken_wings:OnDestroy()
	if IsServer() then
		self:GetAbility():UseResources(false, false, false, true)
	end
end