--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
function isValidAbilityIndex(index) {
    return index != null && index !== -1;
}
function isValidEntityIndex(index) {
    return index != null && index !== -1;
}
function asWorldPosition(value) {
    return value !== null && value !== void 0 ? value : [0, 0, 0];
}
function makeVectorOrderKey(abilityIndex) {
    return String(abilityIndex);
}
function hasFlag(value, flag) {
    return (value & flag) === flag;
}
function distance(a, b) {
    const x = a[0] - b[0];
    const y = a[1] - b[1];
    const z = a[2] - b[2];
    return Math.sqrt(x * x + y * y + z * z);
}
function firstMouseTarget(screenPos) {
    const targets = GameUI.FindScreenEntities(screenPos);
    for (const ent of targets) {
        if (ent.accurateCollision) {
            return ent.entityIndex;
        }
    }
    return targets.length > 0 ? targets[0].entityIndex : -1;
}
function getCursorTarget(abilityIndex) {
    const cursorPos = GameUI.GetCursorPosition();
    const entityTarget = firstMouseTarget(cursorPos);
    let treeTarget;
    let result = -1;
    let isTree = false;
    const targetType = Abilities.GetAbilityTargetType(abilityIndex);
    if (hasFlag(targetType, DOTA_UNIT_TARGET_TYPE.DOTA_UNIT_TARGET_TREE)) {
        let trees = Entities.GetAllEntitiesByClassname("ent_dota_tree");
        if (trees.length > 0) {
            const world = asWorldPosition(GameUI.GetScreenWorldPosition(cursorPos));
            trees = trees.filter((tree) => distance(world, Entities.GetAbsOrigin(tree)) < 100);
            trees.sort((a, b) => {
                return distance(world, Entities.GetAbsOrigin(a)) - distance(world, Entities.GetAbsOrigin(b));
            });
            if (trees[0]) {
                treeTarget = trees[0];
            }
        }
    }
    if (hasFlag(targetType, DOTA_UNIT_TARGET_TYPE.DOTA_UNIT_TARGET_TREE) &&
        (targetType ^ DOTA_UNIT_TARGET_TYPE.DOTA_UNIT_TARGET_TREE) > 0) {
        if (isValidEntityIndex(entityTarget) && treeTarget) {
            const world = asWorldPosition(GameUI.GetScreenWorldPosition(cursorPos));
            if (distance(world, Entities.GetAbsOrigin(entityTarget)) <=
                distance(world, Entities.GetAbsOrigin(treeTarget))) {
                result = entityTarget;
            }
            else {
                result = treeTarget;
                isTree = true;
            }
        }
        else if (isValidEntityIndex(entityTarget)) {
            result = entityTarget;
        }
        else if (treeTarget) {
            result = treeTarget;
            isTree = true;
        }
    }
    else if ((targetType ^ DOTA_UNIT_TARGET_TYPE.DOTA_UNIT_TARGET_TREE) > 0) {
        result = entityTarget;
    }
    return [result, isTree];
}
function isBehaviorAvailable(order, behavior, needed) {
    if (!order.OrderType) {
        return hasFlag(behavior, needed);
    }
    return false;
}
function canCast(abilityIndex, casterIndex) {
    if (!isValidAbilityIndex(abilityIndex)) {
        return false;
    }
    if (!isValidEntityIndex(casterIndex)) {
        return false;
    }
    if (!Abilities.AbilityReady(abilityIndex)) {
        return false;
    }
    if (Abilities.GetLevel(abilityIndex) <= 0) {
        return false;
    }
    if (Abilities.IsPassive(abilityIndex)) {
        return false;
    }
    if (!Entities.IsControllableByPlayer(casterIndex, Players.GetLocalPlayer())) {
        return false;
    }
    if (!Abilities.IsCooldownReady(abilityIndex)) {
        return false;
    }
    if (!Abilities.IsOwnersGoldEnough(abilityIndex)) {
        return false;
    }
    return true;
}
function prepareOrder(order) {
    if (!order.OrderType) {
        return false;
    }
    Game.PrepareUnitOrders(order);
    return true;
}
(function () {
    const cfg = GameUI.CustomUIConfig();
    if (cfg.QuickcastHelper) {
        return;
    }
    const vectorOrders = {};
    function castAbility(abilityIndex, casterIndex, quickcast, shift, keyDown) {
        if (!canCast(abilityIndex, casterIndex)) {
            return false;
        }
        if (!isValidAbilityIndex(abilityIndex) || !isValidEntityIndex(casterIndex)) {
            return false;
        }
        if (!quickcast && keyDown) {
            Abilities.ExecuteAbility(abilityIndex, casterIndex, false);
            return true;
        }
        const order = {
            AbilityIndex: abilityIndex,
            UnitIndex: casterIndex,
        };
        const vectorOrder = {
            AbilityIndex: abilityIndex,
            UnitIndex: casterIndex,
        };
        const behavior = Abilities.GetBehavior(abilityIndex);
        const cursorPos = GameUI.GetCursorPosition();
        if (isBehaviorAvailable(order, behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ||
            (isBehaviorAvailable(order, behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_OPTIONAL_UNIT_TARGET) &&
                GameUI.IsControlDown())) {
            const [targetIndex, isTreeTarget] = getCursorTarget(abilityIndex);
            if (isValidEntityIndex(targetIndex)) {
                order.OrderType = isTreeTarget
                    ? dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TARGET_TREE
                    : dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TARGET;
                order.TargetIndex = targetIndex;
                if (keyDown && hasFlag(behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING)) {
                    vectorOrder.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_VECTOR_TARGET_POSITION;
                    vectorOrder.Position = Entities.GetAbsOrigin(targetIndex);
                    vectorOrder.TargetIndex = targetIndex;
                }
            }
            if (hasFlag(behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING)) {
                order.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TARGET;
                const world = GameUI.GetScreenWorldPosition(cursorPos);
                if (world) {
                    order.Position = world;
                }
            }
            if (hasFlag(behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING)) {
                if (keyDown) {
                    vectorOrder.OrderTypeOld = isTreeTarget
                        ? dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TARGET_TREE
                        : dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TARGET;
                }
                order.OrderType = isTreeTarget
                    ? dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TARGET_TREE
                    : dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TARGET;
                const world = GameUI.GetScreenWorldPosition(cursorPos);
                if (world) {
                    order.Position = world;
                    vectorOrder.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_VECTOR_TARGET_POSITION;
                    vectorOrder.Position = world;
                    if (order.TargetIndex) {
                        vectorOrder.TargetIndex = order.TargetIndex;
                    }
                }
            }
        }
        if (isBehaviorAvailable(order, behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_POINT)) {
            const world = GameUI.GetScreenWorldPosition(cursorPos);
            if (world) {
                order.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_CAST_POSITION;
                if (hasFlag(behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING)) {
                    vectorOrder.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_VECTOR_TARGET_POSITION;
                    vectorOrder.TargetIndex = casterIndex;
                    vectorOrder.Position = world;
                }
                order.Position = world;
            }
        }
        if (isBehaviorAvailable(order, behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_TOGGLE)) {
            order.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TOGGLE;
        }
        if (isBehaviorAvailable(order, behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_NO_TARGET)) {
            order.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_CAST_NO_TARGET;
        }
        if (!order.OrderType) {
            return false;
        }
        if (shift) {
            Game.PrepareUnitOrders({
                OrderType: dotaunitorder_t.DOTA_UNIT_ORDER_STOP,
                TargetIndex: casterIndex,
                QueueBehavior: OrderQueueBehavior_t.DOTA_ORDER_QUEUE_NEVER,
            });
        }
        if (keyDown) {
            if (hasFlag(behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING)) {
                vectorOrders[makeVectorOrderKey(abilityIndex)] = vectorOrder;
            }
            else {
                prepareOrder(order);
            }
            return true;
        }
        if (hasFlag(behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING)) {
            if (hasFlag(behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_POINT)) {
                const stored = vectorOrders[makeVectorOrderKey(abilityIndex)];
                if (stored) {
                    const savedPos = stored.Position;
                    stored.Position = order.Position;
                    prepareOrder(stored);
                    order.Position = savedPos;
                }
                prepareOrder(order);
                return true;
            }
            if (hasFlag(behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET)) {
                const stored = vectorOrders[makeVectorOrderKey(abilityIndex)];
                if (stored) {
                    stored.Position = order.Position;
                    prepareOrder(stored);
                    order.TargetIndex = stored.TargetIndex;
                    if (stored.OrderTypeOld) {
                        order.OrderType = stored.OrderTypeOld;
                    }
                    prepareOrder(order);
                    return true;
                }
            }
        }
        return true;
    }
    function bindKey(keyName, onPressState) {
        if (!keyName || typeof onPressState !== "function") {
            return undefined;
        }
        const commandName = "QuickcastHelper_" + Math.floor(Math.random() * 99999999);
        Game.CreateCustomKeyBind(keyName.toUpperCase(), "+" + commandName);
        Game.AddCommand("+" + commandName, () => {
            onPressState(true);
        }, "", 0);
        Game.AddCommand("-" + commandName, () => {
            onPressState(false);
        }, "", 0);
        return commandName;
    }
    cfg.QuickcastHelper = {
        CastAbility: castAbility,
        BindKey: bindKey,
    };
})();