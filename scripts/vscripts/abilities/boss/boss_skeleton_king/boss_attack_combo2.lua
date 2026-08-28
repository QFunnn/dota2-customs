--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_skeleton_king/boss_attack_combo2"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "boss_attack_combo2"
d(j, h)
function j.prototype.GetCastRange(self, k, l)
	return self:GetCaster():Script_GetAttackRange()
end
function j.prototype.OnAbilityPhaseStart(self)
	local m = self:GetCaster()
	local n = self:GetCursorPosition()
	local o = CalcDirection2D(n, m)
	self:SectorWarning(m:GetAbsOrigin(), o, m:Script_GetAttackRange(), 120, self:GetCastPoint())
	return true
end
function j.prototype.OnSpellStart(self)
	local m = self:GetCaster()
	local p = m:GetAbsOrigin()
	local n = self:GetCursorPosition()
	local o = CalcDirection2D(n, m)
	local q = self:GetSpecialValueFor("damage")
	m:Dash(o, 50, 0, 0.06, function(n)
		m:PushOff(n)
	end)
	local r = FindEnemiesInSector(m, p, m:Script_GetAttackRange(), o, 120)
	m:DealDamage(r, nil, q)
	m:StartGesture(ACT_SCRIPT_CUSTOM_10)
	m:SimulateCast({ duration = 0.43 })
	local s = m:FindModifierByName("modifier_boss_skeleton_king")
	local t
	if s ~= nil then
		t = s.currentStage
	else
		t = 1
	end
	local u = t
	if u >= 2 then
		self:StartThink(0.4, function()
			local v = m:FindAbilityByName("boss_attack_combo3")
			if u >= 4 and RollPercentage(30) then
				v = m:FindAbilityByName("boss_spike")
			end
			if v ~= nil then
				v:EndCooldown()
			end
			m:FadeGesture(ACT_SCRIPT_CUSTOM_10)
			if v ~= nil then
				if u >= 3 then
					local r = FindEnemiesInRadius(m, p, 1200)
					if #r > 0 then
						n = r[1]:GetAbsOrigin()
					end
				end
				m:ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, v, n)
			end
			return -1
		end)
	end
	m:EmitSound("Hero_SkeletonKing.Attack")
end
j = e({ i(nil) }, j)
return f