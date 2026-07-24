--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const Buttons = $("#_ButtonsScrollable")
const ButtonsFixed = $("#_ButtonsFixed")
const Categories = $("#_Container")
const BigWiki = $("#BigWiki")

let CurrentOpenedPage = undefined

function OpenPage(page, group){
    if(CurrentOpenedPage == page){return}
    CurrentOpenedPage = page

    if(group == undefined){
        group = ""
    }

    // Обновляем состояние кнопок в обоих контейнерах
    function UpdateButtons(container) {
        for (let i = 0; i < container.GetChildCount(); i++) {
            let Child = container.GetChild(i)
            if(Child){
                Child.SetHasClass("Selected", Child.id == `${page}_Button` || Child.id == `${group}_Group` || Child.id == `${group}_Button`)

                if(Child.BHasClass("_Group")){
                    for (let j = 0; j < Child.GetChildCount(); j++) {
                        let GroupChild = Child.GetChild(j)
                        if(GroupChild){
                            GroupChild.SetHasClass("Selected", GroupChild.id == `${page}_Button`)
                        }
                    }
                }
            }
        }
    }

    UpdateButtons(Buttons)
    UpdateButtons(ButtonsFixed)

    // Показываем нужную категорию
    // Если есть группа, показываем основную категорию группы, иначе показываем саму страницу
    let displayCategory = group != "" ? group : page
    
    for (let i = 0; i < Categories.GetChildCount(); i++) {
        let Child = Categories.GetChild(i)
        if(Child){
            Child.SetHasClass("Selected", Child.id == displayCategory)
        }
    }
    
    // Если это подкатегория, показываем её как отдельную страницу
    if(group != ""){
        // Показываем подкатегорию как отдельную категорию
        let subcategory = $("#" + page)
        if(subcategory){
            // Скрываем основную категорию группы
            for (let i = 0; i < Categories.GetChildCount(); i++) {
                let Child = Categories.GetChild(i)
                if(Child){
                    Child.SetHasClass("Selected", Child.id == page) // Показываем подкатегорию
                }
            }
        }
    }
}

function OnStart(){
    for (let i = 0; i < Buttons.GetChildCount(); i++) {
        let MainButton = Buttons.GetChild(i)
        if(MainButton){
            if(MainButton.BHasClass("_Button")){
                let page = MainButton.id.replace("_Button", "")
                let GroupPanel = Buttons.FindChildTraverse(`${page}_Group`)
                let bIsGroup = GroupPanel != undefined
                MainButton.SetPanelEvent("onactivate", function(){
                    if(bIsGroup){
                        let FChild = GroupPanel.GetChild(0)
                        if(FChild){
                            let fpage = FChild.id.replace("_Button", "")
                            OpenPage(fpage, page)
                        }
                    }else{
                        OpenPage(page)
                    }
                })
            }else if(MainButton.BHasClass("_Group")){
                let group = MainButton.id.replace("_Group", "")
                for (let j = 0; j < MainButton.GetChildCount(); j++) {
                    let ChildButton = MainButton.GetChild(j)
                    if(ChildButton){
                        let page = ChildButton.id.replace("_Button", "")
                        ChildButton.SetPanelEvent("onactivate", function(){
                            OpenPage(page, group)
                        })
                    }
                }
            }
        }
    }

    // Обрабатываем кнопки в ButtonsFixed
    for (let i = 0; i < ButtonsFixed.GetChildCount(); i++) {
        let MainButton = ButtonsFixed.GetChild(i)
        if(MainButton && MainButton.BHasClass("_Button")){
            let page = MainButton.id.replace("_Button", "")
            MainButton.SetPanelEvent("onactivate", function(){
                OpenPage(page)
            })
        }
    }
}


OnStart()

function ToggleWiki(bIsButton){
    if(bIsButton){
        // Закрываем меню если оно открыто
        if(GameUI.CustomUIConfig().CloseMenu){
            GameUI.CustomUIConfig().CloseMenu()
        }
        
        BigWiki.ToggleClass("Show")
    }else{
        BigWiki.RemoveClass("Show")
    }
}

// Функция для принудительного закрытия Wiki
function CloseWiki(){
    if(BigWiki.BHasClass("Show")){
        BigWiki.RemoveClass("Show")
    }
}

GameUI.CustomUIConfig().ToggleWiki = ToggleWiki
GameUI.CustomUIConfig().CloseWiki = CloseWiki