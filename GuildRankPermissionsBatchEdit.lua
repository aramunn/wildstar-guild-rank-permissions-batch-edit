local GuildRankPermissionsBatchEdit = {}

local ktRankAmounts = {}

ktRankAmounts[1]  = 2000000
ktRankAmounts[2]  = 2000000
ktRankAmounts[3]  = 2000000
ktRankAmounts[4]  = 1500000
ktRankAmounts[5]  = 100000
ktRankAmounts[6]  = 100000
ktRankAmounts[7]  = 750000
ktRankAmounts[8]  = 0
ktRankAmounts[9]  = 0
ktRankAmounts[10] = 0

function GuildRankPermissionsBatchEdit:EnableRepairs()
  self:DoStuff(true)
end

function GuildRankPermissionsBatchEdit:DisableRepairs()
  self:DoStuff(false)
end

function GuildRankPermissionsBatchEdit:DoStuff(bEnable)
  for idx, guild in ipairs(GuildLib.GetGuilds()) do
    self:ActOnGuild(guild, bEnable)
  end
end

function GuildRankPermissionsBatchEdit:ActOnGuild(guild, bEnable)
  if guild:GetType() ~= GuildLib.GuildType_Guild then return end
  for idx, tRank in ipairs(guild:GetRanks()) do
    if tRank.bValid then self:SetRepairs(guild, bEnable, idx) end
  end
end

function GuildRankPermissionsBatchEdit:SetRepairs(guild, bEnable, nRank)
  if nRank < 5 then return end
  local monAmount = Money.new()
  if bEnable then
    monAmount:SetAmount(ktRankAmounts[nRank])
  end
  guild:SetRankBankRepairLimit(nRank, monAmount)
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
  Apollo.RegisterSlashCommand("enablerepairs", "EnableRepairs", self)
  Apollo.RegisterSlashCommand("disablerepairs", "DisableRepairs", self)
end

local GuildRankPermissionsBatchEditInst = GuildRankPermissionsBatchEdit:new()
GuildRankPermissionsBatchEditInst:Init()
