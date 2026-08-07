--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/ability_ai"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["7"] = 1,
		["8"] = 1,
		["9"] = 1,
		["10"] = 3,
		["11"] = 4,
		["12"] = 6,
		["13"] = 8,
		["14"] = 9,
		["15"] = 10,
		["16"] = 11,
		["17"] = 13,
		["18"] = 14,
		["19"] = 15,
		["20"] = 16,
		["21"] = 17,
		["22"] = 18,
		["23"] = 19,
		["24"] = 20,
		["25"] = 21,
		["26"] = 22,
		["27"] = 23,
		["28"] = 24,
		["29"] = 25,
		["30"] = 26,
		["31"] = 27,
		["33"] = 29,
		["34"] = 30,
		["36"] = 10,
		["37"] = 3,
		["38"] = 51,
		["39"] = 51,
		["40"] = 51,
		["41"] = 51,
		["42"] = 56,
		["43"] = 57,
		["44"] = 58,
		["45"] = 60,
		["46"] = 61,
		["47"] = 62,
		["48"] = 63,
		["49"] = 64,
		["50"] = 65,
		["51"] = 66,
		["52"] = 67,
		["55"] = 71,
		["56"] = 72,
		["57"] = 73,
		["58"] = 74,
		["59"] = 75,
		["61"] = 77,
		["62"] = 78,
		["65"] = 56,
		["66"] = 83,
		["67"] = 84,
		["68"] = 85,
		["69"] = 86,
		["70"] = 87,
		["71"] = 87,
		["72"] = 87,
		["73"] = 88,
		["74"] = 89,
		["75"] = 90,
		["77"] = 92,
		["78"] = 93,
		["79"] = 94,
		["80"] = 94,
		["81"] = 94,
		["82"] = 94,
		["83"] = 94,
		["84"] = 94,
		["85"] = 94,
		["86"] = 94,
		["87"] = 94,
		["88"] = 94,
		["89"] = 94,
		["90"] = 95,
		["91"] = 96,
		["94"] = 99,
		["97"] = 102,
		["98"] = 87,
		["99"] = 87,
		["100"] = 104,
		["101"] = 105,
		["102"] = 105,
		["103"] = 105,
		["104"] = 106,
		["105"] = 107,
		["106"] = 108,
		["108"] = 110,
		["109"] = 111,
		["110"] = 112,
		["111"] = 113,
		["112"] = 114,
		["113"] = 115,
		["114"] = 116,
		["115"] = 116,
		["116"] = 116,
		["117"] = 116,
		["118"] = 116,
		["119"] = 116,
		["120"] = 116,
		["121"] = 116,
		["122"] = 116,
		["123"] = 116,
		["124"] = 116,
		["125"] = 117,
		["126"] = 118,
		["127"] = 118,
		["128"] = 118,
		["129"] = 118,
		["130"] = 118,
		["131"] = 118,
		["133"] = 120,
		["134"] = 121,
		["136"] = 123,
		["137"] = 124,
		["138"] = 124,
		["139"] = 124,
		["140"] = 124,
		["141"] = 124,
		["142"] = 124,
		["143"] = 124,
		["144"] = 124,
		["145"] = 124,
		["146"] = 124,
		["147"] = 125,
		["148"] = 126,
		["149"] = 126,
		["150"] = 126,
		["151"] = 126,
		["152"] = 126,
		["153"] = 126,
		["154"] = 126,
		["155"] = 126,
		["156"] = 126,
		["157"] = 126,
		["158"] = 126,
		["159"] = 126,
		["161"] = 128,
		["162"] = 129,
		["165"] = 132,
		["166"] = 105,
		["167"] = 105,
		["168"] = 134,
		["169"] = 135,
		["170"] = 135,
		["171"] = 135,
		["172"] = 136,
		["173"] = 137,
		["174"] = 138,
		["176"] = 140,
		["177"] = 141,
		["178"] = 142,
		["179"] = 143,
		["180"] = 144,
		["181"] = 144,
		["182"] = 144,
		["183"] = 144,
		["184"] = 144,
		["185"] = 144,
		["186"] = 144,
		["187"] = 144,
		["188"] = 144,
		["189"] = 144,
		["190"] = 144,
		["191"] = 145,
		["192"] = 146,
		["193"] = 146,
		["194"] = 146,
		["195"] = 146,
		["196"] = 146,
		["197"] = 146,
		["199"] = 148,
		["200"] = 149,
		["202"] = 151,
		["203"] = 152,
		["205"] = 154,
		["206"] = 155,
		["207"] = 155,
		["208"] = 155,
		["209"] = 155,
		["210"] = 155,
		["211"] = 155,
		["212"] = 155,
		["213"] = 155,
		["214"] = 155,
		["215"] = 155,
		["217"] = 157,
		["218"] = 158,
		["221"] = 161,
		["222"] = 135,
		["223"] = 135,
		["225"] = 83,
		["226"] = 165,
		["227"] = 166,
		["228"] = 167,
		["229"] = 168,
		["231"] = 165,
		["232"] = 171,
		["233"] = 172,
		["234"] = 172,
		["235"] = 172,
		["236"] = 172,
		["237"] = 172,
		["238"] = 171,
		["239"] = 174,
		["240"] = 175,
		["241"] = 175,
		["242"] = 175,
		["243"] = 175,
		["244"] = 175,
		["245"] = 175,
		["246"] = 174,
		["247"] = 177,
		["248"] = 178,
		["249"] = 178,
		["250"] = 178,
		["251"] = 178,
		["252"] = 178,
		["253"] = 178,
		["254"] = 177,
		["255"] = 180,
		["256"] = 181,
		["257"] = 182,
		["259"] = 184,
		["260"] = 180,
		["261"] = 186,
		["262"] = 187,
		["263"] = 188,
		["264"] = 189,
		["265"] = 190,
		["266"] = 191,
		["269"] = 194,
		["270"] = 186,
		["271"] = 196,
		["272"] = 197,
		["273"] = 198,
		["275"] = 200,
		["276"] = 196,
		["277"] = 202,
		["278"] = 203,
		["279"] = 204,
		["281"] = 206,
		["282"] = 202,
	}
)
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.BaseAbility
local i = g.toDotaClassInstance
f.registerAbilityAI = function(j, k)
	return function(j, l)
		local m = _G
		m[l.name] = {}
		i(nil, m[l.name], l)
		local n = m[l.name].Spawn
		m[l.name].Spawn = function(self)
			self:____constructor()
			self.iBehavior = k and k.iBehavior
			self.iSearchBehavior = k and k.iSearchBehavior or AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_NONE
			self.iAOERadius = k and k.iAOERadius
			self.iStartWidth = k and k.iStartWidth
			self.iEndWidth = k and k.iEndWidth
			self.iTargetTeam = k and k.iTargetTeam
			self.iTargetType = k and k.iTargetType
			self.iTargetFlags = k and k.iTargetFlags
			self.funcSortFunction = k and k.funcSortFunction
			self.funcCondition = k and k.funcCondition
			self.funcUnitsCallback = k and k.funcUnitsCallback
			self.bIsNotPassive = k and k.bIsNotPassive
			self.iOrderType = k and k.iOrderType or FIND_ANY_ORDER
			if n then
				n(self)
			end
			if n ~= f.BaseAbilityAI.prototype.Spawn then
				f.BaseAbilityAI.prototype.Spawn(self)
			end
		end
	end
