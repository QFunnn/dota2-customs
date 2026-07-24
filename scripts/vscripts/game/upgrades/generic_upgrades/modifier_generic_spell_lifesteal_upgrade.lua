--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_spell_lifesteal_upgrade = class(modifier_base_generic_upgrade)

function modifier_generic_spell_lifesteal_upgrade:RecalculateBonusPerUpgrade()
	self:CalculateBonusPerUpgrade("spell_lifesteal")
end

function modifier_generic_spell_lifesteal_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_spell_lifesteal_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_spell_lifesteal_upgrade:DeclareFunctions()
	if IsClient() then return {} end
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end


function modifier_generic_spell_lifesteal_upgrade:OnTakeDamage(params)
	local parent = self:GetParent()
	if parent ~= params.attacker then return end
	if parent == params.unit then return end -- self-damage is not healed
	if params.damage <= 0 then return end
	if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return end
	if params.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then return end

	local steal = math.max(1, params.damage * ( self.bonus / 100))

	if params.unit and not params.unit:IsHero() then
		steal = 0.2 * steal
	end

	parent:HealWithParams(steal, params.inflictor, false, true, parent, true)

	local particle = ParticleManager:CreateParticle("particles/items3_fx/octarine_core_lifesteal.vpcf", PATTACH_OVERHEAD_FOLLOW, parent)
	ParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, parent, steal, nil)
end