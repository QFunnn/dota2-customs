--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_conjurers_catalyst_custom",
	"abilities/items/neutral/item_conjurers_catalyst_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_conjurers_catalyst_custom_burn",
	"abilities/items/neutral/item_conjurers_catalyst_custom",
	LUA_MODIFIER_MOTION_NONE
)

item_conjurers_catalyst_custom = class({})

function item_conjurers_catalyst_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_item_conjurers_catalyst_custom"
end

function item_conjurers_catalyst_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/items7_fx/misrule_focus.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_invoker/invoker_chaos_meteor_burn_debuff.vpcf", context)
end

function item_conjurers_catalyst_custom:Spawn()
	self.duration = self:GetSpecialValueFor("duration")
	self.damage = self:GetSpecialValueFor("damage")
	self.damage_health = self:GetSpecialValueFor("damage_health") / 100
	self.heal = self:GetSpecialValueFor("heal") / 100
	self.creeps_damage = self:GetSpecialValueFor("creeps_damage")
	self.radius = self:GetSpecialValueFor("radius")
end

modifier_item_conjurers_catalyst_custom = class(mod_hidden)
function modifier_item_conjurers_catalyst_custom:RemoveOnDeath()
	return false
end
function modifier_item_conjurers_catalyst_custom:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.parent:AddSpellEvent(self, true)
end

function modifier_item_conjurers_catalyst_custom:SpellEvent(params)
	if not IsServer() then
		return
	end
	if not IsValid(self.ability) then
		return
	end
	if not self.ability:IsFullyCastable() then
		return
	end
	if self.parent ~= params.unit then
		return
	end
	if not params.target then
		return
	end

	local target = params.target
	if not target:IsUnit() then
		return
	end
	if target:GetTeamNumber() == self.parent:GetTeamNumber() then
		return
	end

	target:EmitSound("item_searing_signet.activate")

	local hit_effect =
		ParticleManager:CreateParticle("particles/items7_fx/misrule_focus.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(
		hit_effect,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		false
	)
	ParticleManager:SetParticleControl(hit_effect, 1, Vector(self.ability.radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(hit_effect)

	for _, aoe_target in pairs(self.parent:FindTargets(self.ability.radius, target:GetAbsOrigin())) do
		aoe_target:RemoveModifierByName("modifier_item_conjurers_catalyst_custom_burn")
		aoe_target:AddNewModifier(self.parent, self.ability, "modifier_item_conjurers_catalyst_custom_burn", {})
	end

	self.ability:StartCd()
end

modifier_item_conjurers_catalyst_custom_burn = class(mod_hidden)
function modifier_item_conjurers_catalyst_custom_burn:IsPurgable()
	return true
end
function modifier_item_conjurers_catalyst_custom_burn:GetEffectName()
	return "particles/units/heroes/hero_invoker/invoker_chaos_meteor_burn_debuff.vpcf"
end
function modifier_item_conjurers_catalyst_custom_burn:GetStatusEffectName()
	return "particles/status_fx/status_effect_burn.vpcf"
end
function modifier_item_conjurers_catalyst_custom_burn:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end
function modifier_item_conjurers_catalyst_custom_burn:OnCreated()
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()
	self.parent = self:GetParent()

	self.damage = self.ability.damage
	self.damage_health = self.ability.damage_health
	self.count = self.ability.duration
	self.heal = self.ability.heal
	self.creeps_damage = self.ability.creeps_damage

	self.damageTable = {
		victim = self.parent,
		attacker = self.caster,
		ability = self.ability,
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
	}

	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
end

function modifier_item_conjurers_catalyst_custom_burn:OnIntervalThink()
	if not IsServer() then
		return
	end
	self.damageTable.damage = self.parent:IsCreep() and self.creeps_damage
		or self.damage + self.damage_health * self.parent:GetMaxHealth()
	local real_damage = DoDamage(self.damageTable)
	local result = self.caster:CanLifesteal(self.parent)
	if result then
		self.caster:GenericHeal(
			result * real_damage * self.heal,
			self.ability,
			true,
			"particles/items3_fx/octarine_core_lifesteal.vpcf"
		)
	end

	self.count = self.count - 1
	if self.count <= 0 then
		self:Destroy()
		return
	end
end