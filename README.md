
-----------------
##observer_cli
[![Build Status](https://travis-ci.org/zhongwencool/observer_cli.svg?branch=master)](https://travis-ci.org/zhongwencool/observer_cli)

Visualize Erlang Nodes On The Command Line By Using [recon](https://github.com/ferd/recon).

##Goal
Minimal consumption.

Just look like [observer](http://www.erlang.org/doc/apps/observer/observer_ug.html) in shell, 

but you might think that one day observer_cli more convenient than observer.

------------------
###Try Try Try...

```bash
$ make && make shell   
1> observer_cli:start().

```
![Top](http://7q5a9k.com1.z0.glb.clouddn.com/observer_cli_home_11_11.jpg)

```erlang
2> observer_cli:system().
```
![System](http://7q5a9k.com1.z0.glb.clouddn.com/observer_cli_ets_11_11.jpg)

```erlang
2> observer_cli:allocator().
```
![Allocator](http://7q5a9k.com1.z0.glb.clouddn.com/observer_cli_allocator_11_11.jpg)

```erlang
2> observer_cli:help().
```
![Help](http://7q5a9k.com1.z0.glb.clouddn.com/observer_cli_help_11_11.jpg)



----------------
###Command

```erlang
> observer_cli:start().%% default refresh interval is 2000
> observer_cli:start(Interval).
> observer_cli:start(Node, Cookie, Interval).
> observer_cli:start(Node, Interval).
```

-------------------
###TODO
- [x] observer_cli:start(). Processes Memory, Binary, Total Heap Size, Reductions Top.     
- [x] observer_cli:system(). include System and Architecture, CPU's and Threads metrics  in observer's system 
- [x] observer_cli:allocator(). Memory Allocators: std, ll, eheap, ets,fix, binary, driver.
- [x] observer_cli:table(). include all metrics ets in observer's Table Viewer.
- [x] observer_cli:help()
- [x] remote node support
- [ ] ~~mneisa table info~~ You should use mnesia:info or mnesia:system_info() or mnesia:system_info(all).
- [ ] ~~Draw all appication’s relations.~~
- [ ] ~~Trace Overview.~~ You should use recon_trace.


--------------------
###License
See the [LICENSE](https://github.com/zhongwencool/observer_cli/blob/master/LICENSE) file for license rights and limitations (MIT).
