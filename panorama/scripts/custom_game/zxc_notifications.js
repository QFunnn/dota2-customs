--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const MAIN_PANEL = $.GetContextPanel()
const LocalPID = Players.GetLocalPlayer()

const bSubscribedToBattlePass = IsPlayerBattlePassSubscribed(LocalPID)

MAIN_PANEL.SetHasClass("BattlePassSubscribed", bSubscribedToBattlePass)

//BANS
const BannedInThisGame = $("#BannedInThisGame")
const CurrentBannedListHeroes = $("#CurrentBannedListHeroes")
const CurrentBannedListAbilities = $("#CurrentBannedListAbilities")

const UnbannedSSSListContainer = $("#UnbannedSSSListContainer")

const BanButtons = $("#BanButtons")
const Pages = $("#Pages")
const InfoContainerAbilitiesCategoriesList = $("#InfoContainerAbilitiesCategoriesList")
const InfoContainerAbilitiesList = $("#InfoContainerAbilitiesList")

let BansSchedule = -1
let PlayerShowed = 0
let OveredToIcon = false

let PLAYERS_BANS_INFO = {}

let UNBANNED_SSS_ABILITIES = []

let SelectedPage = ""

let SelectedCategory = {
    main: "",
    sub: ""
};

//BASIC DUEL
const DuelNotification = $("#DuelNotification")
const HeroIcon = $("#HeroIcon")
const DuelNotificationEnemyRow = $("#DuelNotificationEnemyRow")

let BasicDuelSchedule = -1
let BasicDuelSchedule2 = -1

//EXTRA CREATURE
const ExtraCreature = $("#ExtraCreature")
const ExtraCreatureBlock = $("#ExtraCreatureBlock")
const ExtraCreaturePlayerHeroIcon = $("#ExtraCreaturePlayerHeroIcon")

let Scheduler = -1

// SubscribeAndFireNetTableByKey("players", `player_${LocalPID}_ban_info`, function(v){
//     PlayerShowed = v.showed_banned_list
// })

// for (const PlayerID of Game.GetAllPlayerIDs()) {
//     SubscribeAndFireNetTableByKey("players", `player_${PlayerID}_ban_info`, function(v){
//         PLAYERS_BANS_INFO[PlayerID] = {
//             heroes: toArray(v.banned_heroes),
//             abilities: toArray(v.banned_abilities),
//         }
//     })
// }

// if(bSubscribedToBattlePass){
//     SubscribeAndFireNetTableByKey("globals", `unbanned_sss_abilities`, function(v){
//         // UNBANNED_SSS_ABILITIES = toArray(v)

//         // UNBANNED_SSS_ABILITIES = UNBANNED_SSS_ABILITIES.sort((a, b)=>{
//         //     let aLocalize = $.Localize(`#DOTA_Tooltip_ability_${a}`)
//         //     let bLocalize = $.Localize(`#DOTA_Tooltip_ability_${b}`)
//         //     if(aLocalize > bLocalize){return 1}
//         //     if(aLocalize < bLocalize){return -1}
//         //     return 0
//         // })

//         // UpdateUnbannedList()

//         UNBANNED_SSS_ABILITIES = v

//         SetupCategories()

//         SelectCategory("SSS")
//     })
// }

// SubscribeAndFireNetTableByKey("globals", "ban_info", function(v){
//     UpdateThisGameBans(v)
    
//     // let bNeedShow = (JSON.stringify(v.heroes) != "{}" || JSON.stringify(v.abilities) != "{}")
//     // if(bNeedShow && PlayerShowed == 0){
//     //     GameEvents.SendCustomGameEventToServer("bans_banned_showed", {});
//     //     BannedInThisGame.AddClass("Show")
//     //     if(BansSchedule != -1){
//     //         $.CancelScheduled(BansSchedule)
//     //         BansSchedule = -1
//     //     } 

//     //     BansSchedule = $.Schedule(10, function(){
//     //         BannedInThisGame.RemoveClass("Show")
//     //     })
//     // }
// })

// SelectPage("Banned")

function UpdateThisGameBans(v){
    for (const TableName in v) {
		let TableInfo = toArray(v[TableName])
		let bIsAbility = TableName == "abilities"
		let bIsHero = TableName == "heroes"

		let Container = bIsAbility ? CurrentBannedListAbilities : CurrentBannedListHeroes
		if(Container){

            TableInfo = TableInfo.sort((a, b)=>{
                let aLocalize = bIsAbility ? $.Localize(`#DOTA_Tooltip_ability_${a}`) : $.Localize(`#${a}`)
                let bLocalize = bIsAbility ? $.Localize(`#DOTA_Tooltip_ability_${b}`) : $.Localize(`#${b}`)
                if(aLocalize > bLocalize){return 1}
                if(aLocalize < bLocalize){return -1}
                return 0
            })

			Container.SetHasClass("SmallIcons", TableInfo.length > 11)
			for (const Name of TableInfo) {
				// let Name = TableInfo[_]
				let panel = GetOrCreateBannedItem(Container, Name)

				panel.SetHasClass("IsHero", bIsHero)
				panel.SetHasClass("IsAbility", bIsAbility)

				if(bIsAbility){
					panel.SetPanelEvent('onmouseover', function () {
						$.DispatchEvent("DOTAShowAbilityTooltip", panel, Name);
                        OveredToIcon = true
					});
				
					panel.SetPanelEvent('onmouseout', function () {
						$.DispatchEvent("DOTAHideAbilityTooltip", panel);
                        OveredToIcon = false
					});
				}

				let BannedItemHero = panel.FindChildTraverse("BannedItemHero")
				if(bIsHero && BannedItemHero){
					BannedItemHero.heroname = Name
				}

				let BannedItemAbility = panel.FindChildTraverse("BannedItemAbility")
				if(bIsAbility && BannedItemAbility){
					BannedItemAbility.abilityname = Name
				}

                if(bSubscribedToBattlePass){
                    let OwnerPID = GetBannedItemOwner(Name)

                    panel.SetHasClass("HasOwner", OwnerPID != -1 && OwnerPID != undefined)

                    if(OwnerPID != -1 && OwnerPID != undefined){
                        let PlayerInfo = Game.GetPlayerInfo( OwnerPID )

                        let BannedItemHeroOwner = panel.FindChildTraverse("BannedItemHeroOwner")
                        if(BannedItemHeroOwner){
                            BannedItemHeroOwner.heroname = PlayerInfo.player_selected_hero

                            BannedItemHeroOwner.SetPanelEvent('onmouseover', function() {
                                $.DispatchEvent('DOTAShowTextTooltip', BannedItemHeroOwner, PlayerInfo.player_name); 
                            });
                                
                            BannedItemHeroOwner.SetPanelEvent('onmouseout', function() {
                                $.DispatchEvent('DOTAHideTextTooltip', BannedItemHeroOwner);
                                if(OveredToIcon == true && bIsAbility){
                                    $.DispatchEvent("DOTAShowAbilityTooltip", panel, Name);
                                }
                            });  
                        }
                    }
                }
			}
		}
	}
}

function GetOrCreateBannedItem(Container, BannedItemName){
	let f = Container.FindChildTraverse(`Item_${BannedItemName}`)
	if(f){
		return f
	}else{
		let panel = $.CreatePanel("Panel", Container, `Item_${BannedItemName}`, {})
		panel.BLoadLayoutSnippet("BannedItem")

		return panel
	}
}

function UpdateUnbannedList(){
    UnbannedSSSListContainer.SetHasClass("SmallIcons", UNBANNED_SSS_ABILITIES.length > 11)

    for (const AbilityName of UNBANNED_SSS_ABILITIES) {
        let panel = GetOrCreateUnbannedSSSItem(AbilityName)

        panel.abilityname = AbilityName

        panel.SetPanelEvent('onmouseover', function () {
            $.DispatchEvent("DOTAShowAbilityTooltip", panel, AbilityName);
        });
    
        panel.SetPanelEvent('onmouseout', function () {
            $.DispatchEvent("DOTAHideAbilityTooltip", panel);
        });
    }
}

function SetupCategories(){
	InfoContainerAbilitiesCategoriesList.RemoveAndDeleteChildren()
    let MainCategoryPanel = GetOrCreateCategory(InfoContainerAbilitiesCategoriesList, "SSS")
    MainCategoryPanel.SetDialogVariable("category_name", $.Localize(`#BAN_STATE_Category_SSS`))
    MainCategoryPanel.AddClass("SSS")

    MainCategoryPanel.SetPanelEvent("onactivate", ()=>{
        SelectCategory("SSS", "")
    })

    let SortedMiniCategories = Object.keys(UNBANNED_SSS_ABILITIES).sort((a, b)=>{
        if(a == "DEFAULT"){return -1}
        let aLocalize = $.Localize(`#BAN_STATE_Category_${a}`)
        let bLocalize = $.Localize(`#BAN_STATE_Category_${b}`)
        if(aLocalize > bLocalize){return 1}
        if(aLocalize < bLocalize){return -1}
        return 0
    })
    for (const CategoryName of SortedMiniCategories) {
        if(CategoryName == "DEFAULT"){continue}

        let MiniCategoryPanel = GetOrCreateCategory(InfoContainerAbilitiesCategoriesList, CategoryName)
        MiniCategoryPanel.SetDialogVariable("category_name", $.Localize(`#BAN_STATE_Category_${CategoryName}`))
        MiniCategoryPanel.AddClass("SubCategory")

        MiniCategoryPanel.SetPanelEvent("onactivate", ()=>{
            SelectCategory("SSS", CategoryName)
        })
    }
}

