--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


// Unlock Difficulty UI JavaScript
(function() {
    "use strict";
    
    // Game state
    let unlockedDifficulties = [];
    let unlockCost = 0;
    let maxDifficulty = 20;
    
    // UI elements
    let mainPanel = null;
    let unlockedPanel = null;
    let lockedPanel = null;
    let buyPanel = null;
    let buyPriceLabel = null;
    
    const DotaHUD = GameUI.CustomUIConfig().DotaHUD;

    DotaHUD.windowControllers["unlock_difficulty"] = {
        is_open: false,
        open: function(){
            mainPanel.style.opacity = "1";
            Game.EmitSound("ui_window_open");
        },
        close: function(){
            mainPanel.style.opacity = "0";
            Game.EmitSound("ui_window_close");
        }
    }
    DotaHUD.ListenToMouseEvent(
        DotaHUD.GetCloseWindowOnOutsideClick($("#main"), "unlock_difficulty")
    );

    // Initialize the UI
    function Initialize() {
        mainPanel = $.GetContextPanel();
        if (!mainPanel) {
            $.Schedule(0.1, Initialize);
            return;
        }
        
        unlockedPanel = mainPanel.FindChildTraverse("unlocked_difficulty");
        lockedPanel = mainPanel.FindChildTraverse("locked_difficulty");
        buyPanel = mainPanel.FindChildTraverse("buy_panel");
        buyPriceLabel = mainPanel.FindChildTraverse("buy_price_label");
        
        // Set up unlock button event
        if (buyPanel) {
            buyPanel.SetPanelEvent("onactivate", OnUnlockButtonPressed);
            buyPanel.SetPanelEvent("onmouseover", OnButtonHover);
        }
    }
    
    // Load interface with data
    function LoadInterface(unlockedCount, price, maxDiff) {
        unlockedDifficulties = [];
        unlockCost = price;
        maxDifficulty = maxDiff;
        
        // Fill unlocked difficulties array
        for (let i = 1; i <= unlockedCount; i++) {
            unlockedDifficulties.push(i);
        }
        
        // Clear existing panels
        if (unlockedPanel) {
            unlockedPanel.RemoveAndDeleteChildren();
        }
        if (lockedPanel) {
            lockedPanel.RemoveAndDeleteChildren();
        }
        
        // Create difficulty squares using snippets
        for (let i = 1; i <= maxDifficulty; i++) {
            // Create panel with mainPanel as parent first
            let diffPanel = $.CreatePanel("Panel", mainPanel, "diff_" + i);
            diffPanel.AddClass("difficulty_square");
            
            let diffLabel = $.CreatePanel("Label", diffPanel, "diff_" + i + "_label");
            diffLabel.AddClass("difficulty_unit_label");
            diffLabel.text = i.toString();
            
            // Add hover sound for difficulty squares
            diffPanel.SetPanelEvent("onmouseover", OnButtonHover);
            
            // Add to appropriate panel
            if (unlockedDifficulties.includes(i)) {
                diffPanel.SetParent(unlockedPanel);
                diffPanel.AddClass("unlocked");
            } else {
                diffPanel.SetParent(lockedPanel);
                diffPanel.AddClass("locked");
            }
        }
        
        // Update price
        if (buyPriceLabel) {
            buyPriceLabel.text = unlockCost.toString();
        }
        
        // Show/hide unlock button
        if (buyPanel) {
            let nextDifficulty = GetNextDifficultyToUnlock();
            if (nextDifficulty) {
                buyPanel.visible = true;
            } else {
                buyPanel.visible = false; // All difficulties unlocked
            }
        }
    }
    
    // Get next difficulty to unlock
    function GetNextDifficultyToUnlock() {
        for (let i = 1; i <= maxDifficulty; i++) {
            if (!unlockedDifficulties.includes(i)) {
                return i;
            }
        }
        return null; // All difficulties unlocked
    }
    
    // Handle button hover
    function OnButtonHover() {
        Game.EmitSound("ui_rollover");
    }
    
    // Handle unlock button press
    function OnUnlockButtonPressed() {
        let nextDifficulty = GetNextDifficultyToUnlock();
        if (nextDifficulty) {
            // Play click sound
            Game.EmitSound("General.ButtonClick")
            // Send unlock request to server
            GameEvents.SendCustomGameEventToServer("buy_unlock_difficulty", {});
        }
    }

    GameEvents.Subscribe("difficulty_data_updated", (data) => {
        if (data.current_difficulty !== undefined && data.unlock_cost !== undefined && data.max_possible_difficulty !== undefined) {
            LoadInterface(data.current_difficulty, data.unlock_cost, data.max_possible_difficulty);
            if(!DotaHUD.IsWindowOpen("unlock_difficulty")){
                DotaHUD.WindowOpen("unlock_difficulty")
            }
        }
    });
    
    // Initialize immediately
    Initialize();
    
    // Make LoadInterface function globally available
    $.LoadInterface = LoadInterface;
    
})();