--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_doom_bringer_doom_custom",
	"heroes/hero_doom_bringer/doom_bringer_doom_custom/doom_bringer_doom_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_doom_bringer_doom_custom_aura",
	"heroes/hero_doom_bringer/doom_bringer_doom_custom/doom_bringer_doom_custom",
	LUA_MODIFIER_MOTION_NONE
)

doom_bringer_doom_custom = class({})

function doom_bringer_doom_custom:Precache(context)
	PrecacheResource("particle", "particles/status_fx/status_effect_doom.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_doom_bringer/doom_bringer_doom.vpcf", context)
end

function doom_bringer_doom_custom:CastFilterResultTarget(target)
	local nResult = UnitFilter(
		target,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
		self:GetCaster():GetTeamNumber()
	)

	if self:GetCaster():HasScepter() then
		nResult = UnitFilter(
			target,
			DOTA_UNIT_TARGET_TEAM_BOTH,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
			self:GetCaster():GetTeamNumber()
		)
	end

	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end

function doom_bringer_doom_custom:OnSpellStart()
	if not IsServer() then
		return
	end
	local target = self:GetCursorTarget()
	if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		if target:TriggerSpellAbsorb(self) then
			return
		end
	end
	local duration = self:GetSpecialValueFor("duration")
	self:ApplyDoom(target, duration)
end

function doom_bringer_doom_custom:ApplyDoom(target, duration)
	if not IsServer() then
		return
	end
	if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		target:Purge(true, false, false, false, false)
	end
	if self:GetCaster():HasScepter() then
		target:AddNewModifier(self:GetCaster(), self, "modifier_doom_bringer_doom_custom_aura", { duration = duration })
		return
	end
	target:AddNewModifier(self:GetCaster(), self, "modifier_doom_bringer_doom_custom", { duration = duration })
end

modifier_doom_bringer_doom_custom = class({})

function modifier_doom_bringer_doom_custom:IsHidden()
	return false
end

function modifier_doom_bringer_doom_custom:IsDebuff()
	return true
end

function modifier_doom_bringer_doom_custom:IsStunDebuff()
	return false
end

function modifier_doom_bringer_doom_custom:IsPurgable()
	return false
end

function modifier_doom_bringer_doom_custom:OnCreated(kv)
	self.interval = 1
	if not IsServer() then
		return
	end
	self:OnIntervalThink()
	self:StartIntervalThink(self.interval)
	self:PlayEffects()
end

function modifier_doom_bringer_doom_custom:OnDestroy()
	if not IsServer() then
		return
	end
	self:GetParent():StopSound("Hero_DoomBringer.Doom")
end

function modifier_doom_bringer_doom_custom:CheckState()
	local state = {
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = self:GetAbility():GetSpecialValueFor("does_mute") > 0,
		[MODIFIER_STATE_PASSIVES_DISABLED] = self:GetAbility():GetSpecialValueFor("does_break") > 0,
		[MODIFIER_STATE_SPECIALLY_DENIABLE] = self:GetParent():GetHealthPercent() <= self:GetAbility()
			:GetSpecialValueFor("deniable_pct"),
	}
	return state
end

function modifier_doom_bringer_doom_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_DISABLE_HEALING,
	}
end

function modifier_doom_bringer_doom_custom:GetDisableHealing()
	return 1
end

function modifier_doom_bringer_doom_custom:OnIntervalThink()
	if not IsServer() then
		return
	end
	local damage = self:GetAbility():GetSpecialValueFor("damage")
	local damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
	}
	ApplyDamage(damageTable)
end

function modifier_doom_bringer_doom_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_doom.vpcf"
end

function modifier_doom_bringer_doom_custom:StatusEffectPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end

function modifier_doom_bringer_doom_custom:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_doom_bringer/doom_bringer_doom.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	self:AddParticle(effect_cast, false, false, MODIFIER_PRIORITY_SUPER_ULTRA, false, false)
	self:GetParent():EmitSound("Hero_DoomBringer.Doom")
end

modifier_doom_bringer_doom_custom_aura = class({})

function modifier_doom_bringer_doom_custom_aura:IsPurgable()
	return false
end
function modifier_doom_bringer_doom_custom_aura:OnCreated()
	if not IsServer() then
		return
	end
	self:StartIntervalThink(FrameTime())
end

function modifier_doom_bringer_doom_custom_aura:OnIntervalThink()
	if not IsServer() then
		return
	end
	if not self:GetParent():IsAlive() then
		self:Destroy()
	end
end

function modifier_doom_bringer_doom_custom_aura:IsAura()
	return true
end

function modifier_doom_bringer_doom_custom_aura:GetModifierAura()
	return "modifier_doom_bringer_doom_custom"
end

function modifier_doom_bringer_doom_custom_aura:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("scepter_aura_radius")
end

function modifier_doom_bringer_doom_custom_aura:GetAuraDuration()
	return 0
end

function modifier_doom_bringer_doom_custom_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end

function modifier_doom_bringer_doom_custom_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_doom_bringer_doom_custom_aura:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_doom_bringer_doom_custom_aura:GetEffectName()
	return "particles/units/heroes/hero_doom_bringer/doom_bringer_doom_aura.vpcf"
end

function modifier_doom_bringer_doom_custom_aura:GetAuraEntityReject(target)
	if IsServer() then
		if target == self:GetCaster() or target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
			return true
		else
			return false
		end
	end
end

function modifier_doom_bringer_doom_custom_aura:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end