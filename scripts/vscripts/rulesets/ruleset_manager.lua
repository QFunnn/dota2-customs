--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__New = ____lualib.__TS__New
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____tstl_2Dutils = require("utils.tstl-utils")
local reloadable = ____tstl_2Dutils.reloadable
local ____season_ruleset = require("shared.season_ruleset")
local SeasonRuleset = ____season_ruleset.SeasonRuleset
local ____ruleset_registry_generated = require("rulesets.ruleset_registry_generated")
local GENERATED_RULESET_ID_BY_MAP = ____ruleset_registry_generated.GENERATED_RULESET_ID_BY_MAP
local GENERATED_RULESET_TABLE_LOADERS = ____ruleset_registry_generated.GENERATED_RULESET_TABLE_LOADERS
local GENERATED_RULESET_REGISTRY =
	{ rulesetIdByMap = GENERATED_RULESET_ID_BY_MAP, tableLoadersByRuleset = GENERATED_RULESET_TABLE_LOADERS }
--- 管理当前对局唯一的赛季数据实例。
____exports.RulesetManager = __TS__Class()
local RulesetManager = ____exports.RulesetManager
RulesetManager.name = "RulesetManager"
__TS__ClassExtends(RulesetManager, SeasonRuleset)
function RulesetManager.prototype.____constructor(self, activeRulesetId, activeTables)
	SeasonRuleset.prototype.____constructor(self, { rulesetId = activeRulesetId, tables = activeTables })
end
function RulesetManager.TryCreate(self, rawMapName, registry)
	if registry == nil then
		registry = GENERATED_RULESET_REGISTRY
	end
	local activeRulesetId = ____exports.RulesetManager:ResolveRulesetIdByMap(rawMapName, registry)
	if not activeRulesetId then
		return nil
	end
	local activeTables = ____exports.RulesetManager:LoadTables(activeRulesetId, registry)
	if not activeTables then
		return nil
	end
	return __TS__New(____exports.RulesetManager, activeRulesetId, activeTables)
end
function RulesetManager.LoadTables(self, rulesetId, registry)
	local nextLoaders = registry.tableLoadersByRuleset[rulesetId]
	if not nextLoaders then
		____exports.RulesetManager:ReportError("缺少数据加载器: " .. rulesetId)
		return nil
	end
	local nextTables = {}
	for rawTableName in pairs(nextLoaders) do
		local tableName = rawTableName
		local loader = nextLoaders[tableName]
		if type(loader) ~= "function" then
			____exports.RulesetManager:ReportError(
				(("数据表加载器无效: ruleset=" .. rulesetId) .. " table=") .. tableName
			)
			return nil
		end
		do
			local function ____catch(____error)
				____exports.RulesetManager:ReportError(
					(((("数据表加载失败: ruleset=" .. rulesetId) .. " table=") .. tableName) .. " error=")
						.. tostring(____error)
				)
				return true, nil
			end
			local ____try, ____hasReturned, ____returnValue = pcall(function()
				local ____table = loader(nil)
				if not ____table then
					____exports.RulesetManager:ReportError(
						(("数据表加载结果为空: ruleset=" .. rulesetId) .. " table=") .. tableName
					)
					return true, nil
				end
				nextTables[tableName] = ____table
			end)
			if not ____try then
				____hasReturned, ____returnValue = ____catch(____hasReturned)
			end
			if ____hasReturned then
				return ____returnValue
			end
		end
	end
	return nextTables
end
function RulesetManager.ResolveRulesetIdByMap(self, rawMapName, registry)
	if type(rawMapName) ~= "string" or #rawMapName == 0 then
		____exports.RulesetManager:ReportError("地图名无效: " .. tostring(rawMapName))
		return nil
	end
	local rulesetId = registry.rulesetIdByMap[rawMapName]
	if not rulesetId then
		____exports.RulesetManager:ReportError("当前地图未配置 Ruleset: " .. rawMapName)
		return nil
	end
	return rulesetId
end
function RulesetManager.ReportError(self, message)
	if type(print) == "function" then
		print("[RulesetManager] " .. message)
	end
end
RulesetManager = __TS__DecorateLegacy({ reloadable }, RulesetManager)
____exports.RulesetManager = RulesetManager
return ____exports