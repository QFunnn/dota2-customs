--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_huskar_lowhp", "abilities/creeps_lane/npc_huskar_lowhp", LUA_MODIFIER_MOTION_NONE)

npc_huskar_lowhp = class({})

function npc_huskar_lowhp:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_huskar/huskar_berserkers_blood.vpcf", context)
end

function npc_huskar_lowhp:GetIntrinsicModifierName()
	return "modifier_huskar_lowhp"
end

modifier_huskar_lowhp = class(mod_hidden)
function modifier_huskar_lowhp:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.health = self.ability:GetSpecialValueFor("health")
	self.ability.speed = self.ability:GetSpecialValueFor("speed")
	self.ability.armor = self.ability:GetSpecialValueFor("armor")
	self.ability.heal = self.ability:GetSpecialValueFor("heal") / 100

	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.25)
end

function modifier_huskar_lowhp:OnIntervalThink()
	if not IsServer() then
		return
	end

	if self.parent:GetHealthPercent() <= self.ability.health then
		if self.particle then
			return
		end
		self.particle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_huskar/huskar_berserkers_blood.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		ParticleManager:SetParticleControl(self.particle, 1, Vector(50, 0, 0))
		self.parent:SetRenderColor(255, 40, 40)
	elseif self.particle then
		ParticleManager:Delete(self.particle, 1)
		self.particle = nil
		self.parent:SetRenderColor(255, 255, 255)
	end
end

function modifier_huskar_lowhp:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
end

function modifier_huskar_lowhp:GetModifierAttackSpeedBonus_Constant()
	if self.parent:GetHealthPercent() > self.ability.health then
		return
	end
	return self.ability.speed
end

function modifier_huskar_lowhp:GetModifierPhysicalArmorBonus()
	if self.parent:GetHealthPercent() > self.ability.health then
		return
	end
	return self.ability.armor
end

function modifier_huskar_lowhp:GetModifierModelScale()
	if self.parent:GetHealthPercent() > self.ability.health then
		return
	end
	return 30
end

function modifier_huskar_lowhp:GetModifierProcAttack_Feedback(params)
	if not IsServer() then
		return
	end
	if self.parent:GetHealthPercent() > self.ability.health then
		return
	end

	self.parent:GenericHeal(self.parent:GetMaxHealth() * self.ability.heal, self.ability, true)
end

function modifier_huskar_lowhp:OnTooltip()
	return self.ability.speed
end

function modifier_huskar_lowhp:OnTooltip2()
	return self.ability.armor
end