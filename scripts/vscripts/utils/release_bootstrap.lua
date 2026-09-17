--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


-- 开发入口：发布器只替换产物中的此文件，不把密钥写入开发 Lua 源码。
return {
	get_stage = function()
		return nil
	end,
	get_key_source = function()
		return "development"
	end,
	get_auth_key = function()
		if IsInToolsMode() then
			return "Invalid_NotDedicatedServer"
		end
		return GetDedicatedServerKeyV3("dota_super_mid")
	end,
	decrypt = function()
		error("Encrypted modules require a matching release bootstrap", 0)
	end,
}