vim.fn.sign_define('DapBreakpoint', {
	text = '🔴',
	texthl = 'DapBreakpoint',
	linehl = '',
	numhl = ''
})

vim.fn.sign_define('DapBreakpointCondition', {
	text = '🟡',
	texthl = 'DapBreakpoint',
	linehl = '',
	numhl = ''
})

vim.fn.sign_define('DapBreakpointRejected', {
	text = '🚫',
	texthl = 'DapBreakpoint',
	linehl = '',
	numhl = ''
})

vim.fn.sign_define('DapStopped', {
	text = '▶️',
	texthl = 'DapStopped',
	linehl = 'debugPC',
	numhl = ''
})

vim.fn.sign_define('DapLogPoint', {
	text = '📝',
	texthl = 'DapLogPoint',
	linehl = '',
	numhl = ''
})