function SelectCategory(CategoryName, SubCategory){
	if(SubCategory == undefined){
		SubCategory = ""
	}
	if(SelectedCategory.main == CategoryName && SelectedCategory.sub == SubCategory){return}

	SelectedCategory.main = CategoryName
	SelectedCategory.sub = SubCategory

	InfoContainerAbilitiesList.RemoveAndDeleteChildren()

	let Cat = SubCategory == "" ? CategoryName : SubCategory

	DeselectCategoryExceptOf(InfoContainerAbilitiesCategoriesList, Cat)

	UpdateInfoLists()
}

function UpdateInfoLists(){
	if(SelectedCategory.main != ""){
		let ItemsArray = []

		if(SelectedCategory.sub == ""){
			for (const TierName in UNBANNED_SSS_ABILITIES) {
                let Array = toArray(UNBANNED_SSS_ABILITIES[TierName])
                ItemsArray = ItemsArray.concat(Array)
			}
		}else{
			let Array = toArray(UNBANNED_SSS_ABILITIES[SelectedCategory.sub])
			ItemsArray = ItemsArray.concat(Array)
		}

		ItemsArray = ItemsArray.sort((a, b)=>{
			let aLocalize = $.Localize(`#DOTA_Tooltip_ability_${a}`)
			let bLocalize = $.Localize(`#DOTA_Tooltip_ability_${b}`)
			if(aLocalize > bLocalize){return 1}
			if(aLocalize < bLocalize){return -1}
			return 0
		})

		for (const Item of ItemsArray) {
			let p = GetOrCreateInfoItem(InfoContainerAbilitiesList, Item)

			p.AddClass("IsAbility")

            let CategoryItemAbilityImage = p.FindChildTraverse("CategoryItemAbilityImage")
            if(CategoryItemAbilityImage){
                CategoryItemAbilityImage.abilityname = Item
            }

            p.SetPanelEvent('onmouseover', function () {
                $.DispatchEvent("DOTAShowAbilityTooltip", p, Item);
            });
        
            p.SetPanelEvent('onmouseout', function () {
                $.DispatchEvent("DOTAHideAbilityTooltip", p);
            });

            p.SetPanelEvent("onactivate", function(){
                OnPlayerSelectedToBan(Item, "ABILITY")
            })
		}
	}
}

function GetOrCreateUnbannedSSSItem(UnbannedSSSItemName){
	let f = UnbannedSSSListContainer.FindChildTraverse(`Item_${UnbannedSSSItemName}`)
	if(f){
		return f
	}else{
		let panel = $.CreatePanel("DOTAAbilityImage", UnbannedSSSListContainer, `Item_${UnbannedSSSItemName}`, {class: "UnbannedSSSItem", scaling:"stretch-to-cover-preserve-aspect", hittest:"true"})

		return panel
	}
}

function GetOrCreateCategory(Container, CategoryName){
	let f = Container.FindChildTraverse(`Category_${CategoryName}`)
	if(f){
		return f
	}else{
		let panel = $.CreatePanel("Panel", Container, `Category_${CategoryName}`, {})
		panel.BLoadLayoutSnippet("CategoryLine")

		return panel
	}
}

function GetOrCreateInfoItem(Container, ItemName){
	let f = Container.FindChildTraverse(`InfoItem_${ItemName}`)
	if(f){
		return f
	}else{
		let panel = $.CreatePanel("Panel", Container, `InfoItem_${ItemName}`, {})
		panel.BLoadLayoutSnippet("CategoryItem")

		return panel
	}
}
function DeselectCategoryExceptOf(Container, CategoryName){
	for (let i = 0; i < Container.GetChildCount(); i++) {
		let Child = Container.GetChild(i)
		if(Child){
			Child.SetHasClass("SelectedCategory", Child.id == `Category_${CategoryName}`)
		}
	}
}

function DeselectPagesExceptOf(PageName){
	for (let i = 0; i < Pages.GetChildCount(); i++) {
		let Child = Pages.GetChild(i)
		if(Child){
			Child.SetHasClass("Selected", Child.id == `Page${PageName}`)
		}
	}
	for (let i = 0; i < BanButtons.GetChildCount(); i++) {
		let Child = BanButtons.GetChild(i)
		if(Child){
			Child.SetHasClass("Selected", Child.id == `Button${PageName}`)
		}
	}
}

function SelectPage(PageName){
	if(SelectedPage == PageName){
		return
	}

	DeselectPagesExceptOf(PageName)
}

function CloseBans(){
    BannedInThisGame.RemoveClass("Show")
    if(BansSchedule != -1){
        $.CancelScheduled(BansSchedule)
        BansSchedule = -1
    } 
}

GameUI.CustomUIConfig().ToggleGameBans = () =>
{
    BannedInThisGame.ToggleClass("Show")
    if(BansSchedule != -1){
        $.CancelScheduled(BansSchedule)
        BansSchedule = -1
    } 
}

function GetBannedItemOwner(ItemName){
    for (const PlayerID in PLAYERS_BANS_INFO) {
        let Lists = PLAYERS_BANS_INFO[PlayerID]
        for (const CATEGORY in Lists) {
            let List = Lists[CATEGORY]
            if(List.includes(ItemName)){
                return parseInt(PlayerID)
            }
        }
    }

    return -1
}

function ExtraCreatureAdded(keys) {
    let PlayerInfo = Game.GetPlayerInfo(keys.caller)

    if(!PlayerInfo){return}

    // [NP-23] Режим уведомления о призыве крипа: 0=большое, 1=маленькое, 2=выкл.
    // При "выкл" попап не показываем вообще (звук/партикла тоже). Лента не затрагивается.
    let _ecSd = GetPlayerTablesValue(`player_${Players.GetLocalPlayer()}`, `setting_data`)
    if(_ecSd && _ecSd.minimized_extra_creatures == 2){ return }

    UpdateExtraCreatureStyle()

    // let Text = `<span class="PlayerName">${PlayerInfo.player_name}</span> (<img class="HeroImage" src="file://{images}/heroes/icons/${PlayerInfo.player_selected_hero}.png"/> <span class="HeroName">${$.Localize(`#${PlayerInfo.player_selected_hero}`)}</span>) ${$.Localize("#EXTRA_CREEP_SENDED_TEXT")}`

    ExtraCreatureBlock.SetDialogVariable("caller_player_name", PlayerInfo.player_name)
    ExtraCreatureBlock.SetDialogVariable("caller_hero_name", $.Localize(`#${PlayerInfo.player_selected_hero}`))
    ExtraCreatureBlock.SetDialogVariable("creep_name", $.Localize(`#${keys.creatureName}`))

    ExtraCreaturePlayerHeroIcon.heroname = PlayerInfo.player_selected_hero

    ExtraCreatureBlock.AddClass("fade")
    // ExtraCreature.SetImage("file://{images}/custom_game/creature_show/" + keys.creatureName + ".png")
    ExtraCreature.SetUnit(keys.creatureName, "", true)
    var soundEventName = EXTRA_CREATURE_SOUND_EVENTS[keys.creatureName]
    if (soundEventName != undefined) 
    {
        Game.EmitSound(soundEventName)
    }
    Game.EmitSound("Creep.Sended")
    var particleID = Particles.CreateParticle("particles/creep_sended/creep_sended.vpcf", ParticleAttachment_t.PATTACH_EYES_FOLLOW, 0)
    $.Schedule(0.5, function() {
        Particles.DestroyParticleEffect(particleID, false)
    })

    if(Scheduler != -1){
        $.CancelScheduled(Scheduler)
        Scheduler = -1
    }

    Scheduler = $.Schedule(2, function(){
        ExtraCreatureBlock.RemoveClass("fade")
    })
}

function UpdateExtraCreatureStyle(){
    let settingData = GetPlayerTablesValue(`player_${Players.GetLocalPlayer()}`, `setting_data`)
    // [CREEP-SETTING-CLIENT] временный дебаг: что реально пришло клиенту в setting_data.
    // Виден в КЛИЕНТСКОЙ консоли (в отличие от серверного [CREEP-SETTING]).
    // value=1 а попап большой -> баг применения на клиенте; value=0/undefined -> не доехало с сервера.
    $.Msg("[CREEP-SETTING-CLIENT] setting_data=", settingData ? "есть" : "НЕТ",
          " | minimized_extra_creatures=", settingData ? settingData.minimized_extra_creatures : "(нет таблицы)",
          " | тип=", settingData ? typeof settingData.minimized_extra_creatures : "-")
    if(settingData){
        let bMinimized = settingData.minimized_extra_creatures == 1
        ExtraCreatureBlock.SetHasClass("Minimized", bMinimized)
    }
}

