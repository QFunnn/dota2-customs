--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_terrorblade_innate_custom",
	"abilities/terrorblade/terrorblade_innate_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_terrorblade_innate_custom_tracker",
	"abilities/terrorblade/terrorblade_innate_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_terrorblade_innate_custom_aura_damage",
	"abilities/terrorblade/terrorblade_innate_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_terrorblade_innate_custom_aura_damage_count",
	"abilities/terrorblade/terrorblade_innate_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_terrorblade_innate_custom_damage_reduce",
	"abilities/terrorblade/terrorblade_innate_custom",
	LUA_MODIFIER_MOTION_NONE
)

terrorblade_innate_custom = class({})
terrorblade_innate_custom.talents = {}

function terrorblade_innate_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("soundfile", "soundevents/npc_dota_hero_terrorblade.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/vo_custom/terrorblade_vo_custom.vsndevts", context)
end

function terrorblade_innate_custom:UpdateTalents(name)
	local caster = self:GetCaster()
	if not self.init then
		self.init = true
		self.talents = {
			has_w1 = 0,
			w1_damage = 0,
			w1_slow = 0,
			w1_radius = caster:GetTalentValue("modifier_terror_illusion_1", "radius", true),
			w1_radius_meta = caster:GetTalentValue("modifier_terror_illusion_1", "radius_meta", true),
			w1_interval = caster:GetTalentValue("modifier_terror_illusion_1", "interval", true),

			w3_move = 0,
			w3_magic = 0,

			w4_damage = 0,
			w4_agility = 0,
			w4_max = caster:GetTalentValue("modifier_terror_illusion_4", "max", true),

			has_w6 = 0,
			w6_duration = caster:GetTalentValue("modifier_terror_illusion_6", "duration", true),
			w6_damage_self = caster:GetTalentValue("modifier_terror_illusion_6", "damage_self", true),
			w6_damage_reduce = caster:GetTalentValue("modifier_terror_illusion_6", "damage_reduce", true),

			e2_range = 0,
			e2_bonus = caster:GetTalentValue("modifier_terror_meta_2", "bonus", true),

			has_e6 = 0,
			e6_status = caster:GetTalentValue("modifier_terror_meta_6", "status", true),

			r2_health = 0,
		}
	end

	if caster:HasTalent("modifier_terror_illusion_1") then
		self.talents.has_w1 = 1
		self.talents.w1_damage = caster:GetTalentValue("modifier_terror_illusion_1", "damage")
		self.talents.w1_slow = caster:GetTalentValue("modifier_terror_illusion_1", "slow")
	end

	if caster:HasTalent("modifier_terror_illusion_3") then
		self.talents.w3_move = caster:GetTalentValue("modifier_terror_illusion_3", "move")
		self.talents.w3_magic = caster:GetTalentValue("modifier_terror_illusion_3", "magic")
	end

	if caster:HasTalent("modifier_terror_illusion_4") then
		self.talents.w4_damage = caster:GetTalentValue("modifier_terror_illusion_4", "damage")
		self.talents.w4_agility = caster:GetTalentValue("modifier_terror_illusion_4", "agility")
	end

	if caster:HasTalent("modifier_terror_illusion_6") then
		self.talents.has_w6 = 1
	end

	if caster:HasTalent("modifier_terror_meta_2") then
		self.talents.e2_range = caster:GetTalentValue("modifier_terror_meta_2", "range")
	end

	if caster:HasTalent("modifier_terror_meta_6") then
		self.talents.has_e6 = 1
	end

	if caster:HasTalent("modifier_terror_sunder_2") then
		self.talents.r2_health = caster:GetTalentValue("modifier_terror_sunder_2", "health")
	end
end

function terrorblade_innate_custom:GetIntrinsicModifierName()
	if self:GetCaster():IsRealHero() then
		return "modifier_terrorblade_innate_custom"
	else
		return "modifier_terrorblade_innate_custom_tracker"
	end
end

modifier_terrorblade_innate_custom_tracker = class(mod_hidden)
function modifier_terrorblade_innate_custom_tracker:OnCreated()
	if not IsServer() then
		return
	end
	self.ability = self:GetAbility()
	self.parent = self:GetParent()

	self:StartIntervalThink(0.1)
end

function modifier_terrorblade_innate_custom_tracker:OnIntervalThink()
	if not IsServer() then
		return
	end
	if not self.parent.owner or self.parent.owner:IsNull() then
		return
	end

	self.parent:AddNewModifier(self.parent.owner, self.ability, "modifier_terrorblade_innate_custom", {})

	if not self.parent:HasModifier("modifier_terrorblade_innate_custom") then
		return
	end

	self:StartIntervalThink(-1)
