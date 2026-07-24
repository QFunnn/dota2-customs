--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


sniper_assassinate_lua = class({})

function sniper_assassinate_lua:OnAbilityPhaseInterrupted()
	if not IsValidEntity(self.target) then return end
	local modifier = self.target:FindModifierByName("modifier_sniper_assassinate")
	if not modifier then return end
	modifier:Destroy()
end

function sniper_assassinate_lua:GetCastPoint()
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor("scepter_cast_point") or 0.5
	end
	return self.BaseClass.GetCastPoint(self)
end

function sniper_assassinate_lua:OnAbilityPhaseStart()
	self.caster = self:GetCaster()
	if not IsValidEntity(self.caster) then return end
	self.target = self:GetCursorTarget()
	if not IsValidEntity(self.target) then return end

	self.target:AddNewModifier(self.caster, self, "modifier_sniper_assassinate", {duration = 4})
	EmitSoundOnClient("Ability.AssassinateLoad", self.caster:GetPlayerOwner())

	if not self.listener then
		self.listener = EventDriver:Listen("Events:hero_killed", self.OnHeroKilled, self)
	end

	return true
end

function sniper_assassinate_lua:OnSpellStart()
	self.caster = self:GetCaster()
	if not IsValidEntity(self.caster) then return end
	self.target = self:GetCursorTarget()
	if not IsValidEntity(self.target) then return end

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local info = {
		Target = self.target,
		Source = self.caster,
		Ability = self,

		EffectName = "particles/units/heroes/hero_sniper/sniper_assassinate.vpcf",
		iMoveSpeed = projectile_speed,
		bDodgeable = true,
		--ExtraData = {},
	}
	ProjectileManager:CreateTrackingProjectile(info)

	EmitSoundOn("Ability.Assassinate", self.caster)
	--local sound_target = "Hero_Sniper.AssassinateProjectile"
	--EmitSoundOn(sound_cast, target)
end

function sniper_assassinate_lua:OnProjectileHit_ExtraData(target, location, extradata)
	if not IsValidEntity(target) then return end
	if not IsValidEntity(self.caster) then return end
	if target:IsInvulnerable() or target:IsOutOfGame() or target:TriggerSpellAbsorb(self) then return end

	-- Assassinate first applies the spell damage, the instant attack, then the debuff.
	local damage = self:GetSpecialValueFor("damage")
	local damage_table = {
		victim = target,
		attacker = self.caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}
	ApplyDamage(damage_table)

	self.attack_bonus = true
	self.caster:PerformAttack(target, true, true, true, true, false, false, true)
	self.attack_bonus = false

	if not target:IsDebuffImmune() and not target:IsMagicImmune() then
		target:Interrupt()
	end

	if self.caster:HasScepter() then
		local scepter_stun_duration = self:GetSpecialValueFor("scepter_stun_duration")
		self.target:AddNewModifierSR(self.caster, self, "modifier_stunned", {duration = scepter_stun_duration})
	end

	local modifier = self.target:FindModifierByName("modifier_sniper_assassinate")
	if modifier then
		modifier:Destroy()
	end

	EmitSoundOn("Hero_Sniper.AssassinateDamage", target)
end

function sniper_assassinate_lua:OnHeroKilled(event)
	local killed = event.killed
	local killer = event.killer
	local inflictor = event.inflictor

	if not IsValidEntity(killed) then return end
	if not IsValidEntity(killer) then return end
	if not killed:IsRealHero() then return end
	if killer ~= self.caster then return end
	if inflictor then -- assassinate spell damage
		if not IsValidEntity(inflictor) then return end
		if inflictor ~= self then return end
	else -- assassinate perform attack
		if not self.attack_bonus then return end
	end

	local cooldown_reduction_on_kill_pct = self:GetSpecialValueFor("cooldown_reduction_on_kill_pct") or 0
	local override_cooldown = self:GetCooldownTimeRemaining() * (1 - cooldown_reduction_on_kill_pct * 0.01)
	if override_cooldown <= 0 then return end
	self:EndCooldown()
	self:StartCooldown(override_cooldown)
end