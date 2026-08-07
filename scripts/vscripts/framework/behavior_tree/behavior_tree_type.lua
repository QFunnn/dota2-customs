--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "framework/behavior_tree/behavior_tree_type"
BehaviorNodeType = BehaviorNodeType or {}
BehaviorNodeType.Root = "Root"
BehaviorNodeType.Sequence = "Sequence"
BehaviorNodeType.Selector = "Selector"
BehaviorNodeType.Parallel = "Parallel"
BehaviorNodeType.Rotation = "Rotation"
BehaviorNodeType.Action = "Action"
BehaviorNodeType.Condition = "Condition"
BehaviorNodeType.Cooldown = "Cooldown"
BehaviorNodeType.Polling = "Polling"
BehaviorNodeStatus = BehaviorNodeStatus or {}
BehaviorNodeStatus.Success = "Success"
BehaviorNodeStatus.Failure = "Failure"
BehaviorNodeStatus.Running = "Running"