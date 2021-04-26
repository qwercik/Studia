$1 == "#replace" {
    regex = $2
    gsub(/\./, "\\.", regex)
    gsub(/\+/, "\\+", regex)
    gsub(/\*/, "\\*", regex)
    gsub(/\?/, "\\?", regex)
    gsub(/\^/, "\\^", regex)
    gsub(/\$/, "\\$", regex)
    gsub(/\(/, "\\(", regex)
    gsub(/\)/, "\\)", regex)
    gsub(/\[/, "\\[", regex)
    gsub(/\]/, "\\]", regex)
    gsub(/\{/, "\\{", regex)
    gsub(/\}/, "\\}", regex)
    gsub(/\|/, "\\|", regex)
    gsub(/\\/, "\\\\", regex)
    replacements[regex] = $3
}

$1 != "#replace" {
    line = $0
    for (replacement in replacements) {
        gsub(replacement, replacements[replacement], line)
    }

    print line
}
