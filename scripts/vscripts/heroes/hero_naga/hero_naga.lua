--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_naga_siren_mirror_image_lua", "heroes/hero_naga/hero_naga", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_illusion_naga_siren_mirror_image_lua", "heroes/hero_naga/hero_naga", LUA_MODIFIER_MOTION_NONE)

naga_siren_mirror_image_lua = {}

function naga_siren_mirror_image_lua:GetIntrinsicModifierName()
	return "modifier_naga_siren_mirror_image_lua"
end

function naga_siren_mirror_image_lua:OnSpellStart()
	local caster = self:GetCaster()
	local outgoing = self:GetSpecialValueFor("illusion_outgoing_damage")
	local incoming = self:GetSpecialValueFor("illusion_incoming_damage") - 100
	local count = self:GetSpecialValueFor("count")

	if self.illusions then
		for _, illusion in pairs(self.illusions) do
			if illusion and not illusion:IsNull() and illusion:IsAlive() then
				UTIL_Remove(illusion)
			end
		end
	end

	self.illusions = {}

	local illusions =
		CreateIllusions(caster, caster, { outgoing_damage = 0, incoming_damage = incoming }, count, 72, false, true)
	if illusions then
		for _, illusion in pairs(illusions) do
			local average_bonus_damage = caster:GetAverageTrueAttackDamage(nil) / 100 * outgoing
			illusion:SetBaseDamageMin(average_bonus_damage - self:GetCaster():GetAgility())
			illusion:SetBaseDamageMax(average_bonus_damage - self:GetCaster():GetAgility())
			illusion:AddNewModifier(caster, self, "modifier_illusion_naga_siren_mirror_image_lua", {})

			EmitSoundOn("Hero_NagaSiren.MirrorImage", illusion)
			table.insert(self.illusions, illusion)
		end
	end
end

--------------------------------------------------------------------------------

modifier_illusion_naga_siren_mirror_image_lua = class({})

function modifier_illusion_naga_siren_mirror_image_lua:IsHidden()
	return true
end

function modifier_illusion_naga_siren_mirror_image_lua:OnCreated()
	if not IsServer() then
		return
	end
end

function modifier_illusion_naga_siren_mirror_image_lua:OnDestroy()
	if not IsServer() then
		return
	end
	local abil = self:GetAbility()
	local parent = self:GetParent()

	if abil and abil.illusions then
		for i, illusion in pairs(abil.illusions) do
			if illusion == parent then
				table.remove(abil.illusions, i)
				break
			end
		end
	end
end

--------------------------------------------------------------------------------

modifier_naga_siren_mirror_image_lua = class({})

function modifier_naga_siren_mirror_image_lua:IsHidden()
	return true
end
function modifier_naga_siren_mirror_image_lua:IsPurgable()
	return false
end

function modifier_naga_siren_mirror_image_lua:OnCreated()
	if IsServer() then
		self:StartIntervalThink(0.1)
	end
end

function modifier_naga_siren_mirror_image_lua:OnDestroy()
	if not IsServer() then
		return
	end
	local abil = self:GetAbility()

	if abil.illusions then
		for _, illusion in pairs(abil.illusions) do
			if illusion and not illusion:IsNull() and illusion:IsAlive() then
				UTIL_Remove(illusion)
			end
		end
	end
end

function modifier_naga_siren_mirror_image_lua:OnIntervalThink()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not caster:IsAlive() then
		for i, illusion in pairs(ability.illusions) do
			if illusion and not illusion:IsNull() then
				UTIL_Remove(illusion)
			end
		end
		ability.illusions = {}
		return
	end

	if ability.illusions and ability:IsFullyCastable() and #ability.illusions < 1 and caster:IsRealHero() then
		ability:OnSpellStart()
		ability:UseResources(true, false, false, false)
		ability:StartCooldown(1.0)
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_naga_siren_ensnare_lua", "heroes/hero_naga/hero_naga", LUA_MODIFIER_MOTION_NONE)

naga_siren_ensnare_lua = class({})

function naga_siren_ensnare_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function naga_siren_ensnare_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target_point = self:GetCursorPosition()
	local radius = self:GetSpecialValueFor("radius")
	local net_speed = self:GetSpecialValueFor("net_speed")

	local targets = FindUnitsInRadius(
		caster:GetTeamNumber(),
		target_point,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)

	for _, target in pairs(targets) do
		local info = {
			Target = target,
			Source = caster,
			Ability = self,
			EffectName = "particles/units/heroes/hero_siren/siren_net_projectile.vpcf",
			iMoveSpeed = net_speed,
			bDodgeable = true,
			ExtraData = {},
		}
		ProjectileManager:CreateTrackingProjectile(info)
	end

	EmitSoundOn("Hero_NagaSiren.Ensnare.Cast", caster)
