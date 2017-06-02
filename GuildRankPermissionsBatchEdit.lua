local GuildRankPermissionsBatchEdit = {}

function GuildRankPermissionsBatchEdit:SetRepairsCmd(strCmd, strParam)
  local nAmount = tonumber(strParam)
  if not nAmount or nAmount < 0 then
    Print("Invalid amount")
    return
  end
  for idx, guild in ipairs(GuildLib.GetGuilds()) do
    self:DoStuff(guild, nAmount)
  end
end

function GuildRankPermissionsBatchEdit:DoStuff(guild, nAmount)
  if guild:GetType() ~= GuildLib.GuildType_Guild then return end
  for idx, tRank in ipairs(guild:GetRanks()) do
    if tRank.strName ~= "" then
      self:SetRepairs(guild, idx, nAmount)
    end
  end
end

function GuildRankPermissionsBatchEdit:SetRepairs(guild, nRank, nAmount)
  Print("Here with "..tostring(nRank).." and "..tostring(nAmount))
  -- guild:SetRankBankMoneyLimit(nRank, nAmount)
end

function GuildRankPermissionsBatchEdit:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function GuildRankPermissionsBatchEdit:Init()
  Apollo.RegisterAddon(self)
end

function GuildRankPermissionsBatchEdit:OnLoad()
  Apollo.RegisterSlashCommand("setrepairs", "SetRepairsCmd", self)
end

local GuildRankPermissionsBatchEditInst = GuildRankPermissionsBatchEdit:new()
GuildRankPermissionsBatchEditInst:Init()
