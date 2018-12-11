" highlight trailing spaces
syntax match MailTrailSpaces /\s\+$/
" abuse the @mailLinks cluster to highlight trailing spaces in quotes
syntax cluster mailLinks add=MailTrailSpaces

hi link MailTrailSpaces User1
