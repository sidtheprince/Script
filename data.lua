
-- displays a table's values, functions, and other contents
function get_properties(class)
    if class == nil then
        print("No data was entered or the class does not exist.")
    end
    for s, i in pairs(class) do
        if type(i) == "function" then
            print(s.."() =", i,"type = "..type(i))

         elseif type(i) ~= "function" then
            print(s.." =", i,"type = "..type(i))
        end
    end
end
-----------------
XML = "XML"
TEXT = "TEXT"
-----------------
data_folder = nil
-----------------
 function folder() 
  data_folder = "data_folder/"
  os.execute("mkdir data_folder")
 end
----------------- 
files_stored = 0;
----------------- 
function save_as_text(class) 
 folder() -- create a folder
 files_stored = files_stored + 1; -- number of files stored
 
  filename = string.format("%s%s", data_folder, string.lower(class.name)..".txt")

 if not io.open(filename, "w") then
  file = assert(io.open(filename, "w")); -- create text file in write mode
 end
 
 for s, i in pairs(class) do -- s=variable, i= value
  file = assert(io.open(filename, "a+")); -- attach new data, save data
  file:write(s.." = ", tostring(i),"\n");  --  write data in file
  file:close(filename);
 end
end
-----------------
function read_from_file(filename)
  -- READ FROM THE FILE
 file = assert(io.open(filename, "rb"), "Unable to load file.")
 print(file:read("*all"))
 
 file:close(filename)
end
-----------------
function get_bytes_from_file(filename)
 file = assert(io.open(filename, "rb"), "Unable to load file.") -- open the file
 local current = file:seek() -- current pos 
 local size = file:seek("end")
 file:seek("set", current)  
 
 return size
end
-----------------
function get_line_count(filename)
 file = assert(io.open(filename, "rb"), "Unable to load file.") -- open the file
 local BUFSIZE = 2^13
 local lc = 0
 while true do
  local lines, rest = file:read(BUFSIZE, "*line")
  if not lines then break end
  -- count newlines in the chunk
  _,t = string.gsub(lines, "\n", "\n")
  lc = lc + t
 end 
  return lc
end
-----------------
function get_word_count(filename)
 file = assert(io.open(filename, "rb"), "Unable to load file.") -- open the file
 local BUFSIZE = 2^13
 local wc = 0
 while true do
  local lines, rest = file:read(BUFSIZE, "*line")
  if not lines then break end
    -- count words in the chunk
  local _,t = string.gsub(lines, "%S+", "")
  wc = wc + t
 end
  return wc
end
-----------------
function file_info(filename)
 print("file contents:")
 read_from_file(filename)
 print("lines:", get_line_count(filename))
 print("word:", get_word_count(filename))
 print("bytes:",get_bytes_from_file(filename) )
end