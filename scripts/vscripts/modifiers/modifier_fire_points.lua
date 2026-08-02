--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_fire_points = class({})

function modifier_fire_points:OnCreated(kv)
	if IsServer() then
		self:StartIntervalThink(0.1)
	end
end

function modifier_fire_points:IsHidden()
	return false
end

function modifier_fire_points:IsDebuff()
	return true
end

function modifier_fire_points:IsPurgable()
	return false
end

function modifier_fire_points:GetTexture()
	return "pit"
end

function modifier_fire_points:OnIntervalThink()
	if IsServer() then
		if self:GetParent():IsAlive() then
			local hAttacker = self:GetParent()
			local damageTable = {
				victim = self:GetParent(),
				attacker = hAttacker,
				damage = self:GetParent():GetMaxHealth() * 0.1,
				damage_type = DAMAGE_TYPE_PURE,
				damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
			}
			ParticleManager:CreateParticle(
				"particles/units/heroes/hero_ogre_magi/ogre_magi_ignite_trail_1.vpcf",
				PATTACH_ABSORIGIN,
				self:GetParent()
			)
			ApplyDamage(damageTable)
		end
	end
end