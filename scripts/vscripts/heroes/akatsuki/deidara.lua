--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_deidara_unstable_art", "heroes/akatsuki/deidara", LUA_MODIFIER_MOTION_NONE)

deidara_unstable_art = class({})

function deidara_unstable_art:GetIntrinsicModifierName()
	return "modifier_deidara_unstable_art"
end

---------------------------------------------------------------------------

modifier_deidara_unstable_art = class({})

function modifier_deidara_unstable_art:IsHidden()
	return true
end
function modifier_deidara_unstable_art:IsPurgable()
	return false
end
function modifier_deidara_unstable_art:IsPermanent()
	return true
end

function modifier_deidara_unstable_art:OnCreated()
	if not IsServer() then
		return
	end
	self:_RefreshValues()
	self:StartIntervalThink(1.0)
end

function modifier_deidara_unstable_art:OnRefresh()
	if not IsServer() then
		return
	end
	self:_RefreshValues()
end

function modifier_deidara_unstable_art:OnIntervalThink()
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	local new_level = math.min(math.floor((self:GetParent():GetLevel() - 1) / 6) + 1, ability:GetMaxLevel())
	if ability:GetLevel() ~= new_level then
		ability:SetLevel(new_level)
		self:_RefreshValues()
	end
end

function modifier_deidara_unstable_art:_RefreshValues()
	local ab = self:GetAbility()
	self._splash_radius = ab:GetSpecialValueFor("splash_radius")
	self._explode_radius = ab:GetSpecialValueFor("explode_radius")
	self._base_splash = ab:GetSpecialValueFor("base_splash_pct") / 100
	self._explode_pct = ab:GetSpecialValueFor("explode_hp_pct") / 100
end

function modifier_deidara_unstable_art:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_deidara_unstable_art:OnAttackLanded(data)
	if not IsServer() then
		return
	end
	if data.attacker ~= self:GetParent() then
		return
	end
	if not data.target or data.target:IsNull() then
		return
	end

	local caster = self:GetParent()
	local splash_pct = self._base_splash
	local splash_dmg = caster:GetAverageTrueAttackDamage(caster) * splash_pct
	local ab = self:GetAbility()

	local nearby = FindUnitsInRadius(
		caster:GetTeamNumber(),
		data.target:GetAbsOrigin(),
		nil,
		self._splash_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(nearby) do
		if enemy ~= data.target then
			ApplyDamage({
				victim = enemy,
				attacker = caster,
				damage = splash_dmg,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = ab,
			})
		end
	end

	EmitSoundOn("Hero_Jakiro.LiquidFire", data.attacker)
end

function modifier_deidara_unstable_art:OnDeath(params)
	if not IsServer() then
		return
	end
	if not IsMyKilledBadGuys2(self:GetParent(), params) then
		return
	end

	local caster = self:GetParent()
	local target = params.unit
	local origin = target:GetAbsOrigin()
	local dmg = target:GetMaxHealth() * self._explode_pct
	local team = caster:GetTeamNumber()
	local ab = self:GetAbility()

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_techies/techies_suicide_explosion.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOnLocationWithCaster(origin, "Hero_Techies.LandMine.Detonate", caster)

	local enemies = FindUnitsInRadius(
		team,
		origin,
		nil,
		self._explode_radius,
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
			damage = dmg,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = ab,
		})
	end
end

function IsMyKilledBadGuys2(hero, params)
	if params.unit:GetTeamNumber() ~= DOTA_TEAM_NEUTRALS then
		return false
	end
	local attacker = params.attacker
	if hero ~= attacker or attacker:HasModifier("modifier_guild_event") then
		return false
	end
	if not _G.excludedUnitsLookup[params.unit:GetUnitName()] then
		return false
	end
	return true
end