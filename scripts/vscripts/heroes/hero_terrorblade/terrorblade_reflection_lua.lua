--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


terrorblade_reflection_lua = class({}) ---@class terrorblade_reflection_lua : CDOTA_Ability_Lua
LinkLuaModifier("modifier_terrorblade_reflection_creep_damage_lua", "heroes/hero_terrorblade/terrorblade_reflection_lua",
	LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_terrorblade_reflection_lua_slow", "heroes/hero_terrorblade/terrorblade_reflection_lua",
	LUA_MODIFIER_MOTION_NONE)

function terrorblade_reflection_lua:GetAOERadius()
	return self:GetSpecialValueFor("range")
end

function terrorblade_reflection_lua:OnSpellStart()
	local caster = self:GetCaster()
	local ability_level = self:GetLevel() - 1
	local target_loc = self:GetCursorPosition()
	local illusion_duration = self:GetSpecialValueFor("illusion_duration")
	local range = self:GetSpecialValueFor("range")
	local illusion_outgoing_damage = self:GetLevelSpecialValueFor("illusion_outgoing_damage", ability_level)
	local max_creep_affect = self:GetSpecialValueFor("max_creep_affect")
	self.creep_affect_counter = 0

	local enemies = FindUnitsInRadius(
		caster:GetTeam(),
		target_loc,
		nil,
		range,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_ANY_ORDER,
		false
	)
	for i, enemy in pairs(enemies) do
		if IsValid(enemy) and enemy:IsAlive() then
			local reflection
			local modifier_apply_flag = false
			if enemy:IsRealHero() then
				local reflection_loc = enemy:GetAbsOrigin() + RandomVector(200)
				local illusions = CreateIllusions(caster, enemy, {}, 1, enemy:GetHullRadius(), false, true)
				reflection = illusions[1]
				reflection:RemoveModifierByName("modifier_hero_refreshing")
				if enemy:GetUnitName() == "npc_dota_hero_muerta" then
					reflection:RemoveModifierByName("modifier_muerta_gunslinger")
					reflection:RemoveModifierByName("modifier_muerta_pierce_the_veil")
				end
				reflection:AddNewModifier(enemy, self, "modifier_illusion",
					{ duration = illusion_duration, outgoing_damage = illusion_outgoing_damage, incoming_damage = 0 })
				reflection:AddNewModifier(caster, self, "modifier_terrorblade_reflection_invulnerability",
					{ duration = illusion_duration })
				FindClearSpaceForUnit(reflection, reflection_loc, true)
				reflection:SetForceAttackTarget(enemy)
				modifier_apply_flag = true
			else
				if self.creep_affect_counter < max_creep_affect then
					enemy:AddNewModifier(caster, self, "modifier_terrorblade_reflection_creep_damage_lua",
						{ duration = illusion_duration })
					modifier_apply_flag = true
					self.creep_affect_counter = self.creep_affect_counter + 1
				end
			end

			if modifier_apply_flag then
				if IsValid(reflection) then
					enemy:AddNewModifier(caster, self, "modifier_terrorblade_reflection_lua_slow",
						{ duration = illusion_duration, illusion_index = reflection:entindex() })
				else
					enemy:AddNewModifier(caster, self, "modifier_terrorblade_reflection_lua_slow",
						{ duration = illusion_duration })
				end

				local particle_cast = "particles/units/heroes/hero_terrorblade/terrorblade_reflection_cast.vpcf"
				local particle_fx = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT_FOLLOW, caster)
				ParticleManager:SetParticleControl(particle_fx, 3, Vector(1, 0, 0))
				ParticleManager:SetParticleControlEnt(particle_fx, 1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc",
					enemy:GetAbsOrigin(), true)
				ParticleManager:SetParticleControlEnt(particle_fx, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc",
					enemy:GetAbsOrigin(), true)
				ParticleManager:ReleaseParticleIndex(particle_fx)
			end
		end
	end

	EmitSoundOn("Hero_Terrorblade.Reflection", caster)
end

