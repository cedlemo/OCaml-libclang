open OUnit2

let () =
  run_test_tt_main
  (
    "Libclang Tests" >:::
    [
      Test_index.tests
    ]
  )

