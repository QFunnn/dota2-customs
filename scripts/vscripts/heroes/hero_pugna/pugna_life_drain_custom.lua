--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pugna_life_drain_custom", "heroes/hero_pugna/pugna_life_drain_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pugna_life_drain_custom_debuff", "heroes/hero_pugna/pugna_life_drain_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pugna_life_drain_custom_buff", "heroes/hero_pugna/pugna_life_drain_custom", LUA_MODIFIER_MOTION_NONE)

pugna_life_drain_custom = class({})

function pugna_life_drain_custom:CastFilterResultTarget(target)
	if target == self:GetCaster() then
		return UF_FAIL_CUSTOM
	end
	return UnitFilter(target, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, self:GetCaster():GetTeamNumber())
end

function pugna_life_drain_custom:GetCustomCastErrorTarget(target)
	if target == self:GetCaster() then
		return "dota_hud_error_cant_cast_on_self"
	end
end

function pugna_life_drain_custom:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function pugna_life_drain_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()
	local radius = self:GetSpecialValueFor("radius")

	self.targets = {}
	
	if target ~= nil then
		if not target:TriggerSpellAbsorb(self) then
			target:AddNewModifier(self:GetCaster(), self, "modifier_pugna_life_drain_custom", {duration = self:GetChannelTime()})
			table.insert(self.targets, target)
		end

		local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
		for _, enemy in pairs(enemies) do
			if enemy ~= target then
				table.insert(self.targets, enemy)
				enemy:AddNewModifier(self:GetCaster(), self, "modifier_pugna_life_drain_custom", {duration = self:GetChannelTime()})
			end
		end
	else
		local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
		for _, enemy in pairs(enemies) do
			table.insert(self.targets, enemy)
			enemy:AddNewModifier(self:GetCaster(), self, "modifier_pugna_life_drain_custom", {duration = self:GetChannelTime()})
		end
	end

	self:GetCaster():EmitSound("Hero_Pugna.LifeDrain.Cast")
end

function pugna_life_drain_custom:OnChannelFinish(bInterrupted)
	if not IsServer() then return end
	if self.targets then
		for _, hero in pairs(self.targets) do
			if hero then
				hero:RemoveModifierByName("modifier_pugna_life_drain_custom")
			end
		end
	end
	self.targets = nil
end

modifier_pugna_life_drain_custom = class({})

function modifier_pugna_life_drain_custom:GetPriority() return MODIFIER_PRIORITY_HIGH end
function modifier_pugna_life_drain_custom:IsHidden() return true end
function modifier_pugna_life_drain_custom:IsPurgable() return false end
function modifier_pugna_life_drain_custom:IsDebuff()
	if self.is_ally then
		return false
	else
		return true
	end
end

