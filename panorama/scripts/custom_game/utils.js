--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function EmitErrorToPlayer(errorText, errorSound){
    GameUI.SendCustomHUDError( errorText, errorSound )
}

function SubscribeAndFireNetTableByKey(tableName, keyName, callback){
	const currentValue = CustomNetTables.GetTableValue(tableName, keyName);
	if (currentValue) {
		callback(currentValue);
	}
	return CustomNetTables.SubscribeNetTableListener(tableName, (name, key, values) => {
		if (key == keyName) {
			callback(values);
		}
	});
}

function SubscribeAndFirePlayerTableByKey(tableName, keyName, callback){
    if(!GameUI.CustomUIConfig().PlayerTables){return -1}
    
	const currentValue = GameUI.CustomUIConfig().PlayerTables.GetTableValue(tableName, keyName);
	if (currentValue) {
		callback(currentValue);
	}
	return GameUI.CustomUIConfig().PlayerTables.SubscribeNetTableListener(tableName, (name, changes, deletions) => {
		if (changes[keyName] || deletions[keyName]) {
            let bIsChanges = Count(changes[keyName]) != 0
            let Values = bIsChanges ? changes[keyName] : {}
			callback(Values, !bIsChanges);
		}
	});
}

function SubscribeAndFirePlayerTable(tableName, callback){
	const currentValue = GameUI.CustomUIConfig().PlayerTables.GetAllTableValues(tableName);
	if (currentValue) {
		callback(currentValue);
	}
	return GameUI.CustomUIConfig().PlayerTables.SubscribeNetTableListener(tableName, (name, changes, deletions) => {
		if (tableName == name) {
            let Values = GameUI.CustomUIConfig().PlayerTables.GetAllTableValues(tableName)
            if(Values != undefined){
                callback(Values);
            }
		}
	});
}

function GetPlayerTablesValue(tableName, key){
    const value = GameUI.CustomUIConfig().PlayerTables.GetTableValue(tableName, key)
    if(value){
        return value
    }

    return undefined
}

function GetAllPlayerTableValues(tableName){
    if(GameUI.CustomUIConfig().PlayerTables != undefined){
        return GameUI.CustomUIConfig().PlayerTables.GetAllTableValues(tableName)
    }

    return {}
}

function UnsubscribeFromPlayerTable(Sub){
    GameUI.CustomUIConfig().PlayerTables.UnsubscribeNetTableListener(Sub)
}

function GetPlayerRating(PlayerID){
    let info = CustomNetTables.GetTableValue("players_server_info", `player_${PlayerID}`)
    if(!info || !info.profile){return 3000}

    return info.profile.rating
}

let OTHER_ABILITIES_LIST = {}
SubscribeAndFirePlayerTableByKey("globals", "other_abilities_list", function(v){
    OTHER_ABILITIES_LIST = v
})

let INNATE_ABILITIES = {}
SubscribeAndFirePlayerTableByKey("globals", "innate_abilities", function(v){
    INNATE_ABILITIES = v
})

function IsInnateAbility(AbilityName){
    return INNATE_ABILITIES[AbilityName] != undefined
}

function IsOtherAbility(AbilityName){
    return OTHER_ABILITIES_LIST[AbilityName] != undefined
}

function IsPlayerBattlePassSubscribedInTable(Table){
    if (Game.IsInToolsMode()) return true
    return (Table != undefined && Table.profile != undefined && Table.profile.battle_pass != undefined && Table.profile.battle_pass.status == 1)
}

function IsPlayerBattlePassSubscribed(PlayerID){
    if (Game.IsInToolsMode()) return true
    let info = CustomNetTables.GetTableValue("players_server_info", `player_${PlayerID}`)
    return (info != undefined && info.profile != undefined && info.profile.battle_pass != undefined && info.profile.battle_pass.status == 1)
}

let PLAYERS_ITEMS_LISTS = {}
for (const PlayerID of Game.GetAllPlayerIDs()) {
    PLAYERS_ITEMS_LISTS[PlayerID] = {}
    SubscribeAndFireNetTableByKey(`players_server_info`, `player_${PlayerID}`, function(v){
        if(v.player_owned_items){
            PLAYERS_ITEMS_LISTS[PlayerID]["owned"] = toArray(v.player_owned_items)
        }
        if(v.player_items_slots){
            PLAYERS_ITEMS_LISTS[PlayerID]["slots"] = v.player_items_slots
        }
    })
}

