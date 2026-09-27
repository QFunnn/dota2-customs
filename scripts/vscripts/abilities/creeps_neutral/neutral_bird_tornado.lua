--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bird_tornado", "abilities/creeps_neutral/neutral_bird_tornado", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tornado_think", "abilities/creeps_neutral/neutral_bird_tornado", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_tornado_think_slow",
	"abilities/creeps_neutral/neutral_bird_tornado",
	LUA_MODIFIER_MOTION_NONE
)

neutral_bird_tornado = class({})

function neutral_bird_tornado:Precache(context)
	PrecacheResource("particle", "particles/creatures/enraged_wildkin/enraged_wildkin_tornado.vpcf", context)
end

function neutral_bird_tornado:GetIntrinsicModifierName()
	if not self:GetCaster():IsCreep() then
		return
	end
	return "modifier_bird_tornado"
end

modifier_bird_tornado = class(mod_hidden)
function modifier_bird_tornado:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.damage_health = self.ability:GetSpecialValueFor("damage_health")
	self.ability.health = self.ability:GetSpecialValueFor("health")
	self.ability.aoe = self.ability:GetSpecialValueFor("aoe")
	self.ability.slow = self.ability:GetSpecialValueFor("slow")
end

function modifier_bird_tornado:StartCast(target)
	if not IsServer() then
		return
	end

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_neutral_cast",
		{
			target = target and target:entindex() or nil,
			duration = 0.4,
			anim = ACT_DOTA_CAST_ABILITY_1,
			parent_mod = self:GetName(),
		}
	)
end

function modifier_bird_tornado:EndCast()
	if not IsServer() then
		return
	end

	self.parent:EmitSound("n_creep_Wildkin.SummonTornado")

	local tornado = CreateUnitByName(
		"npc_dota_enraged_wildkin_tornado",
		self.parent:GetAbsOrigin() + self.parent:GetForwardVector() * 250,
		true,
		nil,
		nil,
		DOTA_TEAM_NEUTRALS
	)
	tornado:SetOwner(self.parent)
	tornado:AddNewModifier(tornado, self.ability, "modifier_kill", { duration = self.ability.duration })
	tornado:AddNewModifier(tornado, self.ability, "modifier_tornado_think", {})
end

modifier_tornado_think = class(mod_hidden)
function modifier_tornado_think:GetAbsoluteNoDamageMagical()
	return 1
end
function modifier_tornado_think:GetAbsoluteNoDamagePhysical()
	return 1
end
function modifier_tornado_think:GetAbsoluteNoDamagePure()
	return 1
end
function modifier_tornado_think:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.damage = self.ability.damage
	self.damage_health = self.ability.damage_health
	self.health = self.ability.health
	self.aoe = self.ability.aoe
	self.interval = 0.2

	self.parent:AddAttackEvent_inc(self, true)
	self.parent:GenericParticle("particles/creatures/enraged_wildkin/enraged_wildkin_tornado.vpcf", self)

	self:StartIntervalThink(self.interval)
end

function modifier_tornado_think:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_tornado_think:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
	}
end

function modifier_tornado_think:AttackEvent_inc(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.target then
		return
	end

	self.health = self.health - 1

	if self.health <= 0 then
		self.parent:Kill(nil, params.attacker)
	else
		self.parent:SetHealth(self.health)
	end
end

function modifier_tornado_think:OnIntervalThink()
	if not IsServer() then
		return
	end

	for _, target in pairs(self.parent:FindTargets(self.aoe)) do
		DoDamage({
			victim = target,
			attacker = self.parent,
			damage = (self.damage + target:GetMaxHealth() * self.damage_health / 100) * self.interval,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self.ability,
		})
		target:AddNewModifier(self.parent, self.ability, "modifier_tornado_think_slow", { duration = 0.5 })
	end
end

modifier_tornado_think_slow = class(mod_visible)
function modifier_tornado_think_slow:IsPurgable()
	return true
end
function modifier_tornado_think_slow:GetTexture()
	return "enraged_wildkin_tornado"
end
function modifier_tornado_think_slow:OnCreated()
	self.ability = self:GetAbility()
	if not self.ability then
		return
	end

	self.slow = self.ability.slow
end

function modifier_tornado_think_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_tornado_think_slow:GetModifierAttackSpeedBonus_Constant()
	return self.slow
end