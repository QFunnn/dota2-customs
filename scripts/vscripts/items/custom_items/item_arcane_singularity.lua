--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


item_arcane_singularity_1 = item_arcane_singularity_1 or class({})
item_arcane_singularity_2 = item_arcane_singularity_1 or class({})
item_arcane_singularity_3 = item_arcane_singularity_1 or class({})

LinkLuaModifier(
	"modifier_item_arcane_singularity",
	"items/custom_items/item_arcane_singularity.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_arcane_singularity_thinker",
	"items/custom_items/item_arcane_singularity.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_arcane_singularity_pull",
	"items/custom_items/item_arcane_singularity.lua",
	LUA_MODIFIER_MOTION_NONE
)

function item_arcane_singularity_1:Precache(context)
	PrecacheResource("particle", "particles/items_fx/dagon.vpcf", context)
	PrecacheResource("particle", "particles/items_fx/ethereal_blade.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_enigma/enigma_blackhole.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_enigma.vsndevts", context)
end

function item_arcane_singularity_1:GetIntrinsicModifierName()
	return "modifier_item_arcane_singularity"
end

function item_arcane_singularity_1:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if not target then
		return
	end

	-- Dagon-style cast FX
	caster:EmitSound("DOTA_Item.Dagon.Activate")

	ProjectileManager:CreateTrackingProjectile({
		Target = target,
		Source = caster,
		Ability = self,
		EffectName = "particles/items_fx/ethereal_blade.vpcf",
		iMoveSpeed = 1200,
		bDodgeable = true,
		bIsAttack = false,
		bVisibleToEnemies = true,
		bReplaceExisting = false,
		flExpireTime = GameRules:GetGameTime() + 10,
		bProvidesVision = false,
	})
end

function item_arcane_singularity_1:OnProjectileHit(target, location)
	if not IsServer() then
		return true
	end
	if not target or target:IsNull() then
		return true
	end

	-- Linken's / Lotus
	if target:TriggerSpellAbsorb(self) then
		return true
	end

	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

	CreateModifierThinker(
		caster,
		self,
		"modifier_item_arcane_singularity_thinker",
		{ duration = duration },
		target:GetAbsOrigin(),
		caster:GetTeamNumber(),
		false
	)

	target:EmitSound("Hero_Enigma.Black_Hole")
	return true
end

---------------------------------------------------------------------------------------------------

modifier_item_arcane_singularity = modifier_item_arcane_singularity or class({})

function modifier_item_arcane_singularity:IsHidden()
	return true
end
function modifier_item_arcane_singularity:IsPurgable()
	return false
end
function modifier_item_arcane_singularity:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_arcane_singularity:OnCreated()
	self.bonus_all_stats = self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_arcane_singularity:OnRefresh()
	self:OnCreated()
end

function modifier_item_arcane_singularity:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end

function modifier_item_arcane_singularity:GetModifierBonusStats_Strength()
	return self.bonus_all_stats or 0
end

function modifier_item_arcane_singularity:GetModifierBonusStats_Agility()
	return self.bonus_all_stats or 0
end

function modifier_item_arcane_singularity:GetModifierBonusStats_Intellect()
	return self.bonus_all_stats or 0
end

---------------------------------------------------------------------------------------------------

modifier_item_arcane_singularity_thinker = class({})

function modifier_item_arcane_singularity_thinker:OnCreated()
	if not IsServer() then
		return
	end
	self.radius = self:GetAbility():GetSpecialValueFor("radius")

	self:GetParent():EmitSound("Hero_Enigma.Black_Hole")

	local pfx = ParticleManager:CreateParticle(
		"particles/econ/items/enigma/enigma_world_chasm/enigma_blackhole_ti5.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(pfx, 0, self:GetParent():GetOrigin())
	self:AddParticle(pfx, false, false, -1, false, false)

	self:StartIntervalThink(0.1)
end

function modifier_item_arcane_singularity_thinker:OnIntervalThink()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not caster or caster:IsNull() or not caster:IsAlive() or caster:IsStunned() or caster:IsSilenced() then
		self:Destroy()
	end
end

function modifier_item_arcane_singularity_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	self:GetParent():StopSound("Hero_Enigma.Black_Hole")
	self:GetParent():EmitSound("Hero_Enigma.Black_Hole.Stop")
end

function modifier_item_arcane_singularity_thinker:IsAura()
	return true
end
function modifier_item_arcane_singularity_thinker:GetModifierAura()
	return "modifier_item_arcane_singularity_pull"
end
function modifier_item_arcane_singularity_thinker:GetAuraRadius()
	return self.radius
end
function modifier_item_arcane_singularity_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_item_arcane_singularity_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_item_arcane_singularity_thinker:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end

--------------------------------------------------------------------------------

modifier_item_arcane_singularity_pull = class({})

function modifier_item_arcane_singularity_pull:IsHidden()
	return false
end
function modifier_item_arcane_singularity_pull:IsStunDebuff()
	return true
end

function modifier_item_arcane_singularity_pull:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function modifier_item_arcane_singularity_pull:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

function modifier_item_arcane_singularity_pull:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_item_arcane_singularity_pull:OnCreated()
	if not IsServer() then
		return
	end
	self.pull_speed = 60
	self:StartIntervalThink(0.03)
end

function modifier_item_arcane_singularity_pull:OnIntervalThink()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()

	if parent:IsMagicImmune() then
		self:Destroy()
		return
	end

	local thinker = self:GetAuraOwner()
	if not thinker then
		return
	end

	local center = thinker:GetOrigin()
	local parent_pos = parent:GetOrigin()

	local direction = center - parent_pos
	local distance = direction:Length2D()
	direction = direction:Normalized()

	if distance > 20 then
		parent:SetOrigin(parent_pos + direction * self.pull_speed * 0.03)
	end

	local ability = self:GetAbility()
	local damage_base = ability:GetSpecialValueFor("damage")

	ApplyDamage({
		victim = parent,
		attacker = caster,
		damage = damage_base * 0.03,
		damage_type = DAMAGE_TYPE_PURE,
		ability = ability,
	})
end