--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_ultimate_enigma_black_hole_thinker = class({})

function modifier_ultimate_enigma_black_hole_thinker:IsHidden()
	return true
end
function modifier_ultimate_enigma_black_hole_thinker:IsPurgable()
	return false
end

function modifier_ultimate_enigma_black_hole_thinker:OnCreated()
	if not IsServer() then
		return
	end
	self.particle = LevelUpParticleManager:CreateParticle(
		"particles/units/heroes/hero_enigma/enigma_blackhole.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	LevelUpParticleManager:SetParticleControl(self.particle, 0, self:GetParent():GetAbsOrigin())
	EmitSoundOn("LevelUp.Black_Hole", self:GetParent())
end

function modifier_ultimate_enigma_black_hole_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	StopSoundOn("LevelUp.Black_Hole", self:GetParent())
	EmitSoundOn("LevelUp.Black_Hole.Stop", self:GetParent())
	if self.particle then
		LevelUpParticleManager:DestroyParticle(self.particle, false)
		LevelUpParticleManager:ReleaseParticleIndex(self.particle)
		self.particle = nil
	end
	UTIL_Remove(self:GetParent())
end