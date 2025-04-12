-- Caputure output of a shell command
function os.capture(cmd, raw)
	local handle = assert(io.popen(cmd, "r"))
	local output = assert(handle:read("*a"))

	handle:close()

	if raw then
		return output
	end

	output = string.gsub(string.gsub(string.gsub(output, "^%s+", ""), "%s+$", ""), "[\n\r]+", " ")

	return output
end

function GetCommandPath(command, default_value)
	local which_python = os.capture("which " .. command, false)
	if vim.fn.executable(which_python) == 1 then
		return which_python
	else
		return default_value
	end
end
