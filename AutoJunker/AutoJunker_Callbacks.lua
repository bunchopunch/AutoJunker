
local LII = LibStub:GetLibrary("LibItemInfo-1.0")
local LN4R = LibStub:GetLibrary("LibNeed4Research")

--*********************************************************************************************--
----	Functions for hooks/callbacks 	----
--*********************************************************************************************--

local tCraftingIcons = {
    [CRAFTING_TYPE_BLACKSMITHING] 	= "/esoui/art/icons/servicemappins/servicepin_smithy.dds",
    [CRAFTING_TYPE_CLOTHIER] 		= "/esoui/art/icons/servicemappins/servicepin_outfitter.dds",
    [CRAFTING_TYPE_PROVISIONING] 	= "/esoui/art/progression/icon_provisioner.dds",
    [CRAFTING_TYPE_WOODWORKING] 	= "/esoui/art/icons/servicemappins/servicepin_woodworking.dds",
    
    [CRAFTING_TYPE_ALCHEMY] 		="/esoui/art/charactercreate/unavailable_overlay.dds",
    [CRAFTING_TYPE_ENCHANTING] 		= "/esoui/art/charactercreate/unavailable_overlay.dds",
    [CRAFTING_TYPE_INVALID] 		= "/esoui/art/charactercreate/unavailable_overlay.dds",
}

-------------------------------------------------------------------------------------------------
--  Colors  --
-------------------------------------------------------------------------------------------------
local colorYellow 		= "|cFFFF00" 	-- yellow 
local colorGreen 		= "|c00FF00" 	-- green
local colorRed 			= "|cFF0000" 	-- Red

-----------------------------------------------------------------------------------------------------
--  Destroy Item --
-----------------------------------------------------------------------------------------------------
local function DestoyItem(_cInvRowControl)
    local iBagId 	= _cInvRowControl.dataEntry.data.bagId
    local iSlotId 	= _cInvRowControl.dataEntry.data.slotIndex
    if not AutoJunker.IsValidBagSlot(iBagId, iSlotId) then return end
    
    local lItemLink = GetItemLink(iBagId, iSlotId, LINK_STYLE_DEFAULT)

    if (IsItemJunk(iBagId, iSlotId) and AutoJunker.SavedVariables["JUNKDESTROYER"]) then 
        DestroyItem(iBagId, iSlotId) 
        ZO_ScrollList_RefreshVisible(ZO_PlayerInventoryBackpack)
        if AutoJunker.SavedVariables["DESTROYERBTNMESSAGES"] then
            d(colorRed.."AutoJunker: Item Destroyed: "..zo_strformat(SI_TOOLTIP_ITEM_NAME, lItemLink))
        end
        AutoJunker.DebugWin:AddText(colorRed.."Item Destroyed:"..zo_strformat(SI_TOOLTIP_ITEM_NAME, lItemLink)..", "..colorYellow.." You clicked one of the AutoJunker Destroyer (X) buttons in the junk area of your inventory.")
    end
end

---------------------------------------------------------------------------------------------------
--  Callback function for inventory rowControls, used to create Destroy Icons --
---------------------------------------------------------------------------------------------------
local function CreateDestroyButton(_cInvRowControl)
    if not (_cInvRowControl and _cInvRowControl.dataEntry and _cInvRowControl.dataEntry.data) then return end
    local iIconSize 	= AutoJunker.iconSize
    local cCntrlIcon 	= _cInvRowControl:GetNamedChild("AutoJunkerDestroyBtn")
    local cCntrlName 	= _cInvRowControl:GetNamedChild("Name")
    local iBagId 		= _cInvRowControl.dataEntry.data.bagId
    local iSlotId 		= _cInvRowControl.dataEntry.data.slotIndex

    
    -- If My child doesn't exist, create it --
    if(not cCntrlIcon) then
        cCntrlIcon = WINDOW_MANAGER:CreateControl(_cInvRowControl:GetName() .. "AutoJunkerDestroyBtn", _cInvRowControl, CT_BUTTON)
        cCntrlIcon:SetDimensions(iIconSize, iIconSize)
        cCntrlIcon:ClearAnchors()
        cCntrlIcon:SetAnchor(TOPLEFT, cCntrlName, TOPRIGHT, AutoJunker.SavedVariables["INFOBUTTONOFFSETX"], 0)
        cCntrlIcon:SetDrawLevel(1)
        cCntrlIcon:SetNormalTexture(AutoJunker.iconDestroy)
        cCntrlIcon:SetHandler("OnClicked", function() DestoyItem(_cInvRowControl) end)
        cCntrlIcon:SetClickSound("Click")
    end
    
    if (IsItemJunk(iBagId, iSlotId) and AutoJunker.SavedVariables["JUNKDESTROYER"]) then 
        cCntrlIcon:SetHidden(false)
        cCntrlIcon:SetEnabled(true) 
    else
        cCntrlIcon:SetHidden(true)
        cCntrlIcon:SetEnabled(false) 
    end
    
