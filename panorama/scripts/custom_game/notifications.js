--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const MAIN_PANEL = $.GetContextPanel()
const LocalPlayerID = Players.GetLocalPlayer()

MAIN_PANEL.SetParent(FindDotaHudElement("HUDElements"));

const bSubscribedToBattlePass = IsPlayerBattlePassSubscribed(LocalPlayerID)

MAIN_PANEL.SetHasClass("BattlePassSubscribed", bSubscribedToBattlePass)

const NotificationButton = $("#NotificationButton")
const NotificationBody = $("#NotificationBody")
const ButtonsContainer = $("#ButtonsContainer")
const Pages = $("#Pages")

const SettingsBody = $("#SettingsBody")
const SettingsButton = $("#SettingsButton")

const PageLog = $("#PageLog")

const LogContainer = $("#LogContainer")

const PagesContainer = $("#PagesContainer")

const LogHeader = $("#LogHeader")
const SortRounds = $("#SortRounds")
const SortMessages = $("#SortMessages")

const DamageButtonsContainer = $("#DamageButtonsContainer")
const DamagePages = $("#DamagePages")

const OutgoingContainer = $("#OutgoingContainer")
const IncomingContainer = $("#IncomingContainer")

const PageOutgoing = $("#PageOutgoing")
const PageIncoming = $("#PageIncoming")

let SelectedPage = ""

let CurrentLogPage = 1
const MaxNotificationsPerPage = 20

let SelectedDamagePage = ""

let SortByInstance = undefined
let SortTurn = undefined

let GLOBAL_NOTIFICATIONS = []
let PLAYER_NOTIFICATIONS = []

let TEXT_COMPLETED = {}

const TEXT_VALUES = {
	hero: (v, s) => ({
		[`%h${s}%`]: `<span class="HeroName">${$.Localize(`#${v}`)}</span>`,
		[`%h${s}i%`]: `<img class="HeroImage" src="file://{images}/heroes/icons/${v}.png"/>`
	}),
	player: (id, s) => {
		const pi = Game.GetPlayerInfo(id); if (!pi) return {};
		return {
			[`%p${s}%`]: `<span class="PlayerName">${pi.player_name}</span>`,
			[`%p${s}h%`]: `<span class="HeroName">${$.Localize(`#${pi.player_selected_hero}`)}</span>`,
			[`%p${s}hi%`]: `<img class="HeroImage" src="file://{images}/heroes/icons/${pi.player_selected_hero}.png"/>`
		};
	},
	creep: (v, s) => ({
		[`%c${s}%`]: `<span class="HeroName">${$.Localize(`#${v}`)}</span>`,
		[`%c${s}i%`]: `<img class="CreepImage" src="file://{images}/custom_game/creature_show/${v}.png"/>`
	}),
	value: (v, s) => {
		const cls = v == 0 ? "" : v < 0 ? "MinusValue" : "PlusValue";
		return { [`%v${s}%`]: `<span class="Value ${cls}">${v}</span>` };
	},
	item: (v, s) => ({ [`%i${s}i%`]: `<img class="ItemImage" src="file://{images}/items/${v}.png"/>` }),
	gold: (v, s) => ({
		[`%g${s}%`]: `<span class="GoldLabel">${v}</span>`,
		[`%g${s}i%`]: `<img class="GoldIcon" src="s2r://panorama/images/hud/reborn/gold_small_psd.vtex"/>`
	}),
	time: (v, s) => ({
		[`%t${s}%`]: `<span class="Value">${GetTimeString(v)}</span>`,
		[`%t${s}i%`]: `<img class="TimeIcon" src="s2r://panorama/images/hud/reborn/icon_attack_speed2_psd.vtex"/>`,
	}),
};

