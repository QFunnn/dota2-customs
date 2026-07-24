--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


TIMERS_VERSION = "1.01"
TIMERS_THINK = 0.01

if Timers == nil then
  print ( '[Timers] creating Timers' )
  Timers = {}
  Timers.__index = Timers
end

function Timers:new( o )
  o = o or {}
  setmetatable( o, Timers )
  return o
end

function Timers:start()
  Timers = self
  self.timers = {}
  
  local ent = Entities:CreateByClassname("info_target")
  ent:SetThink("Think", self, "timers", TIMERS_THINK)
end

function Timers:Think()
  if GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
    return
  end
  local now = GameRules:GetGameTime()
  for k,v in pairs(Timers.timers) do
    local bUseGameTime = true
    if v.useGameTime ~= nil and v.useGameTime == false then
      bUseGameTime = false
    end
    local bOldStyle = false
    if v.useOldStyle ~= nil and v.useOldStyle == true then
      bOldStyle = true
    end

    local now = GameRules:GetGameTime()
    if not bUseGameTime then
      now = Time()
    end

    if v.endTime == nil then
      v.endTime = now
    end
    if now >= v.endTime then
      Timers.timers[k] = nil
      local status, nextCall = pcall(v.callback, GameRules:GetGameModeEntity(), v)
      if status then
        if nextCall then
          if bOldStyle then
            v.endTime = v.endTime + nextCall - now
          else
            v.endTime = v.endTime + nextCall
          end

          Timers.timers[k] = v
        end
      else
        Timers:HandleEventError('Timer', k, nextCall)
      end
    end
  end

  return TIMERS_THINK
end

function Timers:HandleEventError(name, event, err)
  name = tostring(name or 'unknown')
  event = tostring(event or 'unknown')
  err = tostring(err or 'unknown')
  if not self.errorHandled then
    self.errorHandled = true
  end
end

function Timers:CreateTimer(name, args)
  if type(name) == "function" then
    args = {callback = name}
    name = DoUniqueString("timer")
  elseif type(name) == "table" then
    args = name
    name = DoUniqueString("timer")
  elseif type(name) == "number" then
    args = {endTime = name, callback = args}
    name = DoUniqueString("timer")
  end
  if not args.callback then
    print("Invalid timer created: "..name)
    return
  end


  local now = GameRules:GetGameTime()
  if args.useGameTime ~= nil and args.useGameTime == false then
    now = Time()
  end

  if args.endTime == nil then
    args.endTime = now
  elseif args.useOldStyle == nil or args.useOldStyle == false then
    args.endTime = now + args.endTime
  end

  Timers.timers[name] = args 

  return name
end

function Timers:RemoveTimer(name)
  Timers.timers[name] = nil
end

function Timers:RemoveTimers(killAll)
  local timers = {}

  if not killAll then
    for k,v in pairs(Timers.timers) do
      if v.persist then
        timers[k] = v
      end
    end
  end

  Timers.timers = timers
end


if not Timers.timers then Timers:start() end