end


-------------------------------------------------------------------------------------------------
--  Callback function for inventory rowControls, used to create research icons  --
-------------------------------------------------------------------------------------------------
local function CreateResearchIcon(_InvRowControl, _bIsAtTradingHouse)
    if not (_InvRowControl and _InvRowControl.dataEntry and _InvRowControl.dataEntry.data) then return end
    local bResearchIconsPlayer 	= AutoJunker.SavedVariables["ICONSRESEARCHPLAYER"]
    local bRecipeIconsPlayer 	= AutoJunker.SavedVariables["ICONSRECIPEPLAYER"]
    local bResearchIconsOther 	= AutoJunker.SavedVariables["ICONSRESEARCHOTHER"]
    local bRecipeIconsOther 	= AutoJunker.SavedVariables["ICONSRECIPEOTHER"]
    local iconSize				= AutoJunker.AccountSavedVariables["ICONSIZE"]
    
    local cCntrlIcon 	= _InvRowControl:GetNamedChild("AutoJunkerResearchIcon")
    local iBagId 		= _InvRowControl.dataEntry.data.bagId
    local iSlotId 		= _InvRowControl.dataEntry.data.slotIndex
    local lItemLink
    
    if iBagId then
        lItemLink = GetItemLink(iBagId, iSlotId)
    -- double check that were at the trading house, because an invalid slotId here will crash the client
    -- TRADING_HOUSE:IsAtTradingHouse() 
    -- local tradingHouseListingIndex = ZO_Inventory_GetSlotIndex(inventorySlot)
    elseif TRADING_HOUSE:IsAtTradingHouse() then
        if TRADING_HOUSE.m_searchResultsList and TRADING_HOUSE.m_searchResultsList.data  
        -- Had to remove this for compatability with Awesome Guild Store
        -- it rearranges the slots...not good because if the id doesn't
        -- exist it will crash the game.
        --and TRADING_HOUSE.m_searchResultsList.data[iSlotId] 
        then
            lItemLink = GetTradingHouseSearchResultItemLink(iSlotId)
        end
    end
    --[[
    local lItemLink		= iBagId and GetItemLink(iBagId, iSlotId) or GetTradingHouseSearchResultItemLink(_InvRowControl.slotIndex)
    --]]
    local iItemType 	= GetItemLinkItemType(lItemLink)
    --if iItemType == ITEMTYPE_NONE then return end
    
    local tNeedInfo, bMarkForPlayer, bMarkForOther
    local cCntrlName
    
    if iBagId then
        -- In an inventory
        cCntrlName = _InvRowControl:GetNamedChild("Name")
    else
        -- In Trading House
        cCntrlName = _InvRowControl:GetNamedChild("TimeRemaining")
    end
    
    -- If My child doesn't exist, create it --
    if(not cCntrlIcon) then
        cCntrlIcon = WINDOW_MANAGER:CreateControl(_InvRowControl:GetName() .. "AutoJunkerResearchIcon", _InvRowControl, CT_TEXTURE)
        cCntrlIcon:SetDrawTier(1)
        cCntrlIcon:SetDrawLayer(2)
        cCntrlIcon:SetHidden(true)
    end
    cCntrlIcon:ClearAnchors()
    cCntrlIcon:SetDimensions(iconSize, iconSize)
    local isGrid = false

    --[[
    if AutoJunker.loadedAddons["InventoryGridView"] then
        local inventoryId = PLAYER_INVENTORY.bagToInventoryType[iBagId]
        isGrid = InventoryGridViewSettings:IsGrid(inventoryId)
    end

    if isGrid then
        cCntrlIcon:SetAnchor(BOTTOMRIGHT, _InvRowControl, BOTTOMRIGHT, 0, -5)
    else
        cCntrlIcon:SetAnchor(TOPLEFT, cCntrlName, TOPRIGHT, 0, 0)
    end
    ]]
    cCntrlIcon:SetAnchor(BOTTOMRIGHT, _InvRowControl, BOTTOMRIGHT, 0, -5) -- FIXME: Restore proper gridview support
    
    if iItemType == ITEMTYPE_RECIPE then 
        tNeedInfo = LN4R:DoAnyPlayersNeedRecipe(lItemLink)
        if not tNeedInfo then 
            cCntrlIcon:SetHidden(true)
            return
        end
        local bAreOthersWhoNeedOnWatchList = AutoJunker.AreOtherCharsOnWatchlist(tNeedInfo)
        bMarkForPlayer = AutoJunker.IsPlayerOnWatchlist(tNeedInfo.CraftingSkillType)
        
        bMarkForPlayer = bMarkForPlayer and bRecipeIconsPlayer and tNeedInfo.PlayerNeeds
        bMarkForOther  = bRecipeIconsOther and bAreOthersWhoNeedOnWatchList
        
    else
        tNeedInfo = LN4R:DoAnyPlayersNeedTrait(lItemLink)
        if not tNeedInfo then 
            cCntrlIcon:SetHidden(true)
            return
        end
        local bAreOthersWhoNeedOnWatchList = AutoJunker.AreOtherCharsOnWatchlist(tNeedInfo)
        bMarkForPlayer = AutoJunker.IsPlayerOnWatchlist(tNeedInfo.CraftingSkillType)
        bMarkForPlayer = bMarkForPlayer and bResearchIconsPlayer and tNeedInfo.PlayerNeeds
        bMarkForOther  = bResearchIconsOther and bAreOthersWhoNeedOnWatchList
        
    end
    
    -- If player needs & icons are ON, or Other needs & other icons are ON, or its a recipe --
    if bMarkForPlayer or bMarkForOther then
        cCntrlIcon:SetTexture(tCraftingIcons[tNeedInfo.CraftingSkillType])
        cCntrlIcon:SetColor(unpack(AutoJunker.GetIconColor(bMarkForPlayer, bMarkForOther)))
        cCntrlIcon:SetHidden(false)
    else
        cCntrlIcon:SetHidden(true)
    end
