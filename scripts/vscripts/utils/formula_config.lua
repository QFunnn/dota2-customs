--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local BaseFormulaJson = require("json.ak_items_formula")
local BASE_FORMULA_CONFIG = BaseFormulaJson
--- 仅从图纸配置域解析产物，避免其他物品复用 `item` 字段时被误判为图纸。
function ____exports.getFormulaTargetItem(self, formulaId)
	local ____MyGameRulesetManager_0
	if MyGameRulesetManager then
		____MyGameRulesetManager_0 = MyGameRulesetManager:GetFormulaConfig(formulaId)
	else
		____MyGameRulesetManager_0 = BASE_FORMULA_CONFIG[formulaId]
	end
	local formulaConfig = ____MyGameRulesetManager_0
	local targetItem = formulaConfig and formulaConfig.item
	local ____temp_3
	if type(targetItem) == "string" and #targetItem > 0 then
		____temp_3 = targetItem
	else
		____temp_3 = nil
	end
	return ____temp_3
end
return ____exports