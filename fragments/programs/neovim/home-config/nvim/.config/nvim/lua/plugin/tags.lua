local function MakeTagsInGitRootDir()
    local pipe = assert(io.popen('git rev-parse --show-toplevel', 'r'))
    local rootdir = pipe:read('*a'):gsub('%s*$', '')
    pipe:close()

    local tagfile = rootdir .. '/.git/tags'
    local excluded = [[-type d \( -path "*/.git" -o -path "*/build" \) -prune]]
    local pattern = [[\( -name "*.[ch]" -o -name "*.[ch]pp" -o -name "*.[ch]xx" -o -name "*.cc" -o -name "*.hh" \)]]
    local filelist = vm.fn.systemlist('find ' .. rootdir .. ' ' .. excluded .. ' -o ' .. pattern)
    pipe = assert(io.popen('ctags -L - --c++-kinds=+p --fields=+iaS --extras=+q -f ' .. tagfile, 'w'))
    for line in filelist do
        pipe:write(line, '\n')
    end
    pipe:close()

    print('Updated tags: ', tagfile)
end

local function GetGitTags()
    local pipe = io.popen('git rev-parse --show-toplevel', 'r')
    if not pipe then
        return
    end

    local tagfile = pipe:read() .. '/.git/tags'
    pipe:close()

    return tagfile
end

local function setup()
    local mygroup = vim.api.nvim_create_augroup('GitTagsGroup', { clear = true })

    vim.api.nvim_create_autocmd('FileType', {
        group = mygroup,
        pattern = { 'cpp', 'hpp', 'cxx', 'hxx', 'c', 'h' },
        callback = function(args)
            vim.cmd("setlocal tags+=" .. GetGitTags())
        end
    })

    vim.api.nvim_create_user_command('MakeGitTags', MakeTagsInGitRootDir, { nargs = 0 })
end

return { setup = setup }
