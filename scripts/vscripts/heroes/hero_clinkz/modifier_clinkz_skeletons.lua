--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_clinkz_skeletons = class({})

function modifier_clinkz_skeletons:OnCreated()
	if IsServer() then
		self:StartIntervalThink(0.2)
	end
end

function modifier_clinkz_skeletons:OnIntervalThink()
	if IsServer() then
		local parent = self:GetParent()
		local enemies = FindUnitsInRadius(parent:GetTeamNumber(), parent:GetAbsOrigin(), nil, 1300, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, FIND_CLOSEST, false)
		if enemies[1] and enemies[1]:IsAlive() and (not enemies[1]:IsAttackImmune()) then
			parent:MoveToTargetToAttack(enemies[1])
		end
	end
end

function modifier_clinkz_skeletons:IsHidden() return true end
function modifier_clinkz_skeletons:IsDebuff() return false end
function modifier_clinkz_skeletons:IsPurgable() return false end
function modifier_clinkz_skeletons:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end