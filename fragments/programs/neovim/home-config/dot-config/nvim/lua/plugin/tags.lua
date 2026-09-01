local function GetCommonPath(path1, path2)
    local parts1 = vim.split(path1, "/", { plain = true, trimempty = true })
    local parts2 = vim.split(path2, "/", { plain = true, trimempty = true })

    local prefix = {}
    for i, val in ipairs(parts1) do
        if val == parts2[i] then
            table.insert(prefix, val)
        else
            break
        end
    end

    return "/" .. table.concat(prefix, "/")
end

local function GetGitTags(dir)
    local data = vim.fn.systemlist({'git', 'rev-parse', '--path-format=absolute', '--git-dir'})
    if vim.v.shell_error ~= 0 or #(data) == 0 then
        return nil
    end

    local rootdir = GetCommonPath(data[1]:gsub('%s*$', ''), vim.fs.abspath(dir))
    return rootdir .. '/.git/tags', rootdir
end

local function MakeTagsInGitRootDir()
    local tagfile, rootdir = GetGitTags(vim.uv.cwd())
    local excluded = [[-type d \( -path "*/.git" -o -path "*/build" \) -prune -false]]
    local pattern = [[\( -name "*.[ch]" -o -name "*.[ch]pp" -o -name "*.[ch]xx" -o -name "*.cc" -o -name "*.hh" \)]]
    local filelist = vim.fn.systemlist('find -L ' .. rootdir .. ' ' .. excluded .. ' -o ' .. pattern .. ' -print')
    pipe = assert(io.popen('ctags -L - --c++-kinds=+p --fields=+iaS --extras=+q -f ' .. tagfile, 'w'))
    for number,line in pairs(filelist) do
        pipe:write(line, '\n')
    end
    pipe:close()

    vim.print('Updated tags: ', tagfile)
end

local function setup()
    local mygroup = vim.api.nvim_create_augroup('GitTagsGroup', { clear = true })

    vim.api.nvim_create_autocmd('FileType', {
        group = mygroup,
        pattern = { 'cpp', 'hpp', 'cxx', 'hxx', 'c', 'h' },
        callback = function(args)
            local tagsfile, rootdir = GetGitTags(vim.fs.dirname(args.file))
            if tagsfile ~= nil then
                vim.cmd("setlocal tags+=" .. tagsfile)
            end
        end
    })

    vim.api.nvim_create_user_command('MakeGitTags', MakeTagsInGitRootDir, { nargs = 0 })
end

return { setup = setup }
