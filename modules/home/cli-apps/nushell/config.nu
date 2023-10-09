
# https://www.nushell.sh/cookbook/external_completers.html#fish-completer
let external_completer = {|spans|
    # if the current command is an alias, get it's expansion
    let expanded_alias = (scope aliases | where name == $spans.0 | get -i 0 | get -i expansion)

    # overwrite
    let spans = (if $expanded_alias != null  {
        # put the first word of the expanded alias first in the span
        $spans | skip 1 | prepend ($expanded_alias | split words)
    } else { $spans })

    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | $"value(char tab)description(char newline)" + $in
    | from tsv --flexible --no-infer
}

def "history fzf" [] {
  commandline (
    history
      | each { |it| $it.command }
      | uniq
      | reverse
      | str join (char -i 0)
      | fzf --read0 --layout=reverse --height=40% -q (commandline)
      | decode utf-8
      | str trim
  )
}

$env.config = {
  completions: {
    algorithm: "fuzzy"
    external: {
      enable: true,
      completer: $external_completer
    }
  }
  cd: { abbreviations: true }
}
