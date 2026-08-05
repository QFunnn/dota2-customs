--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


const main = $("#DiscountPanel");
const buyControl = $("#BuyControl");
buyControl.visible = false;
main.visible = false;

let isOpened = false;

const DotaHUD = GameUI.CustomUIConfig().DotaHUD;
DotaHUD.windowControllers["discount"] = {
    is_open: false,
    open: function() {
        isOpened = !isOpened;
        main.visible = isOpened;
        if (isOpened) {
            showContent();
        } else {
            buyControl.visible = false;
        }
    },
    close: function() {
        buyControl.visible = false;
        isOpened = false;
        main.visible = isOpened;
    }
};

DotaHUD.ListenToMouseEvent(
    DotaHUD.GetCloseWindowOnOutsideClick(main, "discount")
);

function openButton() {
    DotaHUD.WindowOpen("discount");
}

function closeButton() {
    DotaHUD.WindowClose("discount");
}

function closebuy() {
    buyControl.visible = false;
}

function showContent() {
    ["#leftImage", "#middleImage", "#rightImage", "#boostImage"].forEach(CreateVeryRareItemEffect);
}

function CreateVeryRareItemEffect(targetId) {
    let panel = $.CreatePanel("DOTAParticleScenePanel", $(targetId), "", {
        particleName: "particles/ui/dota_hud_armory_selection_icon.vpcf",
        renderdeferred: "true",
        particleonly: "false",
        startActive: "true",
        cameraOrigin: "160 0 0",
        lookAt: "0 0 0",
        fov: "60"
    });
    panel.AddClass("very_rare_item_effect");
    panel.hittest = false;
    return panel;
}

const prices = {
    set_discount: 50,
    bless:        25,
    dust:         15,
    boost:        10,
    exp_150:      10,
    exp_300:      18,
    exp_500:      28,
};

const itemImages = {
    set_discount: "file://{images}/set_discount.png",
    bless:        "file://{images}/bless.png",
    dust:         "file://{images}/dust.png",
    boost:        "file://{images}/boost.png",
    exp_150:      "file://{images}/exp_150.png",
    exp_300:      "file://{images}/exp_300.png",
    exp_500:      "file://{images}/exp_500.png",
};

function buy(data) {
    const itemImage = $("#item_buy_image");
    itemImage.style.backgroundImage = `url('${itemImages[data] || "file://{images}/" + data + ".png"}')`;

    CreateVeryRareItemEffect("#item_buy_image");

    const price = prices[data] || 0;
    buyControl.visible = true;

    const buyLabel = buyControl.FindChildTraverse('buy_label');
    const buyButton = buyControl.FindChildTraverse('buy_button');

    buyLabel.text = price;
    buyButton.SetPanelEvent("onmouseactivate", () => acceptBuy(price, data));
}

function acceptBuy(price, data) {
    buyControl.visible = false;

    if (data.startsWith('exp_')) {
        const product = parseInt(data.split('_')[1]*4);
        $.Msg(product)
        GameEvents.SendCustomGameEventToServer("buy_experience", { product });
    }else if (data == 'boost'){
        GameEvents.SendCustomGameEventToServer("buy_daily_boost", {});
    } else {
        GameEvents.SendCustomGameEventToServer("buy_discount_item", { price, data });
    }
}

function TipsOver(message, pos) {
    $.DispatchEvent("DOTAShowTextTooltip", $("#" + pos), $.Localize('#' + message));
}

function TipsOut() {
    $.DispatchEvent("DOTAHideTitleTextTooltip");
    $.DispatchEvent("DOTAHideTextTooltip");
}

GameUI.LoopTime.Schedule(0.0, () => {
    DotaHUD.CreateTopBarButton("file://{images}/discount.png", "discount", openButton, "open_discount");
});