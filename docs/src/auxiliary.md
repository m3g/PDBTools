# Some auxiliary functions to quickly retrieve some data 

## Get the protein sequence

To obtain a list of the residue names of the protein with three- and one-letter codes, use
```julia-repl
julia> seq = getseq("file.pdb")
76-element Vector{String}:
 "V"
 "K"
  ⋮      
 "R"
 "G"

```

Use `getseq(atoms,code=2)` to get the sequence as three-letter residue codes, or `code=3` to get 
full natural-aminoacid names, like "Alanine", "Proline", etc.

!!! note
    If there is some non-standard protein residue in the sequence,
    inform the `getseq` function by adding a selection:
    ```julia-repl
    julia> getseq("file.pdb","protein or resname NEW")
    77-element Vector{String}:
     "V"
     "N"
      ⋮      
     "R"
     "G"
    ```
    By default the selection will only return the sequence of natural amino acids. 

The `getseq` function can of course be used on an `Atom` list, accepts selections as the
last argument, as well as the reading and writing functions:

```julia
atoms = readPDB("file.pdb")
seq = getseq(atoms,"chain A")

```

## Distance between sets of atoms

The distance between atoms, or sets of atoms, can be computed with the `distance` function. This
function returns the *minimum distance* between the atoms of the sets involved. For example:

```julia-repl
julia> model = wget("1BSX");

julia> protein = select(model,"protein");

julia> ligand = select(model,"resname T3");

julia> distance(protein,ligand)
2.7775834820937417
  
```

## Closest atoms and their distance

A function similar to the one above is `closest`, which returns the shortest distance between atoms
but also the identity of the atom or pair of atoms that satisfy that shortest distance:

```julia-repl
julia> model = wget("1BSX");

julia> protein = select(model,"protein");

julia> ligand = select(model,"resname T3");

julia> closest(ligand,protein)
((43, 3684), 2.7775834820937417)

julia> ligand[43]
    4037   O1      T3     B        2      512  -22.568   81.625    3.159 36.59  1.00     1       -      4041

julia> protein[3684]
    3684  NE2     HIS     B      435      472  -21.539   82.145    5.686 44.44  1.00     1       -      3686

julia> distance(ligand[43],protein[3684])
2.7775834820937417
  
```

## Obtain arrays with coordinates

All atoms:

```julia-repl
julia> x = coor(atoms)
1870×3 Matrix{Float64}:
  45.228  84.358  70.638
  46.08   83.165  70.327
  45.257  81.872  70.236
   ⋮              
 -26.929  77.888  51.398
 -27.112  78.62   50.033
 -27.481  77.605  48.554

```

Or use selections to retrieve the coordinates of subsets of atoms:

C``\alpha`` coordinates:

```julia-repl
julia> xCA = coor(protein,"name CA")
238×3 Matrix{Float64}:
  46.08   83.165  70.327
  43.02   80.825  70.455
  41.052  82.178  67.504
   ⋮              
 -10.342  80.743  58.658
 -10.352  84.347  57.613
 -10.768  83.294  53.989

```

By default, the output arrays are column based (the x, y and z coordinates of each
atom are in each column). If you want a column-major output, add `row_major=false` to
the input parameters of `coor`: `coor(atoms,row_major=false)`

## Maximum and minimum coordinates of the atoms

Use `maxmin(atoms)`, or `maxmin(atoms,"resname CA")`, for example:

```julia-repl
julia> m = maxmin(atoms,"chain A")

 Minimum atom coordinates: xmin = [-41.5, -41.526, -41.517]
 Maximum atom coordinates: xmax = [41.583, 41.502, 41.183]
 Length in each direction: xlength = [83.083, 83.028, 82.7]

```

`m` is a structure containing the three vectors with minimum and maximum
coordinates, and lengths.





