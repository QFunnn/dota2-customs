--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('dig_veins_logic', exports); const require = GameUI.__require;

const ACTIVITY_DICE_ID = 802;

const ACTIVITY_MINING_ID = 1002;
const getDigVeinsTaskState = task => {
  if (task.receive_progress == 1) {
    return "Received";
  }
  if (task.progress >= task.target) {
    return "Claimable";
  }
  return "InProgress";
};
const isDigVeinsTaskClaimable = task => getDigVeinsTaskState(task) == "Claimable";
const isDigVeinsTask = task => {
  const taskConfig = KeyValues.task[task.task_id];
  return taskConfig != undefined && taskConfig.activity_id == ACTIVITY_MINING_ID && (taskConfig.type == 6 || taskConfig.type == 7);
};
const hasClaimableDigVeinsTask = tasks => Object.values(tasks).some(task => {
  return isDigVeinsTask(task) && isDigVeinsTaskClaimable(task);
});
const hasClaimableDigVeinsTaskForMenu = hasClaimableDigVeinsTask;

exports.ACTIVITY_DICE_ID = ACTIVITY_DICE_ID;
exports.ACTIVITY_MINING_ID = ACTIVITY_MINING_ID;
exports.hasClaimableDigVeinsTask = hasClaimableDigVeinsTask;
exports.hasClaimableDigVeinsTaskForMenu = hasClaimableDigVeinsTaskForMenu;