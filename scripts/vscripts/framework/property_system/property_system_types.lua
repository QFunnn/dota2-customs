--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "framework/property_system/property_system_types"
PropertyScope = PropertyScope or {}
PropertyScope.UNIT = 0
PropertyScope[PropertyScope.UNIT] = "UNIT"
PropertyScope.PLAYER = 1
PropertyScope[PropertyScope.PLAYER] = "PLAYER"
PropertyValueType = PropertyValueType or {}
PropertyValueType.NUMBER = 0
PropertyValueType[PropertyValueType.NUMBER] = "NUMBER"
PropertyValueType.PERCENTAGE = 1
PropertyValueType[PropertyValueType.PERCENTAGE] = "PERCENTAGE"
PropertyValueType.BOOLEAN = 2
PropertyValueType[PropertyValueType.BOOLEAN] = "BOOLEAN"
PropertyValueType.CUSTOM = 3
PropertyValueType[PropertyValueType.CUSTOM] = "CUSTOM"
AggregationStrategy = AggregationStrategy or {}
AggregationStrategy.SUM = 0
AggregationStrategy[AggregationStrategy.SUM] = "SUM"
AggregationStrategy.MULTIPLY = 1
AggregationStrategy[AggregationStrategy.MULTIPLY] = "MULTIPLY"
AggregationStrategy.DECMUL = 2
AggregationStrategy[AggregationStrategy.DECMUL] = "DECMUL"
AggregationStrategy.MAX = 3
AggregationStrategy[AggregationStrategy.MAX] = "MAX"
AggregationStrategy.MIN = 4
AggregationStrategy[AggregationStrategy.MIN] = "MIN"
AggregationStrategy.FIRST = 5
AggregationStrategy[AggregationStrategy.FIRST] = "FIRST"
AggregationStrategy.LAST = 6
AggregationStrategy[AggregationStrategy.LAST] = "LAST"
AggregationStrategy.CUSTOM = 7
AggregationStrategy[AggregationStrategy.CUSTOM] = "CUSTOM"