end

function naga_siren_ensnare_lua:OnProjectileHit_ExtraData(target, location, data)
	if not target or target:IsMagicImmune() or target:TriggerSpellAbsorb(self) then
		return
	end

	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	local damage = self:GetSpecialValueFor("damage")

	target:AddNewModifier(caster, self, "modifier_naga_siren_ensnare_lua", { duration = duration })

	ApplyDamage({
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self,
	})

	EmitSoundOn("Hero_NagaSiren.Ensnare.Target", target)
end

--------------------------------------------------------------------------------

modifier_naga_siren_ensnare_lua = class({})

function modifier_naga_siren_ensnare_lua:IsHidden()
	return false
end
function modifier_naga_siren_ensnare_lua:IsDebuff()
	return true
end
function modifier_naga_siren_ensnare_lua:IsPurgable()
	return true
end
function modifier_naga_siren_ensnare_lua:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

function modifier_naga_siren_ensnare_lua:CheckState()
	return {
		[MODIFIER_STATE_INVISIBLE] = false,
		[MODIFIER_STATE_ROOTED] = true,
	}
end

function modifier_naga_siren_ensnare_lua:GetEffectName()
	return "particles/units/heroes/hero_siren/siren_net.vpcf"
end

function modifier_naga_siren_ensnare_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_naga_siren_rip_tide_lua", "heroes/hero_naga/hero_naga", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_naga_siren_rip_tide_lua_debuff", "heroes/hero_naga/hero_naga", LUA_MODIFIER_MOTION_NONE)

naga_siren_rip_tide_lua = class({})
naga_siren_rip_tide_lua.illusions = {}

function naga_siren_rip_tide_lua:GetIntrinsicModifierName()
	return "modifier_naga_siren_rip_tide_lua"
end

--------------------------------------------------------------------------------

modifier_naga_siren_rip_tide_lua = class({})

function modifier_naga_siren_rip_tide_lua:IsHidden()
	return self:GetStackCount() == 0
end

function modifier_naga_siren_rip_tide_lua:IsPurgable()
	return false
end

function modifier_naga_siren_rip_tide_lua:OnCreated()
	if not IsServer() then
		return
	end
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.duration = self:GetAbility():GetSpecialValueFor("duration")

	if self:GetParent():IsIllusion() then
		self:GetAbility().illusions[self:GetParent()] = true
	end
end

function modifier_naga_siren_rip_tide_lua:OnRefresh()
	if not IsServer() then
		return
	end
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
end

function modifier_naga_siren_rip_tide_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_naga_siren_rip_tide_lua:GetModifierProcAttack_Feedback(params)
	if not IsServer() or self.parent:PassivesDisabled() then
		return
	end

	local target_modifier = self
	if self.parent:IsIllusion() then
		local owner = self.parent:GetPlayerOwner():GetAssignedHero()
		if owner then
			target_modifier = owner:FindModifierByName("modifier_naga_siren_rip_tide_lua")
		end
	end

	if target_modifier then
		target_modifier:AddRipStack()
	end
end

function modifier_naga_siren_rip_tide_lua:AddRipStack()
	self:IncrementStackCount()
	if self:GetStackCount() >= self:GetAbility():GetSpecialValueFor("stacks") then
		self:SetStackCount(0)
		self:TriggerRipTide()
	end
end

function modifier_naga_siren_rip_tide_lua:TriggerRipTide()
	self:Proc()

	for illusion, _ in pairs(self:GetAbility().illusions) do
		if
			illusion:IsIllusion()
			and illusion:GetPlayerOwner() == self:GetParent():GetPlayerOwner()
			and illusion:IsAlive()
		then
			local mod = illusion:FindModifierByName("modifier_naga_siren_rip_tide_lua")
			if mod then
				mod:Proc()
			end
		end
	end
end

function modifier_naga_siren_rip_tide_lua:Proc()
	local damage = self:GetAbility():GetSpecialValueFor("damage")

	local enemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),
		self.parent:GetAbsOrigin(),
		self.parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(
			self.caster,
			self:GetAbility(),
			"modifier_naga_siren_rip_tide_lua_debuff",
			{ duration = self.duration }
		)

		ApplyDamage({
			victim = enemy,
			attacker = self.parent,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility(),
		})
	end

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_siren/naga_siren_riptide.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControl(pfx, 1, Vector(self.radius, 1, 1))
	ParticleManager:ReleaseParticleIndex(pfx)

	EmitSoundOn("Hero_NagaSiren.Riptide.Cast", self.parent)
