# Atomic and molecular properties

Some simple atom properties can be retrieved using special functions, which
operate on atoms of the type `Atom`. For example:

```julia-repl
julia> atoms = readPDB("./file.pdb");

julia> printatom(atoms[1])
   index name resname chain   resnum  residue        x        y        z  beta occup model segname index_pdb
       1   OW     SOL     X        1        1   54.370   45.310   33.970  0.00  0.00     1       -         1

julia> mass(atoms[1])
14.0067

julia> atomic_number(atoms[1])
7

julia> element(atoms[1])
"N"

julia> element_name(atoms[1])
"Nitrogen"

```

The formula or stoichiometry of a selection can also be retrieved:

```julia-repl
julia> atoms = wget("1LBD","protein and residue 1");

julia> f = formula(atoms)
C₃N₁O₂

julia> stoichiometry(select(atoms,"water"))
H₂O₁

```