end
f.BaseAbilityAI = c()
local o = f.BaseAbilityAI
o.name = "BaseAbilityAI"
d(o, h)
function o.prototype.Spawn(self)
	if IsServer() then
		local p = self:GetCaster()
		if not self:IsPassive() and self.iBehavior == nil then
			local q = self:GetBehaviorInt()
			if bit.band(q, DOTA_ABILITY_BEHAVIOR_NO_TARGET) == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
				self.iBehavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET
			elseif bit.band(q, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
				self.iBehavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
			elseif bit.band(q, DOTA_ABILITY_BEHAVIOR_POINT) == DOTA_ABILITY_BEHAVIOR_POINT then
				self.iBehavior = DOTA_ABILITY_BEHAVIOR_POINT
			end
		end
		self.iTargetTeam = self.iTargetTeam or self:GetAbilityTargetTeam()
		self.iTargetType = self.iTargetType or self:GetAbilityTargetType()
		self.iTargetFlags = self.iTargetFlags or self:GetAbilityTargetFlags()
		if self.iTargetTeam == DOTA_UNIT_TARGET_TEAM_NONE then
			self.iTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY
		end
		if self.iTargetType == DOTA_UNIT_TARGET_NONE then
			self.iTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
		end
	end
end
function o.prototype._StartThink(self)
	self:_StopThink()
	local p = self:GetCaster()
	if self.iBehavior == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
		self.AITimer = self:GameTimer(0, function()
			if self:_IsReady() then
				if self.funcCondition ~= nil and self:funcCondition() ~= true then
					return AI_TIMER_TICK_TIME
				end
				local r = self:_GetRadius()
				if r > 0 then
					local s = FindUnitsInRadius(
						p:GetTeamNumber(),
						p:GetAbsOrigin(),
						nil,
						r,
						self.iTargetTeam,
						self.iTargetType,
						self.iTargetFlags,
						self.iOrderType,
						false
					)
					if IsValid(s[2]) then
						self:_CastAbilityNoTarget()
					end
				else
					self:_CastAbilityNoTarget()
				end
			end
			return AI_TIMER_TICK_TIME
		end)
	elseif self.iBehavior == DOTA_ABILITY_BEHAVIOR_POINT then
		self.AITimer = self:GameTimer(0, function()
			if self:_IsReady() then
				if self.funcCondition ~= nil and self:funcCondition() ~= true then
					return AI_TIMER_TICK_TIME
				end
				local t = self:GetCastRange(vec3_invalid, nil)
				local r = self:_GetRadius()
				local u = self:_GetStartWidth()
				local v = self:_GetEndWidth()
				local w = vec3_invalid
				if self.iSearchBehavior == AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_NONE then
					local s = FindUnitsInRadius(
						p:GetTeamNumber(),
						p:GetAbsOrigin(),
						nil,
						t,
						self.iTargetTeam,
						self.iTargetType,
						self.iTargetFlags,
						self.iOrderType,
						false
					)
					if self.funcSortFunction then
						table.sort(s, function(x, y)
							return self:funcSortFunction(x, y)
						end)
					end
					if IsValid(s[2]) then
						w = s[2]:GetAbsOrigin()
					end
				elseif self.iSearchBehavior == AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_MOST_AOE_TARGET then
					w = GetAOEMostTargetsPosition(
						p:GetAbsOrigin(),
						t,
						p:GetTeamNumber(),
						r,
						self.iTargetTeam,
						self.iTargetType,
						self.iTargetFlags,
						self.iOrderType
					)
				elseif self.iSearchBehavior == AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_MOST_LINE_TARGET then
					w = GetLinearMostTargetsPosition(
						p:GetAbsOrigin(),
						t,
						p:GetTeamNumber(),
						u,
						v,
						self.iTargetTeam,
						self.iTargetType,
						self.iTargetFlags,
						self.iOrderType,
						{}
					)
				end
				if w ~= vec3_invalid then
					self:_CastAbilityOnPosition(w)
				end
			end
			return AI_TIMER_TICK_TIME
		end)
	elseif self.iBehavior == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
		self.AITimer = self:GameTimer(0, function()
			if self:_IsReady() then
				if self.funcCondition ~= nil and self:funcCondition() ~= true then
					return AI_TIMER_TICK_TIME
				end
				local t = self:GetCastRange(vec3_invalid, nil)
				local r = self:_GetRadius()
				local z
				if self.iSearchBehavior == AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_NONE then
					local s = FindUnitsInRadius(
						p:GetTeamNumber(),
						p:GetAbsOrigin(),
						nil,
						t,
						self.iTargetTeam,
						self.iTargetType,
						self.iTargetFlags,
						self.iOrderType,
						false
					)
					if self.funcSortFunction then
						table.sort(s, function(x, y)
							return self:funcSortFunction(x, y)
						end)
					end
					if self.funcUnitsCallback then
						self:funcUnitsCallback(s)
					end
					if IsValid(s[2]) then
						z = s[2]
					end
				elseif self.iSearchBehavior == AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_MOST_AOE_TARGET then
					z = GetAOEMostTargetsSpellTarget(
						p:GetAbsOrigin(),
						t,
						p:GetTeamNumber(),
						r,
						self.iTargetTeam,
						self.iTargetType,
						self.iTargetFlags,
						self.iOrderType
					)
				end
				if z then
					self:_CastAbilityOnTarget(z)
				end
			end
			return AI_TIMER_TICK_TIME
		end)
	end
end
function o.prototype._StopThink(self)
	if self.AITimer then
		self:StopTimer(self.AITimer)
		self.AITimer = nil
	end
end
function o.prototype._CastAbilityNoTarget(self)
	executeOrder(self:GetCaster(), DOTA_UNIT_ORDER_CAST_NO_TARGET, self)
end
function o.prototype._CastAbilityOnPosition(self, w)
	executeOrder(self:GetCaster(), DOTA_UNIT_ORDER_CAST_POSITION, self, w)
end
function o.prototype._CastAbilityOnTarget(self, z)
	executeOrder(self:GetCaster(), DOTA_UNIT_ORDER_CAST_TARGET, self, z)
end
function o.prototype._GetRadius(self)
	if self.iAOERadius then
		return self.iAOERadius
	end
	return 0
end
function o.prototype._IsReady(self)
	local A = GameState:getStateName()
	if (A == "GameState_Battle" or A == "GameState_Neutral") and self:IsAbilityReady() then
		local B = self:GetCaster():GetEnemy()
		if IsInjurable(B) then
			return true
		end
	end
	return false
end
function o.prototype._GetStartWidth(self)
	if self.iStartWidth then
		return self.iStartWidth
	end
	return 0
end
function o.prototype._GetEndWidth(self)
	if self.iEndWidth then
		return self.iEndWidth
	end
	return 0
end
return f