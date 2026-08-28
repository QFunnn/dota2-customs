--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_hallowed_ground", "items/custom_items/item_hallowed_ground", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_item_hallowed_ground_aura_emitter",
	"items/custom_items/item_hallowed_ground",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_hallowed_ground_aura",
	"items/custom_items/item_hallowed_ground",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_hallowed_ground_thinker",
	"items/custom_items/item_hallowed_ground",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_hallowed_ground_zone_aura",
	"items/custom_items/item_hallowed_ground",
	LUA_MODIFIER_MOTION_NONE
)

item_hallowed_ground_1 = item_hallowed_ground_1 or class({})
item_hallowed_ground_2 = item_hallowed_ground_1 or class({})
item_hallowed_ground_3 = item_hallowed_ground_1 or class({})

function item_hallowed_ground_1:Precache(context)
	PrecacheResource("particle", "particles/items2_fx/pipe_of_insight.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_witchdoctor/witchdoctor_voodoo_restoration.vpcf", context)
	PrecacheResource("soundfile", "sounds/items/pipe.vsnd", context)
end

function item_hallowed_ground_1:GetIntrinsicModifierName()
	return "modifier_item_hallowed_ground"
end

function item_hallowed_ground_1:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

	EmitSoundOn("DOTA_Item.Pipe.Activate", caster)

	CreateModifierThinker(
		caster,
		self,
		"modifier_item_hallowed_ground_thinker",
		{ duration = duration },
		caster:GetAbsOrigin(),
		caster:GetTeamNumber(),
		false
	)
end

---------------------------------------------------------------------------------------------------

modifier_item_hallowed_ground = class({})

function modifier_item_hallowed_ground:IsHidden()
	return true
end
function modifier_item_hallowed_ground:IsPurgable()
	return false
end
function modifier_item_hallowed_ground:RemoveOnDeath()
	return false
end
function modifier_item_hallowed_ground:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_hallowed_ground:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	self.bonus_movement = ability:GetSpecialValueFor("bonus_movement")
	self.bonus_mana = ability:GetSpecialValueFor("bonus_mana")
	self.bonus_armor = ability:GetSpecialValueFor("bonus_armor")
	self.health_regen = ability:GetSpecialValueFor("health_regen")
	self.magic_resistance = ability:GetSpecialValueFor("magic_resistance")

	if IsServer() then
		local parent = self:GetParent()
		if parent then
			parent:AddNewModifier(parent, ability, "modifier_item_hallowed_ground_aura_emitter", {})
		end
	end
end

function modifier_item_hallowed_ground:OnRefresh()
	self:OnCreated()
end

function modifier_item_hallowed_ground:OnDestroy()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent then
		return
	end

	if not parent:HasModifier("modifier_item_hallowed_ground") then
		parent:RemoveModifierByName("modifier_item_hallowed_ground_aura_emitter")
	end
end

function modifier_item_hallowed_ground:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_item_hallowed_ground:GetModifierMoveSpeedBonus_Special_Boots()
	return self.bonus_movement
end
function modifier_item_hallowed_ground:GetModifierManaBonus()
	return self.bonus_mana
end
function modifier_item_hallowed_ground:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end
function modifier_item_hallowed_ground:GetModifierConstantHealthRegen()
	return self.health_regen
end
function modifier_item_hallowed_ground:GetModifierMagicalResistanceBonus()
	return self.magic_resistance
end

modifier_item_hallowed_ground_thinker = class({})

function modifier_item_hallowed_ground_thinker:IsHidden()
	return true
end
function modifier_item_hallowed_ground_thinker:IsPurgable()
	return false
end

function modifier_item_hallowed_ground_thinker:OnCreated()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	-- Stores remaining spell barrier per unit while this zone exists.
	-- Key: unit:entindex() -> remaining barrier value
	self._zone_barrier_remaining = {}

	local radius = ability:GetSpecialValueFor("radius")
	-- local duration = self:GetDuration()
	self.mainParticle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_witchdoctor/witchdoctor_voodoo_restoration.vpcf",
		PATTACH_POINT_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		self.mainParticle,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_staff",
		self:GetParent():GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(self.mainParticle, 1, Vector(radius, radius, radius))
	ParticleManager:SetParticleControlEnt(
		self.mainParticle,
		2,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_staff",
		self:GetParent():GetAbsOrigin(),
		true
	)
