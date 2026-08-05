--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_golden_queen_field_thinker",
	"abilities/addition_bosses/golden_queen",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_golden_queen_field_slow", "abilities/addition_bosses/golden_queen", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_golden_queen_field_freeze",
	"abilities/addition_bosses/golden_queen",
	LUA_MODIFIER_MOTION_NONE
)

golden_queen_field = class({})

function golden_queen_field:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function golden_queen_field:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_ancient_apparition/ancient_ice_vortex.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_crystalmaiden/maiden_crystal_nova.vpcf", context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_slowed_cold.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_crystalmaiden.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_ancient_apparition.vsndevts", context)
end

function golden_queen_field:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local delay = self:GetSpecialValueFor("delay")
	local interval = 0.5
	local current_time = 0

	caster:SetContextThink(DoUniqueString("queen_field"), function()
		if not self or self:IsNull() or not caster or caster:IsNull() then
			return nil
		end

		self:CreateExplosionZone()
		current_time = current_time + interval

		if current_time < delay then
			return interval
		else
			return nil
		end
	end, 0)
end

function golden_queen_field:CreateExplosionZone()
	local caster = self:GetCaster()
	local range = self:GetSpecialValueFor("range")
	local explosion_delay = self:GetSpecialValueFor("explosion_delay")

	local target_pos = caster:GetAbsOrigin()
	target_pos = target_pos + RandomVector(RandomInt(0, range))

	EmitSoundOn("Hero_Ancient_Apparition.IceVortexCast", caster)
	CreateModifierThinker(
		caster,
		self,
		"modifier_golden_queen_field_thinker",
		{ duration = explosion_delay },
		target_pos,
		caster:GetTeamNumber(),
		false
	)
end

--------------------------------------------------------------------------------

modifier_golden_queen_field_thinker = class({})

function modifier_golden_queen_field_thinker:IsAura()
	return true
end

function modifier_golden_queen_field_thinker:GetAuraRadius()
	return 350
end

function modifier_golden_queen_field_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_golden_queen_field_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_golden_queen_field_thinker:GetModifierAura()
	return "modifier_golden_queen_field_slow"
end

function modifier_golden_queen_field_thinker:OnCreated()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local radius = ability:GetSpecialValueFor("damage_radius")

	self.preFX = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ancient_apparition/ancient_ice_vortex.vpcf",
		PATTACH_ABSORIGIN,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(self.preFX, 1, Vector(radius, 0, 0))
	ParticleManager:SetParticleControl(self.preFX, 5, Vector(radius, 0, 0))

	self:GetParent():EmitSound("Hero_Ancient_Apparition.IceVortexCast")
end

function modifier_golden_queen_field_thinker:OnDestroy()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not caster or caster:IsNull() or not ability or ability:IsNull() then
		return
	end

	local parent = self:GetParent()
	local pos = parent:GetAbsOrigin()
	local radius = ability:GetSpecialValueFor("damage_radius")
	local damage = ability:GetSpecialValueFor("damage") + ability:GetSpecialValueFor("diff_boost_damage")
	local duration = ability:GetSpecialValueFor("duration")

	if self.preFX then
		ParticleManager:DestroyParticle(self.preFX, false)
		ParticleManager:ReleaseParticleIndex(self.preFX)
	end

	local targets = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		0,
		false
	)

	for _, unit in pairs(targets) do
		ApplyDamage({
			victim = unit,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = ability,
		})
		unit:AddNewModifier(caster, self, "modifier_golden_queen_field_freeze", { duration = duration })
	end

	self:GetAbility():PlayEffects(pos, radius)
end

function golden_queen_field:PlayEffects(point, radius)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_crystalmaiden/maiden_crystal_nova.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(effect_cast, 0, point)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	local sound_cast = "Hero_Crystal.CrystalNova"
	-- EmitSoundOnLocationWithCaster( point, sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

--------------------------------------------------------------------------------

modifier_golden_queen_field_slow = class({})

function modifier_golden_queen_field_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_golden_queen_field_slow:GetModifierMoveSpeedBonus_Percentage()
	return -self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_golden_queen_field_slow:GetEffectName()
	return "particles/generic_gameplay/generic_slowed_cold.vpcf"
end

--------------------------------------------------------------------------------

modifier_golden_queen_field_freeze = class({})

function modifier_golden_queen_field_freeze:IsHidden()
	return false
end

function modifier_golden_queen_field_freeze:IsDebuff()
	return true
end

function modifier_golden_queen_field_freeze:IsStunDebuff()
	return false
end

function modifier_golden_queen_field_freeze:IsPurgable()
	return true
end

function modifier_golden_queen_field_freeze:OnCreated(kv)
	EmitSoundOn("hero_Crystal.frostbite", self:GetParent())
end

function modifier_golden_queen_field_freeze:OnDestroy()
	StopSoundOn("hero_Crystal.frostbite", self:GetParent())
end

function modifier_golden_queen_field_freeze:CheckState()
	local state = {
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_INVISIBLE] = false,
	}
	return state
