open Base
open Stdio
open Shcaml

let write_sexp fn sexp =
  Out_channel.write_all fn ~data:(Sexp.to_string sexp)

type conf_t = { cflags: string list; libs: string list }

let () =
  let open UsrBin in
  let conf =
    let clang_libs = Printf.sprintf "-L%s" (backquote "llvm-config --libdir") in
    let clang_flags = String.split ~on:' ' (backquote "llvm-config --cflags") in
    let libffi_libs = String.split ~on:' ' (backquote "pkg-config --libs libffi") in
    let libffi_flags = String.split ~on:' ' (backquote "pkg-config --cflags libffi") in
    let libs = [clang_libs] @ libffi_libs in
    let cflags = ["-lclang";"-Wl,--start-group"; "-O2"; "-Wall"; "-Wextra"; "-Wno-unused-parameter"] @ (clang_flags @ libffi_flags) in
    { cflags; libs }

  in
  write_sexp "c_flags.sexp"         (sexp_of_list sexp_of_string conf.cflags);
  write_sexp "c_library_flags.sexp" (sexp_of_list sexp_of_string conf.libs)
