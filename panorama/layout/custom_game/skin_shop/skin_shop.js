--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


const SSPanel = $("#SSPanel")
const SSGrid  = $("#SSGrid")
const SSModal = SSPanel ? SSPanel.FindChildTraverse("SkinShopModal") : null

if (SSPanel) SSPanel.visible = false
if (SSModal) SSModal.visible = false

const SKINS_PER_ROW = 5

const AKATSUKI_SKINS = [
    { id: "pain",    name: "Pain",          ability: "pain_six_paths_authority",    attack: "melee",    price: 50 },
    { id: "itachi",  name: "Itachi Uchiha", ability: "itachi_crow_guard",           attack: "melee",    price: 50 },
    { id: "kisame",  name: "Kisame",        ability: "kisame_samehada_hunger",      attack: "melee",    price: 50 },
    { id: "hidan",   name: "Hidan",         ability: "hidan_ritual_of_blood",       attack: "melee",    price: 50 },
    { id: "tobi",    name: "Tobi",          ability: "tobi_phantom_strike",         attack: "melee",    price: 50 },
    { id: "zetsu",   name: "Zetsu",         ability: "zetsu_root_assimilation",     attack: "ranged",   price: 50 },
    { id: "konan",   name: "Konan",         ability: "konan_paper_dance",           attack: "ranged",   price: 50 },
    { id: "deidara", name: "Deidara",       ability: "deidara_unstable_art",        attack: "ranged",   price: 50 },
    { id: "kakuzu",  name: "Kakuzu",        ability: "kakuzu_earth_grudge_fear",    attack: "ranged",   price: 50 },
    { id: "sasori",  name: "Sasori",        ability: "sasori_red_secret_technique", attack: "ranged",   price: 50 },
]

var skinStates = {}
for (var i = 0; i < AKATSUKI_SKINS.length; i++) {
    skinStates[AKATSUKI_SKINS[i].id] = { owned: false, equipped: false, expires: 0 }
}

var currentBuySkin = null

const DotaHUD = GameUI.CustomUIConfig().DotaHUD
DotaHUD.windowControllers["skin_shop"] = {
    is_open: false,
    open: function() {
        SSPanel.visible = true
        SSPanel.AddClass('open_panel')
        GameEvents.SendCustomGameEventToServer("skin_get_state", {})
    },
    close: function() {
        SSPanel.RemoveClass('open_panel')
        closeBuyModal()
        $.Schedule(0.25, function() {
            SSPanel.visible = false
        })
    }
}

DotaHUD.ListenToMouseEvent(
    DotaHUD.GetCloseWindowOnOutsideClick(SSPanel, "skin_shop")
)

function toggleSkinShop() {
    if (DotaHUD.IsWindowOpen("skin_shop")) {
        DotaHUD.WindowClose("skin_shop")
    } else {
        DotaHUD.WindowOpen("skin_shop")
    }
}

function closeSkinShop() {
    DotaHUD.WindowClose("skin_shop")
}

// ========================
// МОДАЛЬНОЕ ОКНО
// ========================
function openBuyModal(skin) {
    $.Msg("[SkinShop] SSModal=" + SSModal + " SSPanel=" + SSPanel)
    if (!SSModal) return
    currentBuySkin = skin
    SSModal.FindChildTraverse("SkinShopModalName").text  = skin.name
    SSModal.FindChildTraverse("SkinShopModalPrice").text = skin.price + " " + $.Localize("#crystals")
    SSModal.visible = true
}

function confirmBuy() {
    if (!currentBuySkin) return
    GameEvents.SendCustomGameEventToServer("skin_buy", { skin_id: currentBuySkin.id })
    closeBuyModal()
}

function cancelBuy() {
    closeBuyModal()
}

function closeBuyModal() {
    if (SSModal) SSModal.visible = false
    currentBuySkin = null
}

// ========================
// ТАЙМЕР
// ========================
function formatExpiry(seconds) {
    if (seconds <= 0) return $.Localize("#skin_expired")
    var days  = Math.floor(seconds / 86400)
    var hours = Math.floor((seconds % 86400) / 3600)
    return $.Localize("#skin_expires") + " " + days + $.Localize("#days_short") + " " + hours + $.Localize("#hours_short")
}

// ========================
// ОБНОВЛЕНИЕ КАРТОЧКИ
// ========================
function updateCard(skinId) {
    var state = skinStates[skinId]
    var btn   = SSGrid.FindChildTraverse("SkinCardBtn_" + skinId)
    var timer = SSGrid.FindChildTraverse("SkinCardTimer_" + skinId)
    if (!btn) return
    var btnLabel = btn.GetChild(0)

    btn.RemoveClass("owned")
    btn.RemoveClass("equipped")

    if (!state.owned) {
        if (btnLabel) btnLabel.text = $.Localize("#skin_buy")
        if (timer) timer.visible = false
    } else if (state.equipped) {
        btn.AddClass("equipped")
        if (btnLabel) btnLabel.text = $.Localize("#skin_remove")
        if (timer) {
            timer.visible = true
            timer.text = formatExpiry(state.expires)
        }
    } else {
        btn.AddClass("owned")
        if (btnLabel) btnLabel.text = $.Localize("#skin_equip")
        if (timer) {
            timer.visible = true
            timer.text = formatExpiry(state.expires)
        }
    }
}

