require("smear_cursor").setup({
	-- General configuration -------------------------------------------------------

	-- Smear cursor when switching buffers or windows
	smear_between_buffers = true,

	-- Smear cursor when moving within line or to neighbor lines
	-- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
	smear_between_neighbor_lines = true,

	-- Only smear cursor when moving at least these distances
	min_horizontal_distance_smear = 0,
	min_vertical_distance_smear = 0,

	-- Toggles for directions
	smear_horizontally = true,
	smear_vertically = true,
	smear_diagonally = true, -- Neither horizontal nor vertical

	-- Smear cursor when entering or leaving command line mode
	smear_to_cmd = true,

	-- Draw the smear in buffer space instead of screen space when scrolling
	scroll_buffer_space = true,

	-- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
	-- Smears will blend better on all backgrounds.
	legacy_computing_symbols_support = false,

	-- Set to `true` if your cursor is a vertical bar in normal mode.
	vertical_bar_cursor = false,

	-- Smear cursor in insert mode.
	-- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
	smear_insert_mode = true,

	-- Set to `true` if your cursor is a vertical bar in insert mode.
	vertical_bar_cursor_insert_mode = true,

	-- Smear cursor in replace mode.
	smear_replace_mode = false,

	-- Smear cursor in terminal mode.
	-- If the smear goes to the wrong location when enabled, try increasing `delay_after_key`.
	smear_terminal_mode = false,

	-- Set to `true` if your cursor is a horizontal bar in replace mode.
	horizontal_bar_cursor_replace_mode = true,

	-- Set to `false` to allow the smear to overlap the target character, hiding it until the animation is over.
	never_draw_over_target = true,

	-- Attempt to hide the real cursor by drawing a character below it.
	-- Can be useful when not using `termguicolors`
	hide_target_hack = false,

	-- Number of windows that stay open for rendering.
	max_kept_windows = 50,

	-- Adjust to have the smear appear above or below other floating windows
	windows_zindex = 300,

	-- List of filetypes where the plugin is disabled.
	filetypes_disabled = {},

	-- Sets animation framerate
	time_interval = 17, -- milliseconds

	-- Amount of time the cursor has to stay still before triggering animation.
	-- Useful if the target changes and rapidly comes back to its original position.
	-- E.g. when hitting a keybinding that triggers CmdlineEnter.
	-- Increase if the cursor makes weird jumps when hitting keys.
	delay_event_to_smear = 1, -- milliseconds

	-- Delay for `vim.on_key` to avoid redundancy with vim events triggers.
	delay_after_key = 5, -- milliseconds

	-- Smear configuration ---------------------------------------------------------

	-- How fast the smear's head moves towards the target.
	-- 0: no movement, 1: instantaneous
	stiffness = 0.6,

	-- How fast the smear's tail moves towards the target.
	-- 0: no movement, 1: instantaneous
	trailing_stiffness = 0.4,

	-- Controls if middle points are closer to the head or the tail.
	-- < 1: closer to the tail, > 1: closer to the head
	trailing_exponent = 2,

	-- How much the smear slows down when getting close to the target.
	-- < 0: less slowdown, > 0: more slowdown. Keep small, e.g. [-0.2, 0.2]
	slowdown_exponent = 0,

	-- Stop animating when the smear's tail is within this distance (in characters) from the target.
	distance_stop_animating = 0.1,

	-- Set of parameters for insert mode
	stiffness_insert_mode = 0.4,
	trailing_stiffness_insert_mode = 0.4,
	trailing_exponent_insert_mode = 1,
	distance_stop_animating_vertical_bar = 0.875, -- Can be decreased (e.g. to 0.1) if using legacy computing symbols

	-- When to switch between rasterization methods
	max_slope_horizontal = 0.5,
	min_slope_vertical = 2,

	color_levels = 16, -- Minimum 1, don't set manually if using cterm_cursor_colors
	gamma = 2.2, -- For color blending
	max_shade_no_matrix = 0.75, -- 0: more overhangs, 1: more matrices
	matrix_pixel_threshold = 0.7, -- 0: all pixels, 1: no pixel
	matrix_pixel_threshold_vertical_bar = 0.3, -- 0: all pixels, 1: no pixel
	matrix_pixel_min_factor = 0.5, -- 0: all pixels, 1: no pixel
	volume_reduction_exponent = 0.3, -- 0: no reduction, 1: full reduction
	minimum_volume_factor = 0.7, -- 0: no limit, 1: no reduction
	max_length = 25, -- Maximum smear length
	max_length_insert_mode = 1,

	-- For debugging ---------------------------------------------------------------

	logging_level = vim.log.levels.INFO,
	-- Set trailing_stiffness to 0 for debugging
})
