--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_lifesteal_upgrade = class(modifier_base_generic_upgrade)

function modifier_generic_lifesteal_upgrade:RecalculateBonusPerUpgrade()
	self:CalculateBonusPerUpgrade("lifesteal")
end

function modifier_generic_lifesteal_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_lifesteal_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_lifesteal_upgrade:DeclareFunctions()
	if IsClient() then return {} end
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end


function modifier_generic_lifesteal_upgrade:GetModifierProcAttack_Feedback(kv)
	if kv.damage <= 0 then return end
	if kv.target:IsBuilding() then return end
	if kv.target:IsOther() then return end

	local attacker = kv.attacker
	local steal = kv.damage * (self.bonus/100)

	attacker:HealWithParams(steal, attacker, true, true, attacker, false) -- this function still doesn't do its particle magic

	local particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_OVERHEAD_FOLLOW, kv.attacker)
	ParticleManager:SetParticleControl(particle, 0, kv.attacker:GetAbsOrigin())
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, kv.attacker, steal, nil)
end