let FILTERS = {
	only_self: {
		enabled: false,
		mod: true,
		condition: item => item.values && (item.values.player1 == LocalPlayerID || item.values.player2 == LocalPlayerID)
	},
	kills: {
		enabled: true,
		mod: false,
		condition: item => item.type == "DUEL_KILL" || item.type == "DUEL_KILL_SELF" || item.type == "CREEP_KILL" || item.type == "KILL"
	},
	aegis: {
		enabled: true,
		mod: false,
		condition: item => item.type == "AEGIS_GET" || item.type == "AEGIS_LOST"
	},
	creep_send: {
		enabled: true,
		mod: false,
		condition: item => item.type == "CREEP_SENDED"
	},
	minigames_massarena: {
		enabled: true,
		mod: false,
		condition: item => item.type == "MINIGAMES_LOSE" || item.type == "MINIGAMES_WIN" || item.type == "MASS_ARENA_LOSE" || item.type == "MASS_ARENA_WIN"
	},
	last_place_bonus: {
		enabled: true,
		mod: false,
		condition: item => item.type == "LAST_PLACE_BONUS" || item.type == "LAST_PLACE_BONUS_WITH_SMOKE"
	},
	bets_win: {
		enabled: true,
		mod: false,
		condition: item => item.type == "BET_WIN" || item.type == "BET_WIN_SELF"
	},
	used_book: {
		enabled: true,
		mod: false,
		condition: item => item.type == "USED_BOOK"
	},
	round_ended: {
		enabled: true,
		mod: false,
		condition: item => item.type == "ROUND_ENDED"
	},
}

LogContainer.RemoveAndDeleteChildren()
OutgoingContainer.RemoveAndDeleteChildren()
IncomingContainer.RemoveAndDeleteChildren()

SubscribeAndFirePlayerTableByKey(`player_${Players.GetLocalPlayer()}`, `setting_data`, function(v){
	for (const FilterType in FILTERS) {
		if(v.settings_notifications_filters && v.settings_notifications_filters[FilterType] != undefined){
			FILTERS[FilterType].enabled = v.settings_notifications_filters[FilterType] == 1 ? true : false
		}
		
		SetFilterClass(FilterType, FILTERS[FilterType].enabled)
	}
})

SubscribeAndFirePlayerTable("notifications", function(v){
	let TempTableGlobal = []
	let TempTablePlayer = []
	for (const NotificationName in v) {
		if(NotificationName.includes("global_notification")){
			TempTableGlobal.push(v[NotificationName])
		}else if(NotificationName.includes( `player_${LocalPlayerID}_notification`)){
			TempTablePlayer.push(v[NotificationName])
		}

		if(TEXT_COMPLETED[v[NotificationName].ID] == undefined){
			TEXT_COMPLETED[v[NotificationName].ID] = CreateNotificationText(v[NotificationName])
		}
	}

	GLOBAL_NOTIFICATIONS = TempTableGlobal
	PLAYER_NOTIFICATIONS = TempTablePlayer

	UpdateNotifications()
})

let OUTGOING_DAMAGE = []
let INCOMING_DAMAGE = []

if(bSubscribedToBattlePass) {
	SubscribeAndFirePlayerTableByKey(`player_${LocalPlayerID}`, `outgoing_damage`, function(v){
		OUTGOING_DAMAGE = toArray(v)

		UpdateDamage(1)
	})

	SubscribeAndFirePlayerTableByKey(`player_${LocalPlayerID}`, `incoming_damage`, function(v){
		INCOMING_DAMAGE = toArray(v)

		UpdateDamage(2)
	})
}

