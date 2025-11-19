-- local rod ids
local oldRod = 3506

-- bait ids
local seaweed = 3512
local worm = 3517

const = {
  rods = { oldRod },
  baits = { seaweed, worm },

  waterIds = {
    [231] = true,
    [232] = true,
    [234] = true,
    [236] = true,
  },

  allowBaitsOnRod = {
    [worm] = {
      [oldRod] = true,

      fishingLevel = 1
    },

    [seaweed] = {
      [oldRod] = true,

      fishingLevel = 25
    },
  },

  fishItem = 3500,
  fishOnTheHookItem = 3501,
  fishingTimeout = 2000,
  baitStorage = 19500,
  maxDelayToFish = 8,

  fishingOutfits = {
    [154] = 157,
    [155] = 156,
  },

  fishings = {
    default = {
      { name = "magikarp" },
    },

    [worm] = {
      { name = "poliwag" },
      { name = "goldeen" },
      { name = "horsea" },
    },

    [seaweed] = {
      { name = "tentacool" },
      { name = "staryu" },
      { name = "krabby" },
      { name = "shellder" },
    },
  }
}
