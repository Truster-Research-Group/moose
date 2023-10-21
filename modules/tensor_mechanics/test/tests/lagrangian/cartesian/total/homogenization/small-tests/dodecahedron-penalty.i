
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
  [left_block_id]
    type = SubdomainIDGenerator
    input = base
    subdomain_id = 1
  []

  [A1_lower]
    type = LowerDBlockFromSidesetGenerator
    input = left_block_id
    sidesets = 'A-1'
    new_block_id = '10000'
    new_block_name = 'secondary_A'
  []
  [A2_lower]
    type = LowerDBlockFromSidesetGenerator
    input = A1_lower
    sidesets = 'A-2'
    new_block_id = '10001'
    new_block_name = 'primary_A'
  []

  [B1_lower]
    type = LowerDBlockFromSidesetGenerator
    input = A2_lower
    sidesets = 'B-1'
    new_block_id = '10002'
    new_block_name = 'secondary_B'
  []
  [B2_lower]
    type = LowerDBlockFromSidesetGenerator
    input = B1_lower
    sidesets = 'B-2'
    new_block_id = '10003'
    new_block_name = 'primary_B'
  []

  [C1_lower]
    type = LowerDBlockFromSidesetGenerator
    input = B2_lower
    sidesets = 'C-1'
    new_block_id = '10004'
    new_block_name = 'secondary_C'
  []
  [C2_lower]
    type = LowerDBlockFromSidesetGenerator
    input = C1_lower
    sidesets = 'C-2'
    new_block_id = '10005'
    new_block_name = 'primary_C'
  []

  [D1_lower]
    type = LowerDBlockFromSidesetGenerator
    input = C2_lower
    sidesets = 'D-1'
    new_block_id = '10006'
    new_block_name = 'secondary_D'
  []
  [D2_lower]
    type = LowerDBlockFromSidesetGenerator
    input = D1_lower
    sidesets = 'D-2'
    new_block_id = '10007'
    new_block_name = 'primary_D'
  []

  [E1_lower]
    type = LowerDBlockFromSidesetGenerator
    input = D2_lower
    sidesets = 'E-1'
    new_block_id = '10008'
    new_block_name = 'secondary_E'
  []
  [E2_lower]
    type = LowerDBlockFromSidesetGenerator
    input = E1_lower
    sidesets = 'E-2'
    new_block_id = '10009'
    new_block_name = 'primary_E'
  []

  [F1_lower]
    type = LowerDBlockFromSidesetGenerator
    input = E2_lower
    sidesets = 'F-1'
    new_block_id = '10010'
    new_block_name = 'secondary_F'
  []
  [F2_lower]
    type = LowerDBlockFromSidesetGenerator
    input = F1_lower
    sidesets = 'F-2'
    new_block_id = '10011'
    new_block_name = 'primary_F'
  []
  [./corner_node]
    type = ExtraNodesetGenerator
    new_boundary = 'pinned_node'
    nodes = '0'
    input = F2_lower
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
    block = '1'
  []
  [syy]
    type = RankTwoAux
    variable = syy
    rank_two_tensor = pk1_stress
    index_i = 1
    index_j = 1
    block = '1'
  []
  [sxy]
    type = RankTwoAux
    variable = sxy
    rank_two_tensor = pk1_stress
    index_i = 0
    index_j = 1
    block = '1'
  []

  [zz]
    type = RankTwoAux
    variable = szz
    rank_two_tensor = pk1_stress
    index_i = 2
    index_j = 2
    block = '1'
  []
  [syz]
    type = RankTwoAux
    variable = syz
    rank_two_tensor = pk1_stress
    index_i = 1
    index_j = 2
    block = '1'
  []
  [sxz]
    type = RankTwoAux
    variable = sxz
    rank_two_tensor = pk1_stress
    index_i = 0
    index_j = 2
    block = '1'
  []

  [exx]
    type = RankTwoAux
    variable = exx
    rank_two_tensor = mechanical_strain
    index_i = 0
    index_j = 0
    block = '1'
  []
  [eyy]
    type = RankTwoAux
    variable = eyy
    rank_two_tensor = mechanical_strain
    index_i = 1
    index_j = 1
    block = '1'
  []
  [exy]
    type = RankTwoAux
    variable = exy
    rank_two_tensor = mechanical_strain
    index_i = 0
    index_j = 1
    block = '1'
  []

  [ezz]
    type = RankTwoAux
    variable = ezz
    rank_two_tensor = mechanical_strain
    index_i = 2
    index_j = 2
    block = '1'
  []
  [eyz]
    type = RankTwoAux
    variable = eyz
    rank_two_tensor = mechanical_strain
    index_i = 1
    index_j = 2
    block = '1'
  []
  [exz]
    type = RankTwoAux
    variable = exz
    rank_two_tensor = mechanical_strain
    index_i = 0
    index_j = 2
    block = '1'
  []
[]