function UpdateDamage(nType){
	let List = nType == 1 ? OUTGOING_DAMAGE : INCOMING_DAMAGE

	let ListToCheck = SelectedDamagePage == "Outgoing" ? OUTGOING_DAMAGE : INCOMING_DAMAGE

	DamagePages.SetHasClass("Empty", ListToCheck.length == 0)

	let Container = nType == 1 ? OutgoingContainer : IncomingContainer

	if(List.length == 0){
		Container.RemoveAndDeleteChildren()
	}

	let Page = nType == 1 ? PageOutgoing : PageIncoming

	let MaxDamage = 0
	for (const DamageInfo of List) {
		MaxDamage+=DamageInfo.damage
	}

	for (const DamageInfo of List) {
		let p = GetOrCreateDamageInstance(Container, DamageInfo)

		p.damage = DamageInfo.damage

		let pct = (DamageInfo.damage * 100) / (MaxDamage || 1)
        pct = Math.min(100, pct)

		let DamageInstanceLine = p.FindChildTraverse("DamageInstanceLine")
		if(DamageInstanceLine){
			DamageInstanceLine.style.width = pct.toFixed(0) + '%'
		}

		p.SetDialogVariable("instance_damage", `${CheckStringDamage(DamageInfo.damage)} <font color='gray'>(${pct.toFixed(0)}%)</font >`)
	}

	ReorderPanels(Container, SortFuncDamage)

	Page.SetDialogVariable("all_damage_incoming", `${$.Localize("#DamageRoundHistoryHeadLabel_maximum")}: <span class="Value">${CheckStringDamage(MaxDamage)}</span>`)
}

function UpdateNotifications(){
	let List = GLOBAL_NOTIFICATIONS.concat(PLAYER_NOTIFICATIONS)

	let conds = []
	for (const FilterType in FILTERS) {
		if(FILTERS[FilterType].enabled == true && FILTERS[FilterType].mod == true){
			conds.push(FILTERS[FilterType].condition)
		}else if(FILTERS[FilterType].enabled == false && FILTERS[FilterType].mod == false){
			conds.push(item => !FILTERS[FilterType].condition(item))
		}
	}

	List = filterItems(List, conds)

	if(SortByInstance == undefined){return}

	let PagesCount = Math.max(Math.ceil(List.length / MaxNotificationsPerPage), 1)

	let PossibleNums = [];

	if (PagesCount <= 9) {
		for (let i = 1; i <= PagesCount; i++) {
			PossibleNums.push(i);
		}
	} else {
		if (CurrentLogPage <= 5) {
			for (let i = 1; i <= 9; i++) {
				PossibleNums.push(i);
			}
		} else if (CurrentLogPage >= PagesCount - 4) {
			for (let i = PagesCount - 8; i <= PagesCount; i++) {
				PossibleNums.push(i);
			}
		} else {
			for (let i = CurrentLogPage - 4; i <= CurrentLogPage + 4; i++) {
				PossibleNums.push(i);
			}
		}
	}

	for (let i = 0; i < 9; i++) {
		let PageChild = GetOrCreatePageButton(PagesContainer, i)
		let isFirstPage = i == 0 && CurrentLogPage > 5 && PagesCount > 9
		let isPrevPage = i == 1 && CurrentLogPage > 5 && PagesCount > 9

		let isLastPage = i == 8 && PagesCount - 4 > CurrentLogPage && PagesCount > 9
		let isNextPage = i == 7 && PagesCount - 4 > CurrentLogPage && PagesCount > 9

		PageChild.SetHasClass("PageActive", PagesCount >= i+1)

		PageChild.SetHasClass("IsActivePage", PossibleNums[i]==CurrentLogPage)
 
		let symbol = PossibleNums[i]
		if(isFirstPage){
			symbol = "<<"
		}else if(isPrevPage){
			symbol = "<"
		}else if(isLastPage){
			symbol = ">>"
		}else if(isNextPage){
			symbol = ">"
		}
		PageChild.SetDialogVariable("log_button", symbol+"")
		PageChild.SetPanelEvent("onactivate", function(){
			if(isFirstPage){
				CurrentLogPage = 1
			}else if(isPrevPage){
				CurrentLogPage = Math.max(CurrentLogPage - 1, 1)
			}else if(isLastPage){
				CurrentLogPage = PagesCount
			}else if(isNextPage){
				CurrentLogPage = Math.min(CurrentLogPage + 1, PagesCount)
			}else{
				CurrentLogPage = PossibleNums[i]
			}

			UpdateNotifications()
		})
	}

	List.sort((a, b)=>{
		let aValue = SortByInstance == "round" ? a.round : (TEXT_COMPLETED[a.ID]?.[0] ?? "")
		let bValue = SortByInstance == "round" ? b.round : (TEXT_COMPLETED[b.ID]?.[0] ?? "")

		let Dir = SortTurn ? -1 : 1;

		if (aValue != undefined && bValue != undefined && aValue !== bValue) {
			if(typeof aValue == "string"){
				if (aValue < bValue) return -1 * Dir;
        		if (aValue > bValue) return 1 * Dir;
			}else{
				return Dir * (aValue - bValue)
			}
		}

		if (a.type !== b.type) {
			if (a.type < b.type) return -1;
			if (a.type > b.type) return 1;
		}

		if (a.values && b.values) {
			if(a.values.value1 !== b.values.value1){
				return Dir * (a.values.value1 - b.values.value1);
			}
			if(a.values.gold1 !== b.values.gold1){
				return Dir * (a.values.gold1 - b.values.gold1);
			}
		}

		if (a.ID !== b.ID) {
			return Dir * (a.ID - b.ID);
		}

		return 0;
	})

	let PageStart = (CurrentLogPage - 1) * MaxNotificationsPerPage
	let PageList = List.slice(PageStart, PageStart + MaxNotificationsPerPage)

	PageLog.SetHasClass("Empty", PageList.length == 0)

	let Groups = {}
	let GroupsMax = 0
	let LastGroup = undefined
	for (const NotificationInfo of PageList) {
		if(Groups[NotificationInfo.round] == undefined){
			Groups[NotificationInfo.round] = {}
		}
		if(Groups[NotificationInfo.round][NotificationInfo.type] == undefined){
			GroupsMax++;
			Groups[NotificationInfo.round][NotificationInfo.type] = {
				group: GroupsMax,
				num: 0,
			}
		}
	}

	for (let i = 0; i < MaxNotificationsPerPage; i++) {
		let Info = PageList[i]
		let p = GetOrCreateNotification(i, Info)

		if(Info != undefined){
			let bIsFirst = false 
			let CurrentGroupInfo = undefined
			let CurrentNum = 0
			let Group = Groups[Info.round]?.[Info.type]
			if(Group){
				CurrentGroupInfo = Group.group
				CurrentNum = Group.num
				bIsFirst = (LastGroup != CurrentGroupInfo && i != 0)
				LastGroup = CurrentGroupInfo
				Group.num++;
			}
			
			for (let j = 1; j <= GroupsMax; j++) {
				p.RemoveClass(`Group${j}`);
			}
			if (CurrentGroupInfo) {
				p.SetHasClass(`Group${CurrentGroupInfo}`, true);
			}

			p.SetHasClass("GroupOdd", CurrentNum%2!=0)

			p.SetHasClass("IsFirstInGroup", bIsFirst);
		}
	}
}

