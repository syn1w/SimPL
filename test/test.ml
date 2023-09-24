open OUnit2
open Interp.Main

let self (x : string) = x

let make_i n i s =
  n >:: (fun _ -> assert_equal (string_of_int i) (interp s) ~printer:self)

let make_b n b s =
  n >:: (fun _ -> assert_equal (string_of_bool b) (interp s) ~printer:self)

let tests = [
  make_i "int" 22 "22";
  make_i "add" 22 "11+11";
  make_i "mul" 22 "2*11";
  make_i "mul of mul" 40 "2*2*10";
  make_i "mul on right" 22 "2+2*10";
  make_i "mul on left" 14 "2*2+10";
  make_i "nested add" 22 "(10 + 1) + (5 + 6)";
  make_i "sub" 20 "22-2";
  make_i "neg" 20 "-2+22";
  make_i "neg" (-20) "-2*10";
  make_i "neg2" (-20) "10*-2";
  make_i "sub" (-40) "-2*10-10*2";
  make_i "sub2" (-40) "-2+10*-2-18";
  make_i "div" 20 "40/2";
  make_i "div2" 20 "20*2/2";
  make_i "div3" 22 "2+40/2";
  make_i "mod" 0 "4%2";
  make_i "mod" 1 "10%3";
  make_i "mod" 1 "10%-3";

  make_b "true" true "true";
  make_b "false" true "true";
  make_b "lt" true "1<2";
  make_b "lt2" true "-2<1";
  make_b "lt2" false "2<-1";
  make_b "eq" true "1==1";
  make_b "eq2" false "1==2";
  make_b "eq3" true "-1==-1";
  make_b "eq4" false "-1==-2";
]

let _ = run_test_tt_main ("suite" >::: tests)