end

--------------------------------------------------------------------------------

modifier_naga_siren_rip_tide_lua_debuff = class({})

function modifier_naga_siren_rip_tide_lua_debuff:IsDebuff()
	return true
end
function modifier_naga_siren_rip_tide_lua_debuff:IsPurgable()
	return true
end

function modifier_naga_siren_rip_tide_lua_debuff:DeclareFunctions()
	return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end

function modifier_naga_siren_rip_tide_lua_debuff:GetModifierPhysicalArmorBonus()
	return -self:GetAbility():GetSpecialValueFor("armor_reduction")
end

function modifier_naga_siren_rip_tide_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_siren/naga_siren_riptide_debuff.vpcf"
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_naga_siren_song_of_the_siren_lua", "heroes/hero_naga/hero_naga", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_naga_siren_song_of_the_siren_lua_buff",
	"heroes/hero_naga/hero_naga",
	LUA_MODIFIER_MOTION_NONE
)

naga_siren_song_of_the_siren_lua = class({})

function naga_siren_song_of_the_siren_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	caster:AddNewModifier(caster, self, "modifier_naga_siren_song_of_the_siren_lua", { duration = duration })
end

--------------------------------------------------------------------------------

modifier_naga_siren_song_of_the_siren_lua = class({})

function modifier_naga_siren_song_of_the_siren_lua:IsHidden()
	return false
end
function modifier_naga_siren_song_of_the_siren_lua:IsPurgable()
	return false
end

function modifier_naga_siren_song_of_the_siren_lua:OnCreated()
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()

	local cast_pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_siren/naga_siren_siren_song_cast.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:ReleaseParticleIndex(cast_pfx)

	self.main_pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_siren/naga_siren_song_aura.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControlEnt(
		self.main_pfx,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	self:AddParticle(self.main_pfx, false, false, -1, false, false)

	EmitSoundOn("Hero_NagaSiren.SongOfTheSiren", caster)
end

function modifier_naga_siren_song_of_the_siren_lua:OnDestroy()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	StopSoundOn("Hero_NagaSiren.SongOfTheSiren", caster)
	EmitSoundOn("Hero_NagaSiren.SongOfTheSiren.Cancel", caster)
end

function modifier_naga_siren_song_of_the_siren_lua:IsAura()
	return true
end
function modifier_naga_siren_song_of_the_siren_lua:GetModifierAura()
	return "modifier_naga_siren_song_of_the_siren_lua_buff"
end
function modifier_naga_siren_song_of_the_siren_lua:GetAuraRadius()
	return self.radius
end
function modifier_naga_siren_song_of_the_siren_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_naga_siren_song_of_the_siren_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_naga_siren_song_of_the_siren_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

--------------------------------------------------------------------------------

modifier_naga_siren_song_of_the_siren_lua_buff = class({})

function modifier_naga_siren_song_of_the_siren_lua_buff:IsHidden()
	return false
end
function modifier_naga_siren_song_of_the_siren_lua_buff:IsPurgable()
	return false
end
function modifier_naga_siren_song_of_the_siren_lua_buff:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_naga_siren_song_of_the_siren_lua_buff:OnCreated()
	local ability = self:GetAbility()
	self.res = ability:GetSpecialValueFor("magic_resistance")
	self.regen = ability:GetSpecialValueFor("hp_regeneration")
end

function modifier_naga_siren_song_of_the_siren_lua_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE_UNIQUE,
	}
end

function modifier_naga_siren_song_of_the_siren_lua_buff:GetModifierMagicalResistanceBonus()
	return self.res
end
function modifier_naga_siren_song_of_the_siren_lua_buff:GetModifierHealthRegenPercentageUnique()
	return self.regen
end

function modifier_naga_siren_song_of_the_siren_lua_buff:GetEffectName()
	return "particles/units/heroes/hero_siren/naga_siren_song_debuff.vpcf"
end

function modifier_naga_siren_song_of_the_siren_lua_buff:GetStatusEffectName()
	return "particles/status_fx/status_effect_siren_song.vpcf"
end

function modifier_naga_siren_song_of_the_siren_lua_buff:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end