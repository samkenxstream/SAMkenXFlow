(*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

(** services for producing types from annotations,
    called during AST traversal.
 *)

module type S = sig
  module Class_type_sig : Class_sig_intf.S

  val convert :
    Context.t ->
    Type.t Subst_name.Map.t ->
    (ALoc.t, ALoc.t) Flow_ast.Type.t ->
    (ALoc.t, ALoc.t * Type.t) Flow_ast.Type.t

  val convert_list :
    Context.t ->
    Type.t Subst_name.Map.t ->
    (ALoc.t, ALoc.t) Flow_ast.Type.t list ->
    Type.t list * (ALoc.t, ALoc.t * Type.t) Flow_ast.Type.t list

  val convert_opt :
    Context.t ->
    Type.t Subst_name.Map.t ->
    (ALoc.t, ALoc.t) Flow_ast.Type.t option ->
    Type.t option * (ALoc.t, ALoc.t * Type.t) Flow_ast.Type.t option

  val convert_qualification :
    ?lookup_mode:Type_env.LookupMode.t ->
    Context.t ->
    string ->
    (ALoc.t, ALoc.t) Flow_ast.Type.Generic.Identifier.t ->
    Type.t * (ALoc.t, ALoc.t * Type.t) Flow_ast.Type.Generic.Identifier.t

  val mk_super :
    Context.t ->
    Type.t Subst_name.Map.t ->
    ALoc.t ->
    Type.t ->
    (ALoc.t, ALoc.t) Flow_ast.Type.TypeArgs.t option ->
    (ALoc.t * Type.t * Type.t list option)
    * (ALoc.t, ALoc.t * Type.t) Flow_ast.Type.TypeArgs.t option

  val mk_type_annotation :
    Context.t ->
    Type.t Subst_name.Map.t ->
    Reason.t ->
    (ALoc.t, ALoc.t) Flow_ast.Type.annotation_or_hint ->
    Type.annotated_or_inferred * (ALoc.t, ALoc.t * Type.t) Flow_ast.Type.annotation_or_hint

  val mk_return_annot :
    Context.t ->
    Type.t Subst_name.Map.t ->
    Type.fun_param list ->
    Reason.t ->
    (ALoc.t, ALoc.t) Flow_ast.Function.ReturnAnnot.t ->
    Type.annotated_or_inferred
    * (ALoc.t, ALoc.t * Type.t) Flow_ast.Function.ReturnAnnot.t
    * Type.fun_predicate option

  val mk_return_type_annotation :
    Context.t ->
    Type.t Subst_name.Map.t ->
    Type.fun_param list ->
    Reason.t ->
    void_return:bool ->
    async:bool ->
    (ALoc.t, ALoc.t) Flow_ast.Function.ReturnAnnot.t ->
    Type.annotated_or_inferred
    * (ALoc.t, ALoc.t * Type.t) Flow_ast.Function.ReturnAnnot.t
    * Type.fun_predicate option

  val mk_type_available_annotation :
    Context.t ->
    Type.t Subst_name.Map.t ->
    (ALoc.t, ALoc.t) Flow_ast.Type.annotation ->
    Type.t * (ALoc.t, ALoc.t * Type.t) Flow_ast.Type.annotation

  val mk_function_type_annotation :
    Context.t ->
    Type.t Subst_name.Map.t ->
    ALoc.t * (ALoc.t, ALoc.t) Flow_ast.Type.Function.t ->
    Type.t * (ALoc.t * (ALoc.t, ALoc.t * Type.t) Flow_ast.Type.Function.t)

  val mk_nominal_type :
    Context.t ->
    Reason.t ->
    Type.t Subst_name.Map.t ->
    Type.t * (ALoc.t, ALoc.t) Flow_ast.Type.TypeArgs.t option ->
    Type.t * (ALoc.t, ALoc.t * Type.t) Flow_ast.Type.TypeArgs.t option

  val mk_type_param :
    Context.t ->
    Type.t Subst_name.Map.t ->
    from_infer_type:bool ->
    (ALoc.t, ALoc.t) Flow_ast.Type.TypeParam.t ->
    (ALoc.t, ALoc.t * Type.t) Flow_ast.Type.TypeParam.t * Type.typeparam * Type.t

  val mk_type_param_declarations :
    Context.t ->
    ?tparams_map:Type.t Subst_name.Map.t ->
    (ALoc.t, ALoc.t) Flow_ast.Type.TypeParams.t option ->
    Type.typeparams
    * Type.t Subst_name.Map.t
    * (ALoc.t, ALoc.t * Type.t) Flow_ast.Type.TypeParams.t option

  val mk_interface_sig :
    Context.t ->
    ALoc.t ->
    Reason.t ->
    (ALoc.t, ALoc.t) Flow_ast.Statement.Interface.t ->
    Class_type_sig.Types.t * Type.t * (ALoc.t, ALoc.t * Type.t) Flow_ast.Statement.Interface.t

  val mk_declare_class_sig :
    Context.t ->
    ALoc.t ->
    Reason.t ->
    (ALoc.t, ALoc.t) Flow_ast.Statement.DeclareClass.t ->
    Class_type_sig.Types.t * Type.t * (ALoc.t, ALoc.t * Type.t) Flow_ast.Statement.DeclareClass.t

  val mk_declare_component_sig :
    Context.t ->
    ALoc.t ->
    (ALoc.t, ALoc.t) Flow_ast.Statement.DeclareComponent.t ->
    Type.t * (ALoc.t, ALoc.t * Type.t) Flow_ast.Statement.DeclareComponent.t

  val polarity : Context.t -> ALoc.t Flow_ast.Variance.t option -> Polarity.t

  val qualified_name : (ALoc.t, ALoc.t) Flow_ast.Type.Generic.Identifier.t -> string

  val error_type :
    Context.t ->
    ALoc.t ->
    Error_message.t ->
    (ALoc.t, ALoc.t) Flow_ast.Type.t ->
    (ALoc.t, ALoc.t * Type.t) Flow_ast.Type.t
end
