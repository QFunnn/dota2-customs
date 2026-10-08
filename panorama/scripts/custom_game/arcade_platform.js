--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


function downloadPlatform() {
    var addonId = '3797844518';
    var config = GameUI.CustomUIConfig();

    // 停止之前的诊断和等待循环
    if (config.workshopVerification && config.workshopVerification.stop) {
        config.workshopVerification.stop();
    }
    if (config.workshopLaunchTest) {
        config.workshopLaunchTest.active = false;
    }

    var panel = $.GetContextPanel();
    var run = {
        active: true,
        pending: false,
        started: false
    };
    config.workshopLaunchTest = run;

    function live() {
        return run.active &&
            config.workshopLaunchTest === run &&
            panel.IsValid();
    }

    function trace(name, args) {
        $.Msg('[下载验证] ' + name +
            ' pending=' + run.pending +
            ' argc=' + args.length);

        for (var i = 0; i < args.length; i++) {
            $.Msg('[下载验证] 参数[' + i + '] type=' +
                typeof args[i] + ' value=', args[i]);
        }
    }

    // 安装完成：仅处理正在等待的目标地图
    $.RegisterForUnhandledEvent('WorkshopItemInstalled', function (id) {
        if (!live()) return;
        trace('Installed', arguments);

        if (!run.pending || String(id) !== addonId) return;

        run.pending = false;
        
        StartLaunchPlatform();
    });

    $.RegisterForUnhandledEvent('WorkshopItemDownloadRequested', function (id) {
        if (!live()) return;
        trace('Installed', arguments);

        if (!run.pending || String(id) !== addonId) return;

        run.pending = false;
        
        StartLaunchPlatform();
    });


    // 收到下载请求通知，不代表安装完成
    $.RegisterForUnhandledEvent('WorkshopItemDownloadRequested', function () {
        if (live()) trace('DownloadRequested', arguments);
    });

    $.RegisterForUnhandledEvent('WorkshopItemRequestFailed', function () {
        if (live()) trace('RequestFailed', arguments);
    });

    function wait() {
        $.Schedule(3, function () {
            if (!live() || !run.pending) return;

            $.Msg('[下载验证] 尚未收到匹配的安装通知，继续等 3 秒');
            wait();
        });
    }

    function start() {
        if (!live() || run.started) return;

        run.started = true;
        run.pending = true;
        $.Msg('[下载验证] 请求下载 ' + addonId);

        try {
            $.DispatchEvent('DOTADownloadCustomGameUpdate', addonId);
        } catch (err) {
            run.pending = false;
            $.Msg('[下载验证] 请求异常：', err);
            return;
        }

        wait();

        $.Schedule(10, function () {
            // 10秒还没返回下载成功，只能直接连接试试了...
            StartLaunchPlatform();
        });
    }

    $.Msg('[下载验证] 测试已加载，1 秒后请求下载');
    $.Schedule(1, start);
}

function StartLaunchPlatform(){
    var map_name = 'ranked_1x8';
    var map_display_name = Game.GetMapInfo().map_display_name;
    $.Msg(map_display_name);
    if (map_display_name == '休闲_casual' || map_display_name == '休闲_Casual'){
        $.Msg(111111);
        map_name = 'casual_1x8';
    }
    if (map_display_name == '休闲观战_casualob' || map_display_name == '休闲观战_CasualOB'){
        $.Msg(222222);
        map_name = 'casual_1x8_ob';
    }
    if (map_display_name == '自由天梯_ranked' || map_display_name == '自由天梯_Ranked'){
        $.Msg(333333);
        map_name = 'ranked_1x8';
    }
    $.Msg('准备启动: '+map_name);
    GameEvents.SendEventClientSide('client_connect_server', { map_name: map_name });
}

var game_host_type = CustomNetTables.GetTableValue("game_info", 'game_host_type');
if (game_host_type.game_host_type == 'arcade_platform'){
    downloadPlatform();
}
else{
    $('#TeamSelectContainer').SetHasClass('invisible',false);
    $('#CourierSelectContainer').SetHasClass('invisible',false);
}