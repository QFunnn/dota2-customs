--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


WebMail = WebMail or {}
-- status: complete, untested

function WebMail:Init()
	EventStream:Listen("WebMail:get_mails", WebMail.GetMails, WebMail)
	EventStream:Listen("WebMail:delete_mail", WebMail.DeleteMail, WebMail)
	EventStream:Listen("WebMail:claim_mail", WebMail.ClaimMail, WebMail)

	WebMail.mails = {}
end


-- add all mails from before-match player data
function WebMail:SetPlayerMails(player_id, mails)
	for _, mail in pairs(mails or {}) do
		WebMail:AddMail(player_id, mail)
	end

	WebMail:UpdateClient(player_id)
end


-- add mail to player mails by id
function WebMail:AddMail(player_id, mail_data)
	if not WebMail.mails[player_id] then WebMail.mails[player_id] = {} end

	WebMail.mails[player_id][mail_data.id] = mail_data
end


-- send all mails to client on panorama module (re)loading
function WebMail:GetMails(event)
	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

	WebMail:UpdateClient(player_id)
end


-- delete mail (from backend)
function WebMail:DeleteMail(event)
	local player_id = event.PlayerID
	if not player_id then return end

	local mail_id = tonumber(event.mail_id)
	if not mail_id or not WebMail.mails[player_id] or not WebMail.mails[player_id][mail_id] then return end

	local steam_id = tostring(PlayerResource:GetSteamID(player_id))

	WebApi:Send(
		"api/lua/mail/delete",
		{
			steam_id = steam_id,
			mail_id = event.mail_id
		},
		function()
			print("[WebMail] successfully deleted mail", event.mail_id)
			WebMail.mails[player_id][mail_id] = nil
		end,
		function()
			print("[WebMail] failed to delete mail", event.mail_id)
		end
	)
end


-- claim attachments of mail (currency, items etc.)
function WebMail:ClaimMail(event)
	local player_id = event.PlayerID
	if not player_id then return end

	local mail_id = tonumber(event.mail_id)
	if not mail_id or not WebMail.mails[player_id] or not WebMail.mails[player_id][mail_id] then
		print("[WebMail] no mail found", player_id, mail_id, WebMail.mails[player_id], WebMail.mails[player_id][mail_id])
		DeepPrintTable(WebMail.mails)
		return
	end

	local mail = WebMail.mails[player_id][mail_id]
	if mail.is_claimed then
		print("[WebMail] mail " .. mail_id .. " is already claimed")
		return
	end

	local steam_id = tostring(PlayerResource:GetSteamID(player_id))

	WebApi:Send(
		"api/lua/mail/claim",
		{
			steam_id = steam_id,
			mail_id = event.mail_id
		},
		function(response)
			print("[WebMail] successfully claimed mail", mail_id)

			mail.is_claimed = true
			if response then
				WebApi:ProcessMetadata(player_id, response)
			end
		end,
		function()
			print("[WebMail] failed to claim mail", mail_id)
		end
	)
end


function WebMail:UpdateClient(player_id)
	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	CustomGameEventManager:Send_ServerToPlayer(player, "WebMail:update", {
		mails = WebMail.mails[player_id]
	})
end


-- handle match event type for incoming mail
-- in case feedback reply is sent while player is in active game
MatchEvents.event_handlers.mail_incoming = function(data)
	print("[WebMail] mail received from match event")
	DeepPrintTable(data)

	local player_id = WebApi:GetPlayerIdBySteamId(data.steam_id)
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	WebMail:AddMail(player_id, data.mail)

	WebMail:UpdateClient(player_id)
	Toasts:NewForPlayer(player_id, "mail_incoming", data.mail)
end


WebMail:Init()