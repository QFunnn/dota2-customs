--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_creature_true_sight = class({})


function modifier_creature_true_sight:GetTexture()
	return "item_gem"
end


function modifier_creature_true_sight:IsHidden()
	return true
end

function modifier_creature_true_sight:IsDebuff()
	return false
end

function modifier_creature_true_sight:IsPurgable()
	return false
end

function modifier_creature_true_sight:GetEffectName()
    return "particles/econ/wards/f2p/f2p_ward/f2p_ward_true_sight_ambient.vpcf"
end


function modifier_creature_true_sight:OnCreated( kv )
	if IsServer() then
		self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_tower_truesight_aura", {})
	end
end