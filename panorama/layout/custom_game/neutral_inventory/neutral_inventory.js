--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const PlayerID = Players.GetLocalPlayer()
const NeutralsList = $("#NeutralsList")
const ActiveNeutralsList = $("#ActiveNeutralsList")
const RoshpitIndicatorPanel = $("#RoshpitIndicatorPanel")

function SubscribeAndFireCustomTableByKey(tableName, keyName, callback){
	const currentValue = Game.GetCustomTable(tableName, keyName);
	if (currentValue) {
		callback(currentValue);
	}
	return Game.SubscribeCustomTableListener(tableName, (name, key, values) => {
		if (key == keyName) {
			callback(values);
		}
	});
}

function SafeDeleteAsync(p){
    if(p && p.IsValid()){
        p.DeleteAsync(0)
    }
}

let NEUTRAL_STATE = "not_active"
let NEUTRAL_SETTINGS = {}
let NEUTRAL_ITEMS = {}
let NEUTRAL_ROSHPIT = {}

// Получаем здесь настройки инвентаря
SubscribeAndFireCustomTableByKey("neutral_items", `settings`, function(v){
    NEUTRAL_SETTINGS = v
})
// Получаем текущее состояние системы и прячем панели если они не нужны
SubscribeAndFireCustomTableByKey("neutral_items", `state`, function(v){
    NEUTRAL_STATE = v.state
    
    $.GetContextPanel().SetHasClass("IsNeutralsActive", NEUTRAL_STATE == "active")
})
// Получаем текущий инвентарь игрока и обновляем его
SubscribeAndFireCustomTableByKey("neutral_items", `player_${PlayerID}`, function(v){
    NEUTRAL_ITEMS = v

    UpdateInventory()
})
// Получаем информацию о рошпите игрока
SubscribeAndFireCustomTableByKey("neutral_items", `player_roshpit_${PlayerID}`, function(v){
    NEUTRAL_ROSHPIT = v

    UpdateRoshpit()
})

function UpdateInventory(){
    let PassiveSlots = NEUTRAL_SETTINGS.passive_slots || 0
    let MaxSlots = NEUTRAL_SETTINGS.passive_slots == undefined ? 0 : NEUTRAL_SETTINGS.passive_slots + NEUTRAL_SETTINGS.active_slots
    for (let i = 1; i <= MaxSlots; i++) {
        let SlotID = i.toString()
        let SlotData = NEUTRAL_ITEMS[SlotID]

        let Container = i > PassiveSlots ? ActiveNeutralsList : NeutralsList

        let p = GetOrCreateInventorySlot(Container, SlotID)

        p.SetHasClass("IsActiveNeutralSlot", i > PassiveSlots)

        let Rarity = 0
        let ItemName = ""
        if(SlotData){
            ItemName = SlotData.item_name
            Rarity = SlotData.rarity

            SetCustomTooltip(p, "neutral_item_tooltip", {item_name : ItemName})

            $.RegisterEventHandler( 'DragStart', p, function(a, dragCallbacks ){
                $.DispatchEvent("UIHideCustomLayoutTooltip", p, "neutral_item_tooltip_custom");

                p.AddClass("dragging_from")
                let panel = $.CreatePanel( "Image", $.GetContextPanel(), "", {
                    class: "DragImage",
                    scaling: "stretch-to-fit-y-preserve-aspect"
                });
                panel.SetImage(`file://{images}/neutral_items/${SlotData.item_name}.png`)
                panel.slot_from = SlotID

                dragCallbacks.displayPanel = panel;
                dragCallbacks.offsetX = 0;
                dragCallbacks.offsetY = 0;
                return true
            } );

            $.RegisterEventHandler( 'DragEnd', p, function(a, draggedPanel ){
                p.RemoveClass("dragging_from")
                SafeDeleteAsync(draggedPanel)
                return true
            } );
        }else{
            p.ClearPanelEvent("onmouseover")

            $.RegisterEventHandler( 'DragStart', p, function(a, dragCallbacks ){
                return true
            } );

            $.RegisterEventHandler( 'DragEnd', p, function(a, draggedPanel ){
                return true
            } );
        }

        for (let j = 1; j <= 7; j++) {
            p.SetHasClass(`Rarity_${j}`, j == Rarity)
        }

        let ItemImage = p.FindChildTraverse("ItemImage")
        if(ItemImage){
            ItemImage.SetImage(`file://{images}/neutral_items/${ItemName}.png`)
        }

        const CooldownPanel = p.FindChildTraverse("ItemCooldownPanel")
        if(CooldownPanel){
            CooldownPanel.visible = false
            CooldownPanel.SetHasClass("IsCoolingDown", false)
        }

        $.RegisterEventHandler( 'DragDrop', p, function(a, draggedPanel ){
            if(Entities.IsControllableByPlayer(Players.GetLocalPlayerPortraitUnit(), PlayerID)){
                GameEvents.SendCustomGameEventToServer("event_player_swap_neutral_items", { Slot1: draggedPanel.slot_from, Slot2: SlotID });
            }

            return true
        })

        $.RegisterEventHandler( 'DragEnter', p, function(a, draggedPanel ){
            p.AddClass("potential_drop_target")
            return true
        });

        $.RegisterEventHandler( 'DragLeave', p, function(a, draggedPanel ){
            p.RemoveClass("potential_drop_target")
            return true
        });
    }
}