function PlayerHasItem(PlayerID, ItemName){
    if(PLAYERS_ITEMS_LISTS[PlayerID]){
        for (const ItemInfo of PLAYERS_ITEMS_LISTS[PlayerID]["owned"]) {
            if(ItemInfo.item_name == ItemName){
                return true
            }
        }
    }

    return false
}

function IsItemWeared(PlayerID, ItemName){
    if(PLAYERS_ITEMS_LISTS[PlayerID] && PlayerHasItem(PlayerID, ItemName)){
        for (const SlotName in PLAYERS_ITEMS_LISTS[PlayerID]["slots"]) {
            if(PLAYERS_ITEMS_LISTS[PlayerID]["slots"][SlotName] == ItemName){
                return true
            }
        }
    }

    return false
}

function GetPlayerSlotItemName(PlayerID, SlotName){
    if(PLAYERS_ITEMS_LISTS[PlayerID]){
        if(PLAYERS_ITEMS_LISTS[PlayerID]["slots"][SlotName] != undefined){
            if(PlayerHasItem(PlayerID, PLAYERS_ITEMS_LISTS[PlayerID]["slots"][SlotName])){
                return PLAYERS_ITEMS_LISTS[PlayerID]["slots"][SlotName]
            }
        }
    }

    return undefined
}

function GetPlayerSlotItem(PlayerID, SlotName){
    if(PLAYERS_ITEMS_LISTS[PlayerID]){
        if(PLAYERS_ITEMS_LISTS[PlayerID]["slots"][SlotName] != undefined){
            return GetPlayerItemByName(PlayerID, PLAYERS_ITEMS_LISTS[PlayerID]["slots"][SlotName])
        }
    }

    return undefined
}

let GLOBAL_ITEMS_LIST = {}
SubscribeAndFirePlayerTableByKey(`items`, `list`, function(v){
    GLOBAL_ITEMS_LIST = v
})

function GetItemInfo(ItemName){
    return GLOBAL_ITEMS_LIST[ItemName]
}

function GetPlayerItemByName(PlayerID, ItemName){
    if(!PlayerHasItem(PlayerID, ItemName)){return}

    if(PLAYERS_ITEMS_LISTS[PlayerID]){
        for (const ItemInfo of PLAYERS_ITEMS_LISTS[PlayerID]["owned"]) {
            if(ItemInfo.item_name == ItemName){
                return ItemInfo
            }
        }
    }

    return
}

function SetupPlayerHeroIcon(PlayerID, Container){
    let PlayerHeroIconContainer = Container.FindChildTraverse("HeroIconEffect")
    let ItemName = GetPlayerSlotItemName(PlayerID, "icons")

    if(PlayerHeroIconContainer){
        if(Container._SetupedPlayerHeroIcon != ItemName){
            PlayerHeroIconContainer.RemoveAndDeleteChildren()
        }

        Container._SetupedPlayerHeroIcon = ItemName

        if(ItemName != undefined){
            let ItemInfo = GetItemInfo(ItemName)
            if(!ItemInfo){return}

            let pFx = PlayerHeroIconContainer.FindChildTraverse("PlayerEffect")
            if(pFx){

            }else{
                let EffectName = ItemInfo.game_value
                $.CreatePanel("DOTAParticleScenePanel", PlayerHeroIconContainer, "PlayerEffect", {
                    class: "PlayerHeroIconFX",
                    hittest: "false",
                    particleName: EffectName,
                    startActive: "true",
                    particleonly: "false",
                    cameraOrigin: "0 0 180",
                    lookAt: "0 0 0",
                    fov: "55",
                    squarePixels: "true",
                    drawbackground: "true"
                });
            }
        }
    }
}

function DeleteAllChildren(p) {
    if(p != null){
        let count = p.GetChildCount();
        if (count > 0) {
            for (let i = 0; i < count; i++) {
                let child = p.GetChild(i);
                if (child != undefined) {
                    child.DeleteAsync(0.0);
                }
            }
        }
    }
}

function SafeDeleteAsync(p){
    if(p && p.IsValid()){
        p.DeleteAsync(0)
    }
}

function GetTimeString(nTime) {
    var Time = Math.floor(nTime);
    var minutes = Math.floor(Time / 60);
    var del = "";
    if (minutes < 10) {
        del = "0";
    }
    var seconds = Time - minutes * 60;
    var del2 = "";
    if (seconds < 10) {
        del2 = "0";
    }
    let TimeText = del + minutes + ":" + del2 + seconds;
    return TimeText;
}

