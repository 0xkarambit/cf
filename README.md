
# cf

bash script to scrape input/output from codeforces contest challenges (WIP)
>meh this could have just been a gist, but this is what i decided to do instead of actually solving codeforces challenges

# demo

```console
karambit@0xKarambit:~/code/cf-tool$ ./cf https://codeforces.com/contest/1996/
fetching contest 1996
fetching problem A
fetching problem B
fetching problem C
fetching problem D
fetching problem E
fetching problem F
fetching problem G
karambit@0xKarambit:~/code/cf-tool$ tree 1996
1996
├── A.py
├── B.py
├── C.py
├── D.py
├── E.py
├── F.py
├── G.py
├── exp_output
│   ├── A
│   ├── B
│   ├── C
│   ├── D
│   ├── E
│   ├── F
│   └── G
├── input
│   ├── A
│   ├── B
│   ├── C
│   ├── D
│   ├── E
│   ├── F
│   └── G
└── output

3 directories, 21 files
```

# Config Structure

```
~/.config
    .codeforces
    template.py
```

# Dependencies

- [ pup ]( https://github.com/ericchiang/pup )

## Roadmap

- [ ] pull <contest_id> \[<problem_id>\]
- [ ] run \[<problem_id>\]
- [ ] submit
- [ ] loging
- [ ] submissions
- [ ] status 
- [ ] friends
