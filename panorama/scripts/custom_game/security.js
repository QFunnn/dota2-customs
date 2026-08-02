--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]



function FindHudRoot(){  
    var hudRoot;
    for(panel=$.GetContextPanel();panel!=null;panel=panel.GetParent()){
        hudRoot = panel;
    }
    return hudRoot;
}

function IsSecurityKeyValid(securityKey)
{
   var hudRoot = FindHudRoot();
      
   if (hudRoot==undefined || hudRoot.SECURITY_KEY==undefined){
      return true
   }

   if (hudRoot.SECURITY_KEY==securityKey) {
      return true
   } else {
      return false
   }
}


(function(){


})();