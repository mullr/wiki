### Can you show me an example of a tactic written in OCaml?

Have a look at the skeleton “Hello World” tactic [below](#is-there-a-skeleton-of-ocaml-tactic-i-can-reuse-somewhere). You also have some examples of tactics written in OCaml in the “plugins” directory of Coq's source.

### Is there a skeleton of OCaml tactic I can reuse somewhere?

The following steps describe how to write a simplistic “Hello world” OCaml tactic. This takes the form of a dynamically loadable OCaml module, which will be invoked from the Coq toplevel.

1. In the plugins directory of the Coq source location, create a directory `hello`. Proceed to create a grammar and OCaml file, respectively `plugins/hello/g_hello.ml4` and `plugins/hello/coq_hello.ml`, containing:

in `g_hello.ml4`:

```
(*i camlp4deps: "grammar/grammar.cma" i*)
TACTIC EXTEND Hello
| [ "hello" ] -> [ Coq_hello.printHello ]
END
```

in `coq_hello.ml`:

```ocaml
let printHello gl =
Tacticals.tclIDTAC_MESSAGE (Pp.str "Hello world") gl
```
2. Create a file `plugins/hello/hello_plugin.mllib`, containing the names of the OCaml modules bundled in the dynamic library:
```
Coq_hello
G_hello
```
3. Append the following lines in `plugins/plugins{byte,opt}.itarget`:

in `in pluginsopt.itarget`:
```
hello/hello_plugin.cmxa
```

in `pluginsbyte.itarget`:
```
hello/hello_plugin.cma
```
4. In the root directory of the Coq source location, modify the file `Makefile.common`:
    * add `hello` to the `SRCDIR` definition (second argument of the `addprefix` function);
    * in the section “Object and Source files”, add `HELLOCMA:=plugins/hello/hello_plugin.cma`;
    * add `$(HELLOCMA)` to the `PLUGINSCMA` definition.

5. Modify the file `Makefile.build`, adding in section “3) plugins” the line:
```
hello: $(HELLOCMA)
```
6. From the command line, run `make hello`, then `make plugins/hello/hello_plugin.cmxs`.

The call to the tactic `hello` from a Coq script has to be preceded by `Declare ML Module "hello_plugin"`,
which will load the dynamic object `hello_plugin.cmxs`. For instance:

```coq
Declare ML Module "hello_plugin".
Variable A:Prop.
Goal A-> A.
Proof.
hello.
auto.
Qed.
```