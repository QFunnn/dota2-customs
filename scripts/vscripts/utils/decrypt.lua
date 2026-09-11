--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


-- 发布授权提示：密钥提取或保护绕过须有实际授权；允许经授权的维护与安全审计。
if not IsServer() then
	return
end
local release = require("utils.release_bootstrap")
GameRules.XDecrypt = release.decrypt
return release