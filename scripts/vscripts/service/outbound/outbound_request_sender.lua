--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


﻿OutboundRequestSender = OutboundRequestSender or {}
local applySecurityHeaders = require("service/outbound/security_headers")
OutboundRequestSender.logEnabled = true
local BASE_URL = "https://ratten.run/api"
-- local BASE_URL = "http://localhost:8080/api"

---@param method string
---@param url string
---@param body table | nil
---@param callback? fun(response: CScriptHTTPResponse)
function OutboundRequestSender:SendJson(method, url, body, callback)
    url = string.format("%s%s", BASE_URL, url)
    local req = CreateHTTPRequestScriptVM(method, url)
    req:SetHTTPRequestHeaderValue("Content-Type", "application/json")
    applySecurityHeaders(req)
    req:SetHTTPRequestRawPostBody("application/json", json.encode(body or {}))
    self:Log(string.format("Starting %s %s", method, url))
    req:Send(function(res)
        local ok = res.StatusCode == 200 or res.StatusCode == 204 -- todo добавить обработку
        self:Log(string.format("%s %s -> %s", method, url, tostring(res.StatusCode)))
        if callback and ok then
            callback(res)
        end
    end)
    self:Log(string.format("Finished %s %s", method, url))
end

function OutboundRequestSender:Log(...)
    if self.logEnabled == true then
        logger:Log(...)
    end
end