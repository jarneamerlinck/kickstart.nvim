-- <nixCats>/lua/nixCatsUtils/lzUtils.lua
-- Check the nixCats.extra table for a matching key/value pair
-- This is to turn this value on if it's off
-- Expects a table with { key = "key.subkey", value = "this_val", }
M.in_extra = {
  spec_field = 'in_extra',
  set_lazy = false,
  modify = function(plugin)
    if type(plugin.in_extra) == 'table' then
      if
        (plugin.enabled == false)
        and (vim.g[ [[nixCats-special-rtp-entry-nixCats]] ] ~= nil)
        and (type(plugin.in_extra.key) == 'string')
        -- and (type(plugin.in_extra.value) == "string")
      then
        -- Do oneshot
        if type(plugin.in_extra.value) == 'string' then
          plugin.enabled = nixCats.extra(plugin.in_extra.key) == plugin.in_extra.value
        -- Loop if we are given a table
        elseif type(plugin.in_extra.value) == 'table' then
          for _, val_string in ipairs(plugin.in_extra.value) do
            plugin.enabled = nixCats.extra(plugin.in_extra.key) == val_string
            if plugin.enabled then
              break
            end
          end
        end
      end
    end
    return plugin
  end,
}
