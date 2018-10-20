function nocase (s)
    s = string.gsub(s, "%a", function (c) return string.format("[%s%s]", string.lower(c), string.upper(c)) end)
    return s
end