" Maintainer: Steven Hall

" This plugin depends on xsel being installed
if !executable('xsel')
  echoe 'Failed to load yankssh.vim. [xsel] is not installed.'
  finish
endif

" If already loaded, don't load again
if exists('g:yankssh#loaded')
  finish
endif
let g:yankmatches#loaded = 1


function! CustomCopy()
  " NOTE: The only reason for the substitute is because shellescape escapes
  " newlines, so you end up with backslashes at the end of every line. This is
  " a bug in our version of vim which was patched in version 8.0.0625
  " REF: https://github.com/vim/vim/issues/1590)
  " Therefore, please excuse the massive number of backslashed characters
  " here.

  " y => completes the standard copy
  " :call system() => Execute a bash command
  " echo -n => Don't print the extra newline that the bash echo gives
  " substitute => vimscript function that we are using to remove trailing
  "               backslashes
  " shellescape => To escape any characters in our register that bash may not
  "                like
  " @0 => A default copy in vim saves the copied text into your default
  "       register (usually the double quote, or + or *), but also saves it in
  "       register 0. This is common for everyone which is why we use it
  " \\\\\\n => matches a backslash followed by newline... The regex is
  "            actually \\\n, but vim also needs the backslashes escaped...
  "            hence, 6 backslashes, yikes...
  " xsel -i -b => takes what was in register 0 and give it to xsel.
  return "y:call system('echo -n ' . substitute(shellescape(@0), \'\\\\\\n\', \'\\n\', \'g\') . ' | xsel -i -b')\<cr>"
endfunction

function! CustomPaste()
  " Get data from xsel (host clipboard)
  return ":r!xsel\<cr>"
endfunction

vnoremap <silent> <expr> <Plug>yankmatches#visualYank CustomCopy()
noremap  <silent> <expr> <Plug>yankmatches#paste      CustomPaste()