end

function modifier_item_hallowed_ground_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	self._zone_barrier_remaining = nil
end

function modifier_item_hallowed_ground_thinker:IsAura()
	return true
end
function modifier_item_hallowed_ground_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_item_hallowed_ground_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_item_hallowed_ground_thinker:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_item_hallowed_ground_thinker:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("radius")
end
function modifier_item_hallowed_ground_thinker:GetModifierAura()
	return "modifier_item_hallowed_ground_zone_aura"
end

---------------------------------------------------------------------------------------------------

modifier_item_hallowed_ground_aura_emitter = class({})
function modifier_item_hallowed_ground_aura_emitter:IsAura()
	return true
end
function modifier_item_hallowed_ground_aura_emitter:IsHidden()
	return true
end
function modifier_item_hallowed_ground_aura_emitter:IsDebuff()
	return false
end
function modifier_item_hallowed_ground_aura_emitter:IsPurgable()
	return false
end

function modifier_item_hallowed_ground_aura_emitter:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	self.aura_radius = ability:GetSpecialValueFor("aura_radius")
end

function modifier_item_hallowed_ground_aura_emitter:OnRefresh()
	self:OnCreated()
end

function modifier_item_hallowed_ground_aura_emitter:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_item_hallowed_ground_aura_emitter:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_item_hallowed_ground_aura_emitter:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_item_hallowed_ground_aura_emitter:GetAuraRadius()
	return self.aura_radius or 0
end
function modifier_item_hallowed_ground_aura_emitter:GetModifierAura()
	return "modifier_item_hallowed_ground_aura"
end

---------------------------------------------------------------------------------------------------

modifier_item_hallowed_ground_aura = class({})
function modifier_item_hallowed_ground_aura:IsHidden()
	return false
end
function modifier_item_hallowed_ground_aura:IsPurgable()
	return false
end

function modifier_item_hallowed_ground_aura:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	self.aura_health_regen = ability:GetSpecialValueFor("aura_health_regen")
	self.aura_armor = ability:GetSpecialValueFor("aura_armor")
	self.aura_health_regen_bonus = ability:GetSpecialValueFor("aura_health_regen_bonus")
	self.aura_armor_bonus = ability:GetSpecialValueFor("aura_armor_bonus")
	self.aura_bonus_threshold = ability:GetSpecialValueFor("aura_bonus_threshold")
	self.magic_resistance_aura = ability:GetSpecialValueFor("magic_resistance_aura")
end

function modifier_item_hallowed_ground_aura:OnRefresh()
	self:OnCreated()
end

function modifier_item_hallowed_ground_aura:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_item_hallowed_ground_aura:GetModifierMagicalResistanceBonus()
	return self.magic_resistance_aura
end

function modifier_item_hallowed_ground_aura:GetModifierPhysicalArmorBonus()
	local owner = self:GetParent()
	if owner and owner:IsRealHero() then
		local bonus_power = (1 - math.max(owner:GetHealthPercent() or 100, self.aura_bonus_threshold) * 0.01)
			/ (1 - self.aura_bonus_threshold * 0.01)
		return self.aura_armor + (self.aura_armor_bonus - self.aura_armor) * bonus_power
	end
	return self.aura_armor
end

function modifier_item_hallowed_ground_aura:GetModifierConstantHealthRegen()
	local owner = self:GetParent()
	if owner and owner:IsRealHero() then
		local bonus_power = (1 - math.max(owner:GetHealthPercent() or 100, self.aura_bonus_threshold) * 0.01)
			/ (1 - self.aura_bonus_threshold * 0.01)
		return self.aura_health_regen + (self.aura_health_regen_bonus - self.aura_health_regen) * bonus_power
	end
	return self.aura_health_regen
end

---------------------------------------------------------------------------------------------------

modifier_item_hallowed_ground_zone_aura = class({})

function modifier_item_hallowed_ground_zone_aura:IsHidden()
	return false
end
function modifier_item_hallowed_ground_zone_aura:IsPurgable()
	return false
end

