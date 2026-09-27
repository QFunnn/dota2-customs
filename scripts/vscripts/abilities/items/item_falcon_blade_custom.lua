--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_falcon_blade_custom",
	"abilities/items/item_falcon_blade_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_falcon_blade_custom_active",
	"abilities/items/item_falcon_blade_custom",
	LUA_MODIFIER_MOTION_HORIZONTAL
)

item_falcon_blade_custom = class({})

function item_falcon_blade_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/items_fx/force_staff.vpcf", context)
	PrecacheResource("particle", "particles/falcon_blade_charge.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_forcestaff.vpcf", context)
end

function item_falcon_blade_custom:GetIntrinsicModifierName()
	return "modifier_item_falcon_blade_custom"
end

function item_falcon_blade_custom:Spawn()
	self.range = self:GetSpecialValueFor("range")
	self.duration = self:GetSpecialValueFor("duration")
	self.bonus_health = self:GetSpecialValueFor("bonus_health")
	self.bonus_mana_regen = self:GetSpecialValueFor("bonus_mana_regen")
	self.bonus_damage = self:GetSpecialValueFor("bonus_damage")
	self.damage_cd = self:GetSpecialValueFor("damage_cd")
end

function item_falcon_blade_custom:OnAbilityPhaseStart()
	if self:GetCaster():IsStunned() then
		return false
	end

	return true
end

function item_falcon_blade_custom:GetCastRange(vLocation, hTarget)
	if IsClient() then
		return self.range
	end
	return 99999
end

function item_falcon_blade_custom:OnSpellStart()
	if not IsServer() then
		return
	end

	local point = self:GetCaster():GetCursorPosition()
	if point == self:GetCaster():GetAbsOrigin() then
		point = self:GetCaster():GetForwardVector() * 10 + self:GetCaster():GetAbsOrigin()
	end

	self:GetCaster():FacePoint(point)

	ProjectileManager:ProjectileDodge(self:GetCaster())

	self:GetCaster():EmitSound("Item.Falcon_blade")
	self:GetCaster():AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_item_falcon_blade_custom_active",
		{ x = point.x, y = point.y, z = point.z, duration = self.duration }
	)
end

modifier_item_falcon_blade_custom_active = class(mod_hidden)
function modifier_item_falcon_blade_custom_active:IsDebuff()
	return false
end
function modifier_item_falcon_blade_custom_active:IsPurgable()
	return true
end
function modifier_item_falcon_blade_custom_active:GetEffectName()
	return "particles/falcon_blade_charge.vpcf"
end
function modifier_item_falcon_blade_custom_active:GetStatusEffectName()
	return "particles/status_fx/status_effect_forcestaff.vpcf"
end
function modifier_item_falcon_blade_custom_active:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end
function modifier_item_falcon_blade_custom_active:OnCreated(kv)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	self.pfx =
		ParticleManager:CreateParticle("particles/items_fx/force_staff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	self.parent:StartGesture(ACT_DOTA_RUN)

	self.point = Vector(kv.x, kv.y, kv.z)

	self.angle = self.parent:GetForwardVector():Normalized()

	self.distance = self.ability.range / (self:GetDuration() / FrameTime())

	self.targets = {}

	if self:ApplyHorizontalMotionController() == false then
		self:Destroy()
	end
end

function modifier_item_falcon_blade_custom_active:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_DISABLE_TURNING,
	}
end

function modifier_item_falcon_blade_custom_active:GetActivityTranslationModifiers()
	return "haste"
end

function modifier_item_falcon_blade_custom_active:GetModifierDisableTurning()
	return 1
end

function modifier_item_falcon_blade_custom_active:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:InterruptMotionControllers(true)
	ParticleManager:Delete(self.pfx, 1)

	self.parent:FadeGesture(ACT_DOTA_RUN)

	self.parent:FacePoint()

	ResolveNPCPositions(self.parent:GetAbsOrigin(), 128)
end

function modifier_item_falcon_blade_custom_active:UpdateHorizontalMotion(me, dt)
	if not IsServer() then
		return
	end
	local pos = self.parent:GetAbsOrigin()
	GridNav:DestroyTreesAroundPoint(pos, 80, false)
	local pos_p = self.angle * self.distance
	local next_pos = GetGroundPosition(pos + pos_p, self.parent)
	self.parent:SetAbsOrigin(next_pos)
end

function modifier_item_falcon_blade_custom_active:OnHorizontalMotionInterrupted()
	self:Destroy()
end

modifier_item_falcon_blade_custom = class(mod_hidden)
function modifier_item_falcon_blade_custom:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_item_falcon_blade_custom:OnCreated()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()

	self.bonus_health = self.ability.bonus_health
	self.bonus_mana_regen = self.ability.bonus_mana_regen
	self.bonus_damage = self.ability.bonus_damage
	self.damage_cd = self.ability.damage_cd

	if self.parent:IsRealHero() then
		self.parent:AddDamageEvent_inc(self, true)
	end
end

function modifier_item_falcon_blade_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	}
end

function modifier_item_falcon_blade_custom:GetModifierHealthBonus()
	return self.bonus_health
end

function modifier_item_falcon_blade_custom:GetModifierConstantManaRegen()
	return self.bonus_mana_regen
end

function modifier_item_falcon_blade_custom:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_item_falcon_blade_custom:DamageEvent_inc(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.unit then
		return
	end
	if self.parent == params.attacker then
		return
	end
	if not params.attacker:IsRealHero() and not params.attacker:IsIllusion() then
		return
	end
	if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then
		return
	end
	if params.damage < 5 then
		return
	end
	if not IsValid(self.ability) then
		return
	end
	if self.ability:GetCooldownTime() > self.damage_cd then
		return
	end

	self.ability:EndCd(0)
	self.ability:StartCooldown(self.damage_cd)
end