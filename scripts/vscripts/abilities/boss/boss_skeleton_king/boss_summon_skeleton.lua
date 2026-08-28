--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_skeleton_king/boss_summon_skeleton"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayIncludes
local f = b.__TS__ArrayFilter
local g = b.__TS__DecorateLegacy
local h = {}
local i = require("abilities.eom_ability")
local j = i.EOMAbility
local k = i.registerEOMAbility
local l = c()
l.name = "boss_summon_skeleton"
d(l, j)
function l.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.summonRecords = {}
	self.nextSummonAllowedTime = 0
end
function l.prototype.OnSpellStart(self)
	local m = self:GetCaster()
	m:SimulateCast({ orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET, duration = 1 })
	self.nextSummonAllowedTime = GameRules:GetGameTime() + 16
	local n = m:GetAbsOrigin()
	m:RemoveModifierByName("modifier_face_move")
	m:RemoveGesture(ACT_DOTA_RUN)
	local o = self:GetSpecialValueFor("skeleton_count")
	local p = self:GetSpecialValueFor("radius")
	local q = 100
	local r = 12
	do
		local s = 0
		while s < o do
			do
				local t
				if s == 0 then
					t = n + m:GetForwardVector() * 150
				else
					do
						local u = 0
						while u < r do
							local v = GetGroundPosition(n + RandomVector(RandomInt(q, p)), nil)
							if GridNav:IsValidPosition(v) then
								t = v
								break
							end
							u = u + 1
						end
					end
				end
				if t == nil then
					goto w
				end
				local x = m:SummonUnit("skeleton_king_summon", t)
				if x ~= nil then
					local y = DungeonManager:GetCurrentRoom()
					if y ~= nil then
						y:ApplyDifficultyModifiers(x)
					end
					FindClearSpaceForUnit(x, t, true)
					local z = self.summonRecords
					z[#z + 1] = x
				end
			end
			::w::
			s = s + 1
		end
	end
end
function l.prototype.EventListener(self)
	return {
		entity_killed = function(A, B)
			if e(self.summonRecords, B.victim) then
				self.summonRecords = f(self.summonRecords, function(A, x)
					return x ~= B.victim
				end)
				if #self.summonRecords <= 0 then
					self.nextSummonAllowedTime = GameRules:GetGameTime() + 16
				end
			end
			if B.victim == self:GetCaster() then
				self:OnDestroy()
			end
		end,
	}
end
function l.prototype.OnDestroy(self)
	local m = self:GetCaster()
	for A, x in ipairs(self.summonRecords) do
		if IsValid(x) then
			x:Kill(self, m)
		end
	end
	self.summonRecords = {}
end
l = g(
	{
		k(nil, {
			startCooldown = 15,
			funcCondition = function(A, C)
				return C:GetCaster():GetCurrentActiveAbility() == nil
					and #C.summonRecords <= 0
					and GameRules:GetGameTime() >= C.nextSummonAllowedTime
			end,
		}),
	},
	l
)
return h