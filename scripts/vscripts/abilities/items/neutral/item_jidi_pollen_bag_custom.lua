--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_jidi_pollen_bag_custom_burn",
	"abilities/items/neutral/item_jidi_pollen_bag_custom",
	LUA_MODIFIER_MOTION_NONE
)

item_jidi_pollen_bag_custom = class({})

function item_jidi_pollen_bag_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/items5_fx/jidi_pollen_bag.vpcf", context)
	PrecacheResource("particle", "particles/items5_fx/jidi_pollen_bag_debuff.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_jidi_pollen_bag.vpcf", context)
end

function item_jidi_pollen_bag_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_item_jidi_pollen_bag_custom"
end

function item_jidi_pollen_bag_custom:Spawn()
	self.debuff_radius = self:GetSpecialValueFor("debuff_radius")
	self.debuff_duration = self:GetSpecialValueFor("debuff_duration")
	self.health_regen_loss = self:GetSpecialValueFor("health_regen_loss")
	self.damage_interval = self:GetSpecialValueFor("damage_interval")
	self.hp_damage = self:GetSpecialValueFor("hp_damage")
	self.damage_creeps = self:GetSpecialValueFor("damage_creeps")
end

function item_jidi_pollen_bag_custom:OnSpellStart()
	local caster = self:GetCaster()
	local radius = self.debuff_radius
	local duration = self.debuff_duration

	local particle_start =
		ParticleManager:CreateParticle("particles/items5_fx/jidi_pollen_bag.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle_start, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_start, 1, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(particle_start)

	caster:EmitSound("item_jidi_pollen.activate")

	for _, target in pairs(caster:FindTargets(radius)) do
		target:AddNewModifier(caster, self, "modifier_item_jidi_pollen_bag_custom_burn", { duration = duration })
	end
end

modifier_item_jidi_pollen_bag_custom_burn = class(mod_visible)
function modifier_item_jidi_pollen_bag_custom_burn:IsPurgable()
	return true
end
function modifier_item_jidi_pollen_bag_custom_burn:GetStatusEffectName()
	return "particles/status_fx/status_effect_jidi_pollen_bag.vpcf"
end
function modifier_item_jidi_pollen_bag_custom_burn:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end
function modifier_item_jidi_pollen_bag_custom_burn:OnCreated()
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()
	self.parent = self:GetParent()

	self.heal_reduce = self.ability.health_regen_loss

	self.duration = self.ability.debuff_duration
	self.interval = self.ability.damage_interval
	self.damage = (self.ability.hp_damage / (self.duration + 1)) * self.interval

	if self.parent:IsCreep() then
		self.damage = (self.ability.damage_creeps / (self.duration + 1)) * self.interval
	end

	self.damageTable =
		{ victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL }

	if not IsServer() then
		return
	end
	self.parent:GenericParticle("particles/items5_fx/jidi_pollen_bag_debuff.vpcf", self)
	self:OnIntervalThink()
	self:StartIntervalThink(self.interval - FrameTime())
end

function modifier_item_jidi_pollen_bag_custom_burn:OnIntervalThink()
	if not IsServer() then
		return
	end

	local damage = self.parent:IsHero() and self.damage * self.parent:GetMaxHealth() / 100 or self.damage
	self.damageTable.damage = damage
	self.parent:SendNumber(4, damage)
	DoDamage(self.damageTable)
end

function modifier_item_jidi_pollen_bag_custom_burn:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}
end

function modifier_item_jidi_pollen_bag_custom_burn:GetModifierLifestealRegenAmplify_Percentage()
	return self.heal_reduce
end

function modifier_item_jidi_pollen_bag_custom_burn:GetModifierHealChange()
	return self.heal_reduce
end

function modifier_item_jidi_pollen_bag_custom_burn:GetModifierHPRegenAmplify_Percentage()
	return self.heal_reduce
end