function modifier_pugna_life_drain_custom:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	self.health_drain = self.ability:GetSpecialValueFor("health_drain")
	self.tick_rate = self.ability:GetSpecialValueFor("tick_rate")
	self.break_distance_extend = 700

	if self.parent:GetTeamNumber() == self.caster:GetTeamNumber() then
		self.is_ally = true
	else
		self.is_ally = false
	end

	self.drain_amount = self.health_drain

	if IsServer() then
		EmitSoundOn("Hero_Pugna.LifeDrain.Target", self.parent)
		StopSoundOn("Hero_Pugna.LifeDrain.Loop", self.parent)
		EmitSoundOn("Hero_Pugna.LifeDrain.Loop", self.parent)

		if self.is_ally then
			self.particle_drain_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_pugna/pugna_life_give.vpcf", PATTACH_ABSORIGIN, self.caster)
			ParticleManager:SetParticleControlEnt(self.particle_drain_fx, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", self.caster:GetAbsOrigin(), true)
			ParticleManager:SetParticleControlEnt(self.particle_drain_fx, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
		else
			self.particle_drain_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_pugna/pugna_life_drain.vpcf", PATTACH_ABSORIGIN, self.caster)
			ParticleManager:SetParticleControlEnt(self.particle_drain_fx, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", self.caster:GetAbsOrigin(), true)
			ParticleManager:SetParticleControlEnt(self.particle_drain_fx, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
		end

		self.break_distance_extend = self.break_distance_extend + self:GetCaster():GetCastRangeBonus()

        local mod = self
		Timers:CreateTimer(self.tick_rate, function()
            if mod and not mod:IsNull() then
			    mod:StartIntervalThink(self.tick_rate)
            end
		end)
	else
		self:StartIntervalThink(self.tick_rate)
	end
end

function modifier_pugna_life_drain_custom:OnDestroy()
	if not IsServer() then return end
	print(self.particle_drain_fx)
	ParticleManager:DestroyParticle(self.particle_drain_fx, false)
	ParticleManager:ReleaseParticleIndex(self.particle_drain_fx)
	StopSoundOn("Hero_Pugna.LifeDrain.Target", self.parent)
	StopSoundOn("Hero_Pugna.LifeDrain.Loop", self.parent)
end

function modifier_pugna_life_drain_custom:OnIntervalThink()
	if IsServer() then
		if self.parent:IsIllusion() and self.parent:GetTeamNumber() ~= self.caster:GetTeamNumber() and not self.parent:IsStrongIllusion() then
			self.parent:Kill(self.ability, self.caster)
			return nil
		end

		if self.caster:IsStunned() or self.caster:IsSilenced() then
			self:Destroy()
		end

		if self.parent:GetTeamNumber() ~= self.caster:GetTeamNumber() and self.parent:IsInvisible() then
			self:Destroy()
		end

		if not self.caster:CanEntityBeSeenByMyTeam(self.parent) or self.parent:IsInvulnerable() or self.parent:IsMagicImmune() then
			self:Destroy()
		end

		local cast_range = self.ability:GetCastRange(self.caster:GetAbsOrigin(), self.parent)
		local distance = (self.parent:GetAbsOrigin() - self.caster:GetAbsOrigin()):Length2D()

		if distance > (cast_range + self.break_distance_extend) then
			self:Destroy()
		end

		if not self.caster:IsAlive() then
			self:Destroy()
		end


		local damage = self.drain_amount * self.tick_rate

		if self.is_ally then
			local damageTable = 
			{
				victim = self.caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				attacker = self.caster,
				ability = self.ability
			}
			local actual_damage = ApplyDamage(damageTable)
			local missing_health = self.parent:GetMaxHealth() - self.parent:GetHealth()
			self.parent:Heal(actual_damage, self.caster)

			if missing_health < actual_damage then
				local recover_mana = actual_damage - missing_health
				self.parent:GiveMana(recover_mana)
			end
		else

			if self:GetCaster():HasScepter() then
				local modifier_enemy = self:GetParent():FindModifierByName("modifier_pugna_life_drain_custom_debuff")
				local modifier_friendly = self:GetCaster():FindModifierByName("modifier_pugna_life_drain_custom_buff")
				if modifier_friendly then
					self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_pugna_life_drain_custom_buff", {duration = self:GetAbility():GetSpecialValueFor("spell_amp_drain_duration")})
					modifier_friendly:SetStackCount(math.min(modifier_friendly:GetStackCount() + 2, 100))
				else
					local modifier_friendly = self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_pugna_life_drain_custom_buff", {duration = self:GetAbility():GetSpecialValueFor("spell_amp_drain_duration")})
					modifier_friendly:SetStackCount(math.min(modifier_friendly:GetStackCount() + 2, 100))
				end
				if modifier_enemy then
					self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_pugna_life_drain_custom_debuff", {duration = self:GetAbility():GetSpecialValueFor("spell_amp_drain_duration")})
					modifier_enemy:SetStackCount(math.min(modifier_enemy:GetStackCount() + 2, 75))
				else
					local modifier_enemy = self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_pugna_life_drain_custom_debuff", {duration = self:GetAbility():GetSpecialValueFor("spell_amp_drain_duration")})
					if modifier_enemy then
						modifier_enemy:SetStackCount(math.min(modifier_enemy:GetStackCount() + 2, 75))
					end
				end
			end

			local damageTable = 
			{
				victim = self.parent,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				attacker = self.caster,
				ability = self.ability
			}

			local actual_damage = ApplyDamage(damageTable)
			local missing_health = self.caster:GetMaxHealth() - self.caster:GetHealth()

            if actual_damage <= 0 then
                actual_damage = damage
            end

			self.caster:Heal(actual_damage, self.ability)

			if missing_health < actual_damage then
				local recover_mana = actual_damage - missing_health
				self.caster:GiveMana(recover_mana)
			end
		end
	end
end

function modifier_pugna_life_drain_custom:CheckState()
	if self:GetCaster():GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
		return {
			[MODIFIER_STATE_PROVIDES_VISION]	= true,
			[MODIFIER_STATE_INVISIBLE]			= false
		}
	end
end

modifier_pugna_life_drain_custom_buff = class({})

function modifier_pugna_life_drain_custom_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
end

function modifier_pugna_life_drain_custom_buff:GetModifierSpellAmplify_Percentage()
	return self:GetStackCount()
end

modifier_pugna_life_drain_custom_debuff = class({})

function modifier_pugna_life_drain_custom_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
end

function modifier_pugna_life_drain_custom_debuff:GetModifierSpellAmplify_Percentage()
	return self:GetStackCount() * -1
end