
local LII = LibStub:GetLibrary("LibItemInfo-1.0")
local LN4R = LibStub:GetLibrary("LibNeed4Research")

--*********************************************************************************************--
-----	Functions for getting research information					 ----
--*********************************************************************************************--


-------------------------------------------------------------------------------------------------
--  Keep for Research  --
--		Determines if the item should be kept for research based on settings & if --
--		the player needs it or if some other char needs it --
-------------------------------------------------------------------------------------------------

function AutoJunker.KeepForResearch(_BagIdOrLink, _iSlotId)
	local lItemLink = LII:GetFormattedItemLink(_BagIdOrLink, _iSlotId)
	local iItemType = GetItemLinkItemType(lItemLink)
	if iItemType == ITEMTYPE_NONE then return end
	
	local bSaveForOthersFlag = AutoJunker.SavedVariables["SAVEUNKNOWNSOTHER"]
	local iCraftingSkillType, sReason, tNeedInfo
	
	if iItemType == ITEMTYPE_RECIPE then 
		tNeedInfo = LN4R:DoAnyPlayersNeedRecipe(_BagIdOrLink, _iSlotId)
	else
		tNeedInfo = LN4R:DoAnyPlayersNeedTrait(_BagIdOrLink, _iSlotId)
	end
	if not tNeedInfo then return end
	
	iCraftingSkillType = tNeedInfo.CraftingSkillType
	local craftingTypeLabelName = LII:GetCraftingSkillTypeLabelName(iCraftingSkillType)
	
	local bIsPlayerOnWatchlist = AutoJunker.IsPlayerOnWatchlist(iCraftingSkillType)
	local bAreOthersWhoNeedOnWatchList = AutoJunker.AreOtherCharsOnWatchlist(tNeedInfo)
	
	if bIsPlayerOnWatchlist and tNeedInfo.PlayerNeeds then
		sReason = AutoJunker.FormatJunkDebugMsg(false, lItemLink, "Matches KEEP Unknown "..craftingTypeLabelName.." Trait Items filter"..". It is being kept for your current character.")
		return tNeedInfo, sReason
	elseif bSaveForOthersFlag and bAreOthersWhoNeedOnWatchList then
		sReason = AutoJunker.FormatJunkDebugMsg(false, lItemLink, "Matches KEEP Unknowns for Other Characters. Matches another characters KEEP Unknown "..craftingTypeLabelName.." Trait Items filter.")
		return tNeedInfo, sReason
	end
	-- Returning nil because no one needs it for research
	return
end