SubscribeAndFirePlayerTableByKey(`player_${Players.GetLocalPlayer()}`, `setting_data`, function(v){
    UpdateExtraCreatureStyle()
})

GameEvents.Subscribe("ExtraCreatureAdded", ExtraCreatureAdded);

function CloseDuelNotificationButton(){
    CloseDuelNotification()

    GameEvents.SendCustomGameEventToServer("duel_notification_closed", {});
}

function CloseDuelNotification(){
    if(BasicDuelSchedule != -1){
        $.CancelScheduled(BasicDuelSchedule)
        BasicDuelSchedule = -1
    }
    if(BasicDuelSchedule2 != -1){
        $.CancelScheduled(BasicDuelSchedule2)
        BasicDuelSchedule2 = -1
    }

    DuelNotification.RemoveClass("Show")
    DuelNotificationEnemyRow.RemoveClass("Show")
}

SubscribeAndFireNetTableByKey("players", `player_${LocalPID}_duel_info`, function(v){
    let Duration = Math.max(Math.ceil(v.LastTime - Game.GetGameTime()), 0)
    if(v.bCanBeShowed == 1 && Duration > 0){

        // $.Schedule(0.05, function(){
        //     AdjustMovablePanelPosition(DuelNotification)
        // })

        DuelNotification.AddClass("Show")
        if(BasicDuelSchedule != -1){
            $.CancelScheduled(BasicDuelSchedule)
            BasicDuelSchedule = -1
        }
        if(BasicDuelSchedule2 != -1){
            $.CancelScheduled(BasicDuelSchedule2)
            BasicDuelSchedule2 = -1
        }

        Game.EmitSound("Loot_Drop_Stinger_Short")
    
        BasicDuelSchedule = $.Schedule(Duration, function(){
            DuelNotification.RemoveClass("Show")
            DuelNotificationEnemyRow.RemoveClass("Show")
        })

        let EnemyInfo = Game.GetPlayerInfo(v.EnemyPlayerID)
        if(EnemyInfo){
            DuelNotification.SetDialogVariable("enemy_player_name", EnemyInfo.player_name)
            DuelNotification.SetDialogVariable("enemy_hero_name", $.Localize(`#${EnemyInfo.player_selected_hero}`))

            HeroIcon.heroname = EnemyInfo.player_selected_hero
        }

        let delay = 0.4

        BasicDuelSchedule2 = $.Schedule(delay, function(){
            DuelNotificationEnemyRow.AddClass("Show")

            Game.EmitSound("Draft.PickMade")
        })

    }else if(DuelNotification.BHasClass("Show")){
        CloseDuelNotification()
    }
})

let DotaHUDPanel = GetDotaHud();

// [NP-24] Прямая привязка пинга к СТАТИЧНЫМ нативным панелям HUD (сферы HP/маны, портрет
// аганим/шард, слот нейтрала). Для них StyleClassesChanged не срабатывает, поэтому находим
// панели напрямую в дереве HUD и вешаем onactivate. Ретраи — панели грузятся асинхронно.
function PingHP(){
    let u = Players.GetLocalPlayerPortraitUnit(); if(u == undefined || u == -1) return
    let hn = $.Localize("#"+Entities.GetUnitName(u))
    let hp = Math.round(Entities.GetHealth(u)), mhp = Math.round(Entities.GetMaxHealth(u))
    let pct = mhp > 0 ? Math.round(hp / mhp * 100) : 0
    SendPingTextToChat(hn + ": <font color='#6cd16c'>HP "+hp+" / "+mhp+"</font> <font color='#bfe8bf'>("+pct+"%)</font>")
}
function PingMana(){
    let u = Players.GetLocalPlayerPortraitUnit(); if(u == undefined || u == -1) return
    let hn = $.Localize("#"+Entities.GetUnitName(u))
    let mp = Math.round(Entities.GetMana(u)), mmp = Math.round(Entities.GetMaxMana(u))
    let pct = mmp > 0 ? Math.round(mp / mmp * 100) : 0
    SendPingTextToChat(hn + ": <font color='#4aa3ff'>MP "+mp+" / "+mmp+"</font> <font color='#a9d4ff'>("+pct+"%)</font>")
}
function PingScepter(){
    let u = Players.GetLocalPlayerPortraitUnit(); if(u == undefined || u == -1) return
    let hn = $.Localize("#"+Entities.GetUnitName(u))
    let status = Entities.HasScepter(u) ? $.Localize("#PING_YES") : $.Localize("#PING_NO")
    SendPingTextToChat(hn + ": " + ItemNameHtml("item_ultimate_scepter") + " — " + status)
}
function PingShard(){
    let u = Players.GetLocalPlayerPortraitUnit(); if(u == undefined || u == -1) return
    let hn = $.Localize("#"+Entities.GetUnitName(u))
    let status = HasModifier(u, "modifier_item_aghanims_shard") ? $.Localize("#PING_YES") : $.Localize("#PING_NO")
    SendPingTextToChat(hn + ": " + ItemNameHtml("item_aghanims_shard") + " — " + status)
}
function PingOwnNeutral(){
    let u = Players.GetLocalPlayerPortraitUnit(); if(u == undefined || u == -1) return
    let idx = Entities.GetItemInSlot(u, 16)
    if(idx != undefined && idx != -1){ PingAbilityToChat(idx, u) }
    else { SendPingTextToChat($.Localize("#PING_NEUTRAL_NONE").replace("%s1", $.Localize("#"+Entities.GetUnitName(u)))) }
}
// Слот нейтрала перехватывается через onactivate (там это работает).
let _nativePingMap = {
    "inventory_neutral_slot": PingOwnNeutral,
}
function AttachNativeHudPings(){
    let missing = 0, total = 0
    for(let id in _nativePingMap){
        total++
        let p = DotaHUDPanel.FindChildTraverse(id)
        if(p){
            let fn = _nativePingMap[id]
            p.SetPanelEvent("onactivate", function(){ if(IsDotaAltPressed()) fn() })
        } else { missing++ }
    }
    _nativeTries++
    if(missing > 0 && _nativeTries < 12){ $.Schedule(1.5, AttachNativeHudPings) }
}
let _nativeTries = 0
$.Schedule(2.0, AttachNativeHudPings)

// Оверлеи-дети клик не ловят (нативный компонент DOTAHealthMana перехватывает на своём уровне,
// как DOTAAbilityPanel у нейтрала, который поддался прямому onactivate). Поэтому onmousedown
// вешаем на САМ health_mana и делим HP/ману по Y курсора (HP — верхняя полоса, мана — нижняя).
// Клик по бару попадает на HealthProgress (заливка поверх контейнера), а не на сам контейнер.
// Поэтому вешаем onactivate на ВСЕ звенья: контейнер, прогресс-бар и сам health_mana (с делением
// по Y). Сработает только тот, на который реально попал клик (onactivate не всплывает) — дубля
// наших не будет, а дебаг покажет, какое звено поймало.
function HMSplitPing(){
    let useMana = false
    try { let cy = ToAbsPixelValue(GameUI.GetCursorPosition()[1]); let mc = DotaHUDPanel.FindChildTraverse("ManaContainer"); if(mc){ let b=GetAbsPanelBounds(mc); useMana=(cy>=b.minY&&cy<=b.maxY) } } catch(e){}
    if(useMana){ PingMana() } else { PingHP() }
}
function AttachHealthManaPing(){
    let targets = [
        ["HealthContainer", PingHP], ["HealthProgress", PingHP],
        ["ManaContainer", PingMana], ["ManaProgress", PingMana],
        ["health_mana", HMSplitPing], ["HealthManaContainer", HMSplitPing],
    ]
    let foundNew = false
    for(let t of targets){
        let id = t[0], fn = t[1]
        if(_hmAttached[id]) continue
        let p = DotaHUDPanel.FindChildTraverse(id)
        if(p){ p.SetPanelEvent("onactivate", function(){ if(IsDotaAltPressed()){ fn() } }); _hmAttached[id] = true; foundNew = true }
    }
    _hmTries++; _hmDry = foundNew ? 0 : (_hmDry + 1)
    if(_hmTries < 12 && _hmDry < 3){ $.Schedule(1.5, AttachHealthManaPing) }
}
let _hmTries = 0, _hmDry = 0, _hmAttached = {}
$.Schedule(2.0, AttachHealthManaPing)

