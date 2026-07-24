--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


winter_wyvern_eldwurm_scholar = winter_wyvern_eldwurm_scholar or class({})
LinkLuaModifier("modifier_winter_wyvern_eldwurm_scholar_custom", "abilities/heroes/winter_wyvern/winter_wyvern_eldwurm_scholar", LUA_MODIFIER_MOTION_NONE)


function winter_wyvern_eldwurm_scholar:GetIntrinsicModifierName()
	return "modifier_winter_wyvern_eldwurm_scholar_custom"
end



modifier_winter_wyvern_eldwurm_scholar_custom = modifier_winter_wyvern_eldwurm_scholar_custom or class({})


function modifier_winter_wyvern_eldwurm_scholar_custom:IsHidden() return true end
function modifier_winter_wyvern_eldwurm_scholar_custom:IsPurgable() return false end
function modifier_winter_wyvern_eldwurm_scholar_custom:RemoveOnDeath() return false end


function modifier_winter_wyvern_eldwurm_scholar_custom:OnCreated()
	local ability = self:GetAbility()
	self.exp_per_orb = ability:GetSpecialValueFor("exp_per_orb")

	if not IsServer() then return end

	self.parent = self:GetParent()
	self.listener = EventDriver:Listen("GameLoop:orb_captured", self.OnOrbCaptured, self)
end


function modifier_winter_wyvern_eldwurm_scholar_custom:OnOrbCaptured(event)
	if event.team ~= self.parent:GetTeam() then return end

	local exp = self.exp_per_orb * event.rarity

	for _, hero in pairs(GameLoop.heroes_by_team[self.parent:GetTeam()]) do
		if IsValidEntity(hero) then
			hero:AddExperience(exp, DOTA_ModifyXP_Unspecified, false, true)
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_XP, hero, exp, nil)
		end
	end
end