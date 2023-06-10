function showInfo()
  -- fetch artist (title of show, like Naruto)
  local metadata = mp.get_property_native("metadata")
  local title = metadata["ARTIST"]

  -- fetch exact name of file (like Naruto EP49.mkv)
  local filename = mp.get_property("filename")
  -- fetch duration
  local duration = mp.get_property_number("duration")
  -- fetch height only (to be printed as 1080p, 720p, etc.)
  local height = mp.get_property_number("height")
  -- fetch codec (like hevc)
  local codec = mp.get_property("video-codec")

  -- format all strings concisely
  local final = string.format("\n%s\n%01dhrs %02dmins : %dp [%s]", filename, duration/3600, duration%3600/60, height, string.sub(codec, 1, 4))

  -- print all info
  mp.commandv("show-text", mp.command_native({"expand-text", "${osd-ass-cc/0}{\\an1\\fs14\\cDBE519\\alpha&H55&{\\b1}"..title.."{\\b0}${osd-ass-cc/1}".. final}), "5000")
end

-- show info when file loads
mp.register_event("file-loaded", showInfo)

-- For debugging - use `n` to show title
-- mp.add_key_binding("n", "showTitle", showTitle)
