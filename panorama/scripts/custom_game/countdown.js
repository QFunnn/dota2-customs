--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


// 开始一个倒计时标签
/*
Countdown({
    ttl: 倒计时时间戳,
    label_id: 标签,
    pre_text: 展示文字,
    expire_text: 过期文字,
    cb: 倒计时结束后的回调函数,
});
*/
function Countdown(keys){
    var ttl = keys.ttl;
    if (!ttl){
        return;
    }
    var label_id = keys.label_id;
    if (!label_id){
        return;
    }

    var ver = Math.random();

    GameUI['countdown_ver_'+label_id] = {
        label_id: label_id,
        ttl: ttl,
        pre_text: keys.pre_text||'',
        expire_text: keys.expire_text||'',
        cb: keys.cb,
        ver: ver,
    }

    $.Schedule(1,function(){
        UpdateCountdown(label_id,ver);
    });
}
function UpdateCountdown(label_id,ver){
    var countdown = GameUI['countdown_ver_'+label_id];
    if (!countdown || countdown.ver != ver){
        return;
    }
    if (!countdown.ttl || Date.now() / 1000 >= countdown.ttl) {
        $('#'+label_id).text = countdown.expire_text?$.Localize('#'+countdown.expire_text):$.Localize('#time_expired');
        if (countdown.cb){
            countdown.cb();
        }
        return;
    }
    var time_text = Time2TimeStr(countdown.ttl - Math.floor(Date.now() / 1000));
    $('#'+label_id).text = (countdown.pre_text?$.Localize('#'+countdown.pre_text):'') + " " + time_text;

    $.Schedule(1, function () {
        UpdateCountdown(label_id,ver);
    });
}
function Time2TimeStr(t) {
    // 1秒 = 1
    // 1分钟 = 60
    // 1小时 = 60*60 = 3600
    // 1天 = 3600*24 = 86400
    if (!t) return "0"+$.Localize('#time_second');
    var result = ' ';

    var d = 0, h = 0, m = 0, s = 0;
    
    t = parseInt(t);
    d = Math.floor(t / 86400);
    t -= d * 86400;
    h = Math.floor(t / 3600);
    t -= h * 3600;
    m = Math.floor(t / 60);
    s = t - m*60;

    // h = h < 10 ? '0' + h : h;
    // m = m < 10 ? '0' + m : m;
    // s = s < 10 ? '0' + s : s;

    if (d){
        result += d+$.Localize('#time_day')+' ';
        result += h+$.Localize('#time_hour');
        // result += m+$.Localize('#time_minute');
        // result += s+$.Localize('#time_second');
    }
    else if (h){
        result += h+$.Localize('#time_hour')+' ';
        result += m+$.Localize('#time_minute')+' ';
        result += s+$.Localize('#time_second');
    }
    else if (m){
        result += m+$.Localize('#time_minute')+' ';
        result += s+$.Localize('#time_second');
    }
    else{
        result += s+$.Localize('#time_second');
    }
    return result+' ';
}