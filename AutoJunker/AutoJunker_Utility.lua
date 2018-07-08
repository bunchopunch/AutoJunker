
local LII = LibStub:GetLibrary("LibItemInfo-1.0")

--*********************************************************************************************--
-- These functions have logic, but work and are unlikely to need changed when adding features ---
--*********************************************************************************************--

-------------------------------------------------------------------------------------------------
--  Colors  --
-------------------------------------------------------------------------------------------------
local colorYellow 		= "|cFFFF00" 	-- yellow 
local colorMagenta		= "|cFF00FF"	-- Magenta
local colorRed 			= "|cFF0000" 	-- Red
local colorBrown	 	= "|c996633" 	-- colorBrown
--local colorGreen	 	= "|cFFFF00" 	-- colorGreen
local colorGreen 		= "|c00FF00" 	-- green
local colorDrkOrange 	= "|cFFA500"	-- Dark Orange

--[[
INVENTORY_BACKPACK = 1
INVENTORY_QUEST_ITEM = 2
INVENTORY_BANK = 3
INVENTORY_GUILD_BANK = 4
BAG_WORN = 0 
BAG_BACKPACK = 1
BAG_BANK = 2 
BAG_GUILDBANK = 3 
--]]

function AutoJunker.IsValidBagSlot(_iBagId, _iSlotId)    
	if (type(_iBagId) == "number" and _iBagId >= 0 and _iBagId <= 3) then
        if (type(_iSlotId) == "number" and _iSlotId >= 0 and _iSlotId <= GetBagSize(_iBagId) - 1) then
            local _, iStackCount = GetItemInfo(_iBagId, _iSlotId)
            return iStackCount > 0
        end
    end
end

function AutoJunker.GetCharNamesStringFromTable(_tNeedInfo)
	if not _tNeedInfo then return end
	
	local sCharsWhoNeedTrait = ""

	for sPlayerName, v in pairs(_tNeedInfo.PlayerNames) do
		if AutoJunker.IsPlayerOnWatchlist(_tNeedInfo.CraftingSkillType, sPlayerName) then
			if sCharsWhoNeedTrait ~= "" then
				sCharsWhoNeedTrait = sCharsWhoNeedTrait..", "..sPlayerName
			else
				sCharsWhoNeedTrait = sCharsWhoNeedTrait..sPlayerName
			end
		end
	end
	return sCharsWhoNeedTrait
end
function AutoJunker.ApplyJunkFilters()
	local iBagId
	local iInventory
	
	if not ZO_PlayerInventoryTabs:IsHidden() then 
		iBagId = BAG_BACKPACK 
		iInventory = INVENTORY_BACKPACK
	elseif not ZO_PlayerBankTabs:IsHidden() then
		iBagId = BAG_BANK 
		iInventory = INVENTORY_BANK
	elseif not ZO_GuildBankTabs:IsHidden() then
		iBagId = BAG_GUILDBANK 
		iInventory = INVENTORY_GUILD_BANK
	else
		return 
	end
	
	local tSlots = PLAYER_INVENTORY.inventories[iInventory].slots
    local bagSize = GetBagSize(iBagId)
	local iJunkCount = 0
	local iUnJunkCount = 0
	
    for iSlotId = 0, bagSize-1 do
       if tSlots[iSlotId] then
			local bWasJunkedStatus = AutoJunker.OnSlotUpdate(iBagId, iSlotId)
			if bWasJunkedStatus then
				iJunkCount = iJunkCount + 1
			elseif bWasJunkedStatus ~= nil then
				iUnJunkCount = iUnJunkCount + 1
			end
       end
    end
	AutoJunker.PrintApplyJunkFiltersMsg(iJunkCount, iUnJunkCount)
end

-- Called from Keybind only
function AutoJunker.ToggleIsJunk()
	local cItemControl = WINDOW_MANAGER:GetMouseOverControl()
	if not (cItemControl.dataEntry and cItemControl.dataEntry.data) then return end
	if not (cItemControl.dataEntry.data.bagId and cItemControl.dataEntry.data.slotIndex) then return end
	
	local iBagId = cItemControl.dataEntry.data.bagId
	local iSlotId = cItemControl.dataEntry.data.slotIndex
	local bSetItemAsJunk = not IsItemJunk(iBagId, iSlotId)
	
	SetItemIsJunk(iBagId, iSlotId, bSetItemAsJunk)
end

function AutoJunker.DestroyItem(_iBagId, _iSlotId)  
	local lLink = LII:GetFormattedItemLink(_iBagId, _iSlotId)
	DestroyItem(_iBagId, _iSlotId) 
	AutoJunker.DebugWin:AddText(colorRed.."ITEM DESTROYED: "..lLink..", You have Auto-Destroy 0 Sell Price Items turned on. The item was junk & had 0 sell price.")
end

