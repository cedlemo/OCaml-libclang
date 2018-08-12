(*
 * Copyright 2017 Cedric LE MOIGNE, cedlemo@gmx.com
 * This file is part of OCaml-GObject-Introspection.
 *
 * OCaml-GObject-Introspection is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * OCaml-GObject-Introspection is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OCaml-GObject-Introspection.  If not, see <http://www.gnu.org/licenses/>.
 *)

open Ctypes
open Foreign

type t = unit ptr
let typ_t : t typ = ptr void

let dispose =
  foreign "clang_disposeIndex" (typ_t @-> returning void)

let create exclude_decls_from_pch display_diagnostics =
  let e = if exclude_decls_from_pch then 1 else 0 in
  let d = if display_diagnostics then 1 else 0 in
  let create_raw =
    foreign "clang_createIndex" (int @-> int @-> returning typ_t)
  in
  create_raw e d