end

-------------------------------------------------------------------------------------------------
--  Add ToolTip Line: Adds char names to item tooltip --
-------------------------------------------------------------------------------------------------
local function AddToolTipLine(_cItemToolTip, _iBagId, _iSlotIdOrTradingHouseSlotIndex)
    if not AutoJunker.SavedVariables["RESEARCHTOOLTIPS"] then return end
    
    local lItemLink
    
    if _iBagId then
        lItemLink = GetItemLink(_iBagId, _iSlotIdOrTradingHouseSlotIndex)
    elseif TRADING_HOUSE:IsAtTradingHouse() then
        if TRADING_HOUSE.m_searchResultsList and TRADING_HOUSE.m_searchResultsList.data and TRADING_HOUSE.m_searchResultsList.data[_iSlotIdOrTradingHouseSlotIndex] then
        lItemLink = GetTradingHouseSearchResultItemLink(_iSlotIdOrTradingHouseSlotIndex)
        end
    else
        return
    end
    
    local iItemType = GetItemLinkItemType(lItemLink)
    if iItemType == ITEMTYPE_NONE then return end
    local tNeedInfo
    
    if iItemType == ITEMTYPE_RECIPE then
        tNeedInfo = LN4R:DoAnyPlayersNeedRecipe(lItemLink)
    else
        tNeedInfo = LN4R:DoAnyPlayersNeedTrait(lItemLink)
    end
    
    if not tNeedInfo then return end
    
    local sCharsWhoNeedTrait = AutoJunker.GetCharNamesStringFromTable(tNeedInfo)
    
    if sCharsWhoNeedTrait ~= "" then
        _cItemToolTip:AddVerticalPadding(20)

    --AddLine(string text, string font, number r, number g, number b, AnchorPosition lineAnchor, ModifyTextType modifyTextType, TextAlignment textAlignment, bool setToFullSize) 
    -- Why doesn't LEFT TextAlignment work? --
        _cItemToolTip:AddLine("Needs For Research: ", "ZoFontGame", 1, 0, 0, LEFT, MODIFY_TEXT_TYPE_NONE, LEFT, false)
        _cItemToolTip:AddLine(sCharsWhoNeedTrait, "ZoFontGame", 1, 0, 0, LEFT, MODIFY_TEXT_TYPE_NONE, LEFT, false)
    end
end

