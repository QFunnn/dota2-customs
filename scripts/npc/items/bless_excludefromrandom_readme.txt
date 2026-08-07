--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


祝福系统配置说明 - ExcludeFromRandom 配置项
================================================================================

功能说明：
-----------
ExcludeFromRandom 配置项用于标记某些祝福不加入随机池。
标记为 ExcludeFromRandom 的祝福无法通过 DrawBless 随机获取，
但仍可以通过 AddBless 等其他方式直接添加到玩家身上。

使用场景：
1. 某些特殊的祝福只能通过特定方式获得（如完成任务、击败特定BOSS等）
2. 某些祝福过于强大，不适合随机获取
3. 某些祝福需要手动添加进行测试

配置方法：
-----------
在 bless.kv 文件中的祝福配置项中添加：

    "ExcludeFromRandom"     "1"

配置示例：
-----------
以下是一个完整的配置示例：

"item_special_boss_reward"
{
    "Note"                  "BOSS奖励祝福"
    "Description"           "击败特定BOSS后获得的特殊祝福"
    "AbilityTextureName"    "example_texture"
    "Suit"                  "Special"
    "RarityRange"           "1|2|3|4"
    "AbilityValues"
    {
        "damage"            "10 20 30 40"
    }
    "ScriptFile"            "abilities/bless/item_special_boss_reward"
    "BaseClass"             "item_lua"
    "RequireBless1"         ""
    "RequireBless2"         ""
    "GlobalUnique"          "0"
    "ExcludeFromRandom"     "1"              // 关键配置：不加入随机池
    "Access"                "Bless"
    "AbilityBehavior"       "DOTA_ABILITY_BEHAVIOR_PASSIVE"
}

技术实现：
-----------
代码位置：content/c1/scripts/vscripts/mechanics/bless.ts

1. BlessPrerequire 接口新增 excludeFromRandom 字段（第14行）
2. ParseBlessKv 函数解析 KV 配置（第102-107行）
3. DrawBless 函数应用排除逻辑（第207-212行）

注意事项：
-----------
1. ExcludeFromRandom 的值设为非空或非0即可生效（通常使用 "1"）
2. 该配置项与 RequireBless/GlobalUnique 等其他配置项可以同时使用
3. 标记为 ExcludeFromRandom 的祝福仍会显示在祝福列表中，只是无法随机获取
4. 如需完全隐藏祝福，需要配合其他机制实现

================================================================================
更新日期：2025
================================================================================