--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const Buttons = $("#_Buttons")
const Categories = $("#_Container")

let CurrentOpenedPage = undefined

function OpenPage(page, group){
    if(CurrentOpenedPage == page){return}
    CurrentOpenedPage = page

    if(group == undefined){
        group = ""
    }

    $.Msg(page, " | ", group)

    for (let i = 0; i < Buttons.GetChildCount(); i++) {
        let Child = Buttons.GetChild(i)
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

    for (let i = 0; i < Categories.GetChildCount(); i++) {
        let Child = Categories.GetChild(i)
        if(Child){
            Child.SetHasClass("Selected", Child.id == page)
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
}

OnStart()