SelectPage("Log")
SelectDamagePage("Outgoing")
ToggleSort("round")

function DeselectPagesExceptOf(PageName){
	for (let i = 0; i < Pages.GetChildCount(); i++) {
		let Child = Pages.GetChild(i)
		if(Child){
			Child.SetHasClass("Selected", Child.id == `Page${PageName}`)
		}
	}
	for (let i = 0; i < ButtonsContainer.GetChildCount(); i++) {
		let Child = ButtonsContainer.GetChild(i)
		if(Child){
			Child.SetHasClass("Selected", Child.id == `Button${PageName}`)
		}
	}
}

function SelectPage(PageName){
	if(SelectedPage == PageName){
		return
	}

	SelectedPage = PageName

	DeselectPagesExceptOf(PageName)
}

function DeselectDamagePagesExceptOf(PageName){
	for (let i = 0; i < DamagePages.GetChildCount(); i++) {
		let Child = DamagePages.GetChild(i)
		if(Child){
			Child.SetHasClass("Selected", Child.id == `Page${PageName}`)
		}
	}
	for (let i = 0; i < DamageButtonsContainer.GetChildCount(); i++) {
		let Child = DamageButtonsContainer.GetChild(i)
		if(Child){
			Child.SetHasClass("Selected", Child.id == `Button${PageName}`)
		}
	}
}