function modifier_item_hallowed_ground_zone_aura:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	self.barrier_block_total = ability:GetSpecialValueFor("barrier_block")
	self.regen_per_ally_pct = ability:GetSpecialValueFor("regen_per_ally_pct")
	self.radius = ability:GetSpecialValueFor("radius")

	self.particle = ParticleManager:CreateParticle(
		"particles/items2_fx/pipe_of_insight.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(self.particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(
		self.particle,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_origin",
		self:GetParent():GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(self.particle, 2, Vector(self:GetParent():GetModelRadius() * 1.2, 0, 0))
	self:AddParticle(self.particle, false, false, -1, false, false)

	if IsServer() then
		local thinker = self:GetAuraOwner()
		if thinker then
			local thinker_mod = thinker:FindModifierByName("modifier_item_hallowed_ground_thinker")
			if thinker_mod and thinker_mod._zone_barrier_remaining then
				local idx = self:GetParent():entindex()
				if thinker_mod._zone_barrier_remaining[idx] == nil then
					thinker_mod._zone_barrier_remaining[idx] = self.barrier_block_total
				end
			end
		end
		self:StartIntervalThink(0.25)
	end
end

function modifier_item_hallowed_ground_zone_aura:OnRefresh()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	-- Do not reset barrier remaining on refresh/reapply.
	self.barrier_block_total = ability:GetSpecialValueFor("barrier_block")
	self.regen_per_ally_pct = ability:GetSpecialValueFor("regen_per_ally_pct")
	self.radius = ability:GetSpecialValueFor("radius")
end

function modifier_item_hallowed_ground_zone_aura:OnIntervalThink()
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not parent or not caster then
		return
	end

	local origin = nil
	local thinker = self:GetAuraOwner()
	if thinker then
		origin = thinker:GetAbsOrigin()
	else
		origin = parent:GetAbsOrigin()
	end

	local allies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	self:SetStackCount(#allies)
end

function modifier_item_hallowed_ground_zone_aura:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	}
end

function modifier_item_hallowed_ground_zone_aura:OnTooltip()
	if not IsServer() then
		return self.barrier_block_total or 0
	end

	local thinker = self:GetAuraOwner()
	if not thinker then
		return self.barrier_block_total or 0
	end
	local thinker_mod = thinker:FindModifierByName("modifier_item_hallowed_ground_thinker")
	if not thinker_mod or not thinker_mod._zone_barrier_remaining then
		return self.barrier_block_total or 0
	end

	local idx = self:GetParent():entindex()
	local remaining = thinker_mod._zone_barrier_remaining[idx]
	if remaining == nil then
		remaining = self.barrier_block_total or 0
		thinker_mod._zone_barrier_remaining[idx] = remaining
	end
	return remaining
end

function modifier_item_hallowed_ground_zone_aura:GetModifierHealthRegenPercentage()
	return (self.regen_per_ally_pct or 0) * self:GetStackCount()
end

function modifier_item_hallowed_ground_zone_aura:GetModifierIncomingSpellDamageConstant(keys)
	if not IsServer() then
		return 0
	end
	if keys.damage_type ~= DAMAGE_TYPE_MAGICAL then
		return 0
	end
	local thinker = self:GetAuraOwner()
	if not thinker then
		return 0
	end
	local thinker_mod = thinker:FindModifierByName("modifier_item_hallowed_ground_thinker")
	if not thinker_mod or not thinker_mod._zone_barrier_remaining then
		return 0
	end

	local idx = self:GetParent():entindex()
	local remaining = thinker_mod._zone_barrier_remaining[idx]
	if remaining == nil then
		remaining = self.barrier_block_total or 0
	end
	if remaining <= 0 then
		thinker_mod._zone_barrier_remaining[idx] = 0
		return 0
	end

	if keys.original_damage >= remaining then
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_MAGICAL_BLOCK, self:GetParent(), remaining, nil)
		thinker_mod._zone_barrier_remaining[idx] = 0
		return remaining * -1
	else
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_MAGICAL_BLOCK, self:GetParent(), keys.original_damage, nil)
		thinker_mod._zone_barrier_remaining[idx] = remaining - keys.original_damage
		return keys.original_damage * -1
	end
end