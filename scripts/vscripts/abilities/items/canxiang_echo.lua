--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____canxiang_set = require("shared.canxiang_set")
local CANXIANG_ECHO_TAG = ____canxiang_set.CANXIANG_ECHO_TAG
--- 安排一次「残响」：delay 秒后对目标结算 damage 的 damageType 伤害
-- （之刃传 PHYSICAL、法印传 MAGICAL——残响吃防御减免，不再是无视护甲/魔抗的 PURE）。
-- NO_PROC + CANXIANG_ECHO_TAG：不触发 on-hit、不再回声；结算时目标/自身失效则作废。
function ____exports.ScheduleEcho(self, parent, target, ability, damage, delay, damageType)
	if damage <= 0 then
		return
	end
	SysTimers:CreateTimer(math.max(0.03, delay), function()
		if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) then
			return nil
		end
		if target:GetTeamNumber() == parent:GetTeamNumber() then
			return nil
		end
		Damage:ApplyDamage({
			attacker = parent,
			victim = target,
			damage = damage,
			damage_type = damageType,
			ability = ability,
			extra_data = {
				damage_tags = DamageTag.NO_PROC,
				custom_tag = CANXIANG_ECHO_TAG,
				source_name = "canxiang_set:残响",
			},
		})
		EmitSoundOn("Hero_Weaver.GeminateAttack", target)
		return nil
	end)
end
return ____exports