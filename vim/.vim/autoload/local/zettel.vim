func! local#zettel#edit(...)

  " build the file name
  let l:sep = ''
  if len(a:000) > 0
    let l:sep = '-'
  endif
  let l:fname = expand('~/vimwiki/') . 'zett' . l:sep . join(a:000, '-') . l:sep . strftime("%Y-%m-%d-%H%M") . '.md'

  " build title-case title
  let l:tctitle = substitute(join(a:000, ' '), '\(^.\)', '\u&', '')

  " build frontmatter
  let l:frontmatter = "---\ntitle: " . tctitle  . "\ndate: " . strftime("%Y-%m-%d") . "\nkeywords: \n---\n"

  " write frontmatter to new file
  0put = l:frontmatter
  exec 'w ' . l:fname

  " edit the new file
  exec 'e ' . l:fname
endfunc
