(* TEST
 * expect
*)

module M1 : sig
  type t = {f0 : unit * unit * unit * int * unit * unit * unit;
            f1 : unit * unit * unit * int * unit * unit * unit}
end = struct
  type t = {f0 : unit * unit * unit * float* unit * unit * unit;
            f1 : unit * unit * unit * string * unit * unit * unit}
end;;
[%%expect{|
Lines 4-7, characters 6-3:
4 | ......struct
5 |   type t = {f0 : unit * unit * unit * float* unit * unit * unit;
6 |             f1 : unit * unit * unit * string * unit * unit * unit}
7 | end..
Error: Signature mismatch:
       Modules do not match:
         sig
           type t = {
             f0 : unit * unit * unit * float * unit * unit * unit;
             f1 : unit * unit * unit * string * unit * unit * unit;
           }
         end
       is not included in
         sig
           type t = {
             f0 : unit * unit * unit * int * unit * unit * unit;
             f1 : unit * unit * unit * int * unit * unit * unit;
           }
         end
       Type declarations do not match:
         type t = {
           f0 : unit * unit * unit * float * unit * unit * unit;
           f1 : unit * unit * unit * string * unit * unit * unit;
         }
       is not included in
         type t = {
           f0 : unit * unit * unit * int * unit * unit * unit;
           f1 : unit * unit * unit * int * unit * unit * unit;
         }
       1. Fields do not match:
         f0 : unit * unit * unit * float * unit * unit * unit;
       is not the same as:
         f0 : unit * unit * unit * int * unit * unit * unit;
       The type unit * unit * unit * float * unit * unit * unit
       is not equal to the type unit * unit * unit * int * unit * unit * unit
       Type float is not equal to type int
       2. Fields do not match:
         f1 : unit * unit * unit * string * unit * unit * unit;
       is not the same as:
         f1 : unit * unit * unit * int * unit * unit * unit;
       The type unit * unit * unit * string * unit * unit * unit
       is not equal to the type unit * unit * unit * int * unit * unit * unit
       Type string is not equal to type int
|}];;


module M2 : sig
  type t = {mutable f0 : unit * unit * unit * int * unit * unit * unit;
            f1 : unit * unit * unit * int * unit * unit * unit}
end = struct
  type t = {f0 : unit * unit * unit * float* unit * unit * unit;
            f1 : unit * unit * unit * string * unit * unit * unit}
end;;
[%%expect{|
Lines 4-7, characters 6-3:
4 | ......struct
5 |   type t = {f0 : unit * unit * unit * float* unit * unit * unit;
6 |             f1 : unit * unit * unit * string * unit * unit * unit}
7 | end..
Error: Signature mismatch:
       Modules do not match:
         sig
           type t = {
             f0 : unit * unit * unit * float * unit * unit * unit;
             f1 : unit * unit * unit * string * unit * unit * unit;
           }
         end
       is not included in
         sig
           type t = {
             mutable f0 : unit * unit * unit * int * unit * unit * unit;
             f1 : unit * unit * unit * int * unit * unit * unit;
           }
         end
       Type declarations do not match:
         type t = {
           f0 : unit * unit * unit * float * unit * unit * unit;
           f1 : unit * unit * unit * string * unit * unit * unit;
         }
       is not included in
         type t = {
           mutable f0 : unit * unit * unit * int * unit * unit * unit;
           f1 : unit * unit * unit * int * unit * unit * unit;
         }
       1. Fields do not match:
         f0 : unit * unit * unit * float * unit * unit * unit;
       is not the same as:
         mutable f0 : unit * unit * unit * int * unit * unit * unit;
       The second is mutable and the first is not.
       2. Fields do not match:
         f1 : unit * unit * unit * string * unit * unit * unit;
       is not the same as:
         f1 : unit * unit * unit * int * unit * unit * unit;
       The type unit * unit * unit * string * unit * unit * unit
       is not equal to the type unit * unit * unit * int * unit * unit * unit
       Type string is not equal to type int
|}];;

module M3 : sig
  type t = {f0 : unit}
end = struct
  type t = {f1 : unit}
end;;
[%%expect{|
Lines 3-5, characters 6-3:
3 | ......struct
4 |   type t = {f1 : unit}
5 | end..
Error: Signature mismatch:
       Modules do not match:
         sig type t = { f1 : unit; } end
       is not included in
         sig type t = { f0 : unit; } end
       Type declarations do not match:
         type t = { f1 : unit; }
       is not included in
         type t = { f0 : unit; }
       Fields have different names, f1 and f0.
|}];;

module M4 : sig
  type t = {f0 : unit; f1 : unit}
end = struct
  type t = {f0 : unit}
end;;
[%%expect{|
Lines 3-5, characters 6-3:
3 | ......struct
4 |   type t = {f0 : unit}
5 | end..
Error: Signature mismatch:
       Modules do not match:
         sig type t = { f0 : unit; } end
       is not included in
         sig type t = { f0 : unit; f1 : unit; } end
       Type declarations do not match:
         type t = { f0 : unit; }
       is not included in
         type t = { f0 : unit; f1 : unit; }
       A field, f1, is missing in the first declaration.
|}];;
