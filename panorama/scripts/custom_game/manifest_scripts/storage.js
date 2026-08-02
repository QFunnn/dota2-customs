--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


var CPanoramaScript_Storage = /** @class */ (function () {
    function CPanoramaScript_Storage() {
        this.storage = {};
    }
    CPanoramaScript_Storage.prototype.SaveData = function (key, data) {
        this.storage[key] = data;
    };
    CPanoramaScript_Storage.prototype.LoadData = function (key, defaultValue) {
        var _a;
        return (_a = this.storage[key]) !== null && _a !== void 0 ? _a : defaultValue;
    };
    return CPanoramaScript_Storage;
}());
var storage = CustomUIConfig.Storage;
if (storage !== undefined) {
    Object.setPrototypeOf(storage, CPanoramaScript_Storage.prototype);
}
else {
    CustomUIConfig.Storage = new CPanoramaScript_Storage();
}