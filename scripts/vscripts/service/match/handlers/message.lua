--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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