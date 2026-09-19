--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---Проверка на null. После проверки использовать с ---@cast variable CLASS, чтобы IDE не ругалась на nil
---@param object any?
---@return boolean
function IsValid(object)
	return object ~= nil and object.IsNull ~= nil and not object:IsNull()
end