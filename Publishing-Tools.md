(Part of [[the Coq FAQ]])

### How can I generate some LaTex from my development?

You can use `coqdoc`.

### How can I generate some HTML from my development?

You can use `coqdoc`.

### How can I generate a dependency graph from my development?

You can use the tool `coqgraph` developed by Philippe Audebaud in 2002. This tool transforms dependencies generated by `coqdep` into `.dot` files which can be visualized using the Graphviz software (http://www.graphviz.org/).

### How can I cite some Coq in my LaTex document?

You can use `coq tex`.

### How can I cite the Coq reference manual?
You can use this bibtex entry (to adapt to the appropriate version):

```
@manual{Coq:manual,
  author = {{Coq} {Development} {Team}, The},
  title  = {The {Coq} Proof Assistant Reference Manual, version 8.7},
  month  = Oct,
  year   = {2017},
  url    = {http://coq.inria.fr}
}
```

### Where can I publish my developments in Coq?

You can submit your developments to the [Coq Package Index](https://coq.inria.fr/packages).

An earlier related projet (unmaintained) was the HELM/MoWGLI repository at the University of Bologna (see http://mowgli.cs.unibo.it). For developments submitted in this database, it was possible to visualize them in natural language and execute various retrieving requests.
