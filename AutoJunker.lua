
local LIBMW = LibStub:GetLibrary("LibMsgWin-1.0")
local LIBLA = LibStub:GetLibrary("LibLoadedAddons")

local ADDON_NAME	= "AutoJunker"
local CODE_VERSION	= 1.0

--------------------------------------------------------------------------------------
-- Create Tables used in the addon --
--------------------------------------------------------------------------------------
AutoJunker = {}
AutoJunker.loadedAddons = {}
AutoJunker.debug = {}
-- When debugMode = true, it will process old items. Can be used to
-- swap things in & out of inventories to see debug messages on how/why items are being junked/not junked
AutoJunker.debugMode = false

--=================================================================--
--  Initialize Variables --
--=================================================================--
AutoJunker.name            = ADDON_NAME
AutoJunker.SettingVersion  = 1.0
--=================================================================--

--[[
-- locals --
local bIsBankFilterIdsInitialized = false
local bIsGuildBankFilterIdsInitialized = false
--]]


--=================================================================--
AutoJunker.version = 1.0 -- leave to prevent resetting saved vars --
--=================================================================--

-----------------------------------------------------------------------------------
--  Slot Update (called from: EVENT_INVENTORY_SINGLE_SLOT_UPDATE) --
-------------------------------------------------------------------------------------
local function SlotUpdate(_eventCode, _iBagId, _iSlotId, _bNewItem, _itemSoundCategory, _UpdateReason)
    -- To reduce code bloat in the main file these are only cases that need to be ruled out for all functions Each function may have its own checks to determine if the item should be processed --
    if not (_bNewItem or AutoJunker.debugMode) then return end
    if _iBagId ~= BAG_BACKPACK then return end
    
    AutoJunker.OnSlotUpdate(_iBagId, _iSlotId)
end

--------------------------------------------------------------------------------------
--  Looted (called from: EVENT_LOOT_UPDATED) --
-- GetLoot: Determines if an item should be looted & then loots it, if appropriate. --
---------------------------------------------------------------------------------------
local function Looted(_EventCode)
    if not AutoJunker.SavedVariables["LOOTMODE"] then return end
    AutoJunker.GetLoot()	-- In AutoJunker_AutoLoot.lua --
end

------------------------------------------------------------------------------------
-- Looted Money   (called from: EVENT_MONEY_UPDATE) 											--
-----------------------------------------------------------------------------------
local function LootedMoney( _EventCode, _NewMoney, _OldMoney, _Reason) 
    local goldAmount = (_NewMoney - _OldMoney)
    AutoJunker.OnMoneyLooted(goldAmount, _Reason)
end


---------------------------------------------------------------------------------
--  Misc (--
---------------------------------------------------------------------------------


local function OnOpenTradingHouse()
    -- Hook row controls
    AutoJunker.SetTradingHouseRowCallbacks()
    EVENT_MANAGER:UnregisterForEvent(ADDON_NAME, EVENT_TRADING_HOUSE_RESPONSE_RECEIVED)
end
function AutoJunker.ToggleDebugWin()
    -- Toggle the hidden saved variable & then set the window property
    AutoJunker.SavedVariables.DEBUGWIN_HIDDEN = not AutoJunker.SavedVariables.DEBUGWIN_HIDDEN
    AutoJunker.DebugWin:SetHidden(AutoJunker.SavedVariables.DEBUGWIN_HIDDEN)
end

local function SetUpDebugWin()
    AutoJunker.DebugWin = LIBMW:CreateMsgWindow("AutoJunkerDebugWindow", "AutoJunker Debug Window")
    local debugWin = AutoJunker.DebugWin
    
    debugWin:SetHidden(AutoJunker.SavedVariables.DEBUGWIN_HIDDEN)
    debugWin:ClearAnchors()
    debugWin:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, AutoJunker.SavedVariables.DEBUGWIN_OFFSETX, AutoJunker.SavedVariables.DEBUGWIN_OFFSETY)
    debugWin:SetWidth(AutoJunker.SavedVariables.DEBUGWIN_WIDTH)
    debugWin:SetHeight(AutoJunker.SavedVariables.DEBUGWIN_HEIGHT)
    local buffer = debugWin:GetNamedChild("Buffer")
    buffer:SetMaxHistoryLines(300)

    debugWin:SetHandler("OnMoveStop", function(self)
        AutoJunker.SavedVariables.DEBUGWIN_OFFSETX = self:GetLeft()
        AutoJunker.SavedVariables.DEBUGWIN_OFFSETY = self:GetTop()
    end)
    debugWin:SetHandler("OnResizeStop", function(self)
        AutoJunker.SavedVariables.DEBUGWIN_WIDTH = self:GetWidth()
        AutoJunker.SavedVariables.DEBUGWIN_HEIGHT = self:GetHeight()
    end)
end

local function OnPlayerActivated()
    -- done here to catch loaded addons
    EVENT_MANAGER:UnregisterForEvent(ADDON_NAME, EVENT_ADD_ON_LOADED)
    
end


