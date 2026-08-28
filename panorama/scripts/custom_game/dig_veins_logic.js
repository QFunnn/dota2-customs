--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('dig_veins_logic', exports); const require = GameUI.__require;

const ACTIVITY_MINING_ID = 1001;
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
const isDigVeinsTaskActive = (task, timestamp) => {
  return task.start_time <= timestamp && task.end_time >= timestamp;
};
const isDigVeinsTask = task => {
  const taskConfig = KeyValues.task[task.task_id];
  return taskConfig != undefined && taskConfig.activity_id == ACTIVITY_MINING_ID && (taskConfig.type == 6 || taskConfig.type == 7);
};
const hasClaimableDigVeinsTask = (tasks, timestamp) => Object.values(tasks).some(task => {
  return isDigVeinsTask(task) && isDigVeinsTaskActive(task, timestamp) && isDigVeinsTaskClaimable(task);
});
const hasClaimableDigVeinsTaskForMenu = tasks => Object.values(tasks).some(task => {
  return isDigVeinsTask(task) && isDigVeinsTaskClaimable(task);
});
const hasClaimableDigVeinsDepthReward = activityData => {
  if (activityData == undefined) {
    return false;
  }
  const receivedRewardIDs = new Set(activityData.received?.map(reward => reward.reward_id) ?? []);
  return Object.values(GameUI.CustomUIConfig().activity_mining_node ?? {}).some(node => {
    return node.activity_id == ACTIVITY_MINING_ID && Number.isFinite(node.depth_num) && node.depth_num > 0 && activityData.depth >= node.depth_num && !receivedRewardIDs.has(node.depth_num);
  });
};

exports.ACTIVITY_MINING_ID = ACTIVITY_MINING_ID;
exports.getDigVeinsTaskState = getDigVeinsTaskState;
exports.hasClaimableDigVeinsDepthReward = hasClaimableDigVeinsDepthReward;
exports.hasClaimableDigVeinsTask = hasClaimableDigVeinsTask;
exports.hasClaimableDigVeinsTaskForMenu = hasClaimableDigVeinsTaskForMenu;
exports.isDigVeinsTask = isDigVeinsTask;
exports.isDigVeinsTaskActive = isDigVeinsTaskActive;
exports.isDigVeinsTaskClaimable = isDigVeinsTaskClaimable;