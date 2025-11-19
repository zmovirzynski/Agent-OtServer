function fileExists(filename)
  local file = io.open(filename, "r")
  if (file) then
    print("exist", filename)
    file:close()
    return true
  end
  print("don't exist", filename)
  return false
end
