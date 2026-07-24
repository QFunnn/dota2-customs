--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


// Все возможные SSS-подкатегории — для очистки старых классов перед установкой
// новой при сортировке/перерисовке списка. Должно быть объявлено ДО любых
// SubscribeAndFire-колбэков (они срабатывают синхронно и вызывают UpdateInfoLists
// → ReferenceError если const ещё в TDZ).
const BANS_SUBGROUP_CLASSES = ["FormsSub","SplashesSub","OpSub","BkbSub","BashesSub","PercentSub","SavesSub","UsefulSub"]
function GetSubgroupClass(subgroupName){
    if(!subgroupName) return null
    // FORMS → FormsSub, SPLASHES → SplashesSub, etc.
    return subgroupName.charAt(0) + subgroupName.slice(1).toLowerCase() + "Sub"
}

const LocalPID = Players.GetLocalPlayer()

const CurrentBannedListHeroes = $("#CurrentBannedListHeroes")
const CurrentBannedListAbilities = $("#CurrentBannedListAbilities")

const UnbannedSSSListContainer = $("#UnbannedSSSListContainer")

const BanButtons = $("#BanButtons")
const Pages = $("#Pages")
const InfoContainerAbilitiesCategoriesList = $("#InfoContainerAbilitiesCategoriesList")
const InfoContainerAbilitiesList = $("#InfoContainerAbilitiesList")

const PageBanned = $("#PageBanned")

let OveredToIcon = false

let PLAYERS_BANS_INFO = {}

let UNBANNED_SSS_ABILITIES = []

let SelectedPage = ""

let SelectedCategory = {
    main: "",
    sub: ""
};

for (const PlayerID of Game.GetAllPlayerIDs()) {
    SubscribeAndFirePlayerTableByKey(`player_${PlayerID}_global`, `ban_info`, function(v){
        PLAYERS_BANS_INFO[PlayerID] = {
            heroes: toArray(v.banned_heroes),
            abilities: toArray(v.banned_abilities),
        }
        // Per-player данные могут прийти ПОСЛЕ отрисовки глобального списка (особенно
        // на реконнекте). Перерисовываем иконки чтобы показать "кто заблокировал".
        let globalBans = CustomNetTables.GetTableValue("globals", "ban_info")
        if (globalBans) UpdateThisGameBans(globalBans)
    })
}

SubscribeAndFirePlayerTableByKey("globals", `unbanned_sss_abilities`, function(v){
    if (!IsPlayerBattlePassSubscribed(LocalPID)) return

    UNBANNED_SSS_ABILITIES = v

    SetupCategories()

    SelectCategory("SSS")
})

SubscribeAndFireNetTableByKey("globals", "ban_info", function(v){
    UpdateThisGameBans(v)
})

SelectPage("Banned")