function SelectDamagePage(PageName){
	if(SelectedDamagePage == PageName){
		return
	}

	SelectedDamagePage = PageName

	DeselectDamagePagesExceptOf(PageName)

	let List = SelectedDamagePage == "Outgoing" ? OUTGOING_DAMAGE : INCOMING_DAMAGE

	DamagePages.SetHasClass("Empty", List.length == 0)
}


function ToggleNotifications(){
    NotificationButton.ToggleClass("Show")
    NotificationBody.ToggleClass("Show")

	if(!NotificationButton.BHasClass("Show")){
		SettingsBody.RemoveClass("Show")
		SettingsButton.RemoveClass("Show")
	}
}

GameUI.CustomUIConfig().ToggleNotifications = ToggleNotifications

function ToggleSettings(){
	SettingsBody.ToggleClass("Show")
	SettingsButton.ToggleClass("Show")
}

function ToggleSort(SortBy){
	if(SortBy != SortByInstance){
		SortByInstance = SortBy
		SortTurn = true
	}else{
		SortTurn = !SortTurn
	}

	for (let i = 0; i < LogHeader.GetChildCount(); i++) {
		let Child = LogHeader.GetChild(i)
		if(Child){
			Child.SetHasClass("Sort", Child.id == `Sort${SortByInstance}`)

			Child.SetHasClass("SortedTurn", Child.id == `Sort${SortByInstance}` && SortTurn)
		}
	}

	CurrentLogPage = 1

	UpdateNotifications()

	LogContainer.ScrollToTop()
}

function GetOrCreateNotification(i, NotificationInfo){
	let f = LogContainer.FindChildTraverse(`Notification_${i}`)
	if(f){
		f.SetHasClass("EmptyNotification", NotificationInfo==undefined)

		if(NotificationInfo && f.notification_id == NotificationInfo.ID){return f}
		
		if(NotificationInfo != undefined){
			f.SetDialogVariable("round_num", NotificationInfo.round+"")

			f.notification_id = NotificationInfo.ID

			let [Text, ImagesIDs] = TEXT_COMPLETED[NotificationInfo.ID]
			if(Text){
				f.SetDialogVariable("log_text", Text)

				// if(f.Schedule != undefined){
				// 	$.CancelScheduled(f.Schedule)
				// 	f.Schedule = undefined
				// }

				// f.Schedule = $.Schedule(0.01*i, ()=>{
					let LogMessage = f.FindChildTraverse("LogMessage")
					if(LogMessage){
						for (let i = 0; i < LogMessage.GetChildCount(); i++) {
							const Child = LogMessage.GetChild(i);
							if(Child && ImagesIDs[i] && ImagesIDs[i].tooltip != undefined){
								Child.SetPanelEvent('onmouseover', function () {
									$.DispatchEvent(ImagesIDs[i].tooltip, Child, ImagesIDs[i].name);
								});
							
								Child.SetPanelEvent('onmouseout', function () {
									$.DispatchEvent(ImagesIDs[i].tooltip_close, Child);
								});
							}
						}
					}
				// })
			}
		}

		return f
	}else{
		let panel = $.CreatePanel("Panel", LogContainer, `Notification_${i}`, {})
		panel.BLoadLayoutSnippet("LogRow")

		panel.SetHasClass("EmptyNotification", NotificationInfo==undefined)
		// panel.SetHasClass("Odd", i%2==0)

		if(NotificationInfo != undefined){
			panel.SetDialogVariable("round_num", NotificationInfo.round+"")

			panel.notification_id = NotificationInfo.ID

			let [Text, ImagesIDs] = TEXT_COMPLETED[NotificationInfo.ID]
			if(Text){
				panel.SetDialogVariable("log_text", Text)

				// if(panel.Schedule != undefined){
				// 	$.CancelScheduled(f.Schedule)
				// 	panel.Schedule = undefined
				// }

				// panel.Schedule = $.Schedule(0.02*i, ()=>{
					let LogMessage = panel.FindChildTraverse("LogMessage")
					if(LogMessage){
						for (let i = 0; i < LogMessage.GetChildCount(); i++) {
							const Child = LogMessage.GetChild(i);
							if(Child && ImagesIDs[i] && ImagesIDs[i].tooltip != undefined){
								Child.SetPanelEvent('onmouseover', function () {
									$.DispatchEvent(ImagesIDs[i].tooltip, Child, ImagesIDs[i].name);
								});
							
								Child.SetPanelEvent('onmouseout', function () {
									$.DispatchEvent(ImagesIDs[i].tooltip_close, Child);
								});
							}
						}
					}
				// })
			}
		}

		return panel
	}
}