// Аганим/шард: id неуникальны (несколько экземпляров) — вешаем onactivate на ВСЕ видимые
// экземпляры индикаторов. onactivate (в отличие от onmousedown) может заменить нативный пинг.
function FindAllById(root, id, out){
    if(!root) return
    try { if(root.id == id){ out.push(root) } let n=root.GetChildCount(); for(let i=0;i<n;i++){ FindAllById(root.GetChild(i), id, out) } } catch(e){}
}
let _aghsTries = 0, _aghsDry = 0, _aghsAttached = {}
function AttachAghsPings(){
    let pairs = [["AghsStatusScepterContainer", PingScepter], ["AghsStatusScepter", PingScepter], ["AghsStatusShard", PingShard]]
    let foundNew = false
    for(let pr of pairs){
        let id = pr[0], fn = pr[1]
        if(_aghsAttached[id]) continue
        let p = DotaHUDPanel.FindChildTraverse(id)
        if(p){
            try {
                if(p.actuallayoutwidth > 0 && p.actuallayoutheight > 0){
                    p.SetPanelEvent("onactivate", function(){ if(IsDotaAltPressed()){ fn() } })
                    _aghsAttached[id] = true; foundNew = true
                }
            } catch(e){}
        }
    }
    _aghsTries++; _aghsDry = foundNew ? 0 : (_aghsDry + 1)
    // Ловим панели при загрузке HUD, затем СТОП — без вечного полного обхода дерева.
    if(_aghsTries < 12 && _aghsDry < 3){ $.Schedule(1.0, AttachAghsPings) }
}
$.Schedule(2.0, AttachAghsPings)

// [NP-24] Уровень героя: onactivate на кружок уровня (LevelBackground). Обычный клик по нему
// ничего не делает, поэтому замена нативного безопасна.
function PingLevel(){
    let u = Players.GetLocalPlayerPortraitUnit(); if(u == undefined || u == -1) return
    let hn = $.Localize("#"+Entities.GetUnitName(u))
    SendPingTextToChat($.Localize("#PING_LEVEL").replace("%s1", hn).replace("%s2", Entities.GetLevel(u)))
}
function PingItemByName(itemname){
    if(!itemname || itemname == "") return
    let u = Players.GetLocalPlayerPortraitUnit(); if(u == undefined || u == -1) return
    let hn = $.Localize("#"+Entities.GetUnitName(u))
    let item = $.Localize("#DOTA_Tooltip_ability_"+itemname)
    SendPingTextToChat($.Localize("#PING_WANT_ITEM").replace("%s1", hn).replace("%s2", item))
}

// [NP-24] Хуки клика на панели магазина/уровня/квикбая УБРАНЫ:
//  - onactivate-замена на предметах магазина ломала Shift+клик → квикбай (он тоже onactivate);
//  - на уровне (DOTAXP/LevelBackground) и квикбае панорама-события (onactivate/onmousedown)
//    вообще НЕ приходят — обработка нативная C++, хука на клик нет.
// Поэтому идём единым путём через чат: нативный пинг пусть срабатывает, а его строку ловим в
// UpdateChatLines (диагностика ниже ищет признак), прячем у всех и пере-рассылаем в общий чат.
// PingLevel/PingItemByName оставлены — пригодятся для пере-рассылки, когда найдём признак.

let Hud = DotaHUDPanel.FindChildTraverse("HUDElements");
if (Hud) {
    let GlyphScanContainer = Hud.FindChildTraverse("GlyphScanContainer");
    let RoshanTimerContainer = Hud.FindChildTraverse("RoshanTimerContainer");
    let TormentorTimerContainer = Hud.FindChildTraverse("TormentorTimerContainer");
    if(RoshanTimerContainer){
        RoshanTimerContainer.style.visibility = "collapse"
    }
    if (GlyphScanContainer) {
        GlyphScanContainer.style.visibility = "collapse"
    }
    if (TormentorTimerContainer) {
        TormentorTimerContainer.style.visibility = "collapse"
    }

    let spectator_quickstats = DotaHUDPanel.FindChildTraverse("spectator_quickstats")
    if(spectator_quickstats){
        spectator_quickstats.style.visibility = "collapse"
    }
    let spectator_game_stats = DotaHUDPanel.FindChildTraverse("spectator_game_stats")
    if(spectator_game_stats){
        spectator_game_stats.style.visibility = "collapse"
    }
    let FightRecap = DotaHUDPanel.FindChildTraverse("FightRecap")
    if(FightRecap){
        FightRecap.style.visibility = "collapse"
    }
    let GoldDiscreteDisplay = Hud.FindChildTraverse("GoldDiscreteDisplay")
    if(GoldDiscreteDisplay){
        GoldDiscreteDisplay.style.visibility = "collapse"
    }
}

let bHasExtraLarge = DotaHUDPanel.BHasClass("MinimapExtraLarge")

UpdateMinimap()

function UpdateMinimap(){
    let Hud = DotaHUDPanel.FindChildTraverse("HUDElements");
    if (Hud) {
        let minimap_block = Hud.FindChildTraverse("minimap_block");
        let minimap = Hud.FindChildTraverse("minimap");
        let HUDSkinMinimap = Hud.FindChildTraverse("HUDSkinMinimap");
        let HUDSkinAbilityContainerBG = Hud.FindChildTraverse("HUDSkinAbilityContainerBG");
        let center_bg = Hud.FindChildTraverse("center_bg");

        // let SizeBorder = bHasExtraLarge ? "312px" : "276px"
        // let SizeMinimap = bHasExtraLarge ? "296px" : "260px"

        let SizeBorder = "276px"
        let SizeMinimap = "260px"

        if(minimap_block){
            minimap_block.style.width = SizeBorder
            minimap_block.style.height = SizeBorder
        }
        if(minimap){
            minimap.style.width = SizeMinimap
            minimap.style.height = SizeMinimap
        }
        if(HUDSkinMinimap){
            HUDSkinMinimap.style.visibility = "collapse"
        }
        if(HUDSkinAbilityContainerBG){
            HUDSkinAbilityContainerBG.style.visibility = "collapse"
        }
        if(center_bg){
            center_bg.style.backgroundImage = "url('s2r://panorama/images/hud/reborn/hud_custom_ti10/ability_bg_psd.vtex')"
        }
    }
}

const LocalizeFormat = function () {
	let formatted = arguments[0];
	for (let i = 1; i < arguments.length; i++) {
		const regex = new RegExp(`%s${i}`, 'g');
		formatted = formatted.replace(regex, arguments[i]);
	}
	return formatted;
};


const AlertBehavior_Skip = Symbol("AlertBehavior_Skip");
const ExplicitBehaviors = {
	["modifier_oracle_prognosticate"]: AlertBehavior_Skip,
	["modifier_bounty_hunter_track"]: AlertBehavior_Skip,
	["modifier_spirit_breaker_charge_of_darkness_target"]: AlertBehavior_Skip,
	modifier_ability_test: function (data) {
		// Custom behavior example
		return [
			"#Custom_Alert_Behavior", // %s1+%s2=%s3
			[1, 2, 3]
		]
	}
}

GameEvents.Subscribe("cdota_buff_alert", function (data) {
	let [playerid, ent, serial, hasstacks] = [data.playerid, data.ent, data.serial, data.hasstacks];
	// [NP-24] Пинг эффекта виден ВСЕМ игрокам (раньше был фильтр только для союзников).
	let name = Buffs.GetName(ent, serial);
	if (name === "") return;
	let behavior = ExplicitBehaviors[name];
	if (behavior) {
		let [loc_string, values] = behavior(data)
		// [NP-24] Пинг эффекта — в наш стиль (портрет + стрелка), как остальные пинги.
		SayLine(playerid, LocalizeFormat($.Localize(loc_string), ...values), true, 1);
	} else {
		let playerowner = Entities.GetPlayerOwnerID(ent);
		let iscontrol = Entities.GetPlayerOwnerID(ent) == playerid;
		let isdebuff = Buffs.IsDebuff(ent, serial);
		let remaining_time = Buffs.GetRemainingTime(ent, serial);
		let hasduration = Buffs.GetDuration(ent, serial) > 0 && remaining_time > 0;
		let stackcount = Buffs.GetStackCount(ent, serial);
		let ishero = Entities.IsHero(ent);
		let isenemy = Entities.IsEnemy(ent);
		let loc_string = iscontrol ? "#DOTA_Modifier_Alert" :
			ishero ?
				isenemy ? "#DOTA_Modifier_Alert_Enemy_Hero" : "#DOTA_Modifier_Alert_Ally_Hero" :
				isenemy ? "#DOTA_Modifier_Alert_Enemy_Unit" : "#DOTA_Modifier_Alert_Ally_Unit";
		let [s1, s2, s3, s4, s5, s6] = [];
		s1 = isdebuff ? "#ff0000" : "#00ff00"
		s2 = hasstacks || stackcount > 1 ? `${stackcount} ` : "";
		s3 = $.Localize("#DOTA_Tooltip_" + name);
		switch (loc_string) {
			case "#DOTA_Modifier_Alert":
				s4 = hasduration ? LocalizeFormat($.Localize("#DOTA_Modifier_Alert_Time_Remaining"), remaining_time.toFixed(1)) : "";
				SayLine(playerid, LocalizeFormat($.Localize(loc_string), s1, s2, s3, s4), true, 1);
				break;
			default:
				// Цвет имени носителя: у героя — цвет игрока; у крипа — серый (читаемее, не «чёрный»).
				s4 = ishero ? GetHEXPlayerColor(playerowner) : "#c8c8c8";
				s5 = $.Localize(`#${Entities.GetUnitName(ent)}`);
				s6 = hasduration ? LocalizeFormat($.Localize("#DOTA_Modifier_Alert_Time_Remaining"), remaining_time.toFixed(1)) : "";
				SayLine(playerid, LocalizeFormat($.Localize(loc_string), s1, s2, s3, s4, s5, s6), true, 1);
		}
	}
})

