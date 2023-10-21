
[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
  large_kinematics = false
  macro_gradient = hvar
  homogenization_constraint = homogenization
[]

[Mesh]
  [./base]
    type = FileMeshGenerator
    file = 'dodecahedron.exo'
  [../]
[]

[Variables]
  [disp_x]
    family = LAGRANGE
    order = SECOND
  []
  [disp_y]
    family = LAGRANGE
    order = SECOND
  []
  [disp_z]
    family = LAGRANGE
    order = SECOND
  []
  [hvar]
    family = SCALAR
    order = SIXTH
  []
[]

[AuxVariables]
  [sxx]
    family = MONOMIAL
    order = CONSTANT
  []
  [syy]
    family = MONOMIAL
    order = CONSTANT
  []
  [sxy]
    family = MONOMIAL
    order = CONSTANT
  []
  [szz]
    family = MONOMIAL
    order = CONSTANT
  []
  [syz]
    family = MONOMIAL
    order = CONSTANT
  []
  [sxz]
    family = MONOMIAL
    order = CONSTANT
  []
  [exx]
    family = MONOMIAL
    order = CONSTANT
  []
  [eyy]
    family = MONOMIAL
    order = CONSTANT
  []
  [exy]
    family = MONOMIAL
    order = CONSTANT
  []
  [ezz]
    family = MONOMIAL
    order = CONSTANT
  []
  [eyz]
    family = MONOMIAL
    order = CONSTANT
  []
  [exz]
    family = MONOMIAL
    order = CONSTANT
  []
[]

[AuxKernels]
  [sxx]
    type = RankTwoAux
    variable = sxx
    rank_two_tensor = pk1_stress
    index_i = 0
    index_j = 0
  []
  [syy]
    type = RankTwoAux
    variable = syy
    rank_two_tensor = pk1_stress
    index_i = 1
    index_j = 1
  []
  [sxy]
    type = RankTwoAux
    variable = sxy
    rank_two_tensor = pk1_stress
    index_i = 0
    index_j = 1
  []

  [zz]
    type = RankTwoAux
    variable = szz
    rank_two_tensor = pk1_stress
    index_i = 2
    index_j = 2
  []
  [syz]
    type = RankTwoAux
    variable = syz
    rank_two_tensor = pk1_stress
    index_i = 1
    index_j = 2
  []
  [sxz]
    type = RankTwoAux
    variable = sxz
    rank_two_tensor = pk1_stress
    index_i = 0
    index_j = 2
  []

  [exx]
    type = RankTwoAux
    variable = exx
    rank_two_tensor = mechanical_strain
    index_i = 0
    index_j = 0
  []
  [eyy]
    type = RankTwoAux
    variable = eyy
    rank_two_tensor = mechanical_strain
    index_i = 1
    index_j = 1
  []
  [exy]
    type = RankTwoAux
    variable = exy
    rank_two_tensor = mechanical_strain
    index_i = 0
    index_j = 1
  []

  [ezz]
    type = RankTwoAux
    variable = ezz
    rank_two_tensor = mechanical_strain
    index_i = 2
    index_j = 2
  []
  [eyz]
    type = RankTwoAux
    variable = eyz
    rank_two_tensor = mechanical_strain
    index_i = 1
    index_j = 2
  []
  [exz]
    type = RankTwoAux
    variable = exz
    rank_two_tensor = mechanical_strain
    index_i = 0
    index_j = 2
  []
[]

[UserObjects]
  [homogenization]
    type = HomogenizationConstraint
    constraint_types = 'strain none none strain strain none strain strain strain'
    targets = 'strain11 strain12 strain22 strain13 strain23 strain33'
    execute_on = 'INITIAL LINEAR NONLINEAR'
    block = '1 2 3 4 5 6 7 8'
  []
[]

[Kernels]
  [sdx]
    type = HomogenizedTotalLagrangianStressDivergence
    variable = disp_x
    component = 0
    block = '1 2 3 4 5 6 7 8'
  []
  [sdy]
    type = HomogenizedTotalLagrangianStressDivergence
    variable = disp_y
    component = 1
    block = '1 2 3 4 5 6 7 8'
  []
  [sdz]
    type = HomogenizedTotalLagrangianStressDivergence
    variable = disp_z
    component = 2
    block = '1 2 3 4 5 6 7 8'
  []
[]

[ScalarKernels]
  [enforce]
    type = HomogenizationConstraintScalarKernel
    variable = hvar
  []
[]

[Functions]
  [strain11]
    type = ParsedFunction
    value = '4.0e-2*t'
  []
  [strain22]
    type = ParsedFunction
    value = '-2.0e-2*t'
  []
  [strain33]
    type = ParsedFunction
    value = '8.0e-2*t'
  []
  [strain23]
    type = ParsedFunction
    value = '2.0e-2*t'
  []
  [strain13]
    type = ParsedFunction
    value = '-7.0e-2*t'
  []
  [strain12]
    type = ParsedFunction
    value = '1.0e-2*t'
  []
  [stress11]
    type = ParsedFunction
    value = '4.0e2*t'
  []
  [stress22]
    type = ParsedFunction
    value = '-2.0e2*t'
  []
  [stress33]
    type = ParsedFunction
    value = '8.0e2*t'
  []
  [stress23]
    type = ParsedFunction
    value = '2.0e2*t'
  []
  [stress13]
    type = ParsedFunction
    value = '-7.0e2*t'
  []
  [stress12]
    type = ParsedFunction
    value = '1.0e2*t'
  []
[]

[BCs]
  [./Periodic]
    [./Ax]
      variable = disp_x
      primary = 'A-1'
      secondary = 'A-2'
      translation = '1.4142135623730951 1.4142135623730951 -1.4142135623730951'
    [../]
    [./Ay]
      variable = disp_y
      primary = 'A-1'
      secondary = 'A-2'
      translation = '1.4142135623730951 1.4142135623730951 -1.4142135623730951'
    [../]
    [./Az]
      variable = disp_z
      primary = 'A-1'
      secondary = 'A-2'
      translation = '1.4142135623730951 1.4142135623730951 -1.4142135623730951'
    [../]


    [./Bx]
      variable = disp_x
      primary = 'B-1'
      secondary = 'B-2'
      translation = '1.4142135623730951 -1.4142135623730951 -1.4142135623730951'
    [../]
    [./By]
      variable = disp_y
      primary = 'B-1'
      secondary = 'B-2'
      translation = '1.4142135623730951 -1.4142135623730951 -1.4142135623730951'
    [../]
    [./Bz]
      variable = disp_z
      primary = 'B-1'
      secondary = 'B-2'
      translation = '1.4142135623730951 -1.4142135623730951 -1.4142135623730951'
    [../]

    [./Cx]
      variable = disp_x
      primary = 'C-1'
      secondary = 'C-2'
      translation = '-1.4142135623730951 -1.4142135623730951 -1.4142135623730951'
    [../]
    [./Cy]
      variable = disp_y
      primary = 'C-1'
      secondary = 'C-2'
      translation = '-1.4142135623730951 -1.4142135623730951 -1.4142135623730951'
    [../]
    [./Cz]
      variable = disp_z
      primary = 'C-1'
      secondary = 'C-2'
      translation = '-1.4142135623730951 -1.4142135623730951 -1.4142135623730951'
    [../]

    [./Dx]
      variable = disp_x
      primary = 'D-1'
      secondary = 'D-2'
      translation = '0 0 -2.8284271247461903'
    [../]
    [./Dy]
      variable = disp_y
      primary = 'D-1'
      secondary = 'D-2'
      translation = '0 0 -2.8284271247461903'
    [../]
    [./Dz]
      variable = disp_z
      primary = 'D-1'
      secondary = 'D-2'
      translation = '0 0 -2.8284271247461903'
    [../]

    [./Ex]
      variable = disp_x
      primary = 'E-1'
      secondary = 'E-2'
      translation = '0 2.8284271247461903 0'
    [../]
    [./Ey]
      variable = disp_y
      primary = 'E-1'
      secondary = 'E-2'
      translation = '0 2.8284271247461903 0'
    [../]
    [./Ez]
      variable = disp_z
      primary = 'E-1'
      secondary = 'E-2'
      translation = '0 2.8284271247461903 0'
    [../]

    [./Fx]
      variable = disp_x
      primary = 'F-1'
      secondary = 'F-2'
      translation = '-2.8284271247461903 0 0'
    [../]
    [./Fy]
      variable = disp_y
      primary = 'F-1'
      secondary = 'F-2'
      translation = '-2.8284271247461903 0 0'
    [../]
    [./Fz]
      variable = disp_z
      primary = 'F-1'
      secondary = 'F-2'
      translation = '-2.8284271247461903 0 0'
    [../]

  [../]

  [./fix1_x]
    type = DirichletBC
    boundary = "fix_all"
    variable = disp_x
    value = 0
  [../]
  [./fix1_y]
    type = DirichletBC
    boundary = "fix_all"
    variable = disp_y
    value = 0
  [../]
  [./fix1_z]
    type = DirichletBC
    boundary = "fix_all"
    variable = disp_z
    value = 0
  [../]

  [./fix2_x]
    type = DirichletBC
    boundary = "fix_xy"
    variable = disp_x
    value = 0
  [../]
  [./fix2_y]
    type = DirichletBC
    boundary = "fix_xy"
    variable = disp_y
    value = 0
  [../]

  [./fix3_z]
    type = DirichletBC
    boundary = "fix_z"
    variable = disp_z
    value = 0
  [../]
[]

[Materials]
  [elastic_tensor_1]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 100000.0
    poissons_ratio = 0.3
    block = '1 2 3 4 5 6 7 8'
  []
  [compute_stress]
    type = ComputeLagrangianLinearElasticStress
    block = '1 2 3 4 5 6 7 8'
  []
  [compute_strain]
    type = ComputeLagrangianStrain
    homogenization_gradient_names = 'homogenization_gradient'
    block = '1 2 3 4 5 6 7 8'
  []
  [compute_homogenization_gradient]
    type = ComputeHomogenizedLagrangianStrain
    block = '1 2 3 4 5 6 7 8'
  []
[]

[Postprocessors]
  [sxx]
    type = ElementAverageValue
    variable = sxx
    execute_on = 'initial timestep_end'
  []
  [syy]
    type = ElementAverageValue
    variable = syy
    execute_on = 'initial timestep_end'
  []
  [sxy]
    type = ElementAverageValue
    variable = sxy
    execute_on = 'initial timestep_end'
  []

  [szz]
    type = ElementAverageValue
    variable = szz
    execute_on = 'initial timestep_end'
  []
  [syz]
    type = ElementAverageValue
    variable = syz
    execute_on = 'initial timestep_end'
  []
  [sxz]
    type = ElementAverageValue
    variable = sxz
    execute_on = 'initial timestep_end'
  []

  [exx]
    type = ElementAverageValue
    variable = exx
    execute_on = 'initial timestep_end'
  []
  [eyy]
    type = ElementAverageValue
    variable = eyy
    execute_on = 'initial timestep_end'
  []
  [exy]
    type = ElementAverageValue
    variable = exy
    execute_on = 'initial timestep_end'
  []

  [ezz]
    type = ElementAverageValue
    variable = ezz
    execute_on = 'initial timestep_end'
  []
  [eyz]
    type = ElementAverageValue
    variable = eyz
    execute_on = 'initial timestep_end'
  []
  [exz]
    type = ElementAverageValue
    variable = exz
    execute_on = 'initial timestep_end'
  []
[]

[Executioner]
  type = Transient

  solve_type = 'newton'
  line_search = none

  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'

  l_max_its = 2
  l_tol = 1e-14
  nl_max_its = 10
  nl_rel_tol = 1e-8
  nl_abs_tol = 1e-10

  start_time = 0.0
  dt = 0.2
  dtmin = 0.2
  end_time = 0.2
[]

[Outputs]
  exodus = true
  csv = true
[]
