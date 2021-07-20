[Mesh]
  type = GeneratedMesh
  dim = 2
  xmin = 0
  xmax = 1
  nx = 2
  ymin = 0
  ymax = 1
  ny = 2
[]

[Variables]
  [./u]
    order = FIRST
    family = LAGRANGE
    initial_condition = 1
  [../]
[]

[AuxVariables]
 [w]
   order = FIRST
   family = LAGRANGE
 []
[]

[Kernels]
  [./time]
    type = TimeDerivative
    variable = u
  [../]

  [./diff]
    type = Diffusion
    variable = u
  [../]
[]

[AuxKernels]
  active = 'NormalizationAuxTest1'
  [NormalizationAuxTest1]
    type = NormalizationAux
    variable = w
    source_variable = u
    normalization = scale1
    execute_on = 'FINAL'
  []
  [NormalizationAuxTest3]
    type = NormalizationAux
    variable = w
    source_variable = u
    normalization = scale3
    execute_on = 'TIMESTEP_END'
  []
[]

[Postprocessors]
  [./total_u]
    type = ElementIntegralVariablePostprocessor
    variable = u
  [../]

  # scale1 and scale2 depend on the ElementUO total_u. total_u is executed on
  # timestep_end in POST_AUX _before_ the GeneralPostprocessors. scale1 is executed
  # at its default location, timestep_end/POST_AUX/after total_u and hence gets
  # the most up to date information. scale2 is pushed into PRE_AUX and hence picks
  # up the value of total_u from the last timestep.
  #
  # Additionally, the aux kernel NormalizationAuxTest1 uses scale1. User objects
  # including postprocessors and their depending user objects are automatically
  # put into PRE_AUX group when the user objects are used by an auxiliary kernel
  # on the same execute_on flag.
  # If the execute_on = 'final' flag for NormalizationAuxTest1 were not accounted
  # for, the scale1 would be forced into PRE_AUX by the dependency and
  # scale1 and scale2 would behave the same. When the dependency is handled
  # correctly, this does not occur
  # When NormalizationAuxTest3 is active, all posprocessors then have
  # PRE_AUX dependency and the same value
  [./scale1]
    type = ScalePostprocessor
    value = total_u
    scaling_factor = 1
  [../]

  [./scale2]
    type = ScalePostprocessor
    value = total_u
    scaling_factor = 1
    force_preaux = true
  [../]

  [./scale3]
    type = ScalePostprocessor
    value = total_u
    scaling_factor = 1
  [../]
[]

[BCs]
  [./left]
    type = DirichletBC
    variable = u
    boundary = 1
    value = 0
  [../]
[]

[Executioner]
  type = Transient
  dt = 1.0
  end_time = 2.0
[]

[Outputs]
  csv = true
[]
