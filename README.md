yaml-vim
========

YAML syntax/indent plugin for Vim.

By this plugin introducing, you can write as the indent style shown below:

```YAML
---
# The block sequences with the block mappings in the same line:
- name: create file
  command: >
    creates=/path/to/file
    touch /path/to/file

# Not exists spaces after the block sequences symbol:
-
  name: install packages
  apt: name={{item}} state=present
  with_items:
    - package1
    - package2
```

```YAML
---
# The block scalar headers on the top domain:
>
  A value of the block scalar.
```

And added the syntax highlighting listed below:

* The block scalar headers: `>` and `|`
* Not exists spaces after the block sequences symbol: `-`

## Usage

All you have to do is to write the loading settings of this plugin to the `.vimrc`.

```VimL
NeoBundle 'mrk21/yaml-vim'
```
