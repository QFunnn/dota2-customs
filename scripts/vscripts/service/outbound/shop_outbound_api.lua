--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


ShopOutboundApi = ShopOutboundApi or {}

---@param url string
---@param uid string
---@param itemId string
---@param callback function|nil
local function SendPlayerShopItemRequest(url, uid, itemId, callback)
    OutboundRequestSender:SendJson("POST", url, {
        uid = uid,
        itemId = itemId
    }, callback)
end

---@param callback function|nil
function ShopOutboundApi:GetPurchasableItems(callback)
    OutboundRequestSender:SendJson("POST", "/shop/get-purchasable-items", {}, callback)
end

---@param uid string
---@param itemId string
---@param callback function|nil
function ShopOutboundApi:BuyItem(uid, itemId, callback)
    SendPlayerShopItemRequest("/shop/buy-item", uid, itemId, callback)
end

---@param uid string
---@param itemId string
---@param callback function|nil
function ShopOutboundApi:EquipItem(uid, itemId, callback)
    SendPlayerShopItemRequest("/shop/equip-item", uid, itemId, callback)
end

---@param uid string
---@param itemId string
---@param callback function|nil
function ShopOutboundApi:UnequipItem(uid, itemId, callback)
    SendPlayerShopItemRequest("/shop/unequip-item", uid, itemId, callback)
end

---@param uid string
---@param code string
---@param callback fun(response: CScriptHTTPResponse)
function ShopOutboundApi:ActivatePromo(uid, code, callback)
    local url = string.format("/promo/%s/activate", uid)
    OutboundRequestSender:SendJson("POST", url, {promo = code}, callback)
end