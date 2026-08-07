--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


modifier_clown_escape_act_box = class({})

function modifier_clown_escape_act_box:IsHidden()
	return false
end
function modifier_clown_escape_act_box:IsPurgable()
	return false
end
function modifier_clown_escape_act_box:IsPurgeException()
	return false
end
function modifier_clown_escape_act_box:RemoveOnDeath()
	return true
end
function modifier_clown_escape_act_box:GetStatusEffectName()
	return "particles/status_fx/status_effect_ringmaster_box.vpcf"
end
function modifier_clown_escape_act_box:StatusEffectPriority()
	return 20
end

function modifier_clown_escape_act_box:OnCreated(kv)
	self.radius = tonumber(kv and kv.radius) or 600
	self.stun_duration = tonumber(kv and kv.stun_duration) or 1.0

	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	EmitSoundOn("Hero_Ringmaster.Box.Cast", parent)
	EmitSoundOn("Hero_RingMaster.Box.Target", parent)

	self.effect = LevelUpParticleManager:CreateParticle(
		"particles/clown_set/ringmaster_escape_act_target.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent
	)

	local p = LevelUpParticleManager:CreateParticle(
		"particles/units/heroes/hero_ringmaster/ringmaster_box_dust_kickup.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent
	)
	LevelUpParticleManager:ReleaseParticleIndex(p)
end

function modifier_clown_escape_act_box:CheckState()
	return {
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_clown_escape_act_box:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_CHANGE,
	}
end

function modifier_clown_escape_act_box:GetModifierModelChange()
	return "models/heroes/ringmaster/ringmaster_box.vmdl"
end

function modifier_clown_escape_act_box:OnDestroy()
	if not IsServer() then
		return
	end

	if self.effect then
		LevelUpParticleManager:DestroyParticle(self.effect, false)
		LevelUpParticleManager:ReleaseParticleIndex(self.effect)
		self.effect = nil
	end

	local parent = self:GetParent()
	if not IsValid(parent) or not parent:IsAlive() then
		return
	end
	StopSoundOn("Hero_Ringmaster.Box.Target", parent)
	EmitSoundOn("Hero_Ringmaster.Box.Destroy", parent)

	local p = LevelUpParticleManager:CreateParticle(
		"particles/units/heroes/hero_ringmaster/ringmaster_wheel_aoe.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	LevelUpParticleManager:SetParticleControl(p, 0, parent:GetAbsOrigin())
	LevelUpParticleManager:SetParticleControl(p, 1, Vector(self.radius, 0, 0))
	LevelUpParticleManager:ReleaseParticleIndex(p)

	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	for _, enemy in ipairs(enemies) do
		enemy:AddNewModifier(
			parent,
			self:GetAbility(),
			"modifier_generic_stunned_lua",
			{ duration = self.stun_duration }
		)
	end
end