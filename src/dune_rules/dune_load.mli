(** Loads dune files from the file system.

    Also responsible for evaluating dune files written in OCaml syntax. *)

open Import

module Dune_files : sig
  (** A partially evaluated dune file. The context's ocamlc is used to evaluate
      dune files in ocaml syntax *)
  type t

  val eval : t -> context:Context_name.t -> Dune_file.t list Memo.t
  val in_dir : Path.Build.t -> Dune_file.t option Memo.t
end

type conf = private
  { dune_files : Dune_files.t
  ; packages : Package.t Package.Name.Map.t
  ; projects : Dune_project.t list
  ; projects_by_root : Dune_project.t Path.Source.Map.t
  }

(** Load all dune files. This function is memoized. *)
val load : unit -> conf Memo.t

val find_project : dir:Path.Build.t -> Dune_project.t Memo.t
