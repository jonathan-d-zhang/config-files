function nvim --description 'make nvim open a file selected with fzf on startup with no arguments'
    if count $argv > /dev/null;
        /usr/bin/nvim $argv;
    else;
        set file (/usr/bin/fzf)
        if test -n "$file";
            /usr/bin/nvim $file;
        else;
            return 1;
        end
    end
end
