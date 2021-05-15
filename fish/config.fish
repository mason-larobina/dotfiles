set -U fish_greeting
set -gx EDITOR nvim

function ll
    command ls -lh
end

function lt
    command ls -lht
end

function vim
    command nvim $argv
end
