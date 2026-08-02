--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_acid_damage = class({})

function modifier_acid_damage:OnCreated(kv)
	if IsServer() then
		self:StartIntervalThink(0.1)
	end
end

function modifier_acid_damage:IsHidden()
	return false
end
function modifier_acid_damage:IsDebuff()
	return true
end

function modifier_acid_damage:GetTexture()
	return "acid2"
end

function modifier_acid_damage:IsPurgable()
	return false
end

function modifier_acid_damage:OnIntervalThink()
	if IsServer() then
		if self:GetParent():IsAlive() then
			local hAttacker = self:GetParent()
			local damageTable = {
				victim = self:GetParent(),
				attacker = hAttacker,
				damage = self:GetParent():GetMaxHealth() * 0.02,
				damage_type = DAMAGE_TYPE_PURE,
				damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
			}
			local pfx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_venomancer/venomancer_loadout.vpcf",
				PATTACH_ABSORIGIN,
				self:GetParent()
			)
			ParticleManager:ReleaseParticleIndex(pfx)
			ApplyDamage(damageTable)
		end
	end
end