-------------------------------------------------------------------------------------------------
--  Set Item Tooltip Callbacks --
-------------------------------------------------------------------------------------------------
local function SetItemTooltipCallbacks()
    local hSetBagItem = ItemTooltip.SetBagItem
    ItemTooltip.SetBagItem = function(control, bagId, slotIndex, ...)
        hSetBagItem(control, bagId, slotIndex, ...)
        AddToolTipLine(control, bagId, slotIndex)
    end
    
    local hSetWornItem = ItemTooltip.SetWornItem
    ItemTooltip.SetWornItem = function(control, slotIndex, ...)
        hSetWornItem(control, slotIndex, ...)
        AddToolTipLine(control, BAG_WORN, slotIndex)
    end
    
    local hSetTradingHouseBagItem = ItemTooltip.SetTradingHouseItem
    ItemTooltip.SetTradingHouseItem = function(control, tradingHouseSlotIndex, ...)
        hSetTradingHouseBagItem(control, tradingHouseSlotIndex, ...)
        AddToolTipLine(control, nil, tradingHouseSlotIndex)
    end
end

-----------------------------------------------------------------------------------------------------
--  Sets up the callbacks for inventory items --
-----------------------------------------------------------------------------------------------------
local function SetInventoryRowCallbacks()
    -- Callbacks for icons in inventory, bank, ?guild bank? --
    -- I don't have a guild though can't verify that it works for guild bags --
    for k,v in pairs(PLAYER_INVENTORY.inventories) do
        if (v.listView.dataTypes[1] and (v.listView:GetName() ~= "ZO_PlayerInventoryQuest")) then
            -- preserve other callbacks --
            local hCallback = v.listView.dataTypes[1].setupCallback				
            
            v.listView.dataTypes[1].setupCallback = function(invRowControl, ...)	
                    CreateResearchIcon(invRowControl)
                    CreateDestroyButton(invRowControl)					
                    hCallback(invRowControl, ...)
                end				
        end
    end
end
function AutoJunker.SetTradingHouseRowCallbacks()
    --local temp = ZO_TradingHouseItemPaneSearchResults
    local hCallback = TRADING_HOUSE.m_searchResultsList.dataTypes[1].setupCallback
    TRADING_HOUSE.m_searchResultsList.dataTypes[1].setupCallback = function(TradingHouseRowControl, ...)	
                    CreateResearchIcon(TradingHouseRowControl, true)				
                    hCallback(TradingHouseRowControl, ...)
                end		
end
local function SetDeconstructionPanelRowCallbacks()
    -- Callback for icons in the deconstructionPanel (inv window that opens when deconstructing items) --
    -- SMITHING.control = ZO_SmithingTopLevel --
    -- Get deconstruction window control: ZO_SmithingTopLevelDeconstructionPanelInventoryBackpack --
    -- There has to be an easier way to do this :P -- Need a get control by name function is there one? --
    --local cntrl = SMITHING.control:GetNamedChild("DeconstructionPanel"):GetNamedChild("Inventory"):GetNamedChild("Backpack")
    local cntrl = ZO_SmithingTopLevelDeconstructionPanelInventoryBackpack
    
    if cntrl.dataTypes[1] then
        -- preserve other callbacks --
        local hDeconCallback = cntrl.dataTypes[1].setupCallback

        cntrl.dataTypes[1].setupCallback = function (deconstructionRowControl, ...)
                hDeconCallback(deconstructionRowControl, ...)
                CreateResearchIcon(deconstructionRowControl)
            end
    end
end

--[[  I don't think theres any way to get info about items in the guild store so even
if I setup callbacks (which I didn't finish, this isn't correct) it would not work...
local function SetTradeStoreRowCallbacks()
    -- ZO_TradingHouseItemPaneSearchResultsContents
    local cntrl = ZO_TradingHouseItemPaneSearchResults
    if cntrl.dataTypes[1] then
        -- preserve other callbacks --
        local hTradeStoreCallback = cntrl.dataTypes[1].setupCallback

        cntrl.dataTypes[1].setupCallback = function (tradingHouseRowControl, ...)
                hTradeStoreCallback(tradingHouseRowControl, ...)
                CreateResearchIcon(tradingHouseRowControl)
            end
    end
end
--]]


-------------------------------------------------------------------------------------------------
--  Initialize all callbacks  --
-------------------------------------------------------------------------------------------------
function AutoJunker.SetUpCallbacks()
    SetInventoryRowCallbacks()
    SetDeconstructionPanelRowCallbacks()
    SetItemTooltipCallbacks()
end