[UserObjects]
  [homogenization]
    type = HomogenizationConstraint
    constraint_types = 'strain none none strain strain none strain strain strain'
    targets = 'strain11 strain12 strain22 strain13 strain23 strain33'
    execute_on = 'INITIAL LINEAR NONLINEAR'
    block = '1'
  []
[]

[Kernels]
  [sdx]
    type = HomogenizedTotalLagrangianStressDivergence
    variable = disp_x
    component = 0
    block = '1'
  []
  [sdy]
    type = HomogenizedTotalLagrangianStressDivergence
    variable = disp_y
    component = 1
    block = '1'
  []
  [sdz]
    type = HomogenizedTotalLagrangianStressDivergence
    variable = disp_z
    component = 2
    block = '1'
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

[Constraints]
  [interfaceAx]
    type = PenaltyEqualValueConstraint
    primary_boundary = 'A-2'
    secondary_boundary = 'A-1'
    primary_subdomain = 'primary_A'
    secondary_subdomain = 'secondary_A'
    secondary_variable = disp_x
    correct_edge_dropping = true
    penalty_value = 1.e7
    boundary_offset = '1.4142135623730951 1.4142135623730951 -1.4142135623730951'
  []
  [interfaceAy]
    type = PenaltyEqualValueConstraint
    primary_boundary = 'A-2'
    secondary_boundary = 'A-1'
    primary_subdomain = 'primary_A'
    secondary_subdomain = 'secondary_A'
    secondary_variable = disp_y
    correct_edge_dropping = true
    penalty_value = 1.e7
    boundary_offset = '1.4142135623730951 1.4142135623730951 -1.4142135623730951'
  []
  [interfaceAz]
    type = PenaltyEqualValueConstraint
    primary_boundary = 'A-2'
    secondary_boundary = 'A-1'
    primary_subdomain = 'primary_A'
    secondary_subdomain = 'secondary_A'
    secondary_variable = disp_z
    correct_edge_dropping = true
    penalty_value = 1.e7
    boundary_offset = '1.4142135623730951 1.4142135623730951 -1.4142135623730951'
  []

  [interfaceBx]
    type = PenaltyEqualValueConstraint
    primary_boundary = 'B-2'
    secondary_boundary = 'B-1'
    primary_subdomain = 'primary_B'
    secondary_subdomain = 'secondary_B'
    secondary_variable = disp_x
    correct_edge_dropping = true
    penalty_value = 1.e7
    boundary_offset = '1.4142135623730951 -1.4142135623730951 -1.4142135623730951'
  []
  [interfaceBy]
    type = PenaltyEqualValueConstraint
    primary_boundary = 'B-2'
    secondary_boundary = 'B-1'
    primary_subdomain = 'primary_B'
    secondary_subdomain = 'secondary_B'
    secondary_variable = disp_y
    correct_edge_dropping = true
    penalty_value = 1.e7
    boundary_offset = '1.4142135623730951 -1.4142135623730951 -1.4142135623730951'
  []
  [interfaceBz]
    type = PenaltyEqualValueConstraint
    primary_boundary = 'B-2'
    secondary_boundary = 'B-1'
    primary_subdomain = 'primary_B'
    secondary_subdomain = 'secondary_B'
    secondary_variable = disp_z
    correct_edge_dropping = true
    penalty_value = 1.e7
    boundary_offset = '1.4142135623730951 -1.4142135623730951 -1.4142135623730951'
  []

  [interfaceCx]
    type = PenaltyEqualValueConstraint
    primary_boundary = 'C-2'
    secondary_boundary = 'C-1'
    primary_subdomain = 'primary_C'
    secondary_subdomain = 'secondary_C'
    secondary_variable = disp_x
    correct_edge_dropping = true
    penalty_value = 1.e7
    boundary_offset = '-1.4142135623730951 -1.4142135623730951 -1.4142135623730951'
  []
  [interfaceCy]
    type = PenaltyEqualValueConstraint
    primary_boundary = 'C-2'
    secondary_boundary = 'C-1'
    primary_subdomain = 'primary_C'
    secondary_subdomain = 'secondary_C'
    secondary_variable = disp_y
    correct_edge_dropping = true
    penalty_value = 1.e7
    boundary_offset = '-1.4142135623730951 -1.4142135623730951 -1.4142135623730951'
  []
  [interfaceCz]
    type = PenaltyEqualValueConstraint
    primary_boundary = 'C-2'
    secondary_boundary = 'C-1'
    primary_subdomain = 'primary_C'
    secondary_subdomain = 'secondary_C'
    secondary_variable = disp_z
    correct_edge_dropping = true
    penalty_value = 1.e7
    boundary_offset = '-1.4142135623730951 -1.4142135623730951 -1.4142135623730951'
  []

  [interfaceDx]
    type = PenaltyEqualValueConstraint
    primary_boundary = 'D-2'
    secondary_boundary = 'D-1'
    primary_subdomain = 'primary_D'
    secondary_subdomain = 'secondary_D'
    secondary_variable = disp_x
    correct_edge_dropping = true
    penalty_value = 1.e7
  []
  [interfaceDy]
    type = PenaltyEqualValueConstraint
    primary_boundary = 'D-2'
    secondary_boundary = 'D-1'
    primary_subdomain = 'primary_D'
    secondary_subdomain = 'secondary_D'
    secondary_variable = disp_y
    correct_edge_dropping = true
    penalty_value = 1.e7
  []
  [interfaceDz]
    type = PenaltyEqualValueConstraint
    primary_boundary = 'D-2'
    secondary_boundary = 'D-1'
    primary_subdomain = 'primary_D'
    secondary_subdomain = 'secondary_D'
    secondary_variable = disp_z
    correct_edge_dropping = true
    penalty_value = 1.e7
  []

  [interfaceEx]
    type = PenaltyEqualValueConstraint
    primary_boundary = 'E-2'
    secondary_boundary = 'E-1'
    primary_subdomain = 'primary_E'
    secondary_subdomain = 'secondary_E'
    secondary_variable = disp_x
    correct_edge_dropping = true
    penalty_value = 1.e7
  []
  [interfaceEy]
    type = PenaltyEqualValueConstraint
    primary_boundary = 'E-2'
    secondary_boundary = 'E-1'
    primary_subdomain = 'primary_E'
    secondary_subdomain = 'secondary_E'
    secondary_variable = disp_y
    correct_edge_dropping = true
    penalty_value = 1.e7
  []
  [interfaceEz]
    type = PenaltyEqualValueConstraint
    primary_boundary = 'E-2'
    secondary_boundary = 'E-1'
    primary_subdomain = 'primary_E'
    secondary_subdomain = 'secondary_E'
    secondary_variable = disp_z
    correct_edge_dropping = true
    penalty_value = 1.e7
  []

  [interfaceFx]
    type = PenaltyEqualValueConstraint
    primary_boundary = 'F-2'
    secondary_boundary = 'F-1'
    primary_subdomain = 'primary_F'
    secondary_subdomain = 'secondary_F'
    secondary_variable = disp_x
    correct_edge_dropping = true
    penalty_value = 1.e7
  []
  [interfaceFy]
    type = PenaltyEqualValueConstraint
    primary_boundary = 'F-2'
    secondary_boundary = 'F-1'
    primary_subdomain = 'primary_F'
    secondary_subdomain = 'secondary_F'
    secondary_variable = disp_y
    correct_edge_dropping = true
    penalty_value = 1.e7
  []
  [interfaceFz]
    type = PenaltyEqualValueConstraint
    primary_boundary = 'F-2'
    secondary_boundary = 'F-1'
    primary_subdomain = 'primary_F'
    secondary_subdomain = 'secondary_F'
    secondary_variable = disp_z
    correct_edge_dropping = true
    penalty_value = 1.e7
  []
