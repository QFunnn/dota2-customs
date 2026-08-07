--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "framework/notification"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__New
local g = {}
local h = require("lib.tstl-utils")
local i = h.reloadable
local j = c()
j.name = "CNotification"
d(j, CModule)
function j.prototype.init(self, k)
	if not k then
		self.tPlayersChatLineCount = {}
	end
	do
		local l = 0
		while l < DOTA_MAX_PLAYERS do
			self.tPlayersChatLineCount[l] = 2
			l = l + 1
		end
	end
end
function j.prototype.ShowPlaceName(self, m, n, o)
	if o == nil then
		o = 2
	end
	local p = PlayerResource:GetPlayer(m)
	if p then
		CustomGameEventManager:Send_ServerToPlayer(p, "ShowPlaceName", { text = n, duration = o })
	end
end
function j.prototype.Upper(self, q)
	CustomGameEventManager:Send_ServerToAllClients("notification_upper", q)
end
function j.prototype.UpperToPlayer(self, m, q)
	local p = PlayerResource:GetPlayer(m)
	if p then
		CustomGameEventManager:Send_ServerToPlayer(p, "notification_upper", q)
	end
end
function j.prototype.Combat(self, q)
	CustomGameEventManager:Send_ServerToAllClients("notification_combat", q)
end
function j.prototype.CombatToPlayer(self, m, q)
	local p = PlayerResource:GetPlayer(m)
	if p then
		CustomGameEventManager:Send_ServerToPlayer(p, "notification_combat", q)
	end
end
function j.prototype.CombatResource(self, q, r)
	local s = {}
	for t, u in pairs(r) do
		s[#s + 1] = { t, u }
	end
	if not q.message then
		q.message = "DrawReward_AllPlayer_Custom_Resources"
	end
	q.array_get = { type = "$0 $1", split = " / ", param_type = { "resource", "b_int" }, list = s }
	self:Combat(q)
end
function j.prototype.CombatAttribute(self, q, v)
	if not q.message then
		q.message = "DrawReward_AttributeTotal"
	end
	q.array_get = { type = "custom_variable", split = " / ", list = v }
	self:Combat(q)
end
function j.prototype.CombatResourceToPlayer(self, m, q, r)
	local s = {}
	for t, u in pairs(r) do
		s[#s + 1] = { t, u }
	end
	if not q.message then
		q.message = "DrawReward_Custom_Resources"
	end
	q.array_get = { type = "$0 $1", split = " / ", param_type = { "resource", "b_int" }, list = s }
	self:CombatToPlayer(m, q)
end
function j.prototype.CombatAttributeToPlayer(self, m, q, v)
	if not q.message then
		q.message = "DrawReward_AttributeTotal"
	end
	q.array_get = { type = "custom_variable", split = " / ", list = v }
	self:CombatToPlayer(m, q)
end
function j.prototype.ChatLine(self, q)
	local m = q.player_id
	if type(m) == "number" and PlayerResource:IsValidPlayerID(m) then
		CustomGameEventManager:Send_ServerToAllClients("notification_chat_line", q)
	end
end
function j.prototype.HelpTip(self, m, w)
	local p = PlayerResource:GetPlayer(m)
	w.flDuration = w.flDuration or 5
	w.sDirection = w.sDirection or "top"
	if p then
		CustomGameEventManager:Send_ServerToPlayer(p, "notification_help", w)
	end
end
function j.prototype.CloseHelpTip(self, m, x)
	local p = PlayerResource:GetPlayer(m)
	if p then
		CustomGameEventManager:Send_ServerToPlayer(p, "notification_close_help", { sPanelID = x })
	end
end
j = e({ i }, j)
if Notification == nil then
	Notification = f(j)
end
return g