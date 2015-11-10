%%% @author zhongwen <zhongwencool@gmail.com>
-module(observer_cli_help).


%% API
-export([start/0]).

-define(TOP_MIN_REFLUSH_INTERVAL, 5000).
-define(BROAD, 133).

start() ->
  Pid = spawn_link(fun() ->
    observer_cli_lib:clear_screen(),
    draw_menu(),
    draw_help(),
    loop(?TOP_MIN_REFLUSH_INTERVAL) end),
  waiting(Pid).

waiting(Pid) ->
  Input = io:get_line(""),
  case  Input of
    "q\n" -> erlang:send(Pid, quit);
    "o\n" ->
      erlang:send(Pid, quit),
      observer_cli:start();
    "e\n" ->
      erlang:send(Pid, quit),
      observer_cli_system:start();
    "a\n" ->
      erlang:send(Pid, quit),
      observer_cli_allocator:start();
    _ -> waiting(Pid)
  end.

loop(Interval) ->
  observer_cli_lib:move_cursor_to_top_line(),
  draw_menu(),
  erlang:send_after(Interval, self(), refresh),
  receive
    refresh -> loop(Interval);
    quit -> quit
  end.

draw_help() ->
  io:format("|Due to bytes in and out of the node, number of garbage colelctor runs, words of memory that were garbage collected, and the global |~n"),
  io:format("|reductions count for the node never stop increasing, \e[48;2;80;80;80mo(OBSERVER)\e[0m's \"IO input/out\", \"Gc Count\", \"Gc Words Reclaimed\"                |~n"),
  io:format("|only represents the increments between two refresh interval. The total bytes in and out in \e[48;2;80;80;80me(Ets)\e[0m.                                 |~n"),

  io:format("|\e[42mAbout o(OBSERVER)'s Interval\e[49m                                                                                                       |~n"),
  io:format("|If the refresh interval of \e[48;2;80;80;80mo(OBSERVER)\e[0m's is 2000ms, the 2000ms will be divided into two sections:                                  |~n"),
  io:format("|1. collect IO information it take (2000 div 2) = 1000 ms by using recon:node_stats_list/2;                                         |~n"),
  io:format("|2. the time of collecting process info deps on which mode you choose:                                                              |~n"),
  io:format("| 2.1 if you use r mode's(recon:proc_count/2), it will be  very fast, the time can be ignored,                                      |~n"),
  io:format("| 2.2 if you use rr mode's(recon:proc_window/3), it will took (2 * 1000 - 1000 div 2) = 3000 ms.                                    |~n"),

  io:format("|\e[42mAbout o(OBSERVER)'s Command\e[49m                                                                                                        |~n"),
  io:format("|\e[48;2;80;80;80mr:5000\e[0m will switch mode to reduction(proc_count) and set the refresh  time to 5000ms                                               |~n"),
  io:format("|\e[48;2;80;80;80mrr:5000\e[0m will switch mode to reduction(proc_window) and set the refresh time to 5000ms                                              |~n"),
  io:format("|\e[42mReference\e[49m                                                                                                                          |~n"),
  io:format("|More infomation about recon:proc_count/2 and recon:proc_window/3 refer to https://github.com/ferd/recon/blob/master/src/recon.erl  |~n"),
  io:format("|Any issue please visit: https://github.com/zhongwencool/observer_cli/issues                                                        |~n").

draw_menu() ->
  [Home, Ets, Alloc, Help]  = observer_cli_lib:get_menu_title(help),
  Title = lists:flatten(["|", Home, "|", Ets, "|", Alloc, "| ", Help, "|"]),
  UpTime = observer_cli_lib:green(" Uptime:" ++ observer_cli_lib:uptime()) ++ "|",
  Space = lists:duplicate(?BROAD - erlang:length(Title)    - erlang:length(UpTime)+ 90, " "),
  io:format("~s~n", [Title ++ Space ++ UpTime]).