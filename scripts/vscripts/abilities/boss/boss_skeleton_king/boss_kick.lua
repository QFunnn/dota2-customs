--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_skeleton_king/boss_kick"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "boss_kick"
d(j, h)
function j.prototype.OnAbilityPhaseStart(self)
	return true
end
function j.prototype.OnSpellStart(self)
	local k = self:GetCaster()
	local l = self:GetCursorPosition()
	local m = k:GetForwardVector()
	local n = FindUnitsInRadius(
		k:GetTeamNumber(),
		k:GetAttachmentPosition("attach_attack3"),
		nil,
		150,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for o, p in ipairs(n) do
		if p ~= k then
			if not p:IsFriendly(k) then
			end
			p:KnockBack(m, 600, 150, 0.5)
		end
	end
	k:EmitSound("Hero_Tusk.WalrusPunch.Damage")
	k:SimulateCast({ orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET, duration = 0.5 })
end
j = e(
	{
		i(nil, {
			funcCondition = function(o, q)
				local k = q:GetCaster()
				local n = FindUnitsInRadius(
					k:GetTeamNumber(),
					k:GetAttachmentPosition("attach_attack3"),
					nil,
					150,
					DOTA_UNIT_TARGET_TEAM_BOTH,
					DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
				if #n > 1 then
					return true
				end
				return false
			end,
		}),
	},
	j
)
return f