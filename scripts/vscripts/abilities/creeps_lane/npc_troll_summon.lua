--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


npc_troll_summon = class({})

function npc_troll_summon:Precache(context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_has_quest.vpcf", context)
end

function npc_troll_summon:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.total = self:GetLevelSpecialValueFor("total", 1)
end

function npc_troll_summon:OnAbilityPhaseStart()
	self.sign = ParticleManager:CreateParticle(
		"particles/generic_gameplay/generic_has_quest.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self.caster
	)
	self.caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 0.75)
	return true
end

function npc_troll_summon:OnAbilityPhaseInterrupted()
	ParticleManager:Delete(self.sign, 2)
	self.caster:RemoveGesture(ACT_DOTA_CAST_ABILITY_2)
end

function npc_troll_summon:OnSpellStart()
	ParticleManager:Delete(self.sign, 2)

	self.caster:EmitSound("n_creep_TrollWarlord.RaiseDead")

	for i = 1, self.total do
		local skeleton =
			CreateUnitByName("npc_troll_skelet", self.caster:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_CUSTOM_5)
		skeleton:SetOwner(self.caster)
		skeleton.mkb = self.caster.mkb
		skeleton.summoned = true
		skeleton.host_team = self.caster.host_team
		skeleton:SetPhysicalArmorBaseValue(2)
		dota1x6:SetLaneCreepsStats(skeleton)
	end
end