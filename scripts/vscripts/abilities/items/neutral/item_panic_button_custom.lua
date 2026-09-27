--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_panic_button_custom",
	"abilities/items/neutral/item_panic_button_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_panic_button_custom_reduce",
	"abilities/items/neutral/item_panic_button_custom",
	LUA_MODIFIER_MOTION_NONE
)

item_panic_button_custom = class({})

function item_panic_button_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/items5_fx/magic_lamp.vpcf", context)
	PrecacheResource("particle", "particles/items2_fx/vindicators_axe_armor.vpcf", context)
end

function item_panic_button_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_item_panic_button_custom"
end

function item_panic_button_custom:Spawn()
	self.health_threshold = self:GetSpecialValueFor("health_threshold")
	self.heal = self:GetSpecialValueFor("heal")
	self.duration = self:GetSpecialValueFor("duration")
	self.damage_reduce = self:GetSpecialValueFor("damage_reduce")
end

modifier_item_panic_button_custom = class(mod_hidden)
function modifier_item_panic_button_custom:RemoveOnDeath()
	return false
end
function modifier_item_panic_button_custom:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.health_threshold = self.ability.health_threshold
	self.heal = self.ability.heal
	self.duration = self.ability.duration

	self.parent:AddDamageEvent_inc(self, true)
end

function modifier_item_panic_button_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MIN_HEALTH,
	}
end

function modifier_item_panic_button_custom:GetMinHealth()
	if not self.ability:IsFullyCastable() then
		return
	end
	if self.parent:HasModifier("modifier_death") then
		return
	end
	if self.parent:LethalDisabled() then
		return
	end
	if not self.parent:IsAlive() then
		return
	end
	if self.parent:GetHealth() <= 0 then
		return
	end

	return 1
end

function modifier_item_panic_button_custom:DamageEvent_inc(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.unit then
		return
	end
	if not IsValid(self.ability) then
		return
	end
	if not self.ability:IsFullyCastable() then
		return
	end
	if self.parent:HasModifier("modifier_death") then
		return
	end
	if not self.parent:IsAlive() then
		return
	end
	if self.parent:GetHealthPercent() > self.health_threshold then
		return
	end

	self.parent:EmitSound("DOTA_Item.MagicLamp.Cast")

	local effect =
		ParticleManager:CreateParticle("particles/items5_fx/magic_lamp.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(
		effect,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(effect)

	self.parent:GenericHeal(self.heal, self.ability)
	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_item_panic_button_custom_reduce",
		{ duration = self.duration }
	)

	self.parent:Purge(false, true, false, true, true)
	self.ability:StartCd()
end

modifier_item_panic_button_custom_reduce = class(mod_hidden)
function modifier_item_panic_button_custom_reduce:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.damage_reduce = self.ability.damage_reduce
	if not IsServer() then
		return
	end
	self.parent:GenericParticle("particles/items2_fx/vindicators_axe_armor.vpcf", self)
end

function modifier_item_panic_button_custom_reduce:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_item_panic_button_custom_reduce:GetModifierIncomingDamage_Percentage()
	return self.damage_reduce
end