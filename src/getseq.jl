#
# Functions to read the sequence of a PDB file
#

# From the vector of atoms already read

function getseq( atoms :: Union{Vector{Atom},Vector{MutableAtom}}, selection :: String)
  query = parse_query(selection)
  return getseq(atoms, only = atom -> apply_query(query,atom))
end

function getseq( atoms :: Union{Vector{Atom},Vector{MutableAtom}}; only = atom -> true)
  natoms = length(atoms)
  n = 0
  iresidue = -1
  for i in 1:natoms
    if only(atoms[i]) && atoms[i].resnum != iresidue
      n = n + 1
      iresidue = atoms[i].resnum
    end
  end
  seq = Array{String}(undef,n,2)
  ichain = 0
  iresidue = -1
  for i in 1:natoms 
    if only(atoms[i]) && atoms[i].resnum != iresidue
      ichain = ichain + 1
      seq[ichain,1] = atoms[i].resname
      seq[ichain,2] = oneletter(atoms[i].resname)
      iresidue = atoms[i].resnum
    end
  end
  return seq
end

# If no selection is provided, select everything that is a protein

getseq( atoms :: Union{Vector{Atom},Vector{MutableAtom}} ) = getseq(atoms, only = atom -> isprotein(atom))
  
# From the file name

function getseq( file :: String, selection :: String) 
  atoms = readPDB(file)
  return getseq(atoms, selection)
end

getseq(file :: String) = getseq(file, only = atom -> isprotein(atom))