end

modifier_terrorblade_innate_custom = class(mod_visible)
function modifier_terrorblade_innate_custom:IsHidden()
	return IsValid(self.parent) and self.parent:IsIllusion()
end
function modifier_terrorblade_innate_custom:RemoveOnDeath()
	return false
end
function modifier_terrorblade_innate_custom:IsAura()
	return self.ability.talents.has_w1 == 1
end
function modifier_terrorblade_innate_custom:GetAuraRadius()
	return self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") and self.ability.talents.w1_radius_meta
		or self.ability.talents.w1_radius
end
function modifier_terrorblade_innate_custom:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_terrorblade_innate_custom:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_terrorblade_innate_custom:GetModifierAura()
	return "modifier_terrorblade_innate_custom_aura_damage"
end
function modifier_terrorblade_innate_custom:OnCreated(table)
	self.parent = self:GetParent()
	self.parent:AddDeathEvent(self, true)

	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.ability.tracker = self
	self.ability:UpdateTalents()

	self.radius = self.ability:GetSpecialValueFor("radius")
	self.damage_inc = self.ability:GetSpecialValueFor("damage_inc") + self.ability.talents.w4_damage
	self.damage_reduce = self.ability:GetSpecialValueFor("damage_reduce")

	self.is_illusion = self.parent:IsIllusion()

	if not IsServer() then
		return
	end

	if self.ability.talents.has_w6 == 1 and self.parent:IsIllusion() then
		self.parent:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_terrorblade_innate_custom_damage_reduce",
			{ duration = self.ability.talents.w6_duration }
		)
	end

	if not self.parent:IsRealHero() then
		return
	end
	self.interval = 0.2
	self:OnIntervalThink()
	self:StartIntervalThink(self.interval)
end

function modifier_terrorblade_innate_custom:OnIntervalThink()
	if not IsServer() then
		return
	end
	self:SetStackCount(#self.parent:FindIllusions(self.radius))
end

function modifier_terrorblade_innate_custom:CheckState()
	if self.ability.talents.has_w6 == 0 then
		return
	end
	if not IsValid(self.parent) then
		return
	end
	if not self.parent:IsIllusion() then
		return
	end
	return {
		[MODIFIER_STATE_UNSLOWABLE] = true,
	}
end

function modifier_terrorblade_innate_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_terrorblade_innate_custom:DeathEvent(params)
	if not IsServer() then
		return
	end
	if params.unit ~= self.parent then
		return
	end
	if not self.parent:IsRealHero() then
		return
	end

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_terrorblade/terrorblade_death_custom.vpcf",
		PATTACH_CUSTOMORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		1,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetAbsOrigin(),
		true
	)
	if self.parent.current_model == "models/heroes/terrorblade/terrorblade_arcana.vmdl" then
		local color = self.parent:GetTerrorbladeColor()
		ParticleManager:SetParticleControl(particle, 15, color)
		ParticleManager:SetParticleControl(particle, 16, Vector(1, 0, 0))
	else
		ParticleManager:SetParticleControl(particle, 15, Vector(0, 152, 255))
		ParticleManager:SetParticleControl(particle, 16, Vector(1, 0, 0))
	end
	local parent = self.parent

	Timers:CreateTimer(FrameTime(), function()
		if not IsValid(parent) then
			return
		end
		if not parent:IsAlive() then
			return FrameTime()
		end

		ParticleManager:DestroyParticle(particle, true)
		ParticleManager:ReleaseParticleIndex(particle)
	end)
end

function modifier_terrorblade_innate_custom:GetModifierStatusResistanceStacking()
	if self.ability.talents.has_e6 == 0 then
		return
	end
	return self.ability.talents.e6_status
end

function modifier_terrorblade_innate_custom:GetModifierHealthBonus()
	return self.ability.talents.r2_health * self.parent:GetAgility()
end

function modifier_terrorblade_innate_custom:GetModifierAttackRangeBonus()
	local bonus = self.ability.talents.e2_range
	if self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
		bonus = bonus * self.ability.talents.e2_bonus
	end
	return bonus
end

function modifier_terrorblade_innate_custom:GetModifierBonusStats_Agility()
	local stack = self:GetStackCount()
	if self.is_illusion and IsValid(self.caster) then
		stack = self.caster:GetModifierStackCount("modifier_terrorblade_innate_custom", self.caster)
	end
	stack = math.min(stack, self.ability.talents.w4_max)
	return self.ability.talents.w4_agility * stack
end

