# YankSSH.vim

This plugin is used to copy text from a remote vim session over SSH using the
vim copying commands, and have that text be accessible by the host computer's
clipboard.

It also allows the reverse.

## Dependencies

This plugin depends on:
* `xsel` being installed on the remote system, and
* The SSH session must have X11 forwarding enabled (ie, using the `-X` option
  with your SSH command).

## Installation


Use your favourite plug-in manager and add some mappings like the below example:

```vim
vmap y        <Plug>yankmatches#visualYank
map <leader>p <Plug>yankmatches#paste
```

As you may be able to tell from the above mappings, there is currently only a
mapping available for visual mode.