function toArray(obj) {
    const result = [];
    let key = 1;
    while (obj[key] != undefined) {
        result.push(obj[key]);
        key++;
    }
    return result;
}

function GetDotaHud() {
	var rootUI = $.GetContextPanel();
	while (rootUI.id != "Hud" && rootUI.GetParent() != null) {
		rootUI = rootUI.GetParent();
	}
	return rootUI;
}

let ITEMS_IDS = {}

SubscribeAndFirePlayerTableByKey("globals", "items_info", function(v){
    ITEMS_IDS = v
})

function GetItemID(ItemName){
    return ITEMS_IDS[ItemName]
}

let NEUTRAL_ITEMS_LIST = []

SubscribeAndFirePlayerTableByKey("globals", "neutrals", function(v){
    NEUTRAL_ITEMS_LIST = toArray(v)
})

function ItemIsNeutral(ItemName){
    return NEUTRAL_ITEMS_LIST.includes(ItemName)
}

let NEUTRAL_ROUNDS = []

SubscribeAndFirePlayerTableByKey("globals", "neutrals_rounds", function(v){
    NEUTRAL_ROUNDS = toArray(v)
})

function GetNeutralRound(Tier){
    return NEUTRAL_ROUNDS[Tier-1] || 0
}

function ToAbsPixelValue(value){
    return Math.floor((1 / $.GetContextPanel().actualuiscale_x) * value);
}

function GetAbsPanelBounds(panel){
    let windowPosition = panel.GetPositionWithinWindow();
    let posX = ToAbsPixelValue(windowPosition.x);
    let poxY = ToAbsPixelValue(windowPosition.y);
    let height = ToAbsPixelValue(panel.actuallayoutheight);
    let width = ToAbsPixelValue(panel.actuallayoutwidth);

    return {
        minX: posX,
        maxX: posX + width,
        minY: poxY,
        maxY: poxY + height,
    };
}

function GetDateString(Date, bTime){
    if(!Date){
        return ""
    }
    let DateAndTime = Date.split(" ")
    if(!DateAndTime[0]){
        return ""
    }

    let Day = DateAndTime[0].split("-")[2]
    let Month = DateAndTime[0].split("-")[1]
    let Year = DateAndTime[0].split("-")[0]

    let Time = " "

    if(DateAndTime[1] && bTime){
        Time = " " + DateAndTime[1].split(":")[0] + ":" + DateAndTime[1].split(":")[1]
    }

    return `${Day}.${Month}.${Year}${Time}`
}

function FindParentByID(panel, id){
    var FindedPanel = panel
	while (FindedPanel.id != id && FindedPanel.GetParent() != null) {
		FindedPanel = FindedPanel.GetParent();
	}

    if(FindedPanel.id != id){return undefined}

	return FindedPanel;
}



function GetRGBPlayerColor(PID) {
    let color = Players.GetPlayerColor(PID);
    let RGB = { r: 0, g: 0, b: 0 };
    if (color >= 0) {
        let red = color & 255;
        let green = color >> 8 & 255;
        let blue = color >> 16 & 255;
        RGB = { r: red, g: green, b: blue };
        return RGB;
    }
    return RGB;
}
function GetHEXPlayerColor(PID) {
    var Color = Players.GetPlayerColor(PID).toString(16);
    return Color == null
        ? "#000000"
        : "#" +
            Color.substring(6, 8) +
            Color.substring(4, 6) +
            Color.substring(2, 4) +
            Color.substring(0, 2);
}

function filterItems(items, conditions) {
	if(conditions.length == 0){
		return items
	}
	return items.filter(item =>
		conditions.every(cond => cond(item))
	);
}

function withAlpha(hex, alpha) {
    let c = hex.replace("#", "");
    if (c.length === 3) c = c.split("").map(x => x+x).join("");

    const r = parseInt(c.slice(0, 2), 16);
    const g = parseInt(c.slice(2, 4), 16);
    const b = parseInt(c.slice(4, 6), 16);

    return `rgba(${r}, ${g}, ${b}, ${alpha})`;
}








function hasSome(n1, n2){
    return (n1 & n2) == n2
}

function Distance(pos1, pos2){
    let a = pos1[0] - pos2[0]
    let b = pos1[1] - pos2[1]
    let c = pos1[2] - pos2[2]

    let dist = Math.sqrt(a*a + b*b + c*c)
    return dist
}