function AutoJunker.DestroyCheck(_iBagId, _iSlotId) 
	if not AutoJunker.SavedVariables["AUTODESTROY0VALUEITEMS"] then return end
	
	local _, _, iSellPrice = GetItemInfo(_iBagId, _iSlotId) 
	if iSellPrice == 0 then
		if AutoJunker.SavedVariables["AUTODESTROY0VALUEITEMSCONFIRM"] then
			ZO_Dialogs_ShowDialog("AutoJunker_CONFIRM_DESTROY_0VALUE", {_iBagId, _iSlotId}, 
			{titleParams={"Auto-Destroy 0 Sell Price Items"}, 
			mainTextParams={"Do you want to destroy: ", 
			LII:GetItemToolTipName(_iBagId, _iSlotId)}})
		else
			AutoJunker.DestroyItem(_iBagId, _iSlotId) 
		end
	end
end

-------------------------------------------------------------------------------------------------
--  Trim - Trims leading & trailing whitespace  --
-------------------------------------------------------------------------------------------------
function AutoJunker.Trim(s)
	return s:find'^%s*$' and '' or s:match'^%s*(.*%S)'
end

-------------------------------------------------------------------------------------------------
--  Deep Copy --
--	Used to copy the saved variables table, to be saved for profiles --
-------------------------------------------------------------------------------------------------
function AutoJunker.deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[AutoJunker.deepcopy(orig_key)] = AutoJunker.deepcopy(orig_value)
        end
        --setmetatable(copy, AutoJunker.deepcopy(getmetatable(orig)))
        copy["_meta"] = AutoJunker.deepcopy(getmetatable(orig))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end


function AutoJunker.IsPlayerOnWatchlist(_iCraftingSkillType, _sPlayerName)
	local tCharacterList = AutoJunker.AccountSavedVariables["CHARACTER_WATCH_LISTS"][_iCraftingSkillType]
	local sPlayerName = _sPlayerName or GetUnitName("player") 
	-- Can be nil so it or false
	return tCharacterList[sPlayerName] or false
end

-- ug, getting sloppy. Since the change, now using libNeed4Research information is passed
-- differently. I need to search through the PlayerNames table & see if any are on the
-- watch list for the crafting skill type to know if I should be keeping an item for
-- research for them...because LN4R returns everyone who needs it, not players on MY watchlist
function AutoJunker.AreOtherCharsOnWatchlist(_tNeedInfo)
	if not _tNeedInfo then return false end
	if not _tNeedInfo.OtherNeeds then return false end
	local sCurrentPlayerName = GetUnitName("player") 
	
	for sPlayerName, v in pairs(_tNeedInfo.PlayerNames) do
		if sPlayerName ~= sCurrentPlayerName and AutoJunker.IsPlayerOnWatchlist(_tNeedInfo.CraftingSkillType, sPlayerName) then
			return true
		end
	end
	return false
end
-- Add or remove a character from the watchlist
function AutoJunker.UpdateWatchlist(_iCraftingSkillType, _bShouldBeOnList, _sPlayerName)
	local tCharacterList = AutoJunker.AccountSavedVariables["CHARACTER_WATCH_LISTS"][_iCraftingSkillType]
	local sPlayerName = _sPlayerName or GetUnitName("player")   
	
	if _bShouldBeOnList then
		tCharacterList[sPlayerName] = true
	else
		tCharacterList[sPlayerName] = nil
	end
end
function AutoJunker.RemoveDeletedCharacter(_sPlayerName)
	if type(_sPlayerName) ~= "string" then return end
	local bNameFound = false
	
	d(colorMagenta.."Attempting to remove ".._sPlayerName.." from watchlists")
	
	local tCraftTable = {
		[CRAFTING_TYPE_BLACKSMITHING] 	= "Blacksmithing",
		[CRAFTING_TYPE_CLOTHIER] 		= "Clothier",
		[CRAFTING_TYPE_WOODWORKING] 	= "Woodworking",
		[CRAFTING_TYPE_PROVISIONING] 	= "Provisioning",
	}
	for iCraftingSkillType, sCraftingSkillLabel in pairs(tCraftTable) do
		if AutoJunker.IsPlayerOnWatchlist(iCraftingSkillType, _sPlayerName) then
			bNameFound = true
			d(colorYellow.._sPlayerName.." found on the "..sCraftingSkillLabel.." watchlist")
			AutoJunker.UpdateWatchlist(iCraftingSkillType, false, _sPlayerName)
			d(colorGreen.."**** Player removed from "..sCraftingSkillLabel.." watchlist")
		else
			d(colorRed.._sPlayerName.." is NOT on the "..sCraftingSkillLabel.." watchlist")
		end
	end
	-- Remove from provisioning
	if bNameFound then
		d("...")
		d(colorYellow.."UI will reload in 10 seconds to update all necessary files.")
		zo_callLater(function() ReloadUI("ingame") end, 10000)
	else
		d(colorMagenta.."Character Name: ".._sPlayerName.." not found on any crafting watchlists")
	end
	return bNameFound
