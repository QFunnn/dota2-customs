--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_golem_stun", "abilities/creeps_neutral/neutral_golem_stun", LUA_MODIFIER_MOTION_NONE)

neutral_golem_stun = class({})

function neutral_golem_stun:Precache(context)
	PrecacheResource("particle", "particles/neutral_fx/mud_golem_hurl_boulder.vpcf", context)
end

function neutral_golem_stun:GetIntrinsicModifierName()
	return "modifier_golem_stun"
end

function neutral_golem_stun:OnProjectileHit(target, location)
	if not IsServer() then
		return
	end
	if not target then
		return
	end
	if target:TriggerSpellAbsorb(self) then
		return
	end

	local damage = self.damage + target:GetMaxHealth() * self.damage_health / 100

	target:SendNumber(4, damage)
	target:EmitSound("n_mud_golem.Boulder.Target")
	target:AddNewModifier(
		self.caster,
		self,
		"modifier_stunned",
		{ duration = self.stun * (1 - target:GetStatusResistance()) }
	)

	DoDamage({
		victim = target,
		attacker = self.caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	})
end

modifier_golem_stun = class(mod_hidden)
function modifier_golem_stun:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.damage_health = self.ability:GetSpecialValueFor("damage_health")
	self.ability.stun = self.ability:GetSpecialValueFor("stun")
	self.ability.speed = self.ability:GetSpecialValueFor("speed")
end

function modifier_golem_stun:StartCast(target)
	if not IsServer() then
		return
	end
	self.target = target

	self.parent:EmitSound("n_mud_golem.Boulder.Cast")
	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_neutral_cast",
		{
			target = target and target:entindex() or nil,
			duration = 0.1,
			anim = ACT_DOTA_CAST_ABILITY_1,
			parent_mod = self:GetName(),
		}
	)
end

function modifier_golem_stun:EndCast()
	if not IsServer() then
		return
	end
	if not IsValid(self.target) or not self.target:IsAlive() then
		return
	end

	local info = {
		Target = self.target,
		Source = self.parent,
		Ability = self.ability,
		EffectName = "particles/neutral_fx/mud_golem_hurl_boulder.vpcf",
		iMoveSpeed = self.ability.speed,
		bReplaceExisting = false,
		bProvidesVision = true,
		iVisionRadius = 450,
		iVisionTeamNumber = self.parent:GetTeamNumber(),
	}
	ProjectileManager:CreateTrackingProjectile(info)
end