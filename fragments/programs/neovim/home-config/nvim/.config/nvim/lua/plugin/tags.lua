local function MakeTagsInGitRootDir()
    local pipe = assert(io.popen('git rev-parse --show-toplevel', 'r'))
    local rootdir = pipe:read('*a'):gsub('%s*$', '')
    pipe:close()

    local tagfile = rootdir .. '/.git/tags'
    local excluded = [[-type d \( -path "*/.git" -o -path "*/build" \) -prune -false]]
    local pattern = [[\( -name "*.[ch]" -o -name "*.[ch]pp" -o -name "*.[ch]xx" -o -name "*.cc" -o -name "*.hh" \)]]
    local filelist = vim.fn.systemlist('find -L ' .. rootdir .. ' ' .. excluded .. ' -o ' .. pattern .. ' -print')
    pipe = assert(io.popen('ctags -L - --c++-kinds=+p --fields=+iaS --extras=+q -f ' .. tagfile, 'w'))
    for number,line in pairs(filelist) do
        pipe:write(line, '\n')
    end
    pipe:close()

    print('Updated tags: ', tagfile)
end

local function GetGitTags(dir)
    local data = vim.fn.systemlist({'git', 'rev-parse', '--show-toplevel'})
    return data[1]:gsub('%s*$', '') .. '/.git/tags'
end

local function setup()
    local mygroup = vim.api.nvim_create_augroup('GitTagsGroup', { clear = true })

    vim.api.nvim_create_autocmd('FileType', {
        group = mygroup,
        pattern = { 'cpp', 'hpp', 'cxx', 'hxx', 'c', 'h' },
        callback = function(args)
            vim.cmd("setlocal tags+=" .. GetGitTags(vim.fs.dirname(args.file)))
        end
    })

    vim.api.nvim_create_user_command('MakeGitTags', MakeTagsInGitRootDir, { nargs = 0 })
end

return { setup = setup }