end

function modifier_golden_queen_field_freeze:DeclareFunctions()
	local decFuncs = {
		MODIFIER_PROPERTY_DISABLE_HEALING,
	}
	return decFuncs
end

function modifier_golden_queen_field_freeze:GetDisableHealing()
	return 1
end

function modifier_golden_queen_field_freeze:GetEffectName()
	return "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf"
end

function modifier_golden_queen_field_freeze:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_golden_queen_aero_echo", "abilities/addition_bosses/golden_queen", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_golden_queen_aero_echo_thinker",
	"abilities/addition_bosses/golden_queen",
	LUA_MODIFIER_MOTION_NONE
)

golden_queen_aero_echo = class({})

function golden_queen_aero_echo:Precache(context)
	PrecacheResource(
		"particle",
		"particles/econ/items/invoker/invoker_apex/invoker_sun_strike_team_glow_small2_immortal1.vpcf",
		context
	)
	PrecacheResource("particle", "particles/items_fx/dagon.vpcf", context)
end

function golden_queen_aero_echo:GetIntrinsicModifierName()
	return "modifier_golden_queen_aero_echo"
end

--------------------------------------------------------------------------------

modifier_golden_queen_aero_echo = class({})

function modifier_golden_queen_aero_echo:IsHidden()
	return true
end

function modifier_golden_queen_aero_echo:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_golden_queen_aero_echo:OnTakeDamage(params)
	if not IsServer() then
		return
	end

	if params.unit ~= self:GetParent() then
		return
	end

	local attacker = params.attacker
	local ability = params.inflictor
	local damage_received = params.damage

	if ability and attacker:GetTeamNumber() ~= params.unit:GetTeamNumber() then
		local delay = self:GetAbility():GetSpecialValueFor("echo_delay")
		local pos = attacker:GetAbsOrigin() + RandomVector(RandomInt(50, 150))

		CreateModifierThinker(params.unit, self:GetAbility(), "modifier_golden_queen_aero_echo_thinker", {
			duration = delay,
			target_entindex = attacker:entindex(),
			echo_damage = damage_received,
		}, pos, params.unit:GetTeamNumber(), false)

		local pfx = ParticleManager:CreateParticle(
			"particles/econ/items/invoker/invoker_apex/invoker_sun_strike_team_glow_small2_immortal1.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(pfx, 0, pos)
		ParticleManager:ReleaseParticleIndex(pfx)
	end
end

--------------------------------------------------------------------------------

modifier_golden_queen_aero_echo_thinker = class({})

function modifier_golden_queen_aero_echo_thinker:OnCreated(keys)
	if not IsServer() then
		return
	end
	self.echo_damage = keys.echo_damage
	self.target_index = keys.target_entindex

	self:GetParent():EmitSound("Hero_ArcWarden.SparkWraith.Appear")
end

function modifier_golden_queen_aero_echo_thinker:OnDestroy()
	if not IsServer() then
		return
	end

	local pos = self:GetParent():GetAbsOrigin()
	local caster = self:GetCaster()

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
		nil,
		self:GetAbility():GetSpecialValueFor("find_radius"),
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		caster:EmitSound("DOTA_Item.Dagon.Activate")
		DagonizeIt(self:GetParent(), self:GetAbility(), self:GetParent(), enemy, self.echo_damage)
	end
end

function DagonizeIt(caster, ability, source, target, damage)
	if not IsServer() then
		return
	end
	local dagon_pfx =
		ParticleManager:CreateParticle("particles/items_fx/dagon.vpcf", PATTACH_RENDERORIGIN_FOLLOW, source)
	ParticleManager:SetParticleControlEnt(
		dagon_pfx,
		0,
		source,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		source:GetAbsOrigin(),
		false
	)
	ParticleManager:SetParticleControlEnt(
		dagon_pfx,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		false
	)
	ParticleManager:SetParticleControl(dagon_pfx, 2, Vector(damage, 0, 0))
	ParticleManager:SetParticleControl(dagon_pfx, 3, Vector(0.3, 0, 0))
	ParticleManager:ReleaseParticleIndex(dagon_pfx)

	if target:IsAlive() then
		ApplyDamage({
			attacker = caster,
			victim = target,
			ability = ability,
			damage = damage,
			damage_type = DAMAGE_TYPE_PURE,
			damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		})
	end
end