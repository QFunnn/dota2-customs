--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_courier"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 4,
		["15"] = 12,
		["16"] = 4,
		["17"] = 12,
		["19"] = 12,
		["20"] = 13,
		["21"] = 14,
		["22"] = 4,
		["23"] = 20,
		["24"] = 21,
		["25"] = 20,
		["26"] = 28,
		["27"] = 29,
		["28"] = 30,
		["29"] = 31,
		["30"] = 32,
		["31"] = 33,
		["32"] = 34,
		["33"] = 34,
		["34"] = 34,
		["35"] = 34,
		["36"] = 34,
		["37"] = 34,
		["40"] = 28,
		["41"] = 38,
		["42"] = 39,
		["43"] = 40,
		["44"] = 41,
		["47"] = 38,
		["48"] = 45,
		["49"] = 46,
		["50"] = 45,
		["51"] = 50,
		["52"] = 51,
		["53"] = 50,
		["54"] = 63,
		["55"] = 64,
		["56"] = 65,
		["57"] = 66,
		["58"] = 67,
		["59"] = 67,
		["60"] = 67,
		["61"] = 67,
		["63"] = 63,
		["64"] = 70,
		["65"] = 71,
		["66"] = 70,
		["67"] = 76,
		["68"] = 77,
		["69"] = 76,
		["70"] = 79,
		["71"] = 80,
		["72"] = 81,
		["74"] = 79,
		["75"] = 84,
		["76"] = 85,
		["77"] = 86,
		["78"] = 87,
		["79"] = 88,
		["80"] = 90,
		["81"] = 91,
		["82"] = 92,
		["83"] = 93,
		["84"] = 93,
		["85"] = 93,
		["86"] = 93,
		["87"] = 93,
		["88"] = 94,
		["89"] = 95,
		["90"] = 96,
		["91"] = 97,
		["92"] = 98,
		["93"] = 100,
		["95"] = 102,
		["96"] = 103,
		["97"] = 104,
		["98"] = 105,
		["102"] = 84,
		["103"] = 12,
		["104"] = 4,
		["105"] = 4,
		["106"] = 4,
		["107"] = 4,
		["108"] = 4,
		["109"] = 4,
		["110"] = 4,
		["111"] = 4,
		["112"] = 12,
		["114"] = 12,
	}
)
local g = {}
local h = require("units.ai")
local i = h.processAI
local j = h.stopProcessAI
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.modifier_courier = c()
local n = g.modifier_courier
n.name = "modifier_courier"
d(n, l)
function n.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.position = self:GetParent():GetAbsOrigin()
	self.positionRecord = self:GetParent():GetAbsOrigin()
end
function n.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true }
end
function n.prototype.OnCreated(self, o)
	if IsServer() then
		self.playerID = self:GetParent():GetPlayerOwnerID()
		self:StartIntervalThink(1)
		self:StartThink(1)
		if self.parent:GetTeamNumber() == DOTA_TEAM_BADGUYS then
			self.parent:AddNewModifier(self.parent, self.parent:GetDummyAbility(), "modifier_stun", {})
		end
	end
end
function n.prototype.getConsumableName(self, p)
	for q, r in pairs(KeyValues.ConsumablesKv) do
		if r.Id == p then
			return q
		end
	end
end
function n.prototype.ECheckState(self)
	return {}
end
function n.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE] = { -1, -1 } }
end
function n.prototype.OnPrepare(self)
	self:GetParent():FadeGesture(ACT_DOTA_VICTORY)
	local s = PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
	if s then
		self:SetStackCount(math.min(10, math.max(0, s.winStack - 1)))
	end
end
function n.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE, MODIFIER_PROPERTY_HEALTH_BONUS }
end
function n.prototype.GetModifierModelScale(self)
	return 14 * self:GetStackCount()
end
function n.prototype.GetModifierHealthBonus(self)
	if IsGroupMode(nil) then
		return INIT_GAME_HEALTH_TEAM - INIT_GAME_HEALTH
	end
end
function n.prototype.OnIntervalThink(self)
	local t = PlayerResource:GetConnectionState(self.playerID)
	local s = PlayerData:getplayerData(self.playerID)
	if s and not s:IsBotData() then
		if not self.playerAbandonGame then
			if t == DOTA_CONNECTION_STATE_ABANDONED then
				PlayerData:OnPlayerAbandonGame(self.playerID)
				j(nil, self.playerID)
				self.timer = i(nil, self.playerID, Match:getBotMode())
				self.playerAbandonGame = true
			elseif t ~= DOTA_CONNECTION_STATE_CONNECTED and self.timer == nil then
				self.timer = i(nil, self.playerID, "disconnect")
				PlayerData:setConnectState(self.playerID, false)
				if
					IsCompetitionMode(nil)
					and not GameRules:IsGamePaused()
					and PlayerData:isAlivePlayer(self.playerID)
				then
					Game:OnCustomTogglePause({})
				end
			elseif t == DOTA_CONNECTION_STATE_CONNECTED and self.timer ~= nil then
				j(nil, self.playerID)
				self.timer = nil
				PlayerData:setConnectState(self.playerID, true)
			end
		end
	end
end
n = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	n
)
g.modifier_courier = n
return g