end
-------------------------------------------------------------------------------------------------
--  Get Crafting Type Watch List --
--		Used to get the names of characters in the watch list for the given crafting skill type --
-- 		Returns the character watch list (string) & the number of characters in the list --
--		The Watch List is the list of character names who have KEEP (this crafting type) for research turned ON. --
-------------------------------------------------------------------------------------------------
function AutoJunker.GetCraftingTypeWatchList(_iCraftingSkillType)
	local tCharacterList = AutoJunker.AccountSavedVariables["CHARACTER_WATCH_LISTS"][_iCraftingSkillType]
	local sCharsInList = ""
	local iNumCharsInList = 0
	
	for sPlayerName,v in pairs(tCharacterList) do
		iNumCharsInList = iNumCharsInList + 1
		if sCharsInList == "" then
			sCharsInList = (sCharsInList..sPlayerName)
		else
			sCharsInList = (sCharsInList..", "..sPlayerName)
		end
	end
	return sCharsInList, iNumCharsInList
end

-------------------------------------------------------------------------------------------------
--  Get Icon Color --
--	If the item is a recipe we call this function with (false,false) so it returns green --
-------------------------------------------------------------------------------------------------
function AutoJunker.GetIconColor(_bPlayerNeedsTrait, _bOtherNeedsTrait)
	local tIconColor = AutoJunker.iconColorGreen -- Recipe Color --
	
	if (_bPlayerNeedsTrait and _bOtherNeedsTrait) then
		tIconColor = AutoJunker.iconColorOrange
	elseif _bPlayerNeedsTrait then
		tIconColor = AutoJunker.iconColorRed
	elseif _bOtherNeedsTrait then
		tIconColor = AutoJunker.iconColorYellow
	end
	return tIconColor
end

-------------------------------------------------------------------------------------------------
--  Functions for determining if an item should be kept for its sellPrice value --
-------------------------------------------------------------------------------------------------
function AutoJunker.KeepForValue(_tItemInfo)
	if AutoJunker.SavedVariables["KEEPATORABOVEVALUE"] <= 0 then return false end

	if (_tItemInfo["SELLPRICE"] >= AutoJunker.SavedVariables["KEEPATORABOVEVALUE"]) then
		return true, AutoJunker.FormatJunkDebugMsg(false, _tItemInfo.LINK, "Matches Keep Items At or Above This Value filter.")
	end
	return false
end


-------------------------------------------------------------------------------------------------
--  Function to compare item qualities --
-------------------------------------------------------------------------------------------------
function AutoJunker.MeetsQualityCheck(itemQuality, savedQuality, callingFunction, itemName, itemType)
	if not savedQuality or type(savedQuality) ~= "number" then
		local msg = colorRed.."FAILED QUALITY CHECK: CALLINGFUNCTION: "..tostring(callingFunction)..", ITEMNAME: "..tostring(itemName)..", ITEMTYPE = "..tostring(itemType)..", SAVEDQUALITY: "..tostring(savedQuality)
		
		AutoJunker.DebugWin:AddText(msg)
		-- Default to false, so the item does not get junked.
		return false
	end
	
	if itemQuality <= savedQuality then
		return true
	end
	return false
end

--***************************************************************************************************--
----     These functions below have no logic that would be affected by changes in the program      ----
--***************************************************************************************************--
function AutoJunker.Escape(s)
	--return (s:gsub('[%-%.%+%[%]%(%)%$%^%%%?%*]','%%%1'):gsub('%z','%%z'))
	local sName = s:gsub("(%^%a+:*%a*)$","")
	return sName:gsub('[%-%.%+%[%]%(%)%$%^%%%?%*]','%%%1'):gsub('%z','%%z')
end



-------------------------------------------------------------------------------------------------
--  ItemTypes to Exclude I don't know what they are or do not want handle  --
--	They are actually handled in the code, but this helps me insure I know I'm only working with --
--  itemTypes that I use to prevent unseen errors due to item types I'm not sure what they are --
--  or side-effects I just didn't think of because I'm not using the item type, makes debugging easier --
-------------------------------------------------------------------------------------------------
function AutoJunker.IsAHandledItemType(_BagIdOrLink, _iSlotId) 
	local lItemLink = LII:GetItemLink(_BagIdOrLink, _iSlotId)
	-- will be nil for invalid items:
	if not lItemLink then return end
	-- Can't check this because passing in nil returns ITEMTYPE_NONE
	local iItemType = GetItemLinkItemType(lItemLink)
	
	if not iItemType then
		local itemName = LII:GetItemToolTipName(_BagIdOrLink, _iSlotId)
		local reason = colorRed.."ITEM HAS NO ITEMTYPE "..itemName
		return false, reason
	elseif not AutoJunker.SavedVariables[iItemType] then
		local itemName = LII:GetItemToolTipName(_BagIdOrLink, _iSlotId)
		local reason = colorRed.."ITEMTYPE NOT HANDLED BY ADDON: "..colorYellow..itemName.."("..iItemType..")"
		return false, reason
	end
	return true
end



