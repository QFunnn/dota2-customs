--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


modifier_generic_silence_lua = class({})

function modifier_generic_silence_lua:IsDebuff()
	return true
end
function modifier_generic_silence_lua:IsPurgable()
	return true
end

function modifier_generic_silence_lua:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.particle = LevelUpParticleManager:CreateParticle(
		"particles/generic_gameplay/generic_silenced.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
end

function modifier_generic_silence_lua:OnDestroy()
	if not IsServer() then
		return
	end
	if self.particle then
		LevelUpParticleManager:DestroyParticle(self.particle, false)
		LevelUpParticleManager:ReleaseParticleIndex(self.particle)
		self.particle = nil
	end
end

function modifier_generic_silence_lua:CheckState()
	return {
		[MODIFIER_STATE_SILENCED] = true,
	}
end