- no sparse arrays
- empty elements from unquoted parameter expansions are removed
  - pro: it avoids   rm $foo $bar $baz -> file not found '' x3
  - con: it actually destroys your data   params=($@)
- $( ) is always split because consistency
- no printf -v; an alternative is  print -rz -- word; IFS= read -rz var
  - in 5.3, printf has a -v option 
- procsub is not async like in bash or ksh:    : >(sleep 2)
  - of course with exec it's different because consistency
- echo $(echo $RANDOM) $(echo $RANDOM)
- emulate *shellname* doesn't actually work, for any shell
  - csh:
    - never works, completely different syntax, nor is documented.
  - ksh:
    - no ${ cmd;}
    - no {a,b}(glob)
    - no math library or user defined math functions without mathfunc module
    - no <#((expr)) or <#pattern..
    - no {a..b..c%fmt} and brace expansion is still zsh's (arguably better)
    - no static scope
    - pretty much a subset of ksh88
  - bash:
    - supported as an alias for sh but completely undocumented
      - emulate blastoise also works, anything starting with a b.
  - sh:
    - actually this works ok but it's stupid because posix
- much slower than ksh
- typeset/local/export/etc are builtin commands in zsh <= 5.0.8; so you can't do  local arr=(a b c)
- zcompile doesn't actually compile, it pretty much saves the preparsed form
- time can't time builtins and functions
- no namerefs
- the parameter _ is readonly in pre-5.x, so idiomatic use of it as a throw away variable isn't possible
- [[ cannot span across multiple lines in some cases in pre 5.3 zsh
- removing numerical array elements is done with  arr[2]=()
  - using the unset builtin will just make it an empty string
  - you unset associative array elements _with_ unset, because consistency
- variable expansion works in glob qualifiers/flags, not in parameter expansion flags
- without looking at the man page what does this do? unsetopt +o nonomatch
- nested expansions is great, until you read _git
- user defined math functions return the last expression evaluated in the current shell.
  - e.g: add() ( for arg; (( ret += $arg))); functions -M add; print $(( add(1,2,3,4) )) will return 4, since there are 4 arguments
- hard limit on math recursion set at compile time
- [ "(" = ")" ] is true, which is what posix says but it means you need x$var
  - [ ! -o ] is also true
