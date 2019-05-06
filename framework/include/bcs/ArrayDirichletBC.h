//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "ArrayNodalBC.h"

class ArrayDirichletBC;

template <>
InputParameters validParams<ArrayDirichletBC>();

/**
 * Boundary condition of a Dirichlet type
 *
 * Sets the value in the node
 */
class ArrayDirichletBC : public ArrayNodalBC
{
public:
  ArrayDirichletBC(const InputParameters & parameters);

protected:
  virtual RealArrayValue computeQpResidual() override;

  /// The value for this BC
  const RealArrayValue & _values;
};
