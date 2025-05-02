local M = {}

-- Get a date from X days ago in ISO format
function M.get_date_days_ago(days)
  -- Get current timestamp
  local current = os.time()
  -- Subtract days in seconds
  local past = current - (days * 24 * 60 * 60)
  -- Format as ISO date
  return os.date("%Y-%m-%d", past)
end

-- Checkout plugins to a specific date
function M.revert_plugins_to_date(date_str)
  -- Get list of all plugins
  local plugins = require("lazy.core.config").plugins
  local plugin_list = {}

  -- Convert plugins table to list
  for name, _ in pairs(plugins) do
    table.insert(plugin_list, name)
  end

  -- Temporarily disable change detection and checker
  local original_change_detection = require("lazy.core.config").options.change_detection.enabled
  local original_checker = require("lazy.core.config").options.checker.enabled
  require("lazy.core.config").options.change_detection.enabled = false
  require("lazy.core.config").options.checker.enabled = false

  -- Process each plugin
  for _, plugin_name in ipairs(plugin_list) do
    local plugin = plugins[plugin_name]

    -- Skip if not a git repo
    if not plugin or not plugin.dir then
      goto continue
    end

    -- Execute git command to get commit hash from date
    local cmd = string.format(
      "cd %s && git log --before=%s -n 1 --format=format:%%H",
      vim.fn.shellescape(plugin.dir),
      vim.fn.shellescape(date_str)
    )

    local commit_hash = vim.fn.system(cmd):gsub("%s+", "")

    -- If we found a commit, checkout to it
    if commit_hash and #commit_hash > 0 then
      local checkout_cmd = string.format(
        "cd %s && git checkout %s --quiet",
        vim.fn.shellescape(plugin.dir),
        commit_hash
      )
      vim.fn.system(checkout_cmd)
      print(string.format("Reverted %s to commit %s", plugin_name, commit_hash:sub(1, 8)))
    else
      print(string.format("No commit found for %s before %s", plugin_name, date_str))
    end

    ::continue::
  end

  -- Restore original settings
  require("lazy.core.config").options.change_detection.enabled = original_change_detection
  require("lazy.core.config").options.checker.enabled = original_checker

  print("All plugins reverted to state before " .. date_str)
  print("You may need to restart Neovim for changes to take full effect")
end

-- Revert all plugins to X days ago
function M.revert_plugins_days_ago(days)
  local date_str = M.get_date_days_ago(days)
  print("Reverting all plugins to state before " .. date_str)
  M.revert_plugins_to_date(date_str)
end

-- Create command to revert plugins
vim.api.nvim_create_user_command("LazyRevertDays", function(opts)
  local days = tonumber(opts.args) or 21  -- Default to 3 weeks
  M.revert_plugins_days_ago(days)
end, { nargs = "?" })

vim.api.nvim_create_user_command("LazyRevertDate", function(opts)
  M.revert_plugins_to_date(opts.args)
end, { nargs = 1 })

return M