function Count(array){
    let c = 0
    for (const k in array) {
        c++;
    }
    return c
}

let util_abilities = {}

function CastAbility(Ability, PlayerHero, quickcast, shift, button_down) {
    if (!Ability) {return;};
    if (!Abilities.AbilityReady(Ability)) {return;};
    if (Abilities.GetLevel(Ability) <= 0) {return;};
    if (Abilities.IsPassive(Ability)) {return;};
    if (!Entities.IsControllableByPlayer(PlayerHero, Players.GetLocalPlayer())) {return;};
    if (!Abilities.IsCooldownReady(Ability)) {return;};
    if (!Abilities.IsOwnersGoldEnough(Ability)) {return;};
    
    if (!quickcast && button_down) {
        Abilities.ExecuteAbility(Ability, PlayerHero, false);
        return;
    }
    let order = {
        AbilityIndex: Ability,
        UnitIndex: PlayerHero,
    };
    let VectorOrder = {
        AbilityIndex: Ability,
        UnitIndex: PlayerHero,
    };
    
    let Behavior = Abilities.GetBehavior(Ability);
    let CursorPos = GameUI.GetCursorPosition();
    if (UniqIsThisAbilityIs(order, Behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ||
        (UniqIsThisAbilityIs(order, Behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_OPTIONAL_UNIT_TARGET) && GameUI.IsControlDown())) {
        let [CursorTarget, IsTreeTarget] = GetAbilityCursorTarget(Ability);
        CursorTarget = CursorTarget;
        IsTreeTarget = IsTreeTarget;
        if (CursorTarget != -1) {
            if (IsTreeTarget) {
                order.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TARGET_TREE;
                order.TargetIndex = CursorTarget;
            }
            else {
                order.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TARGET;
                order.TargetIndex = CursorTarget;
            }
            if (button_down) {
                if (hasSome(Behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING)) {
                    VectorOrder.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_VECTOR_TARGET_POSITION;
                    VectorOrder.Position = Entities.GetAbsOrigin(CursorTarget);
                    VectorOrder.TargetIndex = CursorTarget;
                }
            }
        }
        if (hasSome(Behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING)) {
            order.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TARGET;
            let World = GameUI.GetScreenWorldPosition(CursorPos);
            if (World) {
                order.Position = World;
            }
        }
        if (hasSome(Behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING)) {
            if (button_down) {
                VectorOrder.OrderTypeOld = IsTreeTarget ? dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TARGET_TREE : dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TARGET;
            }
            order.OrderType = IsTreeTarget ? dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TARGET_TREE : dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TARGET;
            let World = GameUI.GetScreenWorldPosition(CursorPos);
            if (World) {
                order.Position = World;
                VectorOrder.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_VECTOR_TARGET_POSITION;
                VectorOrder.Position = World;
                if (order.TargetIndex) {
                    VectorOrder.TargetIndex = order.TargetIndex;
                }
            }
        }
    }
    if (UniqIsThisAbilityIs(order, Behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_POINT)) {
        let World = GameUI.GetScreenWorldPosition(CursorPos);
        if (World) {
            order.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_CAST_POSITION;
            if (hasSome(Behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING)) {
                VectorOrder.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_VECTOR_TARGET_POSITION;
                VectorOrder.TargetIndex = PlayerHero;
                VectorOrder.Position = World;
            }
            order.Position = World;
        }
    }
    if (UniqIsThisAbilityIs(order, Behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_TOGGLE)) {
        order.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TOGGLE;
    }
    if (UniqIsThisAbilityIs(order, Behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_NO_TARGET)) {
        order.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_CAST_NO_TARGET;
    }
    if (!order.OrderType) {
        return;
    }
    if (shift) {
        let orderStop = {
            OrderType: dotaunitorder_t.DOTA_UNIT_ORDER_STOP,
            TargetIndex: PlayerHero,
            QueueBehavior: OrderQueueBehavior_t.DOTA_ORDER_QUEUE_NEVER
        };
        Game.PrepareUnitOrders(orderStop);
    }
    if (button_down) {
        if (hasSome(Behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING)) {
            util_abilities[Ability] = VectorOrder;
        }
        else {
            Game.PrepareUnitOrders(order);
        }
    }
    else if (hasSome(Behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING)) {
        if (hasSome(Behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_POINT)) {
            if (util_abilities[Ability]) {
                let New = util_abilities[Ability];
                let VectorPos = New.Position;
                New.Position = order.Position;
                Game.PrepareUnitOrders(New);
                order.Position = VectorPos;
            }
            Game.PrepareUnitOrders(order);
        }
        else if (hasSome(Behavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET)) {
            let New = util_abilities[Ability];
            New.Position = order.Position;
            Game.PrepareUnitOrders(New);
            order.TargetIndex = New.TargetIndex;
            if (New.OrderTypeOld) {
                order.OrderType = New.OrderTypeOld;
            }
            Game.PrepareUnitOrders(order);
        }
    }
}

function GetAbilityCursorTarget(ability) {
    let CursorPos = GameUI.GetCursorPosition();
    let TargetEnt = GetMouseCastTarget(CursorPos);
    let TargetTree = undefined;
    let TargetType = Abilities.GetAbilityTargetType(ability);
    let isTreeTarget = false;
    let ResultTarget = -1;
    if (hasSome(TargetType, DOTA_UNIT_TARGET_TYPE.DOTA_UNIT_TARGET_TREE)) {
        let Targets = Entities.GetAllEntitiesByClassname("ent_dota_tree");
        if (Targets && Targets.length > 0) {
            let World = GameUI.GetScreenWorldPosition(CursorPos);
            if (World == null) {
                World = [0, 0, 0];
            }
            Targets = Targets.filter(tree => Distance(World, Entities.GetAbsOrigin(tree)) < 100);
            Targets.sort(function (a, b) {
                if (Distance(World, Entities.GetAbsOrigin(a)) < Distance(World, Entities.GetAbsOrigin(b)))
                    return -1;
                if (Distance(World, Entities.GetAbsOrigin(a)) > Distance(World, Entities.GetAbsOrigin(b)))
                    return 1;
                return 0;
            });
            if (Targets[0]) {
                TargetTree = Targets[0];
            }
        }
    }
    if (hasSome(TargetType, DOTA_UNIT_TARGET_TYPE.DOTA_UNIT_TARGET_TREE) &&
        (TargetType ^ DOTA_UNIT_TARGET_TYPE.DOTA_UNIT_TARGET_TREE) > 0) {
        if (TargetEnt != -1 && TargetTree) {
            let World = GameUI.GetScreenWorldPosition(CursorPos);
            if (World == null) {
                World = [0, 0, 0];
            }
            if (Distance(World, Entities.GetAbsOrigin(TargetEnt)) < Distance(World, Entities.GetAbsOrigin(TargetTree))) {
                ResultTarget = TargetEnt;
            }
            else {
                ResultTarget = TargetTree;
                isTreeTarget = true;
            }
        }
        else if (TargetEnt != -1) {
            ResultTarget = TargetEnt;
        }
        else if (TargetTree) {
            ResultTarget = TargetTree;
            isTreeTarget = true;
        }
    }
    else if ((TargetType ^ DOTA_UNIT_TARGET_TYPE.DOTA_UNIT_TARGET_TREE) > 0) {
        ResultTarget = TargetEnt;
    }
    return [ResultTarget, isTreeTarget];
}

function GetMouseCastTarget(pos) {
    let Targets = GameUI.FindScreenEntities(pos);
    for (const ent of Targets) {
        if (!ent.accurateCollision)
            continue;
        return ent.entityIndex;
    }
    return (Targets && Targets[0]) ? Targets[0].entityIndex : -1;
}


function UniqIsThisAbilityIs(order, List, Need){
    if(!order.OrderType){
        return hasSome(List, Need)
    }
    return false
}

function HasModifier(unit, name){
	for (var i = 0; i < Entities.GetNumBuffs(unit); i++) {
	    var buff = Entities.GetBuff(unit, i);
        var buffName = Buffs.GetName(unit, buff);

        if (name == buffName) {
        	return true
        }
	}
	return false
}

function GetModifierStackCount(unit, name){
    for (var i = 0; i < Entities.GetNumBuffs(unit); i++) {
	    var buff = Entities.GetBuff(unit, i);
        var buffName = Buffs.GetName(unit, buff);

        if (name == buffName) {
        	return Buffs.GetStackCount( unit, buff )
        }
	}
	return 0
}

function isNumeric(str) {
  if (typeof str != "string") return false
  return !isNaN(str) &&
         !isNaN(parseInt(str))
}













 














function FindDotaHudElement(id){
    var hudRoot = GetDotaHud()
    var comp = hudRoot.FindChildTraverse(id);
    return comp;
}

function FindDotaHudElementByClass(className){
    var hudRoot = GetDotaHud()
    var comp = hudRoot.FindChildrenWithClassTraverse(className);
    if (comp.length>0)
    {
        return comp[0];
    } 
    else 
    {
        return null;
    }
}

function ConvertToSteamid64(steamid32)
{
    var steamid64 = '765' + (parseInt(steamid32) + 61197960265728).toString();
    return steamid64;
}

function ConvertToSteamId32(steamid64) {
    return steamid64.substr(3) - 61197960265728;
}

function SendHudError(keys) {
    GameEvents.SendEventClientSide("dota_hud_error_message", {
        splitscreenplayer: 0,
        reason: 80,
        message: "#"+keys.message,
    });
}

function IsValidAbility(abilityIndex) 
{
    var result = false;
    var abilityName = Abilities.GetAbilityName(abilityIndex);
    if (abilityName!=null && abilityName != "" && abilityName.substring(0, 14) != "special_bonus_" && abilityName!= "generic_hidden" )
    {
        if (!Abilities.IsHidden(abilityIndex) && !IsOtherAbility(abilityName))
        {
           result = true;
        }
    }
    return result;
}

function GetImageRank(rating)
{
    if (rating >= 7000) {
        return "rank8_5"
    } else if (rating >= 6700) {
        return "rank8_4"
    } else if (rating >= 6400) {
        return "rank8_3"
    } else if (rating >= 6100) {
        return "rank8_2"
    } else if (rating >= 5800) {
        return "rank8_1"
    } else if (rating >= 5420) {
        return "rank7_5"
    } else if (rating >= 5220) {
        return "rank7_4"
    } else if (rating >= 5020) {
        return "rank7_3"
    } else if (rating >= 4820) {
        return "rank7_2"
    } else if (rating >= 4620) {
        return "rank7_1"
    } else if (rating >= 4460) {
        return "rank6_5"
    } else if (rating >= 4300) {
        return "rank6_4"
    } else if (rating >= 4150) {
        return "rank6_3"
    } else if (rating >= 4000) {
        return "rank6_2"
    } else if (rating >= 3850) {
        return "rank6_1"
    } else if (rating >= 3700) {
        return "rank5_5"
    } else if (rating >= 3540) {
       return  "rank5_4"
    } else if (rating >= 3390) {
        return "rank5_3"
    } else if (rating >= 3230) {
        return "rank5_2"
    } else if (rating >= 3080) {
        return "rank5_1"
    } else if (rating >= 2930) {
        return "rank4_5"
    } else if (rating >= 2770) {
        return "rank4_4"
    } else if (rating >= 2610) {
        return "rank4_3"
    } else if (rating >= 2450) {
        return "rank4_2"
    } else if (rating >= 2310) {
        return "rank4_1"
    } else if (rating >= 2150) {
        return "rank3_5"
    } else if (rating >= 2000) {
        return "rank3_4"
    } else if (rating >= 1850) {
        return "rank3_3"
    } else if (rating >= 1700) {
        return "rank3_2"
    } else if (rating >= 1540) {
        return "rank3_1"
    } else if (rating >= 1400) {
        return "rank2_5"
    } else if (rating >= 1230) {
        return "rank2_4"
    } else if (rating >= 1080) {
        return "rank2_3"
    } else if (rating >= 920) {
        return "rank2_2"
    } else if (rating >= 770) {
        return "rank2_1"
    } else if (rating >= 610) {
        return "rank1_5"
    } else if (rating >= 460) {
        return "rank1_4"
    } else if (rating >= 300) {
        return "rank1_3"
    } else if (rating >= 150) {
        return "rank1_2"
    } else if (rating <= 149) {
        return "rank1_1"
    }
}

function IsAllowForThis()
{
    var LocalPlayerInfo = CustomNetTables.GetTableValue("players_server_info", `player_${Players.GetLocalPlayer()}`)
    if (LocalPlayerInfo && LocalPlayerInfo.profile && (LocalPlayerInfo.profile.game_time > 12000 || LocalPlayerInfo.profile.total_games > 5))
    {
        return true
    }
    if (Game.IsInToolsMode())
    {
        return true
    }
    return false
}

(function () {
    GameEvents.Subscribe("SendHudError", SendHudError);
})();

function Fix(){}



















// ПЕРЕДВИЖЕНИЕ ПАНЕЛЕЙ



function SetupMovablePanel(root, movable, pos_config){
    root.pos_config = pos_config

    if(root.pos_config){
        $.Schedule(0.05, function(){
            AdjustMovablePanelPosition(root)
        })
    }

    $.RegisterEventHandler( 'DragStart', movable, function(a, dragCallbacks ){
        if(!GameUI.CustomUIConfig().TogglePanelsMove){return}
        
        let panel = $.CreatePanel("Panel", $.GetContextPanel(), "Drag_panel", {style: "width: 50px; height: 50px; background-color: rgba(0, 0, 0, 0.3); border: 3px solid white;"})
        panel.style.width = ToAbsPixelValue(root.actuallayoutwidth)+"px"
        panel.style.height = ToAbsPixelValue(root.actuallayoutheight)+"px"

        let PanelPos = root.GetPositionWithinWindow()
        let CursorPos = GameUI.GetCursorPosition()

        // $.Msg(ToAbsPixelValue(PanelPos.x), " ", ToAbsPixelValue(CursorPos[0]))

        let OffestX = CursorPos[0] - PanelPos.x
        let OffestY = CursorPos[1] - PanelPos.y

        panel.offsetX = OffestX
        panel.offsetY = OffestY

        dragCallbacks.displayPanel = panel;
        dragCallbacks.offsetX = OffestX;
        dragCallbacks.offsetY = OffestY;
        return true
    } );

    $.RegisterEventHandler( 'DragEnd', movable, function(a, draggedPanel ){
        let EndPos = GameUI.GetCursorPosition()
        let Offset = [draggedPanel.offsetX, draggedPanel.offsetY]

        SetPanelPosition(root, EndPos, Offset, true)

        SafeDeleteAsync(draggedPanel)

        return true
    });
}

function SetPanelPosition(root, Pos, Offset, bSetCustom, bIsAdjust){
    let NewX = Pos[0]
    let NewY = Pos[1]

    if(!bIsAdjust){
        NewX = Math.floor(ToAbsPixelValue(Pos[0]))-ToAbsPixelValue(Offset[0])
        NewY = Math.floor(ToAbsPixelValue(Pos[1]))-ToAbsPixelValue(Offset[1])
    }

    let ScreenWidth = ToAbsPixelValue(Game.GetScreenWidth())
    let ScreenHeight = ToAbsPixelValue(Game.GetScreenHeight())

    let CurrentWidth = ToAbsPixelValue(root.actuallayoutwidth)
    let CurrentHeight = ToAbsPixelValue(root.actuallayoutheight)

    NewX = Math.max(0, Math.min(NewX, ScreenWidth-CurrentWidth))

    NewY = Math.max(0, Math.min(NewY, ScreenHeight-CurrentHeight))

    root.style.x = NewX + "px"
    root.style.y = NewY + "px"

    if(bSetCustom){
        root._custom_position = [NewX, NewY]
    }
}

function AdjustMovablePanelPosition(root){
    let ScreenWidth = Game.GetScreenWidth()
    let ScreenHeight = Game.GetScreenHeight()

    let CurrentWidth = root.actuallayoutwidth
    let CurrentHeight = root.actuallayoutheight

    // $.Msg(root)
    // $.Msg(CurrentWidth, CurrentHeight)

    let X = (ScreenWidth / 2) - (CurrentWidth / 2)
    let Y = (ScreenHeight / 2) - (CurrentHeight / 2)

    let Config = root.pos_config
    if(Config){
        // Left
        if(Config.align[0] == 0){
            X = 0
        }
        // Up
        if(Config.align[1] == 0){
            Y = 0
        }

        // Right
        if(Config.align[0] == 2){
            X = ScreenWidth - CurrentWidth
        }
        //Down
        if(Config.align[1] == 2){
            Y = CurrentHeight - CurrentHeight
        }

        // X Margin
        if(Config.margin[0] != undefined){
            X+=Config.margin[0]
        }
        // Y Margin
        if(Config.margin[1] != undefined){
            Y+=Config.margin[1]
        }
    }

    let Pos = [X, Y]

    if(root._custom_position){
        SetPanelPosition(root, root._custom_position, [0,0], false, true)
    }else{
        SetPanelPosition(root, Pos, [0,0])
    }
}