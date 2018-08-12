open OUnit2

let test_create_dispose_index test_ctxt =
  let open Libclang in
  let i = Index.create false false in
  Index.dispose i

let tests =
  "Libclang.Index tests" >:::
  [
    "Test to see if it builds" >:: test_create_dispose_index;
  ]
