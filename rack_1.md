
1、[rack的规范](http://www.rubydoc.info/github/rack/rack/master/file/SPEC)
2、[github地址](https://github.com/rack/rack)


```
requitr

# env must be a hash
def p_rack_env(env)
    env.map{ |key, value| "#{key} - #{value}" }.sort.join('<br>')
end
```