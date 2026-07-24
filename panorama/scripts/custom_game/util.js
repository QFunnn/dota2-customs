--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



// 需要由服务端校验“事件发送者 == 本地英雄所有者”的局内事件。
// 与 common.js 保持同一白名单；两个脚本同时加载时只安装一次。
if (!GameEvents.__localHeroVerificationInstalled) {
    var originalSendCustomGameEventToServer = GameEvents.SendCustomGameEventToServer;
    var localHeroVerifiedEvents = {
        AbilitySelected: true,
        AcceptTeammateSwap: true,
        ActiveChatWheel: true,
        ActiveTaunt: true,
        ChangeEquip: true,
        ConfirmActor: true,
        ConfirmBet: true,
        CustomPauseGame: true,
        DeclineTeammateSwap: true,
        DemoEvent: true,
        EquipTempItem: true,
        HeroIconClicked: true,
        HideNeutralItemSelect: true,
        NeutralItemSelected: true,
        PlayerReady: true,
        ProposeTeammateSwap: true,
        RelearnBookAbilitySelected: true,
        ReorderComplete: true,
        SpellBookAbilitySelected: true,
        SwapAbility: true,
        SwitchWearable: true,
        Taunt: true,
        ToggleAutoCreep: true,
        ToggleAutoDuel: true,
        alt_ping_ability: true,
        bet_on_team_allias: true,
        can_choose_ability: true,
        set_mute_player: true,
    };

    GameEvents.SendCustomGameEventToServer = function (eventName, eventData) {
        var securedEventData = eventData;
        if (localHeroVerifiedEvents[eventName]) {
            securedEventData = Object.assign({}, eventData || {});
            var localPlayerID = Players.GetLocalPlayer();
            securedEventData.hero_entindex = Players.GetPlayerHeroEntityIndex(localPlayerID);
        }
        originalSendCustomGameEventToServer.call(GameEvents, eventName, securedEventData);
    };
    GameEvents.__localHeroVerificationInstalled = true;
}

const dotaHud = (() => {
    let panel = $.GetContextPanel();
    while (panel) {
        if (panel.id === "DotaHud") return panel;
        panel = panel.GetParent();
    }
})();


function GetLength2D(p1,p2){
    return Math.sqrt(Math.pow((p1[0]-p2[0]),2)+Math.pow((p1[1]-p2[1]),2));
}

function FindDotaHudElement(id){
    var hudRoot;
    for(panel=$.GetContextPanel();panel!=null;panel=panel.GetParent()){
        hudRoot = panel;
    }
    var comp = hudRoot.FindChildTraverse(id);
    return comp;
}



