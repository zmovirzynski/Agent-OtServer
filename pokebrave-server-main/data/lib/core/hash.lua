g_hash = { }

g_hash.positionToHash = function(position)
  local hash = 0
  hash = (hash * 31) + position.x
  hash = (hash * 31) + position.y
  hash = (hash * 31) + position.z
  return string.format("%x", hash)
end