function modifier_terrorblade_innate_custom:GetModifierMagicalResistanceBonus()
	if self.parent:IsIllusion() or self:GetStackCount() == 0 then
		return
	end
	return self.ability.talents.w3_magic
end

function modifier_terrorblade_innate_custom:GetModifierMoveSpeedBonus_Constant()
	if self.parent:IsRealHero() and self:GetStackCount() == 0 then
		return
	end
	return self.ability.talents.w3_move
end

function modifier_terrorblade_innate_custom:GetModifierIncomingDamage_Percentage(params)
	if not self.parent:IsIllusion() then
		return
	end
	if self.parent:HasModifier("modifier_terrorblade_innate_custom_damage_reduce") then
		return
	end
	if not params.damage_type then
		return
	end
	if params.damage_type ~= DAMAGE_TYPE_MAGICAL then
		return
	end

	return self.ability.talents.w3_magic * -1
end

function modifier_terrorblade_innate_custom:GetModifierTotalDamageOutgoing_Percentage(params)
	if not self.parent:IsIllusion() then
		return
	end
	if not params.target:IsUnit() then
		return
	end
	if params.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then
		return
	end
	if params.inflictor then
		return
	end

	local stack = self.damage_inc
	if (self.caster:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > self.radius then
		stack = self.damage_reduce
	end
	return stack
end

function modifier_terrorblade_innate_custom:GetModifierDamageOutgoing_Percentage(params)
	if not self.parent:IsIllusion() then
		return
	end
	if IsServer() then
		return
	end

	local stack = self.damage_inc
	if (self.caster:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > self.radius then
		stack = self.damage_reduce
	end
	return stack
end

modifier_terrorblade_innate_custom_aura_damage = class(mod_hidden)
function modifier_terrorblade_innate_custom_aura_damage:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_terrorblade_innate_custom_aura_damage:OnCreated(table)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	if self.caster.owner then
		self.caster = self.caster.owner
	end
	self.ability = self.caster:FindAbilityByName(self:GetAbility():GetName())

	self.parent:AddNewModifier(self.caster, self.ability, "modifier_terrorblade_innate_custom_aura_damage_count", {})
end

function modifier_terrorblade_innate_custom_aura_damage:OnDestroy()
	if not IsServer() then
		return
	end
	if not IsValid(self.parent) then
		return
	end
	local mod = self.parent:FindModifierByName("modifier_terrorblade_innate_custom_aura_damage_count")
	if not mod then
		return
	end

	mod:DecrementStackCount()
	if mod:GetStackCount() < 1 then
		mod:Destroy()
	end
end

modifier_terrorblade_innate_custom_aura_damage_count = class(mod_visible)
function modifier_terrorblade_innate_custom_aura_damage_count:GetTexture()
	return "buffs/illusion_burn"
end
function modifier_terrorblade_innate_custom_aura_damage_count:GetEffectName()
	return "particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave_burn.vpcf"
end
function modifier_terrorblade_innate_custom_aura_damage_count:OnCreated(table)
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.interval = self.ability.talents.w1_interval
	self.slow = self.ability.talents.w1_slow
	self.damage = self.ability.talents.w1_damage * self.interval

	if not IsServer() then
		return
	end

	self.damageTable =
		{ victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL }

	self:SetStackCount(1)
	self:StartIntervalThink(self.interval)
end

function modifier_terrorblade_innate_custom_aura_damage_count:OnIntervalThink()
	if not IsServer() then
		return
	end
	local damage = self.damage * self:GetStackCount()
	self.damageTable.damage = damage
	DoDamage(self.damageTable, "modifier_terror_illusion_1")
end

function modifier_terrorblade_innate_custom_aura_damage_count:OnRefresh(table)
	if not IsServer() then
		return
	end
	self:IncrementStackCount()
end

function modifier_terrorblade_innate_custom_aura_damage_count:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_terrorblade_innate_custom_aura_damage_count:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

modifier_terrorblade_innate_custom_damage_reduce = class(mod_hidden)
function modifier_terrorblade_innate_custom_damage_reduce:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if self.parent:IsRealHero() then
		self.damage_reduce = self.ability.talents.w6_damage_self
	else
		self.damage_reduce = self.ability.talents.w6_damage_reduce
	end

	if not IsServer() then
		return
	end
	self.effect = ParticleManager:CreateParticle(
		"particles/terrorblade/illusion_damage_reduce.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(
		self.effect,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		self.effect,
		1,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(self.effect, false, false, -1, false, false)
end

function modifier_terrorblade_innate_custom_damage_reduce:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_terrorblade_innate_custom_damage_reduce:GetModifierIncomingDamage_Percentage()
	return self.damage_reduce
end