function FindDotaHudElementByClass(className){
    var hudRoot;
    for(panel=$.GetContextPanel();panel!=null;panel=panel.GetParent()){
        hudRoot = panel;
    }
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



function ConvertToSteamid64(steamid32)  //32位转64位
{
    var steamid64 = '765' + (parseInt(steamid32) + 61197960265728).toString();
    return steamid64;
}

function ConvertToSteamId32(steamid64) {   //64位转32位
    return steamid64.substr(3) - 61197960265728;
}

function FormatSeconds(value) {
    var theTime = parseInt(value);// 秒
    var theTime1 = 0;// 分
    var theTime2 = 0;// 小时
    if(theTime > 60) {
        theTime1 = parseInt(theTime/60);
        theTime = parseInt(theTime%60);
            if(theTime1 > 60) {
            theTime2 = parseInt(theTime1/60);
            theTime1 = parseInt(theTime1%60);
            }
    }
        var result = ""+parseInt(theTime)+"\"";
        if(theTime1 > 0) {
           result = ""+parseInt(theTime1)+"\'"+result;
        }
        if(theTime2 > 0) {
          result = ""+parseInt(theTime2)+":"+result;
        }
    return result;
}

function DrawRandomFromArray (arr,num){

    var result = [];

    for (var i = 0; i < num; i++) {
        var ran = Math.floor(Math.random() * arr.length);
        result.push(arr.splice(ran, 1)[0]);
    }

    return result;

};

var ShowAbilityTooltip = ( function( ability )
{ 
    return function()
    {
        $.DispatchEvent( "DOTAShowAbilityTooltip", ability, ability.abilityname );
    }
});

var HideAbilityTooltip = ( function( ability )
{
    return function()
    {
        $.DispatchEvent( "DOTAHideAbilityTooltip", ability );
    }
});


var ShowItemTooltip = ( function( item )
{
    return function()

    {
        $.DispatchEvent( "DOTAShowAbilityTooltip", item, item.itemname );
    }
});

var HideItemTooltip = ( function( item )
{
    return function()
    {
        $.DispatchEvent( "DOTAHideAbilityTooltip", item );
    }
});




function TipsOver(message, pos){
    if ($("#"+pos)!=undefined)
    {
       $.DispatchEvent( "DOTAShowTextTooltip", $("#"+pos), $.Localize("#"+message));
    }
}

function TipsOut(){
    $.DispatchEvent( "DOTAHideTitleTextTooltip");
    $.DispatchEvent( "DOTAHideTextTooltip");
}

function SendHudError(keys) {
    GameEvents.SendEventClientSide("dota_hud_error_message", {
        splitscreenplayer: 0,
        reason: 80,
        message: "#"+keys.message,
    });
}

function AbilityInDeleteCoolDown(keys) {
    GameEvents.SendEventClientSide("dota_hud_error_message", {
        splitscreenplayer: 0,
        reason: 80,
        message:  $.Localize("#DOTA_Tooltip_ability_" + keys.ability_name) + $.Localize("#InDeleteCoolDown"),
    });
}

function GetEarlyLeaver(playerId) {

  var early_leaver = CustomNetTables.GetTableValue("rank_data", "early_leaver");
  if (early_leaver &&  early_leaver[playerId])
  {
    return $.Localize("#early_leaver");
  }
  else
  {
     return "";
  }

}



//获取玩家全部饰品
function GetPlayerEconInfoData(steam_id) {

    var playerData = [];
    var bucketData = CustomNetTables.GetTableValue("econ_data", "econ_total_bucket_"+steam_id) 
    if (bucketData && bucketData.total_bucket)
    {
       var bucket_number = parseInt(bucketData.total_bucket)
       for (var i = 1; i <= bucket_number; i++) {
          var econ_info = CustomNetTables.GetTableValue("econ_data", "econ_info_"+steam_id+"_"+i)
          for (var index in econ_info){
               playerData.push(econ_info[index])
          }
       }
    }
    return playerData;
}

//带回传的请求，每次调用id都增加1
function CreateEventRequestCreator(eventName) {
    var idCounter = 0;
    return function(data, callback) {
        var id = ++idCounter;
        data.id = id;
        GameEvents.SendCustomGameEventToServer(eventName, data);
        var listener = GameEvents.Subscribe(eventName, function(data) {
            if (data.id !== id) return;
            GameEvents.Unsubscribe(listener);
            callback(data)
        });
        return listener;
    }
}

//判断技能 是否为动作栏的有效技能
function IsValidAbility(abilityIndex) {

    var result = false;
    var abilityName = Abilities.GetAbilityName(abilityIndex);
    //有效技能
    if (abilityName!=null && abilityName != "" && abilityName.substring(0, 14) != "special_bonus_" && abilityName!= "generic_hidden" && abilityName.substring(0, 6) != "empty_" )
    {
        //不是隐藏技能 不是配赠技能
        if (!Abilities.IsHidden(abilityIndex)  && CustomNetTables.GetTableValue("subsidiary_list", abilityName)==undefined)
        {
           result = true; 
        }
    }

    return result;
}



//7.32后 每局比赛后命令不清空，必须重启游戏客户端才可以清空
//如果重复注入相同CommandName 则触发BUG使得键位不生效
//解决：CommandName加上时间戳区分
//addoninfo.txt 里面的 Default_Keys 方法废弃
function CreateKeyCommand(key,pressCallback,releaseCallback)
{
    const command = `On${key}${Date.now()}`;
    Game.CreateCustomKeyBind(key, `+${command}`);
    Game.AddCommand(
        `+${command}`,
        () => {
           if (pressCallback)
           {
              pressCallback(); 
           }
        },
        ``,
        1 << 32
    );
    Game.AddCommand(
        `-${command}`,
        () => {
           if (releaseCallback)
           {
              releaseCallback(); 
           }
        },
        ``,
        1 << 32
    );
}


(function () {
    GameEvents.Subscribe("SendHudError", SendHudError);
    GameEvents.Subscribe("AbilityInDeleteCoolDown", AbilityInDeleteCoolDown);
})();