function UpdateThisGameBans(v){
    // Динамическая проверка BP — на реконнекте players_server_info приходит с задержкой,
    // статический const при загрузке скрипта мог быть false.
    const bSubscribedToBattlePass = IsPlayerBattlePassSubscribed(LocalPID)
    let c = 0
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

			// Container.SetHasClass("SmallIcons", TableInfo.length > 11)
			for (const Name of TableInfo) {
                c++;
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

    PageBanned.SetHasClass("Empty", c == 0)
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

// Snippet CategoryLine кладётся внутрь созданной обёртки и сам имеет hittest=true.
// Клик попадает на внутреннюю панель, поэтому onactivate надо вешать именно на неё,
// иначе хендлер на обёртке не сработает.
function GetCategoryClickTarget(wrapperPanel){
    if(!wrapperPanel) return null
    let inner = wrapperPanel.FindChildrenWithClassTraverse("CategoryLine")
    if(inner && inner[0]) return inner[0]
    return wrapperPanel
}

function SetupCategories(){
	InfoContainerAbilitiesCategoriesList.RemoveAndDeleteChildren()
    let MainCategoryPanel = GetOrCreateCategory(InfoContainerAbilitiesCategoriesList, "SSS")
    MainCategoryPanel.SetDialogVariable("category_name", $.Localize(`#BAN_STATE_Category_SSS`))
    MainCategoryPanel.AddClass("SSS")

    GetCategoryClickTarget(MainCategoryPanel).SetPanelEvent("onactivate", ()=>{
        SelectCategory("SSS", "")
    })

    // Канонический список — на случай если сервер не прислал часть категорий.
    let canonicalSubs = (typeof SSS_SUBGROUPS !== "undefined" && SSS_SUBGROUPS) ? SSS_SUBGROUPS.slice() : []
    let serverSubs = Object.keys(UNBANNED_SSS_ABILITIES)
    let allSubsSet = {}
    for(let k of canonicalSubs){ allSubsSet[k] = true }
    for(let k of serverSubs){ allSubsSet[k] = true }
    let SortedMiniCategories = Object.keys(allSubsSet).sort((a, b)=>{
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
        // Привязываем имя категории к панели — нужно для real-time перерисовки полос
        // при смене настроек подсветки (RefreshCategoryStripes ниже).
        MiniCategoryPanel.zxcCategoryName = CategoryName
        ApplyCategoryStripeColor(MiniCategoryPanel, CategoryName)

        GetCategoryClickTarget(MiniCategoryPanel).SetPanelEvent("onactivate", ()=>{
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
		// {name, sub} — храним подкатегорию для каждой способности, чтобы повесить
		// цветовой класс полосы (CategoryItemColorStripe) даже когда сетка
		// смешана (SSS Разряд показывает все подкатегории сразу).
		let ItemsArray = []

		if(SelectedCategory.sub == ""){
			for (const TierName in UNBANNED_SSS_ABILITIES) {
                let arr = toArray(UNBANNED_SSS_ABILITIES[TierName])
                for(const ab of arr){ ItemsArray.push({name: ab, sub: TierName}) }
			}
		}else{
			let arr = toArray(UNBANNED_SSS_ABILITIES[SelectedCategory.sub])
			for(const ab of arr){ ItemsArray.push({name: ab, sub: SelectedCategory.sub}) }
		}

		ItemsArray = ItemsArray.sort((a, b)=>{
			let aLocalize = $.Localize(`#DOTA_Tooltip_ability_${a.name}`)
			let bLocalize = $.Localize(`#DOTA_Tooltip_ability_${b.name}`)
			if(aLocalize > bLocalize){return 1}
			if(aLocalize < bLocalize){return -1}
			return 0
		})

		for (const Item of ItemsArray) {
			let p = GetOrCreateInfoItem(InfoContainerAbilitiesList, Item.name)

			p.AddClass("IsAbility")

            let CategoryItemAbilityImage = p.FindChildTraverse("CategoryItemAbilityImage")
            if(CategoryItemAbilityImage){
                CategoryItemAbilityImage.abilityname = Item.name
            }

            p.SetPanelEvent('onmouseover', function () {
                $.DispatchEvent("DOTAShowAbilityTooltip", p, Item.name);
            });

            p.SetPanelEvent('onmouseout', function () {
                $.DispatchEvent("DOTAHideAbilityTooltip", p);
            });

            p.SetPanelEvent("onactivate", function(){
                OnPlayerSelectedToBan(Item.name, "ABILITY")
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

// Цветная полоса слева у subcategory: цвет с учётом пользовательских настроек.
// null (master/sss off ИЛИ use_categories=0 ИЛИ "none") → прозрачная полоса.
// ВАЖНО: Panorama НЕ принимает пустую строку для backgroundColor (кидает
// "Failed to parse style value"), поэтому для отключения цвета — "transparent".
function ApplyCategoryStripeColor(panel, categoryName){
    if(!panel) return
    let stripes = panel.FindChildrenWithClassTraverse("CategoryLineColorStripe")
    let stripe = stripes && stripes[0]
    if(stripe && stripe.style){
        let col = (typeof GetCategoryStripeColor === "function") ? GetCategoryStripeColor(categoryName) : null
        stripe.style.backgroundColor = col || "transparent"
    }
}

// Перерисовка всех полос. Вызывается слушателем при смене настроек подсветки
// (settings.js HL_OnPickColor / HL_OnToggle). Идёт по уже отрендеренным
// subcategory-панелям с привязанным zxcCategoryName.
function RefreshCategoryStripes(){
    if(!InfoContainerAbilitiesCategoriesList) return
    for(let i = 0; i < InfoContainerAbilitiesCategoriesList.GetChildCount(); i++){
        let child = InfoContainerAbilitiesCategoriesList.GetChild(i)
        if(child && child.zxcCategoryName){
            ApplyCategoryStripeColor(child, child.zxcCategoryName)
        }
    }
}

// Подписка на real-time изменения подсветки из settings.js (через ability_colors.js).
(function(){
    let cfg = GameUI.CustomUIConfig()
    if(!cfg) return
    if(!cfg.HighlightChangeListeners) cfg.HighlightChangeListeners = []
    cfg.HighlightChangeListeners.push(RefreshCategoryStripes)
})()

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