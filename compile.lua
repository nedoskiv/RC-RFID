-- httpserver-compile.lua
-- Part of nodemcu-httpserver, compiles server code after upload.
-- Author: Marcos Kirsch

local compileAndRemoveIfNeeded = function(f)
   if file.exists(f) then
      print('Compiling:', f)
      node.compile(f)
      file.remove(f)
      collectgarbage()
   end
end

local serverFiles = {

   'obtn4.lua',
   'web5.lua',
   'web_tag.lua',
   'web_login.lua',
   'web_is_tag.lua',
   'web_control.lua',
   'web_file.lua',
   'web_request.lua',
   'RC522.lua',
   'functions.lua',
   'tag4.lua',
   'gen_list.lua',
   'gen_list_c.lua',
   'gen_export.lua',
   'deletetags.lua',
   'init1.lua',
   'reader6.lua'
}
for i, f in ipairs(serverFiles) do compileAndRemoveIfNeeded(f) end

compileAndRemoveIfNeeded = nil
serverFiles = nil
collectgarbage()

