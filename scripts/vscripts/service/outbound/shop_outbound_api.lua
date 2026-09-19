--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


ShopOutboundApi = ShopOutboundApi or {}

---@param uid string
---@param inventory table
---@param balanceChange integer|nil
---@param callback function|nil
function ShopOutboundApi:UpdateInventory(uid, inventory, balanceChange, callback)
	local payload = {
		uid = uid,
		inventory = inventory,
	}

	if balanceChange ~= nil then
		payload.balanceChange = balanceChange
	end

	OutboundRequestSender:SendJson("POST", "/player/save-inventory", payload, callback)
end

---@param uid string
---@param code string
---@param callback fun(response: CScriptHTTPResponse)
function ShopOutboundApi:ActivatePromo(uid, code, callback)
	OutboundRequestSender:SendJson("POST", "/promo/activate", {
		uid = uid,
		code = code,
	}, callback, true)
end