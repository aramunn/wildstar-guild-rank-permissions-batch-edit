function GuildRankPermissionsBatchEdit:SetRepairs()
  for idx, guild in pairs(GuildLib.GetGuilds()) do
    
  end
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
  Apollo.RegisterSlashCommand("setrepairs", "SetRepairs", self)
end

local GuildRankPermissionsBatchEditInst = GuildRankPermissionsBatchEdit:new()
GuildRankPermissionsBatchEditInst:Init()