function CreateNotificationText(NotificationInfo){
	let Text = $.Localize(`#NOTIFICATIONS_TEXT_${NotificationInfo.type}`);
    const Images = [];

    const ReplaceMap = { "%aegisi%": `<img class="ItemImage" src="file://{images}/items/aegis.png"/>` };

    for (const [ValueName, Value] of Object.entries(NotificationInfo.values)) {
        const ValueMap = ValueName.match(/([a-z]+)(\d+)/); 
		if (!ValueMap) continue;

        Object.assign(ReplaceMap, TEXT_VALUES[ValueMap[1]]?.(Value, ValueMap[2]));
    }

    for (const [Tag, Html] of Object.entries(ReplaceMap)) {
        const TagIndex = Text.indexOf(Tag);
        if (TagIndex !== -1 && Tag.includes("i%")) {
            const ImageItem = { tooltip: undefined, index: TagIndex };
            if (Tag.startsWith("%i")) {
                ImageItem.tooltip = "DOTAShowAbilityTooltip";
                ImageItem.tooltip_close = "DOTAHideAbilityTooltip";
                ImageItem.name = NotificationInfo.values[`item${Tag[2]}`];
            }
            Images.push(ImageItem);
        }
    }

	Text = Text.replace(/%[a-z0-9]+%/g, m => ReplaceMap[m] ?? m);

    Images.sort((a, b) => a.index - b.index);

    return [Text, Images];
}

function GetOrCreatePageButton(Container, Num){
	let f = Container.FindChildTraverse(`LogPageButton_${Num}`)
	if(f){
		return f
	}else{
		let panel = $.CreatePanel("Panel", Container, `LogPageButton_${Num}`, {})
		panel.BLoadLayoutSnippet("LogPageButton")

		return panel
	}
}

function GetOrCreateDamageInstance(Container, DamageInfo){
	let f = Container.FindChildTraverse(`Instance_${DamageInfo.name}`)
	if(f){
		return f
	}else{
		let panel = $.CreatePanel("Panel", Container, `Instance_${DamageInfo.name}`, {})
		panel.BLoadLayoutSnippet("DamageInstance")

		panel.AddClass(DamageInfo.type)

		if(DamageInfo.type == "ability"){
			let DamageInstanceAbilityImage = panel.FindChildTraverse("DamageInstanceAbilityImage")
			if(DamageInstanceAbilityImage){
				DamageInstanceAbilityImage.abilityname = DamageInfo.name
			}
		}else if(DamageInfo.type == "attack"){
			let DamageInstanceAbilityImage = panel.FindChildTraverse("DamageInstanceAbilityImage")
			if(DamageInstanceAbilityImage){
				DamageInstanceAbilityImage.abilityname = "action_attack"
				DamageInstanceAbilityImage.SetImage( "s2r://panorama/images/spellicons/action_attack_png.vtex" )
			}
		}else if(DamageInfo.type == "item"){
			let DamageInstanceItemImage = panel.FindChildTraverse("DamageInstanceItemImage")
			if(DamageInstanceItemImage){
				DamageInstanceItemImage.itemname = DamageInfo.name
			}
		}else if(DamageInfo.type == "unit"){

			let UnitName = DamageInfo.name
			UnitName = UnitName.replace("_1", '')
			UnitName = UnitName.replace("_2", '')
			UnitName = UnitName.replace("_3", '')
			UnitName = UnitName.replace("_4", '')
			UnitName = UnitName.replace("1", '')
			UnitName = UnitName.replace("2", '')
			UnitName = UnitName.replace("3", '')
			UnitName = UnitName.replace("4", '')

			let DamageInstanceUnitImage = panel.FindChildTraverse("DamageInstanceUnitImage")
			if(DamageInstanceUnitImage){
				DamageInstanceUnitImage.style.backgroundImage = 'url("s2r://panorama/images/heroes/' + UnitName + '_png.vtex")';
			}
		}

		panel.SetDialogVariable("instance_damage", CheckStringDamage(DamageInfo.damage))

		panel.AddClass(`DamageType_${DamageInfo.damage_type}`)

		return panel
	}
}

