(*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

val find_local_refs :
  reader:State_reader.t ->
  options:Options.t ->
  file_key:File_key.t ->
  parse_artifacts:Types_js_types.parse_artifacts ->
  typecheck_artifacts:Types_js_types.typecheck_artifacts ->
  line:int ->
  col:int ->
  (FindRefsTypes.find_refs_ok, string) result

val local_refs_for_global_find_refs :
  options:Options.t ->
  loc_of_aloc:(ALoc.t -> Loc.t) ->
  FindRefsUtils.ast_info ->
  Types_js_types.typecheck_artifacts ->
  File_key.t ->
  GetDefUtils.def_info ->
  (FindRefsTypes.find_refs_found, string) result
