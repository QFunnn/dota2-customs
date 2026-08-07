--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


# 行为树系统说明文档

## 概述

本目录包含了Dota 2自定义游戏中使用的所有行为树配置文件。行为树是一种用于控制NPC（非玩家角色）AI行为的树状结构系统，通过不同的节点类型和组合方式实现复杂的AI逻辑。

## 文件列表

### 1. `melee_creep.btree` - 巡逻追击AI
**适用单位**: 基础近战小兵

**功能特点**:
- 检测敌人并追击，否则巡逻
- 800单位索敌范围
- 使用`enemy_melee_attack`技能进行攻击

**结构分析**:
```
Root (巡逻追击AI)
└── MainSelector (主选择器)
    ├── CombatSequence (战斗序列)
    │   ├── CheckEnemy (HasEnemy) - 检查800范围内敌人
    │   ├── MoveToTarget (MoveToEnemy) - 移动到敌人身边
    │   └── AbilityTarget (Ability) - 释放enemy_melee_attack技能
    └── PatrolAction (Patrol) - 在区域内巡逻
```

---

### 2. `melee_ability_attack.btree` - 普攻-技能-巡逻AI
**适用单位**: 具备技能的近战单位

**功能特点**:
- 优先释放技能，技能不可用时进行普通攻击
- 800单位索敌范围
- 智能技能选择机制

**结构分析**:
```
Root (普攻-技能-巡逻AI)
└── MainSelector (主选择器)
    ├── CombatSequence (战斗序列)
    │   ├── CheckEnemy (是否有敌人) - 检查800范围内敌人
    │   └── BattleSelector (技能-攻击选择器)
    │       ├── AbilitySequence (技能序列)
    │       │   ├── CheckAbilityStatus (检查技能状态)
    │       │   └── SpellAbility (释放技能)
    │       ├── AttackSequence (攻击序列)
    │       │   ├── CheckAttackStatus (检查攻击状态)
    │       │   └── Attack (攻击)
    │       └── MoveToEnemy (追击敌人)
    └── Patrol (巡逻)
```

---

### 3. `test.btree` - 测试用巡逻追击AI
**适用单位**: 测试单位、基础怪物

**功能特点**:
- 简化的战斗逻辑
- 800单位索敌范围
- 基础的攻击和移动行为

**结构分析**:
```
Root (巡逻追击AI)
└── MainSelector (主选择器)
    ├── CombatSequence (战斗序列)
    │   ├── CheckEnemy (HasEnemy) - 检查800范围内敌人
    │   └── BattleSelector (战斗选择器)
    │       ├── AttackSequence (攻击序列)
    │       │   ├── CheckAttackStatus (检查攻击状态)
    │       │   └── Attack (Attack)
    │       └── MoveToEnemy (MoveToEnemy)
    └── Patrol (Patrol)
```

---

### 4. `melee_attack.btree` - 近战攻击AI
**适用单位**: 纯近战攻击单位

**功能特点**:
- 专注于近战攻击
- 800单位索敌范围
- 简化的战斗流程

**结构分析**:
```
Root (巡逻追击AI)
└── MainSelector (主选择器)
    ├── CombatSequence (战斗序列)
    │   ├── CheckEnemy (HasEnemy) - 检查800范围内敌人
    │   └── BattleSelector (战斗选择器)
    │       ├── AttackSequence (攻击序列)
    │       │   ├── CheckAttackStatus (检查攻击状态)
    │       │   └── Attack (Attack)
    │       └── MoveToEnemy (MoveToEnemy)
    └── Patrol (Patrol)
```

---

### 5. `range_ability.btree` - 远程单位技能AI
**适用单位**: 具备技能的远程单位

**功能特点**:
- 优先释放技能
- 技能不可用时逃离敌人
- 800单位索敌范围

**结构分析**:
```
Root (远程单位技能AI)
└── MainSelector (主选择器)
    ├── CombatSequence (战斗序列)
    │   ├── CheckEnemy (HasEnemy) - 检查800范围内敌人
    │   └── BattleSelector (战斗选择器)
    │       ├── AbilitySequence (技能序列)
    │       │   ├── CheckAbilityStatus (检查技能状态)
    │       │   └── SpellAbility (释放自己的技能)
    │       └── EscapeFromEnemy (逃离敌人警戒范围)
    └── Patrol (巡逻)
```

---

### 6. `range_attack.btree` - 远程攻击AI ⭐
**适用单位**: 远程攻击单位 (弓箭手、法师等)

**功能特点**:
- 智能的远程攻击行为
- **已优化**: 使用`MoveToAttackPosition`寻找最佳攻击距离
- 800单位索敌范围
- 包含微调移动机制，避免单位呆立

**结构分析**:
```
Root (远程攻击)
└── MainSelector (主选择器)
    ├── CombatSequence (战斗序列)
    │   ├── CheckEnemy (HasEnemy) - 检查800范围内敌人
    │   └── BattleSelector (战斗选择器)
    │       ├── AttackSequence (攻击序列)
    │       │   ├── CheckAttackStatus (检查攻击状态)
    │       │   └── Attack (Attack)
    │       └── MoveToAttackPosition (寻找最佳攻击位置) 🆕
    └── Patrol (巡逻)
```

## 节点类型说明

### 基础节点类型

#### 1. **Root** - 根节点
- 行为树的入口点
- 只能有一个子节点

#### 2. **Selector** - 选择器节点
- 按顺序尝试执行子节点
- **成功**: 遇到第一个成功的子节点时返回成功
- **失败**: 所有子节点都失败时返回失败

#### 3. **Sequence** - 序列节点
- 按顺序执行所有子节点
- **成功**: 所有子节点都成功时返回成功
- **失败**: 遇到第一个失败的子节点时返回失败

#### 4. **Condition** - 条件节点
- 检查特定条件是否满足
- 通常用于检测敌人、距离、状态等

#### 5. **Action** - 动作节点
- 执行具体的AI行为
- 如移动、攻击、释放技能、巡逻等

### 常用Action节点

| 节点名称 | 功能描述 | 参数 |
|---------|---------|------|
| `Patrol` | 在区域内巡逻 | 无 |
| `MoveToEnemy` | 移动到敌人位置 | 无 |
| `Attack` | 攻击目标 | 无 |
| `Ability` | 释放指定技能 | `ability_name` |
| `SpellAbility` | 释放自己的技能 | 无 |
| `CheckAttackStatus` | 检查攻击状态 | 无 |
| `CheckAbilityStatus` | 检查技能状态 | 无 |
| `MoveToAttackPosition` | 寻找最佳攻击位置 | 无 🆕 |
| `EscapeFromEnemy` | 逃离敌人 | 无 |

## 优化建议

### 1. 远程攻击行为优化 ✅
- `range_attack.btree` 已更新使用 `MoveToAttackPosition` 节点
- 实现了最佳攻击距离控制 (70%-90%攻击范围)
- 添加了微调移动机制，避免单位呆立

### 2. 待优化项目
- `range_ability.btree` 中的逃离逻辑可能需要优化
- 可以考虑为更多远程单位应用新的移动逻辑
- 统一格式和命名规范

## 文件格式说明

行为树文件采用JSON格式，包含以下主要字段：
- `Type`: 节点类型
- `Name`: 节点名称 (中文描述)
- `Description`: 节点功能描述
- `X`, `Y`: 可视化编辑器中的坐标位置
- `Index`: 子节点索引
- `Params`: 节点参数
- `Children`: 子节点列表

---

**最后更新**: 2025-12-09
**版本**: 1.0
**维护者**: Claude Code Assistant