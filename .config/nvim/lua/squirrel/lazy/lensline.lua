return {
  "oribarilan/lensline.nvim",
  tag = "2.0.0", -- or: branch = 'release/2.x' for latest non-breaking updates
  event = "LspAttach",
  config = function()
    require("lensline").setup({
      profiles = {
        {
          name = "base",
          providers = {
            { name = "usages", enabled = true, include = { "refs", "defs", "impls" }, breakdown = true },
            { name = "diagnostics", enabled = true, min_level = "HINT" },
            { name = "complexity", enabled = true },
            { name = "last_author", enabled = true },
          },
          style = { render = "all", placement = "above" },
        },
      },
    })
  end,
}