-----------------------------------------------------------------------------
modifier_terrorblade_reflection_creep_damage_lua = class({}) ---@class CDOTA_Modifier_Lua
function modifier_terrorblade_reflection_creep_damage_lua:IsHidden()
	return true
end

function modifier_terrorblade_reflection_creep_damage_lua:IsDebuff()
	return true
end

function modifier_terrorblade_reflection_creep_damage_lua:IsPurgable()
	return true
end

function modifier_terrorblade_reflection_creep_damage_lua:IsPurgeException()
	return true
end

function modifier_terrorblade_reflection_creep_damage_lua:OnCreated(keys)
	self.illusion_outgoing_tooltip = self:GetAbilitySpecialValueFor("illusion_outgoing_tooltip")
	local hParent = self:GetParent()
	local bat = hParent:GetBaseAttackTime(false)
	bat = math.max(bat, 0.32)
	if IsServer() then
		self:StartIntervalThink(bat)
	end
end

function modifier_terrorblade_reflection_creep_damage_lua:OnRefresh(keys)
	self.illusion_outgoing_tooltip = self:GetAbilitySpecialValueFor("illusion_outgoing_tooltip")
end

function modifier_terrorblade_reflection_creep_damage_lua:OnIntervalThink()
	local hCaster = self:GetCaster()
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()

	if IsValid(hCaster) and IsValid(hParent) and IsValid(hAbility) then
		local fAverageDamage = (hParent:GetBaseDamageMax() + hParent:GetBaseDamageMin()) * 0.5
		ApplyDamage({
			attacker = hCaster,
			victim = hParent,
			ability = hAbility,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			damage = fAverageDamage * self.illusion_outgoing_tooltip * 0.01,
			damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		})
	end
end

function modifier_terrorblade_reflection_creep_damage_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

---------------------------------------------------------------------
--Modifiers
if modifier_terrorblade_reflection_lua_slow == nil then
	modifier_terrorblade_reflection_lua_slow = class({})
end
function modifier_terrorblade_reflection_lua_slow:IsHidden()
	return false
end

function modifier_terrorblade_reflection_lua_slow:IsDebuff()
	return true
end

function modifier_terrorblade_reflection_lua_slow:IsPurgable()
	return true
end

function modifier_terrorblade_reflection_lua_slow:IsPurgeException()
	return true
end

function modifier_terrorblade_reflection_lua_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_terrorblade_reflection_lua_slow:OnCreated(keys)
	self.move_slow = self:GetAbilitySpecialValueFor("move_slow")
	self.attack_slow = self:GetAbilitySpecialValueFor("attack_slow")
	if IsServer() then
		self.illusions = {}
		if keys.illusion_index ~= nil and type(keys.illusion_index) == "number" then
			table.insert(self.illusions, EntIndexToHScript(keys.illusion_index))
		end
	end
end

function modifier_terrorblade_reflection_lua_slow:OnRefresh(keys)
	self.move_slow = self:GetAbilitySpecialValueFor("move_slow")
	self.attack_slow = self:GetAbilitySpecialValueFor("attack_slow")
	if IsServer() then
		if keys.illusion_index ~= nil and type(keys.illusion_index) == "number" then
			table.insert(self.illusions, EntIndexToHScript(keys.illusion_index))
		end
	end
end

function modifier_terrorblade_reflection_lua_slow:OnDestroy()
	if IsServer() then
		for _, illusion in pairs(self.illusions) do
			if IsValid(illusion) and illusion.IsAlive ~= nil then
				if illusion:IsAlive() then
					illusion:ForceKill(false)
				end
			end
		end
	end
end

function modifier_terrorblade_reflection_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return -self.move_slow
end

function modifier_terrorblade_reflection_lua_slow:GetModifierAttackSpeedBonus_Constant()
	return -self.attack_slow
end

function modifier_terrorblade_reflection_lua_slow:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_terrorblade_reflection_lua_slow:GetEffectName()
	return "particles/units/heroes/hero_terrorblade/terrorblade_reflection_slow.vpcf"
end