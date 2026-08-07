--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local function handleMessage(payload, initiatorName)
	if not payload or not payload.message or payload.message == "" then
		logger:Log("message: пустой payload.message, пропускаем")
		return
	end
	MatchCommandService:Notify(initiatorName, payload.message)
end

MatchCommandService:Register("message", handleMessage)