function ReorderPanels(Container, SortFunc){
    var count = Container.GetChildCount()
	if (count > 0) {
		for (var i = 0; i < count; i++) {
            for (var j = i+1; j < count; j++) {
                let prev = Container.GetChild(i);
                let child = Container.GetChild(j);
                if(child != undefined){
                    SortFunc(Container, prev, child);
                }
            }
        }

		for (var i = 0; i < count; i++) {
			let Child = Container.GetChild(i);
			if(Child){
				Child.SetHasClass("Odd", i%2==0)
			}
		}
	}
}

function SortFuncRounds(Container, a, b){
	if(SortByInstance){
		let aRound = a[SortByInstance]
    	let bRound = b[SortByInstance]
		if(SortTurn == false){
			if ( aRound != undefined && bRound != undefined && aRound > bRound )
			{
				Container.MoveChildBefore(b, a);
			}else if(aRound != undefined && bRound != undefined && aRound == bRound && SortByInstance == "round" && a.notification_id > b.notification_id){
				Container.MoveChildBefore(b, a);
			}
		}else{
			if ( aRound != undefined && bRound != undefined && aRound < bRound )
			{
				Container.MoveChildBefore(b, a);
			}else if(aRound != undefined && bRound != undefined && aRound == bRound && SortByInstance == "round" && a.notification_id < b.notification_id){
				Container.MoveChildBefore(b, a);
			}
		}
	}
}

function SortFuncDamage(Container, a, b){
	let aValue = a.damage
	let bValue = b.damage
	if ( aValue != undefined && bValue != undefined && aValue < bValue )
	{
		Container.MoveChildBefore(b, a);
	}
}

function CheckStringDamage(damage) {
	if (damage > 999999) {
		return String((damage/1000000).toFixed(2)) + "M"
	} else if (damage > 999) {
		return String((damage/1000).toFixed(2)) + "K"
	} else {
		return damage.toFixed(0)
	}
}

function SafeSetText(panel, id, text){
	if ( panel === null )
		return;
	var childPanel = panel.FindChildInLayoutFile( id )
	if ( childPanel === null )
		return;

	childPanel.text = text;
}

function SetFilterClass(FilterType, enabled){
	if(FILTERS[FilterType] != undefined){
		let p = $(`#${FilterType}`)
		if(p){
			p.SetHasClass("Checked", enabled)
			let box = p.GetChild(0)
			if(box){
				box.SetSelected(enabled)
			}
		}
	}
}

function ToggleFilterSetting(FilterType){
	if(FILTERS[FilterType] != undefined){
		FILTERS[FilterType].enabled = !FILTERS[FilterType].enabled

		SetFilterClass(FilterType, FILTERS[FilterType].enabled)

		UpdateNotifications()

		GameEvents.SendCustomGameEventToServer("server_update_notification_filter_settings", {filter_type: FilterType, enabled: FILTERS[FilterType].enabled});
	}
}

// Обработка подсказок для блока уведомлений
GameEvents.Subscribe("cha_hint_visible", function(params) {
    if (params.hint == "info_panel")
    {
        if (!GameUI.CustomUIConfig().HintOutlineParticles) {
            GameUI.CustomUIConfig().HintOutlineParticles = {}
        }
        // Используем глобальную функцию из hints.js с передачей контекста
        if (GameUI.CustomUIConfig().CreateHintParticle) {
            GameUI.CustomUIConfig().HintOutlineParticles["info_panel"] = GameUI.CustomUIConfig().CreateHintParticle(NotificationButton, $.GetContextPanel())
        }
    }
})