describe("special.files", function()
  it("can be required", function()
    local special_files = require('special.files')
  end)

  it("should load default opts when input opts is empty", function()
    local special_files = require('special.files')

    local expected = {
      src = vim.fn.stdpath("data") .. "/jonathans_special_files",
      cwd_to_path = true,
      effect = function(path)
        vim.cmd("tabedit " .. path)
      end
    }

    local sut = special_files.opts_resolver()

    assert.are.same(sut, expected)
  end)
end)
