//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "ADMaterial.h"
#include "Function.h"

/**
 * This class defines a Hill tensor material object with a given base name.
 */

class HillConstants : public ADMaterial
{
public:
  static InputParameters validParams();

  HillConstants(const InputParameters & parameters);

protected:
  virtual void computeQpProperties();

  virtual void rotateHillConstants(const std::vector<Real> & hill_constants_input);

  /// Base name of the material system
  const std::string _base_name;

  /// Hill constants for orthotropic inelasticity
  std::vector<Real> _hill_constants_input;
  std::vector<Real> _hill_constants;

  /// material property for storing hill constants
  MaterialProperty<std::vector<Real>> & _hill_constant_material;

  /// Angles for transformation of hill tensor
  RealVectorValue _zyx_angles;

  /// Transformation matrix
  DenseMatrix<Real> _transformation_tensor;

  /// Flag to determine if temperature is supplied by the user
  const bool _has_temp;

  /// Temperature variable value
  const VariableValue & _temperature;

  /// Function names
  const std::vector<FunctionName> _function_names;

  /// Number of function names
  const unsigned int _num_functions;

  /// The functions describing the temperature dependence
  std::vector<const Function *> _functions;
};
