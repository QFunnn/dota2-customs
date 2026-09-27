--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


neutral_golem_stun_active = class({})

function neutral_golem_stun_active:Precache(context)
	PrecacheResource("particle", "particles/neutral_fx/mud_golem_hurl_boulder.vpcf", context)
end

function neutral_golem_stun_active:OnSpellStart()
	self.damage = self:GetSpecialValueFor("damage")
	self.damage_health = self:GetSpecialValueFor("damage_health")
	self.stun = self:GetSpecialValueFor("stun")

	self.caster:EmitSound("n_mud_golem.Boulder.Cast")

	local info = {
		Target = self:GetCursorTarget(),
		Source = self.caster,
		Ability = self,
		EffectName = "particles/neutral_fx/mud_golem_hurl_boulder.vpcf",
		iMoveSpeed = self:GetSpecialValueFor("speed"),
		bReplaceExisting = false,
		bProvidesVision = true,
		iVisionRadius = 450,
		iVisionTeamNumber = self.caster:GetTeamNumber(),
	}
	ProjectileManager:CreateTrackingProjectile(info)
end

function neutral_golem_stun_active:OnProjectileHit(target, location)
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
	target:AddNewModifier(self.caster, self, "modifier_stunned", { duration = self.stun })

	DoDamage({
		victim = target,
		attacker = self.caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	})
end