function CleanPanel(panel){
    if(!panel || !panel.IsValid()){return}

    panel.SetPanelEvent("onmouseup", ()=>{})
    panel.SetPanelEvent("onactivate", ()=>{})
    panel.SetPanelEvent("onmousedown", ()=>{})
    panel.SetPanelEvent("onmouseactivate", ()=>{})

    for (let i = 0; i < panel.GetChildCount(); i++) {
        const Child = panel.GetChild(i);
        if(Child){
            CleanPanel(Child)
        }
    }
}

let ping_stacks = 2;
let ping_cooldown = 5;

// [NP-24] Акцентные цвета имён в пинге: способности и предметы — РАЗНЫЕ (для различения контекста).
const PING_ABILITY_COLOR = "#7fb5ff"   // способности/таланты — голубой
const PING_ITEM_COLOR = "#ffcf7a"      // предметы (вкл. аганим/шард) — золотой
// Короткое имя текстуры предмета по имени: срез "item_" + суффиксов кастома (_custom/_lua),
// чтобы кастомные предметы (напр. item_smoke_of_deceit_custom) ссылались на базовую иконку.
// A40: URL иконки предмета для HTML-строк чата. file://{images} внутри <img> html-лейблов
// резолвит только вшитые иконки доты — кастомные иконки аддона грузятся ТОЛЬКО прямым
// s2r-путём к скомпилированному vtex (формат работает и для ванильных иконок — тот же
// неймспейс, прецедент: иконка врождёнки ниже). Суффиксы _custom/_lua НЕ режем:
// png кастомных иконок названы вместе с ними (items/kaya_2_lua.png).
function ItemIconUrl(tex){
    tex = tex.replace(/^\.\.\/items\//, "")   // KV вида "../items/hex_2"
    if(tex.indexOf("item_") === 0){ tex = tex.substring(5) }
    return "s2r://panorama/images/items/" + tex + "_png.vtex"
}
// HTML имени способности/предмета: иконка (предмет/спелл) + цветное имя (цвет зависит от типа).
function PingNameHtml(abilityIndex){
    let name = Abilities.GetAbilityName(abilityIndex)
    let loc = $.Localize("#DOTA_Tooltip_ability_" + name)
    // Надёжное имя текстуры (кастомные предметы задают AbilityTextureName в KV → базовая иконка).
    let tex = ""
    try { tex = Abilities.GetAbilityTextureName(abilityIndex) } catch(e){}
    if(!tex || tex === ""){ tex = name }
    if(tex.indexOf("item_") === 0){ tex = tex.substring(5) }
    let icon = "", color = PING_ABILITY_COLOR
    if(Abilities.IsItem(abilityIndex)){
        icon = "<img class='PingItemIcon' src='"+ItemIconUrl(tex)+"'/>"
        color = PING_ITEM_COLOR
    } else if(IsInnateAbility(name)){
        // Врождёнка: единая заглушка-иконка врождёнки (гарантированно рендерится).
        icon = "<img class='PingAbilityIcon' src='s2r://panorama/images/hud/facets/innate_icon_large_png.vtex'/>"
    } else if(name.indexOf("special_bonus") !== 0){
        // Способность (не талант): её spellicon. Таланты spellicon не имеют — иконку не ставим.
        icon = "<img class='PingAbilityIcon' src='file://{images}/spellicons/"+tex+".png'/>"
    }
    return icon + "<font color='"+color+"'>" + loc + "</font>"
}
// Подсветка имени предмета внутри готового текста пинга (для рероута магазина/квикбая).
function HighlightItemInText(content, itemName){
    if(!itemName || itemName === "") return content
    let loc = $.Localize("#DOTA_Tooltip_ability_" + itemName)
    if(!loc || loc === "" || content.indexOf(loc) === -1) return content
    let html = "<img class='PingItemIcon' src='"+ItemIconUrl(itemName)+"'/><font color='"+PING_ITEM_COLOR+"'>"+loc+"</font>"
    return content.replace(loc, html)
}
// Иконка+цветное имя предмета по его имени (для аганим/шард-пингов).
function ItemNameHtml(itemName){
    let loc = $.Localize("#DOTA_Tooltip_ability_" + itemName)
    return "<img class='PingItemIcon' src='"+ItemIconUrl(itemName)+"'/><font color='"+PING_ITEM_COLOR+"'>"+loc+"</font>"
}
// Подкраска словесного статуса в пинге способности: «готов(а/о)»/ready → зелёный;
// «не изучен(а)»/not learned → красный. ВАЖНО: «не изучен» красим ПЕРВЫМ (иначе «изучен» внутри
// него попадёт под зелёный). Для способностей отдельного «изучен» (без «не») нет — это таланты.
function ColorPingStatus(msg){
    // \S* (НЕ \w* — \w не матчит кириллицу, из-за чего «не изучена» красилась лишь наполовину).
    msg = msg.replace(/(не\s+изуч\S*|not\s+learned)/gi, "<font color='#e05c5c'>$1</font>")
    msg = msg.replace(/(готов\S*|\bready\b)/gi, "<font color='#5dd45d'>$1</font>")
    return msg
}

// [NP-24] Строит ГОТОВУЮ строку пинга на клиенте ПИНГУЮЩЕГО (где entity способности/
// предмета валиден). У получателей entity-индексы способностей не резолвятся → строим
// строку здесь и рассылаем её, а не индексы. Возвращает строку (или undefined).
// Иконку-стрелку добавляет SayLine (hasIcon) — здесь её НЕ встраиваем (единая позиция стрелки).
function BuildAbilityPingMessage(abilityIndex, ent){
    if(abilityIndex == undefined || abilityIndex == -1 || ent == undefined || ent == -1){ return }
    if(!Entities.IsHero(ent) && !Entities.IsCreep(ent)){ return }   // [NP-24] разрешаем и крипов (пинг их способностей)

    let playerowner = Entities.GetPlayerOwnerID(ent);
    let isenemy = Entities.IsEnemy(ent);
    let level = Abilities.GetLevel( abilityIndex )
    let is_item = Abilities.IsItem( abilityIndex )
    let is_passive = Abilities.IsPassive( abilityIndex )

    let loc = ""
    let [s1, s2, s3, s4, s5, s6] = [];

    if(isenemy){
        loc = "#DOTA_EnemyAbility_Ping"
        s2 = ""
        s3 = PingNameHtml(abilityIndex);
        // Имя владельца: у героя — цвет игрока; у крипа владелец «чёрный» → берём серый (читаемее).
        let ownerColor = Entities.IsHero(ent) ? GetHEXPlayerColor(playerowner) : "#c8c8c8"
        s1 = `<font color='${ownerColor}'>`
        s4 = $.Localize(`#${Entities.GetUnitName(ent)}`)
        if(is_item){
            if(Items.RequiresCharges( abilityIndex ))
                s3 += $.Localize("#DOTA_Item_Charge_Description:p").replace("%s1", Abilities.GetCurrentCharges( abilityIndex ))
            else if(Items.IsStackable( abilityIndex )){
                s3 += $.Localize("#DOTA_Item_Charge_StackableDescription").replace("%s1", Abilities.GetCurrentCharges( abilityIndex ))
            }
        }
    }else{
        s3 = ""
        s2 = PingNameHtml(abilityIndex);
        s1 = ""
        if(is_item){
            loc = "#DOTA_Item_Ping_Ready"
            if(Items.RequiresCharges( abilityIndex ))
                s2 += $.Localize("#DOTA_Item_Charge_Description:p").replace("%s1", Abilities.GetCurrentCharges( abilityIndex ))
            else if(Items.IsStackable( abilityIndex )){
                s2 += $.Localize("#DOTA_Item_Charge_StackableDescription").replace("%s1", Abilities.GetCurrentCharges( abilityIndex ))
            }
        }else{
            if(level <= 0){
                loc = "#DOTA_Ability_Ping_Unlearned"
            }else{
                if(is_passive){
                    loc = "#DOTA_Ability_Ping_ReadyPassive"
                }else{
                    loc = "#DOTA_Ability_Ping_Ready"
                }
                if(Abilities.UsesAbilityCharges(abilityIndex)){
                    loc = "#DOTA_Ability_Ping_ReadyCharges"
                    s5 = Abilities.GetCurrentAbilityCharges( abilityIndex )
                }
                s4 = level
                if(!Abilities.IsCooldownReady( abilityIndex )){
                    loc = "#DOTA_Ability_Ping_Cooldown"
                    s5 = level
                    s4 = Abilities.GetCooldownTimeRemaining( abilityIndex ).toFixed(1)
                    if(Abilities.UsesAbilityCharges(abilityIndex)){
                        s4 = Abilities.GetAbilityChargeRestoreTimeRemaining(abilityIndex).toFixed(1)
                    }
                }
            }
        }
    }

    return ColorPingStatus(LocalizeFormat($.Localize(loc), s1, s2, s3, s4, s5, s6));
}

// [NP-24] Сообщение пинга способности по ИМЕНИ (без живой сущности) — для превью в «подробнее».
// Формат идентичен BuildAbilityPingMessage (вражеский вариант): «Остерегайтесь <abil> у <unit>».
function BuildAbilityPingByName(abilityName, unitName){
    let s3 = "<img class='PingAbilityIcon' src='file://{images}/spellicons/"+abilityName+".png'/><font color='"+PING_ABILITY_COLOR+"'>"+$.Localize("#DOTA_Tooltip_ability_"+abilityName)+"</font>"
    let s1 = "<font color='#c8c8c8'>"   // имя крипа серым (как у вражеского крипа в обычном пинге)
    let s4 = $.Localize("#"+unitName)
    return LocalizeFormat($.Localize("#DOTA_EnemyAbility_Ping"), s1, "", s3, s4, "", "")
}
GameUI.CustomUIConfig().BuildAbilityPingByName = BuildAbilityPingByName

// [A65] Пинг смока по ЧИСЛУ зарядов, когда живой сущности нет (пустой смок-слот = 0 смоков).
// Иконку/имя собираем вручную ровно как PingNameHtml для предмета: иконка — базовая
// item_smoke_of_deceit (AbilityTextureName кастома → базовый item), имя — кастомный ключ,
// заряды — тем же "(xN)"-суффиксом (#DOTA_Item_Charge_Description:p), что и живой предмет.
// Формат совпадает с BuildAbilityPingMessage: враг → «Остерегайтесь <иконка Smoke (xN)> у <герой>»,
// союзник → «<иконка Smoke (xN)> готов». Нужно, чтобы пустой слот писал x0 в том же виде, что живой.
function BuildSmokePingByCharges(unit, charges){
    if(unit == undefined || unit == -1){ return }
    let nameHtml = "<img class='PingItemIcon' src='"+ItemIconUrl("item_smoke_of_deceit")+"'/><font color='"+PING_ITEM_COLOR+"'>"+$.Localize("#DOTA_Tooltip_ability_item_smoke_of_deceit_custom")+"</font>"
    // Смок стакаемый (ItemStackable=1) → живой пинг берёт ветку StackableDescription (даёт «(xN)»),
    // а НЕ :p-ключ (тот для заряжаемых предметов и не резолвится здесь). Повторяем ту же ветку.
    nameHtml += $.Localize("#DOTA_Item_Charge_StackableDescription").replace("%s1", charges)
    let unitLoc = $.Localize("#"+Entities.GetUnitName(unit))
    if(Entities.IsEnemy(unit)){
        let ownerColor = Entities.IsHero(unit) ? GetHEXPlayerColor(Entities.GetPlayerOwnerID(unit)) : "#c8c8c8"
        return LocalizeFormat($.Localize("#DOTA_EnemyAbility_Ping"), "<font color='"+ownerColor+"'>", "", nameHtml, unitLoc, "", "")
    }
    return LocalizeFormat($.Localize("#DOTA_Item_Ping_Ready"), "", nameHtml, "", "", "", "")
}
GameUI.CustomUIConfig().BuildSmokePingByCharges = BuildSmokePingByCharges

// [NP-24] Рассылка готового пинга ВСЕМ через кастомный чат SayLine (умеет HTML: иконка-стрелка,
// цвет, иконка предмета, портрет; виден всем, включая врагов). Заменил серверный Say, который
// резал любой HTML — из-за чего раньше стояла юникод-стрелка ►. is_ping=1 → SayLine не режет HTML.
function RenderPingToAll(msg, hasIcon){
    GameEvents.SendCustomGameEventToAllClients("chat_say_from_ally", { caller: LocalPID, msg: msg, has_icon: hasIcon ? 1 : 0, allow_self: 1, is_ping: 1 });
}
// [NP-DBG] Мастер-тумблер Alt-пингов (всё, что добавлено в патче 16.06: Alt+клик по
// элементам HUD/дуэли -> пинг в чат, покадровый опрос Alt+ЛКМ, рероут нативного пинга).
// Управляется из чит-панели (раздел «Другое») для проверки, уходят ли микроподёргивания.
// По умолчанию ВКЛ — штатное поведение. Шарится через CustomUIConfig (как SendPingTextToChat).
let AltPingEnabled = true
GameUI.CustomUIConfig().IsAltPingEnabled = function(){ return AltPingEnabled }
GameUI.CustomUIConfig().SetAltPingEnabled = function(v){
    let was = AltPingEnabled
    AltPingEnabled = !!v
    // Перезапускаем покадровый опрос, если включили обратно (при выключении он сам остановился).
    if(AltPingEnabled && !was && typeof AltClickPoll === "function"){ AltClickPoll() }
}

function SendPingTextToChat(text, hasIcon){
    if(!AltPingEnabled){ return false }
    if(!text || text === ""){ return false }
    if(ping_stacks <= 0){ return false }
    ping_stacks--;
    $.Schedule(ping_cooldown, () => { ping_stacks++; });
    if(hasIcon === undefined){ hasIcon = true }   // плоский текст → стрелку нарисует SayLine
    RenderPingToAll(text, hasIcon);
    return true;
}
GameUI.CustomUIConfig().SendPingTextToChat = SendPingTextToChat

function PingAbilityToChat(abilityIndex, ent){
    if(abilityIndex == undefined || abilityIndex == -1 || ent == undefined || ent == -1){ return }
    if(!Entities.IsHero(ent) && !Entities.IsCreep(ent)){ return }   // [NP-24] разрешаем и крипов (пинг их способностей)
    let msg = BuildAbilityPingMessage(abilityIndex, ent);
    if(!msg){ return }
    SendPingTextToChat(msg);
}
GameUI.CustomUIConfig().PingAbilityToChat = PingAbilityToChat
// Алиас для совместимости: предметы пингуются тем же кодом.
GameUI.CustomUIConfig().PingItemToChat = PingAbilityToChat

$.RegisterForUnhandledEvent("DOTAShowBuffTooltip", function (buffpanel, ent, serial) {
    let button = buffpanel.GetChild(0);
    let name = Buffs.GetName(ent, serial);
    if (button) {
        button.SetPanelEvent("onactivate", function () {
            if (ExplicitBehaviors[name] == AlertBehavior_Skip) {
                Players.BuffClicked(ent, serial, AltPingEnabled && IsDotaAltPressed());
            } else if (AltPingEnabled && IsDotaAltPressed()) {
                if (ping_stacks <= 0) return;
                ping_stacks--;
                $.Schedule(ping_cooldown, () => {
                    ping_stacks++;
                });
                GameEvents.SendCustomGameEventToAllClients("cdota_buff_alert", {
                    playerid: Players.GetLocalPlayer(),
                    ent: ent,
                    serial: serial,
                    hasstacks: buffpanel.BHasClass("has_stacks"),
                });
            }
        });
    }
})

$.RegisterForUnhandledEvent("StyleClassesChanged", function(panel){
    if(panel == null){return;}
    if(panel.type == "DOTAAbilityPanel"){
        const itemImage = panel.FindChildTraverse("ItemImage")
        const abilityImage = panel.FindChildTraverse("AbilityImage")
		let abilityIndex = itemImage.contextEntityIndex >= 0 ? itemImage.contextEntityIndex : abilityImage.contextEntityIndex;
        // [NP-24] Свой слот нейтрала — отдельный обработчик: на момент клика читаем слот 16
        // СВЕЖИМ (захваченный abilityIndex устаревает после удаления нейтрала) и обрабатываем
        // пустой слот (иначе пустой → нативный командный пинг). Это перекрывает generic-ветку.
        if(panel.id == "inventory_neutral_slot"){
            panel.SetPanelEvent("onactivate", function(){
                let myUnit = Players.GetLocalPlayerPortraitUnit()
                let idx = Entities.GetItemInSlot(myUnit, 16)
                if(!IsDotaAltPressed()){
                    // [A11] Обычный клик — активируем нейтрал-предмет (как generic-ветка ниже на ~1093).
                    // Этот обработчик перекрывает neutrals.js, поэтому каст нужен ИМЕННО здесь.
                    // Пассивные предметы не кастуем.
                    if(idx != undefined && idx != -1 && !Abilities.IsPassive(idx)){
                        if(Entities.IsControllableByPlayer(myUnit, LocalPID)){
                            Abilities.ExecuteAbility(idx, myUnit, false)
                        }
                    }
                    return
                }
                if(idx != undefined && idx != -1){
                    PingAbilityToChat(idx, myUnit)
                } else {
                    let hn = $.Localize("#"+Entities.GetUnitName(myUnit))
                    SendPingTextToChat($.Localize("#PING_NEUTRAL_NONE").replace("%s1", hn))
                }
            })
            return
        }
        // [A65] TP-слот = слот смока (мод кладёт смок в слот 15 поверх TP). Как и у нейтрала:
        // на клике читаем слот 15 СВЕЖИМ, иначе захваченный abilityIndex устаревает (переиспользование
        // entity-index → в чат уходит ЧУЖОЙ смок пингующего либо пустой «модификатор»). Пустой = 0 смоков.
        if(panel.id == "inventory_tpscroll_slot"){
            panel.SetPanelEvent("onactivate", function(){
                let myUnit = Players.GetLocalPlayerPortraitUnit()
                let idx = Entities.GetItemInSlot(myUnit, 15)
                if(!IsDotaAltPressed()){
                    // Обычный клик — используем предмет слота (TP/смок), как generic-ветка ниже.
                    if(idx != undefined && idx != -1 && !Abilities.IsPassive(idx)){
                        if(Entities.IsControllableByPlayer(myUnit, LocalPID)){
                            Abilities.ExecuteAbility(idx, myUnit, false)
                        }
                    }
                    return
                }
                if(idx != undefined && idx != -1){
                    PingAbilityToChat(idx, myUnit)
                } else {
                    // Пусто = 0 смоков: x0-пинг в том же формате, что живой смок.
                    SendPingTextToChat(BuildSmokePingByCharges(myUnit, 0))
                }
            })
            return
        }
        if(abilityIndex >= 0){
            let AbilityButton = panel.FindChildTraverse("AbilityButton")
            if(AbilityButton){
                CleanPanel(abilityImage)
                let p = panel
                let FixCastPanel = AbilityButton.FindChildTraverse("FixCast")
                if(!FixCastPanel){
                    FixCastPanel = $.CreatePanel("Panel", AbilityButton, "FixCast", {style: "width: 100%; height: 100%; z-index: -1;", hittest: true})
                    FixCastPanel.SetPanelEvent("onmousedown", ()=>{})
                }
                if(!Abilities.IsItem( abilityIndex )){
                    p = FixCastPanel

                    p.SetPanelEvent("oncontextmenu", function(){
                        if(Entities.IsControllableByPlayer(Players.GetLocalPlayerPortraitUnit(), LocalPID)){
                            let order = dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TOGGLE_ALT
                            if(Abilities.IsAutocast( abilityIndex )){
                                order = dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TOGGLE_AUTO
                            }
                            Game.PrepareUnitOrders( {
                                OrderType: order,
                                AbilityIndex: abilityIndex,
                                UnitIndex: Players.GetLocalPlayerPortraitUnit(),
                                Queue: false,
                                ShowEffects: false,
                            } )
                        }
                    })
                }
                p.SetPanelEvent("onactivate", function () {
                    if(IsDotaAltPressed()){
                        // [NP-24] Пинг рассылается ВСЕМ через PingAbilityToChat (фильтр крипов
                        // + рейт-лимит внутри). Раньше печаталось локально -> видел только пингующий.
                        PingAbilityToChat(abilityIndex, Players.GetLocalPlayerPortraitUnit())
                    }else{
                        if(Entities.IsControllableByPlayer(Players.GetLocalPlayerPortraitUnit(), LocalPID)){
                            Abilities.ExecuteAbility( abilityIndex, Players.GetLocalPlayerPortraitUnit(), false )
                        }
                    }
                })
            }
        }
    }
    if(panel.id != "Hud"){return;}

    if(bHasExtraLarge != panel.BHasClass("MinimapExtraLarge")){
        bHasExtraLarge = panel.BHasClass("MinimapExtraLarge")
        UpdateMinimap()
    }
})

// SetupMovablePanel(DuelNotification, DuelNotification, {align: [1,0], margin: [0,150]})

// $.RegisterForUnhandledEvent("DOTAHeroFacetPickerFacetSelected", function(HeroID, FacetID){
//     FacetID = FacetID & 0xFFFFFFFF

//     $.Msg(FacetID)
// });

// DOTAShowTalentDisplayTooltip
// DOTAShowTalentTextTooltip

// const TestPanel = $("#TestPanel")

// Abilities.PingAbility( Entities.GetAbility( Players.GetLocalPlayerPortraitUnit(), 0 ) )
function FirstLoad(){
    let ChatLines = DotaHUDPanel.FindChildTraverse("ChatLinesPanel");
    if (ChatLines) {
        let Childs = ChatLines.GetChildCount();
        for (let i = 0; i < Childs; i++) {
            let Child = ChatLines.GetChild(i);
            if (Child != undefined && !Child._created) {
                Child._created = true;
            }
        }
    }
}

let LastCount = 0

// [NP-24] Флаг "локальный Alt+ЛКМ" — детерминированный признак СВОЕГО нативного HUD-пинга
// (уровень/магазин/квикбай и пр.): нативный пинг = всегда мой клик с Alt, а обычный текст
// набирается в чат-боксе БЕЗ Alt+ЛКМ. По флагу прячем нативную строку (она уходит в
// [Союзникам]) и пере-рассылаем её текст в ОБЩИЙ чат — без хрупкого matching по тексту и без
// перехвата кликов магазина (Shift+ЛКМ → квикбай не задет).
let AltClickPingFlag = false
let LastAltItemName = ""
// Имя предмета под курсором (магазин/квикбай) — чтобы подсветить именно его при рероуте пинга.
function GetItemNameUnderCursor(){
    try {
        let cur = GameUI.GetCursorPosition()
        let cx = ToAbsPixelValue(cur[0]), cy = ToAbsPixelValue(cur[1])
        // Магазин: кликабельна вся плитка MainShopItem — её берём по границам (надёжнее мелкого
        // ItemImage), имя — из её дочернего ItemImage.
        let shop = DotaHUDPanel.FindChildTraverse("shop")
        if(shop && shop.BHasClass("ShopOpen")){
            let tiles = shop.FindChildrenWithClassTraverse("MainShopItem")
            for(let i=0;i<tiles.length;i++){
                let b = GetAbsPanelBounds(tiles[i])
                if(cx>=b.minX && cx<=b.maxX && cy>=b.minY && cy<=b.maxY){
                    let img = tiles[i].FindChildTraverse("ItemImage")
                    if(img && img.itemname && img.itemname !== ""){ return img.itemname }
                }
            }
        }
        // Квикбай: предметы — панели ItemImage.
        let qb = DotaHUDPanel.FindChildTraverse("quickbuy")
        if(qb){
            let imgs = qb.FindChildrenWithClassTraverse("ItemImage")
            for(let j=0;j<imgs.length;j++){
                let img = imgs[j]
                if(img.itemname && img.itemname !== ""){
                    let b = GetAbsPanelBounds(img)
                    if(cx>=b.minX && cx<=b.maxX && cy>=b.minY && cy<=b.maxY){ return img.itemname }
                }
            }
        }
    } catch(e){}
    return ""
}
function AltClickPoll(){
    if(!AltPingEnabled){ return }   // тумблер выкл -> полностью гасим покадровый цикл
    $.Schedule(0.0, AltClickPoll)
    if(IsDotaAltPressed() && GameUI.IsMouseDown(0) && !AltClickPingFlag){
        AltClickPingFlag = true
        LastAltItemName = GetItemNameUnderCursor()
        $.Schedule(0.7, function(){ AltClickPingFlag = false; LastAltItemName = "" })
    }
}
AltClickPoll()

// Имя предмета по ТЕКСТУ пинга: среди предметов магазина/квикбая ищем тот, чьё локализованное
// имя входит в текст (берём самое длинное совпадение). Надёжнее координат: текст движка уже
// называет предмет, а координатный детект цеплял скрытые плитки магазина / не видел квикбай.
// Рекурсивно собирает все непустые itemname под панелью (магазин/квикбай). "ItemImage" — это
// id, а не класс, поэтому ищем по свойству itemname на любой панели, без привязки к классу/id.
function CollectItemNames(root, out){
    if(!root) return
    try {
        let nm = root.itemname
        if(nm && nm !== "" && out.indexOf(nm) === -1){ out.push(nm) }
        let n = root.GetChildCount()
        for(let i=0;i<n;i++){ CollectItemNames(root.GetChild(i), out) }
    } catch(e){}
}
function GetItemNameFromContent(content){
    let best = "", bestLen = 0
    try {
        let names = []
        CollectItemNames(DotaHUDPanel.FindChildTraverse("shop"), names)
        CollectItemNames(DotaHUDPanel.FindChildTraverse("quickbuy"), names)
        for(let j=0;j<names.length;j++){
            let loc = $.Localize("#DOTA_Tooltip_ability_" + names[j])
            if(loc && loc !== "" && content.indexOf(loc) !== -1 && loc.length > bestLen){
                best = names[j]; bestLen = loc.length
            }
        }
    } catch(e){}
    return best
}
// Индекс врождённой способности юнита (как в duel_info.js) — чтобы пинг врождёнки по панораме
// рендерить так же, как в окне дуэли (иконка+цвет), а не плоским рероут-текстом.
function FindInnateAbility(unit){
    try {
        if(unit == undefined || unit == -1) return -1
        let n = Entities.GetAbilityCount(unit)
        for(let i=0;i<n;i++){
            let ab = Entities.GetAbility(unit, i)
            if(ab != undefined && ab != -1 && IsInnateAbility(Abilities.GetAbilityName(ab))){ return ab }
        }
    } catch(e){}
    return -1
}

// Вырезает из строки чата ведущий "[Канал] Имя: " — остаётся чистый текст пинга.
function ExtractPingContent(text){
    let t = (text || "")
    t = t.replace(/^\s*\[[^\]]*\]\s*/, "")   // убрать ведущий "[Союзникам]"
    t = t.replace(/^[^:]*:\s*/, "")           // убрать "Имя: "
    return t.trim()
}

