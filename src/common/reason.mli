(*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

val mk_id : unit -> int

type name =
  | OrdinaryName of string
  | InternalName of string
  | InternalModuleName of string
[@@deriving eq, ord, show]

type 'loc virtual_reason_desc =
  | RTrusted of 'loc virtual_reason_desc
  | RPrivate of 'loc virtual_reason_desc
  | RAnyExplicit
  | RAnyImplicit
  | RNumber
  | RBigInt
  | RString
  | RBoolean
  | RMixed
  | REmpty
  | REmptyArrayElement
  | RVoid
  | RNull
  | RVoidedNull
  | RSymbol
  | RExports
  | RNullOrVoid
  | RLongStringLit of int (* Max length *)
  | RStringLit of name
  | RNumberLit of string
  | RBigIntLit of string
  | RBooleanLit of bool
  | RIndexedAccess of { optional: bool }
  | RConditionalType
  | RInferType of string
  | RMatchingProp of string * 'loc virtual_reason_desc
  | RObject
  | RObjectLit
  | RObjectType
  | RMappedType
  | RObjectClassName
  | RInterfaceType
  | RArray
  | RArrayLit
  | REmptyArrayLit
  | RArrayType
  | RArrayElement
  | RROArrayType
  | RTupleType
  | RTupleElement of { name: string option }
  | RTupleLength of int
  | RTupleOutOfBoundsAccess of int
  | RFunction of reason_desc_function
  | RFunctionType
  | RFunctionBody
  | RFunctionCall of 'loc virtual_reason_desc
  | RFunctionCallType
  | RFunctionUnusedArgument
  | RJSXChild
  | RJSXFunctionCall of string
  | RJSXIdentifier of string * string
  | RJSXElementProps of string
  | RJSXElement of string option
  | RJSXText
  | RFbt
  | RUnaryOperator of string * 'loc virtual_reason_desc
  | RBinaryOperator of string * 'loc virtual_reason_desc * 'loc virtual_reason_desc
  | RLogical of string * 'loc virtual_reason_desc * 'loc virtual_reason_desc
  | RTemplateString
  | RUnknownString
  | RUnionEnum
  | REnum of string
  | REnumRepresentation of 'loc virtual_reason_desc
  | RThis
  | RThisType
  | RImplicitInstantiation
  | RTooFewArgs
  | RTooFewArgsExpectedRest
  | RConstructorVoidReturn
  | RNewObject
  | RUnion
  | RUnionType
  | RIntersection
  | RIntersectionType
  | RKeySet
  | RAnd
  | RConditional
  | RPrototype
  | RObjectPrototype
  | RFunctionPrototype
  | RDestructuring
  | RDefaultValue
  | RConstructor
  | RDefaultConstructor
  | RConstructorCall of 'loc virtual_reason_desc
  | RReturn
  | RRegExp
  | RSuper
  | RNoSuper
  | RDummyPrototype
  | RDummyThis
  | RImplicitThis of 'loc virtual_reason_desc
  | RTupleMap
  | RObjectMap
  | RObjectMapi
  | RObjectKeyMirror
  | RObjectMapConst
  | RType of name
  | RTypeAlias of string * 'loc option * 'loc virtual_reason_desc
  | ROpaqueType of string
  | RTypeParam of
      Subst_name.t * ('loc virtual_reason_desc * 'loc) * ('loc virtual_reason_desc * 'loc)
  | RTypeParamDefault of 'loc virtual_reason_desc
  | RTypeParamBound of 'loc virtual_reason_desc
  | RTypeof of string
  | RMethod of string option
  | RMethodCall of string option
  | RParameter of string option
  | RRestParameter of string option
  | RPatternParameter of string
  | RIdentifier of name
  | RUnknownParameter of string
  | RIdentifierAssignment of string
  | RPropertyAssignment of string option
  | RProperty of name option
  | RPrivateProperty of string
  | RMember of {
      object_: string;
      property: string;
    }
  | RPropertyOf of name * 'loc virtual_reason_desc
  | RPropertyIsAString of name
  | RMissingProperty of name option
  | RUnknownProperty of name option
  | RUnknownUnspecifiedProperty of 'loc virtual_reason_desc
  | RUndefinedProperty of name
  | RSomeProperty
  | RNameProperty of 'loc virtual_reason_desc
  | RMissingAbstract of 'loc virtual_reason_desc
  | RFieldInitializer of string
  | RUntypedModule of string
  | RNamedImportedType of string * string
  | RImportStarType of string
  | RImportStarTypeOf of string
  | RImportStar of string
  | RDefaultImportedType of string * string
  | RAsyncImport
  | RCode of string
  | RCustom of string
  | RPolyType of 'loc virtual_reason_desc
  | RExactType of 'loc virtual_reason_desc
  | RReadOnlyType
  | ROptional of 'loc virtual_reason_desc
  | RMaybe of 'loc virtual_reason_desc
  | RRestArrayLit of 'loc virtual_reason_desc
  | RAbstract of 'loc virtual_reason_desc
  | RTypeApp of 'loc virtual_reason_desc
  | RTypeAppImplicit of 'loc virtual_reason_desc
  | RThisTypeApp of 'loc virtual_reason_desc
  | RExtends of 'loc virtual_reason_desc
  | RClass of 'loc virtual_reason_desc
  | RStatics of 'loc virtual_reason_desc
  | RSuperOf of 'loc virtual_reason_desc
  | RFrozen of 'loc virtual_reason_desc
  | RBound of 'loc virtual_reason_desc
  | RPredicateOf of 'loc virtual_reason_desc
  | RPredicateCall of 'loc virtual_reason_desc
  | RPredicateCallNeg of 'loc virtual_reason_desc
  | RRefined of 'loc virtual_reason_desc
  | RRefinedElement of 'loc virtual_reason_desc
  | RIncompatibleInstantiation of string
  | RSpreadOf of 'loc virtual_reason_desc
  | RPartialOf of 'loc virtual_reason_desc
  | RRequiredOf of 'loc virtual_reason_desc
  | RObjectPatternRestProp
  | RArrayPatternRestProp
  | RCommonJSExports of string
  | RModule of name
  | ROptionalChain
  | RReactProps
  | RReactElement of name option
  | RReactClass
  | RReactComponent
  | RReactStatics
  | RReactDefaultProps
  | RReactState
  | RReactChildren
  | RReactChildrenOrType of 'loc virtual_reason_desc
  | RReactChildrenOrUndefinedOrType of 'loc virtual_reason_desc
  | RReactSFC
  | RReactConfig
  | RPossiblyMissingPropFromObj of name * 'loc virtual_reason_desc
  | RWidenedObjProp of 'loc virtual_reason_desc
  | RUnionBranching of 'loc virtual_reason_desc * int
  | RUninitialized
  | RPossiblyUninitialized
  | RUnannotatedNext
  | RTypeGuardParam of string
  | RComponent of name
  | RComponentType
  | RPropsOfComponent of 'loc virtual_reason_desc

and reason_desc_function =
  | RAsync
  | RGenerator
  | RAsyncGenerator
  | RNormal
  | RUnknown

type reason_desc = ALoc.t virtual_reason_desc

type 'loc virtual_reason

type reason = ALoc.t virtual_reason

type concrete_reason = Loc.t virtual_reason

type t = reason (* convenience *)

(* reason constructor *)
val mk_reason : 'loc virtual_reason_desc -> 'loc -> 'loc virtual_reason

(* ranges *)
val in_range : Loc.t -> Loc.t -> bool

val string_of_desc : 'loc virtual_reason_desc -> string

val map_reason_locs : ('a -> 'b) -> 'a virtual_reason -> 'b virtual_reason

val map_desc_locs : ('a -> 'b) -> 'a virtual_reason_desc -> 'b virtual_reason_desc

val string_of_loc : ?strip_root:File_path.t option -> Loc.t -> string

val string_of_aloc : ?strip_root:File_path.t option -> ALoc.t -> string

val json_of_loc :
  ?strip_root:File_path.t option ->
  ?catch_offset_errors:bool ->
  offset_table:Offset_utils.t option ->
  Loc.t ->
  Hh_json.json

val json_of_loc_props :
  ?strip_root:File_path.t option ->
  ?catch_offset_errors:bool ->
  offset_table:Offset_utils.t option ->
  Loc.t ->
  (string * Hh_json.json) list

val json_of_source : ?strip_root:File_path.t option -> File_key.t option -> Hh_json.json

val json_source_type_of_source : File_key.t option -> Hh_json.json

val locationless_reason : reason_desc -> reason

val func_reason : async:bool -> generator:bool -> ALoc.t -> reason

val display_string_of_name : name -> string

val is_internal_name : name -> bool

val internal_name : string -> name

val internal_name_of_name : name -> name

val is_internal_module_name : name -> bool

val internal_module_name : string -> name

val uninternal_name : name -> string

val is_instantiable_reason : 'loc virtual_reason -> bool

val is_constant_reason : 'loc virtual_reason -> bool

val is_nullish_reason : 'loc virtual_reason -> bool

val is_scalar_reason : 'loc virtual_reason -> bool

val is_array_reason : 'loc virtual_reason -> bool

val is_literal_object_reason : 'loc virtual_reason -> bool

val is_lib_reason : reason -> bool

val is_lib_reason_def : reason -> bool

val is_blamable_reason : reason -> bool

val string_of_source : ?strip_root:File_path.t option -> File_key.t -> string

val string_of_reason : ?strip_root:File_path.t option -> reason -> string

val dump_reason : ?strip_root:File_path.t option -> reason -> string

(* accessors *)
val loc_of_reason : 'loc virtual_reason -> 'loc

val def_loc_of_reason : 'loc virtual_reason -> 'loc

val annot_loc_of_reason : 'loc virtual_reason -> 'loc option

val desc_of_reason : ?unwrap:bool -> 'loc virtual_reason -> 'loc virtual_reason_desc

(* simple way to get derived reasons whose descriptions are
   simple replacements of the original *)
(* replace desc, but keep loc, def_loc, annot_loc *)
val update_desc_reason :
  ('loc virtual_reason_desc -> 'loc virtual_reason_desc) ->
  'loc virtual_reason ->
  'loc virtual_reason

(* replace desc, keep loc, but clobber def_loc, annot_loc as in new reason *)
val update_desc_new_reason :
  ('loc virtual_reason_desc -> 'loc virtual_reason_desc) ->
  'loc virtual_reason ->
  'loc virtual_reason

(* replace desc, but keep loc, def_loc, annot_loc *)
val replace_desc_reason : 'loc virtual_reason_desc -> 'loc virtual_reason -> 'loc virtual_reason

(* replace desc, keep loc, but clobber def_loc, annot_loc as in new reason *)
val replace_desc_new_reason : 'loc virtual_reason_desc -> 'loc virtual_reason -> 'loc virtual_reason

(* replace loc, but keep def_loc *)
val repos_reason : 'loc -> 'loc virtual_reason -> 'loc virtual_reason

(* add / replace annot_loc, but keep loc and def_loc *)
val annot_reason : annot_loc:'loc -> 'loc virtual_reason -> 'loc virtual_reason

(* when annot_loc is given, same as annot_reason; otherwise, identity *)
val opt_annot_reason : ?annot_loc:'loc -> 'loc virtual_reason -> 'loc virtual_reason

(* create a new reason with annot_loc = loc: same as mk_reason followed by annot_reason *)
val mk_annot_reason : 'loc virtual_reason_desc -> 'loc -> 'loc virtual_reason

module ReasonMap : WrappedMap.S with type key = reason

module ImplicitInstantiationReasonMap : WrappedMap.S with type key = reason * reason * reason Nel.t

val mk_expression_reason : ('loc, 'loc) Flow_ast.Expression.t -> 'loc virtual_reason

val mk_initial_arguments_reason :
  ('loc, 'loc) Flow_ast.Expression.ArgList.t -> 'loc virtual_reason list

val mk_pattern_reason : (ALoc.t, ALoc.t) Flow_ast.Pattern.t -> reason

val unknown_elem_empty_array_desc : reason_desc

val inferred_union_elem_array_desc : reason_desc

val invalidate_rtype_alias : 'loc virtual_reason_desc -> 'loc virtual_reason_desc

val code_desc_of_expression : wrap:bool -> ('a, 'b) Flow_ast.Expression.t -> string

val code_desc_of_pattern : ('a, 'b) Flow_ast.Pattern.t -> string

(* Pass in any available aloc tables to be used when comparing abstract and concrete locations from
 * the same file. Usually `Context.aloc_tables` is a good choice, but if the context is not
 * available, the empty map may be appropriate. *)
val concretize_equal : ALoc.table Lazy.t Utils_js.FilenameMap.t -> t -> t -> bool

val pp_virtual_reason_desc :
  (Format.formatter -> 'loc -> Ppx_deriving_runtime.unit) ->
  Format.formatter ->
  'loc virtual_reason_desc ->
  Ppx_deriving_runtime.unit

val show_virtual_reason_desc :
  (Format.formatter -> 'loc -> Ppx_deriving_runtime.unit) -> 'loc virtual_reason_desc -> string

val show_reason_desc_function : reason_desc_function -> string

val range_string_of_loc : strip_root:File_path.t option -> Loc.t -> string
