--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var global = this;
(function (factory) {
    typeof define === 'function' && define.amd ? define(factory) :
    factory();
})((function () { 'use strict';

    var _a, _b, _c;
    {
      let pCustomUIRoot = (_b = (_a = $.GetContextPanel()) === null || _a === void 0 ? void 0 : _a.GetParent()) === null || _b === void 0 ? void 0 : _b.GetParent();
      let pCustomUIContainer = pCustomUIRoot.FindChildTraverse("CustomUIContainer");
      if (pCustomUIContainer) {
        pCustomUIContainer.style.marginLeft = '0px';
      }
      let pDOTAReturnToDashboardOverlay = (_c = pCustomUIRoot.FindChildrenWithClassTraverse('DOTAReturnToDashboardOverlay')) === null || _c === void 0 ? void 0 : _c[0];
      if (pDOTAReturnToDashboardOverlay) {
        pDOTAReturnToDashboardOverlay.style.opacity = '0';
      }
    }

}));