// [NP-24] Талант-пинг (содержит «…»): сам текст — в цвет способностей (голубой), а статус в конце
// (изучен / не изучен) — зелёным/красным. Признак таланта — наличие «…» в тексте.
function IsTalentContent(content){ return content.indexOf("«") !== -1 }
function ColorTalent(content){
    // 1) описание в «…» → цвет способностей (только содержимое скобок).
    let html = content.replace(/«([^»]*)»/g, "«<font color='"+PING_ABILITY_COLOR+"'>$1</font>»")
    // 2) статус в конце. В этом моде ВЫУЧЕННЫЙ талант = «готов», невыученный = «не изучен».
    //    «не изучен»/«not learned» → красный; «готов»/«изучен»/«ready»/«learned» → зелёный.
    //    Красный проверяем ПЕРВЫМ (иначе «изуч» внутри «не изучен» уйдёт в зелёный).
    //    ВАЖНО: \S* (не \w* — \w НЕ матчит кириллицу, из-за чего «не изучен» раньше не ловился).
    let red = html.match(/(не\s+изуч\S*|not\s+learned)\s*$/i)
    if(red){
        html = html.slice(0, html.length - red[0].length) + "<font color='#e05c5c'>"+red[0]+"</font>"
    } else {
        let green = html.match(/(готов\S*|изуч\S*|ready|learned)\s*$/i)
        if(green){
            html = html.slice(0, html.length - green[0].length) + "<font color='#5dd45d'>"+green[0]+"</font>"
        }
    }
    // 3) иконку талантов пока не ставим (решим позже) — только цвет текста/статуса.
    return html
}

