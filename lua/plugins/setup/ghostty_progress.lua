local group = vim.api.nvim_create_augroup("user-ghostty-progress", { clear = true })
local is_ghostty = (vim.env.TERM_PROGRAM or ""):lower() == "ghostty"

local function send_ghostty_progress(state, percent)
  if not is_ghostty then
    return
  end

  if not vim.api.nvim_ui_send then
    return
  end

  local seq
  if percent == nil then
    seq = string.format("\27]9;4;%d\7", state)
  else
    local pct = math.max(0, math.min(100, math.floor(percent + 0.5)))
    seq = string.format("\27]9;4;%d;%d\7", state, pct)
  end

  vim.api.nvim_ui_send(seq)
end

vim.api.nvim_create_autocmd("LspProgress", {
  group = group,
  callback = function(args)
    local data = args.data
    if not data or not data.params or not data.params.value then
      return
    end

    local value = data.params.value
    local message = value.message or "LSP progress"
    if #message > 80 then
      message = message:sub(1, 77) .. "..."
    end

    vim.api.nvim_echo({ { message } }, false, {
      id = "lsp-progress",
      kind = "progress",
      source = "lsp",
      title = value.title or "LSP",
      status = value.kind == "end" and "success" or "running",
      percent = value.percentage,
    })

    if value.kind == "end" then
      send_ghostty_progress(0)
      return
    end

    if value.percentage ~= nil then
      send_ghostty_progress(1, value.percentage)
    else
      send_ghostty_progress(3)
    end
  end,
})
