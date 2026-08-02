--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_kakuzu_earth_grudge_fear", "heroes/akatsuki/kakuzu", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kakuzu_heart_explosion", "heroes/akatsuki/kakuzu", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kakuzu_kill_counter", "heroes/akatsuki/kakuzu", LUA_MODIFIER_MOTION_NONE)

kakuzu_earth_grudge_fear = class({})

function kakuzu_earth_grudge_fear:GetIntrinsicModifierName()
	return "modifier_kakuzu_earth_grudge_fear"
end

---------------------------------------------------------------------------

modifier_kakuzu_earth_grudge_fear = class({})

function modifier_kakuzu_earth_grudge_fear:IsHidden()
	return false
end

function modifier_kakuzu_earth_grudge_fear:IsPurgable()
	return false
end

function modifier_kakuzu_earth_grudge_fear:IsPermanent()
	return true
end

function modifier_kakuzu_earth_grudge_fear:OnCreated()
	if not IsServer() then
		return
	end
	self.kill_counter = 0
	self.kills_per_heart = self:GetAbility():GetSpecialValueFor("kills_per_heart")
	self.max_hearts = self:GetAbility():GetSpecialValueFor("max_hearts")
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_kakuzu_kill_counter", {})
	self:StartIntervalThink(1.0)
end

function modifier_kakuzu_earth_grudge_fear:OnRefresh()
	self.kills_per_heart = self:GetAbility():GetSpecialValueFor("kills_per_heart")
	self.max_hearts = self:GetAbility():GetSpecialValueFor("max_hearts")
end

function modifier_kakuzu_earth_grudge_fear:OnIntervalThink()
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	local new_level = math.min(math.floor((self:GetParent():GetLevel() - 1) / 6) + 1, ability:GetMaxLevel())
	if ability:GetLevel() ~= new_level then
		ability:SetLevel(new_level)
	end
end

function modifier_kakuzu_earth_grudge_fear:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_kakuzu_earth_grudge_fear:OnDeath(params)
	if not IsServer() then
		return
	end
	local hero = self:GetParent()
	if not IsMyKilledBadGuys2(hero, params) then
		return
	end

	self.kill_counter = self.kill_counter + 1
	if self.kill_counter >= self.kills_per_heart then
		self.kill_counter = 0
		local hearts = self:GetStackCount()
		if hearts < self.max_hearts then
			self:SetStackCount(hearts + 1)
		end
	end

	local counter_mod = self:GetParent():FindModifierByName("modifier_kakuzu_kill_counter")
	if counter_mod then
		counter_mod:SetStackCount(self.kill_counter)
	end
end

function modifier_kakuzu_earth_grudge_fear:OnTakeDamage(data)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	if data.unit ~= caster then
		return
	end
	if self:GetStackCount() <= 0 then
		return
	end
	-- Срабатывает только если удар был смертельным
	if caster:GetHealth() > 0 then
		return
	end

	self:SetStackCount(self:GetStackCount() - 1)
	caster:SetHealth(1)
	self:ExplodeHeart()

	local heal_pct = self:GetAbility():GetSpecialValueFor("heal_pct_base") / 100
	caster:Heal(caster:GetMaxHealth() * heal_pct, caster)
end

function modifier_kakuzu_earth_grudge_fear:GetModifierMagicalResistanceBonus()
	local resist_per_heart = self:GetAbility():GetSpecialValueFor("magic_resist_per_heart")
	return self:GetStackCount() * resist_per_heart
end

function modifier_kakuzu_earth_grudge_fear:GetModifierPhysicalArmorBonus()
	local armor_per_heart = self:GetAbility():GetSpecialValueFor("armor_per_heart")
	return self:GetStackCount() * armor_per_heart
end

function modifier_kakuzu_earth_grudge_fear:ExplodeHeart()
	local caster = self:GetParent()
	local radius = self:GetAbility():GetSpecialValueFor("explosion_radius")
	local damage = caster:GetAverageTrueAttackDamage(caster)
	local stun_dur = self:GetAbility():GetSpecialValueFor("explosion_stun_duration")
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf",
		PATTACH_CUSTOMORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(pfx)

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		ApplyDamage({
			victim = enemy,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility(),
		})
		enemy:AddNewModifier(caster, self:GetAbility(), "modifier_kakuzu_heart_explosion", { duration = stun_dur })
	end
	caster:EmitSound("Hero_Abaddon.AphoticShield.Destroy")
end

---------------------------------------------------------------------------

modifier_kakuzu_heart_explosion = class({})

function modifier_kakuzu_heart_explosion:IsHidden()
	return false
end

function modifier_kakuzu_heart_explosion:IsPurgable()
	return false
end

function modifier_kakuzu_heart_explosion:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_STATE_STUNNED,
	}
end

function modifier_kakuzu_heart_explosion:GetModifierMoveSpeedBonus_Percentage()
	return -100
end

function modifier_kakuzu_heart_explosion:GetModifierStateStunned()
	return 1
end

---------------------------------------------------------------------------

modifier_kakuzu_kill_counter = class({})

function modifier_kakuzu_kill_counter:IsHidden()
	return false
end
function modifier_kakuzu_kill_counter:IsPurgable()
	return false
end
function modifier_kakuzu_kill_counter:IsPermanent()
	return true
end
function modifier_kakuzu_kill_counter:RemoveOnDeath()
	return false
end

---------------------------------------------------------------------------

function IsMyKilledBadGuys2(hero, params)
	if params.unit:GetTeamNumber() ~= DOTA_TEAM_NEUTRALS then
		return false
	end
	local attacker = params.attacker
	if hero ~= attacker or attacker:HasModifier("modifier_guild_event") then
		return false
	end
	if not _G.excludedUnitsLookup or not _G.excludedUnitsLookup[params.unit:GetUnitName()] then
		return false
	end
	return true
end