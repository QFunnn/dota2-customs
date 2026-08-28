--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


var main = $("#MailPanel")
var LeftSide = $("#LeftSide")
var RightSide = $("#RightSide")
var first = true

const DotaHUD = GameUI.CustomUIConfig().DotaHUD;

DotaHUD.windowControllers["mail"] = {
    is_open: false,
    open: function(){
        main.ToggleClass("hidden")
		LeftSide.RemoveAndDeleteChildren();
		RightSide.RemoveAndDeleteChildren();
		GameEvents.SendCustomGameEventToServer("get_mails", {})	
    },
    close: function(){ 
        main.ToggleClass("hidden")
    }
}
DotaHUD.ListenToMouseEvent(
    DotaHUD.GetCloseWindowOnOutsideClick(main, "mail")
);

function openButton()
{
	DotaHUD.WindowOpen("mail");
}

function closeButton()
{
	DotaHUD.WindowClose("mail");
}

function mail_init(t) {
    LeftSide.RemoveAndDeleteChildren();
    var hasUnread = false; 

    for (var key in t) {
        var mail = t[key];
        var Mail_Panel = $.CreatePanel("Panel", LeftSide, "Mail_" + key);
        Mail_Panel.BLoadLayoutSnippet("mail_button");

        Mail_Panel.FindChildTraverse('Mail_Label').text = $.Localize(mail.additional_text || "");
        Mail_Panel.FindChildTraverse('mailfrom').text = mail.from_user || "Unknown";
        Mail_Panel.FindChildTraverse('maildate').text = date_conv(mail.mail_data);

        if (mail.read_status == 0) {
            hasUnread = true;
            DotaHUD.ChangeIconTopButton("mail", "file://{images}/mail/mail2.png");
            Mail_Panel.AddClass("read_status");
        } else {
            Mail_Panel.RemoveClass("read_status");
        }

        (function(currentMail, currentPanel) {
            currentPanel.SetPanelEvent("onmouseactivate", function () {
                opn_mail(currentMail, currentPanel);
            });
        })(mail, Mail_Panel);
    }

    if (!hasUnread) {
        DotaHUD.ChangeIconTopButton("mail", "file://{images}/mail/mail.png");
    }
}

function opn_mail(mail, pan){
	RightSide.RemoveAndDeleteChildren();
	if (mail.read_status == 0){
		pan.RemoveClass("read_status")
		mail.read_status = 1
		GameEvents.SendCustomGameEventToServer("send_mail_read", {id : mail.id})	
	}
	var Mail_Desc = $.CreatePanel("Panel", RightSide, "Mail_Desc");
	Mail_Desc.BLoadLayoutSnippet("mail_desc");
	Mail_Desc.FindChildTraverse('MailTitle').text = $.Localize(mail.mail_title);
	Mail_Desc.FindChildTraverse('MailText').text = $.Localize(mail.mail_text);
	
	if (Object.keys(mail.additional_dict).length > 0) {
		for (var key in mail.additional_dict) {
			var name = mail.additional_dict[key]
			if (mail.get_item_status == 1){
				RightSide.FindChildTraverse('RightSideButton').visible = false
			}else{
				RightSide.FindChildTraverse('RightSideButton').visible = true
				RightSide.FindChildTraverse('RightSideButton').SetPanelEvent("onmouseactivate", function () {
					RightSide.FindChildTraverse('RightSideButton').visible = false
					GameEvents.SendCustomGameEventToServer("send_mail_reward", {id : mail.id})
					Game.EmitSound("ui.treasure_01")
				})
			}

			if (typeof name === 'object') {
				const item_panel = $.CreatePanel("Panel", RightSide.FindChildTraverse('RightSideItems'), "other");
				item_panel.AddClass("dota_item")
				item_panel.style.backgroundSize = "100%"
				item_panel.style.backgroundImage = "url('file://{resources}/images/sets/" + name.set_type + "/" + name.item_type +".png')";
				item_panel.SetPanelEvent("onmouseover", onAbilityMouseOver.bind(this, item_panel, name));
				item_panel.SetPanelEvent("onmouseout", onAbilityMouseOut.bind(this, item_panel));
			} else if (typeof name === 'string'){
				if (name.includes('item_')){
					const item = $.CreatePanel("DOTAItemImage", RightSide.FindChildTraverse('RightSideItems'), 'item');
					item.AddClass("dota_item")
					item.itemname = name
				}else{
					const other = $.CreatePanel("Image", RightSide.FindChildTraverse('RightSideItems'), "other");
					if(name.includes("highfive")){
						other.AddClass("dota_item")
						other.SetImage('file://{resources}/images/highfive/' + name + '.png');
					}
					if(name.includes("spray")){
						other.AddClass("dota_item")
						other.SetImage('file://{resources}/images/spray/' + name + '.png');
					}
					if(name.includes("effect")){
						other.AddClass("dota_item")
						other.SetImage('file://{resources}/images/effect/' + name + '.png');
					}
				}
			}
		}
	}else{
		RightSide.FindChildTraverse('RightSideButton').visible = false
	}
}


function showTooltip(panel, data) {
    if (data) {
        let params = `&item_data=` + JSON.stringify(data); + 
        $.DispatchEvent("UIShowCustomLayoutParametersTooltip", panel, "SetCreepTooltip", "file://{resources}/layout/custom_game/custom_tooltip/custom_tooltip.xml", params);
    }
}

function onAbilityMouseOver(panel, data) {
    showTooltip(panel, data);
}

function onAbilityMouseOut(panel) {
	$.DispatchEvent("UIHideCustomLayoutTooltip", panel, "SetCreepTooltip");
}


function date_conv(dateString) {
    let date = new Date(dateString);
    let year = date.getFullYear();
    let month = String(date.getMonth() + 1).padStart(2, '0');
    let day = String(date.getDate()).padStart(2, '0');
    let hours = String(date.getHours()).padStart(2, '0');
    let minutes = String(date.getMinutes()).padStart(2, '0');
    let formattedDate = `${year}-${month}-${day} ${hours}:${minutes}`;
    return formattedDate;
}


function TipsOver(message, pos)
{
	$.DispatchEvent( "DOTAShowTextTooltip", $("#"+pos), $.Localize('#'+message))
}

function TipsOut()
{
    $.DispatchEvent( "DOTAHideTitleTextTooltip")
    $.DispatchEvent( "DOTAHideTextTooltip")
}

(function(){
	main.ToggleClass("hidden")
	GameEvents.Subscribe( "mail_init", mail_init)
	GameUI.LoopTime.Schedule(0.0, ()=>{
		DotaHUD.CreateTopBarButton("file://{images}/mail/mail.png", "mail", openButton, "mail");
	});
})()
