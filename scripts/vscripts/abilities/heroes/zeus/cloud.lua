--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_zuus_cloud_custom", "abilities/heroes/zeus/cloud", LUA_MODIFIER_MOTION_NONE)

zuus_cloud_custom = zuus_cloud_custom or class({})

function zuus_cloud_custom:Spawn()
	if IsClient() then return end
	self:SetLevel(1)
end

function zuus_cloud_custom:OnInventoryContentsChanged()
	if IsClient() then return end
	if self:GetCaster():HasScepter() then
		self:SetHidden(false)
	else
		self:SetHidden(true)
	end
end

function zuus_cloud_custom:GetAOERadius()
	return self:GetSpecialValueFor("cloud_radius")
end

function zuus_cloud_custom:OnSpellStart()
	if IsServer() then
		self.target_point 			= self:GetCursorPosition()
		local caster 				= self:GetCaster()

		EmitSoundOnLocationWithCaster(self.target_point, "Hero_Zuus.Cloud.Cast", caster)

		self.zuus_nimbus_unit = CreateUnitByName("npc_dota_zeus_cloud", Vector(self.target_point.x, self.target_point.y, 450), false, caster, nil, caster:GetTeam())
		self.zuus_nimbus_unit:SetControllableByPlayer(caster:GetPlayerID(), true)
		self.zuus_nimbus_unit:SetModelScale(0.7)
		self.zuus_nimbus_unit:AddNewModifier(self.zuus_nimbus_unit, self, "modifier_phased", {})
		self.zuus_nimbus_unit:AddNewModifier(caster, self, "modifier_zuus_cloud_custom", {duration = self:GetSpecialValueFor("cloud_duration"), cloud_bolt_interval = self:GetSpecialValueFor("cloud_bolt_interval"), cloud_radius = self:GetSpecialValueFor("cloud_radius")})
		self.zuus_nimbus_unit:SetMinimumGoldBounty(self:GetSpecialValueFor("cloud_bounty_tooltip"))
		self.zuus_nimbus_unit:SetMaximumGoldBounty(self:GetSpecialValueFor("cloud_bounty_tooltip"))
	end
end

modifier_zuus_cloud_custom = class({})
function modifier_zuus_cloud_custom:IsHidden() return true end
function modifier_zuus_cloud_custom:OnCreated(keys)
	if IsServer() then
		self.caster 				= self:GetCaster()
		self.cloud_radius 			= keys.cloud_radius
		self.lightning_interval		= keys.cloud_bolt_interval
		self.current_interval		= 0
		local target_point 			= GetGroundPosition(self:GetParent():GetAbsOrigin(), self:GetParent())

		self.original_z = target_point.z
		self:SetStackCount(self.original_z)

		-- Create nimbus cloud particle
		self.zuus_nimbus_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zeus/zeus_cloud.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		-- Position of ground effect
		ParticleManager:SetParticleControl(self.zuus_nimbus_particle, 0, Vector(target_point.x, target_point.y, 450))
		-- Radius of ground effect
		ParticleManager:SetParticleControl(self.zuus_nimbus_particle, 1, Vector(self.cloud_radius, 0, 0))
		-- Position of cloud
		ParticleManager:SetParticleControl(self.zuus_nimbus_particle, 2, Vector(target_point.x, target_point.y, target_point.z + 450))

		self:StartIntervalThink(FrameTime())
	end
end

function modifier_zuus_cloud_custom:LightningBolt(target)
	local lightning_bolt		 		= self.caster:FindAbilityByName("zuus_lightning_bolt")
	local bolt_damage = lightning_bolt and lightning_bolt:GetAbilityDamage() or self:GetAbility():GetSpecialValueFor("fallback_lightning_damage")

	local bolt_damage_table = self.caster.upgrades["zuus_lightning_bolt"] and self.caster.upgrades["zuus_lightning_bolt"]["damage"]
	if bolt_damage_table then
		bolt_damage = bolt_damage + bolt_damage_table["base_value"] * bolt_damage_table["count"]
	end

	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf", PATTACH_WORLDORIGIN, target)
	local target_point = target:GetAbsOrigin()
	local nimbus_origin = self:GetParent():GetAbsOrigin()
	EmitSoundOnLocationWithCaster(target_point, "Hero_Zuus.LightningBolt", caster)

	-- Renders the particle on the ground target
	ParticleManager:SetParticleControl(particle, 0, Vector(target_point.x, target_point.y, target_point.z))
	ParticleManager:SetParticleControl(particle, 1, Vector(target_point.x, target_point.y, 2000))
	ParticleManager:SetParticleControl(particle, 2, Vector(target_point.x, target_point.y, target_point.z))
	ParticleManager:ReleaseParticleIndex(particle)

	local glow = ParticleManager:CreateParticle("particles/units/heroes/hero_zeus/zeus_cloud_strike_modglow.vpcf", PATTACH_WORLDORIGIN, target)
	ParticleManager:SetParticleControl(glow, 0, Vector(target_point.x, target_point.y, target_point.z))
	ParticleManager:SetParticleControl(glow, 1, Vector(nimbus_origin.x, nimbus_origin.y, nimbus_origin.z))

	local ministun_talent = self:GetCaster():FindAbilityByName("special_bonus_unique_zeus_3")
	CreateModifierThinker(self.caster, self:GetAbility(), "modifier_zuus_lightningbolt_vision_thinker", {duration = lightning_bolt and lightning_bolt:GetSpecialValueFor("sight_duration") or 5}, target_point, self.caster:GetTeam(), false)
	target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_stunned", {duration = 0.3 + (ministun_talent and ministun_talent:GetSpecialValueFor("value") or 0)})

	ApplyDamage({
		victim = target,
		attacker = self:GetParent(),
		damage = bolt_damage,
		damage_type = DAMAGE_TYPE_MAGICAL
	})
end

function modifier_zuus_cloud_custom:OnIntervalThink()
	if self.current_interval > 0 then
		self.current_interval = self.current_interval - FrameTime()
		return
	end

	local enemies = FindUnitsInRadius(self.caster:GetTeam(), self:GetParent():GetAbsOrigin(), nil, self.cloud_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)
	if #enemies == 0 then return end

	self.current_interval = self.lightning_interval
	self:LightningBolt(enemies[1])
end

function modifier_zuus_cloud_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_VISUAL_Z_DELTA,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
end

function modifier_zuus_cloud_custom:CheckState()
	return {
		[MODIFIER_STATE_MAGIC_IMMUNE] = true
	}
end

function modifier_zuus_cloud_custom:GetVisualZDelta()
	return 450
end

function modifier_zuus_cloud_custom:GetModifierIncomingDamage_Percentage(keys)
    if IsClient() then return end

	local attacker = keys.attacker

	if attacker:IsHero() then
		if attacker:IsRangedAttacker() then
			self:GetParent():SetHealth(self:GetParent():GetHealth() - 2)
		else
			self:GetParent():SetHealth(self:GetParent():GetHealth() - 4)
		end
	else
		self:GetParent():SetHealth(self:GetParent():GetHealth() - 1)
	end

	return -9999999
end

function modifier_zuus_cloud_custom:OnRemoved()
	if IsServer() then
		ParticleManager:DestroyParticle(self.zuus_nimbus_particle, false)

		if self:GetParent():IsAlive() then
			self:GetParent():ForceKill(false)
		end
	end
end