function UpdateChatLines() {
    $.Schedule(0.0, UpdateChatLines);
    let ChatLines = DotaHUDPanel.FindChildTraverse("ChatLinesPanel");
    if (ChatLines) {
        let Childs = ChatLines.GetChildCount();
        if(LastCount >= Childs){
            FirstLoad()
        }
        LastCount = Childs
        for (let i = 0; i < Childs; i++) {
            let Child = ChatLines.GetChild(i);
            if (Child != undefined && !Child._created) {
                Child._created = true;
                let txt = Child.text || ""
                // [NP-24] Мой нативный HUD-пинг (только что был Alt+ЛКМ) ушёл в канал [Союзникам] →
                // ПРЯЧЕМ строку и пере-рассылаем её текст в ОБЩИЙ чат. НЕ зеркалим в союзный.
                // Защита "►": пере-рассланная строка (с маркером ►) не ловится повторно.
                // [NP-24] Мой нативный HUD-пинг ушёл в канал [Союзникам] → ПРЯЧЕМ строку и
                // пере-рассылаем её текст в ОБЩИЙ чат. Признак "мой пинг": (флаг недавнего Alt+ЛКМ
                // ИЛИ Alt зажат прямо сейчас) + строка содержит моё имя + это не уже пере-рассланная
                // нами строка (в ней текстовый маркер ►; у нативной стрелка — картинка, не текст).
                // Alt-зажат добавлен, т.к. покадровый опрос мыши изредка пропускал быстрый клик →
                // пинг утекал в союзный (двойной пинг). Имя-гард не даёт рероутить чужие союзные строки.
                let altActive = AltPingEnabled && (AltClickPingFlag || IsDotaAltPressed())
                let myName = ""; try { myName = Game.GetPlayerInfo(LocalPID).player_name } catch(e){}
                if(altActive && txt.includes("  [") && txt.indexOf("►") === -1 && (myName === "" || txt.indexOf(myName) !== -1)){
                    let content = ExtractPingContent(txt)
                    let unit = Players.GetLocalPlayerPortraitUnit()
                    let itemName = GetItemNameFromContent(content)
                    let rich
                    // Врождёнка: пинг по панораме (HUD) рендерим как в окне дуэли (иконка+цвет) —
                    // если в тексте есть имя врождёнки выбранного юнита, строим её как ability.
                    let innateAb = FindInnateAbility(unit)
                    if(innateAb !== -1){
                        let innateLoc = $.Localize("#DOTA_Tooltip_ability_" + Abilities.GetAbilityName(innateAb))
                        if(innateLoc && innateLoc !== "" && content.indexOf(innateLoc) !== -1){
                            rich = BuildAbilityPingMessage(innateAb, unit)
                        }
                    }
                    if(rich === undefined){
                        if(itemName !== ""){
                            rich = HighlightItemInText(content, itemName)
                        } else if(IsTalentContent(content)){
                            rich = ColorTalent(content)   // талант: текст голубым, статус зелёным/красным
                        } else {
                            rich = content
                        }
                    }
                    try { Child.visible = false; Child.style.height = "0px" } catch(e){}
                    if(content != ""){ SendPingTextToChat(rich) }
                    continue
                }
                if(txt.includes("  [")){
                    let bHasIcon = Child.FindChildrenWithClassTraverse("ChatWheelIcon")
                    GameEvents.SendCustomGameEventToAllClients("chat_say_from_ally", { caller: LocalPID, msg: txt, has_icon: (bHasIcon && bHasIcon[0]) });
                }
            }
        }
    }
}

