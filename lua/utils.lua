local M = {}

M.terminal_buf = nil
M.terminal_floating_win = nil
M.terminal_bottom_win = nil
M.prev_win = nil

function M.resize_fixed()
	local neotree_winid = vim.fn.bufwinid("neo-tree filesystem")
	if neotree_winid ~= -1 then
		vim.api.nvim_win_set_width(neotree_winid, 30)
	end
	if M.terminal_bottom_win and vim.api.nvim_win_is_valid(M.terminal_bottom_win) then
		vim.api.nvim_win_set_height(M.terminal_bottom_win, 15)
	end
end

local function terminal_create_buf()
	local buf_name = "custom-terminal"
	
	local buf = M.terminal_buf
	if not buf or not vim.api.nvim_buf_is_valid(buf) then
		buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_name(buf, buf_name)
		M.terminal_buf = buf
		vim.keymap.set({ 't', 'n' }, '<Esc>', function()
			local win = M.terminal_floating_win
			if win and vim.api.nvim_win_is_valid(win) and vim.api.nvim_get_current_win() == win then
				vim.api.nvim_win_close(win, false)
			end
			vim.schedule(function()
				vim.cmd("stopinsert")
			end)
		end, { buffer = buf, silent = true })
	end
	return buf
end

local function is_job_running(job_id)
	if not job_id then
		return false
	end
	
	local status = vim.fn.jobwait({job_id}, 0)[1]
	return status == -1
end

function M.exec_command(cmd)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_option(buf, 'modifiable', false)

	local width = vim.o.columns
	local height = vim.o.lines
	
	local win_width = math.floor(width * 0.8)
	local win_height = math.floor(height * 0.8)

	local row = math.floor((height - win_height) / 2)
	local col = math.floor((width - win_width) / 2)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded"
	})
	local function close_and_delete()
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
		if vim.api.nvim_buf_is_valid(buf) then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
	local job_id = vim.fn.termopen(cmd, {
		cwd = vim.fn.getcwd(),
		on_exit = function(_, exit_code, _)
			if exit_code == 0 then
				vim.defer_fn(close_and_delete, 500)
				vim.api.nvim_win_set_option(win, 'winhl', 'FloatBorder:DiagnosticOk')
			else
				vim.notify("Build failed (exit code: " .. exit_code .. ")", vim.log.levels.ERROR)
				vim.keymap.set('n', '<Esc>', close_and_delete, { buffer = buf, silent = true })
				vim.api.nvim_win_set_option(win, 'winhl', 'FloatBorder:DiagnosticError')
			end
		end
	})
	vim.api.nvim_win_set_option(win, 'winhl', 'FloatBorder:DiagnosticWarn')
	vim.keymap.set('n', '<C-c>', function()
		if is_job_running(job_id) then
			vim.fn.chansend(job_id, '\x03')
			vim.defer_fn(function()
				vim.fn.jobstop(job_id)
			end, 5000)
		end
	end, {buffer = buf, silent = true, noremap = true})
	vim.api.nvim_buf_attach(buf, false, {
		on_lines = function()
			vim.schedule(function()
				if vim.api.nvim_win_is_valid(win) then
					vim.api.nvim_win_set_cursor(win, {vim.api.nvim_buf_line_count(buf), 0})
				end
			end)
		end
	})
end

function M.toggle_terminal()
	local buf = terminal_create_buf()

	if not M.terminal_floating_win or not vim.api.nvim_win_is_valid(M.terminal_floating_win) then
		local width = vim.o.columns
		local height = vim.o.lines
		
		local win_width = math.floor(width * 0.8)
		local win_height = math.floor(height * 0.8)

		local row = math.floor((height - win_height) / 2)
		local col = math.floor((width - win_width) / 2)

		M.terminal_floating_win = vim.api.nvim_open_win(buf, true, {
			relative = "editor",
			width = win_width,
			height = win_height,
			row = row,
			col = col,
			style = "minimal",
			border = "rounded"
		})
		if vim.bo[buf].buftype ~= "terminal" then
			vim.fn.termopen("zsh")
		end
		vim.cmd("startinsert")
	else
		if vim.api.nvim_get_current_win() == M.terminal_floating_win then
			vim.api.nvim_win_close(M.terminal_floating_win, false)
			M.terminal_floating_win = nil
		else
			vim.api.nvim_set_current_win(M.terminal_floating_win)
			vim.cmd("startinsert")
		end
	end
end

function M.toggle_terminal_buf()
	local buf = terminal_create_buf()
	
	if not M.terminal_bottom_win or not vim.api.nvim_win_is_valid(M.terminal_bottom_win) then
		M.prev_win = vim.api.nvim_get_current_win()
		vim.cmd("botright split")
		M.terminal_bottom_win = vim.api.nvim_get_current_win()
		vim.api.nvim_win_set_buf(M.terminal_bottom_win, buf)
		M.resize_fixed()
		if vim.bo[buf].buftype ~= "terminal" then
			vim.fn.termopen("zsh")
		end
		vim.cmd("startinsert")
	else
		if vim.api.nvim_get_current_win() == M.terminal_bottom_win then
			vim.api.nvim_win_close(M.terminal_bottom_win, false)
			M.terminal_bottom_win = nil
			vim.api.nvim_set_current_win(M.prev_win)
		else
			vim.api.nvim_set_current_win(M.terminal_bottom_win)
			vim.cmd("startinsert")
		end
	end
end

return M
