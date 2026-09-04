--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("utils.modifier_links_autogen")
require("utils.aeslua")
require("utils.decrypt")
require("utils.json")
require("utils.md5")
require("utils.utils")
require("utils.utils")
require("utils.tween")
if IsServer() then
	require("utils.timers")
	require("utils.systimers")
	require("utils.pool")
end
_G.SHA = require("utils.sha")
_G.LibDeflate = require("utils.libs.deflate")
_G.base64 = require("utils.libs.base64")