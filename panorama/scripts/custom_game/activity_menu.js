--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('activity_menu', exports); const require = GameUI.__require;

const ACTIVITY_LOGIN_ID = 101;
const ACTIVITY_DICE_ID = 801;
const ACTIVITY_MENU_GRACE_SECONDS = 7 * 24 * 60 * 60;
function isLoginActivityCompleted(context) {
  const rewardCount = Object.keys(KeyValues.activity_login[ACTIVITY_LOGIN_ID] ?? {}).length;
  const loginActivity = context.loginActivities[ACTIVITY_LOGIN_ID];
  return rewardCount > 0 && loginActivity != undefined && loginActivity.step >= rewardCount;
}
function hasClaimableDiceTask(tasks) {
  return Object.values(tasks).some(task => {
    const taskConfig = KeyValues.task[task.task_id];
    if (!taskConfig || taskConfig.activity_id != ACTIVITY_DICE_ID) return false;
    if (taskConfig.type != 6 && taskConfig.type != 7) return false;
    const isClaimable = task.progress >= task.target && task.receive_progress != 1;
    return isClaimable;
  });
}
function isBeforeEndTime(now, endTime) {
  return endTime == 0 || now < endTime;
}
function isActivityInTimeRange(now, startTime, endTime) {
  return (startTime == 0 || startTime <= now) && (endTime == 0 || now <= endTime);
}
function getActiveStarseaActivityID(now) {
  const timestamp = Math.floor(now);
  const activities = Object.values(KeyValues.activity_data).filter(activity => activity.type == 2).sort((left, right) => left.activity_id - right.activity_id);
  let activeActivityID;
  for (const activity of activities) {
    const rewards = KeyValues.activity_starsea[activity.activity_id];
    if (rewards == undefined || Object.keys(rewards).length == 0) continue;
    if (!isActivityInTimeRange(timestamp, activity.start_time, activity.end_time)) continue;
    activeActivityID = activity.activity_id;
  }
  return activeActivityID;
}
function shouldShowPrimaryMenu(menu, config, context) {
  if (config.storeMenus.has(menu) && !context.openStore) {
    return false;
  }
  if (menu == "starsea") {
    return getActiveStarseaActivityID(context.now) != undefined;
  }
  if (menu == "seven_days") {
    return !isLoginActivityCompleted(context);
  }
  if (menu == "boardslot") {
    const endTime = KeyValues.activity_data[ACTIVITY_DICE_ID]?.end_time ?? 0;
    return endTime == 0 || context.now < endTime + ACTIVITY_MENU_GRACE_SECONDS;
  }
  return true;
}
function shouldShowSecondaryMenu(secondMenu, context) {
  const diceEndTime = KeyValues.activity_data[ACTIVITY_DICE_ID]?.end_time ?? 0;
  if (secondMenu == "dice_gift") {
    return isBeforeEndTime(context.now, diceEndTime);
  }
  if (secondMenu == "dice_game") {
    return isBeforeEndTime(context.now, diceEndTime) || hasClaimableDiceTask(context.tasks);
  }
  return true;
}
function buildActivityMenuList(config, context) {
  const result = {};
  for (const menu in config.menuList) {
    if (!shouldShowPrimaryMenu(menu, config, context)) continue;
    const templateSecondMenus = config.menuList[menu];
    const secondMenus = templateSecondMenus.filter(secondMenu => shouldShowSecondaryMenu(secondMenu, context));
    if (templateSecondMenus.length > 0 && secondMenus.length == 0) continue;
    result[menu] = secondMenus;
  }
  return result;
}
function isActivityMenuVisible(menuList, menu, secondMenu) {
  const secondMenus = menuList[menu];
  if (secondMenus == undefined) return false;
  if (secondMenu == undefined) return true;
  return secondMenus.includes(secondMenu);
}
function getVisibleActivityRedPoint(menuList, menu, secondMenu) {
  if (menu == undefined) {
    return Object.keys(menuList).some(visibleMenu => getVisibleActivityRedPoint(menuList, visibleMenu));
  }
  const secondMenus = menuList[menu];
  if (secondMenus == undefined) return false;
  if (secondMenu != undefined) {
    return isActivityMenuVisible(menuList, menu, secondMenu) && CustomUIConfig.GetRedPoint("activity", menu, secondMenu);
  }
  if (secondMenus.length == 0) {
    return CustomUIConfig.GetRedPoint("activity", menu);
  }
  return secondMenus.some(visibleSecondMenu => CustomUIConfig.GetRedPoint("activity", menu, visibleSecondMenu));
}
function areActivityMenuListsEqual(left, right) {
  const leftMenus = Object.keys(left);
  const rightMenus = Object.keys(right);
  if (leftMenus.length != rightMenus.length) return false;
  return leftMenus.every((menu, index) => {
    if (menu != rightMenus[index]) return false;
    const leftSecondMenus = left[menu];
    const rightSecondMenus = right[menu];
    return leftSecondMenus.length == rightSecondMenus.length && leftSecondMenus.every((secondMenu, secondIndex) => secondMenu == rightSecondMenus[secondIndex]);
  });
}

exports.areActivityMenuListsEqual = areActivityMenuListsEqual;
exports.buildActivityMenuList = buildActivityMenuList;
exports.getActiveStarseaActivityID = getActiveStarseaActivityID;
exports.getVisibleActivityRedPoint = getVisibleActivityRedPoint;