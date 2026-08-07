--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict';
function JumpT11Url() {
  $.DispatchEvent('DOTAShowCustomGamePage', 3591915450);
  $.DispatchEvent('DOTASubscribeToCustomGame', 3591915450);
}

(() => {
  var root = $.GetContextPanel();
  root.AddClass($.Language().toLowerCase());
  var pParent = root.GetParent();
  if (pParent?.IsValid()) {
    let pSideBar = pParent.FindChild("SidebarAndBattleCupLayoutContainer");
    if (pSideBar?.IsValid()) {
      pSideBar.hittest = false;
      let pChild = pSideBar.FindChild("LoadingScreenBattleCupWinnerContainer");
      if (pChild?.IsValid()) {
        pChild.hittest = false;
      }
    }
  }
  if (T11LinkageEnable) {
    root.BLoadLayoutSnippet('T11ContainerRoot');
  } else if (T12LinkageEnable) {
    root.BLoadLayoutSnippet('T12ContainerRoot');
  } else if (C1LinkageEnable) {
    root.AddClass('C1Linkage');
    root.BLoadLayoutSnippet('C1ContainerRoot');
  }
  if (loadingScreenSeason != undefined) {
    root.AddClass('Season' + loadingScreenSeason);
  }
})();