function UpdateNeutralItemCooldowns(){
    const PassiveSlots = Number(NEUTRAL_SETTINGS.passive_slots || 0)
    const ActiveSlots = Number(NEUTRAL_SETTINGS.active_slots || 0)
    const Now = Math.max(0, Game.GetGameTime())

    for(let i = PassiveSlots + 1; i <= PassiveSlots + ActiveSlots; i++){
        const SlotID = i.toString()
        const SlotPanel = ActiveNeutralsList.FindChildTraverse(`Item_${SlotID}`)
        if(!SlotPanel) continue

        const CooldownPanel = SlotPanel.FindChildTraverse("ItemCooldownPanel")
        if(!CooldownPanel) continue

        const SlotData = NEUTRAL_ITEMS[SlotID]
        const CooldownEndTime = Number(SlotData?.cooldown_end_time || 0)
        const CooldownDuration = Number(SlotData?.cooldown_duration || 0)
        const Remaining = Math.max(0, CooldownEndTime - Now)
        const IsCoolingDown = Boolean(SlotData) && CooldownDuration > 0 && Remaining > 0

        CooldownPanel.visible = IsCoolingDown
        CooldownPanel.SetHasClass("IsCoolingDown", IsCoolingDown)
        if(IsCoolingDown){
            const Progress = (Remaining / CooldownDuration) * -360
            if(!isNaN(Progress)){
                CooldownPanel.style.clip = `radial( 50% 50%, 0deg, ${Progress}deg )`
            }
        }
    }

    $.Schedule(0.1, UpdateNeutralItemCooldowns)
}

function UpdateRoshpit(){
    let bActive = NEUTRAL_ROSHPIT.is_alive == 1 || NEUTRAL_ROSHPIT.is_alive === true
    RoshpitIndicatorPanel.SetHasClass("IsAlive", bActive)
}

function CraftItems(){
    GameEvents.SendCustomGameEventToServer("event_player_craft_neutral_items", { });
}

function Toggle(){
    $.GetContextPanel().ToggleClass("NeutralsToggled")
}

function GetOrCreateInventorySlot(Container, SlotID){
    let f = Container.FindChildTraverse(`Item_${SlotID}`)
    if(f){
        return f
    }else{
        let p = $.CreatePanel("Panel", Container, `Item_${SlotID}`, {})
        p.BLoadLayoutSnippet("Item")

        return p
    }
}

UpdateNeutralItemCooldowns()