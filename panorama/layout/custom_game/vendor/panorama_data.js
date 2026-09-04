--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


function isDataObject(value) {
    return value !== null && typeof value === 'object' && !Array.isArray(value);
}

function syncDataInPlace(currentValue, nextValue) {
    if (Array.isArray(currentValue) && Array.isArray(nextValue)) {
        for (let index = 0; index < nextValue.length; index++) {
            currentValue[index] = syncDataInPlace(currentValue[index], nextValue[index]);
        }
        currentValue.length = nextValue.length;
        return currentValue;
    }

    if (isDataObject(currentValue) && isDataObject(nextValue)) {
        Object.keys(currentValue).forEach(key => {
            if (!(key in nextValue)) delete currentValue[key];
        });
        Object.keys(nextValue).forEach(key => {
            currentValue[key] = syncDataInPlace(currentValue[key], nextValue[key]);
        });
        return currentValue;
    }

    return nextValue;
}

const customUIConfig = GameUI.CustomUIConfig();
if (customUIConfig.__AK_PANORAMA_DATA__ == null) customUIConfig.__AK_PANORAMA_DATA__ = {};
const panoramaData = customUIConfig.__AK_PANORAMA_DATA__;

function refreshAllItems() {
    const nextItems = {
        ...(panoramaData['@/json/ak_items.json'] ?? {}),
        ...(panoramaData['@/json/ak_items_potion.json'] ?? {}),
        ...(panoramaData['@/json/ak_items_stone.json'] ?? {}),
    };
    panoramaData['@/utils/ak_items_all'] = syncDataInPlace(panoramaData['@/utils/ak_items_all'], nextItems);
}

// 每张表由独立脚本调用发布函数，热更新时只刷新发生变化的数据表。
customUIConfig.__AK_PANORAMA_PUBLISH_DATA__ = (moduleKey, nextData) => {
    panoramaData[moduleKey] = syncDataInPlace(panoramaData[moduleKey], nextData);
    if (
        moduleKey === '@/json/ak_items.json' ||
        moduleKey === '@/json/ak_items_potion.json' ||
        moduleKey === '@/json/ak_items_stone.json'
    ) {
        refreshAllItems();
    }
};

refreshAllItems();