function SayLine(CallerPlayerID, Msg, bHasIcon, isPing){
    let Info = Game.GetPlayerInfo(CallerPlayerID)
    let HeroName = Info.player_selected_hero
    let playerColor = GetHEXPlayerColor(CallerPlayerID)

    let ChatWheelIcon = " "
    if(bHasIcon){
        // ведущий пробел → после «Имя:» идёт пробел, потом стрелка (в одну линию, как у фраз).
        ChatWheelIcon = " <img class='ChatWheelIcon' src='file://{images}/control_icons/chat_wheel_icon.png' />"
    }

    let GuildName = ""
    if(!isPing){
        // Обычный чат: режем канал/гильдию и "Имя : " (это формат полной нативной чат-строки).
        Msg = Msg.replace(/  \[.*?\]/g, "")
        let FindGuild = Msg.match(/\[.*?\]/g)
        Msg = Msg.replace(/.*? : */g, "")
        GuildName = FindGuild && FindGuild[0] ? " " + FindGuild[0] : ""
    }
    // Пинг (isPing): Msg — уже готовый HTML-контент (иконки/цвет), регэкспы НЕ применяем.

    let Text = `<font color='${playerColor}'>${Info.player_name}${GuildName}</font>:${ChatWheelIcon}${Msg}`

    let ChatLines = DotaHUDPanel.FindChildTraverse("ChatLinesPanel")
    if(ChatLines){
        let msgPanel = $.CreatePanel("Panel", ChatLines, "", {class:"ChatLine"})
        msgPanel.BLoadLayout("file://{resources}/layout/custom_game/custom_chat_line.xml", false, false)
        msgPanel.hittest = false
        msgPanel._created = true

        let HeroImage = msgPanel.FindChildTraverse("HeroImage")

        HeroImage.SetImage( "file://{images}/heroes/" + HeroName + ".png" );

        msgPanel.SetDialogVariable("chat_line", Text)
        $.Schedule(5, function(){
            if(msgPanel && msgPanel.IsValid()){
                msgPanel.AddClass("ExpireThis")
            }
        })
    }
}

FirstLoad()
UpdateChatLines()

// MF-18: локальная проверка мута по категории (стор GameUI.CustomUIConfig().MutePrefs,
// ключ — PlayerID цели). Мут по категории (флага all нет — «всё» = все 3 включены).
function _MuteCatLocal(pid, cat){
    let cfg = GameUI.CustomUIConfig()
    let store = cfg && cfg.MutePrefs
    if(!store || !store[pid]){ return false }
    return store[pid][cat] ? true : false
}

GameEvents.Subscribe("chat_say_from_ally", function(event){
    if(event.caller != LocalPID || event.allow_self == 1){
        // Мут текстового чата игрока (категория «Текст»). Пинги (is_ping) не глушим.
        if(event.is_ping != 1 && _MuteCatLocal(event.caller, "text")){ return }
        SayLine(event.caller, event.msg, event.has_icon, event.is_ping)
    }
})