[]

[Materials]
  [elastic_tensor_1]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 100000.0
    poissons_ratio = 0.3
    block = '1'
  []
  [compute_stress]
    type = ComputeLagrangianLinearElasticStress
    block = '1'
  []
  [compute_strain]
    type = ComputeLagrangianStrain
    homogenization_gradient_names = 'homogenization_gradient'
    block = '1'
  []
  [compute_homogenization_gradient]
    type = ComputeHomogenizedLagrangianStrain
    block = '1'
  []
[]

[Postprocessors]
  [sxx]
    type = ElementAverageValue
    variable = sxx
    execute_on = 'initial timestep_end'
    block = '1'
  []
  [syy]
    type = ElementAverageValue
    variable = syy
    execute_on = 'initial timestep_end'
    block = '1'
  []
  [sxy]
    type = ElementAverageValue
    variable = sxy
    execute_on = 'initial timestep_end'
    block = '1'
  []

  [szz]
    type = ElementAverageValue
    variable = szz
    execute_on = 'initial timestep_end'
    block = '1'
  []
  [syz]
    type = ElementAverageValue
    variable = syz
    execute_on = 'initial timestep_end'
    block = '1'
  []
  [sxz]
    type = ElementAverageValue
    variable = sxz
    execute_on = 'initial timestep_end'
    block = '1'
  []

  [exx]
    type = ElementAverageValue
    variable = exx
    execute_on = 'initial timestep_end'
    block = '1'
  []
  [eyy]
    type = ElementAverageValue
    variable = eyy
    execute_on = 'initial timestep_end'
    block = '1'
  []
  [exy]
    type = ElementAverageValue
    variable = exy
    execute_on = 'initial timestep_end'
    block = '1'
  []

  [ezz]
    type = ElementAverageValue
    variable = ezz
    execute_on = 'initial timestep_end'
    block = '1'
  []
  [eyz]
    type = ElementAverageValue
    variable = eyz
    execute_on = 'initial timestep_end'
    block = '1'
  []
  [exz]
    type = ElementAverageValue
    variable = exz
    execute_on = 'initial timestep_end'
    block = '1'
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