// ========================
// ПОСТРОЕНИЕ ГРИДА
// ========================
function buildGrid() {
    SSGrid.RemoveAndDeleteChildren()

    var row = null

    for (var i = 0; i < AKATSUKI_SKINS.length; i++) {
        var skin = AKATSUKI_SKINS[i]

        if (i % SKINS_PER_ROW === 0) {
            row = $.CreatePanel("Panel", SSGrid, "")
            row.AddClass("SSSkinRow")
        }

        var card = $.CreatePanel("Panel", row, "SkinCard_" + skin.id)
        card.AddClass("SkinCard")

        // --- Портрет ---
        var portrait = $.CreatePanel("Panel", card, "")
        portrait.AddClass("SkinCardPortrait")

        var img = $.CreatePanel("Image", portrait, "")
        img.AddClass("SkinCardImg")
        img.SetImage("file://{resources}/images/akatsuki/" + skin.id + ".png")

        var iconsBar = $.CreatePanel("Panel", portrait, "")
        iconsBar.AddClass("SkinCardIconsBar")

        var attackIcon = $.CreatePanel("Image", iconsBar, "")
        attackIcon.AddClass("SkinCardAttackIcon")
        attackIcon.SetImage(
            skin.attack === "melee"
                ? "file://{resources}/images/melee.png"
                : "file://{resources}/images/ranged.png"
        )
        ;(function(icon, attack) {
            icon.SetPanelEvent("onmouseover", function() {
                $.DispatchEvent("UIShowTextTooltip", icon,
                    attack === "melee"
                        ? $.Localize("#skin_attack_tooltip_melee")
                        : $.Localize("#skin_attack_tooltip_ranged")
                )
            })
            icon.SetPanelEvent("onmouseout", function() {
                $.DispatchEvent("UIHideTextTooltip")
            })
        })(attackIcon, skin.attack)

        var spacer = $.CreatePanel("Panel", iconsBar, "")
        spacer.AddClass("SkinCardIconSpacer")

        if (skin.ability !== "") {
            var abilityIcon = $.CreatePanel("DOTAAbilityImage", iconsBar, "")
            abilityIcon.AddClass("SkinCardAbilityIcon")
            abilityIcon.abilityname = skin.ability
            ;(function(s, p) {
                p.SetPanelEvent("onmouseover", function() {
                    $.DispatchEvent("DOTAShowAbilityTooltip", p, s.ability)
                })
                p.SetPanelEvent("onmouseout", function() {
                    $.DispatchEvent("DOTAHideAbilityTooltip")
                })
            })(skin, abilityIcon)
        }

        // --- Нижняя часть ---
        var bottom = $.CreatePanel("Panel", card, "")
        bottom.AddClass("SkinCardBottom")

        var nameLabel = $.CreatePanel("Label", bottom, "")
        nameLabel.AddClass("SkinCardName")
        nameLabel.text = skin.name

        var timer = $.CreatePanel("Label", bottom, "SkinCardTimer_" + skin.id)
        timer.AddClass("SkinCardTimer")
        timer.visible = false

        var btn = $.CreatePanel("Panel", bottom, "SkinCardBtn_" + skin.id)
        btn.AddClass("SkinCardBtn")

        var btnLabel = $.CreatePanel("Label", btn, "")
        btnLabel.AddClass("SkinCardBtnLabel")
        btnLabel.text = $.Localize("#skin_buy")

        ;(function(s) {
            var b = SSGrid.FindChildTraverse("SkinCardBtn_" + s.id)
            if (!b) return
            b.SetPanelEvent("onmouseactivate", function() {
                var state = skinStates[s.id]
                if (!state.owned) {
                    openBuyModal(s)
                } else if (state.equipped) {
                    GameEvents.SendCustomGameEventToServer("skin_unequip", { skin_id: s.id })
                } else {
                    GameEvents.SendCustomGameEventToServer("skin_equip", { skin_id: s.id })
                }
            })
        })(skin)
    }
}

// ========================
// СЕРВЕРНЫЕ СОБЫТИЯ
// ========================
GameEvents.Subscribe("skin_state_update", function(data) {
    var id = data.skin_id
    if (!skinStates[id]) return
    skinStates[id].owned   = data.owned   == 1
    skinStates[id].expires = data.expires || 0
    var nowEquipped = data.equipped == 1
    if (nowEquipped) {
        for (var i = 0; i < AKATSUKI_SKINS.length; i++) {
            var other = AKATSUKI_SKINS[i]
            if (other.id !== id && skinStates[other.id].equipped) {
                skinStates[other.id].equipped = false
                updateCard(other.id)
            }
        }
    }
    skinStates[id].equipped = nowEquipped
    updateCard(id)
})

buildGrid()

GameUI.LoopTime.Schedule(0.0, function() {
    DotaHUD.CreateTopBarButton(
        "s2r://panorama/images/generic_treasure_icon_psd.vtex",
        "skin_shop_title",
        toggleSkinShop,
        "skin_shop"
    )
})