--------------------------------------------
-- Temporary table cleaner --
--------------------------------------------
--[[
local function tableCleaner()
    local itemTypesToRemove = {
    [ITEMTYPE_RACIAL_STYLE_MOTIF]   = ITEMTYPE_RACIAL_STYLE_MOTIF,
    [ITEMTYPE_COSTUME]              = ITEMTYPE_COSTUME,
    [ITEMTYPE_DISGUISE]             = ITEMTYPE_DISGUISE,
    [ITEMTYPE_SIEGE]                = ITEMTYPE_SIEGE,
    [ITEMTYPE_ADDITIVE]             = ITEMTYPE_ADDITIVE,
    [ITEMTYPE_ARMOR_BOOSTER]        = ITEMTYPE_ARMOR_BOOSTER,
    [ITEMTYPE_AVA_REPAIR]           = ITEMTYPE_AVA_REPAIR,
    [ITEMTYPE_CONTAINER]            = ITEMTYPE_CONTAINER,
    [ITEMTYPE_LOCKPICK]             = ITEMTYPE_LOCKPICK,
    [ITEMTYPE_PLUG]                 = ITEMTYPE_PLUG,
    [ITEMTYPE_POISON]               = ITEMTYPE_POISON,
    [ITEMTYPE_RAW_MATERIAL]         = ITEMTYPE_RAW_MATERIAL ,
    [ITEMTYPE_TABARD]               = ITEMTYPE_TABARD,
    [ITEMTYPE_WEAPON_BOOSTER]       = ITEMTYPE_WEAPON_BOOSTER,
    }
    for key,v in pairs(itemTypesToRemove) do 
        if AutoJunker.SavedVariables[key] then
            AutoJunker.SavedVariables[key] = nil
        end
    end
end
--]]


---------------------------------------------------------------------------
--  OnAddOnLoaded  --
---------------------------------------------------------------------------
local function OnAddOnLoaded(_event, addonName)
    if addonName == ADDON_NAME then
        AutoJunker:Initialize()
    end
    if(addonName == "InventoryGridView") then 
        AutoJunker.loadedAddons["InventoryGridView"] = true
    end
end

---------------------------------------------------------------------------------
--  Initialize Function --
----------------------------------------------------------------------------------
function AutoJunker:Initialize()
    -- Registers addon to loadedAddon library
    LIBLA:RegisterAddon(ADDON_NAME, CODE_VERSION)
    
    -- Get saved variables (char specific) --
    self.SavedVariables = ZO_SavedVars:New("AutoJunkerSavedVars", AutoJunker.version, nil, AutoJunkerPlayerDefault)
    
    
    -- Get Account variables, its the trait table (used for the trait table of names, if your names in it you don't know the trait) --
    self.AccountSavedVariables = ZO_SavedVars:NewAccountWide("AutoJunkerSavedVars", AutoJunker.version, nil, AutoJunkerAccountDefault)
    
    AutoJunker.SetUpCallbacks()		-- Sets-up destroyer buttons, research icons, & research tooltips --
    
    --===========================================--
    --=== Temporary to clean out old itemTypes ==--
    --===========================================--
    --tableCleaner()
    --===========================================--
    --===========================================--
    
    -- Must be done after trait tables are set-up or else first time log-ins will not show up on the watch lists --
    
    -- Create the debug window
    SetUpDebugWin()
    
    local colorMagenta		= "|cFF00FF"	-- Magenta
    local colorDrkOrange 	= "|cFFA500"	-- Dark Orange
    -- Initialize HotKeys
    ZO_CreateStringId("SI_BINDING_NAME_AUTOJUNKER_TOGGLE_DEBUG_WINDOW", colorDrkOrange.."Toggle Debug Window|r "..colorMagenta.."- Toggles a window that will tell you why every item is junked or kept. Displays which filter the item matched when junked or kept.")
    ZO_CreateStringId("SI_BINDING_NAME_AUTOJUNKER_DESTROY0SELLPRICE", colorDrkOrange.."Destroy 0 Sell Price Junk|r "..colorMagenta.."- Destroys all junk items with 0 Sell Price in your backpack. Your backpack must be open for this to work.")
    ZO_CreateStringId("SI_BINDING_NAME_AUTOJUNKER_TOGGLE_ITEM_JUNK", colorDrkOrange.."Toggles an items junk status. |r "..colorMagenta.."- Hoover your mouse over an item in your inventory & hit the hotkey to mark it as junk.")
    ZO_CreateStringId("SI_BINDING_NAME_AUTOJUNKER_APPLY_FILTER_TO_BAG", colorDrkOrange.."Apply Junk Filters To Open Invnetory|r "..colorMagenta.."- When pressed your current junk filters will be applied to the open inventory. Works on your backpack, bank, & guild bank. The inventory must be open to work.")
    
    -- Register Events --
    EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, SlotUpdate)
    EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_OPEN_STORE, AutoJunker.StoreOpened)
    EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_LOOT_UPDATED, Looted) 
    EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_MONEY_UPDATE, LootedMoney) 
    EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_PLAYER_ACTIVATED, OnPlayerActivated)
    EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_OPEN_FENCE, AutoJunker.OnFenceOpened)

    AutoJunker.CreateSettingsMenu()
end

---------------------------------------------------------------------------------
--  Register Events --
---------------------------------------------------------------------------------
EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_ADD_ON_LOADED, OnAddOnLoaded)
EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_TRADING_HOUSE_RESPONSE_RECEIVED, OnOpenTradingHouse)

local function RemoveDeletedCharacter(_sPlayerName)
    AutoJunker.RemoveDeletedCharacter(_sPlayerName)
end
SLASH_COMMANDS["/AutoJunkerDeleteChar"] = RemoveDeletedCharacter


